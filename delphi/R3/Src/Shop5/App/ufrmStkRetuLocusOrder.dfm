inherited frmStkRetuLocusOrder: TfrmStkRetuLocusOrder
  Left = 195
  Top = 49
  Width = 786
  Height = 523
  Caption = #37319#36141#36864#36135
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 778
    Height = 496
    inherited RzPanel2: TRzPanel
      Width = 768
      Height = 100
      Enabled = False
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 563
        Top = 9
        Width = 48
        Height = 12
        Caption = #36827#36135#26085#26399
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 194
        Top = 9
        Width = 48
        Height = 12
        Caption = #20379' '#24212' '#21830
      end
      object Label1: TLabel [2]
        Left = 409
        Top = 30
        Width = 36
        Height = 12
        Caption = #39564#36135#21592
      end
      object Label2: TLabel [3]
        Left = 194
        Top = 72
        Width = 48
        Height = 12
        Caption = #22791'    '#27880
      end
      object Label40: TLabel [4]
        Left = 194
        Top = 30
        Width = 48
        Height = 12
        Caption = #36827#36135#38376#24215
      end
      object Label12: TLabel [5]
        Left = 563
        Top = 30
        Width = 48
        Height = 12
        Caption = #35746#36135#21333#21495
      end
      object Label3: TLabel [6]
        Left = 194
        Top = 51
        Width = 48
        Height = 12
        Caption = #25152#23646#37096#38376
      end
      object Label8: TLabel [7]
        Left = 563
        Top = 51
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel [8]
        Left = 564
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      inherited RzPanel4: TRzPanel
        Top = 5
        Height = 76
        Enabled = False
        TabOrder = 7
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
      object edtSTOCK_DATE: TcxDateEdit
        Tag = 1
        Left = 623
        Top = 5
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 5
      end
      object edtREMARK: TcxTextEdit
        Tag = 1
        Left = 250
        Top = 68
        Width = 287
        Height = 20
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtGUIDE_USER: TzrComboBoxList
        Tag = 1
        Left = 456
        Top = 26
        Width = 81
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 2
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
      object edtCLIENT_ID: TzrComboBoxList
        Tag = 1
        Left = 250
        Top = 5
        Width = 287
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
        FilterFields = 'CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
        KeyField = 'CLIENT_ID'
        ListField = 'CLIENT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CLIENT_CODE'
            Footers = <>
            Title.Caption = #20195#30721
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = #20379#24212#21830#21517#31216
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
        DropWidth = 290
        DropHeight = 281
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtSHOP_ID: TzrComboBoxList
        Tag = 1
        Left = 250
        Top = 26
        Width = 131
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 1
        InGrid = False
        KeyValue = Null
        FilterFields = 'SEQ_NO;SHOP_NAME;SHOP_SPELL'
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
      object edtINDE_GLIDE_NO: TcxButtonEdit
        Tag = 1
        Left = 623
        Top = 26
        Width = 121
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        TabOrder = 6
      end
      object edtDEPT_ID: TzrComboBoxList
        Tag = 1
        Left = 250
        Top = 47
        Width = 131
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
      object edtLOCUS_CHK_DATE: TcxTextEdit
        Tag = 1
        Left = 623
        Top = 47
        Width = 121
        Height = 20
        TabOrder = 8
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtLOCUS_CHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 623
        Top = 68
        Width = 121
        Height = 20
        TabOrder = 9
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
        Brush.Color = 13686755
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
      Top = 139
      Width = 768
      Height = 248
      Color = clWhite
      TabOrder = 3
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
          Title.Caption = #36864#36135#25968#37327
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
      Top = 105
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
