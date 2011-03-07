inherited frmTransOrderList: TfrmTransOrderList
  Left = 270
  Top = 97
  Width = 906
  Height = 587
  Caption = #23384#21462#27454#21333
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 898
    Height = 530
    inherited RzPanel2: TRzPanel
      Width = 888
      Height = 520
      inherited RzPage: TRzPageControl
        Width = 882
        Height = 514
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #23384#21462#27454#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 880
            Height = 487
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 870
              Height = 117
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object LabTRANS_DATE: TLabel
                Left = 27
                Top = 11
                Width = 48
                Height = 12
                Caption = #23384#21462#26085#26399
              end
              object Label1: TLabel
                Left = 182
                Top = 11
                Width = 12
                Height = 12
                Caption = #33267
              end
              object LabIN_ACCOUNT_ID: TLabel
                Left = 27
                Top = 53
                Width = 48
                Height = 12
                Caption = #23384#27454#36134#21495
              end
              object LabOUT_ACCOUNT_ID: TLabel
                Left = 27
                Top = 74
                Width = 48
                Height = 12
                Caption = #21462#27454#36134#21495
              end
              object LabTRANS_USER: TLabel
                Left = 38
                Top = 95
                Width = 36
                Height = 12
                Caption = #36127#36131#20154
              end
              object Label40: TLabel
                Left = 26
                Top = 31
                Width = 48
                Height = 12
                Caption = #23384#21462#38376#24215
              end
              object TRANS_DATE1: TcxDateEdit
                Left = 80
                Top = 7
                Width = 97
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object TRANS_DATE2: TcxDateEdit
                Left = 200
                Top = 7
                Width = 97
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndIN_ACCOUNT_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 49
                Width = 217
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
                FilterFields = 'ACCOUNT_ID;ACCT_NAME;ACCT_SPELL'
                KeyField = 'ACCOUNT_ID'
                ListField = 'ACCT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_ID'
                    Footers = <>
                    Title.Caption = #32534#21495
                    Width = 40
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = False
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndOUT_ACCOUNT_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 70
                Width = 217
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
                FilterFields = 'ACCT_ID;ACCT_NAME;ACCOUNT_SPELL'
                KeyField = 'ACCOUNT_ID'
                ListField = 'ACCT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_ID'
                    Footers = <>
                    Title.Caption = #32534#21495
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = False
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndTRANS_USER: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 91
                Width = 89
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
                FilterFields = 'USER_ID;USER_NAME;USER_SPELL'
                KeyField = 'USER_ID'
                ListField = 'USER_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCOUNT'
                    Footers = <>
                    Title.Caption = #36134#21495
                    Width = 20
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #21517'  '#31216
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = False
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndQuery: TRzBitBtn
                Left = 437
                Top = 79
                Width = 67
                Height = 28
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
              object fndOrderStatus: TcxRadioGroup
                Left = 321
                Top = 22
                Width = 105
                Height = 88
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
                TabOrder = 6
                Caption = ''
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 28
                Width = 217
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
                ShowButton = False
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            object RzPanel6: TRzPanel
              Left = 5
              Top = 122
              Width = 870
              Height = 360
              Align = alClient
              BorderOuter = fsNone
              Color = clWhite
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 0
                Top = 0
                Width = 870
                Height = 360
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = Dsc_1
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
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                TitleHeight = 20
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                Columns = <
                  item
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'SEQ_NO'
                    Footers = <>
                    ReadOnly = True
                    Title.Alignment = taCenter
                    Title.Caption = #24207#21495
                    Width = 32
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GLIDE_NO'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #27969#27700#21495
                    Width = 100
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'TRANS_DATE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #36716#36134#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'IN_ACCOUNT_ID'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23384#27454#36134#21495
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'OUT_ACCOUNT_ID'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #21462#27454#36134#21495
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TRANS_MNY'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23384#21462#37329#39069
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TRANS_USER_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #36127#36131#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #35828'    '#26126
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_USER_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23457#26680#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_DATE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23457#26680#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_USER_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #21046#21333#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_DATE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #21046#21333#26102#38388
                    Width = 120
                  end>
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 898
    inherited Image1: TImage
      Left = 530
      Width = 359
    end
    inherited Image14: TImage
      Left = 889
    end
    inherited Image3: TImage
      Left = 530
      Width = 359
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#23384#21462#27454#21333
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
          Width = 30
        end>
      inherited ToolBar1: TToolBar
        Width = 354
        ButtonHeight = 30
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
          Caption = #20462#25913
        end
        object ToolButton3: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
          Caption = #35814#24773
          ImageIndex = 0
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
          ImageIndex = 36
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
          OnClick = ToolButton8Click
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
    Left = 464
    Top = 48
  end
  inherited actList: TActionList
    Left = 656
    Top = 64
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
  object cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    AfterScroll = cdsListAfterScroll
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 470
    Top = 84
  end
  object Dsc_1: TDataSource
    DataSet = cdsList
    Left = 502
    Top = 85
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    Left = 550
    Top = 88
    ReportForm = {18000000}
  end
end
