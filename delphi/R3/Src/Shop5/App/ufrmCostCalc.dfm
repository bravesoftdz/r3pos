inherited frmCostCalc: TfrmCostCalc
  Left = 371
  Top = 306
  BorderStyle = bsDialog
  Caption = #25104#26412#26680#31639
  ClientHeight = 161
  ClientWidth = 349
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel [0]
    Left = 16
    Top = 12
    Width = 321
    Height = 89
    Shape = bsFrame
  end
  object Label11: TLabel [1]
    Left = 34
    Top = 51
    Width = 72
    Height = 12
    Caption = #25191#34892#25104#26412#26680#31639
    Font.Charset = GB2312_CHARSET
    Font.Color = clLime
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object RzProgressBar1: TRzProgressBar [2]
    Left = 33
    Top = 68
    Width = 280
    Height = 17
    BorderOuter = fsFlatRounded
    BorderWidth = 0
    InteriorOffset = 0
    PartsComplete = 0
    Percent = 0
    TotalParts = 0
  end
  object Label1: TLabel [3]
    Left = 33
    Top = 27
    Width = 222
    Height = 12
    Caption = #27491#22312#25104#26412#26680#31639#38656#35201#36739#38271#30340#26102#38388','#35831#31245#20505'....'
  end
  object btnStart: TRzBitBtn [4]
    Left = 147
    Top = 117
    Height = 28
    Caption = #24320#22987#35745#31639
    Color = 4227327
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    ParentFont = False
    TextShadowColor = clYellow
    TextShadowDepth = 4
    TabOrder = 0
    OnClick = btnStartClick
    NumGlyphs = 2
    Spacing = 5
  end
end
