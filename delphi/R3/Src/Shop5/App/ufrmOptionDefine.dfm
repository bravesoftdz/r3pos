inherited frmOptionDefine: TfrmOptionDefine
  Left = 702
  Top = 155
  BorderStyle = bsDialog
  Caption = #24211#23384#36873#39033#35774#32622
  ClientHeight = 237
  ClientWidth = 340
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl [0]
    Left = 0
    Top = 0
    Width = 340
    Height = 193
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #23384#38144#27604#21442#25968
      ImageIndex = 1
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 332
        Height = 166
        Align = alClient
        ParentShowHint = False
        Shape = bsFrame
        ShowHint = False
      end
      object GroupBox9: TGroupBox
        Left = 11
        Top = 9
        Width = 177
        Height = 136
        Caption = #40664#35748#24211#23384#36873#39033
        TabOrder = 0
        object Label19: TLabel
          Left = 23
          Top = 25
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #23433#20840#22825#25968
        end
        object Label20: TLabel
          Left = 127
          Top = 25
          Width = 12
          Height = 12
          Caption = #22825
        end
        object Label23: TLabel
          Left = 10
          Top = 74
          Width = 60
          Height = 12
          Alignment = taRightJustify
          Caption = #26085#22343#38144#37327#25353
        end
        object Label25: TLabel
          Left = 129
          Top = 74
          Width = 36
          Height = 12
          Caption = #22825#27979#31639
        end
        object Label26: TLabel
          Left = 22
          Top = 49
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #21512#29702#22825#25968
        end
        object Label27: TLabel
          Left = 127
          Top = 49
          Width = 12
          Height = 12
          Caption = #22825
        end
        object Label28: TLabel
          Left = 10
          Top = 98
          Width = 60
          Height = 12
          Alignment = taRightJustify
          Caption = #23384#38144#27604#25351#26631
        end
        object edtSAFE_DAY: TcxSpinEdit
          Left = 75
          Top = 21
          Width = 50
          Height = 20
          Properties.MaxValue = 100.000000000000000000
          Properties.MinValue = 1.000000000000000000
          TabOrder = 0
          Value = 7
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object edtDAY_SALE_STAND: TcxSpinEdit
          Left = 75
          Top = 70
          Width = 50
          Height = 20
          Properties.MaxValue = 999999.000000000000000000
          Properties.MinValue = 1.000000000000000000
          TabOrder = 1
          Value = 90
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object edtREAS_DAY: TcxSpinEdit
          Left = 75
          Top = 45
          Width = 50
          Height = 20
          Properties.MaxValue = 100.000000000000000000
          Properties.MinValue = 1.000000000000000000
          TabOrder = 2
          Value = 14
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object edtSMT_RATE: TcxComboBox
          Left = 75
          Top = 95
          Width = 88
          Height = 20
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          Properties.DropDownListStyle = lsFixedList
          Properties.OnChange = edtSMT_RATEPropertiesChange
          TabOrder = 3
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #23384#38144#27604
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 340
        Height = 177
        Align = alClient
        ParentShowHint = False
        Shape = bsFrame
        ShowHint = False
      end
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 340
        Height = 177
        Align = alClient
        AllowedOperations = [alopUpdateEh]
        AutoFitColWidths = True
        DataSource = DsIndex
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FrozenCols = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghEnterAsTab]
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
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SORT_ID'
            Footers = <>
            ReadOnly = True
            Title.Caption = #25351'  '#26631
            Title.Color = clWhite
            Width = 100
          end
          item
            DisplayFormat = '#0.00'
            EditButtons = <>
            FieldName = 'LowerLimit'
            Footers = <>
            MaxWidth = 100
            Title.Caption = #19979'  '#38480
            Title.Color = clWhite
            Width = 66
          end
          item
            DisplayFormat = '#0.00'
            EditButtons = <>
            FieldName = 'TopLimit'
            Footers = <>
            MaxWidth = 100
            Title.Caption = #19978'  '#38480
            Title.Color = clWhite
          end>
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 193
    Width = 340
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOK: TRzBitBtn
      Left = 175
      Top = 10
      Caption = #30830#23450'(&O)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TRzBitBtn
      Left = 260
      Top = 10
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
    Left = 1
    Top = 210
  end
  inherited actList: TActionList
    Left = 32
    Top = 210
  end
  object CdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 63
    Top = 210
  end
  object CdsIndex: TZQuery
    FieldDefs = <
      item
        Name = 'SORT_ID'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'TopLimit'
        DataType = ftFloat
      end
      item
        Name = 'LowerLimit'
        DataType = ftFloat
      end>
    CachedUpdates = True
    Params = <>
    Left = 1
    Top = 240
  end
  object DsIndex: TDataSource
    DataSet = CdsIndex
    Left = 32
    Top = 240
  end
end
