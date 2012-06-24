inherited frmMktKpiResultList: TfrmMktKpiResultList
  Left = 267
  Caption = #25351#26631#32771#26680#28165#21333
  ClientHeight = 383
  ClientWidth = 600
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 600
    Height = 383
    inherited RzPage: TRzPageControl
      Width = 590
      Height = 333
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 586
          Height = 329
          object DBGridEh1: TDBGridEh
            Tag = -1
            Left = 5
            Top = 40
            Width = 576
            Height = 284
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
            FooterRowCount = 1
            FrozenCols = 1
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            RowHeight = 20
            SumList.Active = True
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
                Width = 22
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE1'
                Footer.Value = #21512#35745#65306
                Footer.ValueType = fvtStaticText
                Footers = <>
                ReadOnly = True
                Title.Caption = #24320#22987#26085#26399
                Width = 61
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE2'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32467#26463#26085#26399
                Width = 61
              end
              item
                EditButtons = <>
                FieldName = 'GODS_ID_TEXT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21830#21697#21517#31216
                Width = 127
              end
              item
                EditButtons = <>
                FieldName = 'UNIT_NAME'
                Footers = <>
                Title.Caption = #21333#20301
                Width = 23
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'LVL_AMT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #31614#32422#31561#32423
                Width = 31
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00#'
                EditButtons = <>
                FieldName = 'FISH_AMT'
                Footer.DisplayFormat = '#0.00'
                Footer.ValueType = fvtSum
                Footers = <>
                Title.Caption = #23436#25104#37327
                Width = 42
                OnUpdateData = DBGridEh1Columns9UpdateData
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00%'
                EditButtons = <>
                FieldName = 'FISH_RATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #23436#25104#29575
                Width = 40
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00#'
                EditButtons = <>
                FieldName = 'ADJS_AMT'
                Footer.DisplayFormat = '#0.00'
                Footer.ValueType = fvtSum
                Footers = <>
                ReadOnly = True
                Title.Caption = #35843#25972#37327
                Width = 44
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'KPI_RATIO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36820#21033#31995#25968
                Width = 33
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'KPI_MNY'
                Footer.DisplayFormat = '#0.00'
                Footer.ValueType = fvtSum
                Footers = <>
                ReadOnly = True
                Title.Caption = #36820#21033#37329#39069
                Width = 52
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'BUDG_KPI'
                Footer.DisplayFormat = '#0.00'
                Footer.ValueType = fvtSum
                Footers = <>
                Title.Caption = #24066#22330#36153
                Width = 55
              end
              item
                EditButtons = <>
                FieldName = 'RATIO_TYPE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36820#21033#35774#23450
                Width = 67
              end
              item
                EditButtons = <>
                FieldName = 'KPI_DATA'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32771#26680#26631#20934
                Width = 79
              end
              item
                EditButtons = <>
                FieldName = 'KPI_CALC'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35745#31639#26631#20934
                Width = 73
              end>
          end
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 576
            Height = 35
            Align = alTop
            BorderOuter = fsNone
            BorderSides = [sdBottom]
            BorderWidth = 2
            Color = clWindow
            TabOrder = 1
            object lab_KPI_NAME: TRzLabel
              Left = -17
              Top = 10
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
            object lab_KPI_TYPE: TLabel
              Left = 312
              Top = 10
              Width = 48
              Height = 12
              Alignment = taRightJustify
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
              Top = 6
              Width = 200
              Height = 20
              Properties.MaxLength = 20
              TabOrder = 0
            end
            object edtKPI_TYPE: TcxComboBox
              Tag = 1
              Left = 366
              Top = 6
              Width = 121
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              TabOrder = 1
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 338
      Width = 590
      object btnClose: TRzBitBtn
        Left = 508
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
