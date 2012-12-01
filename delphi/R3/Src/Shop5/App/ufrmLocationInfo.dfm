inherited frmlocationinfo: Tfrmlocationinfo
  Left = 578
  Top = 242
  Caption = #20648#20301#35814#24773
  ClientHeight = 286
  ClientWidth = 492
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 492
    Height = 286
    inherited RzPage: TRzPageControl
      Top = 81
      Width = 482
      Height = 167
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #20854#23427#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 478
          Height = 140
          object Label4: TLabel
            Left = 17
            Top = 16
            Width = 42
            Height = 12
            Caption = #22791'  '#27880':'
          end
          object edtREMARK: TcxMemo
            Left = 72
            Top = 16
            Width = 401
            Height = 121
            Lines.Strings = (
              'edtREMARK')
            TabOrder = 0
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 248
      Width = 482
      Height = 33
      object btnOk: TRzBitBtn
        Left = 319
        Top = 4
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
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
      object btnClose: TRzBitBtn
        Left = 415
        Top = 4
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20851#38381'(&C)'
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
        OnClick = btnCloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 482
      Height = 76
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      object TLabel
        Left = 13
        Top = 44
        Width = 48
        Height = 12
        Caption = #25152#23646#38376#24215
      end
      object Label2: TLabel
        Left = 13
        Top = 10
        Width = 48
        Height = 12
        Caption = #20648#20301#21517#31216
      end
      object Label3: TLabel
        Left = 221
        Top = 10
        Width = 36
        Height = 12
        Caption = #25340#38899#30721
      end
      object edtLOCATION_NAME: TcxTextEdit
        Left = 70
        Top = 7
        Width = 121
        Height = 20
        Properties.OnChange = edtLOCATION_NAMEPropertiesChange
        TabOrder = 0
      end
      object edtLOCATION_SPELL: TcxTextEdit
        Left = 270
        Top = 7
        Width = 121
        Height = 20
        TabOrder = 1
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 70
        Top = 40
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 2
        InGrid = False
        KeyValue = Null
        FilterFields = 'SHOP_SPELL;SHOP_NAME;SHOP_ID'
        KeyField = 'SHOP_ID'
        ListField = 'SHOP_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SHOP_NAME'
            Footers = <>
            Title.Caption = #38376#24215#21517#31216
          end>
        DropWidth = 290
        DropHeight = 228
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew, zbClear, zbFind]
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 312
    Top = 160
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 41
    Top = 199
  end
end
