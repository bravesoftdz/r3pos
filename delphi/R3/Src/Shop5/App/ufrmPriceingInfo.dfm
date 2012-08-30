inherited frmPriceingInfo: TfrmPriceingInfo
  Left = 428
  Top = 194
  Caption = #21464#20215#35760#24405
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited RzPage: TRzPageControl
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          object DBGridEh1: TDBGridEh
            Tag = -1
            Left = 5
            Top = 5
            Width = 524
            Height = 300
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            Color = clWhite
            DataSource = dsList
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
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 22
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'PRICING_DATE'
                Footer.Value = #21512#35745#65306
                Footer.ValueType = fvtStaticText
                Footers = <>
                ReadOnly = True
                Title.Caption = #21464#20215#26085#26399
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21830#21697#32534#30721
                Width = 60
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
                FieldName = 'UNIT_ID'
                Footers = <>
                Title.Caption = #21333#20301
                Width = 28
              end
              item
                EditButtons = <>
                FieldName = 'PRICE_METHOD'
                Footers = <>
                Title.Caption = #23450#20215#26041#24335
                Width = 60
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'ORG_OUTPRICE'
                Footers = <>
                Title.Caption = #35843#25972#21069#21806#20215
                Width = 70
              end
              item
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'NEW_OUTPRICE'
                Footers = <>
                Title.Caption = #35843#25972#21518#21806#20215
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'PRICING_USER_TEXT'
                Footers = <>
                Title.Caption = #25805#20316#21592
                Width = 60
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      object btnClose: TRzBitBtn
        Left = 463
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
  object cdsList: TZQuery
    SortedFields = 'PRICING_DATE'
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'PRICING_DATE Asc'
    Left = 206
    Top = 176
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 238
    Top = 176
  end
end
