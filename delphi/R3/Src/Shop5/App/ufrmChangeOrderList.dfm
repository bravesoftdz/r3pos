inherited frmChangeOrderList: TfrmChangeOrderList
  Left = 193
  Top = 101
  Width = 832
  Height = 619
  Caption = #35843#25972#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 816
    Height = 545
    inherited RzPanel2: TRzPanel
      Width = 806
      Height = 535
      inherited RzPage: TRzPageControl
        Width = 800
        Height = 529
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #35843#25972#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 798
            Height = 502
            inherited RzPanel1: TRzPanel
              Width = 788
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
                Caption = #36131' '#20219' '#20154
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
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 0
                Width = 109
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndCHANGE_ID: TcxTextEdit
                Left = 89
                Top = 60
                Width = 104
                Height = 20
                TabOrder = 3
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
                Width = 144
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
                Buttons = [zbNew, zbClear]
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
                ShowButton = False
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            inherited DBGridEh1: TDBGridEh
              Top = 97
              Width = 788
              Height = 400
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
                  FieldName = 'DUTY_USER_TEXT'
                  Footers = <>
                  Title.Caption = #36127#36131#20154
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
    Width = 816
    inherited Image1: TImage
      Left = 585
      Width = 211
    end
    inherited Image3: TImage
      Left = 585
      Width = 211
    end
    inherited Image14: TImage
      Left = 796
    end
    inherited rzPanel5: TPanel
      Left = 585
    end
    inherited CoolBar1: TCoolBar
      Width = 565
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 565
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 565
        object ToolButton11: TToolButton
          Left = 522
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
      18000000CA1C0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00A0000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      500100000700B7D6D7E9CDB7310002010000000018000000F602000064000000
      3200100001000000000000000000FFFFFF1F000000001300494E5428285B5345
      514E4F5D2D31292F31362900000000000000FFFF000000000002000000010000
      000000000001000000C8000000140000000100000000000002003A0200000700
      B7D6D7E9BDC5310002010000000011010000F60200004A000000300011000100
      0000000000000000FFFFFF1F0000000000000000000007000500626567696E0D
      1F002020696620436F756E74284D61737465724461746131293C313520746865
      6E0D07002020626567696E0D260020202020666F7220693A3D436F756E74284D
      617374657244617461312920746F20313420646F0D15002020202053686F7742
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
      02000000000000000000EB03000006004D656D6F34300002007D0000003B0000
      005C000000120000000300000001000000000000000000FFFFFF1F2E02000000
      000001000D005B4348414E47455F444154455D00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000000000000000800000086000200
      00000000FFFFFF00000000020000000000000000007404000006004D656D6F32
      33000200CD010000A0000000240000001300000001000F000100000000000000
      0000FFFFFF1F2E02000000000001000B005B554E49545F4E414D455D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000FC04
      000006004D656D6F3538000200410200003B0000007800000012000000030000
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
      00020000000000FFFFFF0000000002000000000000000000B506000005004D65
      6D6F35000200DE0000003B000000460000001200000003000000010000000000
      00000000FFFFFF1F2E02000000000001000A00C3C5B5EAC3FBB3C6A3BA000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000080000008600020000000000FFFFFF000000000200000000000000000046
      07000006004D656D6F3133000200310000003B0000004C000000120000000300
      000001000000000000000000FFFFFF1F2E020000000000010013005B4348414E
      47455F4E414D455DC8D5C6DAA3BA00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000020000000000080000008600020000000000FF
      FFFF0000000002000000000000000000CF07000006004D656D6F333100020026
      0100003B000000CF000000120000000300000001000000000000000000FFFFFF
      1F2E02000000000001000B005B53484F505F4E414D455D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      8600020000000000FFFFFF00000000020000000000000000006008000006004D
      656D6F3332000200FA0100003B00000046000000120000000300000001000000
      000000000000FFFFFF1F2E020000000000010013005B4348414E47455F4E414D
      455DB5A5BAC5A3BA00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      02000000000000000000E608000006004D656D6F3336000200F9000000660000
      00D40000001600000003000F0001000000000000000000FFFFFF1F2E02000000
      000001000800C9CCC6B7C3FBB3C600000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000200000000000A0000008600020000000000FF
      FFFF00000000020000000000000000006809000006004D656D6F3337000200F1
      01000066000000370000001600000003000F0001000000000000000000FFFFFF
      1F2E02000000000001000400CAFDC1BF00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000A00000086000200000000
      00FFFFFF0000000002000000000000000000EA09000006004D656D6F33380002
      00CD01000066000000240000001600000003000F0001000000000000000000FF
      FFFF1F2E02000000000001000400B5A5CEBB00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF0000000002000000000000000000800A000006004D656D6F3432
      0002004301000029010000860000001200000003000000010000000000000000
      00FFFFFF1F2E02000000000001001800B8BAD4F0C8CBA3BA5B445554595F5553
      45525F544558545D00000000010000000000000200000001000000000400CBCE
      CCE5000A0000000200FFFFFF1F080000008600020000000000FFFFFF00000000
      02000000000000000000150B000006004D656D6F3434000200BC000000290100
      007C000000120000000300000001000000000000000000FFFFFF1F2E02000000
      000001001700C9F3BACBC8CBA3BA5B43484B5F555345525F544558545D000000
      00010000000000000200000001000000000400CBCECCE5000A0000000200FFFF
      FF1F080000008600020000000000FFFFFF0000000002000000000000000000AB
      0B000006004D656D6F3431000200330000002901000081000000120000000300
      000001000000000000000000FFFFFF1F2E02000000000001001800D6C6B5A5C8
      CBA3BA5B435245415F555345525F544558545D00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000086000200
      00000000FFFFFF0000000002000000000000000000310C000006004D656D6F34
      3900020033000000110100005E0000001300000003000F000100000000000000
      0000FFFFFF1F2E02000000000001000800BACF20202020BCC600000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000200000000000A00
      00008600020000000000FFFFFF0000000002000000000000000000400D000006
      004D656D6F35310002009100000011010000600100001300000003000F000100
      0000000000000000FFFFFF1F2E02000000000001009100B3C9B1BEA3BA5B666F
      726D6174466C6F6174282723302E3030272C5B4348414E47455F4D4E595D295D
      2020CFFACADBA3BA5B666F726D6174466C6F6174282723302E3030272C5B544F
      54414C5F52544C5F4D4E595D295D2020B2EEB6EE3A5B666F726D6174466C6F61
      74282723302E3030272C5B544F54414C5F52544C5F4D4E595D2D5B4348414E47
      455F4D4E595D295D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000080000008600020000000000FFFFFF00000000
      02000000000000000000C60D000006004D656D6F353200020059010000500000
      0060010000130000000300020001000000000000000000FFFFFF1F2E02000000
      0000010008005B52454D41524B5D00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000080000008600020000000000FF
      FFFF00000000020000000000000000004A0E000006004D656D6F353300020027
      0100005000000032000000130000000300000001000000000000000000FFFFFF
      1F2E02000000000001000600B1B8D7A2A3BA00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF0000000002000000000000000000CF0E000006004D656D6F3534
      00020033000000A00000001B0000001300000001000F00010000000000000000
      00FFFFFF1F2E020000000000010007005B5345514E4F5D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A0000000000000000000A000000
      8600020000000000FFFFFF00000000020000000000000000004E0F000006004D
      656D6F353500020033000000660000001B0000001600000003000F0001000000
      000000000000FFFFFF1F2E020000000000010001004100000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000200000000000A00000086
      00020000000000FFFFFF0000000002000000000000000000CF0F000005004D65
      6D6F370002004E00000066000000430000001600000003000F00010000000000
      00000000FFFFFF1F2E02000000000001000400BBF5BAC500000000FFFF000000
      00000200000001000000000400CBCECCE5000A0000000200000000000A000000
      0100020000000000FFFFFF00000000020000000000000000005710000005004D
      656D6F380002004E000000A0000000430000001300000001000F000100000000
      0000000000FFFFFF1F2E02000000000001000B005B474F44535F434F44455D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000080000000100020000000000FFFFFF00000000020000000000000000
      00ED10000006004D656D6F323400020062020000180000007A00000013000000
      0300000001000000000000000000FFFFFF1F2E02000000000001001800B5DA5B
      50414745235D2F5B544F54414C50414745535DD2B300000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000090000008600
      020000000000FFFFFF00000000020000000000000000006E11000005004D656D
      6F310002009100000066000000680000001600000003000F0001000000000000
      000000FFFFFF1F2E02000000000001000400CCF5C2EB00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000200000000000A00000001
      00020000000000FFFFFF0000000002000000000000000000F411000005004D65
      6D6F3400020091000000A0000000680000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000010009005B424152434F44455D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000000100020000000000FFFFFF00000000020000000000000000006F12
      000005004D656D6F36000200F9000000DC000000D40000001300000001000F00
      01000000000000000000FFFFFF1F2E020000000000000000000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      8600020000000000FFFFFF0000000002000000000000000000EC12000005004D
      656D6F39000200CD010000DC000000240000001300000003000F000100000000
      0000000000FFFFFF1F2E0200000000000100000000000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000000000000000A000000860002
      0000000000FFFFFF00000000020000000000000000006813000006004D656D6F
      3130000200F1010000DC000000370000001300000003000F0001000000000000
      000000FFFFFF1F2E020000000000000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000900000086000200000000
      00FFFFFF0000000002000000000000000000E413000006004D656D6F31310002
      0033000000DC0000001B0000001300000003000F0001000000000000000000FF
      FFFF1F2E020000000000000000000000FFFF0000000000020000000100000000
      0400CBCECCE5000A0000000000000000000A0000008600020000000000FFFFFF
      00000000020000000000000000006014000006004D656D6F31320002004E0000
      00DC000000430000001300000003000F0001000000000000000000FFFFFF1F2E
      020000000000000000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000080000000100020000000000FFFFFF00000000
      02000000000000000000DE14000006004D656D6F313400020091000000DC0000
      00680000001300000003000F0001000000000000000000FFFFFF1F2E02000000
      00000100000000000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000000100020000000000FFFFFF000000000200
      00000000000000008D15000006004D656D6F313500020028020000A000000047
      0000001300000001000F0001000000000000000000FFFFFF1F2E020000000000
      010031005B666F726D6174466C6F6174282723302E3030272C5B434F53545F50
      524943455D2A5B43414C435F414D4F554E545D295D00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000090000008600
      020000000000FFFFFF00000000020000000000000000001316000006004D656D
      6F31360002002802000066000000470000001600000003000F00010000000000
      00000000FFFFFF1F2E02000000000001000800BDF8BBF5B3C9B1BE00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000020000000000
      0A0000008600020000000000FFFFFF00000000020000000000000000008F1600
      0006004D656D6F313700020028020000DC000000470000001300000003000F00
      01000000000000000000FFFFFF1F2E020000000000000000000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000009000000
      8600020000000000FFFFFF00000000020000000000000000003017000006004D
      656D6F31380002006F020000A00000004B0000001300000001000F0001000000
      000000000000FFFFFF1F2E020000000000010023005B666F726D6174466C6F61
      74282723302E3030272C5B43414C435F4D4F4E45595D295D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF0000000002000000000000000000B41700000600
      4D656D6F31390002006F020000660000004B0000001600000003000F00010000
      00000000000000FFFFFF1F2E02000000000001000600CFFACADBB6EE00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      000A0000008600020000000000FFFFFF00000000020000000000000000003018
      000006004D656D6F32310002006F020000DC0000004B0000001300000003000F
      0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF0000000002000000000000000000B41800000600
      4D656D6F3232000200FA0100003D0100002A0000001200000003000000010000
      00000000000000FFFFFF1F2E02000000000001000600B2C6CEF1A3BA00000000
      010000000000000200000001000000000400CBCECCE5000A0000000200FFFFFF
      1F080000008600020000000000FFFFFF00000000020000000000000000004A19
      000006004D656D6F323500020032000000460100002401000012000000030000
      0001000000000000000000FFFFFF1F2E02000000000001001700B4F2D3A1CAB1
      BCE4A3BA5B444154455D205B54494D455D00000000FFFF000000000002000000
      01000000000500417269616C000A000000000000000000000000000100020000
      000000FFFFFF0000000002000000000000000000121A000006004D656D6F3236
      000200F101000011010000C90000001300000003000F00010000000000000000
      00FFFFFF1F2E02000000000001004A00CAFDC1BFA3BA5B666F726D6174466C6F
      6174282723302E2323272C5B4348414E47455F414D545D295D20B1BED2B3D0A1
      BCC6A3BAA3A43A5B73756D285B43414C435F4D4F4E45595D295D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000009
      0000008600020000000000FFFFFF0000000002000000000000000000C11A0000
      06004D656D6F3237000200C00200006400000019000000260100000300000001
      000000000000000000FFFFFF1F2E02000000000003000D00B0D7C1AAA3BAB4E6
      B8F92020200D10002020BAECC1AAA3BABFCDBBA7202020200D0E002020BBC6C1
      AAA3BABDE1CBE3202000000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000020000000000000000000100020000000000FFFFFF000000
      00020000000000000000004A1B000006004D656D6F32380002007E0000005000
      0000A4000000120000000300020001000000000000000000FFFFFF1F2E020000
      00000001000B005B444550545F4E414D455D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000080000008600020000
      000000FFFFFF0000000002000000000000000000D21B000006004D656D6F3239
      00020032000000500000004C0000001200000003000000010000000000000000
      00FFFFFF1F2E02000000000001000A00CBF9CAF4B2BFC3C5A3BA00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000002000000000008
      0000008600020000000000FFFFFF0000000002000000000000000000501C0000
      06004D656D6F3330000200260200003D0100008E000000120000000300020001
      000000000000000000FFFFFF1F2E020000000000010000000000000001000000
      0000000200000001000000000400CBCECCE5000A0000000200FFFFFF1F080000
      008600020000000000FFFFFF000000000200000000000000FEFEFF060000000A
      00205661726961626C6573000000000200736C0014006364735F436867426F64
      792E22534C30303030220002006A650014006364735F436867426F64792E224A
      4530303030220004006B68796800000000040079687A68000000000200647A00
      0000000000000000000000FDFF0100000000}
  end
end
