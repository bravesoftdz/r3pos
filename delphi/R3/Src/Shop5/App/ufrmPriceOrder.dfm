inherited frmPriceOrder: TfrmPriceOrder
  Left = 199
  Top = 106
  Width = 839
  Height = 576
  Caption = #20419#38144#21333
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 831
    Height = 549
    inherited RzPanel2: TRzPanel
      Width = 821
      Height = 84
      TabStop = True
      object lblSTOCK_DATE: TLabel [0]
        Left = 194
        Top = 10
        Width = 48
        Height = 12
        Caption = #20419#38144#26085#26399
      end
      object Label2: TLabel [1]
        Left = 195
        Top = 55
        Width = 48
        Height = 12
        Caption = #22791'    '#27880
      end
      object Label3: TLabel [2]
        Left = 194
        Top = 32
        Width = 48
        Height = 12
        Caption = #26377#25928#26085#26399
      end
      object RzLabel1: TRzLabel [3]
        Left = 462
        Top = 10
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #20419#38144#33539#22260
      end
      object Label19: TLabel [4]
        Left = 637
        Top = 9
        Width = 6
        Height = 12
        Alignment = taRightJustify
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      inherited RzPanel4: TRzPanel
        TabOrder = 7
      end
      object edtREMARK: TcxTextEdit
        Left = 250
        Top = 51
        Width = 191
        Height = 20
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtBEGIN_DATE: TcxDateEdit
        Left = 250
        Top = 6
        Width = 107
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 0
      end
      object edtEND_DATE: TcxDateEdit
        Left = 250
        Top = 28
        Width = 107
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 2
      end
      object edtBEGIN_TIME: TcxTimeEdit
        Left = 360
        Top = 6
        Width = 81
        Height = 20
        EditValue = 0.000000000000000000
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtEND_TIME: TcxTimeEdit
        Left = 360
        Top = 28
        Width = 81
        Height = 20
        EditValue = 0.999988425925926d
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtPRICE_ID: TcxComboBox
        Left = 514
        Top = 6
        Width = 119
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 5
      end
      object Btn_AddShop: TRzBitBtn
        Left = 542
        Top = 46
        Width = 80
        Height = 26
        Caption = #28155#21152#38376#24215
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
        TabOrder = 6
        TabStop = False
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_AddShopClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_BatchPrice: TRzBitBtn
        Left = 461
        Top = 46
        Width = 80
        Height = 26
        Caption = #25209#37327#20419#38144
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
        OnClick = Btn_BatchPriceClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_View: TRzBitBtn
        Left = 623
        Top = 46
        Width = 80
        Height = 26
        Caption = #26597#30475#38376#24215
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
        TabOrder = 9
        TabStop = False
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_ViewClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    inherited RzPanel3: TRzPanel
      Top = 485
      Width = 821
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
      object edtCHK_DATE: TcxTextEdit
        Tag = 1
        Left = 65
        Top = 5
        Width = 105
        Height = 20
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCHK_USER_TEXT: TcxTextEdit
        Tag = 1
        Left = 233
        Top = 6
        Width = 105
        Height = 20
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited DBGridEh1: TDBGridEh
      Top = 122
      Width = 821
      Height = 313
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
          Width = 206
          Control = fndGODS_ID
          OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          ReadOnly = True
          Tag = 1
          Title.Caption = #36135#21495
          Width = 74
        end
        item
          EditButtons = <>
          FieldName = 'NEW_OUTPRICE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #24403#21069#21806#20215
          Width = 58
        end
        item
          EditButtons = <>
          FieldName = 'OUT_PRICE'
          Footers = <>
          Title.Caption = #35745#37327#21333#20301'|'#21806#20215
          Width = 54
          OnUpdateData = DBGridEh1Columns3UpdateData
        end
        item
          EditButtons = <>
          FieldName = 'CALC_UNITS'
          Footers = <>
          ReadOnly = True
          Tag = 1
          Title.Caption = #35745#37327#21333#20301'|'#21333#20301
          Width = 34
        end
        item
          EditButtons = <>
          FieldName = 'OUT_PRICE1'
          Footers = <>
          Title.Caption = #21253#35013'1|'#21806#20215
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'SMALL_UNITS'
          Footers = <>
          ReadOnly = True
          Tag = 1
          Title.Caption = #21253#35013'1|'#21333#20301
          Width = 33
        end
        item
          EditButtons = <>
          FieldName = 'OUT_PRICE2'
          Footers = <>
          Title.Caption = #21253#35013'2|'#21806#20215
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'BIG_UNITS'
          Footers = <>
          ReadOnly = True
          Tag = 1
          Title.Caption = #21253#35013'2|'#21333#20301
          Width = 34
        end
        item
          Checkboxes = False
          EditButtons = <>
          FieldName = 'RATE_OFF'
          Footers = <>
          Title.Caption = #20250#21592'|'#20419#38144
          Width = 56
          OnUpdateData = DBGridEh1Columns10UpdateData
        end
        item
          DisplayFormat = '#0.00%'
          EditButtons = <>
          FieldName = 'AGIO_RATE'
          Footers = <>
          Title.Caption = #20250#21592'|'#20877#25240#29575
          Width = 52
        end
        item
          Alignment = taCenter
          ButtonStyle = cbsEllipsis
          Checkboxes = True
          EditButtons = <>
          FieldName = 'ISINTEGRAL'
          Footers = <>
          KeyList.Strings = (
            '1'
            '0')
          PickList.Strings = (
            #26159
            #21542)
          Title.Caption = #20250#21592'|'#31215#20998
          Width = 35
        end>
    end
    inherited fndGODS_ID: TzrComboBoxList
      Left = 48
      Top = 179
      Buttons = [zbFind]
    end
    inherited pnlBarCode: TRzPanel
      Top = 89
      Width = 821
    end
    inherited stbHint: TRzPanel
      Top = 520
      Width = 821
    end
    inherited rzHelp: TRzPanel
      Top = 435
      Width = 821
      Height = 50
    end
    inherited fndUNIT_ID: TcxComboBox
      Left = 232
      Top = 176
    end
  end
  inherited actList: TActionList
    inherited actLocusNo: TAction
      Visible = False
    end
    inherited actBatchNo: TAction
      Visible = False
    end
    inherited actUnitConvert: TAction
      Visible = False
    end
    inherited actIsPressent: TAction
      Visible = False
    end
  end
  inherited dsTable: TDataSource
    Left = 48
    Top = 208
  end
  inherited PopupMenu1: TPopupMenu
    inherited munDivRow1: TMenuItem
      Visible = False
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
        Name = 'NEW_OUTPRICE'
        DataType = ftFloat
      end
      item
        Name = 'OUT_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'OUT_PRICE1'
        DataType = ftFloat
      end
      item
        Name = 'OUT_PRICE2'
        DataType = ftFloat
      end
      item
        Name = 'CALC_UNITS'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'SMALL_UNITS'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BIG_UNITS'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'RATE_OFF'
        DataType = ftInteger
      end
      item
        Name = 'AGIO_RATE'
        DataType = ftInteger
      end
      item
        Name = 'ISINTEGRAL'
        DataType = ftInteger
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
      end>
    Left = 48
    Top = 248
  end
  inherited edtProperty: TZQuery
    Left = 48
    Top = 288
  end
  object cdsHeader: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 208
    Top = 248
  end
  object cdsDetail: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 208
    Top = 288
  end
  object cdsShopList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 208
    Top = 328
  end
  object CA_RELATIONS: TZQuery
    Tag = 1
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select RELATION_ID,CHANGE_PRICE,SINGLE_LIMIT,SALE_LIMIT,USING_MO' +
        'DULE from CA_RELATIONS where RELATI_ID=:TENANT_ID order by RELAT' +
        'ION_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
end
