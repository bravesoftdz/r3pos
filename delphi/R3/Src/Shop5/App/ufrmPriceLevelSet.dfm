inherited frmPriceLevelSet: TfrmPriceLevelSet
  Left = 362
  Top = 184
  Caption = #22810#26723#20419#38144
  ClientHeight = 328
  ClientWidth = 343
  Color = clWhite
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Top = 41
    Width = 343
    Height = 287
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 333
      Height = 235
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20419#38144#26723#20301#23450#20041
        inherited RzPanel2: TRzPanel
          Width = 329
          Height = 208
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 319
            Height = 198
            Align = alClient
            DataSource = dsPriceLv
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
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghEnterAsTab]
            PopupMenu = Pm
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
            OnTitleBtnClick = DBGridEh1TitleBtnClick
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQ_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #26723#20301
                Title.Color = clWhite
                Width = 26
              end
              item
                EditButtons = <>
                FieldName = 'LV_AMT'
                Footers = <>
                Title.Caption = #36798#26631#37327
                Title.Color = clWhite
                Title.TitleButton = True
                Width = 102
                OnUpdateData = DBGridEh1Columns1UpdateData
              end
              item
                DisplayFormat = '#0%'
                EditButtons = <>
                FieldName = 'AGIO_RATE'
                Footers = <>
                Title.Caption = #25240#25187#29575
                Title.Color = clWhite
                Width = 53
                OnUpdateData = DBGridEh1Columns2UpdateData
              end
              item
                EditButtons = <>
                FieldName = 'LV_PRC'
                Footers = <>
                Title.Caption = #20248#24800#20215
                Title.Color = clWhite
                Title.TitleButton = True
                Width = 107
                OnUpdateData = DBGridEh1Columns3UpdateData
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 240
      Width = 333
      Height = 42
      BorderColor = clWhite
      Color = clWhite
      object btnSave: TRzBitBtn
        Left = 104
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
        Left = 188
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
        Visible = False
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
        Visible = False
        OnClick = btnDeleteClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object RzPanel1: TRzPanel [1]
    Left = 0
    Top = 0
    Width = 343
    Height = 41
    Align = alTop
    BorderOuter = fsNone
    BorderColor = clWhite
    Color = clWhite
    TabOrder = 1
    object lblTypeName: TLabel
      Left = 13
      Top = 8
      Width = 48
      Height = 12
      Caption = #20419#38144#31867#22411
    end
    object RzLabel23: TRzLabel
      Left = 199
      Top = 7
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
    object edtLVL_TYPE: TcxComboBox
      Left = 67
      Top = 3
      Width = 129
      Height = 20
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #25353#21333#21697#37329#39069
        #25353#21333#21697#25968#37327
        #25353#25972#21333#37329#39069)
      Properties.OnChange = edtLVL_TYPEPropertiesChange
      Properties.OnEditValueChanged = edtLVL_TYPEPropertiesEditValueChanged
      TabOrder = 0
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
    object CtrlAdd: TAction
      Caption = #28155#21152
      OnExecute = CtrlAddExecute
    end
    object CtrlDel: TAction
      Caption = #21024#38500
      OnExecute = CtrlDelExecute
    end
  end
  object dsPriceLv: TDataSource
    DataSet = cdsPriceLv
    Left = 70
    Top = 173
  end
  object Pm: TPopupMenu
    AutoHotkeys = maManual
    Left = 214
    Top = 85
    object N6: TMenuItem
      Action = CtrlAdd
    end
    object N7: TMenuItem
      Action = CtrlDel
    end
    object N5: TMenuItem
      Caption = '-'
    end
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
  object cdsPriceLv: TZQuery
    SortedFields = 'SEQ_NO'
    FieldDefs = <>
    CachedUpdates = True
    BeforeInsert = cdsPriceLvBeforeInsert
    AfterEdit = cdsPriceLvAfterEdit
    BeforePost = cdsPriceLvBeforePost
    OnNewRecord = cdsPriceLvNewRecord
    Params = <>
    IndexFieldNames = 'SEQ_NO Asc'
    Left = 22
    Top = 173
  end
end
