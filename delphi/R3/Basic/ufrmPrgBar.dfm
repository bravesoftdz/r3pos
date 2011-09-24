object frmPrgBar: TfrmPrgBar
  Left = 399
  Top = 208
  BorderStyle = bsNone
  Caption = 'frmPrgBar'
  ClientHeight = 129
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RzFormShape1: TRzFormShape
    Left = 0
    Top = 0
    Width = 357
    Height = 129
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 357
    Height = 129
    Align = alClient
    BorderInner = fsFlatBold
    BorderOuter = fsFlat
    BorderShadow = clNavy
    Color = clWhite
    TabOrder = 0
    object RzLabel1: TRzLabel
      Left = 27
      Top = 48
      Width = 302
      Height = 13
      AutoSize = False
      Caption = #35831#31245#20505'...'
    end
    object RzProgressBar1: TRzProgressBar
      Left = 27
      Top = 72
      Width = 305
      BorderOuter = fsFlatRounded
      BorderWidth = 0
      InteriorOffset = 0
      PartsComplete = 0
      Percent = 0
      TotalParts = 0
    end
  end
end
