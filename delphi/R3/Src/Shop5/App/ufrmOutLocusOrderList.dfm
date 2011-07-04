inherited frmOutLocusOrderList: TfrmOutLocusOrderList
  Left = 205
  Top = 142
  Width = 868
  Height = 575
  Caption = #21457#36135#21333
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 852
    Height = 500
    inherited RzPanel2: TRzPanel
      Width = 842
      Height = 490
      inherited RzPage: TRzPageControl
        Width = 836
        Height = 484
        ActivePage = TabSheet3
        TabIndex = 2
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38144#21806#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 834
            Height = 457
            inherited RzPanel1: TRzPanel
              Width = 824
              Height = 112
              object RzLabel2: TRzLabel
                Left = 33
                Top = 5
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #38144#21806#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 5
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel4: TRzLabel
                Left = 33
                Top = 68
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #23458#25143#21517#31216
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 88
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #38144#21806#21333#21495
              end
              object Label40: TLabel
                Left = 33
                Top = 26
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object Label1: TLabel
                Left = 201
                Top = 89
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
              object Label3: TLabel
                Left = 33
                Top = 47
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object btnOk: TRzBitBtn
                Left = 504
                Top = 56
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
                TabOrder = 1
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSTATUS: TcxRadioGroup
                Left = 344
                Top = -5
                Width = 145
                Height = 86
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
                  end>
                TabOrder = 0
                Caption = ''
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 1
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 2
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 1
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 3
              end
              object fndSALES_ID: TcxTextEdit
                Left = 89
                Top = 85
                Width = 104
                Height = 20
                TabOrder = 4
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndCLIENT_ID: TzrComboBoxList
                Left = 89
                Top = 64
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
                FilterFields = 'CLIENT_NAME;CLIENT_SPELL;CLIENT_CODE;LICENSE_CODE;TELEPHONE2'
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
                DropWidth = 236
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = False
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear, zbFind]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 22
                Width = 236
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
                Left = 89
                Top = 43
                Width = 236
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
            inherited DBGridEh1: TDBGridEh
              Top = 117
              Width = 824
              Height = 335
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OnDblClick = DBGridEh1DblClick
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
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #27969#27700#21495
                  Width = 85
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'SALES_DATE'
                  Footers = <>
                  Title.Caption = #38144#21806#26085#26399
                  Width = 68
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #23458#25143#21517#31216
                  Width = 160
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #39564#36135#21592
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'INVOICE_FLAG'
                  Footers = <>
                  Title.Caption = #31080#25454#31867#22411
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #38144#21806#25968#37327
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_AMT'
                  Footers = <>
                  Title.Caption = #25195#30721#25968#37327
                  Width = 63
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_DATE'
                  Footers = <>
                  Title.Caption = #21457#36135#26085#26399
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21457#36135#20154
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 143
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#21592
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 131
                end>
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clWindow
          Caption = #35843#25320#21333#26597#35810
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 834
            Height = 457
            Align = alClient
            BorderOuter = fsNone
            BorderShadow = clWindow
            BorderWidth = 5
            Color = clWindow
            FlatColor = clWindow
            TabOrder = 0
            object RzPanel7: TRzPanel
              Left = 5
              Top = 5
              Width = 824
              Height = 102
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              Caption = '.'
              TabOrder = 0
              object RzLabel1: TRzLabel
                Left = 33
                Top = 5
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#25320#26085#26399
              end
              object RzLabel6: TRzLabel
                Left = 200
                Top = 5
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel7: TRzLabel
                Left = 33
                Top = 47
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#20837#38376#24215
              end
              object RzLabel8: TRzLabel
                Left = 33
                Top = 68
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#25320#21333#21495
              end
              object Label2: TLabel
                Left = 33
                Top = 26
                Width = 48
                Height = 12
                Caption = #35843#20986#38376#24215
              end
              object Label4: TLabel
                Left = 201
                Top = 69
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
              object fndP2_D1: TcxDateEdit
                Left = 89
                Top = 1
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object fndP2_D2: TcxDateEdit
                Left = 216
                Top = 1
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object RzBitBtn1: TRzBitBtn
                Left = 508
                Top = 60
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
                TabOrder = 4
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndP2_SALES_ID: TcxTextEdit
                Left = 89
                Top = 65
                Width = 104
                Height = 20
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndP2_STATUS: TcxRadioGroup
                Left = 344
                Top = -4
                Width = 145
                Height = 90
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
                  end>
                TabOrder = 3
                Caption = ''
              end
              object fndP2_SHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 22
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
              object fndP2_CLIENT_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 44
                Width = 236
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
            object DBGridEh2: TDBGridEh
              Left = 5
              Top = 107
              Width = 824
              Height = 345
              Align = alClient
              AllowedOperations = []
              Color = clWhite
              DataSource = dsP2List
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FrozenCols = 1
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              ReadOnly = True
              RowHeight = 20
              TabOrder = 1
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
              OnDrawColumnCell = DBGridEh2DrawColumnCell
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 29
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #21333#21495
                  Width = 78
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'SALES_DATE'
                  Footers = <>
                  Title.Caption = #35843#25320#26085#26399
                  Width = 67
                end
                item
                  EditButtons = <>
                  FieldName = 'SHOP_NAME'
                  Footers = <>
                  Title.Caption = #35843#20986#38376#24215
                  Width = 148
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #35843#20837#38376#24215
                  Width = 150
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #35843#25320#25968#37327
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_AMT'
                  Footers = <>
                  Title.Caption = #25195#30721#25968#37327
                  Width = 58
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_DATE'
                  Footers = <>
                  Title.Caption = #21457#36135#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21457#36135#20154
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #36865#36135#21592
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'STOCK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #39564#36135#21592
                  Width = 52
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 98
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#21592
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 119
                end>
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Color = clWindow
          Caption = #35843#25972#21333#26597#35810
          object RzPanel8: TRzPanel
            Left = 0
            Top = 0
            Width = 834
            Height = 457
            Align = alClient
            BorderOuter = fsNone
            BorderShadow = clWindow
            BorderWidth = 5
            Color = clWindow
            FlatColor = clWindow
            TabOrder = 0
            object RzPanel9: TRzPanel
              Left = 5
              Top = 5
              Width = 824
              Height = 92
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object RzLabel9: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#25972#26085#26399
              end
              object RzLabel10: TRzLabel
                Left = 200
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel11: TRzLabel
                Left = 33
                Top = 64
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #27969#27700#21333#21495
              end
              object Label5: TLabel
                Left = 201
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
              object RzLabel12: TRzLabel
                Left = 33
                Top = 44
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #32463' '#25163' '#20154
              end
              object Label6: TLabel
                Left = 33
                Top = 24
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object fndP3_D1: TcxDateEdit
                Left = 89
                Top = 0
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object fndP3_D2: TcxDateEdit
                Left = 216
                Top = 0
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndP3_CHANGE_ID: TcxTextEdit
                Left = 89
                Top = 60
                Width = 104
                Height = 20
                TabOrder = 3
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzBitBtn2: TRzBitBtn
                Left = 480
                Top = 50
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
                TabOrder = 5
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndP3_STATUS: TcxRadioGroup
                Left = 336
                Top = -5
                Width = 129
                Height = 83
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
                  end>
                TabOrder = 4
                Caption = ''
              end
              object fndP3_DUTY_USER: TzrComboBoxList
                Left = 89
                Top = 40
                Width = 144
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
                FilterFields = 'ACCOUNT;USER_NAME;USER_SPELL'
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
                Buttons = [zbNew, zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndP3_SHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 20
                Width = 236
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
            object DBGridEh3: TDBGridEh
              Left = 5
              Top = 97
              Width = 824
              Height = 355
              Align = alClient
              AllowedOperations = []
              Color = clWhite
              DataSource = dsP3List
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FrozenCols = 1
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              ReadOnly = True
              RowHeight = 20
              TabOrder = 1
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
              OnDrawColumnCell = DBGridEh3DrawColumnCell
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 28
                end
                item
                  EditButtons = <>
                  FieldName = 'CHANGE_CODE'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '2')
                  PickList.Strings = (
                    #25439#30410#21333
                    #39046#29992#21333)
                  Title.Caption = #21333#25454#31867#22411
                  Width = 54
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'CHANGE_DATE'
                  Footers = <>
                  Title.Caption = #35843#25972#26085#26399
                  Width = 72
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #21333#21495
                  Width = 105
                end
                item
                  EditButtons = <>
                  FieldName = 'DEPT_NAME'
                  Footers = <>
                  Title.Caption = #37096#38376
                  Width = 101
                end
                item
                  EditButtons = <>
                  FieldName = 'DUTY_USER_TEXT'
                  Footers = <>
                  Title.Caption = #36127#36131#20154
                  Width = 56
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #35843#25972#25968#37327
                  Width = 65
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_AMT'
                  Footers = <>
                  Title.Caption = #25195#30721#25968#37327
                  Width = 65
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_DATE'
                  Footers = <>
                  Title.Caption = #21457#36135#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21457#36135#20154
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 198
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#20154
                  Width = 61
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 137
                end>
            end
          end
        end
        object TabSheet4: TRzTabSheet
          Color = clWindow
          Caption = #37319#36141#36864#36135#21333
          object RzPanel10: TRzPanel
            Left = 0
            Top = 0
            Width = 834
            Height = 457
            Align = alClient
            BorderOuter = fsNone
            BorderShadow = clWindow
            BorderWidth = 5
            Color = clWindow
            FlatColor = clWindow
            TabOrder = 0
            object RzPanel11: TRzPanel
              Left = 5
              Top = 5
              Width = 824
              Height = 110
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object RzLabel13: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36864#36135#26085#26399
              end
              object RzLabel14: TRzLabel
                Left = 200
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel15: TRzLabel
                Left = 33
                Top = 64
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20379' '#24212' '#21830
              end
              object RzLabel16: TRzLabel
                Left = 33
                Top = 84
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36864#36135#21333#21495
              end
              object Label7: TLabel
                Left = 201
                Top = 85
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
              object Label8: TLabel
                Left = 33
                Top = 24
                Width = 48
                Height = 12
                Caption = #36864#36135#38376#24215
              end
              object Label9: TLabel
                Left = 33
                Top = 44
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object fndP4_D1: TcxDateEdit
                Left = 89
                Top = 0
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object fndP4_D2: TcxDateEdit
                Left = 216
                Top = 0
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndP4_CLIENT_ID: TzrComboBoxList
                Left = 89
                Top = 60
                Width = 236
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
              object fndP4_STOCK_ID: TcxTextEdit
                Left = 89
                Top = 80
                Width = 104
                Height = 20
                TabOrder = 3
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzBitBtn3: TRzBitBtn
                Left = 504
                Top = 56
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
                TabOrder = 5
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndP4_STATUS: TcxRadioGroup
                Left = 344
                Top = -5
                Width = 145
                Height = 86
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
                  end>
                TabOrder = 4
                Caption = ''
              end
              object fndP4_SHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 20
                Width = 236
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
              object fndP4_DEPT_ID: TzrComboBoxList
                Left = 89
                Top = 40
                Width = 236
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
            object DBGridEh4: TDBGridEh
              Left = 5
              Top = 115
              Width = 824
              Height = 337
              Align = alClient
              AllowedOperations = []
              Color = clWhite
              DataSource = dsP4List
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              ReadOnly = True
              RowHeight = 20
              TabOrder = 1
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
              OnDrawColumnCell = DBGridEh4DrawColumnCell
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
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #27969#27700#21495
                  Width = 85
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'STOCK_DATE'
                  Footers = <>
                  Title.Caption = #36864#36135#26085#26399
                  Width = 68
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #20379#24212#21830
                  Width = 160
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #39564#36135#21592
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'INVOICE_FLAG'
                  Footers = <>
                  Title.Caption = #31080#25454#31867#22411
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #36864#36135#25968#37327
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_AMT'
                  Footers = <>
                  Title.Caption = #25195#30721#25968#37327
                  Width = 63
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_DATE'
                  Footers = <>
                  Title.Caption = #21457#36135#26085#26399
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21457#36135#20154
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 143
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#21592
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 131
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 852
    inherited Image1: TImage
      Left = 593
      Width = 239
    end
    inherited Image3: TImage
      Left = 593
      Width = 239
    end
    inherited Image14: TImage
      Left = 832
    end
    inherited rzPanel5: TPanel
      Left = 593
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#36827#36135#20837#24211
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 573
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 573
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 573
        object ToolButton17: TToolButton
          Left = 522
          Top = 0
          Width = 8
          Caption = 'ToolButton17'
          ImageIndex = 14
          Style = tbsDivider
          Visible = False
        end
        object ToolButton11: TToolButton
          Left = 530
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 208
    Top = 144
  end
  inherited actList: TActionList
    inherited actNew: TAction
      Caption = #21457#36135
    end
    inherited actDelete: TAction
      Caption = #25195#30721
    end
    inherited actEdit: TAction
      Visible = False
    end
    inherited actSave: TAction
      Caption = #23436#25104
    end
    inherited actCancel: TAction
      Caption = #25764#28040
    end
    inherited actPrint: TAction
      Visible = False
    end
    inherited actPreview: TAction
      Visible = False
    end
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfSalesOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 488
    Top = 201
    ReportForm = {
      18000000E0200000180000FFFF1D004D6963726F736F66742058505320446F63
      756D656E742057726974657200FFFFFFFFFF0001000034080000780500002400
      000012000000240000001200000000FFFF00000000FFFF000000000000000000
      000000030400466F726D000F000080DC000000780000007C0100002C01000004
      0000000200F20000000B004D6173746572446174613100020100000000BE0000
      00F6020000130000003000050001000000000000000000FFFFFF1F000000000C
      0066724442446174615365743100000000000000FFFF00000000000200000001
      0000000000000001000000C8000000140000000100000000000002006E010000
      0700B7D6D7E9CDB7310002010000000019000000F60200006D00000032001000
      01000000000000000000FFFFFF1F000000001500494E5428285B5345514E4F5D
      2D3129202F2031352900000000000000FFFF0000000000020000000100000000
      00000001000000C800000014000000010000000000000200550200000700B7D6
      D7E9BDC5310002010000000012010000F60200004A0000003000110001000000
      000000000000FFFFFF1F0000000000000000000007000500626567696E0D1E00
      20696620436F756E74284D61737465724461746131293C3134207468656E0D06
      0020626567696E0D260020202020666F7220693A3D436F756E74284D61737465
      7244617461312920746F20313320646F0D15002020202053686F7742616E6428
      4368696C6431293B0D050020656E643B0D0300656E6400FFFF00000000000200
      0000010000000000000001000000C800000014000000010000000000000200BB
      02000006006368696C643100020100000000E8000000F6020000130000003000
      150001000000000000000000FFFFFF1F00000000000000000000000000FFFF00
      0000000002000000010000000000000001000000C80000001400000001000000
      00000000003F03000006004D656D6F333200020025020000320000002E000000
      120000000100000001000000000000000000FFFFFF1F2E020000000000010006
      00B5A5BAC5A3BA00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000020000000000080000008600020000000000FFFFFF0000000002
      000000000000000000DD03000006004D656D6F31340002002E020000BE000000
      3E0000001300000001000F0001000000000000000000FFFFFF1F2E0200000000
      00010020005B466F726D6174466C6F6174282723302E303023272C5B41505249
      43455D295D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000090000008600020000000000FFFFFF00000000020000
      000000000000007E04000006004D656D6F31380002006C020000BE0000004F00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000001
      0023005B666F726D6174466C6F6174282723302E3030272C5B43414C435F4D4F
      4E45595D295D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000090000008600020000000000FFFFFF000000000200
      00000000000000003E05000006004D656D6F3230000200EE000000BE000000F9
      0000001300000001000F0001000000000000000000FFFFFF1F2E020000000000
      010042005B474F44535F4E414D455D205B50524F50455254595F30315F544558
      545D5B50524F50455254595F30325F544558545D205B49535F50524553454E54
      5F544558545D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000008600020000000000FFFFFF000000000200
      0000000000000000C805000005004D656D6F390002007B000000320000000001
      0000120000000100020001000000000000000000FFFFFF1F2E02000000000001
      000D005B434C49454E545F4E414D455D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000800000086000200000000
      00FFFFFF00000000020000000000000000005206000006004D656D6F34300002
      00AB0100003200000079000000120000000100020001000000000000000000FF
      FFFF1F2E02000000000001000C005B53414C45535F444154455D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000008
      0000008600020000000000FFFFFF0000000002000000000000000000DB060000
      06004D656D6F3233000200E7010000BE000000200000001300000001000F0001
      000000000000000000FFFFFF1F2E02000000000001000B005B554E49545F4E41
      4D455D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      00000000000000000A0000008600020000000000FFFFFF000000000200000000
      00000000006307000006004D656D6F3538000200540200003200000067000000
      120000000100020001000000000000000000FFFFFF1F2E02000000000001000A
      005B474C4944455F4E4F5D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000000000008600020000000000FFFFFF00
      00000002000000000000000000FF07000005004D656D6F3300020007020000BE
      000000270000001300000001000F0001000000000000000000FFFFFF1F2E0200
      0000000001001F005B666F726D6174666C6F6174282723302E2323272C5B414D
      4F554E545D295D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000090000008600020000000000FFFFFF0000000002
      0000000000000000009008000005004D656D6F32000200350000001900000085
      020000180000000100000001000000000000000500FFFFFF1F2E020000000000
      010014005BC6F3D2B5C3FBB3C65DCFFACADBB3F6BBF5B5A500000000FFFF0000
      0000000200000001000000000400CBCECCE500100000000200000000000A0000
      008600020000000000FFFFFF0000000002000000000000000000170900000600
      4D656D6F31320002003500000032000000460000001200000001000000010000
      00000000000000FFFFFF1F2E02000000000001000900BFCDBBA7C3FBB3C63A00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      00000000080000008600020000000000FFFFFF00000000020000000000000000
      009B09000006004D656D6F31330002007D010000320000002E00000012000000
      0100000001000000000000000000FFFFFF1F2E02000000000001000600C8D5C6
      DAA3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      00000000001D0A000006004D656D6F33340002002E020000700000003E000000
      1600000001000F0001000000000000000000FFFFFF1F2E020000000000010004
      00B5A5BCDB00000000FFFF00000000000200000001000000000400CBCECCE500
      0A0000000200000000000A0000008600020000000000FFFFFF00000000020000
      00000000000000A30A000006004D656D6F3336000200EE00000070000000F900
      00001600000001000F0001000000000000000000FFFFFF1F2E02000000000001
      000800C9CCC6B7C3FBB3C600000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000250B000006004D656D6F333700020007020000
      70000000270000001600000001000F0001000000000000000000FFFFFF1F2E02
      000000000001000400CAFDC1BF00000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000200000000000A0000008600020000000000FFFF
      FF0000000002000000000000000000A70B000006004D656D6F3338000200E701
      000070000000200000001600000001000F0001000000000000000000FFFFFF1F
      2E02000000000001000400B5A5CEBB00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000008600020000000000
      FFFFFF00000000020000000000000000007C0C000006004D656D6F3235000200
      3500000012010000B20100001300000001000E0001000000000000000000FFFF
      FF1F2E02000000000001005700BACFBCC6BDF0B6EEA3BA5B536D616C6C546F42
      6967285B53414C455F4D4E595D295D2020A3A43A5B666F726D6174466C6F6174
      282723302E3030272C5B53414C455F4D4E595D295D2020202020202020202020
      2020202000000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000020000000000080000008600020000000000FFFFFF0000000002000000
      0000000000000A0D000006004D656D6F3432000200C20100004A0100006E0000
      000F0000000100000001000000000000000000FFFFFF1F2E0200000000000100
      1000BFCDBBA7C7A9C3FB28B8C7D5C229A3BA0000000001000000000000020000
      0001000000000400CBCECCE5000A0000000200FFFFFF1F080000008600020000
      000000FFFFFF0000000002000000000000000000900D000006004D656D6F3434
      000200590100002A010000370000001400000001000000010000000000000000
      00FFFFFF1F2E02000000000001000800B2D6B9DCD4B1A3BA0000000001000000
      0000000200000001000000000400CBCECCE5000A0000000200FFFFFF1F080000
      008600020000000000FFFFFF0000000002000000000000000000160E00000600
      4D656D6F3431000200FC0100002A010000350000001400000001000000010000
      00000000000000FFFFFF1F2E02000000000001000800CBCDBBF5D4B1A3BA0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000020000
      000000080000008600020000000000FFFFFF0000000002000000000000000000
      980E000006004D656D6F34350002006C020000700000004F0000001600000001
      000F0001000000000000000000FFFFFF1F2E02000000000001000400BDF0B6EE
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      00001D0F000006004D656D6F353400020035000000BE0000001B000000130000
      0001000F0001000000000000000000FFFFFF1F2E020000000000010007005B53
      45514E4F5D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A0000000000000000000A0000008600020000000000FFFFFF00000000020000
      000000000000009D0F000006004D656D6F353500020035000000700000001B00
      00001600000001000F0001000000000000000000FFFFFF1F2E02000000000001
      000200D0F200000000FFFF00000000000200000001000000000400CBCECCE500
      0A0000000200000000000A0000008600020000000000FFFFFF00000000020000
      000000000000001E10000005004D656D6F3700020050000000700000003E0000
      001600000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      0400BBF5BAC500000000FFFF00000000000200000001000000000400CBCECCE5
      000A0000000200000000000A0000000100020000000000FFFFFF000000000200
      0000000000000000A610000005004D656D6F3800020050000000BE0000003E00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000001
      000B005B474F44535F434F44455D00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000080000000100020000000000FF
      FFFF00000000020000000000000000003C11000006004D656D6F32340002007A
      0200001900000056000000120000000100000001000000000000000000FFFFFF
      1F2E02000000000001001800B5DA5B50414745235D2F5B544F54414C50414745
      535DD2B300000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000090000008600020000000000FFFFFF0000000002000000
      000000000000C511000006004D656D6F32360002007B00000046000000E50000
      00120000000100020001000000000000000000FFFFFF1F2E0200000000000100
      0B005B53454E445F414444525D00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000008600020000000000FFFF
      FF00000000020000000000000000004C12000006004D656D6F32370002003500
      00004600000046000000120000000100000001000000000000000000FFFFFF1F
      2E02000000000001000900CBCDBBF5B5D8D6B73A00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000002000000000008000000860002
      0000000000FFFFFF0000000002000000000000000000D512000006004D656D6F
      3238000200A8010000460000007C000000120000000100020001000000000000
      000000FFFFFF1F2E02000000000001000B005B54454C4550484F4E455D000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000080000008600020000000000FFFFFF00000000020000000000000000005C
      13000006004D656D6F3239000200620100004600000046000000120000000100
      000001000000000000000000FFFFFF1F2E02000000000001000900C1AACFB5B5
      E7BBB03A00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000020000000000080000008600020000000000FFFFFF0000000002000000
      000000000000F113000005004D656D6F31000200370000002A0100007C000000
      140000000100000001000000000000000000FFFFFF1F2E020000000000010018
      00D6C6B5A5C8CBA3BA5B435245415F555345525F544558545D00000000010000
      000000000200000001000000000400CBCECCE5000A0000000200FFFFFF1F0800
      00008600020000000000FFFFFF00000000020000000000000000007314000006
      004D656D6F35360002008E00000070000000600000001600000001000F000100
      0000000000000000FFFFFF1F2E02000000000001000400CCF5C2EB00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000020000000000
      0A0000000100020000000000FFFFFF0000000002000000000000000000FA1400
      0006004D656D6F35370002008E000000BE000000600000001300000001000F00
      01000000000000000000FFFFFF1F2E020000000000010009005B424152434F44
      455D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000000100020000000000FFFFFF00000000020000000000
      00000000DD15000006004D656D6F3539000200C00200005C000000180000002A
      0100000300000001000000000000000000FFFFFF1F2E02000000000007000B00
      B0D7C1AAA3BAB4E6B8F9200D00000D1E00202020202020202020202020202020
      2020202020202020202020202020200D0C00BAECC1AAA3BABFCDBBA720200D00
      000D140020202020202020202020202020202020202020200D0A00BBC6C1AAA3
      BABDE1CBE300000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000000000000100020000000000FFFFFF00000000020000
      000000000000005916000006004D656D6F36300002002E020000E80000003E00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      000000D516000006004D656D6F36310002006C020000E80000004F0000001300
      000001000F0001000000000000000000FFFFFF1F2E0200000000000000000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000090000008600020000000000FFFFFF000000000200000000000000000051
      17000006004D656D6F3632000200EE000000E8000000F9000000130000000100
      0F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00008600020000000000FFFFFF0000000002000000000000000000CD17000006
      004D656D6F3633000200E7010000E8000000200000001300000001000F000100
      0000000000000000FFFFFF1F2E020000000000000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000000000000000A0000008600
      020000000000FFFFFF00000000020000000000000000004918000006004D656D
      6F363400020007020000E8000000270000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000000000000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000009000000860002000000
      0000FFFFFF0000000002000000000000000000C518000006004D656D6F363500
      020035000000E80000001B0000001300000001000F0001000000000000000000
      FFFFFF1F2E020000000000000000000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000000000000000A0000008600020000000000FFFF
      FF00000000020000000000000000004119000006004D656D6F36360002005000
      0000E80000003E0000001300000001000F0001000000000000000000FFFFFF1F
      2E020000000000000000000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000080000000100020000000000FFFFFF000000
      0002000000000000000000BF19000006004D656D6F36370002008E000000E800
      0000600000001300000001000F0001000000000000000000FFFFFF1F2E020000
      0000000100000000000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000080000000100020000000000FFFFFF0000000002
      0000000000000000009D1A000005004D656D6F35000200E701000012010000D4
      0000001300000003000B0001000000000000000000FFFFFF1F2E020000000000
      01006100D7DCCAFDC1BFA3BA5B666F726D6174666C6F6174282723302E232327
      2C5B53414C455F414D545D295D20B1BED2B3D0A1BCC6A3BAA3A43A5B666F726D
      6174466C6F6174282723302E3030272C5B73756D285B43414C435F4D4F4E4559
      5D295D295D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000090000000100020000000000FFFFFF00000000020000
      00000000000000191B000006004D656D6F3130000200320200002F0100006100
      00000C0000000100020001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      020000000000080000008600020000000000FFFFFF0000000002000000000000
      000000951B000006004D656D6F3131000200920100002C010000610000001000
      00000100020001000000000000000000FFFFFF1F2E0200000000000000000000
      00010000000000000200000001000000000400CBCECCE5000A0000000200FFFF
      FF1F080000008600020000000000FFFFFF000000000200000000000000000025
      1C000006004D656D6F3135000200550200004600000066000000120000000100
      020001000000000000000000FFFFFF1F2E020000000000010012005B53455454
      4C455F434F44455F544558545D00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000008600020000000000FFFF
      FF0000000002000000000000000000A81C000006004D656D6F31360002002602
      0000460000002E000000120000000100000001000000000000000000FFFFFF1F
      2E02000000000001000500BDE1CBE33A00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000800000086000200000000
      00FFFFFF00000000020000000000000000003B1D000005004D656D6F34000200
      370000004B01000014010000120000000300000001000000000000000000FFFF
      FF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D205B5449
      4D455D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000000000000100020000000000FFFFFF000000000200000000
      0000000000C31D000005004D656D6F360002007D0000005B0000009700000012
      0000000100020001000000000000000000FFFFFF1F2E02000000000001000B00
      5B53484F505F4E414D455D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000008600020000000000FFFFFF00
      000000020000000000000000004A1E000006004D656D6F313700020035000000
      5B00000046000000120000000100000001000000000000000000FFFFFF1F2E02
      000000000001000900B7A2BBF5C3C5B5EA3A00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000008600020000
      000000FFFFFF0000000002000000000000000000E11E000006004D656D6F3139
      000200B50000002A0100007C0000001400000001000000010000000000000000
      00FFFFFF1F2E02000000000001001900D2B5CEF1D4B1A3BA5B47554944455F55
      5345525F544558545D00000000010000000000000200000001000000000400CB
      CECCE5000A0000000200FFFFFF1F080000008600020000000000FFFFFF000000
      0002000000000000000000641F000006004D656D6F32310002001A0100005B00
      000027000000120000000100000001000000000000000000FFFFFF1F2E020000
      00000001000500B1B8D7A23A00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000020000000000080000008600020000000000FFFFFF
      0000000002000000000000000000EA1F000006004D656D6F3335000200410100
      005B0000007A010000120000000100020001000000000000000000FFFFFF1F2E
      020000000000010008005B52454D41524B5D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000080000008600020000
      000000FFFFFF00000000020000000000000000006620000006004D656D6F3339
      000200320200004E010000610000000C00000001000200010000000000000000
      00FFFFFF1F2E020000000000000000000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000020000000000080000008600020000000000FF
      FFFF000000000200000000000000FEFEFF060000000A00205661726961626C65
      73000000000200736C0014006364735F436867426F64792E22534C3030303022
      0002006A650014006364735F436867426F64792E224A4530303030220004006B
      68796800000000040079687A68000000000200647A0000000000000000000000
      00FDFF0100000000}
  end
  object cdsP2List: TZQuery
    FieldDefs = <>
    AfterScroll = cdsP2ListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 350
    Top = 240
  end
  object dsP2List: TDataSource
    DataSet = cdsP2List
    Left = 382
    Top = 240
  end
  object cdsP3List: TZQuery
    FieldDefs = <>
    AfterScroll = cdsP3ListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 350
    Top = 288
  end
  object dsP3List: TDataSource
    DataSet = cdsP3List
    Left = 382
    Top = 288
  end
  object cdsP4List: TZQuery
    FieldDefs = <>
    AfterScroll = cdsP4ListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 350
    Top = 336
  end
  object dsP4List: TDataSource
    DataSet = cdsP4List
    Left = 382
    Top = 336
  end
end
