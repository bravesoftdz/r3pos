inherited frmDbOrder: TfrmDbOrder
  Left = 194
  Top = 111
  Width = 885
  Height = 552
  Caption = #35843#25320#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 869
    Height = 514
    inherited RzPanel2: TRzPanel
      Width = 859
      Height = 98
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 418
        Top = 9
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #35843#20986#26085#26399
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 195
        Top = 9
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #35843#20837#38376#24215
      end
      object Label2: TLabel [2]
        Left = 195
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object Label6: TLabel [3]
        Left = 207
        Top = 51
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #36865#36135#21592
      end
      object Label40: TLabel [4]
        Left = 195
        Top = 30
        Width = 48
        Height = 12
        Caption = #35843#20986#38376#24215
      end
      object Label13: TLabel [5]
        Left = 419
        Top = 30
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #21040#36135#26085#26399
      end
      object Label3: TLabel [6]
        Left = 431
        Top = 51
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #39564#36135#21592
      end
      inherited RzPanel4: TRzPanel
        Height = 83
        TabOrder = 5
        inherited Shape1: TShape
          Top = 33
        end
        inherited lblCaption: TLabel
          Left = 11
          Caption = #21333#21495':'#33258#21160#32534#21495
        end
        inherited Image1: TImage
          Left = 95
          Top = 39
        end
        inherited lblState: TLabel
          Left = 8
          Top = 48
          Caption = #25910#27454':'
        end
      end
      object edtSALES_DATE: TcxDateEdit
        Left = 475
        Top = 5
        Width = 121
        Height = 20
        TabOrder = 3
      end
      object edtREMARK: TcxTextEdit
        Left = 251
        Top = 68
        Width = 313
        Height = 20
        TabOrder = 2
      end
      object edtGUIDE_USER: TzrComboBoxList
        Left = 251
        Top = 47
        Width = 116
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 1
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
        Top = 26
        Width = 158
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
        OnSaveValue = edtSHOP_IDSaveValue
        MultiSelect = False
      end
      object edtPLAN_DATE: TcxDateEdit
        Left = 475
        Top = 26
        Width = 121
        Height = 20
        TabOrder = 4
      end
      object edtSTOCK_USER: TzrComboBoxList
        Left = 475
        Top = 47
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 6
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
        Buttons = [zbNew, zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtCLIENT_ID: TzrComboBoxList
        Left = 251
        Top = 5
        Width = 158
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 7
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
        OnSaveValue = edtSHOP_IDSaveValue
        MultiSelect = False
      end
      object btnOk: TRzBitBtn
        Left = 602
        Top = 26
        Width = 67
        Height = 42
        Action = actOK
        Caption = #21040#36135#30830#35748
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
        TextStyle = tsRaised
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 410
      Width = 859
      Height = 62
      TabOrder = 2
      object Label8: TLabel
        Left = 28
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel
        Left = 204
        Top = 15
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      object Label1: TLabel
        Left = 379
        Top = 15
        Width = 60
        Height = 12
        Caption = #35843#20986#26041#24211#23384
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 579
        Top = 15
        Width = 60
        Height = 12
        Caption = #35843#20837#26041#24211#23384
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 83
        Top = 11
        Width = 99
        Height = 20
        TabOrder = 0
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 259
        Top = 11
        Width = 98
        Height = 20
        TabOrder = 1
      end
      object fndMY_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 449
        Top = 11
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 2
      end
      object fndMY1_AMOUNT: TcxTextEdit
        Tag = 1
        Left = 649
        Top = 11
        Width = 98
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 3
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 136
      Width = 859
      Height = 274
      TabOrder = 3
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
          Width = 150
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #36135#21495
          Width = 72
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          ReadOnly = True
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
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #25968#37327
          Width = 56
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          DisplayFormat = '#0.0##'
          EditButtons = <>
          FieldName = 'COST_APRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25104#26412#20215
          Width = 57
        end
        item
          DisplayFormat = '#0.00'
          EditButtons = <>
          FieldName = 'COST_MONEY'
          Footers = <>
          ReadOnly = True
          Title.Caption = #36827#36135#25104#26412
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 'APRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #38646#21806#20215
          Width = 57
        end
        item
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = #38144#21806#39069
          Width = 71
        end
        item
          EditButtons = <>
          FieldName = 'IS_PRESENT'
          Footers = <>
          ReadOnly = True
          Title.Caption = #36192#21697
          Width = 33
        end
        item
          EditButtons = <>
          FieldName = 'LOCUS_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #29289#27969#36319#36394#21495
          Width = 94
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25209#21495
          Width = 95
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          ReadOnly = True
          Title.Caption = #22791#27880
          Width = 140
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 96
      Top = 203
    end
    inherited pnlBarCode: TRzPanel
      Top = 103
      Width = 859
    end
    inherited stbHint: TRzPanel
      Top = 472
      Width = 859
    end
    inherited rzHelp: TRzPanel
      Top = 496
      Width = 859
      Height = 13
    end
    inherited fndUNIT_ID: TcxComboBox
      Top = 208
    end
  end
  inherited actList: TActionList
    object actCustomer: TAction
      Caption = #36755#20837#20250#21592#21345#21495
      ShortCut = 116
      OnExecute = actCustomerExecute
    end
    object actOK: TAction
      Caption = #21040#36135#30830#35748
      OnExecute = actOKExecute
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
