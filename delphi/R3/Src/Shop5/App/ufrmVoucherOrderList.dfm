inherited frmVoucherOrderList: TfrmVoucherOrderList
  Left = 310
  Top = 173
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
              Height = 261
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
      Left = 583
      Width = 237
    end
    inherited rzPanel5: TPanel
      Left = 583
    end
    inherited CoolBar1: TCoolBar
      Width = 563
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 563
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 563
        object ToolButton15: TToolButton
          Left = 520
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
      1800000083100000180000000001000100FFFFFFFFFF09000000340800009A0B
      00000000000000000000000000001200000000FFFF00000000FFFF0000000000
      000000000500506167653100030400466F726D000F0000FFDC00000078000000
      7C0100002C010000040000000200CF0000000B004D6173746572446174613100
      02010000000036000000F6020000CD0000003000050001000000000000000000
      FFFFFF1F00000000000000000000000000FFFF00000000000200000001000000
      0000000001000000C800000014000000010000000000000200480100000700B7
      D6D7E9CDB7310002010000000012000000F60200000200000032001000010000
      00000000000000FFFFFF1F000000001200494E5428285B5345514E4F5D2D3129
      2F352900000000000000FFFF0000000000020000000100000000000000010000
      00C800000014000000010000000000000200300200000700B7D6D7E9BDC53100
      0201000000002B020000F6020000020000003000110001000000000000000000
      FFFFFF1F0000000000000000000007000500626567696E0D1E00202069662043
      6F756E74284D61737465724461746131293C35207468656E0D07002020626567
      696E0D250020202020666F7220693A3D436F756E74284D617374657244617461
      312920746F203420646F0D15002020202053686F7742616E64284368696C6431
      293B0D06002020656E643B0D0300656E6400FFFF000000000002000000010000
      000000000001000000C800000014000000010000000000000200960200000600
      6368696C6431000201000000002A010000F6020000CF00000030001500010000
      00000000000000FFFFFF1F00000000000000000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      FB020000050042616E64310002010000000038000000F6020000CF0000003000
      050001000000000000000000FFFFFF1F00000000000000000000000000FFFF00
      0000000002000000010000000000000001000000C80000001400000001000000
      00000000008403000005004D656D6F310002004B00000069000000E700000012
      0000000300060001000000000000000000FFFFFF1F2E02000000000001000B00
      5B474F44535F4E414D455D00000000FFFF000000000002000000010000000005
      00417269616C0009000000000000000000000000000100020000000000FFFFFF
      00000000020000000000000000000B04000005004D656D6F3400020013000000
      6900000037000000120000000300060001000000000000000000FFFFFF1F2E02
      000000000001000900C9CCC6B7C3FBB3C63A00000000FFFF0000000000020000
      0001000000000500417269616C00090000000000000000000000000001000200
      00000000FFFFFF00000000020000000000000000009104000005004D656D6F35
      0002001300000038000000630100001D00000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000800CCE120BBF520C8AF00000000FFFF0000
      0000000200000001000000000500417269616C000C0000000200000000000A00
      00000100020000000000FFFFFF00000000020000000000000000001705000005
      004D656D6F360002007F01000038000000630100001D00000003000F00010000
      00000000000000FFFFFF1F2E02000000000001000800B8B120202020C8AF0000
      0000FFFF00000000000200000001000000000500417269616C000C0000000200
      000000000A0000000100020000000000FFFFFF00000000020000000000000000
      00AB05000005004D656D6F380002009F02000055000000430000007E00000003
      000B0001000000000000000000FFFFFF1F2E02000000000005000200BBFC0D02
      00BACB0D0200D4B10D0200C1F40D0200B4E600000000FFFF0000000000020000
      0001000000000500417269616C000A0000000000000000000A00000001000200
      00000000FFFFFF00000000020000000000000000004206000005004D656D6F39
      0002003301000055000000430000007E00000003000F00010000000000000000
      00FFFFFF1F2E02000000000004000400CCE1BBF50D0400C8CBD4B10D0400B8C7
      D5C20D0400C1F4B4E600000000FFFF0000000000020000000100000000050041
      7269616C000A0000000000000000000A0000000100020000000000FFFFFF0000
      000002000000000000000000CA06000006004D656D6F31300002001300000056
      00000037000000120000000300060001000000000000000000FFFFFF1F2E0200
      0000000001000900C9CCC6B7B4FAC2EB3A00000000FFFF000000000002000000
      01000000000500417269616C00090000000000000000000A0000000100020000
      000000FFFFFF00000000020000000000000000005407000006004D656D6F3131
      0002004B00000056000000460000001200000003000600010000000000000000
      00FFFFFF1F2E02000000000001000B005B474F44535F434F44455D00000000FF
      FF00000000000200000001000000000500417269616C00090000000000000000
      00080000000100020000000000FFFFFF0000000002000000000000000000DC07
      000006004D656D6F313200020092000000560000003700000012000000030006
      0001000000000000000000FFFFFF1F2E02000000000001000900C9CCC6B7CCF5
      C2EB3A00000000FFFF00000000000200000001000000000500417269616C0009
      0000000000000000000A0000000100020000000000FFFFFF0000000002000000
      0000000000006408000006004D656D6F3133000200CA00000056000000680000
      00120000000300060001000000000000000000FFFFFF1F2E0200000000000100
      09005B424152434F44455D00000000FFFF000000000002000000010000000005
      00417269616C0009000000000000000000080000000100020000000000FFFFFF
      0000000002000000000000000000F908000006004D656D6F31340002004B0000
      007C000000E7000000120000000300060001000000000000000000FFFFFF1F2E
      020000000000010016005B444154455D20D6C1205B5641494C445F444154455D
      00000000FFFF00000000000200000001000000000500417269616C0009000000
      000000000000000000000100020000000000FFFFFF0000000002000000000000
      0000007F09000006004D656D6F3135000200130000007C000000370000001200
      00000300060001000000000000000000FFFFFF1F2E02000000000001000700D3
      D0CFDEC6DA3A00000000FFFF0000000000020000000100000000050041726961
      6C0009000000000000000000010000000100020000000000FFFFFF0000000002
      000000000000000000030A000006004D656D6F3136000200130000008F000000
      1F010000440000000300060001000000000000000000FFFFFF1F2E0200000000
      0001000500B1B8D7A23A00000000FFFF00000000000200000001000000000500
      417269616C0009000000000000000000000000000100020000000000FFFFFF00
      000000020000000000000000007F0A000005004D656D6F3200020013000000D3
      000000CF0200002400000003000F0001000000000000000000FFFFFF1F2E0200
      00000000000000000000FFFF0000000000020000000100000000050041726961
      6C000A000000000000000000080000000100020000000000FFFFFF0000000002
      000000000000000A0E00546672426172436F6465566965770000FE0A00000400
      4261723100020023000000D7000000860000001C000000010000000100000000
      0000000000FFFFFF1F2E020000000000010006005B434F44455D00000000FFFF
      0000000000020000000100000000000000140100000000000000000000400000
      0000000000000000850B000005004D656D6F330002007F010000560000003700
      0000120000000300060001000000000000000000FFFFFF1F2E02000000000001
      000900C9CCC6B7B4FAC2EB3A00000000FFFF0000000000020000000100000000
      0500417269616C00090000000000000000000A0000000100020000000000FFFF
      FF00000000020000000000000000000E0C000005004D656D6F37000200B70100
      005600000046000000120000000300060001000000000000000000FFFFFF1F2E
      02000000000001000B005B474F44535F434F44455D00000000FFFF0000000000
      0200000001000000000500417269616C00090000000000000000000800000001
      00020000000000FFFFFF0000000002000000000000000000960C000006004D65
      6D6F3137000200FE010000560000003700000012000000030006000100000000
      0000000000FFFFFF1F2E02000000000001000900C9CCC6B7CCF5C2EB3A000000
      00FFFF00000000000200000001000000000500417269616C0009000000000000
      0000000A0000000100020000000000FFFFFF0000000002000000000000000000
      1E0D000006004D656D6F31380002003602000056000000680000001200000003
      00070001000000000000000000FFFFFF1F2E020000000000010009005B424152
      434F44455D00000000FFFF00000000000200000001000000000500417269616C
      0009000000000000000000080000000100020000000000FFFFFF000000000200
      00000000000004006D0D000005004C696E653100020013000000FF000000CF02
      00000000000001000800DC050000000000000100FFFFFF002E02000000000000
      0000000000FFFF00000000000200000001000000000000F70D000006004D656D
      6F3139000200B701000069000000E70000001200000003000700010000000000
      00000000FFFFFF1F2E02000000000001000B005B474F44535F4E414D455D0000
      0000FFFF00000000000200000001000000000500417269616C00090000000000
      00000000000000000100020000000000FFFFFF00000000020000000000000000
      007F0E000006004D656D6F32300002007F010000690000003700000012000000
      0300060001000000000000000000FFFFFF1F2E02000000000001000900C9CCC6
      B7C3FBB3C63A00000000FFFF0000000000020000000100000000050041726961
      6C0009000000000000000000000000000100020000000000FFFFFF0000000002
      000000000000000000140F000006004D656D6F3231000200B70100007C000000
      E7000000120000000300070001000000000000000000FFFFFF1F2E0200000000
      00010016005B444154455D20D6C1205B5641494C445F444154455D00000000FF
      FF00000000000200000001000000000500417269616C00090000000000000000
      00000000000100020000000000FFFFFF00000000020000000000000000009A0F
      000006004D656D6F32320002007F0100007C0000003700000012000000030006
      0001000000000000000000FFFFFF1F2E02000000000001000700D3D0CFDEC6DA
      3A00000000FFFF00000000000200000001000000000500417269616C00090000
      00000000000000010000000100020000000000FFFFFF00000000020000000000
      000000001E10000006004D656D6F32330002007F0100008F0000001F01000044
      0000000300070001000000000000000000FFFFFF1F2E02000000000001000500
      B1B8D7A23A00000000FFFF00000000000200000001000000000500417269616C
      0009000000000000000000000000000100020000000000FFFFFF000000000200
      00000000000004006D10000005004C696E65320002007B010000380000000000
      00009B0000000100040002000000000000000100FFFFFF002E02000000000000
      0000000000FFFF0000000000020000000100000000FEFEFF0000000000000000
      00000000FDFF0100000000}
  end
end
