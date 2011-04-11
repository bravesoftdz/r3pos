inherited frmRelationUpdateMode: TfrmRelationUpdateMode
  Left = 428
  Top = 175
  BorderStyle = bsDialog
  Caption = #23545#29031#34920#21047#26032#27169#24335#36873#25321
  ClientHeight = 249
  ClientWidth = 413
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object TitlePanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 413
    Height = 47
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
      Top = 45
      Width = 413
      Height = 2
      Align = alBottom
    end
    object HintL: TLabel
      Left = 7
      Top = 16
      Width = 65
      Height = 12
      Caption = #23545#29031#34920#21047#26032
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblMsg: TLabel
      Left = 175
      Top = 16
      Width = 65
      Height = 12
      Caption = #21047#26032#26041#24335#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
  end
  object RzPage: TRzPageControl [1]
    Left = 0
    Top = 47
    Width = 413
    Height = 160
    ActivePage = TabUpResult
    Align = alClient
    TabHeight = 20
    TabIndex = 1
    TabOrder = 1
    TabStyle = tsRoundCorners
    FixedDimension = 20
    object TabUpMode: TRzTabSheet
      Caption = #23545#29031#27169#24335#36873#25321
      object RzPanel2: TRzPanel
        Left = 0
        Top = 0
        Width = 409
        Height = 133
        Align = alClient
        BorderOuter = fsNone
        BorderWidth = 5
        TabOrder = 0
        object edtCHECK_TYPE: TGroupBox
          Left = 5
          Top = 5
          Width = 399
          Height = 123
          Align = alClient
          TabOrder = 0
          object RB_ALL: TRadioButton
            Left = 20
            Top = 50
            Width = 81
            Height = 17
            Caption = #21047#26032#25152#26377
            Checked = True
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            TabStop = True
          end
          object RB_NEW: TRadioButton
            Left = 148
            Top = 50
            Width = 82
            Height = 17
            Caption = #21047#26032#26032#21697
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
          object RB_PRICE: TRadioButton
            Left = 268
            Top = 50
            Width = 80
            Height = 17
            Caption = #21047#26032#20215#26684
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
        end
      end
    end
    object TabUpResult: TRzTabSheet
      Caption = #23545#29031#32467#26524#26174#31034
      object RzPanel1: TRzPanel
        Left = 0
        Top = 0
        Width = 409
        Height = 133
        Align = alClient
        BorderOuter = fsNone
        BorderWidth = 5
        TabOrder = 0
        object Grid_Relation: TDBGridEh
          Left = 5
          Top = 5
          Width = 399
          Height = 107
          Align = alClient
          AllowedOperations = [alopUpdateEh]
          DataSource = Ds
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FrozenCols = 1
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
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
          OnDrawColumnCell = Grid_RelationDrawColumnCell
          Columns = <
            item
              EditButtons = <>
              FieldName = 'SEQNO'
              Footers = <>
              Title.Caption = #24207#21495
              Width = 30
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
              Width = 139
            end
            item
              EditButtons = <>
              FieldName = 'PACK_BARCODE'
              Footers = <>
              Title.Caption = #26465#26465#30721
              Width = 91
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
            end
            item
              EditButtons = <>
              FieldName = 'UpdateCase'
              Footers = <>
              Title.Caption = #26356#26032#24773#20917
              Width = 63
            end>
        end
        object stbPanel: TPanel
          Left = 5
          Top = 112
          Width = 399
          Height = 16
          Align = alBottom
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = ' '#32418#23383#34920#31034#27809#26377#23545#19978#65281
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
  object BottonPanel: TPanel [2]
    Left = 0
    Top = 207
    Width = 413
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 2
    object Bevel1: TBevel
      Left = 1
      Top = 1
      Width = 411
      Height = 2
      Align = alTop
    end
    object btnOK: TRzBitBtn
      Left = 150
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
      Left = 233
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
  inherited mmMenu: TMainMenu
    Left = 360
    Top = 16
  end
  inherited actList: TActionList
    Left = 304
    Top = 8
  end
  object CdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 273
    Top = 49
  end
  object Ds: TDataSource
    DataSet = CdsTable
    Left = 313
    Top = 50
  end
end
