{**************************************************************************************************}
{                                                                                                  }
{ Unit Vcl.Styles.ProgressBarWnd                                                                   }
{ unit for the VCL Styles Utils                                                                    }
{ http://code.google.com/p/vcl-styles-utils/                                                       }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is Vcl.Styles.ProgressBarWnd.pas.                                              }
{                                                                                                  }
{ The Initial Developer of the Original Code is Rodrigo Ruz V.                                     }
{                                                                                                  }
{ Portions created by SMP3 are Copyright (C) 2013 SMP3.                                            }
{ Portions created by Rodrigo Ruz V. are Copyright (C) 2013 Rodrigo Ruz V.                         }
{ All Rights Reserved.                                                                             }
{                                                                                                  }
{**************************************************************************************************}
unit Vcl.Styles.ProgressBarWnd;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Vcl.Themes,
  System.Types,
  Vcl.Styles.ControlWnd;

type
  TProgressBarOrientation = (pbHorizontal, pbVertical);

  TProgressBarWnd = class(TControlWnd)
  private
    FOrientation: TProgressBarOrientation;
    function GetBarRect: TRect;
    function GetBorderWidth: Integer;
    function GetPercent: Single;
    function GetMax: Integer;
    function GetMin: Integer;
    function GetPosition: Integer;
  protected
    procedure WndProc(var Message: TMessage); override;
    property Orientation: TProgressBarOrientation read FOrientation default pbHorizontal;
    property BarRect: TRect read GetBarRect;
    property BorderWidth: Integer read GetBorderWidth;
    property Max: Integer read GetMax;
    property Min: Integer read GetMin;
    property Position: Integer read GetPosition;
  public
    constructor Create(AHandle: THandle); override;
  end;

implementation

uses
  Vcl.Graphics,
  System.SysUtils,
  //System.IOUtils,
  Winapi.CommCtrl;

{ TEditWnd }

constructor TProgressBarWnd.Create(AHandle: THandle);
begin
  inherited Create(AHandle);
  if (GetWindowLong(AHandle, GWL_STYLE) And PBS_VERTICAL)<>0 then
    FOrientation:=pbVertical
  else
    FOrientation:=pbHorizontal;

end;

function TProgressBarWnd.GetBarRect: TRect;
begin
  Result := TRect.Create(0, 0, Width, Height);
  InflateRect(Result, -BorderWidth, -BorderWidth);
end;

function TProgressBarWnd.GetBorderWidth: Integer;
begin
 Result:=0;
end;

function TProgressBarWnd.GetMax: Integer;
begin
  Result := SendMessage(Handle, PBM_GetRange, 0, 0);
end;

function TProgressBarWnd.GetMin: Integer;
begin
  Result := SendMessage(Handle, PBM_GetRange, 1, 0);
end;

function TProgressBarWnd.GetPercent: Single;
var
  LMin, LMax, LPos: Integer;
begin
  LMin := Min;
  LMax := Max;
  LPos := Position;
  if (LMin >= 0) and (LPos >= LMin) and (LMax >= LPos) and (LMax - LMin <> 0) then
    Result := (LPos - LMin) / (LMax - LMin)
  else
    Result := 0;
end;

function TProgressBarWnd.GetPosition: Integer;
begin
  Result := SendMessage(Handle, PBM_GETPOS, 0, 0);
end;

   {
procedure Addlog(const msg : string);
begin
   TFile.AppendAllText('C:\Dephi\google-code\vcl-styles-utils\log.txt',msg+sLineBreak);
end;
   }
procedure TProgressBarWnd.WndProc(var Message: TMessage);
var
  uMsg: UINT;
  DC: HDC;
  R: TRect;
  LDetails: TThemedElementDetails;
  W, Pos : Integer;
  FillR  : TRect;
  Canvas: TCanvas;
  PS: TPaintStruct;
begin

  uMsg := Message.Msg;

  case uMsg of

    WM_PAINT:
      begin
        DC := HDC(Message.WParam);
        Canvas := TCanvas.Create;
        try
          if DC <> 0 then
            Canvas.Handle := DC
          else
            Canvas.Handle := BeginPaint(Handle, PS);


          //Frame
          R := BarRect;
          if Orientation = pbHorizontal then
            LDetails := StyleServices.GetElementDetails(tpBar)
          else
            LDetails := StyleServices.GetElementDetails(tpBarVert);

          //Addlog(Format('Frame R  Width %d Height %d',[R.Width, R.Height]));

          StyleServices.DrawElement(Canvas.Handle, LDetails, R);

          //Bar
          InflateRect(R, -1, -1);
          if Orientation = pbHorizontal then
            W := R.Width
          else
            W := R.Height;

          //Addlog(Format('GetPosition %d',[GetPosition]));
          //Addlog(Format('GetPercent %n',[GetPercent]));

          Pos := Round(W * GetPercent);

          //Addlog(Format('Pos %d',[Pos]));

          FillR := R;
          if Orientation = pbHorizontal then
          begin
            FillR.Right := FillR.Left + Pos;
            LDetails := StyleServices.GetElementDetails(tpChunk);
          end
          else
          begin
            FillR.Top := FillR.Bottom - Pos;
            LDetails := StyleServices.GetElementDetails(tpChunkVert);
          end;

          StyleServices.DrawElement(Canvas.Handle, LDetails, FillR);


          if DC = 0 then
            EndPaint(Handle, PS);
        finally
          Canvas.Handle := 0;
          Canvas.Free;
        end;
      end;

    WM_ERASEBKGND:
      begin
        Message.Result := 1;
      end;
  else
    Message.Result := CallOrgWndProc(Message);
  end;
end;

end.
