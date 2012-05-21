inherited frmSalInvoiceList: TfrmSalInvoiceList
  Left = 242
  Top = 144
  Width = 908
  Height = 549
  Caption = #38144#39033#21457#31080#31649#29702
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
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38144#39033#21457#31080#26597#35810
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
                Height = 119
                Align = alTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 5
                Color = clWhite
                TabOrder = 0
                object Label3: TLabel
                  Left = 208
                  Top = 48
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object RzLabel2: TRzLabel
                  Left = 24
                  Top = 6
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #19994#21153#26085#26399
                end
                object RzLabel3: TRzLabel
                  Left = 186
                  Top = 6
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label2: TLabel
                  Left = 24
                  Top = 68
                  Width = 48
                  Height = 12
                  Caption = #23458#25143#21517#31216
                end
                object Label8: TLabel
                  Left = 24
                  Top = 48
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object RzLabel5: TRzLabel
                  Left = 24
                  Top = 27
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #27969#27700#21333#21495
                end
                object Label1: TLabel
                  Left = 208
                  Top = 29
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
                  Top = 69
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26041#24335
                end
                object Label10: TLabel
                  Left = 24
                  Top = 95
                  Width = 48
                  Height = 12
                  Caption = #21333#25454#31867#22411
                end
                object P1_D1: TcxDateEdit
                  Left = 80
                  Top = 2
                  Width = 97
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 205
                  Top = 2
                  Width = 98
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object btnOk: TRzBitBtn
                  Left = 512
                  Top = 86
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
                  TabOrder = 7
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 264
                  Top = 44
                  Width = 121
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
                  Left = 395
                  Top = 28
                  Width = 105
                  Height = 85
                  ItemIndex = 1
                  Properties.Items = <
                    item
                      Caption = #20840#37096
                    end
                    item
                      Caption = #26410#24320#31080
                    end
                    item
                      Caption = #24050#24320#31080
                    end>
                  TabOrder = 6
                  Caption = #29366#24577
                end
                object fndP1_CUST_ID: TzrComboBoxList
                  Left = 80
                  Top = 65
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
                  Top = 44
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
                  Top = 23
                  Width = 121
                  Height = 20
                  TabOrder = 5
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object fndSALES_STYLE: TzrComboBoxList
                  Left = 264
                  Top = 65
                  Width = 121
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
                object fndOrderType: TcxRadioGroup
                  Left = 80
                  Top = 83
                  Width = 305
                  Height = 30
                  ItemIndex = 1
                  Properties.Columns = 4
                  Properties.Items = <
                    item
                      Caption = #35746#36135#21333
                    end
                    item
                      Caption = #38144#21806#21333
                    end
                    item
                      Caption = #36864#36135#21333
                    end>
                  TabOrder = 9
                  Caption = ''
                end
              end
              object Panel1: TPanel
                Left = 6
                Top = 125
                Width = 860
                Height = 301
                Align = alClient
                Caption = 'Panel1'
                TabOrder = 1
                object DBGridEh1: TDBGridEh
                  Left = 1
                  Top = 1
                  Width = 858
                  Height = 299
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
                      Checkboxes = True
                      EditButtons = <>
                      FieldName = 'SetFlag'
                      Footers = <>
                      KeyList.Strings = (
                        '1'
                        '0')
                      PickList.Strings = (
                        '0'
                        '1')
                      Title.Caption = #24320#31080
                      Width = 30
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
                      Width = 100
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
                      Width = 70
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'AMOUNT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25968#37327
                      Width = 70
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'AMONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #21512#35745#37329#39069
                      Width = 70
                    end
                    item
                      DisplayFormat = '00000000'
                      EditButtons = <>
                      FieldName = 'INVOICE_NO'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #21457#31080#21495
                      Width = 100
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CREA_USER_TEXT'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #24320#31080#20154
                      Width = 60
                    end>
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #24320#31080#21333#26597#35810
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
                Caption = #24320#31080#26085#26399
              end
              object RzLabel1: TRzLabel
                Left = 186
                Top = 11
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label4: TLabel
                Left = 181
                Top = 87
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #24320#31080#20154
              end
              object Label17: TLabel
                Left = 24
                Top = 68
                Width = 48
                Height = 12
                Caption = #23458#25143#21517#31216
              end
              object Label7: TLabel
                Left = 24
                Top = 87
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #21457#31080#31867#22411
              end
              object Label40: TLabel
                Left = 24
                Top = 30
                Width = 48
                Height = 12
                Caption = #24320#31080#38376#24215
              end
              object Label9: TLabel
                Left = 24
                Top = 49
                Width = 48
                Height = 12
                Caption = #24320#31080#37096#38376
              end
              object RzLabel6: TRzLabel
                Left = 24
                Top = 107
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #21457' '#31080' '#21495
              end
              object Label5: TLabel
                Left = 188
                Top = 107
                Width = 114
                Height = 12
                Caption = #25903#25345#21457#31080#21495#21518'4'#20301#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
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
                Left = 413
                Top = 97
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
                TabOrder = 9
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndINVOICE_STATUS: TcxRadioGroup
                Left = 316
                Top = 31
                Width = 85
                Height = 92
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #26377#25928
                  end
                  item
                    Caption = #20316#24223
                  end>
                TabOrder = 8
                Caption = ''
              end
              object fndCREA_USER: TzrComboBoxList
                Left = 220
                Top = 83
                Width = 83
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
              object fndINVOICE_FLAG: TcxComboBox
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
              object fndINVOICE_NO: TcxTextEdit
                Left = 80
                Top = 103
                Width = 97
                Height = 20
                TabOrder = 7
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object Panel2: TPanel
              Left = 6
              Top = 135
              Width = 870
              Height = 301
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh2: TDBGridEh
                Left = 1
                Top = 1
                Width = 868
                Height = 299
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
                    DisplayFormat = '00000000'
                    EditButtons = <>
                    FieldName = 'INVOICE_NO'
                    Footers = <>
                    Title.Caption = #21457#31080#21495
                    Width = 80
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'CREA_DATE'
                    Footers = <>
                    Title.Caption = #24320#31080#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #23458#25143#21517#31216
                    Width = 153
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'INVOICE_MNY'
                    Footers = <>
                    Title.Caption = #24320#31080#37329#39069
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID_TEXT'
                    Footers = <>
                    Title.Caption = #24320#31080#38376#24215
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'DEPT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #24320#31080#37096#38376
                    Width = 90
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_USER_TEXT'
                    Footers = <>
                    Title.Caption = #24320#31080#20154
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'INVOICE_FLAG'
                    Footers = <>
                    Title.Caption = #21457#31080#31867#22411
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'INVOICE_STATUS'
                    Footers = <>
                    Title.Caption = #29366#24577
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Caption = #35828#26126
                    Width = 150
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
      Caption = #20316#24223
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
