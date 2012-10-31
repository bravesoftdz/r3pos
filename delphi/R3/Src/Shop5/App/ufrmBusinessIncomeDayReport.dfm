inherited frmBusinessIncomeDayReport: TfrmBusinessIncomeDayReport
  Left = -8
  Top = -8
  Width = 1296
  Height = 776
  Caption = #33829#19994#26085#27719#24635#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1280
    Height = 701
    inherited RzPanel2: TRzPanel
      Width = 1270
      Height = 691
      inherited RzPage: TRzPageControl
        Width = 1065
        Height = 685
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #33829#19994#26085#27719#24635#34920
          inherited RzPanel3: TRzPanel
            Width = 1063
            Height = 658
            inherited Panel4: TPanel
              Width = 1053
              Height = 648
              inherited w1: TRzPanel
                Width = 1053
                Height = 82
                object RzLabel2: TRzLabel
                  Left = 33
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #19994#21153#26085#26399
                end
                object RzLabel3: TRzLabel
                  Left = 200
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label40: TLabel
                  Left = 33
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label3: TLabel
                  Left = 33
                  Top = 54
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object P1_D1: TcxDateEdit
                  Left = 89
                  Top = 10
                  Width = 104
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 216
                  Top = 10
                  Width = 109
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object fndP1_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 89
                  Top = 30
                  Width = 236
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
                object fndP1_DEPT_ID: TzrComboBoxList
                  Left = 89
                  Top = 50
                  Width = 236
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
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object RzBitBtn3: TRzBitBtn
                  Left = 345
                  Top = 38
                  Width = 67
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
                  TabOrder = 4
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 82
                Width = 1053
                Height = 566
                inherited DBGridEh1: TDBGridEh
                  Width = 1049
                  Height = 562
                  FooterRowCount = 0
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 1068
        Height = 685
        inherited Panel2: TPanel
          Height = 664
          inherited Panel5: TPanel
            Height = 549
            inherited rzShowColumns: TRzCheckList
              Height = 545
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 1280
    inherited Image3: TImage
      Width = 494
    end
    inherited Image14: TImage
      Left = 1260
    end
    inherited Image1: TImage
      Left = 848
    end
  end
  inherited mmMenu: TMainMenu
    Left = 80
    Top = 464
  end
  inherited actList: TActionList
    Left = 112
    Top = 464
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited SaveDialog1: TSaveDialog
    Left = 178
    Top = 463
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    Left = 144
    Top = 464
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
