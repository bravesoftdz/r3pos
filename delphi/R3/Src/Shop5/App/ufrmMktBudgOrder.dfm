inherited frmMktBudgOrder: TfrmMktBudgOrder
  Left = 229
  Top = 189
  Width = 929
  Height = 520
  Caption = #26680#38144#21333
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 921
    Height = 493
    inherited RzPanel2: TRzPanel
      Width = 911
      Height = 125
      object lblBUDG_DATE: TLabel [0]
        Left = 562
        Top = 17
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #26680#38144#26085#26399
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 195
        Top = 17
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32463' '#38144' '#21830
      end
      object Label2: TLabel [2]
        Left = 195
        Top = 101
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object Label40: TLabel [3]
        Left = 195
        Top = 59
        Width = 48
        Height = 12
        Caption = #26680#38144#38376#24215
      end
      object Label3: TLabel [4]
        Left = 195
        Top = 80
        Width = 48
        Height = 12
        Caption = #26680#38144#37096#38376
      end
      object Label8: TLabel [5]
        Left = 562
        Top = 38
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel [6]
        Left = 562
        Top = 59
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      object Label21: TLabel [7]
        Left = 195
        Top = 38
        Width = 48
        Height = 12
        Caption = #30003#39046#21333#21495
      end
      object Label6: TLabel [8]
        Left = 404
        Top = 38
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #26680#38144#20154
      end
      object RzLabel3: TRzLabel [9]
        Left = 370
        Top = 80
        Width = 71
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #26680#38144#37329#39069
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      inherited RzPanel4: TRzPanel
        TabOrder = 10
      end
      object edtCLIENT_ID: TzrComboBoxList
        Left = 251
        Top = 13
        Width = 264
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
        OnSaveValue = edtCLIENT_IDSaveValue
        MultiSelect = False
      end
      object edtBUDG_DATE: TcxDateEdit
        Left = 619
        Top = 13
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 7
      end
      object edtREMARK: TcxTextEdit
        Left = 251
        Top = 97
        Width = 286
        Height = 20
        TabOrder = 6
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 251
        Top = 55
        Width = 286
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
      object edtDEPT_ID: TzrComboBoxList
        Left = 251
        Top = 76
        Width = 134
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 4
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
      object RzBitBtn1: TRzBitBtn
        Left = 514
        Top = 13
        Width = 23
        Height = 20
        Caption = #35814
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 11
        TabStop = False
        TextStyle = tsRaised
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 619
        Top = 34
        Width = 121
        Height = 20
        TabOrder = 8
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 619
        Top = 55
        Width = 121
        Height = 20
        TabOrder = 9
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtREQU_ID_TEXT: TcxButtonEdit
        Left = 251
        Top = 34
        Width = 134
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = edtREQU_IDPropertiesButtonClick
        TabOrder = 1
      end
      object edtBUDG_USER: TzrComboBoxList
        Left = 448
        Top = 34
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
        OnAddClick = edtBUDG_USERAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtBUDG_VRF: TcxTextEdit
        Left = 448
        Top = 76
        Width = 89
        Height = 20
        Enabled = False
        Properties.MaxLength = 11
        TabOrder = 5
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 418
      Width = 911
      Height = 38
    end
    inherited DBGridEh1: TDBGridEh
      Top = 130
      Width = 911
      Height = 288
      PopupMenu = PopupMenu1
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
          FieldName = 'KPI_ID_TEXT'
          Footers = <>
          Title.Caption = #25351#26631#21517#31216
          Width = 141
          Control = edtKPI_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'ACTIVE_ID_TEXT'
          Footers = <>
          Title.Caption = #27963#21160#21517#31216
          Width = 141
          Control = edtACTIVE_ID
          OnBeforeShowControl = DBGridEh1Columns2BeforeShowControl
        end
        item
          DisplayFormat = '#0.00'
          EditButtons = <>
          FieldName = 'BUDG_VRF'
          Footers = <>
          Title.Caption = #27963#21160#36153#29992
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = #25688#35201
          Width = 340
        end>
    end
    inherited stbHint: TRzPanel
      Top = 456
      Width = 911
      Height = 8
    end
    inherited rzHelp: TRzPanel
      Top = 464
      Width = 911
      Height = 24
    end
    object edtKPI_ID: TzrComboBoxList
      Left = 44
      Top = 172
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
    object edtACTIVE_ID: TzrComboBoxList
      Left = 60
      Top = 204
      Width = 141
      Height = 20
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = True
      TabOrder = 6
      Visible = False
      OnEnter = edtACTIVE_IDEnter
      OnExit = edtACTIVE_IDExit
      OnKeyDown = edtACTIVE_IDKeyDown
      OnKeyPress = edtACTIVE_IDKeyPress
      InGrid = True
      KeyValue = Null
      FilterFields = 'ACTIVE_NAME;ACTIVE_SPELL'
      KeyField = 'ACTIVE_ID'
      ListField = 'ACTIVE_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'ACTIVE_NAME'
          Footers = <>
          Title.Caption = #27963#21160#21517#31216
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'ACTIVE_SPELL'
          Footers = <>
          Title.Caption = #25340#38899#30721
          Width = 30
        end>
      DataSet = CdsActive
      DropWidth = 157
      DropHeight = 180
      ShowTitle = True
      AutoFitColWidth = True
      ShowButton = True
      LocateStyle = lsDark
      Buttons = []
      DropListStyle = lsFixed
      OnSaveValue = edtACTIVE_IDSaveValue
      MultiSelect = False
    end
  end
  inherited cdsHeader: TZQuery
    Left = 72
    Top = 235
  end
  object cdsKPI_ID: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 192
    Top = 168
  end
  object CdsActive: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 208
    Top = 200
  end
  object cdsBudgShare: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 72
    Top = 296
  end
  object PopupMenu1: TPopupMenu
    Left = 152
    Top = 304
    object N1: TMenuItem
      Caption = #28155#21152#25351#26631
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21024#38500#25351#26631
      OnClick = N2Click
    end
  end
end
