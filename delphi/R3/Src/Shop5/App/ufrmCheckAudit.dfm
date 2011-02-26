inherited frmCheckAudit: TfrmCheckAudit
  Left = 377
  Top = 316
  BorderStyle = bsDialog
  Caption = #30424#28857#23457#26680
  ClientHeight = 220
  ClientWidth = 352
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
    Top = 56
    Width = 276
    Height = 36
    Caption = #27880#65306#30424#28857#23457#26680#21518#23558#20135#29983#25439#30410#35843#25972#21333#24182#26356#26032#24403#21069#24211#23384#37327#13#13'    '#35831#23545#27809#26377#30424#28857#30340#21830#21697#36873#25321#22788#29702#26041#24335#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object RzBitBtn5: TRzBitBtn [2]
    Left = 91
    Top = 168
    Height = 29
    Caption = #31435#21363#23457#26680
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
    Top = 168
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
  object rdb1: TcxRadioButton [4]
    Left = 32
    Top = 132
    Width = 263
    Height = 17
    Caption = #27809#26377#30424#28857#30340#21830#21697#24403#38646#24211#23384#22788#29702
    TabOrder = 2
  end
  object rdb2: TcxRadioButton [5]
    Left = 32
    Top = 108
    Width = 263
    Height = 17
    Caption = #27809#26377#30424#28857#30340#21830#21697#19981#22788#29702'('#20445#30041#24403#21069#24211#23384#37327')'
    Checked = True
    TabOrder = 3
    TabStop = True
  end
  inherited mmMenu: TMainMenu
    Left = 320
    Top = 88
  end
  inherited actList: TActionList
    Left = 320
    Top = 120
  end
end
