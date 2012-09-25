inherited frmStockTotalReport: TfrmStockTotalReport
  Left = 200
  Top = 112
  Width = 955
  Height = 543
  Caption = #36827#36135#20998#26512#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 947
    Height = 479
    inherited RzPanel2: TRzPanel
      Width = 937
      Height = 469
      inherited RzPage: TRzPageControl
        Width = 732
        Height = 463
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #36827#36135#20998#26512#25253#34920
          inherited RzPanel3: TRzPanel
            Width = 730
            Height = 436
            inherited Panel4: TPanel
              Width = 720
              Height = 426
              inherited w1: TRzPanel
                Width = 720
                Height = 101
                object Label3: TLabel
                  Left = 24
                  Top = 37
                  Width = 48
                  Height = 12
                  Caption = #25253#34920#26679#24335
                end
                object RzLabel8: TRzLabel
                  Left = 24
                  Top = 13
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36827#36135#26085#26399
                end
                object RzLabel9: TRzLabel
                  Left = 171
                  Top = 13
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label21: TLabel
                  Left = 291
                  Top = 59
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label25: TLabel
                  Left = 24
                  Top = 80
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label26: TLabel
                  Left = 577
                  Top = 80
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object Label12: TLabel
                  Left = 24
                  Top = 59
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label13: TLabel
                  Left = 293
                  Top = 80
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#21517#31216
                end
                object rptTemplate: TcxComboBox
                  Left = 80
                  Top = 34
                  Width = 193
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  TabOrder = 2
                end
                object btnNew: TRzBitBtn
                  Left = 291
                  Top = 34
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
                  TabOrder = 13
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnNewClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object btnEdit: TRzBitBtn
                  Left = 340
                  Top = 34
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
                  TabOrder = 14
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnEditClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 481
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
                  TabOrder = 11
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object btnDelete: TRzBitBtn
                  Left = 389
                  Top = 34
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
                  TabOrder = 15
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnDeleteClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object P1_D1: TcxDateEdit
                  Left = 80
                  Top = 9
                  Width = 85
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 187
                  Top = 9
                  Width = 86
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object fndP1_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 76
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 6
                end
                object fndP1_UNIT_ID: TcxComboBox
                  Left = 627
                  Top = 76
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 10
                end
                object fndP1_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 76
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
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_SORT_ID: TcxButtonEdit
                  Left = 154
                  Top = 76
                  Width = 119
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = False
                  Properties.OnButtonClick = fndP1_SORT_IDPropertiesButtonClick
                  TabOrder = 8
                end
                object fndP1_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 344
                  Top = 55
                  Width = 124
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
                  FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL;SEQ_NO'
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
                      FieldName = 'SEQ_NO'
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
                object fndP1_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 55
                  Width = 119
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 55
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 3
                end
                inline P1_DateControl: TfrmDateControl
                  Left = 290
                  Top = 9
                  Width = 170
                  Height = 20
                  TabOrder = 12
                end
                object fndP1_GODS_ID: TzrComboBoxList
                  Tag = 100
                  Left = 344
                  Top = 76
                  Width = 124
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 9
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
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 101
                Width = 720
                Height = 325
                inherited DBGridEh1: TDBGridEh
                  Width = 716
                  Height = 321
                  OnGetFooterParams = DBGridEh1GetFooterParams
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 735
        Height = 463
        Visible = False
        inherited Panel2: TPanel
          Height = 429
          inherited Panel5: TPanel
            Height = 314
            inherited rzShowColumns: TRzCheckList
              Height = 310
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 947
    inherited Image14: TImage
      Left = 927
    end
    inherited Image1: TImage
      Width = 577
    end
  end
  inherited mmMenu: TMainMenu
    Left = 168
    Top = 171
  end
  inherited actList: TActionList
    Left = 200
    Top = 171
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    object actTemplate: TAction
      Caption = #34920#26679
    end
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    Top = 171
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
