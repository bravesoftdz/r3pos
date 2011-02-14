inherited frameDialogForm: TframeDialogForm
  Left = 288
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #24377#20986#24335#31383#20307#27169#29256
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object bgPanel: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 541
    Height = 376
    Align = alClient
    BorderOuter = fsNone
    BorderWidth = 5
    TabOrder = 0
    object RzPage: TRzPageControl
      Left = 5
      Top = 5
      Width = 531
      Height = 326
      ActivePage = TabSheet1
      Align = alClient
      TabHeight = 20
      TabIndex = 0
      TabOrder = 0
      TabStyle = tsRoundCorners
      FixedDimension = 20
      object TabSheet1: TRzTabSheet
        Caption = #22522#30784#20449#24687
        object RzPanel2: TRzPanel
          Left = 0
          Top = 0
          Width = 527
          Height = 299
          Align = alClient
          BorderOuter = fsNone
          BorderWidth = 5
          TabOrder = 0
        end
      end
    end
    object btPanel: TRzPanel
      Left = 5
      Top = 331
      Width = 531
      Height = 40
      Align = alBottom
      BorderOuter = fsNone
      TabOrder = 1
    end
  end
end
