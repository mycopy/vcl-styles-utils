object Main: TMain
  Left = 590
  Top = 208
  BiDiMode = bdLeftToRight
  Caption = 'Main'
  ClientHeight = 263
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  ParentBiDiMode = False
  PopupMenu = PopupMenu1
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 463
    Top = 16
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 63
    Height = 13
    Caption = 'Select Style :'
  end
  object Label2: TLabel
    Left = 8
    Top = 229
    Width = 161
    Height = 13
    Caption = 'Right Click to desplay PopupMenu'
  end
  object SpeedButton2: TSpeedButton
    Left = 264
    Top = 161
    Width = 112
    Height = 22
    Caption = 'PrinterSetupDialog'
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 382
    Top = 161
    Width = 104
    Height = 22
    Caption = 'MessageBox'
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 176
    Top = 161
    Width = 82
    Height = 22
    Caption = '  SaveDialog'
    OnClick = SpeedButton4Click
  end
  object SpeedButton5: TSpeedButton
    Left = 89
    Top = 161
    Width = 81
    Height = 22
    Caption = 'ColorDialog'
    OnClick = SpeedButton5Click
  end
  object SpeedButton6: TSpeedButton
    Left = 8
    Top = 161
    Width = 73
    Height = 22
    Caption = 'FontDialog'
    OnClick = SpeedButton6Click
  end
  object SpeedButton7: TSpeedButton
    Left = 295
    Top = 189
    Width = 84
    Height = 22
    Caption = ' FindDialog'
    OnClick = SpeedButton7Click
  end
  object SpeedButton8: TSpeedButton
    Left = 96
    Top = 189
    Width = 103
    Height = 22
    Caption = 'PageSetupDialog'
    OnClick = SpeedButton8Click
  end
  object SpeedButton9: TSpeedButton
    Left = 205
    Top = 189
    Width = 84
    Height = 22
    Caption = 'ReplaceDialog'
    OnClick = SpeedButton9Click
  end
  object SpeedButton10: TSpeedButton
    Left = 8
    Top = 189
    Width = 82
    Height = 22
    Caption = 'TaskDialog'
    OnClick = SpeedButton10Click
  end
  object SpeedButton11: TSpeedButton
    Left = 385
    Top = 189
    Width = 101
    Height = 22
    Caption = 'Raise Exception'
    OnClick = SpeedButton11Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 16
    Width = 449
    Height = 21
    TabOrder = 0
    Text = 'Select a File ...'
  end
  object ListBox1: TListBox
    Left = 77
    Top = 43
    Width = 380
    Height = 102
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 344
    Top = 48
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = '&New'
        ImageIndex = 4
        ShortCut = 16462
      end
      object Open1: TMenuItem
        Caption = '&Open'
        ImageIndex = 0
        ShortCut = 16463
      end
      object Close1: TMenuItem
        Caption = '&Close'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Save1: TMenuItem
        Caption = '&Save'
        ImageIndex = 2
        ShortCut = 16467
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = '&Print'
        Enabled = False
        ImageIndex = 1
        ShortCut = 16464
      end
      object PrintSetup1: TMenuItem
        Caption = 'Prin&t Setup...'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        ImageIndex = 5
      end
    end
    object Window1: TMenuItem
      Caption = '&Window'
      object NewWindow1: TMenuItem
        Caption = '&New Window'
      end
      object Tile1: TMenuItem
        Caption = '&Tile'
      end
      object Cascade1: TMenuItem
        Caption = '&Cascade'
      end
      object ArrangeAll1: TMenuItem
        Caption = '&Arrange All'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Hide1: TMenuItem
        Caption = '&Hide'
      end
      object Show1: TMenuItem
        Caption = '&Show...'
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object Contents1: TMenuItem
        Caption = '&Contents'
      end
      object SearchforHelpOn1: TMenuItem
        Caption = '&Search for Help On...'
      end
      object HowtoUseHelp1: TMenuItem
        Caption = '&How to Use Help'
      end
      object About1: TMenuItem
        Caption = '&About...'
        ImageIndex = 3
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 368
    Top = 80
    object Item11: TMenuItem
      Caption = 'Item 1'
    end
    object CheckedItem1: TMenuItem
      Caption = 'Checked Item'
      Checked = True
    end
    object DisabledItem1: TMenuItem
      Caption = 'Disabled Item'
      Enabled = False
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Item21: TMenuItem
      Caption = 'Item 2'
      object SubItem11: TMenuItem
        Caption = 'Sub Item 1'
      end
      object SubItem21: TMenuItem
        Caption = 'Sub Item 2'
        object SubItem12: TMenuItem
          Caption = 'Sub Item 1'
        end
        object SubItem22: TMenuItem
          Caption = 'Sub Item 2'
        end
      end
      object SubItem31: TMenuItem
        Caption = 'Sub Item 3'
        Checked = True
      end
      object SubItem41: TMenuItem
        Caption = 'Sub Item 4'
      end
    end
    object Item31: TMenuItem
      Caption = 'About'
      ImageIndex = 3
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 48
    Top = 104
  end
  object SaveDialog1: TSaveDialog
    Left = 24
    Top = 72
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 128
    Top = 72
  end
  object ColorDialog1: TColorDialog
    Left = 185
    Top = 80
  end
  object FindDialog1: TFindDialog
    Left = 336
    Top = 216
  end
  object PageSetupDialog1: TPageSetupDialog
    MinMarginLeft = 0
    MinMarginTop = 0
    MinMarginRight = 0
    MinMarginBottom = 0
    MarginLeft = 2500
    MarginTop = 2500
    MarginRight = 2500
    MarginBottom = 2500
    PageWidth = 21000
    PageHeight = 29700
    Left = 136
    Top = 216
  end
  object TaskDialog1: TTaskDialog
    Buttons = <>
    RadioButtons = <>
    Left = 208
    Top = 216
  end
  object OpenDialog1: TOpenDialog
    FileName = 'C:\Users\Public\Pictures\Sample Pictures\Desert.jpg'
    Filter = 'Images|*.bmp;*.jpg'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofOldStyleDialog, ofEnableIncludeNotify, ofEnableSizing]
    Left = 72
    Top = 24
  end
  object ReplaceDialog1: TReplaceDialog
    Left = 384
    Top = 128
  end
  object PrintDialog1: TPrintDialog
    Left = 184
    Top = 32
  end
  object OpenDialog2: TOpenDialog
    Left = 24
    Top = 40
  end
  object ImageList1: TImageList
    Left = 296
    Top = 144
    Bitmap = {
      494C010106000800580010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECECEC13ECECEC13ECEC
      EC13ECECEC13ECECEC13ECECEC13ECECEC13ECECEC13ECECEC13ECECEC13ECEC
      EC13ECECEC13ECECEC13ECECEC13000000000000000000000000E6E6F419D4D4
      ED32D4D4ED32D4D4ED32D4D4ED32D4D4ED32D4D4ED32D4D4ED32D4D4ED32D4D4
      ED32D4D4ED32CFCFEB3100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC13FBFBFBFFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FFFBFBFBFFECECEC1300000000000000005D5DBEA40000
      CEFF0000CFFF0000D0FF0000D1FF0000D1FF0000D2FF0000D3FF0000D4FF0000
      D5FF0000D6FF4747C3FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC13F7F7F7FFF6F6F6FFF6F6
      F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6
      F6FFF6F6F6FFF6F6F6FFF7F7F7FFECECEC1300000000000000005D5DBEA40000
      CAFF0000CBFF0000CBFFECECFBFFFFFFFFFFFFFFFFFFFFFFFFFF5252DFFF0000
      D1FF0000D2FF4747C2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC13F6F6F6FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF6F6F6FFECECEC1300000000000000005E5EBEA40202
      C6FF0000C6FFFFFFFFFFFCFCFEFF1414CDFF0000CAFF8989E6FFFFFFFFFF5454
      DDFF0000CDFF4747C1FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC13F5F5F5FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF5F5F5FFECECEC1300000000000000005E5EBEA43C3C
      D0FF7E7EE0FFFFFFFFFF0000C3FF0000C4FF0000C5FF0000C6FF8686E4FFFFFF
      FFFF0000C8FF4747C0FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC13F4F4F4FFF3F3F3FFF3F3
      F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3
      F3FFF3F3F3FFF3F3F3FFF4F4F4FFECECEC1300000000000000005E5EBEA44141
      D0FFE1E1F7FFE8E8F9FF3838CEFF0B0BC4FF0000C1FF0000C2FF0000C2FFFFFF
      FFFF0000C3FF4747BFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC13F2F2F2FFF2F2F2FFEEEF
      F1FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2
      F2FFF2F2F2FFF2F2F2FFF3F3F3FFECECEC1300000000000000005E5EBEA44646
      CFFFCFCFF2FFFBFBFEFF4444D0FF4444D0FF4C4CD2FF4141D0FF4D4DD3FFFFFF
      FFFF3939CFFF5454C2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC13F1F1F1FF9DBFDEFF74B5
      DDFFE7EBEEFF8DB5DDFFF0F0F0FFF0F0F0FFF1F1F1FFF1F1F1FFF1F1F1FFF1F1
      F1FFF1F1F1FFF1F1F1FFF1F1F1FFECECEC1300000000000000005E5EBEA44B4B
      D0FF5555D2FFFFFFFFFF6C6CD9FF8E8EE1FFFFFFFFFF4242CEFFFCFCFEFFF6F6
      FCFF4242CFFF5656C2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DBE1E824B2CCE7FF23D0F4FF12DB
      FAFF12DAFAFFC1D4E6FF8DB5DDFFF0F0F0FFE8E8E8FFEFEFEFFFEFEFEFFFEFEF
      EFFFEFEFEFFFEFEFEFFFF0F0F0FFECECEC1300000000000000005E5EBEA45050
      D1FF5050D1FFB9B9EDFFFFFFFFFF8E8EE1FFFFFFFFFFD9D9F5FFFFFFFFFF4545
      CFFF4646CFFF5757C2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008EADCDDC00DDFFFF00DD
      FFFF00DDFFFF0FD4F7FBCDD0D4CDCACACACEEFEFEFFFEFEFEFFFEFEFEFFFEFEF
      EFFFEFEFEFFFEFEFEFFFEFEFEFFFECECEC1300000000000000005E5EBEA45555
      D2FF5454D3FF5353D2FF5D5DD4FF9393E2FFFFFFFFFF7D7DDDFF4C4CD0FF4C4C
      D0FF4B4BD0FF5959C2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFCCEA504AC3EAF396F3FFFF96F3
      FFFF96F3FFFF6DE7FCFD6FAED9E5D0D3D4CCEFEFEFFFEFEFEFFFEFEFEFFFEFEF
      EFFFEFEFEFFFEFEFEFFFEFEFEFFFECECEC1300000000000000005F5FBEA45A5A
      D4FF5959D4FF5858D4FF5757D3FF7777DBFFC7C7F0FF5353D2FF5252D2FF5151
      D1FF5050D1FF5A5AC2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBFCFD044EDCFAF73BBAE5E96DE8
      FFFF6DE8FFFF4ED0F2F384A5C5B6CACACA39FFFFFFFFEFEFEFFFEFEFEFFFEFEF
      EFFFEFEFEFFFEFEFEFFFFFFFFFFFFDFDFD0200000000000000008686CE799090
      D6D09090D6D09090D6D08F8FD6D08F8FD6D08F8FD6D08F8FD6D08F8FD6D08E8E
      D6D08E8ED6D05151BBCE00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002FD3FCF24CC2
      EFC3ABC9E954B7D1EC480000000000000000FDFDFD02ECECEC13ECECEC13ECEC
      EC13ECECEC13ECECEC13FDFDFD02000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFCFD04AECC
      EA5100000000EDF3FA1200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE01F5F5F50CFCFCFC040000000000000000CDCDCD32BBBBBB44B3B3B356B2B2
      B262B2B2B262B2B2B262B2B2B262B2B2B262B2B2B262B2B2B262B2B2B262B2B2
      B262B2B2B262B3B3B356BBBBBB44CCCCCC3300000000E3E3E31CE6E6E619FCFC
      FC03FCFCFC03FCFCFC03FCFCFC03FCFCFC03FCFCFC03FCFCFC03FCFCFC03FCFC
      FC03FCFCFC03EFEFEF10E6E6E61900000000000000000000000000000000FCFC
      FC03F4F4F40BECECEC13E6E6E619E4E4E41BE4E4E41BE6E6E619ECECEC13F4F4
      F40BFCFCFC030000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFC03E8E8E81BB9B9B9543C56
      68D9164660FF90909086D7D7D73000000000A6A6A65E333333FF6A6A6AFF4341
      41FF444141FF444141FF444141FF444141FF444141FF444141FF444141FF4441
      41FF434141FF6A6A6AFF333333FFA6A6A65EE3E3E31C3D3D3DFE464646FF8F8F
      8FFF8F8F8FFF8F8F8FFF8F8F8FFF909090FF8C8C8CFF888888FF848484FF8383
      83FF808080FF494949FF4A4A4AFFECECEC1300000000FAFAFA05EAEAEA15DADA
      DA25CCCBCB34A07B61B28F542AFD92562CFF92562CFF8F542AFDA07B61B2CBCA
      CA35D9D9D926E9E9E916F9F9F906000000000000000000000000000000000000
      0000FEFEFE01F1F1F110D2D2D235848E948D16415AFF027BAFFF0081B8FF0286
      BEFF0B446AFF96B1C36BFEFEFE0100000000ABABAB5F505050FF4F4F4FFF4E4E
      4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
      4EFF4E4E4EFF4F4F4FFF505050FFABABAB5FDCDCDC233F3F3FFF3E3E3EFFFEFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFF5F5F5FFEEEEEEFFE7E7E7FFE0E0
      E0FFD8D8D8FF313131FF393939FFE8E8E81700000000F2F2F20DE1E1E11EB49C
      8A829A5F35FF95572AFF955729FF95572AFF95572AFF955729FF95572AFF9A5F
      35FFB39A8983E0E0E01FF1F1F10E0000000000000000FEFEFE01E7E7E71DB5B5
      B559475F6DCE0C6188FF0081B8FF0082B9FF0489C1FF0890C9FF0C98D2FF119A
      D2FF026090FF6A96B4950000000000000000BBBABA5EABABABFFABABABFF504A
      4AFF51494BFF51494BFF51494BFF51494BFF51494BFF51494BFF51494BFF5149
      4BFF504A4AFFABABABFFABABABFFBBBABA5EDCDCDC23323232FF3D3D3DFFFAF7
      F5FFE6CFBFFFE6CFBFFFE6CFBFFFE6CFBFFFE5CEBEFFDFC9B9FFDBC4B4FFD5BF
      AFFFDEDDDDFF2C2C2DFF2B2B2BFFE8E8E8170000000000000000BFA08B869E63
      36FF9A5B2DFF9B5C2EFF9A5C2DFF9B5C2DFF9B5C2DFF9A5C2DFF9A5C2EFF9A5C
      2DFF9E6336FFBFA08A87000000000000000000000000D2D2D236027BAFFF0081
      B8FF0285BDFF068CC5FF0993CDFF0E99D2FF139BD3FF189DD4FF1EA0D5FF23A2
      D6FF066A9CFF36729AC90000000000000000BBBABA5EBBBBBBFFBBBBBBFF302F
      2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F
      2FFF302F2FFFBBBBBBFFBBBBBBFFBBBABA5EDCDCDC23343434FF3F3F3FFFFCFA
      F9FFF0E3D9FFF0E3D9FFF0E3D9FFF0E3D9FFF0E3D9FFEDE0D6FFE7DAD0FFE1D4
      CAFFE4E4E4FF2D2D2DFF2B2B2BFFE8E8E81700000000F3EDE919A66E43FF9F60
      30FFA06131FFA06131FFEDE1D8FFFFFFFFFFFFFFFFFFEDE1D8FFA06231FFA061
      31FF9F6030FFA66E43FFF3EDE91900000000000000001B6E9DE4078FC8FF0B97
      D1FF109AD2FF159CD3FF1B9ED4FF20A1D5FF25A3D6FF2BA5D7FF30A8D8FF2895
      C6FF0974A8FF045083FB0000000000000000BBBABA5ECBCBCBFFCBCBCBFF4F4F
      4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F
      4FFF4F4F4FFFCBCBCBFFCBCBCBFFBBBABA5EDCDCDC23383838FF414141FFF8F8
      F8FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFF9F9FAFFF2F2
      F3FFEAEAEAFF2F2F2FFF2B2B2BFFE8E8E81700000000A36E46EBA36433FFA566
      35FFA66736FFA66838FFA76938FFE2CEBDFFE2CEBDFFA76938FFA66837FFA667
      36FFA56635FFA36434FFA36E46EB0000000000000000139BD3FF189DD4FF1D9F
      D5FF23A2D6FF28A4D6FF2DA6D7FF32A9D9FF36ACDBFF3BAFDDFF3FB1DFFF1B76
      A6FF0C7FB4FF004F81FF0000000000000000BCBABA5EDCDCDCFFDCDCDCFF6F6F
      6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F
      6FFF6F6F6FFFDCDCDCFFDCDCDCFFBCBABA5EDCDCDC233E3E3EFF444444FFEEEA
      E7FFDCBEA8FFDFC1ABFFDEC1ABFFDEC1ABFFDEC1ABFFDEC1ABFFDFC1ABFFDBBD
      A8FFEFEFEEFF313131FF2B2B2BFFE8E8E81700000000B37E56FFA96D3CFFAB6E
      3EFFAC7040FFAD7141FFAD7242FFE4D0C1FFE4D0C1FFAD7242FFAD7141FFAC70
      3FFFAB6E3EFFAA6D3CFFB37F56FF000000000000000025A3D6FF2AA5D7FF2FA8
      D8FF34AADAFF38ADDCFF3DB0DEFF41B2E0FF46B5E2FF4AB8E4FF4FBBE6FF0250
      82FF1089BFFF045083FB0000000000000000B7B7B748EAE5E5EBECE7E8F3403D
      3DFF908E8EFF8F8E8EFF8F8E8EFF8F8E8EFF8F8E8EFF8F8E8EFF8F8E8EFF908E
      8EFF3F3D3DFFECE7E8F3EAE5E5EBB7B7B748DCDCDC23424242FF454545FFECEC
      ECFFF3F3F3FFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFD
      FDFFF6F6F6FF333333FF2C2C2CFFE8E8E817F3ECE71CB47D51FFAF7444FFB176
      47FFB27848FFB3794AFFB47A4BFFE6D3C3FFE6D3C3FFB47A4BFFB3794AFFB278
      48FFB17747FFAF7545FFB47E52FFF3ECE71CCAE1EC3536ABDBFF3AAEDDFF3FB1
      DFFF43B4E1FF48B6E3FF4CB9E5FF51BCE7FF55BFE9FF5AC1EBFF005085FF1291
      C9FF1394CDFF0B5D8FF4000000000000000000000000E4E4E41BC5C5C53A3838
      38FEDAD9D9FFDAD9D9FFDAD9D9FFDAD9D9FFDAD9D9FFDAD9D9FFDAD9D9FFDAD9
      D9FF383838FEC5C5C53AE4E4E41B00000000DCDCDC23464646FF3F3F3FFF9595
      95FF999999FFA2A2A2FFA6A6A6FFA6A6A6FFA6A6A6FFA6A6A6FFA5A5A5FFA5A5
      A5FFA3A3A3FF2B2B2BFF2E2E2EFFE8E8E817ECE2DA2BB88256FFB57C4DFFB77F
      4FFFB88051FFB98253FFBA8254FFE8D6C6FFE8D6C6FFBA8354FFB98253FFB880
      51FFB77E4FFFB57C4DFFB88356FFECE2DA2B70B2D28F45B5E2FF4AB8E4FF4EBA
      E6FF53BDE7FF57C0E9FF5CC3EBFF61C5EDFF1B79B0FF0C7DB6FF159AD3FF169D
      D7FF17A0DBFF2D7AA6D200000000000000000000000000000000D0D0D02F5555
      55FEEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEE
      EEFF555555FED0D0D02F0000000000000000DCDCDC234A4A4AFF424242FF4040
      40FF3D3D3DFF3B3B3BFF383838FF333333FF313131FF2E2E2EFF2B2B2BFF2929
      29FF222222FF1F1E1EFF2F2F2FFFE8E8E817F9F5F30EC3936AFFBB8455FFBD86
      58FFBE895AFFBF8A5CFFF3E9E0FFFFFFFFFFEAD9CAFFC08B5DFFBF8A5CFFBE89
      5AFFBD8658FFBB8455FFC3936AFFF9F5F30E4AA2CBB555BEE8FF59C1EAFF5EC4
      ECFF62C7EEFF65C7EFFF0F75B6FF118ECAFF179FDAFF18A3DDFF19A6E1FF1AA9
      E5FF1BACE8FF6FA8C79000000000000000000000000000000000D0D0D02F7272
      72FEEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEE
      EEFF717171FED0D0D02F0000000000000000DCDCDC23535253FF303030FF6262
      62FFD5D5D5FFC9C9C9FFB8B8B8FFAFAFAFFFABABABFFA8A8A8FFA4A4A4FF9898
      98FF353536FF202020FF313031FFE8E8E81700000000C79D7AFFC08B5CFFC28E
      60FFC49062FFC69365FFC69365FFC79365FFC79466FFC79466FFC69265FFC491
      63FFC28E60FFC08B5DFFC79D7BFF0000000000000000BFDFEE400989C9FF1091
      D1FF179FD8FF18A2DCFF19A5E0FF1AA8E4FF1BACE7FF1CAFEBFF18A6E3FF9EC8
      DD61000000000000000000000000000000000000000000000000D1D1D12E9A9A
      9AC7EEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFDEDEDEFFD1D1D1FFE8E8
      E8FA959595C5D1D1D12E0000000000000000DCDCDC23565656FF323232FF7B7B
      7BFFF7F7F7FFEFEFEFFFDCDCDCFFC8C8C8FFADADADFF3A3A3AFF373737FFB9B9
      B9FF363636FF212121FF323232FFE8E8E81700000000BD9474B4C69365FFC795
      68FFCA986BFFCB9B6DFFCC9C6FFFFDFBF9FFFDFBF9FFCC9C6FFFCC9B6DFFCA98
      6BFFC89568FFC69365FFBD9474B40000000000000000000000000D96D2FF1AA7
      E3FF1BABE6FF1CAEEAFF1DB1EDFF2198D0E6EFF7FA1000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B6B6
      B653EEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFF0F0F0FFEFEFEFFFB5B5
      B550F6F6F609000000000000000000000000DCDCDC23595959FF343433FF7878
      78FFEFEFEFFFF0F0F0FFE9E9E9FFD1D1D1FFB0B0B0FF3C3C3CFF393939FFBEBE
      BEFF373737FF222222FF333333FFE8E8E8170000000000000000CCA685FFCD9C
      6EFFCF9F72FFD0A175FFD0A276FFFDFBF9FFFDFBF9FFD0A276FFD0A175FFCF9F
      73FFCD9C6FFFCDA685FF000000000000000000000000000000000D9EDCFF1EB3
      F1FF1FB7F4FF1FB8F6FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B6B6
      B653EEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEFEFEFFFF4F4F4FFB8B8B85CFBFB
      FB0400000000000000000000000000000000DCDCDC235E5E5EFF363636FF7676
      76FFE8E8E8FFEBEBEBFFECECECFFDEDEDEFFB9B9B9FF3D3D3DFF3A3A3AFFC4C4
      C4FF373737FF232323FF343434FFE8E8E8170000000000000000F5EFEB18D6B4
      96FFD1A377FFD2A57BFFD3A77DFFD3A77FFFD3A77FFFD3A77DFFD2A57BFFD1A3
      78FFD6B496FFF5EFEB180000000000000000000000000000000019A3DDE80BA2
      E2FEDAEFF8250000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B6B6
      B653F4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF6F6F6FFB9B9B959F8F8F8070000
      000000000000000000000000000000000000E2E2E21D666666FF454545FF7B7B
      7BFFE4E4E4FFE7E7E7FFEDEDEDFFE9E9E9FFD9D9D9FFBABABAFFB7B7B7FFC8C8
      C8FF424242FF323232FF424242FFF2F2F20D000000000000000000000000FCFA
      F907BD906CEBDFBFA1FFD5AC85FFD5AC85FFD5AC85FFD5AC85FFDFBFA1FFBD90
      6CEBFCFAF9070000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD42BEBEBE65BFBFBF64BFBFBF64BEBEBE65B6B6B649FCFCFC03000000000000
      00000000000000000000000000000000000000000000DADADA25F9F9F906D3D3
      D32CA7A7A758A6A6A659A6A6A659A6A6A659A6A6A659A6A6A659A6A6A659B0B0
      B04FE8E8E817E2E2E21DEFEFEF10000000000000000000000000000000000000
      000000000000F9F5F20FD1B19982C29877C5C29877C5D1B19982F9F5F20F0000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      8001C003000000000000C003000000000000C003000000000000C00300000000
      0000C003000000000000C003000000000000C003000000000000C00300000000
      0000C003000000008000C003000000000000C003000000000000C00300000000
      C301FFFF00000000CBFFFFFF00000000FFE300008001E007FF01000000008001
      F001000000008001800300000000C00380030000000080018003000000008001
      8003000000008001800300000000000000038001000000000003C00300000000
      0003C00300008001800FC00300008001C07FE0070000C003C3FFE00F0000C003
      C7FFE01F0000E007FFFFE03F8001F81F00000000000000000000000000000000
      000000000000}
  end
end
