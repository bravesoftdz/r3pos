inherited frmDibsOption: TfrmDibsOption
  Left = 363
  Top = 249
  BorderStyle = bsNone
  Caption = 'frmDibsOption'
  ClientHeight = 194
  ClientWidth = 314
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 314
    Height = 194
    Align = alClient
    BorderInner = fsFlatBold
    BorderOuter = fsFlatRounded
    BorderColor = clBlack
    BorderShadow = clBlack
    BorderWidth = 3
    Color = clBlack
    TabOrder = 0
    object lblPAY_G: TLabel
      Left = 28
      Top = 457
      Width = 150
      Height = 29
      Caption = #25903#20184#26041#24335#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPAY_F: TLabel
      Left = 28
      Top = 408
      Width = 150
      Height = 29
      Caption = #25903#20184#26041#24335#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtPAY_G: TcxTextEdit
      Left = 172
      Top = 451
      Width = 233
      Height = 41
      TabStop = False
      Enabled = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.Color = 15198183
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -32
      Style.Font.Name = #40657#20307
      Style.Font.Style = [fsBold]
      TabOrder = 0
    end
    object edtPAY_F: TcxTextEdit
      Left = 172
      Top = 403
      Width = 233
      Height = 41
      TabStop = False
      Enabled = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.Color = 15198183
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -32
      Style.Font.Name = #40657#20307
      Style.Font.Style = [fsBold]
      TabOrder = 1
    end
    object rzGrid: TRzStringGrid
      Left = 7
      Top = 65
      Width = 300
      Height = 122
      Align = alClient
      BorderStyle = bsNone
      Color = clBlack
      ColCount = 3
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
      ParentFont = False
      TabOrder = 2
      OnDblClick = rzGridDblClick
      OnEnter = rzGridEnter
      OnKeyPress = rzGridKeyPress
      ColWidths = (
        60
        104
        107)
      RowHeights = (
        18
        51)
    end
    object RzPanel2: TRzPanel
      Left = 7
      Top = 7
      Width = 300
      Height = 58
      Align = alTop
      Alignment = taLeftJustify
      BorderOuter = fsFlatBold
      BorderSides = [sdBottom]
      Color = clBlack
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -35
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object edtPAY_FEE: TcxTextEdit
        Left = 3
        Top = 6
        Width = 294
        Height = 43
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -35
        Style.Font.Name = #40657#20307
        Style.Font.Style = [fsBold]
        TabOrder = 0
        OnKeyDown = edtPAY_FEEKeyDown
        OnKeyPress = edtPAY_FEEKeyPress
      end
    end
  end
end
