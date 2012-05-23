inherited frmMktKpiModify: TfrmMktKpiModify
  Left = 349
  Top = 145
  Caption = #36820#21033#38144#37327#35843#25972
  ClientHeight = 443
  ClientWidth = 726
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 726
    Height = 443
    inherited RzPage: TRzPageControl
      Top = 61
      Width = 716
      OnChange = RzPageChange
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #38750#36820#21033#21830#21697#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 712
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 702
            Height = 300
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = dsList
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 3
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu1
            RowHeight = 17
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            VertScrollBar.VisibleMode = sbAlwaysShowEh
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            OnDrawFooterCell = DBGridEh1DrawFooterCell
            OnKeyPress = DBGridEh1KeyPress
            Columns = <
              item
                Checkboxes = True
                EditButtons = <>
                FieldName = 'A'
                Footers = <>
                KeyList.Strings = (
                  '1'
                  '0')
                PickList.Strings = (
                  '0'
                  '1')
                Title.Caption = #36873#25321
                Width = 20
              end
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'SALES_DATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #38144#21806#26085#26399
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'GODS_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21830#21697#21517#31216
                Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721'" '#26597#35810
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36135#21495
                Width = 72
              end
              item
                Alignment = taCenter
                EditButtons = <>
                FieldName = 'UNIT_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20301
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
                Width = 30
              end
              item
                ButtonStyle = cbsEllipsis
                EditButtons = <>
                FieldName = 'AMOUNT'
                Footer.ValueType = fvtSum
                Footers = <>
                ReadOnly = True
                Title.Caption = #25968#37327
                Width = 56
              end
              item
                EditButtons = <>
                FieldName = 'APRICE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20215
                Width = 63
              end
              item
                EditButtons = <>
                FieldName = 'AMONEY'
                Footer.ValueType = fvtSum
                Footers = <>
                ReadOnly = True
                Title.Caption = #37329#39069
                Width = 83
              end
              item
                Alignment = taCenter
                Checkboxes = False
                EditButtons = <>
                FieldName = 'IS_PRESENT'
                Footers = <>
                KeyList.Strings = (
                  '0'
                  '1'
                  '2')
                PickList.Strings = (
                  #27491#24120
                  #36192#21697
                  #20817#25442)
                ReadOnly = True
                Title.Caption = #36192#21697
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#36192#21697#36716#25442
                Width = 36
              end
              item
                EditButtons = <>
                FieldName = 'BATCH_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #25209#21495
                Width = 95
              end
              item
                EditButtons = <>
                FieldName = 'REMARK'
                Footers = <>
                ReadOnly = True
                Title.Caption = #22791#27880
                Width = 140
              end
              item
                EditButtons = <>
                FieldName = 'GLIDE_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#21495
                Width = 110
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32463#38144#21830
                Width = 150
              end>
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Caption = #36820#21033#21830#21697#20449#24687
        object RzPanel3: TRzPanel
          Left = 0
          Top = 0
          Width = 712
          Height = 310
          Align = alClient
          BorderOuter = fsNone
          BorderWidth = 5
          TabOrder = 0
          object DBGridEh2: TDBGridEh
            Left = 5
            Top = 5
            Width = 702
            Height = 300
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = dsList2
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 3
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu2
            RowHeight = 17
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            VertScrollBar.VisibleMode = sbAlwaysShowEh
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh2DrawColumnCell
            OnDrawFooterCell = DBGridEh2DrawFooterCell
            OnKeyPress = DBGridEh2KeyPress
            Columns = <
              item
                Checkboxes = True
                EditButtons = <>
                FieldName = 'A'
                Footers = <>
                KeyList.Strings = (
                  '1'
                  '0')
                PickList.Strings = (
                  '0'
                  '1')
                Title.Caption = #36873#25321
                Width = 20
              end
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'SALES_DATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #38144#21806#26085#26399
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'GODS_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21830#21697#21517#31216
                Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721'" '#26597#35810
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36135#21495
                Width = 72
              end
              item
                Alignment = taCenter
                EditButtons = <>
                FieldName = 'UNIT_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20301
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
                Width = 30
              end
              item
                ButtonStyle = cbsEllipsis
                EditButtons = <>
                FieldName = 'AMOUNT'
                Footer.ValueType = fvtSum
                Footers = <>
                ReadOnly = True
                Title.Caption = #25968#37327
                Width = 56
              end
              item
                EditButtons = <>
                FieldName = 'APRICE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20215
                Width = 63
              end
              item
                EditButtons = <>
                FieldName = 'AMONEY'
                Footer.ValueType = fvtSum
                Footers = <>
                ReadOnly = True
                Title.Caption = #37329#39069
                Width = 83
              end
              item
                Alignment = taCenter
                Checkboxes = False
                EditButtons = <>
                FieldName = 'IS_PRESENT'
                Footers = <>
                KeyList.Strings = (
                  '0'
                  '1'
                  '2')
                PickList.Strings = (
                  #27491#24120
                  #36192#21697
                  #20817#25442)
                ReadOnly = True
                Title.Caption = #36192#21697
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#36192#21697#36716#25442
                Width = 36
              end
              item
                EditButtons = <>
                FieldName = 'BATCH_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #25209#21495
                Width = 95
              end
              item
                EditButtons = <>
                FieldName = 'REMARK'
                Footers = <>
                ReadOnly = True
                Title.Caption = #22791#27880
                Width = 140
              end
              item
                EditButtons = <>
                FieldName = 'GLIDE_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#21495
                Width = 110
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #32463#38144#21830
                Width = 150
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 398
      Width = 716
      object btnOK: TRzBitBtn
        Left = 550
        Top = 11
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&O)'
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
        OnClick = btnOKClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 636
        Top = 11
        Width = 70
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
        OnClick = btnExitClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 716
      Height = 56
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      object lab_KPI_NAME: TRzLabel
        Left = -16
        Top = 31
        Width = 90
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25351#26631#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel10: TRzLabel
        Left = 280
        Top = 31
        Width = 57
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #24180#24230
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel1: TRzLabel
        Left = -16
        Top = 7
        Width = 90
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #23458#25143#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtKPI_NAME: TcxTextEdit
        Tag = 1
        Left = 81
        Top = 27
        Width = 221
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 1
      end
      object edtKPI_YEAR: TcxTextEdit
        Tag = 1
        Left = 343
        Top = 27
        Width = 60
        Height = 20
        Properties.MaxLength = 10
        TabOrder = 2
      end
      object edtCLIENT_ID: TcxTextEdit
        Tag = 1
        Left = 81
        Top = 3
        Width = 221
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 0
      end
      object edtRightTranBtn: TRzBmpButton
        Left = 650
        Top = 21
        Width = 24
        Height = 24
        Bitmaps.Disabled.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFDFDFDFAFAFAFAFAFAFDFDFDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAEFEFEFEBEBEBEBEEF4FBFCFDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAE4E4E4D0D0D0AEBEE1DC
          E3F4FDFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCE8E8E8BEBE
          BF4D80E07EA3E9F8F9FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          F2F2F2CACACA4077DC0A70F2D4D9E5FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFCFCFCE1E1E1748ECA007DF7287BEAE6E6E6FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6C7CAD11974EB0088F82B7AE9E1E1E1FD
          FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7EBEBEBEFEFEFFBFBFBFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8BA1D2007FF7008B
          F72076E8D0D0D0F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7BFBFBFC3
          C3C3E7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA
          5D86DA0082F7008CF8077AF38D9BBFDEDEDEF7F7F7FEFEFEFFFFFFFFFFFFFFFF
          FFDFDFDF0057F24C73C8BFBFBFE7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFEAEAEA387AE60083F7008BF70082F72B6FDFAFB0B4D4D4D4E9E9E9
          F4F4F4FCFCFCFFFFFFDFDFDF0065F3006AF34C72C7BFBFBFE7E7E7FBFBFBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF3B7CE70080F60088F70086F7007BF62F
          6ED88C96ACB6B6B6C9C9C9D9D9D9DFDFDFC7C7C70066F30074F50067F34C72C6
          BFBFBFE7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFF6F6F66A92E3007BF60085
          F70085F70083F7007BF60A6EED376BCF5C7ABB9C9C9C9F9F9F979797006AF300
          74F50070F40C6BF34C71C4BFBFBFE7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFCFCFC
          A3B8E60073F50081F60082F60081F60080F6007DF60076F50070F4006AF30067
          F3006AF30070F40C7AF52D8AF64D99F72B7CF44C70C4BFBFBFE7E7E7FBFBFBFF
          FFFFFFFFFFFEFEFEE9ECF22172EE007BF5007FF6007EF6007EF6007CF6007BF5
          007AF50078F50076F51480F6318EF74F9DF760A5F85FA4F85EA0F82E7CF44E73
          C5CBCBCBF3F3F3FFFFFFFFFFFFFFFFFFFCFCFC9CB5EB006DF4007AF6007CF600
          7BF5007AF5067CF51984F63090F7489BF861A8F969ABF969AAF969AAF967A7F8
          66A6F864A3F83079F46689DCF3F3F3FFFFFFFFFFFFFFFFFFFFFFFFFAFAFA6390
          ED0F75F5278BF73695F7469CF859A6F868ADF96BAEF96EAFF96FAFF970AEF970
          AEF970ADF96FABF96EAAF86BA6F8347CF47497EAFBFBFBFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF9F9FA6F98ED1B76F34495F763AAF96BAEF96FB0F972B1F975B2
          F977B2F978B2F978B1F978B1F977B0F975ACF93980F47498EAFBFBFBFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDB5C8F44781EF0964F1005FF2
          0060F2005FF1005EF10061F20067F380B5FA80B4F97EB2F93E84F47498EAFBFB
          FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF005FF287B8F987B7F94286F5
          7498EAFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF0059F08E
          BBFA4789F57498EAFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFE7E7E70056F04A8BF57498EAFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF7F7F70048EE789BEEFBFBFBFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Bitmaps.TransparentColor = clOlive
        Bitmaps.Up.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C006000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFDFDFDFAFAFAFAFAFAFDFDFDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAEFEFEFEBEBEBEBF0EDFBFCFBFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAE4E4E4D0D0D0AFCBBBDC
          EAE2FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCE8E8E8BEBF
          BE4FA47380BF9AF8F9F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
          F2F2F2CACACA439A6810A251D4DED8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFCFCFCE1E1E175A38809AC562DA663E6E6E6FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6C7CCC91EA05907B45D2FA664E1E1E1FD
          FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7EBEBEBEFEFEFFBFBFBFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8CB29C09AC5608B8
          6125A65ED0D0D0F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7BFBFBFC3
          C3C3E7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA
          5FA47C0AB15B08BA630EAD598EA99ADEDEDEF7F7F7FEFEFEFFFFFFFFFFFFFFFF
          FFDFDFDF05B4524F9E6FBFBFBFE7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFEAEAEA3CA16819B96808BB6307B65F2FA061AFB2B0D4D4D4E9E9E9
          F4F4F4FCFCFCFFFFFFDFDFDF07BD6208C46A4F9F6FBFBFBFE7E7E7FBFBFBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF3EA36A2BBD7319BF6D08BA6307B45D32
          9C618C9E94B6B6B6C9C9C9D9D9D9DFDFDFC7C7C707BD6209CA7508C46A4F9F70
          BFBFBFE7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFF6F6F66CB0882BBA7041C9
          861FC17208BB6407B76010AD593999625E94759C9C9C9F9F9F97979708BF6609
          CA7509CA7408C2694F9E6FBFBFBFE7E7E7FBFBFBFFFFFFFFFFFFFFFFFFFCFCFC
          A4CAB41CB0625BCF9553CF9134C77F14C06D08BC6507BA6407B75F07B55D06B6
          5C08BC6309C46D09C87309C97409C97308C1674E9E6FBFBFBFE7E7E7FBFBFBFF
          FFFFFFFFFFFEFEFEE9EEEB29A56154CB8E64D39C65D49E55D19537CA831BC474
          08C06A08C26B08C36D09C46E09C57009C67109C77209C87309C77108BF66509E
          71CBCBCBF3F3F3FFFFFFFFFFFFFFFFFFFCFCFC9DCAB026B3686BD39F6ED6A36E
          D7A36ED8A466D6A04ED19336CC8620C77A0EC36F09C46E09C56F09C57009C671
          09C67109C56F08BA6168B589F3F3F3FFFFFFFFFFFFFFFFFFFFFFFFFAFAFA65B5
          873FBD7B72D6A374D8A774D9A874D9A873D9A870DAA76DDAA65ED79E4CD3943C
          CF8B30CC8424CA7E1AC87814C6720AB96176C296FBFBFBFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF9FAF971BA9028B26858CB9177D8A87BDBAC79DBAC76DBAA74DA
          A970DAA76CD9A667D9A362D8A15DD79F56D5992CC27776C196FBFBFBFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDB6DAC54AB0760EA55505A751
          05A95206AA5306AC5407B15A08BA626ED9A668D8A362D69E31C17876C095FBFB
          FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF07B05973D9A86ED8A437C17A
          77BF95FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF06AA5378
          D9A93CC07C76BE94FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFE7E7E705A55041C07E76BD94FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF7F7F70494417AC097FBFBFBFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Color = clBtnFace
        TabOrder = 3
        OnClick = actToModifyExecute
      end
      object edtLeftTranBtn: TRzBmpButton
        Left = 686
        Top = 21
        Width = 24
        Height = 24
        Bitmaps.Disabled.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFBFBFB789BEE0048EEF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFBFBFB7498EA4A8BF50056F0E7E7E7FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB7498EA4789F58EBBFA0059F0
          DFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB7498EA4286F587
          B7F987B8F9005FF2DFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB7498
          EA3E84F47EB2F980B4F980B5FA0067F30061F2005EF1005FF10060F2005FF209
          64F14781EFB5C8F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FBFBFB7498EA3980F475ACF977B0F978B1F978B1F978B2F977B2F975B2F972B1
          F96FB0F96BAEF963AAF94495F71B76F36F98EDF9F9FAFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFBFBFB7497EA347CF46BA6F86EAAF86FABF970ADF970AEF970AEF9
          6FAFF96EAFF96BAEF968ADF959A6F8469CF83695F7278BF70F75F56390EDFAFA
          FAFFFFFFFFFFFFFFFFFFFFFFFFF3F3F36689DC3079F464A3F866A6F867A7F869
          AAF969AAF969ABF961A8F9489BF83090F71984F6067CF5007AF5007BF5007CF6
          007AF6006DF49CB5EBFCFCFCFFFFFFFFFFFFFFFFFFF3F3F3CBCBCB4E73C52E7C
          F45EA0F85FA4F860A5F84F9DF7318EF71480F60076F50078F5007AF5007BF500
          7CF6007EF6007EF6007FF6007BF52172EEE9ECF2FEFEFEFFFFFFFFFFFFFBFBFB
          E7E7E7BFBFBF4C70C42B7CF44D99F72D8AF60C7AF50070F4006AF30067F3006A
          F30070F40076F5007DF60080F60081F60082F60081F60073F5A3B8E6FCFCFCFF
          FFFFFFFFFFFFFFFFFBFBFBE7E7E7BFBFBF4C71C40C6BF30070F40074F5006AF3
          9797979F9F9F9C9C9C5C7ABB376BCF0A6EED007BF60083F70085F70085F7007B
          F66A92E3F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFBFBFBE7E7E7BFBFBF4C72C600
          67F30074F50066F3C7C7C7DFDFDFD9D9D9C9C9C9B6B6B68C96AC2F6ED8007BF6
          0086F70088F70080F63B7CE7EFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFB
          FBE7E7E7BFBFBF4C72C7006AF30065F3DFDFDFFFFFFFFCFCFCF4F4F4E9E9E9D4
          D4D4AFB0B42B6FDF0082F7008BF70083F7387AE6EAEAEAFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFBFBFBE7E7E7BFBFBF4C73C80057F2DFDFDFFFFFFFFFFF
          FFFFFFFFFEFEFEF7F7F7DEDEDE8D9BBF077AF3008CF80082F75D86DAEAEAEAFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBE7E7E7C3C3C3BFBFBF
          E7E7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6D0D0D02076E8008BF7007F
          F78BA1D2EFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB
          FBFBEFEFEFEBEBEBF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE1E1E1
          2B7AE90088F81974EBC7CAD1F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFE6E6E6287BEA007DF7748ECAE1E1E1FCFCFCFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFED4D9E50A70F24077DCCACACAF2F2F2FEFEFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F9FA7EA3E94D80E0BEBEBFE8E8
          E8FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFEDCE3F4AEBEE1
          D0D0D0E4E4E4FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB
          FCFDEBEEF4EBEBEBEFEFEFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFF}
        Bitmaps.TransparentColor = clOlive
        Bitmaps.Up.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C006000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFBFBFB7AC097049441F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFBFBFB76BD9441C07E05A550E7E7E7FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB76BE943CC07C78D9A906AA53
          DFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB77BF9537C17A6E
          D8A473D9A807B059DFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB76C0
          9531C17862D69E68D8A36ED9A608BA6207B15A06AC5406AA5305A95205A7510E
          A5554AB076B6DAC5FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FBFBFB76C1962CC27756D5995DD79F62D8A167D9A36CD9A670DAA774DAA976DB
          AA79DBAC7BDBAC77D8A858CB9128B26871BA90F9FAF9FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFBFBFB76C2960AB96114C6721AC87824CA7E30CC843CCF8B4CD394
          5ED79E6DDAA670DAA773D9A874D9A874D9A874D8A772D6A33FBD7B65B587FAFA
          FAFFFFFFFFFFFFFFFFFFFFFFFFF3F3F368B58908BA6109C56F09C67109C67109
          C57009C56F09C46E0EC36F20C77A36CC864ED19366D6A06ED8A46ED7A36ED6A3
          6BD39F26B3689DCAB0FCFCFCFFFFFFFFFFFFFFFFFFF3F3F3CBCBCB509E7108BF
          6609C77109C87309C77209C67109C57009C46E08C36D08C26B08C06A1BC47437
          CA8355D19565D49E64D39C54CB8E29A561E9EEEBFEFEFEFFFFFFFFFFFFFBFBFB
          E7E7E7BFBFBF4E9E6F08C16709C97309C97409C87309C46D08BC6306B65C07B5
          5D07B75F07BA6408BC6514C06D34C77F53CF915BCF951CB062A4CAB4FCFCFCFF
          FFFFFFFFFFFFFFFFFBFBFBE7E7E7BFBFBF4F9E6F08C26909CA7409CA7508BF66
          9797979F9F9F9C9C9C5E947539996210AD5907B76008BB641FC17241C9862BBA
          706CB088F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFBFBFBE7E7E7BFBFBF4F9F7008
          C46A09CA7507BD62C7C7C7DFDFDFD9D9D9C9C9C9B6B6B68C9E94329C6107B45D
          08BA6319BF6D2BBD733EA36AEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFB
          FBE7E7E7BFBFBF4F9F6F08C46A07BD62DFDFDFFFFFFFFCFCFCF4F4F4E9E9E9D4
          D4D4AFB2B02FA06107B65F08BB6319B9683CA168EAEAEAFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFBFBFBE7E7E7BFBFBF4F9E6F05B452DFDFDFFFFFFFFFFF
          FFFFFFFFFEFEFEF7F7F7DEDEDE8EA99A0EAD5908BA630AB15B5FA47CEAEAEAFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBE7E7E7C3C3C3BFBFBF
          E7E7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6D0D0D025A65E08B86109AC
          568CB29CEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB
          FBFBEFEFEFEBEBEBF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE1E1E1
          2FA66407B45D1EA059C7CCC9F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFE6E6E62DA66309AC5675A388E1E1E1FCFCFCFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFED4DED810A251439A68CACACAF2F2F2FEFEFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F9F880BF9A4FA473BEBFBEE8E8
          E8FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDDCEAE2AFCBBB
          D0D0D0E4E4E4FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB
          FCFBEBF0EDEBEBEBEFEFEFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFF}
        Color = clBtnFace
        TabOrder = 4
        OnClick = actToNotModifyExecute
      end
    end
  end
  inherited actList: TActionList
    object actToModify: TAction
      Caption = #36716#21521#36820#21033#21830#21697
      OnExecute = actToModifyExecute
    end
    object actToNotModify: TAction
      Caption = #36716#21521#38750#36820#21033#21830#21697
      OnExecute = actToNotModifyExecute
    end
    object actQuery: TAction
      Caption = #26597#35810
    end
  end
  object cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 350
    Top = 216
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 216
  end
  object cdsList2: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 350
    Top = 248
  end
  object dsList2: TDataSource
    DataSet = cdsList2
    Left = 382
    Top = 248
  end
  object PopupMenu1: TPopupMenu
    Left = 174
    Top = 221
    object N1: TMenuItem
      Action = actToModify
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 206
    Top = 221
    object N2: TMenuItem
      Action = actToNotModify
    end
  end
end
