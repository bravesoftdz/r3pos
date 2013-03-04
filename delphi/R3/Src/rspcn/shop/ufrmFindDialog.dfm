inherited frmFindDialog: TfrmFindDialog
  Caption = 'frmFindDialog'
  ClientWidth = 451
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlAddressBar: TPanel
    Width = 451
    inherited Image1: TImage
      Left = -102
    end
    inherited Image3: TImage
      Width = 719
    end
    inherited RzFormShape1: TRzFormShape
      Width = 451
    end
    inherited RzBmpButton2: TRzBmpButton
      Left = 426
    end
    object RzPanel2: TRzPanel
      Left = 12
      Top = 25
      Width = 279
      Height = 23
      BorderOuter = fsFlatRounded
      TabOrder = 1
      object findText: TcxTextEdit
        Left = 0
        Top = 0
        Width = 280
        Height = 23
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Text = #35831#36755#20837#25628#32034#20869#23481
      end
    end
    object RzBitBtn2: TRzBitBtn
      Left = 302
      Top = 23
      Width = 67
      Height = 26
      Anchors = [akTop]
      Caption = #30830#35748'(&O)'
      Color = 15461355
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      HighlightColor = 14276036
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      ParentFont = False
      TextShadowColor = clWhite
      TextShadowDepth = 4
      TabOrder = 2
      TabStop = False
      ThemeAware = False
      OnClick = RzBitBtn2Click
      NumGlyphs = 2
      Spacing = 5
    end
    object RzBitBtn1: TRzBitBtn
      Left = 371
      Top = 23
      Width = 67
      Height = 26
      Anchors = [akTop]
      Caption = #21462#28040'(&C)'
      Color = 15461355
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      HighlightColor = 14276036
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      ParentFont = False
      TextShadowColor = clWhite
      TextShadowDepth = 4
      TabOrder = 3
      TabStop = False
      ThemeAware = False
      OnClick = RzBitBtn1Click
      NumGlyphs = 2
      Spacing = 5
    end
  end
  inherited RzPanel1: TRzPanel
    Width = 451
    object DBGridEh1: TDBGridEh
      Left = 1
      Top = 0
      Width = 449
      Height = 289
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopAppendEh]
      AutoFitColWidths = True
      DataSource = DataSource1
      FixedColor = clSilver
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clBlack
      FooterFont.Height = -15
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FrozenCols = 2
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection]
      RowHeight = 25
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -15
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      TitleHeight = 30
      UseMultiTitle = True
      IsDrawNullRow = False
      CurrencySymbol = #65509
      DecimalNumber = 2
      DigitalNumber = 12
      OnDrawColumnCell = DBGridEh1DrawColumnCell
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SEQNO'
          Footers = <>
          ReadOnly = True
          Tag = 1
          Title.Caption = #24207#21495
          Width = 30
        end
        item
          EditButtons = <>
          FieldName = 'CODE_ID'
          Footers = <>
          ReadOnly = True
          Tag = 1
          Title.Caption = #32534#30721
          Width = 123
        end
        item
          EditButtons = <>
          FieldName = 'CODE_NAME'
          Footers = <>
          Title.Caption = #36873#39033#21517#31216
          Width = 260
        end>
    end
  end
  inherited RzPanel6: TRzPanel
    Width = 451
    inherited Image7: TImage
      Left = 370
    end
    inherited Image8: TImage
      Width = 289
    end
  end
  object rs: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 112
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = rs
    Left = 144
    Top = 120
  end
end
