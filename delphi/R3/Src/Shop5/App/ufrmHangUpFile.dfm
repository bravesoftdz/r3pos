inherited frmHangUpFile: TfrmHangUpFile
  Left = 563
  Top = 250
  ActiveControl = DBGridEh1
  Caption = #25346#26426#25991#20214
  ClientHeight = 291
  ClientWidth = 294
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 294
    Height = 291
    inherited RzPage: TRzPageControl
      Width = 284
      Height = 241
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 280
          Height = 237
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 270
            Height = 227
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            AutoFitColWidths = True
            DataSource = DataSource1
            Flat = True
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 1
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            ParentFont = False
            RowHeight = 25
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = [fsBold]
            UseMultiTitle = True
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            OnGetCellParams = DBGridEh1GetCellParams
            OnKeyPress = DBGridEh1KeyPress
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                EditButtons = <>
                FieldName = 'FILENAME'
                Footer.ValueType = fvtCount
                Footers = <>
                ReadOnly = True
                Tag = 1
                Title.Caption = #25346#21333#21495
                Width = 214
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 246
      Width = 284
      object btnOk: TRzBitBtn
        Left = 114
        Top = 9
        Width = 67
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
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object RzBitBtn2: TRzBitBtn
        Left = 201
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #21462#28040'(&C)'
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
    Left = 248
    Top = 184
  end
  inherited actList: TActionList
    Left = 248
    Top = 136
  end
  object cdsTable: TADODataSet
    Parameters = <>
    Left = 168
    Top = 88
    object cdsTableID: TStringField
      FieldName = 'FILENAME'
      Size = 100
    end
    object cdsTableSEQNO: TIntegerField
      FieldName = 'SEQNO'
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsTable
    Left = 200
    Top = 88
  end
end
