inherited frmSaleAnaly: TfrmSaleAnaly
  Left = 199
  Top = 103
  Width = 984
  Height = 667
  Caption = #38144#21806#20998#26512#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 976
    Height = 604
    inherited RzPanel2: TRzPanel
      Width = 966
      Height = 594
      inherited RzPage: TRzPageControl
        Width = 960
        Height = 588
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #33829#38144#27010#20917
          inherited RzPanel3: TRzPanel
            Width = 958
            Height = 561
            inherited Panel4: TPanel
              Width = 948
              Height = 551
              inherited w1: TRzPanel
                Width = 948
                Height = 97
                object RzLabel2: TRzLabel
                  Left = 25
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24320#22987#26085#26399
                end
                object Label5: TLabel
                  Left = 25
                  Top = 34
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38376#24215#32676#32452
                end
                object Label7: TLabel
                  Left = 25
                  Top = 54
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#25351#26631
                end
                object RzLabel3: TRzLabel
                  Left = 164
                  Top = 12
                  Width = 48
                  Height = 12
                  Caption = #25130#27490#26085#26399
                end
                object Label6: TLabel
                  Left = 317
                  Top = 32
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#20998#31867
                end
                object Label31: TLabel
                  Left = 25
                  Top = 77
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#21517#31216
                end
                object Label1: TLabel
                  Left = 317
                  Top = 75
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #26597#30475#26041#24335
                end
                object Label3: TLabel
                  Left = 317
                  Top = 54
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#31867#22411
                end
                object Label32: TLabel
                  Left = 316
                  Top = 13
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object fndP1_TYPE_ID: TcxComboBox
                  Left = 78
                  Top = 51
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 0
                end
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 78
                  Top = 30
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 1
                end
                object P1_D1: TcxDateEdit
                  Left = 78
                  Top = 8
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 2
                end
                object fndP1_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 162
                  Top = 30
                  Width = 136
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 3
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 162
                  Top = 51
                  Width = 136
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 4
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
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
                object P1_D2: TcxDateEdit
                  Left = 216
                  Top = 8
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 5
                end
                object fndP1_GODS_ID: TzrComboBoxList
                  Tag = 100
                  Left = 78
                  Top = 72
                  Width = 220
                  Height = 20
                  TabStop = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 6
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
                  Buttons = [zbNew, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_SORT_ID: TcxButtonEdit
                  Left = 368
                  Top = 28
                  Width = 166
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP1_SORT_IDPropertiesButtonClick
                  TabOrder = 7
                  OnKeyPress = fndP1_SORT_IDKeyPress
                end
                object btnOk: TRzBitBtn
                  Left = 553
                  Top = 64
                  Width = 67
                  Height = 27
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
                  TabOrder = 8
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object RzPanel9: TRzPanel
                  Left = 369
                  Top = 71
                  Width = 164
                  Height = 20
                  BorderInner = fsFlat
                  BorderOuter = fsNone
                  Color = clWhite
                  FlatColor = 6956042
                  GridColor = clGray
                  TabOrder = 9
                  object RB_hour: TcxRadioButton
                    Left = 3
                    Top = 2
                    Width = 61
                    Height = 17
                    Caption = #25353#23567#26102
                    Checked = True
                    TabOrder = 0
                    TabStop = True
                  end
                  object RB_week: TcxRadioButton
                    Left = 83
                    Top = 2
                    Width = 57
                    Height = 17
                    Caption = #25353#26143#26399
                    TabOrder = 1
                  end
                end
                object RzPanel6: TRzPanel
                  Left = 369
                  Top = 49
                  Width = 164
                  Height = 20
                  BorderInner = fsFlat
                  BorderOuter = fsNone
                  Color = clWhite
                  FlatColor = 6956042
                  GridColor = clGray
                  TabOrder = 10
                  object RB_all: TcxRadioButton
                    Left = 3
                    Top = 2
                    Width = 45
                    Height = 17
                    Caption = #20840#37096
                    Checked = True
                    TabOrder = 0
                    TabStop = True
                  end
                  object RB_sale: TcxRadioButton
                    Left = 59
                    Top = 2
                    Width = 44
                    Height = 17
                    Caption = #38646#21806
                    TabOrder = 1
                  end
                  object RB_batch: TcxRadioButton
                    Left = 116
                    Top = 2
                    Width = 45
                    Height = 17
                    Caption = #25209#21457
                    TabOrder = 2
                  end
                end
                object fndP1_DEPT_ID: TzrComboBoxList
                  Left = 368
                  Top = 8
                  Width = 166
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 11
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'DEPT_NAME;DEPT_SPELL'
                  KeyField = 'DEPT_ID'
                  ListField = 'DEPT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                  RangeField = 'DEPT_TYPE'
                  RangeValue = '1'
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 97
                Width = 948
                Height = 454
                OnResize = RzPanel7Resize
                object Pnl_Mm: TRzPanel
                  Left = 2
                  Top = 265
                  Width = 944
                  Height = 187
                  Align = alClient
                  BorderOuter = fsGroove
                  BorderSides = []
                  Color = clWhite
                  TabOrder = 0
                  object AnalyInfo: TcxMemo
                    Left = 0
                    Top = 24
                    Width = 944
                    Height = 163
                    Align = alClient
                    Properties.ReadOnly = True
                    Style.Font.Charset = GB2312_CHARSET
                    Style.Font.Color = clWindowText
                    Style.Font.Height = -12
                    Style.Font.Name = #23435#20307
                    Style.Font.Style = []
                    TabOrder = 0
                  end
                  object RzTool: TRzPanel
                    Left = 0
                    Top = 0
                    Width = 944
                    Height = 24
                    Align = alTop
                    BorderOuter = fsGroove
                    BorderSides = []
                    TabOrder = 1
                    object Label2: TLabel
                      Left = 57
                      Top = 6
                      Width = 60
                      Height = 12
                      Caption = #26597#30475#25968#20540#65306
                    end
                    object Label4: TLabel
                      Left = 307
                      Top = 7
                      Width = 72
                      Height = 12
                      Caption = #38144#21806#39069#21333#20301#65306
                    end
                    object RB_SaleMoney: TcxRadioButton
                      Left = 126
                      Top = 4
                      Width = 62
                      Height = 17
                      Caption = #39069#38144#21806
                      Checked = True
                      TabOrder = 0
                      TabStop = True
                      OnClick = RB_SaleMoneyClick
                    end
                    object RB_SaleMount: TcxRadioButton
                      Left = 197
                      Top = 4
                      Width = 62
                      Height = 17
                      Caption = #38144#21806#37327
                      TabOrder = 1
                      OnClick = RB_SaleMoneyClick
                    end
                    object Sale_UNIT: TcxComboBox
                      Left = 378
                      Top = 3
                      Width = 95
                      Height = 20
                      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                      Properties.DropDownListStyle = lsFixedList
                      Properties.Items.Strings = (
                        #20803
                        #19975#20803)
                      Properties.OnChange = Sale_UNITPropertiesChange
                      TabOrder = 2
                    end
                  end
                end
                object Pnl_Char: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 944
                  Height = 263
                  Align = alTop
                  BorderOuter = fsGroove
                  BorderSides = []
                  Color = clWhite
                  TabOrder = 1
                  object Chart1: TChart
                    Left = 0
                    Top = 0
                    Width = 944
                    Height = 263
                    BackWall.Brush.Color = clWhite
                    BackWall.Brush.Style = bsClear
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clBlue
                    Title.Font.Height = -16
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = [fsBold]
                    Title.Text.Strings = (
                      '')
                    Title.Visible = False
                    Legend.Alignment = laBottom
                    Legend.TextStyle = ltsRightValue
                    Legend.Visible = False
                    View3D = False
                    Align = alClient
                    BevelOuter = bvLowered
                    Color = clWhite
                    TabOrder = 0
                    object BarSeries1: TBarSeries
                      Marks.ArrowLength = 20
                      Marks.Style = smsValue
                      Marks.Visible = False
                      SeriesColor = clRed
                      Title = #38144#37327
                      MultiBar = mbNone
                      XValues.DateTime = False
                      XValues.Name = 'X'
                      XValues.Multiplier = 1.000000000000000000
                      XValues.Order = loAscending
                      YValues.DateTime = False
                      YValues.Name = 'Bar'
                      YValues.Multiplier = 1.000000000000000000
                      YValues.Order = loNone
                    end
                    object BarSeries2: TBarSeries
                      Marks.ArrowLength = 20
                      Marks.Visible = True
                      SeriesColor = clGreen
                      Title = #37329#39069
                      XValues.DateTime = False
                      XValues.Name = 'X'
                      XValues.Multiplier = 1.000000000000000000
                      XValues.Order = loAscending
                      YValues.DateTime = False
                      YValues.Name = 'Bar'
                      YValues.Multiplier = 1.000000000000000000
                      YValues.Order = loNone
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
    Width = 976
    inherited Image1: TImage
      Width = 606
    end
    inherited Image3: TImage
      Width = 606
    end
    inherited Image14: TImage
      Left = 956
    end
    inherited CoolBar1: TCoolBar
      inherited ToolBar1: TToolBar
        inherited ToolButton5: TToolButton
          Visible = False
        end
        inherited ToolButton3: TToolButton
          Visible = False
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 16
    Top = 464
  end
  inherited actList: TActionList
    Left = 48
    Top = 464
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited dsadoReport1: TDataSource
    Left = 41
    Top = 234
  end
  inherited SaveDialog1: TSaveDialog
    Left = 389
    Top = 4
  end
  inherited adoReport1: TZQuery
    Left = 40
    Top = 204
  end
  object AnalyQry1: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 40
    Top = 172
  end
end
