inherited frmShopInfoList: TfrmShopInfoList
  Left = 436
  Top = 179
  Width = 735
  Height = 487
  Caption = #38376#24215#26723#26696#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 727
    Height = 423
    inherited RzPanel2: TRzPanel
      Width = 717
      Height = 413
      inherited RzPage: TRzPageControl
        Width = 711
        Height = 407
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #38376#24215#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 709
            Height = 380
            object Splitter1: TSplitter
              Left = 181
              Top = 41
              Height = 334
            end
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 699
              Height = 36
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              DesignSize = (
                699
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
                Width = 588
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
                  Properties.OnChange = edtKeyPropertiesChange
                  TabOrder = 0
                  OnKeyDown = edtKeyKeyDown
                end
                object btnOk: TRzBitBtn
                  Left = 218
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
            object rzTree: TRzTreeView
              Left = 5
              Top = 41
              Width = 176
              Height = 334
              SelectionPen.Color = clBtnShadow
              Align = alLeft
              FrameStyle = fsGroove
              FrameVisible = True
              HideSelection = False
              Indent = 19
              ReadOnly = True
              RowSelect = True
              TabOrder = 1
              OnChange = rzTreeChange
              OnChanging = rzTreeChanging
            end
            object Panel3: TPanel
              Left = 184
              Top = 41
              Width = 520
              Height = 334
              Align = alClient
              Caption = 'Panel3'
              TabOrder = 2
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 518
                Height = 313
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
                OnDblClick = DBGridEh1DblClick
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
                    FieldName = 'COMP_ID'
                    Footers = <>
                    Title.Caption = #38376#24215#20195#30721
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'COMP_NAME'
                    Footers = <>
                    Title.Caption = #38376#24215#21517#31216
                    Width = 125
                  end
                  item
                    EditButtons = <>
                    FieldName = 'COMP_SPELL'
                    Footers = <>
                    Title.Caption = #25340#38899#30721
                    Width = 78
                  end
                  item
                    EditButtons = <>
                    FieldName = 'COMP_TYPE'
                    Footers = <>
                    KeyList.Strings = (
                      '1'
                      '2'
                      '3')
                    PickList.Strings = (
                      #32463#38144#21830
                      #30452#33829#24215
                      #21152#30431#24215
                      #9)
                    Title.Caption = #38376#24215#31867#22411
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UPCOMP_ID'
                    Footers = <>
                    Title.Caption = #38582#23646#32463#38144#21830
                    Width = 83
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GROUP_NAME'
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
                    EditButtons = <>
                    FieldName = 'ADDRESS'
                    Footers = <>
                    Title.Caption = #22320#22336
                    Width = 215
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
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Caption = #22791#27880
                    Width = 123
                  end>
              end
              object stbPanel: TPanel
                Left = 1
                Top = 314
                Width = 518
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
    Width = 727
    inherited Image1: TImage
      Left = 484
      Width = 234
    end
    inherited Image14: TImage
      Left = 718
    end
    inherited Image3: TImage
      Left = 484
      Width = 234
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
    object actIntoShop: TAction
      Caption = #36716#25442#25104#24635#24215
      OnExecute = actIntoShopExecute
    end
  end
  object dsBrowser: TDataSource
    Left = 137
    Top = 280
  end
  object PopupMenu1: TPopupMenu
    Left = 312
    Top = 171
    object N1: TMenuItem
      Action = actIntoShop
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
    AfterScroll = cdsBrowserAfterScroll
    Params = <>
    Left = 49
    Top = 207
  end
end
