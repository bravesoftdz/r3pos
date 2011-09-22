object frmProfitAnaly: TfrmProfitAnaly
  Left = 0
  Top = 0
  Width = 1016
  Height = 241
  TabOrder = 0
  OnResize = FrameResize
  object MainPnl: TPanel
    Left = 0
    Top = 0
    Width = 1016
    Height = 237
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 478
      Top = 0
      Width = 6
      Height = 237
      Color = clWhite
      ParentColor = False
    end
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 5
      Height = 237
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Pnl_Left: TPanel
      Left = 5
      Top = 0
      Width = 470
      Height = 237
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Panel1: TPanel
        Left = 0
        Top = 28
        Width = 470
        Height = 209
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object DBGridEh1: TDBGridEh
          Left = 1
          Top = 1
          Width = 468
          Height = 207
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
          OnGetFooterParams = DBGridEh1GetFooterParams
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
              Width = 102
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
              Alignment = taRightJustify
              DisplayFormat = '#,##0.00'
              EditButtons = <>
              FieldName = 'ANALYSUM'
              Footer.DisplayFormat = '#,##0.00'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #38144#21806#39069
              Title.Color = clWhite
              Width = 108
            end
            item
              EditButtons = <>
              FieldName = 'UNIT_NAME'
              Footers = <>
              Title.Caption = #21333#20301
              Title.Color = clWhite
              Width = 31
            end
            item
              EditButtons = <>
              FieldName = 'OrderNo'
              Footers = <>
              Title.Caption = #25490#21517
              Title.Color = clWhite
              Width = 32
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
      Left = 484
      Top = 0
      Width = 528
      Height = 237
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 528
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ChartTitle: TPanel
          Left = 0
          Top = 0
          Width = 419
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
          Left = 419
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
      object RzPanel15: TRzPanel
        Left = 0
        Top = 28
        Width = 528
        Height = 209
        Align = alClient
        BorderOuter = fsGroove
        Color = clWhite
        TabOrder = 1
        object Chart1: TChart
          Left = 2
          Top = 2
          Width = 524
          Height = 205
          BackWall.Brush.Color = clWhite
          BackWall.Brush.Style = bsClear
          MarginBottom = 0
          MarginLeft = 1
          MarginRight = 1
          MarginTop = 1
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
      end
    end
    object Panel5: TPanel
      Left = 475
      Top = 0
      Width = 3
      Height = 237
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object RihtPnl: TPanel
      Left = 1012
      Top = 0
      Width = 4
      Height = 237
      Align = alRight
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object ButtomPnl: TPanel
    Left = 0
    Top = 237
    Width = 1016
    Height = 4
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
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
