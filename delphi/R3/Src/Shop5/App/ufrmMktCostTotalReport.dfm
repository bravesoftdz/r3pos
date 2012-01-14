inherited frmMktCostTotalReport: TfrmMktCostTotalReport
  Left = 192
  Top = 105
  Width = 958
  Height = 558
  Caption = #36153#29992#20998#26512#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 950
    Height = 494
    inherited RzPanel2: TRzPanel
      Width = 940
      Height = 484
      inherited RzPage: TRzPageControl
        Width = 735
        Height = 478
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #36153#29992#20998#26512#25253#34920
          inherited RzPanel3: TRzPanel
            Width = 733
            Height = 451
            inherited Panel4: TPanel
              Width = 723
              Height = 441
              inherited w1: TRzPanel
                Width = 723
                Height = 105
                object Label3: TLabel
                  Left = 16
                  Top = 12
                  Width = 48
                  Height = 12
                  Caption = #25253#34920#26679#24335
                end
                object RzLabel1: TRzLabel
                  Left = 16
                  Top = 38
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #26597#35810#26085#26399
                end
                object RzLabel12: TRzLabel
                  Left = 162
                  Top = 38
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label13: TLabel
                  Left = 282
                  Top = 60
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object Label14: TLabel
                  Left = 282
                  Top = 83
                  Width = 48
                  Height = 12
                  Caption = #23458#25143#21517#31216
                end
                object Label8: TLabel
                  Left = 16
                  Top = 60
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #32771#26680#25351#26631
                end
                object Label10: TLabel
                  Left = 16
                  Top = 83
                  Width = 48
                  Height = 12
                  Caption = #23458#25143#20998#32452
                end
                object Label28: TLabel
                  Left = 281
                  Top = 39
                  Width = 48
                  Height = 12
                  Caption = #36153#29992#31867#22411
                end
                object rptTemplate: TcxComboBox
                  Left = 72
                  Top = 8
                  Width = 193
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  TabOrder = 0
                end
                object btnNew: TRzBitBtn
                  Left = 282
                  Top = 7
                  Width = 48
                  Height = 21
                  Caption = #28155#21152
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
                  OnClick = btnNewClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object btnEdit: TRzBitBtn
                  Left = 331
                  Top = 7
                  Width = 48
                  Height = 21
                  Caption = #20462#25913
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
                  TabOrder = 2
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnEditClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 502
                  Top = 67
                  Width = 72
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
                  TabOrder = 4
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object btnDelete: TRzBitBtn
                  Left = 380
                  Top = 7
                  Width = 48
                  Height = 21
                  Caption = #21024#38500
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
                  TabOrder = 3
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnDeleteClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_DEPT_ID: TzrComboBoxList
                  Left = 335
                  Top = 56
                  Width = 156
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
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP1_CLIENT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 335
                  Top = 78
                  Width = 156
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 6
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'CLIENT_ID;CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
                  KeyField = 'CLIENT_ID'
                  ListField = 'CLIENT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'CLIENT_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CLIENT_SPELL'
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
                object fndP1_CUST_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 146
                  Top = 78
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 7
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
                object fndP1_KPI_ID: TzrComboBoxList
                  Tag = -1
                  Left = 72
                  Top = 56
                  Width = 193
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 8
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'KPI_ID;KPI_NAME'
                  KeyField = 'KPI_ID'
                  ListField = 'KPI_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'KPI_NAME'
                      Footers = <>
                      Title.Caption = #25351#26631#21517#31216
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
                  RangeField = 'IDX_TYPE'
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP1_CUST_TYPE: TcxComboBox
                  Left = 72
                  Top = 78
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #23458#25143#31561#32423
                    #23458#25143#20998#31867
                    #23458#25143#32676#20307)
                  TabOrder = 9
                end
                object fndP1_REQU_TYPE: TcxComboBox
                  Left = 335
                  Top = 34
                  Width = 156
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #23458#25143#31561#32423
                    #23458#25143#20998#31867
                    #23458#25143#32676#20307)
                  TabOrder = 10
                end
                object P1_D1: TcxDateEdit
                  Left = 72
                  Top = 34
                  Width = 85
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 11
                end
                object P1_D2: TcxDateEdit
                  Left = 179
                  Top = 34
                  Width = 86
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 12
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 105
                Width = 723
                Height = 336
                inherited DBGridEh1: TDBGridEh
                  Width = 719
                  Height = 332
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 738
        Height = 478
        Visible = False
        inherited Panel2: TPanel
          Height = 444
          inherited Panel5: TPanel
            Height = 329
            inherited rzShowColumns: TRzCheckList
              Height = 325
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 950
    inherited Image14: TImage
      Left = 930
    end
    inherited Image1: TImage
      Width = 580
    end
  end
  inherited mmMenu: TMainMenu
    Left = 112
    Top = 224
  end
  inherited actList: TActionList
    Left = 144
    Top = 224
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    object actTemplate: TAction
      Caption = #34920#26679
    end
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    Left = 200
    Top = 248
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
