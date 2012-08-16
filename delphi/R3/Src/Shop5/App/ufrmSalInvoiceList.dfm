inherited frmSalInvoiceList: TfrmSalInvoiceList
  Left = 271
  Top = 145
  Width = 908
  Height = 567
  Caption = #38144#39033#21457#31080#31649#29702
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 900
    Height = 503
    inherited RzPanel2: TRzPanel
      Width = 890
      Height = 493
      inherited RzPage: TRzPageControl
        Width = 884
        Height = 487
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38144#39033#21457#31080#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 882
            Height = 460
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 872
              Height = 450
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
                  Left = 24
                  Top = 26
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
                  Top = 45
                  Width = 48
                  Height = 12
                  Caption = #23458#25143#21517#31216
                end
                object Label8: TLabel
                  Left = 208
                  Top = 26
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object RzLabel5: TRzLabel
                  Left = 24
                  Top = 94
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #27969#27700#21333#21495
                end
                object Label1: TLabel
                  Left = 208
                  Top = 96
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
                  Top = 46
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26041#24335
                end
                object Label10: TLabel
                  Left = 24
                  Top = 71
                  Width = 48
                  Height = 12
                  Caption = #21333#25454#31867#22411
                end
                object fndOrderType: TcxRadioGroup
                  Left = 80
                  Top = 59
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
                  TabOrder = 6
                  Caption = ''
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
                  Top = 81
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
                  TabOrder = 9
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 22
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
                  Top = 24
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
                  TabOrder = 8
                  Caption = #29366#24577
                end
                object fndP1_CUST_ID: TzrComboBoxList
                  Left = 80
                  Top = 42
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
                  Left = 264
                  Top = 22
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
                  Top = 90
                  Width = 121
                  Height = 20
                  TabOrder = 7
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object fndSALES_STYLE: TzrComboBoxList
                  Left = 264
                  Top = 42
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
                Top = 125
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
            Height = 453
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
              Height = 312
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh2: TDBGridEh
                Left = 1
                Top = 1
                Width = 868
                Height = 310
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
    Left = 119
    Top = 337
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
  object frfSalinvoice: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfSalinvoiceGetValue
    OnUserFunction = frfSalinvoiceUserFunction
    Left = 143
    Top = 277
    ReportForm = {
      180000009B1C0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      000D010000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      500100000700B7D6D7E9CDB7310002010000000019000000F6020000BC000000
      3200100001000000000000000000FFFFFF1F000000001300696E7428285B5345
      514E4F5D2D31292F31302900000000000000FFFF000000000002000000010000
      000000000001000000C800000014000000010000000000000200360200000700
      B7D6D7E9BDC531000201000000008F010000F602000045000000300011000100
      0000000000000000FFFFFF1F0000000000000000000007000500626567696E0D
      1E0020696620436F756E74284D61737465724461746131293C3130207468656E
      0D060020626567696E0D250020202020666F7220693A3D436F756E74284D6173
      74657244617461312920746F203920646F0D15002020202053686F7742616E64
      284368696C6431293B0D050020656E643B0D0300656E6400FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      9C02000006006368696C64310002010000000045010000F60200001300000030
      00150001000000000000000000FFFFFF1F00000000000000000000000000FFFF
      000000000002000000010000000000000001000000C800000014000000010000
      0000000000002C03000006004D656D6F333600020051000000BF000000D10000
      001600000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      1200BBF5CEEFBCB0D3A6CBB0C0CDCEF1C3FBB3C600000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000AE03000006004D656D6F
      33370002004E010000BF0000005A0000001600000001000F0001000000000000
      000000FFFFFF1F2E02000000000001000400CAFDC1BF00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000200000000000A00000086
      00020000000000FFFFFF00000000020000000000000000003004000006004D65
      6D6F333800020022010000BF0000002C0000001600000001000F000100000000
      0000000000FFFFFF1F2E02000000000001000400B5A5CEBB00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      008600020000000000FFFFFF0000000002000000000000000000B50400000600
      4D656D6F343100020031000000AE0100003D0000001200000001000000010000
      00000000000000FFFFFF1F2E02000000000001000700CAD5BFEEC8CB3A000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000080000008600020000000000FFFFFF000000000200000000000000000037
      05000006004D656D6F343500020002020000BF0000005A000000160000000100
      0F0001000000000000000000FFFFFF1F2E02000000000001000400BDF0B6EE00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00B905000006004D656D6F353500020030000000BF0000002100000016000000
      01000F0001000000000000000000FFFFFF1F2E02000000000001000400D0F2BA
      C500000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0200000000000A0000008600020000000000FFFFFF0000000002000000000000
      0000003A06000005004D656D6F37000200A8010000BF0000005A000000160000
      0001000F0001000000000000000000FFFFFF1F2E02000000000001000400B5A5
      BCDB00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      000200000000000A0000000100020000000000FFFFFF00000000020000000000
      00000000C706000006004D656D6F3131000200B80000008F010000FE0100001C
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001000F00
      5B53554D285B414D4F4E45595D295D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000080000008600020000000000
      FFFFFF00000000020000000000000000004E07000006004D656D6F3136000200
      300000008F010000870000001C00000001000E0001000000000000000000FFFF
      FF1F2E02000000000001000900BFAAC6B1BDF0B6EE3A00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000200000000000900000086
      00020000000000FFFFFF0000000002000000000000000000D507000006004D65
      6D6F33320002002F000000330000000C02000012000000010000000100000000
      0000000000FFFFFF1F2E02000000000001000900B7A2C6B1B1BEBAC53A000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000090000008600020000000000FFFFFF00000000020000000000000000005C
      08000006004D656D6F35380002003B020000330000007B000000120000000100
      020001000000000000000000FFFFFF1F2E020000000000010009005B494E5648
      5F4E4F5D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000000000008600020000000000FFFFFF0000000002000000
      000000000000E408000005004D656D6F32000200300000001900000086020000
      180000000100000001000000000000000500FFFFFF1F2E02000000000001000B
      00CFFA20CFEE20B7A220C6B100000000FFFF0000000000020000000100000000
      0400CBCECCE500100000000200000000000A0000008600020000000000FFFFFF
      00000000020000000000000000006609000005004D656D6F31000200DC000000
      AD0100002C000000140000000100000001000000000000000000FFFFFF1F2E02
      000000000001000500B8B4BACB3A000000000100000000000002000000010000
      00000400CBCECCE5000A000000020000000000080000008600020000000000FF
      FFFF0000000002000000000000000000ED09000006004D656D6F33310002002E
      0000004700000048000000120000000300000001000000000000000000FFFFFF
      1F2E02000000000001000900BFAAC6B1C8D5C6DA3A00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000020000000000090000000100
      020000000000FFFFFF0000000002000000000000000000760A000006004D656D
      6F353000020074000000470000009F0000001200000003000200010000000000
      00000000FFFFFF1F2E02000000000001000B005B435245415F444154455D0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000080000000100020000000000FFFFFF0000000002000000000000000000
      FD0A000006004D656D6F35360002001401000047000000490000001200000003
      00000001000000000000000000FFFFFF1F2E02000000000001000900B7A2C6B1
      C0E0D0CD3A00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000090000000100020000000000FFFFFF00000000020000
      000000000000008E0B000006004D656D6F35370002005D010000470000008A00
      0000120000000300020001000000000000000000FFFFFF1F2E02000000000001
      0013005B494E564F4943455F464C41475F544558545D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000001
      00020000000000FFFFFF0000000002000000000000000000100C000006004D65
      6D6F34320002005C020000BF0000005A0000001600000001000F000100000000
      0000000000FFFFFF1F2E02000000000001000400CBB0B6EE00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      000100020000000000FFFFFF0000000002000000000000000000F00C00000600
      4D656D6F3638000200C10200007F000000140000001401000003000000010000
      00000000000000FFFFFF1F2E020000000000080000000D0C00B0D7C1AAB4E6B8
      F9202020200D00000D1500202020202020202020202020202020202020202020
      0D0C00BAECC1AACAD5BBF5B7BD20200D00000D18002020202020202020202020
      202020202020202020202020200D0800BBC6C1AAB2C6CEF100000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000020000000000000000
      000100020000000000FFFFFF0000000002000000000000000000770D00000600
      4D656D6F3130000200E701000047000000540000001200000003000000010000
      00000000000000FFFFFF1F2E02000000000001000900B7A220C6B120BAC53A00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      00000000090000000100020000000000FFFFFF00000000020000000000000000
      00010E000006004D656D6F31350002003B020000470000007B00000012000000
      0300020001000000000000000000FFFFFF1F2E02000000000001000C005B494E
      564F4943455F4E4F5D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000080000000100020000000000FFFFFF000000
      0002000000000000000000860E000006004D656D6F323100020068010000AE01
      000034000000120000000100000001000000000000000000FFFFFF1F2E020000
      00000001000700BFAAC6B1C8CB3A000000000100000000000002000000010000
      00000400CBCECCE5000A000000020000000000080000008600020000000000FF
      FFFF0000000002000000000000000000140F000006004D656D6F32320002009D
      010000AE0100005C000000120000000100020001000000000000000000FFFFFF
      1F2E020000000000010010005B435245415F555345525F544558545D00000000
      010000000000000200000001000000000400CBCECCE5000A0000000200000000
      00080000008600020000000000FFFFFF0000000002000000000000000000A90F
      000006004D656D6F323500020031000000C20100008801000012000000030000
      0001000000000000000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1
      BCE43A5B444154455D205B54494D455D00000000FFFF00000000000200000001
      000000000500417269616C000A00000000000000000000000000010002000000
      0000FFFFFF00000000020000000000000000002F10000005004D656D6F340002
      00690000005C00000048000000180000000300080001000000000000000000FF
      FFFF1F2E02000000000001000900BFCDBBA7C3FBB3C63A00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000002000000000009000000
      0100020000000000FFFFFF0000000002000000000000000000BC10000005004D
      656D6F35000200AF0000005C0000000702000018000000030009000100000000
      0000000000FFFFFF1F2E020000000000010010005B434C49454E545F49445F54
      4558545D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000080000000100020000000000FFFFFF0000000002000000
      0000000000004A11000005004D656D6F36000200300000005C00000038000000
      6300000003000F0001000000000000000000FFFFFF1F2E020000000000040002
      00B9BA0D0200BBF50D0200B5A50D0200CEBB00000000FFFF0000000000020000
      0001000000000400CBCECCE5000C0000000200000000000A0000000100020000
      000000FFFFFF0000000002000000000000000000D011000005004D656D6F3900
      0200690000007500000048000000180000000300000001000000000000000000
      FFFFFF1F2E02000000000001000900BFAAC6B1C3C5B5EA3A00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000020000000000090000
      000100020000000000FFFFFF00000000020000000000000000005C1200000600
      4D656D6F3132000200AF00000075000000070200001800000003000100010000
      00000000000000FFFFFF1F2E02000000000001000E005B53484F505F49445F54
      4558545D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000080000000100020000000000FFFFFF0000000002000000
      000000000000E312000006004D656D6F3133000200690000008E000000480000
      00180000000300000001000000000000000000FFFFFF1F2E0200000000000100
      0900BFAAC6B1B2BFC3C53A00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000090000000100020000000000FFFFFF00
      000000020000000000000000006F13000006004D656D6F3134000200AF000000
      8E00000007020000180000000300010001000000000000000000FFFFFF1F2E02
      000000000001000E005B444550545F49445F544558545D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      0100020000000000FFFFFF0000000002000000000000000000F513000006004D
      656D6F313700020069000000A700000048000000180000000300020001000000
      000000000000FFFFFF1F2E02000000000001000800CBB5202020C3F73A000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000090000000100020000000000FFFFFF00000000020000000000000000007B
      14000006004D656D6F3139000200AF000000A700000007020000180000000300
      030001000000000000000000FFFFFF1F2E020000000000010008005B52454D41
      524B5D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000000100020000000000FFFFFF000000000200000000
      00000000000315000005004D656D6F33000200510000000D010000D100000013
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001000B00
      5B474F44535F4E414D455D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000000000000000A0000008600020000000000FFFFFF00
      000000020000000000000000008815000005004D656D6F380002004E0100000D
      0100005A0000001300000001000F0001000000000000000000FFFFFF1F2E0200
      00000000010008005B414D4F554E545D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000A00000086000200000000
      00FFFFFF00000000020000000000000000001116000006004D656D6F31380002
      00220100000D0100002C0000001300000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000B005B554E49545F4E414D455D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000A00
      00008600020000000000FFFFFF00000000020000000000000000009716000006
      004D656D6F3230000200020200000D0100005A0000001300000001000F000100
      0000000000000000FFFFFF1F2E020000000000010008005B414D4F4E45595D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      001C17000006004D656D6F3233000200300000000D0100002100000013000000
      01000F0001000000000000000000FFFFFF1F2E020000000000010007005B5345
      514E4F5D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      0000000000000000000A0000008600020000000000FFFFFF0000000002000000
      000000000000A217000006004D656D6F3236000200A80100000D0100005A0000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      08005B4150524943455D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000000000000000A0000000100020000000000FFFFFF0000
      0000020000000000000000003218000006004D656D6F32370002005C0200000D
      0100005A0000001300000001000F0001000000000000000000FFFFFF1F2E0200
      00000000010012005B524F554E44285B5441585F4D4E595D295D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000000000000000A
      0000000100020000000000FFFFFF0000000002000000000000000000BD180000
      06004D656D6F323800020019020000AD01000064000000120000000100000001
      000000000000000000FFFFFF1F2E02000000000001000D00CFFABBF5B5A5CEBB
      3A28D5C22900000000010000000000000200000001000000000400CBCECCE500
      0A000000020000000000080000008600020000000000FFFFFF00000000020000
      000000000000003919000006004D656D6F32340002005100000045010000D100
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0000000000000A0000008600020000000000FFFFFF0000000002000000000000
      000000B519000006004D656D6F32390002004E010000450100005A0000001300
      000001000F0001000000000000000000FFFFFF1F2E0200000000000000000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      00000A0000008600020000000000FFFFFF000000000200000000000000000031
      1A000006004D656D6F333000020022010000450100002C000000130000000100
      0F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000A00
      00008600020000000000FFFFFF0000000002000000000000000000AD1A000006
      004D656D6F333300020002020000450100005A0000001300000001000F000100
      0000000000000000FFFFFF1F2E020000000000000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000000000000000A0000008600
      020000000000FFFFFF0000000002000000000000000000291B000006004D656D
      6F33340002003000000045010000210000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000000000000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000000000000000A000000860002000000
      0000FFFFFF0000000002000000000000000000A51B000006004D656D6F333500
      0200A8010000450100005A0000001300000001000F0001000000000000000000
      FFFFFF1F2E020000000000000000000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000000000000000A0000000100020000000000FFFF
      FF0000000002000000000000000000211C000006004D656D6F33390002005C02
      0000450100005A0000001300000001000F0001000000000000000000FFFFFF1F
      2E020000000000000000000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000000000000000A0000000100020000000000FFFFFF000000
      000200000000000000FEFEFF060000000A00205661726961626C657300000000
      0200736C0014006364735F436867426F64792E22534C30303030220002006A65
      0014006364735F436867426F64792E224A4530303030220004006B6879680000
      0000040079687A68000000000200647A000000000000000000000000FDFF0100
      000000}
  end
end
