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

unit helper_skin;

interface

uses
 windows,classes,registry,sysutils,Graphics,controls,xpbutton,TntStdCtrls,
 comettrees,tntforms,forms;

type
 TSkinZone=(
            szTopLeft,
            szTop,
            szTopRight,
            szLeftTop,
            szLeft,
            szLeftBottom,
            szBottomLeft,
            szBottom,
            szBottomRight,
            szRightBottom,
            szRight,
            szRightTop,
            
            szMinBtn,
            szMinBtnDown,
            szMinBtnHover,
            szMaxBtn,
            szMaxBtnDown,
            szMaxBtnHover,
            szCloseBtn,
            szCloseBtnDown,
            szCloseBtnHover
            );

            
 type
 TBtnRectType=(
               brClose,
               brMinimise,
               brMaximise
               );

 type
 TskinBitmap=class
  SourceCopyleft,
  SourceCopyTop,
  SourceCopyWidth,
  SourceCopyHeight:integer;
  zone:TSkinZone;
 end;

procedure mainGUI_loadStartSkin;
procedure defaultColors;

procedure parse_line_skin(linea:String);
procedure parse_color(cont:string);
procedure apply_colors;
procedure parse_boolean(cont:string);
procedure parse_credit(cont:string);//cont non lowercase
procedure parse_bitmap(cont:string);
procedure parse_enum(cont:string);
function colorstr_toenum(value:String):byte;

procedure load_images(imglist:timagelist; filenameW:widestring; numtoadd:integer);
procedure fill_listbox_skin;
procedure load_new_skin(dummy:boolean); overload;
procedure load_new_skin; overload;
procedure SetDefaultSettings;
function DelphiColorKey_2_color(colorkey:string):tcolor;


procedure NilFrameImages;
procedure FreeFrameBitmaps;
procedure ExtractRectIntegers(var leftI,topI,rightI,bottomI:integer; coordStr:string);
procedure ExtractPointIntegers(var leftI,topI:integer; coordStr:string);
procedure parse_windowFrame(cont:string);
procedure FrameloadMainBitmap(filename:string);
procedure FrameLoadBitmap(coordStr:string; parsePoint:integer; var bitmap:tskinBitmap; zone:TSkinZone);
procedure FrameLoadNCAnchor(coordStr:string; parsePoint:integer; isMinimise,isMaximise,isClose:boolean);
procedure FrameLoadBtnRect(coordStr:string; parsePoint:integer; btnType:TBtnRectType);
procedure FrameToggleSkin(form:TtntForm; enable:boolean);
procedure FrameLoadIconRect(coordStr:string; parsePoint:integer);
procedure FrameLoadCaptionRect(coordStr:string; parsePoint:integer);
procedure drawCustomSkinnedCaption(form:TtntForm);

procedure Parse_Tabs(cont:string);
procedure TabsloadMainBitmap(filename:string);
procedure ParsePoint(coordStr:string; parseI:integer; var point:TPoint);
procedure parse_smallTabs(cont:string);

procedure parse_listview(cont:string);
procedure listviewLoadMainBitmap(filename:string);


procedure parse_buttons(cont:string);
procedure buttonsLoadMainBitmap(filename:string);

procedure loadCustomPlayerImage(filenameW:widestring);
procedure loadCustomPlayerTrackbarImage(filenameW:widestring);

procedure AddCustomSysMenu(form:TForm);
function GetOEMMenuWString(menuHandle:THandle; mCommand:integer):widestring;
procedure SetMenuGrayedState(menuHandle:THandle; mCommand:integer; isEnabled:boolean);
procedure GetOemMenuStrings(form:tform);


var
 skin_directory:widestring;
 SkinnedFrameLoaded:boolean;
 fborderWidth:integer;
 fBorderHeight:integer;
 fcaptionHeight:integer;
 FrameRoundCorner:integer;

 strMenuClose,strMenuMinimize,strMenuMaximize,strMenuRestore,strMenuMove,strMenuSize:widestring;

 FrameSourceBitmap:graphics.TBitmap;
 TabsSourceBitmap:graphics.TBitmap;
 smallTabsSourceBitmap:graphics.TBitmap;
 listviewHeaderBitmap:graphics.TBitmap;
 buttonsBitmap:graphics.TBitmap;

  FrameTopleftBitmap,FrameTopBitmap,
  FrameTopRigthBitmap,FrameLeftTopBitmap,
  FrameLeftBitmap,FrameleftBottomBitmap,
  FrameBottomLeftBitmap,FrameBottomBitmap,
  FrameBottomRightBitmap,FrameRightBottomBitmap,
  FrameRightBitmap,FrameRightTopBitmap,
  FrameMinimiseOffBitmap,FrameMinimiseDownBitmap,FrameMinimiseHoverBitmap,
  FrameMaximiseOffBitmap,FrameMaximiseDownBitmap,FrameMaximiseHoverBitmap,
  FrameCloseOffBitmap,FrameCloseDownBitmap,FrameCloseHoverBitmap:tskinBitmap;


  MaximiseBtnPaintPoint,
  MinimiseBtnPaintPoint,
  closeBtnPaintPoint:TPoint;

  MinimisebtnHitRect,
  MaximisebtnHitRect,
  ClosebtnHitRect:TRect;
  
  FCaptionIconRect:TRect;
  //FCaptionIconCopyRect:TRect;
  FCaptionRect:TRect;
  color_skinned_caption:TColor;

  //tabs
  TabsCopyPointLeft,TabsCopyPointMiddle,TabsCopyPointRight:TPoint;
  TabsHoverCopyPointA,TabsHoverCopyPointB,TabsHoverCopyPointC:TPoint;
  TabsDownHoverCopyPointA,TabsDownHoverCopyPointB,TabsDownHoverCopyPointC:TPoint;
  TabsDownCopyPointA,TabsDownCopyPointB,TabsDownCopyPointC:TPoint;
  TabsClickedCopyPointA,TabsClickedCopyPointB,TabsClickedCopyPointC:TPoint;
  TabsOffCopyPointA,TabsOffCopyPointB,TabsOffCopyPointC:TPoint;

  //small tabs
  smallTabsCopyPointLeft,smallTabsCopyPointMiddle,smallTabsCopyPointRight:TPoint;
  smallTabsHoverCopyPointA,smallTabsHoverCopyPointB,smallTabsHoverCopyPointC:TPoint;
  smallTabsDownHoverCopyPointA,smallTabsDownHoverCopyPointB,smallTabsDownHoverCopyPointC:TPoint;
  smallTabsDownCopyPointA,smallTabsDownCopyPointB,smallTabsDownCopyPointC:TPoint;
  smallTabsClickedCopyPointA,smallTabsClickedCopyPointB,smallTabsClickedCopyPointC:TPoint;
  smallTabsOffCopyPointA,smallTabsOffCopyPointB,smallTabsOffCopyPointC:TPoint;
  smalltabsOffCloseBtnRect,smalltabsHoverCloseBtnRect:TRect;

  //listview headers
  listviewHeaderCopyPointA,listviewHeaderCopyPointB:TPoint;
  listviewHeaderHoverCopyPointA,listviewHeaderHoverCopyPointB:TPoint;
  listviewHeaderDownCopyPointA,listviewHeaderDownCopyPointB,listviewHeaderDownCopyPointC:TPoint;

  buttonsHoverCopyPointA,buttonsHoverCopyPointB,ButtonsHoverCopyPointC:TPoint;
  buttonsClickedCopyPointA,buttonsClickedCopyPointB,ButtonsClickedCopyPointC:TPoint;
  buttonsCopyPointA,buttonsCopyPointB,ButtonsCopyPointC:TPoint;
  buttonsDownCopyPointA,buttonsDownCopyPointB,ButtonsDownCopyPointC:TPoint;

implementation

uses
 ufrmmain,helper_unicode,helper_diskIO,vars_global,const_ares,helper_gui_misc,
 helper_strings,ares_types,helper_player,const_win_messages,ufrmpvt,utility_ares;


procedure drawCustomSkinnedCaption(form:TtntForm);
var
 rc:TRect;
 pointx:integer;
 shouldGetDc:boolean;
 tempBitmap:tbitmap;
begin
if not helper_skin.SkinnedFrameLoaded then exit;

  tempBitmap:=tbitmap.create;
  tempBitmap.Width:=form.clientwidth-helper_skin.FrameTopRigthBitmap.SourceCopyWidth;
  tempBitmap.height:=helper_skin.FrameTopLeftBitmap.SourceCopyHeight;



 // top left
 bitBlt(tempBitmap.canvas.handle,
        0,0,helper_skin.FrameTopLeftBitmap.SourceCopyWidth,helper_skin.FrameTopLeftBitmap.SourceCopyHeight,
        helper_skin.FrameSourceBitmap.canvas.Handle,
        helper_skin.FrameTopLeftBitmap.SourceCopyleft,helper_skin.FrameTopLeftBitmap.SourceCopyTop,
        SRCCopy);

 // top

 pointx:=helper_skin.FrameTopLeftBitmap.SourceCopyWidth;
 while (pointx<form.width-helper_skin.FrameTopRigthBitmap.SourceCopyWidth) do begin
  BitBlt(tempBitmap.canvas.handle,
         pointx,0,helper_skin.FrameTopBitmap.SourceCopyWidth,helper_skin.FrameTopBitmap.SourceCopyHeight,
         helper_skin.FrameSourceBitmap.canvas.handle,
         helper_skin.FrameTopBitmap.SourceCopyleft,helper_skin.FrameTopBitmap.SourceCopyTop,
         SRCCopy);
  inc(pointx,helper_skin.FrameTopBitmap.SourceCopyWidth);
 end;

//  if helper_skin.FCaptionIconRect.left>=0 then
 // form.canvas.Draw(helper_skin.FCaptionIconRect.left,helper_skin.FCaptionIconRect.Top,ares_frmmain.Icon);
   if helper_skin.FCaptionIconRect.left>=0 then  begin
   DrawIconEx(tempBitmap.canvas.handle, helper_skin.FCaptionIconRect.left,helper_skin.FCaptionIconRect.Top,form.icon.Handle, 0, 0, 0, 0, DI_NORMAL);
  end;


 tempBitmap.canvas.font.color:=helper_skin.color_skinned_caption;
 tempBitmap.canvas.font.name:=form.canvas.font.name;
 tempBitmap.canvas.font.size:=form.canvas.font.size;
 tempBitmap.canvas.font.style:=[fsBold];

 rc:=rect(helper_skin.FCaptionRect.left,helper_skin.FCaptionRect.top,form.width-helper_skin.FrameTopRigthBitmap.SourceCopyWidth,helper_skin.FrameTopLeftBitmap.SourceCopyHeight-helper_skin.FCaptionRect.top);

 SetBkMode(tempBitmap.canvas.Handle, TRANSPARENT);
 tempBitmap.canvas.brush.style:=bsclear;
 Windows.ExtTextOutW(tempBitmap.canvas.Handle, helper_skin.FCaptionRect.left, helper_skin.FCaptionRect.top, ETO_CLIPPED, @rc, PWideChar(form.caption),Length(form.caption), nil);

 form.canvas.lock;
  bitblt(form.canvas.handle,
         0,0,tempBitmap.width,tempBitmap.height,
         tempbitmap.canvas.handle,0,0,SRCCOPY);
 tempBitmap.free;         
 form.canvas.Unlock;



  
