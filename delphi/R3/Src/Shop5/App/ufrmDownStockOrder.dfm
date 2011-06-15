inherited frmDownStockOrder: TfrmDownStockOrder
  Left = 198
  Top = 115
  BorderStyle = bsDialog
  Caption = #21040#36135#30830#35748
  ClientHeight = 330
  ClientWidth = 499
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 33
    Width = 499
    Height = 250
    Align = alClient
    BorderInner = fsFlat
    BorderOuter = fsLowered
    BorderSides = []
    BorderColor = clSilver
    BorderShadow = 12615680
    BorderWidth = 3
    FlatColor = clTeal
    TabOrder = 0
    object DBGridEh1: TDBGridEh
      Left = 3
      Top = 3
      Width = 493
      Height = 244
      Align = alClient
      AutoFitColWidths = True
      DataSource = Ds
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -12
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
      ReadOnly = True
      RowHeight = 20
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      UseMultiTitle = True
      IsDrawNullRow = False
      CurrencySymbol = #65509
      DecimalNumber = 2
      DigitalNumber = 12
      OnDrawColumnCell = DBGridEh1DrawColumnCell
      OnGetCellParams = DBGridEh1GetCellParams
      Columns = <
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
          FieldName = 'INDE_DATE'
          Footers = <>
          Title.Caption = #35746#36135#26085#26399
          Width = 78
        end
        item
          EditButtons = <>
          FieldName = 'CLIENT_NAME'
          Footers = <>
          Title.Caption = #20379#24212#21830
          Width = 160
        end
        item
          EditButtons = <>
          FieldName = 'INDE_AMT'
          Footers = <>
          Title.Caption = #35746#36135#25968#37327
          Width = 68
        end
        item
          EditButtons = <>
          FieldName = 'INDE_MNY'
          Footers = <>
          Title.Caption = #35746#36135#37329#39069
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 'NEED_AMT'
          Footers = <>
          Title.Caption = #38656#27714#25968#37327
          Width = 62
        end>
    end
  end
  object TitlePanel: TPanel [1]
    Left = 0
    Top = 0
    Width = 499
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object LblMsg: TLabel
      Left = 80
      Top = 9
      Width = 119
      Height = 12
      Caption = #24403#21069#26377'    '#21333#35746#21333#65281
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 31
      Width = 499
      Height = 2
      Align = alBottom
    end
    object HintL: TLabel
      Left = 13
      Top = 9
      Width = 52
      Height = 12
      Caption = #21040#36135#30830#35748
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblCount: TLabel
      Left = 126
      Top = 9
      Width = 7
      Height = 12
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object BottonPanel: TPanel [2]
    Left = 0
    Top = 283
    Width = 499
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 2
    object Bevel1: TBevel
      Left = 1
      Top = 1
      Width = 497
      Height = 2
      Align = alTop
    end
    object btnOK: TRzBitBtn
      Left = 302
      Top = 13
      Width = 79
      Caption = #21040#36135#30830#35748'(&O)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
      OnClick = btnOKClick
    end
    object RzBitBtn1: TRzBitBtn
      Left = 385
      Top = 13
      Width = 64
      Caption = #21462#28040'(&C)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 1
      OnClick = RzBitBtn1Click
    end
  end
  inherited mmMenu: TMainMenu
    Left = 344
    Top = 120
  end
  inherited actList: TActionList
    Left = 312
    Top = 120
  end
  object Ds: TDataSource
    DataSet = cdsTable
    Left = 64
    Top = 96
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 32
    Top = 96
  end
  object CdsStockData: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 32
    Top = 144
  end
end
