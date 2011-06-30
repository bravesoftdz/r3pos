inherited frmDefineStateInfo: TfrmDefineStateInfo
  Left = 379
  Top = 181
  Caption = #33258#23450#20041#21830#21697#25351#26631
  ClientHeight = 364
  ClientWidth = 369
  Color = clWhite
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 369
    Height = 364
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 359
      Height = 317
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #21830#21697#25351#26631
        inherited RzPanel2: TRzPanel
          Width = 355
          Height = 290
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 345
            Height = 280
            Align = alClient
            AutoFitColWidths = True
            DataSource = dsStateInfo
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
                FieldName = 'CODE_ID'
                Footers = <>
                ReadOnly = True
                Title.Caption = #25351#26631'ID'
                Title.Color = clWindow
                Width = 55
              end
              item
                EditButtons = <>
                FieldName = 'CODE_NAME'
                Footers = <>
                Title.Caption = #25351#26631#21517#31216
                Title.Color = clWhite
                Width = 185
                OnUpdateData = DBGridEh1Columns1UpdateData
              end
              item
                Checkboxes = True
                EditButtons = <>
                FieldName = 'USEFLAG'
                Footers = <>
                KeyList.Strings = (
                  '1'
                  '0')
                PickList.Strings = (
                  '0'
                  '1')
                Title.Caption = #33258#23450#20041
                Title.Color = clWindow
                Width = 44
                OnUpdateData = DBGridEh1Columns2UpdateData
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 322
      Width = 359
      Height = 37
      BorderColor = clWhite
      Color = clWhite
      object btnSave: TRzBitBtn
        Left = 160
        Top = 9
        Width = 67
        Height = 26
        Caption = #20445#23384'(&S)'
        Color = clSilver
        Enabled = False
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
        Left = 239
        Top = 9
        Width = 67
        Height = 26
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
    Top = 184
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
  object dsStateInfo: TDataSource
    DataSet = cdsStateInfo
    Left = 86
    Top = 173
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 198
    Top = 133
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
  object cdsStateInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    AfterEdit = cdsStateInfoAfterEdit
    BeforePost = cdsStateInfoBeforePost
    Params = <>
    Left = 38
    Top = 173
  end
end
