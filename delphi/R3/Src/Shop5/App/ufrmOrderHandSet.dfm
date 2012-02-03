inherited frmOrderHandSet: TfrmOrderHandSet
  Left = 342
  Top = 149
  ActiveControl = DBGridEh1
  Caption = #35746#21333#25163#24037#32467#26696
  ClientHeight = 364
  ClientWidth = 519
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 519
    Height = 364
    inherited RzPage: TRzPageControl
      Width = 509
      Height = 314
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #35746#21333#21015#34920
        inherited RzPanel2: TRzPanel
          Width = 505
          Height = 287
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 495
            Height = 277
            Align = alClient
            AllowedOperations = []
            DataSource = dsList
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
            ReadOnly = True
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
            OnDblClick = DBGridEh1DblClick
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 17
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'BILL_DATE'
                Footers = <>
                Title.Caption = #26085#26399
                Width = 68
              end
              item
                EditButtons = <>
                FieldName = 'GLIDE_NO'
                Footers = <>
                Title.Caption = #21333#21495
                Width = 89
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_NAME'
                Footers = <>
                Title.Caption = #23458#25143#21517#31216
                Width = 135
              end
              item
                EditButtons = <>
                FieldName = 'ADVA_MNY'
                Footers = <>
                Title.Caption = #39044#25910#27454
                Width = 59
              end
              item
                EditButtons = <>
                FieldName = 'SHOP_NAME'
                Footers = <>
                Title.Caption = #38376#24215#21517#31216
                Width = 120
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 319
      Width = 509
      object LblMsg: TLabel
        Left = 6
        Top = 6
        Width = 124
        Height = 12
        Caption = #35831#36873#25321#35201#32467#26696#30340#35746#21333'!'
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnOK: TRzBitBtn
        Left = 316
        Top = 6
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&O)'
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
        OnClick = btnOKClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 396
        Top = 6
        Width = 70
        Height = 26
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
        OnClick = btnExitClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 264
    Top = 176
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 192
  end
  object cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 350
    Top = 192
  end
end
