inherited frmInvoice: TfrmInvoice
  Left = 364
  Top = 169
  Width = 863
  Height = 551
  Caption = #21457#31080#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 847
    Height = 476
    inherited RzPanel2: TRzPanel
      Width = 837
      Height = 466
      inherited RzPage: TRzPageControl
        Width = 831
        Height = 460
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #21457#31080#20449#24687#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 829
            Height = 433
            object RzPanel1: TRzPanel
              Left = 5
              Top = 121
              Width = 819
              Height = 307
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object DBGridEh1: TDBGridEh
                Left = 5
                Top = 5
                Width = 809
                Height = 278
                Align = alClient
                DataSource = Ds_Invoice
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                FrozenCols = 1
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
                PopupMenu = PopupMenu1
                ReadOnly = True
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
                OnDblClick = actInfoExecute
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnGetCellParams = DBGridEh1GetCellParams
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SEQ_NO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 30
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'CREA_DATE'
                    Footers = <>
                    Title.Caption = #39046#29992#26085#26399
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'INVH_NO'
                    Footers = <>
                    Title.Caption = #21457#31080#26412#21495
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'BEGIN_NO'
                    Footers = <>
                    Title.Caption = #21457#31080#36215#22987#21495
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'ENDED_NO'
                    Footers = <>
                    Title.Caption = #21457#31080#32456#27490#21495
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID'
                    Footers = <>
                    Title.Caption = #39046#29992#38376#24215
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_USER'
                    Footers = <>
                    Title.Caption = #39046#29992#20154
                    Width = 60
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'USING_AMT'
                    Footers = <>
                    Title.Caption = #24320#31080#24352#25968
                    Width = 60
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'TOTAL_AMT'
                    Footers = <>
                    Title.Caption = #21512#35745#24352#25968
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CANCEL_AMT'
                    Footers = <>
                    Title.Caption = #20316#24223#24352#25968
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BALANCE'
                    Footers = <>
                    Title.Caption = #32467#20313#24352#25968
                    Width = 60
                  end>
              end
              object stbPanel: TPanel
                Left = 5
                Top = 283
                Width = 809
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
            object RzPanel6: TRzPanel
              Left = 5
              Top = 5
              Width = 819
              Height = 116
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 1
              object Panel2: TPanel
                Left = 5
                Top = 5
                Width = 809
                Height = 106
                Align = alClient
                Alignment = taLeftJustify
                BevelInner = bvLowered
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentColor = True
                ParentFont = False
                TabOrder = 0
                object lab_SHOP_ID: TRzLabel
                  Left = 19
                  Top = 34
                  Width = 60
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #39046#29992#38376#24215
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel6: TRzLabel
                  Left = 20
                  Top = 57
                  Width = 60
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #39046#29992#20154
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object labCREA_DATE: TRzLabel
                  Left = 19
                  Top = 11
                  Width = 60
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #39046#29992#26085#26399
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label3: TLabel
                  Left = 32
                  Top = 80
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21457#31080#26412#21495
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel1: TRzLabel
                  Left = 182
                  Top = 11
                  Width = 20
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #21040
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label1: TLabel
                  Left = 181
                  Top = 81
                  Width = 126
                  Height = 12
                  Caption = #25903#25345#21457#31080#26412#21495#21518'4'#20301#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object edtKey: TcxTextEdit
                  Left = 85
                  Top = 76
                  Width = 95
                  Height = 20
                  ParentFont = False
                  Style.Font.Charset = GB2312_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -12
                  Style.Font.Name = #23435#20307
                  Style.Font.Style = []
                  TabOrder = 4
                  OnKeyDown = edtKeyKeyDown
                end
                object btnOk: TRzBitBtn
                  Left = 319
                  Top = 74
                  Width = 70
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
                  TabOrder = 5
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object edtSHOP_ID: TzrComboBoxList
                  Left = 85
                  Top = 30
                  Width = 223
                  Height = 20
                  ParentFont = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  Style.Font.Charset = GB2312_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -12
                  Style.Font.Name = #23435#20307
                  Style.Font.Style = []
                  TabOrder = 2
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'SHOP_NAME;SHOP_ID;SHOP_SPELL'
                  KeyField = 'SHOP_ID'
                  ListField = 'SHOP_NAME'
                  Columns = <
                    item
                      AutoDropDown = True
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = #38376#24215#21517#31216
                      Width = 220
                    end>
                  DropWidth = 224
                  DropHeight = 130
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object edtCREA_USER: TzrComboBoxList
                  Left = 85
                  Top = 53
                  Width = 223
                  Height = 20
                  ParentFont = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  Style.Font.Charset = GB2312_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -12
                  Style.Font.Name = #23435#20307
                  Style.Font.Style = []
                  TabOrder = 3
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'USER_ID;USER_NAME;USER_SPELL'
                  KeyField = 'USER_ID'
                  ListField = 'USER_NAME'
                  Columns = <
                    item
                      AutoDropDown = True
                      EditButtons = <>
                      FieldName = 'USER_NAME'
                      Footers = <>
                      Title.Caption = #21517'  '#31216
                      Width = 176
                    end
                    item
                      EditButtons = <>
                      FieldName = 'ACCOUNT'
                      Footers = <>
                      Title.Caption = #36134#21495
                    end>
                  DropWidth = 222
                  DropHeight = 130
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object D1: TcxDateEdit
                  Left = 85
                  Top = 7
                  Width = 100
                  Height = 20
                  ParentFont = False
                  Style.Font.Charset = GB2312_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -12
                  Style.Font.Name = #23435#20307
                  Style.Font.Style = []
                  TabOrder = 0
                end
                object D2: TcxDateEdit
                  Left = 208
                  Top = 7
                  Width = 100
                  Height = 20
                  ParentFont = False
                  Style.Font.Charset = GB2312_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -12
                  Style.Font.Name = #23435#20307
                  Style.Font.Style = []
                  TabOrder = 1
                end
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 847
    inherited Image3: TImage
      Left = 324
      Width = 0
    end
    inherited Image14: TImage
      Left = 827
    end
    inherited Image1: TImage
      Left = 316
      Width = 511
    end
    inherited rzPanel5: TPanel
      Left = 324
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #21457#31080#20449#24687
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 304
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 304
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 304
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
        object But_Print: TToolButton
          Left = 175
          Top = 0
          Action = actPrint
        end
        object But_Preview: TToolButton
          Left = 218
          Top = 0
          Action = actPreview
        end
        object ToolButton3: TToolButton
          Left = 261
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 24
    Top = 306
  end
  inherited actList: TActionList
    Left = 56
    Top = 306
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
    object actRights: TAction
      Caption = #25480#26435
      ImageIndex = 31
      ShortCut = 16466
    end
  end
  object Ds_Invoice: TDataSource
    DataSet = Cds_Invoice
    Left = 56
    Top = 336
  end
  object PopupMenu1: TPopupMenu
    Left = 150
    Top = 267
  end
  object Cds_Invoice: TZQuery
    FieldDefs = <>
    AfterScroll = Cds_InvoiceAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 62
    Top = 240
  end
  object PrintDBGridEh1: TPrintDBGridEh
    Options = []
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
    Left = 198
    Top = 264
  end
end
