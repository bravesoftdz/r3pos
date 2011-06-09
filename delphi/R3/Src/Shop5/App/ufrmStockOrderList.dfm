inherited frmStockOrderList: TfrmStockOrderList
  Left = 198
  Top = 105
  Width = 868
  Height = 612
  Caption = #36827#36135#21333
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 860
    Height = 549
    inherited RzPanel2: TRzPanel
      Width = 850
      Height = 539
      inherited RzPage: TRzPageControl
        Width = 844
        Height = 533
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #36827#36135#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 842
            Height = 506
            inherited RzPanel1: TRzPanel
              Width = 832
              Height = 110
              object RzLabel2: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36827#36135#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel4: TRzLabel
                Left = 33
                Top = 64
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20379' '#24212' '#21830
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 84
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36827#36135#21333#21495
              end
              object Label1: TLabel
                Left = 201
                Top = 85
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
                Top = 24
                Width = 48
                Height = 12
                Caption = #36827#36135#38376#24215
              end
              object Label3: TLabel
                Left = 33
                Top = 44
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
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
              object fndCLIENT_ID: TzrComboBoxList
                Left = 89
                Top = 60
                Width = 236
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
                FilterFields = 'CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
                KeyField = 'CLIENT_ID'
                ListField = 'CLIENT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_CODE'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_NAME'
                    Footers = <>
                    Title.Caption = #20379#24212#21830#21517#31216
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LINKMAN'
                    Footers = <>
                    Title.Caption = #32852#31995#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TELEPHONE2'
                    Footers = <>
                    Title.Caption = #32852#31995#30005#35805
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LICENSE_CODE'
                    Footers = <>
                    Title.Caption = #35777#20214#21495
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ADDRESS'
                    Footers = <>
                    Title.Caption = #22320#22336
                    Width = 150
                  end>
                DropWidth = 236
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = False
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndSTOCK_ID: TcxTextEdit
                Left = 89
                Top = 80
                Width = 104
                Height = 20
                TabOrder = 3
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object btnOk: TRzBitBtn
                Left = 504
                Top = 56
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
                Left = 344
                Top = -5
                Width = 145
                Height = 86
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
                    Caption = #26410#32467#36134
                  end
                  item
                    Caption = #24050#32467#36134
                  end>
                TabOrder = 4
                Caption = ''
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
              object fndDEPT_ID: TzrComboBoxList
                Left = 89
                Top = 40
                Width = 236
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 7
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
              Top = 115
              Width = 832
              Height = 386
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OnDblClick = DBGridEh1DblClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 30
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #27969#27700#21495
                  Width = 85
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'STOCK_DATE'
                  Footers = <>
                  Title.Caption = #36827#36135#26085#26399
                  Width = 68
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #20379#24212#21830
                  Width = 160
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #39564#36135#21592
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'INVOICE_FLAG'
                  Footers = <>
                  Title.Caption = #31080#25454#31867#22411
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #25968#37327
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'AMONEY'
                  Footers = <>
                  Title.Caption = #21512#35745#37329#39069
                  Width = 58
                end
                item
                  EditButtons = <>
                  FieldName = 'PAYM_MNY'
                  Footers = <>
                  Title.Caption = #24050#32467#31639
                  Width = 56
                end
                item
                  EditButtons = <>
                  FieldName = 'RECK_MNY'
                  Footers = <>
                  Title.Caption = #26410#32467#31639
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 143
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
                  Width = 131
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 860
    inherited Image1: TImage
      Left = 632
      Width = 208
    end
    inherited Image3: TImage
      Left = 632
      Width = 208
    end
    inherited Image14: TImage
      Left = 840
    end
    inherited rzPanel5: TPanel
      Left = 632
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#36827#36135#20837#24211
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 612
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 612
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 612
        object ToolButton16: TToolButton
          Left = 518
          Top = 0
          Action = actfrmPayOrder
        end
        object ToolButton17: TToolButton
          Left = 561
          Top = 0
          Width = 8
          Caption = 'ToolButton17'
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton11: TToolButton
          Left = 569
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 208
    Top = 144
  end
  inherited actList: TActionList
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    object actfrmPayOrder: TAction
      Caption = #20184#27454
      ImageIndex = 28
      OnExecute = actfrmPayOrderExecute
    end
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfStockOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfStockOrderGetValue
    OnUserFunction = frfStockOrderUserFunction
    Left = 416
    Top = 193
    ReportForm = {
      180000003F1F0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00A4000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      500100000700B7D6D7E9CDB7310002010000000019000000F60200006D000000
      3200100001000000000000000000FFFFFF1F000000001300696E7428285B5345
      514E4F5D2D31292F31352900000000000000FFFF000000000002000000010000
      000000000001000000C800000014000000010000000000000200370200000700
      B7D6D7E9BDC5310002010000000012010000F602000045000000300011000100
      0000000000000000FFFFFF1F0000000000000000000007000500626567696E0D
      1E0020696620436F756E74284D61737465724461746131293C3135207468656E
      0D060020626567696E0D260020202020666F7220693A3D436F756E74284D6173
      74657244617461312920746F20313420646F0D15002020202053686F7742616E
      64284368696C6431293B0D050020656E643B0D0300656E6400FFFF0000000000
      02000000010000000000000001000000C8000000140000000100000000000002
      009D02000006006368696C643100020100000000CC000000F602000013000000
      3000150001000000000000000000FFFFFF1F00000000000000000000000000FF
      FF000000000002000000010000000000000001000000C8000000140000000100
      000000000000003B03000006004D656D6F31340002001A020000A40000003C00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000001
      0020005B466F726D6174466C6F6174282723302E303023272C5B415052494345
      5D295D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000090000008600020000000000FFFFFF000000000200000000
      0000000000DC03000006004D656D6F313800020056020000A400000060000000
      1300000001000F0001000000000000000000FFFFFF1F2E020000000000010023
      005B666F726D6174466C6F6174282723302E3030272C5B43414C435F4D4F4E45
      595D295D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000090000008600020000000000FFFFFF0000000002000000
      0000000000009C04000006004D656D6F3230000200F1000000A4000000D10000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      42005B474F44535F4E414D455D205B50524F50455254595F30315F544558545D
      5B50524F50455254595F30325F544558545D205B49535F50524553454E545F54
      4558545D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000080000008600020000000000FFFFFF0000000002000000
      0000000000002605000005004D656D6F390002007500000033000000EF000000
      120000000100020001000000000000000000FFFFFF1F2E02000000000001000D
      005B434C49454E545F4E414D455D00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000080000008600020000000000FF
      FFFF0000000002000000000000000000B005000006004D656D6F343000020092
      0100003300000086000000120000000100020001000000000000000000FFFFFF
      1F2E02000000000001000C005B53544F434B5F444154455D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000080000
      008600020000000000FFFFFF0000000002000000000000000000390600000600
      4D656D6F3233000200C2010000A4000000240000001300000001000F00010000
      00000000000000FFFFFF1F2E02000000000001000B005B554E49545F4E414D45
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0000000000000A0000008600020000000000FFFFFF0000000002000000000000
      000000D506000005004D656D6F33000200E6010000A400000034000000130000
      0001000F0001000000000000000000FFFFFF1F2E02000000000001001F005B66
      6F726D6174466C6F6174282723302E2323272C5B414D4F554E545D295D000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000090000008600020000000000FFFFFF00000000020000000000000000005D
      07000006004D656D6F31320002002F0000003300000046000000120000000100
      000001000000000000000000FFFFFF1F2E02000000000001000A00B9A920D3A6
      20C9CCA3BA00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000080000008600020000000000FFFFFF00000000020000
      00000000000000E107000006004D656D6F313300020065010000330000002C00
      0000120000000100000001000000000000000000FFFFFF1F2E02000000000001
      000600C8D5C6DAA3BA00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000020000000000080000008600020000000000FFFFFF000000
      00020000000000000000006308000006004D656D6F33340002001A0200007000
      00003C0000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000400B5A5BCDB00000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000E908000006004D656D6F3336000200F1000000
      70000000D10000001600000001000F0001000000000000000000FFFFFF1F2E02
      000000000001000800C9CCC6B7C3FBB3C600000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF00000000020000000000000000006B09000006004D656D6F333700
      0200E601000070000000340000001600000001000F0001000000000000000000
      FFFFFF1F2E02000000000001000400CAFDC1BF00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000A00000086000200
      00000000FFFFFF0000000002000000000000000000ED09000006004D656D6F33
      38000200C201000070000000240000001600000001000F000100000000000000
      0000FFFFFF1F2E02000000000001000400B5A5CEBB00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000200000000000A0000008600
      020000000000FFFFFF0000000002000000000000000000830A000006004D656D
      6F34310002003100000029010000810000001200000001000000010000000000
      00000000FFFFFF1F2E02000000000001001800D6C6B5A5C8CBA3BA5B43524541
      5F555345525F544558545D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000080000008600020000000000FFFFFF00
      00000002000000000000000000050B000006004D656D6F343500020056020000
      70000000600000001600000001000F0001000000000000000000FFFFFF1F2E02
      000000000001000400BDF0B6EE00000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000200000000000A0000008600020000000000FFFF
      FF00000000020000000000000000008A0B000006004D656D6F35340002003000
      0000A40000001B0000001300000001000F0001000000000000000000FFFFFF1F
      2E020000000000010007005B5345514E4F5D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000000000000000A0000008600020000
      000000FFFFFF0000000002000000000000000000090C000006004D656D6F3535
      00020030000000700000001B0000001600000001000F00010000000000000000
      00FFFFFF1F2E020000000000010001004100000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF00000000020000000000000000008A0C000005004D656D6F370002
      004B00000070000000420000001600000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000400BBF5BAC500000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000000100020000
      000000FFFFFF0000000002000000000000000000120D000005004D656D6F3800
      02004B000000A4000000420000001300000001000F0001000000000000000000
      FFFFFF1F2E02000000000001000B005B474F44535F434F44455D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000008
      0000000100020000000000FFFFFF0000000002000000000000000000EF0D0000
      06004D656D6F3131000200E601000012010000D00000001300000001000B0001
      000000000000000000FFFFFF1F2E02000000000001005F00D7DCCAFDC1BFA3BA
      5B666F726D6174466C6F6174282723302E2323272C5B53544F434B5F414D545D
      295D20B1BED2B3D0A1BCC6A3BAA3A45B666F726D6174466C6F6174282723302E
      3030272C73756D285B43414C435F4D4F4E45595D29295D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000009000000
      8600020000000000FFFFFF0000000002000000000000000000770E000006004D
      656D6F313600020030000000120100004A0000001300000001000E0001000000
      000000000000FFFFFF1F2E02000000000001000A00BACFBCC6BDF0B6EEA3BA00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00FB0E000006004D656D6F333200020019020000330000002D00000012000000
      0100000001000000000000000000FFFFFF1F2E02000000000001000600B5A5BA
      C5A3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      0000000000830F000006004D656D6F3538000200460200003300000070000000
      120000000100020001000000000000000000FFFFFF1F2E02000000000001000A
      005B474C4944455F4E4F5D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000000000008600020000000000FFFFFF00
      000000020000000000000000001410000005004D656D6F320002003000000019
      00000086020000180000000100000001000000000000000500FFFFFF1F2E0200
      00000000010014005BC6F3D2B5C3FBB3C65DBDF8BBF5C8EBBFE2B5A500000000
      FFFF00000000000200000001000000000400CBCECCE500100000000200000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000AA10
      000006004D656D6F32340002005C0200001B0000007A0000000F000000010000
      0001000000000000000000FFFFFF1F2E02000000000001001800B5DA5B504147
      45235D2F5B544F54414C50414745535DD2B300000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000090000008600020000
      000000FFFFFF00000000020000000000000000004011000005004D656D6F3100
      0200C90000002801000080000000140000000100000001000000000000000000
      FFFFFF1F2E02000000000001001900D1E9BBF5D4B1A3BA5B47554944455F5553
      45525F544558545D00000000010000000000000200000001000000000400CBCE
      CCE5000A0000000200FFFFFF1F080000008600020000000000FFFFFF00000000
      020000000000000000001712000006004D656D6F34330002007A000000120100
      006D0100001300000001000A0001000000000000000000FFFFFF1F2E02000000
      0000010059005B536D616C6C546F426967285B666F726D6174466C6F61742827
      23302E3030272C5B53544F434B5F4D4E595D295D295D20A3A4A3BA5B666F726D
      6174466C6F6174282723302E303023272C5B53544F434B5F4D4E595D295D2000
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000080000008600020000000000FFFFFF00000000020000000000000000
      009E12000006004D656D6F33310002002E000000470000004800000012000000
      0300000001000000000000000000FFFFFF1F2E02000000000001000900B5D820
      202020D6B73A00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000020000000000080000000100020000000000FFFFFF000000000200
      00000000000000002513000006004D656D6F35300002007400000047000000F1
      000000120000000300020001000000000000000000FFFFFF1F2E020000000000
      010009005B414444524553535D00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000000100020000000000FFFF
      FF0000000002000000000000000000A913000006004D656D6F35360002006501
      0000470000002C000000120000000300000001000000000000000000FFFFFF1F
      2E02000000000001000600B5E7BBB0A3BA00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000002000000000008000000010002000000
      0000FFFFFF00000000020000000000000000003214000006004D656D6F353700
      0200920100004700000086000000120000000300020001000000000000000000
      FFFFFF1F2E02000000000001000B005B4D4F56455F54454C455D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000008
      0000000100020000000000FFFFFF0000000002000000000000000000B4140000
      06004D656D6F34320002008D00000070000000640000001600000001000F0001
      000000000000000000FFFFFF1F2E02000000000001000400CCF5C2EB00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      000A0000000100020000000000FFFFFF00000000020000000000000000003B15
      000006004D656D6F35390002008D000000A4000000640000001300000001000F
      0001000000000000000000FFFFFF1F2E020000000000010009005B424152434F
      44455D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000000100020000000000FFFFFF000000000200000000
      0000000000B715000006004D656D6F36300002001A020000CC0000003C000000
      1300000001000F0001000000000000000000FFFFFF1F2E020000000000000000
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000090000008600020000000000FFFFFF00000000020000000000000000
      003316000006004D656D6F363100020056020000CC0000006000000013000000
      01000F0001000000000000000000FFFFFF1F2E020000000000000000000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000000000000000
      090000008600020000000000FFFFFF0000000002000000000000000000AF1600
      0006004D656D6F3632000200F1000000CC000000D10000001300000001000F00
      01000000000000000000FFFFFF1F2E020000000000000000000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      8600020000000000FFFFFF00000000020000000000000000002D17000006004D
      656D6F3633000200C2010000CC000000240000001300000001000F0001000000
      000000000000FFFFFF1F2E0200000000000100000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000000000000000A0000008600
      020000000000FFFFFF0000000002000000000000000000A917000006004D656D
      6F3634000200E6010000CC000000340000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000000000000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000009000000860002000000
      0000FFFFFF00000000020000000000000000002718000006004D656D6F363500
      020030000000CC0000001B0000001300000001000F0001000000000000000000
      FFFFFF1F2E0200000000000100000000000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000000000000000A0000008600020000000000
      FFFFFF0000000002000000000000000000A518000006004D656D6F3636000200
      4B000000CC000000420000001300000001000F0001000000000000000000FFFF
      FF1F2E0200000000000100000000000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000000100020000000000FFFF
      FF00000000020000000000000000002119000006004D656D6F36370002008D00
      0000CC000000640000001300000001000F0001000000000000000000FFFFFF1F
      2E020000000000000000000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000080000000100020000000000FFFFFF000000
      0002000000000000000000041A000006004D656D6F3638000200C10200006100
      0000140000002E0100000300000001000000000000000000FFFFFF1F2E020000
      00000007000E00B0D7C1AAA3BAB4E6B8F9202020200D00000D15002020202020
      202020202020202020202020202020200D0E00BAECC1AAA3BAB9A9D3A6C9CC20
      200D00000D18002020202020202020202020202020202020202020202020200D
      0A00BBC6C1AAA3BABDE1CBE300000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000020000000000000000000100020000000000FFFFFF
      0000000002000000000000000000881A000006004D656D6F3130000200190200
      00470000002C000000120000000300000001000000000000000000FFFFFF1F2E
      02000000000001000600BDE1CBE3A3BA00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000800000001000200000000
      00FFFFFF0000000002000000000000000000181B000006004D656D6F31350002
      00460200004700000070000000120000000300020001000000000000000000FF
      FFFF1F2E020000000000010012005B534554544C455F434F44455F544558545D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000080000000100020000000000FFFFFF000000000200000000000000
      00009E1B000005004D656D6F34000200320000005B0000004400000012000000
      0300000001000000000000000000FFFFFF1F2E02000000000001000900CAD5BB
      F5C3C5B5EA3A00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000020000000000080000000100020000000000FFFFFF000000000200
      0000000000000000261C000005004D656D6F36000200730000005B000000F300
      0000120000000300020001000000000000000000FFFFFF1F2E02000000000001
      000B005B53484F505F4E414D455D00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000080000000100020000000000FF
      FFFF0000000002000000000000000000AA1C000006004D656D6F313700020065
      0100005B0000002C000000120000000300000001000000000000000000FFFFFF
      1F2E02000000000001000600B1B8D7A2A3BA00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000000100020000
      000000FFFFFF0000000002000000000000000000301D000006004D656D6F3139
      000200920100005B000000240100001200000003000200010000000000000000
      00FFFFFF1F2E020000000000010008005B52454D41524B5D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000080000
      000100020000000000FFFFFF0000000002000000000000000000B41D00000600
      4D656D6F32310002001F020000390100002C0000001200000001000000010000
      00000000000000FFFFFF1F2E02000000000001000600B2C6CEF1A3BA00000000
      010000000000000200000001000000000400CBCECCE5000A0000000200FFFFFF
      1F080000008600020000000000FFFFFF0000000002000000000000000000301E
      000006004D656D6F323200020054020000390100005C00000012000000010002
      0001000000000000000000FFFFFF1F2E02000000000000000000000001000000
      0000000200000001000000000400CBCECCE5000A0000000200FFFFFF1F080000
      008600020000000000FFFFFF0000000002000000000000000000C51E00000600
      4D656D6F32350002003100000041010000880100001200000003000000010000
      00000000000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B
      444154455D205B54494D455D00000000FFFF0000000000020000000100000000
      0500417269616C000A000000000000000000000000000100020000000000FFFF
      FF000000000200000000000000FEFEFF060000000A00205661726961626C6573
      000000000200736C0014006364735F436867426F64792E22534C303030302200
      02006A650014006364735F436867426F64792E224A4530303030220004006B68
      796800000000040079687A68000000000200647A000000000000000000000000
      FDFF0100000000}
  end
end
