inherited frmInvoiceTotalReport: TfrmInvoiceTotalReport
  Left = 197
  Top = 145
  Width = 999
  Height = 551
  Caption = #21457#31080#32479#35745#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 991
    Height = 487
    inherited RzPanel2: TRzPanel
      Width = 981
      Height = 477
      inherited RzPage: TRzPageControl
        Width = 776
        Height = 471
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #21457#31080#32479#35745#26597#35810#21015#34920
          inherited RzPanel3: TRzPanel
            Width = 774
            Height = 444
            inherited Panel4: TPanel
              Width = 764
              Height = 434
              inherited w1: TRzPanel
                Width = 764
                Height = 122
                object labINVH_NO: TRzLabel
                  Left = 24
                  Top = 100
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21457#31080#26412#21495
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object lab_SHOP_ID: TRzLabel
                  Left = 24
                  Top = 34
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #39046#29992#38376#24215
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel6: TRzLabel
                  Left = 166
                  Top = 78
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #39046#29992#20154
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel13: TRzLabel
                  Left = 24
                  Top = 56
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #39046#29992#37096#38376
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object labIDN_TYPE: TRzLabel
                  Left = 24
                  Top = 79
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21457#31080#31867#22411
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel1: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #39046#29992#26085#26399
                end
                object RzLabel12: TRzLabel
                  Left = 186
                  Top = 12
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label3: TLabel
                  Left = 181
                  Top = 100
                  Width = 120
                  Height = 12
                  Caption = #25903#25345#27169#22359','#36755#21518'4'#20301#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object fndINVH_NO: TcxTextEdit
                  Left = 80
                  Top = 96
                  Width = 99
                  Height = 20
                  Properties.MaxLength = 50
                  TabOrder = 6
                end
                object fndSHOP_ID: TzrComboBoxList
                  Left = 80
                  Top = 30
                  Width = 223
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
                  FilterFields = 'SHOP_NAME;SHOP_ID;SHOP_SPELL'
                  KeyField = 'SHOP_ID'
                  ListField = 'SHOP_NAME'
                  Columns = <
                    item
                      AutoDropDown = True
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = #38376#24215#21517#31216
                      Width = 120
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 30
                    end>
                  DropWidth = 151
                  DropHeight = 130
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbNew]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndCREA_USER: TzrComboBoxList
                  Left = 208
                  Top = 74
                  Width = 95
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
                  FilterFields = 'USER_ID;USER_NAME;USER_SPELL'
                  KeyField = 'USER_ID'
                  ListField = 'USER_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'ACCOUNT'
                      Footers = <>
                      Title.Caption = #36134#21495
                      Width = 70
                    end
                    item
                      AutoDropDown = True
                      EditButtons = <>
                      FieldName = 'USER_NAME'
                      Footers = <>
                      Title.Caption = #21517'  '#31216
                      Width = 80
                    end>
                  DropWidth = 151
                  DropHeight = 130
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndDEPT_ID: TzrComboBoxList
                  Left = 80
                  Top = 52
                  Width = 223
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
                  FilterFields = 'DEPT_ID;DEPT_NAME;DEPT_SPELL'
                  KeyField = 'DEPT_ID'
                  ListField = 'DEPT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Visible = False
                      Width = 30
                    end
                    item
                      AutoDropDown = True
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footers = <>
                      Title.Caption = #37096#38376#21517#31216
                      Width = 90
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_SEPLL'
                      Footers = <>
                      Title.Caption = #25340#38899#30721
                      Visible = False
                    end>
                  DropWidth = 176
                  DropHeight = 130
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbNew]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndINVOICE_FLAG: TcxComboBox
                  Left = 80
                  Top = 74
                  Width = 80
                  Height = 20
                  TabOrder = 4
                end
                object P1_D1: TcxDateEdit
                  Left = 80
                  Top = 8
                  Width = 100
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 203
                  Top = 8
                  Width = 100
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object BtnDept: TRzBitBtn
                  Left = 318
                  Top = 86
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
              end
              inherited RzPanel7: TRzPanel
                Top = 122
                Width = 764
                Height = 312
                inherited DBGridEh1: TDBGridEh
                  Width = 760
                  Height = 308
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SEQNO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 35
                    end
                    item
                      EditButtons = <>
                      FieldName = 'INVH_NO'
                      Footers = <>
                      Title.Caption = #21457#31080#26412#21495
                      Width = 150
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'LAST_TOTAL_AMT'
                      Footers = <>
                      Title.Caption = #26399#21021#24211#23384'|'#20221#25968
                      Width = 50
                    end
                    item
                      EditButtons = <>
                      FieldName = 'LAST_TOTAL_INVH_NO'
                      Footers = <>
                      Title.Caption = #26399#21021#24211#23384'|'#21457#31080#21495#30721
                      Width = 150
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'THIS_TOTAL_AMT'
                      Footers = <>
                      Title.Caption = #26412#26399#39046#21462'|'#20221#25968
                      Width = 50
                    end
                    item
                      EditButtons = <>
                      FieldName = 'THIS_TOTAL_INVH_NO'
                      Footers = <>
                      Title.Caption = #26412#26399#39046#21462'|'#21457#31080#21495#30721
                      Width = 150
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'USING_AMT'
                      Footers = <>
                      Title.Caption = #26412#26399#24320#20855'|'#20221#25968
                      Width = 50
                    end
                    item
                      EditButtons = <>
                      FieldName = 'USING_INVH_NO'
                      Footers = <>
                      Title.Caption = #26412#26399#24320#20855'|'#21457#31080#21495#30721
                      Width = 150
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'CANCEL_AMT'
                      Footers = <>
                      Title.Caption = #26412#26399#20316#24223'|'#20221#25968
                      Width = 50
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CANCEL_INVH_NO'
                      Footers = <>
                      Title.Caption = #26412#26399#20316#24223'|'#21457#31080#21495#30721
                      Width = 150
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'BALANCE'
                      Footers = <>
                      Title.Caption = #26399#26411#24211#23384'|'#20221#25968
                      Width = 50
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BALANCE_INVH_NO'
                      Footers = <>
                      Title.Caption = #26399#26411#24211#23384'|'#21457#31080#21495#30721
                      Width = 150
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 779
        Height = 471
        inherited Panel2: TPanel
          Height = 439
          inherited Panel5: TPanel
            Height = 324
            inherited rzShowColumns: TRzCheckList
              Height = 320
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 991
    inherited Image3: TImage
      Width = 209
    end
    inherited Image14: TImage
      Left = 971
    end
    inherited Image1: TImage
      Left = 559
    end
  end
  inherited mmMenu: TMainMenu
    Left = 90
    Top = 324
  end
  inherited actList: TActionList
    Left = 122
    Top = 324
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited dsadoReport1: TDataSource
    Left = 19
    Top = 354
  end
  inherited SaveDialog1: TSaveDialog
    Left = 55
    Top = 324
  end
  inherited adoReport1: TZQuery
    Left = 18
    Top = 324
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    Left = 55
    Top = 354
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
