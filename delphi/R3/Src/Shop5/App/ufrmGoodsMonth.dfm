inherited frmGoodsMonth: TfrmGoodsMonth
  Left = 213
  Top = 140
  Width = 1046
  Height = 597
  Caption = #26376#25104#26412#35843#25972
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1038
    Height = 533
    inherited RzPanel2: TRzPanel
      Width = 1028
      Height = 523
      inherited RzPage: TRzPageControl
        Width = 1022
        Height = 517
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          inherited RzPanel3: TRzPanel
            Width = 1020
            Height = 490
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 1010
              Height = 480
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 0
              object RzPanel6: TRzPanel
                Left = 0
                Top = 0
                Width = 1010
                Height = 480
                Align = alClient
                BorderOuter = fsNone
                TabOrder = 0
                object Splitter1: TSplitter
                  Left = 177
                  Top = 41
                  Height = 439
                end
                object RzPanel7: TRzPanel
                  Left = 0
                  Top = 41
                  Width = 177
                  Height = 439
                  Align = alLeft
                  BorderOuter = fsNone
                  TabOrder = 0
                  object rzTree: TRzTreeView
                    Left = 0
                    Top = 0
                    Width = 177
                    Height = 439
                    SelectionPen.Color = clBtnShadow
                    Align = alClient
                    FrameSides = [sdLeft, sdRight, sdBottom]
                    FrameStyle = fsGroove
                    FrameVisible = True
                    HideSelection = False
                    Indent = 19
                    ReadOnly = True
                    RowSelect = True
                    TabOrder = 0
                    OnChange = rzTreeChange
                  end
                end
                object RzPanel8: TRzPanel
                  Left = 180
                  Top = 41
                  Width = 830
                  Height = 439
                  Align = alClient
                  BorderOuter = fsNone
                  TabOrder = 1
                  object Panel1: TPanel
                    Left = 0
                    Top = 0
                    Width = 830
                    Height = 439
                    Align = alClient
                    Caption = 'Panel1'
                    TabOrder = 0
                    object dbGoodsMonth: TDBGridEh
                      Left = 1
                      Top = 1
                      Width = 828
                      Height = 437
                      Align = alClient
                      AllowedOperations = [alopUpdateEh]
                      DataSource = DsGoodsMonth
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
                      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                      PopupMenu = PopupMenu1
                      RowHeight = 23
                      SumList.Active = True
                      TabOrder = 0
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
                      OnDrawColumnCell = dbGoodsMonthDrawColumnCell
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
                          Visible = False
                          Width = 21
                        end
                        item
                          EditButtons = <>
                          FieldName = 'SEQNO'
                          Footers = <>
                          Title.Caption = #24207#21495
                          Width = 30
                        end
                        item
                          EditButtons = <>
                          FieldName = 'GODS_CODE'
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #36135#21495
                          Width = 60
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
                          FieldName = 'GODS_NAME'
                          Footer.ValueType = fvtCount
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #21830#21697#21517#31216
                          Width = 150
                        end
                        item
                          EditButtons = <>
                          FieldName = 'UNIT_ID'
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #21333#20301
                          Width = 30
                        end
                        item
                          Alignment = taRightJustify
                          DisplayFormat = '#0.###'
                          EditButtons = <>
                          FieldName = 'BAL_AMT'
                          Footer.Alignment = taRightJustify
                          Footer.DisplayFormat = '#0.###'
                          Footer.ValueType = fvtSum
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #32467#20313#25968#37327
                          Width = 60
                        end
                        item
                          Alignment = taRightJustify
                          DisplayFormat = '#0.00'
                          EditButtons = <>
                          FieldName = 'BAL_PRICE'
                          Footer.Alignment = taRightJustify
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #32467#23384#21333#20215
                          Width = 67
                        end
                        item
                          DisplayFormat = '#0.00'
                          EditButtons = <>
                          FieldName = 'BAL_CST'
                          Footer.DisplayFormat = '#0.00'
                          Footer.ValueType = fvtSum
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #32467#23384#25104#26412
                        end
                        item
                          DisplayFormat = '#0.00'
                          EditButtons = <>
                          FieldName = 'ADJ_PRICE'
                          Footers = <>
                          Title.Caption = #35843#25972#21518#21333#20215
                          OnUpdateData = dbGoodsMonthColumns9UpdateData
                        end
                        item
                          DisplayFormat = '#0.00'
                          EditButtons = <>
                          FieldName = 'ADJ_MNY'
                          Footer.DisplayFormat = '#0.00'
                          Footer.ValueType = fvtSum
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #35843#25972#21518#37329#39069
                        end
                        item
                          DisplayFormat = '#0.00'
                          EditButtons = <>
                          FieldName = 'ADJ_CST'
                          Footer.DisplayFormat = '#0.00'
                          Footer.ValueType = fvtSum
                          Footers = <>
                          ReadOnly = True
                          Title.Caption = #35843#25972#21518#25104#26412
                        end>
                    end
                  end
                end
                object RzPanel9: TRzPanel
                  Left = 0
                  Top = 0
                  Width = 1010
                  Height = 41
                  Align = alTop
                  BorderOuter = fsNone
                  BorderSides = [sdBottom]
                  TabOrder = 2
                  object Panel3: TPanel
                    Left = 0
                    Top = 0
                    Width = 178
                    Height = 41
                    Align = alLeft
                    BevelInner = bvLowered
                    Caption = #25104#26412#35843#25972
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
                    Left = 178
                    Top = 0
                    Width = 832
                    Height = 41
                    Align = alClient
                    Alignment = taLeftJustify
                    BevelInner = bvLowered
                    ParentColor = True
                    TabOrder = 1
                    object Label25: TLabel
                      Left = 8
                      Top = 16
                      Width = 48
                      Height = 12
                      Caption = #21830#21697#25351#26631
                      Font.Charset = GB2312_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -12
                      Font.Name = #23435#20307
                      Font.Style = []
                      ParentFont = False
                    end
                    object Label1: TLabel
                      Left = 272
                      Top = 16
                      Width = 24
                      Height = 12
                      Caption = #26376#20221
                      Font.Charset = GB2312_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -12
                      Font.Name = #23435#20307
                      Font.Style = []
                      ParentFont = False
                    end
                    object btnOk: TRzBitBtn
                      Left = 424
                      Top = 10
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
                      TabOrder = 0
                      TextStyle = tsRaised
                      ThemeAware = False
                      ImageIndex = 12
                      NumGlyphs = 2
                      Spacing = 5
                    end
                    object edtGoods_Type: TcxComboBox
                      Left = 64
                      Top = 12
                      Width = 73
                      Height = 20
                      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                      ParentFont = False
                      Properties.DropDownListStyle = lsEditFixedList
                      Properties.OnChange = edtGoods_TypePropertiesChange
                      TabOrder = 1
                    end
                    object edtGoods_ID: TzrComboBoxList
                      Tag = -1
                      Left = 136
                      Top = 12
                      Width = 119
                      Height = 20
                      ParentFont = False
                      Properties.AutoSelect = False
                      Properties.Buttons = <
                        item
                          Default = True
                        end>
                      Properties.ReadOnly = False
                      TabOrder = 2
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
                          Title.Caption = #21517#31216
                        end>
                      DropWidth = 185
                      DropHeight = 180
                      ShowTitle = True
                      AutoFitColWidth = True
                      ShowButton = True
                      LocateStyle = lsDark
                      Buttons = [zbClear]
                      DropListStyle = lsFixed
                      MultiSelect = False
                    end
                    object edtMonth: TzrMonthEdit
                      Left = 304
                      Top = 12
                      Width = 101
                      Height = 20
                      Properties.Buttons = <
                        item
                          Default = True
                        end>
                      Properties.ReadOnly = False
                      TabOrder = 3
                      Text = '2011-07'
                      Year = 0
                      Month = 0
                      asString = '000000'
                      asFormatString = '0000-00'
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 1038
    inherited Image1: TImage
      Left = 158
      Width = 860
    end
    inherited Image3: TImage
      Left = 158
      Width = 860
    end
    inherited Image14: TImage
      Left = 1018
    end
    inherited rzPanel5: TPanel
      Left = 158
    end
    inherited CoolBar1: TCoolBar
      Width = 138
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 138
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 138
        ButtonWidth = 43
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actSave
          Caption = #25552#20132
        end
        object ToolButton3: TToolButton
          Left = 43
          Top = 0
          Action = actFind
        end
        object ToolButton4: TToolButton
          Left = 86
          Top = 0
          Width = 9
          Caption = 'ToolButton4'
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton2: TToolButton
          Left = 95
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited actList: TActionList
    inherited actSave: TAction
      OnExecute = actSaveExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  object DsGoodsMonth: TDataSource
    DataSet = CdsGoodsMonth
    Left = 295
    Top = 410
  end
  object CdsGoodsMonth: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 326
    Top = 410
  end
  object PopupMenu1: TPopupMenu
    Left = 682
    Top = 311
    object N1: TMenuItem
      Caption = #25209#37327#24405#20837'...'
      OnClick = N1Click
    end
  end
end
