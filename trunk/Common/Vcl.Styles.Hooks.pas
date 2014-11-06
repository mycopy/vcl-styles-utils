//**************************************************************************************************
//
// Unit Vcl.Styles.Hooks
// unit for the VCL Styles Utils
// http://code.google.com/p/vcl-styles-utils/
//
// The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License");
// you may not use this file except in compliance with the License. You may obtain a copy of the
// License at http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
// ANY KIND, either express or implied. See the License for the specific language governing rights
// and limitations under the License.
//
// The Original Code is Vcl.Styles.Hooks.pas.
//
// The Initial Developer of the Original Code is Rodrigo Ruz V.
// Portions created by Rodrigo Ruz V. are Copyright (C) 2013-2014 Rodrigo Ruz V.
// All Rights Reserved.
//
//**************************************************************************************************
unit Vcl.Styles.Hooks;

interface

implementation

{$DEFINE HOOK_UXTHEME}

{$IFDEF HOOK_UXTHEME}
 {$DEFINE HOOK_Button}
 {$DEFINE HOOK_Scrollbar}
 {$DEFINE HOOK_TaskDialog}
 {$DEFINE HOOK_ProgressBar}
 {$DEFINE HOOK_DateTimePicker}
 {$DEFINE HOOK_TreeView}
 {$DEFINE HOOK_ListView}
 {$DEFINE HOOK_ComboBox}
 {$DEFINE HOOK_SPIN}
{$ENDIF}

uses
  DDetours,
  System.SysUtils,
  System.Types,
  System.Classes,
  WinApi.Windows,
  Vcl.Graphics,
  Vcl.Styles.Utils.SysControls,
{$IFDEF HOOK_UXTHEME}
  System.UITypes,
  System.Generics.Collections,
  Winapi.UxTheme,
  Winapi.Messages,
  Vcl.GraphUtil,
{$ENDIF}
  System.StrUtils,
  Vcl.ComCtrls,
  Vcl.Styles,
  Vcl.Themes;

{$IFDEF HOOK_UXTHEME}
type
 TDrawThemeBackground  = function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pRect: TRect; Foo: Pointer): HRESULT; stdcall;
{$ENDIF}

type
  TListStyleBrush = TObjectDictionary<Integer, TBrush>;


{$IFDEF HOOK_ProgressBar}
const
  VSCLASS_PROGRESS_INDERTERMINATE        = 'Indeterminate::Progress';
{$ENDIF}

{$IFDEF HOOK_ListView}
const
  VSCLASS_ITEMSVIEW_LISTVIEW             = 'ItemsView::ListView';
{$ENDIF}


var
{$IFDEF HOOK_UXTHEME}
  ThemeLibrary: THandle;
  TrampolineOpenThemeData         : function(hwnd: HWND; pszClassList: LPCWSTR): HTHEME; stdcall =  nil;
  TrampolineCloseThemeData        : function(hTheme: HTHEME): HRESULT; stdcall =  nil;
  TrampolineDrawThemeBackground   : function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pRect: TRect; pClipRect: Pointer): HRESULT; stdcall =  nil;
  TrampolineDrawThemeBackgroundEx : function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pRect: TRect; pOptions: Pointer): HResult; stdcall =  nil;
  TrampolineGetThemeColor         : function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var pColor: COLORREF): HRESULT; stdcall = nil;
  TrampolineGetThemeSysColor      : function(hTheme: HTHEME; iColorId: Integer): COLORREF; stdcall =  nil;
  TrampolineGetThemeSysColorBrush : function(hTheme: HTHEME; iColorId: Integer): HBRUSH; stdcall =  nil;

  TrampolineDrawThemeText         : function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;  pszText: LPCWSTR; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD; const pRect: TRect): HRESULT; stdcall = nil;
  TrampolineDrawThemeTextEx       : function(hTheme: HTHEME; hdc: HDC; iPartId: Integer; iStateId: Integer; pszText: LPCWSTR; cchText: Integer; dwTextFlags: DWORD; pRect: PRect; var pOptions: TDTTOpts): HResult; stdcall = nil;
  THThemesClasses  : TDictionary<HTHEME, string>;
  THThemesHWND     : TDictionary<HTHEME, HWND>;
{$ENDIF}
  VCLStylesBrush  : TObjectDictionary<string, TListStyleBrush>;


  TrampolineGetSysColor           : function (nIndex: Integer): DWORD; stdcall =  nil;
  TrampolineGetSysColorBrush      : function (nIndex: Integer): HBRUSH; stdcall=  nil;
  TrampolineCreateSolidBrush      : function (p1: COLORREF): HBRUSH; stdcall;
  TrampolineCreateBrushIndirect   : function (const p1: TLogBrush): HBRUSH; stdcall = nil;
  TrampolineGetStockObject        : function (Index: Integer): HGDIOBJ; stdcall = nil;

//
//  Trampoline_DrawText                      : function (hDC: HDC; lpString: LPCWSTR; nCount: Integer;  var lpRect: TRect; uFormat: UINT): Integer; stdcall = nil;
//  Trampoline_DrawTextEx                    : function (DC: HDC; lpchText: LPCWSTR; cchText: Integer; var p4: TRect;  dwDTFormat: UINT; DTParams: PDrawTextParams): Integer; stdcall = nil;
//  Trampoline_ExtTextOutW                   : function (DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: LPCWSTR; Count: Longint; Dx: PInteger): BOOL; stdcall = nil;


procedure GradientRoundedFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection; Radius : Integer);
var
  LBuffer : TBitmap;
  LRect : TRect;
  LRgn : THandle;
  LPoint : TPoint;
begin
  LBuffer:=TBitmap.Create;
  try
    LBuffer.Width:=1;
    LBuffer.Height:=ARect.Height;
    LRect.Create(0, 0, 1, ARect.Height);
    GradientFillCanvas(LBuffer.Canvas, AStartColor, AEndColor, LRect, Direction);

    LRgn := CreateRoundRectRgn(ARect.Left, ARect.Top, ARect.Left +  ARect.Width,  ARect.Top + ARect.Height, Radius, Radius);
    if LRgn>0 then
    try
      GetWindowOrgEx(ACanvas.Handle, LPoint);
      OffsetRgn(LRgn, -LPoint.X, -LPoint.Y);
      SelectClipRgn(ACanvas.Handle, LRgn);
      ACanvas.StretchDraw(Rect(ARect.Left,  ARect.Top, ARect.Left + ARect.Width,  ARect.Top + ARect.Height), LBuffer);
      SelectClipRgn(ACanvas.Handle, 0);
    finally
      DeleteObject(LRgn);
    end;
  finally
   LBuffer.Free;
  end;
end;


procedure AlphaBlendFillCanvas(const ACanvas: TCanvas;  const AColor : TColor;const ARect: TRect; SourceConstantAlpha : Byte);
var
 LBuffer   : TBitmap;
 LBlendFunc: TBlendFunction;
begin
  LBuffer := TBitmap.Create;
  try
    LBuffer.Width := ARect.Width;
    LBuffer.Height := ARect.Height;
    LBuffer.Canvas.Brush.Color := AColor;
    LBuffer.Canvas.FillRect(Rect(0, 0, ARect.Width, ARect.Height));
    ZeroMemory(@LBlendFunc, SizeOf(LBlendFunc));
    LBlendFunc.BlendOp := AC_SRC_OVER;
    LBlendFunc.BlendFlags := 0;
    LBlendFunc.SourceConstantAlpha := SourceConstantAlpha;
    LBlendFunc.AlphaFormat := 0;
    AlphaBlend(ACanvas.Handle, ARect.Left, ARect.Top, LBuffer.Width, LBuffer.Height, LBuffer.Canvas.Handle, 0, 0, LBuffer.Width, LBuffer.Height, LBlendFunc);
  finally
    LBuffer.Free;
  end;
end;


{$IFDEF HOOK_UXTHEME}
function Detour_UxTheme_OpenThemeData(hwnd: HWND; pszClassList: LPCWSTR): HTHEME; stdcall;
begin
  Result:=TrampolineOpenThemeData(hwnd, pszClassList);
  if THThemesClasses.ContainsKey(Result) then
    THThemesClasses.Remove(Result);
  THThemesClasses.Add(Result, pszClassList);

  if THThemesHWND.ContainsKey(Result) then
    THThemesHWND.Remove(Result);
  THThemesHWND.Add(Result, hwnd);

  //OutputDebugString(PChar('Detour_UxTheme_OpenThemeData '+pszClassList+' hTheme '+IntToStr(Result)+' Handle '+IntToHex(hwnd, 8)));
end;


procedure DrawParentBackground(Handle : THandle; DC: HDC; const ARect: TRect);
var
  LBuffer: TBitmap;
  LPoint: TPoint;
  ParentHandle : THandle;
begin
  if Handle=0 then exit;
  LPoint := Point(ARect.Left, ARect.Top);
  LBuffer := TBitmap.Create;
  try
    ParentHandle:=GetParent(Handle);
    if ParentHandle<>0 then
    begin
      LBuffer.SetSize(ARect.Width, ARect.Height);
      SendMessage(ParentHandle , WM_ERASEBKGND, LBuffer.Canvas.Handle, 0);
      ClientToScreen(Handle, LPoint);
      ScreenToClient(ParentHandle, LPoint);
      //BitBlt(DC, ARect.Left, ARect.Top, ARect.Width, ARect.Height, Bmp.Canvas.Handle, P.X, P.Y, SRCCOPY)
    end;
  finally
    LBuffer.Free;
  end;
end;


function Detour_UxTheme_DrawThemeMain(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;  const pRect: TRect; Foo: Pointer; Trampoline : TDrawThemeBackground): HRESULT; stdcall;
var
  LBuffer   : TBitmap;
  SaveIndex : integer;
  LDetails  : TThemedElementDetails;
  LScrollDetails: TThemedScrollBar;
  LRect     : TRect;
  LSize     : TSize;
  LColor, LStartColor, LEndColor  : TColor;
  LCanvas   : TCanvas;
