inherited frameSelectCustomer: TframeSelectCustomer
  Left = 262
  Top = 144
  ActiveControl = DBGridEh1
  Caption = #25152#26377#20250#21592#20013#26597#25214'...'
  ClientHeight = 398
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Height = 398
    inherited RzPage: TRzPageControl
      Height = 348
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        Caption = #21830#21697#36873#25321#26694
        inherited RzPanel2: TRzPanel
          Height = 344
          object RzPanel4: TRzPanel
            Left = 5
            Top = 5
            Width = 517
            Height = 334
            Align = alClient
            BorderOuter = fsFlatRounded
            TabOrder = 0
            object DBGridEh1: TDBGridEh
              Left = 2
              Top = 59
              Width = 513
              Height = 273
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
              TabOrder = 1
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
                  Tag = -1
                  Title.Caption = #36873#25321
                  Title.Color = clWhite
                  Visible = False
                  Width = 20
                end
                item
                  EditButtons = <>
                  FieldName = 'CUST_CODE'
                  Footer.Value = #35760#24405#25968#65306
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #20250#21592#21495
                  Title.Color = clWhite
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'CUST_NAME'
                  Footer.ValueType = fvtCount
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #20250#21592#21517#31216
                  Title.Color = clWhite
                  Width = 98
                end
                item
                  EditButtons = <>
                  FieldName = 'BIRTHDAY'
                  Footers = <>
                  Title.Caption = #29983#26085
                  Title.Color = clWhite
                  Width = 73
                end
                item
                  EditButtons = <>
                  FieldName = 'SEX'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24615#21035
                  Title.Color = clWhite
                  Width = 30
                end
                item
                  EditButtons = <>
                  FieldName = 'ADDRESS'
                  Footers = <>
                  Title.Caption = #22320#22336
                  Title.Color = clWhite
                  Width = 183
                end
                item
                  EditButtons = <>
                  FieldName = 'COMP_NAME'
                  Footers = <>
                  Title.Caption = #20837#20250#38376#24215
                  Title.Color = clWhite
                  Width = 77
                end
                item
                  EditButtons = <>
                  FieldName = 'PRICE_NAME'
                  Footers = <>
                  Title.Caption = #20250#21592#31561#32423
                  Title.Color = clWhite
                  Width = 79
                end
                item
                  EditButtons = <>
                  FieldName = 'SND_DATE'
                  Footers = <>
                  Title.Caption = #20837#20250#26085#26399
                  Title.Color = clWhite
                  Width = 76
                end>
            end
            object fndPanel: TPanel
              Left = 2
              Top = 2
              Width = 513
              Height = 57
              Align = alTop
              BevelOuter = bvLowered
              Color = clWhite
              TabOrder = 0
              object RzPanel5: TRzPanel
                Left = 1
                Top = 1
                Width = 511
                Height = 55
                Align = alClient
                BorderOuter = fsNone
                BorderWidth = 1
                Color = clWhite
                TabOrder = 0
                object Label8: TLabel
                  Left = 158
                  Top = 32
                  Width = 24
                  Height = 12
                  Caption = #26597#25214
                end
                object Label2: TLabel
                  Left = 16
                  Top = 8
                  Width = 48
                  Height = 12
                  Caption = #20250#21592#31561#32423
                end
                object Label3: TLabel
                  Left = 208
                  Top = 8
                  Width = 48
                  Height = 12
                  Caption = #20837#20250#38376#24215
                end
                object Label1: TLabel
                  Left = 16
                  Top = 32
                  Width = 48
                  Height = 12
                  Caption = #26597#25214#33539#22260
                end
                object edtSearch: TcxTextEdit
                  Tag = -1
                  Left = 190
                  Top = 28
                  Width = 143
                  Height = 20
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 0
                  ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
                  OnKeyDown = edtSearchKeyDown
                end
                object btnFilter: TRzBitBtn
                  Left = 342
                  Top = 26
                  Width = 74
                  Height = 24
                  Caption = #26597#25214'(&F)'
                  Color = 15791348
                  HighlightColor = 16026986
                  HotTrack = True
                  HotTrackColor = 3983359
                  TabOrder = 3
                  OnClick = btnFilterClick
                  NumGlyphs = 2
                end
                object fndPRICE_ID: TcxComboBox
                  Tag = -1
                  Left = 72
                  Top = 4
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsFixedList
                  Properties.OnChange = fndPRICE_IDPropertiesChange
                  TabOrder = 1
                end
                object fndCOMP_ID: TzrComboBoxList
                  Left = 264
                  Top = 5
                  Width = 152
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
                  FilterFields = 'COMP_ID;COMP_NAME;COMP_SPELL'
                  KeyField = 'COMP_ID'
                  ListField = 'COMP_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'COMP_NAME'
                      Footers = <>
                      Title.Caption = #38376#24215#21517#31216
                      Width = 150
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMP_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 60
                    end>
                  DropWidth = 236
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = False
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  OnSaveValue = fndCOMP_IDSaveValue
                end
                object edtFIND_FLAG: TcxComboBox
                  Tag = -1
                  Left = 72
                  Top = 28
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #33258#21160#25628#32034
                    #20250#21592#21495
                    #20648#20540#21345#21495
                    #20250#21592#22995#21517
                    #22320#22336
                    #31227#21160#30005#35805)
                  Properties.OnChange = fndPRICE_IDPropertiesChange
                  TabOrder = 4
                end
              end
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 353
      object btnOk: TRzBitBtn
        Left = 335
        Top = 9
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
        Left = 423
        Top = 9
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
    Top = 200
  end
  inherited actList: TActionList
    Left = 200
    Top = 200
  end
  object cdsList: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CUST_CODE'
    Params = <>
    AfterScroll = cdsListAfterScroll
    Left = 345
    Top = 193
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 192
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 274
    Top = 235
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
    object N1: TMenuItem
      Caption = #26174#31034#25152#26377
      OnClick = N1Click
    end
  end
end
