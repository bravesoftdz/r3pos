inherited frmShopInfo: TfrmShopInfo
  Left = 581
  Top = 263
  Caption = #38376#24215#26723#26696
  ClientHeight = 348
  ClientWidth = 534
  Color = clWhite
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 534
    Height = 348
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 95
      Width = 524
      Height = 203
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #35814#32454#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 520
          Height = 176
          BorderColor = clWhite
          Color = clWhite
          object Label18: TLabel
            Left = 15
            Top = 9
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36127#36131#20154
          end
          object Label16: TLabel
            Left = 15
            Top = 57
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20256#30495
          end
          object Label17: TLabel
            Left = 15
            Top = 33
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #30005#35805
          end
          object Label22: TLabel
            Left = 15
            Top = 81
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#22336
          end
          object Label26: TLabel
            Left = 15
            Top = 105
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22791#27880
          end
          object Label20: TLabel
            Left = 265
            Top = 57
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#32534
          end
          object Label25: TLabel
            Left = 265
            Top = 33
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#21306
          end
          object edtLINKMAN: TcxTextEdit
            Left = 106
            Top = 5
            Width = 120
            Height = 20
            TabOrder = 0
          end
          object edtFAXES: TcxTextEdit
            Left = 106
            Top = 53
            Width = 120
            Height = 20
            TabOrder = 2
          end
          object edtTELEPHONE: TcxTextEdit
            Left = 106
            Top = 29
            Width = 120
            Height = 20
            TabOrder = 1
          end
          object edtADDRESS: TcxTextEdit
            Left = 106
            Top = 77
            Width = 370
            Height = 20
            TabOrder = 5
          end
          object edtREMARK: TcxMemo
            Left = 106
            Top = 101
            Width = 370
            Height = 68
            TabOrder = 6
          end
          object edtPOSTALCODE: TcxTextEdit
            Left = 356
            Top = 53
            Width = 120
            Height = 20
            TabOrder = 4
          end
          object edtREGION_ID: TzrComboBoxList
            Left = 356
            Top = 29
            Width = 120
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
              end
              item
                EditButtons = <>
                FieldName = 'CODE_ID'
                Footers = <>
                Title.Caption = #32534#30721
                Width = 36
              end>
            DropWidth = 170
            DropHeight = 228
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            MultiSelect = False
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 298
      Width = 524
      Height = 45
      BorderColor = clWhite
      Color = clWhite
      DesignSize = (
        524
        45)
      object btnOk: TRzBitBtn
        Left = 373
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
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnClose: TRzBitBtn
        Left = 456
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
        OnClick = btnCloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 524
      Height = 90
      Align = alTop
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 2
      object Label1: TLabel
        Left = 15
        Top = 8
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #38376#24215#20195#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 15
        Top = 33
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #38376#24215#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 228
        Top = 33
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
      object Label5: TLabel
        Left = 15
        Top = 58
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #31649#29702#32676#32452
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 228
        Top = 58
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
      object Label7: TLabel
        Left = 267
        Top = 33
        Width = 80
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
      object Label6: TLabel
        Left = 478
        Top = 33
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
      object Label2: TLabel
        Left = 265
        Top = 58
        Width = 80
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
      object Label9: TLabel
        Left = 478
        Top = 58
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
      object edtSHOP_ID: TcxTextEdit
        Tag = 1
        Left = 106
        Top = 4
        Width = 120
        Height = 20
        Enabled = False
        TabOrder = 0
      end
      object edtSHOP_NAME: TcxTextEdit
        Left = 106
        Top = 29
        Width = 120
        Height = 20
        Properties.OnChange = edtSHOP_NAMEPropertiesChange
        TabOrder = 1
      end
      object edtSHOP_SPELL: TcxTextEdit
        Left = 356
        Top = 29
        Width = 120
        Height = 20
        TabStop = False
        TabOrder = 4
      end
      object edtLICENSE_CODE: TcxTextEdit
        Left = 356
        Top = 54
        Width = 120
        Height = 20
        TabOrder = 3
      end
      object edtSHOP_TYPE: TzrComboBoxList
        Left = 106
        Top = 54
        Width = 120
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
        FilterFields = 'CODE_ID,CODE_NAME,CODE_SPELL'
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAEM'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #21517#31216
            Width = 100
          end>
        DropWidth = 122
        DropHeight = 130
        ShowTitle = True
        AutoFitColWidth = True
        OnAddClick = edtSHOP_TYPEAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew, zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 120
    Top = 293
  end
  inherited actList: TActionList
    Left = 48
    Top = 293
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 17
    Top = 295
  end
  object cdsSHOPTYPE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 80
    Top = 296
  end
end
