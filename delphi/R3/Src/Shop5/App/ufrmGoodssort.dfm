inherited frmGoodssort: TfrmGoodssort
  Left = 842
  Top = 172
  Caption = #21830#21697#20998#31867#31649#29702
  ClientHeight = 350
  ClientWidth = 349
  Color = clWhite
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 349
    Height = 350
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 339
      Height = 298
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #21830#21697#20998#31867
        inherited RzPanel2: TRzPanel
          Width = 335
          Height = 271
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 325
            Height = 261
            Align = alClient
            AutoFitColWidths = True
            DataSource = dsUnit
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 1
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection, dghEnterAsTab]
            PopupMenu = PopupMenu1
            RowHeight = 20
            TabOrder = 0
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
                FieldName = 'SORT_NAME'
                Footers = <>
                Title.Caption = #21517'    '#31216
                Title.Color = clWhite
                Width = 150
                OnUpdateData = DBGridEh1Columns1UpdateData
              end
              item
                EditButtons = <>
                FieldName = 'SORT_SPELL'
                Footers = <>
                Title.Caption = #25340#38899#30721
                Title.Color = clWhite
                Width = 90
                OnUpdateData = DBGridEh1Columns2UpdateData
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 303
      Width = 339
      Height = 42
      BorderColor = clWhite
      Color = clWhite
      object btnSave: TRzBitBtn
        Left = 176
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
        Left = 260
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
        Left = 93
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
    Left = 152
    Top = 176
  end
  inherited actList: TActionList
    Left = 192
    Top = 176
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
  object dsUnit: TDataSource
    DataSet = cdsGoodsSort
    Left = 110
    Top = 173
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 142
    Top = 117
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
  object cdsGoodsSort: TZQuery
    SortedFields = 'SEQ_NO'
    FieldDefs = <>
    CachedUpdates = True
    BeforeInsert = cdsGoodsSortBeforeInsert
    AfterEdit = cdsGoodsSortAfterEdit
    BeforePost = cdsGoodsSortBeforePost
    OnNewRecord = cdsGoodsSortNewRecord
    Params = <>
    IndexFieldNames = 'SEQ_NO Asc'
    Left = 38
    Top = 173
  end
end
