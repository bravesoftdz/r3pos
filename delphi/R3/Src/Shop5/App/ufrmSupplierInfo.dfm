inherited frmSupplierInfo: TfrmSupplierInfo
  Left = 410
  Caption = #20379#24212#21830#26723#26696
  ClientHeight = 374
  ClientWidth = 528
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 528
    Height = 374
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 121
      Width = 518
      Height = 208
      Color = clWhite
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #27880#20876#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 514
          Height = 181
          Align = alNone
          BorderColor = clWhite
          Color = clWhite
          object RzLabel21: TRzLabel
            Left = -9
            Top = 31
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #27861#20154#20195#34920
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel24: TRzLabel
            Left = -9
            Top = 8
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20844#21496#20840#31216
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel31: TRzLabel
            Left = 264
            Top = 100
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #31246#21153#30331#35760#35777#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel32: TRzLabel
            Left = 264
            Top = 31
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #27880#20876#30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labADDRESS: TRzLabel
            Left = -9
            Top = 123
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel9: TRzLabel
            Left = -9
            Top = 78
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24320#25143#38134#34892
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel10: TRzLabel
            Left = -9
            Top = 101
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36134#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel3: TRzLabel
            Left = 264
            Top = 55
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21457#31080#31867#22411
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labHOMEPAGE: TRzLabel
            Left = -10
            Top = 145
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
          object RzLabel15: TRzLabel
            Left = 264
            Top = 78
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36827#39033#31246#29575
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel23: TRzLabel
            Left = -11
            Top = 55
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32463#33829#35768#21487#35777
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtLEGAL_REPR: TcxTextEdit
            Left = 96
            Top = 28
            Width = 121
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 1
          end
          object edtINVO_NAME: TcxTextEdit
            Left = 96
            Top = 5
            Width = 241
            Height = 20
            Properties.MaxLength = 60
            TabOrder = 0
          end
          object edtTAX_NO: TcxTextEdit
            Left = 369
            Top = 97
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 8
          end
          object edtTELEPHONE3: TcxTextEdit
            Left = 369
            Top = 28
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 5
          end
          object edtADDRESS: TcxTextEdit
            Left = 96
            Top = 120
            Width = 395
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 9
            OnKeyDown = edtADDRESSKeyDown
          end
          object edtACCOUNT: TcxTextEdit
            Left = 96
            Top = 97
            Width = 170
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 4
          end
          object edtBANK_ID: TcxComboBox
            Left = 96
            Top = 74
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 3
          end
          object edtINVOICE_FLAG: TcxComboBox
            Left = 369
            Top = 51
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 6
          end
          object edtREMARK: TcxMemo
            Left = 96
            Top = 143
            Width = 395
            Height = 32
            Properties.MaxLength = 200
            TabOrder = 10
          end
          object edtTAX_RATE: TcxTextEdit
            Left = 369
            Top = 74
            Width = 121
            Height = 20
            TabOrder = 7
          end
          object edtLICENSE_CODE: TcxTextEdit
            Left = 96
            Top = 51
            Width = 121
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 2
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Color = clWhite
        Caption = #32852#31995#20449#24687
        object RzPanel3: TRzPanel
          Left = 0
          Top = 0
          Width = 514
          Height = 181
          Align = alClient
          BorderOuter = fsNone
          BorderColor = clWhite
          Color = clWhite
          TabOrder = 0
          object labLINKMAN: TRzLabel
            Left = -10
            Top = 31
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32852#31995#20154
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labTELEPHONE1: TRzLabel
            Left = -10
            Top = 97
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labFAXES: TRzLabel
            Left = -10
            Top = 65
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20256#30495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labEMAIL: TRzLabel
            Left = 264
            Top = 97
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #30005#23376#37038#20214
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labTELEPHONE2: TRzLabel
            Left = 264
            Top = 33
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'QQ'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel5: TRzLabel
            Left = -10
            Top = 129
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25163#26426
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labMSN: TRzLabel
            Left = 264
            Top = 65
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
          object RzLabel12: TRzLabel
            Left = 264
            Top = 128
            Width = 99
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32593#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtLINKMAN: TcxTextEdit
            Left = 97
            Top = 28
            Width = 121
            Height = 20
            Properties.MaxLength = 10
            TabOrder = 0
          end
          object edtTELEPHONE1: TcxTextEdit
            Left = 97
            Top = 93
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 2
          end
          object edtFAXES: TcxTextEdit
            Left = 97
            Top = 61
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 1
          end
          object edtEMAIL: TcxTextEdit
            Left = 371
            Top = 93
            Width = 121
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 6
          end
          object edtQQ: TcxTextEdit
            Left = 371
            Top = 29
            Width = 121
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 4
          end
          object edtTELEPHONE2: TcxTextEdit
            Left = 97
            Top = 125
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 3
          end
          object edtMSN: TcxTextEdit
            Left = 371
            Top = 61
            Width = 121
            Height = 20
            Properties.MaxLength = 35
            TabOrder = 5
          end
          object edtHOMEPAGE: TcxTextEdit
            Left = 371
            Top = 125
            Width = 121
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 7
          end
        end
      end
      object TabSheet3: TRzTabSheet
        Color = clWhite
        Caption = #25910#21457#20449#24687
        object RzPanel4: TRzPanel
          Left = 0
          Top = 0
          Width = 514
          Height = 181
          Align = alClient
          BorderOuter = fsNone
          Color = clWhite
          TabOrder = 0
          object RzLabel25: TRzLabel
            Left = -10
            Top = 45
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#23492#20154
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel26: TRzLabel
            Left = -10
            Top = 19
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#23492#22320#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel27: TRzLabel
            Left = -11
            Top = 152
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25910#36135#20154#25163#26426
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel28: TRzLabel
            Left = -10
            Top = 70
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#23492#20154#25163#26426
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel29: TRzLabel
            Left = -11
            Top = 125
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25910#36135#20154
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel30: TRzLabel
            Left = -11
            Top = 98
            Width = 99
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25910#36135#22320#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labPOSTALCODE: TRzLabel
            Left = 264
            Top = 45
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#23492#32534#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtSEND_LINKMAN: TcxTextEdit
            Left = 97
            Top = 41
            Width = 121
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 1
          end
          object edtSEND_ADDR: TcxTextEdit
            Left = 97
            Top = 15
            Width = 395
            Height = 20
            Properties.MaxLength = 100
            TabOrder = 0
          end
          object edtRECV_TELE: TcxTextEdit
            Left = 96
            Top = 148
            Width = 121
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 6
          end
          object edtSEND_TELE: TcxTextEdit
            Left = 97
            Top = 66
            Width = 121
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 2
          end
          object edtRECV_LINKMAN: TcxTextEdit
            Left = 96
            Top = 121
            Width = 121
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 5
          end
          object edtRECV_ADDR: TcxTextEdit
            Left = 96
            Top = 95
            Width = 395
            Height = 20
            Properties.MaxLength = 100
            TabOrder = 4
          end
          object edtPOSTALCODE: TcxTextEdit
            Left = 371
            Top = 41
            Width = 121
            Height = 20
            Properties.MaxLength = 6
            TabOrder = 3
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 329
      Width = 518
      BorderColor = clWhite
      Color = clWhite
      object Btn_Save: TRzBitBtn
        Left = 335
        Top = 9
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
        Left = 434
        Top = 9
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
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 518
      Height = 116
      Align = alTop
      BorderOuter = fsNone
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 2
      object labCLIENT_NAME: TRzLabel
        Left = -10
        Top = 33
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20379#24212#21830#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object labCLIENT_SPELL: TRzLabel
        Left = 265
        Top = 33
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
      object RzLabel6: TRzLabel
        Left = -10
        Top = 57
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20379#24212#21830#20998#31867
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel13: TRzLabel
        Left = 258
        Top = 34
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
      object RzLabel7: TRzLabel
        Left = 265
        Top = 57
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #22320#21306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel2: TRzLabel
        Left = 493
        Top = 57
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
      object RzLabel14: TRzLabel
        Left = 219
        Top = 58
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
      object RzLabel1: TRzLabel
        Left = -10
        Top = 9
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20379#24212#21830#32534#21495
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel11: TRzLabel
        Left = 219
        Top = 9
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
      object labSHOP_ID: TRzLabel
        Left = 264
        Top = 9
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
      object RzLabel8: TRzLabel
        Left = -9
        Top = 83
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #32467#31639#26041#24335
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel22: TRzLabel
        Left = 219
        Top = 83
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
      object RzLabel4: TRzLabel
        Left = 493
        Top = 34
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
      object edtCLIENT_NAME: TcxTextEdit
        Left = 97
        Top = 30
        Width = 160
        Height = 20
        Properties.MaxLength = 50
        Properties.OnChange = edtCLIENT_NAMEPropertiesChange
        TabOrder = 1
      end
      object edtCLIENT_SPELL: TcxTextEdit
        Left = 371
        Top = 30
        Width = 121
        Height = 20
        TabStop = False
        Properties.MaxLength = 50
        TabOrder = 4
      end
      object edtSORT_ID: TzrComboBoxList
        Left = 97
        Top = 54
        Width = 121
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
        FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #23610#30721#32452
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'CODE_SPELL'
            Footers = <>
            Visible = False
          end>
        DropWidth = 176
        DropHeight = 130
        ShowTitle = False
        AutoFitColWidth = True
        OnAddClick = edtSORT_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtSORT_IDSaveValue
        MultiSelect = False
      end
      object edtREGION_ID: TzrComboBoxList
        Left = 371
        Top = 54
        Width = 121
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
        FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #21517#31216
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'CODE_ID'
            Footers = <>
            Title.Caption = #32534#30721
            Width = 50
          end>
        DropWidth = 200
        DropHeight = 160
        ShowTitle = True
        AutoFitColWidth = True
        OnAddClick = edtREGION_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtCLIENT_CODE: TcxTextEdit
        Left = 97
        Top = 6
        Width = 121
        Height = 20
        Properties.MaxLength = 20
        Properties.OnChange = edtCLIENT_NAMEPropertiesChange
        TabOrder = 0
      end
      object edtSHOP_ID: TzrComboBoxList
        Left = 371
        Top = 6
        Width = 121
        Height = 20
        Enabled = False
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 5
        InGrid = False
        KeyValue = Null
        FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
        KeyField = 'SHOP_ID'
        ListField = 'SHOP_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #23610#30721#32452
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'CODE_SPELL'
            Footers = <>
            Visible = False
          end>
        DropWidth = 176
        DropHeight = 130
        ShowTitle = False
        AutoFitColWidth = True
        OnAddClick = edtSORT_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtSORT_IDSaveValue
        MultiSelect = False
      end
      object edtSETTLE_CODE: TzrComboBoxList
        Left = 97
        Top = 79
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
        FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #21517#31216
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'CODE_SPELL'
            Footers = <>
            Title.Caption = #32534#30721
            Width = 40
          end>
        DropWidth = 176
        DropHeight = 130
        ShowTitle = True
        AutoFitColWidth = True
        OnAddClick = edtSETTLE_CODEAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 453
    Top = 115
  end
  inherited actList: TActionList
    Left = 493
    Top = 115
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 412
    Top = 115
  end
end
