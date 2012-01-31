inherited frmOutLocusOrderList: TfrmOutLocusOrderList
  Left = 236
  Top = 161
  Width = 868
  Height = 575
  Caption = #21457#36135#21333
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
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38144#21806#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 842
            Height = 468
            inherited RzPanel1: TRzPanel
              Width = 832
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
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
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
                Buttons = [zbClear]
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
              Width = 832
              Height = 346
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
                  FieldName = 'LOCUS_STATUS_NAME'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '3')
                  PickList.Strings = (
                    #24453#21457#36135
                    #24050#21457#36135)
                  Title.Caption = #21457#36135#29366#24577
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
          Caption = #35843#25320#21333#26597#35810
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
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
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
              Width = 832
              Height = 356
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
                  FieldName = 'LOCUS_STATUS_NAME'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '3')
                  PickList.Strings = (
                    #24453#21457#36135
                    #24050#21457#36135)
                  Title.Caption = #21457#36135#29366#24577
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
        object TabSheet3: TRzTabSheet
          Color = clWindow
          Caption = #35843#25972#21333#26597#35810
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
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
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
                Buttons = [zbClear]
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
              Width = 832
              Height = 366
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
                  FieldName = 'SHOP_NAME_TEXT'
                  Footers = <>
                  Title.Caption = #38376#24215#21517#31216
                  Width = 120
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
                  FieldName = 'LOCUS_STATUS_NAME'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '3')
                  PickList.Strings = (
                    #24453#21457#36135
                    #24050#21457#36135)
                  Title.Caption = #21457#36135#29366#24577
                  Width = 60
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
        object TabSheet4: TRzTabSheet
          Color = clWindow
          Caption = #37319#36141#36864#36135#21333
          object RzPanel10: TRzPanel
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
            object RzPanel11: TRzPanel
              Left = 5
              Top = 5
              Width = 832
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
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#21457#36135
                  end
                  item
                    Caption = #24050#21457#36135
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
              Width = 832
              Height = 348
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
                  FieldName = 'LOCUS_STATUS_NAME'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '3')
                  PickList.Strings = (
                    #24453#21457#36135
                    #24050#21457#36135)
                  Title.Caption = #21457#36135#29366#24577
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
    Left = 208
    Top = 192
  end
  inherited actList: TActionList
    Top = 192
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
  object frfSalesOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfSalesOrderGetValue
    Left = 488
    Top = 201
    ReportForm = {
      1800000030940000180000FFFF01000100FFFFFFFFFF3C00000034080000E40C
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      0036010000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      520100000700B7D6D7E9CDB7310002010000000021000000F6020000DD000000
      3200100001000000000000000000FFFFFF1F000000001500494E5428285B5345
      514E4F5D2D3129202F2031352900000000000000FFFF00000000000200000001
      0000000000000001000000C80000001400000001000000000000020039020000
      0700B7D6D7E9BDC53100020100000000AE010000F6020000FA01000030001100
      01000000000000000000FFFFFF1F000000000000000000000700050062656769
      6E0D1E0020696620436F756E74284D61737465724461746131293C3134207468
      656E0D060020626567696E0D260020202020666F7220693A3D436F756E74284D
      617374657244617461312920746F20313320646F0D15002020202053686F7742
      616E64284368696C6431293B0D050020656E643B0D0300656E6400FFFF000000
      000002000000010000000000000001000000C800000014000000010000000000
      0002009F02000006006368696C64310002010000000070010000F60200001300
      00003000150001000000000000000000FFFFFF1F000000000000000000000000
      00FFFF000000000002000000010000000000000001000000C800000014000000
      0100000000000000002303000006004D656D6F3332000200DC010000CE000000
      34000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000600B5A520BAC53A00000000FFFF000000000002000000010000000004
      00CBCECCE5000C000000020000000000080000008600020000000000FFFFFF00
      00000002000000000000000000B003000006004D656D6F31340002002A020000
      36010000980000001300000001000F0001000000000000000000FFFFFF1F2E02
      000000000001000F005B52454D41524B5F44455441494C5D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF0000000002000000000000000000700400000600
      4D656D6F32300002009A000000360100003D0100001300000001000F00010000
      00000000000000FFFFFF1F2E020000000000010042005B474F44535F4E414D45
      5D205B50524F50455254595F30315F544558545D5B50524F50455254595F3032
      5F544558545D205B49535F50524553454E545F544558545D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000C000000000000000000080000
      008600020000000000FFFFFF0000000002000000000000000000FA0400000500
      4D656D6F3900020083000000E60100001D020000120000000100020001000000
      000000000000FFFFFF1F2E02000000000001000D005B434C49454E545F4E414D
      455D00000000FFFF00000000000200000001000000000400CBCECCE5000C0000
      00000000000000080000008600020000000000FFFFFF00000000020000000000
      000000008305000006004D656D6F3233000200D7010000360100002000000013
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001000B00
      5B554E49545F4E414D455D00000000FFFF000000000002000000010000000004
      00CBCECCE5000C0000000000000000000A0000008600020000000000FFFFFF00
      000000020000000000000000000B06000006004D656D6F353800020018020000
      CE000000A6000000120000000100020001000000000000000000FFFFFF1F2E02
      000000000001000A005B474C4944455F4E4F5D00000000FFFF00000000000200
      000001000000000400CBCECCE5000C0000000000000000000000000086000200
      00000000FFFFFF0000000002000000000000000000A706000005004D656D6F33
      000200F701000036010000330000001300000001000F00010000000000000000
      00FFFFFF1F2E02000000000001001F005B666F726D6174666C6F617428272330
      2E2323272C5B414D4F554E545D295D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000C0000000200000000000A0000008600020000000000
      FFFFFF00000000020000000000000000002E07000005004D656D6F320002003D
      0000004100000085020000180000000100000001000000000000000500FFFFFF
      1F2E02000000000001000A005BC6F3D2B5C3FBB3C65D00000000FFFF00000000
      000200000001000000000400CBCECCE500180000000200000000000A00000086
      00020000000000FFFFFF0000000002000000000000000000B507000006004D65
      6D6F313200020039000000E60100004600000012000000010000000100000000
      0000000000FFFFFF1F2E02000000000001000900CAD5BBF5B5A5CEBB3A000000
      00FFFF00000000000200000001000000000400CBCECCE5000C00000002000000
      0000080000008600020000000000FFFFFF000000000200000000000000000039
      08000006004D656D6F33340002002A020000E800000098000000160000000100
      0F0001000000000000000000FFFFFF1F2E02000000000001000600B1B82020D7
      A200000000FFFF00000000000200000001000000000400CBCECCE5000C000000
      0200000000000A0000008600020000000000FFFFFF0000000002000000000000
      000000BF08000006004D656D6F33360002009A000000E80000003D0100001600
      000001000F0001000000000000000000FFFFFF1F2E02000000000001000800C9
      CCC6B7C3FBB3C600000000FFFF00000000000200000001000000000400CBCECC
      E5000C0000000200000000000A0000008600020000000000FFFFFF0000000002
      0000000000000000004109000006004D656D6F3337000200F7010000E8000000
      330000001600000001000F0001000000000000000000FFFFFF1F2E0200000000
      0001000400CAFDC1BF00000000FFFF00000000000200000001000000000400CB
      CECCE5000C0000000200000000000A0000008600020000000000FFFFFF000000
      0002000000000000000000C309000006004D656D6F3338000200D7010000E800
      0000200000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000400B5A5CEBB00000000FFFF000000000002000000010000000004
      00CBCECCE5000C0000000200000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000550A000006004D656D6F323500020025000000
      AE010000B20100001300000001000E0001000000000000000000FFFFFF1F2E02
      000000000001001400BACFBCC6A3BA2020202020202020202020202020000000
      00FFFF00000000000200000001000000000400CBCECCE5000C00000002000000
      0000080000008600020000000000FFFFFF0000000002000000000000000000E8
      0A000006004D656D6F343400020039000000CA020000BF000000140000000100
      000001000000000000000000FFFFFF1F2E02000000000001001500BBF5BFEECA
      D5C6FDA3ACB3F6C4C9D4B1C7A9C3FB3A00000000010000000000000200000001
      000000000400CBCECCE5000C0000000200FFFFFF1F0800000086000200000000
      00FFFFFF0000000002000000000000000000740B000006004D656D6F34310002
      0039000000A602000079000000140000000100000001000000000000000000FF
      FFFF1F2E02000000000001000E00B8B1D7DCBEADC0EDC7A9C3FBA3BA00000000
      FFFF00000000000200000001000000000400CBCECCE5000C0000000200000000
      00080000008600020000000000FFFFFF0000000002000000000000000000F90B
      000006004D656D6F35340002002500000036010000230000001300000001000F
      0001000000000000000000FFFFFF1F2E020000000000010007005B5345514E4F
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000C000000
      0000000000000A0000008600020000000000FFFFFF0000000002000000000000
      000000780C000006004D656D6F353500020025000000E8000000230000001600
      000001000F0001000000000000000000FFFFFF1F2E0200000000000100010041
      00000000FFFF00000000000200000001000000000400CBCECCE5000C00000002
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      0000F90C000005004D656D6F3700020048000000E80000005200000016000000
      01000F0001000000000000000000FFFFFF1F2E02000000000001000400BBF5BA
      C500000000FFFF00000000000200000001000000000400CBCECCE5000C000000
      0200000000000A0000000100020000000000FFFFFF0000000002000000000000
      000000810D000005004D656D6F38000200480000003601000052000000130000
      0001000F0001000000000000000000FFFFFF1F2E02000000000001000B005B47
      4F44535F434F44455D00000000FFFF00000000000200000001000000000400CB
      CECCE5000C000000000000000000080000000100020000000000FFFFFF000000
      0002000000000000000000170E000006004D656D6F32340002007A0200001100
      000056000000120000000100000001000000000000000000FFFFFF1F2E020000
      00000001001800B5DA5B50414745235D2F5B544F54414C50414745535DD2B300
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000090000008600020000000000FFFFFF00000000020000000000000000
      00A00E000006004D656D6F323600020083000000020200001D02000012000000
      0100020001000000000000000000FFFFFF1F2E02000000000001000B005B5345
      4E445F414444525D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000C000000000000000000080000008600020000000000FFFFFF00000000
      02000000000000000000270F000006004D656D6F323700020039000000020200
      0046000000120000000100000001000000000000000000FFFFFF1F2E02000000
      000001000900CBCDBBF5B5D8D6B73A00000000FFFF0000000000020000000100
      0000000400CBCECCE5000C000000020000000000080000008600020000000000
      FFFFFF0000000002000000000000000000AE0F000006004D656D6F3238000200
      840000001E0200007C000000120000000100020001000000000000000000FFFF
      FF1F2E020000000000010009005B4C494E4B4D414E5D00000000FFFF00000000
      000200000001000000000400CBCECCE5000C0000000000000000000800000086
      00020000000000FFFFFF00000000020000000000000000003510000006004D65
      6D6F3239000200390000001E0200004400000012000000010000000100000000
      0000000000FFFFFF1F2E02000000000001000900C1AA20CFB520C8CB3A000000
      00FFFF00000000000200000001000000000400CBCECCE5000C00000002000000
      0000080000008600020000000000FFFFFF0000000002000000000000000000CB
      10000005004D656D6F31000200370000005A020000CC00000014000000010000
      0001000000000000000000FFFFFF1F2E02000000000001001900D6C6202020B5
      A5A3BA5B435245415F555345525F544558545D00000000010000000000000200
      000001000000000400CBCECCE5000C0000000200FFFFFF1F0800000086000200
      00000000FFFFFF00000000020000000000000000004711000006004D656D6F36
      300002002A02000070010000980000001300000001000F000100000000000000
      0000FFFFFF1F2E020000000000000000000000FFFF0000000000020000000100
      0000000400CBCECCE5000C000000000000000000090000008600020000000000
      FFFFFF0000000002000000000000000000C311000006004D656D6F3632000200
      9A000000700100003D0100001300000001000F0001000000000000000000FFFF
      FF1F2E020000000000000000000000FFFF000000000002000000010000000004
      00CBCECCE5000C000000000000000000080000008600020000000000FFFFFF00
      000000020000000000000000003F12000006004D656D6F3633000200D7010000
      70010000200000001300000001000F0001000000000000000000FFFFFF1F2E02
      0000000000000000000000FFFF00000000000200000001000000000400CBCECC
      E5000C0000000000000000000A0000008600020000000000FFFFFF0000000002
      000000000000000000BB12000006004D656D6F3634000200F701000070010000
      330000001300000001000F0001000000000000000000FFFFFF1F2E0200000000
      00000000000000FFFF00000000000200000001000000000400CBCECCE5000C00
      0000000000000000090000008600020000000000FFFFFF000000000200000000
      00000000003713000006004D656D6F3635000200250000007001000023000000
      1300000001000F0001000000000000000000FFFFFF1F2E020000000000000000
      000000FFFF00000000000200000001000000000400CBCECCE5000C0000000000
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00B313000006004D656D6F363600020048000000700100005200000013000000
      01000F0001000000000000000000FFFFFF1F2E020000000000000000000000FF
      FF00000000000200000001000000000400CBCECCE5000C000000000000000000
      080000000100020000000000FFFFFF00000000020000000000000000008A1400
      0005004D656D6F35000200D3010000AE010000EF0000001300000001000B0001
      000000000000000000FFFFFF1F2E02000000000001005A00D7DCCAFDC1BFA3BA
      5B666F726D6174666C6F6174282723302E2323272C5B53414C455F414D545D29
      5D20B1BED2B3D0A1BCC6A3BA5B666F726D6174466C6F6174282723302E232327
      2C5B73756D285B414D4F554E545D295D295D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000C000000000000000000090000000100020000
      000000FFFFFF00000000020000000000000000001D15000005004D656D6F3400
      0200B30100008B04000014010000120000000300000001000000000000000000
      FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D205B
      54494D455D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000000000000100020000000000FFFFFF00000000020000
      00000000000000A515000005004D656D6F360002002700000093000000C50000
      00120000000100020001000000000000000000FFFFFF1F2E0200000000000100
      0B005B53484F505F4E414D455D00000000FFFF00000000000200000001000000
      000400CBCECCE5000C000000020000000000080000008600020000000000FFFF
      FF00000000020000000000000000002816000006004D656D6F3137000200ED00
      00009300000046000000120000000100000001000000000000000000FFFFFF1F
      2E02000000000001000500B2D6BFE23A00000000FFFF00000000000200000001
      000000000400CBCECCE5000C0000000200000000000800000086000200000000
      00FFFFFF0000000002000000000000000000BB16000006004D656D6F31390002
      003900000082020000C0000000140000000100000001000000000000000000FF
      FFFF1F2E02000000000001001500C5E4CBCDBEC6CFEEC4BFB8B4BACBC8CBC7A9
      C3FB3A00000000010000000000000200000001000000000400CBCECCE5000C00
      00000200FFFFFF1F080000008600020000000000FFFFFF000000000200000000
      00000000004117000006004D656D6F3231000200390000003B02000044000000
      120000000100000001000000000000000000FFFFFF1F2E020000000000010008
      00B1B8202020D7A23A00000000FFFF00000000000200000001000000000400CB
      CECCE5000C000000020000000000080000008600020000000000FFFFFF000000
      0002000000000000000000C717000006004D656D6F3335000200800000003B02
      00008E010000120000000100020001000000000000000000FFFFFF1F2E020000
      000000010008005B52454D41524B5D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000C000000000000000000080000008600020000000000
      FFFFFF00000000020000000000000000005418000006004D656D6F3232000200
      18020000AF000000A8000000120000000100020001000000000000000000FFFF
      FF1F2E02000000000001000F005B474C4944455F4E4F5F46524F4D5D00000000
      FFFF00000000000200000001000000000400CBCECCE5000C0000000000000000
      00080000008600020000000000FFFFFF0000000002000000000000000000DB18
      000006004D656D6F3330000200C3010000AF0000004E00000012000000010000
      0001000000000000000000FFFFFF1F2E02000000000001000900C0B4D4B4B5A5
      BAC53A00000000FFFF00000000000200000001000000000400CBCECCE5000C00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      00000000006319000006004D656D6F31300002003F0100001E02000051000000
      140000000100000001000000000000000000FFFFFF1F2E02000000000001000A
      00C1AACFB5B5E7BBB0A3BA00000000FFFF000000000002000000010000000004
      00CBCECCE5000C000000020000000000080000008600020000000000FFFFFF00
      00000002000000000000000000EC19000006004D656D6F313100020094010000
      1E0200007C000000120000000100020001000000000000000000FFFFFF1F2E02
      000000000001000B005B54454C4550484F4E455D00000000FFFF000000000002
      00000001000000000400CBCECCE5000C00000000000000000008000000860002
      0000000000FFFFFF00000000020000000000000000008B1A000006004D656D6F
      313800020028000000D10000001C010000140000000100000001000000000000
      000000FFFFFF1F2E02000000000001002100C7EBB0B4CFC2C1D0C9CCC6B7C3F7
      CFB8CFF2CAD5B7A2BBF5B5A5CEBBB7A2BBF53A00000000010000000000000200
      000001000000000400CBCECCE5000C0000000000FFFFFF1F0800000086000200
      00000000FFFFFF00000000020000000000000000000F1B000006004D656D6F31
      35000200DC010000910000003400000012000000010000000100000000000000
      0000FFFFFF1F2E02000000000001000600B1E020BAC53A00000000FFFF000000
      00000200000001000000000400CBCECCE5000C00000002000000000008000000
      8600020000000000FFFFFF00000000020000000000000000008D1B000006004D
      656D6F31360002001802000091000000A6000000120000000100020001000000
      000000000000FFFFFF1F2E0200000000000100000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000C000000000000000000000000008600
      020000000000FFFFFF0000000002000000000000000000151C000006004D656D
      6F3331000200AC010000280300001D0100001800000001000000010000000000
      00000500FFFFFF1F2E02000000000001000A005BC6F3D2B5C3FBB3C65D000000
      00FFFF00000000000200000001000000000400CBCECCE5001000000002000000
      00000A0000008600020000000000FFFFFF0000000002000000000000000000AB
      1C000006004D656D6F3333000200400100005A020000D0000000140000000100
      000001000000000000000000FFFFFF1F2E02000000000001001800C9F3202020
      BACBA3BA5B43484B5F555345525F544558545D00000000010000000000000200
      000001000000000400CBCECCE5000C0000000200FFFFFF1F0800000086000200
      00000000FFFFFF0000000002000000000000000000411D000006004D656D6F33
      39000200300100008C0400005600000012000000010000000100000000000000
      0000FFFFFF1F2E02000000000001001800B5DA5B50414745235D2F5B544F5441
      4C50414745535DD2B300000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000008600020000000000FFFFFF000000
      0002000000000000000000C61D000006004D656D6F3432000200D80100005203
      000040000000120000000100000001000000000000000000FFFFFF1F2E020000
      00000001000700C8D52020C6DA3A00000000FFFF000000000002000000010000
      00000400CBCECCE5000C000000020000000000080000008600020000000000FF
      FFFF0000000002000000000000000000501E000006004D656D6F343300020020
      0200005203000078000000120000000100020001000000000000000000FFFFFF
      1F2E02000000000001000C005B53414C45535F444154455D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000C000000000000000000080000
      008600020000000000FFFFFF0000000002000000000000000000E41E00000600
      4D656D6F31330002001C01000094030000140100001200000003000000010000
      00000000000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B
      444154455D205B54494D455D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000000000000100020000000000FFFFFF
      00000000020000000000000000006C1F000006004D656D6F34300002003C0000
      006100000085020000180000000100000001000000000000000500FFFFFF1F2E
      02000000000001000A00B7A2BBF5CDA8D6AAB5A500000000FFFF000000000002
      00000001000000000400CBCECCE500120000000200000000000A000000860002
      0000000000FFFFFF000000000200000000000000010020930000080050696374
      7572653100020044000000400000005400000038000000050000000100000000
      0000000000FFFFFF1F2E020000000000000000000000FFFF0000000000020000
      000100000000040020930000FFD8FFE000104A46494600010201015E015E0000
      FFE10C504578696600004D4D002A000000080007011200030000000100010000
      011A00050000000100000062011B0005000000010000006A0128000300000001
      0002000001310002000000140000007201320002000000140000008687690004
      000000010000009C000000C80000015E000000010000015E0000000141646F62
      652050686F746F73686F7020372E3000323031313A30373A31342031313A3438
      3A32380000000003A001000300000001FFFF0000A002000400000001000001F0
      A003000400000001000001400000000000000006010300030000000100060000
      011A00050000000100000116011B0005000000010000011E0128000300000001
      00020000020100040000000100000126020200040000000100000B2200000000
      00000048000000010000004800000001FFD8FFE000104A464946000102010048
      00480000FFED000C41646F62655F434D0002FFEE000E41646F62650064800000
      0001FFDB0084000C08080809080C09090C110B0A0B11150F0C0C0F1518131315
      131318110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
      0C0C0C0C0C0C0C010D0B0B0D0E0D100E0E10140E0E0E14140E0E0E0E14110C0C
      0C0C0C11110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
      0C0C0C0C0C0C0C0CFFC00011080053008003012200021101031101FFDD000400
      08FFC4013F000001050101010101010000000000000003000102040506070809
      0A0B0100010501010101010100000000000000010002030405060708090A0B10
      00010401030204020507060805030C3301000211030421123105415161132271
      8132061491A1B14223241552C16233347282D14307259253F0E1F163733516A2
      B283264493546445C2A3743617D255E265F2B384C3D375E3F3462794A485B495
      C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F637475767778797A7B7C7D7
      E7F7110002020102040403040506070706053501000211032131120441516171
      22130532819114A1B14223C152D1F0332462E1728292435315637334F1250616
      A2B283072635C2D2449354A317644555367465E2F2B384C3D375E3F34694A485
      B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F62737475767778797A7
      B7C7FFDA000C03010002110311003F00F5549242C9C9C6C4A1F91956B28A2B13
      65B638318D1C7BDEF86B525254979B7D63FF001CB818AF7E3741C7FB6D8DD3ED
      574B299D3F9BA86DBEF6FD267FDA6FFAE2F3DEB3F5EFEB57592E6E5E7D8CA5D2
      3ECF41F46B83F98E655B7D56FF00C7BAD494FBB757FAD3F57BA283FB4F3E9C77
      889AA77DBAF7FB3D5EA5FF00F81AE5F3BFC72FD56C773998B564E611F45ED60A
      EB3FDAB9ECB9BFF6C2F125A5D03EAE756FAC39ADC3E9949B1D23D5B4E9554D3F
      E12FB7F319ED77FC259FE09963D253DF657F8F1C970230FA4B2B77675B7178FF
      0032BAA9FF00CF8AA637F8D6FAF7D5AE18BD33031EDBDDC371E8B6C701E2EDD7
      58D6B7F96BA4FABBFE27BA260B59775979EA592209A84D7434FB4C6D6FE96FDA
      EFF48FF4ECFF00B8EBBAC4C2C3C1A463E1515E2D0D248AA9636B602793B2B0D6
      A4A784C1C5FF001C79F0FC9CDC5E94C9D5AE65363E3F798CAAAC967FDB9756BA
      2C0E85F59AB93D47EB2DF907B0A3171291FDAF528CBDDFF41740924A614D6EAE
      B6B1D63AD239B1F1B8FF005BD36D6CFF00A0A69249294924924A524924929FFF
      D0F40FACBF58B07EAE749B7A966190DF6D34830EB2D20FA74B39FA5B7DCEFCCA
      FDEBC17EB47D6FEB1F59B2CDD9D66DC769FD061D648AAB8D2437F3EDD7DF73FF
      0049FF005AFD1ADEFF001C3D56DCBFAD5FB3C93E8F4DA98C633B6FB5ADC9B6CF
      EDB1F4B3FEB2B86494A49249253B7F53FEAC64FD67EB55F4FA89650D1EA65DC2
      3D95348DC5B3FE11EE3E9D5FCBFF0083F517D03D17A2F4DE8780CE9FD36914D0
      CD4F773DC7E95B73FF00C25AFDBF4BFEF8B8DFF133D3598FF56EFCF2D1EAE764
      3A5E3935D23D3AD87FAB6BB23FEDC5DF91223C5252E92C4EA3F55A9CD7FA95F5
      2EA782F99271B32D00FF00D6B21D914FF9B5AE77A97D4EFAF94B8BFA2FD67B6D
      6CFB6ACC24380FF8E636F6D8EFFAC54929EF525E39D4FABFF8E3E84D2FCC75AE
      A192E37329A2FAF68FCEB2DA6AB1D537FE3BD354F1BFC72FD6CA4016D78993E2
      E7D6E6BBFF0001B6A67FD0494FB7A4BCBBA77F8EFC676D6F53E98FAE07BACC6B
      03E4FF00269B853B7FEDF5D2F4CFF1A1F537A86C69CC3876BFFC1E530D71FD7B
      86FC56FF00DBE929EB1241C5CBC4CCA464625D5E452EFA36D4E0F61F83EB2E6A
      324A524924929FFFD1ADFE39FEAEDF5E7D1F582864E35EC6D194E1F9B6B27D27
      D9AFF86A7F47FF0058FF0084AD799AFA8F3B0713A861DB859B536FC6C86965B5
      BB820FC3DCD77EE3DBF4178BFD70FF00157D53A43DF97D1DAFEA3D3B92C68DD7
      D5AF0FAD9FCFB3FE1696FF00C6D55FF38929E1124882342924A7D8FF00C4B758
      A6EE8F95D1DEF1F69C5B4DEC61224D3606B658DFA4EF4EF6BBD5FF008EA57A3A
      F98FA275ACFE85D4E9EA7D3DE197D27870963DA747D56B74DD5D8DFF00D47FA4
      5EEFF54BEBEF45FACF58AEA70C5EA007E9306C70DDC6E73B1DFEDFB4D7ED77D0
      FD233FC2D55A4A7A549249252973DF587EA27D5BFAC0C7BB2F15B565BF519940
      15DBBB4F73DCDF65FF0047FED432C5D0A4929F03FADBFE2D7AD7D5C6BB2EB3F6
      FE9ADE726A690E608FFB5347BFD26FFC2B5F655FBFE9EFF4D722BEA920110448
      3C85E2FF00E34BEA2D3D1AE6F5AE9557A7D3F25FB722868F6D369D5A6A6FF83C
      7BFF0073F9BA2DFD1FF376D14B129E1B07A8E7F4EBBED181936E2DDC7A94BDCC
      747EEEE616FB5777F573FC71F57C2228EB950EA3448FD3B36D77B4683F34369B
      F6B7F7BD2B3FEEC2F3C49253F497D5EFAD9D0FEB1D1EAF4CC80FB1A26DC67FB6
      E671FCE55FBBEEDBEAD7EA53FF0008B617CB787999583935E5E1DAFA32293BAB
      B6B25AE078D085EDDFE2EFFC60B3EB255FB3BA8C57D6286EE240865EC1FE1AB1
      FE0EE67F87A7FEBD47E8FD4AB1929FFFD2F5549249253CEF5FFA85F563AFB9D6
      E6628AB29FCE5E39F4ED9FDE7C4D573F4FFB5155AB84EADFE24B3584BFA3F50A
      EE64922ACA69ADC0761EB522D65AFF00FAD50BD752494FCF1D43FC5DFD73C0D6
      DE976DAD980EC78BE7CF6633ACB1BFDB62C02DC9C3BC121F8F9153839B32C7B5
      C0CB5C3E8BD8E6B97D4CA16D34DCC35DCC6D8C3CB1E0381FECB9253E1DD07FC6
      D7D66E96194E696F54C66C022F245DB4766E5B7DDBBF97915E4AEE3A57F8E3FA
      AF961ADEA0CBBA6DB12E2F6FAB5CFEEB2CC7DD73BFB58D5AE9EEFAA9F55EE936
      F48C2739DCBBECF5877F9E19B950BBFC5CFD4AB892FE95509FDC758CFF00CF56
      31253A9D33EB0744EAC27A6E75194624B2B782F03F974FF3ACFEDB1682E53FF1
      ADFA89FF00959FF83E47FEF42D1C4FAA1D1305A198632A863750CAF373037FED
      BFB56C494ED2C8FADD815750FAB1D5312D0087E358E6CF01F5B7D6A1FF00D8BA
      BADEB56BAC56C0C69710DD01712E3F37BF739CB9BFF18DD6EAE8FF0054F35CE2
      3D6CD61C4C76C904BAE058F70DBFE8A9F56EFEC24A7E7B49249252969FD58EA1
      774DFAC3D3B368243EAC8AE76F258E77A7757FF5DA9EFAD662EB3FC59FD5CBBA
      DFD65A2E2230FA63999590FED2D3BB1E9FA2E6EEBAD67D077F80AEF494FF00FF
      D3F554924925292492494A49249252924C4C6A785959FF005AFEAD74EDDF6CEA
      78D5399F4ABF55AEB3FED8ACBEEFFA0929D649707D57FC71FD57C46B86032FEA
      3644B0B5A6AAC9FDD7D991B6E67F671AC5C2F5BFF1B3F5A7A9B5F4E2BD9D331D
      D2231C1F5483FBD92F97B5DFCBC7FB3A4A7D6BEB3FD70E8BF56718D99D68764B
      84D186C20DB6133B7D9FE0EAF6FF003F67E8FF00EB9FA35E17F5B3EB6752FAD1
      D48E6661F4E9AE5B8B8AD32CA987B0E37DB647E9EFFF000BFC8A99553551A703
      ACF56B9F6D18F939F7584B9EF631F739C4FD273DCD0F7396CE07F8B7FAE99C03
      99D35F4B0982EC873698F335DCE65DFE6D4929E6925EA1D1FF00C4964B9DBFAD
      E7B2B6023F43880B9C477FD3DED636A77FD62E5DCF42FA85F55FA1165B87862C
      CA64465641F56C91C3D9BFF474BFFF000BD74A4A7C9BEA87F8B5EB3F582CAF23
      2D8FC0E967DCEC8B1B0FB0407462D4FF0073BD4DDFD21DFA0FF8DFE697B5743E
      85D37A0F4EAFA774DABD2A19EE713ABDEF3F4EEB9FFE12D7C7FE8BAFF44C6316
      824929FFD4F55497CAA924A7EAA497CAA924A7EAA4C785F2B24929F64FAD1F66
      FB79FF00C4EEE93FF2AFAFBFFF0020B259E976FF00991F3F53FEFCBCC52494FA
      B57F49BFF884EDC72BB0FABBF499FF00237FED379FEC2F9E52494FD5492F9552
      494FD5492F9552494FD5492F9552494FFFD9FFED110A50686F746F73686F7020
      332E30003842494D042500000000001000000000000000000000000000000000
      3842494D03ED000000000010015E000000010002015E0000000100023842494D
      042600000000000E000000000000000000003F8000003842494D040D00000000
      00040000001E3842494D04190000000000040000001E3842494D03F300000000
      0009000000000000000001003842494D040A00000000000100003842494D2710
      00000000000A000100000000000000023842494D03F5000000000048002F6666
      0001006C66660006000000000001002F6666000100A1999A0006000000000001
      003200000001005A00000006000000000001003500000001002D000000060000
      000000013842494D03F80000000000700000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E80000
      3842494D040000000000000200023842494D0402000000000006000000000000
      3842494D0408000000000010000000010000024000000240000000003842494D
      041E000000000004000000003842494D041A0000000003470000000600000000
      0000000000000140000001F00000000994F657FA004C004F0047002E006A0070
      0067000000010000000000000000000000000000000000000001000000000000
      0000000001F00000014000000000000000000000000000000000010000000000
      000000000000000000000000000010000000010000000000006E756C6C000000
      0200000006626F756E64734F626A630000000100000000000052637431000000
      0400000000546F70206C6F6E6700000000000000004C6566746C6F6E67000000
      000000000042746F6D6C6F6E670000014000000000526768746C6F6E67000001
      F000000006736C69636573566C4C73000000014F626A63000000010000000000
      05736C6963650000001200000007736C69636549446C6F6E6700000000000000
      0767726F757049446C6F6E6700000000000000066F726967696E656E756D0000
      000C45536C6963654F726967696E0000000D6175746F47656E65726174656400
      00000054797065656E756D0000000A45536C6963655479706500000000496D67
      2000000006626F756E64734F626A630000000100000000000052637431000000
      0400000000546F70206C6F6E6700000000000000004C6566746C6F6E67000000
      000000000042746F6D6C6F6E670000014000000000526768746C6F6E67000001
      F00000000375726C54455854000000010000000000006E756C6C544558540000
      00010000000000004D7367655445585400000001000000000006616C74546167
      544558540000000100000000000E63656C6C54657874497348544D4C626F6F6C
      010000000863656C6C546578745445585400000001000000000009686F727A41
      6C69676E656E756D0000000F45536C696365486F727A416C69676E0000000764
      656661756C740000000976657274416C69676E656E756D0000000F45536C6963
      6556657274416C69676E0000000764656661756C740000000B6267436F6C6F72
      54797065656E756D0000001145536C6963654247436F6C6F7254797065000000
      004E6F6E6500000009746F704F75747365746C6F6E67000000000000000A6C65
      66744F75747365746C6F6E67000000000000000C626F74746F6D4F7574736574
      6C6F6E67000000000000000B72696768744F75747365746C6F6E670000000000
      3842494D041100000000000101003842494D0414000000000004000000033842
      494D040C000000000B3E0000000100000080000000530000018000007C800000
      0B2200180001FFD8FFE000104A46494600010201004800480000FFED000C4164
      6F62655F434D0002FFEE000E41646F626500648000000001FFDB0084000C0808
      0809080C09090C110B0A0B11150F0C0C0F1518131315131318110C0C0C0C0C0C
      110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C010D0B
      0B0D0E0D100E0E10140E0E0E14140E0E0E0E14110C0C0C0C0C11110C0C0C0C0C
      0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC0
      0011080053008003012200021101031101FFDD00040008FFC4013F0000010501
      010101010100000000000000030001020405060708090A0B0100010501010101
      010100000000000000010002030405060708090A0B1000010401030204020507
      060805030C33010002110304211231054151611322718132061491A1B1422324
      1552C16233347282D14307259253F0E1F163733516A2B283264493546445C2A3
      743617D255E265F2B384C3D375E3F3462794A485B495C4D4E4F4A5B5C5D5E5F5
      5666768696A6B6C6D6E6F637475767778797A7B7C7D7E7F71100020201020404
      0304050607070605350100021103213112044151617122130532819114A1B142
      23C152D1F0332462E1728292435315637334F1250616A2B283072635C2D24493
      54A317644555367465E2F2B384C3D375E3F34694A485B495C4D4E4F4A5B5C5D5
      E5F55666768696A6B6C6D6E6F62737475767778797A7B7C7FFDA000C03010002
      110311003F00F5549242C9C9C6C4A1F91956B28A2B1365B638318D1C7BDEF86B
      525254979B7D63FF001CB818AF7E3741C7FB6D8DD3ED574B299D3F9BA86DBEF6
      FD267FDA6FFAE2F3DEB3F5EFEB57592E6E5E7D8CA5D23ECF41F46B83F98E655B
      7D56FF00C7BAD494FBB757FAD3F57BA283FB4F3E9C77889AA77DBAF7FB3D5EA5
      FF00F81AE5F3BFC72FD56C773998B564E611F45ED60AEB3FDAB9ECB9BFF6C2F1
      25A5D03EAE756FAC39ADC3E9949B1D23D5B4E9554D3FE12FB7F319ED77FC259F
      E09963D253DF657F8F1C970230FA4B2B77675B7178FF0032BAA9FF00CF8AA637
      F8D6FAF7D5AE18BD33031EDBDDC371E8B6C701E2EDD758D6B7F96BA4FABBFE27
      BA260B59775979EA592209A84D7434FB4C6D6FE96FDAEFF48FF4ECFF00B8EBBA
      C4C2C3C1A463E1515E2D0D248AA9636B602793B2B0D6A4A784C1C5FF001C79F0
      FC9CDC5E94C9D5AE65363E3F798CAAAC967FDB9756BA2C0E85F59AB93D47EB2D
      F907B0A3171291FDAF528CBDDFF41740924A614D6EAEB6B1D63AD239B1F1B8FF
      005BD36D6CFF00A0A69249294924924A524924929FFFD0F40FACBF58B07EAE74
      9B7A966190DF6D34830EB2D20FA74B39FA5B7DCEFCCAFDEBC17EB47D6FEB1F59
      B2CDD9D66DC769FD061D648AAB8D2437F3EDD7DF73FF0049FF005AFD1ADEFF00
      1C3D56DCBFAD5FB3C93E8F4DA98C633B6FB5ADC9B6CFEDB1F4B3FEB2B86494A4
      9249253B7F53FEAC64FD67EB55F4FA89650D1EA65DC23D95348DC5B3FE11EE3E
      9D5FCBFF0083F517D03D17A2F4DE8780CE9FD36914D0CD4F773DC7E95B73FF00
      C25AFDBF4BFEF8B8DFF133D3598FF56EFCF2D1EAE7643A5E3935D23D3AD87FAB
      6BB23FEDC5DF91223C5252E92C4EA3F55A9CD7FA95F52EA782F99271B32D00FF
      00D6B21D914FF9B5AE77A97D4EFAF94B8BFA2FD67B6D6CFB6ACC24380FF8E636
      F6D8EFFAC54929EF525E39D4FABFF8E3E84D2FCC75AEA192E37329A2FAF68FCE
      B2DA6AB1D537FE3BD354F1BFC72FD6CA4016D78993E2E7D6E6BBFF0001B6A67F
      D0494FB7A4BCBBA77F8EFC676D6F53E98FAE07BACC6B03E4FF00269B853B7FED
      F5D2F4CFF1A1F537A86C69CC3876BFFC1E530D71FD7B86FC56FF00DBE929EB12
      41C5CBC4CCA464625D5E452EFA36D4E0F61F83EB2E6A324A524924929FFFD1AD
      FE39FEAEDF5E7D1F582864E35EC6D194E1F9B6B27D27D9AFF86A7F47FF0058FF
      0084AD799AFA8F3B0713A861DB859B536FC6C86965B5BB820FC3DCD77EE3DBF4
      178BFD70FF00157D53A43DF97D1DAFEA3D3B92C68DD7D5AF0FAD9FCFB3FE1696
      FF00C6D55FF38929E1124882342924A7D8FF00C4B758A6EE8F95D1DEF1F69C5B
      4DEC61224D3606B658DFA4EF4EF6BBD5FF008EA57A3AF98FA275ACFE85D4E9EA
      7D3DE197D27870963DA747D56B74DD5D8DFF00D47FA45EEFF54BEBEF45FACF58
      AEA70C5EA007E9306C70DDC6E73B1DFEDFB4D7ED77D0FD233FC2D55A4A7A5492
      49252973DF587EA27D5BFAC0C7BB2F15B565BF51994015DBBB4F73DCDF65FF00
      47FED432C5D0A4929F03FADBFE2D7AD7D5C6BB2EB3F6FE9ADE726A690E608FFB
      5347BFD26FFC2B5F655FBFE9EFF4D722BEA9201104483C85E2FF00E34BEA2D3D
      1AE6F5AE9557A7D3F25FB722868F6D369D5A6A6FF83C7BFF0073F9BA2DFD1FF3
      76D14B129E1B07A8E7F4EBBED181936E2DDC7A94BDCC747EEEE616FB5777F573
      FC71F57C2228EB950EA3448FD3B36D77B4683F34369BF6B7F7BD2B3FEEC2F3C4
      9253F497D5EFAD9D0FEB1D1EAF4CC80FB1A26DC67FB6E671FCE55FBBEEDBEAD7
      EA53FF0008B617CB787999583935E5E1DAFA32293BABB6B25AE078D085EDDFE2
      EFFC60B3EB255FB3BA8C57D6286EE240865EC1FE1AB1FE0EE67F87A7FEBD47E8
      FD4AB1929FFFD2F5549249253CEF5FFA85F563AFB9D6E6628AB29FCE5E39F4ED
      9FDE7C4D573F4FFB5155AB84EADFE24B3584BFA3F50AEE64922ACA69ADC0761E
      B522D65AFF00FAD50BD752494FCF1D43FC5DFD73C0D6DE976DAD980EC78BE7CF
      6633ACB1BFDB62C02DC9C3BC121F8F9153839B32C7B5C0CB5C3E8BD8E6B97D4C
      A16D34DCC35DCC6D8C3CB1E0381FECB9253E1DD07FC6D7D66E96194E696F54C6
      6C022F245DB4766E5B7DDBBF97915E4AEE3A57F8E3FAAF961ADEA0CBBA6DB12E
      2F6FAB5CFEEB2CC7DD73BFB58D5AE9EEFAA9F55EE936F48C2739DCBBECF5877F
      9E19B950BBFC5CFD4AB892FE95509FDC758CFF00CF5631253A9D33EB0744EAC2
      7A6E75194624B2B782F03F974FF3ACFEDB1682E53FF1ADFA89FF00959FF83E47
      FEF42D1C4FAA1D1305A198632A863750CAF373037FEDBFB56C494ED2C8FADD81
      5750FAB1D5312D0087E358E6CF01F5B7D6A1FF00D8BABADEB56BAC56C0C69710
      DD01712E3F37BF739CB9BFF18DD6EAE8FF0054F35CE23D6CD61C4C76C904BAE0
      58F70DBFE8A9F56EFEC24A7E7B49249252969FD58EA1774DFAC3D3B368243EAC
      8AE76F258E77A7757FF5DA9EFAD662EB3FC59FD5CBBADFD65A2E2230FA639995
      90FED2D3BB1E9FA2E6EEBAD67D077F80AEF494FF00FFD3F55492492529249249
      4A49249252924C4C6A785959FF005AFEAD74EDDF6CEA78D5399F4ABF55AEB3FE
      D8ACBEEFFA0929D649707D57FC71FD57C46B86032FEA3644B0B5A6AAC9FDD7D9
      91B6E67F671AC5C2F5BFF1B3F5A7A9B5F4E2BD9D331DD2231C1F5483FBD92F97
      B5DFCBC7FB3A4A7D6BEB3FD70E8BF56718D99D68764B84D186C20DB6133B7D9F
      E0EAF6FF003F67E8FF00EB9FA35E17F5B3EB6752FAD1D48E6661F4E9AE5B8B8A
      D32CA987B0E37DB647E9EFFF000BFC8A99553551A703ACF56B9F6D18F939F758
      4B9EF631F739C4FD273DCD0F7396CE07F8B7FAE99C0399D35F4B0982EC873698
      F335DCE65DFE6D4929E6925EA1D1FF00C4964B9DBFADE7B2B6023F43880B9C47
      7FD3DED636A77FD62E5DCF42FA85F55FA1165B87862CCA64465641F56C91C3D9
      BFF474BFFF000BD74A4A7C9BEA87F8B5EB3F582CAF232D8FC0E967DCEC8B1B0F
      B0407462D4FF0073BD4DDFD21DFA0FF8DFE697B5743E85D37A0F4EAFA774DABD
      2A19EE713ABDEF3F4EEB9FFE12D7C7FE8BAFF44C6316824929FFD4F55497CAA9
      24A7EAA497CAA924A7EAA4C785F2B24929F64FAD1F66FB79FF00C4EEE93FF2AF
      AFBFFF0020B259E976FF00991F3F53FEFCBCC52494FAB57F49BFF884EDC72BB0
      FABBF499FF00237FED379FEC2F9E52494FD5492F9552494FD5492F9552494FD5
      492F9552494FFFD93842494D042100000000005500000001010000000F004100
      64006F00620065002000500068006F0074006F00730068006F00700000001300
      410064006F00620065002000500068006F0074006F00730068006F0070002000
      37002E003000000001003842494D04060000000000070008010100010100FFE1
      1248687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F003C
      3F787061636B657420626567696E3D27EFBBBF272069643D2757354D304D7043
      656869487A7265537A4E54637A6B633964273F3E0A3C3F61646F62652D786170
      2D66696C74657273206573633D224352223F3E0A3C783A7861706D6574612078
      6D6C6E733A783D2761646F62653A6E733A6D6574612F2720783A786170746B3D
      27584D5020746F6F6C6B697420322E382E322D33332C206672616D65776F726B
      20312E35273E0A3C7264663A52444620786D6C6E733A7264663D27687474703A
      2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D73796E74
      61782D6E73232720786D6C6E733A69583D27687474703A2F2F6E732E61646F62
      652E636F6D2F69582F312E302F273E0A0A203C7264663A446573637269707469
      6F6E2061626F75743D27757569643A64333838383835392D616463392D313165
      302D623664322D666538633931633562343663270A2020786D6C6E733A786170
      4D4D3D27687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F
      6D6D2F273E0A20203C7861704D4D3A446F63756D656E7449443E61646F62653A
      646F6369643A70686F746F73686F703A64333838383835312D616463392D3131
      65302D623664322D6665386339316335623436633C2F7861704D4D3A446F6375
      6D656E7449443E0A203C2F7264663A4465736372697074696F6E3E0A0A3C2F72
      64663A5244463E0A3C2F783A7861706D6574613E0A2020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020202020202020202020200A202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020200A20
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020200A20202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020200A2020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020200A202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020200A20202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020202020202020202020200A2020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020202020202020202020202020200A202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      200A202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020200A20202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020200A2020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020200A202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020200A20202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020202020202020202020202020200A2020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020202020202020202020202020202020200A
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020200A202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020200A20202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020200A2020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020202020200A202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020200A20202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020202020202020202020202020202020200A2020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20200A2020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020200A202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020200A20202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020202020200A2020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020202020202020200A202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020200A20202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      0A20202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020200A2020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020200A202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020200A20202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020202020202020200A2020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020202020202020202020200A202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020200A20
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020200A20202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020200A2020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020200A202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020200A20202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020202020202020202020200A2020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      2020202020202020202020202020202020202020202020202020202020202020
      202020202020202020202020202020202020202020202020202020200A202020
      2020202020202020202020202020202020202020202020202020202020202020
      20202020202020202020202020202020202020200A3C3F787061636B65742065
      6E643D2777273F3EFFEE002141646F6265006440000000010300100302030600
      0000000000000000000000FFDB00840001010101010101010101010101010101
      0101010101010101010101010101010101010101010101010101010202020202
      0202020202020303030303030303030301010101010101010101010202010202
      0303030303030303030303030303030303030303030303030303030303030303
      0303030303030303030303030303030303FFC2001108014001F0030111000211
      01031101FFC400C5000100020202030101000000000000000000090A080B0607
      0203050401010100000000000000000000000000000000100001020603000301
      010101000000000008070902030405060A0030014050122014B0131100010303
      020303060709090A0A0B00000401050602030711080021143112133041516115
      095022322333241640718191A15243341720D163734454649425F0B1E1426272
      53833526C1B445556595A536461882B29384A485B5B637781912010000000000
      00000000000000000000B0FFDA000C03010102110311000000BFC00000000000
      000000000000781EB3841D6C7043E29F98FB4736325400000000000000000000
      0000000000000E2C47D11A6478181A60C987E62718E07419C30FE920A4E09374
      4CB92EE770800000000000000000000000000000E204441086434910245F1D7E
      7F0000198858C8B0C93F66759E6000000000000000000000000000003D445295
      C02BBC4169D30000000489969F2D264CE9F58000000000000000000000000000
      000F02228A9B156A2380F000000039C16A72E3A4F41F50000000000000000000
      0000000000001D5054BCA6310D47800000003B70B9E178F33440000000000000
      0000000000000000003A54A4F1483313800000003F596DB361C99B2000000000
      00000000000000000000001F3CA869AF50C3400000000195C6CEC2CBC0000000
      000000000000000000000000030C0D61A572000000000094636D312180000000
      000000000000000000000000021B8D4EC61080000000012246E1633400000000
      00000000000000000000000004451A828C7100000000039B1B8C099200000000
      0000000000000000000000001D2C698E2384000000000178E363500000000000
      0000000000000000000000140E35FC00000000003901BBC4CE7001F1C8C22144
      84C2198EAB39F9DAA773990C64B996E66499C867F19E47353C80000000000000
      0003C0D23847680000000002714DC660000007C122BC80C2000AFD98D60000E4
      C48112944B2130C4CE99F67B00000000000001D2C68773D00000000000BA01B2
      E0000000000E3042395942AE44701E200001E666993BE4FD962A246CF3000000
      0000700343A9C400000000001743365A800000000000FCE427950A2A6A63F000
      0001E64A116722D444CC9EE000000001A80880400000000005864DBBE0000000
      0000001D12540CA3218280000000F22530B8496FA329C000000154E355C00000
      000003B20DE52643800000000000000EBA2974506CC7500000000ED42DD85EA8
      90E000001F24D46E57940000000001B07CBEC800000000000000030B8D668568
      C0000000073A2E6C5FCCC9500000C3F34F711B000000000076F9B8FC95A00000
      000000000007CB28445014FC400000000330CD95A5A200000304CD4D64438000
      00000122C6DED33D4000000000000000029086B853C0000000007E92F126C463
      9000003A60D72053B0FC00000000033BCDAA24DC00000000000000003C4D6AA5
      2CC00000000016ED36789F6800002BF86BA52190000000007352F585EECEDC00
      00000000000003A7CD2B06070000000000360297F3000001F28ACE14722050FC
      E000000019D05EACB821DC20000000000000029146B7C0000000000730374712
      7400000078914A543CAAD11F47880000003278B6F16FE25E8F60000000000001
      88E68D33E580000000002F066C75000000001F3C8852B8057948443A94000000
      F324DCB3F1639273CE700000000000F1349691B600000000009BC371E0000000
      00000E1444690B8444115E46298AE7A800003B809B427609A6265CCCB3D80000
      000D32A43880000000002634DCD60000000000000007ACC663024C0E3074C4F3
      168C5F3A40E9C3A78E1671F3E099564B792DC4B612D86500001F9CD16E62B800
      00000002E686CC400000000000000000000000000F13C800000089434BA1E200
      00000007B0DC424E98000000000000000000000000000000001AD58A58000000
      00002D306D5E3C8000000000000000000000000000000004339A73CE1E000000
      0004941B8A4CA700000000000000000000000000000000184069F423C4000000
      00093436DF120C0000000000000000000000000000000022B0D4EE4710000000
      0016733676193200000000000000000000000000000001F0CA6D1AEC8E950000
      000019C26C382DAC7E900000000000000000000000000000007CF2B8A6BF5216
      C0000000067497752E7477000000000000000000000000000000003A00AA514B
      822080000000397962B2DFE59B8E6200000000000000000000000000000062E1
      5D22AE056FCEA60000000651160E2C9A5974C9E0000000000000000000000000
      0000F59876426104A40810D27C100000F23B3093E26109A827309583EE000000
      0000000000000000000001D0446A9194453914843B98487ACF61E473F3BDCCA6
      3294CBC33A8CF0240094133E0E400000000000000000000000000000007E53A3
      CEB93851F20F9C7D33901F74EC03B78E507B0F300000000000000000000FFFDA
      0008010200010500FF008D87FFDA0008010300010500FF008D87FFDA00080101
      00010500F9F14C821E7FA2443CBDAA09B635CB916C2C59BCAE70A02ADB1CE72D
      6E8A7F25B9DB6D4E8A9DC55BFEAF98B18624E6772FADC9B2FC4F0BB52B2F1AD6
      288F8A7ED98CCC9FFAA6EED620DA78A0EEF0BF5CBDCF7717769CB23CD36767B4
      CD7CCADEB9DAB33F7273D0E4CE22BE29CA364FEFFA2A7DE4BFF44F89006A3726
      28B88069D4E8EA7FA8369402A637021DADA337211C4B1034310BB67D46619CE1
      89DD8C82D84D9EC72F177DD7C43C5625CF73571FCF7D59DFC9E0579F73B5494E
      552EFEFBEFBFD8DC011AA60DC05BD371C5D59E0DBA6FB6BA5BE8DED96DFE2441
      0430C3E7D44C9904A84AC7B66BA0D3D27776044AC1C2576A078121662BC412F4
      415F7A43A6A67033CEA443D29551BF7046D7ADA7039976CB55BACB43F531C50C
      309A4F98D8609F8606EB0A75F622D1DC1C68DE9F145145174E049EE7EAAE5804
      EA22791210853AD6353863CB75B282D143F54AE2CE92209839EFB8A07A89CC39
      9FB9CF4F9F638E28A2EA4711058081CF9B734E05573BE086DF01A81D89FD5AE2
      4122633278E39B94E298FCE2B4DC2B8E3CFF00AE9E9E7D5CE69DD520A22FA00B
      9BE0446F94DBEAEAAB296DF4AEBBB650D6284E31CF42C4F9523B0410C88D3B96
      A677D6E05C6DEA2FAC36CF5179BCD19780D8D0B1731B9F6B5AB53924EB6BCB75
      36B0B4D8886FD63BF3C90ECD308B9D67F93CE32B976B67B722EAE78500260B0F
      CDE03B7D63C3BB3A38D303314851ADE66AE9DB80E07982A59C328352E06D4A21
      FD62FCB926834A2EE88E30AEB9D16FDDA7736650A94AAFD6EE64E27534527BB1
      DC7AF195DF9B7840C780F087F8BADB69EF76E5E5B12A55C857C6247AC87D5F9B
      B36E541E2580F67F31BAE76E7C2773B5C56DD831E52D3ED8366A7BCC7B960DB2
      1E8ECFEE2BB973AC587987EEDC5BD1C584EF0B86557300DD21B6EFF127BB5132
      A673C4CDE25AC15DE620A427AA0DBFC8BCF7E4451FE6176027AEA61B8D776B9C
      36D1938F03D37CB0D8B26B510CC5AD304DCB24B4AB12F33E129A893AFA2DEAFA
      239482C5F7FAC7F2CCA312BAA4CF0CE8E87F11CDB61E252D8D17DDEF30A6E21B
      B7B3482A70A04E9ADCE4F452E64B990FC222B299F818FB3E2FD4EEED2913AA3B
      B9D7DB94E258BE6F6429B5B868329F85EE94EAAD8785BB48B8B83932287F3D10
      C7143EA00E2C770B5E8E5B813A9243C19F7490C33F8C617706DB31B90450C5E7
      72A1845BD4D4D33CC4AF29FE6FDDA4F6614540757C09D2A554CB35F5EE6B2392
      03634CB2CD31F4811848514F3BE98638A1885479A7370BBD10F75A52EC91072F
      F6D566DC52A6CB9D2FB365810AA84576BEED5D97DA6421E47E1AEE37A0850E08
      E07A6B0FCA4539AADBE68B7A66DD5E45EC3E85CF38E4E05CC06F74549B2BE0BA
      690A66BE11D5B60B715CCC1063B9225332B4555414886C24B31B3E229A95264B
      5E16E85A7D246A3CA24C592183D553AD2759D5941B376EFDC34A34623059D241
      E71DC57A2E36FA0BBD16C38D01776BF2D7BB4E573BA0AEC7FE31AA030A2E0E93
      3C8EB784C36845D89FA879E25397B5DEDFEB4A51503096E38998967F67005887
      1FA35B9D365104D6848F6A1AB3A903B2BAD10E8893BAA89DF1AE1414775A37E9
      D5CA8A2A7A9A6A9A2A8EC0DCEC2A0065619AF6621B9C4E2FECFC6F81A9C887F7
      5F674295A8158ED6D27265F9AEC976F670E1B9CAC7CF8FB26EBC96E5C2D31C11
      4B8BB24CE9D4F358A3694C85249B63BDDA729B37F4B9A1290930983C66A96B50
      B936AA92AA82A7B00270F265B69756917CA13DD7708F8D143FAE6D54CA74235E
      7BDDAECEC2D9203B96D9EED69BDDAFFB750D7641A734F1C918BDC05B2AE5D982
      E799AA639834C6DF35767908EAD4939069FF00C55CD184E08A47DC8C1CCF5BA4
      C9EED4EDEA6BEE351D170A0A2BAD2388EAB4DE0684C3DB5C173C04A7CE93369E
      6F584EE3264B7A678DE9B900F2A7F1185D91921B01F89B9981B499F0F1DD84E6
      79526F993421FB64727023A6287F5C36D94DB65C0BC3434AF54B1EE168D66E06
      0E54450FE7AC6531CA40D33507F74020B02F4357D56BF39A9E5CC82679F04EE1
      AED26086971B6D659EE3DDA589795589113D955474B5F4E53B0AB4F97F0137A4
      B6095FE925ABF3C40E9315442D6A43320E98628A18845787728076315F76053A
      CB2861D9B59F49C87055153F54B1CEE8A1FD78EF89248435D03BB5CE526E4983
      CE7C0CD93DC094AB12FBAF533C911EADFA5504995C4B3695A78E2D315DD67DE8
      922F55A078CB417914B8E5F424CBDAE0835EC76DA05E307CF07CDDD6EB2E5A15
      B66B3C2C3C435C3815257904C823EBD80AFD2B24792EE6014F6EEA63C77C58E5
      C11F14D0BC3E5A635175F966D53F8A26A26CF19B7338D25440B8CFCBF477C825
      F998693A7AD17329D3F5DEAC13AFBAA93DB5A797BD6D5ECF1BE5E9895DFEC315
      5B31BB152FB3DA21D4697D9ED66E756FE2329C6C0C81FA8B397EDC495711A7EB
      D83A8BD45DE8CB0CBF88C135215F87F99F3E5D3C937964A621CCBEED31455AA5
      18DDFA3FC43D4F8A5E5204ED7B145EC5176CB971CC8B5E46FCAB6F66D2FADDC3
      1C6E916B233BB58068EB91D858430FE7CFAC7B7759C21A943FCD732CA144CBFB
      5B05B457A74826C3B11D1506C78FAC3E8F71E9B887272B7145D1CF0A1ED6C36B
      126DD3D776E26E21D1B0873FAC74476E149AA12272973926DD197BED66FD6B89
      A719AA1584C1F025473EAEF178B4582D6EE5B67A223D4B5D57F59C9C53BB02B6
      F1309C294369DD5305D0EFC912245349FAAAAACA5A0A7711D9F9B881E90E52FB
      27DB9ED5F606ADBE6C1FD9537469BC94609C4550B470794F7EA9782687A1630A
      37F7240ED2684FE7C871871B9FD786E11992859105BAACBA6959C06F52B6DB17
      E2C2F06C2935C5FEA4833484A142D25AEE0ADAE89482FB6DD746217D57171595
      7DCBFA87E0B8B42B2E62F6A0EE94B6C62969BADE291463906C290898E7D3C71C
      10717270606C678087DB5DA2D15F488DDA170BCF84DEC32EF253C17EBFDF328B
      BFF70C3FAE6028EAB8AD5C5136097855EE242F4C3712CE634134AD0870EE0EAC
      4AD2C30F2CF67B463F6DFA5544A718D0F8554D8659A51DF15CDC99AEF0596B26
      EF2A3D77165DB49E2D53817572770025791CC9B1FBF88B9FF9CC8B90D254C7CB
      1A42AB651EE28DFE76E7D1E1EC64EF39CFB886AECF6F96F300D385D832E9A9CE
      902B1DC389E6930175AFC4A753B6694D66A46D18D84877963C72C18CDB7EA67C
      8915526EC2E8CF7DF6E6DF406DE3CA86B06C8AB8A7B4A3594FF2267E6A9F62A6
      6976B5A5F299AFDB5E8FCA66E76FAA4E5884214719E59F03C231BF3C91261F61
      97043F33FFDA0008010202063F001B0FFFDA0008010302063F001B0FFFDA0008
      010101063F00FBBFE3D54D2BEB5E34F1ACFF00ED69D7F126BC554C8F21419816
      8D3FDB52C616AD3F01C750A9A715A3BEE570235787F49ED1CBD010B4FEB6FD4E
      BC770FDECED2C3AFF30ADC5E23B0BF8AA96FAB8F9FDFC6CCAD7F1BBA0C256BF0
      F39BA2E9C78767DE05B28BB73F328DD2E0F55FFEF8E17A2DF1ED08AFE2372786
      EF73FF00D19AF01B1C37747B78973D9D73C06F698D66AC72FAEC75ED3541C505
      BE4E69A556ABF9A8BF075E7C984AA3F1665113EB4F5267A6C636B1D5539A946B
      8180854EBE8554E08B790F7F1B5E10C13542DA23796E313F9107CBF954731F1D
      267F175F58DC13447330E54CC77AC26896B19E0F9E584BF77CDD29793C2C700D
      49CFD29CF82530FECE77113C4B69F565C8D29C758B3C7F373FB32765B5174D7D
      0ABC5FFD95EC4F1143E9ED1AAC8197263917C24F49291B8B633EF2A7A134E2F2
      469A36B18C6DDCD7C3487E24933A5DB3F7AAC839226DAAFE0E2F59BBBCC26341
      5DFE450EC3981E36B63CDA8CEA1637FB41E6FE77C5FA9E3DE1FBB01148E573EC
      B66093C1D35D74F8BF624E8EF4C9F7B8B8933DE6EE9E59E2A6973ED26E0B2CBE
      78BEA5EBE56722AF15FDA49FCD243E2FD2FB6E52FAEBE2FDF430DB9AA71F4D71
      7FD62FEFF1DCA3C7B957E650B57FC1AFF7B86FBD83F653B879A33BA2D9E865C4
      6387F89C06F22FC94FDA14D048EC33B3FE914D3810FCC522DBF6DB5A6E2DAEB9
      BE553D2F224DC3A5579748D18BD96491131694F32BF8FC0A5EE4B7759C72B1F6
      92C5D21B313C561B87182FDF44D7A5296489975D0B0D1511156C12254A9D9E12
      70114D5B398C6477A1F55BEF79B65133CACA6FA3AA8ACA5F4F8052BAF6F4ED43
      F1EC2C2786316620664B296BD918C31F45602D5E0268A963A38BB3B603DDF568
      8BF0497289F4C22F098D37DBF11C243317F6A8DB206889CAA29D9E4C000175FF
      00295383C596EF6B1ACD9E8345B691FC1D4BE67038ABFA69D2D2EB8C1BA491C0
      CBA513F95390DF7F970785B76DA6E75CC240FADB15D724C8E1B8598CDBFA69D5
      0A8CCB96DF941F51028847AB8301C2F8976DD819A6FEBD2B87D9C94E4D9907A2
      E8BFDAD269437C44A5F5AB12705D136DFBE706318D4D2F098A1D9AB07585B2BA
      FD59130C32419529E7E7F3FE2E2A9064DC8B3BC88FD5AFCE3C4E25AFB2A75554
      F49AF67B89BF978E7FBBB616D976BD9AF318D78B516E3FC3E04F85C3DBEFAAA2
      E8EF37283061ECAA9FD28C1F970DEEDB90C8B8636A91EBFE129ECF75CAACD793
      43D7E5224721073763D2D13D52F4EDE0171CFB3CCEBB9F7AB0967AF6C73910D8
      931F1A889AAF4EC38FA949F05CF97FDE75E00BFB74DA0E07C64F0DE8BD34B5B7
      1EB13AE41D55174EAB22C902749F9BFEBDCAAE3E2D3DDFC1A767C1355CBB5514
      51468BDFAF4444F4EBCD387303346F13167DAD6B5BB608C778E1D08CBB906DB8
      51C91B4E8B6331650E11B32A544E6E5D1D84D3B787266DA06D2320648335BC28
      135CEB276AC6EC56AFF650E43C26189387E7805579F82439B493CFCDC3986C39
      B229B6F8C1E97AD2C776FF00026A8E916AC689FAB4E2655CDF2186527E70CE63
      2F15CA73AE69CA999A4772E5DB8AF794320CAA7AECAABCD57AD943C399B4F67A
      7B3C959AF6BFB5EC97902397AE25AAB2218D83C3315095255DD2909C9B33363D
      0DA8C05175A861CA20AE5CACF995AE45BE0DD4C7202DF72AB374FC65B7667226
      523B8354B4EA3179366A0B54758DC29F3F4CC4FA37A2F70DCE109DAC44F28CDC
      1E9EEAE46DC2D4B9AA4B78A1555467411A6514D58FA32E49FE9D958DB157CFC0
      8D4D0DC235B7378D60301BDBC6B010218C3721C71051284A06129D174A511111
      397C15DEAAAEED3CB9FF00722AF0EAD599F7430C7AC88D68459AF11622BAB957
      262B909AFF00653BB342FDA4042CDEF55DB2129A87FF002B8748F6C676B11F82
      36DDAEF8EDF933712E97A6328B83AAAF74A0F19C2CE6B8EB19F46BFCA5F5F46F
      4D9E1C6D6E3376595A5F1A715BC84E3A647F580E2BA8755AAA41EAC6700A6390
      C35529D13C724424AD13E9979EBF197BCA9CBFBB4F24CD03C6307956449C490A
      E81861B068E3B4AE54FA6D69DE411A23EC8138399C5E9D8962C2AF0CD34DD7BF
      306CCB1A19E010AC8F828D3FCE4E60F752F7D531EB23800C51643555517DB4EA
      2B909CB56FBC9AA70CCFD4E0EA3719931B3C0BFF00B45DCA102E49BD68EA74A9
      0B69C7C8DED98B9A2A08A44516FA31A9A2F3D0855E7C08D6D6088DADC00F6050
      5BC01AC0408838C88830E20A2D1E18C2D3A72A5134A53969F05BAE48CDF93609
      89A00C5696EBACD7234AD8E1B1C095552BA6C12EEF47B78085D688BA59EF6B7D
      74444EDD1DE11B23C72FDBB19C09E309672248AA73C65839B89D1514B1EB7007
      F68335F679489DEB161B5AC4253E81C387964CADB877C8162E78526D5CC2D82F
      A9C598E7D9C57CA6A77A590EAA5D356FFE0642E8EA9CB8EF55577AAF4FDEFC1A
      79363C5B83B18CDB2DE4691DE4A192178FE38E929911D422FD64BA5A59843AFD
      2DE0A548A491552838B4F3BEA89C31649F792647FD90462E28CE09B79C46E6D7
      23C9AE43A6BF549CE434A5C6170CEF69CEC33FB78AA86BBFAC0242725876D4B6
      F98EF11077831C4789032B4F5B3993D81513BBF6B720BDD4E53394548BD9ED07
      127E0C7CCB3B80CAB09C3F8DD82DA2B9CC320481BA3CCD64954AEE0ED83946D5
      4F5CF4E1D82803F8E594BF16C59A9797121C6BEED2C5D6A686DBF1C0FF00CC86
      6D6B766B8A255CE9573C77892846F913CD294D5A8A7C8896C44253E7DA6FD8D3
      5BB9277579D67F9964D55E22E014CA1E2A58DC6AC98BF5816170A011BA230C6E
      54FE4CDA20832E9D9E52D0C35AB97C9BF712DDAB166DADEBD7AEAF2444A53555
      EDF3711BCC9BD22647B4BDBE9DD3390311BED435ADC3E46675A34446989BE897
      1BF17006D2BF15C24231267245469BF62EA5FE2CE31DA861989E336AB96AC5B9
      1C8C61AA759F4D8D193BB4BA4DE6EEEA7C924EE2ABCD10927A415790D62C58D2
      D27C164986116050C5B578924ABF752C59B16054FAC904DF5D29A529A535555F
      47127C35B1C6D8FEEBF3CB7750D87E48B8E042EDCA04F14A528BA3C32176DC32
      E1C076A8ECC48AD5AD4A9ED6F1ECDE1F82F296EB733CA72A48FBD79585B1CCAE
      8E1D0800BAF5469824240A418DC55BFBAB4F7D001A9A8954F1C85BD7D56F2F94
      60C09B60C6AF79267EFA95144500D9E958E2B1EA091043253379014B43745A2C
      D951769082C9BE88B55EB762C25E26F59B1763398B328B1FDC7EF185B421D772
      13DB4F8F8E313BAD3A7784C3714770E9D0F6EF92927711BDAC4AD9F1C6A5AE9B
      B7AC2FC18E99D774D931B20514152F8B1D65B54ABACD720C8507ACA0E2D8F62A
      1AFB424CFEE089A688882094EB7CABF607B576FA3F630C7A73DEDC767D7AE900
      0B87630F0B6255921BF9D343A66D95B7D542BED2E3CAFF00B006A9180354B68A
      8711650E5F2A2E24C26D6AC1098E5D00FCC79ADEC022F41B1344CC2AAA692CDA
      A95B6AF52972A46BE8D0CA3DFA4B7522D5CE7645B261A38185F6D90C40482ADB
      79591B25BDD8B06E47CB7260874A3DBF359074B6D6E25159375446F15066A6CA
      6F5D4187B3DEBBAFC195C92777C59F67C9AB7B8538576FCD0EA38B2497989474
      892790954D0E0B16C74D272EA5B8DF1D548A916C0D66F11AA23DE7ADD16412E5
      72136D92345A32129214031BC5EA2D4A0E198F6294977426263017455E77CB32
      FA2DF3EF9045576FAF95886DC30904810A4780FF009432438017C88D625C6C11
      C18B2299C87C354A89B8AA420CD4022A54EAE77AD0E8B6695BD7EC4336D5B738
      9D98DC46376EA29F1ECAA0622579166260E2DB7F9E4E1DA9A69ADDE4F2051295
      AB4D05106B56871ECD81AC58B16BE0C332B4C68126198E6EAEF1BDBF61CA4C51
      4F9F4C041A9A8A7576AE8D4C68824390AB37DDDC111754BB646B3F582ECA713E
      DC5EE126EE13DCA590DE2FBB3D3A19715016D192A5F6546A38D7FA8B14523C12
      5230400E948C28D6D1113CEBE561F8DB1EC79D65B3C9F48D961B0C8AB20AA7BB
      48E512472119D818DA85A5514A39C5C8BB56294ECD6AE23B8C6C86D2EFB80C8A
      2B3CCF7279084B545FBB229F74952588A34B9A77AA583639A4CB8034FC842554
      93FC1B57CCBF4FC1B9373F66292D988E31C4710799B4CDF4954FA9B3B30C8656
      28427792B707871A92D8C18D67EB25977ADD81D16F5D4459F6E4B2910537B314
      4111CC438E7A8A6FB562BC52D861B5C56200D49F154DEE15D53B13AEA6BB904D
      F44B54ADAB367CB4FBDE479458BAA8BE11703F17EDE03701D2B09CB2C3CB1D3F
      6EA781D445BD6B483C4DE2CB708BF254D78BCBAA5F6FF83B0F7BB571EBD5DB14
      388CDB9F3711D25D5EE961A1668588E026AD09AE886085C84C1AFF009ED33DF4
      F2ECB178F3794EF2092BBB6B1B0B507478C6BA3C3C18302D4DC1D3D951671A55
      BA11354E6BF838DB8ED518AD8484629C6ECA04C4F02DA2587FC92F14AC8B26C9
      939222D3219CBBB8129DABE05DB69C9113F725B5955395910EB5D35EB8D8E8EC
      C47DAA6A4D554474652DBDC82AD1153E787BF4AEBD8BC185E3CF7807BC836E27
      5CF9D146C65BA0903F325921294A97AC072E37E45732C3445F923B90B56BFA6E
      0D336E5EFF00ADC548BC4A55408DE6390E5B80A594E7F562A5D8F67136A4EAB9
      7D3FB0865F57059EDBB94DD8E78650FE99F703EF66652A4BC9E80E25279B42B2
      099A7F47635E159B3D6E5FDE5185DCADDEE9AD079665D9DE157EF5E45EC1BED4
      FB350BAB44E5A2D5DBC6A37BC2B7435FA9C3253A3B7FF59F68F1474BBF9CCB75
      28FF009C2D431DD7B7FE998A3873FC1C516C4DF13C196A85E76DEF0AEDC9FD6E
      A7344D4A7BC3CE072EABFE57147B4B3963295787DBEDCC0D8BEC78BCF4E7F661
      8E37DBC5AA1EE03B3C9B509CAEABE62AC8C0DDBBEBD62F98E3888BF838A3EDE6
      CCF6EF24A3F4B4C4A5991A1CB735E5AEAF26CDF4D78B36722FBBC24ACFA69D51
      90CDC6B648FC4E6A9F556B7BC391BD35D3CE571646C8182F773002AE6A97090E
      258BA62C5697B3F5B072A36BF55FF567162C396E76478E8D23E8C4C81847328D
      A269DA53A4620F268F88BAF6EA5F035106DFF6D4CA2CCFD4DA9FF324360EFA56
      BAFEAF1F9B38C71FEAFEADC7B5A013A87CDDAF4D51CE2527639237AFABAB6634
      FB69F8F8E5F745757E6EBF9138DE0EE04F715756D98E6D98B5C348F156F59B58
      DE0862C0F198942A273A4182C71BE9F3F3D7CBED0230F007B462B8E25CEF9E64
      E95DAEA07B3630A301D3D8B2963AA68A19B915A99C65FE3FD5E48D649132B63F
      B43858E98E69796F19CDACCB0BFA0282369AC22935D792A2F07D792B63784DB9
      E0F4AAE5E9462A62270BC96E93A2AFB44C78C446C20D773745ED294AE1C1D36B
      9BA3CCD851C884BD7458EE4D618CE6887D9BCBF2430CB0171B4B8107BD4E9E39
      05BA154A735F1B87073C50D786F7471F196F5F1FF65F90868ACB3A0A755A54D8
      A6590A0E0F5D56ABF30DCE6E8BEBE2E47B71FB7ACC5839D509E9C6B79331FC92
      240B8E894EAACEE8F205B6C7B0F972BE29248EBE9FDD8EF91591BF461E4454E9
      9DA3EF4E4C8E81AEBC9043802ED1B453CB9E8BC0D6F1D6FD7740DE005FAA32BF
      E5A94CE2382E9CBEAD1D9B1F248FD3F806D381E997646C359F45B0A952D8CB78
      623E0D57C6FE6F517882AC4C7779513E996A55E040B70DB108E3C77F91D25C37
      981CE3AB639688A2C266B159321AAABE97D1B8105C8AE99EB6E4E1752D5A2EE6
      4DC54449592C92A888A82BAE197AC94794122A73BC40827DEE021B076F4F6EF3
      9793D2D74B13B593630C937BDAFC9FF7224C7354B957FF0074D78EF5AAA8AE8F
      37734FDFD3EE3CE3361AFDD18887621C912AB44D8A53C6B37A390D79784213D7
      4A848BC5DAFF003AEDEFCABCBF16BE5F74B94094B370A81ED7A98A375BB9AADF
      B244FB27C34D24B193D40C22ED85FE3BCB1D1999C7582571A76B7D3BA47E4ACE
      DAF8C8E761517BA31AD2EE29CDE6D1EAAA954E1C9C1D76B4CD84E5AE1E3F7661
      B70732F0E9821057352C689B22578B4B2FBC9DA531149C393FEC8374F18C820D
      3E35E071B6E1598B8349EDD8D6A4A051322428191C75F4F55FE70C6C2368BCEF
      F0793B92DA765586465B2A5527223432FDBDC554D8EF5494DFAF26E3F264B0D0
      EAA91117C024B189D1535B29CF4F21F16A5A75FCD55FDFE05A36F9BBADC262A6
      E03BBE0C6E3193E51661BDBA2F550834F3E206A27F0E255C000663B183B744C5
      63C2B47133E81FD859BDF1935EF20721C4A7C2A3E29BA2FD310C65EBC04D3BA0
      DB9E69DBDBB10B6AD152183B931670828B555FAC9A61494C1A661074FF008B60
      66372ABD7C370DB7DDE2E1498C81CFC2F67421DA554C03241DDEFE698CF21511
      79F94A8BE86DE3E2D5DEFC3AF6F97C858DDD6BAECB54FE13298539DCB4BF3B68
      093B09CCC62A76F3510C5E26104918DD1C8615287F893F87CFEA8F31C753199D
      46E7CBE29C1DC4F2FBAB815EBDDD2E4FB544948B697F4D621D96606D05FE2AA6
      F6BEE1AECDFB76EF5AB89DCB96EE5A4BB6AE22FA6954545D3D7C3ABC4EB6E2CF
      8A3253AF8F76E65BDBCD42E2398F5A622F52E8EAD4CC0D58FE54E3572D487A64
      7323D7E977956C8F3343372D19B1D4162637C81D2E23CB566C26BD335353B1A6
      B8E3293989A73209738FA2EA9A58E0BC65B90C339170BCE86F1AAAA3D90A30E5
      1B20C1E854A11CD98A34446F7D65AD5391CDE41425F4F93797B7C925542AD356
      BCBBBAA2FE0E1B42C0DBC2CB8DD166CA6CD91B1E4D1E69CA98DECD8A7B440A0D
      93049347D969A953E5B70E211A2AE97B970D91EDF16D563B386FB7558B46E4AD
      BA3C910E91DB1A9EEA2925E339B1CEB1E7C3EA44E7D33EB10DCF959E1A99B196
      E862F02C86EBD3DAB38B33AA2E1F9C29E527C56B6B5945DA6232970D53E8595D
      1CFB38A6E5AAE8B94569F375D1CE95E4BE7E7E8F2BB8746F68B8D701DC4941EE
      56044DBB5E0846D394D0A2F20D23E9ADA446FCB01C82C2584D5691BC25E5E2A7
      97DB90EE2750DEC39C19F20E0679BF72EF834DCBF328B98F3111355D5155C723
      451907D3F85FB90FC63B8AC3B8FF0034C0DC16E55723391628D5296D1CB4EFD3
      43A3623B895AB3BD854F310F15472C55F8D62F52BC3ECE7DDEF955CF00CD6EF5
      4737E18CAE73B4EB0DB891AFD59ADA66FF00DA593E0E1AF255209FB51AF6259B
      5C5509DD7E0998635524A2448E4C6E068FB8CE6DD222AA5F88E4365ADC224F6B
      5069E3D43D257582D2A9D458B2ABA793D69D69FBCBC3501B7DDD16410E06D3E0
      DAB788E7A57ED331228089555536870899D2EADD18A4DF3DF6556C3153F4FC33
      C3FDE03B7E74C58F373C014CCC780D4B99C06E90BA2DC7279C62FA62CCE2CDF4
      AAFF00C9CE7272754E5634E29C83B58CF78E336C73C1B174EB90C7F1AFBE473A
      CA57A61A5B1333D9F2E869CBAAFD59C84109D53B3C985B97C68C74BAE64D955D
      914E4A0C419487591E0979085A72CB60B451FAD950DA5A439153DEA950711B8F
      4B29E3DED17CB635CC706315B6698A67911C8D1270E7F5293C31F8192B091CB5
      F92E0D76978C21B96C777FC587E6BC6912C86D3616F2DFBED89246914D3580FA
      B55FED98E1F55D00BECD0AB173EE57DC6D97E030FC9D8FA4E2A852284CF238D5
      298BBD0ABA274CE8CEF421EDE6528BF9D4AE9C4872AFBB4A5636179DD3492E65
      EDCF223BBB3B62A9210BA908341A6E5FB4E438F4FAABA969A45725746BAAABB6
      D12FB60E9C3DE16DCC62597E1EC951EB88A5C7A5ADA83758DF5555A0AF71C771
      6BB8C5276070A6CAF4AE2DC51419689AD9BCBE51A324E14C993BC4B3F63BBE2B
      3CD71DCA5EE1F226FD169D7A478633003D06ABCF6B5D153B7862816FEA0826E8
      71DD9A6C8D7B2942466483E78656E4AA9A54C35AC3A1AF1D642E844A74A6C5F1
      D88C27E98870BCABCFED0ED533AC6E66F418231D27C62EF76A8A65A86A555A50
      AB22C7AF480C8102A4BF994701A925A4A54F9826F26ABE44B6B75107726E7118
      805C002ECD8BE19609761452432C727BD4921994AAA2A2A2A55D8BCB83E458CE
      3CE3FF00940DC0BA3BCB7093C59B2412D90577D7AD94E11742EA45EE1F0D5294
      8695BFFADB05EB3F3D7C8B07783E5A6FEEC4CB124F05E1A0B9065CDADA39954F
      75C59CB4ADDB2D63069D5294A4B6E70D65018F4F3290C79BFF00A0FB9CDC3DBA
      CC4B1FC911CAAD977A3CFB7ACA813A81BC1967BBF6831E4D83D1FA30F14AA5A5
      5E9D5452A9B29649B17EC2AD957ECD3886EBCEE3F6756C8249BB905B5A749FE2
      76EAD52A103CC91A6AA16946FA3BCB6124EDC88D44D7CC8B0D6B76C58BBE518F
      216309ACAF1CCF62E7D8738E4CA0EFEE91494309E2AA2D25B3C8598C6F7200CA
      354E766A45545FBFC477137BC9E3A7672C796FA76C1F70B066C6A6ACCF181A9E
      E0C84CE2262A3747328020D0889D40E8D6EE89E2DFBEAE642F0D39976BD97617
      98B1D3AAD16BDB31671F14966394742558E56C26D214821D210ADD48A437390A
      2983AF25B29E6FDDE44DB0EE023C8F9079E36A206E63503512483CB84EFAC727
      90A2CD45F634AE36E3578E2DF455A6FD3E20E425D16FDEB379EF046706CADD18
      8D535EB126596B6FBE3C3B2E41FABA8615F986BAEAEE84F6DF52DAB0EED155FA
      C96A29745F186BB62FDFF2B8E739621949B08C9D8AE5AD13784C9C154A6FB53D
      33174982ADC1169514E6F70A5147285BE8A29625EBA3DF45B376A4E22B9BA164
      36B1E528FD86F8CEE0B140C52DD3F1B649A445A8BA4714CA94F2E0F27516E9F1
      F3D53BA489AD855EA4432C58FB98B6D7216C1C09C35F10D0CAB484885D82A851
      8914912E225248D551569522F254E271BC6F764C2D0628643A4F96F6831D117C
      12ADFC635D655B790C6A11062D3990543F4D2A4D519B454B0D77AE885D9B8312
      35DBC39162F5BAACDEB57A955A6AB37D17BAA8A9553E7F5F956FCCBB54CB321C
      652C1D6CD979041BBD744270CC297D6AB04F2227555B04A98D55574B048CAA2A
      D5E30EB66FA25E48DE0BDC3511EDB5EF00D51DB9B980E73E9F12E673D512D77F
      17C91E8BAAA669538168BFEEBB990A62ADEB48010E7F3FE07EEDFB6FBB9686D0
      F6CA6292E50D97B57481CF718CC2A12A14499E3F90DD09C1599F01ECAAC55492
      21836B60AB17EC2AD9E2F4672AB15F9961693389B6F10EE2238D45D3079E0347
      78B1DA5DB4ADC121990C1017531989216A45B372E8B7CC193C75F2B1DDC3E0C7
      04344AED5960CA38CDD4B2EDC432CC008290A768A4892944AC23744EA1A9CAC2
      752D66A5BBF4A5DA7C7B17E3DB82DB94BAD39B7116EC033D81B85E1879CE2A98
      A0885190B9BB4D3F1813C4D7514844E8DD0544206BD7ACF3FBA273EF07D8E426
      D0D9C59C43E53B8AC1916034B3999B854529DB28C21A824D69CAADC122DF766F
      B09A4846A56FD8A55DD151D2AA6BA7B95D0A88B42FA7CE8BCFCAD17ECDDB96AF
      5AB9E25BB96EE78376D5D45F948BDA9A69E6E217B47F796CB5D65D8B7BCDF1DC
      6BBA776BC43B4BF1C52BDD08463CCC5695B8CCE0F4D4BF1640BD43B35FF29434
      75F1826A9030BB00F6C0F8DC03C333DB41A339353D343A0E8635BA353A075284
      737B88645ABE3103D55515D2A8A952EBFBB97E12CF58EE2F947164E9AD5AE590
      89637A38B4B90F522D4190956B41C039361B4A1019E3543961156ADDF1EF5ABF
      692A494E7BF77C0D2CDC46DFECDD21E5F70B2D957BCEF8ADBFF5A2FD802854A5
      DCB9126FEEAF75461BDBC20BE1F8F60D4B441DC5F0CB1EF0A60B7AF0C40F7EDA
      D8BF66F8ABA123903AFC6A568AB92EBA7673F2AD39EB6C93758F3C5AA476E98C
      3DDE929D6019462A84D461310C871CA4D6FA5E00A97551EFD8A862C227E7C5BF
      62F225DE010A22F01E2CDCDB4337599036DF2B751BED203D1F73DA720C78E955
      215190A11DF455528644283A7C2F680C1ADEB1E3FDCC9CF4D3837DE31B67895B
      0303E5B945A1770509620691DB315E599192BD24EDA4411569120D94DC35EAD3
      441DB24177445D1CAC58B1E5A29B3BDE0CC0E7ED99CA9CEC33C2266F370A39D7
      6CF20762D3A4345257BE617879CDC09D5D5BFF00E495BAA78C894F5962FB6BE3
      33906ECCCF0158726B756D32C1AD8E4DC75842C3720CB0FBC11611E2D5E3517A
      955A6A4A9345E689E41EB217B1976E5BA032C917EDE78C5ACAD7A4A9C534D3F6
      B505A95B5872177E9A97EBFD436BFF002B69D7AD8B283ABABA65AC624E44C183
      1352356E23108CE729C6779B56FD7D2FDADABA2A6418CCFAD6A44AAC3D0A28D5
      13F14620C444BCBE523F9071BCB647049C441D067D8B4C21EF4E71E92471E04A
      BBC23A33BCB312038B79E1554AE97C7A917B7CCBCE3583BDE96DE5BC87694769
      65DDB40987C775B365295442733E3B640A9A9E569EC5788E8C852A78697DA88B
      CB7CE58DE56C23916219571D4B855398269049036C9238E4353AA55A1EDE4554
      526855AD360A1574285235B37E94AA95FB9B24608CBD1A12658CF2B44DE21334
      8E9F6BBF65C999E85E90AE92B55D40706F4A909109B1A1221766D916552FDA45
      4CD5B4F9F78E7DDC7724AAEC2651747F02C4EF1B3DA23C63D9A0C94D1489FEF0
      460BB4A5D8B0B5522BA5A246FD02F978FF00BACB73325B855C415C2EECFE7CF6
      7AADEB4384298F2ED819D4B32AD6AA69046BC744F55ECB57DBB5FF006658F224
      B7390639E09E3DF10F04B1EC101183934F4E48C58A4D3A122D69573454D2A4E5
      CD392BCCF30BB613B31CD8E2851153FE2066008C46F8EC52AAA9329C27516DAC
      22FC6AB92C74A60EF7CABFE3AF0EEFA561C2771987DBFC722D65CDB98CED3E00
      46C4D2AEA65D07A42A720C33A0113BC5904B62B50BE63EEE9AF15D922DD766F5
      BAFB976DDCB6B6AEDB54F32D2A9C97CA24FB69F9BE598DEE5F284224710EA51E
      F1C4DAD06894A0D35C7CF3438C6DEFBC252B62922A1D0B169B8BE0116579F0C9
      03F784630336ED3323C006EE64C6161F67585DC48554EF15208955ED3C898FE9
      55AD11106FB514E89ADFBF6513867CA182B29C173063F7CB54A364CB1EC99AE5
      4C245DF89D48BD6B3967D02B8035568848D7FBA48B572BC94AA2FDCB877DE030
      B63EFCBF043F0187F301E1D944BE6E1F9F39975425D5DC94D3EA50CC94674222
      2FF8D2ABBE5E2990E0AFEE7149AC1646CB2D894A190AA82786093C71C867A8FB
      EB51694A74673638876AF8F569CAAB5C60FDCCD821B6DCF5C59BEC566F620129
      B1623999E1DD2B4CDC441139820BFDCAACBCB5D85EC6B7317C9273D34E1C5DB3
      FEDA625464671F1AF7ED971BD94C67973DA15A69ED47595C591BD267553AF2B1
      211DD84F3F83E7E1D651B0DDCB31E4769A3C5284C57B870D21932B2376A06D79
      3218DEE3129338AEA9A212C6C0369FA7F41ABB9BDA8E59C72C20D6B6AE4F2861
      596631BCBAAF77A6C9F0BAE458FEAAFB3E67DA5D4F3ECF47934C83B5ACF39230
      8CA2E28FED0220F2335A9B1FAC0ABA8C1CAA3FDEB91E94014AAFEAEE2294373E
      69C33C4F7E5822379D63F6D4714CCB186BA4C73932D58D514A74768419DEC792
      93B4A79586E58B8C9A72E1A42C45BA58346678E88359AB126672EC623C8F69C0
      B5E4D21B3CD2A6E6F991C88BAAAC78B7517F86F477E8AA8AE95FF1A95EDD3F1F
      DC5B98DB1BB591EAA73461B9CC219EF99A780D72A3D8CBAA14FAABAA7FDDE960
      C19E9FC470735390D7C4706C30800E12FD0B66F884884542923914E88B4D5455
      4F757D0BE5F72BB287F70AEA8F6608137E6F820E45ED0602738D0B12352A0C11
      D56AD4C98C4A57608297D11CB5E54810D1EC9421366F0C40F7EDA5EB37EC149F
      581C81D5169A92A4E4BAEBCB8733F26ECFF1C45A5AE1E35DAF206170C9C2B324
      3EA44D5D4E331DD71E6E939FCB9ABC8AE69C39BB6CF3799258D55F3D79AE0DB8
      986364A06BB57C9A6C159371EFD9A342174F3FD992D79F07981EDDDBB703196F
      5BBFEF46DE264C539EAF4F3870A78AA33944B4FBCC4BC5715CD788F26621935B
      5BDE247B26C164F067BA7A64F8DAB5C9DB9B0E4445EDF8BA792F8ABDD55E5FDD
      AF0DA16DE37679518222D9E05B1B19CADD29C918B106E75D43078F67E1C8E36C
      D51C89A78EDE3085E8BF4C9C35B1EF3768B189C5342D9B27E42DBFCA4A83BAF4
      C9526A4DCC7335492B63C1D5AA7351DF5AC6F459E016FAB71D776FB2B70F053E
      CA6E56386633E8D7FA64E29AE438885D13B7FB7FFC004C71ACE22390A22E94A5
      6D72783C91A2531D70A57B7A4776338F6F2F4F554BE5F4E37E58D410ADB6B533
      6E7F2CBA3037DAB6B6070E312F9417318A083A7E684C122153CDD9E5F638F0DC
      5A0D4493214831CBA5BD7EAE737E47C732F8774A573D569435DECDFA7B7EB366
      DFDC2545F22426273C8C1E9A9F1E9A471A652C8672F8A8534BD04E0095A7AE9E
      0B2257B21C610B782916ED0F984AE3FE0F20523BBFACFB2B183D4663665752F2
      FACB7129CFB382CAC0DBA3DC361D309A52EDA0A70D305CC51C6EBCBDB4882060
      E3490F45CBE492E64D5CBE9B8209C23B91DB465F6C19556D8F2C59F623949DAA
      EAA82B45317C8F1DA79FFA77C4E0924CD9CBC4FDA07F92ED89B20E30C8085F9D
      3A58F32CB566356A9CFF00D989C15566BDA86E3714591156ABA7642C2D916260
      253AFD3AB9BE30B700A1AF6F8E957779F6F1F1E8AE8D7F3EDAA7F7FC85128C21
      99329E1D92DBBB62E23F62E9FCAB1FBBEA2EBDC54758B3CB59DAA7A35E00089D
      C6B7E778DB7A5AEE46B70509619D751A27619340698DE512F54F4BEFE2E036ED
      D3EC7DBCCBA9E021F30C0592890695FE7350B8F321B7B92AF2ECD64C9F7B80C6
      9764CCADB7A732FE6903CD18964376CF51AF34579C4B5E4C6012DE8BF4C4922A
      70159C0FBBDDBAE51723B95A8FC4F2D42DC25569569FD5CC89FB712421168BE6
      BE2D2AAA9D9C7C5AE8AFFCD5FF000AF93DFE1D62FD24D1633790C4B5DB45D108
      8CC5A371C2AC7AFBA634D5F7BCBEC1A3CC742D46B5E6D1B2097FC0B3E2B8F48F
      24C83FEC389DEFB9BE351457FE727F81782AF661DAAEDCF2990626A4919170A6
      3899DEBE889AAA9044922EE55AF17D649B03C2CDDD473AFF0067D4CAF12AA72F
      E4BFB2F95433A5D17D1A704AC721D9F31177FE8571FE6E763FA4E5AA28A993DB
      F246BAAFFA7EF76F047ECE378BB8C89D8D5544B7358BE359F5DB5AAEBF582591
      971BA15CFD49C5DBD02F78B33B87FA26F96ED9CC675B7E7D15D19B3848B5FEAB
      C5D5826EA3699244A3E8BED4DCCB90DF153FF93E399BAD3F8538B96D9C2DB5CD
      68B69AF8D1DCCA4036AEFAFF00DF289C617F2715F41B6089C9D53B3D85B82C0C
      3F8ABDBFF8A322C73CFC57D7EC4666577345FEC4C9583E4BF8BECD65273E2AEB
      FDDF3B8DBCA9FF0033C352449FF621AE4BC7CEFBBAB783527A06C113D357FF00
      8364AB8F9FF7716F76B4FE8DB61CC86FFC4A25738FACFBBBB7D01FA7C4DA8E79
      B2BF960C9C0F460BC65EF6DC64387CACB5C0F1FEED58D8B4EC418C8F02C891F3
      044D35F0091953D5C062D78037B397590355F0DA32EFBBDA6524A6FF003E4854
      A99B0E46A626A227A5D178086CD1EE1FCB3912AB5A2144C0B08EE870A5F2F9AE
      89ACCA2B964010B4FEE4E03A72FF00B8D3DE558DAB213BB7AB85C621D9047117
      54F8CBF6D0EC26E0A2689F2BA6D781693F056E530F1C5AD4B6DBF3062274625D
      34E4853AC6CD9447825FE3CBA7F7572F5EAE8A2DD8B6B72E575F622222AEABD9
      A7671BAECF00DEF19B3326E2F34E4A6BAD75D3D8F32C8D249134D95F37EA06DA
      F2F9CF75CE822D71BDB7E21A624C04DDB757FF00917369C5802122109A212ADF
      07893E5825111399D6BCDA7C09D9F957F7FC96ECB30D878B6D13379C72E58971
      6576EEADA3EF648CBA32C1238534A7614746E976BCF352227215B6EF669C77BC
      FF008F4F2D451452B5D7717BB453E955E31242E66C15B0E6ECD15919E3370C58
      DD3BC36CA27820891D873AAD49D6046C2A0A1B53796355FAB3A592D53E939FC1
      B8F76018D9EC73E0BB61BA93BCC6404525D0DCF3B4BDA6A15A582BF9C50EB5C6
      F02745D56955ABAD7F387BDA2889E5C0DCFE568FD7736B1B519432C88F4710D2
      F34E55CCE2286F309C702A169D11ECB1CAFC2789122F534A0B48A05FB1DD7245
      4D3E0D9164C5BED8EDB80C9169DE0FB6EC7C65DA6F5E904E544A149983B069DE
      AAA83E3814BB6E0EAABDC429545012F5920DB0BC4AB204E5FDCE57339CC8DEA5
      D2D92BC95D6BB3FC9E44E25BCBCBE3B14B4D5D61EE2E265DBE455A73AAEAF968
      E602C2EDB79B23C3DD09DF32657301BE4C5B1163D4269A5D24EF1522250E0F87
      50976C3434A5FA4A7633E6516CD84BF7EC635DB2EDF62D445F1C636674006F15
      68BAF924762EE758FF003295B9A51423D4AE4AF35DE24D217977AEF76C7823D3
      66CD3F064B7729B8B94DA668D3250804622C15D1AF4C326CD8DB04D6CF028433
      2AD2AECFEE548CAAB52D4830835AB84937AC8D66F5E4986E4B369D703B46F88C
      78DB1B8279474631263800826B8F42E3A95A5BA4AAA9A8C5BE7B874E3ABA39DF
      BC4F76CA5D4B36BCA8788703B0D6DB1267B8DA7E5ACCD2104A480E278A944D54
      54E8F255094D4F2FAE34D1791A5987A90B7426DAFD08F68822C30EDF36F8C571
      695B961EB23E4779B627DB8CB13841A910C964B4D1685A52BEDB2137D85411AC
      4F98B09A6AB77E0CB93CCED25A1F72448823EBC4980A2E60D7F2464E721294A5
      14412B4EEC5E140189A1AFEE14A08222AA5942095B215F3736EE1246B65A40AD
      C80C5189996F93671EE2489997D7FB0A28DB5AFD75C5C6916CD4EAF17E9EB1D4
      AB48B7952CDA1EC58F2B16CD59E2CC876DDB3822E88E36662F0D88064DCC2CC9
      F5AE970EC71E42ABA5667311512994390EAD49E3F8E30EE9E15EB0918C01B67C
      6AC18BF18C5AC6A334B2D84A9C1DDC9528A4D92CB9FCAEFBA4A650E696A9A8A7
      03EF90592A9CEAD2DA27C18E2F8FAE40B332B3844B9B9BC3996382D8D80043D4
      514E25985AD21881022D3AD57AA54A511175D34E251827DDD1723DB83CCF4505
      343AE7E3D55CB0563C397EAD55F8853F17F6BCFADEA952D17AC2A47A9D6D5E42
      1CA9F18749566CDC064B95658CA3373AA364B2F983A5F74762B5EF20A28A95D3
      D1333236D3F301B788830618DDDB03D9B3651294F294634DA8E139464C711C91
      6CC9E5364546AC7F0318AABE2B9CDA76F35831B8D514D14DD5A6CDF210A2D2DA
      A0D62FDE44458DE64DE8DC8E6EDB7100D361D5BE2A635DFBDB77C6CEA89DE446
      6893D0941D939F01A957470910D487F475586AB045A4BEB6C71ECDBB362CDB4B
      56ACDBA3C1B56ACA68894A53A6888889F05905964581441ED5E24922FDC4B166
      C58193EB24117D57BA894A73555D3B389043F1D4C6D6F033B36544D81F1FE0E7
      710E83B4BB26A948B36CCA88E10E654B7525C1CAB0CE8FEEA1949A100D9D75E1
      CA3D95B21DBC6D81AB36A21AF6EB89EF38C6B1C20F45FEF06B362BACA9FF0026
      1F42D1697C67A24916C149E30A386ABA795A231B51DBDCF329516CF1827A978E
      DB431E378B5FAD12B5FB5792E495B74318AA40EAF1D07BE5A164D28A9607BAA9
      A70CB91FDE4193EACCB231BA7329DBFE1B39F6398C43BF4FC64126D916B09AA7
      D35454AF9D86C1A3F40D572520DB3C32629C178BE1388B1CC76D5343342E011E
      6B8B3005734A1092A9059C40A828F3AAB4951445FEF124D5CEF2AAAAEBF05119
      0B71B9B719E14858A845343F6489932C547348152AABD9CD5ED73AD96F8F5553
      DDEE8C2A124DF5D74B2BD9C3B44B6538A66BBA6968CB7C51720CAEB2710E1DB4
      42256885068F209F93A536EDF9C756A62A4944F983B87668CE59B4E8C62771B9
      77C1C0F88692E01896D0AA952746EAD019CE1209A53A55DB2172755454D5153C
      A36C3F1FC4A4D3896BE1282B2C6620C2E926913C128A8BD334B3B282E0E2694B
      DBA59A6A5D386A90E4480C7B6878D8EF04ABAFFB803890A7179BD57EB1ECAC4A
      C34B8CC4670A5535E9DED18917B3C6E19E559F6C48F7A3938051CABA564FB74C
      6B1186E34D5AADF69C3B1A3AA08F097454E9E44E4FE2E9FA145E19E158F21D17
      824323E2F42C11185C79AA2D1B65028F8C823547D9026F6D6F1294FD0D8B094E
      BF0554F1B94DC7E18C24320AA50A3644C87198EBDB9D9D11151823A69D4BFBF1
      7AFE840189A974ECE1C5AF6ECC59577752F1A9BD6C32632C04E2AC617881AA5F
      AA9D37C861012EA29B8BD97DBE32E6369E75D787561C327E3ADA1418C5BE2DBB
      18AD8BED4E46BEDEBAA20CE991320A3AF48672E44B235B113C193FCE395721E5
      F9D1C9DD2A5D92E67209BC86F59E6883ABBC99C5C8F41517B2C77BBBA79BC9D0
      D5B6EDB7E68CDA5291D312463CC71279234B7DE5F8C9ED890001571F6417969E
      31450F4A73E7C3738E6CAB106D462E4D562F9693F988D3D9F20552222A8510C6
      1F691B3ADD34FABB83DB5AFE2E1B5E772D923306EBA48278374E66B877EC5715
      18A9AEA891C851CE39029E7E897F2E3ECB6D9B6F788F0834D635A18FFD9F4258
      989D5E528E69548A442034486506AFF387128A217D3F047C7AE8A7FCE54FDF4E
      0CB79EF771B78C52E01A2788C130CB90B6A95575A53A74C2452A7A5909C62AA7
      D0D816AABD5C1C2C066D977730F43A785682C358B9CC068EBD117E29121CB476
      356EA81F8DCC803AC4F425DE1C1BB6A9B33C6D8FACFCEDB02519C66EFF00931C
      0845EC2FEC9C2D31B37B2969AFD02B9B9D3EBE0E6D98EF0E798F22A6F8D6D223
      80ECB660F69B63D7FAC875BBE3D0DAA62F21AA799C1D0BE1C1F646F6ED207C75
      2BAA73787A7029D5D1C09ABE2A9059C75CACC309D6AF9552AAE9E47D918B3166
      43C8EE955D4B68D70184C9A607F8CBFE2F48C40391A8BE9F8BC0B721DB0ECD51
      E0885A110FCBADED38347B43A2EA84AA6677A8399588BAAA6B629AB5E0233376
      6BDB760A68217EB6200F130CAB370D39AE88CECAC31D8894ABEA7EE033370DB9
      7DC067073193C4BCDD0B021B8561CE17FB1692DAD41C912EE9135FE4EFA2AF0D
      E4E34D8FE1A747C0152F5993E59692F38492C9C9CBDA41BAE5D709AAB29DCB4D
      5B9054F5700B3B134B6B2B4B78C8280D6D000A00018E8BDE41C40C2A290C3179
      762269F03137334EE2B05E22A0344EABF6999660706F0754EC25250FAD8B4E9C
      116E4DBEEC572028755FABE2F6C9E662F1EFFA052F17C5266DB57F58E5C123E3
      5836E7735B9D094F4A4324022F0E8DDFD139F52EB369C363F87CFF0035A89E09
      13006C46171BEE2E80BF65CCC2FB31F19157BBD4951685C56108169DBE0FB54A
      4F5F05DA8A64FC3F818536AF0EA1F116198C9376C0CBCFBA21D976ACB2E41D68
      BCBC6427A8F455C154E74DE56E3724B7B822F8F1A7DCB13148753A72FAA42817
      10220127F10253C77EBAEBAFD75AAFEFAEBDBC767E54FDFE3E45C5FF0054BFDF
      E3E258BD57FAAABF7978A3ECDE329FC812E7D1FB121B2075EF73D3F90B7D7C51
      441B65DBB099ADDFA3FB2DB78CB6FCB73FEA7899C8BC59564F77C6E583F1975A
      7ED6408A80F62EBD936AA39D37E1D38B37EBD9F0F140AFF3EB25B9D36F8D7E0F
      AD5A82CA8E4FFC913F9AF16D65324DAA62E17F49F6BB2BC9DD8E4D575D2C0B8F
      71BCD1BEAE5FD2938B1565ADFC63689E9C8A1F1EE1493CFF00D7A0A6C966F8DB
      F28DC5A5CABBBCDCBCD6BA3F58482B2E31C7166EF3EC457C62C955D289F8F8B3
      7A4786729669207FA0BB93F354F2CD95BDCFE3161E323B1BB79C9CB5EEDF1947
      F57035CC69B0CDADB31E1FEAAF8EB87E1D319559F4AA4AE68048A42BFD6B8159
      E38C6D0C0D61DB5B62B5B1B608D6009A27C91430A8B610BF7913E0ABA3116ADD
      E1EF5B5B776CDDA12F59BB6575454AA95E4A8A8BE7E2BB8F9B78C20F35DCFA5A
      9D314C10E5BBF7FAB63AF555E2AF6BECA369AEAB73E93DA3B78C4676BF84B89D
      7CB8AEB27DDD7B1C22BAFB548DA8607BBF92A82AA71AD7EEDFD8C53EAB1B55C2
      037FC4E0F47A78EFFF00FCE5D95F7FFF00D6DC4A9DBDBFF8574E35B5EEE1D8CA
      7F1FB54C224FE42E0F5F1F54F77C6C947F4783B59C2167FF00560DC7D4F631B3
      F17CFF0031B69C3567FBD0AE28FB39B63DBFC7BC25D6DFB130DE396BFC5D1305
      1AF147D9D87C59856DFD1FB1985A9B397A9420E85E35F0ADFE0B68BFBFA71F12
      9A695F527DD9FFD90000B693000006004D656D6F3435000200B0000000920300
      0056000000120000000100000001000000000000000000FFFFFF1F2E02000000
      000001001800B5DA5B50414745235D2F5B544F54414C50414745535DD2B30000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000090000008600020000000000FFFFFF000000000200000000000000FEFE
      FF060000000A00205661726961626C6573000000000200736C0014006364735F
      436867426F64792E22534C30303030220002006A650014006364735F43686742
      6F64792E224A4530303030220004006B68796800000000040079687A68000000
      000200647A000000000000000000000000FDFF0100000000}
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