begin
//  OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx hTheme %d iPartId %d iStateId %d', [hTheme, iPartId, iStateId])));
//
//  if THThemesClasses.ContainsKey(hTheme)  then
//    OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])))
//  else
//    OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx hTheme %d iPartId %d iStateId %d', [hTheme, iPartId, iStateId])));

  if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled then
    Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
   {$IFDEF HOOK_SPIN}
   if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_SPIN) then
   begin
     case iPartId of
        SPNP_UP :
                        begin
                          case iStateId of
                            UPS_NORMAL   :LDetails:=StyleServices.GetElementDetails(tsUpNormal);
                            UPS_HOT      :LDetails:=StyleServices.GetElementDetails(tsUpHot);
                            UPS_PRESSED  :LDetails:=StyleServices.GetElementDetails(tsUpPressed);
                            UPS_DISABLED :LDetails:=StyleServices.GetElementDetails(tsUpDisabled);
                          end;

                          SaveIndex := SaveDC(hdc);
                          try
                           if THThemesHWND.ContainsKey(hTheme)  then
                             DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);

                           StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                          finally
                            RestoreDC(hdc, SaveIndex);
                          end;
                          Result:=S_OK;
                        end;

        SPNP_DOWN :
                        begin
                          case iStateId of
                            DNS_NORMAL   :LDetails:=StyleServices.GetElementDetails(tsDownNormal);
                            DNS_HOT      :LDetails:=StyleServices.GetElementDetails(tsDownHot);
                            DNS_PRESSED  :LDetails:=StyleServices.GetElementDetails(tsDownPressed);
                            DNS_DISABLED :LDetails:=StyleServices.GetElementDetails(tsDownDisabled);
                          end;

                          SaveIndex := SaveDC(hdc);
                          try
                           if THThemesHWND.ContainsKey(hTheme)  then
                             DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);

                           StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                          finally
                            RestoreDC(hdc, SaveIndex);
                          end;
                          Result:=S_OK;
                        end;
     else
       begin
         //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
         Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
       end;
     end;
   end
   else
   {$ENDIF}
   {$IFDEF HOOK_ComboBox}
   if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_COMBOBOX) then
   begin

     case iPartId of
        CP_DROPDOWNBUTTONRIGHT :
                        begin
                          case iStateId of
                            CBXSR_NORMAL   :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonNormal);
                            CBXSR_HOT      :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonHot);
                            CBXSR_PRESSED  :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonPressed);
                            CBXSR_DISABLED :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonDisabled);
                          end;

                          SaveIndex := SaveDC(hdc);
                          try
                           StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                          finally
                            RestoreDC(hdc, SaveIndex);
                          end;
                          Result:=S_OK;
                        end;


     else
       begin
         //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
         Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
       end;
     end;
   end
   else
   {$ENDIF}
   {$IFDEF HOOK_ListView}
   if  THThemesClasses.ContainsKey(hTheme) and (SameText(THThemesClasses.Items[hTheme], VSCLASS_LISTVIEW) or SameText(THThemesClasses.Items[hTheme], VSCLASS_ITEMSVIEW_LISTVIEW)) then
   begin
        case iPartId of
          LVP_LISTITEM       :
                              begin
                                  case iStateId of
                                      LIS_HOT,
                                      LISS_HOTSELECTED,
                                      LIS_SELECTEDNOTFOCUS,
                                      LIS_SELECTED          : begin
                                                                LColor :=StyleServices.GetSystemColor(clHighlight);
                                                                LCanvas:=TCanvas.Create;
                                                                SaveIndex := SaveDC(hdc);
                                                                try
                                                                  LCanvas.Handle:=hdc;
                                                                  if iStateId=LISS_HOTSELECTED then
                                                                    AlphaBlendFillCanvas(LCanvas, LColor, pRect, 96)
                                                                  else
                                                                    AlphaBlendFillCanvas(LCanvas, LColor, pRect, 50);
                                                                  LCanvas.Pen.Color:=LColor;
                                                                  LCanvas.Brush.Style:=bsClear;
                                                                  LRect:=pRect;
                                                                  LCanvas.Rectangle(LRect.Left, LRect.Top, LRect.Left +  LRect.Width,  LRect.Top + LRect.Height);
                                                                finally
                                                                  LCanvas.Handle:=0;
                                                                  LCanvas.Free;
                                                                  RestoreDC(hdc, SaveIndex);
                                                                end;
                                                                Result:=S_OK;
                                                              end;
                                  else
                                  begin
                                      //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
                                      Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
                                  end;
                                  end;



                              end;

          LVP_EXPANDBUTTON   :
                              begin

                                  case iStateId of
                                      LVEB_NORMAL  : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronOpenedNormal);
                                      LVEB_HOVER   : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronOpenedHot);
                                      LVEB_PUSHED  : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronOpenedPressed);
                                  else
                                      LDetails:=StyleServices.GetElementDetails(tcpThemedChevronOpenedNormal);
                                  end;

                                  SaveIndex := SaveDC(hdc);
                                  try
                                     if THThemesHWND.ContainsKey(hTheme)  then
                                       DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);
                                     StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                                  finally
                                    RestoreDC(hdc, SaveIndex);
                                  end;

                                  Result:=S_OK;
                              end;

          LVP_COLLAPSEBUTTON  :
                              begin

                                  case iStateId of
                                      LVCB_NORMAL  : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronClosedNormal);
                                      LVCB_HOVER   : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronClosedHot);
                                      LVCB_PUSHED  : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronClosedPressed);
                                  else
                                      LDetails:=StyleServices.GetElementDetails(tcpThemedChevronClosedNormal);
                                  end;

                                  SaveIndex := SaveDC(hdc);
                                  try
                                     if THThemesHWND.ContainsKey(hTheme)  then
                                       DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);
                                     StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                                  finally
                                    RestoreDC(hdc, SaveIndex);
                                  end;

                                  Result:=S_OK;
                              end;
          LVP_GROUPHEADER     :
                               begin
                                  case iStateId of
                                   LVGH_OPENMIXEDSELECTIONHOT,
                                   LVGH_OPENSELECTED,
                                   LVGH_OPENSELECTEDNOTFOCUSEDHOT,
                                   LVGH_OPENSELECTEDHOT,
                                   LVGH_CLOSEHOT,
                                   LVGH_CLOSESELECTEDHOT,
                                   LVGH_CLOSESELECTEDNOTFOCUSEDHOT,
                                   LVGHL_CLOSESELECTED,
                                   LVGH_CLOSESELECTEDNOTFOCUSED,
                                   LVGH_CLOSEMIXEDSELECTION,
                                   LVGH_CLOSEMIXEDSELECTIONHOT,
                                   LVGH_OPENHOT         :
                                                         begin
                                                            LColor :=StyleServices.GetSystemColor(clHighlight);
                                                            LCanvas:=TCanvas.Create;
                                                            SaveIndex := SaveDC(hdc);
                                                            try
                                                              LCanvas.Handle:=hdc;
                                                              AlphaBlendFillCanvas(LCanvas, LColor, pRect, 96);
                                                              LCanvas.Pen.Color:=LColor;
                                                              LCanvas.Brush.Style:=bsClear;
                                                              LRect:=pRect;
                                                              LCanvas.Rectangle(LRect.Left, LRect.Top, LRect.Left +  LRect.Width,  LRect.Top + LRect.Height);
                                                            finally
                                                              LCanvas.Handle:=0;
                                                              LCanvas.Free;
                                                              RestoreDC(hdc, SaveIndex);
                                                            end;
                                                            Result:=S_OK;
                                                         end;
                                  else
                                   begin
                                     //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
                                     Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
                                   end;
                                  end;

                               end;
          LVP_GROUPHEADERLINE :
                               begin

                                  case iStateId of
                                   LVGHL_CLOSEHOT,
                                   LVGHL_OPENHOT,
                                   LVGHL_OPENMIXEDSELECTIONHOT,
                                   LVGHL_OPENSELECTEDNOTFOCUSEDHOT,
                                   LVGHL_CLOSESELECTEDNOTFOCUSEDHOT,
                                   LVGHL_OPENSELECTED,
                                   LVGHL_CLOSESELECTED,
                                   LVGHL_CLOSESELECTEDHOT,
                                   LVGHL_CLOSEMIXEDSELECTION,
                                   LVGHL_CLOSEMIXEDSELECTIONHOT,
                                   LVGHL_OPENSELECTEDHOT :
                                                          begin
                                                              //LColor := StyleServices.GetSystemColor(clHighlight);
                                                              LColor := StyleServices.GetSystemColor(clWindowText);
                                                              LCanvas:=TCanvas.Create;
                                                              SaveIndex := SaveDC(hdc);
                                                              try
                                                                LCanvas.Handle:=hdc;
                                                                LCanvas.Pen.Color:=LColor;
                                                                LCanvas.MoveTo(pRect.Left, pRect.Top);
                                                                LCanvas.LineTo(pRect.Right, pRect.Top);
                                                              finally
                                                                LCanvas.Handle:=0;
                                                                LCanvas.Free;
                                                                RestoreDC(hdc, SaveIndex);
                                                              end;

                                                              Result:=S_OK;
                                                          end;

                                   LVGHL_CLOSE,
                                   LVGHL_OPENSELECTEDNOTFOCUSED,
                                   LVGHL_OPEN,
                                   LVGHL_OPENMIXEDSELECTION :
                                                          begin
                                                              LColor := StyleServices.GetSystemColor(clWindowText);
                                                              LCanvas:=TCanvas.Create;
                                                              SaveIndex := SaveDC(hdc);
                                                              try
                                                                LCanvas.Handle:=hdc;
                                                                LCanvas.Pen.Color:=LColor;
                                                                LCanvas.MoveTo(pRect.Left, pRect.Top);
                                                                LCanvas.LineTo(pRect.Right, pRect.Top);
                                                              finally
                                                                LCanvas.Handle:=0;
                                                                LCanvas.Free;
                                                                RestoreDC(hdc, SaveIndex);
                                                              end;

                                                              Result:=S_OK;
                                                          end;
                                  else
                                   begin
                                     //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
                                     Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
                                   end;
                                  end;

                               end;

        else
          begin
            //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
            Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
          end;
        end;

   end
   else
   {$ENDIF}
   {$IFDEF HOOK_DateTimePicker}
   if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_DATEPICKER) then
   begin
     case iPartId of
        DP_DATEBORDER :
                        begin
                          case iStateId of
                            DPDB_NORMAL   :LDetails:=StyleServices.GetElementDetails(teEditBorderNoScrollNormal);
                            DPDB_HOT      :LDetails:=StyleServices.GetElementDetails(teEditBorderNoScrollHot);
                            DPDB_FOCUSED  :LDetails:=StyleServices.GetElementDetails(teEditBorderNoScrollFocused);
                            DPDB_DISABLED :LDetails:=StyleServices.GetElementDetails(teEditBorderNoScrollDisabled);
                          end;

                          SaveIndex := SaveDC(hdc);
                          try
                           StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                          finally
                            RestoreDC(hdc, SaveIndex);
                          end;
                          Result:=S_OK;
                        end;

        DP_SHOWCALENDARBUTTONRIGHT :
                        begin
                          case iStateId of
                            DPSCBR_NORMAL   :LDetails:=StyleServices.GetElementDetails(tcBorderNormal);
                            DPSCBR_HOT      :LDetails:=StyleServices.GetElementDetails(tcBorderHot);
                            DPSCBR_PRESSED  :LDetails:=StyleServices.GetElementDetails(tcBorderHot);
                            DPSCBR_DISABLED :LDetails:=StyleServices.GetElementDetails(tcBorderDisabled);
                          end;

                          SaveIndex := SaveDC(hdc);
                          try
                           StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                          finally
                            RestoreDC(hdc, SaveIndex);
                          end;

                          case iStateId of
                            DPSCBR_NORMAL   :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonNormal);
                            DPSCBR_HOT      :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonHot);
                            DPSCBR_PRESSED  :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonPressed);
                            DPSCBR_DISABLED :LDetails:=StyleServices.GetElementDetails(tcDropDownButtonDisabled);
                          end;

                          SaveIndex := SaveDC(hdc);
                          try
                           LRect:=pRect;
                           InflateRect(LRect, -1, -1);

                           StyleServices.DrawElement(hdc, LDetails, LRect, nil);
                          finally
                            RestoreDC(hdc, SaveIndex);
                          end;
                          Result:=S_OK;
                        end;
     else
       begin
         //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
         Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
       end;
     end;
   end
   else
   if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_MONTHCAL) then
   begin
     case iPartId of
       MC_BORDERS        :
                           begin
                              LDetails:=StyleServices.GetElementDetails(teEditBorderNoScrollNormal);
                              SaveIndex := SaveDC(hdc);
                              try
                                 StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                              finally
                                RestoreDC(hdc, SaveIndex);
                              end;
                              Result:=S_OK;
                           end;

       MC_BACKGROUND,
       MC_GRIDBACKGROUND :
                           begin
                            SaveIndex := SaveDC(hdc);
                            LCanvas := TCanvas.Create;
                            try
                             LCanvas.Handle := hdc;
                             LCanvas.Brush.Color := StyleServices.GetStyleColor(scGrid);
                             LCanvas.FillRect(pRect);

                             //LDetails:=StyleServices.GetElementDetails(teBackgroundNormal);
                             //StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                            finally
                              LCanvas.Handle := 0;
                              LCanvas.Free;
                              RestoreDC(hdc, SaveIndex);
                            end;
                            Result:=S_OK;
                           end;

       MC_COLHEADERSPLITTER  : begin
                                  LStartColor := StyleServices.GetSystemColor(clBtnShadow);
                                  LEndColor   := StyleServices.GetSystemColor(clBtnHighlight);

                                  LCanvas:=TCanvas.Create;
                                  SaveIndex := SaveDC(hdc);
                                  try
                                    LCanvas.Handle:=hdc;
                                    LCanvas.Pen.Color:=LStartColor;
                                    LCanvas.MoveTo(pRect.Left, pRect.Top);
                                    LCanvas.LineTo(pRect.Right, pRect.Top);
                                    LCanvas.Pen.Color:=LEndColor;
                                    LCanvas.MoveTo(pRect.Left, pRect.Top+1);
                                    LCanvas.LineTo(pRect.Right, pRect.Top+1);
                                  finally
                                    LCanvas.Handle:=0;
                                    LCanvas.Free;
                                    RestoreDC(hdc, SaveIndex);
                                  end;

                                  Result:=S_OK;
                               end;

       MC_GRIDCELLBACKGROUND : begin

