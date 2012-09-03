inherited frmSizeGroupInfo: TfrmSizeGroupInfo
  Left = 366
  Top = 232
  Caption = #23610#30721#32452#31649#29702
  ClientHeight = 371
  ClientWidth = 562
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 562
    Height = 371
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 552
      Height = 321
      TabIndex = -1
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = #23610#30721#19982#23610#30721#32452#26723#26696
        inherited RzPanel2: TRzPanel
          Width = 548
          Height = 317
          BorderColor = clWhite
          Color = clWhite
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 180
            Height = 307
            Align = alLeft
            BorderOuter = fsNone
            Color = clWhite
            TabOrder = 0
            object rzTree: TRzTreeView
              Left = 0
              Top = 0
              Width = 180
              Height = 307
              SelectionPen.Color = clBtnShadow
              Align = alClient
              FrameVisible = True
              HideSelection = False
              Indent = 19
              PopupMenu = PopupMenu1
              ReadOnly = True
              RowSelect = True
              TabOrder = 0
              OnChange = rzTreeChange
            end
          end
          object RzPanel3: TRzPanel
            Left = 185
            Top = 5
            Width = 358
            Height = 307
            Align = alClient
            BorderOuter = fsNone
            Color = clWhite
            TabOrder = 1
            DesignSize = (
              358
              307)
            object Label1: TLabel
              Left = -21
              Top = 16
              Width = 80
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #21517#31216
            end
            object Label2: TLabel
              Left = -21
              Top = 42
              Width = 80
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #25340#38899#30721
            end
            object Label11: TLabel
              Left = 187
              Top = 15
              Width = 6
              Height = 12
              Alignment = taRightJustify
              Caption = '*'
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label3: TLabel
              Left = 156
              Top = 40
              Width = 6
              Height = 12
              Alignment = taRightJustify
              Caption = '*'
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 11
              Top = 74
              Width = 48
              Height = 12
              Caption = #21487#36873#23610#30721
            end
            object edtSORT_SPELL: TcxTextEdit
              Left = 65
              Top = 36
              Width = 90
              Height = 20
              Properties.OnChange = edtSPELLPropertiesChange
              TabOrder = 1
            end
            object edtSORT_NAME: TcxTextEdit
              Left = 65
              Top = 11
              Width = 121
              Height = 20
              Properties.OnChange = edtNAMEPropertiesChange
              TabOrder = 0
            end
            object RzPanel4: TRzPanel
              Left = 0
              Top = 96
              Width = 358
              Height = 211
              Align = alBottom
              BorderOuter = fsNone
              Color = clWhite
              TabOrder = 4
              object RzPanel6: TRzPanel
                Left = 0
                Top = 0
                Width = 358
                Height = 211
                Align = alClient
                BorderOuter = fsNone
                Color = clWhite
                TabOrder = 0
                object DBGridEh1: TDBGridEh
                  Left = 12
                  Top = 0
                  Width = 335
                  Height = 209
                  AllowedOperations = [alopUpdateEh]
                  AutoFitColWidths = True
                  DataSource = DsSizeInfo
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
                  Columns = <
                    item
                      Checkboxes = True
                      EditButtons = <>
                      FieldName = 'FLAG'
                      Footers = <>
                      KeyList.Strings = (
                        '1'
                        '0')
                      PickList.Strings = (
                        '0'
                        '1')
                      Title.Caption = #36873#25321
                      Title.Color = clWhite
                      Width = 30
                    end
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
                      ReadOnly = True
                      Title.Caption = #23610#30721#21517#31216
                      Title.Color = clWhite
                      Width = 100
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SORT_SPELL'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25340#38899#30721
                      Title.Color = clWhite
                      Width = 87
                    end>
                end
              end
            end
            object BtnAddSelected: TRzBitBtn
              Left = 291
              Top = 70
              Width = 57
              Height = 22
              Caption = #21152#20837#32452
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
              OnClick = BtnAddSelectedClick
              NumGlyphs = 2
              Spacing = 5
            end
            object BtnSize: TRzBitBtn
              Left = 195
              Top = 70
              Width = 88
              Height = 22
              Anchors = [akTop, akRight]
              Caption = #26032#22686#23610#30721'(&N)'
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
              OnClick = BtnSizeClick
              NumGlyphs = 2
              Spacing = 5
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 326
      Width = 552
      Color = clWhite
      object BtnSave: TRzBitBtn
        Left = 304
        Top = 6
        Width = 71
        Height = 27
        Anchors = [akTop, akRight]
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
        OnClick = BtnSaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object BtnExit: TRzBitBtn
        Left = 473
        Top = 6
        Width = 70
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
        TabOrder = 4
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = BtnExitClick
        NumGlyphs = 2
        Spacing = 5
      end
      object BtnDelete: TRzBitBtn
        Left = 216
        Top = 6
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
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
        TabOrder = 3
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = BtnDeleteClick
        NumGlyphs = 2
        Spacing = 5
      end
      object BtnCancel: TRzBitBtn
        Left = 388
        Top = 6
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #21462#28040'(&R)'
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
        OnClick = BtnCancelClick
        NumGlyphs = 2
        Spacing = 5
      end
      object BtnSizeGroup: TRzBitBtn
        Left = 128
        Top = 6
        Width = 71
        Height = 27
        Anchors = [akTop, akRight]
        Caption = #28155#21152#32452
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
        OnClick = BtnSizeGroupClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 14
    Top = 276
  end
  inherited actList: TActionList
    Left = 54
    Top = 276
    object CtrUp: TAction
      Caption = #21521#19978
      ShortCut = 16469
      OnExecute = CtrUpExecute
    end
    object CtrDown: TAction
      Caption = #21521#19979
      ShortCut = 16457
      OnExecute = CtrDownExecute
    end
    object CtrHome: TAction
      Caption = #32622#39030
      ShortCut = 16456
      OnExecute = CtrHomeExecute
    end
    object CtrEnd: TAction
      Caption = #32622#24213
      ShortCut = 16453
      OnExecute = CtrEndExecute
    end
  end
  object CdsSizeInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 13
    Top = 334
  end
  object CdsSizeGroupInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 45
    Top = 334
  end
  object CdsSizeGroupRelation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 77
    Top = 334
  end
  object DsSizeInfo: TDataSource
    DataSet = CdsSizeInfo
    Left = 14
    Top = 305
  end
  object PopupMenu1: TPopupMenu
    Left = 91
    Top = 275
    object N1: TMenuItem
      Caption = #21024#38500#36873#20013
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21024#38500#25152#26377
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = CtrUp
    end
    object N4: TMenuItem
      Action = CtrDown
    end
    object N6: TMenuItem
      Action = CtrHome
    end
    object N7: TMenuItem
      Action = CtrEnd
    end
  end
end
