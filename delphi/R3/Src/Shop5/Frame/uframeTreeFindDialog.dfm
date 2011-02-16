inherited frameTreeFindDialog: TframeTreeFindDialog
  Left = 374
  Top = 245
  Caption = #26641#26597#25214#23545#35805#26694
  ClientHeight = 372
  ClientWidth = 361
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 361
    Height = 372
    inherited RzPage: TRzPageControl
      Width = 351
      Height = 322
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 347
          Height = 318
          object fndPanel: TPanel
            Left = 5
            Top = 5
            Width = 337
            Height = 37
            Align = alTop
            BevelOuter = bvLowered
            Color = clWhite
            TabOrder = 0
            object RzPanel5: TRzPanel
              Left = 1
              Top = 1
              Width = 335
              Height = 35
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 1
              Color = clWhite
              TabOrder = 0
              DesignSize = (
                335
                35)
              object Label8: TLabel
                Left = 24
                Top = 11
                Width = 72
                Height = 12
                Caption = #36755#20837#26597#35810#20869#23481
              end
              object edtSearch: TcxTextEdit
                Tag = -1
                Left = 103
                Top = 7
                Width = 135
                Height = 20
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
                OnKeyPress = edtSearchKeyPress
              end
              object RzBitBtn4: TRzBitBtn
                Left = 243
                Top = 4
                Width = 67
                Height = 26
                Anchors = [akTop, akRight]
                Caption = #25628#32034'(&F)'
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
                NumGlyphs = 2
                Spacing = 5
              end
            end
          end
          object RzTree: TRzTreeView
            Left = 5
            Top = 42
            Width = 337
            Height = 271
            SelectionPen.Color = clBtnShadow
            Align = alClient
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
      Top = 327
      Width = 351
      object btnOk: TRzBitBtn
        Left = 164
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
        Left = 252
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
