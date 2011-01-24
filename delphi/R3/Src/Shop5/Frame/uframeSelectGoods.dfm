inherited frameSelectGoods: TframeSelectGoods
  Left = 304
  Top = 144
  ActiveControl = DBGridEh1
  Caption = #21830#21697#36873#25321#26694
  ClientHeight = 401
  ClientWidth = 605
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 605
    Height = 401
    inherited RzPage: TRzPageControl
      Width = 595
      Height = 355
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        Caption = #21830#21697#36873#25321#26694
        inherited RzPanel2: TRzPanel
          Width = 591
          Height = 351
          object Splitter1: TSplitter
            Left = 161
            Top = 5
            Height = 341
          end
          object RzPanel3: TRzPanel
            Left = 5
            Top = 5
            Width = 156
            Height = 341
            Align = alLeft
            BorderOuter = fsFlatRounded
            TabOrder = 0
            object RzTree: TRzTreeView
              Left = 2
              Top = 57
              Width = 152
              Height = 282
              SelectionPen.Color = clBtnShadow
              Align = alClient
              Ctl3D = True
              FrameVisible = True
              Indent = 19
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 1
              OnChange = RzTreeChange
              OnKeyDown = RzTreeKeyDown
            end
            object RzPanel1: TRzPanel
              Left = 2
              Top = 2
              Width = 152
              Height = 55
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 1
              Color = clWhite
              TabOrder = 0
              object Label2: TLabel
                Left = 12
                Top = 31
                Width = 24
                Height = 12
                Caption = #26174#31034
              end
              object fndGODS_FLAG1: TcxComboBox
                Left = 40
                Top = 27
                Width = 96
                Height = 20
                Properties.Items.Strings = (
                  #25353#21830#21697#20998#31867
                  #25353#21697#29260#21378#23478
                  #25353#20027#20379#24212#21830)
                Properties.OnChange = fndGODS_FLAGPropertiesChange
                TabOrder = 0
              end
              object CheckBox1: TCheckBox
                Left = 12
                Top = 7
                Width = 97
                Height = 17
                Caption = #24320#21551#22810#36873
                TabOrder = 1
                OnClick = CheckBox1Click
              end
            end
          end
          object RzPanel4: TRzPanel
            Left = 164
            Top = 5
            Width = 422
            Height = 341
            Align = alClient
            BorderOuter = fsFlatRounded
            TabOrder = 1
            object DBGridEh1: TDBGridEh
              Left = 2
              Top = 57
              Width = 418
              Height = 282
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              DataSource = dsList
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FrozenCols = 1
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              PopupMenu = PopupMenu1
              RowHeight = 23
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
              OnDblClick = DBGridEh1DblClick
              OnKeyDown = DBGridEh1KeyDown
              OnTitleClick = DBGridEh1TitleClick
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
                  Title.Color = clWhite
                  Width = 21
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_CODE'
                  Footer.Value = #35760#24405#25968#65306
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #36135#21495
                  Title.Color = clWhite
                  Width = 50
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_NAME'
                  Footer.ValueType = fvtCount
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #21830#21697#21517#31216
                  Title.Color = clWhite
                  Width = 122
                end
                item
                  EditButtons = <>
                  FieldName = 'BARCODE'
                  Footers = <>
                  Title.Caption = #26465#30721
                  Title.Color = clWhite
                  Width = 83
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24211#23384#37327
                  Title.Color = clWhite
                  Width = 40
                end
                item
                  EditButtons = <>
                  FieldName = 'UNIT_ID'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #35745#37327#21333#20301
                  Title.Color = clWhite
                  Width = 29
                end
                item
                  EditButtons = <>
                  FieldName = 'NEW_OUTPRICE'
                  Footers = <>
                  Title.Caption = #38646#21806#20215
                  Title.Color = clWhite
                  Width = 42
                end>
            end
            object fndPanel: TPanel
              Left = 2
              Top = 2
              Width = 418
              Height = 55
              Align = alTop
              BevelOuter = bvLowered
              Color = clWhite
              TabOrder = 1
              object RzPanel5: TRzPanel
                Left = 1
                Top = 1
                Width = 416
                Height = 53
                Align = alClient
                BorderOuter = fsNone
                BorderWidth = 1
                Color = clWhite
                TabOrder = 0
                object Label8: TLabel
                  Left = 8
                  Top = 11
                  Width = 96
                  Height = 12
                  Caption = #36755#20837#35201#26597#35810#30340#20869#23481
                end
                object Label1: TLabel
                  Left = 8
                  Top = 34
                  Width = 252
                  Height = 12
                  Caption = #25903#25345#65288#36135#21495#12289#21697#21517#12289#25340#38899#30721#12289#26465#30721#65289#20851#20581#23383#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object edtSearch: TcxTextEdit
                  Tag = -1
                  Left = 109
                  Top = 7
                  Width = 116
                  Height = 20
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 0
                  ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
                  OnKeyDown = edtSearchKeyDown
                end
                object btnFilter: TRzBitBtn
                  Left = 235
                  Top = 5
                  Width = 59
                  Height = 24
                  Caption = #26597#25214'(&F5)'
                  Color = 15791348
                  HighlightColor = 16026986
                  HotTrack = True
                  HotTrackColor = 3983359
                  TabOrder = 1
                  OnClick = btnFilterClick
                  NumGlyphs = 2
                end
              end
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 360
      Width = 595
      Height = 36
      object btnOk: TRzBitBtn
        Left = 391
        Top = 4
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&O)'
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
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object RzBitBtn2: TRzBitBtn
        Left = 471
        Top = 4
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #21462#28040'(&C)'
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
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 200
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 192
  end
  object PopupMenu1: TPopupMenu
    Left = 274
    Top = 235
    object N1: TMenuItem
      Caption = #26174#31034#25152#26377
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20840#36873
      ShortCut = 16449
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #20840#21453#36873
      ShortCut = 16450
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #20840#19981#36873
      ShortCut = 16452
      OnClick = N4Click
    end
  end
  object cdsList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 346
    Top = 193
  end
end
