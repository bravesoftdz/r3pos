inherited frmIcInfo: TfrmIcInfo
  Left = 531
  Top = 212
  Caption = #20250#21592#21345#20449#24687
  ClientHeight = 173
  ClientWidth = 292
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 292
    Height = 173
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 282
      Height = 123
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20250#21592#21345#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 278
          Height = 96
          BorderColor = clWhite
          Color = clWhite
          object Label1: TLabel
            Left = 14
            Top = 40
            Width = 60
            Height = 12
            Alignment = taRightJustify
            Caption = #21830#30431#36873#25321#65306
          end
          object Label2: TLabel
            Left = 14
            Top = 70
            Width = 60
            Height = 12
            Alignment = taRightJustify
            Caption = #20250#21592#21345#21495#65306
          end
          object Label4: TLabel
            Left = 14
            Top = 12
            Width = 60
            Height = 12
            Alignment = taRightJustify
            Caption = #20250#21592#22995#21517#65306
          end
          object labCUST_NAME: TLabel
            Left = 77
            Top = 12
            Width = 6
            Height = 12
            Alignment = taRightJustify
          end
          object cmbUNION_ID: TcxComboBox
            Left = 73
            Top = 36
            Width = 121
            Height = 20
            TabOrder = 0
          end
          object edtIC_CARDNO: TcxTextEdit
            Left = 73
            Top = 66
            Width = 200
            Height = 20
            TabOrder = 1
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 128
      Width = 282
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 129
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
        Left = 214
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
    Left = 8
    Top = 280
  end
  inherited actList: TActionList
    Left = 48
    Top = 280
  end
  object cdsCard: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 5
    Top = 144
  end
end
