inherited frmSortDropFrom: TfrmSortDropFrom
  Caption = 'frmSortDropFrom'
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    object rzTree: TRzTreeView
      Left = 1
      Top = 1
      Width = 261
      Height = 213
      SelectionPen.Color = clBtnShadow
      Align = alClient
      BorderStyle = bsNone
      Images = ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnClick = rzTreeClick
      OnKeyPress = rzTreeKeyPress
    end
    object RzPanel2: TRzPanel
      Left = 1
      Top = 214
      Width = 261
      Height = 24
      Align = alBottom
      BorderOuter = fsFlat
      BorderSides = [sdTop]
      TabOrder = 1
      object RzLabel1: TRzLabel
        Left = 212
        Top = 5
        Width = 32
        Height = 15
        Cursor = crHandPoint
        Caption = #28165#38500
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = #23435#20307
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = RzLabel1Click
      end
    end
  end
  object ImageList1: TImageList
    Left = 56
    Top = 112
  end
end