end;

procedure NilFrameImages;
begin
helper_skin.SkinnedFrameLoaded:=false;
  FCaptionIconRect.left:=-1;
  FCaptionIconRect.top:=-1;

  FrameSourceBitmap:=nil;
  FrameTopLeftBitmap:=nil;
  FrameTopBitmap:=nil;
  FrameTopRigthBitmap:=nil;
  FrameLeftTopBitmap:=nil;
  FrameLeftBitmap:=nil;
  FrameLeftBottomBitmap:=nil;
  FrameBottomLeftBitmap:=nil;
  FrameBottomBitmap:=nil;
  FrameBottomRightBitmap:=nil;
  FrameRightBottomBitmap:=nil;
  FrameRightBitmap:=nil;
  FrameRightTopBitmap:=nil;

  FrameMinimiseOffBitmap:=nil;
  FrameMinimiseDownBitmap:=nil;
  FrameMinimiseHoverBitmap:=nil;
  FrameMaximiseOffBitmap:=nil;
  FrameMaximiseDownBitmap:=nil;
  FrameMaximiseHoverBitmap:=nil;
  FrameCloseOffBitmap:=nil;
  FrameCloseDownBitmap:=nil;
  FrameCloseHoverBitmap:=nil;

  TabsSourceBitmap:=nil;
  smallTabsSourceBitmap:=nil;
  listviewHeaderBitmap:=nil;
  buttonsBitmap:=nil;
end;

procedure FreeFrameBitmaps;
begin
helper_skin.SkinnedFrameLoaded:=false;

ares_frmmain.trackbar_player.SourceBitmap:=nil;
ares_frmmain.MPlayerPanel1.SourceBitmap:=nil;

if FrameTopleftBitmap<>nil then FreeAndNil(FrameTopLeftBitmap);
if FrametopBitmap<>nil then FreeAndNil(FrameTopBitmap);
if FrametopRigthBitmap<>nil then FreeAndNil(FrameTopRigthBitmap);
if FrameleftTopBitmap<>nil then FreeAndNil(FrameLeftTopBitmap);
if FrameleftBitmap<>nil then FreeAndNil(FrameLeftBitmap);
if FrameleftBottomBitmap<>nil then FreeAndNil(FrameLeftBottomBitmap);
if FramebottomLeftBitmap<>nil then FreeAndNil(FrameBottomLeftBitmap);
if FramebottomBitmap<>nil then FreeAndNil(FrameBottomBitmap);
if FramebottomRightBitmap<>nil then FreeAndNil(FrameBottomRightBitmap);
if FramerightBottomBitmap<>nil then FreeAndNil(FrameRightBottomBitmap);
if FramerightBitmap<>nil then FreeAndNil(FrameRightBitmap);
if FramerightTopBitmap<>nil then FreeAndNil(FrameRightTopBitmap);

if FrameMinimiseOffBitmap<>nil then FreeAndNil(FrameMinimiseOffBitmap);
if FrameMinimiseDownBitmap<>nil then FreeAndNil(FrameMinimiseDownBitmap);
if FrameMinimiseHoverBitmap<>nil then FreeAndNil(FrameMinimiseHoverBitmap);
if FrameMaximiseOffBitmap<>nil then FreeAndNil(FrameMaximiseOffBitmap);
if FrameMaximiseDownBitmap<>nil then FreeAndNil(FrameMaximiseDownBitmap);
if FrameMaximiseHoverBitmap<>nil then FreeAndNil(FrameMaximiseHoverBitmap);
if FrameCloseOffBitmap<>nil then FreeAndNil(FrameCloseOffBitmap);
if FrameCloseDownBitmap<>nil then FreeAndNil(FrameCloseDownBitmap);
if FrameCloseHoverBitmap<>nil then FreeAndNil(FrameCloseHoverBitmap);
if frameSourceBitmap<>nil then FreeAndNil(FrameSourceBitmap);

if TabsSourceBitmap<>nil then FreeAndNil(TabsSourceBitmap);
if smallTabsSourceBitmap<>nil then FreeAndNil(smallTabsSourceBitmap);
if listviewHeaderBitmap<>nil then FreeAndNil(listviewHeaderBitmap);
if buttonsBitmap<>nil then FreeAndNil(buttonsBitmap);
end;

procedure ExtractRectIntegers(var leftI,topI,rightI,bottomI:integer; coordStr:string);
begin
leftI:=StrTointDef(copy(coordStr,1,pos(',',coordStr)-1),0);
 Delete(coordStr,1,pos(',',coordStr));
topI:=StrTointDef(copy(coordStr,1,pos(',',coordStr)-1),0);
 Delete(coordStr,1,pos(',',coordStr));
rightI:=StrTointDef(copy(coordStr,1,pos(',',coordStr)-1),0);
 Delete(coordStr,1,pos(',',coordStr));
bottomI:=StrTointDef(coordStr,0);
end;

procedure ExtractPointIntegers(var leftI,topI:integer; coordStr:string);
begin
leftI:=StrTointDef(copy(coordStr,1,pos(',',coordStr)-1),0);
 Delete(coordStr,1,pos(',',coordStr));
topI:=StrTointDef(coordStr,0);
end;

function DelphiColorKey_2_color(colorkey:string):tcolor;
begin
 if colorkey='clactiveborder' then result:=clactiveborder else
 if colorkey='clactivecaption' then result:=clactivecaption else
 if colorkey='clappworkspace' then result:=clappworkspace else
 if colorkey='clbackground' then result:=clbackground else
 if colorkey='clbtnface' then result:=clBtnFace else
 if colorkey='clbtntext' then result:=clBtntext else
 if colorkey='clbtnshadow' then result:=clBtnshadow else
 if colorkey='clbtnhighlight' then result:=clBtnhighlight else
 if colorkey='clcaptiontext' then result:=clcaptiontext else
 if colorkey='clgray' then result:=clGray else
 if colorkey='cl3dlight' then result:=cl3DLight else
 if colorkey='cl3ddkshadow' then result:=cl3ddkshadow else
 if colorkey='clwindow' then result:=clwindow else
 if colorkey='clwindowtext' then result:=clwindowtext else
 if colorkey='clwindowframe' then result:=clwindowframe else
 if colorkey='clscrollbar' then result:=clscrollbar else
 if colorkey='clsilver' then result:=clSilver else
 if colorkey='clinfobk' then result:=clInfoBk else
 if colorkey='clinfotext' then result:=clinfotext else
 if colorkey='clmenu' then result:=clmenu else
 if colorkey='clmenutext' then result:=clmenutext else
 if colorkey='clmenuhighlight' then result:=clmenuhighlight else
 if colorkey='clmenubar' then result:=clmenubar else
 if colorkey='clinactiveborder' then result:=clinactiveborder else
 if colorkey='clinactivecaption' then result:=clinactivecaption else
 if colorkey='clinactivecaptiontext' then result:=clinactivecaptiontext else
 if colorkey='clhotlight' then result:=clhotlight else
 if colorkey='clhighlight' then result:=clhighlight else
 if colorkey='clhighlighttext' then result:=clhighlighttext else result:=clblack;
end;

procedure SetDefaultSettings;
begin
with ares_frmmain do begin
 lbl_opt_skin_title.caption:='Name: N/A';
 lbl_opt_skin_author.caption:='Author: N/A';
 lbl_opt_skin_url.caption:='';
 lbl_opt_skin_version.caption:='Version: N/A';
 lbl_opt_skin_date.caption:='Date: N/A';
 lbl_opt_skin_comments.caption:='Details: ';
end;

 ares_frmmain.ImageList_tabs.Clear;
 FrameRoundCorner:=0;
 ares_frmmain.tabs_pageview.buttonsHeight:=36;
 ares_frmmain.tabs_pageview.buttonsLeftMargin:=5;
 ares_frmmain.tabs_pageview.buttonsTopMargin:=12;
 ares_frmmain.tabs_pageview.buttonsLeft:=5;

 ares_frmmain.panel_chat.buttonsHeight:=25;
 ares_frmmain.settings_control.buttonsHeight:=ares_frmmain.panel_chat.buttonsHeight;
 ares_frmmain.pagesrc.buttonsHeight:=ares_frmmain.panel_chat.buttonsHeight;
 ares_frmmain.pgctrl_shareset.buttonsHeight:=ares_frmmain.panel_chat.buttonsHeight;

 ares_frmmain.panel_chat.buttonsLeftMargin:=6;
 ares_frmmain.settings_control.buttonsLeftMargin:=ares_frmmain.panel_chat.buttonsLeftMargin;
 ares_frmmain.pagesrc.buttonsLeftMargin:=ares_frmmain.panel_chat.buttonsLeftMargin;
 ares_frmmain.pgctrl_shareset.buttonsLeftMargin:=ares_frmmain.panel_chat.buttonsLeftMargin;

 ares_frmmain.panel_chat.buttonsTopMargin:=8;
 ares_frmmain.settings_control.buttonsTopMargin:=ares_frmmain.panel_chat.buttonsTopMargin;
 ares_frmmain.pagesrc.buttonsTopMargin:=ares_frmmain.panel_chat.buttonsTopMargin;
 ares_frmmain.pgctrl_shareset.buttonsTopMargin:=ares_frmmain.panel_chat.buttonsTopMargin;

 ares_frmmain.panel_chat.buttonsLeft:=5;
 ares_frmmain.settings_control.buttonsLeft:=ares_frmmain.panel_chat.buttonsLeft;
 ares_frmmain.pagesrc.buttonsLeft:=ares_frmmain.panel_chat.buttonsLeft;
 ares_frmmain.pgctrl_shareset.buttonsLeft:=ares_frmmain.panel_chat.buttonsLeft;

 ares_frmmain.panel_chat.closebuttonLeftMargin:=17;
 ares_frmmain.settings_control.closebuttonLeftMargin:=ares_frmmain.panel_chat.closebuttonLeftMargin;
 ares_frmmain.pagesrc.closebuttonLeftMargin:=ares_frmmain.panel_chat.closebuttonLeftMargin;
 ares_frmmain.pgctrl_shareset.closebuttonLeftMargin:=ares_frmmain.panel_chat.closebuttonLeftMargin;

 ares_frmmain.panel_chat.closebuttonTopMargin:=8;
 ares_frmmain.settings_control.closebuttonTopMargin:=ares_frmmain.panel_chat.closebuttonTopMargin;
 ares_frmmain.pagesrc.closebuttonTopMargin:=ares_frmmain.panel_chat.closebuttonTopMargin;
 ares_frmmain.pgctrl_shareset.closebuttonTopMargin:=ares_frmmain.panel_chat.closebuttonTopMargin;

 ares_frmmain.panel_chat.closeButtonWidth:=13;
 ares_frmmain.panel_chat.closeButtonHeight:=13;
 ares_frmmain.settings_control.closeButtonWidth:=13;
 ares_frmmain.settings_control.closeButtonHeight:=13;
 ares_frmmain.pagesrc.closeButtonWidth:=13;
 ares_frmmain.pagesrc.closeButtonHeight:=13;
 ares_frmmain.pgctrl_shareset.closeButtonWidth:=13;
 ares_frmmain.pgctrl_shareset.closeButtonHeight:=13;