//                                   case iStateId of
//                                    MCGCB_SELECTED : LDetails:=StyleServices.GetElementDetails(tgCellSelected);
//                                    MCGCB_HOT :LDetails:=StyleServices.GetElementDetails(tgFixedCellHot);
//                                    MCGCB_SELECTEDHOT :LDetails:=StyleServices.GetElementDetails(tgCellSelected);
//                                    MCGCB_SELECTEDNOTFOCUSED :LDetails:=StyleServices.GetElementDetails(tgCellSelected);
//                                    MCGCB_TODAY :LDetails:=StyleServices.GetElementDetails(tgFixedCellHot);
//                                    else
//                                      Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
//                                   end;
//
//                                    SaveIndex := SaveDC(hdc);
//                                    try
//                                       StyleServices.DrawElement(hdc, LDetails, pRect, nil);
//                                    finally
//                                      RestoreDC(hdc, SaveIndex);
//                                    end;

                                      SaveIndex := SaveDC(hdc);
                                      LCanvas:=TCanvas.Create;
                                      try
                                        LCanvas.Handle:=hdc;
                                        LStartColor:= StyleServices.GetSystemColor(clHighlight);
                                        //GradientRoundedFillCanvas(LCanvas, LStartColor, LEndColor, pRect, gdVertical, 4);
                                        if iStateId=MCGCB_TODAY then
                                         AlphaBlendFillCanvas(LCanvas, LStartColor, pRect, 200)
                                        else
                                         AlphaBlendFillCanvas(LCanvas, LStartColor, pRect, 96);

                                        LCanvas.Pen.Color:=LStartColor;
                                        LCanvas.Brush.Style:=bsClear;
                                        LRect:=pRect;
                                        //LCanvas.RoundRect(LRect.Left, LRect.Top, LRect.Left +  LRect.Width,  LRect.Top + LRect.Height, 6, 6);
                                        LCanvas.Rectangle(LRect.Left, LRect.Top, LRect.Left +  LRect.Width,  LRect.Top + LRect.Height);
                                      finally
                                        LCanvas.Handle:=0;
                                        LCanvas.Free;
                                        RestoreDC(hdc, SaveIndex);
                                      end;

                                    Result:=S_OK;
                               end;

        MC_NAVNEXT             : begin
                                    case iStateId of
                                      MCNN_NORMAL    :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnRightNormal);
                                      MCNN_HOT       :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnRightHot);
                                      MCNN_PRESSED   :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnRightPressed);
                                      MCNN_DISABLED  :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnRightDisabled);
                                    end;

                                    SaveIndex := SaveDC(hdc);
                                    try
                                       StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                                    finally
                                      RestoreDC(hdc, SaveIndex);
                                    end;
                                    Result:=S_OK;
                                 end;

        MC_NAVPREV             : begin
                                    case iStateId of
                                      MCNP_NORMAL :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnLeftNormal);
                                      MCNP_HOT :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnLeftHot);
                                      MCNP_PRESSED :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnLeftPressed);
                                      MCNP_DISABLED :  LDetails:=StyleServices.GetElementDetails(tsArrowBtnLeftDisabled);
                                    end;

                                    SaveIndex := SaveDC(hdc);
                                    try
                                       StyleServices.DrawElement(hdc, LDetails, pRect, nil);
                                    finally
                                      RestoreDC(hdc, SaveIndex);
                                    end;
                                    Result:=S_OK;
                                 end;

     else
       begin
         //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
         Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
       end;
     end;
   end
   else
   {$ENDIF}
   {$IFDEF HOOK_Scrollbar}
   if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_SCROLLBAR) then
   begin

      LScrollDetails := tsScrollBarRoot;
      LDetails.Element := TThemedElement.teScrollBar;
      LDetails.Part := iPartId;
      LDetails.State := iStateId;
      LDetails := StyleServices.GetElementDetails(TThemedScrollBar.tsThumbBtnHorzNormal);

      case iPartId  of
        SBP_ARROWBTN :
        begin
          case iStateId of
            ABS_UPNORMAL      : LScrollDetails := tsArrowBtnUpNormal;
            ABS_UPHOT         : LScrollDetails := tsArrowBtnUpHot;
            ABS_UPPRESSED     : LScrollDetails := tsArrowBtnUpPressed;
            ABS_UPDISABLED    : LScrollDetails := tsArrowBtnUpDisabled;
            ABS_DOWNNORMAL    : LScrollDetails := tsArrowBtnDownNormal;
            ABS_DOWNHOT       : LScrollDetails := tsArrowBtnDownHot;
            ABS_DOWNPRESSED   : LScrollDetails := tsArrowBtnDownPressed;
            ABS_DOWNDISABLED  : LScrollDetails := tsArrowBtnDownDisabled;
            ABS_LEFTNORMAL    : LScrollDetails := tsArrowBtnLeftNormal;
            ABS_LEFTHOT       : LScrollDetails := tsArrowBtnLeftHot;
            ABS_LEFTPRESSED   : LScrollDetails := tsArrowBtnLeftPressed;
            ABS_LEFTDISABLED  : LScrollDetails := tsArrowBtnLeftDisabled;
            ABS_RIGHTNORMAL   : LScrollDetails := tsArrowBtnRightNormal;
            ABS_RIGHTHOT      : LScrollDetails := tsArrowBtnRightHot;
            ABS_RIGHTPRESSED  : LScrollDetails := tsArrowBtnRightPressed;
            ABS_RIGHTDISABLED : LScrollDetails := tsArrowBtnRightDisabled;
            ABS_UPHOVER       : LScrollDetails := tsArrowBtnUpNormal;//tsArrowBtnUpHover;
            ABS_DOWNHOVER     : LScrollDetails := tsArrowBtnDownNormal;//tsArrowBtnDownHover;
            ABS_LEFTHOVER     : LScrollDetails := tsArrowBtnLeftNormal;//tsArrowBtnLeftHover;
            ABS_RIGHTHOVER    : LScrollDetails := tsArrowBtnRightNormal;//tsArrowBtnRightHover;
          end;
        end;

        SBP_THUMBBTNHORZ:
        begin
          case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsThumbBtnHorzNormal;
           SCRBS_HOT      : LScrollDetails := tsThumbBtnHorzHot;
           SCRBS_PRESSED  : LScrollDetails := tsThumbBtnHorzPressed;
           SCRBS_DISABLED : LScrollDetails := tsThumbBtnHorzDisabled;
           SCRBS_HOVER    : LScrollDetails := tsThumbBtnHorzNormal;
          end;
        end;

        SBP_THUMBBTNVERT:
        begin
          case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsThumbBtnVertNormal;
           SCRBS_HOT      : LScrollDetails := tsThumbBtnVertHot;
           SCRBS_PRESSED  : LScrollDetails := tsThumbBtnVertPressed;
           SCRBS_DISABLED : LScrollDetails := tsThumbBtnVertDisabled;
           SCRBS_HOVER    : LScrollDetails := tsThumbBtnVertNormal;
          end;
        end;

        SBP_LOWERTRACKHORZ:
        begin
          case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsLowerTrackHorzNormal;
           SCRBS_HOT      : LScrollDetails := tsLowerTrackHorzHot;
           SCRBS_PRESSED  : LScrollDetails := tsLowerTrackHorzPressed;
           SCRBS_DISABLED : LScrollDetails := tsLowerTrackHorzDisabled;
           SCRBS_HOVER    : LScrollDetails := tsLowerTrackHorzNormal;//tsLowerTrackHorzHover; //no support for hover
          end;
        end;

        SBP_UPPERTRACKHORZ :
        begin
         case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsUpperTrackHorzNormal;
           SCRBS_HOT      : LScrollDetails := tsUpperTrackHorzHot;
           SCRBS_PRESSED  : LScrollDetails := tsUpperTrackHorzPressed;
           SCRBS_DISABLED : LScrollDetails := tsUpperTrackHorzDisabled;
           SCRBS_HOVER    : LScrollDetails := tsUpperTrackHorzNormal;//tsUpperTrackHorzHover; //no support for hover
         end;
        end;

        SBP_LOWERTRACKVERT:
        begin
         case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsLowerTrackVertNormal;
           SCRBS_HOT      : LScrollDetails := tsLowerTrackVertHot;
           SCRBS_PRESSED  : LScrollDetails := tsLowerTrackVertPressed;
           SCRBS_DISABLED : LScrollDetails := tsLowerTrackVertDisabled;
           SCRBS_HOVER    : LScrollDetails := tsLowerTrackVertNormal;//tsLowerTrackVertHover; //no support for hover
         end;
        end;

        SBP_UPPERTRACKVERT:
        begin
         case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsUpperTrackVertNormal;
           SCRBS_HOT      : LScrollDetails := tsUpperTrackVertHot;
           SCRBS_PRESSED  : LScrollDetails := tsUpperTrackVertPressed;
           SCRBS_DISABLED : LScrollDetails := tsUpperTrackVertDisabled;
           SCRBS_HOVER    : LScrollDetails := tsUpperTrackVertNormal;//tsUpperTrackVertHover; //no support for hover
         end;
        end;

        SBP_SIZEBOX :
        begin
         case iStateId of
          SZB_RIGHTALIGN            : LScrollDetails := tsSizeBoxRightAlign;
          SZB_LEFTALIGN             : LScrollDetails := tsSizeBoxLeftAlign;
          SZB_TOPRIGHTALIGN         : LScrollDetails := tsSizeBoxTopRightAlign;
          SZB_TOPLEFTALIGN          : LScrollDetails := tsSizeBoxTopLeftAlign;
          SZB_HALFBOTTOMRIGHTALIGN  : LScrollDetails := tsSizeBoxHalfBottomRightAlign;
          SZB_HALFBOTTOMLEFTALIGN   : LScrollDetails := tsSizeBoxHalfBottomLeftAlign;
          SZB_HALFTOPRIGHTALIGN     : LScrollDetails := tsSizeBoxHalfTopRightAlign;
          SZB_HALFTOPLEFTALIGN      : LScrollDetails := tsSizeBoxHalfTopLeftAlign;
         end;
        end;

        SBP_GRIPPERHORZ :
        begin
         case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsGripperHorzNormal;
           SCRBS_HOT      : LScrollDetails := tsGripperHorzHot;
           SCRBS_PRESSED  : LScrollDetails := tsGripperHorzPressed;
           SCRBS_DISABLED : LScrollDetails := tsGripperHorzDisabled;
           SCRBS_HOVER    : LScrollDetails := tsGripperHorzHover;//tsGripperHorzHover; //no support for hover
         end;
        end;

        SBP_GRIPPERVERT :
        begin
         case iStateId of
           SCRBS_NORMAL   : LScrollDetails := tsGripperVertNormal;
           SCRBS_HOT      : LScrollDetails := tsGripperVertHot;
           SCRBS_PRESSED  : LScrollDetails := tsGripperVertPressed;
           SCRBS_DISABLED : LScrollDetails := tsGripperVertDisabled;
           SCRBS_HOVER    : LScrollDetails := tsGripperVertNormal;//tsGripperVertHover; //no support for hover
         end;
        end;

      end;
      LDetails := StyleServices.GetElementDetails(LScrollDetails);

      if (iPartId=SBP_THUMBBTNHORZ) then
        StyleServices.DrawElement(hdc, StyleServices.GetElementDetails(tsUpperTrackHorzNormal), pRect, nil)
      else
      if (iPartId=SBP_THUMBBTNVERT) then
        StyleServices.DrawElement(hdc, StyleServices.GetElementDetails(tsUpperTrackVertNormal), pRect, nil);

      StyleServices.DrawElement(hdc, LDetails, pRect, nil);
      Exit(S_OK);

   end
   else
   {$ENDIF}
   {$IFDEF HOOK_Progressbar}
   if  THThemesClasses.ContainsKey(hTheme) and (SameText(THThemesClasses.Items[hTheme], VSCLASS_PROGRESS) or SameText(THThemesClasses.Items[hTheme], VSCLASS_PROGRESS_INDERTERMINATE)) then
   begin
        case iPartId of
         PP_BAR         :   LDetails:=StyleServices.GetElementDetails(tpBar);
         PP_BARVERT     :   LDetails:=StyleServices.GetElementDetails(tpBarVert);
         PP_CHUNK       :   LDetails:=StyleServices.GetElementDetails(tpChunk);
         PP_CHUNKVERT   :   LDetails:=StyleServices.GetElementDetails(tpChunkVert);

         PP_FILL        :   if SameText(THThemesClasses.Items[hTheme], VSCLASS_PROGRESS) then
                             LDetails:=StyleServices.GetElementDetails(tpChunk)//GetElementDetails(tpChunk);//GetElementDetails(tpFill);   not defined
                            else
                             LDetails:=StyleServices.GetElementDetails(tpBar);
         PP_FILLVERT    :    LDetails:=StyleServices.GetElementDetails(tpChunkVert);//GetElementDetails(tpFillVert); not defined

