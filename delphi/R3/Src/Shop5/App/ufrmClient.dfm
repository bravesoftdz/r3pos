inherited frmClient: TfrmClient
  Left = 369
  Top = 175
  Width = 742
  Height = 490
  Caption = #23458#25143#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 734
    Height = 433
    inherited RzPanel2: TRzPanel
      Width = 724
      Height = 423
      inherited RzPage: TRzPageControl
        Width = 718
        Height = 417
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #23458#25143#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 716
            Height = 390
            object RzPanel6: TRzPanel
              Left = 5
              Top = 5
              Width = 706
              Height = 61
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object Label1: TLabel
                Left = 280
                Top = 10
                Width = 195
                Height = 12
                Caption = #25903#25345#65288#25340#38899#30721#12289#21517#31216#12289#20195#21495#65289#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label3: TLabel
                Left = 4
                Top = 9
                Width = 72
                Height = 12
                Alignment = taRightJustify
                Caption = '  '#26597#35810#20851#20581#23383
              end
              object Label40: TLabel
                Left = 26
                Top = 36
                Width = 48
                Height = 12
                Caption = #20225#19994#20998#31867
              end
              object edtKey: TcxTextEdit
                Left = 80
                Top = 5
                Width = 196
                Height = 20
                Properties.OnChange = edtKeyPropertiesChange
                TabOrder = 0
                OnKeyDown = edtKeyKeyDown
              end
              object btnOk: TRzBitBtn
                Left = 208
                Top = 30
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
                TabOrder = 2
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSORT_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 32
                Width = 105
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
                FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
                KeyField = 'CODE_ID'
                ListField = 'CODE_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CODE_NAME'
                    Footers = <>
                    Title.Caption = #20998#31867#21517#31216
                  end>
                DropWidth = 176
                DropHeight = 130
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            object RzPanel1: TRzPanel
              Left = 5
              Top = 66
              Width = 706
              Height = 319
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 5
                Top = 5
                Width = 696
                Height = 290
                Align = alClient
                DataSource = Ds_Client
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                FrozenCols = 1
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
                OnTitleClick = DBGridEh1TitleClick
                Columns = <
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'selflag'
                    Footers = <>
                    Title.Caption = #36873#25321
                    Width = 24
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
                    FieldName = 'CLIENT_CODE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #23458#25143#32534#21495
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_NAME'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #23458#25143#21517#31216
                    Width = 128
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_SPELL'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25340#38899#30721
                    Width = 77
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PRICE_ID'
                    Footers = <>
                    Title.Caption = #23458#25143#31561#32423
                    Width = 56
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SORT_ID'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #23458#25143#20998#31867
                    Width = 79
                  end
                  item
                    EditButtons = <>
                    FieldName = 'INVOICE_FLAG'
                    Footers = <>
                    KeyList.Strings = (
                      '1'
                      '2'
                      '3')
                    PickList.Strings = (
                      #25910#27454#25910#25454
                      #26222#36890#21457#31080
                      #22686#20540#31246#31080)
                    ReadOnly = True
                    Title.Caption = #21457#31080#31867#22411
                    Width = 58
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SETTLE_CODE'
                    Footers = <>
                    KeyList.Strings = (
                      '0'
                      '1')
                    PickList.Strings = (
                      #25353#27425
                      #25353#26376)
                    ReadOnly = True
                    Title.Caption = #32467#31639#26041#24335
                    Width = 55
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REGION_ID'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #22320#21306
                    Width = 101
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LINKMAN'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #32852#31995#20154
                    Width = 60
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'TELEPHONE1'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #30005#35805
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TELEPHONE2'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25163#26426
                    Width = 97
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'FAXES'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #20256#30495
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'EMAIL'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #30005#23376#37038#20214
                    Width = 130
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ADDRESS'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #32852#31995#22320#22336
                    Width = 150
                  end>
              end
              object stbPanel: TPanel
                Left = 5
                Top = 295
                Width = 696
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
    Width = 734
    inherited Image1: TImage
      Left = 484
      Width = 241
    end
    inherited Image14: TImage
      Left = 725
    end
    inherited Image3: TImage
      Left = 484
      Width = 241
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 24
        Caption = #23458#25143
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 308
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 308
          Width = 30
        end>
      inherited ToolBar1: TToolBar
        Width = 308
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
          Width = 7
          Caption = 'ToolButton2'
          ImageIndex = 3
          Style = tbsDivider
        end
        object But_Print: TToolButton
          Left = 179
          Top = 0
          Action = actPrint
        end
        object But_Preview: TToolButton
          Left = 222
          Top = 0
          Action = actPreview
        end
        object But_Exit: TToolButton
          Left = 265
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 73
    Top = 228
  end
  inherited actList: TActionList
    Left = 102
    Top = 228
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
  end
  object Ds_Client: TDataSource
    DataSet = Cds_Client
    Left = 73
    Top = 201
  end
  object PopupMenu1: TPopupMenu
    Left = 414
    Top = 236
    object N4: TMenuItem
      Caption = #21457#36865#30701#20449
      OnClick = N4Click
    end
    object N1: TMenuItem
      Caption = #20840#36873
      ShortCut = 16449
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20840#21453#36873
      ShortCut = 16450
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #20840#19981#36873
      ShortCut = 16452
      OnClick = N3Click
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
  object Cds_Client: TZQuery
    SortedFields = 'CLIENT_CODE'
    FieldDefs = <>
    AfterScroll = Cds_ClientAfterScroll
    OnFilterRecord = Cds_ClientFilterRecord
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'CLIENT_CODE Asc'
    Left = 182
    Top = 337
  end
end
