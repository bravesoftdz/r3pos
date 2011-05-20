inherited frmDbLocusOrder: TfrmDbLocusOrder
  Left = 304
  Top = 221
  Width = 827
  Height = 523
  Caption = #35843#25320#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 811
    Height = 485
    inherited RzPanel2: TRzPanel
      Width = 801
      Height = 117
      Enabled = False
      TabStop = True
      object Label9: TLabel [0]
        Left = 579
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label12: TLabel [1]
        Left = 579
        Top = 93
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      object lblSTOCK_DATE: TLabel [2]
        Left = 579
        Top = 8
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #35843#20986#26085#26399
      end
      object lblCLIENT_ID: TLabel [3]
        Left = 195
        Top = 29
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #35843#20837#38376#24215
      end
      object Label2: TLabel [4]
        Left = 195
        Top = 93
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object Label1: TLabel [5]
        Left = 431
        Top = 8
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #21457#36135#20154
      end
      object Label40: TLabel [6]
        Left = 195
        Top = 8
        Width = 48
        Height = 12
        Caption = #35843#20986#38376#24215
      end
      object Label3: TLabel [7]
        Left = 580
        Top = 29
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #21040#36135#26085#26399
      end
      object Label8: TLabel [8]
        Left = 581
        Top = 51
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #25910' '#36135' '#20154
      end
      object Label15: TLabel [9]
        Left = 195
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #25910#36135#22320#22336
      end
      object Label16: TLabel [10]
        Left = 195
        Top = 51
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32852#31995#30005#35805
      end
      object Label17: TLabel [11]
        Left = 431
        Top = 29
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #32852#31995#20154
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
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 636
        Top = 68
        Width = 121
        Height = 20
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 636
        Top = 89
        Width = 121
        Height = 20
        TabOrder = 2
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtSALES_DATE: TcxDateEdit
        Left = 636
        Top = 4
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 3
      end
      object edtREMARK: TcxTextEdit
        Left = 251
        Top = 89
        Width = 313
        Height = 20
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtGUIDE_USER: TzrComboBoxList
        Left = 475
        Top = 4
        Width = 89
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 5
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
        Left = 251
        Top = 4
        Width = 158
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 6
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
      object edtPLAN_DATE: TcxDateEdit
        Left = 636
        Top = 25
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 7
      end
      object edtSTOCK_USER: TzrComboBoxList
        Left = 636
        Top = 47
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 8
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
        Buttons = [zbNew, zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtCLIENT_ID: TzrComboBoxList
        Left = 251
        Top = 25
        Width = 158
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 9
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
        Left = 251
        Top = 68
        Width = 313
        Height = 20
        TabOrder = 10
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtTELEPHONE: TcxTextEdit
        Left = 251
        Top = 47
        Width = 313
        Height = 20
        TabOrder = 11
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtLINKMAN: TcxTextEdit
        Left = 475
        Top = 25
        Width = 89
        Height = 20
        TabOrder = 12
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 376
      Width = 801
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
      Top = 156
      Width = 801
      Height = 220
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
      Top = 122
      Width = 801
      Height = 34
    end
    inherited stbHint: TRzPanel
      Top = 437
      Width = 801
    end
    inherited rzHelp: TRzPanel
      Top = 461
      Width = 801
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
