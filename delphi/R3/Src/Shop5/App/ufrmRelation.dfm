inherited frmRelation: TfrmRelation
  Left = 305
  Top = 147
  Width = 956
  Height = 628
  Caption = #20379#24212#38142#31649#29702
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 940
    Height = 554
    inherited RzPanel2: TRzPanel
      Width = 930
      Height = 544
      inherited RzPage: TRzPageControl
        Width = 924
        Height = 538
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #20379#24212#38142#31649#29702
          inherited RzPanel3: TRzPanel
            Width = 922
            Height = 511
            object Splitter1: TSplitter
              Left = 181
              Top = 41
              Height = 465
            end
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 912
              Height = 36
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              DesignSize = (
                912
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
              Height = 465
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
              OnChange = rzTreeChange
            end
            object Panel1: TPanel
              Left = 184
              Top = 41
              Width = 733
              Height = 465
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 2
              object stbPanel: TPanel
                Left = 1
                Top = 445
                Width = 731
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
                TabOrder = 0
                object Label1: TLabel
                  Left = 4
                  Top = 8
                  Width = 7
                  Height = 12
                end
              end
              object Grid_RelationAndGoods: TDBGridEh
                Left = 1
                Top = 1
                Width = 731
                Height = 444
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = Ds_RelationAndGoods
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FrozenCols = 1
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                PopupMenu = PopupMenu1
                RowHeight = 23
                TabOrder = 1
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                UseMultiTitle = True
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                Columns = <
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'A'
                    Footers = <>
                    KeyList.Strings = (
                      '1'
                      '0')
                    PickList.Strings = (
                      '0'
                      '1')
                    Tag = -1
                    Title.Caption = #36873#25321
                    Title.Color = clWhite
                    Width = 21
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_CODE'
                    Footer.Value = #35760#24405#25968#65306
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #36135#21495
                    Title.Color = clWhite
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_NAME'
                    Footer.ValueType = fvtCount
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21830#21697#21517#31216
                    Title.Color = clWhite
                    Width = 122
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BARCODE'
                    Footers = <>
                    Title.Caption = #26465#30721
                    Title.Color = clWhite
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'AMOUNT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #24211#23384#37327
                    Title.Color = clWhite
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_ID'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #35745#37327#21333#20301
                    Title.Color = clWhite
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'NEW_OUTPRICE'
                    Footers = <>
                    Title.Caption = #26631#20934#21806#20215
                    Title.Color = clWhite
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'NEW_INPRICE'
                    Footers = <>
                    Title.Caption = #26631#20934#36827#20215
                    Title.Color = clWhite
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'NEW_LOWPRICE'
                    Footers = <>
                    Title.Caption = #26368#20302#21806#20215
                    Title.Color = clWhite
                    Width = 80
                  end>
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 940
    inherited Image1: TImage
      Left = 417
      Width = 503
    end
    inherited Image3: TImage
      Left = 417
      Width = 503
    end
    inherited Image14: TImage
      Left = 920
    end
    inherited rzPanel5: TPanel
      Left = 417
      inherited lblToolCaption: TRzLabel
        Width = 60
        Caption = #20379#24212#38142#26723#26696
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 397
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 397
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 397
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
        end
        object ToolButton1: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
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
        object ToolButton3: TToolButton
          Left = 182
          Top = 0
          Action = actSave
        end
        object ToolButton6: TToolButton
          Left = 225
          Top = 0
          Action = actCancel
        end
        object ToolButton8: TToolButton
          Left = 268
          Top = 0
          Action = actPrint
        end
        object ToolButton9: TToolButton
          Left = 311
          Top = 0
          Action = actPreview
        end
        object ToolButton10: TToolButton
          Left = 354
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
      Caption = #30003#35831
      OnExecute = actNewExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
    inherited actEdit: TAction
      Caption = #21019#24314
      OnExecute = actEditExecute
    end
    inherited actSave: TAction
      OnExecute = actSaveExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
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
    end
    object actPrintBarCode: TAction
      Caption = #25171#21360#26465#30721
    end
  end
  object Ds_RelationAndGoods: TDataSource
    DataSet = Cds_RelationAndGoods
    Left = 353
    Top = 250
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 217
    Top = 226
    object ShowAll: TMenuItem
      Caption = #26174#31034#25152#26377
      OnClick = ShowAllClick
    end
    object AllSelect: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#36873
      ImageIndex = 46
      ShortCut = 16449
      OnClick = AllSelectClick
    end
    object InverserSelect: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#21453#36873
      ShortCut = 16450
      OnClick = InverserSelectClick
    end
    object NotSelect: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#19981#36873
      ShortCut = 16452
      OnClick = NotSelectClick
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
    Left = 272
    Top = 192
  end
  object Cds_RelationAndGoods: TZQuery
    SortedFields = 'GODS_CODE'
    FieldDefs = <>
    AfterScroll = Cds_RelationAndGoodsAfterScroll
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
    Left = 41
    Top = 151
    object N8: TMenuItem
      Caption = #28155#21152#21830#21697#20998#31867
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object N10: TMenuItem
      Caption = #21047#26032
    end
  end
end