//      Use the Native PP_PULSEOVERLAY part to get better results.
//      PP_PULSEOVERLAY : if SameText(THThemesClasses.Items[hTheme], VSCLASS_PROGRESS) then
//                         LDetails:=StyleServices.GetElementDetails(tpChunk)//GetElementDetails(tpPulseOverlay);
//                        else
//                         LDetails:=StyleServices.GetElementDetails(tpBar);

         PP_MOVEOVERLAY      : if SameText(THThemesClasses.Items[hTheme], VSCLASS_PROGRESS) then
                                LDetails:=StyleServices.GetElementDetails(tpMoveOverlay)
                               else
                                LDetails:=StyleServices.GetElementDetails(tpChunk);

//       PP_PULSEOVERLAYVERT :   LDetails:=StyleServices.GetElementDetails(tpPulseOverlayVert);
//       PP_MOVEOVERLAYVERT  :   LDetails:=StyleServices.GetElementDetails(tpMoveOverlayVert);

         PP_TRANSPARENTBAR       :   LDetails:=StyleServices.GetElementDetails(tpBar);//GetElementDetails(tpTransparentBarNormal); not defined
         PP_TRANSPARENTBARVERT   :   LDetails:=StyleServices.GetElementDetails(tpBarVert);//GetElementDetails(tpTransparentBarVertNormal); not defined
        else
        begin
          //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeMain hTheme %d iPartId %d iStateId %d', [hTheme, iPartId, iStateId])));
          Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
        end;
        end;

        SaveIndex := SaveDC(hdc);
        try
           if THThemesHWND.ContainsKey(hTheme)  then
             DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);
           StyleServices.DrawElement(hdc, LDetails, pRect, nil);
        finally
          RestoreDC(hdc, SaveIndex);
        end;
        Result:=S_OK;
   end
   else
   {$ENDIF}
   {$IFDEF HOOK_TaskDialog}
   if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_TASKDIALOG) then
   begin

        case iPartId of

            TDLG_PRIMARYPANEL  :
            begin
              //LDetails:=StyleServices.GetElementDetails(ttdPrimaryPanel);   //ttdPrimaryPanel  this element is not included in the VCL Styles yet
              LColor:=StyleServices.GetStyleColor(scEdit);
              LCanvas:=TCanvas.Create;
              SaveIndex := SaveDC(hdc);
              try
                LCanvas.Handle:=hdc;
                LCanvas.Brush.Color:=LColor;
                LCanvas.FillRect(pRect);
              finally
                LCanvas.Handle:=0;
                LCanvas.Free;
                RestoreDC(hdc, SaveIndex);
              end;
              Result:=S_OK;
            end;

            TDLG_FOOTNOTEPANE,
            TDLG_SECONDARYPANEL  :
            begin
              LDetails:=StyleServices.GetElementDetails(tpPanelBackground);   //ttdSecondaryPanel  this element is not included in the VCL Styles yet
              StyleServices.GetElementColor(LDetails, ecFillColor, LColor);
              LCanvas:=TCanvas.Create;
              SaveIndex := SaveDC(hdc);
              try
                LCanvas.Handle:=hdc;
                LCanvas.Brush.Color:=LColor;
                LCanvas.FillRect(pRect);
              finally
                LCanvas.Handle:=0;
                LCanvas.Free;
                RestoreDC(hdc, SaveIndex);
              end;


              Result:=S_OK;
            end;

            TDLG_EXPANDOBUTTON :
            begin
              case iStateId of
                  TDLGEBS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronClosedNormal);
                  TDLGEBS_HOVER      : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronClosedHot);
                  TDLGEBS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronClosedPressed);

                  TDLGEBS_EXPANDEDNORMAL : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronOpenedNormal);
                  TDLGEBS_EXPANDEDHOVER     : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronOpenedHot);
                  TDLGEBS_EXPANDEDPRESSED        : LDetails:=StyleServices.GetElementDetails(tcpThemedChevronOpenedPressed);
              end;

              SaveIndex := SaveDC(hdc);
              try
                 if THThemesHWND.ContainsKey(hTheme)  then
                   DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);
                 StyleServices.DrawElement(hdc, LDetails, pRect, nil);
              finally
                RestoreDC(hdc, SaveIndex);
              end;

              Result:=S_OK;
            end;

            TDLG_FOOTNOTESEPARATOR :
            begin
              LStartColor := StyleServices.GetSystemColor(clBtnShadow);
              LEndColor   := StyleServices.GetSystemColor(clBtnHighlight);

              LCanvas:=TCanvas.Create;
              SaveIndex := SaveDC(hdc);
              try
                LCanvas.Handle:=hdc;
                LCanvas.Pen.Color:=LStartColor;
                LCanvas.MoveTo(pRect.Left, pRect.Top);
                LCanvas.LineTo(pRect.Right, pRect.Top);
                LCanvas.Pen.Color:=LEndColor;
                LCanvas.MoveTo(pRect.Left, pRect.Top+1);
                LCanvas.LineTo(pRect.Right, pRect.Top+1);
              finally
                LCanvas.Handle:=0;
                LCanvas.Free;
                RestoreDC(hdc, SaveIndex);
              end;

              Result:=S_OK;
            end
        else
          begin
           Result:= Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo);
           //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
          end;
        end;

   end
  else
  {$ENDIF}
  {$IFDEF HOOK_Button}
  if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_BUTTON) then
  begin
        case iPartId of

            BP_PUSHBUTTON  :
            begin
              case iStateId of
                  PBS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tbPushButtonNormal);
                  PBS_HOT      : LDetails:=StyleServices.GetElementDetails(tbPushButtonHot);
                  PBS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tbPushButtonPressed);
                  PBS_DISABLED : LDetails:=StyleServices.GetElementDetails(tbPushButtonDisabled);
                  PBS_DEFAULTED     : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaulted);
                  PBS_DEFAULTED_ANIMATING        : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaultedAnimating);
              end;

              SaveIndex := SaveDC(hdc);
              try
                 if THThemesHWND.ContainsKey(hTheme)  then
                   DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);
                 StyleServices.DrawElement(hdc, LDetails, pRect, nil);
              finally
                RestoreDC(hdc, SaveIndex);
              end;

              Result:=S_OK;
            end;

            BP_COMMANDLINK  :
            begin

              case iStateId of
                  CMDLS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tbPushButtonNormal);
                  CMDLS_HOT      : LDetails:=StyleServices.GetElementDetails(tbPushButtonHot);
                  CMDLS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tbPushButtonPressed);
                  CMDLS_DISABLED : LDetails:=StyleServices.GetElementDetails(tbPushButtonDisabled);
                  CMDLS_DEFAULTED     : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaulted);
                  CMDLS_DEFAULTED_ANIMATING        : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaultedAnimating);
              end;

