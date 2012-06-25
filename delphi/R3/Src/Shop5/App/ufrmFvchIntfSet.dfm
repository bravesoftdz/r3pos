inherited frmFvchIntfSet: TfrmFvchIntfSet
  Left = 320
  Top = 170
  Caption = #36741#21161#32534#30721#34920
  ClientWidth = 370
  Color = clWhite
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 370
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 360
      Height = 339
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #36741#21161#32534#30721#34920
        inherited RzPanel2: TRzPanel
          Width = 356
          Height = 312
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 36
            Width = 346
            Height = 271
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
            OnGetCellParams = DBGridEh1GetCellParams
            OnKeyDown = DBGridEh1KeyDown
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQ_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                EditButtons = <>
                FieldName = 'CNAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21517#31216
                Title.TitleButton = True
                Width = 140
              end
              item
                EditButtons = <>
                FieldName = 'SUBJECT_NO'
                Footers = <>
                Title.Caption = #36741#21161#20195#30721
                Width = 139
                OnUpdateData = DBGridEh1Columns2UpdateData
              end>
          end
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 346
            Height = 31
            Align = alTop
            BorderOuter = fsNone
            BorderColor = clWhite
            Color = clWhite
            TabOrder = 1
            object lblTypeName: TLabel
              Left = 11
              Top = 7
              Width = 48
              Height = 12
              Caption = #32534#30721#31867#22411
            end
            object RzLabel23: TRzLabel
              Left = 230
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
            object edtIntf_TYPE: TcxComboBox
              Left = 63
              Top = 3
              Width = 163
              Height = 20
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                #38376#24215#26680#31639
                #37096#38376#26680#31639
                #20010#20154#24448#26469
                #21333#20301#24448#26469
                #19987#39033#26680#31639)
              Properties.OnChange = edtLVL_TYPEPropertiesChange
              Properties.OnEditValueChanged = edtLVL_TYPEPropertiesEditValueChanged
              TabOrder = 0
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 344
      Width = 360
      Height = 38
      BorderColor = clWhite
      Color = clWhite
      object btnSave: TRzBitBtn
        Left = 209
        Top = 9
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnSaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExit: TRzBitBtn
        Left = 285
        Top = 9
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
    Left = 152
    Top = 176
  end
  inherited actList: TActionList
    Left = 192
    Top = 176
    object CtrlUp: TAction
      Caption = #21521#19978
    end
    object CtrlDown: TAction
      Caption = #21521#19979
    end
    object CtrlHome: TAction
      Caption = #32622#39030
    end
    object CtrlEnd: TAction
      Caption = #32622#24213
    end
    object CtrlAdd: TAction
      Caption = #28155#21152
    end
    object CtrlDel: TAction
      Caption = #21024#38500
    end
  end
  object dsPriceLv: TDataSource
    DataSet = cdsPriceLv
    Left = 70
    Top = 173
  end
  object cdsPriceLv: TZQuery
    SortedFields = 'vTYPE'
    FieldDefs = <>
    CachedUpdates = True
    AfterEdit = cdsPriceLvAfterEdit
    Params = <>
    IndexFieldNames = 'vTYPE Asc'
    Left = 22
    Top = 173
  end
end
