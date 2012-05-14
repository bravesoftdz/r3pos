object frmPassword: TfrmPassword
  Left = 355
  Top = 430
  BorderStyle = bsDialog
  Caption = #29992#25143#35748#35777
  ClientHeight = 141
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 281
    Height = 81
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 96
    Height = 12
    Caption = #35831#36755#20837#31649#29702#23494#30721#65306
  end
  object MaskEdit1: TMaskEdit
    Left = 24
    Top = 48
    Width = 241
    Height = 20
    PasswordChar = '*'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 104
    Top = 101
    Width = 75
    Height = 25
    Caption = #30830#35748'(&O)'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 189
    Top = 101
    Width = 75
    Height = 25
    Caption = #21462#28040'(&C)'
    TabOrder = 2
    OnClick = Button2Click
  end
end
