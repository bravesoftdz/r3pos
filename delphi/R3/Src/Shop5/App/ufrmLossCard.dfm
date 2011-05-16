inherited frmLossCard: TfrmLossCard
  Left = 443
  Top = 258
  Caption = #25346#22833
  ClientHeight = 265
  ClientWidth = 444
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 444
    Height = 265
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 434
      Height = 215
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20250#21592#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 430
          Height = 188
          BorderColor = clWhite
          Color = clWhite
          object RzLabel1: TRzLabel
            Left = 1
            Top = 75
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21457#21345#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel2: TRzLabel
            Left = 1
            Top = 99
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20313#39069
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RzLabel3: TRzLabel
            Left = 1
            Top = 120
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25688'    '#35201
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel4: TRzLabel
            Left = 2
            Top = 54
            Width = 80
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
          object RzLabel5: TRzLabel
            Left = 2
            Top = 10
            Width = 80
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
          object RzLabel6: TRzLabel
            Left = 2
            Top = 32
            Width = 80
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
          object edtCREA_DATE: TcxTextEdit
            Left = 88
            Top = 72
            Width = 121
            Height = 20
            TabOrder = 0
          end
          object edtBALANCE: TcxTextEdit
            Left = 88
            Top = 95
            Width = 121
            Height = 20
            ParentFont = False
            Style.Font.Charset = GB2312_CHARSET
            Style.Font.Color = clNavy
            Style.Font.Height = -12
            Style.Font.Name = #23435#20307
            Style.Font.Style = [fsBold]
            TabOrder = 1
          end
          object edtIC_INFO: TcxMemo
            Left = 88
            Top = 118
            Width = 229
            Height = 61
            TabOrder = 2
            OnKeyPress = edtIC_INFOKeyPress
          end
          object edtIC_CARDNO: TcxTextEdit
            Left = 88
            Top = 50
            Width = 166
            Height = 20
            TabOrder = 3
          end
          object edtCLIENT_NAME: TcxTextEdit
            Left = 88
            Top = 6
            Width = 121
            Height = 20
            TabOrder = 4
          end
          object edtUNION_ID: TcxComboBox
            Left = 88
            Top = 28
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
      Top = 220
      Width = 434
      BorderColor = clWhite
      Color = clWhite
      object Btn_Save: TRzBitBtn
        Left = 274
        Top = 11
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #25346#22833'(&S)'
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
        Left = 365
        Top = 11
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
    Left = 403
    Top = 32
  end
  inherited actList: TActionList
    Left = 371
    Top = 32
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 339
    Top = 32
  end
end
