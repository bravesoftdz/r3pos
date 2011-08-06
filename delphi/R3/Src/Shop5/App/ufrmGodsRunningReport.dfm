inherited frmGodsRunningReport: TfrmGodsRunningReport
  Left = -8
  Top = -8
  Width = 1292
  Height = 776
  Caption = #21830#21697#27969#27700#24080#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1276
    Height = 701
    inherited RzPanel2: TRzPanel
      Width = 1266
      Height = 691
      inherited RzPage: TRzPageControl
        Width = 1061
        Height = 685
        Color = clCream
        ParentColor = False
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clCream
          Caption = #21830#21697#27969#27700#24080#25253#34920
          inherited RzPanel3: TRzPanel
            Width = 1059
            Height = 658
            inherited Panel4: TPanel
              Width = 1049
              Height = 648
              Color = clBtnFace
              inherited w1: TRzPanel
                Width = 1049
                Height = 82
                TabOrder = 1
                object RzLabel2: TRzLabel
                  Left = 22
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #27969#27700#26085#26399
                end
                object RzLabel3: TRzLabel
                  Left = 176
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label5: TLabel
                  Left = 301
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label3: TLabel
                  Left = 22
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#21517#31216
                end
                object Label4: TLabel
                  Left = 301
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label6: TLabel
                  Left = 22
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = #26465' '#24418' '#30721
                end
                object Label8: TLabel
                  Left = 920
                  Top = 58
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object btnOk: TRzBitBtn
                  Left = 571
                  Top = 41
                  Width = 73
                  Height = 32
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
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 352
                  Top = 32
                  Width = 76
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 3
                end
                object fndP1_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 429
                  Top = 32
                  Width = 127
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
                object P1_D1: TcxDateEdit
                  Left = 79
                  Top = 10
                  Width = 90
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 193
                  Top = 10
                  Width = 90
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object fndP1_GODS_ID: TzrComboBoxList
                  Left = 79
                  Top = 32
                  Width = 204
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
                  Buttons = [zbNew, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_BarType_ID: TcxComboBox
                  Left = 79
                  Top = 54
                  Width = 76
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #29289#27969#36319#36394#21495
                    #25209#21495)
                  TabOrder = 5
                end
                object fndP1_BarCode: TcxTextEdit
                  Left = 155
                  Top = 54
                  Width = 128
                  Height = 20
                  TabOrder = 6
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object fndP1_SHOP_ID: TzrComboBoxList
                  Left = 352
                  Top = 54
                  Width = 205
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
                      FieldName = 'SEQ_NO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_UNIT_ID: TcxComboBox
                  Left = 970
                  Top = 54
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 9
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 82
                Width = 1049
                Height = 566
                Color = clBtnFace
                TabOrder = 0
                inherited DBGridEh1: TDBGridEh
                  Width = 1045
                  Height = 562
                  FrozenCols = 3
                  OnDblClick = DBGridEh1DblClick
                  OnGetFooterParams = DBGridEh1GetFooterParams
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
                      Width = 65
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 113
                    end
                    item
                      EditButtons = <>
                      FieldName = 'ORDER_TYPE'
                      Footers = <>
                      Title.Caption = #21333#25454#31867#22411
                      Width = 58
                    end
                    item
                      DisplayFormat = '0000-00-00'
                      EditButtons = <>
                      FieldName = 'CREA_DATE'
                      Footers = <>
                      Title.Caption = #21333#25454#26085#26399
                      Width = 69
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CLIENT_NAME'
                      Footers = <>
                      Title.Caption = #23458#25143'/'#20379#24212#21830
                      Width = 103
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = ' #0.###'
                      EditButtons = <>
                      FieldName = 'ORG_AMT'
                      Footer.DisplayFormat = ' #0.###'
                      Footers = <>
                      Title.Caption = #26399#21021#25968#37327
                      Width = 70
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = ' #0.###'
                      EditButtons = <>
                      FieldName = 'IN_AMT'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = ' #0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #25910#20837#25968#37327
                      Width = 70
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = ' #0.###'
                      EditButtons = <>
                      FieldName = 'OUT_AMT'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = ' #0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #21457#20986#25968#37327
                      Width = 70
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = ' #0.###'
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = ' #0.###'
                      Footers = <>
                      Title.Caption = #32467#23384#25968#37327
                      Width = 80
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'APRICE'
                      Footer.DisplayFormat = '#0.00#'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #21333#20215
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'AMONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #37329#39069
                      Width = 85
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BATCH_NO'
                      Footers = <>
                      Title.Caption = #25209#21495
                      Width = 104
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = #26465#30721
                      Width = 93
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GLIDE_NO'
                      Footers = <>
                      Title.Caption = #21333#21495
                      Width = 107
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = #32463#25163#38376#24215
                      Width = 79
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CREA_USER_TXT'
                      Footers = <>
                      Title.Caption = #32463#25163#20154
                      Width = 53
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 1064
        Height = 685
        inherited Panel2: TPanel
          Height = 653
          inherited RzPanel1: TRzPanel [3]
          end
          inherited Panel5: TPanel [4]
            Height = 538
            inherited rzShowColumns: TRzCheckList
              Height = 534
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 1276
    inherited Image1: TImage
      Width = 902
    end
    inherited Image3: TImage
      Width = 902
    end
    inherited Image14: TImage
      Left = 1256
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 84
        Caption = #21830#21697#27969#27700#24080#25253#34920
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 128
    Top = 400
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
    Left = 229
    Top = 340
  end
  inherited adoReport1: TZQuery
    Left = 41
    Top = 321
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    Left = 72
    Top = 320
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
