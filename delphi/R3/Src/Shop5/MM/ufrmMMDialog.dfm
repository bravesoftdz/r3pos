inherited frmMMDialog: TfrmMMDialog
  Left = 557
  Top = 205
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = #32842#22825#23545#35805#26694
  ClientHeight = 462
  ClientWidth = 553
  OldCreateOrder = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgk_tt: TRzPanel
    Width = 553
    Height = 52
    inherited bkg_01: TImage
      Height = 52
    end
    inherited bkg_02: TImage
      Left = 545
      Height = 52
    end
    inherited bkg_top: TRzPanel
      Width = 537
      Height = 52
      inherited bkg_f1: TRzBackground
        Left = 300
      end
      inherited RzFormShape1: TRzFormShape
        Width = 537
        Height = 50
      end
      inherited RzSeparator1: TRzSeparator
        Width = 537
      end
      object Image2: TImage
        Left = 2
        Top = 25
        Width = 24
        Height = 24
        AutoSize = True
        Transparent = True
      end
      object rzUserInfo: TRzLabel
        Left = 32
        Top = 31
        Width = 131
        Height = 12
        Caption = #24352#19977'(dfsdjkfldsdfs)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
    end
  end
  inherited bkg_bb: TRzPanel
    Top = 428
    Width = 553
    Height = 34
    inherited RzPanel10: TRzPanel
      Height = 34
      inherited bkg_03: TImage
        Top = -22
      end
    end
    inherited RzPanel11: TRzPanel
      Left = 545
      Height = 34
      inherited bkg_04: TImage
        Top = -22
      end
    end
    inherited bkg_bottom: TRzPanel
      Width = 537
      Height = 34
      inherited RzSeparator3: TRzSeparator
        Top = 32
        Width = 537
      end
      inherited bkg_f2: TRzBackground
        Height = 32
      end
      object RzLabel1: TRzLabel
        Left = 4
        Top = 10
        Width = 129
        Height = 12
        Caption = #21457#36865#28040#24687' CTRL+ENTER'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object cxBtnOk: TRzBmpButton
        Left = 299
        Top = 4
        Width = 78
        Height = 24
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        Anchors = [akTop, akRight]
        Caption = #21457#36865'(&S)'
        TabOrder = 0
        OnClick = cxBtnOkClick
      end
      object cxBtnClose: TRzBmpButton
        Left = 216
        Top = 5
        Width = 78
        Height = 24
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        Anchors = [akTop, akRight]
        Caption = #20851#38381'(&C)'
        TabOrder = 1
        OnClick = cxBtnCloseClick
      end
    end
  end
  inherited bkg: TRzPanel
    Top = 52
    Width = 553
    Height = 376
    inherited bkg_pnl: TRzPanel
      Width = 551
      Height = 376
      object RzPanel5: TRzPanel
        Left = 1
        Top = 281
        Width = 549
        Height = 95
        Align = alBottom
        BorderOuter = fsNone
        Color = 16707028
        TabOrder = 0
        object RzPanel7: TRzPanel
          Left = 394
          Top = 21
          Width = 155
          Height = 74
          Align = alRight
          BorderOuter = fsNone
          Color = 16621644
          TabOrder = 0
        end
        object RzPanel8: TRzPanel
          Left = 0
          Top = 0
          Width = 549
          Height = 21
          Align = alTop
          BorderOuter = fsNone
          Color = 16621644
          TabOrder = 1
          object toolDesk: TRzBmpButton
            Left = 5
            Top = 2
            Width = 17
            Height = 17
            Cursor = crHandPoint
            GroupIndex = 999
            Down = True
            Bitmaps.TransparentColor = clFuchsia
            Color = clBtnFace
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = toolDeskClick
          end
        end
        object inputRTF: TRzRichEdit
          Left = 0
          Top = 21
          Width = 394
          Height = 74
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          ScrollBars = ssVertical
          TabOrder = 2
          OnKeyPress = inputRTFKeyPress
          FrameVisible = True
        end
      end
      object showRTF: TRzRichEdit
        Left = 1
        Top = 0
        Width = 394
        Height = 281
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        FrameVisible = True
      end
      object RzPanel4: TRzPanel
        Left = 395
        Top = 0
        Width = 155
        Height = 281
        Align = alRight
        BorderOuter = fsNone
        Color = 16621644
        TabOrder = 2
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 65
    Top = 204
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 345
    Top = 252
  end
end
