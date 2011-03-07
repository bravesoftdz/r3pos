inherited frmSalRetuOrder: TfrmSalRetuOrder
  Left = 222
  Top = 108
  Width = 796
  Height = 552
  Caption = #36864#36135#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 788
    Height = 525
    inherited RzPanel2: TRzPanel
      Width = 778
      Height = 140
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 562
        Top = 9
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36864#36135#26085#26399
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 195
        Top = 9
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23458#25143#21517#31216
      end
      object Label2: TLabel [2]
        Left = 195
        Top = 114
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object Label5: TLabel [3]
        Left = 563
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #31080#25454#31867#22411
      end
      object Label6: TLabel [4]
        Left = 404
        Top = 30
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #23548#36141#21592
      end
      object Label40: TLabel [5]
        Left = 195
        Top = 30
        Width = 48
        Height = 12
        Caption = #36864#36135#38376#24215
      end
      object Label12: TLabel [6]
        Left = 195
        Top = 93
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36865#36135#22320#22336
      end
      object Label15: TLabel [7]
        Left = 195
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32852#31995#30005#35805
      end
      object Label16: TLabel [8]
        Left = 405
        Top = 72
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #32852#31995#20154
      end
      object Label17: TLabel [9]
        Left = 562
        Top = 30
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36864#36135#26041#24335
      end
      object Label13: TLabel [10]
        Left = 563
        Top = 51
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36865#36135#26085#26399
      end
      object Label11: TLabel [11]
        Left = 563
        Top = 93
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #38144#39033#31246#29575
      end
      object Label21: TLabel [12]
        Left = 195
        Top = 51
        Width = 48
        Height = 12
        Caption = #38144#21806#21333#21495
      end
      object Label22: TLabel [13]
        Left = 403
        Top = 51
        Width = 36
        Height = 12
        Caption = #39044#20184#27454
      end
      object Label4: TLabel [14]
        Left = 564
        Top = 114
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32467#31639#31246#39069
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      inherited RzPanel4: TRzPanel
        Height = 83
        TabOrder = 13
        inherited Shape1: TShape
          Top = 33
        end
        inherited lblCaption: TLabel
          Left = 11
          Caption = #21333#21495':'#33258#21160#32534#21495
        end
        inherited Image1: TImage
          Left = 95
          Top = 39
        end
        inherited lblState: TLabel
          Left = 8
          Top = 48
          Caption = #25910#27454':'
        end
      end
      object edtCLIENT_ID: TzrComboBoxList
        Left = 251
        Top = 5
        Width = 286
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        Properties.OnChange = edtCLIENT_IDPropertiesChange
        TabOrder = 0
        InGrid = False
        KeyValue = Null
        FilterFields = 'CLIENT_NAME;CLIENT_SPELL;CLIENT_CODE;LICENSE_CODE;TELEPHONE2'
        KeyField = 'CLIENT_ID'
        ListField = 'CLIENT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CLIENT_CODE'
            Footers = <>
            Title.Caption = #23458#25143#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = #23458#25143#21517#31216
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'LINKMAN'
            Footers = <>
            Title.Caption = #32852#31995#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'TELEPHONE2'
            Footers = <>
            Title.Caption = #32852#31995#30005#35805
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'LICENSE_CODE'
            Footers = <>
            Title.Caption = #35777#20214#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ADDRESS'
            Footers = <>
            Title.Caption = #22320#22336
            Width = 150
          end>
        DropWidth = 314
        DropHeight = 281
        ShowTitle = True
        AutoFitColWidth = False
        OnFindClick = edtCLIENT_IDFindClick
        OnAddClick = edtCLIENT_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew, zbFind]
        DropListStyle = lsFixed
        OnSaveValue = edtCLIENT_IDSaveValue
        MultiSelect = False
      end
      object edtSALES_DATE: TcxDateEdit
        Left = 619
        Top = 5
        Width = 121
        Height = 20
        TabOrder = 8
      end
      object edtREMARK: TcxTextEdit
        Left = 251
        Top = 110
        Width = 286
        Height = 20
        TabOrder = 7
      end
      object edtINVOICE_FLAG: TcxComboBox
        Left = 619
        Top = 68
        Width = 121
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = edtINVOICE_FLAGPropertiesChange
        TabOrder = 11
      end
      object edtGUIDE_USER: TzrComboBoxList
        Left = 448
        Top = 26
        Width = 89
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 1
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
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtTAX_RATE: TcxSpinEdit
        Left = 619
        Top = 89
        Width = 50
        Height = 20
        Properties.MaxValue = 100.000000000000000000
        Properties.ValueType = vtFloat
        TabOrder = 12
      end
      object edtSEND_ADDR: TcxTextEdit
        Left = 251
        Top = 89
        Width = 286
        Height = 20
        TabOrder = 6
      end
      object edtTELEPHONE: TcxTextEdit
        Left = 251
        Top = 68
        Width = 131
        Height = 20
        TabOrder = 4
      end
      object edtLINKMAN: TcxTextEdit
        Left = 448
        Top = 68
        Width = 89
        Height = 20
        TabOrder = 5
      end
      object edtSALE_STYLE: TzrComboBoxList
        Left = 619
        Top = 26
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
        FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #23610#30721#32452
            Width = 121
          end>
        DropWidth = 121
        DropHeight = 120
        ShowTitle = False
        AutoFitColWidth = True
        OnAddClick = edtSALE_STYLEAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtPLAN_DATE: TcxDateEdit
        Left = 619
        Top = 47
        Width = 121
        Height = 20
        TabOrder = 10
      end
      object edtFROM_ID: TcxButtonEdit
        Left = 251
        Top = 47
        Width = 131
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        TabOrder = 2
      end
      object edtADVA_MNY: TcxTextEdit
        Left = 448
        Top = 47
        Width = 89
        Height = 20
        TabOrder = 3
      end
      object edtTAX_MONEY: TcxTextEdit
        Tag = 1
        Left = 619
        Top = 110
        Width = 120
        Height = 20
        TabStop = False
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 14
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 251
        Top = 26
        Width = 131
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 15
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
        OnSaveValue = edtSHOP_IDSaveValue
        MultiSelect = False
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 421
      Width = 778
      Height = 62
      TabOrder = 2
      object Label19: TLabel
        Left = 29
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #26412#21333#24050#36864
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 204
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #26412#21333#27424#36864
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 28
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel
        Left = 204
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      object Label10: TLabel
        Left = 395
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32047#35745#27424#27454
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 587
        Top = 39
        Width = 48
        Height = 12
        Caption = #26368#26032#24211#23384
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtRECV_MNY: TcxTextEdit
        Tag = 1
        Left = 83
        Top = 35
        Width = 99
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 0
      end
      object edtRECK_MNY: TcxTextEdit
        Tag = 1
        Left = 259
        Top = 35
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 1
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 83
        Top = 11
        Width = 99
        Height = 20
        TabOrder = 2
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 259
        Top = 11
        Width = 98
        Height = 20
        TabOrder = 3
      end
      object fndRECK_MNY: TcxTextEdit
        Tag = 1
        Left = 449
        Top = 35
        Width = 99
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 4
      end
      object fndMY_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 641
        Top = 35
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 5
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 178
      Width = 778
      Height = 243
      TabOrder = 3
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
          Width = 150
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #36135#21495
          Width = 72
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #26465#30721
          Width = 95
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
          Width = 56
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'APRICE'
          Footers = <>
          Title.Caption = #21333#20215
          Width = 63
          OnUpdateData = DBGridEh1Columns5UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #37329#39069
          Width = 83
          OnUpdateData = DBGridEh1Columns6UpdateData
        end
        item
          DisplayFormat = '#0%'
          EditButtons = <>
          FieldName = 'AGIO_RATE'
          Footers = <>
          Title.Caption = #25240#25187#29575
          Width = 52
          OnUpdateData = DBGridEh1Columns7UpdateData
        end
        item
          Alignment = taCenter
          Checkboxes = True
          EditButtons = <>
          FieldName = 'IS_PRESENT'
          Footers = <>
          KeyList.Strings = (
            '1'
            '0')
          ReadOnly = True
          Title.Caption = #36192#21697
          Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#36192#21697#36716#25442
          Width = 36
        end
        item
          EditButtons = <>
          FieldName = 'LOCUS_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #29289#27969#36319#36394#21495
          Width = 94
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25209#21495
          Width = 95
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = #22791#27880
          Width = 140
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 96
      Top = 203
    end
    inherited pnlBarCode: TRzPanel
      Top = 145
      Width = 778
    end
    inherited stbHint: TRzPanel
      Top = 483
      Width = 778
    end
    inherited rzHelp: TRzPanel
      Top = 507
      Width = 778
      Height = 13
    end
    inherited fndUNIT_ID: TcxComboBox
      Top = 208
    end
  end
  inherited actList: TActionList
    object actCustomer: TAction
      Caption = #36755#20837#20250#21592#21345#21495
      ShortCut = 116
      OnExecute = actCustomerExecute
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem [5]
      Action = actCustomer
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
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'APRICE'
        DataType = ftFloat
      end
      item
        Name = 'AMONEY'
        DataType = ftFloat
      end
      item
        Name = 'COST_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'ORG_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'AGIO_RATE'
        DataType = ftFloat
      end
      item
        Name = 'AGIO_MONEY'
        DataType = ftFloat
      end
      item
        Name = 'POLICY_TYPE'
        DataType = ftInteger
      end
      item
        Name = 'BARTER_INTEGRAL'
        DataType = ftInteger
      end
      item
        Name = 'HAS_INTEGRAL'
        DataType = ftInteger
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_MONEY'
        DataType = ftFloat
      end
      item
        Name = 'REMARK'
        DataType = ftString
        Size = 100
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
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end>
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
