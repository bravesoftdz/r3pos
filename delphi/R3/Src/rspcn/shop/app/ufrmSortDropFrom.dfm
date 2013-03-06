inherited frmSortDropFrom: TfrmSortDropFrom
  Caption = 'frmSortDropFrom'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    object rzTree: TRzTreeView
      Left = 1
      Top = 1
      Width = 261
      Height = 261
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
  end
  object ImageList1: TImageList
    Left = 56
    Top = 112
  end
end
