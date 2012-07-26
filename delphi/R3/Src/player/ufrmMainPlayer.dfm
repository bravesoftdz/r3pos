object frmMainPlayer: TfrmMainPlayer
  Left = 192
  Top = 579
  Width = 207
  Height = 139
  Caption = 'frmMainPlayer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 112
    Top = 40
  end
end
