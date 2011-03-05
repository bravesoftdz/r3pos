inherited frmIoroOrder: TfrmIoroOrder
  Left = 383
  Top = 243
  ActiveControl = edtCLIENT_ID
  Caption = #20854#20182#36153#29992
  ClientHeight = 367
  ClientWidth = 535
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 535
    Height = 367
    BorderColor = clWhite
    inherited RzPage: TRzPageControl
      Top = 89
      Width = 525
      Height = 233
      BackgroundColor = clWhite
      Color = clWhite
      ParentBackgroundColor = False
      ParentColor = False
      TabOrder = 1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #25910#25903#26126#32454
        inherited RzPanel2: TRzPanel
          Width = 521
          Height = 206
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 511
            Height = 196
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
            FooterRowCount = 1
            FrozenCols = 1
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu1
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
            OnKeyPress = DBGridEh1KeyPress
            OnMouseDown = DBGridEh1MouseDown
            Columns = <
              item
                Color = clBtnFace
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                EditButtons = <>
                FieldName = 'ACCOUNT_ID_TEXT'
                Footer.Value = #21512'   '#35745#65306
                Footer.ValueType = fvtStaticText
                Footers = <>
                Title.Caption = #39033#30446#21517#31216
                Width = 127
                Control = edtACCOUNT_ID
                OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
              end
              item
                EditButtons = <>
                FieldName = 'IORO_INFO'
                Footers = <>
                Title.Caption = #25688#35201
                Width = 225
                OnUpdateData = DBGridEh1Columns2UpdateData
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'IORO_MNY'
                Footer.ValueType = fvtSum
                Footers = <>
                Title.Caption = #37329#39069
                Width = 76
                OnUpdateData = DBGridEh1Columns3UpdateData
              end>
          end
          object edtACCOUNT_ID: TzrComboBoxList
            Left = 68
            Top = 52
            Width = 141
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 1
            Visible = False
            OnEnter = edtACCOUNT_IDEnter
            OnExit = edtACCOUNT_IDExit
            OnKeyPress = edtACCOUNT_IDKeyPress
            InGrid = False
            KeyValue = Null
            FilterFields = 'ACCOUNT_ID;ACCT_NAME;ACCT_SPELL'
            KeyField = 'ACCOUNT_ID'
            ListField = 'ACCT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'ACCT_NAME'
                Footers = <>
                Title.Caption = #24080#25143#21517#31216
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'ACCOUNT_ID'
                Footers = <>
                Title.Caption = #24080#25143#20195#30721
                Width = 30
              end>
            DropWidth = 157
            DropHeight = 180
            ShowTitle = True
            AutoFitColWidth = True
            OnAddClick = edtACCOUNT_IDAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            OnSaveValue = edtACCOUNT_IDSaveValue
            MultiSelect = False
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 322
      Width = 525
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 2
      object btnOk: TRzBitBtn
        Left = 315
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
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
      object btnClose: TRzBitBtn
        Left = 416
        Top = 9
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
        OnClick = btnCloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object Panel1: TPanel
      Left = 5
      Top = 5
      Width = 525
      Height = 84
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Label1: TLabel
        Left = 38
        Top = 32
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #25910#25903#31185#30446
      end
      object Label3: TLabel
        Left = 354
        Top = 56
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #36127#36131#20154
      end
      object Label5: TLabel
        Left = 366
        Top = 8
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #21333#21495
      end
      object Label6: TLabel
        Left = 366
        Top = 32
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #26085#26399
      end
      object Label7: TLabel
        Left = 62
        Top = 57
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #35828#26126
      end
      object Label2: TLabel
        Left = 38
        Top = 7
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #24448#26469#21333#20301
      end
      object edtGLIDE_NO: TcxTextEdit
        Tag = 1
        Left = 396
        Top = 3
        Width = 121
        Height = 20
        TabStop = False
        Properties.OnChange = edtGLIDE_NOPropertiesChange
        TabOrder = 0
      end
      object edtVOUC_DATE: TcxDateEdit
        Left = 396
        Top = 27
        Width = 121
        Height = 20
        Properties.OnChange = edtVOUC_DATEPropertiesChange
        TabOrder = 2
      end
      object edtIORO_USER: TzrComboBoxList
        Left = 396
        Top = 51
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 4
        InGrid = False
        KeyValue = Null
        FilterFields = 'ACCOUNT;USER_NAME'
        KeyField = 'USER_ID'
        ListField = 'USER_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ACCOUNT'
            Footers = <>
            Title.Caption = #24080#21495
          end
          item
            EditButtons = <>
            FieldName = 'USER_NAME'
            Footers = <>
            Title.Caption = #22995#21517
            Width = 130
          end>
        DropWidth = 180
        DropHeight = 150
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtIORO_USERSaveValue
        MultiSelect = False
      end
      object edtREMARK: TcxTextEdit
        Left = 92
        Top = 52
        Width = 237
        Height = 20
        Properties.OnChange = edtREMARKPropertiesChange
        TabOrder = 3
      end
      object edtCLIENT_ID: TzrComboBoxList
        Left = 92
        Top = 3
        Width = 237
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 1
        InGrid = False
        KeyValue = Null
        FilterFields = 'CLIENT_NAME;CLIENT_SPELL;CLIENT_CODE'
        KeyField = 'CLIENT_ID'
        ListField = 'CLIENT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CLIENT_ID'
            Footers = <>
            Title.Caption = #24080#21495
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_CODE'
            Footers = <>
            Title.Caption = #22995#21517
            Visible = False
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = #21333#20301#21517
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_SPELL'
            Footers = <>
            Visible = False
          end>
        DropWidth = 180
        DropHeight = 150
        ShowTitle = True
        AutoFitColWidth = True
        OnAddClick = edtCLIENT_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtCLIENT_IDSaveValue
        MultiSelect = False
      end
      object edtITEM_ID: TzrComboBoxList
        Left = 92
        Top = 28
        Width = 141
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 5
        Visible = False
        OnKeyDown = edtITEM_IDKeyDown
        OnKeyPress = edtITEM_IDKeyPress
        InGrid = True
        KeyValue = Null
        FilterFields = 'ITEM_NAME;LEVEL_ID;ITEM_SPELL'
        KeyField = 'ITEM_ID'
        ListField = 'ITEM_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ITEM_TYPE'
            Footers = <>
            KeyList.Strings = (
              '1'
              '2')
            PickList.Strings = (
              #25910#20837
              #25903#20986)
            Title.Caption = #31867#22411
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'ITEM_NAME'
            Footers = <>
            Title.Caption = #31185#30446#21517#31216
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'LEVEL_ID'
            Footers = <>
            Title.Caption = #31185#30446#20195#30721
            Width = 56
          end>
        DropWidth = 180
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtITEM_IDSaveValue
        MultiSelect = False
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 88
    Top = 184
  end
  inherited actList: TActionList
    Left = 88
    Top = 216
  end
  object DataSource1: TDataSource
    DataSet = cdsDetail
    Left = 118
    Top = 249
  end
  object PopupMenu1: TPopupMenu
    Left = 86
    Top = 249
    object N1: TMenuItem
      Caption = #21024#38500#26126#32454
      ShortCut = 16430
      OnClick = N1Click
    end
  end
  object cdsHeader: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 118
    Top = 185
  end
  object cdsDetail: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 118
    Top = 217
  end
end
