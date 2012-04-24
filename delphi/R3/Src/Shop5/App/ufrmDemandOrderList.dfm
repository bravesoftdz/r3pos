inherited frmDemandOrderList: TfrmDemandOrderList
  Left = 512
  Top = 165
  Width = 836
  Height = 607
  Caption = #38656#27714#22635#25253
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 828
    Height = 543
    inherited RzPanel2: TRzPanel
      Width = 818
      Height = 533
      inherited RzPage: TRzPageControl
        Width = 812
        Height = 527
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38656#35201#22635#25253
          inherited RzPanel3: TRzPanel
            Width = 810
            Height = 500
            inherited RzPanel1: TRzPanel
              Width = 800
              Height = 90
              Caption = '.'
              object RzLabel2: TRzLabel
                Left = 33
                Top = 5
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #30003#35831#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 5
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 67
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #22635#25253#21333#21495
              end
              object Label1: TLabel
                Left = 201
                Top = 69
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
              object Label40: TLabel
                Left = 33
                Top = 26
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object Label3: TLabel
                Left = 33
                Top = 47
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 1
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 1
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object btnOk: TRzBitBtn
                Left = 501
                Top = 58
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
                TabOrder = 4
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndDEMA_ID: TcxTextEdit
                Left = 89
                Top = 64
                Width = 104
                Height = 20
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndSTATUS: TcxRadioGroup
                Left = 344
                Top = -5
                Width = 146
                Height = 90
                ItemIndex = 0
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
                  end>
                TabOrder = 3
                Caption = ''
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 22
                Width = 236
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
              object fndDEPT_ID: TzrComboBoxList
                Left = 89
                Top = 43
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
                FilterFields = 'DEPT_NAME;DEPT_SPELL'
                KeyField = 'DEPT_ID'
                ListField = 'DEPT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'DEPT_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
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
              Top = 95
              Width = 800
              Height = 400
              FrozenCols = 1
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
              OnDblClick = DBGridEh1DblClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 29
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #21333'    '#21495
                  Width = 80
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'DEMA_DATE'
                  Footers = <>
                  Title.Caption = #22635#25253#26085#26399
                  Width = 67
                end
                item
                  EditButtons = <>
                  FieldName = 'DEMA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #30003#35831#20154
                  Width = 60
                end
                item
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'DEMA_AMT'
                  Footers = <>
                  Title.Caption = #38656#27714#37327
                  Width = 60
                end
                item
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'DEMA_MNY'
                  Footers = <>
                  Title.Caption = #38656#27714#37329#39069
                  Width = 70
                end
                item
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'SHIP_AMOUNT'
                  Footers = <>
                  Title.Caption = #21457#36135#37327
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 130
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#21592
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 119
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23457#26680#20154
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                  Width = 90
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 828
    inherited Image3: TImage
      Left = 581
      Width = 0
    end
    inherited Image14: TImage
      Left = 808
    end
    inherited Image1: TImage
      Left = 581
      Width = 227
    end
    inherited rzPanel5: TPanel
      Left = 581
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#38144#21806#35746#21333
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
        object ToolButton17: TToolButton
          Left = 518
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 296
    Top = 216
  end
  inherited actList: TActionList
    Left = 328
    Top = 216
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    object actReport: TAction
      Caption = #25253#34920
    end
    object actRecv: TAction
      Caption = #25910#27454
      ImageIndex = 28
    end
  end
  inherited dsList: TDataSource
    Left = 390
    Top = 216
  end
  inherited ppmReport: TPopupMenu
    AutoHotkeys = maManual
    inherited mnmFormer0: TMenuItem
      Caption = #40664#35748#34920#26679
    end
    inherited mnmFormer1: TMenuItem
      Caption = #33258#23450#20041#19968
    end
    inherited mnmFormer2: TMenuItem
      Caption = #33258#23450#20041#20108
    end
    inherited mnmFormer3: TMenuItem
      Caption = #33258#23450#20041#19977
    end
    inherited mnmFormer4: TMenuItem
      Caption = #33258#23450#20041#22235
    end
    inherited mnmFormer5: TMenuItem
      Caption = #33258#23450#20041#20116
    end
  end
  inherited cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    AfterScroll = cdsListAfterScroll
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 358
    Top = 216
  end
  object frfDemandOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfDemandOrderGetValue
    OnUserFunction = frfDemandOrderUserFunction
    Left = 488
    Top = 201
    ReportForm = {
      18000000B71B0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00A0000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      500100000700B7D6D7E9CDB7310002010000000018000000F602000064000000
      3200100001000000000000000000FFFFFF1F000000001300494E5428285B5345
      514E4F5D2D31292F31352900000000000000FFFF000000000002000000010000
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
      000100000000000000004F03000006004D656D6F3230000200F9000000A00000
      00D40000001300000001000F0001000000000000000000FFFFFF1F2E02000000
      0000010031005B474F44535F4E414D455D205B50524F50455254595F30315F54
      4558545D5B50524F50455254595F30325F544558545D2000000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      8600020000000000FFFFFF0000000002000000000000000000D803000006004D
      656D6F34300002007D0000003B0000005C000000120000000300020001000000
      000000000000FFFFFF1F2E02000000000001000B005B44454D415F444154455D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000080000008600020000000000FFFFFF000000000200000000000000
      00006104000006004D656D6F3233000200CD010000A000000024000000130000
      0001000F0001000000000000000000FFFFFF1F2E02000000000001000B005B55
      4E49545F4E414D455D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000000000000000A0000008600020000000000FFFFFF000000
      0002000000000000000000E904000006004D656D6F35380002003C0200003B00
      00007D000000120000000300020001000000000000000000FFFFFF1F2E020000
      00000001000A005B474C4944455F4E4F5D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000000000000860002000000
      0000FFFFFF00000000020000000000000000008505000005004D656D6F330002
      00F1010000A0000000370000001300000001000F0001000000000000000000FF
      FFFF1F2E02000000000001001F005B666F726D6174466C6F6174282723302E23
      23272C5B414D4F554E545D295D00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000090000008600020000000000FFFF
      FF00000000020000000000000000001B06000005004D656D6F32000200340000
      001D00000085020000180000000300000001000000000000000500FFFFFF1F2E
      020000000000010019005BC6F3D2B5C3FBB3C65D5B44454D414E445F4E414D45
      5DB5A500000000FFFF00000000000200000001000000000400CBCECCE5001000
      00000200000000000A0000008600020000000000FFFFFF000000000200000000
      0000000000A206000005004D656D6F35000200DE0000003B0000004600000012
      0000000300000001000000000000000000FFFFFF1F2E02000000000001000A00
      B2D6BFE2C3C5B5EAA3BA00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000080000008600020000000000FFFFFF0000
      0000020000000000000000002A07000006004D656D6F3133000200310000003B
      0000004C000000120000000300000001000000000000000000FFFFFF1F2E0200
      0000000001000A00C9EAC7EBC8D5C6DAA3BA00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000008600020000
      000000FFFFFF0000000002000000000000000000B307000006004D656D6F3331
      000200260100003B000000CF0000001200000003000200010000000000000000
      00FFFFFF1F2E02000000000001000B005B53484F505F4E414D455D00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000000000000000
      080000008600020000000000FFFFFF00000000020000000000000000003B0800
      0006004D656D6F3332000200F50100003B000000460000001200000003000000
      01000000000000000000FFFFFF1F2E02000000000001000A00C9EAC7EBB5A5BA
      C5A3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      0000000000C108000006004D656D6F3336000200F900000066000000D4000000
      1600000003000F0001000000000000000000FFFFFF1F2E020000000000010008
      00C9CCC6B7C3FBB3C600000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      00020000000000000000004309000006004D656D6F3337000200F10100006600
      0000370000001600000003000F0001000000000000000000FFFFFF1F2E020000
      00000001000400CAFDC1BF00000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000C509000006004D656D6F3338000200CD010000
      66000000240000001600000003000F0001000000000000000000FFFFFF1F2E02
      000000000001000400B5A5CEBB00000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000200000000000A0000008600020000000000FFFF
      FF00000000020000000000000000005A0A000006004D656D6F3434000200BC00
      0000290100007C000000120000000300000001000000000000000000FFFFFF1F
      2E02000000000001001700C9F3BACBC8CBA3BA5B43484B5F555345525F544558
      545D00000000010000000000000200000001000000000400CBCECCE5000A0000
      00020000000000080000008600020000000000FFFFFF00000000020000000000
      00000000F00A000006004D656D6F343100020033000000290100008100000012
      0000000300000001000000000000000000FFFFFF1F2E02000000000001001800
      D6C6B5A5C8CBA3BA5B435245415F555345525F544558545D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000020000000000080000
      008600020000000000FFFFFF0000000002000000000000000000760B00000600
      4D656D6F343900020033000000110100005E0000001300000003000F00010000
      00000000000000FFFFFF1F2E02000000000001000800BACF20202020BCC60000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000020000
      0000000A0000008600020000000000FFFFFF0000000002000000000000000000
      F40B000006004D656D6F35310002009100000011010000600100001300000003
      000F0001000000000000000000FFFFFF1F2E0200000000000100000000000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000008600020000000000FFFFFF00000000020000000000000000007A0C
      000006004D656D6F353200020059010000500000006001000013000000030002
      0001000000000000000000FFFFFF1F2E020000000000010008005B52454D4152
      4B5D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000008600020000000000FFFFFF00000000020000000000
      00000000FE0C000006004D656D6F353300020027010000500000003200000013
      0000000300000001000000000000000000FFFFFF1F2E02000000000001000600
      B1B8D7A2A3BA00000000FFFF00000000000200000001000000000400CBCECCE5
      000A0000000200000000000A0000008600020000000000FFFFFF000000000200
      0000000000000000830D000006004D656D6F353400020033000000A00000001B
      0000001300000001000F0001000000000000000000FFFFFF1F2E020000000000
      010007005B5345514E4F5D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000000000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000020E000006004D656D6F353500020033000000
      660000001B0000001600000003000F0001000000000000000000FFFFFF1F2E02
      0000000000010001004100000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF0000
      000002000000000000000000830E000005004D656D6F370002004E0000006600
      0000430000001600000003000F0001000000000000000000FFFFFF1F2E020000
      00000001000400BBF5BAC500000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF00
      000000020000000000000000000B0F000005004D656D6F380002004E000000A0
      000000430000001300000001000F0001000000000000000000FFFFFF1F2E0200
      0000000001000B005B474F44535F434F44455D00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000000000000000800000001000200
      00000000FFFFFF0000000002000000000000000000A10F000006004D656D6F32
      3400020062020000180000007A00000013000000030000000100000000000000
      0000FFFFFF1F2E02000000000001001800B5DA5B50414745235D2F5B544F5441
      4C50414745535DD2B300000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000008600020000000000FFFFFF000000
      00020000000000000000002210000005004D656D6F3100020091000000660000
      00680000001600000003000F0001000000000000000000FFFFFF1F2E02000000
      000001000400CCF5C2EB00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF0000
      000002000000000000000000A810000005004D656D6F3400020091000000A000
      0000680000001300000001000F0001000000000000000000FFFFFF1F2E020000
      000000010009005B424152434F44455D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000800000001000200000000
      00FFFFFF00000000020000000000000000002311000005004D656D6F36000200
      F9000000DC000000D40000001300000001000F0001000000000000000000FFFF
      FF1F2E020000000000000000000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000008600020000000000FFFFFF00
      00000002000000000000000000A011000005004D656D6F39000200CD010000DC
      000000240000001300000003000F0001000000000000000000FFFFFF1F2E0200
      000000000100000000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000000000000000A0000008600020000000000FFFFFF00000000
      020000000000000000001C12000006004D656D6F3130000200F1010000DC0000
      00370000001300000003000F0001000000000000000000FFFFFF1F2E02000000
      0000000000000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000090000008600020000000000FFFFFF0000000002000000
      0000000000009812000006004D656D6F313100020033000000DC0000001B0000
      001300000003000F0001000000000000000000FFFFFF1F2E0200000000000000
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      00001413000006004D656D6F31320002004E000000DC00000043000000130000
      0003000F0001000000000000000000FFFFFF1F2E020000000000000000000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000000100020000000000FFFFFF00000000020000000000000000009213
      000006004D656D6F313400020091000000DC000000680000001300000003000F
      0001000000000000000000FFFFFF1F2E0200000000000100000000000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000008
      0000000100020000000000FFFFFF00000000020000000000000000002F140000
      06004D656D6F313500020028020000A0000000470000001300000001000F0001
      000000000000000000FFFFFF1F2E02000000000001001F005B666F726D617446
      6C6F6174282723302E3030272C5B4150524943455D295D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000009000000
      8600020000000000FFFFFF0000000002000000000000000000B114000006004D
      656D6F31360002002802000066000000470000001600000003000F0001000000
      000000000000FFFFFF1F2E02000000000001000400B5A5BCDB00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000200000000000A00
      00008600020000000000FFFFFF00000000020000000000000000002D15000006
      004D656D6F313700020028020000DC000000470000001300000003000F000100
      0000000000000000FFFFFF1F2E020000000000000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000090000008600
      020000000000FFFFFF0000000002000000000000000000CA15000006004D656D
      6F31380002006F020000A00000004B0000001300000001000F00010000000000
      00000000FFFFFF1F2E02000000000001001F005B666F726D6174466C6F617428
      2723302E3030272C5B414D4F4E45595D295D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000090000008600020000
      000000FFFFFF00000000020000000000000000004C16000006004D656D6F3139
      0002006F020000660000004B0000001600000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000400BDF0B6EE00000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000C816000006004D656D6F
      32310002006F020000DC0000004B0000001300000003000F0001000000000000
      000000FFFFFF1F2E020000000000000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000900000086000200000000
      00FFFFFF00000000020000000000000000004C17000006004D656D6F32320002
      00FA0100003D0100002A000000120000000300000001000000000000000000FF
      FFFF1F2E02000000000001000600B2C6CEF1A3BA000000000100000000000002
      00000001000000000400CBCECCE5000A00000002000000000008000000860002
      0000000000FFFFFF0000000002000000000000000000E217000006004D656D6F
      3235000200320000004601000024010000120000000300000001000000000000
      000000FFFFFF1F2E02000000000001001700B4F2D3A1CAB1BCE4A3BA5B444154
      455D205B54494D455D00000000FFFF0000000000020000000100000000050041
      7269616C000A000000000000000000000000000100020000000000FFFFFF0000
      000002000000000000000000A618000006004D656D6F3236000200F101000011
      010000C90000001300000003000F0001000000000000000000FFFFFF1F2E0200
      0000000001004600CAFDC1BFA3BA5B666F726D6174466C6F6174282723302E23
      23272C5B414D4F554E545D295D20B1BED2B3D0A1BCC6A3BAA3A43A5B73756D28
      5B43414C435F4D4F4E45595D295D00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000090000008600020000000000FF
      FFFF00000000020000000000000000005519000006004D656D6F3237000200C0
      0200006400000019000000260100000300000001000000000000000000FFFFFF
      1F2E02000000000003000D00B0D7C1AAA3BAB4E6B8F92020200D10002020BAEC
      C1AAA3BABFCDBBA7202020200D0E002020BBC6C1AAA3BABDE1CBE32020000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000000000000100020000000000FFFFFF0000000002000000000000000000E3
      19000006004D656D6F32380002007E00000050000000A4000000120000000300
      020001000000000000000000FFFFFF1F2E020000000000010010005B44454D41
      5F555345525F544558545D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000008600020000000000FFFFFF00
      000000020000000000000000006B1A000006004D656D6F323900020032000000
      500000004C000000120000000300000001000000000000000000FFFFFF1F2E02
      000000000001000A00C9EA20C7EB20C8CBA3BA00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000086000200
      00000000FFFFFF0000000002000000000000000000E91A000006004D656D6F33
      30000200260200003D0100008E00000012000000030002000100000000000000
      0000FFFFFF1F2E02000000000001000000000000000100000000000002000000
      01000000000400CBCECCE5000A0000000200FFFFFF1F08000000860002000000
      0000FFFFFF00000000020000000000000001003D1B000004006C6F676F000200
      2400000019000000780000001E0000000500000001000000000000000000FFFF
      FF1F2E020000000000000000000000FFFF000000000002000000010000000000
      003D1B0000FEFEFF060000000A00205661726961626C6573000000000200736C
      0014006364735F436867426F64792E22534C30303030220002006A6500140063
      64735F436867426F64792E224A4530303030220004006B687968000000000400
      79687A68000000000200647A000000000000000000000000FDFF0100000000}
  end
end
