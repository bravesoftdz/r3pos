inherited frmVoucherOrder: TfrmVoucherOrder
  Left = 276
  Top = 173
  Width = 854
  Height = 518
  Caption = #31036#21048#20837#24211#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited RzPanel1: TRzPanel
    Width = 846
    Height = 491
    inherited RzPanel2: TRzPanel
      Width = 836
      Height = 106
      object Label3: TLabel [0]
        Left = 31
        Top = 47
        Width = 48
        Height = 12
        Caption = #20837#24211#37096#38376
      end
      object Label40: TLabel [1]
        Left = 31
        Top = 27
        Width = 48
        Height = 12
        Caption = #20837#24211#38376#24215
      end
      object lblSTOCK_DATE: TLabel [2]
        Left = 385
        Top = 7
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #20837#24211#26085#26399
      end
      object Label9: TLabel [3]
        Left = 386
        Top = 47
        Width = 48
        Height = 12
        Caption = #36127' '#36131' '#20154
      end
      object Label1: TLabel [4]
        Left = 33
        Top = 67
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #31036#21048#31867#22411
      end
      object Label7: TLabel [5]
        Left = 31
        Top = 88
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #22791'    '#27880
      end
      object Label4: TLabel [6]
        Left = 31
        Top = 7
        Width = 48
        Height = 12
        Caption = #31036#21048#21517#31216
      end
      object Label5: TLabel [7]
        Left = 385
        Top = 27
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #26377#25928#26085#26399
      end
      object Label8: TLabel [8]
        Left = 224
        Top = 67
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #38754#20540
      end
      inherited RzPanel4: TRzPanel
        Left = 1
        Top = 3
        Width = 0
        TabOrder = 6
        Visible = False
      end
      object edtDEPT_ID: TzrComboBoxList
        Left = 87
        Top = 43
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
        Top = 23
        Width = 288
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
        MultiSelect = False
      end
      object edtINTO_DATE: TcxDateEdit
        Left = 442
        Top = 3
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 4
      end
      object edtINTO_USER: TzrComboBoxList
        Left = 442
        Top = 43
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
      object edtVOUCHER_TYPE: TcxComboBox
        Left = 87
        Top = 63
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 2
      end
      object edtREMARK: TcxTextEdit
        Left = 87
        Top = 83
        Width = 288
        Height = 20
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtVAILD_DATE: TcxDateEdit
        Left = 442
        Top = 23
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 7
      end
      object edtVUCH_NAME: TcxTextEdit
        Left = 87
        Top = 3
        Width = 288
        Height = 20
        TabOrder = 8
      end
      object edtVOUCHER_PRC: TcxTextEdit
        Left = 254
        Top = 63
        Width = 121
        Height = 20
        Properties.OnChange = edtVOUCHER_PRCPropertiesChange
        TabOrder = 9
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    inherited DBGridEh1: TDBGridEh [1]
      Top = 148
      Width = 836
      Height = 266
      PopupMenu = PopupMenu1
      TabOrder = 2
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
          FieldName = 'BARCODE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #31036#21048#38450#20266#30721
          Width = 230
        end
        item
          EditButtons = <>
          FieldName = 'VOUCHER_TYPE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #31036#21048#31867#22411
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'VOUCHER_PRC'
          Footers = <>
          ReadOnly = True
          Title.Caption = #31036#21048#38754#20540
          Width = 70
        end
        item
          DisplayFormat = '0000-00-00'
          EditButtons = <>
          FieldName = 'VAILD_DATE'
          Footers = <>
          ReadOnly = True
          Title.Caption = #26377#25928#26085#26399
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'VOUCHER_STATUS'
          Footers = <>
          ReadOnly = True
          Title.Caption = #31036#21048#29366#24577
          Width = 70
        end>
    end
    inherited stbHint: TRzPanel [2]
      Top = 462
      Width = 836
    end
    inherited rzHelp: TRzPanel [3]
      Top = 414
      Width = 836
    end
    inherited RzPanel3: TRzPanel [4]
      Top = 111
      Width = 836
      Height = 37
      Align = alTop
      BorderOuter = fsFlat
      BorderSides = [sdTop, sdBottom]
      Enabled = True
      TabOrder = 1
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
        OnKeyPress = edtInputKeyPress
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 192
    Top = 264
  end
  inherited actList: TActionList
    Left = 152
    Top = 264
  end
  inherited cdsHeader: TZQuery
    Left = 61
    Top = 189
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 264
    object N1: TMenuItem
      Caption = #21024#38500#31036#21048#35760#24405
      OnClick = N1Click
    end
  end
end
