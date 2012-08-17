inherited frmFilterUser: TfrmFilterUser
  Left = 595
  Top = 234
  Caption = #29992#25143#20449#24687#26597#35810
  ClientHeight = 282
  ClientWidth = 259
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 259
    Height = 282
    inherited RzPage: TRzPageControl
      Width = 249
      Height = 232
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        inherited RzPanel2: TRzPanel
          Width = 245
          Height = 228
          object Bevel1: TBevel
            Left = 4
            Top = 39
            Width = 237
            Height = 2
          end
          object lab_CLIENT_CODE: TRzLabel
            Left = 18
            Top = 15
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #29992#25143#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel1: TRzLabel
            Left = 18
            Top = 52
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #34892#25919#21306
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel2: TRzLabel
            Left = 18
            Top = 77
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #36947'  '#36335
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel3: TRzLabel
            Left = 18
            Top = 102
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #31038'  '#21306
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel4: TRzLabel
            Left = 18
            Top = 127
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #27004'  '#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_LINKMAN: TRzLabel
            Left = 17
            Top = 184
            Width = 42
            Height = 12
            Caption = #32852#31995#20154':'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_TELEPHONE: TRzLabel
            Left = 5
            Top = 207
            Width = 54
            Height = 12
            Caption = #32852#31995#30005#35805':'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Bevel2: TBevel
            Left = 5
            Top = 173
            Width = 237
            Height = 2
          end
          object RzLabel5: TRzLabel
            Left = 18
            Top = 151
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #25151'  '#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtCLIENT_CODE: TcxTextEdit
            Left = 63
            Top = 11
            Width = 160
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 0
            OnKeyPress = edtCLIENT_CODEKeyPress
          end
          object fndCODE_NAME: TzrComboBoxList
            Left = 63
            Top = 48
            Width = 160
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
            FilterFields = 'YQBM_YQDZ_ID;YQBM_YQDZ_MS'
            KeyField = 'YQBM_YQDZ_ID'
            ListField = 'YQBM_YQDZ_MS'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'YQBM_YQDZ_MS'
                Footers = <>
                Title.Caption = #21517#31216
                Width = 100
              end>
            DataSet = cdsCODE_NAME
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnSaveValue = fndCODE_NAMESaveValue
            MultiSelect = False
          end
          object fndROAD_NAME: TzrComboBoxList
            Left = 63
            Top = 73
            Width = 160
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
            FilterFields = 'YQBM_YQDZ_ID;YQBM_YQDZ_MS'
            KeyField = 'YQBM_YQDZ_ID'
            ListField = 'YQBM_YQDZ_MS'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'YQBM_YQDZ_MS'
                Footers = <>
                Title.Caption = #21517#31216
                Width = 100
              end>
            DataSet = cdsROAD_NAME
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnSaveValue = fndROAD_NAMESaveValue
            MultiSelect = False
          end
          object fndCOMMUNITY: TzrComboBoxList
            Left = 63
            Top = 98
            Width = 160
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = False
            TabOrder = 3
            InGrid = False
            KeyValue = Null
            FilterFields = 'YQBM_YQDZ_ID;YQBM_YQDZ_MS'
            KeyField = 'YQBM_YQDZ_ID'
            ListField = 'YQBM_YQDZ_MS'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'YQBM_YQDZ_MS'
                Footers = <>
                Title.Caption = #21517#31216
                Width = 100
              end>
            DataSet = cdsCOMMUNITY
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnSaveValue = fndCOMMUNITYSaveValue
            MultiSelect = False
          end
          object fndMANSION: TzrComboBoxList
            Left = 63
            Top = 123
            Width = 160
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
            FilterFields = 'YQBM_YQDZ_ID;YQBM_YQDZ_MS'
            KeyField = 'YQBM_YQDZ_ID'
            ListField = 'YQBM_YQDZ_MS'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'YQBM_YQDZ_MS'
                Footers = <>
                Title.Caption = #21517#31216
                Width = 100
              end>
            DataSet = cdsMANSION
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnSaveValue = fndMANSIONSaveValue
            MultiSelect = False
          end
          object fndHouseNumber: TzrComboBoxList
            Left = 63
            Top = 147
            Width = 160
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = False
            TabOrder = 5
            InGrid = False
            KeyValue = Null
            FilterFields = 'YQDZ_MIAOSHU'
            KeyField = 'YQDZ_ID'
            ListField = 'YQDZ_MIAOSHU'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'YQDZ_MIAOSHU'
                Footers = <>
                Title.Caption = #25151#21495
                Width = 100
              end>
            DataSet = cdsHouseNumber
            DropWidth = 122
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnSaveValue = fndHouseNumberSaveValue
            MultiSelect = False
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 237
      Width = 249
      object btnOK: TRzBitBtn
        Left = 92
        Top = 10
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&O)'
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
        OnClick = btnOKClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 177
        Top = 10
        Width = 70
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
        OnClick = btnExitClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 48
    Top = 352
  end
  inherited actList: TActionList
    Left = 16
    Top = 352
  end
  object cdsCODE_NAME: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      ''
      '')
    Params = <>
    Left = 229
    Top = 47
  end
  object cdsROAD_NAME: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 229
    Top = 74
  end
  object cdsCOMMUNITY: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 229
    Top = 101
  end
  object cdsMANSION: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 229
    Top = 127
  end
  object cdsHouseNumber: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 229
    Top = 154
  end
end
