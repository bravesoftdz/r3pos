inherited frmJoinRelation: TfrmJoinRelation
  Left = 568
  Top = 220
  Caption = #30003#35831#20379#24212#38142
  ClientHeight = 351
  ClientWidth = 446
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 446
    Height = 351
    BorderColor = clWhite
    inherited RzPage: TRzPageControl
      Width = 436
      Height = 301
      BackgroundColor = clWhite
      Color = clWhite
      ParentBackgroundColor = False
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20379#24212#38142#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 432
          Height = 274
          BorderColor = clWhite
          Color = clWhite
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 422
            Height = 44
            Align = alTop
            BorderOuter = fsBump
            Color = clWhite
            TabOrder = 0
            object Label8: TLabel
              Left = 39
              Top = 17
              Width = 72
              Height = 12
              Caption = #19978#32423#20225#19994#21495#65306
            end
            object edtKey: TcxTextEdit
              Left = 113
              Top = 13
              Width = 196
              Height = 20
              TabOrder = 0
            end
            object btnFilter: TRzBitBtn
              Left = 320
              Top = 11
              Width = 59
              Height = 24
              Caption = #26597#25214'(&F5)'
              Color = 15791348
              HighlightColor = 16026986
              HotTrack = True
              HotTrackColor = 3983359
              TabOrder = 1
              NumGlyphs = 2
            end
          end
          object RzPanel3: TRzPanel
            Left = 5
            Top = 49
            Width = 422
            Height = 220
            Align = alClient
            BorderOuter = fsBump
            Color = clWhite
            TabOrder = 1
            object DBGridEh1: TDBGridEh
              Left = 2
              Top = 2
              Width = 418
              Height = 216
              Align = alClient
              DataSource = Ds_Telation
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              RowHeight = 20
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 18
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'TENANT_ID'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #20225#19994#32534#21495
                  Width = 80
                end
                item
                  EditButtons = <>
                  FieldName = 'RELATION_ID'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #20379#24212#38142#32534#21495
                  Width = 120
                end
                item
                  EditButtons = <>
                  FieldName = 'RELATION_NAME'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #20379#24212#38142#21517#31216
                  Width = 120
                end
                item
                  EditButtons = <>
                  FieldName = 'RELATION_SPELL'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #25340#38899#30721
                  Width = 80
                end>
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 306
      Width = 436
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 267
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30003#35831'(&S)'
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
        NumGlyphs = 2
        Spacing = 5
      end
      object btnClose: TRzBitBtn
        Left = 352
        Top = 9
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
        OnClick = btnCloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 8
    Top = 312
  end
  inherited actList: TActionList
    Left = 48
    Top = 312
  end
  object Cds_Relation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 85
    Top = 314
  end
  object Ds_Telation: TDataSource
    DataSet = Cds_Relation
    Left = 117
    Top = 314
  end
end