//              case iStateId of
//                  CMDLS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tbCommandLinkNormal);
//                  CMDLS_HOT      : LDetails:=StyleServices.GetElementDetails(tbCommandLinkHot);
//                  CMDLS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tbCommandLinkPressed);
//                  CMDLS_DISABLED : LDetails:=StyleServices.GetElementDetails(tbCommandLinkDisabled);
//                  CMDLS_DEFAULTED     : LDetails:=StyleServices.GetElementDetails(tbCommandLinkDefaulted);
//                  CMDLS_DEFAULTED_ANIMATING        : LDetails:=StyleServices.GetElementDetails(tbCommandLinkDefaultedAnimating);
//              end;

              SaveIndex := SaveDC(hdc);
              try
                 if THThemesHWND.ContainsKey(hTheme)  then
                   DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);
                 StyleServices.DrawElement(hdc, LDetails, pRect, nil);
              finally
                RestoreDC(hdc, SaveIndex);
              end;

              Result:=S_OK;
            end;

            BP_COMMANDLINKGLYPH  :
            begin
              case iStateId of
                  CMDLGS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tbCommandLinkGlyphNormal);
                  CMDLGS_HOT      : LDetails:=StyleServices.GetElementDetails(tbCommandLinkGlyphHot);
                  CMDLGS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tbCommandLinkGlyphPressed);
                  CMDLGS_DISABLED : LDetails:=StyleServices.GetElementDetails(tbCommandLinkGlyphDisabled);
                  CMDLGS_DEFAULTED: LDetails:=StyleServices.GetElementDetails(tbCommandLinkGlyphDefaulted);
              end;

              SaveIndex := SaveDC(hdc);
              try
                 if THThemesHWND.ContainsKey(hTheme)  then
                   DrawParentBackground(THThemesHWND.Items[hTheme], hdc, pRect);
                 StyleServices.DrawElement(hdc, LDetails, pRect, nil);
              finally
                RestoreDC(hdc, SaveIndex);
              end;

              Result:=S_OK;
            end;

            BP_RADIOBUTTON  :
            begin
              case iStateId of
                  RBS_UNCHECKEDNORMAL   : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedNormal);
                  RBS_UNCHECKEDHOT      : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedHot);
                  RBS_UNCHECKEDPRESSED  : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedPressed);
                  RBS_UNCHECKEDDISABLED : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedDisabled);
                  RBS_CHECKEDNORMAL     : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedNormal);
                  RBS_CHECKEDHOT        : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedHot);
                  RBS_CHECKEDPRESSED    : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedPressed);
                  RBS_CHECKEDDISABLED   : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedDisabled);
              end;

              SaveIndex := SaveDC(hdc);
              try
                 StyleServices.DrawElement(hdc, LDetails, pRect, nil);
              finally
                RestoreDC(hdc, SaveIndex);
              end;

              Result:=S_OK;
            end;

            BP_CHECKBOX  :
            begin
              case iStateId of
                  CBS_UNCHECKEDNORMAL     : LDetails:=StyleServices.GetElementDetails(tbCheckBoxUncheckedNormal);
                  CBS_UNCHECKEDHOT        : LDetails:=StyleServices.GetElementDetails(tbCheckBoxUncheckedHot);
                  CBS_UNCHECKEDPRESSED    : LDetails:=StyleServices.GetElementDetails(tbCheckBoxUncheckedPressed);
                  CBS_UNCHECKEDDISABLED   : LDetails:=StyleServices.GetElementDetails(tbCheckBoxUncheckedDisabled);
                  CBS_CHECKEDNORMAL       : LDetails:=StyleServices.GetElementDetails(tbCheckBoxCheckedNormal);
                  CBS_CHECKEDHOT          : LDetails:=StyleServices.GetElementDetails(tbCheckBoxCheckedHot);
                  CBS_CHECKEDPRESSED      : LDetails:=StyleServices.GetElementDetails(tbCheckBoxCheckedPressed);
                  CBS_CHECKEDDISABLED     : LDetails:=StyleServices.GetElementDetails(tbCheckBoxCheckedDisabled);
                  CBS_MIXEDNORMAL         : LDetails:=StyleServices.GetElementDetails(tbCheckBoxMixedNormal);
                  CBS_MIXEDHOT            : LDetails:=StyleServices.GetElementDetails(tbCheckBoxMixedHot);
                  CBS_MIXEDPRESSED        : LDetails:=StyleServices.GetElementDetails(tbCheckBoxMixedPressed);
                  CBS_MIXEDDISABLED       : LDetails:=StyleServices.GetElementDetails(tbCheckBoxMixedDisabled);
                  { For Windows >= Vista }
                  CBS_IMPLICITNORMAL      : LDetails:=StyleServices.GetElementDetails(tbCheckBoxImplicitNormal);
                  CBS_IMPLICITHOT         : LDetails:=StyleServices.GetElementDetails(tbCheckBoxImplicitHot);
                  CBS_IMPLICITPRESSED     : LDetails:=StyleServices.GetElementDetails(tbCheckBoxImplicitPressed);
                  CBS_IMPLICITDISABLED    : LDetails:=StyleServices.GetElementDetails(tbCheckBoxImplicitDisabled);
                  CBS_EXCLUDEDNORMAL      : LDetails:=StyleServices.GetElementDetails(tbCheckBoxExcludedNormal);
                  CBS_EXCLUDEDHOT         : LDetails:=StyleServices.GetElementDetails(tbCheckBoxExcludedHot);
                  CBS_EXCLUDEDPRESSED     : LDetails:=StyleServices.GetElementDetails(tbCheckBoxExcludedPressed);
                  CBS_EXCLUDEDDISABLED    : LDetails:=StyleServices.GetElementDetails(tbCheckBoxExcludedDisabled);
              end;

              SaveIndex := SaveDC(hdc);
              try
                StyleServices.DrawElement(hdc, LDetails, pRect, nil);
              finally
                RestoreDC(hdc, SaveIndex);
              end;
              Result:=S_OK;
            end
        else
         begin
          Result:= Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo);
          //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
         end;
        end;
  end
  else
  {$ENDIF}
  {$IFDEF HOOK_TreeView}
  if  THThemesClasses.ContainsKey(hTheme) and SameText(THThemesClasses.Items[hTheme], VSCLASS_TREEVIEW) then
  begin
    if ((iPartId = TVP_GLYPH) and ((iStateId=GLPS_OPENED) or (iStateId=GLPS_CLOSED))) or
       ((iPartId = TVP_HOTGLYPH) and ((iStateId=HGLPS_OPENED) or (iStateId=HGLPS_CLOSED))) then
    begin
      if (iStateId=GLPS_OPENED) or (iStateId=HGLPS_OPENED) then
       LDetails := StyleServices.GetElementDetails(tcbCategoryGlyphOpened)
      else
       LDetails := StyleServices.GetElementDetails(tcbCategoryGlyphClosed);

       LBuffer:=TBitmap.Create;
       try
         LSize.cx:=10;
         LSize.cy:=10;
         LRect := Rect(0, 0, LSize.Width, LSize.Height);
         LBuffer.SetSize(LRect.Width, LRect.Height);
         StyleServices.DrawElement(LBuffer.Canvas.Handle, LDetails, LRect);
         BitBlt(hdc, pRect.Left, pRect.Top, LRect.Width, LRect.Height, LBuffer.Canvas.Handle, 0, 0, SRCCOPY);
       finally
         LBuffer.Free;
       end;
       Exit(S_OK);
    end
    else
    if (iPartId = TVP_TREEITEM)  then
    begin
          case iStateId of
            TREIS_HOT,
            TREIS_SELECTED,
            TREIS_SELECTEDNOTFOCUS,
            TREIS_HOTSELECTED
                              :
                               begin
                                  SaveIndex := SaveDC(hdc);
                                  LCanvas:=TCanvas.Create;
                                  try
                                    LCanvas.Handle:=hdc;
                                    LStartColor:= StyleServices.GetSystemColor(clHighlight);
                                    AlphaBlendFillCanvas(LCanvas, LStartColor, pRect, 96);
                                    LCanvas.Pen.Color:=LStartColor;
                                    LCanvas.Brush.Style:=bsClear;
                                    LRect:=pRect;
                                    LCanvas.Rectangle(LRect.Left, LRect.Top, LRect.Left +  LRect.Width,  LRect.Top + LRect.Height);
                                  finally
                                    LCanvas.Handle:=0;
                                    LCanvas.Free;
                                    RestoreDC(hdc, SaveIndex);
                                  end;
                                  Result:=S_OK;
                               end;
          else
              Exit(Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo));
          end;
    end
    else
    begin
     Result:= Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo);
     //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
    end;
  end
  else
  {$ENDIF}
  begin
    Result:= Trampoline(hTheme, hdc, iPartId, iStateId, pRect, Foo);
    //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeBackgroundEx  class %s hTheme %d iPartId %d iStateId %d', [THThemesClasses.Items[hTheme],hTheme, iPartId, iStateId])));
  end;
end;

