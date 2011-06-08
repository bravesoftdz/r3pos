inherited frmRelationHandSet: TfrmRelationHandSet
  Left = 339
  Top = 164
  BorderStyle = bsDialog
  Caption = #25163#24037#23545#29031#21367#28895#26723#26696
  ClientHeight = 317
  ClientWidth = 481
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object TitlePanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 481
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object labTitle: TLabel
      Left = 16
      Top = 16
      Width = 7
      Height = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 54
      Width = 481
      Height = 2
      Align = alBottom
    end
    object HintL: TLabel
      Left = 15
      Top = 10
      Width = 92
      Height = 12
      Caption = #23545#29031'R3'#30340#21830#21697#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 34
      Width = 99
      Height = 12
      Caption = 'Rim'#20027#23545#29031#21830#21697#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 466
      Top = 9
      Width = 7
      Height = 12
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 466
      Top = 32
      Width = 7
      Height = 12
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object R3_GODS_ID: TzrComboBoxList
      Tag = 100
      Left = 108
      Top = 6
      Width = 355
      Height = 20
      TabStop = False
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = False
      TabOrder = 0
      InGrid = True
      KeyValue = Null
      FilterFields = 'GODS_CODE;GODS_NAME;GODS_SPELL;BARCODE'
      KeyField = 'GODS_ID'
      ListField = 'GODS_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'GODS_NAME'
          Footers = <>
          Title.Caption = #21830#21697#21517#31216
          Width = 150
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = #36135#21495
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = #26465#30721
          Width = 65
        end>
      DropWidth = 360
      DropHeight = 250
      ShowTitle = True
      AutoFitColWidth = True
      ShowButton = True
      LocateStyle = lsDark
      Buttons = [zbFind]
      DropListStyle = lsFixed
      MultiSelect = False
    end
    object Edt_RimGods: TcxTextEdit
      Left = 108
      Top = 29
      Width = 355
      Height = 20
      TabOrder = 1
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    end
  end
  object BottonPanel: TPanel [1]
    Left = 0
    Top = 275
    Width = 481
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 1
    object Bevel1: TBevel
      Left = 1
      Top = 1
      Width = 479
      Height = 2
      Align = alTop
    end
    object btnOK: TRzBitBtn
      Left = 183
      Top = 11
      Caption = #30830#23450'(&O)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TRzBitBtn
      Left = 266
      Top = 11
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
  end
  object RzPage: TRzPageControl [2]
    Left = 0
    Top = 56
    Width = 481
    Height = 219
    ActivePage = TabUpResult
    Align = alClient
    TabHeight = 20
    TabIndex = 0
    TabOrder = 2
    TabStyle = tsRoundCorners
    FixedDimension = 20
    object TabUpResult: TRzTabSheet
      Caption = #36873#25321'Rim'#20027#23545#29031#21367#28895
      object RzPanel1: TRzPanel
        Left = 0
        Top = 0
        Width = 477
        Height = 192
        Align = alClient
        BorderOuter = fsNone
        BorderWidth = 5
        TabOrder = 0
        object Grid_Relation: TDBGridEh
          Left = 5
          Top = 5
          Width = 467
          Height = 182
          Align = alClient
          AllowedOperations = [alopUpdateEh]
          Flat = True
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FrozenCols = 1
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
          ParentFont = False
          RowHeight = 23
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
          OnCellClick = Grid_RelationCellClick
          OnDrawColumnCell = Grid_RelationDrawColumnCell
          Columns = <
            item
              EditButtons = <>
              FieldName = 'SEQNO'
              Footers = <>
              Title.Caption = #24207#21495
              Width = 33
            end
            item
              EditButtons = <>
              FieldName = 'GODS_CODE'
              Footer.Value = #35760#24405#25968#65306
              Footer.ValueType = fvtStaticText
              Footers = <>
              ReadOnly = True
              Title.Caption = #36135#21495
            end
            item
              EditButtons = <>
              FieldName = 'GODS_NAME'
              Footer.ValueType = fvtCount
              Footers = <>
              ReadOnly = True
              Title.Caption = #21830#21697#21517#31216
              Width = 155
            end
            item
              EditButtons = <>
              FieldName = 'PACK_BARCODE'
              Footers = <>
              Title.Caption = #26465#26465#30721
              Width = 95
            end
            item
              EditButtons = <>
              FieldName = 'NEW_INPRICE'
              Footers = <>
              Title.Caption = #36827#36135#20215
              Width = 54
            end
            item
              EditButtons = <>
              FieldName = 'NEW_OUTPRICE'
              Footers = <>
              Title.Caption = #38646#21806#20215
              Width = 53
            end>
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 384
    Top = 48
  end
  inherited actList: TActionList
    Left = 344
    Top = 40
  end
  object CdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 9
    Top = 105
  end
  object Ds: TDataSource
    DataSet = CdsTable
    Left = 41
    Top = 106
  end
  object SaveQry: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 9
    Top = 161
  end
  object NT_GOODSINFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 321
    Top = 1
  end
end
