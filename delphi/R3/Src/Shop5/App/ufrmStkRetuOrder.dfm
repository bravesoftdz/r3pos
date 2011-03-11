inherited frmStkRetuOrder: TfrmStkRetuOrder
  Left = 184
  Top = 139
  Width = 787
  Height = 542
  Caption = '采购退货单'
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 771
    Height = 504
    inherited RzPanel2: TRzPanel
      Width = 761
      Height = 96
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 563
        Top = 9
        Width = 48
        Height = 12
        Caption = '退货日期'
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 194
        Top = 9
        Width = 48
        Height = 12
        Caption = '供 应 商'
      end
      object Label1: TLabel [2]
        Left = 409
        Top = 30
        Width = 36
        Height = 12
        Caption = '验货员'
      end
      object Label2: TLabel [3]
        Left = 194
        Top = 72
        Width = 48
        Height = 12
        Caption = '备    注'
      end
      object Label5: TLabel [4]
        Left = 563
        Top = 30
        Width = 48
        Height = 12
        Caption = '票据类型'
      end
      object Label40: TLabel [5]
        Left = 194
        Top = 30
        Width = 48
        Height = 12
        Caption = '退货门店'
      end
      object Label12: TLabel [6]
        Left = 194
        Top = 51
        Width = 48
        Height = 12
        Caption = '订货单号'
      end
      object Label13: TLabel [7]
        Left = 409
        Top = 51
        Width = 36
        Height = 12
        Caption = '预付款'
      end
      object Label14: TLabel [8]
        Left = 563
        Top = 51
        Width = 48
        Height = 12
        Caption = '进项税率'
      end
      object Label4: TLabel [9]
        Left = 563
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '进项税额'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      inherited RzPanel4: TRzPanel
        Top = 5
        Height = 76
        TabOrder = 9
        inherited Image1: TImage
          Left = 103
          Top = 31
        end
        inherited lblState: TLabel
          Top = 43
        end
      end
      object edtSTOCK_DATE: TcxDateEdit
        Left = 623
        Top = 5
        Width = 121
        Height = 20
        TabOrder = 6
      end
      object edtREMARK: TcxTextEdit
        Left = 250
        Top = 68
        Width = 287
        Height = 20
        TabOrder = 5
      end
      object edtGUIDE_USER: TzrComboBoxList
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
        OnAddClick = edtGUIDE_USERAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtINVOICE_FLAG: TcxComboBox
        Left = 623
        Top = 26
        Width = 121
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = edtINVOICE_FLAGPropertiesChange
        TabOrder = 7
      end
      object edtTAX_RATE: TcxSpinEdit
        Left = 623
        Top = 47
        Width = 51
        Height = 20
        Properties.MaxValue = 100.000000000000000000
        Properties.ValueType = vtFloat
        TabOrder = 8
      end
      object edtCLIENT_ID: TzrComboBoxList
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
            Title.Caption = '代码'
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = '供应商名称'
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'LINKMAN'
            Footers = <>
            Title.Caption = '联系人'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'TELEPHONE2'
            Footers = <>
            Title.Caption = '联系电话'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'LICENSE_CODE'
            Footers = <>
            Title.Caption = '证件号'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ADDRESS'
            Footers = <>
            Title.Caption = '地址'
            Width = 150
          end>
        DropWidth = 290
        DropHeight = 281
        ShowTitle = True
        AutoFitColWidth = False
        OnAddClick = edtCLIENT_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtCLIENT_IDSaveValue
        MultiSelect = False
      end
      object edtSHOP_ID: TzrComboBoxList
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
      object edtADVA_MNY: TcxTextEdit
        Left = 456
        Top = 47
        Width = 81
        Height = 20
        TabOrder = 4
      end
      object edtFROM_ID: TcxButtonEdit
        Left = 250
        Top = 47
        Width = 131
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        TabOrder = 3
      end
      object edtTAX_MONEY: TcxTextEdit
        Tag = 1
        Left = 623
        Top = 68
        Width = 121
        Height = 20
        TabStop = False
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = '宋体'
        Style.Font.Style = [fsBold]
        TabOrder = 10
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 402
      Width = 761
      Height = 54
      TabOrder = 2
      object Label19: TLabel
        Left = 29
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '本单已退'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 204
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '本单欠退'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 28
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '审核日期'
      end
      object Label9: TLabel
        Left = 204
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '审核用户'
      end
      object Label10: TLabel
        Left = 395
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '累计欠款'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 587
        Top = 39
        Width = 48
        Height = 12
        Caption = '最新库存'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object edtRECV_MNY: TcxTextEdit
        Tag = 1
        Left = 83
        Top = 34
        Width = 99
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = '宋体'
        Style.Font.Style = [fsBold]
        TabOrder = 0
      end
      object edtRECK_MNY: TcxTextEdit
        Tag = 1
        Left = 259
        Top = 34
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = '宋体'
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
        Top = 34
        Width = 99
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = '宋体'
        Style.Font.Style = [fsBold]
        TabOrder = 4
      end
      object fndMY_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 641
        Top = 34
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = '宋体'
        Style.Font.Style = [fsBold]
        TabOrder = 5
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 135
      Width = 761
      Height = 267
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
          Width = 153
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = '货号'
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = '条码'
          Width = 95
        end
        item
          Alignment = taCenter
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
          Width = 53
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'APRICE'
          Footers = <>
          Title.Caption = '退货价'
          Width = 56
          OnUpdateData = DBGridEh1Columns5UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = '金额'
          Width = 72
          OnUpdateData = DBGridEh1Columns6UpdateData
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'IS_PRESENT'
          Footers = <>
          KeyList.Strings = (
            '1'
            '0')
          PickList.Strings = (
            '是'
            '否')
          ReadOnly = True
          Title.Caption = '赠品'
          Title.Hint = '按 "空格键(SPACE)" 进行赠品转换'
          Width = 39
          OnUpdateData = DBGridEh1Columns7UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'ORG_PRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = '零售价'
          Width = 48
        end
        item
          EditButtons = <>
          FieldName = 'RTL_MONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = '销售额'
          Width = 68
        end
        item
          DisplayFormat = '#0%'
          EditButtons = <>
          FieldName = 'AGIO_RATE'
          Footers = <>
          ReadOnly = True
          Title.Caption = '折扣率'
          Width = 45
        end
        item
          EditButtons = <>
          FieldName = 'AGIO_MONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = '让利金额'
          Width = 65
        end
        item
          EditButtons = <>
          FieldName = 'LOCUS_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = '物流跟踪号'
          Width = 89
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = '批号'
          Width = 93
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = '备注'
          Width = 157
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 536
      Top = 179
    end
    inherited pnlBarCode: TRzPanel
      Top = 101
      Width = 761
      Height = 34
    end
    inherited stbHint: TRzPanel
      Top = 456
      Width = 761
    end
    inherited rzHelp: TRzPanel
      Top = 480
      Width = 761
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
    object actPrintBarcode: TAction
      Caption = '打印条码'
      OnExecute = actPrintBarcodeExecute
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem [2]
      Action = actPrintBarcode
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
        Name = 'RTL_MONEY'
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