function Detour_UxTheme_DrawThemeBackgroundEx(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;  const pRect: TRect; pOptions: Pointer): HRESULT; stdcall;
begin
  if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled then
    Exit(TrampolineDrawThemeBackgroundEx(hTheme, hdc, iPartId, iStateId, pRect, pOptions))
  else
    Exit(Detour_UxTheme_DrawThemeMain(hTheme, hdc, iPartId, iStateId, pRect, pOptions, TrampolineDrawThemeBackgroundEx));
end;

function Detour_UxTheme_DrawThemeBackground(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;  const pRect: TRect; pClipRect: Pointer): HRESULT; stdcall;
begin
  if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled then
    Exit(TrampolineDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect))
  else
    Exit(Detour_UxTheme_DrawThemeMain(hTheme, hdc, iPartId, iStateId, pRect, pClipRect, TrampolineDrawThemeBackground));
end;

function Detour_GetThemeSysColor(hTheme: HTHEME; iColorId: Integer): COLORREF; stdcall;
begin
  if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled then
   Result:= TrampolineGetThemeSysColor(hTheme, iColorId)
  else
   Result:= StyleServices.GetSystemColor(iColorId or Integer($FF000000));
end;

function Detour_GetThemeSysColorBrush(hTheme: HTHEME; iColorId: Integer): HBRUSH; stdcall;
begin
  //OutputDebugString(PChar(Format('GetThemeSysColorBrush hTheme %d iColorId %d', [hTheme, iColorId])));
  Exit(TrampolineGetThemeSysColorBrush(hTheme, iColorId));
end;


function Detour_GetThemeColor(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var pColor: COLORREF): HRESULT;  stdcall;
begin
  if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled then
   Result:=TrampolineGetThemeColor(hTheme, iPartId, iStateId, iPropId, pColor)
  else
  begin
    if THThemesClasses.ContainsKey(hTheme) then
    begin
      {$IFDEF HOOK_TaskDialog}
      if SameText(THThemesClasses.Items[hTheme], VSCLASS_TASKDIALOGSTYLE) then
      begin
         case iPartId of
           TDLG_MAININSTRUCTIONPANE : begin
                                       pColor:= StyleServices.GetSystemColor(clHighlight);
                                       Result:= S_OK;
                                      end;

           TDLG_CONTENTPANE         : begin
                                       pColor:= StyleServices.GetSystemColor(clWindowText);
                                       Result:= S_OK;
                                      end;
          TDLG_EXPANDOTEXT,
          TDLG_EXPANDEDFOOTERAREA,
          TDLG_FOOTNOTEPANE,
          TDLG_VERIFICATIONTEXT,
          //TDLG_RADIOBUTTONPANE,
          TDLG_EXPANDEDCONTENT      : begin
                                       pColor:= StyleServices.GetSystemColor(clWindowText);
                                       Result:= S_OK;
                                      end;
         else
          begin
           Result:=TrampolineGetThemeColor(hTheme, iPartId, iStateId, iPropId, pColor);
           //pColor:=clRed;
           //Result:=S_OK;
           //OutputDebugString(PChar(Format('Detour_GetThemeColor hTheme %d iPartId %d iStateId %d  Color %8.x', [hTheme, iPartId, iStateId, pColor])));
          end;
         end;
      end
      else
      {$ENDIF}
      begin
       Result:=TrampolineGetThemeColor(hTheme, iPartId, iStateId, iPropId, pColor);
       //pColor:=clGreen;
       //Result:=S_OK;
       //OutputDebugString(PChar(Format('Detour_GetThemeColor hTheme %d iPartId %d iStateId %d  Color %8.x', [hTheme, iPartId, iStateId, pColor])));
      end;
    end
    else
    begin
     Result:=TrampolineGetThemeColor(hTheme, iPartId, iStateId, iPropId, pColor);
     //pColor:=clFuchsia;
     //Result:=S_OK;
     //OutputDebugString(PChar(Format('Detour_GetThemeColor hTheme %d iPartId %d iStateId %d  Color %8.x', [hTheme, iPartId, iStateId, pColor])));
    end;
  end;
end;

function Detour_UxTheme_DrawThemeText(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;  pszText: LPCWSTR; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD; const pRect: TRect): HRESULT; stdcall;
var
  LDetails: TThemedElementDetails;
  ThemeTextColor : TColor;
  p, SaveIndex : Integer;
  LCanvas : TCanvas;
  plf: LOGFONTW;
  LText : string;
  LRect : TRect;
begin
 if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled or (dwTextFlags and DT_CALCRECT <> 0) then
  Exit(TrampolineDrawThemeText(hTheme, hdc, iPartId, iStateId, pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect));

 // OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeText hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));

 if THThemesClasses.ContainsKey(hTheme) then
 begin
   {$IFDEF  HOOK_DateTimePicker}
   if SameText(THThemesClasses.Items[hTheme], VSCLASS_DATEPICKER) then
   begin
     case iPartId of
        DP_DATETEXT :
                        begin
                          case iStateId of
                            DPDT_NORMAL    :begin
                                             ThemeTextColor:=StyleServices.GetSystemColor(clWindowText);
                                             LDetails:=StyleServices.GetElementDetails(teEditTextNormal);
                                            end;
                            DPDT_DISABLED  :begin
                                             ThemeTextColor:=StyleServices.GetSystemColor(clGrayText);
                                             LDetails:=StyleServices.GetElementDetails(teEditTextDisabled);
                                            end;
                            DPDT_SELECTED  :begin
                                             ThemeTextColor:=StyleServices.GetSystemColor(clHighlightText);
                                             LDetails:=StyleServices.GetElementDetails(tgCellSelected); //Fix issue with selected text color
                                            end;
                          end;

                          LRect:=pRect;
                          StyleServices.DrawText(hdc, LDetails, string(pszText), LRect, TTextFormatFlags(dwTextFlags), ThemeTextColor);
                          Result:=S_OK;
                        end;
     else
         Exit(TrampolineDrawThemeText(hTheme, hdc, iPartId, iStateId, pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect));
     end;
   end
   else
   if SameText(THThemesClasses.Items[hTheme], VSCLASS_MONTHCAL) then
   begin
     case iPartId of
        MC_GRIDCELL  : begin
//                          case iStateId of
//                           MCGCB_SELECTED           :   LDetails:=StyleServices.GetElementDetails(tgCellSelected);
//                           MCGCB_HOT                :   LDetails:=StyleServices.GetElementDetails(tgFixedCellHot);
//                           MCGCB_SELECTEDHOT        :   LDetails:=StyleServices.GetElementDetails(tgCellSelected);
//                           MCGCB_SELECTEDNOTFOCUSED :   LDetails:=StyleServices.GetElementDetails(tgCellSelected);
//                           MCGCB_TODAY              :   LDetails:=StyleServices.GetElementDetails(tgFixedCellHot);
//                          else
//                              LDetails:=StyleServices.GetElementDetails(tgCellNormal);
//                          end;

                          LDetails:=StyleServices.GetElementDetails(tgCellNormal);

                          if not StyleServices.GetElementColor(LDetails, ecTextColor, ThemeTextColor) then
                            ThemeTextColor := StyleServices.GetSystemColor(clBtnText);

                            LCanvas:=TCanvas.Create;
                            SaveIndex := SaveDC(hdc);
                            try
                              LCanvas.Handle:=hdc;
                              ZeroMemory(@plf, SizeOf(plf));
                              plf.lfHeight := 13;
                              plf.lfCharSet := DEFAULT_CHARSET;
                              StrCopy(plf.lfFaceName, 'Tahoma');
                              LCanvas.Font.Handle := CreateFontIndirect(plf);

                              LText :=  string(pszText);
                              p:=Pos(Chr($A), LText);
                              if p>1 then
                                 LText:=Copy(LText, 1, p-1);

                              LRect:=pRect;
                              StyleServices.DrawText(LCanvas.Handle, LDetails, LText, LRect, TTextFormatFlags(dwTextFlags), ThemeTextColor);
                            finally
                              DeleteObject(LCanvas.Font.Handle);
                              LCanvas.Handle:=0;
                              LCanvas.Free;
                              RestoreDC(hdc, SaveIndex);
                            end;

                          //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeText hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));
                          Result:=S_OK;
                       end;

       MC_TRAILINGGRIDCELL :
                       begin
                          case iStateId of
                           MCTGC_HOT                :   LDetails:=StyleServices.GetElementDetails(tgFixedCellHot);
                           MCTGC_HASSTATE           :   LDetails:=StyleServices.GetElementDetails(tgCellSelected);
                           MCTGC_HASSTATEHOT        :   LDetails:=StyleServices.GetElementDetails(tgCellSelected);
                           MCTGC_TODAY              :   LDetails:=StyleServices.GetElementDetails(tgFixedCellHot);
                          else
                              LDetails:=StyleServices.GetElementDetails(teEditTextDisabled);
                          end;

                          if not StyleServices.GetElementColor(LDetails, ecTextColor, ThemeTextColor) then
                            ThemeTextColor := StyleServices.GetSystemColor(clBtnText);

                            LCanvas:=TCanvas.Create;
                            SaveIndex := SaveDC(hdc);
                            try
                              LCanvas.Handle:=hdc;
                              ZeroMemory(@plf, SizeOf(plf));
                              plf.lfHeight := 13;
                              plf.lfCharSet := DEFAULT_CHARSET;
                              StrCopy(plf.lfFaceName, 'Tahoma');
                              LCanvas.Font.Handle := CreateFontIndirect(plf);

                              LText :=  string(pszText);
                              p:=Pos(Chr($A), LText);
                              if p>1 then
                                 LText:=Copy(LText, 1, p-1);

                              LRect:=pRect;
                              StyleServices.DrawText(LCanvas.Handle, LDetails, LText, LRect, TTextFormatFlags(dwTextFlags), ThemeTextColor);
                            finally
                              DeleteObject(LCanvas.Font.Handle);
                              LCanvas.Handle:=0;
                              LCanvas.Free;
                              RestoreDC(hdc, SaveIndex);
                            end;
                          Result:=S_OK;
                       end;
     else
     begin
       //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeText hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));
       Result:=TrampolineDrawThemeText(hTheme, hdc, iPartId, iStateId, pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect);
     end;
     end;
   end
   else
   {$ENDIF}
   {$IFDEF HOOK_Button}
   if SameText(THThemesClasses.Items[hTheme], VSCLASS_BUTTON) then
   begin
        case iPartId of
            BP_PUSHBUTTON  :
                              begin
                                case iStateId of
                                    PBS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tbPushButtonNormal);
                                    PBS_HOT      : LDetails:=StyleServices.GetElementDetails(tbPushButtonHot);
                                    PBS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tbPushButtonPressed);
                                    PBS_DISABLED : LDetails:=StyleServices.GetElementDetails(tbPushButtonDisabled);
                                    PBS_DEFAULTED            : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaulted);
                                    PBS_DEFAULTED_ANIMATING  : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaultedAnimating);
                                end;

                                //StyleServices.DrawText(hdc,  LDetails, string(pszText), pRect, dwTextFlags, dwTextFlags2);

                                if not StyleServices.GetElementColor(LDetails, ecTextColor, ThemeTextColor) then
                                 ThemeTextColor := StyleServices.GetSystemColor(clBtnText);
                                LRect:=pRect;
                                StyleServices.DrawText(hdc, LDetails, string(pszText), LRect, TTextFormatFlags(dwTextFlags), ThemeTextColor);
                                Result:=S_OK;
                              end;

            BP_RADIOBUTTON  : begin
                                case iStateId of
                                    RBS_UNCHECKEDNORMAL   : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedNormal);
                                    RBS_UNCHECKEDHOT      : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedHot);
                                    RBS_UNCHECKEDPRESSED  : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedPressed);
                                    RBS_UNCHECKEDDISABLED : LDetails:=StyleServices.GetElementDetails(tbRadioButtonUncheckedDisabled);
                                    RBS_CHECKEDNORMAL     : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedNormal);
                                    RBS_CHECKEDHOT        : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedHot);
                                    RBS_CHECKEDPRESSED    : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedPressed);
                                    RBS_CHECKEDDISABLED   : LDetails:=StyleServices.GetElementDetails(tbRadioButtonCheckedDisabled);
                                end;

                                if not StyleServices.GetElementColor(LDetails, ecTextColor, ThemeTextColor) then
                                 ThemeTextColor := StyleServices.GetSystemColor(clBtnText);
                                LRect:=pRect;
                                StyleServices.DrawText(hdc, LDetails, string(pszText), LRect, TTextFormatFlags(dwTextFlags), ThemeTextColor);
                                Result:=S_OK;
                              end;

            BP_COMMANDLINK :
                              begin

                                case iStateId of
                                    CMDLS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tbPushButtonNormal);
                                    CMDLS_HOT      : LDetails:=StyleServices.GetElementDetails(tbPushButtonHot);
                                    CMDLS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tbPushButtonPressed);
                                    CMDLS_DISABLED : LDetails:=StyleServices.GetElementDetails(tbPushButtonDisabled);
                                    CMDLS_DEFAULTED     : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaulted);
                                    CMDLS_DEFAULTED_ANIMATING        : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaultedAnimating);
                                end;

                                LCanvas:=TCanvas.Create;
                                SaveIndex := SaveDC(hdc);
                                try
                                  LCanvas.Handle:=hdc;
                                  ZeroMemory(@plf, SizeOf(plf));
                                  plf.lfHeight := 14;
                                  plf.lfCharSet := DEFAULT_CHARSET;
                                  StrCopy(plf.lfFaceName, 'Tahoma');
                                  LCanvas.Font.Handle := CreateFontIndirect(plf);
                                  if not StyleServices.GetElementColor(LDetails, ecTextColor, ThemeTextColor) then
                                   ThemeTextColor := StyleServices.GetSystemColor(clBtnText);
                                  LRect:=pRect;
                                  StyleServices.DrawText(LCanvas.Handle, LDetails, string(pszText), LRect, TTextFormatFlags(dwTextFlags), ThemeTextColor);
                                finally
                                  DeleteObject(LCanvas.Font.Handle);
                                  LCanvas.Handle:=0;
                                  LCanvas.Free;
                                  RestoreDC(hdc, SaveIndex);
                                end;

                                Result:=S_OK;
                              end
            else
            begin
               Result:=TrampolineDrawThemeText(hTheme, hdc, iPartId, iStateId, pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect);
               //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeText hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));
            end;
        end;
   end
   else
   {$ENDIF}
   begin
    Result:=TrampolineDrawThemeText(hTheme, hdc, iPartId, iStateId, pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect);
    //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeText hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));
   end;
 end
 else
   Result:=TrampolineDrawThemeText(hTheme, hdc, iPartId, iStateId, pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect);
