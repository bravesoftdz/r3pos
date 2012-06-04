inherited frmFvchFrameInfo: TfrmFvchFrameInfo
  Left = 294
  Top = 154
  Caption = #20973#35777#27169#22359#23450#20041
  ClientHeight = 392
  ClientWidth = 630
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 630
    Height = 392
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 620
      Height = 342
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = #23450#20041#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 616
          Height = 338
          BorderColor = clWhite
          Color = clWhite
          object RzLabel6: TRzLabel
            Left = 653
            Top = 250
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
          object RzPanel3: TRzPanel
            Left = 5
            Top = 5
            Width = 606
            Height = 52
            Align = alTop
            BorderOuter = fsNone
            BorderColor = clGreen
            Color = clWhite
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              606
              52)
            object Label1: TLabel
              Left = 228
              Top = 5
              Width = 139
              Height = 24
              Anchors = [akLeft, akTop, akRight]
              Caption = #20973' '#35777' '#23450' '#20041
              Font.Charset = GB2312_CHARSET
              Font.Color = clGreen
              Font.Height = -24
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label2: TLabel
              Left = 221
              Top = 32
              Width = 156
              Height = 12
              Anchors = [akLeft, akTop, akRight]
              Caption = '=========================='
              Font.Charset = GB2312_CHARSET
              Font.Color = clGreen
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
          end
          object RzPanel7: TRzPanel
            Left = 5
            Top = 57
            Width = 606
            Height = 276
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clGreen
            BorderWidth = 1
            Color = clWhite
            TabOrder = 1
            object DBGridEh1: TDBGridEh
              Left = 1
              Top = 1
              Width = 604
              Height = 274
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              BorderStyle = bsNone
              DataSource = DsFvchFrame
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 1
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
              PopupMenu = PopupMenu1
              RowHeight = 20
              SumList.Active = True
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 20
              UseMultiTitle = True
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              OnCellClick = DBGridEh1CellClick
              OnDrawColumnCell = DBGridEh1DrawColumnCell
              OnDrawFooterCell = DBGridEh1DrawFooterCell
              OnKeyPress = DBGridEh1KeyPress
              Columns = <
                item
                  Color = clWhite
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24207#21495
                  Title.Color = clWhite
                  Title.Font.Charset = GB2312_CHARSET
                  Title.Font.Color = clGreen
                  Title.Font.Height = -12
                  Title.Font.Name = #23435#20307
                  Title.Font.Style = []
                  Width = 30
                end
                item
                  EditButtons = <>
                  FieldName = 'SUBJECT_NO'
                  Footer.Value = #21512'   '#35745#65306
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  Title.Caption = #31185#30446#20195#30721
                  Title.Color = clWhite
                  Title.Font.Charset = GB2312_CHARSET
                  Title.Font.Color = clGreen
                  Title.Font.Height = -12
                  Title.Font.Name = #23435#20307
                  Title.Font.Style = []
                  Width = 120
                  OnUpdateData = DBGridEh1Columns1UpdateData
                end
                item
                  EditButtons = <>
                  FieldName = 'SUMMARY'
                  Footers = <>
                  Title.Caption = #25688#35201
                  Title.Color = clWhite
                  Title.Font.Charset = GB2312_CHARSET
                  Title.Font.Color = clGreen
                  Title.Font.Height = -12
                  Title.Font.Name = #23435#20307
                  Title.Font.Style = []
                  Width = 210
                end
                item
                  Alignment = taCenter
                  EditButtons = <>
                  FieldName = 'SUBJECT_TYPE_1'
                  Footers = <>
                  Title.Caption = #20511#26041
                  Title.Color = clWhite
                  Title.Font.Charset = GB2312_CHARSET
                  Title.Font.Color = clGreen
                  Title.Font.Height = -12
                  Title.Font.Name = #23435#20307
                  Title.Font.Style = []
                  Width = 70
                  Control = edtAMONEY
                  OnBeforeShowControl = DBGridEh1Columns3BeforeShowControl
                end
                item
                  Alignment = taCenter
                  EditButtons = <>
                  FieldName = 'SUBJECT_TYPE_2'
                  Footer.Alignment = taRightJustify
                  Footers = <>
                  Tag = 1
                  Title.Caption = #36151#26041
                  Title.Color = clWhite
                  Title.Font.Charset = GB2312_CHARSET
                  Title.Font.Color = clGreen
                  Title.Font.Height = -12
                  Title.Font.Name = #23435#20307
                  Title.Font.Style = []
                  Width = 80
                  Control = edtAMONEY_2
                  OnBeforeShowControl = DBGridEh1Columns4BeforeShowControl
                end
                item
                  Alignment = taCenter
                  EditButtons = <>
                  FieldName = 'OPTION'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #36873#39033
                  Title.Color = clWhite
                  Title.Font.Charset = GB2312_CHARSET
                  Title.Font.Color = clGreen
                  Title.Font.Height = -12
                  Title.Font.Name = #23435#20307
                  Title.Font.Style = []
                  Width = 55
                end>
            end
            object edtAMONEY: TcxComboBox
              Left = 369
              Top = 42
              Width = 64
              Height = 20
              Properties.OnChange = edtAMONEYPropertiesChange
              TabOrder = 1
              Visible = False
              OnEnter = edtAMONEYEnter
              OnExit = edtAMONEYExit
              OnKeyDown = edtAMONEYKeyDown
              OnKeyPress = edtAMONEYKeyPress
            end
            object edtAMONEY_2: TcxComboBox
              Left = 441
              Top = 42
              Width = 64
              Height = 20
              Properties.OnChange = edtAMONEY_2PropertiesChange
              TabOrder = 2
              Visible = False
              OnEnter = edtAMONEY_2Enter
              OnExit = edtAMONEY_2Exit
              OnKeyDown = edtAMONEY_2KeyDown
              OnKeyPress = edtAMONEY_2KeyPress
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 347
      Width = 620
      Color = clWhite
      object Btn_Save: TRzBitBtn
        Left = 453
        Top = 10
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&S)'
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
        Left = 539
        Top = 10
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
  end
  inherited mmMenu: TMainMenu
    Left = 8
    Top = 256
  end
  inherited actList: TActionList
    Left = 37
    Top = 256
  end
  object cdsFvchFrame: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 66
    Top = 256
  end
  object CdsFvchSwhere: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 98
    Top = 256
  end
  object DsFvchFrame: TDataSource
    DataSet = cdsFvchFrame
    Left = 131
    Top = 254
  end
  object PopupMenu1: TPopupMenu
    Left = 163
    Top = 254
    object N1: TMenuItem
      Caption = #26032#22686#20973#35777
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21024#38500#20973#35777
      OnClick = N2Click
    end
  end
end
