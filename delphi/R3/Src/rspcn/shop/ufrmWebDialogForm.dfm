inherited frmWebDialogForm: TfrmWebDialogForm
  Left = 103
  Top = 0
  Caption = 'frmWebDialogForm'
  ClientHeight = 722
  ClientWidth = 1151
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited ScrollBox: TScrollBox
    Width = 1151
    Height = 722
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 1151
      Height = 722
      Align = alClient
      object bkgImage: TImage
        Left = 0
        Top = 0
        Width = 1151
        Height = 722
        Align = alClient
      end
    end
  end
end
