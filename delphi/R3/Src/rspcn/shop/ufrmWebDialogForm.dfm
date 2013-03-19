inherited frmWebDialogForm: TfrmWebDialogForm
  Left = 1
  Top = 1
  Caption = 'frmWebDialogForm'
  ClientHeight = 720
  ClientWidth = 1262
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 1262
    Height = 720
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 1262
      Height = 720
      Align = alClient
      object bkgImage: TImage
        Left = 0
        Top = 0
        Width = 1262
        Height = 720
        Align = alClient
      end
    end
  end
end
