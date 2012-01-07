inherited frmPayOrderList: TfrmPayOrderList
  Left = 235
  Top = 155
  Width = 908
  Height = 600
  Caption = #20184#27454#21333
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 892
    Height = 525
    inherited RzPanel2: TRzPanel
      Width = 882
      Height = 515
      inherited RzPage: TRzPageControl
        Width = 876
        Height = 509
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #24212#20184#24080#27454#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 874
            Height = 482
            BorderInner = fsStatus
            object RzPanel1: TRzPanel
              Left = 6
              Top = 6
              Width = 862
              Height = 96
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object Label3: TLabel
                Left = 24
                Top = 32
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object RzLabel2: TRzLabel
                Left = 24
                Top = 11
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36134#27454#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 186
                Top = 11
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label2: TLabel
                Left = 24
                Top = 74
                Width = 48
                Height = 12
                Caption = #20379' '#24212' '#21830
              end
              object Label8: TLabel
                Left = 24
                Top = 53
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object P1_D1: TcxDateEdit
                Left = 80
                Top = 7
                Width = 97
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object P1_D2: TcxDateEdit
                Left = 205
                Top = 7
                Width = 98
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object btnOk: TRzBitBtn
                Left = 435
                Top = 57
                Width = 67
                Height = 32
                Action = actFind
                Caption = #26597#35810
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
                TabOrder = 6
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndP1_SHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 28
                Width = 223
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
              object fndSTATUS: TcxRadioGroup
                Left = 316
                Top = 2
                Width = 105
                Height = 87
                ItemIndex = 1
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #26410#32467#28165
                  end
                  item
                    Caption = #24050#32467#28165
                  end>
                TabOrder = 5
                Caption = #29366#24577
              end
              object fndP1_CLIENT_ID: TzrComboBoxList
                Left = 80
                Top = 70
                Width = 223
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
              object fndP1_DEPT_ID: TzrComboBoxList
                Left = 80
                Top = 49
                Width = 223
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 3
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
            object Panel3: TPanel
              Left = 6
              Top = 102
              Width = 862
              Height = 374
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 860
                Height = 372
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = PayListDs
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
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
                ReadOnly = True
                RowHeight = 20
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
                OnDblClick = actInfoExecute
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                Columns = <
                  item
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 32
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'ABLE_DATE'
                    Footer.Value = #21512'   '#35745#65306
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    Title.Caption = #36134#27454#26085#26399
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #20379#24212#21830#21517#31216
                    Width = 135
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ABLE_TYPE'
                    Footers = <>
                    Title.Caption = #36134#27454#31867#22411
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_INFO'
                    Footers = <>
                    Title.Caption = #25688#35201
                    Width = 188
                  end
                  item
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'ACCT_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #21512#35745#37329#39069
                    Width = 66
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'PAYM_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #24050#20184#37329#39069
                    Width = 65
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'REVE_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #20914#36134#37329#39069
                    Width = 66
                  end
                  item
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'RECK_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #32467#20313#37329#39069
                    Width = 63
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'NEAR_DATE'
                    Footers = <>
                    Title.Caption = #26368#26032#20184#27454#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID_TEXT'
                    Footers = <>
                    Title.Caption = #25152#23646#38376#24215
                    Width = 97
                  end>
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #20184#27454#21333#26597#35810
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 874
            Height = 482
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvNone
            BorderWidth = 5
            Caption = ' '
            TabOrder = 0
            object RzPanel7: TRzPanel
              Left = 6
              Top = 6
              Width = 862
              Height = 129
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object RzLabel4: TRzLabel
                Left = 24
                Top = 11
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20184#27454#26085#26399
              end
              object RzLabel5: TRzLabel
                Left = 186
                Top = 11
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label4: TLabel
                Left = 26
                Top = 106
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20184' '#27454' '#20154
              end
              object Label5: TLabel
                Left = 210
                Top = 106
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #24080#25143#21517
              end
              object Label6: TLabel
                Left = 210
                Top = 87
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #31185#30446#21517
              end
              object Label17: TLabel
                Left = 13
                Top = 68
                Width = 60
                Height = 12
                Caption = #20379#24212#21830#21517#31216
              end
              object Label1: TLabel
                Left = 26
                Top = 87
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20184#27454#26041#24335
              end
              object Label40: TLabel
                Left = 24
                Top = 30
                Width = 48
                Height = 12
                Caption = #20184#27454#38376#24215
              end
              object Label7: TLabel
                Left = 24
                Top = 48
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object D1: TcxDateEdit
                Left = 80
                Top = 7
                Width = 97
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 205
                Top = 7
                Width = 98
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object RzBitBtn1: TRzBitBtn
                Left = 517
                Top = 89
                Width = 67
                Height = 29
                Action = actFind
                Caption = #26597#35810
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
                TabOrder = 10
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndOrderStatus: TcxRadioGroup
                Left = 396
                Top = 29
                Width = 105
                Height = 92
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end>
                TabOrder = 9
                Caption = ''
              end
              object fndPAY_USER: TzrComboBoxList
                Left = 80
                Top = 102
                Width = 97
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 7
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
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndACCOUNT_ID: TzrComboBoxList
                Left = 253
                Top = 102
                Width = 120
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 8
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
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndITEM_ID: TzrComboBoxList
                Left = 253
                Top = 83
                Width = 120
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
                FilterFields = 'CODE_NAME;CODE_SPELL'
                KeyField = 'CODE_ID'
                ListField = 'CODE_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CODE_NAME'
                    Footers = <>
                    Title.Caption = #24080#25143#21517#31216
                    Width = 60
                  end>
                DropWidth = 157
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndCLIENT_ID: TzrComboBoxList
                Left = 80
                Top = 64
                Width = 223
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
              object fndPAYM_ID: TcxComboBox
                Left = 80
                Top = 83
                Width = 97
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsFixedList
                TabOrder = 5
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 26
                Width = 223
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
                    FieldName = 'SEQ_NO'
                    Footers = <>
                    Title.Caption = #24207#21495
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
                Left = 80
                Top = 45
                Width = 223
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 3
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
            object Panel2: TPanel
              Left = 6
              Top = 135
              Width = 862
              Height = 341
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh2: TDBGridEh
                Left = 1
                Top = 1
                Width = 860
                Height = 339
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = DataSource2
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FrozenCols = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
                ReadOnly = True
                RowHeight = 20
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
                OnDblClick = actInfoExecute
                OnDrawColumnCell = DBGridEh2DrawColumnCell
                Columns = <
                  item
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'SEQ_NO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 32
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GLIDE_NO'
                    Footers = <>
                    Title.Caption = #20184#27454#21333#21495
                    Width = 77
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PAY_DATE'
                    Footer.Value = #21512'   '#35745#65306
                    Footers = <>
                    Title.Caption = #20184#27454#26085#26399
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #20379#24212#21830#21517#31216
                    Width = 153
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ACCOUNT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #24080#25143#21517#31216
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PAYM_ID'
                    Footers = <>
                    Title.Caption = #20184#27454#26041#24335
                    Width = 65
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PAY_MNY'
                    Footers = <>
                    Title.Caption = #20184#27454#37329#39069
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ITEM_ID_TEXT'
                    Footers = <>
                    Title.Caption = #25910#25903#31185#30446
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Caption = #35828#26126
                    Width = 129
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_USER_TEXT'
                    Footers = <>
                    Title.Caption = #23457#26680#20154
                    Width = 58
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_DATE'
                    Footers = <>
                    Title.Caption = #23457#26680#26085#26399
                    Width = 63
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'PAY_USER_TEXT'
                    Footers = <>
                    Title.Caption = #20184#27454#20154
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BILL_NO'
                    Footers = <>
                    Title.Caption = #31080#25454#32534#21495
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_DATE'
                    Footers = <>
                    Title.Caption = #21046#21333#26102#38388
                    Width = 130
                  end>
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 892
    inherited Image3: TImage
      Left = 374
      Width = 0
    end
    inherited Image14: TImage
      Left = 872
    end
    inherited Image1: TImage
      Left = 366
      Width = 506
    end
    inherited rzPanel5: TPanel
      Left = 374
      inherited lblToolCaption: TRzLabel
        Width = 36
        Caption = #20184#27454#21333
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 354
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 354
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 354
        ButtonWidth = 43
        object ToolButton2: TToolButton
          Left = 0
          Top = 0
          Action = actNew
          Caption = #20184#27454
        end
        object ToolButton4: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
          Caption = #20462#25913
        end
        object ToolButton1: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
          Caption = #35814#32454
        end
        object ToolButton5: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton7: TToolButton
          Left = 172
          Top = 0
          Width = 10
          Caption = 'ToolButton7'
          ImageIndex = 3
          Style = tbsDivider
        end
        object ToolButton8: TToolButton
          Left = 182
          Top = 0
          Action = actAudit
        end
        object ToolButton3: TToolButton
          Left = 225
          Top = 0
          Action = actPrint
        end
        object ToolButton6: TToolButton
          Left = 268
          Top = 0
          Action = actPreview
        end
        object ToolButton10: TToolButton
          Left = 311
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 112
    Top = 232
  end
  inherited actList: TActionList
    Left = 144
    Top = 232
    inherited actNew: TAction
      OnExecute = actNewExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
    inherited actEdit: TAction
      OnExecute = actEditExecute
    end
    inherited actPrint: TAction
      OnExecute = actPrintExecute
    end
    inherited actPreview: TAction
      OnExecute = actPreviewExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    inherited actAudit: TAction
      OnExecute = actAuditExecute
    end
    object actfrmBatchReck: TAction
      Caption = #25910#38134#32467#36134
    end
  end
  object DataSource2: TDataSource
    DataSet = cdsList
    Left = 253
    Top = 266
  end
  object cdsList: TZQuery
    FieldDefs = <>
    AfterScroll = cdsListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 255
    Top = 225
  end
  object frfPayOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfPayOrderGetValue
    OnUserFunction = frfPayOrderUserFunction
    Left = 488
    Top = 201
    ReportForm = {
      1800000066190000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00BE000000F6020000140000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      500100000700B7D6D7E9CDB7310002010000000018000000F602000066000000
      3200100001000000000000000000FFFFFF1F000000001300696E7428285B5345
      514E4F5D2D31292F31352900000000000000FFFF000000000002000000010000
      000000000001000000C8000000140000000100000000000002003A0200000700
      B7D6D7E9BDC5310002010000000008010000F602000047000000300011000100
      0000000000000000FFFFFF1F0000000000000000000008000500626567696E0D
      1E0020696620436F756E74284D61737465724461746131293C3134207468656E
      0D060020626567696E0D260020202020666F7220693A3D436F756E74284D6173
      74657244617461312920746F20313320646F0D15002020202053686F7742616E
      64284368696C6431293B0D050020656E643B0D00000D0300656E6400FFFF0000
      00000002000000010000000000000001000000C8000000140000000100000000
      00000200A002000006004368696C643100020100000000E0000000F602000014
      0000003000150001000000000000000000FFFFFF1F0000000000000000000000
      00000100000000000002000000010000000000000001000000C8000000140000
      000100000000000000002E03000005004D656D6F390002004B0200004D000000
      74000000120000000300020001000000000000000000FFFFFF1F2E0200000000
      00010011005B4143434F554E545F49445F544558545D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF0000000002000000000000000000B603000006004D65
      6D6F353800020051020000380000006E00000012000000030002000100000000
      0000000000FFFFFF1F2E02000000000001000A005B474C4944455F4E4F5D0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000000000008600020000000000FFFFFF0000000002000000000000000000
      4304000005004D656D6F320002003A0000001D00000081020000180000000300
      000001000000000000000500FFFFFF1F2E020000000000010010005BC6F3D2B5
      C3FBB3C65DB8B6BFEEB5A500000000FFFF000000000002000000010000000004
      00CBCECCE500100000000200000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000CA04000006004D656D6F313200020009020000
      4D00000046000000120000000300000001000000000000000000FFFFFF1F2E02
      000000000001000900B8B6BFEED5CABBA73A00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF00000000020000000000000000005205000006004D656D6F3332
      0002000A02000038000000440000001200000003000000010000000000000000
      00FFFFFF1F2E02000000000001000A00B8B6BFEEB5A5BAC5A3BA00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000002000000000008
      0000008600020000000000FFFFFF0000000002000000000000000000D8050000
      06004D656D6F3334000200E801000063000000480000001B00000003000F0001
      000000000000000000FFFFFF1F2E02000000000001000800CDF9C8D5B8B6BFEE
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      00005A06000006004D656D6F3336000200A200000063000000FE0000001B0000
      0003000F0001000000000000000000FFFFFF1F2E02000000000001000400D5AA
      D2AA00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      000200000000000A0000008600020000000000FFFFFF00000000020000000000
      00000000E006000006004D656D6F3337000200A001000063000000480000001B
      00000003000F0001000000000000000000FFFFFF1F2E02000000000001000800
      D5CBBFEEBDF0B6EE00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000200000000000A0000008600020000000000FFFFFF00000000
      020000000000000000006607000006004D656D6F323500020039000000080100
      00500000001700000003000F0001000000000000000000FFFFFF1F2E02000000
      000001000800BACFBCC6B8B6BFEE00000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000200000000000A0000008600020000000000FF
      FFFF0000000002000000000000000000EA07000006004D656D6F3432000200FD
      0100002901000032000000140000000300000001000000000000000000FFFFFF
      1F2E02000000000001000600B2C6CEF1A3BA0000000001000000000000020000
      0001000000000400CBCECCE5000A0000000200FFFFFF1F080000008600020000
      000000FFFFFF00000000020000000000000000007F08000006004D656D6F3434
      000200EA00000020010000940000001400000001000000010000000000000000
      00FFFFFF1F2E02000000000001001700C9F3BACBC8CBA3BA5B43484B5F555345
      525F544558545D00000000010000000000000200000001000000000400CBCECC
      E5000A0000000200FFFFFF1F080000008600020000000000FFFFFF0000000002
      0000000000000000001409000006004D656D6F34310002003900000020010000
      A5000000140000000100000001000000000000000000FFFFFF1F2E0200000000
      0001001700D6C6B5A5C8CBA3BA5B5041595F555345525F544558545D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      00080000008600020000000000FFFFFF0000000002000000000000000000DF09
      000006004D656D6F343300020089000000080100005F0100001700000003000F
      0001000000000000000000FFFFFF1F2E02000000000001004D005B536D616C6C
      546F426967285B544F54414C5F5041595F4D4E595D295D2020A3A43A5B666F72
      6D6174466C6F6174282723302E3030272C5B544F54414C5F5041595F4D4E595D
      295D202020202000000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000080000008600020000000000FFFFFF0000000002
      0000000000000000005E0A000006004D656D6F35350002003900000063000000
      1B0000001B00000003000F0001000000000000000000FFFFFF1F2E0200000000
      00010001004100000000FFFF00000000000200000001000000000400CBCECCE5
      000A0000000200000000000A0000008600020000000000FFFFFF000000000200
      0000000000000000E30A000005004D656D6F3700020054000000630000004E00
      00001B00000003000F0001000000000000000000FFFFFF1F2E02000000000001
      000800D5CBBFEEC8D5C6DA00000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF00
      00000002000000000000000000790B000006004D656D6F323400020040020000
      1B0000007E000000130000000300000001000000000000000000FFFFFF1F2E02
      000000000001001800B5DA5B50414745235D2F5B544F54414C50414745535DD2
      B300000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      000000070C000006004D656D6F32360002007B00000038000000E00000001200
      00000300020001000000000000000000FFFFFF1F2E020000000000010010005B
      434C49454E545F49445F544558545D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000080000008600020000000000
      FFFFFF00000000020000000000000000008C0C000006004D656D6F3237000200
      390000003800000044000000120000000300000001000000000000000000FFFF
      FF1F2E02000000000001000700B9A9D3A6C9CC3A00000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000380D000005004D656D6F
      31000200E8010000BE000000480000001400000001000F000100000000000000
      0000FFFFFF1F2E02000000000001002F005B666F726D6174466C6F6174282723
      302E3030272C5B41424C455F5041595F4D4E595D2D5B5041595F4D4E595D295D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000090000008600020000000000FFFFFF000000000200000000000000
      0000C00D000005004D656D6F33000200A2000000BE000000FE00000014000000
      01000F0001000000000000000000FFFFFF1F2E02000000000001000B005B4143
      43545F494E464F5D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000080000008600020000000000FFFFFF00000000
      020000000000000000005E0E000005004D656D6F34000200A0010000BE000000
      480000001400000001000F0001000000000000000000FFFFFF1F2E0200000000
      00010021005B666F726D6174466C6F6174282723302E3030272C5B414343545F
      4D4E595D295D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000090000008600020000000000FFFFFF000000000200
      0000000000000000E20E000005004D656D6F3600020039000000BE0000001B00
      00001400000001000F0001000000000000000000FFFFFF1F2E02000000000001
      0007005B5345514E4F5D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000000000000000A0000008600020000000000FFFFFF0000
      0000020000000000000000006A0F000005004D656D6F3800020054000000BE00
      00004E0000001400000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000B005B41424C455F444154455D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000000000000000A0000000100020000
      000000FFFFFF0000000002000000000000000000F20F000006004D656D6F3130
      000200AB010000380000005C0000001200000003000200010000000000000000
      00FFFFFF1F2E02000000000001000A005B5041595F444154455D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000000000000000A
      0000008600020000000000FFFFFF000000000200000000000000000079100000
      06004D656D6F31310002005F010000380000004C000000120000000300000001
      000000000000000000FFFFFF1F2E02000000000001000900B8B6BFEEC8D5C6DA
      3A00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0200000000000A0000008600020000000000FFFFFF0000000002000000000000
      000000FF10000006004D656D6F31340002007B0000004E0000008C0100001200
      00000300020001000000000000000000FFFFFF1F2E020000000000010008005B
      52454D41524B5D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000080000008600020000000000FFFFFF0000000002
      0000000000000000008511000006004D656D6F3135000200390000004E000000
      48000000120000000300000001000000000000000000FFFFFF1F2E0200000000
      0001000800B1B82020D7A2A3BA00000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000200000000000A0000008600020000000000FFFF
      FF00000000020000000000000000000A12000005004D656D6F35000200780200
      0063000000480000001B00000003000F0001000000000000000000FFFFFF1F2E
      02000000000001000800BDE1D3E0C7B7BFEE00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF00000000020000000000000000009012000006004D656D6F3133
      0002003002000063000000480000001B00000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000800B1BEB5A5B8B6BFEE00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      008600020000000000FFFFFF00000000020000000000000000002F1300000600
      4D656D6F313900020078020000BE000000480000001400000001000F00010000
      00000000000000FFFFFF1F2E020000000000010021005B666F726D6174466C6F
      6174282723302E3030272C5B5245434B5F4D4E595D295D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000009000000
      8600020000000000FFFFFF0000000002000000000000000000CD13000006004D
      656D6F323000020030020000BE000000480000001400000001000F0001000000
      000000000000FFFFFF1F2E020000000000010020005B666F726D6174466C6F61
      74282723302E3030272C5B5041595F4D4E595D295D00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000090000008600
      020000000000FFFFFF00000000020000000000000000007414000006004D656D
      6F3136000200E801000008010000D80000001700000001000F00010000000000
      00000000FFFFFF1F2E02000000000001002900B1BED2B3D0A1BCC63A5B666F72
      6D6174466C6F6174282723302E3030272C5B5041595F4D4E595D295D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00090000008600020000000000FFFFFF00000000020000000000000000000815
      000006004D656D6F31370002003A0000003B0100001401000012000000030000
      0001000000000000000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1
      BCE43A5B444154455D205B54494D455D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000000000001000200000000
      00FFFFFF00000000020000000000000000008615000006004D656D6F31380002
      00300200002B0100008C000000120000000300020001000000000000000000FF
      FFFF1F2E0200000000000100000000000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000000000000100020000000000FF
      FFFF00000000020000000000000000000216000006004D656D6F3231000200E8
      010000E0000000480000001400000003000F0001000000000000000000FFFFFF
      1F2E020000000000000000000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      0000020000000000000000007E16000006004D656D6F3232000200A2000000E0
      000000FE0000001400000003000F0001000000000000000000FFFFFF1F2E0200
      00000000000000000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000008600020000000000FFFFFF000000000200
      0000000000000000FA16000006004D656D6F3233000200A0010000E000000048
      0000001400000003000F0001000000000000000000FFFFFF1F2E020000000000
      000000000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000090000008600020000000000FFFFFF00000000020000000000
      000000007617000006004D656D6F323800020039000000E00000001B00000014
      00000003000F0001000000000000000000FFFFFF1F2E02000000000000000000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      0000000A0000008600020000000000FFFFFF0000000002000000000000000000
      F217000006004D656D6F323900020054000000E00000004E0000001400000003
      000F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000000000000000A
      0000000100020000000000FFFFFF00000000020000000000000000006E180000
      06004D656D6F333000020078020000E0000000480000001400000003000F0001
      000000000000000000FFFFFF1F2E020000000000000000000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000900000086
      00020000000000FFFFFF0000000002000000000000000000EC18000006004D65
      6D6F333100020030020000E0000000480000001400000003000F000100000000
      0000000000FFFFFF1F2E0200000000000100000000000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000009000000860002
      0000000000FFFFFF000000000200000000000000FEFEFF060000000A00205661
      726961626C6573000000000200736C0014006364735F436867426F64792E2253
      4C30303030220002006A650014006364735F436867426F64792E224A45303030
      30220004006B68796800000000040079687A68000000000200647A0000000000
      00000000000000FDFF0100000000}
  end
  object CdsPayList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 79
    Top = 281
  end
  object PayListDs: TDataSource
    DataSet = CdsPayList
    Left = 109
    Top = 282
  end
end
