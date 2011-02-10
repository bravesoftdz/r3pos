object frmSaveDesigner: TfrmSaveDesigner
  Left = 385
  Top = 308
  BorderStyle = bsDialog
  Caption = #20445#23384#34920#26679#33267'...'
  ClientHeight = 179
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 179
    Align = alLeft
    BorderInner = fsFlatBold
    BorderOuter = fsFlatRounded
    TabOrder = 0
    object frfGrid: TRzStringGrid
      Left = 4
      Top = 4
      Width = 185
      Height = 171
      Align = alClient
      ColCount = 1
      FixedCols = 0
      RowCount = 6
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
      ColWidths = (
        154)
    end
  end
  object btnPrint: TRzBitBtn
    Left = 211
    Top = 19
    Caption = #20445#23384
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 1
    OnClick = btnPrintClick
    NumGlyphs = 2
  end
  object btnPriview: TRzBitBtn
    Left = 211
    Top = 59
    Caption = #21462#28040
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 2
    OnClick = btnPriviewClick
    NumGlyphs = 2
  end
end
