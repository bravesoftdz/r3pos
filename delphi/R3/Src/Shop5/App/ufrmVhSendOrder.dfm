inherited frmVhSendOrder: TfrmVhSendOrder
  Left = 418
  Top = 214
  Width = 803
  Caption = #31036#21048#21457#25918#31649#29702
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 795
    inherited RzPanel2: TRzPanel
      Width = 785
      Height = 103
      object Label3: TLabel [0]
        Left = 31
        Top = 56
        Width = 48
        Height = 12
        Caption = #21457#25918#37096#38376
      end
      object Label40: TLabel [1]
        Left = 31
        Top = 34
        Width = 48
        Height = 12
        Caption = #21457#25918#38376#24215
      end
      object lblSTOCK_DATE: TLabel [2]
        Left = 385
        Top = 12
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #21457#25918#26085#26399
      end
      object Label9: TLabel [3]
        Left = 386
        Top = 34
        Width = 48
        Height = 12
        Caption = #36127' '#36131' '#20154
      end
      object Label7: TLabel [4]
        Left = 31
        Top = 79
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object lblCLIENT_ID: TLabel [5]
        Left = 31
        Top = 12
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23458#25143#21517#31216
      end
      inherited RzPanel4: TRzPanel
        Width = 0
        TabOrder = 6
      end
      object edtDEPT_ID: TzrComboBoxList
        Left = 87
        Top = 52
        Width = 288
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
        Top = 30
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
      object edtSEND_DATE: TcxDateEdit
        Left = 442
        Top = 8
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 4
      end
      object edtSEND_USER: TzrComboBoxList
        Left = 442
        Top = 30
        Width = 121
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
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtREMARK: TcxTextEdit
        Left = 87
        Top = 74
        Width = 288
        Height = 20
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCLIENT_ID: TzrComboBoxList
        Left = 87
        Top = 8
        Width = 288
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
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew, zbFind]
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 359
      Width = 785
      Height = 26
    end
    inherited DBGridEh1: TDBGridEh
      Top = 145
      Width = 785
      Height = 214
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
          Width = 180
          Control = edtVOUCHER_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footers = <>
          Title.Caption = #25968#37327
          Width = 53
          OnUpdateData = DBGridEh1Columns2UpdateData
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
          DisplayFormat = '#0.00'
          EditButtons = <>
          FieldName = 'VOUCHER_TTL'
          Footer.DisplayFormat = '#0.00'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = #38754#20540#37329#39069
          Width = 83
        end
        item
          DisplayFormat = '#0.00'
          EditButtons = <>
          FieldName = 'VOUCHER_MNY'
          Footer.DisplayFormat = '#0.00'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #23454#25910#37329#39069
          Width = 83
          OnUpdateData = DBGridEh1Columns5UpdateData
        end
        item
          DisplayFormat = '#0%'
          EditButtons = <>
          FieldName = 'AGIO_RATE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25240#25187#29575
          Width = 63
        end
        item
          EditButtons = <>
          FieldName = 'AGIO_MONEY'
          Footer.DisplayFormat = '#0.00'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = #25240#25187#39069
          Width = 83
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #38450#20266#30721
          Width = 130
        end>
    end
    inherited stbHint: TRzPanel
      Width = 785
    end
    inherited rzHelp: TRzPanel
      Width = 785
    end
    object edtVOUCHER_ID: TzrComboBoxList
      Left = 160
      Top = 216
      Width = 133
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
    object RzPanel5: TRzPanel
      Left = 5
      Top = 108
      Width = 785
      Height = 37
      Align = alTop
      BorderOuter = fsFlat
      BorderSides = [sdTop, sdBottom]
      Color = clWhite
      TabOrder = 6
      object lblInput: TLabel
        Left = 32
        Top = 9
        Width = 105
        Height = 20
        Caption = #38450#20266#30721#36755#20837
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -20
        Font.Name = #40657#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtInput: TcxTextEdit
        Left = 141
        Top = 5
        Width = 204
        Height = 27
        ParentFont = False
        Style.BorderStyle = ebsThick
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -19
        Style.Font.Name = #40657#20307
        Style.Font.Style = [fsBold]
        TabOrder = 0
        OnKeyDown = edtInputKeyDown
        OnKeyPress = edtInputKeyPress
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 168
    Top = 264
  end
  inherited actList: TActionList
    Left = 136
    Top = 264
  end
  inherited cdsDetail: TZQuery
    AfterScroll = cdsDetailAfterScroll
  end
  object cdsVoucher: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 296
    Top = 208
  end
end
