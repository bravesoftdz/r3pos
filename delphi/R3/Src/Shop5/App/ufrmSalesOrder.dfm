inherited frmSalesOrder: TfrmSalesOrder
  Left = 172
  Top = 174
  Width = 796
  Height = 552
  Caption = '���۵�'
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 780
    Height = 514
    inherited RzPanel2: TRzPanel
      Width = 770
      Height = 140
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 562
        Top = 9
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '��������'
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 195
        Top = 9
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '�ͻ�����'
      end
      object Label2: TLabel [2]
        Left = 195
        Top = 114
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '��    ע'
      end
      object Label5: TLabel [3]
        Left = 563
        Top = 94
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = 'Ʊ������'
      end
      object Label6: TLabel [4]
        Left = 404
        Top = 30
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = '����Ա'
      end
      object Label40: TLabel [5]
        Left = 195
        Top = 30
        Width = 48
        Height = 12
        Caption = '�����ŵ�'
      end
      object Label12: TLabel [6]
        Left = 195
        Top = 93
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '�ͻ���ַ'
      end
      object Label15: TLabel [7]
        Left = 195
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '��ϵ�绰'
      end
      object Label16: TLabel [8]
        Left = 405
        Top = 51
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = '��ϵ��'
      end
      object Label17: TLabel [9]
        Left = 562
        Top = 52
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '���۷�ʽ'
      end
      object Label13: TLabel [10]
        Left = 563
        Top = 73
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '�ͻ�����'
      end
      object Label11: TLabel [11]
        Left = 563
        Top = 115
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '����˰��'
      end
      object Label21: TLabel [12]
        Left = 563
        Top = 30
        Width = 48
        Height = 12
        Caption = '��������'
      end
      object Label3: TLabel [13]
        Left = 195
        Top = 51
        Width = 48
        Height = 12
        Caption = '��������'
      end
      object Label14: TLabel [14]
        Left = 676
        Top = 115
        Width = 6
        Height = 12
        Alignment = taRightJustify
        Caption = '%'
      end
      inherited RzPanel4: TRzPanel
        Height = 83
        TabOrder = 14
        inherited Shape1: TShape
          Top = 33
        end
        inherited lblCaption: TLabel
          Left = 11
          Caption = '����:�Զ����'
        end
        inherited Image1: TImage
          Left = 95
          Top = 39
        end
        inherited lblState: TLabel
          Left = 8
          Top = 48
          Caption = '�տ�:'
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
            Title.Caption = '�ͻ���'
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = '�ͻ�����'
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'LINKMAN'
            Footers = <>
            Title.Caption = '��ϵ��'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'TELEPHONE2'
            Footers = <>
            Title.Caption = '��ϵ�绰'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'LICENSE_CODE'
            Footers = <>
            Title.Caption = '֤����'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ADDRESS'
            Footers = <>
            Title.Caption = '��ַ'
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
        ImeName = '����(����) - �ѹ�������뷨'
        TabOrder = 8
      end
      object edtREMARK: TcxTextEdit
        Left = 251
        Top = 110
        Width = 286
        Height = 20
        TabOrder = 7
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtINVOICE_FLAG: TcxComboBox
        Left = 619
        Top = 90
        Width = 121
        Height = 20
        ImeName = '����(����) - �ѹ�������뷨'
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = edtINVOICE_FLAGPropertiesChange
        TabOrder = 12
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
            Title.Caption = '�ʺ�'
          end
          item
            EditButtons = <>
            FieldName = 'USER_NAME'
            Footers = <>
            Title.Caption = '����'
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
        Top = 111
        Width = 50
        Height = 20
        Properties.MaxValue = 100.000000000000000000
        Properties.ValueType = vtFloat
        TabOrder = 13
        ImeName = '����(����) - �ѹ�������뷨'
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
        TabOrder = 1
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
            Title.Caption = '����'
          end
          item
            EditButtons = <>
            FieldName = 'SEQ_NO'
            Footers = <>
            Title.Caption = '���'
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
      object edtSEND_ADDR: TcxTextEdit
        Left = 251
        Top = 89
        Width = 286
        Height = 20
        TabOrder = 6
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtTELEPHONE: TcxTextEdit
        Left = 251
        Top = 68
        Width = 286
        Height = 20
        TabOrder = 5
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtLINKMAN: TcxTextEdit
        Left = 448
        Top = 47
        Width = 89
        Height = 20
        TabOrder = 4
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtSALE_STYLE: TzrComboBoxList
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
        TabOrder = 10
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
            Title.Caption = '������'
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
        Top = 69
        Width = 121
        Height = 20
        ImeName = '����(����) - �ѹ�������뷨'
        TabOrder = 11
      end
      object edtINDE_GLIDE_NO: TcxButtonEdit
        Left = 619
        Top = 26
        Width = 121
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = edtFROM_IDPropertiesButtonClick
        TabOrder = 9
      end
      object edtDEPT_ID: TzrComboBoxList
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
            Title.Caption = '����'
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
    end
    inherited RzPanel3: TRzPanel
      Top = 409
      Width = 770
      Height = 63
      TabOrder = 2
      object Label19: TLabel
        Left = 205
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '����ʵ��'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 388
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '����Ƿ��'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 28
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '�������'
      end
      object Label9: TLabel
        Left = 204
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '����û�'
      end
      object Label10: TLabel
        Left = 587
        Top = 39
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '�ۼ�Ƿ��'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 587
        Top = 15
        Width = 48
        Height = 12
        Caption = '���¿��'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 27
        Top = 39
        Width = 48
        Height = 12
        Caption = 'Ԥ�ճ���'
      end
      object Label4: TLabel
        Left = 388
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '����˰��'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object edtRECV_MNY: TcxTextEdit
        Tag = 1
        Left = 259
        Top = 35
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = '����'
        Style.Font.Style = [fsBold]
        TabOrder = 0
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtRECK_MNY: TcxTextEdit
        Tag = 1
        Left = 443
        Top = 35
        Width = 120
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = '����'
        Style.Font.Style = [fsBold]
        TabOrder = 1
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 83
        Top = 11
        Width = 99
        Height = 20
        TabOrder = 2
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 259
        Top = 11
        Width = 98
        Height = 20
        TabOrder = 3
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object fndRECK_MNY: TcxTextEdit
        Tag = 1
        Left = 641
        Top = 35
        Width = 99
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = '����'
        Style.Font.Style = [fsBold]
        TabOrder = 4
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object fndMY_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 641
        Top = 11
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = '����'
        Style.Font.Style = [fsBold]
        TabOrder = 5
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtADVA_MNY: TcxTextEdit
        Tag = 1
        Left = 83
        Top = 35
        Width = 99
        Height = 20
        TabOrder = 6
        ImeName = '����(����) - �ѹ�������뷨'
      end
      object edtTAX_MONEY: TcxTextEdit
        Tag = 1
        Left = 443
        Top = 11
        Width = 120
        Height = 20
        TabStop = False
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -12
        Style.Font.Name = '����'
        Style.Font.Style = [fsBold]
        TabOrder = 7
        ImeName = '����(����) - �ѹ�������뷨'
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 178
      Width = 770
      Height = 231
      TabOrder = 3
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SEQNO'
          Footers = <>
          Title.Caption = '���'
          Width = 31
        end
        item
          EditButtons = <>
          FieldName = 'GODS_NAME'
          Footers = <>
          Title.Caption = '��Ʒ����'
          Title.Hint = '֧�� "���š���Ʒ���ơ�ƴ����" ��ѯ'
          Width = 150
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          ReadOnly = True
          Title.Caption = '����'
          Width = 72
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          ReadOnly = True
          Title.Caption = '����'
          Width = 95
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'UNIT_ID'
          Footers = <>
          Title.Caption = '��λ'
          Title.Hint = '�� "�ո��(SPACE)" ���е�λת��'
          Width = 41
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = '����'
          Width = 56
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'APRICE'
          Footers = <>
          Title.Caption = '����'
          Width = 63
          OnUpdateData = DBGridEh1Columns5UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = '���'
          Width = 83
          OnUpdateData = DBGridEh1Columns6UpdateData
        end
        item
          DisplayFormat = '#0%'
          EditButtons = <>
          FieldName = 'AGIO_RATE'
          Footers = <>
          Title.Caption = '�ۿ���'
          Width = 52
          OnUpdateData = DBGridEh1Columns7UpdateData
        end
        item
          Alignment = taCenter
          Checkboxes = False
          EditButtons = <>
          FieldName = 'IS_PRESENT'
          Footers = <>
          KeyList.Strings = (
            '1'
            '0')
          ReadOnly = True
          Title.Caption = '��Ʒ'
          Title.Hint = '�� "�ո��(SPACE)" ������Ʒת��'
          Width = 36
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = '����'
          Width = 95
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = '��ע'
          Width = 140
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 96
      Top = 203
    end
    inherited pnlBarCode: TRzPanel
      Top = 145
      Width = 770
    end
    inherited stbHint: TRzPanel
      Top = 472
      Width = 770
    end
    inherited rzHelp: TRzPanel
      Top = 496
      Width = 770
      Height = 13
    end
    inherited fndUNIT_ID: TcxComboBox
      Top = 208
    end
  end
  inherited actList: TActionList
    inherited actIsPressent: TAction
      Caption = '�л�(����-��Ʒ-�һ�)'
    end
    object actCustomer: TAction
      Caption = '�����Ա����'
      ShortCut = 116
      OnExecute = actCustomerExecute
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem [5]
      Action = actCustomer
    end
    object N2: TMenuItem [11]
      Caption = '�����˻�'
      OnClick = N2Click
    end
    object N3: TMenuItem [12]
      Caption = '�����˻�'
      OnClick = N3Click
    end
    object N4: TMenuItem [13]
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
