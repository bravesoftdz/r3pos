inherited frmFieldSort: TfrmFieldSort
  Left = 599
  Top = 214
  Caption = #23383#27573#25490#24207
  ClientHeight = 290
  ClientWidth = 296
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 296
    Height = 290
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 286
      Height = 240
      BackgroundColor = clWhite
      Color = clWhite
      UseColoredTabs = True
      ParentBackgroundColor = False
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #23383#27573#25490#24207
        inherited RzPanel2: TRzPanel
          Width = 282
          Height = 213
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 272
            Height = 203
            Align = alClient
            AutoFitColWidths = True
            DataSource = dsFieldSort
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 1
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection, dghEnterAsTab]
            PopupMenu = PopupMenu1
            RowHeight = 20
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
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQ_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Title.Color = clWhite
                Width = 36
              end
              item
                EditButtons = <>
                FieldName = 'CODE_NAME'
                Footers = <>
                Title.Caption = #31867#21035#21517#31216
                Title.Color = clWhite
                Width = 200
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 245
      Width = 286
      BorderColor = clWhite
      Color = clWhite
      object btnSave: TRzBitBtn
        Left = 139
        Top = 10
        Width = 67
        Height = 26
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
        OnClick = btnSaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 218
        Top = 10
        Width = 67
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
  inherited actList: TActionList
    object CtrUp: TAction
      Caption = #21521#19978
      OnExecute = CtrUpExecute
    end
    object CtrDown: TAction
      Caption = #21521#19979
      OnExecute = CtrDownExecute
    end
    object CtrHome: TAction
      Caption = #32622#39030
      OnExecute = CtrHomeExecute
    end
    object CtrEnd: TAction
      Caption = #32622#24213
      OnExecute = CtrEndExecute
    end
  end
  object dsFieldSort: TDataSource
    DataSet = cdsFieldSort
    Left = 46
    Top = 125
  end
  object PopupMenu1: TPopupMenu
    Left = 78
    Top = 125
    object N1: TMenuItem
      Action = CtrUp
    end
    object N2: TMenuItem
      Action = CtrDown
    end
    object N3: TMenuItem
      Action = CtrHome
    end
    object N4: TMenuItem
      Action = CtrEnd
    end
  end
  object cdsFieldSort: TZQuery
    FieldDefs = <
      item
        Name = 'SEQ_NO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CODE_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'CODE_NAME'
        DataType = ftString
        Size = 36
      end>
    CachedUpdates = True
    Params = <>
    Left = 14
    Top = 125
  end
end
