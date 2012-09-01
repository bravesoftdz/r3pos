inherited frmCheckTablePrint: TfrmCheckTablePrint
  Left = 191
  Top = 108
  Width = 1078
  Height = 625
  Caption = #30424#28857#23545#29031#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1070
    Height = 561
    inherited RzPanel2: TRzPanel
      Width = 1060
      Height = 551
      inherited RzPage: TRzPageControl
        Width = 855
        Height = 545
        Color = clCream
        ParentColor = False
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clCream
          Caption = #30424#28857#23545#29031#34920
          inherited RzPanel3: TRzPanel
            Width = 853
            Height = 518
            Caption = '`'
            inherited Panel4: TPanel
              Width = 843
              Height = 508
              inherited w1: TRzPanel
                Width = 843
                Height = 76
                object Label3: TLabel
                  Left = 24
                  Top = 10
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label6: TLabel
                  Left = 281
                  Top = 10
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object Label8: TLabel
                  Left = 281
                  Top = 31
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                end
                object Label19: TLabel
                  Left = 24
                  Top = 51
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label4: TLabel
                  Left = 24
                  Top = 31
                  Width = 48
                  Height = 12
                  Caption = #30424#28857#26085#26399
                end
                object btnOk: TRzBitBtn
                  Left = 486
                  Top = 38
                  Width = 67
                  Height = 29
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
                object fndP1_UNIT_ID: TcxComboBox
                  Left = 337
                  Top = 27
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 3
                end
                object fndP1_SORT_ID: TcxButtonEdit
                  Left = 337
                  Top = 6
                  Width = 121
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP1_SORT_IDPropertiesButtonClick
                  TabOrder = 1
                  OnKeyPress = fndP1_SORT_IDKeyPress
                end
                object fndP1_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 6
                  Width = 185
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  Properties.OnEditValueChanged = fndP1_SHOP_IDPropertiesEditValueChanged
                  TabOrder = 0
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
                  KeyField = 'SHOP_ID'
                  ListField = 'SHOP_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_ID'
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
                object fndP1_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 48
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 4
                end
                object fndP1_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 48
                  Width = 111
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 5
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
                  KeyField = 'CODE_ID'
                  ListField = 'CODE_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SORT_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                      Width = 120
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
                object fndP1_SHOW_ZERO: TcxCheckBox
                  Left = 277
                  Top = 48
                  Width = 173
                  Height = 21
                  Properties.DisplayUnchecked = 'False'
                  Properties.Caption = #26159#21542#26174#31034#38646#24211#23384#30340#21830#21697
                  TabOrder = 6
                end
                object fndP1_PRINT_DATE: TzrComboBoxList
                  Left = 80
                  Top = 27
                  Width = 185
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
                  FilterFields = 'PRINT_DATE'
                  KeyField = 'PRINT_DATE'
                  ListField = 'PRINT_DATE'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'PRINT_DATE'
                      Footers = <>
                      Title.Caption = #30424#28857#26085#26399
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CHECK_STATUS'
                      Footers = <>
                      KeyList.Strings = (
                        '1'
                        '2'
                        '3')
                      PickList.Strings = (
                        #24453#30424#28857
                        #24050#30424#28857
                        #24050#23457#26680)
                      Title.Caption = #29366#24577
                      Width = 40
                    end>
                  DropWidth = 120
                  DropHeight = 120
                  ShowTitle = False
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  OnBeforeDropList = fndP1_PRINT_DATEBeforeDropList
                  MultiSelect = False
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 76
                Width = 843
                Height = 432
                inherited DBGridEh1: TDBGridEh
                  Width = 839
                  Height = 428
                  FrozenCols = 3
                  OnGetFooterParams = DBGridEh1GetFooterParams
                  OnTitleClick = DBGridEh1TitleClick
                  Columns = <
                    item
                      Alignment = taCenter
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
                      Title.Caption = #36135#21495
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = #26465#30721
                      Width = 99
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 156
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BATCH_NO'
                      Footers = <>
                      Title.Caption = #25209#21495
                      Width = 66
                    end
                    item
                      EditButtons = <>
                      FieldName = 'PROPERTY_01'
                      Footers = <>
                      Title.Caption = #23610#30721
                      Width = 49
                    end
                    item
                      EditButtons = <>
                      FieldName = 'PROPERTY_02'
                      Footers = <>
                      Title.Caption = #39068#33394
                      Width = 48
                    end
                    item
                      EditButtons = <>
                      FieldName = 'UNIT_ID'
                      Footers = <>
                      Title.Caption = #21333#20301
                      Width = 32
                    end
                    item
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'RCK_AMOUNT'
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24080#38754#24211#23384
                      Width = 59
                    end
                    item
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'CHK_AMOUNT'
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #23454#29289#24211#23384
                    end
                    item
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'PAL_AMOUNT'
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #30424#28857#25439#30410
                      Width = 61
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'NEW_INPRICE'
                      Footers = <>
                      Title.Caption = #25104#26412#20215
                      Width = 48
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'NEW_OUTPRICE'
                      Footers = <>
                      Title.Caption = #38646#21806#20215
                      Width = 51
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'PAL_INAMONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #36827#36135#37329#39069
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'PAL_OUTAMONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 858
        Height = 545
        inherited Panel2: TPanel
          Height = 502
          inherited Image5: TImage
            Top = 78
          end
          inherited Label1: TLabel
            Top = 86
          end
          inherited Label2: TLabel
            Top = 86
          end
          inherited RzPanel1: TRzPanel [3]
            Height = 76
            inherited Label27: TLabel
              Top = 8
            end
          end
          inherited Panel5: TPanel [4]
            Top = 103
            Height = 393
            inherited rzShowColumns: TRzCheckList
              Height = 389
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 1070
    inherited Image3: TImage
      Left = 434
    end
    inherited Image14: TImage
      Left = 1050
    end
    inherited Image1: TImage
      Left = 434
      Width = 616
    end
    inherited rzPanel5: TPanel
      Left = 434
      inherited lblToolCaption: TRzLabel
        Width = 60
        Caption = #30424#28857#23545#29031#34920
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 414
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 414
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 414
        ButtonWidth = 55
        inherited ToolButton1: TToolButton
          Caption = #26597#35810'(&S)'
        end
        inherited ToolButton2: TToolButton
          Left = 55
        end
        inherited ToolButton6: TToolButton
          Left = 110
        end
        inherited ToolButton5: TToolButton
          Left = 165
        end
        inherited ToolButton3: TToolButton
          Left = 173
        end
        inherited ToolButton9: TToolButton
          Left = 241
        end
        inherited ToolButton10: TToolButton
          Left = 296
        end
        inherited ToolButton8: TToolButton
          Left = 351
        end
        inherited ToolButton4: TToolButton
          Left = 359
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 160
    Top = 392
  end
  inherited actList: TActionList
    Left = 192
    Top = 392
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited dsadoReport1: TDataSource
    Left = 41
    Top = 354
  end
  inherited SaveDialog1: TSaveDialog
    Left = 317
    Top = 172
  end
  inherited adoReport1: TZQuery
    Left = 41
    Top = 321
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
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
