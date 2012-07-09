inherited frmVoucherOrderList: TfrmVoucherOrderList
  Left = 196
  Top = 176
  Caption = #31036#21048#20837#24211#31649#29702
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited RzPanel2: TRzPanel
      inherited RzPage: TRzPageControl
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #31036#21048#26597#35810#21015#34920
          inherited RzPanel3: TRzPanel
            inherited RzPanel1: TRzPanel
              Height = 100
              object RzLabel2: TRzLabel
                Left = 33
                Top = 8
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20837#24211#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 199
                Top = 8
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label3: TLabel
                Left = 33
                Top = 52
                Width = 48
                Height = 12
                Caption = #20837#24211#37096#38376
              end
              object Label40: TLabel
                Left = 33
                Top = 30
                Width = 48
                Height = 12
                Caption = #20837#24211#38376#24215
              end
              object Label9: TLabel
                Left = 193
                Top = 75
                Width = 36
                Height = 12
                Caption = #36127#36131#20154
              end
              object Label1: TLabel
                Left = 33
                Top = 74
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #31036#21048#31867#22411
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 4
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 4
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndDEPT_ID: TzrComboBoxList
                Left = 89
                Top = 48
                Width = 236
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 3
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
              object btnOk: TRzBitBtn
                Left = 352
                Top = 64
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
                TabOrder = 6
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 26
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
              object fndINTO_USER: TzrComboBoxList
                Left = 234
                Top = 70
                Width = 91
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = True
                TabOrder = 5
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
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndVOUCHER_TYPE: TcxComboBox
                Left = 89
                Top = 70
                Width = 95
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsFixedList
                TabOrder = 4
              end
            end
            inherited DBGridEh1: TDBGridEh
              Top = 105
              Height = 272
              OnDblClick = DBGridEh1DblClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 40
                end
                item
                  EditButtons = <>
                  FieldName = 'SHOP_ID_TEXT'
                  Footers = <>
                  Title.Caption = #20837#24211#38376#24215
                  Width = 150
                end
                item
                  EditButtons = <>
                  FieldName = 'DEPT_ID_TEXT'
                  Footers = <>
                  Title.Caption = #20837#24211#37096#38376
                  Width = 100
                end
                item
                  EditButtons = <>
                  FieldName = 'VOUCHER_TYPE'
                  Footers = <>
                  Title.Caption = #31036#21048#31867#22411
                  Width = 80
                end
                item
                  EditButtons = <>
                  FieldName = 'INTO_USER_TEXT'
                  Footers = <>
                  Title.Caption = #36127#36131#20154
                  Width = 80
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'INTO_DATE'
                  Footers = <>
                  Title.Caption = #20837#24211#26085#26399
                  Width = 80
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'VAILD_DATE'
                  Footers = <>
                  Title.Caption = #26377#25928#26085#26399
                  Width = 80
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 200
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 140
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#21592
                  Width = 80
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    inherited Image3: TImage
      Left = 579
      Width = 249
    end
    inherited rzPanel5: TPanel
      Left = 579
    end
    inherited CoolBar1: TCoolBar
      Width = 559
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 559
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 559
        object ToolButton15: TToolButton
          Left = 516
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 176
    Top = 240
  end
  inherited actList: TActionList
    Left = 232
    Top = 216
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    inherited actAudit: TAction
      Visible = False
    end
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfVoucherOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 416
    Top = 248
    ReportForm = {
      1800000049050000180000000001000100FFFFFFFFFF09000000340800009A0B
      00000000000000000000000000001200000000FFFF00000000FFFF0000000000
      000000000500506167653100030400466F726D000F0000FFDC00000078000000
      7C0100002C010000040000000200CF0000000B004D6173746572446174613100
      02010000000036000000F6020000420000003000050001000000000000000000
      FFFFFF1F00000000000000000000000000FFFF00000000000200000001000000
      0000000001000000C800000014000000010000000000000200490100000700B7
      D6D7E9CDB7310002010000000012000000F60200000E00000032001000010000
      00000000000000FFFFFF1F000000001300494E5428285B5345514E4F5D2D3129
      2F31352900000000000000FFFF00000000000200000001000000000000000100
      0000C800000014000000010000000000000200330200000700B7D6D7E9BDC531
      00020100000000E7000000F60200001100000030001100010000000000000000
      00FFFFFF1F0000000000000000000007000500626567696E0D1F002020696620
      436F756E74284D61737465724461746131293C3135207468656E0D0700202062
      6567696E0D260020202020666F7220693A3D436F756E74284D61737465724461
      7461312920746F20313420646F0D15002020202053686F7742616E6428436869
      6C6431293B0D06002020656E643B0D0300656E6400FFFF000000000002000000
      010000000000000001000000C800000014000000010000000000000200990200
      0006006368696C6431000201000000008E000000F60200004200000030001500
      01000000000000000000FFFFFF1F00000000000000000000000000FFFF000000
      000002000000010000000000000001000000C800000014000000010000000000
      000A0E00546672426172436F64655669657700001B0300000400426172310002
      00160000005300000086000000220000000100000001000000000000000000FF
      FFFF1F2E020000000000010009005B424152434F44455D00000000FFFF000000
      0000020000000100000000000000140100000000000000000000400000000000
      0000000000A403000005004D656D6F31000200C70000003C000000CE00000012
      0000000300000001000000000000000000FFFFFF1F2E02000000000001000B00
      5B474F44535F4E414D455D00000000FFFF000000000002000000010000000005
      00417269616C000A000000000000000000000000000100020000000000FFFFFF
      00000000020000000000000000002904000005004D656D6F320002003D000000
      3C0000003C000000120000000300000001000000000000000000FFFFFF1F2E02
      0000000000010007005B5345514E4F5D00000000FFFF00000000000200000001
      000000000500417269616C000A00000000000000000000000000010002000000
      0000FFFFFF0000000002000000000000000000AC04000005004D656D6F330002
      00140000003C00000028000000130000000300000001000000000000000000FF
      FFFF1F2E02000000000001000500D0F2BAC53A00000000FFFF00000000000200
      000001000000000500417269616C000A00000000000000000000000000010002
      0000000000FFFFFF00000000020000000000000000003305000005004D656D6F
      340002007D0000003C0000004800000012000000030000000100000000000000
      0000FFFFFF1F2E02000000000001000900C9CCC6B7C3FBB3C63A00000000FFFF
      00000000000200000001000000000500417269616C000A000000000000000000
      000000000100020000000000FFFFFF000000000200000000000000FEFEFF0000
      00000000000000000000FDFF0100000000}
  end
end
