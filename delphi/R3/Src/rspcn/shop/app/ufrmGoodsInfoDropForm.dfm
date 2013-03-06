inherited frmGoodsInfoDropForm: TfrmGoodsInfoDropForm
  Caption = 'frmGoodsInfoDropForm'
  ClientHeight = 296
  ClientWidth = 414
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    Width = 414
    Height = 296
    object DBGridEh1: TDBGridEh
      Left = 1
      Top = 1
      Width = 412
      Height = 294
      Align = alClient
      AllowedOperations = [alopUpdateEh]
      AutoFitColWidths = True
      DataSource = DataSource1
      FixedColor = clWhite
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FooterRowCount = 1
      FrozenCols = 1
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection]
      RowHeight = 23
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      UseMultiTitle = True
      IsDrawNullRow = False
      CurrencySymbol = #65509
      DecimalNumber = 2
      DigitalNumber = 12
      OnCellClick = DBGridEh1CellClick
      OnDrawColumnCell = DBGridEh1DrawColumnCell
      OnKeyPress = DBGridEh1KeyPress
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SEQNO'
          Footers = <>
          Title.Caption = #24207#21495
          Width = 27
        end
        item
          EditButtons = <>
          FieldName = 'GODS_NAME'
          Footer.ValueType = fvtCount
          Footers = <>
          ReadOnly = True
          Title.Caption = #21830#21697#21517#31216
          Width = 151
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footer.Value = #35760#24405#25968#65306
          Footer.ValueType = fvtStaticText
          Footers = <>
          ReadOnly = True
          Title.Caption = #36135#21495
          Width = 63
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = #26465#30721
          Width = 90
        end
        item
          EditButtons = <>
          FieldName = 'NEW_OUTPRICE'
          Footers = <>
          Title.Caption = #26631#20934#21806#20215
          Width = 48
        end>
    end
  end
  object DataSource1: TDataSource
    Left = 136
    Top = 136
  end
end
