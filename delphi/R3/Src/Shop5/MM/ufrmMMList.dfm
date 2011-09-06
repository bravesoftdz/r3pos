inherited frmMMList: TfrmMMList
  Left = 856
  Top = 141
  BorderIcons = []
  Caption = 'frmMMList'
  ClientHeight = 458
  ClientWidth = 255
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 255
    inherited RzBackground3: TRzBackground
      Width = 255
    end
    inherited RzFormShape1: TRzFormShape
      Width = 255
    end
  end
  inherited RzPanel2: TRzPanel
    Top = 401
    Width = 255
    Height = 57
    inherited RzBackground2: TRzBackground
      Width = 255
      Height = 57
    end
  end
  inherited RzPanel3: TRzPanel
    Width = 255
    Height = 363
    object RzButton1: TRzButton
      Left = 56
      Top = 168
      Caption = 'RzButton1'
      TabOrder = 0
      OnClick = RzButton1Click
    end
  end
  object ImageList1: TImageList
    Left = 88
    Top = 232
  end
  object PopupMenu1: TPopupMenu
    Left = 112
    Top = 128
  end
end
