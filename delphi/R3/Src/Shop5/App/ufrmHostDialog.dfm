inherited frmHostDialog: TfrmHostDialog
  Left = 380
  Top = 239
  BorderStyle = bsDialog
  Caption = #36873#25321#26381#21153#20027#26426
  ClientHeight = 259
  ClientWidth = 384
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object RzBackground1: TRzBackground [0]
    Left = 0
    Top = 0
    Width = 384
    Height = 41
    Active = True
    Align = alTop
    GradientColorStart = clGray
    GradientColorStop = clGray
    ImageStyle = isCenter
    ShowGradient = True
    ShowImage = False
    ShowTexture = False
  end
  object Label1: TLabel [1]
    Left = 16
    Top = 14
    Width = 78
    Height = 12
    Caption = #26381#21153#20027#26426#22320#22336
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object rzDbList: TRzListView [2]
    Left = 0
    Top = 41
    Width = 384
    Height = 150
    Align = alTop
    Columns = <
      item
        Caption = #20027#26426#21495
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = #20027#26426#21517
        Width = 200
      end
      item
        Alignment = taCenter
        Caption = #29366#24577
        Width = 83
      end>
    FrameStyle = fsLowered
    FrameVisible = True
    Items.Data = {
      590000000300000000000000FFFFFFFFFFFFFFFF000000000000000006D6F7BB
      FABAC500000000FFFFFFFFFFFFFFFF000000000000000008D6F7BBFAC3FBB3C6
      00000000FFFFFFFFFFFFFFFF000000000000000004D7B4CCAC}
    RowSelect = True
    SmallImages = ImageList1
    TabOrder = 0
    ViewStyle = vsReport
  end
  object cxbtnCancel: TRzBitBtn [3]
    Left = 290
    Top = 204
    Height = 27
    Caption = #20851#38381'(&C)'
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 1
    OnClick = cxbtnCancelClick
    NumGlyphs = 2
  end
  object btnInstall: TRzBitBtn [4]
    Left = 207
    Top = 204
    Height = 27
    Caption = #36873#25321'(&O)'
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 2
    OnClick = btnInstallClick
    NumGlyphs = 2
  end
  object RzBitBtn1: TRzBitBtn [5]
    Left = 15
    Top = 204
    Height = 27
    Caption = #27880#20876'(&R)'
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 3
    OnClick = RzBitBtn1Click
    NumGlyphs = 2
  end
  object ImageList1: TImageList
    Height = 18
    Width = 10
    Left = 128
    Top = 96
  end
end
