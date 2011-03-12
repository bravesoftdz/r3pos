inherited frmAccountInfo: TfrmAccountInfo
  Left = 420
  Top = 204
  Caption = #36134#25143#26723#26696
  ClientHeight = 309
  ClientWidth = 476
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 476
    Height = 309
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 121
      Width = 466
      Height = 143
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #35814#32454#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 462
          Height = 116
          BorderColor = clWhite
          Color = clWhite
          object Label10: TLabel
            Left = -5
            Top = 32
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36134#25143#25903#20986
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 229
            Top = 32
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36134#25143#25910#20837
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = -5
            Top = 64
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24403#21069#20313#39069
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtOUT_MNY: TcxTextEdit
            Tag = 1
            Left = 101
            Top = 28
            Width = 118
            Height = 20
            Properties.ReadOnly = False
            Properties.OnChange = edtOUT_MNYPropertiesChange
            TabOrder = 0
          end
          object edtIN_MNY: TcxTextEdit
            Tag = 1
            Left = 335
            Top = 28
            Width = 118
            Height = 20
            Properties.OnChange = edtIN_MNYPropertiesChange
            TabOrder = 1
          end
          object edtBALANCE: TcxTextEdit
            Tag = 1
            Left = 101
            Top = 60
            Width = 118
            Height = 20
            Enabled = False
            TabOrder = 2
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 264
      Width = 466
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 312
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
        Left = 397
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
      Width = 466
      Height = 116
      Align = alTop
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 2
      object Label2: TLabel
        Left = -5
        Top = 28
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #36134#25143#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 220
        Top = 28
        Width = 6
        Height = 12
        Alignment = taRightJustify
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = -5
        Top = 58
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25903#20184#26041#24335
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 221
        Top = 58
        Width = 6
        Height = 12
        Alignment = taRightJustify
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 229
        Top = 58
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #26399#21021#37329#39069
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 232
        Top = 28
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
      object Label7: TLabel
        Left = 454
        Top = 58
        Width = 6
        Height = 12
        Alignment = taRightJustify
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object edtACCT_NAME: TcxTextEdit
        Left = 101
        Top = 24
        Width = 118
        Height = 20
        Properties.OnChange = edtACCT_NAMEPropertiesChange
        TabOrder = 0
      end
      object edtORG_MNY: TcxTextEdit
        Left = 335
        Top = 54
        Width = 118
        Height = 20
        Properties.OnChange = edtORG_MNYPropertiesChange
        TabOrder = 2
        OnExit = edtORG_MNYExit
      end
      object edtACCT_SPELL: TcxTextEdit
        Left = 335
        Top = 24
        Width = 118
        Height = 20
        TabStop = False
        TabOrder = 3
      end
      object edtPAYM_ID: TzrComboBoxList
        Left = 101
        Top = 54
        Width = 118
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
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_ID'
            Footers = <>
            Title.Caption = #32534#30721
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #21517'    '#31216
            Width = 88
          end>
        DropWidth = 120
        DropHeight = 160
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Filter = 'CODE_ID,CODE_NAME,CODE_SPELL'
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 336
    Top = 104
  end
  inherited actList: TActionList
    Left = 368
    Top = 104
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 399
    Top = 105
  end
end
