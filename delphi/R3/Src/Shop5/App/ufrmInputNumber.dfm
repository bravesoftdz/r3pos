inherited frmInputNumber: TfrmInputNumber
  Left = 531
  Top = 270
  Caption = #34917#36135#25968#37327
  ClientHeight = 112
  ClientWidth = 278
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 278
    Height = 112
    inherited RzPage: TRzPageControl
      Width = 268
      Height = 62
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 264
          Height = 58
          object lblInput: TLabel
            Left = 8
            Top = 18
            Width = 84
            Height = 20
            Caption = #34917#36135#25968#37327
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -20
            Font.Name = #40657#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtInput: TcxTextEdit
            Left = 100
            Top = 15
            Width = 154
            Height = 27
            ParentFont = False
            Style.BorderStyle = ebsThick
            Style.Font.Charset = GB2312_CHARSET
            Style.Font.Color = clNavy
            Style.Font.Height = -19
            Style.Font.Name = #40657#20307
            Style.Font.Style = [fsBold]
            TabOrder = 0
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 67
      Width = 268
      object btnOk: TRzBitBtn
        Left = 120
        Top = 10
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
        Left = 200
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
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
end
