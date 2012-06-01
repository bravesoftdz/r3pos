inherited frmFvchFrame: TfrmFvchFrame
  Left = 581
  Top = 161
  Caption = #20973#35777#27169#22359#21015#34920
  ClientHeight = 380
  ClientWidth = 382
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 382
    Height = 380
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 372
      Height = 330
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = #20973#35777#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 368
          Height = 326
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 358
            Height = 316
            Align = alClient
            AllowedOperations = []
            AutoFitColWidths = True
            DataSource = DsFrame
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 1
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection, dghEnterAsTab]
            ReadOnly = True
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
            OnCellClick = DBGridEh1CellClick
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQ_NO'
                Footers = <>
                Title.Caption = #24207#21495
                Title.Color = clWhite
                Width = 36
              end
              item
                EditButtons = <>
                FieldName = 'FVCH_GTYPE_NAME'
                Footers = <>
                Title.Caption = #21333#25454#31867#22411
                Title.Color = clWhite
                Width = 150
              end
              item
                Alignment = taCenter
                EditButtons = <>
                FieldName = 'SUM_FVCH_GTYPE'
                Footers = <>
                KeyList.Strings = (
                  '0'
                  '1')
                PickList.Strings = (
                  #27809#26377
                  #26377)
                Title.Caption = #29366#24577
                Title.Color = clWhite
                Width = 87
              end
              item
                EditButtons = <>
                FieldName = 'EDIT_INFO'
                Footers = <>
                Title.Caption = #25805#20316
                Title.Color = clWhite
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 335
      Width = 372
      Color = clWhite
      object btnClose: TRzBitBtn
        Left = 284
        Top = 10
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
  object CdsFrame: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 30
    Top = 245
  end
  object DsFrame: TDataSource
    DataSet = CdsFrame
    Left = 62
    Top = 245
  end
end
