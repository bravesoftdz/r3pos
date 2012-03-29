inherited frmCostCalc: TfrmCostCalc
  Left = 460
  Top = 278
  BorderStyle = bsDialog
  Caption = #25104#26412#26680#31639
  ClientHeight = 199
  ClientWidth = 349
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel [0]
    Left = 14
    Top = 52
    Width = 321
    Height = 93
    Shape = bsFrame
  end
  object Label11: TLabel [1]
    Left = 32
    Top = 91
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
    Left = 31
    Top = 108
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
    Left = 31
    Top = 67
    Width = 198
    Height = 12
    Caption = #27491#22312#26680#31639#38656#35201#36739#38271#30340#26102#38388','#35831#31245#20505'....'
  end
  object Label2: TLabel [4]
    Left = 14
    Top = 16
    Width = 95
    Height = 20
    Caption = #25104#26412#26680#31639':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -20
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnStart: TRzBitBtn [5]
    Left = 139
    Top = 157
    Height = 28
    Caption = #25191#34892
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
