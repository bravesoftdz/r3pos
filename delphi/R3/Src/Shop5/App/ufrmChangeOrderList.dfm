inherited frmChangeOrderList: TfrmChangeOrderList
  Left = 282
  Top = 133
  Width = 832
  Height = 572
  Caption = #35843#25972#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 824
    Height = 508
    inherited RzPanel2: TRzPanel
      Width = 814
      Height = 498
      inherited RzPage: TRzPageControl
        Width = 808
        Height = 492
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #35843#25972#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 806
            Height = 465
            inherited RzPanel1: TRzPanel
              Width = 796
              Height = 92
              object RzLabel2: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #19994#21153#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 64
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #27969#27700#21333#21495
              end
              object Label1: TLabel
                Left = 201
                Top = 65
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
                Left = 33
                Top = 44
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #32463' '#25163' '#20154
              end
              object Label40: TLabel
                Left = 33
                Top = 24
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 0
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 0
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndCHANGE_ID: TcxTextEdit
                Left = 89
                Top = 60
                Width = 104
                Height = 20
                TabOrder = 3
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object btnOk: TRzBitBtn
                Left = 480
                Top = 50
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
                TabOrder = 5
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSTATUS: TcxRadioGroup
                Left = 336
                Top = -5
                Width = 129
                Height = 83
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
              object fndDUTY_USER: TzrComboBoxList
                Left = 89
                Top = 40
                Width = 104
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 2
                InGrid = False
                KeyValue = Null
                FilterFields = 'ACCOUNT;USER_NAME;USER_SPELL'
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
                Top = 20
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
                DropWidth = 185
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
              Top = 97
              Width = 796
              Height = 363
              FrozenCols = 1
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
              OnCellClick = DBGridEh1CellClick
              OnDblClick = DBGridEh1DblClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 28
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'CHANGE_DATE'
                  Footers = <>
                  Title.Caption = #19994#21153#26085#26399
                  Width = 72
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #21333#21495
                  Width = 105
                end
                item
                  EditButtons = <>
                  FieldName = 'DEPT_NAME'
                  Footers = <>
                  Title.Caption = #37096#38376
                  Width = 101
                end
                item
                  EditButtons = <>
                  FieldName = 'SHOP_ID'
                  Footers = <>
                  Title.Caption = #38376#24215#21517#31216
                  Width = 102
                end
                item
                  EditButtons = <>
                  FieldName = 'DUTY_USER_TEXT'
                  Footers = <>
                  Title.Caption = #32463#25163#20154
                  Width = 71
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #25968#37327
                  Width = 69
                end
                item
                  EditButtons = <>
                  FieldName = 'AMONEY'
                  Footers = <>
                  Title.Caption = #36827#36135#25104#26412
                  Width = 86
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 198
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#20154
                  Width = 61
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 137
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 824
    inherited Image3: TImage
      Left = 581
      Width = 0
    end
    inherited Image14: TImage
      Left = 804
    end
    inherited Image1: TImage
      Left = 581
      Width = 223
    end
    inherited rzPanel5: TPanel
      Left = 581
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
    Left = 296
    Top = 296
  end
  inherited actList: TActionList
    Left = 328
    Top = 296
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfChangeOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfChangeOrderGetValue
    OnUserFunction = frfChangeOrderUserFunction
    Left = 488
    Top = 201
    ReportForm = {
      18000000311D0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00A0000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      500100000700B7D6D7E9CDB7310002010000000018000000F602000073000000
      3200100001000000000000000000FFFFFF1F000000001300494E5428285B5345
      514E4F5D2D31292F31352900000000000000FFFF000000000002000000010000
      000000000001000000C8000000140000000100000000000002003A0200000700
      B7D6D7E9BDC5310002010000000011010000F60200004A000000300011000100
      0000000000000000FFFFFF1F0000000000000000000007000500626567696E0D
      1F002020696620436F756E74284D61737465724461746131293C313420746865
      6E0D07002020626567696E0D260020202020666F7220693A3D436F756E74284D
      617374657244617461312920746F20313320646F0D15002020202053686F7742
      616E64284368696C6431293B0D06002020656E643B0D0300656E6400FFFF0000
      00000002000000010000000000000001000000C8000000140000000100000000
      00000200A002000006006368696C643100020100000000DC000000F602000013
      0000003000150001000000000000000000FFFFFF1F0000000000000000000000
      0000FFFF000000000002000000010000000000000001000000C8000000140000
      000100000000000000006003000006004D656D6F3230000200F9000000A00000
      00D40000001300000001000F0001000000000000000000FFFFFF1F2E02000000
      0000010042005B474F44535F4E414D455D205B50524F50455254595F30315F54
      4558545D5B50524F50455254595F30325F544558545D205B49535F5052455345
      4E545F544558545D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000080000008600020000000000FFFFFF00000000
      02000000000000000000EB03000006004D656D6F343000020077000000370000
      0068000000120000000300000001000000000000000000FFFFFF1F2E02000000
      000001000D005B4348414E47455F444154455D00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000000000000000800000086000200
      00000000FFFFFF00000000020000000000000000007404000006004D656D6F32
      33000200CD010000A0000000240000001300000001000F000100000000000000
      0000FFFFFF1F2E02000000000001000B005B554E49545F4E414D455D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000FC04
      000006004D656D6F35380002003B020000370000007E00000012000000030000
      0001000000000000000000FFFFFF1F2E02000000000001000A005B474C494445
      5F4E4F5D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000000000008600020000000000FFFFFF0000000002000000
      0000000000009805000005004D656D6F33000200F1010000A000000037000000
      1300000001000F0001000000000000000000FFFFFF1F2E02000000000001001F
      005B666F726D6174466C6F6174282723302E2323272C5B414D4F554E545D295D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000090000008600020000000000FFFFFF000000000200000000000000
      00002E06000005004D656D6F32000200340000001D0000008502000018000000
      0300000001000000000000000500FFFFFF1F2E020000000000010019005BC6F3
      D2B5C3FBB3C65D5B4348414E47455F4E414D455DB5A500000000FFFF00000000
      000200000001000000000400CBCECCE500100000000200000000000A00000086
      00020000000000FFFFFF0000000002000000000000000000B406000005004D65
      6D6F35000200DF00000037000000460000001200000003000000010000000000
      00000000FFFFFF1F2E02000000000001000900B2D6BFE2C3C5B5EA3A00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      00080000008600020000000000FFFFFF00000000020000000000000000004407
      000006004D656D6F313300020031000000370000004600000012000000030000
      0001000000000000000000FFFFFF1F2E020000000000010012005B4348414E47
      455F4E414D455DC8D5C6DA3A00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000020000000000080000008600020000000000FFFFFF
      0000000002000000000000000000CD07000006004D656D6F3331000200250100
      0037000000D0000000120000000300000001000000000000000000FFFFFF1F2E
      02000000000001000B005B53484F505F4E414D455D00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000080000008600
      020000000000FFFFFF00000000020000000000000000005D08000006004D656D
      6F3332000200F501000037000000460000001200000003000000010000000000
      00000000FFFFFF1F2E020000000000010012005B4348414E47455F4E414D455D
      B5A5BAC53A00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000080000008600020000000000FFFFFF00000000020000
      00000000000000E308000006004D656D6F3336000200F900000075000000D400
      00001600000003000F0001000000000000000000FFFFFF1F2E02000000000001
      000800C9CCC6B7C3FBB3C600000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF00
      000000020000000000000000006509000006004D656D6F3337000200F1010000
      75000000370000001600000003000F0001000000000000000000FFFFFF1F2E02
      000000000001000400CAFDC1BF00000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000200000000000A0000008600020000000000FFFF
      FF0000000002000000000000000000E709000006004D656D6F3338000200CD01
      000075000000240000001600000003000F0001000000000000000000FFFFFF1F
      2E02000000000001000400B5A5CEBB00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000008600020000000000
      FFFFFF00000000020000000000000000007B0A000006004D656D6F3432000200
      58010000290100008E000000120000000100000001000000000000000000FFFF
      FF1F2E02000000000001001600B7A2BBF53A5B4C4F4355535F555345525F5445
      58545D00000000010000000000000200000001000000000400CBCECCE5000A00
      00000200FFFFFF1F080000008600020000000000FFFFFF000000000200000000
      00000000000E0B000006004D656D6F3434000200D1000000290100007C000000
      120000000100000001000000000000000000FFFFFF1F2E020000000000010015
      00C9F3BACBA3BA5B43484B5F555345525F544558545D00000000010000000000
      000200000001000000000400CBCECCE5000A0000000200FFFFFF1F0800000086
      00020000000000FFFFFF0000000002000000000000000000A20B000006004D65
      6D6F343100020033000000290100008100000012000000010000000100000000
      0000000000FFFFFF1F2E02000000000001001600D6C6B5A5A3BA5B435245415F
      555345525F544558545D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000080000008600020000000000FFFFFF0000
      000002000000000000000000250C000006004D656D6F34390002003300000011
      010000280000001300000003000F0001000000000000000000FFFFFF1F2E0200
      0000000001000500BACFBCC63A00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000020000000000080000008600020000000000FFFF
      FF0000000002000000000000000000A30C000006004D656D6F35310002005B00
      000011010000650100001300000001000F0001000000000000000000FFFFFF1F
      2E0200000000000100000000000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000008600020000000000FFFFFF00
      000000020000000000000000002C0D000006004D656D6F353200020061010000
      4B00000094000000130000000300000001000000000000000000FFFFFF1F2E02
      000000000001000B005B54454C4550484F4E455D00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000008000000860002
      0000000000FFFFFF0000000002000000000000000000B30D000006004D656D6F
      35330002001B0100004B00000046000000120000000300000001000000000000
      000000FFFFFF1F2E02000000000001000900C1AACFB5B5E7BBB03A00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000020000000000
      0A0000008600020000000000FFFFFF0000000002000000000000000000380E00
      0006004D656D6F353400020033000000A00000001B0000001300000001000F00
      01000000000000000000FFFFFF1F2E020000000000010007005B5345514E4F5D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      0000B70E000006004D656D6F353500020033000000750000001B000000160000
      0003000F0001000000000000000000FFFFFF1F2E020000000000010001004100
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00380F000005004D656D6F370002004E00000075000000430000001600000003
      000F0001000000000000000000FFFFFF1F2E02000000000001000400BBF5BAC5
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      00000000000A0000000100020000000000FFFFFF000000000200000000000000
      0000C00F000005004D656D6F380002004E000000A00000004300000013000000
      01000F0001000000000000000000FFFFFF1F2E02000000000001000B005B474F
      44535F434F44455D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000080000000100020000000000FFFFFF00000000
      020000000000000000005610000006004D656D6F323400020062020000180000
      007A000000130000000300000001000000000000000000FFFFFF1F2E02000000
      000001001800B5DA5B50414745235D2F5B544F54414C50414745535DD2B30000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000090000008600020000000000FFFFFF0000000002000000000000000000
      D710000005004D656D6F31000200910000007500000068000000160000000300
      0F0001000000000000000000FFFFFF1F2E02000000000001000400CCF5C2EB00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000000100020000000000FFFFFF00000000020000000000000000
      005D11000005004D656D6F3400020091000000A0000000680000001300000001
      000F0001000000000000000000FFFFFF1F2E020000000000010009005B424152
      434F44455D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000080000000100020000000000FFFFFF00000000020000
      00000000000000D811000005004D656D6F36000200F9000000DC000000D40000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000000
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000080000008600020000000000FFFFFF000000000200000000000000
      00005512000005004D656D6F39000200CD010000DC0000002400000013000000
      03000F0001000000000000000000FFFFFF1F2E02000000000001000000000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      00000A0000008600020000000000FFFFFF0000000002000000000000000000D1
      12000006004D656D6F3130000200F1010000DC00000037000000130000000300
      0F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000900
      00008600020000000000FFFFFF00000000020000000000000000004D13000006
      004D656D6F313100020033000000DC0000001B0000001300000003000F000100
      0000000000000000FFFFFF1F2E020000000000000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000000000000000A0000008600
      020000000000FFFFFF0000000002000000000000000000C913000006004D656D
      6F31320002004E000000DC000000430000001300000003000F00010000000000
      00000000FFFFFF1F2E020000000000000000000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000010002000000
      0000FFFFFF00000000020000000000000000004714000006004D656D6F313400
      020091000000DC000000680000001300000003000F0001000000000000000000
      FFFFFF1F2E0200000000000100000000000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000080000000100020000000000
      FFFFFF0000000002000000000000000000D414000006004D656D6F3135000200
      28020000A0000000910000001300000001000F0001000000000000000000FFFF
      FF1F2E02000000000001000F005B52454D41524B5F44455441494C5D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00090000008600020000000000FFFFFF00000000020000000000000000005815
      000006004D656D6F31360002002802000075000000910000001600000003000F
      0001000000000000000000FFFFFF1F2E02000000000001000600B1B82020D7A2
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      0000D415000006004D656D6F313700020028020000DC00000091000000130000
      0003000F0001000000000000000000FFFFFF1F2E020000000000000000000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00090000008600020000000000FFFFFF00000000020000000000000000006A16
      000006004D656D6F323500020032000000460100002401000012000000030000
      0001000000000000000000FFFFFF1F2E02000000000001001700B4F2D3A1CAB1
      BCE4A3BA5B444154455D205B54494D455D00000000FFFF000000000002000000
      01000000000500417269616C000A000000000000000000000000000100020000
      000000FFFFFF00000000020000000000000000002E17000006004D656D6F3236
      000200C001000011010000F80000001300000001000F00010000000000000000
      00FFFFFF1F2E02000000000001004600CAFDC1BFA3BA5B666F726D6174466C6F
      6174282723302E2323272C5B4348414E47455F414D545D295D20B1BED2B3D0A1
      BCC6A3BAA3A43A5B73756D285B414D4F554E545D295D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000900000086
      00020000000000FFFFFF0000000002000000000000000000E017000006004D65
      6D6F3237000200C002000070000000190000001A010000030000000100000000
      0000000000FFFFFF1F2E020000000000070000000D00000D0B00B0D7C1AAB4E6
      B8F92020200D00000D0C00BAECC1AAB2D6BFE2C3C5B5EA0D03002020200D0800
      BBC6C1AAB2C6CEF100000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000000000000100020000000000FFFFFF00000000
      020000000000000000006918000006004D656D6F3238000200770000004B0000
      00A4000000120000000300000001000000000000000000FFFFFF1F2E02000000
      000001000B005B444550545F4E414D455D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF0000000002000000000000000000F918000006004D656D6F323900
      0200320000004B00000045000000120000000300000001000000000000000000
      FFFFFF1F2E020000000000010012005B4348414E47455F4E414D455DB2BFC3C5
      3A00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      020000000000080000008600020000000000FFFFFF0000000002000000000000
      0000008E19000006004D656D6F3138000200F301000029010000910000001200
      00000100000001000000000000000000FFFFFF1F2E02000000000001001700C1
      ECD3C3C8CB3A5B445554595F555345525F544558545D00000000010000000000
      000200000001000000000400CBCECCE5000A0000000200FFFFFF1F0800000086
      00020000000000FFFFFF0000000002000000000000000000141A000006004D65
      6D6F3139000200F101000060000000C800000013000000030000000100000000
      0000000000FFFFFF1F2E020000000000010008005B52454D41524B5D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000008600020000000000FFFFFF00000000020000000000000000009B1A
      000006004D656D6F3231000200A9010000600000004600000012000000030000
      0001000000000000000000FFFFFF1F2E02000000000001000900B1B8A1A1A1A1
      D7A23A00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      00000200000000000A0000008600020000000000FFFFFF000000000200000000
      0000000000241B000006004D656D6F3232000200770000006000000028010000
      120000000300000001000000000000000000FFFFFF1F2E02000000000001000B
      005B53454E445F414444525D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000080000008600020000000000FFFFFF
      0000000002000000000000000000AB1B000006004D656D6F3330000200320000
      006000000045000000120000000300000001000000000000000000FFFFFF1F2E
      02000000000001000900CAD5BBF5B5D8D6B73A00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000086000200
      00000000FFFFFF0000000002000000000000000000321C000006004D656D6F33
      33000200400200004B0000007800000013000000030000000100000000000000
      0000FFFFFF1F2E020000000000010009005B4C494E4B4D414E5D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000008
      0000008600020000000000FFFFFF0000000002000000000000000000B71C0000
      06004D656D6F3334000200020200004B0000003E000000130000000300000001
      000000000000000000FFFFFF1F2E02000000000001000700C1AACFB5C8CB3A00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000008600020000000000FFFFFF000000000200000000000000FE
      FEFF060000000A00205661726961626C6573000000000200736C001400636473
      5F436867426F64792E22534C30303030220002006A650014006364735F436867
      426F64792E224A4530303030220004006B68796800000000040079687A680000
      00000200647A000000000000000000000000FDFF0100000000}
  end
end
