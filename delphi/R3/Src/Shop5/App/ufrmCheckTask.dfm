inherited frmCheckTask: TfrmCheckTask
  Left = 381
  Top = 247
  BorderStyle = bsDialog
  Caption = #30424#28857#31649#29702
  ClientHeight = 206
  ClientWidth = 344
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object RzLabel1: TRzLabel [0]
    Left = 32
    Top = 28
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
    Top = 117
    Width = 276
    Height = 36
    Caption = #27880#65306#24320#22987#30424#28857#21518#24314#35758#20572#27490#24405#20837#19994#21153#21333#25454#65292#24453#30424#28857#23457#26680#13'    '#13'    '#23436#27605#21518#20877#36827#34892#34917#24405#12290
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label40: TLabel [2]
    Left = 34
    Top = 73
    Width = 85
    Height = 16
    Caption = #30424#28857#26041#24335#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RzBitBtn5: TRzBitBtn [3]
    Left = 91
    Top = 169
    Height = 29
    Caption = #24320#22987#30424#28857
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
  object RzBitBtn1: TRzBitBtn [4]
    Left = 190
    Top = 169
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
  object edtCHECK_TYPE: TGroupBox [5]
    Left = 118
    Top = 59
    Width = 197
    Height = 38
    TabOrder = 2
    object RB_Single: TRadioButton
      Left = 8
      Top = 14
      Width = 78
      Height = 17
      Caption = #31616#21333#30424#28857
      Checked = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object RB_Multi: TRadioButton
      Left = 108
      Top = 14
      Width = 79
      Height = 17
      Caption = #22810#20154#30424#28857
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
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
