inherited frmDesigner: TfrmDesigner
  Left = 296
  Top = 250
  BorderStyle = bsDialog
  Caption = #25253#34920#26679#24335
  ClientHeight = 196
  ClientWidth = 287
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 193
    Height = 196
    Align = alLeft
    BorderInner = fsFlatBold
    BorderOuter = fsFlatRounded
    TabOrder = 0
    object frfGrid: TRzStringGrid
      Left = 4
      Top = 4
      Width = 185
      Height = 155
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
    object Panel1: TPanel
      Left = 4
      Top = 159
      Width = 185
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 11
        Width = 60
        Height = 12
        Caption = #40664#35748#26679#24335#65306
      end
    end
  end
  object btnPrint: TRzBitBtn [1]
    Left = 203
    Top = 11
    Caption = #25171#21360
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 1
    OnClick = btnPrintClick
    NumGlyphs = 2
  end
  object btnPriview: TRzBitBtn [2]
    Left = 203
    Top = 43
    Caption = #39044#35272
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 2
    OnClick = btnPriviewClick
    NumGlyphs = 2
  end
  object btnClose: TRzBitBtn [3]
    Left = 203
    Top = 139
    Caption = #20851#38381
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 3
    OnClick = btnCloseClick
    NumGlyphs = 2
  end
  object btnDesigner: TRzBitBtn [4]
    Left = 203
    Top = 75
    Caption = #35774#35745
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 4
    OnClick = btnDesignerClick
    NumGlyphs = 2
  end
  object btnDefault: TRzBitBtn [5]
    Left = 203
    Top = 107
    Caption = #35774#32622#40664#35748
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 5
    OnClick = btnDefaultClick
    NumGlyphs = 2
  end
  object frDesigner1: TfrDesigner
    HideDisabledButtons = False
    OnSaveReport = frDesigner1SaveReport
    Left = 164
    Top = 85
  end
end
