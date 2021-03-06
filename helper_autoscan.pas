{
 this file is part of Ares
 Aresgalaxy ( http://aresgalaxy.sourceforge.net )

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either
  version 2 of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 }

{
Description:
this code scans for folders containing at least two files of a known media type (mp3/avi/mpg)
}

unit helper_autoscan;

interface

uses
classes,classes2,sysutils,windows,ares_types,forms,controls;

 type
  TFileAttr = (ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory,
    ftArchive, ftNormal);
  TFileType = set of TFileAttr;

  TDriveType = (dtUnknown, dtNoDrive, dtFloppy, dtFixed, dtNetwork, dtCDROM,
    dtRAM);

type
  tthread_search_dir = class(TThread)
  protected
  directory:widestring;
  testo:string;
  drives:tmystringlist;
  child_fldrs:tmystringlist;
  last_update_caption:cardinal;
    procedure Execute; override;
    procedure update; // progress +caption
    procedure update_caption;
    procedure check_end;
    function get_drives:boolean;
    procedure SearchTree(dir:widestring);
    procedure max_progress;
    function is_parent_path_already_in(dir:string):boolean;
    procedure add_child;//synch
  end;

  procedure start_autoscan_folder;
  procedure stop_autoscan_folder;
  procedure write_prefs_autoscan;

implementation

uses
ufrmmain,helper_unicode,vars_localiz,
  helper_diskio,helper_strings,vars_global,const_win_messages,
  helper_share_settings,helper_visual_library; // solo per log


procedure write_prefs_autoscan;
var
i:integer;
prima_cartella:precord_cartella_share;
begin
 prima_cartella:=nil;

with ares_frmmain.chklstbx_shareset_auto do begin
 for i:=0 to items.count-1 do
  if checked[i] then helper_share_settings.add_this_shared_folder(prima_cartella,utf8strtowidestr(hexstr_to_bytestr(items.strings[i])));
 helper_share_settings.write_to_file_shared_folders(prima_cartella);
end;

 cancella_cartella_per_treeview2(prima_cartella);

end;


procedure stop_autoscan_folder;
begin
if search_dir=nil then exit;

with ares_frmmain do begin
 chklstbx_shareset_auto.items.endupdate;
 chklstbx_shareset_auto.enabled:=true;

 want_stop_autoscan:=true;//facciamo fermare il beota...

 btn_shareset_atuostop.enabled:=false;
 btn_shareset_atuostart.enabled:=true;
 btn_shareset_atuocheckall.enabled:=true;
 btn_shareset_atuoUncheckall.enabled:=true;
end;

end;

procedure start_autoscan_folder;
begin
if search_dir<>nil then exit;
want_stop_autoscan:=false;

with ares_frmmain do begin
 btn_shareset_atuostart.enabled:=false;
 btn_shareset_atuostop.enabled:=true;
 btn_shareset_atuocheckall.enabled:=false;
 btn_shareset_atuoUncheckall.enabled:=false;

 with chklstbx_shareset_auto do begin
  items.beginupdate;
  items.clear;
  enabled:=False;
 end;
end;

 search_dir:=tthread_search_dir.create(false);


end;

procedure tthread_search_dir.update;
var
dira:widestring;
begin
ares_FrmMain.progbar_shareset_auto.position:=ares_FrmMain.progbar_shareset_auto.position+1;
dira:=' '+GetLangStringW(STR_SCAN_IN_PROGRESS)+': '+directory;
ares_FrmMain.lbl_shareset_auto.caption:=dira;
end;

function Tthread_search_dir.get_drives:boolean;
var
  DriveNum: Integer;
  DriveChar: Char;
  DriveType: cardinal;
  DriveBits: set of 0..25;
  str:string;
begin
result:=false;
try
seterrormode(SEM_FAILCRITICALERRORS);
  Integer(DriveBits) := GetLogicalDrives;
  for DriveNum := 0 to 25 do begin
    if not (DriveNum in DriveBits) then Continue;
    DriveChar := Char(DriveNum + Ord('a'));
    DriveType := GetDriveType(PChar(DriveChar + ':\'));
    if ((DriveType=DRIVE_FIXED) or
        (DriveType=DRIVE_RAMDISK) or
        (drivetype=DRIVE_REMOTE)) then begin
         str:=drivechar+':';
            if setcurrentdirectory(pchar(str)) then begin
             drives.Add(str);
             result:=true;
            end;
    end;
  end;

except
end;
end;



procedure tthread_search_dir.max_progress;
begin
ares_FrmMain.progbar_shareset_auto.max:=(child_fldrs.count+1)*100;
end;

procedure tthread_search_dir.Execute;
var
dir:widestring;
begin
 FreeOnTerminate:=false;
 priority:=tpnormal;

drives:=tmystringlist.create;
child_fldrs:=tmystringlist.create;

try

 last_update_caption:=gettickcount;

if get_drives then begin

synchronize(max_progress);

while (drives.count>0) do begin

  dir:=utf8strtowidestr(drives.strings[0]);
   drives.Delete(0);


  child_fldrs.clear;
   SearchTree(dir);
  synchronize(add_child);

  if terminated then break;
end;
end;


except
end;


child_fldrs.free;
drives.free;

synchronize(check_end);
end;

procedure tthread_search_dir.add_child;//synch
var
i:integer;
str:string;
begin
    for i:=0 to child_fldrs.count-1 do begin
       str:=bytestr_to_hexstr(child_fldrs.strings[i]);
       ares_FrmMain.chklstbx_shareset_auto.items.add(str);
    end;
end;

procedure tthread_search_dir.check_end;
begin

with ares_frmmain do begin

 progbar_shareset_auto.position:=progbar_shareset_auto.Max;

 with chklstbx_shareset_auto do begin
  enabled:=true;
  if items.count=1 then lbl_shareset_auto.caption:=' '+GetLangStringW(STR_SCAN_COMPLETED)+', 1 '+GetLangStringW(STR_DIRECTORY_FOUND) else
  if items.count>1 then lbl_shareset_auto.caption:=' '+GetLangStringW(STR_SCAN_COMPLETED)+', '+inttostr(items.count)+' '+GetLangStringW(STR_DIRECTORY_FOUNDS) else
  lbl_shareset_auto.caption:=' '+GetLangStringW(STR_SCAN_COMPLETED)+' '+GetLangStringW(STR_NO_DIR_FOUND);
  cursor:=crdefault;
  items.endupdate;
 end;

  cursor:=crdefault;
  btn_shareset_atuostart.enabled:=True;
  btn_shareset_atuostop.enabled:=false;
  btn_shareset_atuocheckall.enabled:=true;
  btn_shareset_atuoUncheckall.enabled:=true;

  postmessage(handle,WM_THREADSEARCHDIR_END,0,0);
end;

end;

procedure tthread_search_dir.update_caption;
var
dira:widestring;
begin
try
dira:=' '+GetLangStringW(STR_SCANNING)+': '+directory;

with ares_frmmain do begin
 lbl_shareset_auto.caption:=dira;
 with progbar_shareset_auto do begin
   position:=position+1;
   if position>=max then position:=0;
 end;
end;

if vars_global.want_stop_autoscan then terminate;

except
end;
end;

procedure tthread_search_dir.SearchTree(dir:widestring);
  var
    SearchRec: TSearchRecW;
    DosError: integer;
    estensione:string;
    dira:widestring;

    utfname:string;
    num_mp3,
    num_avi,
    num_mpg:integer;
begin

  try

    if gettickcount-last_update_caption>200 then begin
     directory:=dir; //per show caption
     last_update_caption:=gettickcount;
     synchronize(update_caption);
    end;

    num_mp3:=0;
    num_avi:=0;
    num_mpg:=0;


    try
    DosError := helper_diskio.FindFirstW(dir+'\*.*', faAnyFile, SearchRec);
     while DosError = 0 do begin

     if terminated then exit;
     
     if (((SearchRec.attr and faDirectory) > 0) or
          (SearchRec.name = '.') or
          (SearchRec.name = '..')) then begin
           DosError := helper_diskio.FindNextW(SearchRec);
           continue;
        end;

        if searchrec.size<100000 then begin
         DosError := helper_diskio.FindNextW(SearchRec);
         continue;
        end;

        estensione:=lowercase(extractfileext(widestrtoutf8str(SearchRec.name)));
       if length(estensione)<2 then begin
        DosError := helper_diskio.FindNextW(SearchRec);
        continue;
       end;

       if estensione='.mp3' then inc(num_mp3) else
       if estensione='.avi' then inc(num_avi) else
       if estensione='.mpg' then inc(num_mpg) else begin
        DosError := helper_diskio.FindNextW(SearchRec);
        continue;
       end;

      if ((num_mp3>0) or
           (num_avi>0) or
           (num_mpg>0)) then begin
             utfname:=widestrtoutf8str(dir);
             if not is_parent_path_already_in(utfname) then begin
              child_fldrs.add(utfname);
             end;
             break;
          end;             // fine se c'erano almeno 2 files
      DosError := helper_diskio.FindNextW(SearchRec);
    end;  // fine while doserror

    finally
    helper_diskio.FindCloseW(SearchRec);
    end;


     dira:=dir;
    {Now that we have all the files we need, lets go to subdirectories.}
     try
      DosError := helper_diskio.FindFirstW(dir+'\*.*', faDirectory, SearchRec);
      while DosError = 0 do begin
      if terminated then exit;
          
       {If there is one, go there and search.}
       if (((SearchRec.attr and faDirectory) > 0) and
            (SearchRec.name <> '.') and
            (SearchRec.name <> '..') and
            (lowercase(SearchRec.name) <> 'winnt') and
            (lowercase(SearchRec.name) <> 'windows')) then begin
         SearchTree(dira+'\'+SearchRec.name); {Time for the recursion!}
      end;
      DosError := helper_diskio.FindNextW(SearchRec); {Look for another subdirectory}
     end;

     finally
     helper_diskio.FindCloseW(SearchRec);
     end;



     except
     end;
end; {SearchTree}

function tthread_search_dir.is_parent_path_already_in(dir:string):boolean;
var
i:integer;
begin
       result:=false;
         for i:=0 to child_fldrs.count-1 do begin
           if length(dir)-1<length(child_fldrs.strings[i]) then continue;

           if dir[length(child_fldrs.strings[i])+1]<>'\' then continue; //non finisce qui vedi folder e folderR  example

           if copy(dir,1,length(child_fldrs.strings[i]))=child_fldrs.strings[i] then begin
            result:=true;           // se ho gi� sottodir...
            break;
           end;
          end;
end;

end.

