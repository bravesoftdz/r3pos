inherited frmMktKpiResult3: TfrmMktKpiResult3
  Left = 252
  Top = 172
  Width = 915
  Height = 533
  Caption = #19994#21153#21592#25552#25104
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 907
    Height = 469
    inherited RzPanel2: TRzPanel
      Width = 897
      Height = 459
      inherited RzPage: TRzPageControl
        Width = 891
        Height = 453
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #19994#21153#21592#25552#25104#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 889
            Height = 426
            object Panel1: TPanel
              Left = 5
              Top = 120
              Width = 879
              Height = 301
              Align = alClient
              BevelInner = bvLowered
              TabOrder = 0
              object Grid: TDBGridEh
                Left = 2
                Top = 2
                Width = 875
                Height = 297
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = DsKpiResult
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                FrozenCols = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                PopupMenu = PopupMenu1
                RowHeight = 23
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                UseMultiTitle = True
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDblClick = GridDblClick
                OnDrawColumnCell = GridDrawColumnCell
                OnDrawFooterCell = GridDrawFooterCell
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
                    ReadOnly = True
                    Title.Caption = #24180#24230
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PLAN_USER_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #19994#21153#21592
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'KPI_ID_TEXT'
                    Footers = <>
                    Title.Caption = #25351#26631#21517#31216
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_NAME'
                    Footers = <>
                    Title.Caption = #21333#20301
                    Width = 40
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'PLAN_AMT'
                    Footer.DisplayFormat = '#,##0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #35745#21010#37327
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'FISH_AMT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#,##0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #23436#25104#37327
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0%'
                    EditButtons = <>
                    FieldName = 'FISH_RATE'
                    Footers = <>
                    Title.Caption = #23436#25104#29575
                    Width = 50
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'KPI_MNY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #25552#25104#24635#39069
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
                    FieldName = 'CREA_USER_TEXT'
                    Footers = <>
                    Title.Caption = #25805#20316#20154
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_DATE'
                    Footer.Alignment = taRightJustify
                    Footers = <>
                    Title.Caption = #23457#26680#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_USER_TEXT'
                    Footer.Alignment = taRightJustify
                    Footers = <>
                    Title.Caption = #23457#26680#20154
                    Width = 80
                  end>
              end
            end
            object Panel2: TPanel
              Left = 5
              Top = 5
              Width = 879
              Height = 115
              Align = alTop
              BevelInner = bvLowered
              TabOrder = 1
              object Label1: TLabel
                Left = 14
                Top = 94
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #32771#26680#25351#26631
              end
              object RzLabel7: TRzLabel
                Left = 14
                Top = 10
                Width = 48
                Height = 12
                Alignment = taRightJustify
                AutoSize = False
                Caption = #24180'    '#24230
              end
              object Label32: TLabel
                Left = 14
                Top = 30
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object RzLabel4: TRzLabel
                Left = 14
                Top = 73
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #19994' '#21153' '#21592
              end
              object Label40: TLabel
                Left = 14
                Top = 52
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object fndKPI_ID: TzrComboBoxList
                Left = 70
                Top = 90
                Width = 215
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 0
                InGrid = False
                KeyValue = Null
                FilterFields = 'KPI_NAME;KPI_SPELL'
                KeyField = 'KPI_ID'
                ListField = 'KPI_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'KPI_NAME'
                    Footers = <>
                    Title.Caption = #25351#26631#21517#31216
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'KPI_SPELL'
                    Footers = <>
                    Title.Caption = #25340#38899#30721
                    Width = 60
                  end>
                DataSet = cdsKPI_ID
                DropWidth = 290
                DropHeight = 228
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndKPI_YEAR: TcxSpinEdit
                Left = 70
                Top = 6
                Width = 121
                Height = 20
                Properties.MaxValue = 2111.000000000000000000
                Properties.MinValue = 2000.000000000000000000
                Properties.OnChange = fndKPI_YEARPropertiesChange
                TabOrder = 1
                Value = 2011
              end
              object btnOk: TRzBitBtn
                Left = 294
                Top = 86
                Width = 67
                Height = 24
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
              object fndDEPT_ID: TzrComboBoxList
                Left = 70
                Top = 27
                Width = 121
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
                RangeField = 'DEPT_TYPE'
                RangeValue = '1'
              end
              object fndCLIENT_ID: TzrComboBoxList
                Left = 70
                Top = 69
                Width = 215
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 4
                InGrid = False
                KeyValue = Null
                FilterFields = 'USER_ID;USER_SPELL;USER_NAME'
                KeyField = 'USER_ID'
                ListField = 'USER_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #22995#21517
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_SPELL'
                    Footers = <>
                    Title.Caption = #25340#38899#30721
                    Width = 80
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
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 70
                Top = 48
                Width = 215
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
                DropWidth = 215
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
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 907
    inherited Image3: TImage
      Left = 341
      Width = 526
    end
    inherited Image14: TImage
      Left = 887
    end
    inherited Image1: TImage
      Left = 867
    end
    inherited rzPanel5: TPanel
      Left = 341
    end
    inherited CoolBar1: TCoolBar
      Width = 321
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 321
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 321
        ButtonWidth = 43
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actFind
        end
        object ToolButton2: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
        end
        object ToolButton3: TToolButton
          Left = 86
          Top = 0
          Width = 10
          Caption = 'ToolButton3'
          ImageIndex = 2
          Style = tbsDivider
        end
        object ToolButton9: TToolButton
          Left = 96
          Top = 0
          Action = actAudit
        end
        object ToolButton4: TToolButton
          Left = 139
          Top = 0
          Action = actPrint
        end
        object ToolButton5: TToolButton
          Left = 182
          Top = 0
          Action = actPreview
        end
        object ToolButton6: TToolButton
          Left = 225
          Top = 0
          Action = actSave
        end
        object ToolButton7: TToolButton
          Left = 268
          Top = 0
          Width = 10
          Caption = 'ToolButton7'
          ImageIndex = 6
          Style = tbsDivider
        end
        object ToolButton8: TToolButton
          Left = 278
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 32
    Top = 224
  end
  inherited actList: TActionList
    Left = 64
    Top = 224
    inherited actEdit: TAction
      Caption = #35745#31639
      OnExecute = actEditExecute
    end
    inherited actSave: TAction
      Caption = #23548#20986
      ImageIndex = 4
      OnExecute = actSaveExecute
    end
    inherited actPrint: TAction
      OnExecute = actPrintExecute
    end
    inherited actPreview: TAction
      OnExecute = actPreviewExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    inherited actInfo: TAction
      Caption = #35814#24773
      OnExecute = actInfoExecute
    end
    inherited actAudit: TAction
      OnExecute = actAuditExecute
    end
  end
  object DsKpiResult: TDataSource
    DataSet = CdsKpiResult
    Left = 96
    Top = 224
  end
  object CdsKpiResult: TZQuery
    FieldDefs = <>
    AfterScroll = CdsKpiResultAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 128
    Top = 224
  end
  object cdsKPI_ID: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 214
    Top = 67
  end
  object SaveDialog1: TSaveDialog
    Left = 159
    Top = 224
  end
  object PrintDBGridEh1: TPrintDBGridEh
    Options = []
    Page.BottomMargin = 2.000000000000000000
    Page.LeftMargin = 2.000000000000000000
    Page.RightMargin = 2.000000000000000000
    Page.TopMargin = 2.000000000000000000
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'MS Sans Serif'
    PageHeader.Font.Style = []
    Units = MM
    Left = 190
    Top = 224
  end
  object PopupMenu1: TPopupMenu
    Left = 222
    Top = 224
    object N1: TMenuItem
      Caption = #25351#26631#23646#24615
      OnClick = N1Click
    end
  end
end
