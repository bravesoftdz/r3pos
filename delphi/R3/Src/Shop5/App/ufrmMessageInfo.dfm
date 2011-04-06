inherited frmMessageInfo: TfrmMessageInfo
  Left = 432
  Top = 170
  Caption = #20449#24687#20844#21578
  ClientHeight = 370
  ClientWidth = 506
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 506
    Height = 370
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 496
      Height = 320
      Color = clWhite
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #21457#24067#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 492
          Height = 293
          BorderColor = clWhite
          Color = clWhite
          object Label9: TLabel
            Left = 14
            Top = 36
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21457#24067#29992#25143
          end
          object Label1: TLabel
            Left = 14
            Top = 85
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20449#24687#26631#39064
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 14
            Top = 112
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20449#24687#20869#23481
          end
          object Label5: TLabel
            Left = 14
            Top = 61
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20449#24687#31867#22411
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 227
            Top = 60
            Width = 6
            Height = 12
            Alignment = taRightJustify
            Caption = '*'
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 255
            Top = 36
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21457#24067#26085#26399
          end
          object Label3: TLabel
            Left = 14
            Top = 11
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20449#24687#26469#28304
          end
          object Label4: TLabel
            Left = 468
            Top = 85
            Width = 6
            Height = 12
            Alignment = taRightJustify
            Caption = '*'
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 255
            Top = 61
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26377#25928#26399#38480
          end
          object edtMSG_TITLE: TcxTextEdit
            Left = 105
            Top = 81
            Width = 362
            Height = 20
            TabOrder = 2
          end
          object edtMSG_CLASS: TcxComboBox
            Left = 105
            Top = 56
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 0
          end
          object edtMSG_CONTENT: TcxMemo
            Left = 105
            Top = 109
            Width = 362
            Height = 173
            TabOrder = 3
          end
          object edtISSUE_DATE: TcxDateEdit
            Left = 346
            Top = 31
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 4
          end
          object edtMSG_SOURCE: TcxTextEdit
            Left = 105
            Top = 7
            Width = 184
            Height = 20
            Enabled = False
            TabOrder = 5
          end
          object edtISSUE_USER_TEXT: TcxTextEdit
            Left = 105
            Top = 31
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 6
          end
          object edtEND_DATE: TcxDateEdit
            Left = 346
            Top = 56
            Width = 121
            Height = 20
            TabOrder = 1
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 325
      Width = 496
      BorderColor = clWhite
      Color = clWhite
      object Btn_Save: TRzBitBtn
        Left = 326
        Top = 10
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
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Close: TRzBitBtn
        Left = 413
        Top = 10
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
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 23
    Top = 206
  end
  inherited actList: TActionList
    Left = 23
    Top = 238
  end
  object cdsMessage: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 21
    Top = 267
  end
end
