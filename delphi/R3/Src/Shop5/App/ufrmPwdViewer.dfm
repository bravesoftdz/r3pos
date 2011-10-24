inherited frmPwdViewer: TfrmPwdViewer
  Left = 467
  Top = 192
  Caption = #23494#30721#26597#30475#22120
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited RzPage: TRzPageControl
      Top = 64
      Height = 278
      Align = alNone
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #29992#25143#23494#30721#20449#24687
        inherited RzPanel2: TRzPanel
          Height = 251
          object dbGrid: TDBGridEh
            Left = 5
            Top = 5
            Width = 524
            Height = 241
            Align = alClient
            AllowedOperations = []
            DataSource = DsUsersPwd
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
            OnDrawColumnCell = dbGridDrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 30
              end
              item
                EditButtons = <>
                FieldName = 'SHOP_NAME'
                Footers = <>
                Title.Caption = #38376#24215#21517#31216
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'ACCOUNT'
                Footers = <>
                Title.Caption = #30331#24405#21517
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'USER_NAME'
                Footers = <>
                Title.Caption = #29992#25143#21517
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'USER_SPELL'
                Footers = <>
                Title.Caption = #25340#38899#30721
              end
              item
                EditButtons = <>
                FieldName = 'PASS_WRD'
                Footers = <>
                Title.Caption = #23494#30721
                Width = 80
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      object btnClose: TRzBitBtn
        Left = 445
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
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 538
      Height = 60
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      object RzLabel2: TRzLabel
        Left = 5
        Top = 12
        Width = 60
        Height = 12
        Caption = #20851#38190#23383#26597#35810
      end
      object RzLabel3: TRzLabel
        Left = 16
        Top = 39
        Width = 48
        Height = 12
        Caption = #25152#23646#38376#24215
      end
      object RzLabel5: TRzLabel
        Left = 269
        Top = 12
        Width = 247
        Height = 12
        Caption = #25903#25345#65288#29992#25143#22995#21517#12289#25340#38899#30721#12289#29992#25143#36134#21495#65289#26597#35810
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtKey: TcxTextEdit
        Left = 72
        Top = 7
        Width = 192
        Height = 20
        TabOrder = 0
      end
      object btnSearch: TRzBitBtn
        Left = 273
        Top = 31
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
        TabOrder = 2
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnSearchClick
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 72
        Top = 35
        Width = 192
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 1
        InGrid = False
        KeyValue = Null
        FilterFields = 'SHOP_NAME;SHOP_ID;SHOP_SPELL'
        KeyField = 'SHOP_ID'
        ListField = 'SHOP_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SHOP_NAME'
            Footers = <>
            Title.Caption = #23458#25143#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'SHOP_SPELL'
            Footers = <>
            Title.Caption = #23458#25143#21517#31216
            Width = 92
          end>
        DropWidth = 230
        DropHeight = 230
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
  object DsUsersPwd: TDataSource
    DataSet = CdsUsersPwd
    Left = 86
    Top = 223
  end
  object CdsUsersPwd: TZQuery
    FieldDefs = <>
    AfterScroll = CdsUsersPwdAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 54
    Top = 223
  end
end
