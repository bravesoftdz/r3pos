inherited frmSalRetuMenu: TfrmSalRetuMenu
  Left = 599
  Top = 216
  BorderStyle = bsNone
  Caption = #36864#36135#31867#22411
  ClientHeight = 102
  ClientWidth = 235
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 235
    Height = 102
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
      Width = 221
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = #36864#36135#31867#22411
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
      Width = 221
      Height = 63
      Align = alClient
      BorderStyle = bsNone
      Color = clBlack
      ColCount = 1
      DefaultColWidth = 428
      DefaultRowHeight = 30
      FixedCols = 0
      RowCount = 10
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
      OnMouseDown = rgMenuMouseDown
    end
  end
end
