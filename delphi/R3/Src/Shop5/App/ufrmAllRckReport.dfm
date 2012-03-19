inherited frmAllRckReport: TfrmAllRckReport
  Top = 105
  Width = 958
  Height = 554
  Caption = #32508#21512#21488#36134
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 950
    Height = 490
    inherited RzPanel2: TRzPanel
      Width = 940
      Height = 480
      inherited RzPage: TRzPageControl
        Width = 735
        Height = 474
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #32508#21512#21488#36134
          inherited RzPanel3: TRzPanel
            Width = 733
            Height = 447
            inherited Panel4: TPanel
              Width = 723
              Height = 437
              inherited w1: TRzPanel
                Width = 723
                Height = 60
                object Label3: TLabel
                  Left = 16
                  Top = 37
                  Width = 48
                  Height = 12
                  Caption = #21488#24080#20998#31867
                end
                object LblUnit: TLabel
                  Left = 295
                  Top = 37
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                end
                object RzLabel1: TRzLabel
                  Left = 16
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #25152#23646#26085#26399
                end
                object RzLabel12: TRzLabel
                  Left = 162
                  Top = 12
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object rptTemplate: TcxComboBox
                  Left = 72
                  Top = 33
                  Width = 193
                  Height = 20
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #20840#37096#21830#21697#21488#36134
                    #21367#28895#21830#21697#21488#36134
                    #38750#28895#21830#21697#21488#24080
                    #36827#36135#21488#36134
                    #38144#21806#21488#36134)
                  Properties.OnChange = rptTemplatePropertiesChange
                  TabOrder = 2
                end
                object btnNew: TRzBitBtn
                  Left = 572
                  Top = 35
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
                  TabOrder = 6
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnNewClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object btnEdit: TRzBitBtn
                  Left = 621
                  Top = 35
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
                  TabOrder = 7
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnEditClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 454
                  Top = 24
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
                object fndP1_UNIT_ID: TcxComboBox
                  Left = 346
                  Top = 33
                  Width = 89
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 3
                end
                object btnDelete: TRzBitBtn
                  Left = 670
                  Top = 35
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
                  TabOrder = 8
                  TextStyle = tsRaised
                  ThemeAware = False
                  OnClick = btnDeleteClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object P1_D1: TcxDateEdit
                  Left = 72
                  Top = 7
                  Width = 85
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 180
                  Top = 7
                  Width = 85
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  TabOrder = 1
                end
                inline P1_DateControl: TfrmDateControl
                  Left = 270
                  Top = 7
                  Width = 170
                  Height = 20
                  TabOrder = 5
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 60
                Width = 723
                Height = 377
                inherited DBGridEh1: TDBGridEh
                  Tag = 1
                  Width = 719
                  Height = 373
                  OnDblClick = DBGridEh1DblClick
                  OnGetFooterParams = DBGridEh1GetFooterParams
                  OnTitleClick = DBGridEh1TitleClick
                  Columns = <
                    item
                      EditButtons = <>
                      Footers = <>
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 738
        Height = 474
        Visible = False
        inherited Panel2: TPanel
          Height = 440
          inherited Panel5: TPanel
            Height = 325
            inherited rzShowColumns: TRzCheckList
              Height = 321
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
    inherited CoolBar1: TCoolBar
      inherited ToolBar1: TToolBar
        inherited ToolButton1: TToolButton
          Visible = False
        end
      end
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
    inherited actPrior: TAction
      Visible = False
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
