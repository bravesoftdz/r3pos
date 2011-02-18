inherited frmPosMainList: TfrmPosMainList
  ActiveControl = DBGridEh1
  Caption = #38144#21806#21333#26597#35810
  ClientWidth = 492
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 492
    inherited RzPage: TRzPageControl
      Top = 49
      Width = 482
      Height = 286
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #38144#21806#21333#21015#34920
        inherited RzPanel2: TRzPanel
          Width = 478
          Height = 259
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 468
            Height = 249
            Align = alClient
            AllowedOperations = []
            DataSource = dsList
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
            ReadOnly = True
            RowHeight = 20
            TabOrder = 0
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
            OnKeyPress = DBGridEh1KeyPress
            Columns = <
              item
                EditButtons = <>
                FieldName = 'GLIDE_NO'
                Footers = <>
                Title.Caption = #21333#21495
                Width = 99
              end
              item
                EditButtons = <>
                FieldName = 'SALES_DATE'
                Footers = <>
                Title.Caption = #38144#21806#26085#26399
                Width = 71
              end
              item
                EditButtons = <>
                FieldName = 'CUST_NAME'
                Footers = <>
                Title.Caption = #23458#25143#21517#31216
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'SHROFF_TEXT'
                Footers = <>
                Title.Caption = #25910#38134#21592
                Width = 58
              end
              item
                EditButtons = <>
                FieldName = 'AMOUNT'
                Footers = <>
                Title.Caption = #25968#37327
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'AMONEY'
                Footers = <>
                Title.Caption = #37329#39069
                Width = 76
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Width = 482
      object edtDelete: TRzBitBtn
        Left = 285
        Top = 6
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
        OnClick = edtDeleteClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtExit: TRzBitBtn
        Left = 372
        Top = 6
        Width = 70
        Height = 26
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
        OnClick = edtExitClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 482
      Height = 44
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 2
      object RzLabel2: TRzLabel
        Left = 25
        Top = 5
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #38144#21806#26085#26399
      end
      object RzLabel3: TRzLabel
        Left = 192
        Top = 5
        Width = 12
        Height = 12
        Caption = #33267
      end
      object RzLabel5: TRzLabel
        Left = 25
        Top = 25
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #38144#21806#21333#21495
      end
      object Label1: TLabel
        Left = 193
        Top = 26
        Width = 120
        Height = 12
        Caption = #25903#25345#27169#22359','#36755#21518'4'#20301#26597#35810
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object D1: TcxDateEdit
        Left = 81
        Top = 1
        Width = 104
        Height = 20
        Properties.DateButtons = [btnToday]
        TabOrder = 0
      end
      object D2: TcxDateEdit
        Left = 208
        Top = 1
        Width = 109
        Height = 20
        Properties.DateButtons = [btnToday]
        TabOrder = 1
      end
      object fndSALES_ID: TcxTextEdit
        Left = 81
        Top = 22
        Width = 104
        Height = 20
        TabOrder = 2
      end
      object btnOk: TRzBitBtn
        Left = 351
        Top = 18
        Width = 67
        Height = 26
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
        TabOrder = 3
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnOkClick
        ImageIndex = 12
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object cdsList: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'GLIDE_NO'
    Params = <>
    AfterScroll = cdsListAfterScroll
    Left = 345
    Top = 193
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 192
  end
end
