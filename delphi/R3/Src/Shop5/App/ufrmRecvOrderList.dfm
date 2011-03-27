inherited frmRecvOrderList: TfrmRecvOrderList
  Left = 192
  Top = 106
  Width = 908
  Height = 600
  Caption = #25910#27454#21333
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 892
    Height = 526
    inherited RzPanel2: TRzPanel
      Width = 882
      Height = 516
      inherited RzPage: TRzPageControl
        Width = 876
        Height = 510
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #24212#25910#24080#27454#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 874
            Height = 483
            BorderInner = fsStatus
            object RzPanel6: TRzPanel
              Left = 6
              Top = 6
              Width = 862
              Height = 84
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object Label3: TLabel
                Left = 24
                Top = 33
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
                Caption = #25910#27454#26085#26399
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
                Top = 56
                Width = 48
                Height = 12
                Caption = #23458#25143#21517#31216
              end
              object P1_D1: TcxDateEdit
                Left = 80
                Top = 7
                Width = 97
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object P1_D2: TcxDateEdit
                Left = 205
                Top = 7
                Width = 98
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object btnOk: TRzBitBtn
                Left = 451
                Top = 41
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
                TabOrder = 2
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndP1_CUST_ID: TzrComboBoxList
                Left = 80
                Top = 52
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
                FilterFields = 'CUST_ID;CUST_NAME;CUST_SPELL;CUST_CODE'
                KeyField = 'CUST_ID'
                ListField = 'CUST_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CUST_CODE'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CUST_NAME'
                    Footers = <>
                    Title.Caption = #23458#25143#21517#31216
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SEX'
                    Footers = <>
                    Title.Caption = #24615#21035
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'FAMI_ADDR'
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
              object fndP1_SHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 29
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
                Left = 324
                Top = 2
                Width = 105
                Height = 71
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
            end
            object Panel1: TPanel
              Left = 6
              Top = 90
              Width = 862
              Height = 387
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 860
                Height = 385
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = RecvListDs
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
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                Columns = <
                  item
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    ReadOnly = True
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
                    ReadOnly = True
                    Title.Caption = #36134#27454#26085#26399
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CUST_ID_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #23458#25143#21517#31216
                    Width = 139
                  end
                  item
                    EditButtons = <>
                    FieldName = 'RECV_TYPE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #36134#27454#31867#22411
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_INFO'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25688#35201
                    Width = 208
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_MNY'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21512#35745#37329#39069
                    Width = 61
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'RECV_MNY'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #24050#25910#37329#39069
                    Width = 61
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'REVE_MNY'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20914#24080#37329#39069
                    Width = 61
                  end
                  item
                    EditButtons = <>
                    FieldName = 'RECK_MNY'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #32467#20313#37329#39069
                    Width = 61
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'NEAR_DATE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #26368#26032#25910#27454#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25152#23646#38376#24215
                    Width = 97
                  end>
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #25910#27454#21333#26597#35810
          object RzPanel1: TRzPanel
            Left = 0
            Top = 0
            Width = 874
            Height = 483
            Align = alClient
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object RzPanel7: TRzPanel
              Left = 6
              Top = 6
              Width = 862
              Height = 123
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
                Caption = #25910#27454#26085#26399
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
                Top = 93
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #25910' '#27454' '#20154
              end
              object Label5: TLabel
                Left = 210
                Top = 93
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #24080#25143#21517
              end
              object Label6: TLabel
                Left = 210
                Top = 73
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #31185#30446#21517
              end
              object Label17: TLabel
                Left = 24
                Top = 53
                Width = 48
                Height = 12
                Caption = #23458#25143#21517#31216
              end
              object Label1: TLabel
                Left = 26
                Top = 73
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #25910#27454#26041#24335
              end
              object Label40: TLabel
                Left = 24
                Top = 32
                Width = 48
                Height = 12
                Caption = #25910#27454#38376#24215
              end
              object D1: TcxDateEdit
                Left = 80
                Top = 7
                Width = 97
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 205
                Top = 7
                Width = 98
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object RzBitBtn1: TRzBitBtn
                Left = 517
                Top = 83
                Width = 67
                Height = 26
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
                TabOrder = 2
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
                Height = 80
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
                TabOrder = 3
                Caption = ''
              end
              object fndRECV_USER: TzrComboBoxList
                Left = 80
                Top = 89
                Width = 97
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
                Top = 89
                Width = 120
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
              object fndCLIENT_ID: TzrComboBoxList
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
                TabOrder = 6
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
                DropWidth = 296
                DropHeight = 220
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
                Top = 69
                Width = 97
                Height = 20
                Properties.DropDownListStyle = lsFixedList
                TabOrder = 7
              end
              object fndSHOP_ID: TzrComboBoxList
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
                TabOrder = 8
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
              object fndITEM_ID: TzrComboBoxList
                Left = 253
                Top = 69
                Width = 120
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 9
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
            end
            object Panel2: TPanel
              Left = 6
              Top = 129
              Width = 862
              Height = 348
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh2: TDBGridEh
                Left = 1
                Top = 1
                Width = 860
                Height = 346
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
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
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
                    ReadOnly = True
                    Title.Caption = #24207#21495
                    Width = 32
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GLIDE_NO'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25910#27454#21333#21495
                    Width = 77
                  end
                  item
                    EditButtons = <>
                    FieldName = 'RECV_DATE'
                    Footer.Value = #21512'   '#35745#65306
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25910#27454#26085#26399
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #23458#25143#21517#31216
                    Width = 153
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ACCOUNT_ID_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #24080#25143#21517#31216
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PAYM_ID'
                    Footers = <>
                    Title.Caption = #25910#27454#26041#24335
                    Width = 65
                  end
                  item
                    EditButtons = <>
                    FieldName = 'RECV_MNY'
                    Footers = <>
                    Title.Caption = #25910#27454#37329#39069
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ITEM_ID_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25910#25903#31185#30446
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    ReadOnly = True
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
                    FieldName = 'RECV_USER_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21046#21333#20154
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BILL_NO'
                    Footers = <>
                    Title.Caption = #31080#25454#32534#21495
                    Width = 78
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
    inherited Image1: TImage
      Left = 374
      Width = 498
    end
    inherited Image3: TImage
      Left = 374
      Width = 498
    end
    inherited Image14: TImage
      Left = 872
    end
    inherited rzPanel5: TPanel
      Left = 374
      inherited lblToolCaption: TRzLabel
        Width = 36
        Caption = #25910#27454#21333
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
          Caption = #25910#27454
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
    Left = 429
    Top = 234
  end
  object frfRecvOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfRecvOrderGetValue
    OnUserFunction = frfRecvOrderUserFunction
    Left = 176
    Top = 233
    ReportForm = {
      180000007C190000180000FFFF01000100FFFFFFFFFF00010000340800007805
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
      C3FBB3C65DCAD5BFEEB5A500000000FFFF000000000002000000010000000004
      00CBCECCE500100000000200000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000CA04000006004D656D6F313200020009020000
      4D00000046000000120000000300000001000000000000000000FFFFFF1F2E02
      000000000001000900CAD5BFEED5CABBA73A00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF00000000020000000000000000005205000006004D656D6F3332
      0002000A02000038000000440000001200000003000000010000000000000000
      00FFFFFF1F2E02000000000001000A00CAD5BFEEB5A5BAC5A3BA00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000002000000000008
      0000008600020000000000FFFFFF0000000002000000000000000000D8050000
      06004D656D6F3334000200E801000063000000480000001B00000003000F0001
      000000000000000000FFFFFF1F2E02000000000001000800CDF9C8D5CAD5BFEE
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
      000001000800BACFBCC6CAD5BFEE00000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000200000000000A0000008600020000000000FF
      FFFF0000000002000000000000000000F407000006004D656D6F3432000200BD
      0100003501000072000000140000000300000001000000000000000000FFFFFF
      1F2E02000000000001001000BFCDBBA7C7A9C3FB28B8C7D5C229A3BA00000000
      010000000000000200000001000000000400CBCECCE5000A0000000200FFFFFF
      1F080000008600020000000000FFFFFF00000000020000000000000000008908
      000006004D656D6F3434000200EA000000200100009400000014000000010000
      0001000000000000000000FFFFFF1F2E02000000000001001700C9F3BACBC8CB
      A3BA5B43484B5F555345525F544558545D000000000100000000000002000000
      01000000000400CBCECCE5000A0000000200FFFFFF1F08000000860002000000
      0000FFFFFF00000000020000000000000000001F09000006004D656D6F343100
      02003900000020010000A5000000140000000100000001000000000000000000
      FFFFFF1F2E02000000000001001800D6C6B5A5C8CBA3BA5B524543565F555345
      525F544558545D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000020000000000080000008600020000000000FFFFFF0000000002
      000000000000000000EC09000006004D656D6F34330002008900000008010000
      5F0100001700000003000F0001000000000000000000FFFFFF1F2E0200000000
      0001004F005B536D616C6C546F426967285B544F54414C5F524543565F4D4E59
      5D295D2020A3A43A5B666F726D6174466C6F6174282723302E3030272C5B544F
      54414C5F524543565F4D4E595D295D202020202000000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000008000000860002
      0000000000FFFFFF00000000020000000000000000006B0A000006004D656D6F
      353500020039000000630000001B0000001B00000003000F0001000000000000
      000000FFFFFF1F2E020000000000010001004100000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000A00000086000200
      00000000FFFFFF0000000002000000000000000000F00A000005004D656D6F37
      00020054000000630000004E0000001B00000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000800D5CBBFEEC8D5C6DA00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      000100020000000000FFFFFF0000000002000000000000000000860B00000600
      4D656D6F3234000200400200001B0000007E0000001300000003000000010000
      00000000000000FFFFFF1F2E02000000000001001800B5DA5B50414745235D2F
      5B544F54414C50414745535DD2B300000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000090000008600020000000000FF
      FFFF0000000002000000000000000000140C000006004D656D6F32360002007B
      00000038000000E0000000120000000300020001000000000000000000FFFFFF
      1F2E020000000000010010005B434C49454E545F49445F544558545D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000008600020000000000FFFFFF00000000020000000000000000009B0C
      000006004D656D6F323700020039000000380000004400000012000000030000
      0001000000000000000000FFFFFF1F2E02000000000001000900BFCDBBA7C3FB
      B3C63A00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      00000200000000000A0000008600020000000000FFFFFF000000000200000000
      0000000000490D000005004D656D6F31000200E8010000BE0000004800000014
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001003100
      5B666F726D6174466C6F6174282723302E3030272C5B41424C455F524543565F
      4D4E595D2D5B524543565F4D4E595D295D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000009000000860002000000
      0000FFFFFF0000000002000000000000000000D10D000005004D656D6F330002
      00A2000000BE000000FE0000001400000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000B005B414343545F494E464F5D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00008600020000000000FFFFFF00000000020000000000000000006F0E000005
      004D656D6F34000200A0010000BE000000480000001400000001000F00010000
      00000000000000FFFFFF1F2E020000000000010021005B666F726D6174466C6F
      6174282723302E3030272C5B414343545F4D4E595D295D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000009000000
      8600020000000000FFFFFF0000000002000000000000000000F30E000005004D
      656D6F3600020039000000BE0000001B0000001400000001000F000100000000
      0000000000FFFFFF1F2E020000000000010007005B5345514E4F5D00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000000000000000
      0A0000008600020000000000FFFFFF00000000020000000000000000007B0F00
      0005004D656D6F3800020054000000BE0000004E0000001400000001000F0001
      000000000000000000FFFFFF1F2E02000000000001000B005B41424C455F4441
      54455D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      00000000000000000A0000000100020000000000FFFFFF000000000200000000
      00000000000410000006004D656D6F3130000200AB010000380000005C000000
      120000000300020001000000000000000000FFFFFF1F2E02000000000001000B
      005B524543565F444154455D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A0000000000000000000A0000008600020000000000FFFFFF
      00000000020000000000000000008B10000006004D656D6F31310002005F0100
      00380000004C000000120000000300000001000000000000000000FFFFFF1F2E
      02000000000001000900CAD5BFEEC8D5C6DA3A00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000A00000086000200
      00000000FFFFFF00000000020000000000000000001111000006004D656D6F31
      340002007B0000004E0000008C01000012000000030002000100000000000000
      0000FFFFFF1F2E020000000000010008005B52454D41524B5D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00008600020000000000FFFFFF00000000020000000000000000009911000006
      004D656D6F3135000200390000004E0000004800000012000000030000000100
      0000000000000000FFFFFF1F2E02000000000001000A00B1B820202020D7A2A3
      BA00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0200000000000A0000008600020000000000FFFFFF0000000002000000000000
      0000001E12000005004D656D6F350002007802000063000000480000001B0000
      0003000F0001000000000000000000FFFFFF1F2E02000000000001000800BDE1
      D3E0C7B7BFEE00000000FFFF00000000000200000001000000000400CBCECCE5
      000A0000000200000000000A0000008600020000000000FFFFFF000000000200
      0000000000000000A412000006004D656D6F3133000200300200006300000048
      0000001B00000003000F0001000000000000000000FFFFFF1F2E020000000000
      01000800B1BEB5A5CAD5BFEE00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF
      00000000020000000000000000004313000006004D656D6F3139000200780200
      00BE000000480000001400000001000F0001000000000000000000FFFFFF1F2E
      020000000000010021005B666F726D6174466C6F6174282723302E3030272C5B
      5245434B5F4D4E595D295D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000090000008600020000000000FFFFFF00
      00000002000000000000000000E213000006004D656D6F323000020030020000
      BE000000480000001400000001000F0001000000000000000000FFFFFF1F2E02
      0000000000010021005B666F726D6174466C6F6174282723302E3030272C5B52
      4543565F4D4E595D295D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      0000020000000000000000008A14000006004D656D6F3136000200E801000008
      010000D80000001700000001000F0001000000000000000000FFFFFF1F2E0200
      0000000001002A00B1BED2B3D0A1BCC63A5B666F726D6174466C6F6174282723
      302E3030272C5B524543565F4D4E595D295D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000090000008600020000
      000000FFFFFF00000000020000000000000000001E15000006004D656D6F3137
      0002003A0000003B010000140100001200000003000000010000000000000000
      00FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D20
      5B54494D455D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000000000000100020000000000FFFFFF000000000200
      00000000000000009C15000006004D656D6F313800020030020000370100008C
      000000120000000300020001000000000000000000FFFFFF1F2E020000000000
      0100000000000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000000000000100020000000000FFFFFF0000000002000000
      0000000000001816000006004D656D6F3231000200E8010000E0000000480000
      001400000003000F0001000000000000000000FFFFFF1F2E0200000000000000
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000090000008600020000000000FFFFFF000000000200000000000000
      00009416000006004D656D6F3232000200A2000000E0000000FE000000140000
      0003000F0001000000000000000000FFFFFF1F2E020000000000000000000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000008600020000000000FFFFFF00000000020000000000000000001017
      000006004D656D6F3233000200A0010000E0000000480000001400000003000F
      0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF00000000020000000000000000008C1700000600
      4D656D6F323800020039000000E00000001B0000001400000003000F00010000
      00000000000000FFFFFF1F2E020000000000000000000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000000000000000A000000860002
      0000000000FFFFFF00000000020000000000000000000818000006004D656D6F
      323900020054000000E00000004E0000001400000003000F0001000000000000
      000000FFFFFF1F2E020000000000000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000A00000001000200000000
      00FFFFFF00000000020000000000000000008418000006004D656D6F33300002
      0078020000E0000000480000001400000003000F0001000000000000000000FF
      FFFF1F2E020000000000000000000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000090000008600020000000000FFFFFF
      00000000020000000000000000000219000006004D656D6F3331000200300200
      00E0000000480000001400000003000F0001000000000000000000FFFFFF1F2E
      0200000000000100000000000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      00000200000000000000FEFEFF060000000A00205661726961626C6573000000
      000200736C0014006364735F436867426F64792E22534C30303030220002006A
      650014006364735F436867426F64792E224A4530303030220004006B68796800
      000000040079687A68000000000200647A000000000000000000000000FDFF01
      00000000}
  end
  object cdsList: TZQuery
    FieldDefs = <>
    AfterScroll = cdsListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 399
    Top = 233
  end
  object CdsRecvList: TZQuery
    FieldDefs = <>
    AfterScroll = CdsRecvListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 79
    Top = 281
  end
  object RecvListDs: TDataSource
    DataSet = CdsRecvList
    Left = 109
    Top = 282
  end
end
