inherited frmFindRequOrder: TfrmFindRequOrder
  Left = 536
  Top = 191
  Caption = #26597#25214#30003#39046#21333
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited RzPage: TRzPageControl
      Top = 91
      Height = 251
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        inherited RzPanel2: TRzPanel
          Height = 224
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 524
            Height = 214
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            Color = clWhite
            DataSource = dsList
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
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
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'GLIDE_NO'
                Footers = <>
                Title.Caption = #27969#27700#21495
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_ID_TEXT'
                Footers = <>
                Title.Caption = #38144#21806#21830
                Width = 140
              end
              item
                EditButtons = <>
                FieldName = 'SHOP_ID_TEXT'
                Footers = <>
                Title.Caption = #38376#24215#21517#31216
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'DEPT_ID_TEXT'
                Footers = <>
                Title.Caption = #25152#23646#37096#38376
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'REQU_TYPE'
                Footers = <>
                Title.Caption = #36153#29992#31867#22411
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'BUDG_MNY'
                Footers = <>
                Title.Caption = #24066#22330#36153
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'REQU_USER_TEXT'
                Footers = <>
                Title.Caption = #22635#25253#20154
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'REQU_DATE'
                Footers = <>
                Title.Caption = #22635#25253#26085#26399
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'REMARK'
                Footers = <>
                Title.Caption = #22791#27880
                Width = 200
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      object btnOK: TRzBitBtn
        Left = 380
        Top = 7
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
        Left = 467
        Top = 7
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
      Width = 538
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
        Caption = #30003#39046#26085#26399
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
        Caption = #32463' '#38144' '#21830
      end
      object Label40: TLabel
        Left = 25
        Top = 25
        Width = 48
        Height = 12
        Caption = #30003#25253#38376#24215
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
  object cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 350
    Top = 192
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 192
  end
end
