inherited frmUsersInfo: TfrmUsersInfo
  Left = 534
  Top = 208
  Caption = #29992#25143#26723#26696
  ClientHeight = 411
  ClientWidth = 530
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 530
    Height = 411
    BorderColor = clWhite
    Color = clWhite
    object RzLabel1: TRzLabel [0]
      Left = 233
      Top = 10
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_ACCOUNT: TRzLabel [1]
      Left = 7
      Top = 11
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #29992#25143#36134#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_USER_NAME: TRzLabel [2]
      Left = 7
      Top = 36
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #29992#25143#22995#21517
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_USER_SPELL: TRzLabel [3]
      Left = 240
      Top = 36
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25340#38899#30721
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel7: TRzLabel [4]
      Left = 466
      Top = 35
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_SHOP_ID: TRzLabel [5]
      Left = 240
      Top = 91
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25152#23646#38376#24215
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_DUTY_IDS: TRzLabel [6]
      Left = 7
      Top = 91
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #32844#21153
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel4: TRzLabel [7]
      Left = 233
      Top = 90
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object RzLabel13: TRzLabel [8]
      Left = 7
      Top = 64
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24615#21035
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel [9]
      Left = 233
      Top = 35
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    inherited RzPage: TRzPageControl
      Top = 112
      Width = 520
      Height = 262
      Align = alBottom
      BackgroundColor = clWhite
      ParentBackgroundColor = False
      TabOrder = 6
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        inherited RzPanel2: TRzPanel
          Width = 516
          Height = 235
          BorderColor = clWhite
          Color = clWhite
          object lab_WORK_DATE: TRzLabel
            Left = 1
            Top = 41
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20837#32844#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_REMARK: TRzLabel
            Left = 1
            Top = 166
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22791#27880
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_POSTALCODE: TRzLabel
            Left = 344
            Top = 140
            Width = 52
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#25919#32534#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_OFFI_TELE: TRzLabel
            Left = 1
            Top = 66
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21150#20844#30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_MOBILE: TRzLabel
            Left = 1
            Top = 91
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #31227#21160#30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_FAMI_TELE: TRzLabel
            Left = 234
            Top = 66
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #23478#24237#30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_FAMI_ADDR: TRzLabel
            Left = 1
            Top = 140
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32852#31995#22320#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_EMAIL: TRzLabel
            Left = 1
            Top = 116
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #30005#23376#37038#31665
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_DIMI_DATE: TRzLabel
            Left = 234
            Top = 41
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #31163#32844#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labIDN_TYPE: TRzLabel
            Left = 1
            Top = 16
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #35777#20214#31867#22411
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object LabID_NUMBER: TRzLabel
            Left = 234
            Top = 16
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #35777#20214#21495#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel8: TRzLabel
            Left = 234
            Top = 91
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'QQ'#21495#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Lab_MSN: TRzLabel
            Left = 234
            Top = 116
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'MSN'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtREMARK: TcxMemo
            Left = 106
            Top = 161
            Width = 355
            Height = 68
            TabOrder = 10
          end
          object edtPOSTALCODE: TcxTextEdit
            Left = 400
            Top = 136
            Width = 61
            Height = 20
            TabOrder = 8
          end
          object edtOFFI_TELE: TcxTextEdit
            Left = 106
            Top = 61
            Width = 121
            Height = 20
            TabOrder = 3
          end
          object edtMOBILE: TcxTextEdit
            Left = 106
            Top = 86
            Width = 121
            Height = 20
            TabOrder = 5
          end
          object edtFAMI_TELE: TcxTextEdit
            Left = 340
            Top = 61
            Width = 121
            Height = 20
            TabOrder = 4
          end
          object edtFAMI_ADDR: TcxTextEdit
            Left = 106
            Top = 136
            Width = 237
            Height = 20
            TabOrder = 9
          end
          object edtEMAIL: TcxTextEdit
            Left = 106
            Top = 111
            Width = 121
            Height = 20
            TabOrder = 7
          end
          object edtWORK_DATE: TcxDateEdit
            Left = 106
            Top = 36
            Width = 121
            Height = 20
            TabOrder = 1
          end
          object edtDIMI_DATE: TcxDateEdit
            Left = 340
            Top = 36
            Width = 121
            Height = 20
            TabOrder = 2
          end
          object edtID_NUMBER: TcxTextEdit
            Left = 340
            Top = 11
            Width = 121
            Height = 20
            Properties.OnChange = edt_USER_NAMEPropertiesChange
            TabOrder = 0
          end
          object edtQQ: TcxTextEdit
            Left = 340
            Top = 86
            Width = 121
            Height = 20
            Properties.OnChange = edt_USER_NAMEPropertiesChange
            TabOrder = 6
          end
          object edtMSN: TcxTextEdit
            Left = 340
            Top = 111
            Width = 121
            Height = 20
            Properties.OnChange = edt_USER_NAMEPropertiesChange
            TabOrder = 11
          end
          object edtIDN_TYPE: TzrComboBoxList
            Left = 106
            Top = 11
            Width = 121
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 12
            InGrid = False
            KeyValue = Null
            FilterFields = 'DUTY_NAME;DUTY_ID;DUTY_SPELL'
            KeyField = 'DUTY_ID'
            ListField = 'DUTY_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'DUTY_ID'
                Footers = <>
                Title.Caption = #20195#30721
                Width = 30
              end
              item
                EditButtons = <>
                FieldName = 'DUTY_NAME'
                Footers = <>
                Title.Caption = #32844#21153#21517#31216
                Width = 90
              end
              item
                EditButtons = <>
                FieldName = 'DUTY_SPELL'
                Footers = <>
                Visible = False
              end>
            DropWidth = 130
            DropHeight = 200
            ShowTitle = True
            AutoFitColWidth = False
            OnAddClick = edtDUTY_IDSAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 374
      Width = 520
      Height = 32
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 7
      object Btn_Save: TRzBitBtn
        Left = 331
        Top = 5
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Close: TRzBitBtn
        Left = 438
        Top = 5
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20851#38381'(&C)'
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
        TabOrder = 1
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object edtACCOUNT: TcxTextEdit
      Left = 113
      Top = 6
      Width = 121
      Height = 20
      TabOrder = 0
    end
    object edtUSER_NAME: TcxTextEdit
      Left = 113
      Top = 31
      Width = 121
      Height = 20
      Properties.OnChange = edt_USER_NAMEPropertiesChange
      TabOrder = 1
    end
    object edtUSER_SPELL: TcxTextEdit
      Left = 346
      Top = 31
      Width = 121
      Height = 20
      TabOrder = 2
    end
    object edtSHOP_ID: TzrComboBoxList
      Left = 346
      Top = 86
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
      FilterFields = 'COMP_NAME;COMP_ID;COMP_SPELL'
      KeyField = 'SHOP_ID'
      ListField = 'SHOP_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SHOP_ID'
          Footers = <>
          Title.Caption = #20195#30721
          Width = 30
        end
        item
          EditButtons = <>
          FieldName = 'SHOP_NAME'
          Footers = <>
          Title.Caption = #38376#24215#21517#31216
          Width = 90
        end
        item
          EditButtons = <>
          FieldName = 'SHOP_SEPLL'
          Footers = <>
          Visible = False
        end>
      DropWidth = 130
      DropHeight = 200
      ShowTitle = True
      AutoFitColWidth = False
      ShowButton = True
      LocateStyle = lsDark
      Buttons = []
      DropListStyle = lsFixed
    end
    object edtDUTY_IDS: TzrComboBoxList
      Left = 113
      Top = 86
      Width = 121
      Height = 20
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = True
      TabOrder = 4
      InGrid = False
      KeyValue = Null
      FilterFields = 'DUTY_NAME;DUTY_ID;DUTY_SPELL'
      KeyField = 'DUTY_ID'
      ListField = 'DUTY_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'DUTY_ID'
          Footers = <>
          Title.Caption = #20195#30721
          Width = 30
        end
        item
          EditButtons = <>
          FieldName = 'DUTY_NAME'
          Footers = <>
          Title.Caption = #32844#21153#21517#31216
          Width = 90
        end
        item
          EditButtons = <>
          FieldName = 'DUTY_SPELL'
          Footers = <>
          Visible = False
        end>
      DropWidth = 130
      DropHeight = 200
      ShowTitle = True
      AutoFitColWidth = False
      OnAddClick = edtDUTY_IDSAddClick
      ShowButton = True
      LocateStyle = lsDark
      Buttons = [zbNew]
      DropListStyle = lsFixed
    end
    object edtSEX: TRadioGroup
      Left = 114
      Top = 50
      Width = 150
      Height = 33
      Columns = 3
      Items.Strings = (
        #22899
        #30007
        #20445#23494)
      TabOrder = 3
    end
  end
  inherited mmMenu: TMainMenu
    Left = 488
    Top = 208
  end
  inherited actList: TActionList
    Left = 488
    Top = 240
  end
  object ADODataSet1: TZQuery
    Params = <>
    Left = 488
    Top = 280
  end
  object cdsTable: TZQuery
    Params = <>
    Left = 486
    Top = 168
  end
end
