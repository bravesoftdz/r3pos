inherited frmShopInfoList: TfrmShopInfoList
  Left = 372
  Top = 156
  Width = 901
  Height = 516
  Caption = #38376#24215#26723#26696#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 893
    Height = 459
    inherited RzPanel2: TRzPanel
      Width = 883
      Height = 449
      inherited RzPage: TRzPageControl
        Width = 877
        Height = 443
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38376#24215#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 875
            Height = 416
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 865
              Height = 36
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              DesignSize = (
                865
                36)
              object Panel1: TPanel
                Left = 0
                Top = 0
                Width = 113
                Height = 30
                Alignment = taRightJustify
                BevelInner = bvLowered
                Caption = '  '#26597#35810#20851#20581#23383
                Color = 12698049
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object Panel2: TPanel
                Left = 111
                Top = 0
                Width = 754
                Height = 30
                Alignment = taLeftJustify
                Anchors = [akLeft, akTop, akRight, akBottom]
                BevelInner = bvLowered
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentColor = True
                ParentFont = False
                TabOrder = 1
                object Label1: TLabel
                  Left = 299
                  Top = 10
                  Width = 221
                  Height = 12
                  Caption = #25903#25345#65288#24215#21517#12289#25340#38899#30721#12289#38376#24215#20195#30721#65289#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object edtKey: TcxTextEdit
                  Left = 8
                  Top = 5
                  Width = 196
                  Height = 20
                  TabOrder = 0
                  OnKeyDown = edtKeyKeyDown
                end
                object btnOk: TRzBitBtn
                  Left = 219
                  Top = 3
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
                  TabOrder = 1
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
              end
            end
            object Panel3: TPanel
              Left = 5
              Top = 41
              Width = 865
              Height = 370
              Align = alClient
              Caption = 'Panel3'
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 863
                Height = 349
                Align = alClient
                DataSource = dsBrowser
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
                OnKeyPress = DBGridEh1KeyPress
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 31
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'SHOP_ID'
                    Footers = <>
                    Title.Caption = #38376#24215#20195#30721
                    Width = 90
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_NAME'
                    Footers = <>
                    Title.Caption = #38376#24215#21517#31216
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_SPELL'
                    Footers = <>
                    Title.Caption = #25340#38899#30721
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_TYPE'
                    Footers = <>
                    Title.Caption = #31649#29702#32676#32452
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LICENSE_CODE'
                    Footers = <>
                    Title.Caption = #32463#33829#35768#21487#35777
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REGION_ID'
                    Footers = <>
                    Title.Caption = #22320#21306
                    Width = 114
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LINKMAN'
                    Footers = <>
                    Title.Caption = #36127#36131#20154
                    Width = 51
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'TELEPHONE'
                    Footers = <>
                    Title.Caption = #30005#35805
                    Width = 78
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'FAXES'
                    Footers = <>
                    Title.Caption = #20256#30495
                    Width = 86
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'POSTALCODE'
                    Footers = <>
                    Title.Caption = #37038#32534
                    Width = 55
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ADDRESS'
                    Footers = <>
                    Title.Caption = #22320#22336
                    Width = 215
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Caption = #22791#27880
                    Width = 123
                  end>
              end
              object stbPanel: TPanel
                Left = 1
                Top = 350
                Width = 863
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
    Width = 893
    inherited Image1: TImage
      Left = 484
      Width = 400
    end
    inherited Image14: TImage
      Left = 884
    end
    inherited Image3: TImage
      Left = 484
      Width = 400
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #38376#24215#26723#26696
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
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actNew
          Caption = #26032#22686
        end
        object ToolButton8: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
          Caption = #20462#25913
        end
        object ToolButton5: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
          Caption = #35814#32454
        end
        object ToolButton3: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton7: TToolButton
          Left = 172
          Top = 0
          Width = 7
          Caption = 'ToolButton7'
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton10: TToolButton
          Left = 179
          Top = 0
          Action = actPrint
        end
        object ToolButton9: TToolButton
          Left = 222
          Top = 0
          Action = actPreview
        end
        object ToolButton4: TToolButton
          Left = 265
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 48
    Top = 272
  end
  inherited actList: TActionList
    Left = 136
    Top = 240
    inherited actNew: TAction
      Caption = #28155#21152
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
  object dsBrowser: TDataSource
    DataSet = cdsBrowser
    Left = 137
    Top = 280
  end
  object PopupMenu1: TPopupMenu
    Left = 312
    Top = 171
    object N1: TMenuItem
      Caption = #36716#25442#25104#24635#24215
    end
  end
  object PrintDBGridEh1: TPrintDBGridEh
    DBGridEh = DBGridEh1
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
  object cdsBrowser: TZQuery
    FieldDefs = <>
    AfterScroll = cdsBrowserAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 49
    Top = 207
  end
end
