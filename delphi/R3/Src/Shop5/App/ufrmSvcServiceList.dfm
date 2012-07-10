inherited frmSvcServiceList: TfrmSvcServiceList
  Left = 299
  Top = 146
  Width = 908
  Height = 549
  Caption = #21806#21518#26381#21153
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 900
    Height = 485
    inherited RzPanel2: TRzPanel
      Width = 890
      Height = 475
      inherited RzPage: TRzPageControl
        Width = 884
        Height = 469
        ActivePage = TabSheet2
        TabIndex = 1
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38144#21806#35760#24405#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 882
            Height = 442
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 872
              Height = 432
              Align = alClient
              BorderInner = fsStatus
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object RzPanel6: TRzPanel
                Left = 6
                Top = 6
                Width = 860
                Height = 101
                Align = alTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 5
                Color = clWhite
                TabOrder = 0
                object Label3: TLabel
                  Left = 208
                  Top = 55
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object RzLabel2: TRzLabel
                  Left = 24
                  Top = 9
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26085#26399
                end
                object RzLabel3: TRzLabel
                  Left = 186
                  Top = 9
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label2: TLabel
                  Left = 24
                  Top = 77
                  Width = 48
                  Height = 12
                  Caption = #23458#25143#21517#31216
                end
                object Label8: TLabel
                  Left = 24
                  Top = 55
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object RzLabel5: TRzLabel
                  Left = 24
                  Top = 32
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #27969#27700#21333#21495
                end
                object Label1: TLabel
                  Left = 208
                  Top = 34
                  Width = 126
                  Height = 12
                  Caption = #25903#25345#38144#21806#21333#21495#21518'4'#20301#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label6: TLabel
                  Left = 207
                  Top = 78
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26041#24335
                end
                object P1_D1: TcxDateEdit
                  Left = 80
                  Top = 5
                  Width = 97
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 205
                  Top = 5
                  Width = 98
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object btnOk: TRzBitBtn
                  Left = 504
                  Top = 67
                  Width = 67
                  Height = 27
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
                  TabOrder = 8
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 264
                  Top = 51
                  Width = 121
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
                  Left = 391
                  Top = 9
                  Width = 105
                  Height = 85
                  ItemIndex = 0
                  Properties.Items = <
                    item
                      Caption = #20840#37096
                    end
                    item
                      Caption = #26410#30331#35760
                    end
                    item
                      Caption = #37096#20998#30331#35760
                    end
                    item
                      Caption = #23436#25104#30331#35760
                    end>
                  TabOrder = 7
                  Caption = #29366#24577
                end
                object fndP1_CUST_ID: TzrComboBoxList
                  Left = 80
                  Top = 74
                  Width = 121
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
                object fndP1_DEPT_ID: TzrComboBoxList
                  Left = 80
                  Top = 51
                  Width = 121
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
                object fndSALES_ID: TcxTextEdit
                  Left = 80
                  Top = 28
                  Width = 121
                  Height = 20
                  TabOrder = 2
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object fndSALES_STYLE: TzrComboBoxList
                  Left = 264
                  Top = 74
                  Width = 121
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
                  FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
                  KeyField = 'CODE_ID'
                  ListField = 'CODE_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'CODE_NAME'
                      Footers = <>
                      Title.Caption = #23610#30721#32452
                      Width = 121
                    end>
                  DropWidth = 121
                  DropHeight = 120
                  ShowTitle = False
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
              end
              object Panel1: TPanel
                Left = 6
                Top = 107
                Width = 860
                Height = 319
                Align = alClient
                Caption = 'Panel1'
                TabOrder = 1
                object DBGridEh1: TDBGridEh
                  Left = 1
                  Top = 1
                  Width = 858
                  Height = 317
                  Align = alClient
                  AllowedOperations = [alopUpdateEh]
                  Color = clWhite
                  DataSource = DsSalesList
                  Flat = True
                  FooterColor = clWindow
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 1
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
                      Title.Caption = #24207#21495
                      Width = 29
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GLIDE_NO'
                      Footer.Alignment = taRightJustify
                      Footer.Value = #21512'  '#35745':'
                      Footer.ValueType = fvtStaticText
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #21333#21495
                      Width = 100
                    end
                    item
                      DisplayFormat = '0000-00-00'
                      EditButtons = <>
                      FieldName = 'SALES_DATE'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #38144#21806#26085#26399
                      Width = 67
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 150
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CLIENT_NAME'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #23458#25143#21517#31216
                      Width = 150
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_ID_TEXT'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #38376#24215#21517#31216
                      Width = 120
                    end
                    item
                      EditButtons = <>
                      FieldName = 'INVOICE_FLAG'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #31080#25454#31867#22411
                      Visible = False
                      Width = 70
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'AMOUNT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25968#37327
                      Width = 70
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GUIDE_USER_TEXT'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #23548#36141#21592
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'STATUS'
                      Footers = <>
                      Title.Caption = #29366#24577
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      FieldName = 'REMARK'
                      Footers = <>
                      Title.Caption = #22791#27880
                      Width = 150
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CREA_USER_TEXT'
                      Footers = <>
                      Title.Caption = #21046#21333#21592
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CREA_DATE'
                      Footers = <>
                      Title.Caption = #24405#20837#26102#38388
                      Width = 120
                    end>
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #26381#21153#35760#24405#26597#35810
          object RzPanel7: TRzPanel
            Left = 0
            Top = 0
            Width = 882
            Height = 442
            Align = alClient
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object RzPanel8: TRzPanel
              Left = 6
              Top = 6
              Width = 870
              Height = 111
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object RzLabel4: TRzLabel
                Left = 24
                Top = 8
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #21463#29702#26085#26399
              end
              object RzLabel1: TRzLabel
                Left = 186
                Top = 8
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label4: TLabel
                Left = 36
                Top = 50
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #30331#35760#20154
              end
              object Label17: TLabel
                Left = 24
                Top = 29
                Width = 48
                Height = 12
                Caption = #23458#25143#21517#31216
              end
              object RzLabel6: TRzLabel
                Left = 36
                Top = 71
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #24207#21015#21495
              end
              object RzLabel7: TRzLabel
                Left = 36
                Top = 92
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #23458#25143#21495
              end
              object D1: TcxDateEdit
                Left = 80
                Top = 4
                Width = 97
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 205
                Top = 4
                Width = 98
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object RzBitBtn1: TRzBitBtn
                Left = 328
                Top = 82
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
                TabOrder = 6
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndCREA_USER: TzrComboBoxList
                Left = 80
                Top = 46
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
              object fndCLIENT_ID: TzrComboBoxList
                Left = 80
                Top = 25
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
              object fndSERIAL_NO: TcxTextEdit
                Left = 80
                Top = 67
                Width = 223
                Height = 20
                Properties.MaxLength = 50
                TabOrder = 4
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndCLIENT_CODE: TcxTextEdit
                Left = 80
                Top = 88
                Width = 223
                Height = 20
                Properties.MaxLength = 30
                TabOrder = 5
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object Panel2: TPanel
              Left = 6
              Top = 117
              Width = 870
              Height = 319
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh2: TDBGridEh
                Left = 1
                Top = 1
                Width = 868
                Height = 317
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
                    Title.Caption = #21333#21495
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #23458#25143#21517#31216
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_NAME'
                    Footers = <>
                    Title.Caption = #21830#21697#21517#31216
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SERIAL_NO'
                    Footers = <>
                    Title.Caption = #24207#21015#21495
                    Width = 120
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'RECV_DATE'
                    Footers = <>
                    Title.Caption = #21463#29702#26085#26399
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'RECV_USER_TEXT'
                    Footers = <>
                    Title.Caption = #21463#29702#20154
                    Width = 70
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'SRVR_DATE'
                    Footers = <>
                    Title.Caption = #22788#29702#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SRVR_USER_TEXT'
                    Footers = <>
                    Title.Caption = #22788#29702#20154
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_DATE'
                    Footers = <>
                    Title.Caption = #21046#21333#26102#38388
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_USER_TEXT'
                    Footers = <>
                    Title.Caption = #21046#21333#21592
                    Width = 70
                  end>
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 900
    inherited Image3: TImage
      Left = 374
      Width = 486
    end
    inherited Image14: TImage
      Left = 880
    end
    inherited Image1: TImage
      Left = 860
    end
    inherited rzPanel5: TPanel
      Left = 374
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
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actNew
          Caption = #30331#35760
        end
        object ToolButton2: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
        end
        object ToolButton3: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
        end
        object ToolButton4: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton5: TToolButton
          Left = 172
          Top = 0
          Width = 10
          Caption = 'ToolButton5'
          ImageIndex = 4
          Style = tbsDivider
        end
        object ToolButton6: TToolButton
          Left = 182
          Top = 0
          Action = actAudit
        end
        object ToolButton7: TToolButton
          Left = 225
          Top = 0
          Action = actPrint
        end
        object ToolButton8: TToolButton
          Left = 268
          Top = 0
          Action = actPreview
        end
        object ToolButton9: TToolButton
          Left = 311
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 56
    Top = 240
  end
  inherited actList: TActionList
    Left = 88
    Top = 240
    inherited actNew: TAction
      Caption = #24320#31080
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
      Caption = #23548#20986
      OnExecute = actPreviewExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    inherited actInfo: TAction
      Caption = #35814#32454
      OnExecute = actInfoExecute
    end
    inherited actAudit: TAction
      Visible = False
      OnExecute = actAuditExecute
    end
  end
  object DsSalesList: TDataSource
    DataSet = CdsSalesList
    Left = 109
    Top = 282
  end
  object CdsSalesList: TZQuery
    FieldDefs = <>
    AfterScroll = CdsSalesListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 79
    Top = 281
  end
  object DataSource2: TDataSource
    DataSet = cdsList
    Left = 429
    Top = 234
  end
  object cdsList: TZQuery
    FieldDefs = <>
    AfterScroll = cdsListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 399
    Top = 233
  end
end
