inherited frmPosMainList: TfrmPosMainList
  Left = 414
  Top = 174
  Caption = #38144#21806#21333#26597#35810
  ClientHeight = 421
  ClientWidth = 505
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 505
    Height = 421
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 83
      Width = 495
      Height = 293
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #38144#21806#21333#21015#34920
        inherited RzPanel2: TRzPanel
          Width = 491
          Height = 266
          BorderColor = clWhite
          Color = clWhite
          object dbGrid: TDBGridEh
            Left = 5
            Top = 5
            Width = 481
            Height = 256
            Align = alClient
            AllowedOperations = []
            DataSource = DsSales
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 2
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
            Columns = <
              item
                EditButtons = <>
                FieldName = 'GLIDE_NO'
                Footers = <>
                Title.Caption = #38144#21806#21333#21495
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'SALES_DATE'
                Footers = <>
                Title.Caption = #38144#21806#26085#26399
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'CREA_USER_TEXT'
                Footers = <>
                Title.Caption = #25910#38134#21592
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'SALE_AMT'
                Footers = <>
                Title.Caption = #38144#21806#25968#37327
              end
              item
                EditButtons = <>
                FieldName = 'SALE_MNY'
                Footers = <>
                Title.Caption = #38144#21806#37329#39069
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_ID_TEXT'
                Footers = <>
                Title.Caption = #20250#21592#22995#21517
                Width = 80
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 376
      Width = 495
      Color = clWhite
      object btnClose: TRzBitBtn
        Left = 419
        Top = 10
        Caption = #20851#38381'(&C)'
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
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
      end
      object RzBitBtn1: TRzBitBtn
        Left = 323
        Top = 9
        Caption = #30830#23450'(&O)'
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
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
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 495
      Height = 78
      Align = alTop
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 2
      object RzLabel1: TRzLabel
        Left = 16
        Top = 8
        Width = 48
        Height = 12
        Caption = #38144#21806#26085#26399
      end
      object RzLabel2: TRzLabel
        Left = 16
        Top = 56
        Width = 48
        Height = 12
        Caption = #38144#21806#21333#21495
      end
      object RzLabel3: TRzLabel
        Left = 16
        Top = 30
        Width = 48
        Height = 12
        Caption = #20250#21592#22995#21517
      end
      object RzLabel4: TRzLabel
        Left = 197
        Top = 8
        Width = 12
        Height = 12
        Caption = #33267
      end
      object RzLabel5: TRzLabel
        Left = 200
        Top = 56
        Width = 84
        Height = 12
        Caption = #36755#20837#21518#22235#20301#26597#35810
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object D1: TcxDateEdit
        Left = 72
        Top = 4
        Width = 121
        Height = 20
        TabOrder = 0
      end
      object D2: TcxDateEdit
        Left = 213
        Top = 4
        Width = 121
        Height = 20
        TabOrder = 1
      end
      object edtSALES_ID: TcxTextEdit
        Left = 72
        Top = 51
        Width = 121
        Height = 20
        TabOrder = 2
      end
      object btnSearch: TRzBitBtn
        Left = 340
        Top = 48
        Height = 26
        Caption = #26597#35810'(&F)'
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
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
        TabOrder = 3
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnSearchClick
      end
      object edtCustomerID: TzrComboBoxList
        Left = 72
        Top = 27
        Width = 262
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 4
        InGrid = False
        KeyValue = Null
        FilterFields = 'CLIENT_NAME;CLIENT_SPELL;CLIENT_CODE;LICENSE_CODE;TELEPHONE2'
        KeyField = 'CLIENT_ID'
        ListField = 'CLIENT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CLIENT_CODE'
            Footers = <>
            Title.Caption = #23458#25143#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = #23458#25143#21517#31216
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'LINKMAN'
            Footers = <>
            Title.Caption = #32852#31995#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'TELEPHONE2'
            Footers = <>
            Title.Caption = #32852#31995#30005#35805
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'LICENSE_CODE'
            Footers = <>
            Title.Caption = #35777#20214#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ADDRESS'
            Footers = <>
            Title.Caption = #22320#22336
            Width = 150
          end>
        DropWidth = 314
        DropHeight = 281
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
  end
  object CdsSales: TZQuery
    FieldDefs = <>
    AfterScroll = CdsSalesAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 54
    Top = 223
  end
  object DsSales: TDataSource
    DataSet = CdsSales
    Left = 86
    Top = 223
  end
end
