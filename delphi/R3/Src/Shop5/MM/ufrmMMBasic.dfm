object frmMMBasic: TfrmMMBasic
  Left = 428
  Top = 124
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'frmMMBasic'
  ClientHeight = 388
  ClientWidth = 541
  Color = 16621644
  TransparentColor = True
  TransparentColorValue = clFuchsia
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 12
  object bgk_tt: TRzPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 38
    Align = alTop
    BorderOuter = fsNone
    ParentColor = True
    TabOrder = 0
    Transparent = True
    DesignSize = (
      541
      38)
    object bkg_01: TImage
      Left = 0
      Top = 0
      Width = 8
      Height = 38
      Align = alLeft
      AutoSize = True
    end
    object bkg_02: TImage
      Left = 533
      Top = 0
      Width = 8
      Height = 38
      Align = alRight
      AutoSize = True
    end
    object bkg_top: TRzPanel
      Left = 8
      Top = 0
      Width = 525
      Height = 38
      Align = alClient
      BorderOuter = fsFlat
      BorderSides = [sdTop]
      Color = 16621644
      FlatColor = 6842472
      TabOrder = 0
      DesignSize = (
        525
        38)
      object bkg_f1: TRzBackground
        Left = 280
        Top = 2
        Width = 237
        Height = 36
        Active = True
        Align = alNone
        Anchors = [akTop, akRight]
        GradientColorStart = 16621644
        GradientColorStop = 15847231
        GradientDirection = gdVerticalEnd
        ImageStyle = isCenter
        ShowGradient = True
        ShowImage = False
        ShowTexture = False
      end
      object formLogo: TImage
        Left = 1
        Top = 8
        Width = 65
        Height = 13
        AutoSize = True
      end
      object RzFormShape1: TRzFormShape
        Left = 0
        Top = 2
        Width = 525
        Height = 36
      end
      object RzSeparator1: TRzSeparator
        Left = 0
        Top = 1
        Width = 525
        Height = 1
        HighlightColor = 16703918
        HighlightLocation = hlUpperLeft
        ShowGradient = True
        Align = alTop
        Color = 16703918
        ParentColor = False
      end
    end
    object sysMinimized: TRzBmpButton
      Left = 389
      Top = 8
      Width = 28
      Height = 23
      Bitmaps.TransparentColor = clOlive
      Color = clBtnFace
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = sysMinimizedClick
    end
    object sysMaximized: TRzBmpButton
      Left = 434
      Top = 8
      Width = 28
      Height = 23
      Bitmaps.TransparentColor = clOlive
      Color = clBtnFace
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = sysMaximizedClick
    end
    object sysClose: TRzBmpButton
      Left = 468
      Top = 8
      Width = 41
      Height = 23
      Bitmaps.TransparentColor = clOlive
      Color = clBtnFace
      Anchors = [akTop, akRight]
      TabOrder = 3
      OnClick = sysCloseClick
    end
  end
  object bkg_bb: TRzPanel
    Left = 0
    Top = 362
    Width = 541
    Height = 26
    Align = alBottom
    BorderOuter = fsNone
    ParentColor = True
    TabOrder = 1
    Transparent = True
    object RzPanel10: TRzPanel
      Left = 0
      Top = 0
      Width = 8
      Height = 26
      Align = alLeft
      BorderOuter = fsNone
      TabOrder = 0
      object bkg_03: TImage
        Left = 0
        Top = -30
        Width = 8
        Height = 56
        Align = alBottom
        AutoSize = True
      end
    end
    object RzPanel11: TRzPanel
      Left = 533
      Top = 0
      Width = 8
      Height = 26
      Align = alRight
      BorderOuter = fsNone
      TabOrder = 1
      object bkg_04: TImage
        Left = 0
        Top = -30
        Width = 8
        Height = 56
        Align = alBottom
        AutoSize = True
      end
    end
    object bkg_bottom: TRzPanel
      Left = 8
      Top = 0
      Width = 525
      Height = 26
      Align = alClient
      BorderOuter = fsFlat
      BorderSides = [sdBottom]
      Color = 16621644
      FlatColor = 6842472
      TabOrder = 2
      object RzSeparator3: TRzSeparator
        Left = 0
        Top = 24
        Width = 525
        Height = 1
        ShowGradient = True
        Align = alBottom
        Color = 16703918
        ParentColor = False
      end
      object bkg_f2: TRzBackground
        Left = 0
        Top = 0
        Width = 113
        Height = 24
        Active = True
        Align = alLeft
        GradientColorStart = 15847231
        GradientColorStop = 16621644
        GradientDirection = gdVerticalEnd
        ImageStyle = isCenter
        ShowGradient = True
        ShowImage = False
        ShowTexture = False
      end
    end
  end
  object bkg: TRzPanel
    Left = 0
    Top = 38
    Width = 541
    Height = 324
    Align = alClient
    BorderOuter = fsFlat
    BorderSides = [sdLeft, sdRight]
    Color = 16621644
    FlatColor = 6842472
    TabOrder = 2
    object bkg_pnl: TRzPanel
      Left = 1
      Top = 0
      Width = 539
      Height = 324
      Align = alClient
      BorderOuter = fsFlat
      BorderSides = [sdLeft, sdRight]
      Color = clSilver
      FlatColor = 16703918
      TabOrder = 0
    end
  end
end
