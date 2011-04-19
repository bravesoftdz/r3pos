inherited frmBomOrder: TfrmBomOrder
  Left = 202
  Top = 233
  Width = 846
  Height = 522
  Caption = #31036#30418#21253#35013
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 830
    Height = 484
    inherited RzPanel2: TRzPanel
      Width = 820
      Height = 119
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 563
        Top = 9
        Width = 48
        Height = 12
        Caption = #21253#35013#26085#26399
      end
      object lblCLIENT_ID: TLabel [1]
        Left = 194
        Top = 9
        Width = 48
        Height = 12
        Caption = #31036#30418#32534#21495
      end
      object Label2: TLabel [2]
        Left = 194
        Top = 51
        Width = 48
        Height = 12
        Caption = #26465' '#22411' '#30721
      end
      object Label5: TLabel [3]
        Left = 563
        Top = 30
        Width = 48
        Height = 12
        Caption = #32463' '#25163' '#20154
      end
      object Label3: TLabel [4]
        Left = 194
        Top = 30
        Width = 48
        Height = 12
        Caption = #31036#30418#21517#31216
      end
      object Label1: TLabel [5]
        Left = 194
        Top = 93
        Width = 48
        Height = 12
        Caption = #22791'    '#27880
      end
      object Label8: TLabel [6]
        Left = 568
        Top = 51
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#26085#26399
      end
      object Label9: TLabel [7]
        Left = 568
        Top = 72
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #23457#26680#29992#25143
      end
      inherited RzPanel4: TRzPanel
        Top = 5
        Height = 76
        TabOrder = 2
        inherited Image1: TImage
          Left = 103
          Top = 31
        end
        inherited lblState: TLabel
          Top = 43
        end
      end
      object edtBOM_DATE: TcxDateEdit
        Left = 623
        Top = 5
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 1
      end
      object edtBARCODE: TcxTextEdit
        Left = 250
        Top = 47
        Width = 151
        Height = 20
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtGIFT_CODE: TcxTextEdit
        Left = 250
        Top = 5
        Width = 111
        Height = 20
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtGIFT_NAME: TcxTextEdit
        Left = 250
        Top = 26
        Width = 287
        Height = 20
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtBOM_USER: TzrComboBoxList
        Left = 623
        Top = 26
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
        OnAddClick = edtBOM_USERAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtREMARK: TcxTextEdit
        Left = 250
        Top = 89
        Width = 287
        Height = 20
        TabOrder = 6
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 623
        Top = 47
        Width = 121
        Height = 20
        TabOrder = 7
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 623
        Top = 68
        Width = 121
        Height = 20
        TabOrder = 8
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 403
      Width = 820
      Height = 33
      TabOrder = 2
      object Label13: TLabel
        Left = 547
        Top = 7
        Width = 39
        Height = 12
        Caption = #38646#21806#20215
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtRTL_PRICE: TcxTextEdit
        Left = 594
        Top = -1
        Width = 111
        Height = 20
        ParentFont = False
        Style.Font.Charset = GB2312_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -12
        Style.Font.Name = #23435#20307
        Style.Font.Style = [fsBold]
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 158
      Width = 820
      Height = 245
      TabOrder = 3
      OnCellClick = DBGridEh1CellClick
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
          Width = 153
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = #36135#21495
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
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
          Width = 53
          OnEditButtonClick = DBGridEh1Columns4EditButtonClick
          OnUpdateData = DBGridEh1Columns4UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'ORG_PRICE'
          Footers = <>
          Title.Caption = #21407#21806#20215
        end
        item
          EditButtons = <>
          FieldName = 'APRICE'
          Footers = <>
          Title.Caption = #31036#30418#20215
          Width = 63
          OnUpdateData = DBGridEh1Columns5UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #38144#21806#37329#39069
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
            #26159
            #21542)
          ReadOnly = True
          Title.Caption = #36192#21697
          Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#36192#21697#36716#25442
          Width = 39
          OnUpdateData = DBGridEh1Columns7UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25209#21495
          Width = 86
        end
        item
          EditButtons = <>
          FieldName = 'REMARK'
          Footers = <>
          Title.Caption = #22791#27880
          Width = 157
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 536
      Top = 179
    end
    inherited pnlBarCode: TRzPanel
      Top = 124
      Width = 820
      Height = 34
    end
    inherited stbHint: TRzPanel
      Top = 436
      Width = 820
    end
    inherited rzHelp: TRzPanel
      Top = 460
      Width = 820
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
      Caption = #25171#21360#26465#30721
      OnExecute = actPrintBarcodeExecute
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem [2]
      Action = actPrintBarcode
    end
    object N2: TMenuItem [10]
      Caption = '-'
    end
    object N3: TMenuItem [11]
      Caption = #25972#21333#20837#24211
      OnClick = N3Click
    end
    object N4: TMenuItem [12]
      Caption = #21333#31508#20837#24211
      OnClick = N4Click
    end
  end
  inherited edtTable: TZQuery
    FieldDefs = <>
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
