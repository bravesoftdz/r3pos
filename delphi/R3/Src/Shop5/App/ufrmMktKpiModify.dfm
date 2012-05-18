inherited frmMktKpiModify: TfrmMktKpiModify
  Left = 367
  Top = 179
  Caption = #36820#21033#38144#37327#35843#25972
  ClientHeight = 443
  ClientWidth = 726
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 726
    Height = 443
    inherited RzPage: TRzPageControl
      Top = 74
      Width = 716
      Height = 324
      ActivePage = TabSheet2
      TabIndex = 1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #38750#36820#21033#21830#21697#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 712
          Height = 297
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 702
            Height = 287
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
                EditButtons = <>
                FieldName = 'GODS_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21830#21697#21517#31216
                Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721'" '#26597#35810
                Width = 150
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
          Height = 297
          Align = alClient
          BorderOuter = fsNone
          BorderWidth = 5
          TabOrder = 0
          object DBGridEh2: TDBGridEh
            Left = 5
            Top = 5
            Width = 702
            Height = 287
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
                Width = 41
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
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'COPY_MODI_AMOUNT'
                Footers = <>
                Title.Caption = #35843#25972#38144#37327
                Width = 70
                OnUpdateData = DBGridEh2Columns8UpdateData
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0.00'
                EditButtons = <>
                FieldName = 'MODI_MONEY'
                Footers = <>
                Title.Caption = #35843#25972#37329#39069
                Width = 70
                OnUpdateData = DBGridEh2Columns9UpdateData
              end
              item
                EditButtons = <>
                FieldName = 'REMARK'
                Footers = <>
                ReadOnly = True
                Title.Caption = #22791#27880
                Width = 140
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
      Height = 69
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      object RzLabel2: TRzLabel
        Left = 25
        Top = 43
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #38144#21806#26085#26399
      end
      object RzLabel3: TRzLabel
        Left = 192
        Top = 43
        Width = 12
        Height = 12
        Caption = #33267
      end
      object lab_KPI_NAME: TRzLabel
        Left = -16
        Top = 12
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
        Top = 12
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
      object D1: TcxDateEdit
        Left = 81
        Top = 39
        Width = 104
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 0
      end
      object D2: TcxDateEdit
        Left = 208
        Top = 39
        Width = 109
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 1
      end
      object btnFind: TRzBitBtn
        Left = 336
        Top = 34
        Width = 67
        Height = 26
        Action = actQuery
        Caption = #26597#35810
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
        NumGlyphs = 2
        Spacing = 5
      end
      object edtKPI_NAME: TcxTextEdit
        Tag = 1
        Left = 81
        Top = 8
        Width = 221
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 3
      end
      object edtKPI_YEAR: TcxTextEdit
        Tag = 1
        Left = 343
        Top = 8
        Width = 60
        Height = 20
        Properties.MaxLength = 10
        TabOrder = 4
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
      OnExecute = actQueryExecute
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
