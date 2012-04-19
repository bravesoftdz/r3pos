inherited frmMktActiveList: TfrmMktActiveList
  Left = 792
  Top = 134
  Caption = #24066#22330#27963#21160
  ClientHeight = 350
  ClientWidth = 388
  Color = clWhite
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 388
    Height = 350
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 378
      Height = 298
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #24066#22330#27963#21160#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 374
          Height = 271
          BorderColor = clWhite
          Color = clWhite
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 364
            Height = 261
            Align = alClient
            AutoFitColWidths = True
            DataSource = dsActive
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
            RowHeight = 18
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
            OnKeyPress = DBGridEh1KeyPress
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Title.Color = clWhite
                Width = 30
              end
              item
                EditButtons = <>
                FieldName = 'ACTIVE_NAME'
                Footers = <>
                Title.Caption = #27963#21160#21517#31216
                Title.Color = clWhite
                Width = 120
                OnUpdateData = DBGridEh1Columns1UpdateData
              end
              item
                EditButtons = <>
                FieldName = 'ACTIVE_GROUP_TEXT'
                Footers = <>
                Title.Caption = #27963#21160#20998#32452
                Title.Color = clWhite
                Width = 120
                Control = edtACTIVE_GROUP
                OnBeforeShowControl = DBGridEh1Columns2BeforeShowControl
              end
              item
                EditButtons = <>
                FieldName = 'ACTIVE_SPELL'
                Footers = <>
                Title.Caption = #25340#38899#30721
                Title.Color = clWhite
                Width = 87
              end>
          end
          object edtACTIVE_GROUP: TzrComboBoxList
            Left = 240
            Top = 80
            Width = 121
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 1
            Visible = False
            OnEnter = edtACTIVE_GROUPEnter
            OnExit = edtACTIVE_GROUPExit
            OnKeyDown = edtACTIVE_GROUPKeyDown
            OnKeyPress = edtACTIVE_GROUPKeyPress
            InGrid = False
            KeyValue = Null
            FilterFields = 'CODE_NAME;CODE_SPELL'
            KeyField = 'CODE_ID'
            ListField = 'CODE_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'CODE_NAME'
                Footers = <>
                Title.Caption = #27963#21160#32452#21517#31216
                Width = 121
              end>
            DropWidth = 123
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            OnAddClick = edtACTIVE_GROUPAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            OnSaveValue = edtACTIVE_GROUPSaveValue
            MultiSelect = False
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 303
      Width = 378
      Height = 42
      BorderColor = clWhite
      Color = clWhite
      object btnSave: TRzBitBtn
        Left = 196
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
        Left = 280
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
        Left = 30
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
        Left = 113
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
  end
  object dsActive: TDataSource
    DataSet = cdsActive
    Left = 110
    Top = 173
  end
  object cdsActive: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    OnNewRecord = cdsActiveNewRecord
    Params = <>
    Left = 38
    Top = 173
  end
end
