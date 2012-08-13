inherited frmColorInfo: TfrmColorInfo
  Left = 412
  Top = 176
  ActiveControl = DBGridEh1
  Caption = #39068#33394#20449#24687
  ClientHeight = 347
  ClientWidth = 349
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 349
    Height = 347
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 339
      Height = 294
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = ''
        inherited RzPanel2: TRzPanel
          Width = 335
          Height = 290
        end
        object DBGridEh1: TDBGridEh
          Left = 0
          Top = 0
          Width = 335
          Height = 290
          Align = alClient
          AutoFitColWidths = True
          DataSource = dsClientSort
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FrozenCols = 1
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
          PopupMenu = PopupMenu1
          RowHeight = 20
          TabOrder = 1
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          UseMultiTitle = True
          IsDrawNullRow = False
          CurrencySymbol = #65509
          DecimalNumber = 2
          DigitalNumber = 12
          OnDrawColumnCell = DBGridEh1DrawColumnCell
          OnKeyDown = DBGridEh1KeyDown
          OnKeyPress = DBGridEh1KeyPress
          Columns = <
            item
              EditButtons = <>
              FieldName = 'SEQ_NO'
              Footers = <>
              ReadOnly = True
              Title.Caption = #24207#21495
              Title.Color = clWhite
              Width = 36
            end
            item
              EditButtons = <>
              FieldName = 'COLOR_NAME'
              Footers = <>
              Title.Caption = #39068#33394#21517#31216
              Title.Color = clWhite
              Width = 120
              OnUpdateData = DBGridEh1Columns1UpdateData
            end
            item
              EditButtons = <>
              FieldName = 'COLOR_SPELL'
              Footers = <>
              Title.Caption = #25340#38899#30721
              Title.Color = clWhite
              Width = 87
              OnUpdateData = DBGridEh1Columns2UpdateData
            end
            item
              EditButtons = <>
              FieldName = 'BARCODE_FLAG'
              Footers = <>
              Title.Caption = #26465#30721#26631#21495
              Title.Color = clWhite
              OnUpdateData = DBGridEh1Columns3UpdateData
            end>
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 299
      Width = 339
      Height = 43
      Color = clWhite
      object btnSave: TRzBitBtn
        Left = 171
        Top = 13
        Width = 67
        Height = 26
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
        TabOrder = 1
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnSaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 252
        Top = 13
        Width = 67
        Height = 26
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
        TabOrder = 3
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnExitClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnAppend: TRzBitBtn
        Left = 10
        Top = 13
        Width = 67
        Height = 26
        Caption = #26032#22686'(&A)'
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
        OnClick = btnAppendClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnDelete: TRzBitBtn
        Left = 90
        Top = 13
        Width = 67
        Height = 26
        Caption = #21024#38500'(&D)'
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
        OnClick = btnDeleteClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 144
    Top = 152
  end
  inherited actList: TActionList
    Left = 184
    Top = 152
    object CtrlUp: TAction
      Caption = #21521#19978
      OnExecute = CtrlUpExecute
    end
    object CtrlDown: TAction
      Caption = #21521#19979
      OnExecute = CtrlDownExecute
    end
    object CtrlHome: TAction
      Caption = #32622#39030
      OnExecute = CtrlHomeExecute
    end
    object CtrlEnd: TAction
      Caption = #32622#24213
      OnExecute = CtrlEndExecute
    end
  end
  object dsClientSort: TDataSource
    DataSet = cdsCOLOR_INFO
    Left = 110
    Top = 149
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 222
    Top = 149
    object N1: TMenuItem
      Action = CtrlUp
    end
    object N2: TMenuItem
      Action = CtrlDown
    end
    object N3: TMenuItem
      Action = CtrlHome
    end
    object N4: TMenuItem
      Action = CtrlEnd
    end
  end
  object cdsCOLOR_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    BeforeInsert = cdsCOLOR_INFOBeforeInsert
    BeforeEdit = cdsCOLOR_INFOBeforeEdit
    BeforePost = cdsCOLOR_INFOBeforePost
    OnNewRecord = cdsCOLOR_INFONewRecord
    Params = <>
    Left = 78
    Top = 149
  end
end
