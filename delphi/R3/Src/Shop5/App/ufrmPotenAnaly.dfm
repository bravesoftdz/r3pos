object frmPotenAnaly: TfrmPotenAnaly
  Left = 0
  Top = 0
  Width = 1046
  Height = 236
  TabOrder = 0
  OnResize = FrameResize
  object Splitter1: TSplitter
    Left = 500
    Top = 0
    Width = 5
    Height = 236
    Color = clBtnFace
    ParentColor = False
  end
  object Pnl_Left: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 236
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object PnlTop1: TPanel
      Left = 0
      Top = 0
      Width = 500
      Height = 28
      Align = alTop
      BevelOuter = bvLowered
      Caption = #21367#28895#21830#21697#65288#38144#21806#39069#65289#25490#21517#9#9
      TabOrder = 0
      object Label1: TLabel
        Left = 411
        Top = 7
        Width = 12
        Height = 13
        Caption = #21069
      end
      object Label2: TLabel
        Left = 477
        Top = 7
        Width = 12
        Height = 13
        Caption = #21517
      end
      object edtMaxNo: TcxComboBox
        Left = 424
        Top = 4
        Width = 51
        Height = 19
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
        Style.Font.Height = -11
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 0
        Text = '5'
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 28
      Width = 500
      Height = 208
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      object DBGridEh1: TDBGridEh
        Left = 1
        Top = 1
        Width = 498
        Height = 206
        Align = alClient
        AllowedOperations = []
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = True
        DataSource = dsMaxAnaly
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
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'GODS_CODE'
            Footers = <>
            Title.Caption = #36135#21495
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'GODS_NAME'
            Footers = <>
            Title.Caption = #21830#21697#21517#31216
            Width = 130
          end
          item
            DisplayFormat = '#0.###'
            EditButtons = <>
            FieldName = 'MNY_SUM'
            Footer.DisplayFormat = '#0.###'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38144#21806#39069
            Width = 80
          end
          item
            DisplayFormat = '#0.###'
            EditButtons = <>
            FieldName = 'PRF_SUM'
            Footers = <>
            Title.Caption = #27611#21033
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'AMT_SUM'
            Footers = <>
            Title.Caption = #38144#37327
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'OrderNo'
            Footers = <>
            Title.Caption = #25490#21517
            Width = 32
          end>
      end
    end
  end
  object Pnl_Right: TPanel
    Left = 505
    Top = 0
    Width = 541
    Height = 236
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PnlTop2: TPanel
      Left = 0
      Top = 0
      Width = 541
      Height = 28
      Align = alTop
      BevelOuter = bvLowered
      Caption = #21367#28895#21830#21697#65288#38144#21806#39069#65289#25490#21517#9#9
      TabOrder = 0
      object Label3: TLabel
        Left = 416
        Top = 7
        Width = 12
        Height = 13
        Caption = #21069
      end
      object Label4: TLabel
        Left = 482
        Top = 7
        Width = 12
        Height = 13
        Caption = #21517
      end
      object edtMinNo: TcxComboBox
        Left = 429
        Top = 4
        Width = 51
        Height = 19
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
        Properties.OnChange = edtMinNoPropertiesChange
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -11
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 0
        Text = '5'
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 28
      Width = 541
      Height = 208
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      object DBGridEh2: TDBGridEh
        Left = 1
        Top = 1
        Width = 539
        Height = 206
        Align = alClient
        AllowedOperations = []
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = True
        DataSource = dsMinAnaly
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
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'GODS_CODE'
            Footers = <>
            Title.Caption = #36135#21495
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'GODS_NAME'
            Footers = <>
            Title.Caption = #21830#21697#21517#31216
            Width = 130
          end
          item
            DisplayFormat = '#0.###'
            EditButtons = <>
            FieldName = 'MNY_SUM'
            Footer.DisplayFormat = '#0.###'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38144#21806#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'PRF_SUM'
            Footers = <>
            Title.Caption = #27611#21033
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'AMT_SUM'
            Footers = <>
            Title.Caption = #21806#37327
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'OrderNo'
            Footers = <>
            Title.Caption = #25490#21517
            Width = 32
          end>
      end
    end
  end
  object dsMaxAnaly: TDataSource
    DataSet = MaxAnaly
    Left = 33
    Top = 90
  end
  object adoReport: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 32
    Top = 28
  end
  object MaxAnaly: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 32
    Top = 60
  end
  object MinAnaly: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 536
    Top = 60
  end
  object dsMinAnaly: TDataSource
    DataSet = MinAnaly
    Left = 537
    Top = 98
  end
end
