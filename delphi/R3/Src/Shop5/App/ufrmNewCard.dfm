inherited frmNewCard: TfrmNewCard
  Left = 520
  Top = 285
  Caption = #21457#26032#21345
  ClientHeight = 193
  ClientWidth = 322
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 322
    Height = 193
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 312
      Height = 143
      BackgroundColor = clWhite
      Color = clWhite
      ParentBackgroundColor = False
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #35831#22635#20889#21345#21495
        inherited RzPanel2: TRzPanel
          Width = 308
          Height = 116
          BorderColor = clWhite
          Color = clWhite
          object RzLabel12: TRzLabel
            Left = 3
            Top = 50
            Width = 92
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20250#21592#21345#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edt: TRzLabel
            Left = 3
            Top = 6
            Width = 92
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20250#21592#21517#31216
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel2: TRzLabel
            Left = 3
            Top = 28
            Width = 92
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21830#30431#36873#25321
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel1: TRzLabel
            Left = 3
            Top = 72
            Width = 92
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #23494'    '#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel3: TRzLabel
            Left = 3
            Top = 95
            Width = 92
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #23494#30721#30830#35748
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtIC_CARDNO: TcxTextEdit
            Left = 99
            Top = 46
            Width = 166
            Height = 20
            Properties.MaxLength = 36
            TabOrder = 2
          end
          object edtCLIENT_NAME: TcxTextEdit
            Left = 99
            Top = 2
            Width = 121
            Height = 20
            TabOrder = 0
          end
          object edtUNION_ID: TcxComboBox
            Left = 99
            Top = 24
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = edtUNION_IDPropertiesChange
            TabOrder = 1
          end
          object edtPASSWRD: TcxTextEdit
            Left = 99
            Top = 68
            Width = 121
            Height = 20
            Properties.EchoMode = eemPassword
            Properties.MaxLength = 25
            TabOrder = 3
          end
          object edtPASSWRD1: TcxTextEdit
            Left = 99
            Top = 91
            Width = 121
            Height = 20
            Properties.EchoMode = eemPassword
            Properties.MaxLength = 25
            TabOrder = 4
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 148
      Width = 312
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 160
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #21457#21345'(&S)'
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
        Left = 244
        Top = 9
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
  end
  inherited mmMenu: TMainMenu
    Left = 106
    Top = 65535
  end
  inherited actList: TActionList
    Left = 138
    Top = 65535
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 170
    Top = 65535
  end
end
