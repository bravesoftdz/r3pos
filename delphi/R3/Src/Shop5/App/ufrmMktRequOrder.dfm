inherited frmMktRequOrder: TfrmMktRequOrder
  Left = 321
  Top = 155
  Width = 890
  Height = 569
  Caption = #36153#29992#30003#39046#21333
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 882
    Height = 542
    inherited RzPanel2: TRzPanel
      Width = 872
      Height = 111
      object lblSTOCK_DATE: TLabel [0]
        Left = 562
        Top = 17
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22635#25253#26085#26399
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
      object Label5: TLabel [3]
        Left = 392
        Top = 59
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #36153#29992#31867#22411
      end
      object Label6: TLabel [4]
        Left = 404
        Top = 38
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #22635#25253#20154
      end
      object Label40: TLabel [5]
        Left = 195
        Top = 38
        Width = 48
        Height = 12
        Caption = #30003#25253#38376#24215
      end
      object Label3: TLabel [6]
        Left = 195
        Top = 59
        Width = 48
        Height = 12
        Caption = #25152#23646#37096#38376
      end
      inherited RzPanel4: TRzPanel
        TabOrder = 7
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
        TabOrder = 1
      end
      object edtREMARK: TcxTextEdit
        Left = 251
        Top = 76
        Width = 286
        Height = 20
        TabOrder = 6
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtREQU_TYPE: TcxComboBox
        Left = 448
        Top = 55
        Width = 89
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = edtREQU_TYPEPropertiesChange
        TabOrder = 5
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
        TabOrder = 8
        TabStop = False
        TextStyle = tsRaised
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 462
      Width = 872
      object RzLabel9: TRzLabel
        Left = 33
        Top = 22
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label1: TLabel
        Left = 235
        Top = 22
        Width = 48
        Height = 12
        Caption = #23457#26680#20154#21592
      end
      object Label4: TLabel
        Left = 439
        Top = 22
        Width = 48
        Height = 12
        Caption = #21512#35745#37329#39069
      end
      object edtCHK_USER: TcxTextEdit
        Tag = 1
        Left = 287
        Top = 18
        Width = 121
        Height = 20
        Properties.MaxLength = 11
        TabOrder = 0
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 85
        Top = 18
        Width = 121
        Height = 20
        Properties.MaxLength = 11
        TabOrder = 1
      end
      object edtREQU_MNY: TcxTextEdit
        Tag = 1
        Left = 493
        Top = 18
        Width = 121
        Height = 20
        Properties.MaxLength = 11
        TabOrder = 2
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 116
      Width = 872
      Height = 346
      PopupMenu = PopupMenu1
      OnDrawFooterCell = DBGridEh1DrawFooterCell
      OnEnter = DBGridEh1Enter
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
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'KPI_YEAR'
          Footers = <>
          Title.Caption = #24180#24230
          Width = 60
          OnUpdateData = DBGridEh1Columns2UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'KPI_MNY'
          Footers = <>
          ReadOnly = True
          Title.Caption = #35745#25552#37329#39069
          Width = 68
        end
        item
          EditButtons = <>
          FieldName = 'REQU_MNY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #30003#39046#37329#39069
          Width = 69
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = #25688'    '#35201
          Width = 307
        end>
    end
    inherited stbHint: TRzPanel
      Top = 515
      Width = 872
      Height = 0
    end
    inherited rzHelp: TRzPanel
      Top = 515
      Width = 872
      Height = 22
    end
    object edtKPI_ID: TzrComboBoxList
      Left = 88
      Top = 224
      Width = 150
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
      InGrid = False
      KeyValue = Null
      FilterFields = 'KPI_NAME'
      KeyField = 'KPI_ID'
      ListField = 'KPI_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'KPI_NAME'
          Footers = <>
          Title.Caption = #25351#26631#21517#31216
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
  inherited cdsHeader: TZQuery
    Top = 181
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
    Left = 240
    Top = 216
  end
  object PopupMenu1: TPopupMenu
    Left = 136
    Top = 264
    object DeleteRecord: TMenuItem
      Caption = #21024#38500#25351#26631
      OnClick = DeleteRecordClick
    end
  end
end
