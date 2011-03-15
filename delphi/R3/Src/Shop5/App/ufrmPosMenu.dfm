inherited frmPosMenu: TfrmPosMenu
  Left = 393
  Top = 212
  BorderStyle = bsNone
  Caption = #21151#33021#33756#21333
  ClientHeight = 329
  ClientWidth = 442
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 442
    Height = 329
    Align = alClient
    BorderInner = fsFlatBold
    BorderOuter = fsFlatRounded
    BorderColor = clTeal
    BorderShadow = clBlack
    BorderWidth = 3
    Color = clBlack
    TabOrder = 0
    object Panel1: TPanel
      Left = 7
      Top = 7
      Width = 428
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = #21151#33021#33756#21333
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object rgMenu: TRzStringGrid
      Left = 7
      Top = 32
      Width = 428
      Height = 290
      Align = alClient
      BorderStyle = bsNone
      Color = clBlack
      ColCount = 1
      DefaultColWidth = 428
      DefaultRowHeight = 30
      FixedCols = 0
      RowCount = 9
      FixedRows = 0
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect]
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
      OnKeyPress = rgMenuKeyPress
    end
  end
end
