inherited frmSyncData: TfrmSyncData
  Left = 237
  Top = 182
  Caption = #27491#22312#25191#34892#65292#35831#31245#21518'...'
  ClientHeight = 466
  ClientWidth = 770
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 770
    Height = 466
    inherited webForm: TRzPanel
      Width = 770
      Height = 466
      inherited bkgImage: TImage
        Width = 770
        Height = 466
      end
      object RzPanel1: TRzPanel
        Left = 184
        Top = 136
        Width = 380
        Height = 240
        BorderOuter = fsFlat
        TabOrder = 0
        object Image1: TImage
          Left = 1
          Top = 1
          Width = 378
          Height = 238
          Align = alClient
          AutoSize = True
        end
        object Label1: TLabel
          Left = 5
          Top = 157
          Width = 369
          Height = 12
          Alignment = taCenter
          AutoSize = False
          Caption = #31995#32479#30331#24405#20013#65292#35831#31245#20505
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object RzFormShape1: TRzFormShape
          Left = 1
          Top = 1
          Width = 378
          Height = 238
        end
        object ProgressBar1: TProgressBar
          Left = 120
          Top = 180
          Width = 161
          Height = 7
          TabOrder = 0
        end
      end
    end
  end
end
