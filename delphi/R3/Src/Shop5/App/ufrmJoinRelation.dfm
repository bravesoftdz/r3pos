inherited frmJoinRelation: TfrmJoinRelation
  Left = 425
  Top = 200
  Caption = #30003#35831#20379#24212#38142
  ClientHeight = 287
  ClientWidth = 387
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 387
    Height = 287
    BorderColor = clWhite
    inherited RzPage: TRzPageControl
      Width = 377
      Height = 237
      BackgroundColor = clWhite
      Color = clWhite
      ParentBackgroundColor = False
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20379#24212#38142#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 373
          Height = 210
          BorderColor = clWhite
          Color = clWhite
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 363
            Height = 36
            Align = alTop
            BorderOuter = fsBump
            Color = clWhite
            TabOrder = 0
            object Label8: TLabel
              Left = 25
              Top = 14
              Width = 72
              Height = 12
              Caption = #19978#32423#20225#19994#21495#65306
            end
            object edtKey: TcxTextEdit
              Left = 99
              Top = 10
              Width = 128
              Height = 20
              TabOrder = 0
            end
            object btnFilter: TRzBitBtn
              Left = 234
              Top = 8
              Width = 59
              Height = 24
              Caption = #26597#25214'(&F5)'
              Color = 15791348
              HighlightColor = 16026986
              HotTrack = True
              HotTrackColor = 3983359
              TabOrder = 1
              OnClick = btnFilterClick
              NumGlyphs = 2
            end
          end
          object RzPanel3: TRzPanel
            Left = 5
            Top = 41
            Width = 363
            Height = 164
            Align = alClient
            BorderOuter = fsBump
            Color = clWhite
            TabOrder = 1
            object DBGridEh1: TDBGridEh
              Left = 2
              Top = 2
              Width = 359
              Height = 160
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
              ReadOnly = True
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
                  FieldName = 'RELATION_ID'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #20379#24212#38142#32534#21495
                  Width = 66
                end
                item
                  EditButtons = <>
                  FieldName = 'RELATION_NAME'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #20379#24212#38142#21517#31216
                  Width = 93
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #35828#26126
                  Width = 173
                end>
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 242
      Width = 377
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 208
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
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnClose: TRzBitBtn
        Left = 293
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
    Left = 224
    Top = 120
  end
  inherited actList: TActionList
    Left = 264
    Top = 120
  end
  object Cds_Relation: TZQuery
    FieldDefs = <
      item
        Name = 'TENANT_ID'
        DataType = ftInteger
      end
      item
        Name = 'RELATION_ID'
        DataType = ftInteger
      end
      item
        Name = 'RELATION_NAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'REMARK'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'RELATION_SPELL'
        DataType = ftString
        Size = 50
      end>
    CachedUpdates = True
    Params = <>
    Left = 301
    Top = 122
  end
  object Ds_Telation: TDataSource
    DataSet = Cds_Relation
    Left = 333
    Top = 122
  end
end
