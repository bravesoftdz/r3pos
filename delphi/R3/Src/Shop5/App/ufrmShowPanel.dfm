object frmShowPanel: TfrmShowPanel
  Left = 340
  Top = 324
  BorderStyle = bsNone
  Caption = #39038#26174#23631
  ClientHeight = 112
  ClientWidth = 438
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
    Width = 438
    Height = 112
    Align = alClient
    BorderOuter = fsFlat
    BorderColor = clNavy
    BorderWidth = 1
    Color = clBlack
    FlatColor = clOlive
    TabOrder = 0
    object RzMarqueeStatus1: TRzStatusPane
      Left = 2
      Top = 2
      Width = 434
      Height = 108
      FrameStyle = fsNone
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -56
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Caption = #37329#39069':738.94'
    end
  end
  object Timer1: TTimer
    Interval = 20000
    OnTimer = Timer1Timer
    Left = 152
    Top = 16
  end
end
