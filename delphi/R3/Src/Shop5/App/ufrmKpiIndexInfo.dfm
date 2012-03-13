inherited frmKpiIndexInfo: TfrmKpiIndexInfo
  Left = 367
  Top = 204
  Caption = #32771#26680#25351#26631
  ClientHeight = 397
  ClientWidth = 529
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 529
    Height = 397
    BorderColor = clWhite
    Color = clWhite
    object RzLabel1: TRzLabel [0]
      Left = 235
      Top = 16
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_KPI_NAME: TRzLabel [1]
      Left = 7
      Top = 17
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25351#26631#21517#31216
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_IDX_TYPE: TRzLabel [2]
      Left = 7
      Top = 41
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25351#26631#31867#22411
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel [3]
      Left = 235
      Top = 41
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_KPI_TYPE: TLabel [4]
      Left = 240
      Top = 41
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #32771#26680#31867#22411
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel3: TRzLabel [5]
      Left = 467
      Top = 41
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel9: TRzLabel [6]
      Left = 235
      Top = 65
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel10: TRzLabel [7]
      Left = 7
      Top = 65
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #21333#20301
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel11: TRzLabel [8]
      Left = 240
      Top = 17
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25340#38899#30721
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel5: TRzLabel [9]
      Left = 7
      Top = 88
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #22791#27880
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    inherited RzPage: TRzPageControl
      Top = 140
      Width = 519
      Height = 212
      Align = alBottom
      TabOrder = 6
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #31614#32422#31561#32423
        inherited RzPanel2: TRzPanel
          Width = 515
          Height = 185
          BorderColor = clWhite
          Color = clWhite
          object Notebook1: TNotebook
            Left = 5
            Top = 5
            Width = 505
            Height = 175
            Align = alClient
            PageIndex = 1
            TabOrder = 0
            object TPage
              Left = 0
              Top = 0
              Caption = 'P0'
              object RzLabel4: TRzLabel
                Left = 192
                Top = 72
                Width = 108
                Height = 12
                Caption = #26242#26102#36824#27809#26377#21551#29992#38454#26799
              end
            end
            object TPage
              Left = 0
              Top = 0
              Caption = 'P1'
              object DBGridEh1: TDBGridEh
                Left = 0
                Top = 0
                Width = 505
                Height = 175
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = Ds_KpiLevel
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                FrozenCols = 2
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
                PopupMenu = PopupMenu1
                RowHeight = 17
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                TitleHeight = 20
                UseMultiTitle = True
                VertScrollBar.VisibleMode = sbAlwaysShowEh
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnKeyPress = DBGridEh1KeyPress
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #24207#21495
                    Width = 34
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LEVEL_NAME'
                    Footers = <>
                    Title.Caption = #31561#32423#21517#31216
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LVL_AMT'
                    Footers = <>
                    Title.Caption = #31614#32422#37327'('#21544')'
                    Width = 80
                  end
                  item
                    DisplayFormat = '#0%'
                    EditButtons = <>
                    FieldName = 'LOW_RATE'
                    Footers = <>
                    Title.Caption = #36820#21033#31995#25968
                  end>
              end
            end
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Color = clWhite
        Caption = #21830#21697#28165#21333
        object RzPanel1: TRzPanel
          Left = 0
          Top = 0
          Width = 515
          Height = 185
          Align = alClient
          BorderOuter = fsNone
          BorderColor = clWhite
          BorderWidth = 5
          Color = clWhite
          TabOrder = 0
          object DBGridEh2: TDBGridEh
            Left = 5
            Top = 5
            Width = 505
            Height = 175
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = Ds_KpiGoods
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 2
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu2
            RowHeight = 17
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            VertScrollBar.VisibleMode = sbAlwaysShowEh
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh2DrawColumnCell
            OnKeyPress = DBGridEh2KeyPress
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                EditButtons = <>
                FieldName = 'GODS_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21830#21697#21517#31216
                Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721#12289#35745#37327#21333#20301#26465#30721'" '#26597#35810
                Width = 142
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                ReadOnly = True
                Tag = 1
                Title.Caption = #36135#21495
                Width = 61
              end
              item
                EditButtons = <>
                FieldName = 'BARCODE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #26465#30721
                Width = 93
              end
              item
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                Title.Caption = #21333#20301
                Width = 46
                OnBeforeShowControl = DBGridEh2Columns4BeforeShowControl
              end>
          end
          object fndUNIT_ID: TcxComboBox
            Left = 336
            Top = 33
            Width = 49
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = fndUNIT_IDPropertiesChange
            TabOrder = 1
            Visible = False
            OnEnter = fndUNIT_IDEnter
            OnExit = fndUNIT_IDExit
            OnKeyDown = fndUNIT_IDKeyDown
            OnKeyPress = fndUNIT_IDKeyPress
          end
        end
      end
      object TabSheet3: TRzTabSheet
        Color = clWhite
        Caption = #26102#27573#23450#20041
        object RzPanel3: TRzPanel
          Left = 0
          Top = 0
          Width = 515
          Height = 185
          Align = alClient
          BorderOuter = fsNone
          Color = clWindow
          TabOrder = 0
          object DBGridEh3: TDBGridEh
            Left = 0
            Top = 0
            Width = 515
            Height = 185
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = Ds_KpiTimes
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 2
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu3
            RowHeight = 17
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            VertScrollBar.VisibleMode = sbAlwaysShowEh
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh3DrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 30
              end
              item
                EditButtons = <>
                FieldName = 'TIMES_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #26102#27573#21517
                Width = 80
              end
              item
                DisplayFormat = '00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE1'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24320#22987#26085#26399
                Width = 60
              end
              item
                DisplayFormat = '00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE2'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32467#26463#26085#26399
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'KPI_DATA'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32771#26680#26631#20934
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'KPI_CALC'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35745#31639#26631#20934
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'RATIO_TYPE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36820#21033#35774#23450
                Width = 70
              end
              item
                Checkboxes = True
                EditButtons = <>
                FieldName = 'KPI_FLAG'
                Footers = <>
                Title.Caption = #20419#38144
                Width = 30
              end
              item
                Checkboxes = True
                DisplayFormat = '#0%'
                EditButtons = <>
                FieldName = 'USING_BRRW'
                Footers = <>
                Title.Caption = #20511#37327
                Width = 30
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 352
      Width = 519
      Color = clWhite
      TabOrder = 7
      object Btn_Save: TRzBitBtn
        Left = 357
        Top = 11
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Close: TRzBitBtn
        Left = 447
        Top = 11
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20851#38381'(&C)'
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
        TabOrder = 1
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object edtKPI_NAME: TcxTextEdit
      Left = 113
      Top = 12
      Width = 121
      Height = 20
      Properties.MaxLength = 50
      Properties.OnChange = edtKPI_NAMEPropertiesChange
      TabOrder = 0
    end
    object edtKPI_TYPE: TcxComboBox
      Left = 346
      Top = 37
      Width = 121
      Height = 20
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 3
    end
    object edtIDX_TYPE: TcxComboBox
      Left = 113
      Top = 37
      Width = 121
      Height = 20
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = edtIDX_TYPEPropertiesChange
      TabOrder = 2
    end
    object edtUNIT_NAME: TcxTextEdit
      Left = 113
      Top = 61
      Width = 121
      Height = 20
      Properties.MaxLength = 10
      TabOrder = 4
    end
    object edtKPI_SPELL: TcxTextEdit
      Left = 346
      Top = 12
      Width = 121
      Height = 20
      Properties.MaxLength = 50
      TabOrder = 1
    end
    object edtREMARK: TcxMemo
      Left = 113
      Top = 85
      Width = 354
      Height = 49
      Properties.MaxLength = 100
      TabOrder = 5
    end
  end
  inherited mmMenu: TMainMenu
    Left = 110
    Top = 365
  end
  inherited actList: TActionList
    Left = 142
    Top = 365
  end
  object CdsKpiLevel: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 47
    Top = 365
  end
  object Ds_KpiLevel: TDataSource
    DataSet = CdsKpiLevel
    Left = 79
    Top = 365
  end
  object CdsKpiIndex: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 275
  end
  object CdsKpiGoods: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 335
  end
  object Ds_KpiGoods: TDataSource
    DataSet = CdsKpiGoods
    Left = 79
    Top = 334
  end
  object PopupMenu1: TPopupMenu
    Left = 18
    Top = 365
    object AddRecord_: TMenuItem
      Caption = #26032#22686#31561#32423
      OnClick = AddRecord_Click
    end
    object DeleteRecord: TMenuItem
      Caption = #21024#38500#31561#32423
      OnClick = DeleteRecordClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 19
    Top = 335
    object AddGoods: TMenuItem
      Caption = #26032#22686#21830#21697
      OnClick = AddGoodsClick
    end
    object DeleteGoods: TMenuItem
      Caption = #21024#38500#21333#21697
      OnClick = DeleteGoodsClick
    end
  end
  object Ds_KpiTimes: TDataSource
    DataSet = CdsKpiTimes
    Left = 79
    Top = 304
  end
  object CdsKpiTimes: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 305
  end
  object PopupMenu3: TPopupMenu
    Left = 19
    Top = 305
    object N1: TMenuItem
      Caption = #26032#22686#26102#27573
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20462#25913#26102#27573
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #21024#38500#26102#27573
      OnClick = N3Click
    end
  end
end
