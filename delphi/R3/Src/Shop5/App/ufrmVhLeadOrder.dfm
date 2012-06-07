inherited frmVhLeadOrder: TfrmVhLeadOrder
  Left = 383
  Top = 162
  Width = 807
  Height = 541
  Caption = #31036#21048#39046#29992#31649#29702
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 799
    Height = 514
    inherited RzPanel2: TRzPanel
      Width = 789
      Height = 87
      object Label3: TLabel [0]
        Left = 31
        Top = 37
        Width = 48
        Height = 12
        Caption = #39046#29992#37096#38376
      end
      object Label40: TLabel [1]
        Left = 31
        Top = 13
        Width = 48
        Height = 12
        Caption = #39046#29992#38376#24215
      end
      object lblSTOCK_DATE: TLabel [2]
        Left = 385
        Top = 13
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #39046#29992#26085#26399
      end
      object Label9: TLabel [3]
        Left = 386
        Top = 37
        Width = 48
        Height = 12
        Caption = #36127' '#36131' '#20154
      end
      object Label7: TLabel [4]
        Left = 31
        Top = 62
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      inherited RzPanel4: TRzPanel
        Width = 0
        TabOrder = 5
      end
      object edtDEPT_ID: TzrComboBoxList
        Left = 87
        Top = 33
        Width = 288
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
      object edtSHOP_ID: TzrComboBoxList
        Left = 87
        Top = 9
        Width = 288
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        Properties.OnButtonClick = edtSHOP_IDPropertiesButtonClick
        TabOrder = 0
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
      object edtLEAD_DATE: TcxDateEdit
        Left = 442
        Top = 9
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 3
      end
      object edtLEAD_USER: TzrComboBoxList
        Left = 442
        Top = 33
        Width = 121
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
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtREMARK: TcxTextEdit
        Left = 87
        Top = 57
        Width = 288
        Height = 20
        TabOrder = 2
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 400
      Width = 789
      Height = 37
    end
    inherited DBGridEh1: TDBGridEh
      Top = 92
      Width = 789
      Height = 308
      PopupMenu = PopupMenu1
      OnDrawFooterCell = DBGridEh1DrawFooterCell
      OnKeyPress = DBGridEh1KeyPress
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
          FieldName = 'VOUCHER_ID_TEXT'
          Footers = <>
          Title.Caption = #31036#21048#21517#31216
          Width = 150
          Control = edtVOUCHER_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'SUMMARY'
          Footers = <>
          Title.Caption = #25688#35201
          Width = 175
        end
        item
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footers = <>
          Title.Caption = #25968#37327
          Width = 53
          OnUpdateData = DBGridEh1Columns3UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'VOUCHER_PRC'
          Footers = <>
          ReadOnly = True
          Title.Caption = #38754#20540
          Width = 63
        end
        item
          EditButtons = <>
          FieldName = 'VOUCHER_TTL'
          Footers = <>
          ReadOnly = True
          Title.Caption = #38754#20540#37329#39069
          Width = 83
        end>
    end
    inherited stbHint: TRzPanel
      Top = 485
      Width = 789
    end
    inherited rzHelp: TRzPanel
      Top = 437
      Width = 789
      object Label8: TLabel
        Left = 32
        Top = 14
        Width = 60
        Height = 12
        Alignment = taRightJustify
        Caption = #24403#21069#31036#21048#25968
      end
      object edtVOUCHER_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 98
        Top = 10
        Width = 121
        Height = 20
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    object edtVOUCHER_ID: TzrComboBoxList
      Left = 160
      Top = 184
      Width = 121
      Height = 20
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Visible = False
      OnEnter = edtVOUCHER_IDEnter
      OnExit = edtVOUCHER_IDExit
      OnKeyDown = edtVOUCHER_IDKeyDown
      OnKeyPress = edtVOUCHER_IDKeyPress
      InGrid = False
      KeyValue = Null
      FilterFields = 'INTO_DATE,VAILD_DATE,VUCH_NAME'
      KeyField = 'VOUCHER_ID'
      ListField = 'VUCH_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'VUCH_NAME'
          Footers = <>
          Title.Caption = #21517#31216
          Width = 150
        end
        item
          EditButtons = <>
          FieldName = 'VOUCHER_TYPE_TEXT'
          Footers = <>
          Title.Caption = #31867#22411
          Width = 80
        end
        item
          DisplayFormat = '0000-00-00'
          EditButtons = <>
          FieldName = 'INTO_DATE'
          Footers = <>
          Title.Caption = #20837#24211#26085#26399
          Width = 80
        end
        item
          DisplayFormat = '0000-00-00'
          EditButtons = <>
          FieldName = 'VAILD_DATE'
          Footers = <>
          Title.Caption = #26377#25928#26085#26399
          Width = 80
        end>
      DataSet = cdsVoucher
      DropWidth = 390
      DropHeight = 228
      ShowTitle = True
      AutoFitColWidth = True
      ShowButton = True
      LocateStyle = lsDark
      Buttons = []
      DropListStyle = lsFixed
      OnSaveValue = edtVOUCHER_IDSaveValue
      MultiSelect = False
    end
  end
  inherited actList: TActionList
    object actNewVoucher: TAction
      Caption = #26032#22686#31036#21048
      OnExecute = actNewVoucherExecute
    end
    object actDeleteVoucher: TAction
      Caption = #21024#38500#31036#21048
      OnExecute = actDeleteVoucherExecute
    end
  end
  object cdsVoucher: TZReadOnlyQuery
    FieldDefs = <>
    Params = <>
    Left = 296
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    Left = 200
    Top = 240
    object N1: TMenuItem
      Action = actNewVoucher
    end
    object N2: TMenuItem
      Action = actDeleteVoucher
    end
  end
end
