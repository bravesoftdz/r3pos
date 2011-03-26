inherited frmControlMenu: TfrmControlMenu
  Left = 638
  Top = 174
  BorderStyle = bsNone
  Caption = #27963#21160#26694
  ClientHeight = 300
  ClientWidth = 179
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 179
    Height = 300
    Align = alClient
    BorderInner = fsBump
    BorderOuter = fsNone
    BorderColor = clGrayText
    BorderWidth = 5
    TabOrder = 0
    object Image1: TImage
      Left = 7
      Top = 7
      Width = 165
      Height = 45
      Align = alTop
    end
    object RzPanel2: TRzPanel
      Left = 7
      Top = 52
      Width = 165
      Height = 241
      Align = alClient
      BorderOuter = fsGroove
      BorderSides = [sdTop]
      Color = clWhite
      TabOrder = 0
      DesignSize = (
        165
        241)
      object Label1: TLabel
        Left = 47
        Top = 149
        Width = 72
        Height = 12
        Caption = #20999#25442#25171#21360#26679#24335
      end
      object cmbPrintStyle: TcxComboBox
        Left = 23
        Top = 165
        Width = 121
        Height = 20
        Properties.Items.Strings = (
          #40664#35748#26679#24335)
        TabOrder = 0
      end
      object btnOnceReceipt: TRzBitBtn
        Left = 14
        Top = 14
        Width = 137
        Height = 34
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #31435#21363#25910#27454'(&R)'
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
        OnClick = btnOnceReceiptClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnStarPrint: TRzBitBtn
        Left = 14
        Top = 59
        Width = 137
        Height = 34
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #24320#22987#25171#21360'(&P)'
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
        TabOrder = 2
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnStarPrintClick
        Glyph.Data = {
          C6050000424DC605000000000000360400002800000014000000140000000100
          08000000000090010000120B0000120B0000000100000000000076747500EDED
          ED00A5A5A5003735380049474800FCFCFC00E2E1E0008A89890094939400FAFA
          FA009B9A9B00C2C1C100AAAAAB00E5E5E400F4F4F400CAC9CA006A676700DEDD
          DC00BAB9B90025232600D1D1D100F9F8F800E1E0DE00E9E8E600E5E4E200F6F6
          F600D6D5D4005D5B5B00DADADA0084838400B2B2B200BFBDBD00ECECEB00F1F0
          F000DCDCDA00F3F2F200E9E8E90053515200FEFEFE00CCCCC600C6C5C500D5D4
          D100CFCDCC00F0F0EF00E0DFDD00E3E3E200EBEAEB00CCCAC900DCDAD900BFBF
          BF00F7F6F500B6B5B500C1C0BF00CCCCCA00F8F8F600FAFAF900F8F7F600D8D8
          D600FEFEFD00BCBBBB00F4F4F300F2F2F000D0D0CF00CDCBCC00D1CFCE00BCBC
          BA00B9B9B600FDFCFB00FBFBFB00F9F9F800EFEFED00EBEAE800C6C4C300C3C3
          C20089878700B7B7B800AFAEAE00979698002F2E3000595758007F7E7F001917
          1B00E9E9E800D4D3D40058555500FCFBFC009F9EA000F1F1F000E7E6E500D4D3
          D200B3B4B3004E4C4D00D9DDDC00EFEFF000E5E4E500FBFCFC005F5D5D006360
          6000EAE9EA003D3C3E00D1CFD000D8D7D700EFF0EB008F8E8E00E1E5E400FDFD
          FD005F5E6100F5F5F500F5F6F700F8F7F800A2A0A200F7F8F800F9F9F900C8C7
          C700C8C8C8005A585800706E6F00BDBBBC00403E3F00F4F2F300F2F1F2008685
          8700B8B6B70042414300B9B6B800FEFDFE00FFFFFF00FFFFFF00808080008181
          8100828282008383830084848400858585008686860087878700888888008989
          89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
          9100929292009393930094949400959595009696960097979700989898009999
          99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
          A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
          A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
          B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
          B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
          C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
          C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
          D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
          D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
          E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
          E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
          F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
          F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00000000007F7F7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F447F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7F7F34497F7F7F0C14117F7F7F7F7F7F7F7F0E523B2F2F531408
          790C7E7E33587F7F7F7F69015253162F342020147918203C7E7E4B7F7F7F0520
          0D1E2F487217522B1A422D52707E7E3E7F7F0509292A7575180D5820466B352F
          0D20692E4B7F051565341240062D5857573823061A16455A567F05090F331111
          2C3D4C4E0474063A38320007017F446964223030472513131376251B2B697E24
          141544055711301129767B4E03137B25082B157E19570523713B3E0A4C61605B
          4F314E134E4C1509447E693C091950677702001B5B1004132552476F05267F7F
          7F6E027E2621010B671B5B0337321A43057F7F7F0A677E7E7E7E7D5D244D072B
          172D6B7E7F7F7F7F004D7E7E7E7E7E09707B14381646197F7F7F7F7F2D1A2605
          7E7E7E7E434D0152013C7F7F7F7F7F7F7F57495D557E7E7E49233A19707F7F7F
          7F7F7F7F7F7F7F2E075E6B49607F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F3872
          577F7F7F7F7F7F7F7F7F}
        Spacing = 5
      end
      object btnPrintPreview: TRzBitBtn
        Left = 14
        Top = 104
        Width = 137
        Height = 34
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #25171#21360#39044#35272'(&V)'
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
        TabOrder = 3
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnPrintPreviewClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 14
        Top = 195
        Width = 137
        Height = 34
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
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
        TabOrder = 4
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnExitClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 40
    Top = 289
  end
  inherited actList: TActionList
    Left = 8
    Top = 289
  end
end
