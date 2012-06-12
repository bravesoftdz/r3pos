inherited frmPosMainList: TfrmPosMainList
  Left = 358
  Top = 187
  Caption = #38144#21806#21333#26597#35810
  ClientHeight = 421
  ClientWidth = 576
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 576
    Height = 421
    inherited RzPage: TRzPageControl
      Top = 102
      Width = 566
      Height = 274
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #38144#21806#21333#21015#34920
        inherited RzPanel2: TRzPanel
          Width = 562
          Height = 247
          Color = clWhite
          object dbGrid: TDBGridEh
            Left = 5
            Top = 5
            Width = 552
            Height = 237
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
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
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
            OnDblClick = dbGridDblClick
            OnDrawColumnCell = dbGridDrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 27
              end
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
                Width = 75
              end
              item
                EditButtons = <>
                FieldName = 'CREA_USER_TEXT'
                Footers = <>
                Title.Caption = #25910#38134#21592
                Width = 47
              end
              item
                EditButtons = <>
                FieldName = 'SALE_AMT'
                Footers = <>
                Title.Caption = #38144#21806#25968#37327
                Width = 57
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
                Width = 127
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 376
      Width = 566
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
        Top = 10
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
      Width = 566
      Height = 97
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      object RzLabel1: TRzLabel
        Left = 16
        Top = 3
        Width = 48
        Height = 12
        Caption = #38144#21806#26085#26399
      end
      object RzLabel2: TRzLabel
        Left = 16
        Top = 80
        Width = 48
        Height = 12
        Caption = #38144#21806#21333#21495
      end
      object RzLabel3: TRzLabel
        Left = 16
        Top = 59
        Width = 48
        Height = 12
        Caption = #20250#21592#22995#21517
      end
      object RzLabel4: TRzLabel
        Left = 185
        Top = 3
        Width = 12
        Height = 12
        Caption = #33267
      end
      object RzLabel5: TRzLabel
        Left = 216
        Top = 81
        Width = 91
        Height = 12
        Caption = #25903#25345#21518#22235#20301#26597#35810
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label40: TLabel
        Left = 16
        Top = 22
        Width = 48
        Height = 12
        Caption = #38376#24215#21517#31216
      end
      object Label3: TLabel
        Left = 16
        Top = 41
        Width = 48
        Height = 12
        Caption = #25152#23646#37096#38376
      end
      object D1: TcxDateEdit
        Left = 72
        Top = -1
        Width = 110
        Height = 20
        TabOrder = 0
      end
      object D2: TcxDateEdit
        Left = 201
        Top = -1
        Width = 110
        Height = 20
        TabOrder = 1
      end
      object edtSALES_ID: TcxTextEdit
        Left = 72
        Top = 75
        Width = 133
        Height = 20
        TabOrder = 3
      end
      object btnSearch: TRzBitBtn
        Left = 332
        Top = 72
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
        TabOrder = 4
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnSearchClick
      end
      object edtCustomerID: TzrComboBoxList
        Left = 72
        Top = 56
        Width = 239
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 2
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
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = #23458#25143#21517#31216
            Width = 130
          end>
        DropWidth = 314
        DropHeight = 239
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object fndSHOP_ID: TzrComboBoxList
        Tag = -1
        Left = 72
        Top = 18
        Width = 239
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 5
        InGrid = False
        KeyValue = Null
        FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
        KeyField = 'SHOP_ID'
        ListField = 'SHOP_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SHOP_NAME'
            Footers = <>
            Title.Caption = #21517#31216
          end
          item
            EditButtons = <>
            FieldName = 'SHOP_ID'
            Footers = <>
            Title.Caption = #20195#30721
            Width = 20
          end>
        DropWidth = 185
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object fndDEPT_ID: TzrComboBoxList
        Left = 72
        Top = 37
        Width = 239
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 6
        InGrid = False
        KeyValue = Null
        FilterFields = 'DEPT_NAME;DEPT_SPELL'
        KeyField = 'DEPT_ID'
        ListField = 'DEPT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DEPT_NAME'
            Footers = <>
            Title.Caption = #21517#31216
          end>
        DropWidth = 185
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 144
    Top = 120
  end
  inherited actList: TActionList
    Left = 176
    Top = 120
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