end;


function  Detour_UxTheme_DrawThemeTextEx(hTheme: HTHEME; hdc: HDC; iPartId: Integer; iStateId: Integer; pszText: LPCWSTR; cchText: Integer; dwTextFlags: DWORD; pRect: PRect; var pOptions: TDTTOpts): HResult; stdcall;
var
  LDetails: TThemedElementDetails;
  ThemeTextColor : TColor;
  SaveIndex : Integer;
  LCanvas : TCanvas;
  plf: LOGFONTW;
begin
 //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeTextEx hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));
 //Result:=TrampolineDrawThemeTextEx(hTheme, hdc, iPartId, iStateId, pszText, cchText, dwTextFlags, pRect, pOptions);
 if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled or (dwTextFlags and DT_CALCRECT <> 0)  then
  Exit(TrampolineDrawThemeTextEx(hTheme, hdc, iPartId, iStateId, pszText, cchText, dwTextFlags, pRect, pOptions));

 if THThemesClasses.ContainsKey(hTheme) then
 begin
   {$IFDEF HOOK_ListView}
   if SameText(THThemesClasses.Items[hTheme], VSCLASS_LISTVIEW) or SameText(THThemesClasses.Items[hTheme], VSCLASS_ITEMSVIEW_LISTVIEW) then
   begin
        case iPartId of
          LVP_GROUPHEADER :
                           begin
                             if iStateId=0 then
                             begin
                                  LCanvas:=TCanvas.Create;
                                  SaveIndex := SaveDC(hdc);
                                  try
                                    LCanvas.Handle:=hdc;
                                    if pOptions.dwFlags AND DTT_FONTPROP <> 0  then
                                    begin
                                      ZeroMemory(@plf, SizeOf(plf));
                                      plf.lfHeight := 13;
                                      plf.lfCharSet := DEFAULT_CHARSET;
                                      StrCopy(plf.lfFaceName, 'Tahoma');
                                      LCanvas.Font.Handle := CreateFontIndirect(plf);
                                    end;
                                    LDetails:=StyleServices.GetElementDetails(tlListItemNormal);
                                    ThemeTextColor:=StyleServices.GetStyleFontColor(sfListItemTextNormal);
                                    StyleServices.DrawText(LCanvas.Handle, LDetails, string(pszText), pRect^, TTextFormatFlags(dwTextFlags), ThemeTextColor);
                                  finally
                                    if pOptions.dwFlags AND DTT_FONTPROP <> 0  then
                                      DeleteObject(LCanvas.Font.Handle);
                                    LCanvas.Handle:=0;
                                    LCanvas.Free;
                                    RestoreDC(hdc, SaveIndex);
                                  end;

                                  Result:=S_OK;
                             end
                             else
                             begin
                                 //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeTextEx hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));
                                 Exit(TrampolineDrawThemeTextEx(hTheme, hdc, iPartId, iStateId, pszText, cchText, dwTextFlags, pRect, pOptions));
                             end;
                           end;

        else
          begin
             //OutputDebugString(PChar(Format('Detour_UxTheme_DrawThemeTextEx hTheme %d iPartId %d iStateId %d  text %s', [hTheme, iPartId, iStateId, pszText])));
             Exit(TrampolineDrawThemeTextEx(hTheme, hdc, iPartId, iStateId, pszText, cchText, dwTextFlags, pRect, pOptions));
          end;
        end;
   end
   else
   {$ENDIF}
   {$IFDEF HOOK_Button}
   if SameText(THThemesClasses.Items[hTheme], VSCLASS_BUTTON) then
   begin
        case iPartId of
            BP_COMMANDLINK  :
            begin
              case iStateId of
                  CMDLS_NORMAL   : LDetails:=StyleServices.GetElementDetails(tbPushButtonNormal);
                  CMDLS_HOT      : LDetails:=StyleServices.GetElementDetails(tbPushButtonHot);
                  CMDLS_PRESSED  : LDetails:=StyleServices.GetElementDetails(tbPushButtonPressed);
                  CMDLS_DISABLED : LDetails:=StyleServices.GetElementDetails(tbPushButtonDisabled);
                  CMDLS_DEFAULTED     : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaulted);
                  CMDLS_DEFAULTED_ANIMATING        : LDetails:=StyleServices.GetElementDetails(tbPushButtonDefaultedAnimating);
              end;


              if not StyleServices.GetElementColor(LDetails, ecTextColor, ThemeTextColor) then
                ThemeTextColor := StyleServices.GetSystemColor(clBtnText);

              LCanvas:=TCanvas.Create;
              SaveIndex := SaveDC(hdc);
              try
                LCanvas.Handle:=hdc;
                if pOptions.dwFlags AND DTT_FONTPROP <> 0  then
                begin
                  //GetThemeSysFont(hTheme, pOptions.iFontPropId, plf);  // is not working
                  ZeroMemory(@plf, SizeOf(plf));
                  plf.lfHeight := 13;
                  plf.lfCharSet := DEFAULT_CHARSET;
                  StrCopy(plf.lfFaceName, 'Tahoma');
                  LCanvas.Font.Handle := CreateFontIndirect(plf);
                end;
                StyleServices.DrawText(LCanvas.Handle, LDetails, string(pszText), pRect^, TTextFormatFlags(dwTextFlags), ThemeTextColor);
              finally
                if pOptions.dwFlags AND DTT_FONTPROP <> 0  then
                  DeleteObject(LCanvas.Font.Handle);
                LCanvas.Handle:=0;
                LCanvas.Free;
                RestoreDC(hdc, SaveIndex);
              end;

              Result:=S_OK;
            end
            else
               Result:=TrampolineDrawThemeTextEx(hTheme, hdc, iPartId, iStateId, pszText, cchText, dwTextFlags, pRect, pOptions);
        end;
   end
   else
   {$ENDIF}
    Result:=TrampolineDrawThemeTextEx(hTheme, hdc, iPartId, iStateId, pszText, cchText, dwTextFlags, pRect, pOptions);
 end
 else
   Result:=TrampolineDrawThemeTextEx(hTheme, hdc, iPartId, iStateId, pszText, cchText, dwTextFlags, pRect, pOptions);

end;
{$ENDIF}

function Detour_GetSysColor(nIndex: Integer): DWORD; stdcall;
begin
  if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled  then
   Result:= TrampolineGetSysColor(nIndex)
  else
    Result:= DWORD(StyleServices.GetSystemColor(TColor(nIndex or Integer($FF000000))));
end;


function Detour_GetSysColorBrush(nIndex: Integer): HBRUSH; stdcall;
var
  LCurrentStyleBrush : TListStyleBrush;
