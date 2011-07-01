object frmProfitAnaly: TfrmProfitAnaly
  Left = 0
  Top = 0
  Width = 1057
  Height = 236
  TabOrder = 0
  OnResize = FrameResize
  object Splitter1: TSplitter
    Left = 470
    Top = 0
    Width = 6
    Height = 236
    Color = clWhite
    ParentColor = False
  end
  object Pnl_Left: TPanel
    Left = 0
    Top = 0
    Width = 470
    Height = 236
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 28
      Width = 470
      Height = 208
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      object DBGridEh1: TDBGridEh
        Left = 1
        Top = 1
        Width = 468
        Height = 206
        Align = alClient
        AllowedOperations = []
        AutoFitColWidths = True
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = True
        DataSource = dsAnaly
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        FooterColor = clWhite
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        FrozenCols = 3
        HorzScrollBar.Visible = False
        ImeName = #26497#21697#20116#31508#36755#20837#27861
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        RowHeight = 20
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = [fsBold]
        TitleHeight = 22
        UseMultiTitle = True
        VertScrollBar.VisibleMode = sbNeverShowEh
        IsDrawNullRow = False
        CurrencySymbol = #65509
        DecimalNumber = 2
        DigitalNumber = 12
        OnDrawColumnCell = DBGridEh1DrawColumnCell
        Columns = <
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'SEQNO'
            Footers = <>
            Title.Caption = #24207#21495
            Title.Color = clWhite
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'GODS_CODE'
            Footers = <>
            Title.Caption = #36135#21495
            Title.Color = clWhite
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'GODS_NAME'
            Footers = <>
            Title.Caption = #21830#21697#21517#31216
            Title.Color = clWhite
            Width = 158
          end
          item
            DisplayFormat = '#0.###'
            EditButtons = <>
            FieldName = 'ANALYSUM'
            Footer.DisplayFormat = '#0.###'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38144#21806#39069
            Title.Color = clWhite
            Width = 122
          end
          item
            EditButtons = <>
            FieldName = 'OrderNo'
            Footers = <>
            Title.Caption = #25490#21517
            Title.Color = clWhite
            Width = 46
          end>
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 470
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object PnlTop: TPanel
        Left = 0
        Top = 0
        Width = 365
        Height = 28
        Align = alClient
        BevelOuter = bvNone
        Caption = #21367#28895#21830#21697#65288#38144#21806#39069#65289#25490#21517
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RightPnl: TPanel
        Left = 365
        Top = 0
        Width = 105
        Height = 28
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object Label2: TLabel
          Left = 89
          Top = 7
          Width = 12
          Height = 12
          Caption = #21517
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object edtOrderNo: TcxComboBox
          Left = 39
          Top = 4
          Width = 49
          Height = 20
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12'
            '13'
            '14'
            '15'
            '16'
            '17'
            '18'
            '19'
            '20'
            '25'
            '30'
            '35'
            '40'
            '50'
            '80'
            '100')
          Properties.OnChange = edtOrderNoPropertiesChange
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clRed
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 0
          Text = '5'
        end
        object vType: TcxComboBox
          Left = 3
          Top = 4
          Width = 39
          Height = 20
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #21069
            #21518)
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = []
          TabOrder = 1
        end
      end
    end
  end
  object Pnl_Right: TPanel
    Left = 476
    Top = 0
    Width = 581
    Height = 236
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Chart1: TChart
      Left = 0
      Top = 28
      Width = 581
      Height = 208
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clBlue
      Title.Font.Height = -16
      Title.Font.Name = 'Arial'
      Title.Font.Style = [fsBold]
      Title.Text.Strings = (
        '')
      Title.Visible = False
      Legend.Alignment = laBottom
      Legend.TextStyle = ltsRightValue
      Legend.Visible = False
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object BarSeries1: TBarSeries
        ColorEachPoint = True
        Marks.ArrowLength = 20
        Marks.Style = smsValue
        Marks.Visible = False
        SeriesColor = clRed
        Title = #38144#37327
        MultiBar = mbNone
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 581
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object ChartTitle: TPanel
        Left = 0
        Top = 0
        Width = 472
        Height = 28
        Align = alClient
        BevelOuter = bvNone
        Caption = #21367#28895#21830#21697#65288#38144#21806#39069#65289#25490#21517
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object Panel4: TPanel
        Left = 472
        Top = 0
        Width = 109
        Height = 28
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object CB_Color: TCheckBox
          Left = 9
          Top = 6
          Width = 96
          Height = 17
          Caption = #26174#31034#19981#21516#39068#33394
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 0
          OnClick = CB_ColorClick
        end
      end
    end
  end
  object adoAnaly: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 32
    Top = 60
  end
  object dsAnaly: TDataSource
    DataSet = adoAnaly
    Left = 33
    Top = 98
  end
  object adoReport: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 32
    Top = 28
  end
end
