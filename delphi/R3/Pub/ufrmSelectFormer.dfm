inherited frmSelectFormer: TfrmSelectFormer
  Left = 460
  Top = 131
  BorderStyle = bsDialog
  Caption = #25253#34920#27169#29256
  ClientHeight = 291
  ClientWidth = 304
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object RzPage: TRzPageControl [0]
    Left = 0
    Top = 0
    Width = 304
    Height = 249
    ActivePage = TabSheet1
    Align = alClient
    TabHeight = 20
    TabIndex = 0
    TabOrder = 0
    TabStyle = tsRoundCorners
    FixedDimension = 20
    object TabSheet1: TRzTabSheet
      Caption = #21487#29992#27169#29256#21015#34920
      object RzPanel2: TRzPanel
        Left = 0
        Top = 0
        Width = 300
        Height = 222
        Align = alClient
        BorderOuter = fsNone
        BorderWidth = 5
        TabOrder = 0
        object RzPanel1: TRzPanel
          Left = 5
          Top = 5
          Width = 290
          Height = 212
          Align = alClient
          BorderInner = fsFlatBold
          BorderOuter = fsFlatRounded
          TabOrder = 0
          object frfGrid: TRzStringGrid
            Left = 4
            Top = 4
            Width = 282
            Height = 204
            Align = alClient
            ColCount = 1
            DefaultColWidth = 250
            FixedCols = 0
            RowCount = 6
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
            TabOrder = 0
          end
        end
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 249
    Width = 304
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOK: TRzBitBtn
      Left = 129
      Top = 7
      Width = 71
      Caption = #30830#23450'(&O)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TRzBitBtn
      Left = 207
      Top = 7
      Width = 71
      Cancel = True
      ModalResult = 2
      Caption = #21462#28040'(&C)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 1
    end
  end
end