begin
  if StyleServices.IsSystemStyle or not TSysStyleManager.Enabled  then
   Exit(TrampolineGetSysColorBrush(nIndex))
  else
  begin
   if VCLStylesBrush.ContainsKey(StyleServices.Name) then
    LCurrentStyleBrush:=VCLStylesBrush.Items[StyleServices.Name]
   else
   begin
     VCLStylesBrush.Add(StyleServices.Name, TListStyleBrush.Create([doOwnsValues]));
     LCurrentStyleBrush:=VCLStylesBrush.Items[StyleServices.Name];
   end;

   if LCurrentStyleBrush.ContainsKey(nIndex) then
    Exit(LCurrentStyleBrush.Items[nIndex].Handle)
   else
   begin
     LCurrentStyleBrush.Add(nIndex, TBrush.Create);
     LCurrentStyleBrush.Items[nIndex].Color:= StyleServices.GetSystemColor(TColor(nIndex or Integer($FF000000)));
     //OutputDebugString(PChar(Format('nIndex %d Color %x RGB %x', [nIndex, LCurrentStyleBrush.Items[nIndex].Color, ColorToRGB(LCurrentStyleBrush.Items[nIndex].Color)])));
     Exit(LCurrentStyleBrush.Items[nIndex].Handle);
   end;
  end;
end;


function Detour_CreateSolidBrush(p1: COLORREF): HBRUSH; stdcall;
begin
 Result:=TrampolineCreateSolidBrush(p1);
end;


function Detour_CreateBrushIndirect(const p1: TLogBrush): HBRUSH; stdcall;
//var
//  l : TLogBrush;
begin
// l:=p1;
// l.lbColor:=clRed;
// OutputDebugString(PChar('Detour_CreateBrushIndirect Color '+IntToHex(p1.lbColor, 8)));
// Result:=TrampolineCreateBrushIndirect(l);
Result:=TrampolineCreateBrushIndirect(p1);
end;

function Detour_GetStockObject(Index: Integer): HGDIOBJ; stdcall;
begin
 //OutputDebugString(PChar('Detour_GetStockObject Index '+IntToStr(Index)));
 Result:= TrampolineGetStockObject(Index);
end;

//function Detour_WinApi_DrawText(hDC: HDC; lpString: LPCWSTR; nCount: Integer;  var lpRect: TRect; uFormat: UINT): Integer; stdcall;
//begin
// //OutputDebugString(PChar('Detour_WinApi_DrawText Color'+IntToHex(OrgColor, 8)+' Window '+IntToHex(LWin,8)+' '+lpString));
// Result:=Trampoline_DrawText(hDC, lpString, nCount, lpRect, uFormat);
//end;


//function _ColorToRGB(Color: TColor): Longint;
//begin
//  if Color < 0 then
//    Result := TrampolineGetSysColor(Color and $000000FF) else
//    Result := Color;
//end;


//function Detour_WinApi_DrawTextEx(DC: HDC; lpchText: LPCWSTR; cchText: Integer; var p4: TRect;  dwDTFormat: UINT; DTParams: PDrawTextParams): Integer; stdcall;
//begin
// Result:=Trampoline_DrawTextEx(DC, lpchText, cchText, p4, dwDTFormat, DTParams);
//end;
//
//function Detour_WinApi_ExtTextOutW(DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: LPCWSTR; Count: Longint; Dx: PInteger): BOOL; stdcall;
//begin
// Result:=Trampoline_ExtTextOutW(DC, x, y, Options, Rect, Str, Count, Dx);
//end;

var
 pOrgPointer : Pointer;

initialization
  VCLStylesBrush := TObjectDictionary<string, TListStyleBrush>.Create([doOwnsValues]);
{$IFDEF HOOK_UXTHEME}
 THThemesClasses  := TDictionary<HTHEME, string>.Create;
 THThemesHWND     := TDictionary<HTHEME, HWND>.Create;
{$ENDIF}
 if StyleServices.Available then
 begin

   {$IFDEF  HOOK_DateTimePicker}
   TCustomStyleEngine.RegisterStyleHook(TDateTimePicker, TStyleHook);
   {$ENDIF}
   {$IFDEF  HOOK_ProgressBar}
   TCustomStyleEngine.RegisterStyleHook(TProgressBar, TStyleHook);
   {$ENDIF}
   {$IFDEF  HOOK_ListView}
   //TCustomStyleEngine.RegisterStyleHook(TListView, TStyleHook);
   {$ENDIF}

   pOrgPointer     := GetProcAddress(GetModuleHandle(user32), 'GetSysColor');
   if Assigned(pOrgPointer) then
    @TrampolineGetSysColor    :=  InterceptCreate(pOrgPointer, @Detour_GetSysColor);

   pOrgPointer     := GetProcAddress(GetModuleHandle(user32), 'GetSysColorBrush');
   if Assigned(pOrgPointer) then
    @TrampolineGetSysColorBrush    :=  InterceptCreate(pOrgPointer, @Detour_GetSysColorBrush);

//   pOrgPointer     := GetProcAddress(GetModuleHandle(gdi32), 'CreateSolidBrush');
//   if Assigned(pOrgPointer) then
//    @TrampolineCreateSolidBrush    :=  InterceptCreate(pOrgPointer, @Detour_CreateSolidBrush);
//
//
//   pOrgPointer     := GetProcAddress(GetModuleHandle(gdi32), 'CreateBrushIndirect');
//   if Assigned(pOrgPointer) then
//    @TrampolineCreateBrushIndirect    :=  InterceptCreate(pOrgPointer, @Detour_CreateBrushIndirect);
//
//
//   pOrgPointer     := GetProcAddress(GetModuleHandle(gdi32), 'GetStockObject');
//   if Assigned(pOrgPointer) then
//    @TrampolineGetStockObject    :=  InterceptCreate(pOrgPointer, @Detour_GetStockObject);


//   Trampoline_DrawText                       := InterceptCreate(@WinApi.Windows.DrawTextW, @Detour_WinApi_DrawText);
//   Trampoline_DrawTextEx                     := InterceptCreate(@WinApi.Windows.DrawTextEx, @Detour_WinApi_DrawTextEx);
//   Trampoline_ExtTextOutW                    := InterceptCreate(@WinApi.Windows.ExtTextOutW, @Detour_WinApi_ExtTextOutW);

   {$IFDEF HOOK_UXTHEME}
   ThemeLibrary := GetModuleHandle('uxtheme.dll');
   pOrgPointer   := GetProcAddress(ThemeLibrary, 'OpenThemeData');
   if Assigned(pOrgPointer) then
    @TrampolineOpenThemeData  := InterceptCreate(pOrgPointer, @Detour_UxTheme_OpenThemeData);

   pOrgPointer := GetProcAddress(ThemeLibrary, 'DrawThemeBackground');
   if Assigned(pOrgPointer) then
    @TrampolineDrawThemeBackground := InterceptCreate(pOrgPointer, @Detour_UxTheme_DrawThemeBackground);

   pOrgPointer := GetProcAddress(ThemeLibrary, 'DrawThemeBackgroundEx');
   if Assigned(pOrgPointer) then
    @TrampolineDrawThemeBackgroundEx := InterceptCreate(pOrgPointer, @Detour_UxTheme_DrawThemeBackgroundEx);

   pOrgPointer := GetProcAddress(ThemeLibrary, 'DrawThemeText');
   if Assigned(pOrgPointer) then
    @TrampolineDrawThemeText := InterceptCreate(pOrgPointer, @Detour_UxTheme_DrawThemeText);

   pOrgPointer := GetProcAddress(ThemeLibrary, 'DrawThemeTextEx');
   if Assigned(pOrgPointer) then
    @TrampolineDrawThemeTextEx := InterceptCreate(pOrgPointer, @Detour_UxTheme_DrawThemeTextEx);

   pOrgPointer  := GetProcAddress(ThemeLibrary, 'GetThemeSysColor');
   if Assigned(pOrgPointer) then
    @TrampolineGetThemeSysColor := InterceptCreate(pOrgPointer, @Detour_GetThemeSysColor);

   pOrgPointer  := GetProcAddress(ThemeLibrary, 'GetThemeSysColorBrush');
   if Assigned(pOrgPointer) then
    @TrampolineGetThemeSysColorBrush := InterceptCreate(pOrgPointer, @Detour_GetThemeSysColorBrush);


   pOrgPointer     := GetProcAddress(ThemeLibrary, 'GetThemeColor');
   if Assigned(pOrgPointer) then
    @TrampolineGetThemeColor    := InterceptCreate(pOrgPointer, @Detour_GetThemeColor);
   {$ENDIF}
 end;

finalization
 if Assigned(TrampolineGetSysColor) then
  InterceptRemove(@TrampolineGetSysColor);

 if Assigned(TrampolineGetSysColorBrush) then
  InterceptRemove(@TrampolineGetSysColorBrush);

 if Assigned(TrampolineCreateSolidBrush) then
  InterceptRemove(@TrampolineCreateSolidBrush);

 if Assigned(TrampolineCreateBrushIndirect) then
  InterceptRemove(@TrampolineCreateBrushIndirect);

 if Assigned(TrampolineGetStockObject) then
  InterceptRemove(@TrampolineGetStockObject);


//  if Assigned(Trampoline_DrawText) then
//    InterceptRemove(@Trampoline_DrawText);
//
//  if Assigned(Trampoline_DrawTextEx) then
//    InterceptRemove(@Trampoline_DrawTextEx);
//
//  if Assigned(Trampoline_ExtTextOutW) then
//    InterceptRemove(@Trampoline_ExtTextOutW);
//

  {$IFDEF HOOK_UXTHEME}
 if Assigned(TrampolineGetThemeSysColor) then
  InterceptRemove(@TrampolineGetThemeSysColor);

 if Assigned(TrampolineGetThemeSysColorBrush) then
  InterceptRemove(@TrampolineGetThemeSysColorBrush);


 if Assigned(TrampolineOpenThemeData) then
  InterceptRemove(@TrampolineOpenThemeData);

 if Assigned(TrampolineGetThemeColor) then
  InterceptRemove(@TrampolineGetThemeColor);

 if Assigned(TrampolineDrawThemeBackground) then
  InterceptRemove(@TrampolineDrawThemeBackground);

 if Assigned(TrampolineDrawThemeText) then
  InterceptRemove(@TrampolineDrawThemeText);

 if Assigned(TrampolineDrawThemeTextEx) then
  InterceptRemove(@TrampolineDrawThemeTextEx);

 if Assigned(TrampolineDrawThemeBackgroundEx) then
  InterceptRemove(@TrampolineDrawThemeBackgroundEx);

  THThemesClasses.Free;
  THThemesHWND.Free;
  {$ENDIF}
  VCLStylesBrush.Free;
end.
