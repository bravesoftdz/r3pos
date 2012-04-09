object frmShowPanel: TfrmShowPanel
  Left = 932
  Top = 3
  BorderStyle = bsNone
  Caption = #39038#26174#23631
  ClientHeight = 69
  ClientWidth = 332
  Color = clBlack
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 69
    Align = alClient
    BorderOuter = fsNone
    BorderColor = clOlive
    BorderWidth = 2
    Color = clGreen
    FlatColor = clOlive
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 17
      Width = 117
      Height = 33
      Caption = #37329#39069':80'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -32
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 152
    Top = 16
  end
end
