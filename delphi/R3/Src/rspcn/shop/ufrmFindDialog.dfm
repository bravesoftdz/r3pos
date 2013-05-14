inherited frmFindDialog: TfrmFindDialog
  Caption = 'frmFindDialog'
  ClientWidth = 433
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    Width = 433
    object RzPanel3: TRzPanel
      Left = 12
      Top = 53
      Width = 406
      Height = 256
      Anchors = [akLeft, akTop, akRight]
      BorderOuter = fsStatus
      TabOrder = 0
      object DBGridEh1: TDBGridEh
        Left = 1
        Top = 1
        Width = 404
        Height = 254
        Align = alClient
        AllowedOperations = [alopUpdateEh, alopAppendEh]
        AutoFitColWidths = True
        BorderStyle = bsNone
        DataSource = DataSource1
        FixedColor = clSilver
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clBlack
        FooterFont.Height = -15
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FrozenCols = 2
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghHighlightFocus, dghClearSelection]
        RowHeight = 25
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -15
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        TitleHeight = 30
        UseMultiTitle = True
        IsDrawNullRow = False
        CurrencySymbol = #65509
        DecimalNumber = 2
        DigitalNumber = 12
        OnDrawColumnCell = DBGridEh1DrawColumnCell
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SEQNO'
            Footers = <>
            ReadOnly = True
            Tag = 1
            Title.Caption = #24207#21495
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'CODE_ID'
            Footers = <>
            ReadOnly = True
            Tag = 1
            Title.Caption = #32534#30721
            Width = 123
          end
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #36873#39033#21517#31216
            Width = 260
          end>
      end
    end
    object btnFind: TRzBmpButton
      Left = 346
      Top = 12
      Width = 72
      Bitmaps.TransparentColor = clFuchsia
      Bitmaps.Up.Data = {
        86190000424D86190000000000003600000028000000480000001E0000000100
        1800000000005019000000000000000000000000000000000000EBEBEBEBEBEB
        EAEAEAE6E6E6DDDDDDD4D4D4CECECECDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
        CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
        CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
        CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
        CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
        CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCECECE
        D0D0D0D8D8D8E2E2E2E9E9E9EBEBEBEBEBEBEBEBEBEAEAEAE2E2E2CECECEB3B3
        B39F9F9F94949492929292929292929292929292929292929292929292929292
        9292929292929292929292929292929292929292929292929292929292929292
        9292929292929292929292929292929292929292929292929292929292929292
        9292929292929292929292929292929292929292929292929292929292929292
        9292929292929292929292929292929292929292929292929292929292929292
        929292929292929292929292929292929292929292939393989898A7A7A7C0C0
        C0D9D9D9E7E7E7EBEBEBEBEBEBE3E3E3C7C7C7BCBCBCC9C9C9DADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADAD0D0D0BCBCBC959595919191B4B4B4D9D9D9E9
        E9E9E9E9E9D4D4D4D2D2D2DADADADADADADBDBDBDADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADAA6A6A6919191BFBFBFE2E2E2E4E4E4DDDDDD
        DCDCDCDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADAD9D9D9939393A5A5A5D7D7D7E2E2E2E7E7E7DBDBDBDADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DAC1C1C1969696CFCFCFE4E4E4E7E7E7DADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADAD5D5D5929292CE
        CECEE5E5E5E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
        CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
        CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
        CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
        CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADA939393CECECEE8E8E8E8E8E8
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADAD9D9D99C9C9CD2D2D2EAEAEAECECECDBDBDBDADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DACFCFCFB1B1B1DCDCDCEBEBEBF0F0F0E3E3E3DADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADABFBFBFCDCDCDE6
        E6E6EBEBEBECECECEEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
        DADADADADADADADADADADADADADAD3D3D3C9C9C9E3E3E3EAEAEAEBEBEBEBEBEB
        EBEBEBEBEBEBE7E7E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1
        DEDEDED4D4D4D6D6D6E4E4E4EAEAEAEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAE7E7
        E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
        E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1E1E1E1E5E5E5E9E9
        E9EBEBEBEBEBEBEBEBEB}
      Color = clBtnFace
      Anchors = [akTop, akRight]
      Caption = #30830#35748
      TabOrder = 1
      OnClick = btnFindClick
    end
    object RzPanel5: TRzPanel
      Left = 12
      Top = 12
      Width = 319
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      BorderOuter = fsNone
      TabOrder = 2
      DesignSize = (
        319
        29)
      object Image4: TImage
        Left = 0
        Top = 0
        Width = 6
        Height = 29
        Align = alLeft
        AutoSize = True
        Picture.Data = {
          07544269746D61707A020000424D7A0200000000000036000000280000000600
          00001D000000010018000000000044020000C30E0000C30E0000000000000000
          0000FF00FFFF00FFFF00FFE6E6E6F5F5F5FCFCFC0000FF00FFFF00FFE1E1E1E9
          E9E9F4F4F4FBFBFB0000FF00FFCBCBCBE0E0E0FAFAFAFFFFFFFFFFFF0000CBCB
          CBCACACAF4F4F4FFFFFFFFFFFFFFFFFF0000ABABABD9D9D9FCFCFCFFFFFFFFFF
          FFFFFFFF0000A1A1A1DDDDDDFEFEFEFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
          FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
          00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
          FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
          9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
          FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
          FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
          00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
          FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
          9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
          FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009D9D9DDDDDDD
          FEFEFEFFFFFFFFFFFFFFFFFF00009B9B9BD9D9D9FCFCFCFFFFFFFFFFFFFFFFFF
          0000979797C9C9C9F4F4F4FFFFFFFFFFFFFFFFFF00009B9B9BADADADE0E0E0FA
          FAFAFFFFFFFFFFFF0000FF00FF929292B9B9B9DFDFDFF3F3F3FBFBFB0000FF00
          FFFF00FF919191ACACACC6C6C6D6D6D60000FF00FFFF00FFFF00FFA2A2A29999
          999999990000}
        Transparent = True
      end
      object Image6: TImage
        Left = 314
        Top = 0
        Width = 5
        Height = 29
        Align = alRight
        AutoSize = True
        Picture.Data = {
          07544269746D617006020000424D060200000000000036000000280000000500
          00001D0000000100180000000000D00100000000000000000000000000000000
          0000FCFCFCF5F5F5FF00FFFF00FFFF00FF00FCFCFCFCFCFCFFFFFFFF00FFFF00
          FF00FFFFFFFFFFFFFDFDFDFFFFFFFF00FF00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
          F700FFFFFFFFFFFFFFFFFFFDFDFDFDFDFD00FFFFFFFFFFFFFFFFFFFEFEFEFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFEFEFEFFFFFF00FFFFFFFFFFFFFFFFFFFCFCFCFDFD
          FD00FFFFFFFFFFFFFFFFFFF5F5F5F7F7F700FFFFFFFFFFFFFAFAFAE7E7E7E6E6
          E600FBFBFBF3F3F3DFDFDFE2E2E2FF00FF00D6D6D6C6C6C6CBCBCBFF00FFFF00
          FF00AEAEAECBCBCBFF00FFFF00FFFF00FF00}
        Transparent = True
      end
      object Image7: TImage
        Left = 6
        Top = 0
        Width = 308
        Height = 29
        Align = alClient
        AutoSize = True
        Picture.Data = {
          07544269746D61707A020000424D7A0200000000000036000000280000000600
          00001D0000000100180000000000440200000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000DEDE
          DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE00009E9E9E9E9E9E9E9E9E9E9E9E9E9E
          9E9E9E9E0000}
        Stretch = True
      end
      object serachText: TEdit
        Tag = -1
        Left = 6
        Top = 6
        Width = 308
        Height = 18
        Hint = #35831#36755#20837#21333#21495#25110#23458#25143#21517#31216#25110#22791#27880#35828#26126
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        Text = #35831#36755#20837#25628#32034#20869#23481
        OnChange = serachTextChange
        OnEnter = serachTextEnter
        OnExit = serachTextExit
        OnKeyPress = serachTextKeyPress
      end
    end
  end
  inherited pnlAddressBar: TPanel
    Width = 433
    inherited Image3: TImage
      Width = 425
    end
    inherited Image1: TImage
      Left = 429
    end
    inherited RzFormShape1: TRzFormShape
      Width = 433
    end
  end
  object rs: TZQuery
    FieldDefs = <>
    OnFilterRecord = rsFilterRecord
    CachedUpdates = True
    Params = <>
    Left = 112
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = rs
    Left = 144
    Top = 120
  end
end
