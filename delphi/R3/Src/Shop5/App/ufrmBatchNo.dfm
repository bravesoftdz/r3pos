inherited frmBatchNo: TfrmBatchNo
  Left = 300
  Top = 133
  Width = 948
  Height = 580
  Caption = #25209#21495#31649#29702
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
          Caption = #25209#21495#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 914
            Height = 462
            object RzPanel1: TRzPanel
              Left = 5
              Top = 37
              Width = 904
              Height = 420
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object DBGridEh1: TDBGridEh
                Left = 5
                Top = 5
                Width = 894
                Height = 391
                Align = alClient
                DataSource = dsBatchNo
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
                    FieldName = 'BATCH_NO'
                    Footers = <>
                    Title.Caption = #25209#21495
                    Width = 142
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_ID_TEXT'
                    Footers = <>
                    Title.Caption = #25152#23646#21830#21697
                    Width = 224
                  end
                  item
                    EditButtons = <>
                    FieldName = 'FACT_DATE'
                    Footers = <>
                    Title.Caption = #29983#20135#26085#26399
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'VILD_DATE'
                    Footers = <>
                    Title.Caption = #26377#25928#26085#26399
                    Width = 76
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Caption = #35828#26126
                    Width = 271
                  end>
              end
              object stbPanel: TPanel
                Left = 5
                Top = 396
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
              Height = 32
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 1
              object Panel2: TPanel
                Left = 5
                Top = 5
                Width = 894
                Height = 22
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
                object Label3: TLabel
                  Left = 13
                  Top = 5
                  Width = 52
                  Height = 12
                  Caption = #25209#21495#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object Label1: TLabel
                  Left = 245
                  Top = 5
                  Width = 52
                  Height = 12
                  Caption = #25152#23646#21830#21697
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object edtKey: TcxTextEdit
                  Left = 75
                  Top = 1
                  Width = 158
                  Height = 20
                  TabOrder = 0
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  OnKeyDown = edtKeyKeyDown
                end
                object btnOk: TRzBitBtn
                  Left = 477
                  Top = -1
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
                object edtP2_GoodsName: TzrComboBoxList
                  Left = 307
                  Top = 1
                  Width = 149
                  Height = 20
                  TabStop = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 2
                  InGrid = True
                  KeyValue = Null
                  FilterFields = 'GODS_CODE;GODS_NAME;GODS_SPELL;BARCODE'
                  KeyField = 'GODS_ID'
                  ListField = 'GODS_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 150
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      Title.Caption = #36135#21495
                      Width = 50
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = #26465#30721
                      Width = 65
                    end>
                  DropWidth = 380
                  DropHeight = 250
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    inherited Image3: TImage
      Left = 328
      Width = 35
    end
    inherited Image14: TImage
      Left = 912
    end
    inherited Image1: TImage
      Left = 363
      Width = 549
    end
    inherited rzPanel5: TPanel
      Left = 328
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #29992#25143#26723#26696
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
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 308
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
        object ToolButton3: TToolButton
          Left = 265
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
    object actPasswordReset: TAction
      Caption = #23494#30721#37325#32622
    end
  end
  object dsBatchNo: TDataSource
    DataSet = cdsBatchNo
    Left = 56
    Top = 336
  end
  object PopupMenu1: TPopupMenu
    Left = 102
    Top = 243
    object N1: TMenuItem
      Caption = #25480#26435
    end
    object N2: TMenuItem
      Action = actPasswordReset
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Excel1: TMenuItem
      Caption = 'Excel'#23548#20837
    end
  end
  object cdsBatchNo: TZQuery
    FieldDefs = <>
    AfterScroll = cdsBatchNoAfterScroll
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
      #29992#25143#26723#26696#34920)
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
