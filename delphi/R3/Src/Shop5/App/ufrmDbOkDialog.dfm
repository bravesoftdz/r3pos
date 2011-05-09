inherited frmDbOkDialog: TfrmDbOkDialog
  Left = 363
  Top = 293
  BorderStyle = bsDialog
  Caption = #21040#36135#30830#35748
  ClientHeight = 229
  ClientWidth = 363
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel [0]
    Left = 24
    Top = 24
    Width = 204
    Height = 12
    Caption = #21451#24773#25552#37266#65306#35831#26680#23545#21040#36135#26085#26399#26159#21542#27491#30830#12290
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel [1]
    Left = 131
    Top = 70
    Width = 48
    Height = 12
    Alignment = taRightJustify
    Caption = #21040#36135#26085#26399
  end
  object Label3: TLabel [2]
    Left = 143
    Top = 99
    Width = 36
    Height = 12
    Alignment = taRightJustify
    Caption = #25910#36135#20154
  end
  object edtPLAN_DATE: TcxDateEdit [3]
    Left = 194
    Top = 66
    Width = 121
    Height = 20
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    TabOrder = 0
  end
  object edtSTOCK_USER: TzrComboBoxList [4]
    Left = 194
    Top = 95
    Width = 121
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
    Buttons = [zbNew, zbClear]
    DropListStyle = lsFixed
    MultiSelect = False
  end
  object btnOk: TRzBitBtn [5]
    Left = 144
    Top = 178
    Width = 67
    Height = 30
    Caption = #30830#35748'(&O)'
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
    TabOrder = 2
    TextStyle = tsRaised
    ThemeAware = False
    OnClick = btnOkClick
    NumGlyphs = 2
    Spacing = 5
  end
  object RzBitBtn1: TRzBitBtn [6]
    Left = 232
    Top = 178
    Width = 67
    Height = 30
    Caption = #21462#28040'(&C)'
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
    TabOrder = 3
    TextStyle = tsRaised
    ThemeAware = False
    OnClick = RzBitBtn1Click
    NumGlyphs = 2
    Spacing = 5
  end
end
