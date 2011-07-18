inherited frameSelectCustomer: TframeSelectCustomer
  Left = 781
  Top = 148
  ActiveControl = edtSearch
  Caption = #26597#25214#23458#25143'...'
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
            Width = 525
            Height = 334
            Align = alClient
            BorderOuter = fsFlatRounded
            TabOrder = 0
            object DBGridEh1: TDBGridEh
              Left = 2
              Top = 42
              Width = 521
              Height = 290
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
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
                  FieldName = 'CLIENT_CODE'
                  Footer.Value = #35760#24405#25968#65306
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #23458#25143#21495
                  Title.Color = clWhite
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footer.ValueType = fvtCount
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #23458#25143#21517#31216
                  Title.Color = clWhite
                  Width = 98
                end
                item
                  EditButtons = <>
                  FieldName = 'PRICE_NAME'
                  Footers = <>
                  Title.Caption = #20250#21592#31561#32423
                  Title.Color = clWhite
                  Width = 61
                end
                item
                  EditButtons = <>
                  FieldName = 'TELEPHONE2'
                  Footers = <>
                  Title.Caption = #31227#21160#30005#35805
                  Title.Color = clWhite
                  Width = 84
                end
                item
                  EditButtons = <>
                  FieldName = 'LICENSE_CODE'
                  Footers = <>
                  Title.Caption = #35777#20214#21495
                  Title.Color = clWhite
                  Width = 99
                end
                item
                  EditButtons = <>
                  FieldName = 'ADDRESS'
                  Footers = <>
                  Title.Caption = #22320#22336
                  Title.Color = clWhite
                  Width = 136
                end
                item
                  EditButtons = <>
                  FieldName = 'SHOP_NAME'
                  Footers = <>
                  Title.Caption = #20837#20250#38376#24215
                  Title.Color = clWhite
                  Width = 77
                end>
            end
            object fndPanel: TPanel
              Left = 2
              Top = 2
              Width = 521
              Height = 40
              Align = alTop
              BevelOuter = bvLowered
              Color = clWhite
              TabOrder = 0
              object RzPanel5: TRzPanel
                Left = 1
                Top = 1
                Width = 519
                Height = 38
                Align = alClient
                BorderOuter = fsNone
                BorderWidth = 1
                Color = clWhite
                TabOrder = 0
                object Label1: TLabel
                  Left = 171
                  Top = 13
                  Width = 48
                  Height = 12
                  Caption = #25628#32034#33539#22260
                end
                object edtSearch: TcxTextEdit
                  Tag = -1
                  Left = 302
                  Top = 9
                  Width = 131
                  Height = 20
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 0
                  ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
                  OnKeyDown = edtSearchKeyDown
                end
                object btnFilter: TRzBitBtn
                  Left = 438
                  Top = 7
                  Width = 59
                  Height = 24
                  Caption = #25628#32034'(&F)'
                  Color = 15791348
                  HighlightColor = 16026986
                  HotTrack = True
                  HotTrackColor = 3983359
                  TabOrder = 1
                  OnClick = btnFilterClick
                  NumGlyphs = 2
                end
                object edtFIND_FLAG: TcxComboBox
                  Tag = -1
                  Left = 224
                  Top = 9
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #33258#21160#25628#32034
                    #23458#25143#32534#21495
                    #20250#21592#22995#21517
                    #31227#21160#30005#35805
                    #35777#20214#21495
                    #22320#22336)
                  TabOrder = 2
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
  object cdsList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 339
    Top = 195
  end
end
