inherited frmMMMain: TfrmMMMain
  Left = 858
  Top = 168
  BorderIcons = []
  Caption = 'frmMMMain'
  ClientHeight = 528
  ClientWidth = 243
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 243
    inherited RzBackground3: TRzBackground
      Width = 243
    end
    inherited RzFormShape1: TRzFormShape
      Width = 243
    end
  end
  inherited RzPanel2: TRzPanel
    Top = 471
    Width = 243
    Height = 57
    inherited RzBackground2: TRzBackground
      Width = 243
      Height = 57
    end
  end
  inherited RzPanel3: TRzPanel
    Width = 243
    Height = 433
    object RzButton1: TRzButton
      Left = 56
      Top = 168
      Caption = 'RzButton1'
      TabOrder = 0
      OnClick = RzButton1Click
    end
  end
  object RzTrayIcon1: TRzTrayIcon
    PopupMenu = PopupMenu1
    Icons = ImageList1
    Left = 112
    Top = 96
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
