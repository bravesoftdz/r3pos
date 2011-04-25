inherited frmSalRetuLocusOrder: TfrmSalRetuLocusOrder
  Left = 195
  Top = 49
  Width = 786
  Height = 523
  Caption = #36864#36135#36864#36135#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 778
    Height = 496
    inherited RzPanel2: TRzPanel
      Width = 768
      Height = 139
      Enabled = False
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
      object Label3: TLabel [3]
        Left = 404
        Top = 30
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #23548#36141#21592
      end
      object Label40: TLabel [4]
        Left = 195
        Top = 30
        Width = 48
        Height = 12
        Caption = #36864#36135#38376#24215
      end
      object Label12: TLabel [5]
        Left = 195
        Top = 93
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36865#36135#22320#22336
      end
      object Label15: TLabel [6]
        Left = 195
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32852#31995#30005#35805
      end
      object Label16: TLabel [7]
        Left = 405
        Top = 51
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #32852#31995#20154
      end
      object Label17: TLabel [8]
        Left = 562
        Top = 52
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36864#36135#26041#24335
      end
      object Label8: TLabel [9]
        Left = 562
        Top = 73
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36865#36135#26085#26399
      end
      object Label21: TLabel [10]
        Left = 562
        Top = 30
        Width = 48
        Height = 12
        Caption = #35746#36135#21333#21495
      end
      object Label18: TLabel [11]
        Left = 195
        Top = 51
        Width = 48
        Height = 12
        Caption = #25152#23646#37096#38376
      end
      object Label1: TLabel [12]
        Left = 562
        Top = 94
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel [13]
        Left = 562
        Top = 115
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      inherited RzPanel4: TRzPanel
        Top = 5
        Height = 76
        Enabled = False
        inherited Shape1: TShape
          Enabled = False
        end
        inherited lblCaption: TLabel
          Enabled = False
        end
        inherited Image1: TImage
          Left = 103
          Top = 31
          Enabled = False
        end
        inherited lblState: TLabel
          Top = 43
          Enabled = False
        end
      end
      object edtCLIENT_ID: TzrComboBoxList
        Tag = 1
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
        TabOrder = 1
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
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew, zbFind]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtSALES_DATE: TcxDateEdit
        Tag = 1
        Left = 619
        Top = 5
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 2
      end
      object edtREMARK: TcxTextEdit
        Tag = 1
        Left = 251
        Top = 110
        Width = 286
        Height = 20
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtGUIDE_USER: TzrComboBoxList
        Tag = 1
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
        TabOrder = 4
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
      object edtSHOP_ID: TzrComboBoxList
        Tag = 1
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
        TabOrder = 5
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
      object edtSEND_ADDR: TcxTextEdit
        Tag = 1
        Left = 251
        Top = 89
        Width = 286
        Height = 20
        TabOrder = 6
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtTELEPHONE: TcxTextEdit
        Tag = 1
        Left = 251
        Top = 68
        Width = 286
        Height = 20
        TabOrder = 7
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtLINKMAN: TcxTextEdit
        Tag = 1
        Left = 448
        Top = 47
        Width = 89
        Height = 20
        TabOrder = 8
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtSALE_STYLE: TzrComboBoxList
        Tag = 1
        Left = 619
        Top = 48
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
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtPLAN_DATE: TcxDateEdit
        Tag = 1
        Left = 619
        Top = 69
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 10
      end
      object edtINDE_GLIDE_NO: TcxButtonEdit
        Tag = 1
        Left = 619
        Top = 26
        Width = 121
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        TabOrder = 11
      end
      object edtDEPT_ID: TzrComboBoxList
        Tag = 1
        Left = 251
        Top = 47
        Width = 131
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 12
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
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 619
        Top = 90
        Width = 121
        Height = 20
        TabOrder = 13
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 619
        Top = 111
        Width = 121
        Height = 20
        TabOrder = 14
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 387
      Width = 768
      Height = 61
      TabOrder = 2
      object Label4: TLabel
        Left = 147
        Top = 11
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #24320#21333#25968#37327
      end
      object Label5: TLabel
        Left = 348
        Top = 11
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #25195#30721#25968#37327
      end
      object Label6: TLabel
        Left = 556
        Top = 11
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32467#20313#25968#37327
      end
      object Label7: TLabel
        Left = 147
        Top = 35
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #24320#21333#21697#31181
      end
      object Label10: TLabel
        Left = 348
        Top = 35
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #25195#30721#21697#31181
      end
      object Label11: TLabel
        Left = 556
        Top = 35
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32467#20313#21697#31181
      end
      object Shape2: TShape
        Left = 24
        Top = 8
        Width = 81
        Height = 17
        Brush.Color = clFuchsia
      end
      object Shape3: TShape
        Left = 24
        Top = 31
        Width = 81
        Height = 17
        Brush.Color = 16185078
      end
      object Label13: TLabel
        Left = 51
        Top = 10
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #24403#21069
        Transparent = True
      end
      object Label14: TLabel
        Left = 51
        Top = 33
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #24050#25195
        Transparent = True
      end
      object edtJH: TcxTextEdit
        Tag = 1
        Left = 207
        Top = 7
        Width = 121
        Height = 20
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtSM: TcxTextEdit
        Tag = 1
        Left = 415
        Top = 7
        Width = 121
        Height = 20
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtWT: TcxTextEdit
        Tag = 1
        Left = 623
        Top = 7
        Width = 121
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = []
        TabOrder = 2
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtPZJH: TcxTextEdit
        Tag = 1
        Left = 207
        Top = 31
        Width = 121
        Height = 20
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtPZSM: TcxTextEdit
        Tag = 1
        Left = 415
        Top = 31
        Width = 121
        Height = 20
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtPZWT: TcxTextEdit
        Tag = 1
        Left = 623
        Top = 31
        Width = 121
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = []
        TabOrder = 5
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 178
      Width = 768
      Height = 209
      Color = clWhite
      TabOrder = 3
      OnCellClick = DBGridEh1CellClick
      OnKeyDown = nil
      OnKeyPress = nil
      OnMouseDown = nil
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
          Width = 153
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = #36135#21495
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
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
          ButtonStyle = cbsNone
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #36827#36135#25968#37327
          Width = 56
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'LOCUS_AMT'
          Font.Charset = GB2312_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          Footers = <>
          Title.Caption = #25195#30721#25968#37327
          Width = 60
          OnEditButtonClick = DBGridEh1Columns6EditButtonClick
        end
        item
          EditButtons = <>
          FieldName = 'BAL_AMT'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #21097#20313#25968#37327
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25209#21495
          Width = 91
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = #22791#27880
          Width = 157
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 328
      Top = 171
    end
    inherited pnlBarCode: TRzPanel
      Top = 144
      Width = 768
      Height = 34
    end
    inherited stbHint: TRzPanel
      Top = 448
      Width = 768
    end
    inherited rzHelp: TRzPanel
      Top = 472
      Width = 768
      Height = 19
    end
    inherited fndUNIT_ID: TcxComboBox
      Top = 176
    end
  end
  inherited mmMenu: TMainMenu
    Left = 192
    Top = 192
  end
  inherited actList: TActionList
    Left = 248
    Top = 184
    inherited actBatchNo: TAction
      Visible = False
    end
    inherited actUnitConvert: TAction
      Visible = False
    end
    inherited actIsPressent: TAction
      Visible = False
    end
  end
  inherited PopupMenu1: TPopupMenu
    inherited munInsertRow: TMenuItem
      Visible = False
    end
    inherited munAppendRow: TMenuItem
      Visible = False
    end
    object N1: TMenuItem [2]
      Caption = #25171#21360#26465#30721
      Visible = False
    end
    inherited actCopyToNew: TMenuItem
      Visible = False
    end
    inherited mnuDeleteGods: TMenuItem
      Visible = False
    end
    inherited munDivRow1: TMenuItem
      Visible = False
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
        Name = 'REMARK'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'LOCUS_AMT'
        DataType = ftFloat
      end
      item
        Name = 'BAL_AMT'
        DataType = ftFloat
      end>
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
    Left = 176
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
  object cdsLocusNo: TZQuery
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
    OnFilterRecord = cdsLocusNoFilterRecord
    CachedUpdates = True
    Params = <>
    Left = 176
    Top = 304
  end
end
