inherited frmRelation: TfrmRelation
  Left = 199
  Top = 113
  Width = 844
  Height = 543
  Caption = #20379#24212#38142#31649#29702
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 828
    Height = 469
    inherited RzPanel2: TRzPanel
      Width = 818
      Height = 459
      inherited RzPage: TRzPageControl
        Width = 812
        Height = 453
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #20379#24212#38142#31649#29702
          inherited RzPanel3: TRzPanel
            Width = 810
            Height = 426
            object Splitter1: TSplitter
              Left = 181
              Top = 47
              Height = 374
            end
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 800
              Height = 42
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              DesignSize = (
                800
                42)
              object Panel3: TPanel
                Left = 0
                Top = 0
                Width = 178
                Height = 36
                Alignment = taRightJustify
                BevelInner = bvLowered
                Caption = #20379#24212#38142#32463#33829#21830#21697#31649#29702'  '
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
                Width = 624
                Height = 36
                Alignment = taLeftJustify
                Anchors = [akLeft, akTop, akRight, akBottom]
                BevelInner = bvLowered
                ParentColor = True
                TabOrder = 1
                object rb1: TcxRadioButton
                  Left = 16
                  Top = 11
                  Width = 89
                  Height = 17
                  Caption = #24050#32463#33829#21830#21697
                  Checked = True
                  TabOrder = 0
                  TabStop = True
                  OnClick = rb1Click
                end
                object rb2: TcxRadioButton
                  Left = 120
                  Top = 11
                  Width = 87
                  Height = 17
                  Caption = #26410#32463#33829#21830#21697
                  TabOrder = 1
                  OnClick = rb2Click
                end
              end
            end
            object rzTree: TRzTreeView
              Left = 5
              Top = 47
              Width = 176
              Height = 374
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
              Top = 47
              Width = 621
              Height = 374
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 2
              object stbPanel: TPanel
                Left = 1
                Top = 354
                Width = 619
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
                Width = 619
                Height = 353
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
                OnDrawColumnCell = Grid_RelationAndGoodsDrawColumnCell
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
                    Width = 22
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 28
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_CODE'
                    Footer.Value = #35760#24405#25968#65306
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #36135#21495
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_NAME'
                    Footer.ValueType = fvtCount
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21830#21697#21517#31216
                    Width = 122
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BARCODE'
                    Footers = <>
                    Title.Caption = #26465#30721
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_ID'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #35745#37327#21333#20301
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'NEW_OUTPRICE'
                    Footers = <>
                    Title.Caption = #26631#20934#21806#20215
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'NEW_INPRICE'
                    Footers = <>
                    Title.Caption = #26631#20934#36827#20215
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'NEW_LOWPRICE'
                    Footers = <>
                    Title.Caption = #26368#20302#21806#20215
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SECOND_ID'
                    Footers = <>
                    Title.Caption = #21830#21697#23545#29031#30721
                    Width = 108
                  end>
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 828
    inherited Image1: TImage
      Left = 525
      Width = 283
    end
    inherited Image3: TImage
      Left = 525
      Width = 283
    end
    inherited Image14: TImage
      Left = 808
    end
    inherited rzPanel5: TPanel
      Left = 525
      inherited lblToolCaption: TRzLabel
        Width = 60
        Caption = #20379#24212#38142#26723#26696
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 505
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 505
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 505
        ButtonWidth = 43
        object ToolButton2: TToolButton
          Left = 0
          Top = 0
          Action = actNew
        end
        object ToolButton6: TToolButton
          Left = 43
          Top = 0
          Action = actCancel
        end
        object ToolButton14: TToolButton
          Left = 86
          Top = 0
          Width = 9
          Caption = 'ToolButton14'
          ImageIndex = 14
          Style = tbsSeparator
        end
        object ToolButton4: TToolButton
          Left = 95
          Top = 0
          Action = actEdit
        end
        object ToolButton1: TToolButton
          Left = 138
          Top = 0
          Action = actInfo
        end
        object ToolButton5: TToolButton
          Left = 181
          Top = 0
          Action = actDelete
        end
        object ToolButton7: TToolButton
          Left = 224
          Top = 0
          Width = 10
          Caption = 'ToolButton7'
          ImageIndex = 3
          Style = tbsDivider
        end
        object ToolButton3: TToolButton
          Left = 234
          Top = 0
          Action = actSave
        end
        object ToolButton12: TToolButton
          Left = 277
          Top = 0
          Action = actAudit
          Caption = #23545#29031
        end
        object ToolButton13: TToolButton
          Left = 320
          Top = 0
          Action = actModify
        end
        object ToolButton11: TToolButton
          Left = 363
          Top = 0
          Width = 13
          Caption = 'ToolButton11'
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton8: TToolButton
          Left = 376
          Top = 0
          Action = actPrint
        end
        object ToolButton9: TToolButton
          Left = 419
          Top = 0
          Action = actPreview
        end
        object ToolButton10: TToolButton
          Left = 462
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
      ImageIndex = 16
      OnExecute = actNewExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
    inherited actEdit: TAction
      Caption = #21019#24314
      ImageIndex = 0
      OnExecute = actEditExecute
    end
    inherited actSave: TAction
      Caption = #21457#24067
      OnExecute = actSaveExecute
    end
    inherited actCancel: TAction
      Caption = #19979#36733
      ImageIndex = 39
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
    inherited actAudit: TAction
      ImageIndex = 31
    end
    object actModify: TAction
      Caption = #20462#25913
      ImageIndex = 47
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
