inherited frmChangeOrder: TfrmChangeOrder
  Left = 174
  Top = 207
  Width = 788
  Height = 529
  Caption = '调整单'
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 772
    Height = 491
    inherited RzPanel2: TRzPanel
      Width = 762
      Height = 81
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 568
        Top = 9
        Width = 48
        Height = 12
        Caption = '开单日期'
      end
      object Label13: TLabel [1]
        Left = 569
        Top = 32
        Width = 48
        Height = 12
        Caption = '调整类型'
      end
      object Label1: TLabel [2]
        Left = 390
        Top = 32
        Width = 48
        Height = 12
        Caption = '责 任 人'
      end
      object Label2: TLabel [3]
        Left = 195
        Top = 55
        Width = 48
        Height = 12
        Caption = '备    注'
      end
      object Label40: TLabel [4]
        Left = 194
        Top = 9
        Width = 48
        Height = 12
        Caption = '门店名称'
      end
      object Label4: TLabel [5]
        Left = 194
        Top = 32
        Width = 48
        Height = 12
        Caption = '所属部门'
      end
      inherited RzPanel4: TRzPanel
        Height = 67
        TabOrder = 6
        inherited Image1: TImage
          Top = 23
        end
      end
      object edtCHANGE_DATE: TcxDateEdit
        Left = 624
        Top = 5
        Width = 103
        Height = 20
        TabOrder = 4
      end
      object edtREMARK: TcxTextEdit
        Left = 250
        Top = 51
        Width = 287
        Height = 20
        TabOrder = 3
      end
      object edtDUTY_USER: TzrComboBoxList
        Left = 445
        Top = 28
        Width = 92
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
        FilterFields = 'ACCOUNT;USER_NAME'
        KeyField = 'USER_ID'
        ListField = 'USER_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ACCOUNT'
            Footers = <>
            Title.Caption = '帐号'
          end
          item
            EditButtons = <>
            FieldName = 'USER_NAME'
            Footers = <>
            Title.Caption = '姓名'
            Width = 130
          end>
        DropWidth = 180
        DropHeight = 150
        ShowTitle = True
        AutoFitColWidth = True
        OnAddClick = edtDUTY_USERAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtDUTY_USERSaveValue
        MultiSelect = False
      end
      object edtCHANGE_CODE: TcxComboBox
        Left = 624
        Top = 28
        Width = 103
        Height = 20
        Enabled = False
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = edtCHANGE_CODEPropertiesChange
        TabOrder = 5
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 250
        Top = 5
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 0
        InGrid = False
        KeyValue = Null
        FilterFields = 'SHOP_NAME;SHOP_SPELL'
        KeyField = 'SHOP_ID'
        ListField = 'SHOP_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SHOP_NAME'
            Footers = <>
            Title.Caption = '名称'
          end
          item
            EditButtons = <>
            FieldName = 'SEQ_NO'
            Footers = <>
            Title.Caption = '序号'
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
      object edtDEPT_ID: TzrComboBoxList
        Left = 250
        Top = 28
        Width = 121
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
        FilterFields = 'DEPT_NAME;DEPT_SPELL'
        KeyField = 'DEPT_ID'
        ListField = 'DEPT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DEPT_NAME'
            Footers = <>
            Title.Caption = '名称'
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
      Top = 413
      Width = 762
      Height = 35
      TabOrder = 2
      object Label8: TLabel
        Left = 8
        Top = 9
        Width = 48
        Height = 12
        Caption = '审核日期'
      end
      object Label9: TLabel
        Left = 177
        Top = 10
        Width = 48
        Height = 12
        Caption = '审核用户'
      end
      object Label3: TLabel
        Left = 543
        Top = 10
        Width = 52
        Height = 12
        Caption = '最新库存'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 65
        Top = 5
        Width = 105
        Height = 20
        TabOrder = 0
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 233
        Top = 6
        Width = 105
        Height = 20
        TabOrder = 1
      end
      object fndMY_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 601
        Top = 6
        Width = 99
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = '宋体'
        Style.Font.Style = [fsBold]
        TabOrder = 2
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 119
      Width = 762
      Height = 294
      TabOrder = 3
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SEQNO'
          Footers = <>
          Title.Caption = '序号'
          Width = 31
        end
        item
          EditButtons = <>
          FieldName = 'GODS_NAME'
          Footers = <>
          Title.Caption = '商品名称'
          Title.Hint = '支持 "货号、商品名称、拼音码" 查询'
          Width = 151
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = '货号'
          Width = 69
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = '条码'
          Width = 83
        end
        item
          Alignment = taCenter
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'UNIT_ID'
          Footers = <>
          Title.Caption = '单位'
          Title.Hint = '按 "空格键(SPACE)" 进行单位转换'
          Width = 41
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = '数量'
          Width = 58
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          DisplayFormat = '#0.0##'
          EditButtons = <>
          FieldName = 'COST_APRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = '成本价'
          Width = 58
        end
        item
          DisplayFormat = '#0.00'
          EditButtons = <>
          FieldName = 'COST_MONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = '进货成本'
          Width = 67
        end
        item
          EditButtons = <>
          FieldName = 'APRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = '零售价'
          Width = 59
        end
        item
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = '销售额'
          Width = 71
        end
        item
          EditButtons = <>
          FieldName = 'LOCUS_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = '物流跟踪号'
          Width = 82
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = '批号'
          Width = 96
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = '备注'
          Width = 163
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 88
      Top = 147
    end
    inherited pnlBarCode: TRzPanel
      Top = 86
      Width = 762
    end
    inherited stbHint: TRzPanel
      Top = 448
      Width = 762
    end
    inherited rzHelp: TRzPanel
      Top = 472
      Width = 762
      Height = 14
    end
  end
  inherited mmMenu: TMainMenu
    Left = 272
    Top = 208
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
        Name = 'COST_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'COST_APRICE'
        DataType = ftFloat
      end
      item
        Name = 'COST_MONEY'
        DataType = ftFloat
      end
      item
        Name = 'AMONEY'
        DataType = ftFloat
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
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_AMOUNT'
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
