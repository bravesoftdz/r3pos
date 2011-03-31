inherited frmPublishMessage: TfrmPublishMessage
  Left = 463
  Top = 197
  Caption = #21457#24067#38376#24215
  ClientHeight = 368
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Height = 368
    inherited RzPage: TRzPageControl
      Height = 318
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #24050#21457#24067#38376#24215
        inherited RzPanel2: TRzPanel
          Height = 291
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 525
            Height = 281
            Align = alClient
            DataSource = ShopList
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
            PopupMenu = PopupMenu1
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
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            OnGetCellParams = DBGridEh1GetCellParams
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQ_NO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'SHOP_ID'
                Footers = <>
                Title.Caption = #38376#24215#20195#30721
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'SHOP_NAME'
                Footers = <>
                Title.Caption = #38376#24215#21517#31216
                Width = 125
              end
              item
                EditButtons = <>
                FieldName = 'SHOP_TYPE'
                Footers = <>
                Title.Caption = #38376#24215#31867#22411
              end
              item
                EditButtons = <>
                FieldName = 'REGION_ID'
                Footers = <>
                Title.Caption = #29255#21306
                Width = 65
              end
              item
                EditButtons = <>
                FieldName = 'LINKMAN'
                Footers = <>
                Title.Caption = #36127#36131#20154
                Width = 51
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'TELEPHONE'
                Footers = <>
                Title.Caption = #30005#35805
                Width = 78
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'FAXES'
                Footers = <>
                Title.Caption = #20256#30495
                Width = 86
              end
              item
                EditButtons = <>
                FieldName = 'ADDRESS'
                Footers = <>
                Title.Caption = #22320#22336
                Width = 215
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'POSTALCODE'
                Footers = <>
                Title.Caption = #37038#32534
                Width = 55
              end
              item
                EditButtons = <>
                FieldName = 'REMARK'
                Footers = <>
                Title.Caption = #22791#27880
                Width = 123
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 323
      object btnOk: TRzBitBtn
        Left = 353
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #25764#28040#38376#24215
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
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object RzBitBtn2: TRzBitBtn
        Left = 443
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20851#38381
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
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    object N1: TMenuItem
    end
  end
  object ShopList: TDataSource
    DataSet = cdsShop
    Left = 475
    Top = 97
  end
  object cdsShop: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 446
    Top = 101
  end
  object PopupMenu1: TPopupMenu
    Left = 78
    Top = 165
  end
end
