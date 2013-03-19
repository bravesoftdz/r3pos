inherited frmGoodsSort: TfrmGoodsSort
  Left = 202
  Top = 227
  Caption = #21830#21697#20998#31867
  ClientHeight = 196
  ClientWidth = 346
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlAddressBar: TPanel
    Width = 346
    inherited Image1: TImage
      Left = -207
    end
    inherited RzFormShape1: TRzFormShape
      Width = 346
    end
    object Label1: TLabel [4]
      Left = 17
      Top = 30
      Width = 96
      Height = 15
      Caption = #28155#21152#21830#21697#20998#31867
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited RzBmpButton2: TRzBmpButton
      Left = 321
    end
  end
  inherited RzPanel1: TRzPanel
    Width = 346
    Height = 137
    object RzPanel20: TRzPanel
      Left = 40
      Top = 14
      Width = 99
      Height = 21
      BorderOuter = fsFlatRounded
      Caption = #19978#32423#20998#31867
      Color = 16185078
      FlatColor = clMenuHighlight
      TabOrder = 1
    end
    object sortDrop: TcxButtonEdit
      Tag = -1
      Left = 136
      Top = 13
      Width = 169
      Height = 23
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = sortDropPropertiesButtonClick
      Style.BorderStyle = ebsUltraFlat
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.ButtonStyle = btsUltraFlat
      TabOrder = 0
      OnKeyPress = sortDropKeyPress
    end
    object RzPanel2: TRzPanel
      Left = 40
      Top = 52
      Width = 99
      Height = 21
      BorderOuter = fsFlatRounded
      Caption = #20998#31867#21517#31216
      Color = 16185078
      FlatColor = clMenuHighlight
      TabOrder = 2
    end
    object edtSHOP_NEW_OUTPRICE: TcxTextEdit
      Left = 136
      Top = 51
      Width = 169
      Height = 23
      TabOrder = 3
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    end
    object RzBitBtn6: TRzBitBtn
      Left = 118
      Top = 94
      Width = 92
      Height = 28
      Anchors = [akTop, akRight]
      Caption = #20445#23384#24182#20851#38381
      Color = 15461355
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      HighlightColor = 14276036
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      ParentFont = False
      TextShadowColor = clWhite
      TextShadowDepth = 4
      TabOrder = 4
      TabStop = False
      ThemeAware = False
      NumGlyphs = 2
      Spacing = 5
    end
    object RzBitBtn7: TRzBitBtn
      Left = 221
      Top = 94
      Width = 74
      Height = 28
      Anchors = [akTop, akRight]
      Caption = #20851#38381
      Color = 15461355
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      HighlightColor = 14276036
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      ParentFont = False
      TextShadowColor = clWhite
      TextShadowDepth = 4
      TabOrder = 5
      TabStop = False
      ThemeAware = False
      OnClick = RzBitBtn7Click
      NumGlyphs = 2
      Spacing = 5
    end
  end
  inherited RzPanel6: TRzPanel
    Top = 193
    Width = 346
    inherited Image7: TImage
      Left = 265
    end
    inherited Image8: TImage
      Width = 184
    end
  end
  object cdsSort: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 65528
    Top = 104
  end
end