SETTING_3D_PROGBAR:=true;
VARS_THEMED_BUTTONS:=true;
VARS_THEMED_PANELS:=true;
VARS_THEMED_HEADERS:=true;
defaultColors;
apply_colors;
end;

procedure fill_listbox_skin;
var
doserror:integer;
searchrec:ares_types.tsearchrecW;
begin
  ares_frmmain.lstbox_opt_skin.items.Clear;
      try
      DosError := helper_diskio.FindFirstW(vars_global.app_path+'\Data\GUI\*.*', faAnyFile, SearchRec);
      while DosError = 0 do begin

         if (((SearchRec.attr and faDirectory)>0) and
              (SearchRec.name <> '.') and
              (SearchRec.name <> '..')) then ares_frmmain.lstbox_opt_skin.items.add(searchrec.name);

       DosError := helper_diskio.FindNextW(SearchRec); {Look for another subdirectory}

      end;

     finally
     helper_diskio.FindCloseW(SearchRec);
     end;

end;

procedure select_listbox_skin;
var
i:integer;
str_comp:string;
nameselected:string;
begin

nameselected:=widestrtoutf8str(skin_directory);
for i:=length(nameselected) downto 1 do if nameselected[i]='\' then begin
 delete(nameselected,1,i);
 break;
end;

 for i:=0 to ares_frmmain.lstbox_opt_skin.count-1 do begin
   str_comp:=widestrtoutf8str(ares_frmmain.lstbox_opt_skin.Items.Strings[i]);
   if str_comp=nameselected then begin
     ares_frmmain.lstbox_opt_skin.Selected[i]:=true;
     break;
   end;
 end;

 
end;

procedure load_new_skin;//trigger di select on click di listbox
var
reg:tregistry;
begin

skin_directory:=vars_global.app_path+'\Data\GUI\'+ares_frmmain.lstbox_opt_skin.Items.Strings[ares_frmmain.lstbox_opt_skin.ItemIndex];

 if not direxistsW(skin_directory) then begin
     skin_directory:=vars_global.app_path+'\Data\GUI\General';
     select_listbox_skin;
 end else begin
  reg:=tregistry.create;
   with reg do begin
    openkey(areskey,true);
    writestring('GUI.SkinDirectory',widestrtoutf8str(skin_directory));
    closekey;
    destroy;
   end;
 end;

setdefaultsettings;
load_new_skin(true);
end;

procedure mainGUI_loadStartSkin;
var
reg:tregistry;
begin
fill_listbox_skin;

reg:=tregistry.create;
with reg do begin
 openkey(areskey,true);
 if valueexists('GUI.SkinDirectory') then begin
  skin_directory:=utf8strtowidestr(readstring('GUI.SkinDirectory'));
   if not direxistsW(skin_directory) then begin
     skin_directory:=vars_global.app_path+'\Data\GUI\General';
   end;
 end else begin
  if utility_ares.WinOpSys=osWinVista then skin_directory:=vars_global.app_path+'\Data\GUI\OsThemes'
   else skin_directory:=vars_global.app_path+'\Data\GUI\General';
 end;
closekey;
destroy;
end;

select_listbox_skin;


load_new_skin(true);
end;

procedure load_new_skin(dummy:boolean);
var
stream:thandlestream;
buffer:array[0..1023] of char;
len,previous_len:integer;
str,linea:string;
begin

 helper_skin.FreeFrameBitmaps;
 setdefaultsettings;

 stream:=MyFileOpen(skin_directory+'\Prefs.txt',ARES_READONLY_BUT_SEQUENTIAL);
 if stream=nil then begin
  FrameToggleSkin(ares_frmmain,false);
  exit;
 end;
 

 str:='';
 while (stream.position<stream.size-1) do begin
  len:=stream.read(buffer,sizeof(buffer));
  if len=0 then break;
  previous_len:=length(str);

  setlength(str,len+previous_len);
  move(buffer,str[previous_len+1],len);

 end;

 FreeHandleStream(Stream);


 while (length(str)>0) do begin
   linea:=copy(str,1,pos(CRLF,str)-1);
    delete(str,1,pos(CRLF,str)+1);

    parse_line_skin(trim(linea));
 end;

 apply_colors;
 FrameToggleSkin(ares_frmmain,(FrameSourceBitmap<>nil));
end;

procedure apply_colors;
var
i:integer;
stream:thandlestream;
src:precord_panel_search;
begin
with ares_frmmain do begin
// panel_player_capt.Color:=COLORE_PLAYER_BG;
// panel_player_capt.font.color:=COLORE_PLAYER_FONT;

tabs_pageview.font.color:=COLORE_TOOLBAR_FONT;
panel_chat.font.color:=font.color;//COLORE_TOOLBAR_FONT;
pgctrl_shareset.font.color:=font.color;
pagesrc.font.color:=font.color;
settings_control.font.color:=font.color;

for i:=0 to src_panel_list.count-1 do begin
 src:=src_panel_list[i];
 with src^.listview do begin
  color:=COLORE_LISTVIEWS_BG;
  font.color:=COLORE_LISTVIEWS_FONT;
  Colors.GridLineColor:=COLORE_LISTVIEWS_GRIDLINES;
  Colors.TreeLineColor:=COLORE_LISTVIEWS_TREELINES;
 end;
end;

with panel_src_default do begin
 color:=COLORE_PANELS_BG;
 font.color:=COLORE_LISTVIEWS_FONT;
