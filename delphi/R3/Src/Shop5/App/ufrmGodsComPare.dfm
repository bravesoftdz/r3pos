inherited frmGodsComPare: TfrmGodsComPare
  Left = 310
  Top = 192
  Caption = #21333#25454#21830#21697#23545#27604
  ClientWidth = 774
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 774
    inherited RzPage: TRzPageControl
      Width = 764
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 760
          Height = 333
          object pnlBarCode: TRzPanel
            Left = 5
            Top = 5
            Width = 750
            Height = 33
            Align = alTop
            BorderOuter = fsFlat
            BorderSides = [sdTop, sdBottom]
            Color = clWhite
            TabOrder = 0
            object lblInput: TLabel
              Left = 23
              Top = 6
              Width = 84
              Height = 20
              Caption = #26465#30721#36755#20837
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblHint: TLabel
              Left = 325
              Top = 11
              Width = 206
              Height = 12
              Caption = #35831#25353' [F2] '#20809#26631#28608#27963#26465#30721#36755#20837#26694'...'
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object edtInput: TcxTextEdit
              Left = 113
              Top = 3
              Width = 204
              Height = 27
              ParentFont = False
              Style.BorderStyle = ebsThick
              Style.Font.Charset = GB2312_CHARSET
              Style.Font.Color = clNavy
              Style.Font.Height = -19
              Style.Font.Name = #40657#20307
              Style.Font.Style = [fsBold]
              TabOrder = 0
              OnKeyDown = edtInputKeyDown
              OnKeyPress = edtInputKeyPress
            end
          end
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 38
            Width = 750
            Height = 290
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = DsGods
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 2
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            RowHeight = 17
            SumList.Active = True
            TabOrder = 1
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
            OnDrawFooterCell = DBGridEh1DrawFooterCell
            Columns = <
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
                Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721#12289#35745#37327#21333#20301#26465#30721'" '#26597#35810
                Width = 142
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                ReadOnly = True
                Tag = 1
                Title.Caption = #36135#21495
                Width = 61
              end
              item
                EditButtons = <>
                FieldName = 'BARCODE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #26465#30721
                Width = 93
              end
              item
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20301
                Width = 41
              end
              item
                EditButtons = <>
                FieldName = 'PROPERTY_01'
                Footers = <>
                ReadOnly = True
                Title.Caption = #23610#30721
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'PROPERTY_02'
                Footers = <>
                ReadOnly = True
                Title.Caption = #39068#33394
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'AMOUNT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24320#21333#25968
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'SCANAMOUNT'
                Footers = <>
                Title.Caption = #25195#25551#25968
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'STATUS'
                Footers = <>
                Title.Caption = #29366#24577
                Width = 100
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Width = 764
      object RzBitBtn2: TRzBitBtn
        Left = 687
        Top = 10
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object DsGods: TDataSource
    DataSet = CdsGods
    Left = 46
    Top = 214
  end
  object CdsGods: TZQuery
    FieldDefs = <
      item
        Name = 'SEQNO'
        DataType = ftInteger
      end
      item
        Name = 'GODS_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BARCODE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'GODS_CODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GODS_NAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'UNIT_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BATCH_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PROPERTY_01'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_02'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'SCANAMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'STATUS'
        DataType = ftString
        Size = 50
      end>
    CachedUpdates = True
    Params = <>
    Left = 78
    Top = 214
  end
end
