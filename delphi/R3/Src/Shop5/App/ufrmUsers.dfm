inherited frmUsers: TfrmUsers
  Left = 217
  Top = 100
  Width = 948
  Height = 580
  Caption = #29992#25143#26723#26696#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 932
    Height = 505
    inherited RzPanel2: TRzPanel
      Width = 922
      Height = 495
      inherited RzPage: TRzPageControl
        Width = 916
        Height = 489
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #29992#25143#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 914
            Height = 462
            object RzPanel1: TRzPanel
              Left = 5
              Top = 106
              Width = 904
              Height = 351
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object DBGridEh1: TDBGridEh
                Left = 5
                Top = 5
                Width = 894
                Height = 322
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
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
                OnCellClick = DBGridEh1CellClick
                OnDblClick = actInfoExecute
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnGetCellParams = DBGridEh1GetCellParams
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SEQNO'
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
                    Width = 140
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
                    FieldName = 'ROLE_IDS_TEXT'
                    Footers = <>
                    Title.Caption = #35282#33394
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'DEPT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #37096#38376
                    Width = 90
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
                Top = 327
                Width = 894
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
              Width = 904
              Height = 101
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 1
              object Panel2: TPanel
                Left = 5
                Top = 5
                Width = 894
                Height = 91
                Align = alClient
                Alignment = taLeftJustify
                BevelOuter = bvNone
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentColor = True
                ParentFont = False
                TabOrder = 0
                DesignSize = (
                  894
                  91)
                object Label1: TLabel
                  Left = 21
                  Top = 55
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
                object Bevel1: TBevel
                  Left = 277
                  Top = 60
                  Width = 607
                  Height = 2
                  Anchors = [akLeft, akTop, akRight]
                end
                object Label3: TLabel
                  Left = 21
                  Top = 74
                  Width = 65
                  Height = 12
                  Caption = #26597#35810#20851#20581#23383
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object RzLabel22: TRzLabel
                  Left = 8
                  Top = 7
                  Width = 63
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #25152#23646#38376#24215
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel13: TRzLabel
                  Left = 378
                  Top = 9
                  Width = 37
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #24615#21035
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel6: TRzLabel
                  Left = 21
                  Top = 36
                  Width = 49
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #25152#23646#37096#38376
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object labDEGREES: TRzLabel
                  Left = 200
                  Top = 36
                  Width = 45
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #23398#21382
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object lab_DUTY_IDS: TRzLabel
                  Left = 206
                  Top = 7
                  Width = 40
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #32844#21153
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel1: TRzLabel
                  Left = 364
                  Top = 38
                  Width = 51
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #29366#24577
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object edtKey: TcxTextEdit
                  Left = 91
                  Top = 70
                  Width = 196
                  Height = 20
                  TabOrder = 6
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  OnKeyDown = edtKeyKeyDown
                end
                object btnOk: TRzBitBtn
                  Left = 301
                  Top = 68
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
                  TabOrder = 7
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndSEX: TRadioGroup
                  Left = 425
                  Top = -4
                  Width = 230
                  Height = 29
                  Columns = 4
                  ItemIndex = 0
                  Items.Strings = (
                    #25152#26377
                    #22899
                    #30007
                    #20445#23494)
                  TabOrder = 4
                end
                object fndDEPT_ID: TzrComboBoxList
                  Left = 81
                  Top = 32
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
                  FilterFields = 'DEPT_ID;DEPT_NAME;DEPT_SPELL'
                  KeyField = 'DEPT_ID'
                  ListField = 'DEPT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Visible = False
                      Width = 30
                    end
                    item
                      AutoDropDown = True
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footers = <>
                      Title.Caption = #37096#38376#21517#31216
                      Width = 90
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_SEPLL'
                      Footers = <>
                      Title.Caption = #25340#38899#30721
                      Visible = False
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
                object fndDEGREES: TcxComboBox
                  Left = 256
                  Top = 32
                  Width = 111
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  TabOrder = 3
                end
                object fndDUTY_IDS: TzrComboBoxList
                  Left = 256
                  Top = 3
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
                  FilterFields = 'DUTY_NAME;DUTY_ID;DUTY_SPELL'
                  KeyField = 'DUTY_ID'
                  ListField = 'DUTY_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'DUTY_NAME'
                      Footers = <>
                      Title.Caption = #32844#21153#21517#31216
                      Width = 90
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
                object fndState: TRadioGroup
                  Left = 425
                  Top = 25
                  Width = 230
                  Height = 29
                  Columns = 4
                  ItemIndex = 0
                  Items.Strings = (
                    #25152#26377
                    #26410#20837#32844
                    #22312#32844
                    #31163#32844)
                  TabOrder = 5
                end
                object fndSHOP_ID: TzrComboBoxList
                  Left = 81
                  Top = 3
                  Width = 111
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 0
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
                      Width = 120
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 30
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
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 932
    inherited Image1: TImage
      Left = 371
      Width = 541
    end
    inherited Image3: TImage
      Left = 371
      Width = 541
    end
    inherited Image14: TImage
      Left = 912
    end
    inherited rzPanel5: TPanel
      Left = 371
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
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 351
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
    object actPasswordReset: TAction
      Caption = #23494#30721#37325#32622
      OnExecute = actPasswordResetExecute
    end
  end
  object Ds_Users: TDataSource
    DataSet = Cds_Users
    Left = 56
    Top = 336
  end
  object PopupMenu1: TPopupMenu
    Left = 102
    Top = 243
    object N1: TMenuItem
      Caption = #25480#26435
      OnClick = N1Click
    end
    object N2: TMenuItem
      Action = actPasswordReset
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Excel1: TMenuItem
      Caption = 'Excel'#23548#20837
      OnClick = Excel1Click
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
    Options = [pghFitGridToPageWidth]
    Page.BottomMargin = 2.000000000000000000
    Page.LeftMargin = 2.000000000000000000
    Page.RightMargin = 0.500000000000000000
    Page.TopMargin = 2.000000000000000000
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      #35843#25972#27719#24635#34920)
    PageHeader.Font.Charset = GB2312_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -16
    PageHeader.Font.Name = #23435#20307
    PageHeader.Font.Style = [fsBold]
    Units = MM
    Left = 136
    Top = 240
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323020255B7768725D5C66315C6673
      3136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C71725C66305C667332305C2762345C2766325C2764335C2761315C2763
      615C2762315C2762635C2765345C6C616E67323035325C66315C66733136200D
      0A5C706172207D0D0A00}
  end
end
