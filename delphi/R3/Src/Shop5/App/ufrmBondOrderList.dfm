inherited frmBondOrderList: TfrmBondOrderList
  Left = 322
  Top = 138
  Width = 908
  Height = 600
  Caption = #20445#35777#37329#31649#29702
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 900
    Height = 536
    inherited RzPanel2: TRzPanel
      Width = 890
      Height = 526
      inherited RzPage: TRzPageControl
        Width = 884
        Height = 520
        ActivePage = TabSheet2
        TabIndex = 1
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #20445#35777#37329#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 882
            Height = 493
            BorderInner = fsStatus
            object RzPanel6: TRzPanel
              Left = 6
              Top = 6
              Width = 870
              Height = 99
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object Label3: TLabel
                Left = 24
                Top = 53
                Width = 48
                Height = 12
                Caption = #38376#24215#21517#31216
              end
              object RzLabel2: TRzLabel
                Left = 24
                Top = 31
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36134#27454#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 186
                Top = 31
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label2: TLabel
                Left = 24
                Top = 76
                Width = 48
                Height = 12
                Caption = #23458#25143#21517#31216
              end
              object Label7: TLabel
                Left = 24
                Top = 10
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #36134#27454#31867#22411
              end
              object P1_D1: TcxDateEdit
                Left = 80
                Top = 27
                Width = 97
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object P1_D2: TcxDateEdit
                Left = 205
                Top = 27
                Width = 98
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object btnOk: TRzBitBtn
                Left = 451
                Top = 58
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
              object fndP1_SHOP_ID: TzrComboBoxList
                Tag = -1
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
                Height = 89
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
                TabOrder = 4
                Caption = #29366#24577
              end
              object fndP1_CUST_ID: TzrComboBoxList
                Left = 80
                Top = 71
                Width = 223
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
              object P1_BOND_TYPE: TcxComboBox
                Left = 80
                Top = 5
                Width = 131
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsFixedList
                TabOrder = 6
              end
            end
            object Panel1: TPanel
              Left = 6
              Top = 105
              Width = 870
              Height = 382
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 868
                Height = 380
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
                    FieldName = 'CUST_ID_TEXT'
                    Footers = <>
                    Title.Caption = #23458#25143#21517#31216
                    Width = 139
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GLIDE_NO'
                    Footers = <>
                    Title.Caption = #27969#27700#21495
                    Width = 157
                  end
                  item
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'ACCT_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #21512#35745#37329#39069
                    Width = 61
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'BOND_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #30003#39046#37329#39069
                    Width = 61
                  end
                  item
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'RECK_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #32467#20313#37329#39069
                    Width = 61
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'DEPT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #25152#23646#37096#38376
                    Width = 95
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID_TEXT'
                    Footers = <>
                    Title.Caption = #25152#23646#38376#24215
                    Width = 99
                  end>
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #30003#39046#21333#26597#35810
          object RzPanel1: TRzPanel
            Left = 0
            Top = 0
            Width = 882
            Height = 493
            Align = alClient
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object RzPanel7: TRzPanel
              Left = 6
              Top = 6
              Width = 870
              Height = 123
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object RzLabel4: TRzLabel
                Left = 24
                Top = 30
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #30003#39046#26085#26399
              end
              object RzLabel5: TRzLabel
                Left = 186
                Top = 30
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
              object Label17: TLabel
                Left = 24
                Top = 72
                Width = 48
                Height = 12
                Caption = #23458#25143#21517#31216
              end
              object Label40: TLabel
                Left = 24
                Top = 51
                Width = 48
                Height = 12
                Caption = #25152#23646#38376#24215
              end
              object Label1: TLabel
                Left = 24
                Top = 10
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #30003#39046#31867#22411
              end
              object D1: TcxDateEdit
                Left = 80
                Top = 26
                Width = 97
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 205
                Top = 26
                Width = 98
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
                Left = 332
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
              object fndBOND_USER: TzrComboBoxList
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
              object fndCLIENT_ID: TzrComboBoxList
                Left = 80
                Top = 68
                Width = 223
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
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 47
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
              object P2_BOND_TYPE: TcxComboBox
                Left = 80
                Top = 5
                Width = 131
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsFixedList
                TabOrder = 7
              end
            end
            object Panel2: TPanel
              Left = 6
              Top = 129
              Width = 870
              Height = 358
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh2: TDBGridEh
                Left = 1
                Top = 1
                Width = 868
                Height = 356
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
                    Title.Caption = #30003#39046#21333#21495
                    Width = 77
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BOND_DATE'
                    Footer.Value = #21512'   '#35745#65306
                    Footers = <>
                    Title.Caption = #30003#39046#26085#26399
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
                    FieldName = 'BOND_MNY'
                    Footers = <>
                    Title.Caption = #30003#39046#37329#39069
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Caption = #35828#26126
                    Width = 129
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'BOND_USER_TEXT'
                    Footers = <>
                    Title.Caption = #21046#21333#20154
                    Width = 60
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
    Width = 900
    inherited Image3: TImage
      Left = 374
      Width = 0
    end
    inherited Image14: TImage
      Left = 880
    end
    inherited Image1: TImage
      Left = 374
      Width = 506
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
          Caption = #30003#39046
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
  end
  object DataSource2: TDataSource
    DataSet = cdsList
    Left = 429
    Top = 234
  end
  object frfBondOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfBondOrderGetValue
    OnUserFunction = frfBondOrderUserFunction
    Left = 176
    Top = 233
    ReportForm = {
      18000000B51B0000180000FFFF01000100FFFFFFFFFF00010000340800007805
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
      0100000000000000002203000006004D656D6F33320002001702000032000000
      36000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000500B5A5BAC53A00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000110000008600020000000000FFFFFF0000
      000002000000000000000000AA03000006004D656D6F31340002002C020000BE
      000000480000001300000001000F0001000000000000000000FFFFFF1F2E0200
      0000000001000A005B424F4E445F4D4E595D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000090000008600020000
      000000FFFFFF00000000020000000000000000003704000006004D656D6F3138
      0002009E000000BE000000FE0000001300000001000F00010000000000000000
      00FFFFFF1F2E02000000000001000F005B52454D41524B5F44455441494C5D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000080000008600020000000000FFFFFF00000000020000000000000000
      00C404000005004D656D6F390002007B00000032000000DE0000001200000001
      00020001000000000000000000FFFFFF1F2E020000000000010010005B434C49
      454E545F49445F544558545D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000080000008600020000000000FFFFFF
      00000000020000000000000000004D05000006004D656D6F3430000200A00100
      003200000076000000120000000100020001000000000000000000FFFFFF1F2E
      02000000000001000B005B424F4E445F444154455D00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000080000008600
      020000000000FFFFFF0000000002000000000000000000D505000006004D656D
      6F32330002009C010000BE000000480000001300000001000F00010000000000
      00000000FFFFFF1F2E02000000000001000A005B414343545F4D4E595D000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000090000008600020000000000FFFFFF00000000020000000000000000005D
      06000006004D656D6F35380002004E020000320000006C000000120000000100
      020001000000000000000000FFFFFF1F2E02000000000001000A005B474C4944
      455F4E4F5D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000080000008600020000000000FFFFFF00000000020000
      00000000000000E406000005004D656D6F33000200E4010000BE000000480000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      0A005B5245434B5F4D4E595D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000090000008600020000000000FFFFFF
      00000000020000000000000000007707000005004D656D6F3200020035000000
      1900000085020000180000000100000001000000000000000500FFFFFF1F2E02
      0000000000010016005BC6F3D2B5C3FBB3C65DB1A3D6A4BDF0C9EAC1ECB5A500
      000000FFFF00000000000200000001000000000400CBCECCE500100000000200
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00FE07000006004D656D6F313200020035000000320000004600000012000000
      0100000001000000000000000000FFFFFF1F2E02000000000001000900BEAD20
      CFFA20C9CC3A00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000020000000000080000008600020000000000FFFFFF000000000200
      00000000000000008608000006004D656D6F31330002005B0100003200000044
      000000120000000100000001000000000000000000FFFFFF1F2E020000000000
      01000A00CCEEB1A8C8D5C6DAA3BA00000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000020000000000080000008600020000000000FF
      FFFF00000000020000000000000000000C09000006004D656D6F33340002002C
      02000070000000480000001600000001000F0001000000000000000000FFFFFF
      1F2E02000000000001000800B1BEB4CEC9EAC1EC00000000FFFF000000000002
      00000001000000000400CBCECCE5000A0000000200000000000A000000860002
      0000000000FFFFFF00000000020000000000000000009209000006004D656D6F
      3337000200E401000070000000480000001600000001000F0001000000000000
      000000FFFFFF1F2E02000000000001000800CEB4C1ECBDF0B6EE00000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000200000000000A
      0000008600020000000000FFFFFF0000000002000000000000000000180A0000
      06004D656D6F33380002009C01000070000000480000001600000001000F0001
      000000000000000000FFFFFF1F2E02000000000001000800D5CBBFEED7DCB6EE
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      0000F90A000006004D656D6F32350002003500000012010000B2010000130000
      0001000E0001000000000000000000FFFFFF1F2E02000000000001006300C9EA
      C1ECBACFBCC6A3BA5B536D616C6C546F426967285B544F54414C5F424F4E445F
      4D4E595D295D2020A3A43A5B666F726D6174466C6F6174282723302E3030272C
      5B544F54414C5F424F4E445F4D4E595D295D2020202020202020202020202020
      2000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      020000000000080000008600020000000000FFFFFF0000000002000000000000
      0000007B0B000006004D656D6F34350002009E00000070000000FE0000001600
      000001000F0001000000000000000000FFFFFF1F2E02000000000001000400D5
      AAD2AA00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      00000200000000000A0000008600020000000000FFFFFF000000000200000000
      0000000000000C000006004D656D6F353400020035000000BE0000001B000000
      1300000001000F0001000000000000000000FFFFFF1F2E020000000000010007
      005B5345514E4F5D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000000000000000A0000008600020000000000FFFFFF00000000
      02000000000000000000820C000006004D656D6F353500020035000000700000
      001B0000001600000001000F0001000000000000000000FFFFFF1F2E02000000
      000001000400D0F2BAC500000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF0000
      000002000000000000000000180D000006004D656D6F32340002007A02000019
      00000056000000120000000100000001000000000000000000FFFFFF1F2E0200
      0000000001001800B5DA5B50414745235D2F5B544F54414C50414745535DD2B3
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000090000008600020000000000FFFFFF000000000200000000000000
      0000A40D000006004D656D6F32360002007B00000046000000DE000000120000
      000100020001000000000000000000FFFFFF1F2E02000000000001000E005B53
      484F505F49445F544558545D00000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000080000008600020000000000FFFFFF
      00000000020000000000000000002B0E000006004D656D6F3237000200350000
      004600000046000000120000000100000001000000000000000000FFFFFF1F2E
      02000000000001000900C9EAB1A8C3C5B5EA3A00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000086000200
      00000000FFFFFF0000000002000000000000000000B90E000006004D656D6F32
      38000200A0010000460000007600000012000000010002000100000000000000
      0000FFFFFF1F2E020000000000010010005B424F4E445F545950455F54455854
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000080000008600020000000000FFFFFF0000000002000000000000
      000000400F000006004D656D6F32390002005A01000046000000460000001200
      00000100000001000000000000000000FFFFFF1F2E02000000000001000900B7
      D1D3C3C0E0D0CD3A00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      02000000000000000000D50F000005004D656D6F31000200370000002A010000
      7C000000140000000100000001000000000000000000FFFFFF1F2E0200000000
      0001001800D6C6B5A5C8CBA3BA5B435245415F555345525F544558545D000000
      00010000000000000200000001000000000400CBCECCE5000A00000002000000
      0000080000008600020000000000FFFFFF0000000002000000000000000000B4
      10000006004D656D6F3539000200C00200005C000000180000002A0100000300
      000001000000000000000000FFFFFF1F2E02000000000007000900B0D7C1AAB4
      E6B8F9200D00000D1E0020202020202020202020202020202020202020202020
      20202020202020200D0C00BAECC1AABEADCFFAC9CC20200D00000D1400202020
      20202020202020202020202020202020200D0800BBC6C1AABDE1CBE300000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      00000000000100020000000000FFFFFF00000000020000000000000000003011
      000006004D656D6F36300002002C020000E8000000480000001300000001000F
      0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF0000000002000000000000000000AC1100000600
      4D656D6F36310002009E000000E8000000FE0000001300000001000F00010000
      00000000000000FFFFFF1F2E020000000000000000000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000009000000860002
      0000000000FFFFFF00000000020000000000000000002812000006004D656D6F
      36330002009C010000E8000000480000001300000001000F0001000000000000
      000000FFFFFF1F2E020000000000000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000A00000086000200000000
      00FFFFFF0000000002000000000000000000A412000006004D656D6F36340002
      00E4010000E8000000480000001300000001000F0001000000000000000000FF
      FFFF1F2E020000000000000000000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000090000008600020000000000FFFFFF
      00000000020000000000000000002013000006004D656D6F3635000200350000
      00E80000001B0000001300000001000F0001000000000000000000FFFFFF1F2E
      020000000000000000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000000000000000A0000008600020000000000FFFFFF00000000
      02000000000000000000D213000005004D656D6F35000200E701000012010000
      D40000001300000003000B0001000000000000000000FFFFFF1F2E0200000000
      0001003500B1BED2B3D0A1BCC6A3BAA3A43A5B666F726D6174466C6F61742827
      23302E3030272C5B73756D285B524551555F4D4E595D295D295D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000009
      0000000100020000000000FFFFFF000000000200000000000000000060140000
      06004D656D6F31350002004E020000460000006C000000120000000100020001
      000000000000000000FFFFFF1F2E020000000000010010005B424F4E445F5553
      45525F544558545D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000080000008600020000000000FFFFFF00000000
      02000000000000000000E514000006004D656D6F313600020017020000460000
      0036000000120000000100000001000000000000000000FFFFFF1F2E02000000
      000001000700CCEEB1A8C8CB3A00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000020000000000090000008600020000000000FFFF
      FF00000000020000000000000000007815000005004D656D6F34000200370000
      004B01000014010000120000000300000001000000000000000000FFFFFF1F2E
      02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D205B54494D455D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000000000000100020000000000FFFFFF000000000200000000000000
      00000316000005004D656D6F360002007A0000005B0000009D00000012000000
      0100020001000000000000000000FFFFFF1F2E02000000000001000E005B4445
      50545F49445F544558545D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000008600020000000000FFFFFF00
      000000020000000000000000008A16000006004D656D6F313700020035000000
      5B00000046000000120000000100000001000000000000000000FFFFFF1F2E02
      000000000001000900CBF9CAF4B2BFC3C53A00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000008600020000
      000000FFFFFF00000000020000000000000000001F17000006004D656D6F3139
      000200C40000002A0100007C0000001400000001000000010000000000000000
      00FFFFFF1F2E02000000000001001700C9F3BACBC8CBA3BA5B43484B5F555345
      525F544558545D00000000010000000000000200000001000000000400CBCECC
      E5000A0000000200FFFFFF1F080000008600020000000000FFFFFF0000000002
      000000000000000000A217000006004D656D6F32310002001A0100005B000000
      27000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000500B1B8D7A23A00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000080000008600020000000000FFFFFF0000
      0000020000000000000000002818000006004D656D6F3335000200410100005B
      0000007A010000120000000100020001000000000000000000FFFFFF1F2E0200
      00000000010008005B52454D41524B5D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000800000086000200000000
      00FFFFFF0000000002000000000000000000AD18000005004D656D6F37000200
      50000000700000004E0000001600000001000F0001000000000000000000FFFF
      FF1F2E02000000000001000800D5CBBFEEC8D5C6DA00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000200000000000A0000008600
      020000000000FFFFFF00000000020000000000000000003519000005004D656D
      6F3800020050000000BE0000004E0000001300000001000F0001000000000000
      000000FFFFFF1F2E02000000000001000B005B424F4E445F444154455D000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000090000008600020000000000FFFFFF0000000002000000000000000000B1
      19000006004D656D6F313000020050000000E80000004E000000130000000100
      0F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000900
      00008600020000000000FFFFFF0000000002000000000000000000371A000006
      004D656D6F31310002007402000070000000480000001600000001000F000100
      0000000000000000FFFFFF1F2E02000000000001000800BDE1D3E0BDF0B6EE00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00BF1A000006004D656D6F323000020074020000BE0000004800000013000000
      01000F0001000000000000000000FFFFFF1F2E02000000000001000A005B4241
      4C415F4D4E595D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000090000008600020000000000FFFFFF0000000002
      0000000000000000003B1B000006004D656D6F323200020074020000E8000000
      480000001300000001000F0001000000000000000000FFFFFF1F2E0200000000
      00000000000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000090000008600020000000000FFFFFF000000000200000000
      000000FEFEFF060000000A00205661726961626C6573000000000200736C0014
      006364735F436867426F64792E22534C30303030220002006A65001400636473
      5F436867426F64792E224A4530303030220004006B6879680000000004007968
      7A68000000000200647A000000000000000000000000FDFF0100000000}
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
