inherited frameSelectCompany: TframeSelectCompany
  Left = 239
  Top = 244
  ActiveControl = DBGridEh1
  Caption = #38376#24215#36873#25321#26694
  ClientWidth = 531
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 531
    inherited RzPage: TRzPageControl
      Width = 521
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        Caption = #38376#24215#21015#34920
        inherited RzPanel2: TRzPanel
          Width = 517
          Height = 326
          object DBGridEh1: TDBGridEh
            Tag = -1
            Left = 5
            Top = 45
            Width = 507
            Height = 276
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = DataSource1
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 2
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu1
            RowHeight = 20
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
            OnDblClick = DBGridEh1DblClick
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            OnGetCellParams = DBGridEh1GetCellParams
            OnKeyDown = DBGridEh1KeyDown
            OnTitleClick = DBGridEh1TitleClick
            Columns = <
              item
                Checkboxes = True
                EditButtons = <>
                FieldName = 'A'
                Footers = <>
                KeyList.Strings = (
                  '1'
                  '0')
                Tag = -1
                Title.Caption = #36873#25321
                Width = 25
              end
              item
                EditButtons = <>
                FieldName = 'SEQ_NO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'COMP_ID'
                Footers = <>
                ReadOnly = True
                Title.Caption = #38376#24215#20195#30721
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'COMP_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #38376#24215#21517#31216
                Width = 125
              end
              item
                EditButtons = <>
                FieldName = 'COMP_TYPE'
                Footers = <>
                KeyList.Strings = (
                  '1'
                  '2'
                  '3')
                PickList.Strings = (
                  #32463#38144#21830
                  #30452#33829#24215
                  #21152#30431#24215
                  #9)
                ReadOnly = True
                Title.Caption = #38376#24215#31867#22411
              end
              item
                EditButtons = <>
                FieldName = 'UPCOMP_ID'
                Footers = <>
                ReadOnly = True
                Title.Caption = #38582#23646#32463#38144#21830
                Width = 83
              end
              item
                EditButtons = <>
                FieldName = 'GROUP_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #29255#21306
                Width = 65
              end
              item
                EditButtons = <>
                FieldName = 'LINKMAN'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36127#36131#20154
                Width = 51
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'TELEPHONE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #30005#35805
                Width = 78
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'FAXES'
                Footers = <>
                ReadOnly = True
                Title.Caption = #20256#30495
                Width = 86
              end
              item
                EditButtons = <>
                FieldName = 'ADDRESS'
                Footers = <>
                ReadOnly = True
                Title.Caption = #22320#22336
                Width = 215
              end
              item
                Alignment = taRightJustify
                EditButtons = <>
                FieldName = 'POSTALCODE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #37038#32534
                Width = 55
              end
              item
                EditButtons = <>
                FieldName = 'REMARK'
                Footers = <>
                ReadOnly = True
                Title.Caption = #22791#27880
                Width = 123
              end>
          end
          object fndPanel: TPanel
            Left = 5
            Top = 5
            Width = 507
            Height = 40
            Align = alTop
            BevelOuter = bvLowered
            Color = clWhite
            TabOrder = 1
            object RzPanel5: TRzPanel
              Left = 1
              Top = 1
              Width = 505
              Height = 38
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 1
              Color = clWhite
              TabOrder = 0
              object Label2: TLabel
                Left = 16
                Top = 13
                Width = 48
                Height = 12
                Caption = #38376#24215#31867#22411
              end
              object Label3: TLabel
                Left = 208
                Top = 13
                Width = 48
                Height = 12
                Caption = #25152#23646#22320#21306
              end
              object fndCOMP_TYPE: TcxComboBox
                Tag = -1
                Left = 72
                Top = 9
                Width = 121
                Height = 20
                Properties.DropDownListStyle = lsFixedList
                Properties.OnChange = fndCOMP_TYPEPropertiesChange
                TabOrder = 0
              end
              object fndGROUP_NAME: TzrComboBoxList
                Tag = -1
                Left = 264
                Top = 9
                Width = 185
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 1
                InGrid = False
                KeyValue = Null
                FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
                KeyField = 'CODE_ID'
                ListField = 'CODE_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CODE_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CODE_ID'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Width = 20
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                OnSaveValue = fndGROUP_NAMESaveValue
                OnClearValue = fndGROUP_NAMEClearValue
              end
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Width = 521
      object btnOk: TRzBitBtn
        Left = 316
        Top = 9
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object RzBitBtn2: TRzBitBtn
        Left = 404
        Top = 9
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
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsList
    Left = 342
    Top = 173
  end
  object cdsList: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'SEQ_NO'
    Params = <>
    Left = 310
    Top = 174
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 198
    Top = 214
    object N1: TMenuItem
      Caption = #20840#36873
      ShortCut = 16449
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20840#21453#36873
      ShortCut = 16450
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #20840#19981#36873
      ShortCut = 16452
      OnClick = N3Click
    end
  end
end
