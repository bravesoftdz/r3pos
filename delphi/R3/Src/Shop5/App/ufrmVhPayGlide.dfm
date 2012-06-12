inherited frmVhPayGlide: TfrmVhPayGlide
  Left = 497
  Top = 197
  Caption = #20195#37329#21048#32467#31639
  ClientHeight = 256
  ClientWidth = 357
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 357
    Height = 256
    inherited RzPage: TRzPageControl
      Width = 347
      Height = 206
      ParentColor = False
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        Caption = #20195#37329#21048#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 343
          Height = 202
          Color = clWhite
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 333
            Height = 48
            Align = alClient
            BorderOuter = fsNone
            BorderSides = [sdBottom]
            BorderColor = clInactiveCaption
            BorderWidth = 1
            TabOrder = 0
            object lblInput: TLabel
              Left = 35
              Top = 14
              Width = 63
              Height = 20
              Caption = #38450#20266#30721
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object edtInput: TcxTextEdit
              Left = 106
              Top = 11
              Width = 204
              Height = 27
              ParentFont = False
              Style.BorderStyle = ebsThick
              Style.Font.Charset = GB2312_CHARSET
              Style.Font.Color = clNavy
              Style.Font.Height = -19
              Style.Font.Name = #40657#20307
              Style.Font.Style = [fsBold]
              TabOrder = 0
              OnKeyPress = edtInputKeyPress
            end
          end
          object RzPanel3: TRzPanel
            Left = 5
            Top = 53
            Width = 333
            Height = 144
            Align = alBottom
            BorderOuter = fsNone
            TabOrder = 1
            object labMNY: TLabel
              Left = 13
              Top = 14
              Width = 95
              Height = 20
              Caption = #21097#20313#37329#39069':'
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labPRC: TLabel
              Left = 13
              Top = 110
              Width = 95
              Height = 20
              Caption = #31036#21048#38754#20540':'
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labAMOUNT: TLabel
              Left = 34
              Top = 46
              Width = 74
              Height = 20
              Caption = #31036#21048#25968':'
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labNO: TLabel
              Left = 34
              Top = 79
              Width = 74
              Height = 20
              Caption = #31036#21048#21495':'
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 211
      Width = 347
      object Btn_Close: TRzBitBtn
        Left = 275
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Save: TRzBitBtn
        Left = 191
        Top = 10
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&S)'
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
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 8
    Top = 224
  end
  inherited actList: TActionList
    Left = 38
    Top = 224
  end
  object CdsVhPay: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 68
    Top = 224
  end
end
