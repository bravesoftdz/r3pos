inherited frmCheckOrderList: TfrmCheckOrderList
  Left = 291
  Top = 139
  Width = 891
  Height = 571
  Caption = #30424#28857#21333
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 883
    Height = 507
    inherited RzPanel2: TRzPanel
      Width = 873
      Height = 497
      inherited RzPage: TRzPageControl
        Width = 867
        Height = 491
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #30424#28857#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 865
            Height = 464
            inherited RzPanel1: TRzPanel
              Width = 855
              Height = 91
              object RzLabel2: TRzLabel
                Left = 57
                Top = 3
                Width = 24
                Height = 12
                Alignment = taRightJustify
                Caption = #26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 3
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel5: TRzLabel
                Left = 57
                Top = 64
                Width = 24
                Height = 12
                Alignment = taRightJustify
                Caption = #21333#21495
              end
              object Label1: TLabel
                Left = 201
                Top = 66
                Width = 120
                Height = 12
                Caption = #25903#25345#27169#22359','#36755#21518'4'#20301#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzLabel6: TRzLabel
                Left = 45
                Top = 44
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #30424#28857#20154
              end
              object Label40: TLabel
                Left = 33
                Top = 23
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object D1: TcxDateEdit
                Left = 89
                Top = -1
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = -1
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndPRINT_DATE: TcxTextEdit
                Left = 89
                Top = 59
                Width = 104
                Height = 20
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object btnOk: TRzBitBtn
                Left = 480
                Top = 52
                Width = 67
                Height = 26
                Action = actFind
                Caption = #26597#35810
                Color = clSilver
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                HighlightColor = 16026986
                HotTrack = True
                HotTrackColor = 3983359
                HotTrackColorType = htctActual
                ParentFont = False
                TextShadowColor = clWhite
                TextShadowDepth = 4
                TabOrder = 3
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSTATUS: TcxRadioGroup
                Left = 360
                Top = -6
                Width = 105
                Height = 85
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end>
                TabOrder = 4
                Caption = ''
              end
              object fndCHECK_EMPL: TzrComboBoxList
                Left = 89
                Top = 39
                Width = 152
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 5
                InGrid = False
                KeyValue = Null
                FilterFields = 'ACCOUNT;USER_NAME'
                KeyField = 'USER_ID'
                ListField = 'USER_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCOUNT'
                    Footers = <>
                    Title.Caption = #24080#21495
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #22995#21517
                    Width = 130
                  end>
                DropWidth = 180
                DropHeight = 150
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 19
                Width = 236
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 6
                InGrid = False
                KeyValue = Null
                FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
                KeyField = 'SHOP_ID'
                ListField = 'SHOP_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Width = 20
                  end>
                DropWidth = 236
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            inherited DBGridEh1: TDBGridEh
              Top = 96
              Width = 855
              Height = 363
              OnDblClick = actInfoExecute
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 32
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'PRINT_DATE'
                  Footers = <>
                  Title.Caption = #30424#28857#26085#26399
                  Width = 77
                end
                item
                  EditButtons = <>
                  FieldName = 'SHOP_ID_TEXT'
                  Footers = <>
                  Title.Caption = #30424#28857#38376#24215
                  Width = 138
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #30424#28857#20154
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24320#22987#30424#28857#26102#38388
                  Width = 145
                end
                item
                  EditButtons = <>
                  FieldName = 'CHECK_TYPE'
                  Footers = <>
                  Title.Caption = #30424#28857#31867#22411
                  Width = 67
                end
                item
                  EditButtons = <>
                  FieldName = 'CHECK_STATUS'
                  Footers = <>
                  Title.Caption = #29366#24577
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23457#26680#20154
                  Width = 52
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                  Width = 58
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 273
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 883
    inherited Image1: TImage
      Left = 581
      Width = 282
    end
    inherited Image3: TImage
      Left = 581
      Width = 282
    end
    inherited Image14: TImage
      Left = 863
    end
    inherited rzPanel5: TPanel
      Left = 581
      inherited lblToolCaption: TRzLabel
        Width = 36
        Caption = #30424#28857#21333
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 561
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 561
          Width = 36
        end>
      inherited ToolBar1: TToolBar
        Width = 561
        object ToolButton11: TToolButton
          Left = 518
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 184
    Top = 248
  end
  inherited actList: TActionList
    Left = 216
    Top = 248
    inherited actEdit: TAction
      Caption = #24405#20837
    end
    inherited actPreview: TAction
      Visible = False
    end
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
  end
  inherited ppmReport: TPopupMenu
    Top = 72
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfCheckOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfCheckOrderGetValue
    OnUserFunction = frfCheckOrderUserFunction
    Left = 425
    Top = 190
    ReportForm = {
      18000000FC170000180000FFFF01000100FFFFFFFFFF090000009A0B00003408
      00002400000012000000240000001200000001FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00B60000002F0400001B0000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      3F0100000700B7D6D7E9CDB73100020100000000190000002F0400006D000000
      3200100001000000000000000000FFFFFF1F0000000002003231000000000000
      00FFFF000000000002000000010000000000000001000000C800000014000000
      010000000000000200260200000700B7D6D7E9BDC53100020100000000120100
      002F0400004A0000003000110001000000000000000000FFFFFF1F0000000000
      000000000007000500626567696E0D1E0020696620436F756E74284D61737465
      724461746131293C3134207468656E0D060020626567696E0D26002020202066
      6F7220693A3D436F756E74284D617374657244617461312920746F2031332064
      6F0D15002020202053686F7742616E64284368696C6431293B0D050020656E64
      3B0D0300656E6400FFFF000000000002000000010000000000000001000000C8
      000000140000000100000000000002008C02000006006368696C643100020100
      000000E80000002F0400001B0000003000150001000000000000000000FFFFFF
      1F00000000000000000000000000FFFF00000000000200000001000000000000
      0001000000C8000000140000000100000000000000000F03000006004D656D6F
      3332000200100200004000000024000000120000000100000001000000000000
      000000FFFFFF1F2E02000000000001000500B5A5BAC53A00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000002000000000008000000
      8600020000000000FFFFFF0000000002000000000000000000BD03000006004D
      656D6F3230000200EE000000B6000000F90000001B00000001000F0001000000
      000000000000FFFFFF1F2E020000000000010030005B474F44535F4E414D455D
      205B50524F50455254595F30315F544558545D5B50524F50455254595F30325F
      544558545D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000080000008600020000000000FFFFFF00000000020000
      000000000000004604000006004D656D6F343000020082030000400000007C00
      0000120000000100020001000000000000000000FFFFFF1F2E02000000000001
      000B005B435245415F444154455D00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000080000008600020000000000FF
      FFFF0000000002000000000000000000CF04000006004D656D6F3233000200E7
      010000B6000000280000001B00000001000F0001000000000000000000FFFFFF
      1F2E02000000000001000B005B554E49545F4E414D455D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A0000000000000000000A000000
      8600020000000000FFFFFF00000000020000000000000000005905000006004D
      656D6F3538000200340200004000000086000000120000000100020001000000
      000000000000FFFFFF1F2E02000000000001000C005B5052494E545F44415445
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000000000008600020000000000FFFFFF0000000002000000000000
      000000E605000005004D656D6F320002003500000021000000C9030000180000
      000100000001000000000000000500FFFFFF1F2E020000000000010010005BC6
      F3D2B5C3FBB3C65DC5CCB5E3B1ED00000000FFFF000000000002000000010000
      00000400CBCECCE500100000000200000000000A0000008600020000000000FF
      FFFF00000000020000000000000000006B06000006004D656D6F31330002004E
      0300004000000034000000120000000100000001000000000000000000FFFFFF
      1F2E02000000000001000700C8D52020C6DA3A00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000086000200
      00000000FFFFFF0000000002000000000000000000EF06000006004D656D6F33
      34000200730300005C0000008C0000002A00000001000F000100000000000000
      0000FFFFFF1F2E02000000000001000600B1B82020D7A200000000FFFF000000
      00000200000001000000000400CBCECCE5000A0000000200000000000A000000
      8600020000000000FFFFFF00000000020000000000000000007507000006004D
      656D6F3336000200EE0000005C000000F90000002A00000001000F0001000000
      000000000000FFFFFF1F2E02000000000001000800C9CCC6B7C3FBB3C6000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      00000A0000008600020000000000FFFFFF0000000002000000000000000000F9
      07000006004D656D6F33370002000F0200005C000000620000002A0000000100
      0F0001000000000000000000FFFFFF1F2E02000000000001000600D5CBC3E6CA
      FD00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0200000000000A0000008600020000000000FFFFFF0000000002000000000000
      0000007B08000006004D656D6F3338000200E70100005C000000280000002A00
      000001000F0001000000000000000000FFFFFF1F2E02000000000001000400B5
      A5CEBB00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      00000200000000000A0000008600020000000000FFFFFF000000000200000000
      00000000000009000006004D656D6F34340002001C0100001201000036000000
      1C0000000100000001000000000000000000FFFFFF1F2E020000000000010007
      00B2D6B9DCD4B13A00000000010000000000000200000001000000000400CBCE
      CCE5000A0000000200FFFFFF1F080000008600020000000000FFFFFF00000000
      020000000000000000008609000006004D656D6F3431000200FB020000120100
      00340000001C0000000100000001000000000000000000FFFFFF1F2E02000000
      000001000800BCE0C5CCC8CBA3BA00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000020000000000080000008600020000000000FF
      FFFF0000000002000000000000000000070A000005004D656D6F370002003500
      00005C000000590000002A00000001000F0001000000000000000000FFFFFF1F
      2E02000000000001000400BBF5BAC500000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000000100020000000000
      FFFFFF00000000020000000000000000008F0A000005004D656D6F3800020035
      000000B6000000590000001B00000001000F0001000000000000000000FFFFFF
      1F2E02000000000001000B005B474F44535F434F44455D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      0100020000000000FFFFFF0000000002000000000000000000250B000006004D
      656D6F3234000200A80300002100000056000000120000000100000001000000
      000000000000FFFFFF1F2E02000000000001001800B5DA5B50414745235D2F5B
      544F54414C50414745535DD2B300000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000090000008600020000000000FFFF
      FF0000000002000000000000000000B80B000005004D656D6F31000200370000
      0012010000AE0000001C0000000100000001000000000000000000FFFFFF1F2E
      02000000000001001600D6C6B5A5A3BA5B435245415F555345525F544558545D
      00000000010000000000000200000001000000000400CBCECCE5000A00000002
      00FFFFFF1F080000008600020000000000FFFFFF000000000200000000000000
      00003A0C000006004D656D6F35360002008E0000005C000000600000002A0000
      0001000F0001000000000000000000FFFFFF1F2E02000000000001000400CCF5
      C2EB00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      000200000000000A0000000100020000000000FFFFFF00000000020000000000
      00000000C10C000006004D656D6F35370002008E000000B6000000600000001B
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001000900
      5B424152434F44455D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000080000000100020000000000FFFFFF000000
      00020000000000000000003D0D000006004D656D6F3632000200EE000000E800
      0000F90000001B00000001000F0001000000000000000000FFFFFF1F2E020000
      000000000000000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000080000008600020000000000FFFFFF00000000020000
      00000000000000B90D000006004D656D6F3633000200E7010000E80000002800
      00001B00000001000F0001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0000000000000A0000008600020000000000FFFFFF0000000002000000000000
      000000350E000006004D656D6F363600020035000000E8000000590000001B00
      000001000F0001000000000000000000FFFFFF1F2E0200000000000000000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000080000000100020000000000FFFFFF0000000002000000000000000000B3
      0E000006004D656D6F36370002008E000000E8000000600000001B0000000100
      0F0001000000000000000000FFFFFF1F2E0200000000000100000000000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000000000000000
      080000000100020000000000FFFFFF0000000002000000000000000000460F00
      0005004D656D6F34000200370000004B01000014010000120000000300000001
      000000000000000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE4
      3A5B444154455D205B54494D455D00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000000000000100020000000000FF
      FFFF0000000002000000000000000000CE0F000005004D656D6F360002007B00
      000040000000E5000000120000000100020001000000000000000000FFFFFF1F
      2E02000000000001000B005B53484F505F4E414D455D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF00000000020000000000000000005510000006004D65
      6D6F313700020035000000400000004600000012000000010000000100000000
      0000000000FFFFFF1F2E02000000000001000900C3C5B5EAC3FBB3C63A000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000090000008600020000000000FFFFFF0000000002000000000000000000E9
      10000006004D656D6F3130000200FA01000012010000B50000001C0000000100
      000001000000000000000000FFFFFF1F2E02000000000001001600C5CCB5E3C8
      CB3A5B43484B5F555345525F544558545D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000002000000000008000000860002000000
      0000FFFFFF00000000020000000000000000006C11000005004D656D6F390002
      00230300005C000000500000002A00000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000600C5CCBFF7CAFD00000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000F011000006004D656D6F
      3131000200D30200005C000000500000002A00000001000F0001000000000000
      000000FFFFFF1F2E02000000000001000600C5CCD3AFCAFD00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      008600020000000000FFFFFF0000000002000000000000000000741200000600
      4D656D6F3132000200710200005C000000620000002A00000001000F00010000
      00000000000000FFFFFF1F2E02000000000001000600C5CCB5E3CAFD00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000EF12
      000005004D656D6F3300020073030000B60000008C0000001B00000001000F00
      01000000000000000000FFFFFF1F2E020000000000000000000000FFFF000000
      00000200000001000000000400CBCECCE5000A0000000200000000000A000000
      8600020000000000FFFFFF00000000020000000000000000007913000006004D
      656D6F31340002000F020000B6000000620000001B00000001000F0001000000
      000000000000FFFFFF1F2E02000000000001000C005B52434B5F414D4F554E54
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      0000000414000006004D656D6F313500020023030000B6000000500000001B00
      000001000F0001000000000000000000FFFFFF1F2E02000000000001000D005B
      4C4F53535F414D4F554E545D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000090000008600020000000000FFFFFF
      00000000020000000000000000009114000006004D656D6F3136000200D30200
      00B6000000500000001B00000001000F0001000000000000000000FFFFFF1F2E
      02000000000001000F005B50524F4649545F414D4F554E545D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000900
      00008600020000000000FFFFFF00000000020000000000000000001715000006
      004D656D6F313800020071020000B6000000620000001B00000001000F000100
      0000000000000000FFFFFF1F2E020000000000010008005B414D4F554E545D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000090000008600020000000000FFFFFF00000000020000000000000000
      009215000005004D656D6F3500020073030000E80000008C0000001B00000001
      000F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000000000000000A
      0000008600020000000000FFFFFF00000000020000000000000000000E160000
      06004D656D6F31390002000F020000E8000000620000001B00000001000F0001
      000000000000000000FFFFFF1F2E020000000000000000000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000A00000086
      00020000000000FFFFFF00000000020000000000000000008A16000006004D65
      6D6F323200020023030000E8000000500000001B00000001000F000100000000
      0000000000FFFFFF1F2E020000000000000000000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000000000000000A0000008600020000
      000000FFFFFF00000000020000000000000000000617000006004D656D6F3235
      000200D3020000E8000000500000001B00000001000F00010000000000000000
      00FFFFFF1F2E020000000000000000000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000000000000000A0000008600020000000000FF
      FFFF00000000020000000000000000008217000006004D656D6F323600020071
      020000E8000000620000001B00000001000F0001000000000000000000FFFFFF
      1F2E020000000000000000000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000000000000000A0000008600020000000000FFFFFF0000
      00000200000000000000FEFEFF060000000A00205661726961626C6573000000
      000200736C0014006364735F436867426F64792E22534C30303030220002006A
      650014006364735F436867426F64792E224A4530303030220004006B68796800
      000000040079687A68000000000200647A000000000000000000000000FDFF01
      00000000}
  end
end
