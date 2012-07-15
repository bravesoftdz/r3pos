inherited frmSvcServiceInfo: TfrmSvcServiceInfo
  Left = 402
  Top = 213
  Caption = #21806#21518#26381#21153
  ClientHeight = 343
  ClientWidth = 529
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 529
    Height = 343
    BorderColor = clWhite
    Color = clWhite
    object lab_CLIENT_ID: TRzLabel [0]
      Left = 7
      Top = 14
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #23458#25143#21517#31216
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_GODS_NAME: TRzLabel [1]
      Left = 7
      Top = 40
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #21830#21697#21517#31216
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_CLIENT_CODE: TRzLabel [2]
      Left = 240
      Top = 14
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #23458#25143#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel [3]
      Left = 287
      Top = 14
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
    object lab_SERIAL_NO: TRzLabel [4]
      Left = 7
      Top = 65
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24207#21015#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel1: TRzLabel [5]
      Left = 355
      Top = 65
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
    object RzLabel3: TRzLabel [6]
      Left = 355
      Top = 40
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
      Top = 89
      Width = 519
      Height = 217
      Align = alBottom
      BackgroundColor = clWhite
      ParentBackgroundColor = False
      TabOrder = 4
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #21463#29702#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 515
          Height = 190
          BorderColor = clWhite
          Color = clWhite
          object lab_PROB_DESC: TRzLabel
            Left = 1
            Top = 65
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #38382#39064#25551#36848
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_RECV_USER: TRzLabel
            Left = 1
            Top = 164
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21463#29702#20154#21592
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_RECV_DATE: TRzLabel
            Left = 235
            Top = 139
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21463#29702#26102#38388
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_RECV_CLASS: TRzLabel
            Left = 1
            Top = 139
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21463#29702#31867#22411
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_LINKMAN: TRzLabel
            Left = 1
            Top = 15
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
          object lab_TELEPHONE: TRzLabel
            Left = 234
            Top = 15
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32852#31995#30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_ADDRESS: TRzLabel
            Left = 1
            Top = 39
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #23458#25143#22320#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtPROB_DESC: TcxMemo
            Left = 106
            Top = 61
            Width = 355
            Height = 68
            Properties.MaxLength = 200
            TabOrder = 3
          end
          object edtRECV_DATE: TcxDateEdit
            Left = 340
            Top = 135
            Width = 121
            Height = 20
            TabOrder = 4
          end
          object edtLINKMAN: TcxTextEdit
            Left = 106
            Top = 11
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 0
          end
          object edtTELEPHONE: TcxTextEdit
            Left = 340
            Top = 11
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 1
          end
          object edtADDRESS: TcxTextEdit
            Left = 106
            Top = 35
            Width = 355
            Height = 20
            Properties.MaxLength = 120
            TabOrder = 2
          end
          object edtRECV_USER: TzrComboBoxList
            Left = 106
            Top = 160
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
            Buttons = [zbNew]
            DropListStyle = lsFixed
            MultiSelect = False
          end
          object edtRECV_CLASS: TzrComboBoxList
            Left = 106
            Top = 135
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
                Width = 100
              end>
            DataSet = cdsRecvClass
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            OnAddClick = edtRECV_CLASSAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew, zbClear]
            DropListStyle = lsFixed
            MultiSelect = False
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Color = clWhite
        Caption = #22788#29702#20449#24687
        object RzPanel1: TRzPanel
          Left = 0
          Top = 0
          Width = 515
          Height = 190
          Align = alClient
          BorderOuter = fsNone
          BorderColor = clWhite
          Color = clWhite
          TabOrder = 0
          object lab_SATI_DEGR: TRzLabel
            Left = 49
            Top = 165
            Width = 52
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26381#21153#36136#37327
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_FEE_FLAG: TRzLabel
            Left = 1
            Top = 68
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26159#21542#25910#36153
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_SRVR_DATE: TRzLabel
            Left = 235
            Top = 41
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22788#29702#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_SRVR_CLASS: TRzLabel
            Left = 1
            Top = 16
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26381#21153#26041#24335
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_SRVR_USER: TRzLabel
            Left = 1
            Top = 41
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25351#27966#20154#21592
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_SRVR_DESC: TRzLabel
            Left = 1
            Top = 93
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22788#29702#25551#36848
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_FEE_MNY: TRzLabel
            Left = 283
            Top = 68
            Width = 52
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36153#29992#37329#39069
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtFEE_MNY: TcxTextEdit
            Left = 340
            Top = 64
            Width = 121
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 3
          end
          object edtSRVR_USER: TzrComboBoxList
            Left = 106
            Top = 37
            Width = 121
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 0
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
          object edtSRVR_DATE: TcxDateEdit
            Left = 340
            Top = 37
            Width = 121
            Height = 20
            TabOrder = 1
          end
          object edtSRVR_DESC: TcxMemo
            Left = 106
            Top = 89
            Width = 355
            Height = 68
            Properties.MaxLength = 200
            TabOrder = 4
          end
          object edtFEE_FLAG: TRadioGroup
            Left = 107
            Top = 56
            Width = 120
            Height = 33
            Columns = 2
            Items.Strings = (
              #21542
              #26159)
            TabOrder = 2
            TabStop = True
            OnClick = edtFEE_FLAGClick
          end
          object edtSRVR_CLASS: TzrComboBoxList
            Left = 106
            Top = 12
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
            FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
            KeyField = 'CODE_ID'
            ListField = 'CODE_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'CODE_NAME'
                Footers = <>
                Title.Caption = #21517#31216
                Width = 100
              end>
            DataSet = cdsSrvrClass
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            OnAddClick = edtSRVR_CLASSAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew, zbClear]
            DropListStyle = lsFixed
            MultiSelect = False
          end
          object edtSATI_DEGR: TzrComboBoxList
            Left = 106
            Top = 161
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
                Width = 100
              end>
            DataSet = cdsSatiDegr
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            OnAddClick = edtSATI_DEGRAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew, zbClear]
            DropListStyle = lsFixed
            MultiSelect = False
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 306
      Width = 519
      Height = 32
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 5
      object Btn_Save: TRzBitBtn
        Left = 360
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
        Left = 450
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
    object edtGODS_NAME: TcxTextEdit
      Left = 113
      Top = 36
      Width = 240
      Height = 20
      Properties.MaxLength = 50
      TabOrder = 2
    end
    object edtCLIENT_CODE: TcxTextEdit
      Left = 346
      Top = 10
      Width = 103
      Height = 20
      Properties.MaxLength = 30
      TabOrder = 1
    end
    object edtCLIENT_ID: TzrComboBoxList
      Left = 113
      Top = 10
      Width = 172
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
      FilterFields = 'CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
      KeyField = 'CLIENT_ID'
      ListField = 'CLIENT_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'CLIENT_CODE'
          Footers = <>
          Title.Caption = #20195#30721
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
      DropWidth = 296
      DropHeight = 220
      ShowTitle = True
      AutoFitColWidth = False
      ShowButton = True
      LocateStyle = lsDark
      Buttons = [zbClear]
      DropListStyle = lsFixed
      OnSaveValue = edtCLIENT_IDSaveValue
      MultiSelect = False
    end
    object edtSERIAL_NO: TcxTextEdit
      Left = 113
      Top = 61
      Width = 240
      Height = 20
      Properties.MaxLength = 50
      TabOrder = 3
    end
    object BtnUserInfo: TRzBitBtn
      Left = 448
      Top = 9
      Width = 27
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '...'
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
      TextStyle = tsRaised
      ThemeAware = False
      OnClick = BtnUserInfoClick
      NumGlyphs = 2
      Spacing = 5
    end
  end
  inherited mmMenu: TMainMenu
    Left = 489
    Top = 194
  end
  inherited actList: TActionList
    Left = 489
    Top = 226
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 489
    Top = 163
  end
  object cdsRecvClass: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where COD' +
        'E_TYPE='#39'20'#39' and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <>
    Left = 30
    Top = 313
  end
  object cdsSrvrClass: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where COD' +
        'E_TYPE='#39'21'#39' and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <>
    Left = 237
    Top = 117
  end
  object cdsSatiDegr: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where COD' +
        'E_TYPE='#39'22'#39' and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <>
    Left = 238
    Top = 265
  end
end
