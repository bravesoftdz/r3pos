inherited frmMktRequOrder: TfrmMktRequOrder
  Left = 365
  Top = 164
  Width = 837
  Caption = #36153#29992#30003#35831#21333
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 821
    inherited RzPanel2: TRzPanel
      Width = 811
      Height = 113
      object lblSTOCK_DATE: TLabel [0]
        Left = 562
        Top = 17
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #30003#35831#26085#26399
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
        Top = 80
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object Label6: TLabel [3]
        Left = 404
        Top = 38
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #22635#25253#20154
      end
      object Label40: TLabel [4]
        Left = 195
        Top = 38
        Width = 48
        Height = 12
        Caption = #30003#25253#38376#24215
      end
      object Label3: TLabel [5]
        Left = 195
        Top = 59
        Width = 48
        Height = 12
        Caption = #25152#23646#37096#38376
      end
      object Label8: TLabel [6]
        Left = 562
        Top = 38
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel [7]
        Left = 562
        Top = 59
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      object Label5: TLabel [8]
        Left = 392
        Top = 59
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36820#36824#31867#22411
      end
      inherited RzPanel4: TRzPanel
        TabOrder = 9
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
        MultiSelect = False
      end
      object edtREQU_DATE: TcxDateEdit
        Left = 619
        Top = 13
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 6
      end
      object edtREMARK: TcxTextEdit
        Left = 251
        Top = 76
        Width = 286
        Height = 20
        TabOrder = 5
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtREQU_USER: TzrComboBoxList
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
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 251
        Top = 34
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
        Top = 55
        Width = 131
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
        TabOrder = 10
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
        TabOrder = 7
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 619
        Top = 55
        Width = 121
        Height = 20
        TabOrder = 8
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtREQU_TYPE: TcxComboBox
        Left = 448
        Top = 55
        Width = 89
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 4
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 411
      Width = 811
      Height = 14
    end
    inherited DBGridEh1: TDBGridEh
      Top = 118
      Width = 811
      Height = 269
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
          FieldName = 'KPI_ID_TEXT'
          Footers = <>
          Title.Caption = #25351#26631#21517#31216
          Width = 200
          Control = edtKPI_ID
          OnUpdateData = DBGridEh1Columns1UpdateData
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'KPI_YEAR'
          Footers = <>
          Title.Caption = #24180#24230
          Width = 60
          Control = edtKPI_YEAR
          OnBeforeShowControl = DBGridEh1Columns2BeforeShowControl
        end
        item
          DisplayFormat = '#0.00'
          EditButtons = <>
          FieldName = 'KPI_MNY'
          Footers = <>
          Title.Caption = #36820#21033#37329#39069
          Width = 70
          OnUpdateData = DBGridEh1Columns3UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'BUDG_MNY'
          Footers = <>
          Title.Caption = #24066#22330#36153#29992
          Width = 70
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'AGIO_MNY'
          Footers = <>
          Title.Caption = #20215#26684#25903#25345
          Width = 70
          OnUpdateData = DBGridEh1Columns5UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'OTHR_MNY'
          Footers = <>
          Title.Caption = #20854#23427#36153#29992
          Width = 70
          OnUpdateData = DBGridEh1Columns6UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = #25688#35201
          Width = 200
        end>
    end
    inherited stbHint: TRzPanel
      Top = 387
      Width = 811
    end
    inherited rzHelp: TRzPanel
      Top = 425
      Width = 811
      Height = 21
    end
    object edtKPI_YEAR: TzrComboBoxList
      Left = 280
      Top = 232
      Width = 73
      Height = 20
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Visible = False
      OnEnter = edtKPI_YEAREnter
      OnExit = edtKPI_YEARExit
      OnKeyDown = edtKPI_YEARKeyDown
      OnKeyPress = edtKPI_YEARKeyPress
      InGrid = False
      KeyValue = Null
      KeyField = 'KPI_YEAR'
      ListField = 'KPI_YEAR'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'KPI_YEAR'
          Footers = <>
          Title.Caption = #24180#20221
        end>
      DataSet = cdsKPI_YEAR
      DropWidth = 73
      DropHeight = 200
      ShowTitle = False
      AutoFitColWidth = True
      ShowButton = False
      LocateStyle = lsDark
      Buttons = []
      DropListStyle = lsFixed
      OnSaveValue = edtKPI_YEARSaveValue
      MultiSelect = False
    end
    object edtKPI_ID: TzrComboBoxList
      Left = 152
      Top = 232
      Width = 121
      Height = 20
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = True
      TabOrder = 6
      Visible = False
      OnEnter = edtKPI_IDEnter
      OnExit = edtKPI_IDExit
      OnKeyDown = edtKPI_IDKeyDown
      OnKeyPress = edtKPI_IDKeyPress
      InGrid = False
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
        end
        item
          EditButtons = <>
          FieldName = 'KPI_SPELL'
          Footers = <>
          Title.Caption = #25340#38899#30721
        end>
      DataSet = cdsKPI_ID
      DropWidth = 290
      DropHeight = 228
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
  object cdsKPI_YEAR: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 292
    Top = 255
  end
  object cdsKPI_ID: TZQuery
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
      end>
    CachedUpdates = True
    Params = <>
    Left = 224
    Top = 256
  end
  object PopupMenu1: TPopupMenu
    Left = 192
    Top = 280
    object N1: TMenuItem
      Caption = #21024#38500#25351#26631
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #25351#26631#23646#24615
      OnClick = N2Click
    end
  end
end
