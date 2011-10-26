inherited frmResetTimeStamp: TfrmResetTimeStamp
  Left = 621
  Top = 189
  Width = 462
  Height = 305
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #37325#32622#26102#38388#25139
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 454
    Height = 278
    Align = alClient
    BorderOuter = fsNone
    Color = clWhite
    TabOrder = 0
    object RzLabel1: TRzLabel
      Left = 91
      Top = 18
      Width = 260
      Height = 36
      Caption = #36873#25321#20197#19979#30340#36164#26009#26723#26696#21518#65292#25353#8220#37325#32622#8221#25353#38062#65292#13#13#31995#32479#23558#20026#24744#33258#21160#37325#32622#24403#21069#36164#26009#26723#26696#30340#26102#38388#25139#65281
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RzPanel2: TRzPanel
      Left = 0
      Top = 224
      Width = 454
      Height = 54
      Align = alBottom
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 0
      DesignSize = (
        454
        54)
      object Btn_Save: TRzBitBtn
        Left = 286
        Top = 13
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #37325#32622'(&R)'
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Close: TRzBitBtn
        Left = 372
        Top = 13
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20851#38381'(&C)'
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 1
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzGroupBox1: TRzGroupBox
      Left = 16
      Top = 71
      Width = 425
      Height = 150
      Caption = #36873#25321#37325#32622#26723#26696
      Color = clWhite
      TabOrder = 1
      object edtPUB_GOODS_RELATION: TcxCheckBox
        Left = 32
        Top = 32
        Width = 121
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20379#24212#38142#26723#26696
        TabOrder = 0
      end
      object edtPUB_GOODSINFO: TcxCheckBox
        Left = 232
        Top = 31
        Width = 121
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #21830#21697#36164#26009#26723#26696
        TabOrder = 1
      end
      object edtCA_RELATIONS: TcxCheckBox
        Left = 32
        Top = 70
        Width = 121
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20225#19994#20851#31995#26723#26696
        TabOrder = 2
      end
      object edtCA_TENANT: TcxCheckBox
        Left = 232
        Top = 69
        Width = 121
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20225#19994#36164#26009#26723#26696
        TabOrder = 3
      end
      object edtCA_USERS: TcxCheckBox
        Left = 32
        Top = 109
        Width = 121
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #29992#25143#36164#26009#26723#26696
        TabOrder = 4
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 16
    Top = 240
  end
  inherited actList: TActionList
    Left = 48
    Top = 240
  end
end
