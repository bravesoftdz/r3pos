inherited frameTreeFindDialog: TframeTreeFindDialog
  Left = 374
  Top = 245
  ActiveControl = edtSearch
  BorderStyle = bsDialog
  Caption = #26641#26597#25214#23545#35805#26694
  ClientHeight = 349
  ClientWidth = 384
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 384
    Height = 349
    inherited RzPage: TRzPageControl
      Width = 374
      Height = 299
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 370
          Height = 295
          object fndPanel: TPanel
            Left = 5
            Top = 5
            Width = 360
            Height = 37
            Align = alTop
            BevelOuter = bvLowered
            Color = clWhite
            TabOrder = 0
            object RzPanel5: TRzPanel
              Left = 1
              Top = 1
              Width = 358
              Height = 35
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 1
              Color = clWhite
              TabOrder = 0
              object Label8: TLabel
                Left = 16
                Top = 10
                Width = 96
                Height = 12
                Caption = #36755#20837#35201#26597#35810#30340#20869#23481
              end
              object edtSearch: TcxTextEdit
                Tag = -1
                Left = 117
                Top = 6
                Width = 148
                Height = 20
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
                OnEnter = edtSearchEnter
                OnKeyPress = edtSearchKeyPress
              end
            end
          end
          object RzBitBtn1: TRzBitBtn
            Left = 287
            Top = 53
            Width = 67
            Height = 26
            Anchors = [akTop, akRight]
            Caption = #23637#24320'(&U)'
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
            OnClick = RzBitBtn1Click
            NumGlyphs = 2
            Spacing = 5
          end
          object RzBitBtn3: TRzBitBtn
            Left = 287
            Top = 93
            Width = 67
            Height = 26
            Anchors = [akTop, akRight]
            Caption = #25910#32553'(&I)'
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
            TabOrder = 3
            TextStyle = tsRaised
            ThemeAware = False
            OnClick = RzBitBtn3Click
            NumGlyphs = 2
            Spacing = 5
          end
          object RzTree: TRzTreeView
            Left = 5
            Top = 42
            Width = 265
            Height = 248
            SelectionPen.Color = clBtnShadow
            Align = alLeft
            FrameVisible = True
            HideSelection = False
            Indent = 19
            ReadOnly = True
            RightClickSelect = True
            RowSelect = True
            TabOrder = 1
            OnDblClick = RzTreeDblClick
            OnKeyPress = RzTreeKeyPress
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 304
      Width = 374
      object btnOk: TRzBitBtn
        Left = 171
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#35748'(&O)'
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
        Left = 259
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
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
end
