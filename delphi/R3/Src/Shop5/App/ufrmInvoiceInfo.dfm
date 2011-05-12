inherited frmInvoiceInfo: TfrmInvoiceInfo
  Left = 483
  Top = 240
  Caption = #21457#31080#20449#24687
  ClientHeight = 324
  ClientWidth = 504
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 504
    Height = 324
    BorderColor = clWhite
    Color = clWhite
    object labINVH_NO: TRzLabel [0]
      Left = 7
      Top = 17
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #21457#31080#26412#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object labCREA_DATE: TRzLabel [1]
      Left = 242
      Top = 18
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #39046#29992#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_SHOP_ID: TRzLabel [2]
      Left = 241
      Top = 44
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #39046#29992#38376#24215
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel [3]
      Left = 235
      Top = 17
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
    object RzLabel3: TRzLabel [4]
      Left = 470
      Top = 44
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
    object RzLabel6: TRzLabel [5]
      Left = 241
      Top = 71
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #39046#29992#20154
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel9: TRzLabel [6]
      Left = 470
      Top = 71
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
    object RzLabel1: TRzLabel [7]
      Left = 470
      Top = 17
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
    object RzLabel4: TRzLabel [8]
      Left = 7
      Top = 71
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #21457#31080#32456#27490#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel5: TRzLabel [9]
      Left = 235
      Top = 71
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
    object RzLabel7: TRzLabel [10]
      Left = 7
      Top = 44
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #21457#31080#36215#22987#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel8: TRzLabel [11]
      Left = 235
      Top = 44
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
      Top = 102
      Width = 494
      Height = 177
      Align = alBottom
      BackgroundColor = clWhite
      ParentBackgroundColor = False
      TabOrder = 6
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        inherited RzPanel2: TRzPanel
          Width = 490
          Height = 150
          BorderColor = clWhite
          Color = clWhite
          object lab_REMARK: TRzLabel
            Left = 1
            Top = 64
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
          object LabID_NUMBER: TRzLabel
            Left = 1
            Top = 15
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21512#35745#24352#25968
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel10: TRzLabel
            Left = 235
            Top = 15
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20316#24223#24352#25968
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel11: TRzLabel
            Left = 235
            Top = 41
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32467#20313#24352#25968
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel12: TRzLabel
            Left = 1
            Top = 41
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24320#31080#24352#25968
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtREMARK: TcxMemo
            Left = 106
            Top = 64
            Width = 355
            Height = 73
            TabOrder = 4
          end
          object edtTOTAL_AMT: TcxTextEdit
            Left = 106
            Top = 10
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 0
          end
          object edtCANCEL_AMT: TcxTextEdit
            Left = 340
            Top = 10
            Width = 121
            Height = 20
            Properties.OnChange = edtCANCEL_AMTPropertiesChange
            TabOrder = 2
          end
          object edtBALANCE: TcxTextEdit
            Left = 340
            Top = 36
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 3
          end
          object edtUSING_AMT: TcxTextEdit
            Left = 106
            Top = 36
            Width = 121
            Height = 20
            Properties.OnChange = edtUSING_AMTPropertiesChange
            TabOrder = 1
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 279
      Width = 494
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 7
      object Btn_Save: TRzBitBtn
        Left = 340
        Top = 10
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
        Left = 426
        Top = 10
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
    object edtINVH_NO: TcxTextEdit
      Left = 113
      Top = 13
      Width = 121
      Height = 20
      Properties.MaxLength = 50
      TabOrder = 0
    end
    object edtSHOP_ID: TzrComboBoxList
      Left = 347
      Top = 40
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
      FilterFields = 'SHOP_NAME;SHOP_ID;SHOP_SPELL'
      KeyField = 'SHOP_ID'
      ListField = 'SHOP_NAME'
      Columns = <
        item
          AutoDropDown = True
          EditButtons = <>
          FieldName = 'SHOP_NAME'
          Footers = <>
          Title.Caption = #38376#24215#21517#31216
          Width = 120
        end
        item
          EditButtons = <>
          FieldName = 'SEQ_NO'
          Footers = <>
          Title.Caption = #24207#21495
          Width = 30
        end>
      DropWidth = 151
      DropHeight = 130
      ShowTitle = True
      AutoFitColWidth = True
      OnAddClick = edtSHOP_IDAddClick
      ShowButton = True
      LocateStyle = lsDark
      Buttons = [zbNew]
      DropListStyle = lsFixed
      MultiSelect = False
    end
    object edtCREA_USER: TzrComboBoxList
      Left = 347
      Top = 67
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
      FilterFields = 'USER_ID;USER_NAME;USER_SPELL'
      KeyField = 'USER_ID'
      ListField = 'USER_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'ACCOUNT'
          Footers = <>
          Title.Caption = #36134#21495
          Width = 70
        end
        item
          AutoDropDown = True
          EditButtons = <>
          FieldName = 'USER_NAME'
          Footers = <>
          Title.Caption = #21517'  '#31216
          Width = 80
        end>
      DropWidth = 151
      DropHeight = 130
      ShowTitle = True
      AutoFitColWidth = True
      ShowButton = True
      LocateStyle = lsDark
      Buttons = []
      DropListStyle = lsFixed
      MultiSelect = False
    end
    object edtENDED_NO: TcxTextEdit
      Left = 113
      Top = 67
      Width = 121
      Height = 20
      Properties.OnChange = edtENDED_NOPropertiesChange
      TabOrder = 2
    end
    object edtBEGIN_NO: TcxTextEdit
      Left = 113
      Top = 40
      Width = 121
      Height = 20
      Properties.OnChange = edtBEGIN_NOPropertiesChange
      TabOrder = 1
    end
    object edtCREA_DATE: TcxDateEdit
      Left = 347
      Top = 13
      Width = 121
      Height = 20
      TabOrder = 3
    end
  end
  inherited mmMenu: TMainMenu
    Left = 488
    Top = 150
  end
  inherited actList: TActionList
    Left = 488
    Top = 182
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 488
    Top = 222
  end
end
