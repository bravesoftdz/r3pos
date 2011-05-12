inherited frmPassWord: TfrmPassWord
  Left = 720
  Top = 227
  Caption = #20462#25913#23494#30721
  ClientHeight = 216
  ClientWidth = 388
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 388
    Height = 216
    BorderColor = clWhite
    inherited RzPage: TRzPageControl
      Width = 378
      Height = 166
      BackgroundColor = clWhite
      Color = clWhite
      ParentBackgroundColor = False
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20462#25913#23494#30721
        inherited RzPanel2: TRzPanel
          Width = 374
          Height = 139
          BorderColor = clWhite
          Color = clWhite
          object RzLabel12: TRzLabel
            Left = 16
            Top = 74
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26087' '#23494' '#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edt: TRzLabel
            Left = 16
            Top = 96
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26032' '#23494' '#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel1: TRzLabel
            Left = 16
            Top = 118
            Width = 100
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
          object RzLabel2: TRzLabel
            Left = 16
            Top = 52
            Width = 100
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
          object RzLabel3: TRzLabel
            Left = 16
            Top = 8
            Width = 100
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
          object RzLabel4: TRzLabel
            Left = 16
            Top = 30
            Width = 100
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
          object RzLabel7: TRzLabel
            Left = 244
            Top = 74
            Width = 6
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = '*'
            Font.Charset = GB2312_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel5: TRzLabel
            Left = 244
            Top = 96
            Width = 6
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = '*'
            Font.Charset = GB2312_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel6: TRzLabel
            Left = 244
            Top = 118
            Width = 6
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = '*'
            Font.Charset = GB2312_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtOLD_PASSWRD: TcxTextEdit
            Left = 120
            Top = 70
            Width = 121
            Height = 20
            Properties.EchoMode = eemPassword
            Properties.MaxLength = 25
            TabOrder = 0
          end
          object edtPASSWRD: TcxTextEdit
            Left = 120
            Top = 92
            Width = 121
            Height = 20
            Properties.EchoMode = eemPassword
            Properties.MaxLength = 25
            TabOrder = 1
          end
          object edtPASSWRD1: TcxTextEdit
            Left = 120
            Top = 114
            Width = 121
            Height = 20
            Properties.EchoMode = eemPassword
            Properties.MaxLength = 25
            TabOrder = 2
          end
          object edtIC_CARDNO: TcxTextEdit
            Left = 120
            Top = 48
            Width = 166
            Height = 20
            TabOrder = 3
          end
          object edtCLIENT_NAME: TcxTextEdit
            Left = 120
            Top = 4
            Width = 121
            Height = 20
            TabOrder = 4
          end
          object edtUNION_ID: TcxComboBox
            Left = 120
            Top = 26
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = edtUNION_IDPropertiesChange
            TabOrder = 5
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 171
      Width = 378
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 201
        Top = 9
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
        Left = 303
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
    Left = 289
    Top = 34
  end
  inherited actList: TActionList
    Left = 322
    Top = 34
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 257
    Top = 34
  end
end
