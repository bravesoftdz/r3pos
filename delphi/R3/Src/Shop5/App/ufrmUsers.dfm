inherited frmUsers: TfrmUsers
  Left = 417
  Top = 166
  Width = 744
  Height = 484
  Caption = #29992#25143#26723#26696#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 736
    Height = 427
    inherited RzPanel2: TRzPanel
      Width = 726
      Height = 417
      inherited RzPage: TRzPageControl
        Width = 720
        Height = 411
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #29992#25143#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 718
            Height = 384
            object RzPanel1: TRzPanel
              Left = 5
              Top = 41
              Width = 708
              Height = 338
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object DBGridEh1: TDBGridEh
                Left = 5
                Top = 5
                Width = 698
                Height = 309
                Align = alClient
                DataSource = Ds_Users
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
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'ACCOUNT'
                    Footers = <>
                    Title.Caption = #29992#25143#36134#21495
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #29992#25143#22995#21517
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_ID_TEXT'
                    Footers = <>
                    Title.Caption = #25152#23646#38376#24215
                    Width = 94
                  end
                  item
                    EditButtons = <>
                    FieldName = 'DUTY_IDS_TEXT'
                    Footers = <>
                    Title.Caption = #32844#21153
                    Width = 76
                  end
                  item
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
                    Title.Caption = #24615#21035
                    Width = 40
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'MOBILE'
                    Footers = <>
                    Title.Caption = #31227#21160#30005#35805
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'OFFI_TELE'
                    Footers = <>
                    Title.Caption = #21150#20844#30005#35805
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'FAMI_TELE'
                    Footers = <>
                    Title.Caption = #23478#24237#30005#35805
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'QQ'
                    Footers = <>
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'MSN'
                    Footers = <>
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'MM'
                    Footers = <>
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'EMAIL'
                    Footers = <>
                    Title.Caption = #30005#23376#37038#31665
                    Width = 130
                  end>
              end
              object stbPanel: TPanel
                Left = 5
                Top = 314
                Width = 698
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
              Width = 708
              Height = 36
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 1
              DesignSize = (
                708
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
                Width = 607
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
                  Width = 247
                  Height = 12
                  Caption = #25903#25345#65288#29992#25143#22995#21517#12289#25340#38899#30721#12289#29992#25143#36134#21495#65289#26597#35810
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
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 736
    inherited Image1: TImage
      Left = 527
      Width = 200
    end
    inherited Image14: TImage
      Left = 727
    end
    inherited Image3: TImage
      Left = 527
      Width = 200
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #29992#25143#26723#26696
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 351
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 351
          Width = 30
        end>
      inherited ToolBar1: TToolBar
        Width = 351
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
        object ToolButton4: TToolButton
          Left = 179
          Top = 0
          Action = actRights
        end
        object But_Print: TToolButton
          Left = 222
          Top = 0
          Action = actPrint
        end
        object But_Preview: TToolButton
          Left = 265
          Top = 0
          Action = actPreview
        end
        object ToolButton3: TToolButton
          Left = 308
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
      OnExecute = actRightsExecute
    end
  end
  object Ds_Users: TDataSource
    DataSet = Cds_Users
    Left = 56
    Top = 336
  end
  object PopupMenu1: TPopupMenu
    Left = 238
    Top = 155
    object N1: TMenuItem
      Caption = #25480#26435
      OnClick = N1Click
    end
  end
  object Cds_Users: TZQuery
    FieldDefs = <>
    AfterScroll = Cds_UsersAfterScroll
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
    Left = 238
    Top = 200
  end
end
