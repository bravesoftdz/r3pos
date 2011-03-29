inherited frmGoodsInfoList: TfrmGoodsInfoList
  Left = 197
  Top = 102
  Width = 956
  Height = 628
  Caption = #21830#21697#26723#26696#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 948
    Height = 565
    inherited RzPanel2: TRzPanel
      Width = 938
      Height = 555
      inherited RzPage: TRzPageControl
        Width = 932
        Height = 549
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #21830#21697#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 930
            Height = 522
            object Splitter1: TSplitter
              Left = 181
              Top = 41
              Height = 476
            end
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 920
              Height = 36
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              DesignSize = (
                920
                36)
              object Panel3: TPanel
                Left = 0
                Top = 0
                Width = 178
                Height = 30
                Alignment = taRightJustify
                BevelInner = bvLowered
                Caption = #26597#35810#20851#20581#23383'   '
                Color = 12698049
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object Panel4: TPanel
                Left = 176
                Top = 0
                Width = 748
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
                object Label2: TLabel
                  Left = 298
                  Top = 10
                  Width = 247
                  Height = 12
                  Caption = #25903#25345#65288#21697#21517#12289#25340#38899#30721#12289#36135#21495#12289#26465#24418#30721#65289#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object edtKey: TcxTextEdit
                  Left = 9
                  Top = 5
                  Width = 196
                  Height = 20
                  TabOrder = 0
                  OnKeyDown = edtKeyKeyDown
                  OnKeyPress = edtKeyKeyPress
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
              Height = 476
              SelectionPen.Color = clBtnShadow
              Align = alLeft
              FrameStyle = fsGroove
              FrameVisible = True
              HideSelection = False
              Indent = 19
              PopupMenu = AddSortTree
              ReadOnly = True
              RowSelect = True
              TabOrder = 1
              OnChanging = rzTreeChanging
            end
            object Panel1: TPanel
              Left = 184
              Top = 41
              Width = 741
              Height = 476
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 2
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 739
                Height = 455
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = DataSource1
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
                OnDblClick = DBGridEh1DblClick
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnGetCellParams = DBGridEh1GetCellParams
                OnKeyPress = DBGridEh1KeyPress
                OnTitleClick = DBGridEh1TitleClick
                Columns = <
                  item
                    Checkboxes = True
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'selflag'
                    Footers = <>
                    KeyList.Strings = (
                      '1'
                      '0')
                    PickList.Strings = (
                      '0'
                      '1')
                    Tag = -1
                    Title.Caption = #36873#20013
                    Width = 18
                  end
                  item
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 28
                  end
                  item
                    EditButtons = <>
                    FieldName = 'RELATION_FLAG'
                    Footers = <>
                    KeyList.Strings = (
                      '1'
                      '2')
                    PickList.Strings = (
                      #36830#38145#32463#33829
                      #33258#20027#32463#33829)
                    Title.Caption = #32463#33829#31867#22411
                    Width = 66
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'GODS_CODE'
                    Footers = <>
                    Title.Caption = #36135#21495
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BARCODE'
                    Footers = <>
                    Title.Caption = #26465#30721
                    Width = 85
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_NAME'
                    Footers = <>
                    Title.Caption = #21830#21697#21517#31216
                    Width = 152
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CALC_UNITS'
                    Footers = <>
                    Title.Caption = #35745#37327#21333#20301
                    Width = 34
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'RTL_OUTPRICE'
                    Footers = <>
                    Title.Caption = #26631#20934#21806#20215
                    Width = 62
                  end
                  item
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'NEW_LOWPRICE'
                    Footers = <>
                    Title.Caption = #26368#20302#21806#20215
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'NEW_OUTPRICE'
                    Footers = <>
                    Title.Caption = #26412#24215#21806#20215
                    Width = 60
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'NEW_INPRICE'
                    Footers = <>
                    Title.Caption = #21442#32771#36827#20215
                    Width = 58
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0%'
                    EditButtons = <>
                    FieldName = 'PROFIT_RATE'
                    Footers = <>
                    Title.Caption = #36827#20215#25240#25187#29575
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SORT_ID3'
                    Footers = <>
                    Title.Caption = #20379#24212#21830
                    Width = 129
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SORT_ID4'
                    Footers = <>
                    Title.Caption = #21697#29260
                    Width = 57
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_TYPE'
                    Footers = <>
                    KeyList.Strings = (
                      '0'
                      '1')
                    PickList.Strings = (
                      #21542' '
                      #26159' '
                      '')
                    Title.Caption = #31649#29702#24211#23384
                    Width = 32
                  end>
              end
              object stbPanel: TPanel
                Left = 1
                Top = 456
                Width = 739
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
                object Label1: TLabel
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
    Width = 948
    inherited Image1: TImage
      Left = 331
      Width = 597
    end
    inherited Image3: TImage
      Left = 331
      Width = 597
    end
    inherited Image14: TImage
      Left = 928
    end
    inherited rzPanel5: TPanel
      Left = 331
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #21830#21697#26723#26696
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 311
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 311
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 311
        ButtonWidth = 43
        object ToolButton2: TToolButton
          Left = 0
          Top = 0
          Action = actNew
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
          Action = actPrint
        end
        object ToolButton9: TToolButton
          Left = 225
          Top = 0
          Action = actPreview
        end
        object ToolButton10: TToolButton
          Left = 268
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 80
    Top = 224
  end
  inherited actList: TActionList
    Left = 136
    Top = 224
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
    object actCopyNew: TAction
      Caption = #22797#21046#26032#22686
      OnExecute = actCopyNewExecute
    end
    object actPrintBarCode: TAction
      Caption = #25171#21360#26465#30721
      OnExecute = actPrintBarCodeExecute
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsBrowser
    Left = 353
    Top = 250
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 105
    Top = 130
    object N6: TMenuItem
      Action = actCopyNew
    end
    object N1: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#36873
      ImageIndex = 46
      ShortCut = 16449
      OnClick = N1Click
    end
    object N2: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#21453#36873
      ShortCut = 16450
      OnClick = N2Click
    end
    object N3: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#19981#36873
      ShortCut = 16452
      OnClick = N3Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Action = actPrintBarCode
    end
    object N4: TMenuItem
      Caption = #26174#31034#25152#26377
      OnClick = N4Click
    end
  end
  object cdsBrowser: TZQuery
    SortedFields = 'GODS_CODE'
    FieldDefs = <>
    AfterScroll = cdsBrowserAfterScroll
    CachedUpdates = True
    SQL.Strings = (
      
        'select USER_ID,USER_SPELL,USER_NAME,ACCOUNT,DUTY_IDS,COMP_ID fro' +
        'm VIW_USERS where COMM not in ('#39'02'#39','#39'12'#39')'
      
        'and (COMP_ID=:COMP_ID or COMP_ID='#39'----'#39' or COMP_ID in (select UP' +
        'COMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_TYPE=2)'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID=:COMP' +
        '_ID and COMP_TYPE=2 and COMM not in ('#39'02'#39','#39'12'#39'))'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID in (s' +
        'elect UPCOMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_' +
        'TYPE=2) and COMP_TYPE=2)'
      ') order by ACCOUNT')
    Params = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
    IndexFieldNames = 'GODS_CODE Asc'
    Left = 322
    Top = 250
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
  end
  object AddSortTree: TPopupMenu
    Left = 33
    Top = 95
    object N8: TMenuItem
      Caption = #28155#21152#21830#21697#20998#31867
      OnClick = N8Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object N10: TMenuItem
      Caption = #21047#26032
      OnClick = N10Click
    end
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
    Left = 192
    Top = 288
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
  object edtProperty: TZQuery
    FieldDefs = <
      item
        Name = 'SEQNO'
        DataType = ftInteger
      end
      item
        Name = 'GODS_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'GODS_CODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GODS_NAME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'UNIT_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BATCH_NO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'IS_PRESENT'
        DataType = ftInteger
      end
      item
        Name = 'LOCUS_NO'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BOM_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_01'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_02'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end>
    CachedUpdates = True
    Params = <>
    Left = 392
    Top = 256
  end
end
