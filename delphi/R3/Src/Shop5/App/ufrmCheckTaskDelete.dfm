inherited frmCheckTaskDelete: TfrmCheckTaskDelete
  Left = 381
  Top = 247
  BorderStyle = bsDialog
  Caption = #30424#28857#31649#29702
  ClientHeight = 201
  ClientWidth = 338
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object RzLabel1: TRzLabel [0]
    Left = 32
    Top = 22
    Width = 84
    Height = 20
    Caption = #30424#28857#26085#26399
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = #40657#20307
    Font.Style = [fsBold]
    ParentFont = False
    TextStyle = tsRecessed
  end
  object Label1: TLabel [1]
    Left = 34
    Top = 54
    Width = 276
    Height = 60
    Caption = 
      #27880#65306#21482#33021#25764#28040#26410#23457#26680#30340#20219#21153#65292#22914#26524#24050#32463#23457#26680#35831#20808#24323#23457#13#13'    '#25764#28040#30424#28857#20219#21153#26102#36719#20214#23558#21024#38500#25152#26377#24050#24405#20837#30340#30424#28857#21333#13'  '#13'    '#25764#28040#21069#35831#30830#35748 +
      #28165#26970#26159#21542#19981#30424#28857#20102#65311
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object RzBitBtn5: TRzBitBtn [2]
    Left = 91
    Top = 149
    Height = 29
    Caption = #25764#28040#30424#28857
    Color = clSilver
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
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
    OnClick = RzBitBtn5Click
    NumGlyphs = 2
    Spacing = 5
  end
  object RzBitBtn1: TRzBitBtn [3]
    Left = 190
    Top = 149
    Height = 29
    Caption = #20851#38381
    Color = clSilver
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    ParentFont = False
    TextShadowColor = clYellow
    TextShadowDepth = 4
    TabOrder = 1
    OnClick = RzBitBtn1Click
    NumGlyphs = 2
    Spacing = 5
  end
  object CB_Delete: TCheckBox [4]
    Left = 33
    Top = 125
    Width = 209
    Height = 17
    Caption = #24378#21046#25764#28040#24182#21024#38500#24050#24405#20837#30340#30424#28857#21333
    TabOrder = 2
  end
  inherited mmMenu: TMainMenu
    Left = 184
    Top = 8
  end
  inherited actList: TActionList
    Left = 304
    Top = 8
  end
end
