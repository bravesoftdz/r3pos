inherited frmPriceGradeInfo: TfrmPriceGradeInfo
  Left = 663
  Top = 223
  Caption = #23458#25143#31561#32423#31649#29702
  ClientHeight = 435
  ClientWidth = 603
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 603
    Height = 435
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 593
      Height = 385
      Color = clWhite
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #23458#25143#31561#32423#26723#26696
        inherited RzPanel2: TRzPanel
          Width = 589
          Height = 358
          BorderColor = clWhite
          Color = clWhite
          object Label1: TLabel
            Left = 146
            Top = 16
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #31561#32423#21517#31216
          end
          object Label2: TLabel
            Left = 365
            Top = 16
            Width = 60
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25340#38899#30721
          end
          object Label3: TLabel
            Left = 146
            Top = 41
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #31215#20998#26631#20934
          end
          object Label4: TLabel
            Left = 146
            Top = 66
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20248#24800#31867#22411
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 357
            Top = 16
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
          object Label13: TLabel
            Left = 357
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
          object Label15: TLabel
            Left = 357
            Top = 66
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
          object Label21: TLabel
            Left = 365
            Top = 66
            Width = 60
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26368#20302#25240#25187#29575
          end
          object Label22: TLabel
            Left = 525
            Top = 66
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
          object Label23: TLabel
            Left = 513
            Top = 66
            Width = 6
            Height = 12
            Caption = '%'
          end
          object rzTree: TRzTreeView
            Left = 5
            Top = 5
            Width = 140
            Height = 348
            SelectionPen.Color = clBtnShadow
            Align = alLeft
            FrameColor = clWindow
            FrameStyle = fsGroove
            FrameVisible = True
            HideSelection = False
            Indent = 19
            ReadOnly = True
            RowSelect = True
            TabOrder = 4
            OnChange = rzTreeChange
            OnChanging = rzTreeChanging
          end
          object edtPRICE_NAME: TcxTextEdit
            Left = 236
            Top = 12
            Width = 121
            Height = 20
            Properties.OnChange = edtPRICE_NAMEPropertiesChange
            TabOrder = 0
          end
          object edtPRICE_SPELL: TcxTextEdit
            Left = 435
            Top = 12
            Width = 90
            Height = 20
            TabStop = False
            Properties.OnChange = edtPRICE_SPELLPropertiesChange
            TabOrder = 5
          end
          object edtINTEGRAL: TcxTextEdit
            Left = 236
            Top = 37
            Width = 121
            Height = 20
            Properties.OnChange = edtINTEGRALPropertiesChange
            TabOrder = 1
          end
          object edtAGIO_TYPE: TcxComboBox
            Left = 236
            Top = 62
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = edtAGIO_TYPEPropertiesChange
            TabOrder = 2
          end
          object GroupBox1: TGroupBox
            Left = 178
            Top = 87
            Width = 385
            Height = 204
            TabOrder = 6
            object Notebook1: TNotebook
              Left = 2
              Top = 8
              Width = 381
              Height = 193
              PageIndex = 2
              TabOrder = 0
              object TPage
                Left = 0
                Top = 0
                Caption = 'P0'
                object Label8: TLabel
                  Left = 80
                  Top = 88
                  Width = 198
                  Height = 12
                  Caption = #25152#26377#21830#21697#37117#19981#25171#25240','#25353#32479#19968#38646#21806#20215#35745#20215
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'P1'
                object Label6: TLabel
                  Left = 96
                  Top = 80
                  Width = 60
                  Height = 12
                  Caption = #25351#23450#25240#25187#29575
                end
                object Label9: TLabel
                  Left = 246
                  Top = 81
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object edtAGIO_PERCENT: TcxSpinEdit
                  Left = 155
                  Top = 76
                  Width = 90
                  Height = 20
                  Properties.ValueType = vtFloat
                  Properties.OnChange = edtAGIO_PERCENTPropertiesChange
                  TabOrder = 0
                  Value = 10.000000000000000000
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'P2'
                object Label17: TLabel
                  Left = 0
                  Top = 0
                  Width = 48
                  Height = 193
                  Align = alLeft
                  Caption = #13#13#13#12288#21487#25353'  '#13#12288#25351#19981'  '#13#12288#23450#21516'  '#13#12288#19981#30340'  '#13#12288#21516#25240'  '#13#12288#20998#25187'  '#13#12288#31867#29575'  '#13#12288#12288#35745'  '#13#12288#12288#20215
                end
                object DBGridEh1: TDBGridEh
                  Left = 48
                  Top = 0
                  Width = 248
                  Height = 193
                  Align = alClient
                  AllowedOperations = [alopUpdateEh]
                  AutoFitColWidths = True
                  DataSource = DataSource1
                  Flat = True
                  FooterColor = clWindow
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FrozenCols = 1
                  Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
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
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SORT_NAME'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #21830#21697#31867#21035
                      Title.Color = clWhite
                      Width = 130
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'AGIO_SORTS'
                      Footers = <>
                      MaxWidth = 100
                      Title.Caption = #25240#25187#29575'%'
                      Title.Color = clWhite
                      Width = 66
                      OnUpdateData = DBGridEh1Columns2UpdateData
                    end>
                end
                object RzPanel1: TRzPanel
                  Left = 296
                  Top = 0
                  Width = 85
                  Height = 193
                  Align = alRight
                  BorderOuter = fsFlat
                  BorderColor = clWhite
                  Color = clWhite
                  TabOrder = 1
                  DesignSize = (
                    85
                    193)
                  object btnAdd: TRzBitBtn
                    Left = 8
                    Top = 8
                    Width = 70
                    Height = 26
                    Anchors = [akTop, akRight]
                    Caption = #28155' '#21152
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
                    OnClick = btnAddClick
                    NumGlyphs = 2
                    Spacing = 5
                  end
                  object btnDetele: TRzBitBtn
                    Left = 8
                    Top = 45
                    Width = 70
                    Height = 26
                    Anchors = [akTop, akRight]
                    Caption = #21024' '#38500
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
                    OnClick = btnDeteleClick
                    NumGlyphs = 2
                    Spacing = 5
                  end
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'P3'
                object Label7: TLabel
                  Left = 88
                  Top = 56
                  Width = 192
                  Height = 12
                  Caption = #25353#21830#21697#36164#26009#20013#35774#23450#30340#21508#32423#20195#29702#20215#35745#20215
                end
              end
            end
          end
          object edtMINIMUM_PERCENT: TcxSpinEdit
            Left = 435
            Top = 62
            Width = 75
            Height = 20
            Properties.MaxValue = 100.000000000000000000
            Properties.ValueType = vtFloat
            Properties.OnChange = edtMINIMUM_PERCENTPropertiesChange
            TabOrder = 3
            Value = 100.000000000000000000
          end
          object GroupBox2: TGroupBox
            Left = 178
            Top = 293
            Width = 384
            Height = 60
            Caption = #20250#21592#31215#20998#35268#21017#23450#20041
            TabOrder = 7
            object Label5: TLabel
              Left = 8
              Top = 18
              Width = 88
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #31215#20998#31867#22411
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label14: TLabel
              Left = 191
              Top = 18
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
            object Label19: TLabel
              Left = 8
              Top = 38
              Width = 88
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #31215#19968#20998#25152#38656#36141#20080
            end
            object Label20: TLabel
              Left = 191
              Top = 38
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
            object Label24: TLabel
              Left = 197
              Top = 38
              Width = 88
              Height = 12
              AutoSize = False
              Caption = #20803#30340#21830#21697
            end
            object edtINTE_TYPE: TcxComboBox
              Left = 100
              Top = 14
              Width = 90
              Height = 20
              Properties.DropDownListStyle = lsFixedList
              Properties.OnChange = edtINTE_TYPEPropertiesChange
              TabOrder = 0
            end
            object edtINTE_AMOUNT: TcxTextEdit
              Left = 100
              Top = 34
              Width = 90
              Height = 20
              Properties.OnChange = edtINTE_AMOUNTPropertiesChange
              TabOrder = 1
            end
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 390
      Width = 593
      BorderColor = clWhite
      Color = clWhite
      object edtSave: TRzBitBtn
        Left = 427
        Top = 6
        Width = 70
        Height = 26
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
        OnClick = edtSaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtCancel: TRzBitBtn
        Left = 346
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
        OnClick = edtCancelClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtDelete: TRzBitBtn
        Left = 265
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
        OnClick = edtDeleteClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtExit: TRzBitBtn
        Left = 508
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
        OnClick = edtExitClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtPriceGrade: TRzBitBtn
        Left = 183
        Top = 6
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
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
        OnClick = edtPriceGradeClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 200
  end
  inherited actList: TActionList
    Left = 232
    Top = 0
  end
  object DataSource1: TDataSource
    DataSet = cds_GoodsPercent
    Left = 96
    Top = 277
  end
  object cdsPRICEGRADE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 38
    Top = 317
  end
  object cds_GoodsPercent: TZQuery
    FieldDefs = <
      item
        Name = 'SORT_ID'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'SORT_NAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AGIO_SORTS'
        DataType = ftFloat
      end>
    CachedUpdates = True
    Params = <>
    Left = 94
    Top = 317
  end
end
