inherited frmLocationInfoList: TfrmLocationInfoList
  Left = 406
  Top = 192
  Caption = #20648#20301#26723#26696
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited RzPanel2: TRzPanel
      inherited RzPage: TRzPageControl
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          inherited RzPanel3: TRzPanel
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 720
              Height = 405
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object RzPanel6: TRzPanel
                Left = 5
                Top = 5
                Width = 710
                Height = 36
                Align = alTop
                BorderOuter = fsNone
                BorderWidth = 5
                TabOrder = 0
                DesignSize = (
                  710
                  36)
                object Panel1: TPanel
                  Left = 0
                  Top = 0
                  Width = 113
                  Height = 30
                  Alignment = taRightJustify
                  BevelInner = bvLowered
                  Caption = '  '#26597#35810#20851#20581#23383
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
                  Left = 111
                  Top = 0
                  Width = 754
                  Height = 30
                  Alignment = taLeftJustify
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  BevelInner = bvLowered
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentColor = True
                  ParentFont = False
                  TabOrder = 1
                  object Label1: TLabel
                    Left = 299
                    Top = 10
                    Width = 234
                    Height = 12
                    Caption = #25903#25345#65288#20648#20301#21517#12289#25340#38899#30721#12289#20648#20301#20195#30721#65289#26597#35810
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clNavy
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object edtKey: TcxTextEdit
                    Left = 8
                    Top = 5
                    Width = 196
                    Height = 20
                    TabOrder = 0
                    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  end
                  object btnOk: TRzBitBtn
                    Left = 219
                    Top = 3
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
                    TabOrder = 1
                    TextStyle = tsRaised
                    ThemeAware = False
                    ImageIndex = 12
                    NumGlyphs = 2
                    Spacing = 5
                  end
                end
              end
              object Panel3: TPanel
                Left = 5
                Top = 41
                Width = 710
                Height = 359
                Align = alClient
                Caption = 'Panel3'
                TabOrder = 1
                object DBGridEh1: TDBGridEh
                  Left = 1
                  Top = 1
                  Width = 708
                  Height = 338
                  Align = alClient
                  DataSource = dsBrowser
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
                  Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                  OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
                  ReadOnly = True
                  RowHeight = 20
                  TabOrder = 0
                  TitleFont.Charset = GB2312_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -12
                  TitleFont.Name = #23435#20307
                  TitleFont.Style = []
                  TitleHeight = 20
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDblClick = actInfoExecute
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 27
                    end
                    item
                      EditButtons = <>
                      FieldName = 'LOCATION_NAME'
                      Footers = <>
                      Title.Caption = #20648#20301#21517#31216
                      Width = 158
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = #38376#24215#21517#31216
                      Width = 145
                    end
                    item
                      EditButtons = <>
                      FieldName = 'LOCATION_SPELL'
                      Footers = <>
                      Title.Caption = #25340#38899#30721
                      Width = 100
                    end
                    item
                      EditButtons = <>
                      FieldName = 'REMARK'
                      Footers = <>
                      Title.Caption = #22791#27880
                      Width = 423
                    end>
                end
                object stbPanel: TPanel
                  Left = 1
                  Top = 339
                  Width = 708
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
                  TabOrder = 1
                  object Label2: TLabel
                    Left = 4
                    Top = 8
                    Width = 7
                    Height = 12
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
    inherited Image3: TImage
      Left = 329
      Width = 379
    end
    inherited rzPanel5: TPanel
      Left = 329
    end
    inherited CoolBar1: TCoolBar
      Width = 309
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 309
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 309
        ButtonWidth = 43
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actNew
        end
        object ToolButton2: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
          Caption = #20462#25913
        end
        object ToolButton3: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
        end
        object ToolButton4: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton5: TToolButton
          Left = 172
          Top = 0
          Width = 8
          Caption = 'ToolButton5'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object ToolButton6: TToolButton
          Left = 180
          Top = 0
          Action = actPrint
        end
        object ToolButton7: TToolButton
          Left = 223
          Top = 0
          Action = actPreview
        end
        object ToolButton8: TToolButton
          Left = 266
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited actList: TActionList
    inherited actNew: TAction
      OnExecute = actNewExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
    inherited actEdit: TAction
      OnExecute = actEditExecute
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
  end
  object PopupMenu1: TPopupMenu
    Left = 312
    Top = 171
    object N1: TMenuItem
      Caption = #36716#25442#25104#24635#24215
    end
  end
  object cdsBrowser: TZQuery
    FieldDefs = <>
    AfterScroll = cdsBrowserAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 49
    Top = 207
  end
  object PrintDBGridEh1: TPrintDBGridEh
    Options = [pghFitGridToPageWidth]
    Page.BottomMargin = 2.000000000000000000
    Page.LeftMargin = 2.000000000000000000
    Page.RightMargin = 0.500000000000000000
    Page.TopMargin = 2.000000000000000000
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      #35843#25972#27719#24635#34920)
    PageHeader.Font.Charset = GB2312_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -16
    PageHeader.Font.Name = #23435#20307
    PageHeader.Font.Style = [fsBold]
    Units = MM
    Left = 128
    Top = 208
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
  object dsBrowser: TDataSource
    DataSet = cdsBrowser
    Left = 137
    Top = 280
  end
end
