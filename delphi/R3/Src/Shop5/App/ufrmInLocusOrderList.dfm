inherited frmInLocusOrderList: TfrmInLocusOrderList
  Left = 327
  Top = 137
  Width = 868
  Height = 575
  Caption = #25910#36135#21333
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 860
    Height = 511
    inherited RzPanel2: TRzPanel
      Width = 850
      Height = 501
      inherited RzPage: TRzPageControl
        Width = 844
        Height = 495
        ActivePage = TabSheet2
        TabIndex = 1
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #36827#36135#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 842
            Height = 468
            inherited RzPanel1: TRzPanel
              Width = 832
              Height = 110
              object RzLabel2: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36827#36135#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel4: TRzLabel
                Left = 33
                Top = 64
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20379' '#24212' '#21830
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 84
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36827#36135#21333#21495
              end
              object Label1: TLabel
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
              object Label40: TLabel
                Left = 33
                Top = 24
                Width = 48
                Height = 12
                Caption = #36827#36135#38376#24215
              end
              object Label3: TLabel
                Left = 33
                Top = 44
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 0
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 0
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndCLIENT_ID: TzrComboBoxList
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
              object fndSTOCK_ID: TcxTextEdit
                Left = 89
                Top = 80
                Width = 104
                Height = 20
                TabOrder = 3
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
                TabOrder = 5
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
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#25910#36135
                  end
                  item
                    Caption = #24050#25910#36135
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end>
                TabOrder = 4
                Caption = ''
              end
              object fndSHOP_ID: TzrComboBoxList
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
              object fndDEPT_ID: TzrComboBoxList
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
            inherited DBGridEh1: TDBGridEh
              Top = 115
              Width = 832
              Height = 348
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
                  FieldName = 'STOCK_DATE'
                  Footers = <>
                  Title.Caption = #36827#36135#26085#26399
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
                  Title.Caption = #36827#36135#25968#37327
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
                  Title.Caption = #25195#30721#26085#26399
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_USER_TEXT'
                  Footers = <>
                  Title.Caption = #25195#30721#20154
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_STATUS_NAME'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '3')
                  PickList.Strings = (
                    #24453#25910#36135
                    #24050#25910#36135)
                  Title.Caption = #25910#36135#29366#24577
                  Width = 60
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
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_CHK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23457#26680#20154
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                  Width = 80
                end>
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clWindow
          Caption = #38144#21806#36864#36135#21333
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 842
            Height = 468
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
              Width = 832
              Height = 112
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object RzLabel1: TRzLabel
                Left = 33
                Top = 5
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36864#36135#26085#26399
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
                Top = 68
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #23458#25143#21517#31216
              end
              object RzLabel8: TRzLabel
                Left = 33
                Top = 88
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #38144#21806#21333#21495
              end
              object Label2: TLabel
                Left = 33
                Top = 26
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object Label4: TLabel
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
              object Label5: TLabel
                Left = 33
                Top = 47
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object RzBitBtn1: TRzBitBtn
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
              object fndP2_STATUS: TcxRadioGroup
                Left = 344
                Top = -5
                Width = 145
                Height = 86
                ItemIndex = 0
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#25910#36135
                  end
                  item
                    Caption = #24050#25910#36135
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end>
                TabOrder = 0
                Caption = ''
              end
              object fndP2_D1: TcxDateEdit
                Left = 89
                Top = 1
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 2
              end
              object fndP2_D2: TcxDateEdit
                Left = 216
                Top = 1
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 3
              end
              object fndP2_SALES_ID: TcxTextEdit
                Left = 89
                Top = 85
                Width = 104
                Height = 20
                TabOrder = 4
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndP2_CLIENT_ID: TzrComboBoxList
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
              object fndP2_DEPT_ID: TzrComboBoxList
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
            object DBGridEh2: TDBGridEh
              Left = 5
              Top = 117
              Width = 832
              Height = 346
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
              OnDrawColumnCell = DBGridEh2DrawColumnCell
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
                  Title.Caption = #36864#36135#26085#26399
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
                  Title.Caption = #36827#36135#25968#37327
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
                  Title.Caption = #25195#30721#26085#26399
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_USER_TEXT'
                  Footers = <>
                  Title.Caption = #25195#30721#20154
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_STATUS_NAME'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '3')
                  PickList.Strings = (
                    #24453#25910#36135
                    #24050#25910#36135)
                  Title.Caption = #25910#36135#29366#24577
                  Width = 60
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
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_CHK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23457#26680#20154
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                  Width = 80
                end>
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Color = clWindow
          Caption = #35843#25320#21333#26597#35810
          object RzPanel8: TRzPanel
            Left = 0
            Top = 0
            Width = 842
            Height = 468
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
              Width = 832
              Height = 102
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              Caption = '.'
              TabOrder = 0
              object RzLabel9: TRzLabel
                Left = 33
                Top = 5
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#25320#26085#26399
              end
              object RzLabel10: TRzLabel
                Left = 200
                Top = 5
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel11: TRzLabel
                Left = 33
                Top = 47
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#20837#38376#24215
              end
              object RzLabel12: TRzLabel
                Left = 33
                Top = 68
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#25320#21333#21495
              end
              object Label6: TLabel
                Left = 33
                Top = 26
                Width = 48
                Height = 12
                Caption = #35843#20986#38376#24215
              end
              object Label7: TLabel
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
              object fndP3_D1: TcxDateEdit
                Left = 89
                Top = 1
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object fndP3_D2: TcxDateEdit
                Left = 216
                Top = 1
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object RzBitBtn2: TRzBitBtn
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
              object fndP3_SALES_ID: TcxTextEdit
                Left = 89
                Top = 65
                Width = 104
                Height = 20
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndP3_STATUS: TcxRadioGroup
                Left = 344
                Top = -4
                Width = 145
                Height = 90
                ItemIndex = 0
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#25910#36135
                  end
                  item
                    Caption = #24050#25910#36135
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
              object fndP3_SHOP_ID: TzrComboBoxList
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
              object fndP3_CLIENT_ID: TzrComboBoxList
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
            object DBGridEh3: TDBGridEh
              Left = 5
              Top = 107
              Width = 832
              Height = 356
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
                  FieldName = 'LOCUS_STATUS_NAME'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '3')
                  PickList.Strings = (
                    #24453#25910#36135
                    #24050#25910#36135)
                  Title.Caption = #25910#36135#29366#24577
                  Width = 60
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
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_CHK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23457#26680#20154
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'LOCUS_CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                  Width = 80
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 860
    inherited Image3: TImage
      Left = 589
      Width = 0
    end
    inherited Image14: TImage
      Left = 840
    end
    inherited Image1: TImage
      Left = 589
      Width = 251
    end
    inherited rzPanel5: TPanel
      Left = 589
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#36827#36135#20837#24211
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 569
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 569
          Width = 36
        end>
      inherited ToolBar1: TToolBar
        Width = 569
        object ToolButton17: TToolButton
          Left = 518
          Top = 0
          Width = 8
          Caption = 'ToolButton17'
          ImageIndex = 14
          Style = tbsDivider
          Visible = False
        end
        object ToolButton11: TToolButton
          Left = 526
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 280
    Top = 289
  end
  inherited actList: TActionList
    Left = 312
    Top = 289
    inherited actNew: TAction
      Caption = #25910#36135
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
      Caption = #25764#38144
    end
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    inherited actPrior: TAction
      Visible = False
    end
    inherited actNext: TAction
      Visible = False
    end
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfStockOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfStockOrderGetValue
    OnUserFunction = frfStockOrderUserFunction
    Left = 416
    Top = 193
    ReportForm = {
      180000003E1F0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00A4000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      4F0100000700B7D6D7E9CDB7310002010000000019000000F60200006D000000
      3200100001000000000000000000FFFFFF1F000000001200696E7428285B5345
      514E4F5D2D292F31362900000000000000FFFF00000000000200000001000000
      0000000001000000C800000014000000010000000000000200360200000700B7
      D6D7E9BDC5310002010000000012010000F60200004500000030001100010000
      00000000000000FFFFFF1F0000000000000000000007000500626567696E0D1E
      0020696620436F756E74284D61737465724461746131293C3135207468656E0D
      060020626567696E0D260020202020666F7220693A3D436F756E74284D617374
      657244617461312920746F20313420646F0D15002020202053686F7742616E64
      284368696C6431293B0D050020656E643B0D0300656E6400FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      9C02000006006368696C643100020100000000CC000000F60200001300000030
      00150001000000000000000000FFFFFF1F00000000000000000000000000FFFF
      000000000002000000010000000000000001000000C800000014000000010000
      0000000000003A03000006004D656D6F31340002001A020000A40000003C0000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      20005B466F726D6174466C6F6174282723302E303023272C5B4150524943455D
      295D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000090000008600020000000000FFFFFF00000000020000000000
      00000000DB03000006004D656D6F313800020056020000A40000006000000013
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001002300
      5B666F726D6174466C6F6174282723302E3030272C5B43414C435F4D4F4E4559
      5D295D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000090000008600020000000000FFFFFF000000000200000000
      00000000009B04000006004D656D6F3230000200F1000000A4000000D1000000
      1300000001000F0001000000000000000000FFFFFF1F2E020000000000010042
      005B474F44535F4E414D455D205B50524F50455254595F30315F544558545D5B
      50524F50455254595F30325F544558545D205B49535F50524553454E545F5445
      58545D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000008600020000000000FFFFFF000000000200000000
      00000000002505000005004D656D6F390002007500000033000000EF00000012
      0000000100020001000000000000000000FFFFFF1F2E02000000000001000D00
      5B434C49454E545F4E414D455D00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000008600020000000000FFFF
      FF0000000002000000000000000000AF05000006004D656D6F34300002009201
      00003300000093000000120000000100020001000000000000000000FFFFFF1F
      2E02000000000001000C005B53544F434B5F444154455D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      8600020000000000FFFFFF00000000020000000000000000003806000006004D
      656D6F3233000200C2010000A4000000240000001300000001000F0001000000
      000000000000FFFFFF1F2E02000000000001000B005B554E49545F4E414D455D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      0000D406000005004D656D6F33000200E6010000A40000003400000013000000
      01000F0001000000000000000000FFFFFF1F2E02000000000001001F005B666F
      726D6174466C6F6174282723302E2323272C5B414D4F554E545D295D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00090000008600020000000000FFFFFF00000000020000000000000000005C07
      000006004D656D6F31320002002F000000330000004600000012000000010000
      0001000000000000000000FFFFFF1F2E02000000000001000A00B9A920D3A620
      C9CCA3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000020000000000080000008600020000000000FFFFFF0000000002000000
      000000000000E007000006004D656D6F313300020065010000330000002B0000
      00120000000100000001000000000000000000FFFFFF1F2E0200000000000100
      0600C8D5C6DAA3BA00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      020000000000000000006208000006004D656D6F33340002001A020000700000
      003C0000001600000001000F0001000000000000000000FFFFFF1F2E02000000
      000001000400B5A5BCDB00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF0000
      000002000000000000000000E808000006004D656D6F3336000200F100000070
      000000D10000001600000001000F0001000000000000000000FFFFFF1F2E0200
      0000000001000800C9CCC6B7C3FBB3C600000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000A00000086000200000000
      00FFFFFF00000000020000000000000000006A09000006004D656D6F33370002
      00E601000070000000340000001600000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000400CAFDC1BF00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF0000000002000000000000000000EC09000006004D656D6F3338
      000200C201000070000000240000001600000001000F00010000000000000000
      00FFFFFF1F2E02000000000001000400B5A5CEBB00000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000820A000006004D656D6F
      3431000200310000002901000081000000120000000100000001000000000000
      000000FFFFFF1F2E02000000000001001800D6C6B5A5C8CBA3BA5B435245415F
      555345525F544558545D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000080000008600020000000000FFFFFF0000
      000002000000000000000000040B000006004D656D6F34350002005602000070
      000000600000001600000001000F0001000000000000000000FFFFFF1F2E0200
      0000000001000400BDF0B6EE00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF
      0000000002000000000000000000890B000006004D656D6F3534000200300000
      00A40000001B0000001300000001000F0001000000000000000000FFFFFF1F2E
      020000000000010007005B5345514E4F5D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000000000000000A000000860002000000
      0000FFFFFF0000000002000000000000000000080C000006004D656D6F353500
      020030000000700000001B0000001600000001000F0001000000000000000000
      FFFFFF1F2E020000000000010001004100000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000A00000086000200000000
      00FFFFFF0000000002000000000000000000890C000005004D656D6F37000200
      4B00000070000000420000001600000001000F0001000000000000000000FFFF
      FF1F2E02000000000001000400BBF5BAC500000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000010002000000
      0000FFFFFF0000000002000000000000000000110D000005004D656D6F380002
      004B000000A4000000420000001300000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000B005B474F44535F434F44455D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00000100020000000000FFFFFF0000000002000000000000000000EE0D000006
      004D656D6F3131000200E601000012010000D00000001300000001000B000100
      0000000000000000FFFFFF1F2E02000000000001005F00D7DCCAFDC1BFA3BA5B
      666F726D6174466C6F6174282723302E2323272C5B53544F434B5F414D545D29
      5D20B1BED2B3D0A1BCC6A3BAA3A45B666F726D6174466C6F6174282723302E30
      30272C73756D285B43414C435F4D4F4E45595D29295D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000900000086
      00020000000000FFFFFF0000000002000000000000000000760E000006004D65
      6D6F313600020030000000120100004A0000001300000001000E000100000000
      0000000000FFFFFF1F2E02000000000001000A00BACFBCC6BDF0B6EEA3BA0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000020000
      0000000A0000008600020000000000FFFFFF0000000002000000000000000000
      FA0E000006004D656D6F333200020025020000330000002D0000001200000001
      00000001000000000000000000FFFFFF1F2E02000000000001000600B5A5BAC5
      A3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00020000000000080000008600020000000000FFFFFF00000000020000000000
      00000000820F000006004D656D6F353800020052020000330000006400000012
      0000000100020001000000000000000000FFFFFF1F2E02000000000001000A00
      5B474C4944455F4E4F5D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000000000008600020000000000FFFFFF0000
      0000020000000000000000001310000005004D656D6F32000200300000001900
      000086020000180000000100000001000000000000000500FFFFFF1F2E020000
      000000010014005BC6F3D2B5C3FBB3C65DBDF8BBF5C8EBBFE2B5A500000000FF
      FF00000000000200000001000000000400CBCECCE50010000000020000000000
      0A0000008600020000000000FFFFFF0000000002000000000000000000A91000
      0006004D656D6F32340002005C0200001B0000007A0000000F00000001000000
      01000000000000000000FFFFFF1F2E02000000000001001800B5DA5B50414745
      235D2F5B544F54414C50414745535DD2B300000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000009000000860002000000
      0000FFFFFF00000000020000000000000000003F11000005004D656D6F310002
      00C90000002801000080000000140000000100000001000000000000000000FF
      FFFF1F2E02000000000001001900D1E9BBF5D4B1A3BA5B47554944455F555345
      525F544558545D00000000010000000000000200000001000000000400CBCECC
      E5000A0000000200FFFFFF1F080000008600020000000000FFFFFF0000000002
      0000000000000000001612000006004D656D6F34330002007A00000012010000
      6D0100001300000001000A0001000000000000000000FFFFFF1F2E0200000000
      00010059005B536D616C6C546F426967285B666F726D6174466C6F6174282723
      302E3030272C5B53544F434B5F4D4E595D295D295D20A3A4A3BA5B666F726D61
      74466C6F6174282723302E303023272C5B53544F434B5F4D4E595D295D200000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000080000008600020000000000FFFFFF0000000002000000000000000000
      9D12000006004D656D6F33310002002E00000047000000480000001200000003
      00000001000000000000000000FFFFFF1F2E02000000000001000900B5D82020
      2020D6B73A00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000080000000100020000000000FFFFFF00000000020000
      000000000000002413000006004D656D6F35300002007400000047000000F100
      0000120000000300020001000000000000000000FFFFFF1F2E02000000000001
      0009005B414444524553535D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000080000000100020000000000FFFFFF
      0000000002000000000000000000A813000006004D656D6F3536000200650100
      00470000002C000000120000000300000001000000000000000000FFFFFF1F2E
      02000000000001000600B5E7BBB0A3BA00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000800000001000200000000
      00FFFFFF00000000020000000000000000003114000006004D656D6F35370002
      00920100004700000092000000120000000300020001000000000000000000FF
      FFFF1F2E02000000000001000B005B4D4F56455F54454C455D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00000100020000000000FFFFFF0000000002000000000000000000B314000006
      004D656D6F34320002008D00000070000000640000001600000001000F000100
      0000000000000000FFFFFF1F2E02000000000001000400CCF5C2EB00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000020000000000
      0A0000000100020000000000FFFFFF00000000020000000000000000003A1500
      0006004D656D6F35390002008D000000A4000000640000001300000001000F00
      01000000000000000000FFFFFF1F2E020000000000010009005B424152434F44
      455D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000000100020000000000FFFFFF00000000020000000000
      00000000B615000006004D656D6F36300002001A020000CC0000003C00000013
      00000001000F0001000000000000000000FFFFFF1F2E02000000000000000000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000090000008600020000000000FFFFFF0000000002000000000000000000
      3216000006004D656D6F363100020056020000CC000000600000001300000001
      000F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000009
      0000008600020000000000FFFFFF0000000002000000000000000000AE160000
      06004D656D6F3632000200F1000000CC000000D10000001300000001000F0001
      000000000000000000FFFFFF1F2E020000000000000000000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF00000000020000000000000000002C17000006004D65
      6D6F3633000200C2010000CC000000240000001300000001000F000100000000
      0000000000FFFFFF1F2E0200000000000100000000000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000000000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000A817000006004D656D6F
      3634000200E6010000CC000000340000001300000001000F0001000000000000
      000000FFFFFF1F2E020000000000000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000900000086000200000000
      00FFFFFF00000000020000000000000000002618000006004D656D6F36350002
      0030000000CC0000001B0000001300000001000F0001000000000000000000FF
      FFFF1F2E0200000000000100000000000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000000000000000A0000008600020000000000FF
      FFFF0000000002000000000000000000A418000006004D656D6F36360002004B
      000000CC000000420000001300000001000F0001000000000000000000FFFFFF
      1F2E0200000000000100000000000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000080000000100020000000000FFFFFF
      00000000020000000000000000002019000006004D656D6F36370002008D0000
      00CC000000640000001300000001000F0001000000000000000000FFFFFF1F2E
      020000000000000000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000080000000100020000000000FFFFFF00000000
      02000000000000000000031A000006004D656D6F3638000200C1020000610000
      00140000002E0100000300000001000000000000000000FFFFFF1F2E02000000
      000007000E00B0D7C1AAA3BAB4E6B8F9202020200D00000D1500202020202020
      2020202020202020202020202020200D0E00BAECC1AAA3BAB9A9D3A6C9CC2020
      0D00000D18002020202020202020202020202020202020202020202020200D0A
      00BBC6C1AAA3BABDE1CBE300000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000000000000100020000000000FFFFFF00
      00000002000000000000000000871A000006004D656D6F313000020025020000
      470000002C000000120000000300000001000000000000000000FFFFFF1F2E02
      000000000001000600BDE1CBE3A3BA00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000020000000000080000000100020000000000
      FFFFFF0000000002000000000000000000171B000006004D656D6F3135000200
      520200004700000064000000120000000300020001000000000000000000FFFF
      FF1F2E020000000000010012005B534554544C455F434F44455F544558545D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000080000000100020000000000FFFFFF00000000020000000000000000
      009D1B000005004D656D6F34000200320000005B000000440000001200000003
      00000001000000000000000000FFFFFF1F2E02000000000001000900CAD5BBF5
      C3C5B5EA3A00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000080000000100020000000000FFFFFF00000000020000
      00000000000000251C000005004D656D6F36000200730000005B000000F30000
      00120000000300020001000000000000000000FFFFFF1F2E0200000000000100
      0B005B53484F505F4E414D455D00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000000100020000000000FFFF
      FF0000000002000000000000000000A91C000006004D656D6F31370002006501
      00005B0000002C000000120000000300000001000000000000000000FFFFFF1F
      2E02000000000001000600B1B8D7A2A3BA00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000002000000000008000000010002000000
      0000FFFFFF00000000020000000000000000002F1D000006004D656D6F313900
      0200920100005B00000024010000120000000300020001000000000000000000
      FFFFFF1F2E020000000000010008005B52454D41524B5D00000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000008000000
      0100020000000000FFFFFF0000000002000000000000000000B31D000006004D
      656D6F32310002001F020000390100002C000000120000000100000001000000
      000000000000FFFFFF1F2E02000000000001000600B2C6CEF1A3BA0000000001
      0000000000000200000001000000000400CBCECCE5000A0000000200FFFFFF1F
      080000008600020000000000FFFFFF00000000020000000000000000002F1E00
      0006004D656D6F323200020054020000390100005C0000001200000001000200
      01000000000000000000FFFFFF1F2E0200000000000000000000000100000000
      00000200000001000000000400CBCECCE5000A0000000200FFFFFF1F08000000
      8600020000000000FFFFFF0000000002000000000000000000C41E000006004D
      656D6F3235000200310000004101000088010000120000000300000001000000
      000000000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B44
      4154455D205B54494D455D00000000FFFF000000000002000000010000000005
      00417269616C000A000000000000000000000000000100020000000000FFFFFF
      000000000200000000000000FEFEFF060000000A00205661726961626C657300
      0000000200736C0014006364735F436867426F64792E22534C30303030220002
      006A650014006364735F436867426F64792E224A4530303030220004006B6879
      6800000000040079687A68000000000200647A000000000000000000000000FD
      FF0100000000}
  end
  object cdsP2List: TZQuery
    FieldDefs = <>
    AfterScroll = cdsP2ListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 350
    Top = 232
  end
  object dsP2List: TDataSource
    DataSet = cdsP2List
    Left = 382
    Top = 232
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
  object frfSalRetuOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfSalRetuOrderGetValue
    OnUserFunction = frfSalRetuOrderUserFunction
    Left = 416
    Top = 233
    ReportForm = {
      18000000C4200000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00BE000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      520100000700B7D6D7E9CDB7310002010000000019000000F60200006D000000
      3200100001000000000000000000FFFFFF1F000000001500494E5428285B5345
      514E4F5D2D3129202F2031352900000000000000FFFF00000000000200000001
      0000000000000001000000C80000001400000001000000000000020039020000
      0700B7D6D7E9BDC5310002010000000012010000F60200004A00000030001100
      01000000000000000000FFFFFF1F000000000000000000000700050062656769
      6E0D1E0020696620436F756E74284D61737465724461746131293C3134207468
      656E0D060020626567696E0D260020202020666F7220693A3D436F756E74284D
      617374657244617461312920746F20313320646F0D15002020202053686F7742
      616E64284368696C6431293B0D050020656E643B0D0300656E6400FFFF000000
      000002000000010000000000000001000000C800000014000000010000000000
      0002009F02000006006368696C643100020100000000E8000000F60200001300
      00003000150001000000000000000000FFFFFF1F000000000000000000000000
      00FFFF000000000002000000010000000000000001000000C800000014000000
      0100000000000000002303000006004D656D6F33320002001E02000032000000
      2E000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000600B5A5BAC5A3BA00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000080000008600020000000000FFFFFF00
      00000002000000000000000000C103000006004D656D6F31340002002E020000
      BE0000003E0000001300000001000F0001000000000000000000FFFFFF1F2E02
      0000000000010020005B466F726D6174466C6F6174282723302E303023272C5B
      4150524943455D295D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000008600020000000000FFFFFF000000
      00020000000000000000006204000006004D656D6F31380002006C020000BE00
      00004F0000001300000001000F0001000000000000000000FFFFFF1F2E020000
      000000010023005B666F726D6174466C6F6174282723302E3030272C5B43414C
      435F4D4F4E45595D295D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      0000020000000000000000002205000006004D656D6F3230000200EE000000BE
      000000F90000001300000001000F0001000000000000000000FFFFFF1F2E0200
      00000000010042005B474F44535F4E414D455D205B50524F50455254595F3031
      5F544558545D5B50524F50455254595F30325F544558545D205B49535F505245
      53454E545F544558545D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000080000008600020000000000FFFFFF0000
      000002000000000000000000AC05000005004D656D6F390002007B0000003200
      000000010000120000000100020001000000000000000000FFFFFF1F2E020000
      00000001000D005B434C49454E545F4E414D455D00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000008000000860002
      0000000000FFFFFF00000000020000000000000000003606000006004D656D6F
      3430000200AB0100003200000072000000120000000100020001000000000000
      000000FFFFFF1F2E02000000000001000C005B53414C45535F444154455D0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000080000008600020000000000FFFFFF0000000002000000000000000000
      BF06000006004D656D6F3233000200E7010000BE000000200000001300000001
      000F0001000000000000000000FFFFFF1F2E02000000000001000B005B554E49
      545F4E414D455D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A0000000000000000000A0000008600020000000000FFFFFF0000000002
      0000000000000000004707000006004D656D6F35380002004D02000032000000
      6D000000120000000100020001000000000000000000FFFFFF1F2E0200000000
      0001000A005B474C4944455F4E4F5D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000000000008600020000000000
      FFFFFF0000000002000000000000000000E307000005004D656D6F3300020007
      020000BE000000270000001300000001000F0001000000000000000000FFFFFF
      1F2E02000000000001001F005B666F726D6174666C6F6174282723302E232327
      2C5B414D4F554E545D295D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000090000008600020000000000FFFFFF00
      000000020000000000000000007408000005004D656D6F320002003500000019
      00000085020000180000000100000001000000000000000500FFFFFF1F2E0200
      00000000010014005BC6F3D2B5C3FBB3C65DCFFACADBCDCBBBF5B5A500000000
      FFFF00000000000200000001000000000400CBCECCE500100000000200000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000FB08
      000006004D656D6F313200020035000000320000004600000012000000010000
      0001000000000000000000FFFFFF1F2E02000000000001000900BFCDBBA7C3FB
      B3C63A00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      00000000007F09000006004D656D6F31330002007D010000320000002E000000
      120000000100000001000000000000000000FFFFFF1F2E020000000000010006
      00C8D5C6DAA3BA00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000020000000000080000008600020000000000FFFFFF0000000002
      000000000000000000010A000006004D656D6F33340002002E02000070000000
      3E0000001600000001000F0001000000000000000000FFFFFF1F2E0200000000
      0001000400B5A5BCDB00000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      0002000000000000000000870A000006004D656D6F3336000200EE0000007000
      0000F90000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000800C9CCC6B7C3FBB3C600000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000008600020000000000
      FFFFFF0000000002000000000000000000090B000006004D656D6F3337000200
      0702000070000000270000001600000001000F0001000000000000000000FFFF
      FF1F2E02000000000001000400CAFDC1BF00000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF00000000020000000000000000008B0B000006004D656D6F333800
      0200E701000070000000200000001600000001000F0001000000000000000000
      FFFFFF1F2E02000000000001000400B5A5CEBB00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000A00000086000200
      00000000FFFFFF0000000002000000000000000000600C000006004D656D6F32
      3500020035000000120100009E0100001300000001000E000100000000000000
      0000FFFFFF1F2E02000000000001005700BACFBCC6BDF0B6EEA3BA5B536D616C
      6C546F426967285B53414C455F4D4E595D295D2020A3A43A5B666F726D617446
      6C6F6174282723302E3030272C5B53414C455F4D4E595D295D20202020202020
      202020202020202000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      02000000000000000000EE0C000006004D656D6F3432000200C20100004A0100
      006E0000000F0000000100000001000000000000000000FFFFFF1F2E02000000
      000001001000BFCDBBA7C7A9C3FB28B8C7D5C229A3BA00000000010000000000
      000200000001000000000400CBCECCE5000A0000000200FFFFFF1F0800000086
      00020000000000FFFFFF0000000002000000000000000000740D000006004D65
      6D6F3434000200590100002A0100003700000014000000010000000100000000
      0000000000FFFFFF1F2E02000000000001000800B2D6B9DCD4B1A3BA00000000
      010000000000000200000001000000000400CBCECCE5000A0000000200FFFFFF
      1F080000008600020000000000FFFFFF0000000002000000000000000000FA0D
      000006004D656D6F3431000200FC0100002A0100003500000014000000010000
      0001000000000000000000FFFFFF1F2E02000000000001000800CBCDBBF5D4B1
      A3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00020000000000080000008600020000000000FFFFFF00000000020000000000
      000000007C0E000006004D656D6F34350002006C020000700000004F00000016
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001000400
      BDF0B6EE00000000FFFF00000000000200000001000000000400CBCECCE5000A
      0000000200000000000A0000008600020000000000FFFFFF0000000002000000
      000000000000010F000006004D656D6F353400020035000000BE0000001B0000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      07005B5345514E4F5D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000000000000000A0000008600020000000000FFFFFF000000
      0002000000000000000000810F000006004D656D6F3535000200350000007000
      00001B0000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000200D0F200000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      00020000000000000000000210000005004D656D6F3700020050000000700000
      003E0000001600000001000F0001000000000000000000FFFFFF1F2E02000000
      000001000400BBF5BAC500000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF0000
      0000020000000000000000008A10000005004D656D6F3800020050000000BE00
      00003E0000001300000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000B005B474F44535F434F44455D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000080000000100020000
      000000FFFFFF00000000020000000000000000002011000006004D656D6F3234
      0002007A02000019000000560000001200000001000000010000000000000000
      00FFFFFF1F2E02000000000001001800B5DA5B50414745235D2F5B544F54414C
      50414745535DD2B300000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000090000008600020000000000FFFFFF00000000
      02000000000000000000A911000006004D656D6F32360002007B000000460000
      00E5000000120000000100020001000000000000000000FFFFFF1F2E02000000
      000001000B005B53454E445F414444525D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF00000000020000000000000000003012000006004D656D6F323700
      0200350000004600000046000000120000000100000001000000000000000000
      FFFFFF1F2E02000000000001000900CBCDBBF5B5D8D6B73A00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000020000000000080000
      008600020000000000FFFFFF0000000002000000000000000000B91200000600
      4D656D6F3238000200A801000046000000750000001200000001000200010000
      00000000000000FFFFFF1F2E02000000000001000B005B54454C4550484F4E45
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000080000008600020000000000FFFFFF0000000002000000000000
      0000004013000006004D656D6F32390002006201000046000000460000001200
      00000100000001000000000000000000FFFFFF1F2E02000000000001000900C1
      AACFB5B5E7BBB03A00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      02000000000000000000D513000005004D656D6F31000200370000002A010000
      7C000000140000000100000001000000000000000000FFFFFF1F2E0200000000
      0001001800D6C6B5A5C8CBA3BA5B435245415F555345525F544558545D000000
      00010000000000000200000001000000000400CBCECCE5000A0000000200FFFF
      FF1F080000008600020000000000FFFFFF000000000200000000000000000057
      14000006004D656D6F35360002008E0000007000000060000000160000000100
      0F0001000000000000000000FFFFFF1F2E02000000000001000400CCF5C2EB00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000000100020000000000FFFFFF00000000020000000000000000
      00DE14000006004D656D6F35370002008E000000BE0000006000000013000000
      01000F0001000000000000000000FFFFFF1F2E020000000000010009005B4241
      52434F44455D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000000100020000000000FFFFFF000000000200
      0000000000000000C115000006004D656D6F3539000200C00200005C00000018
      0000002A0100000300000001000000000000000000FFFFFF1F2E020000000000
      07000B00B0D7C1AAA3BAB4E6B8F9200D00000D1E002020202020202020202020
      202020202020202020202020202020202020200D0C00BAECC1AAA3BABFCDBBA7
      20200D00000D140020202020202020202020202020202020202020200D0A00BB
      C6C1AAA3BABDE1CBE300000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000020000000000000000000100020000000000FFFFFF000000
      00020000000000000000003D16000006004D656D6F36300002002E020000E800
      00003E0000001300000001000F0001000000000000000000FFFFFF1F2E020000
      000000000000000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000090000008600020000000000FFFFFF00000000020000
      00000000000000B916000006004D656D6F36310002006C020000E80000004F00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      0000003517000006004D656D6F3632000200EE000000E8000000F90000001300
      000001000F0001000000000000000000FFFFFF1F2E0200000000000000000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000080000008600020000000000FFFFFF0000000002000000000000000000B1
      17000006004D656D6F3633000200E7010000E800000020000000130000000100
      0F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000A00
      00008600020000000000FFFFFF00000000020000000000000000002D18000006
      004D656D6F363400020007020000E8000000270000001300000001000F000100
      0000000000000000FFFFFF1F2E020000000000000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000090000008600
      020000000000FFFFFF0000000002000000000000000000A918000006004D656D
      6F363500020035000000E80000001B0000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000000000000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000000000000000A000000860002000000
      0000FFFFFF00000000020000000000000000002519000006004D656D6F363600
      020050000000E80000003E0000001300000001000F0001000000000000000000
      FFFFFF1F2E020000000000000000000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000000100020000000000FFFF
      FF0000000002000000000000000000A319000006004D656D6F36370002008E00
      0000E8000000600000001300000001000F0001000000000000000000FFFFFF1F
      2E0200000000000100000000000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000000100020000000000FFFFFF00
      00000002000000000000000000811A000005004D656D6F35000200D401000012
      010000E70000001300000003000B0001000000000000000000FFFFFF1F2E0200
      0000000001006100D7DCCAFDC1BFA3BA5B666F726D6174666C6F617428272330
      2E2323272C5B53414C455F414D545D295D20B1BED2B3D0A1BCC6A3BAA3A43A5B
      666F726D6174466C6F6174282723302E3030272C5B73756D285B43414C435F4D
      4F4E45595D295D295D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000000100020000000000FFFFFF000000
      0002000000000000000000FD1A000006004D656D6F3130000200320200002F01
      0000610000000C0000000100020001000000000000000000FFFFFF1F2E020000
      000000000000000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000080000008600020000000000FFFFFF00000000020000
      00000000000000791B000006004D656D6F3131000200920100002C0100006100
      0000100000000100020001000000000000000000FFFFFF1F2E02000000000000
      0000000000010000000000000200000001000000000400CBCECCE5000A000000
      0200FFFFFF1F080000008600020000000000FFFFFF0000000002000000000000
      000000091C000006004D656D6F31350002004D020000460000006D0000001200
      00000100020001000000000000000000FFFFFF1F2E020000000000010012005B
      534554544C455F434F44455F544558545D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF00000000020000000000000000008C1C000006004D656D6F313600
      02001E020000460000002E000000120000000100000001000000000000000000
      FFFFFF1F2E02000000000001000500BDE1CBE33A00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000002000000000008000000860002
      0000000000FFFFFF00000000020000000000000000001F1D000005004D656D6F
      34000200370000004B0100001401000012000000030000000100000000000000
      0000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D
      205B54494D455D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000000000000100020000000000FFFFFF0000000002
      000000000000000000A71D000005004D656D6F360002007D0000005B00000097
      000000120000000100020001000000000000000000FFFFFF1F2E020000000000
      01000B005B53484F505F4E414D455D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000080000008600020000000000
      FFFFFF00000000020000000000000000002E1E000006004D656D6F3137000200
      350000005B00000046000000120000000100000001000000000000000000FFFF
      FF1F2E02000000000001000900CDCBBBF5C3C5B5EA3A00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000200000000000800000086
      00020000000000FFFFFF0000000002000000000000000000C51E000006004D65
      6D6F3139000200B50000002A0100007C00000014000000010000000100000000
      0000000000FFFFFF1F2E02000000000001001900D2B5CEF1D4B1A3BA5B475549
      44455F555345525F544558545D00000000010000000000000200000001000000
      000400CBCECCE5000A0000000200FFFFFF1F080000008600020000000000FFFF
      FF0000000002000000000000000000481F000006004D656D6F32310002001A01
      00005B00000027000000120000000100000001000000000000000000FFFFFF1F
      2E02000000000001000500B1B8D7A23A00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000800000086000200000000
      00FFFFFF0000000002000000000000000000CE1F000006004D656D6F33350002
      00410100005B0000007A010000120000000100020001000000000000000000FF
      FFFF1F2E020000000000010008005B52454D41524B5D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF00000000020000000000000000004A20000006004D65
      6D6F3339000200320200004E010000610000000C000000010002000100000000
      0000000000FFFFFF1F2E020000000000000000000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000008600020000
      000000FFFFFF000000000200000000000000FEFEFF060000000A002056617269
      61626C6573000000000200736C0014006364735F436867426F64792E22534C30
      303030220002006A650014006364735F436867426F64792E224A453030303022
      0004006B68796800000000040079687A68000000000200647A00000000000000
      0000000000FDFF0100000000}
  end
  object frfDbOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfDbOrderGetValue
    OnUserFunction = frfDbOrderUserFunction
    Left = 424
    Top = 289
    ReportForm = {
      18000000AA1F0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00BE000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      520100000700B7D6D7E9CDB7310002010000000019000000F60200006D000000
      3200100001000000000000000000FFFFFF1F000000001500494E5428285B5345
      514E4F5D2D3129202F2031352900000000000000FFFF00000000000200000001
      0000000000000001000000C80000001400000001000000000000020039020000
      0700B7D6D7E9BDC5310002010000000012010000F60200004A00000030001100
      01000000000000000000FFFFFF1F000000000000000000000700050062656769
      6E0D1E0020696620436F756E74284D61737465724461746131293C3134207468
      656E0D060020626567696E0D260020202020666F7220693A3D436F756E74284D
      617374657244617461312920746F20313320646F0D15002020202053686F7742
      616E64284368696C6431293B0D050020656E643B0D0300656E6400FFFF000000
      000002000000010000000000000001000000C800000014000000010000000000
      0002009F02000006006368696C643100020100000000E8000000F60200001300
      00003000150001000000000000000000FFFFFF1F000000000000000000000000
      00FFFF000000000002000000010000000000000001000000C800000014000000
      0100000000000000002403000006004D656D6F33320002001902000032000000
      3A000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000700B5A520BAC5A3BA00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000020000000000090000008600020000000000FFFFFF
      0000000002000000000000000000C203000006004D656D6F31340002002E0200
      00BE000000440000001300000001000F0001000000000000000000FFFFFF1F2E
      020000000000010020005B466F726D6174466C6F6174282723302E303023272C
      5B4150524943455D295D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      0000020000000000000000006304000006004D656D6F313800020072020000BE
      000000490000001300000001000F0001000000000000000000FFFFFF1F2E0200
      00000000010023005B666F726D6174466C6F6174282723302E3030272C5B4341
      4C435F4D4F4E45595D295D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000090000008600020000000000FFFFFF00
      000000020000000000000000002305000006004D656D6F3230000200EE000000
      BE000000F90000001300000001000F0001000000000000000000FFFFFF1F2E02
      0000000000010042005B474F44535F4E414D455D205B50524F50455254595F30
      315F544558545D5B50524F50455254595F30325F544558545D205B49535F5052
      4553454E545F544558545D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000008600020000000000FFFFFF00
      00000002000000000000000000AD05000005004D656D6F390002007B00000046
      000000E5000000120000000100020001000000000000000000FFFFFF1F2E0200
      0000000001000D005B434C49454E545F4E414D455D00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000080000008600
      020000000000FFFFFF00000000020000000000000000003706000006004D656D
      6F3430000200A9010000320000006D0000001200000001000200010000000000
      00000000FFFFFF1F2E02000000000001000C005B53414C45535F444154455D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000080000008600020000000000FFFFFF00000000020000000000000000
      00C006000006004D656D6F3233000200E7010000BE0000002000000013000000
      01000F0001000000000000000000FFFFFF1F2E02000000000001000B005B554E
      49545F4E414D455D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000000000000000A0000008600020000000000FFFFFF00000000
      020000000000000000004807000006004D656D6F353800020054020000320000
      0067000000120000000100020001000000000000000000FFFFFF1F2E02000000
      000001000A005B474C4944455F4E4F5D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000000000086000200000000
      00FFFFFF0000000002000000000000000000E407000005004D656D6F33000200
      07020000BE000000270000001300000001000F0001000000000000000000FFFF
      FF1F2E02000000000001001F005B666F726D6174666C6F6174282723302E2323
      272C5B414D4F554E545D295D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000090000008600020000000000FFFFFF
      00000000020000000000000000007108000005004D656D6F3200020035000000
      1900000085020000180000000100000001000000000000000500FFFFFF1F2E02
      0000000000010010005BC6F3D2B5C3FBB3C65DB5F7B2A6B5A500000000FFFF00
      000000000200000001000000000400CBCECCE500100000000200000000000A00
      00008600020000000000FFFFFF0000000002000000000000000000F808000006
      004D656D6F313200020035000000460000004600000012000000010000000100
      0000000000000000FFFFFF1F2E02000000000001000900B5F7C8EBC3C5B5EA3A
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      0000000000090000008600020000000000FFFFFF000000000200000000000000
      00008009000006004D656D6F3133000200610100003200000045000000120000
      000100000001000000000000000000FFFFFF1F2E02000000000001000A00B5F7
      B2A6C8D5C6DAA3BA00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      02000000000000000000020A000006004D656D6F33340002002E020000700000
      00440000001600000001000F0001000000000000000000FFFFFF1F2E02000000
      000001000400B5A5BCDB00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF0000
      000002000000000000000000880A000006004D656D6F3336000200EE00000070
      000000F90000001600000001000F0001000000000000000000FFFFFF1F2E0200
      0000000001000800C9CCC6B7C3FBB3C600000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000A00000086000200000000
      00FFFFFF00000000020000000000000000000A0B000006004D656D6F33370002
      000702000070000000270000001600000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000400CAFDC1BF00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF00000000020000000000000000008C0B000006004D656D6F3338
      000200E701000070000000200000001600000001000F00010000000000000000
      00FFFFFF1F2E02000000000001000400B5A5CEBB00000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000620C000006004D656D6F
      32350002003500000012010000B10100001300000001000E0001000000000000
      000000FFFFFF1F2E02000000000001005800BACFBCC6BDF0B6EEA3BA205B536D
      616C6C546F426967285B53414C455F4D4E595D295D2020A3A43A5B666F726D61
      74466C6F6174282723302E3030272C5B53414C455F4D4E595D295D2020202020
      2020202020202020202000000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000080000008600020000000000FFFFFF0000
      000002000000000000000000E60C000006004D656D6F34320002000202000049
      0100002A0000000F0000000100000001000000000000000000FFFFFF1F2E0200
      0000000001000600B2C6CEF1A3BA000000000100000000000002000000010000
      00000400CBCECCE5000A0000000200FFFFFF1F080000008600020000000000FF
      FFFF00000000020000000000000000006C0D000006004D656D6F343500020072
      02000070000000490000001600000001000F0001000000000000000000FFFFFF
      1F2E02000000000001000800CFFACADBBDF0B6EE00000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF0000000002000000000000000000F10D000006004D656D6F
      353400020035000000BE0000001B0000001300000001000F0001000000000000
      000000FFFFFF1F2E020000000000010007005B5345514E4F5D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000A00
      00008600020000000000FFFFFF0000000002000000000000000000710E000006
      004D656D6F353500020035000000700000001B0000001600000001000F000100
      0000000000000000FFFFFF1F2E02000000000001000200D0F200000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000200000000000A00
      00008600020000000000FFFFFF0000000002000000000000000000F20E000005
      004D656D6F3700020050000000700000003E0000001600000001000F00010000
      00000000000000FFFFFF1F2E02000000000001000400BBF5BAC500000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000200000000000A
      0000000100020000000000FFFFFF00000000020000000000000000007A0F0000
      05004D656D6F3800020050000000BE0000003E0000001300000001000F000100
      0000000000000000FFFFFF1F2E02000000000001000B005B474F44535F434F44
      455D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000000100020000000000FFFFFF00000000020000000000
      000000001010000006004D656D6F32340002007A020000190000005600000012
      0000000100000001000000000000000000FFFFFF1F2E02000000000001001800
      B5DA5B50414745235D2F5B544F54414C50414745535DD2B300000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF0000000002000000000000000000991000000600
      4D656D6F32360002007C0000005A000000E40000001200000001000200010000
      00000000000000FFFFFF1F2E02000000000001000B005B53454E445F41444452
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000080000008600020000000000FFFFFF0000000002000000000000
      0000002011000006004D656D6F3237000200360000005A000000450000001200
      00000100000001000000000000000000FFFFFF1F2E02000000000001000900CA
      D5BBF5B5D8D6B73A00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000090000008600020000000000FFFFFF00000000
      02000000000000000000A911000006004D656D6F3238000200A8010000470000
      006E000000120000000100020001000000000000000000FFFFFF1F2E02000000
      000001000B005B54454C4550484F4E455D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF00000000020000000000000000003012000006004D656D6F323900
      0200620100004700000046000000120000000100000001000000000000000000
      FFFFFF1F2E02000000000001000900C1AACFB5B5E7BBB03A00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000020000000000080000
      008600020000000000FFFFFF0000000002000000000000000000C51200000500
      4D656D6F31000200370000002A0100007C000000140000000100000001000000
      000000000000FFFFFF1F2E02000000000001001800D6C6B5A5C8CBA3BA5B4352
      45415F555345525F544558545D00000000010000000000000200000001000000
      000400CBCECCE5000A0000000200FFFFFF1F080000008600020000000000FFFF
      FF00000000020000000000000000004713000006004D656D6F35360002008E00
      000070000000600000001600000001000F0001000000000000000000FFFFFF1F
      2E02000000000001000400CCF5C2EB00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000000100020000000000
      FFFFFF0000000002000000000000000000CE13000006004D656D6F3537000200
      8E000000BE000000600000001300000001000F0001000000000000000000FFFF
      FF1F2E020000000000010009005B424152434F44455D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000001
      00020000000000FFFFFF0000000002000000000000000000B514000006004D65
      6D6F3539000200C00200005C000000180000004E010000030000000100000000
      0000000000FFFFFF1F2E02000000000007000D00B0D7C1AAA3BAB5F7B3F6B7BD
      200D00000D1E0020202020202020202020202020202020202020202020202020
      20202020200D0E00BAECC1AAA3BAB5F7C8EBB7BD20200D00000D140020202020
      202020202020202020202020202020200D0A00BBC6C1AAA3BABDE1CBE3000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000000000000100020000000000FFFFFF000000000200000000000000000031
      15000006004D656D6F36300002002E020000E800000044000000130000000100
      0F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000900
      00008600020000000000FFFFFF0000000002000000000000000000AD15000006
      004D656D6F363100020072020000E8000000490000001300000001000F000100
      0000000000000000FFFFFF1F2E020000000000000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000090000008600
      020000000000FFFFFF00000000020000000000000000002916000006004D656D
      6F3632000200EE000000E8000000F90000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000000000000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF0000000002000000000000000000A516000006004D656D6F363300
      0200E7010000E8000000200000001300000001000F0001000000000000000000
      FFFFFF1F2E020000000000000000000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000000000000000A0000008600020000000000FFFF
      FF00000000020000000000000000002117000006004D656D6F36340002000702
      0000E8000000270000001300000001000F0001000000000000000000FFFFFF1F
      2E020000000000000000000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000008600020000000000FFFFFF000000
      00020000000000000000009D17000006004D656D6F363500020035000000E800
      00001B0000001300000001000F0001000000000000000000FFFFFF1F2E020000
      000000000000000000FFFF00000000000200000001000000000400CBCECCE500
      0A0000000000000000000A0000008600020000000000FFFFFF00000000020000
      000000000000001918000006004D656D6F363600020050000000E80000003E00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000080000000100020000000000FFFFFF0000000002000000000000
      0000009718000006004D656D6F36370002008E000000E8000000600000001300
      000001000F0001000000000000000000FFFFFF1F2E0200000000000100000000
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000080000000100020000000000FFFFFF00000000020000000000000000
      006E19000005004D656D6F35000200E701000012010000D40000001300000003
      000B0001000000000000000000FFFFFF1F2E02000000000001005A00D7DCCAFD
      C1BFA3BA5B666F726D6174666C6F6174282723302E2323272C5B53414C455F41
      4D545D295D20B1BED2B3D0A1BCC6A3BA5B666F726D6174466C6F617428272330
      2E3023272C5B73756D285B414D4F554E545D295D295D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000900000001
      00020000000000FFFFFF0000000002000000000000000000011A000005004D65
      6D6F340002003700000046010000140100001200000003000000010000000000
      00000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154
      455D205B54494D455D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000000000000100020000000000FFFFFF000000
      0002000000000000000000891A000005004D656D6F360002007D000000320000
      00E3000000120000000100020001000000000000000000FFFFFF1F2E02000000
      000001000B005B53484F505F4E414D455D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF0000000002000000000000000000101B000006004D656D6F313700
      0200350000003200000046000000120000000100000001000000000000000000
      FFFFFF1F2E02000000000001000900B7A2BBF5C3C5B5EA3A00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000020000000000090000
      008600020000000000FFFFFF0000000002000000000000000000961B00000600
      4D656D6F3231000200630100005B000000430000001200000001000000010000
      00000000000000FFFFFF1F2E02000000000001000800B1B8202020D7A23A0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000020000
      000000090000008600020000000000FFFFFF0000000002000000000000000000
      1C1C000006004D656D6F3335000200A90100005B000000120100001200000001
      00020001000000000000000000FFFFFF1F2E020000000000010008005B52454D
      41524B5D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000080000008600020000000000FFFFFF0000000002000000
      000000000000981C000006004D656D6F3339000200320200004A010000610000
      000C0000000100020001000000000000000000FFFFFF1F2E0200000000000000
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      0000000000080000008600020000000000FFFFFF000000000200000000000000
      00001F1D000006004D656D6F3130000200520200004600000069000000120000
      000100020001000000000000000000FFFFFF1F2E020000000000010009005B4C
      494E4B4D414E5D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000080000008600020000000000FFFFFF0000000002
      000000000000000000A41D000006004D656D6F31350002001802000046000000
      3A000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000700C1AACFB5C8CB3A00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000020000000000080000008600020000000000FFFFFF
      0000000002000000000000000000281E000006004D656D6F3136000200440100
      002A01000027000000140000000100000001000000000000000000FFFFFF1F2E
      02000000000001000600CAD5BBF5A3BA00000000010000000000000200000001
      000000000400CBCECCE5000A0000000200FFFFFF1F0800000086000200000000
      00FFFFFF0000000002000000000000000000AC1E000006004D656D6F32320002
      00C40000002A01000028000000140000000100000001000000000000000000FF
      FFFF1F2E02000000000001000600B7A2BBF5A3BA000000000100000000000002
      00000001000000000400CBCECCE5000A0000000200FFFFFF1F08000000860002
      0000000000FFFFFF0000000002000000000000000000301F000006004D656D6F
      3330000200CF0100002A01000027000000140000000100000001000000000000
      000000FFFFFF1F2E02000000000001000600B3D0D4CBA3BA0000000001000000
      0000000200000001000000000400CBCECCE5000A0000000200FFFFFF1F080000
      008600020000000000FFFFFF000000000200000000000000FEFEFF060000000A
      00205661726961626C6573000000000200736C0014006364735F436867426F64
      792E22534C30303030220002006A650014006364735F436867426F64792E224A
      4530303030220004006B68796800000000040079687A68000000000200647A00
      0000000000000000000000FDFF0100000000}
  end
end
