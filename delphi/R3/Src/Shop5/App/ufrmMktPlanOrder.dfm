inherited frmMktPlanOrder: TfrmMktPlanOrder
  Left = 332
  Top = 164
  Width = 883
  Height = 524
  Caption = #32463#38144#21512#21516
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label4: TLabel [0]
    Left = 430
    Top = 46
    Width = 48
    Height = 12
    Caption = #32463' '#25163' '#20154
  end
  inherited RzPanel1: TRzPanel
    Width = 875
    Height = 497
    inherited RzPanel2: TRzPanel
      Width = 865
      Height = 121
      object RzLabel2: TRzLabel [0]
        Left = 507
        Top = 12
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #31614#32422#26085#26399
      end
      object RzLabel4: TRzLabel [1]
        Left = 199
        Top = 12
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32463' '#38144' '#21830
      end
      object Label3: TLabel [2]
        Left = 199
        Top = 34
        Width = 48
        Height = 12
        Caption = #25152#23646#37096#38376
      end
      object Label2: TLabel [3]
        Left = 198
        Top = 78
        Width = 48
        Height = 12
        Caption = #32463' '#25163' '#20154
      end
      object labBEGIN_DATE: TRzLabel [4]
        Left = 507
        Top = 56
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #24320#22987#26085#26399
      end
      object RzLabel1: TRzLabel [5]
        Left = 507
        Top = 78
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32467#26463#26085#26399
      end
      object RzLabel7: TRzLabel [6]
        Left = 507
        Top = 34
        Width = 48
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #24180'    '#24230
      end
      object RzLabel10: TRzLabel [7]
        Left = 198
        Top = 100
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object RzLabel3: TRzLabel [8]
        Left = 330
        Top = 78
        Width = 71
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20445#35777#37329#24635#39069
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label40: TLabel [9]
        Left = 198
        Top = 55
        Width = 48
        Height = 12
        Caption = #25152#23646#38376#24215
      end
      inherited RzPanel4: TRzPanel
        Height = 79
        TabOrder = 10
        inherited Image1: TImage
          Left = 97
          Top = 32
        end
      end
      object edtPLAN_DATE: TcxDateEdit
        Left = 563
        Top = 8
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 5
      end
      object edtCLIENT_ID: TzrComboBoxList
        Left = 254
        Top = 8
        Width = 224
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
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
        DropWidth = 236
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtDEPT_ID: TzrComboBoxList
        Left = 254
        Top = 30
        Width = 224
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
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtPLAN_USER: TzrComboBoxList
        Left = 254
        Top = 74
        Width = 75
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
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtBEGIN_DATE: TcxDateEdit
        Left = 563
        Top = 52
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 7
      end
      object edtEND_DATE: TcxDateEdit
        Left = 563
        Top = 74
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DateButtons = [btnToday]
        TabOrder = 8
      end
      object edtREMARK: TcxMemo
        Left = 254
        Top = 96
        Width = 312
        Height = 20
        Properties.MaxLength = 100
        TabOrder = 9
      end
      object edtBOND_MNY: TcxTextEdit
        Left = 403
        Top = 74
        Width = 75
        Height = 20
        Properties.MaxLength = 11
        TabOrder = 4
      end
      object edtKPI_YEAR: TcxSpinEdit
        Left = 563
        Top = 30
        Width = 121
        Height = 20
        Properties.MaxValue = 2111.000000000000000000
        Properties.MinValue = 2011.000000000000000000
        Properties.OnChange = edtKPI_YEARPropertiesChange
        TabOrder = 6
        Value = 2011
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 254
        Top = 51
        Width = 224
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
    end
    inherited RzPanel3: TRzPanel
      Top = 428
      Width = 865
      Height = 45
      object RzLabel9: TRzLabel
        Left = 33
        Top = 18
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label5: TLabel
        Left = 235
        Top = 18
        Width = 48
        Height = 12
        Caption = #23457#26680#20154#21592
      end
      object edtCHK_USER: TcxTextEdit
        Tag = 1
        Left = 287
        Top = 14
        Width = 121
        Height = 20
        Properties.MaxLength = 11
        TabOrder = 0
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 85
        Top = 14
        Width = 121
        Height = 20
        Properties.MaxLength = 11
        TabOrder = 1
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 126
      Width = 865
      Height = 302
      FrozenCols = 1
      PopupMenu = PopupMenu1
      OnDblClick = DBGridEh1DblClick
      OnDrawFooterCell = DBGridEh1DrawFooterCell
      OnKeyPress = DBGridEh1KeyPress
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SEQNO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #24207#21495
          Width = 31
        end
        item
          EditButtons = <>
          FieldName = 'KPI_ID_TEXT'
          Footers = <>
          Title.Caption = #25351#26631#21517#31216
          Width = 173
          Control = edtKPI_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'UNIT_NAME'
          Footers = <>
          Title.Caption = #21333#20301
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #31614#32422#38144#37327
          Width = 78
        end
        item
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #31614#32422#37329#39069
          Width = 78
        end
        item
          EditButtons = <>
          FieldName = 'BOND_MNY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #20445#35777#37329
          Width = 75
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = #22791'      '#27880
          Width = 240
        end>
    end
    inherited stbHint: TRzPanel
      Top = 473
      Width = 865
      Height = 0
    end
    inherited rzHelp: TRzPanel
      Top = 473
      Width = 865
      Height = 19
    end
    object edtKPI_ID: TzrComboBoxList
      Left = 36
      Top = 284
      Width = 141
      Height = 20
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Visible = False
      OnEnter = edtKPI_IDEnter
      OnExit = edtKPI_IDExit
      OnKeyDown = edtKPI_IDKeyDown
      OnKeyPress = edtKPI_IDKeyPress
      InGrid = True
      KeyValue = Null
      FilterFields = 'KPI_NAME;KPI_SPELL'
      KeyField = 'KPI_ID'
      ListField = 'KPI_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'KPI_NAME'
          Footers = <>
          Title.Caption = #25351#26631#21517#31216
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'KPI_SPELL'
          Footers = <>
          Title.Caption = #25340#38899#30721
          Width = 30
        end>
      DataSet = cdsKPI_ID
      DropWidth = 157
      DropHeight = 180
      ShowTitle = True
      AutoFitColWidth = True
      ShowButton = True
      LocateStyle = lsDark
      Buttons = []
      DropListStyle = lsFixed
      OnSaveValue = edtKPI_IDSaveValue
      MultiSelect = False
    end
  end
  inherited mmMenu: TMainMenu
    Left = 91
    Top = 164
  end
  inherited actList: TActionList
    Left = 121
    Top = 164
  end
  inherited dsTable: TDataSource
    Left = 96
    Top = 336
  end
  inherited cdsDetail: TZQuery
    Left = 64
    Top = 336
  end
  inherited cdsHeader: TZQuery
    Left = 61
    Top = 164
  end
  object PopupMenu1: TPopupMenu
    Left = 128
    Top = 336
    object Delete: TMenuItem
      Caption = #21024#38500#25351#26631
      OnClick = DeleteClick
    end
    object N1: TMenuItem
      Caption = #25351#26631#23646#24615
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #25209#37327#28155#21152
      OnClick = N3Click
    end
  end
  object cdsKPI_ID: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 192
    Top = 288
  end
end
