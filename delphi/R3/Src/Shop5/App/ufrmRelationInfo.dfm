inherited frmRelationInfo: TfrmRelationInfo
  Left = 443
  Top = 233
  Caption = #20379#24212#38142
  ClientHeight = 314
  ClientWidth = 461
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 461
    Height = 314
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 153
      Width = 451
      Height = 116
      Color = clWhite
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20854#20182#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 447
          Height = 89
          BorderSides = [sdLeft, sdRight, sdBottom]
          BorderWidth = 1
          Color = clWhite
          object Label1: TLabel
            Left = -7
            Top = 27
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32463#38144#21830#24635#25968
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 188
            Top = 27
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21830#21697#24635#25968
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtTENANT_NUM: TcxTextEdit
            Left = 99
            Top = 23
            Width = 118
            Height = 20
            Enabled = False
            TabOrder = 0
          end
          object edtGOODS_NUM: TcxTextEdit
            Left = 293
            Top = 23
            Width = 118
            Height = 20
            Enabled = False
            TabOrder = 1
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 269
      Width = 451
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 257
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
        Left = 342
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
      object btnDelete: TRzBitBtn
        Left = 258
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #21024#38500'(&D)'
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
        TabOrder = 2
        TextStyle = tsRaised
        ThemeAware = False
        Visible = False
        OnClick = btnDeleteClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 451
      Height = 148
      Align = alTop
      BorderOuter = fsNone
      BorderSides = []
      BorderWidth = 1
      Color = clWhite
      TabOrder = 2
      object labRELATION_ID: TLabel
        Left = -13
        Top = 13
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20379#24212#38142'ID'#21495
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object labRELATION_NAME: TLabel
        Left = -13
        Top = 42
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20379#24212#38142#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 224
        Top = 42
        Width = 73
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25340#38899#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = -13
        Top = 73
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #35828#26126
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 212
        Top = 42
        Width = 6
        Height = 12
        Alignment = taRightJustify
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 422
        Top = 42
        Width = 6
        Height = 12
        Alignment = taRightJustify
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtRELATION_ID: TcxTextEdit
        Left = 93
        Top = 9
        Width = 118
        Height = 20
        Enabled = False
        TabOrder = 0
      end
      object edtRELATION_NAME: TcxTextEdit
        Left = 93
        Top = 38
        Width = 118
        Height = 20
        Properties.OnChange = edtRELATION_NAMEPropertiesChange
        TabOrder = 1
      end
      object edtRELATION_SPELL: TcxTextEdit
        Left = 303
        Top = 38
        Width = 118
        Height = 20
        TabOrder = 2
      end
      object edtREMARK: TcxMemo
        Left = 93
        Top = 68
        Width = 328
        Height = 67
        TabOrder = 3
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 512
    Top = 304
  end
  inherited actList: TActionList
    Left = 32
    Top = 96
  end
  object Relation_Data: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 1
    Top = 96
  end
end
