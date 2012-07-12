inherited frmMktKpiModify: TfrmMktKpiModify
  Left = 349
  Top = 145
  Caption = #36820#21033#38144#37327#35843#25972
  ClientHeight = 443
  ClientWidth = 673
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 673
    Height = 443
    inherited RzPage: TRzPageControl
      Top = 73
      Width = 663
      Height = 325
      ActivePage = TabSheet2
      TabIndex = 1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #38750#36820#21033#21830#21697#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 659
          Height = 298
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 649
            Height = 288
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
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE'
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
                FieldName = 'UNIT_ID'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20301
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
                Width = 25
              end
              item
                ButtonStyle = cbsEllipsis
                EditButtons = <>
                FieldName = 'CALC_AMOUNT'
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
                FieldName = 'CALC_MONEY'
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
              end>
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Caption = #36820#21033#21830#21697#20449#24687
        object RzPanel3: TRzPanel
          Left = 0
          Top = 0
          Width = 659
          Height = 298
          Align = alClient
          BorderOuter = fsNone
          BorderWidth = 5
          TabOrder = 0
          object DBGridEh2: TDBGridEh
            Left = 5
            Top = 5
            Width = 649
            Height = 288
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
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                DisplayFormat = '0000-00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #38144#21806#26085#26399
                Width = 80
                Control = dropD2
                OnBeforeShowControl = DBGridEh2Columns2BeforeShowControl
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
                FieldName = 'UNIT_ID'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20301
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
                Width = 23
              end
              item
                ButtonStyle = cbsEllipsis
                EditButtons = <>
                FieldName = 'CALC_AMOUNT'
                Footer.ValueType = fvtSum
                Footers = <>
                Title.Caption = #25968#37327
                Width = 56
                OnUpdateData = DBGridEh2Columns6UpdateData
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
                FieldName = 'CALC_MONEY'
                Footer.ValueType = fvtSum
                Footers = <>
                Title.Caption = #37329#39069
                Width = 83
                OnUpdateData = DBGridEh2Columns8UpdateData
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
              end>
          end
          object dropD2: TcxDateEdit
            Left = 72
            Top = 96
            Width = 121
            Height = 20
            Properties.OnEditValueChanged = dropD2PropertiesEditValueChanged
            TabOrder = 1
            Visible = False
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 398
      Width = 663
      object btnOK: TRzBitBtn
        Left = 465
        Top = 10
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
        Left = 551
        Top = 10
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
      Width = 663
      Height = 68
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      DesignSize = (
        663
        68)
      object lab_KPI_NAME: TRzLabel
        Left = 353
        Top = 4
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
        Left = 257
        Top = 4
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
        Left = -23
        Top = 4
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
      object Label1: TLabel
        Left = 20
        Top = 43
        Width = 48
        Height = 12
        Caption = #19994#21153#26085#26399
      end
      object Label2: TLabel
        Left = 200
        Top = 43
        Width = 12
        Height = 12
        Caption = #33267
      end
      object Bevel1: TBevel
        Left = 18
        Top = 28
        Width = 631
        Height = 2
      end
      object edtKPI_NAME: TcxTextEdit
        Tag = 1
        Left = 450
        Top = 0
        Width = 195
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 1
      end
      object edtKPI_YEAR: TcxTextEdit
        Tag = 1
        Left = 320
        Top = 0
        Width = 50
        Height = 20
        Properties.MaxLength = 10
        TabOrder = 2
      end
      object edtCLIENT_ID: TcxTextEdit
        Tag = 1
        Left = 74
        Top = 0
        Width = 184
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 0
      end
      object D1: TcxDateEdit
        Left = 74
        Top = 39
        Width = 121
        Height = 20
        TabOrder = 3
      end
      object D2: TcxDateEdit
        Left = 218
        Top = 39
        Width = 121
        Height = 20
        TabOrder = 4
      end
      object RzBitBtn1: TRzBitBtn
        Left = 353
        Top = 36
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #26597#35810'(&F)'
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
        TabOrder = 5
        TextStyle = tsRaised
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
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
      Caption = #35774#20026#36820#21033#21830#21697
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 206
    Top = 221
    object N2: TMenuItem
      Action = actToNotModify
      Caption = #35774#20026#38750#36820#21033#21830#21697
    end
  end
end
