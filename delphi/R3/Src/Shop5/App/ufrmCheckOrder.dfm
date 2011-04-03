inherited frmCheckOrder: TfrmCheckOrder
  Left = 228
  Top = 153
  Width = 774
  Height = 468
  Caption = #30424#28857#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 766
    Height = 441
    inherited RzPanel2: TRzPanel
      Width = 756
      Height = 81
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 586
        Top = 10
        Width = 48
        Height = 12
        Caption = #30424#28857#26085#26399
      end
      object Label1: TLabel [1]
        Left = 405
        Top = 10
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #30424' '#28857' '#20154
      end
      object Label2: TLabel [2]
        Left = 195
        Top = 31
        Width = 48
        Height = 12
        Caption = #22791'    '#27880
      end
      object Label40: TLabel [3]
        Left = 194
        Top = 9
        Width = 48
        Height = 12
        Caption = #38376#24215#21517#31216
      end
      inherited RzPanel4: TRzPanel
        TabOrder = 4
      end
      object edtREMARK: TcxTextEdit
        Left = 250
        Top = 27
        Width = 307
        Height = 20
        TabOrder = 2
      end
      object edtCREA_USER: TzrComboBoxList
        Left = 461
        Top = 6
        Width = 96
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
        FilterFields = 'ACCOUNT;USER_NAME'
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
        OnAddClick = edtCREA_USERAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtCREA_USERSaveValue
        MultiSelect = False
      end
      object edtCREA_DATE: TcxDateEdit
        Tag = 1
        Left = 642
        Top = 6
        Width = 107
        Height = 20
        TabOrder = 3
      end
      object RzBitBtn1: TRzBitBtn
        Left = 250
        Top = 52
        Width = 108
        Height = 24
        Action = actImportFromMac
        Caption = #20174#30424#28857#26426#23548#20837
        Color = clSilver
        Enabled = False
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        ParentFont = False
        TextShadowColor = clYellow
        TextShadowDepth = 4
        TabOrder = 5
        Visible = False
        NumGlyphs = 2
        Spacing = 5
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 250
        Top = 6
        Width = 131
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
            FieldName = 'SHOP_ID'
            Footers = <>
            Title.Caption = #20195#30721
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
    end
    inherited RzPanel3: TRzPanel
      Top = 329
      Width = 756
      Height = 35
      TabOrder = 2
      object Label8: TLabel
        Left = 8
        Top = 9
        Width = 48
        Height = 12
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel
        Left = 177
        Top = 10
        Width = 48
        Height = 12
        Caption = #23457#26680#29992#25143
      end
      object Lbl_LinkCheckGood: TLabel
        Left = 382
        Top = 11
        Width = 315
        Height = 12
        Cursor = crHandPoint
        Caption = #25552#31034#65306#24403#21069#30424#28857#21333#36824#26377'      '#20010#21830#21697#27809#26377#24405#20837#30424#28857#25968#65307
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = Lbl_LinkCheckGoodClick
        OnMouseMove = Lbl_LinkCheckGoodMouseMove
        OnMouseLeave = Lbl_LinkCheckGoodMouseLeave
      end
      object LblCount: TLabel
        Left = 522
        Top = 11
        Width = 14
        Height = 12
        Caption = '10'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblMm: TLabel
        Left = 671
        Top = 11
        Width = 72
        Height = 12
        Cursor = crHandPoint
        Caption = #65288#28857#20987#26597#30475#65289
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
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
    end
    inherited DBGridEh1: TDBGridEh
      Top = 119
      Width = 756
      Height = 210
      TabOrder = 3
      UseMultiTitle = False
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
          Width = 125
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = #36135#21495
          Width = 65
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = #26465#30721
          Width = 83
        end
        item
          Alignment = taCenter
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'UNIT_ID'
          Footers = <>
          ReadOnly = True
          Title.Caption = #21333#20301
          Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
          Width = 29
        end
        item
          DisplayFormat = '#0.###'
          EditButtons = <>
          FieldName = 'RCK_AMOUNT'
          Footers = <>
          ReadOnly = True
          Title.Caption = #36134#38754#24211#23384
          Width = 59
        end
        item
          ButtonStyle = cbsNone
          DisplayFormat = '#0.###'
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #23454#30424#25968#37327
          Width = 60
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns6UpdateData
        end
        item
          DisplayFormat = '#0.###'
          EditButtons = <>
          FieldName = 'PAL_AMOUNT'
          Footers = <>
          ReadOnly = True
          Title.Caption = #30424#28857#25439#30410
          Width = 62
        end
        item
          EditButtons = <>
          FieldName = 'NEW_INPRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25104#26412#20215
          Width = 53
        end
        item
          EditButtons = <>
          FieldName = 'NEW_OUTPRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #38646#21806#20215
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'PAL_INAMONEY'
          Footers = <>
          ReadOnly = True
          Title.Caption = #36827#36135#37329#39069
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'PAL_OUTAMONEY'
          Footers = <>
          ReadOnly = True
          Title.Caption = #38144#21806#37329#39069
          Width = 62
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25209#21495
          Width = 105
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 88
      Top = 147
      OnAddClick = nil
      Buttons = [zbFind]
    end
    inherited pnlBarCode: TRzPanel
      Top = 86
      Width = 756
    end
    inherited stbHint: TRzPanel
      Top = 412
      Width = 756
    end
    inherited rzHelp: TRzPanel
      Top = 364
      Width = 756
    end
  end
  inherited actList: TActionList
    object actImportFromPrint: TAction
      Caption = #20174#23545#29031#34920#23548#20837
      OnExecute = actImportFromPrintExecute
    end
    object actImportFromMac: TAction
      Caption = #20174#30424#28857#26426#23548#20837
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N2: TMenuItem
      Action = actImportFromMac
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
        Name = 'RCK_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'RCK_CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'PAL_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'NEW_INPRICE'
        DataType = ftFloat
      end
      item
        Name = 'NEW_OUTPRICE'
        DataType = ftFloat
      end
      item
        Name = 'PAL_INAMONEY'
        DataType = ftFloat
      end
      item
        Name = 'PAL_OUTAMONEY'
        DataType = ftFloat
      end>
    AfterPost = edtTableAfterPost
    AfterDelete = edtTableAfterDelete
    Top = 240
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
        Name = 'RCK_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'RCK_CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end>
    Top = 280
    object edtPropertyAMOUNT: TBCDField
      FieldName = 'AMOUNT'
    end
    object edtPropertyCALC_AMOUNT: TBCDField
      FieldName = 'CALC_AMOUNT'
    end
  end
  object cdsHeader: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 176
    Top = 176
  end
  object cdsDetail: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 176
    Top = 208
  end
end
