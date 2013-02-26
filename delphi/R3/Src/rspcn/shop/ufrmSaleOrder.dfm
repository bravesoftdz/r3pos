inherited frmSaleOrder: TfrmSaleOrder
  Left = 326
  Top = 184
  Align = alNone
  AutoScroll = True
  Caption = 'frmSaleOrder'
  Color = clBlue
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited ScrollBox: TScrollBox
    inherited webForm: TRzPanel
      Top = 72
      Height = 281
      Color = clSilver
      object Label1: TLabel
        Left = 152
        Top = 136
        Width = 39
        Height = 13
        Caption = #24352#26862#33635
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object BitBtn1: TBitBtn
        Left = 56
        Top = 32
        Width = 75
        Height = 25
        Caption = 'connect'
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 312
        Top = 800
        Width = 75
        Height = 25
        Caption = 'BitBtn2'
        TabOrder = 1
      end
      object Button1: TButton
        Left = 552
        Top = 496
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 2
      end
      object DBGridEh1: TDBGridEh
        Left = 248
        Top = 80
        Width = 320
        Height = 120
        DataSource = DataSource1
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -13
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
        TabOrder = 3
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        IsDrawNullRow = False
        CurrencySymbol = #65509
        DecimalNumber = 2
        DigitalNumber = 12
      end
      object Button2: TButton
        Left = 56
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Button2'
        TabOrder = 4
        OnClick = Button2Click
      end
    end
  end
  object ZQuery1: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 278
    Top = 128
  end
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 318
    Top = 128
  end
end
