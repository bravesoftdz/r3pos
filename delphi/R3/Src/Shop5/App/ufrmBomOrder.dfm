inherited frmBomOrder: TfrmBomOrder
  Left = 332
  Top = 165
  Width = 846
  Height = 522
  Caption = #31036#30418#21253#35013
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 838
    Height = 488
    inherited RzPanel2: TRzPanel
      Width = 828
      Height = 119
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 563
        Top = 6
        Width = 48
        Height = 12
        Caption = #21253#35013#26085#26399
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 194
        Top = 77
        Width = 48
        Height = 12
        Caption = #31036#30418#32534#21495
      end
      object Label2: TLabel [2]
        Left = 370
        Top = 77
        Width = 48
        Height = 12
        Caption = #26465' '#22411' '#30721
      end
      object Label5: TLabel [3]
        Left = 563
        Top = 29
        Width = 48
        Height = 12
        Caption = #32463' '#25163' '#20154
      end
      object Label3: TLabel [4]
        Left = 195
        Top = 53
        Width = 48
        Height = 12
        Caption = #31036#30418#21517#31216
      end
      object Label1: TLabel [5]
        Left = 195
        Top = 101
        Width = 48
        Height = 12
        Caption = #22791'    '#27880
      end
      object Label8: TLabel [6]
        Left = 371
        Top = 5
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #31036#30418#25968#37327
      end
      object Label40: TLabel [7]
        Left = 195
        Top = 29
        Width = 48
        Height = 12
        Caption = #25152#23646#38376#24215
      end
      object RzLabel4: TRzLabel [8]
        Left = 195
        Top = 6
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #31036#30418#31867#22411
      end
      object RzLabel1: TRzLabel [9]
        Left = 18
        Top = 93
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #31036#30418#29366#24577
      end
      object Label6: TLabel [10]
        Left = 563
        Top = 53
        Width = 53
        Height = 12
        Caption = #38646' '#21806' '#20215
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel [11]
        Left = 371
        Top = 29
        Width = 48
        Height = 12
        Caption = #25152#23646#37096#38376
      end
      object Label12: TLabel [12]
        Left = 563
        Top = 77
        Width = 48
        Height = 12
        Caption = #26159#21542#31215#20998
      end
      inherited RzPanel4: TRzPanel
        Top = 5
        Height = 100
        TabOrder = 12
        inherited Image1: TImage
          Left = 103
          Top = 31
        end
        inherited lblState: TLabel
          Top = 43
        end
        object LabelBOM_STATUS: TLabel
          Left = 6
          Top = 72
          Width = 59
          Height = 12
          Caption = #31036#30418#29366#24577':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
      end
      object edtBOM_DATE: TcxDateEdit
        Left = 623
        Top = 2
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 8
      end
      object edtBARCODE: TcxTextEdit
        Left = 426
        Top = 73
        Width = 111
        Height = 20
        TabOrder = 6
        Text = #33258#32534#26465#30721
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtGIFT_CODE: TcxTextEdit
        Left = 250
        Top = 73
        Width = 111
        Height = 20
        TabOrder = 5
        Text = #33258#21160#32534#21495
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtGIFT_NAME: TcxTextEdit
        Left = 250
        Top = 49
        Width = 287
        Height = 20
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtBOM_USER: TzrComboBoxList
        Left = 623
        Top = 25
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 9
        InGrid = False
        KeyValue = Null
        FilterFields = 'ACCOUNT;USER_NAME;USER_SPELL'
        KeyField = 'USER_ID'
        ListField = 'USER_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ACCOUNT'
            Footers = <>
            Title.Caption = #24080#21495
          end
          item
            EditButtons = <>
            FieldName = 'USER_NAME'
            Footers = <>
            Title.Caption = #22995#21517
            Width = 130
          end>
        DropWidth = 180
        DropHeight = 150
        ShowTitle = True
        AutoFitColWidth = True
        OnAddClick = edtBOM_USERAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtREMARK: TcxTextEdit
        Left = 250
        Top = 97
        Width = 287
        Height = 20
        TabOrder = 7
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 250
        Top = 25
        Width = 111
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 2
        InGrid = False
        KeyValue = Null
        FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
        KeyField = 'SHOP_ID'
        ListField = 'SHOP_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SHOP_NAME'
            Footers = <>
            Title.Caption = #21517#31216
          end
          item
            EditButtons = <>
            FieldName = 'SEQ_NO'
            Footers = <>
            Title.Caption = #24207#21495
            Width = 20
          end>
        DropWidth = 185
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = False
        LocateStyle = lsDark
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtBOM_TYPE: TcxComboBox
        Left = 250
        Top = 2
        Width = 111
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #25955#35013#31036#30418
          #25972#35013#31036#30418
          #27979#35797#31036#30418)
        Properties.OnChange = edtBOM_TYPEPropertiesChange
        TabOrder = 0
      end
      object edtBOM_STATUS: TcxComboBox
        Left = 88
        Top = 89
        Width = 65
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #21551#29992
          #31105#29992)
        Properties.OnChange = edtBOM_STATUSPropertiesChange
        TabOrder = 11
        Visible = False
      end
      object edtBOM_AMOUNT: TcxTextEdit
        Left = 426
        Top = 1
        Width = 111
        Height = 20
        Properties.OnChange = edtBOM_AMOUNTPropertiesChange
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtRTL_PRICE: TcxTextEdit
        Left = 623
        Top = 49
        Width = 122
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 10
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtDEPT_ID: TzrComboBoxList
        Left = 426
        Top = 25
        Width = 111
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 3
        InGrid = False
        KeyValue = Null
        FilterFields = 'DEPT_NAME;DEPT_SPELL'
        KeyField = 'DEPT_ID'
        ListField = 'DEPT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DEPT_NAME'
            Footers = <>
            Title.Caption = #21517#31216
          end>
        DropWidth = 185
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = False
        LocateStyle = lsDark
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtGODS_IDS: TzrComboBoxList
        Left = 250
        Top = 49
        Width = 287
        Height = 20
        TabStop = False
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 13
        Visible = False
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
        DropWidth = 380
        DropHeight = 250
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Buttons = []
        DropListStyle = lsFixed
        OnSaveValue = edtGODS_IDSSaveValue
        MultiSelect = False
      end
      object edtHAS_INTEGRAL: TcxComboBox
        Left = 623
        Top = 73
        Width = 122
        Height = 20
        Properties.Items.Strings = (
          #31215#20998
          #19981#31215#20998)
        TabOrder = 14
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 408
      Width = 828
      Height = 32
      TabOrder = 2
      object Label4: TLabel
        Left = 385
        Top = 13
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32467#20313#25968#37327
      end
      object Label7: TLabel
        Left = 7
        Top = 13
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label10: TLabel
        Left = 196
        Top = 13
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      object Label9: TLabel
        Left = 575
        Top = 13
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #24050#21806#25968#37327
      end
      object edtSALS_AMOUNT: TcxTextEdit
        Left = 635
        Top = 9
        Width = 94
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtRCK_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 443
        Top = 9
        Width = 94
        Height = 20
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 251
        Top = 9
        Width = 94
        Height = 20
        TabOrder = 2
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 59
        Top = 9
        Width = 94
        Height = 20
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 158
      Width = 828
      Height = 250
      TabOrder = 3
      OnCellClick = DBGridEh1CellClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SEQNO'
          Footers = <>
          Title.Caption = #24207#21495
          Width = 31
        end
        item
          EditButtons = <>
          FieldName = 'GODS_NAME'
          Footers = <>
          Title.Caption = #21830#21697#21517#31216
          Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721'" '#26597#35810
          Width = 187
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = #36135#21495
          Width = 83
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = #26465#30721
          Width = 115
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'UNIT_ID'
          Footers = <>
          Title.Caption = #21333#20301
          Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
          Width = 41
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #25968#37327
          Width = 53
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'RTL_PRICE'
          Footers = <>
          Title.Caption = #21333#20215
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'RTL_MONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #37329#39069
          Width = 75
          OnUpdateData = DBGridEh1Columns6UpdateData
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 72
      Top = 203
    end
    inherited pnlBarCode: TRzPanel
      Top = 124
      Width = 828
      Height = 34
    end
    inherited stbHint: TRzPanel
      Top = 440
      Width = 828
    end
    inherited rzHelp: TRzPanel
      Top = 464
      Width = 828
      Height = 19
    end
    inherited fndUNIT_ID: TcxComboBox
      Left = 384
      Top = 184
    end
  end
  inherited mmMenu: TMainMenu
    Left = 192
    Top = 192
  end
  inherited actList: TActionList
    Left = 256
    Top = 256
    object actPrintBarcode: TAction
      Caption = #25171#21360#26465#30721
      OnExecute = actPrintBarcodeExecute
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 320
    Top = 200
    object N1: TMenuItem [2]
      Action = actPrintBarcode
    end
    object N2: TMenuItem [10]
      Caption = '-'
    end
  end
  inherited edtTable: TZQuery
    FieldDefs = <
      item
        Name = 'SEQNO'
        DataType = ftInteger
      end
      item
        Name = 'GODS_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BARCODE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'GODS_CODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GODS_NAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'UNIT_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BATCH_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IS_PRESENT'
        DataType = ftInteger
      end
      item
        Name = 'LOCUS_NO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'BOM_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_01'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_02'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'RTL_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'RTL_MONEY'
        DataType = ftFloat
      end>
    AfterScroll = edtTableAfterScroll
  end
  inherited edtProperty: TZQuery
    FieldDefs = <
      item
        Name = 'SEQNO'
        DataType = ftInteger
      end
      item
        Name = 'GODS_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'GODS_CODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GODS_NAME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'UNIT_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BATCH_NO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'IS_PRESENT'
        DataType = ftInteger
      end
      item
        Name = 'LOCUS_NO'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BOM_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_01'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_02'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end>
    Left = 216
    Top = 264
  end
  object cdsHeader: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 120
    Top = 192
  end
  object cdsDetail: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 120
    Top = 224
  end
end
