inherited frmFvchCalc: TfrmFvchCalc
  Left = 327
  Top = 157
  Width = 396
  Height = 349
  BorderIcons = [biSystemMenu]
  Caption = #20973#35777#29983#25104
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 380
    Height = 311
    Align = alClient
    BorderOuter = fsNone
    Color = clWhite
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 0
      Top = 0
      Width = 380
      Height = 269
      Align = alClient
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 0
      object Bevel1: TBevel
        Left = 15
        Top = 11
        Width = 360
        Height = 263
        Shape = bsFrame
      end
      object PB: TRzProgressBar
        Left = 39
        Top = 249
        Width = 313
        Height = 18
        BorderInner = fsFlatRounded
        BorderOuter = fsFlatRounded
        BorderWidth = 0
        InteriorOffset = 0
        PartsComplete = 0
        Percent = 0
        TotalParts = 0
      end
      object labINFO: TLabel
        Left = 38
        Top = 232
        Width = 52
        Height = 12
        Caption = #20449#24687#25552#31034
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labInfomation: TLabel
        Left = 98
        Top = 231
        Width = 24
        Height = 12
        Caption = '....'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel2: TRzLabel
        Left = 38
        Top = 21
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #19994#21153#26085#26399
      end
      object RzLabel3: TRzLabel
        Left = 214
        Top = 21
        Width = 12
        Height = 12
        Caption = #33267
      end
      object RzLabel1: TRzLabel
        Left = 38
        Top = 43
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #29983#25104#31867#22411
      end
      object P1_D1: TcxDateEdit
        Left = 89
        Top = 17
        Width = 120
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 0
      end
      object P1_D2: TcxDateEdit
        Left = 230
        Top = 17
        Width = 120
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 1
      end
      object edt_Fvch_Type: TcxComboBox
        Left = 89
        Top = 39
        Width = 202
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsEditFixedList
        Properties.Items.Strings = (
          #27599#20010#19994#21153#21333#25454'/1'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/2'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/3'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/4'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/5'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/6'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/7'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/10'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/15'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/20'#22825#29983#25104#19968#24352#20973#35777
          #27599#20010#19994#21153#21333#25454'/1'#26376#29983#25104#19968#24352#20973#35777)
        TabOrder = 2
      end
      object CB_CHECK: TCheckBox
        Left = 296
        Top = 41
        Width = 58
        Height = 17
        Caption = #24050#23457#26680
        TabOrder = 3
      end
    end
    object RzPanel3: TRzPanel
      Left = 0
      Top = 269
      Width = 380
      Height = 42
      Align = alBottom
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 1
      object btnStart: TRzBitBtn
        Left = 161
        Top = 5
        Width = 72
        Height = 27
        Caption = #24320#22987#29983#25104
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
        OnClick = btnStartClick
        ImageIndex = 12
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object RzPanel7: TRzPanel [1]
    Left = 40
    Top = 62
    Width = 310
    Height = 164
    BorderOuter = fsNone
    BorderColor = clSilver
    BorderWidth = 1
    Color = clWhite
    TabOrder = 1
    object DBGridEh1: TDBGridEh
      Left = 1
      Top = 1
      Width = 308
      Height = 162
      Align = alClient
      AllowedOperations = [alopUpdateEh]
      DataSource = Ds_BillName
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
      PopupMenu = GridPm
      RowHeight = 18
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      TitleHeight = 18
      UseMultiTitle = True
      IsDrawNullRow = False
      CurrencySymbol = #65509
      DecimalNumber = 2
      DigitalNumber = 12
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
          Title.Caption = #36873#25321
          Width = 29
        end
        item
          EditButtons = <>
          FieldName = 'CODE_ID'
          Footers = <>
          ReadOnly = True
          Title.Caption = #32534#30721
          Width = 63
        end
        item
          EditButtons = <>
          FieldName = 'CODE_NAME'
          Footers = <>
          ReadOnly = True
          Title.Caption = #21333#25454#21517#31216
          Width = 185
        end>
    end
  end
  inherited mmMenu: TMainMenu
    Left = 408
    Top = 176
  end
  inherited actList: TActionList
    Left = 16
    Top = 0
  end
  object Ds_BillName: TDataSource
    Left = 8
    Top = 136
  end
  object CdsFvchOrder: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 6
    Top = 277
  end
  object CdsFvchData: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 43
    Top = 277
  end
  object CdsFvchDetail: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 77
    Top = 277
  end
  object CdsFvchGlide: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 112
    Top = 277
  end
  object GridPm: TPopupMenu
    Left = 58
    Top = 83
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
end
