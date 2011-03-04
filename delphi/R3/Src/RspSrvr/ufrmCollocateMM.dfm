inherited frmCollocateMM: TfrmCollocateMM
  Left = 481
  Top = 285
  Width = 369
  Height = 244
  Caption = #26032#21830#30431#37197#32622
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel [0]
    Left = 31
    Top = 59
    Width = 93
    Height = 12
    Alignment = taRightJustify
    AutoSize = False
    Caption = #26381#21153#22320#22336#65306
  end
  object Label2: TLabel [1]
    Left = 31
    Top = 85
    Width = 93
    Height = 12
    Alignment = taRightJustify
    AutoSize = False
    Caption = #29992' '#25143' '#21517#65306
  end
  object Label3: TLabel [2]
    Left = 31
    Top = 110
    Width = 93
    Height = 12
    Alignment = taRightJustify
    AutoSize = False
    Caption = #23494#12288#12288#30721#65306
  end
  object Label5: TLabel [3]
    Left = 31
    Top = 134
    Width = 93
    Height = 12
    Alignment = taRightJustify
    AutoSize = False
    Caption = #23494#30721#30830#35748#65306
  end
  object edtURL: TcxTextEdit [4]
    Left = 126
    Top = 56
    Width = 184
    Height = 20
    TabOrder = 0
  end
  object edtUSERNAME: TcxTextEdit [5]
    Left = 126
    Top = 81
    Width = 184
    Height = 20
    TabOrder = 1
  end
  object edtPASSWORD: TcxTextEdit [6]
    Left = 126
    Top = 106
    Width = 184
    Height = 20
    Properties.EchoMode = eemPassword
    TabOrder = 2
  end
  object RzPanel1: TRzPanel [7]
    Left = 0
    Top = 0
    Width = 361
    Height = 48
    Align = alTop
    BorderOuter = fsGroove
    BorderSides = [sdBottom]
    Color = clWhite
    TabOrder = 3
    object Label4: TLabel
      Left = 3
      Top = 14
      Width = 93
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #26032#21830#30431#21442#25968#37197#32622
    end
  end
  object RzPanel2: TRzPanel [8]
    Left = 0
    Top = 164
    Width = 361
    Height = 53
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    Color = clWhite
    TabOrder = 4
    object btnOK: TRzBitBtn
      Left = 188
      Top = 15
      Width = 64
      Caption = #30830#23450'&(0)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
      OnClick = btnOKClick
      NumGlyphs = 2
    end
    object RzBitBtn2: TRzBitBtn
      Left = 274
      Top = 15
      Width = 64
      Caption = #21462#28040'&(C)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 1
      OnClick = RzBitBtn2Click
      NumGlyphs = 2
    end
  end
  object edtPASSWORD1: TcxTextEdit [9]
    Left = 126
    Top = 130
    Width = 184
    Height = 20
    Properties.EchoMode = eemPassword
    TabOrder = 5
  end
  inherited mmMenu: TMainMenu
    Left = 40
    Top = 176
  end
  inherited actList: TActionList
    Left = 8
    Top = 176
  end
  object cdsMM: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 72
    Top = 176
  end
end
