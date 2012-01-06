inherited frmLocusNoProperty: TfrmLocusNoProperty
  Left = 487
  Top = 239
  ActiveControl = edtInput
  Caption = #25195#30721#35760#24405
  ClientHeight = 365
  ClientWidth = 491
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 491
    Height = 365
    inherited RzPage: TRzPageControl
      Width = 481
      Height = 315
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        Caption = #25195#30721#35760#24405
        inherited RzPanel2: TRzPanel
          Width = 477
          Height = 311
          BorderInner = fsFlat
          object DBGridEh1: TDBGridEh
            Left = 6
            Top = 41
            Width = 327
            Height = 264
            Align = alClient
            AllowedOperations = []
            AutoFitColWidths = True
            DataSource = DataSource1
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 2
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu1
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
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            OnGetFooterParams = DBGridEh1GetFooterParams
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
                FieldName = 'LOCUS_NO'
                Footer.ValueType = fvtCount
                Footers = <>
                ReadOnly = True
                Title.Caption = #29289#27969#36319#36394#30721
                Width = 222
              end
              item
                Alignment = taCenter
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21333#20301
                Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
                Width = 26
              end
              item
                EditButtons = <>
                FieldName = 'AMOUNT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #25968#37327
                Width = 40
              end>
          end
          object pnlBarCode: TRzPanel
            Left = 6
            Top = 6
            Width = 465
            Height = 35
            Align = alTop
            BorderOuter = fsFlat
            BorderSides = [sdTop, sdBottom]
            TabOrder = 0
            object lblInput: TLabel
              Left = 7
              Top = 7
              Width = 84
              Height = 20
              Caption = #25195#30721#36755#20837
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object edtInput: TcxTextEdit
              Left = 97
              Top = 4
              Width = 232
              Height = 27
              ParentFont = False
              Style.BorderStyle = ebsThick
              Style.Font.Charset = GB2312_CHARSET
              Style.Font.Color = clNavy
              Style.Font.Height = -19
              Style.Font.Name = #40657#20307
              Style.Font.Style = [fsBold]
              TabOrder = 0
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              OnKeyPress = edtInputKeyPress
            end
            object RzBitBtn1: TRzBitBtn
              Left = 343
              Top = 5
              Width = 66
              Height = 26
              Caption = #20445#23384'(&O)'
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
              OnClick = RzBitBtn1Click
              NumGlyphs = 2
              Spacing = 5
            end
          end
          object Panel1: TPanel
            Left = 333
            Top = 41
            Width = 138
            Height = 264
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
            object RzLEDDisplay: TRzLEDDisplay
              Left = 8
              Top = 122
              Width = 121
            end
            object Label1: TLabel
              Left = 8
              Top = 101
              Width = 24
              Height = 12
              Caption = #24050#25195
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 8
              Top = 181
              Width = 24
              Height = 12
              Caption = #24453#25195
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object RzLEDDisplay2: TRzLEDDisplay
              Left = 8
              Top = 202
              Width = 121
            end
            object Label3: TLabel
              Left = 8
              Top = 27
              Width = 24
              Height = 12
              Caption = #21512#35745
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object RzLEDDisplay1: TRzLEDDisplay
              Left = 8
              Top = 48
              Width = 121
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 320
      Width = 481
      Visible = False
    end
  end
  inherited actList: TActionList
    object actDelete: TAction
      Caption = #21024#38500
      OnExecute = actDeleteExecute
    end
    object actImport: TAction
      Caption = #23548#20837
      OnExecute = actImportExecute
    end
    object actDeleteAll: TAction
      Caption = #20840#37096#37325#25195
      OnExecute = actDeleteAllExecute
    end
  end
  object DataSource1: TDataSource
    Left = 206
    Top = 189
  end
  object PopupMenu1: TPopupMenu
    Left = 54
    Top = 190
    object N1: TMenuItem
      Action = actDelete
    end
    object N4: TMenuItem
      Action = actDeleteAll
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Action = actImport
    end
  end
  object cdsImport: TZQuery
    FieldDefs = <
      item
        Name = 'LOCUS_NO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AMOUNT'
        DataType = ftString
        Size = 50
      end>
    CachedUpdates = True
    Params = <>
    Left = 150
    Top = 222
  end
end
