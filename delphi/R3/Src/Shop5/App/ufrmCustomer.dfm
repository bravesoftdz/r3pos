inherited frmCustomer: TfrmCustomer
  Left = 501
  Top = 154
  Width = 805
  Height = 534
  Caption = #20250#21592#26723#26696#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 797
    Height = 477
    inherited RzPanel2: TRzPanel
      Width = 787
      Height = 467
      inherited RzPage: TRzPageControl
        Width = 781
        Height = 461
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #20250#21592#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 779
            Height = 434
            object RzPanel6: TRzPanel
              Left = 5
              Top = 5
              Width = 769
              Height = 108
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              DesignSize = (
                769
                108)
              object Label1: TLabel
                Left = 19
                Top = 69
                Width = 377
                Height = 12
                Caption = #25903#25345#65288#20250#21592#21495#12289#20648#20540#21345#21495#12289#25340#38899#30721#12289#21517#31216#12289#31227#21160#30005#35805#65289#20851#20581#23383#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label3: TLabel
                Left = 20
                Top = 90
                Width = 60
                Height = 12
                Alignment = taRightJustify
                Caption = #26597#35810#20851#38190#23383
              end
              object Label4: TLabel
                Left = 242
                Top = 25
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20250#21592#29983#26085
              end
              object Label5: TLabel
                Left = 424
                Top = 25
                Width = 12
                Height = 12
                Caption = #21040
              end
              object RzLabel22: TRzLabel
                Left = 6
                Top = 24
                Width = 63
                Height = 12
                Alignment = taRightJustify
                AutoSize = False
                Caption = #20837#20250#38376#24215
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzLabel2: TRzLabel
                Left = 227
                Top = 4
                Width = 63
                Height = 12
                Alignment = taRightJustify
                AutoSize = False
                Caption = #20837#20250#26085#26399
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzLabel14: TRzLabel
                Left = 17
                Top = 4
                Width = 52
                Height = 12
                Alignment = taRightJustify
                AutoSize = False
                Caption = #20250#21592#31561#32423
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 424
                Top = 4
                Width = 12
                Height = 12
                Caption = #21040
              end
              object Bevel1: TBevel
                Left = 410
                Top = 74
                Width = 354
                Height = 2
                Anchors = [akLeft, akTop, akRight]
              end
              object RzLabel4: TRzLabel
                Left = 218
                Top = 46
                Width = 72
                Height = 12
                Alignment = taRightJustify
                Caption = #21487#29992#31215#20998#22823#20110
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label40: TLabel
                Left = 21
                Top = 44
                Width = 48
                Height = 12
                Caption = #20250#21592#31867#21035
              end
              object edtKey: TcxTextEdit
                Left = 90
                Top = 87
                Width = 196
                Height = 20
                TabOrder = 0
                OnKeyDown = edtKeyKeyDown
                OnKeyPress = edtKeyKeyPress
              end
              object btnOk: TRzBitBtn
                Left = 300
                Top = 85
                Width = 67
                Height = 24
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
              object edtDate1: TcxDateEdit
                Left = 299
                Top = 21
                Width = 117
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 7
              end
              object edtDate2: TcxDateEdit
                Left = 444
                Top = 21
                Width = 118
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 8
              end
              object cmbSHOP_ID: TzrComboBoxList
                Left = 79
                Top = 20
                Width = 111
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
                    Title.Caption = #20837#20250#21333#20301
                    Width = 111
                  end>
                DropWidth = 112
                DropHeight = 228
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object edtDate3: TcxDateEdit
                Left = 299
                Top = 0
                Width = 117
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 5
              end
              object cmbPRICE_ID: TzrComboBoxList
                Left = 79
                Top = 0
                Width = 111
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 1
                InGrid = False
                KeyValue = Null
                FilterFields = 'PRICE_ID;PRICE_NAME;PRICE_SPELL'
                KeyField = 'PRICE_ID'
                ListField = 'PRICE_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'PRICE_NAME'
                    Footers = <>
                    Title.Caption = #31561#32423#21517#31216
                    Width = 111
                  end>
                DropWidth = 112
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = False
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object edtDate4: TcxDateEdit
                Left = 444
                Top = 0
                Width = 118
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 6
              end
              object fndINTEGRAL: TcxTextEdit
                Left = 299
                Top = 42
                Width = 117
                Height = 20
                TabOrder = 3
                OnKeyDown = edtKeyKeyDown
              end
              object fndSORT_ID: TzrComboBoxList
                Tag = -1
                Left = 79
                Top = 40
                Width = 111
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
                FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
                KeyField = 'CODE_ID'
                ListField = 'CODE_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CODE_NAME'
                    Footers = <>
                    Title.Caption = #31867#21035#21517#31216
                    Width = 111
                  end>
                DropWidth = 112
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
            object RzPanel1: TRzPanel
              Left = 5
              Top = 113
              Width = 769
              Height = 316
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 5
                Top = 5
                Width = 759
                Height = 287
                Align = alClient
                DataSource = Ds_Customer
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FrozenCols = 2
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
                PopupMenu = PopupMenu1
                RowHeight = 20
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
                OnDblClick = actEditExecute
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnGetCellParams = DBGridEh1GetCellParams
                OnKeyPress = DBGridEh1KeyPress
                OnTitleClick = DBGridEh1TitleClick
                Columns = <
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'selflag'
                    Footers = <>
                    Tag = -1
                    Title.Caption = #36873#25321
                    Width = 26
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #24207#21495
                    Width = 30
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CUST_CODE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20250#21592#21495
                    Width = 74
                  end
                  item
                    EditButtons = <>
                    FieldName = 'IC_CARDNO'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20648#20540#21345#21495
                    Width = 86
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CUST_NAME'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20250#21592#21517#31216
                    Width = 84
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID'
                    Footers = <>
                    Title.Caption = #20837#20250#38376#24215
                    Width = 87
                  end
                  item
                    Alignment = taCenter
                    EditButtons = <>
                    FieldName = 'SEX'
                    Footers = <>
                    KeyList.Strings = (
                      '0'
                      '1'
                      '2')
                    PickList.Strings = (
                      #22899
                      #30007
                      #20445#23494)
                    ReadOnly = True
                    Title.Caption = #24615#21035
                    Width = 43
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'MOVE_TELE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #31227#21160#30005#35805
                    Width = 89
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'BIRTHDAY'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #29983#26085
                    Width = 73
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PRICE_ID'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20250#21592#31561#32423
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SORT_ID'
                    Footers = <>
                    Title.Caption = #20250#21592#31867#21035
                    Width = 70
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'BALANCE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20313#39069
                    Width = 59
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'ACCU_INTEGRAL'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #32047#35745#31215#20998
                    Width = 58
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'RULE_INTEGRAL'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20351#29992#31215#20998
                    Width = 59
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'INTEGRAL'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21487#29992#31215#20998
                    Width = 55
                  end
                  item
                    EditButtons = <>
                    FieldName = 'FAMI_ADDR'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #22320#22336
                    Width = 279
                  end>
              end
              object stbPanel: TPanel
                Left = 5
                Top = 292
                Width = 759
                Height = 19
                Align = alBottom
                BevelOuter = bvNone
                Color = clWhite
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object Label2: TLabel
                  Left = 4
                  Top = 8
                  Width = 7
                  Height = 12
                end
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 797
    inherited Image1: TImage
      Left = 622
      Width = 166
    end
    inherited Image14: TImage
      Left = 788
    end
    inherited Image3: TImage
      Left = 622
      Width = 166
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #20250#21592#26723#26696
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 446
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 446
          Width = 30
        end>
      inherited ToolBar1: TToolBar
        Width = 446
        ButtonHeight = 30
        ButtonWidth = 43
        object But_Add: TToolButton
          Left = 0
          Top = 0
          Action = actNew
        end
        object But_Edit: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
          Caption = #20462#25913
        end
        object But_Info: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
          Caption = #35814#32454
        end
        object But_Delete: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton2: TToolButton
          Left = 172
          Top = 0
          Width = 3
          Caption = 'ToolButton2'
          ImageIndex = 3
          Style = tbsDivider
        end
        object ToolButton1: TToolButton
          Left = 175
          Top = 0
          Action = actfrmIntegral
          Visible = False
        end
        object ToolButton3: TToolButton
          Left = 218
          Top = 0
          Caption = #20648#20540#21345
          DropdownMenu = PopupMenu2
          ImageIndex = 24
          Style = tbsDropDown
          Visible = False
          OnClick = ToolButton3Click
        end
        object ToolButton5: TToolButton
          Left = 274
          Top = 0
          Action = actRenew
          Visible = False
        end
        object But_Print: TToolButton
          Left = 317
          Top = 0
          Action = actPrint
        end
        object But_Preview: TToolButton
          Left = 360
          Top = 0
          Action = actPreview
        end
        object But_Exit: TToolButton
          Left = 403
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 88
    Top = 351
  end
  inherited actList: TActionList
    Left = 280
    Top = 263
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
    object actfrmIntegral: TAction
      Caption = #20817#25442
      ImageIndex = 41
      OnExecute = actfrmIntegralExecute
    end
    object actNewCard: TAction
      Caption = #21457#26032#21345
      OnExecute = actNewCardExecute
    end
    object actCancelCard: TAction
      Caption = #27880#38144#21345
      OnExecute = actCancelCardExecute
    end
    object actDeposit: TAction
      Caption = #20805#20540
      OnExecute = actDepositExecute
    end
    object actPassword: TAction
      Caption = #20462#25913#23494#30721
      OnExecute = actPasswordExecute
    end
    object actReturn: TAction
      Caption = #36864#27454
      OnExecute = actReturnExecute
    end
    object actRenew: TAction
      Caption = #32493#20250
      ImageIndex = 37
      OnExecute = actRenewExecute
    end
  end
  object Ds_Customer: TDataSource
    DataSet = Cds_Customer
    Left = 215
    Top = 351
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 694
    Top = 67
    object N1: TMenuItem
      Action = actfrmIntegral
      Caption = #31215#20998#20817#25442
    end
    object N2: TMenuItem
      Caption = #21457#36865#30701#20449
      OnClick = N2Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #20840#36873
      ShortCut = 16449
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #20840#21453#36873
      ShortCut = 16450
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #20840#19981#36873
      ShortCut = 16452
      OnClick = N5Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = #26597#35810#25152#26377
      OnClick = N6Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 726
    Top = 67
    object N10: TMenuItem
      Action = actNewCard
    end
    object N11: TMenuItem
      Action = actPassword
    end
    object N13: TMenuItem
      Action = actDeposit
    end
    object N12: TMenuItem
      Action = actReturn
    end
    object N9: TMenuItem
      Action = actCancelCard
    end
  end
  object PrintDBGridEh1: TPrintDBGridEh
    Options = [pghFitGridToPageWidth]
    Page.BottomMargin = 2.000000000000000000
    Page.LeftMargin = 2.000000000000000000
    Page.RightMargin = 2.000000000000000000
    Page.TopMargin = 2.000000000000000000
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'MS Sans Serif'
    PageHeader.Font.Style = []
    Units = MM
    Left = 160
    Top = 256
  end
  object Cds_Customer: TZQuery
    FieldDefs = <>
    AfterScroll = Cds_CustomerAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 166
    Top = 352
  end
end
