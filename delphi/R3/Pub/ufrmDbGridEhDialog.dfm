inherited frmDbGridEhDialog: TfrmDbGridEhDialog
  Left = 327
  Top = 227
  BorderStyle = bsDialog
  Caption = #32593#26684#35774#32622
  ClientHeight = 304
  ClientWidth = 320
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl [0]
    Left = 4
    Top = 6
    Width = 310
    Height = 255
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #32593#26684#23646#24615#35774#32622
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 302
        Height = 228
        Align = alClient
        AllowedOperations = [alopUpdateEh]
        AutoFitColWidths = True
        Ctl3D = True
        DataSource = DataSource1
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeName = #29579#30721#20116#31508#22411#36755#20837#27861'86'#29256
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
        ParentCtl3D = False
        RowHeight = 21
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
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Visible'
            Footers = <>
            Title.Caption = #26174#31034
            Width = 35
          end
          item
            EditButtons = <>
            FieldName = 'Caption'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21015#21517
            Width = 154
          end
          item
            EditButtons = <>
            FieldName = 'Width'
            Footers = <>
            ReadOnly = True
            Title.Caption = #23485#24230
            Width = 82
          end>
      end
    end
  end
  object btnCancel: TRzBitBtn [1]
    Left = 229
    Top = 269
    Cancel = True
    ModalResult = 2
    Caption = #21462#28040'(&C)'
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOK: TRzBitBtn [2]
    Left = 142
    Top = 269
    ModalResult = 1
    Caption = #30830#23450'(&O)'
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 2
  end
  object cdsTable: TADODataSet
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 104
    Top = 117
    object cdsTableVisible: TBooleanField
      FieldName = 'Visible'
    end
    object cdsTableFieldName: TStringField
      FieldName = 'FieldName'
      Size = 100
    end
    object cdsTableWidth: TIntegerField
      FieldName = 'Width'
    end
    object cdsTableCaption: TStringField
      FieldName = 'Caption'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsTable
    Left = 104
    Top = 85
  end
end
