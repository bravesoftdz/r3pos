inherited frmCheckTask: TfrmCheckTask
  Left = 508
  Top = 329
  BorderStyle = bsDialog
  Caption = #30424#28857#31649#29702
  ClientHeight = 209
  ClientWidth = 344
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzLabel1: TRzLabel [0]
    Left = 40
    Top = 12
    Width = 84
    Height = 20
    Caption = #30424#28857#26085#26399
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = #40657#20307
    Font.Style = [fsBold]
    ParentFont = False
    TextStyle = tsRecessed
  end
  object Label1: TLabel [1]
    Left = 34
    Top = 118
    Width = 276
    Height = 36
    Caption = #27880#65306#24320#22987#30424#28857#21518#24314#35758#20572#27490#24405#20837#19994#21153#21333#25454#65292#24453#30424#28857#23457#26680#13'    '#13'    '#23436#27605#21518#20877#36827#34892#34917#24405#12290
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label40: TLabel [2]
    Left = 42
    Top = 86
    Width = 60
    Height = 12
    Caption = #30424#28857#26041#24335#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [3]
    Left = 42
    Top = 50
    Width = 60
    Height = 12
    Caption = #30424#28857#38376#24215#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object RzBitBtn5: TRzBitBtn [4]
    Left = 91
    Top = 165
    Height = 29
    Caption = #24320#22987#30424#28857
    Color = clSilver
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    ParentFont = False
    TextShadowColor = clYellow
    TextShadowDepth = 4
    TabOrder = 0
    OnClick = RzBitBtn5Click
    NumGlyphs = 2
    Spacing = 5
  end
  object RzBitBtn1: TRzBitBtn [5]
    Left = 190
    Top = 165
    Height = 29
    Caption = #20851#38381
    Color = clSilver
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    ParentFont = False
    TextShadowColor = clYellow
    TextShadowDepth = 4
    TabOrder = 1
    OnClick = RzBitBtn1Click
    NumGlyphs = 2
    Spacing = 5
  end
  object edtCHECK_TYPE: TGroupBox [6]
    Left = 105
    Top = 72
    Width = 200
    Height = 35
    TabOrder = 2
    object RB_Single: TRadioButton
      Left = 8
      Top = 12
      Width = 78
      Height = 17
      Caption = #31616#21333#30424#28857
      Checked = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object RB_Multi: TRadioButton
      Left = 108
      Top = 12
      Width = 79
      Height = 17
      Caption = #22810#20154#30424#28857
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object edtSHOP_ID: TzrComboBoxList [7]
    Left = 104
    Top = 46
    Width = 201
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
    FilterFields = 'SHOP_NAME;SHOP_SPELL'
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
    OnSaveValue = edtSHOP_IDSaveValue
    MultiSelect = False
  end
  inherited mmMenu: TMainMenu
    Left = 184
    Top = 8
  end
  inherited actList: TActionList
    Left = 304
    Top = 8
  end
end
