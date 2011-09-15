inherited frmFindOrder: TfrmFindOrder
  Left = 348
  ActiveControl = DBGridEh1
  Caption = #21333#25454#26597#35810
  ClientWidth = 492
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 492
    inherited RzPage: TRzPageControl
      Top = 91
      Width = 482
      Height = 251
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #26597#35810#21015#34920
        inherited RzPanel2: TRzPanel
          Width = 478
          Height = 224
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 468
            Height = 214
            Align = alClient
            AllowedOperations = []
            DataSource = dsList
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
            OnDblClick = DBGridEh1DblClick
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 27
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'INDE_DATE'
                Footers = <>
                Title.Caption = #26085#26399
                Width = 68
              end
              item
                EditButtons = <>
                FieldName = 'GLIDE_NO'
                Footers = <>
                Title.Caption = #21333#21495
                Width = 89
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_NAME'
                Footers = <>
                Title.Caption = #23458#25143#21517#31216
                Width = 130
              end
              item
                EditButtons = <>
                FieldName = 'AMOUNT'
                Footers = <>
                Title.Caption = #25968#37327
                Width = 57
              end
              item
                EditButtons = <>
                FieldName = 'AMONEY'
                Footers = <>
                Title.Caption = #37329#39069
                Width = 63
              end
              item
                EditButtons = <>
                FieldName = 'SHOP_NAME'
                Footers = <>
                Title.Caption = #20179#24211#21517#31216
                Width = 120
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Width = 482
      object btnOK: TRzBitBtn
        Left = 285
        Top = 6
        Width = 70
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
        OnClick = btnOKClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 372
        Top = 6
        Width = 70
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
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 482
      Height = 86
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      object RzLabel2: TRzLabel
        Left = 25
        Top = 5
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #19994#21153#26085#26399
      end
      object RzLabel3: TRzLabel
        Left = 192
        Top = 5
        Width = 12
        Height = 12
        Caption = #33267
      end
      object RzLabel5: TRzLabel
        Left = 25
        Top = 64
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #27969#27700#21333#21495
      end
      object Label1: TLabel
        Left = 193
        Top = 65
        Width = 120
        Height = 12
        Caption = #25903#25345#27169#22359','#36755#21518'4'#20301#26597#35810
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel4: TRzLabel
        Left = 25
        Top = 45
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #20379' '#24212' '#21830
      end
      object Label40: TLabel
        Left = 25
        Top = 25
        Width = 48
        Height = 12
        Caption = #25152#23646#38376#24215
      end
      object D1: TcxDateEdit
        Left = 81
        Top = 1
        Width = 104
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 0
      end
      object D2: TcxDateEdit
        Left = 208
        Top = 1
        Width = 109
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 1
      end
      object fndGLIDE_NO: TcxTextEdit
        Left = 81
        Top = 61
        Width = 104
        Height = 20
        TabOrder = 2
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object btnFind: TRzBitBtn
        Left = 336
        Top = 56
        Width = 67
        Height = 26
        Caption = #26597#35810'(&F)'
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
        TabOrder = 3
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnFindClick
        ImageIndex = 12
        NumGlyphs = 2
        Spacing = 5
      end
      object fndCLIENT_ID: TzrComboBoxList
        Left = 81
        Top = 41
        Width = 236
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
        FilterFields = 'CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
        KeyField = 'CLIENT_ID'
        ListField = 'CLIENT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CLIENT_CODE'
            Footers = <>
            Title.Caption = #20195#30721
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = #20379#24212#21830#21517#31216
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
        DropWidth = 236
        DropHeight = 180
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
        Left = 81
        Top = 21
        Width = 236
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
    end
  end
  inherited mmMenu: TMainMenu
    Left = 264
    Top = 176
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 192
  end
  object cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    AfterScroll = cdsListAfterScroll
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 350
    Top = 192
  end
end
