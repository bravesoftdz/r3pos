inherited frmMktTaskOrderList: TfrmMktTaskOrderList
  Left = 256
  Top = 204
  Caption = #24180#24230#35745#21010
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited RzPanel2: TRzPanel
      inherited RzPage: TRzPageControl
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #24180#24230#35745#21010#21015#34920
          inherited RzPanel3: TRzPanel
            inherited RzPanel1: TRzPanel
              Height = 109
              object RzLabel2: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #32771#26680#24180#24230
              end
              object RzLabel3: TRzLabel
                Left = 176
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 86
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #21333'    '#21495
              end
              object Label3: TLabel
                Left = 33
                Top = 44
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object Label2: TLabel
                Left = 34
                Top = 64
                Width = 48
                Height = 12
                Caption = #19994' '#21153' '#21592
              end
              object Label40: TLabel
                Left = 33
                Top = 24
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object Label1: TLabel
                Left = 184
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
              object fndGLIDE_NO: TcxTextEdit
                Left = 89
                Top = 82
                Width = 88
                Height = 20
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
                TabOrder = 1
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
                Left = 344
                Top = 76
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
                TabOrder = 2
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndPLAN_USER: TzrComboBoxList
                Left = 89
                Top = 60
                Width = 184
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
              object K1: TcxSpinEdit
                Left = 89
                Top = 0
                Width = 80
                Height = 20
                Properties.MinValue = 2000.000000000000000000
                TabOrder = 4
                Value = 2000
              end
              object K2: TcxSpinEdit
                Left = 193
                Top = 0
                Width = 80
                Height = 20
                Properties.MinValue = 2000.000000000000000000
                TabOrder = 5
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
              Top = 114
              Height = 263
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
                  FieldName = 'KPI_YEAR'
                  Footers = <>
                  Title.Caption = #24180#24230
                  Width = 59
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #27969#27700#21495
                  Width = 100
                end
                item
                  EditButtons = <>
                  FieldName = 'DEPT_ID_TEXT'
                  Footers = <>
                  Title.Caption = #25152#23646#37096#38376
                  Width = 121
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_USER_TEXT'
                  Footers = <>
                  Title.Caption = #19994#21153#21592
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_DATE'
                  Footers = <>
                  Title.Caption = #22635#25253#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'BEGIN_DATE'
                  Footers = <>
                  Title.Caption = #24320#22987#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'END_DATE'
                  Footers = <>
                  Title.Caption = #32467#26463#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_AMT'
                  Footers = <>
                  Title.Caption = #21512#35745#25968#37327
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_MNY'
                  Footers = <>
                  Title.Caption = #21512#35745#37329#39069
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #25805#20316#26102#38388
                  Width = 120
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER'
                  Footers = <>
                  Title.Caption = #25805#20316#20154#21592
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_USER'
                  Footers = <>
                  Title.Caption = #23457#26680#20154#21592
                  Width = 60
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    inherited Image3: TImage
      Left = 589
      Width = 239
    end
    inherited rzPanel5: TPanel
      Left = 589
    end
    inherited CoolBar1: TCoolBar
      Width = 569
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 569
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 569
        object ToolButton15: TToolButton
          Left = 516
          Top = 0
          Width = 10
          Caption = 'ToolButton15'
          ImageIndex = 10
          Style = tbsDivider
        end
        object ToolButton16: TToolButton
          Left = 526
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 240
    Top = 232
  end
  inherited actList: TActionList
    Left = 272
    Top = 232
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
  end
  inherited ppmReport: TPopupMenu
    Left = 382
    Top = 231
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfMktPlanOrderList: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    OnGetValue = frfMktPlanOrderListGetValue
    Left = 425
    Top = 230
    ReportForm = {18000000}
  end
end
