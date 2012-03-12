inherited frmMktKpiResultList: TfrmMktKpiResultList
  Left = 430
  Top = 203
  Caption = #25351#26631#32771#26680#28165#21333
  ClientHeight = 334
  ClientWidth = 490
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 490
    Height = 334
    inherited RzPage: TRzPageControl
      Width = 480
      Height = 284
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 476
          Height = 280
          object DBGridEh1: TDBGridEh
            Tag = -1
            Left = 5
            Top = 71
            Width = 466
            Height = 204
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = DsList
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 3
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            RowHeight = 20
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            Columns = <
              item
                Color = clBtnFace
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 30
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE1'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24320#22987#26085#26399
                Width = 70
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE2'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32467#26463#26085#26399
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'KPI_DATA'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32771#26680#26631#20934
              end
              item
                EditButtons = <>
                FieldName = 'KPI_CALC'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35745#31639#26631#20934
              end
              item
                EditButtons = <>
                FieldName = 'RATIO_TYPE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36820#21033#35774#23450
              end
              item
                EditButtons = <>
                FieldName = 'GODS_ID_TEXT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36820#21033#21830#21697
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'LVL_AMT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #31614#32422#37327
                Width = 50
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'KPI_RATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #23436#25104#29575
                Width = 50
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'FISH_AMT'
                Footers = <>
                Title.Caption = #23436#25104#38144#37327
                OnUpdateData = DBGridEh1Columns9UpdateData
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'FISH_CALC_RATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36716#25442#31995#25968
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'ADJS_AMT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35843#25972#38144#37327
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'FISH_MNY'
                Footers = <>
                ReadOnly = True
                Title.Caption = #23436#25104#37329#39069
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'ADJS_MNY'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35843#25972#37329#39069
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'KPI_RATIO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36820#21033#31995#25968
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'KPI_MNY'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32771#26680#32467#26524
              end>
          end
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 466
            Height = 66
            Align = alTop
            BorderOuter = fsNone
            BorderSides = [sdBottom]
            BorderWidth = 2
            Color = clWindow
            TabOrder = 1
            object lab_KPI_NAME: TRzLabel
              Left = -17
              Top = 14
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
            object lab_IDX_TYPE: TRzLabel
              Left = -17
              Top = 40
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
            object lab_KPI_TYPE: TLabel
              Left = 212
              Top = 40
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
            object edtKPI_NAME: TcxTextEdit
              Tag = 1
              Left = 89
              Top = 9
              Width = 232
              Height = 20
              Properties.MaxLength = 20
              TabOrder = 0
            end
            object edtIDX_TYPE: TcxComboBox
              Tag = 1
              Left = 89
              Top = 36
              Width = 121
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              TabOrder = 1
            end
            object edtKPI_TYPE: TcxComboBox
              Tag = 1
              Left = 318
              Top = 36
              Width = 121
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              TabOrder = 2
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 289
      Width = 480
      object btnClose: TRzBitBtn
        Left = 398
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnCloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object DsList: TDataSource
    DataSet = CdsResultList
    Left = 79
    Top = 170
  end
  object CdsResultList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 171
  end
  object CdsResult: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 139
  end
end
