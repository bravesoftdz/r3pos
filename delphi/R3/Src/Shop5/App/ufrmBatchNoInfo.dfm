inherited frmBatchNoInfo: TfrmBatchNoInfo
  Left = 381
  Top = 200
  Caption = #25209#21495#26723#26696
  ClientHeight = 302
  ClientWidth = 443
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 443
    Height = 302
    BorderColor = clWhite
    Color = clWhite
    object RzLabel1: TRzLabel [0]
      Left = 235
      Top = 16
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
      Top = 16
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25209'    '#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_USER_NAME: TRzLabel [2]
      Left = 7
      Top = 41
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25152#23646#21830#21697
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel [3]
      Left = 346
      Top = 41
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
    object RzLabel5: TRzLabel [4]
      Left = 247
      Top = 16
      Width = 160
      Height = 12
      AutoSize = False
      Caption = #21516#31867#21830#21697#20013#19981#33021#37325#22797
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object labBIRTHDAY: TRzLabel [5]
      Left = 7
      Top = 64
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #29983#20135#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lab_WORK_DATE: TRzLabel [6]
      Left = 8
      Top = 88
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #26377#25928#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    inherited RzPage: TRzPageControl
      Top = 128
      Width = 433
      Height = 137
      Align = alBottom
      BackgroundColor = clWhite
      ParentBackgroundColor = False
      TabOrder = 1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20854#20182#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 429
          Height = 110
          BorderColor = clWhite
          Color = clWhite
          object lab_REMARK: TRzLabel
            Left = 1
            Top = 16
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22791'    '#27880
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel7: TRzLabel
            Left = 462
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
          object edtREMARK: TcxMemo
            Left = 106
            Top = 15
            Width = 302
            Height = 68
            Properties.MaxLength = 100
            TabOrder = 0
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 265
      Width = 433
      Height = 32
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 2
      object Btn_Save: TRzBitBtn
        Left = 274
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
        Left = 364
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
    object edtBATCH_NO: TcxTextEdit
      Left = 113
      Top = 12
      Width = 121
      Height = 20
      Properties.MaxLength = 20
      TabOrder = 0
    end
    object edtGODS_ID: TzrComboBoxList
      Left = 113
      Top = 37
      Width = 224
      Height = 20
      TabStop = False
      Properties.AutoSelect = False
      Properties.Buttons = <
        item
          Default = True
        end>
      Properties.ReadOnly = False
      TabOrder = 3
      InGrid = True
      KeyValue = Null
      FilterFields = 'GODS_CODE;GODS_NAME;GODS_SPELL;BARCODE'
      KeyField = 'GODS_ID'
      ListField = 'GODS_NAME'
      Columns = <
        item
          EditButtons = <>
          FieldName = 'GODS_NAME'
          Footers = <>
          Title.Caption = #21830#21697#21517#31216
          Width = 150
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = #36135#21495
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = #26465#30721
          Width = 65
        end>
      DropWidth = 380
      DropHeight = 250
      ShowTitle = True
      AutoFitColWidth = True
      ShowButton = True
      LocateStyle = lsDark
      Buttons = [zbClear]
      DropListStyle = lsFixed
      MultiSelect = False
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    end
    object edtFACT_DATE: TcxDateEdit
      Left = 113
      Top = 59
      Width = 121
      Height = 20
      TabOrder = 4
    end
    object edtVILD_DATE: TcxDateEdit
      Left = 113
      Top = 83
      Width = 121
      Height = 20
      TabOrder = 5
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
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 206
    Top = 128
  end
end
