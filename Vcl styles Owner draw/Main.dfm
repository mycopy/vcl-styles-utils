object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Demo Owner Draw Vcl Styles'
  ClientHeight = 456
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 31
    Width = 193
    Height = 170
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Owner Draw'
    Enabled = False
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object ListView1: TListView
    Left = 207
    Top = 31
    Width = 354
    Height = 170
    Checkboxes = True
    Columns = <
      item
        Caption = 'Caption'
        Width = 80
      end
      item
        Caption = 'Column 1'
        Width = 80
      end
      item
        Caption = 'Column 2'
        Width = 80
      end
      item
        Caption = 'Column 3'
        Width = 80
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object ComboBox1: TComboBox
    Left = 207
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 3
  end
  object TreeView1: TTreeView
    Left = 8
    Top = 328
    Width = 553
    Height = 120
    HideSelection = False
    Images = ImageList1
    Indent = 19
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 8
    Top = 207
    Width = 545
    Height = 89
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    Left = 120
    Bitmap = {
      494C01010A001800300010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000038332F6F776D64D280736BDF7C71
      65DF7A6C62DF76685DDF73645ADF6D6056DF695D53DF655A4FDF61564DDF5E53
      4ADF5A4F47DF574D45DF4E443DD2151311400000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000948A82F2505050FF515151FF5252
      52FF535353FF545454FF555555FF555555FF565656FF575757FF585858FF5959
      59FF5A5A5AFF5A5A5AFF5B5B5BFF352F298C6E4934A9C28D66FFBF8A64FFBD87
      62FFBA845FFFB8825DFFB37C5AFFB17A58FFB07956FFAD7755FFAC7454FFAA73
      52FFA87151FFA86F4FFF6E4934A9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A89E95FF4C4C4CFF3B3B3BFF3B3B
      3BFF3C3C3CFF3D3D3DFF3F3F3FFF404040FF414141FF424242FF434343FF4444
      44FF444444FF464646FF585858FF3B342F94C8916AFFD5FFDAFFD5FFDAFFD6FF
      DBFFD8FFDDFFDAFFDFFF1B5C1EFFA2BBA3FFE3EBE4FFFBFCFBFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFA8704FFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADA39BFF494949FF363636FF3737
      37FF383838FF3A3A3AFF3B3B3BFF3D3D3DFF3D3D3DFF3F3F3FFF404040FF4040
      40FF424242FF434343FF555555FF3F373094CA936CFFD5FFDAFFD5FFDAFFD2FC
      D7FF57965CFFDAFFDFFF206323FFA4BEA5FFE3EBE4FFFBFCFBFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFA97151FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B1A8A0FF454545FF313131FF3232
      32FF343434FF353535FF373737FF383838FF393939FF3A3A3AFF3C3C3CFF3D3D
      3DFF3E3E3EFF3F3F3FFF535353FF413A3494CC966DFFD5FFDAFFD5FFDAFF4B94
      52FF357D3AFFDAFFDFFF256B2AFFA9C3ABFFE5ECE5FFFAFBFAFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFAB7352FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5ADA6FF404040FF2D2D2DFF2E2E
      2EFF2F2F2FFF313131FF323232FF343434FF343434FF363636FF383838FF3939
      39FF3B3B3BFF3B3B3BFF505050FF443D3694D19B71FFD5FFDAFF5DA864FF5BA5
      62FF56A05DFF327C38FF55995BFFA8C4AAFFE4ECE4FFFBFCFBFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFAF7856FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B9B1ABFF3B3B3BFF272727FFD1D1
      D1FFACACACFF2C2C2CFF2D2D2DFF2F2F2FFF303030FF323232FF343434FF3535
      35FF363636FF383838FF4C4C4CFF483F3894D49D73FF56AB60FF67B36FFF8DCC
      95FF8ACB91FF86C88DFF5DA063FFABC9ADFFE5EEE6FFFBFCFBFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFB17A58FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDB6B1FF373737FF232323FF2424
      24FFDEDEDEFF727272FF282828FF2A2A2AFF2B2B2BFF2D2D2DFF2F2F2FFF3030
      30FF323232FF333333FF494949FF4D433B94D59F74FFD5FFDAFF6ABA73FF69B5
      72FF74BB7CFF519F59FF62A669FFB1CFB4FFE7EFE7FFFAFCFAFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFB47C5AFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0B9B4FF323232FF1E1E1EFFCFCF
      CFFFA7A7A7FF222222FF232323FF242424FF262626FF282828FF2A2A2AFF2B2B
      2BFF2D2D2DFF2F2F2FFF444444FF50463F94D8A177FFD5FFDAFFD5FFDAFF67B8
      6FFF52A85CFFB9EABEFF59A361FFB1D2B4FFE8F1E9FFFBFCFBFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFB6805CFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C2BDB8FF323232FF1E1E1EFF1F1F
      1FFF202020FF222222FF232323FF242424FF262626FF282828FF2A2A2AFF2B2B
      2BFF2D2D2DFF2F2F2FFF444444FF52484194D9A277FFD5FFDAFFD5FFDBFFD3FD
      D8FF79C582FFD9FFDEFF4BA053FFB4D6B8FFE8F2E9FFFBFDFBFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFB9845EFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C4BFB9FF2F2F2FFF303030FF3131
      31FF323232FF333333FF343434FF353535FF373737FF393939FF3A3A3AFF3B3B
      3BFF3D3D3DFF3F3F3FFF414141FF483F3894DBA378FFD5FFDAFFD5FFDBFFD6FF
      DBFFD7FFDCFFD9FFDEFF52AA5CFFB7DABBFFE9F3EAFFFBFDFBFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFBC8661FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C9C2BEFFB7BAF1FF93E4F6FFB1E5
      B3FFEDE9E6FFEDE9E6FFEDE9E6FFEDE9E6FFEDE9E6FFEDE9E6FFEDE9E6FFEDE9
      E6FFEDE9E6FFEDE9E6FFF5F4F2FF4D433B94DCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFBF8A64FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C1BDB9FE484DD3FF15ACE2FF3CAF
      40FFE1DBD6FFE1DBD6FFE1DBD6FFE1DBD6FFE1DBD6FFE1DBD6FFE1DBD6FFE1DB
      D6FFE1DBD6FFE1DCD7FFEDEAE7FF50453E93DBA983FDE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFBE8E6CFD000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000065615E99BEBAB6FAC8C3BEFFC8C1
      BDFFC4BFB9FFC0B9B4FFBCB5B0FFB8B1AAFFB4ABA4FFAFA69EFFAA9F97FFA59A
      91FFA0948AFF9B8E84FF908378FA35302D6E462E216BD3A886F4DCA679FFDCA5
      78FFDAA378FFD8A177FFD59F74FFD49D73FFD29C71FFCF9970FFCE986EFFCB95
      6DFFC9936AFFBA9273F4462E216B000000000000000000000000000000000000
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
      0000103951F7265C84FB4685B9FB316A8EC1050F182200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000761EF50279
      1CFF000F02210000000000000000000000000000000000000000000000000000
      0000051E282E061C242C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000296280FB93C7F9FF90C9F9FF3F84C9FF195DA1F30715212F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007D28F541A0
      5DFF006C1AE40011032700000000000000000000000000000000000000000000
      00000A313F491E90C0DF0A334450000000000000000000000000000000000000
      0000000000000000000000000000000000006E4934A9C28D66FFBF8A64FFBD87
      62FFBA845FFFB8825DFFB37C5AFFB17A58FFB07956FFAD7755FFAC7454FFAA73
      52FFA87151FFA86F4FFF6E4934A9000000006E4934A9C28D66FFBF8A64FFBD87
      62FF4188A9FFE0F2FFFF5299D8FF1878BDFF4797C4FF3E80B5FF987769FFAA73
      52FFA87151FFA86F4FFF6E4934A9000000006E4934A9C28D66FFBF8A64FFBD87
      62FFBA845FFFB8825DFF20964FFF1A9047FF148E41FF0F8A39FF389E5CFF7EC0
      95FF44A260FF0F7A22FF5D512FB7000000006E4934A9C28D66FFBF8A64FFBD87
      62FFBA845FFF4CA0BBFF41B4E3FF5194AEFFA77B5EFFAD7755FFAC7454FFAA73
      52FFA87151FFA86F4FFF6E4934A900000000C8916AFFE6E5E5FFE5E5E5FFE5E5
      E6FFE5E5E5FFE5E5E5FFE6E5E5FFE5E5E5FFE6E5E5FFE5E6E5FFE6E6E6FFE6E5
      E5FFE5E6E6FFE6E5E6FFA8704FFF00000000C8916AFFE6E5E5FFE5E5E5FFE5E5
      E6FF96B4C9FF78B5D5FF8FB6D1FF53C9E4FF59DFF5FF76D0EDFF4D9ADBFFCFD9
      E3FFE5E6E6FFE6E5E6FFA8704FFF00000000C8916AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF279A59FF8FCAA8FF8CC8A4FF89C5A0FF87C49DFF68B5
      84FF81C196FF46A464FF0D7A23FF00160530C8916AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF3FBFDFF2FAEDFFF4FB9E6FF39ACDEFFAAD9F0FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFA8704FFF00000000CA936CFFE7E7E7FFE8E7E7FFE7E7
      E7FFE7E7E7FFE7E7E7FFC2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFE7E7E7FFA97151FF00000000CA936CFFE7E7E7FFE8E7E7FFE7E7
      E7FFE7E7E7FFA3C5D7FF73B7D6FFC1F6FDFF61DFF7FF5BE2F8FF77D3F0FF4898
      DCFFE6F1FAFFE7E7E7FFA97151FF00000000CA936CFFFFFFFFFFFFFFFFFFFFFF
      FEFFFFFFFDFFFEFEFDFF2F9E61FF93CDACFF6DB98DFF69B788FF64B584FF5FB2
      7EFF65B481FF82C197FF3A9F5AFF007C23FCCA936CFFFFFFFFFFA3E3F4FF8FDB
      F0FF91DAEFFF8BD6EEFF3BB6E2FF7BD0F0FF6BC7ECFF42B1E2FF71C0E4FFDFEF
      F5FFFCFCF9FFFFFFFFFFA97151FF00000000CC966DFFE9E9E9FFD28256FFD282
      56FFD28256FFE9E9E9FFC2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFE9EAEAFFAB7352FF00000000CC966DFFE9E9E9FFD28256FFD282
      56FFD28256FFE9E9E9FF88ADBEFF75CBE7FFC7F7FDFF5CDCF5FF58E1F7FF79D4
      F1FF4A99DEFFC3D7E7FFAB7352FF00000000CC966DFFFFFFFFFFFFFFFCFFFFFF
      FDFFFEFEFCFFFEFEFCFF35A269FF95CEAFFF93CDACFF90CBA9FF8FCBA7FF72BB
      8FFF89C7A0FF44A466FF078633FF0008020FCC966DFFFFFFFFFF61D1ECFF6CD8
      F0FF66D3EFFF64CFEDFF83D9F3FF87D7F4FF7BCFF1FF56BBE8FF50B6E5FF209C
      D7FFA4D3E9FFF5FAFDFFAB7352FF00000000D19B71FFECECECFFECECEBFFECEC
      EBFFECECECFFECEBECFFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2
      C2FFC2C2C2FFECECEBFFAF7856FF00000000D19B71FFECECECFFECECEBFFECEC
      EBFFECECECFFECEBECFFC2C2C2FF94BCCAFF77D3EEFFC7F7FDFF5DDCF5FF59E2
      F7FF78D6F2FF4E9FE0FF9B7C6CFF00000000D19B71FFFFFFFFFFFEFEFCFFFEFE
      FCFFFEFEFCFFFDFDFBFF3BA46DFF37A36CFF33A166FF2F9D60FF53AE7AFF90CB
      A9FF4DAA72FF178F44FFA87955FF00000000D19B71FFFFFFFFFFD4F3F8FF47C9
      EAFF8FE6F8FF8CE3F7FF5ED2F2FF83D7F4FF3AB6E2FF85CFEAFF8ACFE9FF81CA
      E7FF8FCCE6FFE5F3FAFFAF7856FF00000000D49D73FFEFEEEEFFEFEFEFFFEFEE
      EEFFEFEEEEFFEEEFEEFFEEEEEEFFEEEFEFFFEEEEEEFFEEEEEEFFEEEEEEFFEFEE
      EEFFEEEEEEFFEEEEEFFFB17A58FF00000000D49D73FFEFEEEEFFEFEFEFFFEFEE
      EEFFEFEEEEFFEEEFEEFFEEEEEEFFEEEFEFFFB4DEEBFF7BD4EEFFC3F6FDFF6ADD
      F6FF6BCAEDFF61A2D7FF6198C9FF0C161D26D49D73FFFFFFFFFFFEFEFCFFFDFD
      FBFFFDFDFCFFFDFDFBFFFDFDF9FFFCFCF8FFFBF9F7FFFBF9F5FF37A167FF58B2
      80FF269755FFF7FBF9FFB17A58FF00000000D49D73FFFFFFFFFFFAFDFCFF99E2
      F2FF69D9F1FF95E7F8FF45CFF2FF88DCF4FF36B8E3FFA3DBECFFFBF8F4FFFBF7
      F2FFFBF5F2FFFFFFFFFFB17A58FF00000000D59F74FFF1F1F0FFF1F0F1FFF0F1
      F1FFF1F0F1FFF1F1F1FFC2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF1F1F1FFB47C5AFF00000000D59F74FFF1F1F0FFF1F0F1FFF0F1
      F1FFF1F0F1FFF1F1F1FFC2C2C2FFFFFFFFFFFFFFFFFFB4E6F5FF80D6EEFFB1E3
      F9FF8ABFE7FFADD3F6FFC3E0FCFF6199CCF7D59F74FFFFFFFFFFFDFDFCFFFDFD
      FBFFFDFDFAFFFCFCF9FFFCFBF7FFFBF9F5FFFBF8F4FFFBF7F3FF3DA56EFF2F9E
      63FFF1EFE7FFFFFFFFFFB47C5AFF00000000D59F74FFFFFFFFFFFDFDFCFFE5F7
      F9FF45CCEBFF92E7F8FF5DD8F4FF8FE0F6FF7BD6F2FF50C2E9FFA9DBEBFFFAF3
      EFFFF8F2ECFFFFFFFFFFB47C5AFF00000000D8A177FFF2F2F2FFD28256FFD282
      56FFD28256FFF2F2F3FFC2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF3F3F3FFB6805CFF00000000D8A177FFF2F2F2FFD28256FFD282
      56FFD28256FFF2F2F3FFC2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFB0E6F5FF75BD
      E7FFB3D2F0FFE5F3FFFFABD2EFFF407DB5E8D8A177FFFFFFFFFFFDFDFAFFFCFC
      FAFFFCFBF9FFFBFAF6FFFBF8F5FFFBF7F4FFFBF6F1FFF8F4EEFFF7F2EBFFF7F0
      EAFFF6ECE8FFFFFFFFFFB6805CFF00000000D8A177FFFFFFFFFFFDFDFAFFFAFB
      FAFF8CE0F1FF72DEF3FF88E3F6FF84DEF5FF80D9F4FF76D3F1FF4EC1E8FFADDA
      E7FFF4ECE8FFFFFFFFFFB6805CFF00000000D9A277FFF5F5F5FFF5F5F4FFF4F5
      F4FFF4F4F4FFF5F5F4FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2
      C2FFC2C2C2FFF4F4F5FFB9845EFF00000000D9A277FFF5F5F5FFF5F5F4FFF4F5
      F4FFF4F4F4FFF5F5F4FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FF93BC
      CCFF56A4D8FF84B0DBFF449CD0FF0F374D5ED9A277FFFFFFFFFFFCFBF9FFFCFB
      F8FFFBF9F7FFFBF7F4FFFAF7F2FFF9F5F0FFF7F3EDFFF6EFEAFFF5EBE7FFF3EA
      E4FFF2E7DEFFFFFFFFFFB9845EFF00000000D9A277FFFFFFFFFFFCFBF9FFFCFB
      F8FFCAEEF4FF5BD4ECFF57D1EBFF55CEEAFF53CAE8FF51C7E7FF4CC1E4FF56C1
      E3FFDCE1DEFFFFFFFFFFB9845EFF00000000DBA378FFF6F6F6FFF6F6F6FFF6F6
      F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6
      F6FFF6F6F6FFF6F6F6FFBC8661FF00000000DBA378FFF6F6F6FFF6F6F6FFF6F6
      F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6
      F6FFF6F6F6FFF6F6F6FFBC8661FF00000000DBA378FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFBC8661FF00000000DBA378FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFBC8661FF00000000DCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFBF8A64FF00000000DCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFBF8A64FF00000000DCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFBF8A64FF00000000DCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFBF8A64FF00000000DBA983FDE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFBE8E6CFD00000000DBA983FDE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFBE8E6CFD00000000DBA983FDE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFBE8E6CFD00000000DBA983FDE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFBE8E6CFD00000000462E216BD3A886F4DCA679FFDCA5
      78FFDAA378FFD8A177FFD59F74FFD49D73FFD29C71FFCF9970FFCE986EFFCB95
      6DFFC9936AFFBA9273F4462E216B00000000462E216BD3A886F4DCA679FFDCA5
      78FFDAA378FFD8A177FFD59F74FFD49D73FFD29C71FFCF9970FFCE986EFFCB95
      6DFFC9936AFFBA9273F4462E216B00000000462E216BD3A886F4DCA679FFDCA5
      78FFDAA378FFD8A177FFD59F74FFD49D73FFD29C71FFCF9970FFCE986EFFCB95
      6DFFC9936AFFBA9273F4462E216B00000000462E216BD3A886F4DCA679FFDCA5
      78FFDAA378FFD8A177FFD59F74FFD49D73FFD29C71FFCF9970FFCE986EFFCB95
      6DFFC9936AFFBA9273F4462E216B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000C381C881664
      33F2176935FF166433F20C381C88000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFDFEDE0FF8EBE90FF398B3CFF227726FF227426FF39843CFF8EB890FFDFEA
      E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000002525254849494997656565D8616161D8414141971D1D1D480000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B361B84268B51FF62B9
      8CFF94D2B1FF62B98CFF268B51FF0D391E8C0000000000000000000000006E49
      34A9C28D66FFBD8762FFBA845FFFB8825DFFB17A58FFB07956FFAD7755FFAC74
      54FFAA7352FFA87151FFA86F4FFF6E4934A9FFFFFFFFFFFFFFFFFFFFFFFFB4D8
      B5FF2F8E32FF409F50FF86CA99FF9AD3AAFF9AD2AAFF82C795FF3B964AFF2E7A
      32FFB3D0B5FFFFFFFFFFFFFFFFFFFFFFFFFF00000000030303050808080E1515
      1524616161AF999999FFA8A8A8FFB8B8B8FFB7B7B7FFA2A2A2FF878687FF4848
      48AF0E0E0E240606061002020207000000006E4934A9C28D66FFBF8A64FFBD87
      62FFBA845FFFB8825DFFB37C5AFFB17A58FFB07956FF1E6A38FF60B98AFF5EB9
      86FFFFFFFFFF5EB886FF65BB8EFF176634F7000000000000000000000000C891
      6AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFA8704FFFFFFFFFFFFFFFFFFFB4DBB8FF228E
      27FF6BBD82FFA7DBB4FF86CC97FF64BB7BFF62B97AFF85CB97FFA4D9B3FF64B6
      7BFF217024FFB3D0B5FFFFFFFFFFFFFFFFFF000000000808080C464646708888
      88E1AAAAAAFF8B8B8BF7585858A3A3A3A3FFA1A1A1FF4D4D4DA3707070F79796
      96FF5E5E5EE1272727620707071400000000C8916AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F794AFF9BD4B5FFFFFF
      FFFFFFFFFFFFFFFFFFFF94D2B1FF176935FF000000000000000000000000CC96
      6DFFFFFFFFFFFFFFFDFFFEFEFCFFFEFEFCFFFDFDFAFFFDFDFAFFFDFDFAFFFDFD
      FAFFFCFCF7FFFBFBF6FFFFFFFFFFAB7352FFFFFFFFFFE0F1E4FF319F42FF70C1
      86FFA7DBB1FF5EBB75FF5AB971FF57B76EFF57B46DFF56B46DFF59B672FFA4D9
      B2FF67B77DFF2F7D32FFE0ECE1FFFFFFFFFF000000000F0F0F17A9A9A9FFB2B0
      B0FF48484877161616250E0E0E188A8A8AFE848484FE0C0C0C18111111253636
      3677989797FF727272FF0707071400000000CA936CFFFFFFFFFFFFFFFFFFFFFF
      FEFFFFFFFDFFFEFEFDFFFEFEFCFFFEFEFCFFFEFEFCFF488A60FF8FD3B0FF91D6
      B0FFFFFFFFFF63BB8BFF65BB8EFF176634F7000000000000000000000000D19B
      71FFFFFFFFFFFEFEFCFFFEFEFCFFFDFDFBFFFDFDFAFFFDFDF8FFFBFBF9FFFBFA
      F7FFFBFAF6FFFBF8F4FFFFFFFFFFAF7856FFFFFFFFFF8ED29EFF4AAF62FFA9DD
      B3FF62C077FF5DBD6FFF73C484FFD4ECD9FF89CD98FF54B56AFF56B46CFF5AB6
      72FFA5DAB3FF3F9A4CFF8DBA8FFFFFFFFFFF00000000B2B2B2FFBAB9BAFFB4B3
      B3FFA2A2A2FF1212121E00000000919191FF8C8C8CFF000000000F0F0F1E7A7A
      7AFF979797FF9B9A9BFF6C6C6CFF00000000CC966DFFFFFFFFFFFFFFFCFFFFFF
      FDFFFEFEFCFFFEFEFCFFFEFEFBFFFDFDFAFFFDFDFAFFA6C5B0FF5FAA80FF94D4
      B3FFB9E6D0FF68BA8EFF2B8E55FF0D391E8C56382882956C4EC491684BC4D59F
      74FFFFFFFFFFFDFDFBFFFDFDFAFFFCFCF9FFFBF9F5FFFBF8F4FFFBF7F3FFFBF5
      F2FFFAF3EFFFF8F2ECFFFFFFFFFFB47C5AFFFFFFFFFF3CB45AFF90D29EFF8CD4
      99FF62C272FF77C986FFF2FAF4FFFFFFFFFFFDFEFDFF85CB95FF55B66BFF59B8
      70FF84CC96FF86C799FF398A3CFFFFFFFFFF000000004D4D4D6B9B9B9BDD4949
      496B000000000000000000000000989898FF929292FF00000000000000000000
      00003333336B666666DD2F2F2F6B00000000D19B71FFFFFFFFFFFEFEFCFFFEFE
      FCFFFEFEFCFFFDFDFBFFFDFDFBFFFDFDFAFFFDFDF8FFFBFBF9FFABC8B4FF5E98
      73FF4D8D64FF48895FFF6F774FFF00000000996F51C4C4C4C4C4C4C4C4C4D8A1
      77FFFFFFFFFFFCFCFAFFFCFBF9FFFBFAF6FFFBF7F4FFFBF6F1FFF8F4EEFFF7F2
      EBFFF7F0EAFFF6ECE8FFFFFFFFFFB6805CFFFFFFFFFF24AE46FFA5DCAEFF6ECA
      7DFF71CA7EFFF0F9F1FFFFFFFFFFEBF7EDFFFFFFFFFFFBFDFCFF87CD95FF59B8
      6FFF65BD7BFF9FD7AEFF217C23FFFFFFFFFF0000000000000000000000000000
      00000000000000000000000000009E9E9EFF999999FF00000000000000000000
      000000000000000000000000000000000000D49D73FFFFFFFFFFFEFEFCFFFDFD
      FBFFFDFDFCFFFDFDFBFFFDFDF9FFFCFCF8FFFBF9F7FFFBF9F5FFFBF8F4FFFBF7
      F2FFFBF5F2FFFFFFFFFFB17A58FF000000009C7354C4C4C4C4C4C4C4C1C4D9A2
      77FFFFFFFFFFFCFBF8FFFBF9F7FFFBF7F4FFF9F5F0FFF7F3EDFFF6EFEAFFF5EB
      E7FFF3EAE4FFF2E7DEFFFFFFFFFFB9845EFFFFFFFFFF2BB54FFFA6DDB0FF70CC
      7EFF64C771FFAFE1B6FFD2EED6FF61C06EFFB7E3BEFFFFFFFFFFFBFDFCFF8BD0
      98FF67C07CFFA0D7ADFF218223FFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000A5A5A5FF9F9F9FFF00000000000000000000
      000000000000000000000000000000000000D59F74FFFFFFFFFFFDFDFCFFFDFD
      FBFFFDFDFAFFFCFCF9FFFCFBF7FFFBF9F5FFFBF8F4FFFBF7F3FFFBF5F2FFFAF3
      EFFFF8F2ECFFFFFFFFFFB47C5AFF00000000A07757C4C4C4C4C4C3C3C1C4DBA3
      78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFBC8661FFFFFFFFFF48C36AFF94D7A0FF90D7
      9AFF67C974FF62C56DFF5FC36CFF5FC26DFF5FC16DFFB8E4BFFFFFFFFFFFE3F4
      E6FF8AD198FF8ACE9CFF3A973DFFFFFFFFFF0000000000000000000000000000
      00005C5C5C7E8C8C8CC4878787C4B6B6B6FFB3B2B3FF7B7B7BC4767676C44A4A
      4A7E00000000000000000000000000000000D8A177FFFFFFFFFFFDFDFAFFFCFC
      FAFFFCFBF9FFFBFAF6FFFBF8F5FFFBF7F4FFFBF6F1FFF8F4EEFFF7F2EBFFF7F0
      EAFFF6ECE8FFFFFFFFFFB6805CFF00000000A37A59C4C4C4C4C4C1C1C0C4DCA6
      79FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFDCA679FFBF8A64FFFFFFFFFF99DEABFF55BE6EFFAEE1
      B6FF6BCC78FF66C870FF63C76EFF61C46CFF60C36CFF61C36FFFB5E3BDFF6DC7
      7CFFABDFB4FF46A85CFF8DC792FFFFFFFFFF0000000000000000000000000000
      0000999999CBB9B9B9FCB4B4B4FCC7C7C7FFC7C5C7FFA4A4A4FC9F9F9FFC7B7B
      7BCB00000000000000000000000000000000D9A277FFFFFFFFFFFCFBF9FFFCFB
      F8FFFBF9F7FFFBF7F4FFFAF7F2FFF9F5F0FFF7F3EDFFF6EFEAFFF5EBE7FFF3EA
      E4FFF2E7DEFFFFFFFFFFB9845EFF00000000A67C5BC4C4C4C4C4C1C1C0C4DDAC
      85FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFE8B891FFBE8E6CFDFFFFFFFFE4F6E9FF46C364FF7DCE
      8FFFADE1B4FF6BCC78FF68CA74FF66C870FF66C872FF66C873FF69C977FFABDF
      B3FF74C388FF319F40FFE0F0E3FFFFFFFFFF0000000000000000000000000000
      00000000000000000000ADADADEAB6B6B6FEB1B1B1FE9F9F9FEA000000000000
      000000000000000000000000000000000000DBA378FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFBC8661FF00000000A67D5BC4C4C4C4C4C1C0BEC4B79D
      90DDDBB08DFCDCA578FFDAA378FFD8A177FFD49D73FFD29C71FFCF9970FFCE98
      6EFFCB956DFFC9936AFFBA9273F4462E216BFFFFFFFFFFFFFFFFBEECCAFF3AC1
      5AFF7DCE8FFFAEE1B6FF91D89CFF75CE82FF75CE82FF91D89CFFADE1B4FF76C8
      8AFF24A038FFB4DFBCFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      00000000000000000000B6B6B6EF4747476045454560A8A8A8EF000000000000
      000000000000000000000000000000000000DCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA679FFDCA6
      79FFDCA679FFDCA679FFBF8A64FF00000000A87D5CC4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C491674BC4000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFBEEC
      CBFF47C767FF57C172FF95D7A2FFA4DCADFFA4DCADFF94D6A0FF4EB868FF32B2
      52FFB5E3C0FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      00000000000000000000BBBBBBEF5454546E5252526EADADADEF000000000000
      000000000000000000000000000000000000DBA983FDE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B891FFE8B8
      91FFE8B891FFE8B891FFBE8E6CFD00000000A9805DC4A9805DC4A9805DC4A980
      5DC4A9805DC4A9805DC4A9805DC4A9805DC4A9805DC4A9805DC4A9805DC4A980
      5DC4936A4DC4000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE4F7E9FF9DE2AFFF52CA70FF38BF5AFF34BD58FF46C168FF96DBA9FFE1F4
      E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      000000000000000000007272728EBCBCBCEFB6B6B6EF6969698E000000000000
      000000000000000000000000000000000000462E216BD3A886F4DCA679FFDCA5
      78FFDAA378FFD8A177FFD59F74FFD49D73FFD29C71FFCF9970FFCE986EFFCB95
      6DFFC9936AFFBA9273F4462E216B00000000A88264C2B28C6FC4B28C6FC4B28C
      6FC4B28C6FC4B28C6FC4B28C6FC4B28C6FC4B28C6FC4B28C6FC4B28C6FC4B28C
      6FC4926D53C2000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000036231952A38167BCA97F5CC4A87D
      5CC4A67C5BC4A37858C4A07857C49F7656C49E7554C49C7354C4997151C48F71
      58BC36231952000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF000000000000FFFF00000000
      0000000100000000000000010000000000000001000000000000000100000000
      0000000100000000000000010000000000000001000000000000000100000000
      0000000100000000000000010000000000000001000000000000000100000000
      0000000100000000FFFFFFFF00000000FFFFF07FFFC7F3FFFFFFF03FFFC3F1FF
      0001000100010001000100010000000100010001000000010001000100000001
      0001000100010001000100000001000100010000000100010001000000010001
      0001000000010001000100010001000100010001000100010001000100010001
      0001000100010001FFFFFFFFFFFFFFFF0000FFFFFFC1FFFF0000F81FFF80E000
      000080010000E000000080010000E000000080010000E0000000824100000000
      00008E71000100000000FE7F000100000000FE7F000100000000F00F00010000
      0000F00F000100000000FC3F000100000000FC3F000100070000FC3F00010007
      0000FC3F000100070000FFFFFFFF000700000000000000000000000000000000
      000000000000}
  end
end