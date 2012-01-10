inherited frmMktKpiResultList: TfrmMktKpiResultList
  Left = 736
  Top = 205
  Caption = #25351#26631#32771#26680#28165#21333
  ClientHeight = 321
  ClientWidth = 477
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 477
    Height = 321
    inherited RzPage: TRzPageControl
      Width = 467
      Height = 271
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 463
          Height = 267
          object DBGridEh1: TDBGridEh
            Tag = -1
            Left = 5
            Top = 90
            Width = 453
            Height = 172
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
            FrozenCols = 1
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
                EditButtons = <>
                FieldName = 'SEQ_NO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 30
              end
              item
                EditButtons = <>
                FieldName = 'KPI_DATE1'
                Footers = <>
                Title.Caption = #24320#22987#26085#26399
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'KPI_DATE2'
                Footers = <>
                Title.Caption = #32467#26463#26085#26399
                Width = 60
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'KPI_RATE'
                Footers = <>
                Title.Caption = #36798#26631#29575
                Width = 60
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'KPI_AMT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36798#26631#37327
                Width = 60
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'KPI_AGIO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36798#26631#25240#25187
                Width = 60
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'FSH_VLE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #23436#25104#37327
                Width = 70
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'KPI_MNY'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32771#26680#37327
                Width = 70
              end>
          end
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 453
            Height = 85
            Align = alTop
            BorderOuter = fsNone
            BorderSides = [sdBottom]
            BorderWidth = 2
            Color = clWindow
            TabOrder = 1
            object lab_KPI_NAME: TRzLabel
              Left = -17
              Top = 11
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
              Top = 34
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
            object lab_KPI_DATA: TLabel
              Left = -17
              Top = 58
              Width = 100
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #32771#26680#26631#20934
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object lab_KPI_CALC: TLabel
              Left = 212
              Top = 58
              Width = 100
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #35745#31639#26631#20934
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object lab_KPI_TYPE: TLabel
              Left = 212
              Top = 34
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
              Left = 89
              Top = 6
              Width = 121
              Height = 20
              Properties.MaxLength = 20
              TabOrder = 0
            end
            object edtIDX_TYPE: TcxComboBox
              Left = 89
              Top = 30
              Width = 121
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              Properties.OnChange = edtIDX_TYPEPropertiesChange
              TabOrder = 1
            end
            object edtKPI_DATA: TcxComboBox
              Left = 89
              Top = 54
              Width = 121
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              Properties.OnChange = edtKPI_DATAPropertiesChange
              TabOrder = 2
            end
            object edtKPI_CALC: TcxComboBox
              Left = 318
              Top = 54
              Width = 121
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              Properties.OnChange = edtKPI_CALCPropertiesChange
              TabOrder = 3
            end
            object edtKPI_TYPE: TcxComboBox
              Left = 318
              Top = 30
              Width = 121
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              TabOrder = 4
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 276
      Width = 467
      object btnClose: TRzBitBtn
        Left = 357
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
    DataSet = CdsList
    Left = 79
    Top = 170
  end
  object CdsList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 171
  end
end
