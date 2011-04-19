inherited frmLocusNoProperty: TfrmLocusNoProperty
  Left = 404
  Top = 180
  Caption = #25195#30721#35760#24405
  ClientHeight = 389
  ClientWidth = 462
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 462
    Height = 389
    inherited RzPage: TRzPageControl
      Width = 452
      Height = 339
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #25195#30721#35760#24405
        inherited RzPanel2: TRzPanel
          Width = 448
          Height = 312
          BorderInner = fsFlat
          object DBGridEh1: TDBGridEh
            Left = 6
            Top = 6
            Width = 436
            Height = 300
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = DataSource1
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 2
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            RowHeight = 17
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
            OnGetFooterParams = DBGridEh1GetFooterParams
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
                FieldName = 'LOCUS_NO'
                Footer.ValueType = fvtCount
                Footers = <>
                ReadOnly = True
                Title.Caption = #26465#30721
                Width = 270
              end
              item
                Alignment = taCenter
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                Title.Caption = #21333#20301
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
                Width = 41
              end
              item
                ButtonStyle = cbsEllipsis
                EditButtons = <>
                FieldName = 'AMOUNT'
                Footer.ValueType = fvtSum
                Footers = <>
                Title.Caption = #25968#37327
                Width = 56
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 344
      Width = 452
      object btnExit: TRzBitBtn
        Left = 340
        Top = 8
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnExitClick
        NumGlyphs = 2
        Spacing = 5
      end
      object RzBitBtn1: TRzBitBtn
        Left = 247
        Top = 8
        Width = 67
        Height = 26
        Caption = #21024#38500'(&D)'
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
        OnClick = RzBitBtn1Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object DataSource1: TDataSource
    Left = 326
    Top = 197
  end
end