end;

 treeview_lib_regfolders.color:=COLORE_LISTVIEWS_BG;
 treeview_lib_regfolders.font.color:=COLORE_LISTVIEWS_FONT;
 treeview_lib_regfolders.Colors.TreeLineColor:=COLORE_LISTVIEWS_TREELINES;
  treeview_lib_virfolders.color:=COLORE_LISTVIEWS_BG;
  treeview_lib_virfolders.font.color:=COLORE_LISTVIEWS_FONT;
  treeview_lib_virfolders.Colors.TreeLineColor:=COLORE_LISTVIEWS_TREELINES;

 listview_lib.color:=COLORE_LISTVIEWS_BG;
 listview_lib.font.color:=COLORE_LISTVIEWS_FONT;
 listview_lib.Colors.GridLineColor:=COLORE_LISTVIEWS_GRIDLINES;
 listview_lib.Colors.BorderColor:=COLORE_LISTVIEWS_HEADERBORDER;
  for i:=0 to listview_lib.header.columns.count-1 do listview_lib.header.columns.items[i].Color:=listview_lib.color;

 treeview_download.color:=COLORE_LISTVIEWS_BG;
 treeview_download.Font.color:=COLORE_LISTVIEWS_FONT;
 treeview_download.Colors.GridLineColor:=COLORE_LISTVIEWS_GRIDLINES;
 treeview_download.Colors.TreeLineColor:=COLORE_LISTVIEWS_TREELINES;
 treeview_download.Colors.BorderColor:=COLORE_LISTVIEWS_HEADERBORDER;
  treeview_upload.color:=COLORE_LISTVIEWS_BG;
  treeview_upload.Font.color:=COLORE_LISTVIEWS_FONT;
  treeview_upload.Colors.GridLineColor:=COLORE_LISTVIEWS_GRIDLINES;
  treeview_upload.Colors.TreeLineColor:=COLORE_LISTVIEWS_TREELINES;
  treeview_upload.Colors.BorderColor:=COLORE_LISTVIEWS_HEADERBORDER;
 treeview_queue.color:=COLORE_LISTVIEWS_BG;
 treeview_queue.Font.color:=COLORE_LISTVIEWS_FONT;
 treeview_queue.Colors.GridLineColor:=COLORE_LISTVIEWS_GRIDLINES;
 treeview_queue.Colors.TreeLineColor:=COLORE_LISTVIEWS_TREELINES;
 treeview_queue.Colors.BorderColor:=COLORE_LISTVIEWS_HEADERBORDER;

 listview_chat_channel.color:=COLORE_LISTVIEWS_BG;
 listview_chat_channel.Font.color:=COLORE_LISTVIEWS_FONT;
 listview_chat_channel.colors.gridLineColor:=COLORE_LISTVIEWS_GRIDLINES;
 listview_chat_channel.Colors.BorderColor:=COLORE_LISTVIEWS_HEADERBORDER;
  treeview_chat_favorites.color:=COLORE_LISTVIEWS_BG;
  treeview_chat_favorites.Font.color:=COLORE_LISTVIEWS_FONT;
  treeview_chat_favorites.colors.gridLineColor:=COLORE_LISTVIEWS_GRIDLINES;
  treeview_chat_favorites.Colors.BorderColor:=COLORE_LISTVIEWS_HEADERBORDER;

 //listview_playlist.color:=clblack;
 //listview_playlist.Font.color:=clwhite;//COLORE_LISTVIEWS_FONT;

 panel_hash.color:=COLORE_LISTVIEWS_BG;
 panel_hash.font.color:=COLORE_LISTVIEWS_FONT;
   lbl_hash_progress.font.color:=COLORE_LISTVIEWS_FONT;
   lbl_hash_pri.font.color:=COLORE_LISTVIEWS_FONT;
   lbl_hash_hint.font.color:=COLORE_LISTVIEWS_FONT;
   lbl_hash_folder.font.color:=COLORE_LISTVIEWS_FONT;
   lbl_hash_filedet.font.color:=COLORE_LISTVIEWS_FONT;
   lbl_hash_file.font.color:=COLORE_LISTVIEWS_FONT;

  chklstbx_shareset_auto.color:=COLORE_LISTVIEWS_BG;
  chklstbx_shareset_auto.font.color:=COLORE_LISTVIEWS_FONT;

  { panel_tabs.color:=COLORE_TOOLBAR_BG;
   panel_tabs.Font.color:=COLORE_TOOLBAR_FONT;
   for i:=0 to panel_tabs.ControlCount-1 do begin
    if panel_tabs.Controls[i].classtype=TXPButton then begin
     (panel_tabs.Controls[i] as TXPButton).colorbg:=COLORE_TOOLBAR_BG;
     (panel_tabs.Controls[i] as TXPButton).font.color:=COLORE_TOOLBAR_FONT;
    end else
    if panel_tabs.Controls[i].classtype=ttntlabel then (panel_tabs.Controls[i] as tTntLabel).font.color:=COLORE_TOOLBAR_FONT;
   end;
   panel_tabs.invalidate;
     }


         if VARS_THEMED_HEADERS then listview_lib.TreeOptions.PaintOptions:=listview_lib.TreeOptions.PaintOptions + [toThemeAware]
          else listview_lib.TreeOptions.PaintOptions:=listview_lib.TreeOptions.PaintOptions - [toThemeAware];
          listview_lib.invalidate;
          for i:=0 to src_panel_list.count -1 do begin
          src:=src_panel_list[i];
            if VARS_THEMED_HEADERS then src^.listview.TreeOptions.PaintOptions:=src^.listview.TreeOptions.PaintOptions + [toThemeAware]
             else src^.listview.TreeOptions.PaintOptions:=src^.listview.TreeOptions.PaintOptions - [toThemeAware];
             src^.listview.invalidate;
          end;
          panel_src_default.color:=COLORE_LISTVIEWS_BG;
          
         if VARS_THEMED_HEADERS then treeview_download.TreeOptions.PaintOptions:=treeview_download.TreeOptions.PaintOptions + [toThemeAware]
          else treeview_download.TreeOptions.PaintOptions:=treeview_download.TreeOptions.PaintOptions - [toThemeAware];
         treeview_download.invalidate;
          if VARS_THEMED_HEADERS then treeview_upload.TreeOptions.PaintOptions:=treeview_upload.TreeOptions.PaintOptions + [toThemeAware]
           else treeview_upload.TreeOptions.PaintOptions:=treeview_upload.TreeOptions.PaintOptions - [toThemeAware];
          treeview_upload.invalidate;
         if VARS_THEMED_HEADERS then treeview_queue.TreeOptions.PaintOptions:=treeview_queue.TreeOptions.PaintOptions + [toThemeAware]
          else treeview_queue.TreeOptions.PaintOptions:=treeview_queue.TreeOptions.PaintOptions - [toThemeAware];
         treeview_queue.invalidate;
          if VARS_THEMED_HEADERS then listview_chat_channel.TreeOptions.PaintOptions:=listview_chat_channel.TreeOptions.PaintOptions + [toThemeAware]
           else listview_chat_channel.TreeOptions.PaintOptions:=listview_chat_channel.TreeOptions.PaintOptions - [toThemeAware];
          listview_chat_channel.invalidate;
         if VARS_THEMED_HEADERS then treeview_chat_favorites.TreeOptions.PaintOptions:=treeview_chat_favorites.TreeOptions.PaintOptions + [toThemeAware]
          else treeview_chat_favorites.TreeOptions.PaintOptions:=treeview_chat_favorites.TreeOptions.PaintOptions - [toThemeAware];
         treeview_chat_favorites.invalidate;
         

  mfolder.Color:=COLORE_LISTVIEWS_BG;
  mfolder.font.color:=COLORE_LISTVIEWS_FONT;
  splitter_Library.color:=COLORE_LISTVIEWS_BG;
  tabs_pageview.color:=COLORE_PANELS_BG;
  btns_chat.color:=COLORE_PANELS_BG;
  btns_library.color:=COLORE_PANELS_BG;
  btns_options.color:=COLORE_PANELS_BG;
  btns_transfer.color:=COLORE_PANELS_BG;
  
  btns_options.color:=COLORE_PANELS_BG;//COLORE_PANELS2_BG;
  pnl_opt_sharing.color:=COLORE_PANELS_BG;

  panel_transfer.color:=COLORE_PANELS_BG;
  panel_tran_down.color:=COLORE_PANELS_BG;
   panel_tran_down.font.color:=COLORE_PANELS_FONT;

  panel_tran_upqu.color:=COLORE_PANELS_BG;
   panel_tran_upqu.font.color:=COLORE_PANELS_FONT;
   btn_tran_toggle_queup.colorbg:=COLORE_PANELS_BG;
   btn_tran_toggle_queup.font.color:=COLORE_PANELS_FONT;


  panel_playlist.font.color:=clwhite;//COLORE_PANELS_FONT;
  panel_playlist.color:=clblack;//COLORE_PANELS_BG;
   btn_playlist_close.colorbg:=clblack;//COLORE_PANELS_BG;
   btn_playlist_close.font.color:=clwhite;//COLORE_PANELS_FONT;

   panel_search.font.color:=COLORE_PANELS_FONT;
   panel_search.color:=COLORE_SEARCH_PANEL;

  panel_hash.Color:=COLORE_PANELS_BG;
  panel_hash.font.color:=COLORE_PANELS_FONT;
  //panel_hash.font.color:=COLORE_PANELS_FONT;
   panel_details_library.font.color:=COLORE_PANELS_FONT;
   panel_details_library.color:=COLORE_LIBDETAILS_PANEL;

  
   btn_lib_regular_view.colorbg:=COLORE_PANELS_BG;
   btn_lib_regular_view.font.color:=COLORE_PANELS_FONT;
   btn_lib_virtual_view.colorbg:=COLORE_PANELS_BG;
   btn_lib_virtual_view.font.color:=COLORE_PANELS_FONT;
   
   pnl_chat_fav.color:=COLORE_PANELS_BG;
   pnl_chat_fav.font.color:=COLORE_PANELS_FONT;
   Splitter_chat_channel.color:=COLORE_PANELS_BG;

   for i:=0 to src_panel_list.count-1 do begin
    src:=src_panel_list[i];
    src^.listview.header.background:=COLORE_LISTVIEWS_HEADERBK;
    src^.listview.header.font.color:=COLORE_LISTVIEWS_HEADERFONT;
   end;

    listview_lib.header.background:=COLORE_LISTVIEWS_HEADERBK;
    listview_lib.header.font.color:=COLORE_LISTVIEWS_HEADERFONT;
   treeview_download.header.background:=COLORE_LISTVIEWS_HEADERBK;
   treeview_download.header.font.color:=COLORE_LISTVIEWS_HEADERFONT;
    treeview_upload.header.background:=COLORE_LISTVIEWS_HEADERBK;
    treeview_upload.header.font.color:=COLORE_LISTVIEWS_HEADERFONT;
   treeview_queue.header.background:=COLORE_LISTVIEWS_HEADERBK;
   treeview_queue.header.font.color:=COLORE_LISTVIEWS_HEADERFONT;
    listview_chat_channel.header.background:=COLORE_LISTVIEWS_HEADERBK;
    listview_chat_channel.header.font.color:=COLORE_LISTVIEWS_HEADERFONT;
   treeview_chat_favorites.header.background:=COLORE_LISTVIEWS_HEADERBK;
   treeview_chat_favorites.header.font.color:=COLORE_LISTVIEWS_HEADERFONT;
   
   // COLORE_LISTVIEWS_HEADERFONT,
    try
   mainGui_applyChanges;
   except
   end;


   if imgscnlogo=nil then begin  // update screen logo
    if tabs_pageview.activepage=IDTAB_SCREEN then mainGUI_screenlogo_init;
   end else begin
     if fileexistsW(skin_directory+'\'+VARS_SCREEN_LOGO) then begin

       stream:=MyFileOpen(skin_directory+'\'+VARS_SCREEN_LOGO,ARES_READONLY_BUT_SEQUENTIAL);
       if stream=nil then exit;
        imgscnlogo.picture.bitmap.loadfromstream(stream);

       FreeHandleStream(Stream);
     end;
   end;


   

end;

end;

procedure parse_line_skin(linea:String);
var
str:string;
begin
if length(linea)=0 then exit;
if pos('#',linea)=1 then exit;
if pos('//',linea)=1 then exit;

str:=lowercase(linea);
if pos('color ',str)=1 then parse_color(copy(str,7,length(str))) else
if pos('bool ',str)=1 then parse_boolean(copy(str,6,length(str))) else
if pos('credit ',str)=1 then parse_credit(copy(linea,8,length(str))) else
if pos('bitmap ',str)=1 then parse_bitmap(copy(str,8,length(str))) else
if pos('colorenum ',str)=1 then parse_enum(copy(str,11,length(str))) else
if pos('windowframe ',str)=1 then parse_windowFrame(copy(str,13,length(str))) else
if pos('paneltabs ',str)=1 then parse_tabs(copy(str,11,length(str)));
if pos('smalltabs ',str)=1 then parse_smalltabs(copy(str,11,length(str)));
if pos('listview ',str)=1 then parse_listview(copy(str,10,length(str)));
if pos('buttons ',str)=1 then parse_buttons(copy(str,9,length(str)));
end;


procedure SmallTabsloadMainBitmap(filename:string);
var
filenameW:widestring;
stream:THandleStream;
begin
filename:=trim(filename);
filenameW:=skin_directory+'\'+filename;

 if smallTabsSourceBitmap<>nil then FreeAndNil(smallTabsSourceBitmap);

if not fileexistsW(filenameW) then exit;



stream:=myfileOpen(filenameW,ARES_READONLY_ACCESS);
if stream<>nil then begin
 smallTabsSourceBitmap:=graphics.tbitmap.create;
 smallTabsSourceBitmap.LoadFromStream(stream);
 smallTabsSourceBitmap.pixelFormat:=pf24Bit;
 FreeHandleStream(stream);

end;

end;

procedure TabsloadMainBitmap(filename:string);
var
filenameW:widestring;
stream:THandleStream;
begin
filename:=trim(filename);
filenameW:=skin_directory+'\'+filename;

 if TabsSourceBitmap<>nil then FreeAndNil(TabsSourceBitmap);

if not fileexistsW(filenameW) then exit;



stream:=myfileOpen(filenameW,ARES_READONLY_ACCESS);
if stream<>nil then begin
 TabsSourceBitmap:=graphics.tbitmap.create;
 TabsSourceBitmap.LoadFromStream(stream);
 TabsSourceBitmap.pixelFormat:=pf24Bit;
 FreeHandleStream(stream);

end;

end;

procedure FrameloadMainBitmap(filename:string);
var
filenameW:widestring;
stream:THandleStream;
begin
filename:=trim(filename);
filenameW:=skin_directory+'\'+filename;

 if FrameSourceBitmap<>nil then FreeAndNil(FrameSourceBitmap);

if not fileexistsW(filenameW) then exit;



stream:=myfileOpen(filenameW,ARES_READONLY_ACCESS);
if stream<>nil then begin
 FrameSourceBitmap:=graphics.tbitmap.create;
 FrameSourceBitmap.LoadFromStream(stream);
 FrameSourceBitmap.pixelFormat:=pf24Bit;
 FreeHandleStream(stream);

end;

end;

procedure FrameToggleSkin(form:TtntForm; enable:boolean);
var
 hnd:hwnd;
 style:integer;
begin
if form=ares_frmmain then begin

if not enable then begin


 helper_skin.skinnedFrameLoaded:=false;
 form.WindowState:=wsNormal;

 SetWindowRgn(form.Handle,0,true);

 if (form as tares_frmmain).frameRgn<>0 then begin
  ufrmmain.ares_frmmain.formresize(nil);
  (form as tares_frmmain).frameRgn:=0;
  form.borderstyle:=bsSizeable;
 end;
 //DraGAcceptFiles(ares_frmmain.handle,true);

end else begin

 helper_skin.skinnedFrameLoaded:=true;

 form.WindowState:=wsNormal;
 form.borderstyle:=bsnone;

 helper_skin.FBorderWidth:=helper_skin.FrameleftTopBitmap.SourceCopyWidth;
 helper_skin.FCaptionHeight:=helper_skin.FrameTopLeftBitmap.SourceCopyHeight;
 helper_skin.FBorderHeight:=helper_skin.FrameBottomBitmap.SourceCopyHeight;



 style:=GetWindowLong(ares_frmmain.Handle,GWL_STYLE);
 style:=style or WS_SYSMENU or WS_SIZEBOX or WS_MINIMIZEBOX;
 SetWindowLong(ares_frmmain.Handle,GWL_STYLE,style);

 //DraGAcceptFiles(ares_frmmain.handle,true);


 AddCustomSysMenu(ares_frmmain);
 ufrmmain.ares_frmmain.EnableSysMenus;
 
 {
 hnd:=SafeLoadLibrary('user32.dll');
 if hnd<>0 then begin
   @DisableProcessWindowsGhosting:=GetProcAddress(hnd,'DisableProcessWindowsGhosting');
    if @DisableProcessWindowsGhosting<>nil then begin
     DisableProcessWindowsGhosting;
    end;

 end;
 hnd:=SafeLoadLibrary('uxtheme.dll');
 if hnd<>0 then begin
  @SetWindowTheme:=GetProcAddress(hnd,'SetWindowTheme');
  if @SetWindowTheme<>nil then begin
   SetWindowTheme(ares_frmmain.Handle,' ',' ');
  end;
 end;    }



  (form as tares_frmmain).FrameRgn:=CreateRoundRectRgn(0,0, form.width, form.height,9,9);//9,9);//<shape type="roundRect" rect="0,0,-1,-1" size="4,4"/>
  SetWindowRgn(form.Handle,(form as tares_frmmain).FrameRgn,true);



  (form as tares_frmmain).FMinDown:=false;
  (form as tares_frmmain).FMaxDown:=false;
  (form as tares_frmmain).FCloseDown:=false;

  ufrmmain.ares_frmmain.FormResize(nil);

end;
end;

end;

function GetOEMMenuWString(menuHandle:THandle; mCommand:integer):widestring;
var
 widearray:array[0..40] of widechar;
begin
 GetMenuStringW(menuHandle,mCommand, widearray,sizeof(widearray),MF_BYCOMMAND);
 result:=widearray;
end;

procedure SetMenuGrayedState(menuHandle:THandle; mCommand:integer; isEnabled:boolean);
begin                 //MF_GRAYED, MF_ENABLED
if not isEnabled then
EnableMenuItem(menuHandle, mCommand, MF_BYCOMMAND or MF_GRAYED) else
EnableMenuItem(menuHandle, mCommand, MF_BYCOMMAND and not MF_GRAYED);
end;

procedure GetOemMenuStrings(form:tform);
var
 sysMenu: THandle;
begin
 sysMenu:=GetSystemMenu(ares_frmmain.Handle, False);

 strMenuMaximize:=GetOEMMenuWString(sysmenu,SC_MAXIMIZE);
 strMenuMinimize:=GetOEMMenuWString(sysmenu,SC_MINIMIZE);
 strMenuClose:=GetOEMMenuWString(sysmenu,SC_CLOSE);
 strMenuRestore:=GetOEMMenuWString(sysmenu,SC_RESTORE);
 strMenuMove:=GetOEMMenuWString(sysmenu,SC_MOVE);
 strMenuSize:=GetOEMMenuWString(sysmenu,SC_SIZE);
end;

procedure AddCustomSysMenu(form:TForm);
var
 sysMenu: THandle;
 MenuItemInfo : TMenuItemInfoW;
 bitmap:HBITMAP;
 tempBit:HBitmap;

begin

  sysMenu:=GetSystemMenu(form.Handle, False);

 {FillChar(MenuItemInfo, SizeOf(MenuItemInfo), 0);
 MenuItemInfo.fMask:=MIIM_BITMAP;
 MenuItemInfo.fType:=MFT_BITMAP;



 GetMenuItemInfo(sysmenu,SC_RESTORE,false,MenuItemInfo);
 MIIM_TYPE or MIIM_ID   MFT_STRING  }

 // delete oem sys
 DeleteMenu(sysMenu, SC_SIZE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_MAXIMIZE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_MINIMIZE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_RESTORE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_MOVE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_CLOSE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, 0, MF_BYCOMMAND);

 // delete custom
 DeleteMenu(sysMenu, SC_MYRESTORE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_MOVE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_SIZE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_MYMINIMIZE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_MYMAXIMIZE, MF_BYCOMMAND);
 DeleteMenu(sysMenu, 0, MF_BYCOMMAND);
 DeleteMenu(sysMenu, SC_MYCLOSE, MF_BYCOMMAND);


 AppendMenuW(sysMenu, MF_BYPOSITION, SC_MYRESTORE, pwidechar(strMenuRestore));
 AppendMenuW(sysMenu, MF_BYPOSITION, SC_MOVE, pwidechar(strMenuMove));
 AppendMenuW(sysMenu, MF_BYPOSITION, SC_SIZE, pwidechar(strMenuSize));
 AppendMenuW(sysMenu, MF_BYPOSITION, SC_MYMINIMIZE, pwidechar(strMenuMinimize));
 AppendMenuW(sysMenu, MF_BYPOSITION, SC_MYMAXIMIZE, pwidechar(strMenuMaximize));
 AppendMenu(sysMenu, MF_SEPARATOR, 0, '');
 AppendMenuW(sysMenu, MF_BYPOSITION, SC_MYCLOSE, pwidechar(strMenuClose));

 {
 tempBit:=LoadBitmap( 0, makeintresource(OBM_RESTORE) );
 if tempBit=0 then begin
  SysErrorMessage(GetLastError)
 end;
}
end;

procedure FrameLoadBitmap(coordStr:string; parsePoint:integer; var bitmap:tskinBitmap; zone:TSkinZone);
var
leftI,topI,widthI,HeightI:integer;
begin
delete(coordStr,1,parsePoint);
coordStr:=trim(coordStr);

ExtractRectIntegers(leftI,topI,widthI,HeightI,coordStr);
 if bitmap=nil then Bitmap:=TSkinBitmap.create;
 Bitmap.SourceCopyleft:=leftI;
 bitmap.SourceCopyTop:=topI;
 bitmap.SourceCopyWidth:=widthI;
 bitmap.SourceCopyHeight:=HeightI;
 bitmap.zone:=zone;

end;

procedure buttonsLoadMainBitmap(filename:string);
var
filenameW:widestring;
stream:THandleStream;
begin
filename:=trim(filename);
filenameW:=skin_directory+'\'+filename;

 if buttonsBitmap<>nil then FreeAndNil(buttonsBitmap);

if not fileexistsW(filenameW) then exit;



stream:=myfileOpen(filenameW,ARES_READONLY_ACCESS);
if stream<>nil then begin
 buttonsBitmap:=graphics.tbitmap.create;
 buttonsBitmap.LoadFromStream(stream);
 buttonsBitmap.pixelFormat:=pf24Bit;
 FreeHandleStream(stream);
end;

end;

procedure parse_buttons(cont:string);
begin
if pos('bitmapfile=',cont)=1 then buttonsLoadMainBitmap(copy(cont,12,length(cont)))
 else
 
if pos('copyrecta=',cont)=1 then parsePoint(cont,10,buttonsCopyPointA)
 else
if pos('copyrectb=',cont)=1 then parsePoint(cont,10,buttonsCopyPointB)
 else
if pos('copyrectc=',cont)=1 then parsePoint(cont,10,buttonsCopyPointC)
 else

if pos('hovercopyrecta=',cont)=1 then parsePoint(cont,15,buttonsHoverCopyPointA)
 else
if pos('hovercopyrectb=',cont)=1 then parsePoint(cont,15,buttonsHoverCopyPointB)
 else
if pos('hovercopyrectc=',cont)=1 then parsePoint(cont,15,buttonsHoverCopyPointC)
 else

if pos('downcopyrecta=',cont)=1 then parsePoint(cont,14,buttonsClickedCopyPointA)
 else
if pos('downcopyrectb=',cont)=1 then parsePoint(cont,14,buttonsClickedCopyPointB)
 else
if pos('downcopyrectc=',cont)=1 then parsePoint(cont,14,buttonsClickedCopyPointC)
 else

if pos('checkedcopyrecta=',cont)=1 then parsePoint(cont,17,buttonsDownCopyPointA)
 else
if pos('checkedcopyrectb=',cont)=1 then parsePoint(cont,17,buttonsDownCopyPointB)
 else
if pos('checkedcopyrectc=',cont)=1 then parsePoint(cont,17,buttonsDownCopyPointC);
end;

procedure parse_listview(cont:string);
begin
if pos('headerbitmap=',cont)=1 then listviewLoadMainBitmap(copy(cont,14,length(cont)))
 else
if pos('headercopypointa=',cont)=1 then parsePoint(cont,17,listviewHeaderCopyPointA)
 else
if pos('headercopypointb=',cont)=1 then parsePoint(cont,17,listviewHeaderCopyPointB)
 else
if pos('headerhovercopypointa=',cont)=1 then parsePoint(cont,22,listviewHeaderHoverCopyPointA)
  else
if pos('headerhovercopypointb=',cont)=1 then parsePoint(cont,22,listviewHeaderHoverCopyPointB)
 else
if pos('headerdowncopypointa=',cont)=1 then parsePoint(cont,21,listviewHeaderDownCopyPointA)
  else
if pos('headerdowncopypointb=',cont)=1 then parsePoint(cont,21,listviewHeaderDownCopyPointB)
 else
if pos('headerdowncopypointc=',cont)=1 then parsePoint(cont,21,listviewHeaderDownCopyPointC);
end;

procedure listviewLoadMainBitmap(filename:string);
var
filenameW:widestring;
stream:THandleStream;
begin
filename:=trim(filename);
filenameW:=skin_directory+'\'+filename;

 if ListviewHeaderBitmap<>nil then FreeAndNil(ListviewHeaderBitmap);

if not fileexistsW(filenameW) then exit;



stream:=myfileOpen(filenameW,ARES_READONLY_ACCESS);
if stream<>nil then begin
 ListviewHeaderBitmap:=graphics.tbitmap.create;
 ListviewHeaderBitmap.LoadFromStream(stream);
 ListviewHeaderBitmap.pixelFormat:=pf24Bit;
 FreeHandleStream(stream);

end;
end;

procedure parse_smallTabs(cont:string);
var
 leftI,topI,widthI,HeightI:integer;
begin

if pos('bitmapfile=',cont)=1 then smallTabsloadMainBitmap(copy(cont,12,length(cont)))
else
if pos('height=',cont)=1 then begin
 cont:=trim(copy(cont,8,length(cont)));
 ares_frmmain.panel_chat.buttonsHeight:=strTointdef(cont,3);
 ares_frmmain.settings_control.buttonsHeight:=ares_frmmain.panel_chat.buttonsHeight;
 ares_frmmain.pagesrc.buttonsHeight:=ares_frmmain.panel_chat.buttonsHeight;
 ares_frmmain.pgctrl_shareset.buttonsHeight:=ares_frmmain.panel_chat.buttonsHeight;
end else
if pos('captionleft=',cont)=1 then begin
 cont:=trim(copy(cont,13,length(cont)));
 ares_frmmain.panel_chat.buttonsLeftMargin:=strToIntdef(cont,14);
 ares_frmmain.settings_control.buttonsLeftMargin:=ares_frmmain.panel_chat.buttonsLeftMargin;
 ares_frmmain.pagesrc.buttonsLeftMargin:=ares_frmmain.panel_chat.buttonsLeftMargin;
 ares_frmmain.pgctrl_shareset.buttonsLeftMargin:=ares_frmmain.panel_chat.buttonsLeftMargin;
end else
if pos('captiontop=',cont)=1 then begin
 cont:=trim(copy(cont,12,length(cont)));
 ares_frmmain.panel_chat.buttonsTopMargin:=strToIntDef(cont,12);
 ares_frmmain.settings_control.buttonsTopMargin:=ares_frmmain.panel_chat.buttonsTopMargin;
 ares_frmmain.pagesrc.buttonsTopMargin:=ares_frmmain.panel_chat.buttonsTopMargin;
 ares_frmmain.pgctrl_shareset.buttonsTopMargin:=ares_frmmain.panel_chat.buttonsTopMargin;
end else
if pos('buttonsleft=',cont)=1 then begin
 cont:=trim(copy(cont,13,length(cont)));
 ares_frmmain.panel_chat.buttonsLeft:=strToIntDef(cont,5);
 ares_frmmain.settings_control.buttonsLeft:=ares_frmmain.panel_chat.buttonsLeft;
 ares_frmmain.pagesrc.buttonsLeft:=ares_frmmain.panel_chat.buttonsLeft;
 ares_frmmain.pgctrl_shareset.buttonsLeft:=ares_frmmain.panel_chat.buttonsLeft;
end else
if pos('closebuttonleft=',cont)=1 then begin
 cont:=trim(copy(cont,17,length(cont)));
 ares_frmmain.panel_chat.closebuttonLeftMargin:=strToIntDef(cont,17);
 ares_frmmain.settings_control.closebuttonLeftMargin:=ares_frmmain.panel_chat.closebuttonLeftMargin;
 ares_frmmain.pagesrc.closebuttonLeftMargin:=ares_frmmain.panel_chat.closebuttonLeftMargin;
 ares_frmmain.pgctrl_shareset.closebuttonLeftMargin:=ares_frmmain.panel_chat.closebuttonLeftMargin;
end else
if pos('closebuttontop=',cont)=1 then begin
 cont:=trim(copy(cont,16,length(cont)));
 ares_frmmain.panel_chat.closebuttonTopMargin:=strToIntDef(cont,8);
 ares_frmmain.settings_control.closebuttonTopMargin:=ares_frmmain.panel_chat.closebuttonTopMargin;
 ares_frmmain.pagesrc.closebuttonTopMargin:=ares_frmmain.panel_chat.closebuttonTopMargin;
 ares_frmmain.pgctrl_shareset.closebuttonTopMargin:=ares_frmmain.panel_chat.closebuttonTopMargin;
end else

if pos('hovercopypointa=',cont)=1 then begin
 parsePoint(cont,16,smallTabsHoverCopyPointA);
end else
if pos('hovercopypointb=',cont)=1 then begin
 parsePoint(cont,16,smallTabsHoverCopyPointB);
end else
if pos('hovercopypointc=',cont)=1 then begin
 parsePoint(cont,16,smallTabsHoverCopyPointC);
end else

if pos('downhovercopypointa=',cont)=1 then begin
 parsePoint(cont,20,smallTabsDownHoverCopyPointA);
end else
if pos('downhovercopypointb=',cont)=1 then begin
 parsePoint(cont,20,smallTabsDownHoverCopyPointB);
end else
if pos('downhovercopypointc=',cont)=1 then begin
 parsePoint(cont,20,smallTabsDownHoverCopyPointC);
end else

if pos('downcopypointa=',cont)=1 then begin
 parsePoint(cont,15,smallTabsDownCopyPointA);
end else
if pos('downcopypointb=',cont)=1 then begin
 parsePoint(cont,15,smallTabsDownCopyPointB);
end else
if pos('downcopypointc=',cont)=1 then begin
 parsePoint(cont,15,smallTabsDownCopyPointC);
end else

if pos('clickedcopypointa=',cont)=1 then begin
 parsePoint(cont,18,smallTabsClickedCopyPointA);
end else
if pos('clickedcopypointb=',cont)=1 then begin
 parsePoint(cont,18,smallTabsClickedCopyPointB);
end else
if pos('clickedcopypointc=',cont)=1 then begin
 parsePoint(cont,18,smallTabsClickedCopyPointC);
end else
if pos('copypointleft=',cont)=1 then begin
 parsePoint(cont,14,smallTabsCopyPointLeft);
end else
if pos('copypointmiddle=',cont)=1 then begin
 parsePoint(cont,16,smallTabsCopyPointMiddle);
end else
if pos('copypointright=',cont)=1 then begin
 parsePoint(cont,15,smallTabsCopyPointRight);
end else
if pos('offcopypointa=',cont)=1 then begin
 parsePoint(cont,14,smallTabsOffCopyPointA);
end else
if pos('offcopypointb=',cont)=1 then begin
 parsePoint(cont,14,smallTabsOffCopyPointB);
end else
if pos('offcopypointc=',cont)=1 then begin
 parsePoint(cont,14,smallTabsOffCopyPointC);
end else
if pos('offbtnclosecopy=',cont)=1 then begin
 delete(cont,1,16);
 cont:=trim(cont);
 ExtractRectIntegers(leftI,topI,widthI,HeightI,cont);
 smalltabsOffCloseBtnRect:=rect(leftI,topI,widthI,HeightI);
  ares_frmmain.panel_chat.closeButtonWidth:=widthI;
  ares_frmmain.panel_chat.closeButtonHeight:=heightI;
  ares_frmmain.settings_control.closeButtonWidth:=widthI;
  ares_frmmain.settings_control.closeButtonHeight:=heightI;
  ares_frmmain.pagesrc.closeButtonWidth:=widthI;
  ares_frmmain.pagesrc.closeButtonHeight:=heightI;
  ares_frmmain.pgctrl_shareset.closeButtonWidth:=widthI;
  ares_frmmain.pgctrl_shareset.closeButtonHeight:=heightI;
end else
if pos('hoverbtnclosecopy=',cont)=1 then begin
 delete(cont,1,18);
 cont:=trim(cont);
 ExtractRectIntegers(leftI,topI,widthI,HeightI,cont);
 smalltabsHoverCloseBtnRect:=rect(leftI,topI,widthI,HeightI);
end;

end;

procedure Parse_Tabs(cont:string);
begin
if pos('bitmapfile=',cont)=1 then TabsloadMainBitmap(copy(cont,12,length(cont)))
 else
if pos('height=',cont)=1 then begin
 cont:=trim(copy(cont,8,length(cont)));
 ares_frmmain.tabs_pageview.buttonsHeight:=strTointdef(cont,36);
end else
if pos('captionleft=',cont)=1 then begin
 cont:=trim(copy(cont,13,length(cont)));
 ares_frmmain.tabs_pageview.buttonsLeftMargin:=strToIntdef(cont,14);
end else
if pos('captiontop=',cont)=1 then begin
 cont:=trim(copy(cont,12,length(cont)));
 ares_frmmain.tabs_pageview.buttonsTopMargin:=strToIntDef(cont,12);
end else
if pos('captionright=',cont)=1 then begin
 cont:=trim(copy(cont,14,length(cont)));
 ares_frmmain.tabs_pageview.buttonsRightMargin:=strToIntDef(cont,12);
end else
if pos('buttonsleft=',cont)=1 then begin
 cont:=trim(copy(cont,13,length(cont)));
 ares_frmmain.tabs_pageview.buttonsLeft:=strToIntDef(cont,5);
end else

if pos('hovercopypointa=',cont)=1 then begin
 parsePoint(cont,16,TabsHoverCopyPointA);
end else
if pos('hovercopypointb=',cont)=1 then begin
 parsePoint(cont,16,TabsHoverCopyPointB);
end else
if pos('hovercopypointc=',cont)=1 then begin
 parsePoint(cont,16,TabsHoverCopyPointC);
end else

if pos('downhovercopypointa=',cont)=1 then begin
 parsePoint(cont,20,TabsDownHoverCopyPointA);
end else
if pos('downhovercopypointb=',cont)=1 then begin
 parsePoint(cont,20,TabsDownHoverCopyPointB);
end else
if pos('downhovercopypointc=',cont)=1 then begin
 parsePoint(cont,20,TabsDownHoverCopyPointC);
end else

if pos('downcopypointa=',cont)=1 then begin
 parsePoint(cont,15,TabsDownCopyPointA);
end else
if pos('downcopypointb=',cont)=1 then begin
 parsePoint(cont,15,TabsDownCopyPointB);
end else
if pos('downcopypointc=',cont)=1 then begin
 parsePoint(cont,15,TabsDownCopyPointC);
end else

if pos('clickedcopypointa=',cont)=1 then begin
 parsePoint(cont,18,TabsClickedCopyPointA);
end else
if pos('clickedcopypointb=',cont)=1 then begin
 parsePoint(cont,18,TabsClickedCopyPointB);
end else
if pos('clickedcopypointc=',cont)=1 then begin
 parsePoint(cont,18,TabsClickedCopyPointC);
end else
if pos('copypointleft=',cont)=1 then begin
 parsePoint(cont,14,TabsCopyPointLeft);
end else
if pos('copypointmiddle=',cont)=1 then begin
 parsePoint(cont,16,TabsCopyPointMiddle);
end else
if pos('copypointright=',cont)=1 then begin
 parsePoint(cont,15,TabsCopyPointRight);
end else
if pos('offcopypointa=',cont)=1 then begin
 parsePoint(cont,14,TabsOffCopyPointA);
end else
if pos('offcopypointb=',cont)=1 then begin
 parsePoint(cont,14,TabsOffCopyPointB);
end else
if pos('offcopypointc=',cont)=1 then begin
 parsePoint(cont,14,TabsOffCopyPointC);
end;


end;

procedure ParsePoint(coordStr:string; parseI:integer; var point:TPoint);
var
 leftI,topI:integer;
begin
delete(coordStr,1,parseI);
coordStr:=trim(coordStr);

ExtractPointIntegers(leftI,topI,coordStr);
point.x:=leftI;
point.y:=topI;
end;

procedure parse_windowFrame(cont:string);
begin
if pos('bitmapfile=',cont)=1 then FrameloadMainBitmap(copy(cont,12,length(cont)))
 else
if pos('roundcorner=',cont)=1 then begin
 FrameRoundCorner:=strtointdef(trim(copy(cont,13,length(cont))),0);
 if FrameRoundCorner<0 then FrameRoundCorner:=0;
end else
if pos('window.topleft=',cont)=1 then FrameLoadBitmap(cont,15,FrameTopLeftBitmap,szTopLeft)
 else
if pos('window.top=',cont)=1 then FrameLoadBitmap(cont,11,FrameTopBitmap,szTop)
 else
if pos('window.topright=',cont)=1 then FrameLoadBitmap(cont,16,FrameTopRigthBitmap,szTopRight)
 else
if pos('window.lefttop=',cont)=1 then FrameLoadBitmap(cont,15,FrameLeftTopBitmap,szLeftTop)
 else
if pos('window.left=',cont)=1 then FrameLoadBitmap(cont,12,FrameLeftBitmap,szLeft)
 else
if pos('window.leftbottom=',cont)=1 then FrameLoadBitmap(cont,18,FrameLeftBottomBitmap,szLeftBottom)
 else
if pos('window.bottomleft=',cont)=1 then FrameLoadBitmap(cont,18,FrameBottomLeftBitmap,szBottomLeft)
 else
if pos('window.bottom=',cont)=1 then FrameLoadBitmap(cont,14,FrameBottomBitmap,szBottom)
 else
if pos('window.bottomright=',cont)=1 then FrameLoadBitmap(cont,19,FrameBottomRightBitmap,szBottomRight)
 else
if pos('window.rightbottom=',cont)=1 then FrameLoadBitmap(cont,19,FrameRightBottomBitmap,szRightBottom)
 else
if pos('window.right=',cont)=1 then FrameLoadBitmap(cont,13,FrameRightBitmap,szRight)
 else
if pos('window.righttop=',cont)=1 then FrameLoadBitmap(cont,16,FrameRightTopBitmap,szRightTop)
 else
if pos('window.minimisebtn=',cont)=1 then FrameLoadBitmap(cont,19,FrameMinimiseOffBitmap,szMinBtn)
 else
if pos('window.minimisedown=',cont)=1 then FrameLoadBitmap(cont,20,FrameMinimiseDownBitmap,szMinBtnDown)
 else
if pos('window.minimisehover=',cont)=1 then FrameLoadBitmap(cont,21,FrameMinimiseHoverBitmap,szMinBtnHover)
 else
if pos('window.maximisebtn=',cont)=1 then FrameLoadBitmap(cont,19,FrameMaximiseOffBitmap,szMaxBtn)
 else
if pos('window.maximisedown=',cont)=1 then FrameLoadBitmap(cont,20,FrameMaximiseDownBitmap,szMaxBtnDown)
 else
if pos('window.maximisehover=',cont)=1 then FrameLoadBitmap(cont,21,FrameMaximiseHoverBitmap,szMaxBtnHover)
 else
if pos('window.closebtn=',cont)=1 then FrameLoadBitmap(cont,16,FrameCloseOffBitmap,szCloseBtn)
 else
if pos('window.closedown=',cont)=1 then FrameLoadBitmap(cont,17,FrameCloseDownBitmap,szCloseBtnDown)
 else
if pos('window.closehover=',cont)=1 then FrameLoadBitmap(cont,18,FrameCloseHoverBitmap,szCloseBtnHover)
 else
if pos('btnanchor.close=',cont)=1 then FrameLoadNCAnchor(cont,16,false,false,true)
 else
if pos('btnanchor.minimise=',cont)=1 then FrameLoadNCAnchor(cont,19,true,false,false)
 else
if pos('btnanchor.maximise=',cont)=1 then FrameLoadNCAnchor(cont,19,false,true,false)
 else
if pos('btnrect.close=',cont)=1 then FrameLoadBtnRect(cont,14,brClose)
 else
if pos('btnrect.minimise=',cont)=1 then FrameLoadBtnRect(cont,17,brMinimise)
 else
if pos('btnrect.maximise=',cont)=1 then FrameLoadBtnRect(cont,17,brMaximise)
 else
if pos('icon.rect=',cont)=1 then FrameLoadIconRect(cont,10)
 else
//if pos('icon.prect=',cont)=1 then FrameLoadIconRect(cont,11,true)
// else
if pos('caption.rect=',cont)=1 then FrameLoadCaptionRect(cont,13);
end;


procedure FrameLoadCaptionRect(coordStr:string; parsePoint:integer);
var
 leftI,topI,widthI,HeightI:integer;
begin
delete(coordStr,1,parsePoint);
coordStr:=trim(coordStr);

ExtractRectIntegers(leftI,topI,widthI,HeightI,coordStr);
FCaptionRect:=rect(leftI,topI,widthI,HeightI);
end;


procedure FrameLoadIconRect(coordStr:string; parsePoint:integer);
var
 leftI,topI,widthI,HeightI:integer;
begin
delete(coordStr,1,parsePoint);
coordStr:=trim(coordStr);

ExtractRectIntegers(leftI,topI,widthI,HeightI,coordStr);

//if isPaintRect then FCaptionIconCopyRect:=rect(leftI,topI,widthI,HeightI)
// else
 FCaptionIconRect:=rect(leftI,topI,widthI,HeightI);
end;


procedure FrameLoadBtnRect(coordStr:string; parsePoint:integer; btnType:TBtnRectType);
var
leftI,topI,widthI,HeightI:integer;
begin
delete(coordStr,1,parsePoint);
coordStr:=trim(coordStr);

ExtractRectIntegers(leftI,topI,widthI,HeightI,coordStr);

 case btnType of

  brClose:begin
           closeBtnPaintPoint.x:=leftI;
           closeBtnPaintPoint.y:=topI;
          end;
  brMinimise:begin
             MinimiseBtnPaintPoint.x:=leftI;
             MinimiseBtnPaintPoint.y:=topI;
             end;
  brMaximise:begin
             MaximiseBtnPaintPoint.x:=leftI;
             MaximiseBtnPaintPoint.y:=topI;
             end;
 end;

end;

procedure FrameLoadNCAnchor(coordStr:string; parsePoint:integer; isMinimise,isMaximise,isClose:boolean);
var
leftI,topI,widthI,HeightI:integer;
begin
delete(coordStr,1,parsePoint);
coordStr:=trim(coordStr);

ExtractRectIntegers(leftI,topI,widthI,HeightI,coordStr);

if isMinimise then begin
 MinimisebtnHitRect.left:=leftI;
 MinimisebtnHitRect.Top:=topi;
 MinimisebtnHitRect.right:=widthI;
 MinimisebtnHitRect.bottom:=heightI;
end else
if isMaximise then begin
 MaximisebtnHitRect.Left:=leftI;
 MaximisebtnHitRect.Top:=topi;
 MaximisebtnHitRect.right:=widthI;
 MaximisebtnHitRect.bottom:=heightI;
end else begin
 closebtnHitRect.Left:=leftI;
 closebtnHitRect.Top:=topi;
 closebtnHitRect.right:=widthI;
 closebtnHitRect.bottom:=heightI;
end;


end;

procedure parse_enum(cont:string);
var
objects,value:string;
begin
objectS:=copy(cont,1,pos(' ',cont)-1);
value:=copy(cont,pos('"',cont)+1,length(cont));
delete(value,pos('"',value),length(value));
                       //color_irc_to_color(
if objectS='chat.background' then COLORE_CHAT_BG:=colorstr_toenum(value) else
if objectS='chat.font' then COLORE_CHAT_FONT:=colorstr_toenum(value) else
if objectS='chat.nick' then COLORE_CHAT_NICK:=colorstr_toenum(value) else
if objectS='chat.nickpm' then COLORE_CHATPVTNICK:=colorstr_toenum(value) else
if objectS='chat.public' then vars_global.COLORE_PUBLIC:=colorstr_toenum(value) else
if objectS='chat.join' then vars_global.COLORE_JOIN:=colorstr_toenum(value) else
if objectS='chat.part' then vars_global.COLORE_PART:=colorstr_toenum(value) else
if objectS='chat.emote' then vars_global.COLORE_EMOTE:=colorstr_toenum(value) else
if objectS='chat.notification' then vars_global.COLORE_NOTIFICATION:=colorstr_toenum(value) else
if objectS='chat.error' then vars_global.COLORE_ERROR:=colorstr_toenum(value);

end;

function colorstr_toenum(value:String):byte;
begin   //(clblack,clmaroon,clgreen,$0080ff,clnavy,clpurple,clteal,clgray,clsilver,clred,cllime,clyellow,clblue,clfuchsia,claqua,clwhite); //cl00feffff0
        //'01','05','03','07','02','06','10','14','15','04','09','08','12','13','11','00' (ares) not rtf

if value='black' then result:=1 else
if value='maroon' then result:=2 else
if value='green' then result:=3 else
if value='orange' then result:=4 else
if value='navy' then result:=5 else
if value='purple' then result:=6 else
if value='teal' then result:=7 else
if value='gray' then result:=8 else
if value='silver' then result:=9 else
if value='red' then result:=10 else
if value='lime' then result:=11 else
if value='yellow' then result:=12 else
if value='blue' then result:=13 else
if value='fuchsia' then result:=14 else
if value='aqua' then result:=15 else
if value='white' then result:=16 else result:=1;
end;

procedure parse_bitmap(cont:string);
var
objects:string;
filenW:widestring;
begin
objectS:=copy(cont,1,pos(' ',cont)-1);
 delete(cont,1,pos('"',cont));
 cont:=trim(cont);
filenW:=utf8strtowidestr(copy(cont,1,pos('"',cont)-1));

with ares_frmmain do begin
 if objectS='chat' then load_images(ImageList_chat,filenW,15) else
 if objectS='mimesmall' then load_images(img_mime_small,filenW,22) else
 if objectS='tabsbig' then begin
  load_images(ImageList_tabs,filenW,12);
 end else
 if objectS='libbig' then load_images(imagelist_lib_max,filenW,7) else
 if objectS='emoticons' then load_images(imglist_emotic,filenW,49) else
 if objectS='transfer' then load_images(imglist_transfer,filenW,10) else
 if objectS='tabssmall' then load_images(imagelist_menu,filenW,18) else
 if objectS='screenlogo' then VARS_SCREEN_LOGO:=filenW else
 if objectS='searchpnl' then load_images(imagelist_panel_search,filenW,3) else
 if objectS='mshareset' then load_images(imglist_mfolder,filenW,16) else
 if objectS='searchstars' then load_images(imglist_stars,filenW,4) else
 if objectS='player' then loadCustomPlayerImage(filenW) else
 if objectS='trackbar' then loadCustomPlayerTrackbarImage(filenW);
end;

end;

procedure loadCustomPlayerImage(filenameW:widestring);
var
stream:thandlestream;
bitmap:tbitmap;
begin
  stream:=MyFileOpen(skin_directory+'\'+filenameW,ARES_READONLY_BUT_SEQUENTIAL);
  if stream=nil then exit;

  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf24bit;
  bitmap.LoadFromstream(stream);

  ares_frmmain.MPlayerPanel1.SourceBitmap:=bitmap;

  FreeHandleStream(Stream);
end;

procedure loadCustomPlayerTrackbarImage(filenameW:widestring);
var
stream:thandlestream;
bitmap:tbitmap;
begin
  stream:=MyFileOpen(skin_directory+'\'+filenameW,ARES_READONLY_BUT_SEQUENTIAL);
  if stream=nil then exit;

  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf24bit;
  bitmap.LoadFromstream(stream);

  ares_frmmain.trackbar_player.SourceBitmap:=bitmap;

  FreeHandleStream(Stream);
end;

procedure load_images(imglist:timagelist; filenameW:widestring; numtoadd:integer);
var
bitmap,bitmap2:tbitmap;
stream:thandlestream;
numx,numy,x,y,numadded:integer;
begin
  imglist.Clear;


  stream:=MyFileOpen(skin_directory+'\'+filenameW,ARES_READONLY_BUT_SEQUENTIAL);
  if stream=nil then exit;

  stream.position:=0;

  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf24bit;

 try
  bitmap.LoadFromstream(stream);

  numx:=bitmap.width div imglist.width;
  numy:=bitmap.height div imglist.height;

  numadded:=0;
  for y:=1 to numy do
  for x:=1 to numx do begin
    bitmap2:=tbitmap.create;
    bitmap2.pixelformat:=pf24bit;
    bitmap2.width:=imglist.width;
    bitmap2.height:=imglist.height;

    bitblt(bitmap2.canvas.handle,0,0,bitmap2.width,bitmap2.Height, bitmap.canvas.Handle,(x*bitmap2.width)-bitmap2.width,(y*bitmap2.height)-bitmap2.height, SRCCOPY);

         imglist.AddMasked(bitmap2,clfuchsia);

    bitmap2.free;

    inc(numadded);
    if numadded>numtoadd then break;
  end;


except
end;

  FreeHandleStream(Stream);


  bitmap.free;
end;


procedure parse_credit(cont:string);//cont non lowercase
var
value:string;
objects:string;
begin
objects:=lowercase(trim(copy(cont,1,pos('"',cont)-1)));
value:=copy(cont,pos('"',cont)+1,length(cont));
 delete(value,pos('"',value),length(value));

if objects='' then exit;
if value='' then exit;

with ares_frmmain do begin
 if objects='name' then lbl_opt_skin_title.caption:=ucfirst(objects)+chr(58)+chr(32)+utf8strtowidestr(value) else
 if objects='author' then lbl_opt_skin_author.caption:=ucfirst(objects)+chr(58)+chr(32)+utf8strtowidestr(value) else
 if objects='url' then lbl_opt_skin_url.caption:=utf8strtowidestr(value) else
 if objects='version' then lbl_opt_skin_version.caption:=ucfirst(objects)+chr(58)+chr(32)+utf8strtowidestr(value) else
 if objects='date' then lbl_opt_skin_date.caption:=ucfirst(objects)+chr(58)+chr(32)+utf8strtowidestr(value) else
 if objects='details' then lbl_opt_skin_comments.caption:=ucfirst(objects)+chr(58)+chr(32)+utf8strtowidestr(strip_nl(value));
end;

end;

procedure parse_boolean(cont:string);
var
objects,valueS:string;
value:boolean;
begin
objectS:=copy(cont,1,pos(' ',cont)-1);
 delete(cont,1,pos(' ',cont));
 valueS:=trim(cont);
 value:=(pos('true',valueS)>0);
if objectS='3dprogbars' then SETTING_3D_PROGBAR:=value else
if objectS='xpthemedbuttons' then VARS_THEMED_BUTTONS:=value else
if objectS='xpthemedpanels' then VARS_THEMED_PANELS:=value else
if objectS='xpthemedheaders' then VARS_THEMED_HEADERS:=value;
end;


procedure defaultColors;
begin
COLOR_PROGRESS_DOWN:=$00ee6a16;
ares_frmmain.tabs_pageview.ColorFrame:=clbtnface;//$00262423;
COLOR_DL_COMPLETED:=$00008000;
COLORE_PARTIAL_DOWNLOAD:=$00bbffff;
COLORE_PARTIAL_UPLOAD:=$00eeefb8;
COLOR_MISSING_CHUNK:=$00C0C0C0;
COLOR_CHUNK_COMPLETED:=$00008000;
COLOR_PARTIAL_CHUNK:=$000000ff;
COLORE_DLSOURCE:=$0000dfff;
COLORE_PHASH_VERIFY:=$0000FF00;
COLORE_GRAPH_INK:=$00ff5a00;
COLOR_UL_COMPLETED:=$00008000;
COLOR_UL_CANCELLED:=$00e2eff1;
COLOR_PROGRESS_UP:=$0000dfff;
COLORE_ALTERNATE_ROW:=$00faf3ee;
COLORE_LISTVIEW_HOT:=$00e1dbd7;
COLORE_TRANALTERNATE_ROW:=$00faf3ee;
COLOR_OVERLAY_UPLOAD:=$00e2eff1;
COLORE_ULSOURCE_CHUNK:=$00008000;
COLORE_HINT_BG:=clInfoBk;
ares_frmmain.cmthint.bgcolor:=COLORE_HINT_BG;
COLORE_HINT_FONT:=$00000000;
ares_frmmain.cmthint.font.color:=COLORE_HINT_FONT;
COLORE_GRAPH_BG:=$00FFFFFF;
COLORE_GRAPH_GRID:=$00d8e9ec;
COLORE_PLAYER_BG:=$00e2eff1;
COLORE_PLAYER_FONT:=$00000000;
COLORE_LISTVIEWS_FONT:=$00000000;
COLORE_LISTVIEWS_BG:=$00faf3ee;
COLORE_LISTVIEWS_GRIDLINES:=$00d8e9ec;
COLORE_LISTVIEWS_TREELINES:=$00d8e9ec;
COLORE_SEARCH_PANEL:=$00faf3ee;
COLORE_LIBDETAILS_PANEL:=$00faf3ee;
COLORE_FONT_SEARCHPNL:=$00000000;
COLORE_FONT_LIBDET:=$00000000;
COLORE_LISTVIEWS_FONTALT1:=$00808080;
COLORE_LISTVIEWS_FONTALT2:=$00ffbf95;
COLORE_TOOLBAR_BG:=$00faf3ee;
COLORE_TOOLBAR_FONT:=$00000000;//$00FFFFFF;
COLORE_PANELS_SEPARATOR:=clgray;
COLORE_PANELS_BG:=$00faf3ee;
COLORE_PANELS_FONT:=$00000000;
COLORE_LISTVIEWS_HEADERBK:=$00faf3ee;
COLORE_LISTVIEWS_HEADERFONT:=$00000000;
COLORE_LISTVIEWS_HEADERBORDER:=$00dfd8d4;
//if objectS='chat.background' then COLORE_CHAT_BG:=colorcode else
COLOR_SKINNED_CAPTION:=$00FFFFFF;


COLORE_CHAT_BG:=16;
COLORE_CHAT_FONT:=1;
COLORE_CHAT_NICK:=1;
COLORE_CHATPVTNICK:=8;
COLORE_PUBLIC:=13;
COLORE_JOIN:=3;
COLORE_PART:=4;
COLORE_EMOTE:=6;
COLORE_NOTIFICATION:=5;
COLORE_ERROR:=10;
end;

procedure parse_color(cont:string);
var
colorcodes,objectS:string;
colorcode:integer;
begin
colorcodes:=copy(cont,pos('"',cont)+1,length(cont));
 delete(colorcodes,pos('"',colorcodes),length(colorcodes));

 if pos('cl',colorcodes)=1 then begin
  colorcode:=delphiColorKey_2_color(colorcodes);
 end else begin
  colorcodes:='$00'+copy(colorcodes,5,2)+copy(colorcodes,3,2)+copy(colorcodes,1,2);
  colorcode:=strtointdef(colorcodes,0);
 end;
 

objectS:=copy(cont,1,pos(' ',cont)-1);

if objectS='dlprogbar.progress' then COLOR_PROGRESS_DOWN:=colorcode else
if objectS='clientframe.border' then ares_frmmain.tabs_pageview.ColorFrame:=colorcode else
if objectS='dlprogbar.complete' then COLOR_DL_COMPLETED:=colorcode else
if objectS='dlprogbar.partialdl' then COLORE_PARTIAL_DOWNLOAD:=colorcode else
if objectS='dlprogbar.partialul' then COLORE_PARTIAL_UPLOAD:=colorcode else
if objects='dlprogbar.missinpart' then COLOR_MISSING_CHUNK:=colorcode else
if objectS='dlprogbar.completepart' then COLOR_CHUNK_COMPLETED:=colorcode else
if objectS='dlprogbar.partinprog' then COLOR_PARTIAL_CHUNK:=colorcode else
if objectS='dlprogbar.ichbar' then COLORE_PHASH_VERIFY:=colorcode else
if objectS='hintgraph.ink' then COLORE_GRAPH_INK:=colorcode else
if objects='ulprogbar.complete' then COLOR_UL_COMPLETED:=colorcode else
if objects='ulprogbar.cancelled' then COLOR_UL_CANCELLED:=colorcode else
if objects='ulprogbar.progress' then COLOR_PROGRESS_UP:=colorcode else
if objects='listviews.altrow' then COLORE_ALTERNATE_ROW:=colorcode else
if objects='listviews.hotcolor' then COLORE_LISTVIEW_HOT:=colorcode else
if objects='transfer.altrow' then COLORE_TRANALTERNATE_ROW:=colorcode else
if objects='dlprogbar.dlsource' then COLORE_DLSOURCE:=colorcode else
if objectS='ulprogbar.overlay' then COLOR_OVERLAY_UPLOAD:=colorcode else
if objectS='ulprogbar.part' then COLORE_ULSOURCE_CHUNK:=colorcode else
if objects='hint.background' then begin
                                   COLORE_HINT_BG:=colorcode;
                                   ares_frmmain.cmthint.bgcolor:=colorcode;
                                  end else
if objects='hint.font' then begin
                             COLORE_HINT_FONT:=colorcode;
                             ares_frmmain.cmthint.font.color:=colorcode;
                            end else
if objects='hintgraph.background' then COLORE_GRAPH_BG:=colorcode else
if objectS='hintgraph.grid' then COLORE_GRAPH_GRID:=colorcode else
if objects='player.background' then COLORE_PLAYER_BG:=colorcode else
if objects='player.font' then COLORE_PLAYER_FONT:=colorcode else
if objectS='listviews.font' then COLORE_LISTVIEWS_FONT:=colorcode else
if objectS='listviews.background' then COLORE_LISTVIEWS_BG:=colorcode else
if objectS='listviews.vlines' then COLORE_LISTVIEWS_GRIDLINES:=colorcode else
if objects='listviews.tlines' then COLORE_LISTVIEWS_TREELINES:=colorcode else
if objects='searchpnl.background' then COLORE_SEARCH_PANEL:=colorcode else
if objectS='libdetpnl.background' then COLORE_LIBDETAILS_PANEL:=colorcode else
if objectS='searchpnl.font' then COLORE_FONT_SEARCHPNL:=colorcode else
if objects='libdetpnl.font' then COLORE_FONT_LIBDET:=colorcode else
if objectS='listviews.font2' then COLORE_LISTVIEWS_FONTALT1:=colorcode else
if objectS='listviews.font3' then COLORE_LISTVIEWS_FONTALT2:=colorcode else
if objectS='toolbar.background' then COLORE_TOOLBAR_BG:=colorcode else
if objectS='toolbar.font' then COLORE_TOOLBAR_FONT:=colorcode else
if objectS='panels.separator' then COLORE_PANELS_SEPARATOR:=colorcode else
if objectS='panels.background' then COLORE_PANELS_BG:=colorcode else
if objectS='panels.font' then COLORE_PANELS_FONT:=colorcode else
if objectS='listviews.headerbk' then COLORE_LISTVIEWS_HEADERBK:=colorcode else
if objectS='listviews.headerfont' then COLORE_LISTVIEWS_HEADERFONT:=colorcode else
if objectS='listviews.headerborder' then COLORE_LISTVIEWS_HEADERBORDER:=colorcode else
//if objectS='chat.background' then COLORE_CHAT_BG:=colorcode else
if objectS='caption.font' then helper_skin.COLOR_SKINNED_CAPTION:=colorcode;

end;






end.