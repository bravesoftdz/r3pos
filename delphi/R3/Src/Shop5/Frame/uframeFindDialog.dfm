inherited frameFindDialog: TframeFindDialog
  Left = 484
  Top = 304
  BorderStyle = bsDialog
  Caption = #26597#25214#23545#35805#26694
  ClientHeight = 252
  ClientWidth = 343
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object bgPanel: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 343
    Height = 252
    Align = alClient
    BorderOuter = fsNone
    BorderWidth = 5
    TabOrder = 0
    object RzPage: TRzPageControl
      Left = 5
      Top = 5
      Width = 333
      Height = 202
      ActivePage = TabSheet1
      Align = alClient
      TabHeight = 20
      TabIndex = 0
      TabOrder = 0
      TabStyle = tsRoundCorners
      FixedDimension = 20
      object TabSheet1: TRzTabSheet
        Caption = #26597#25214#26465#20214
        object RzPanel2: TRzPanel
          Left = 0
          Top = 0
          Width = 329
          Height = 175
          Align = alClient
          BorderOuter = fsNone
          BorderWidth = 5
          TabOrder = 0
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 319
            Height = 165
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            AutoFitColWidths = True
            DataSource = DataSource1
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 1
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            RowHeight = 23
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
            OnGetFooterParams = DBGridEh1GetFooterParams
            Columns = <
              item
                EditButtons = <>
                FieldName = 'FileTitle'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21517#31216
                Width = 103
              end
              item
                EditButtons = <>
                FieldName = 'FieldValue'
                Footers = <>
                Title.Caption = #26597#25214#20869#23481
                Width = 206
              end>
          end
        end
      end
    end
    object btPanel: TRzPanel
      Left = 5
      Top = 207
      Width = 333
      Height = 40
      Align = alBottom
      BorderOuter = fsNone
      TabOrder = 1
      DesignSize = (
        333
        40)
      object btnOk: TRzBitBtn
        Left = 157
        Top = 7
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #26597#25214'(&F)'
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
        Left = 245
        Top = 7
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
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object cdsFind: TADODataSet
    Parameters = <>
    Left = 78
    Top = 117
    object cdsFindFieldName: TStringField
      FieldName = 'FieldName'
      Size = 50
    end
    object cdsFindFileTitle: TStringField
      FieldName = 'FieldTitle'
      Size = 100
    end
    object cdsFindFieldValue: TStringField
      FieldName = 'FieldValue'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsFind
    Left = 110
    Top = 117
  end
end
