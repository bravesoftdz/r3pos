inherited frmKpiSeqNoSet: TfrmKpiSeqNoSet
  Left = 281
  Top = 247
  Caption = #36798#26631#26723#20301#35774#32622
  ClientHeight = 259
  ClientWidth = 532
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 532
    Height = 259
    BorderColor = clWindow
    Color = clWindow
    inherited RzPage: TRzPageControl
      Width = 522
      Height = 205
      Color = clWindow
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWindow
        Caption = #36798#26631#26723#20301#35774#32622
        inherited RzPanel2: TRzPanel
          Width = 518
          Height = 178
          BorderColor = clWindow
          Color = clWindow
          object RzLabel3: TRzLabel
            Left = 11
            Top = 20
            Width = 56
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #31561#32423#21517#31216
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel7: TRzLabel
            Left = 11
            Top = 57
            Width = 56
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26102#27573#21517#31216
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel5: TRzLabel
            Left = 237
            Top = 20
            Width = 49
            Height = 11
            Alignment = taRightJustify
            AutoSize = False
            Caption = #31614#32422#37327
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel6: TRzLabel
            Left = 378
            Top = 19
            Width = 56
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20445#24213#36820#21033
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel1: TRzLabel
            Left = 234
            Top = 82
            Width = 52
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24320#22987#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 377
            Top = 82
            Width = 57
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32456#27490#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_IDX_TYPE: TRzLabel
            Left = 15
            Top = 82
            Width = 52
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32771#26680#26631#20934
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_KPI_TYPE: TLabel
            Left = 10
            Top = 106
            Width = 57
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #35745#31639#26631#20934
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel2: TRzLabel
            Left = 227
            Top = 106
            Width = 60
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36820#21033#35774#23450
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel4: TRzLabel
            Left = 9
            Top = 130
            Width = 56
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36798#26631#37327
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtLEVEL_NAME: TcxTextEdit
            Tag = 1
            Left = 72
            Top = 16
            Width = 148
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 0
          end
          object edtLVL_AMT: TcxTextEdit
            Tag = 1
            Left = 292
            Top = 15
            Width = 70
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 1
          end
          object edtLOW_RATE: TcxTextEdit
            Tag = 1
            Left = 437
            Top = 15
            Width = 70
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 2
          end
          object edtKPI_DATE1: TcxTextEdit
            Tag = 1
            Left = 292
            Top = 78
            Width = 70
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 3
          end
          object edtKPI_DATE2: TcxTextEdit
            Tag = 1
            Left = 437
            Top = 78
            Width = 70
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 4
          end
          object edtTIMES_ID: TzrComboBoxList
            Left = 72
            Top = 52
            Width = 148
            Height = 20
            TabStop = False
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 5
            InGrid = True
            KeyValue = Null
            FilterFields = 'TIMES_NAME'
            KeyField = 'TIMES_ID'
            ListField = 'TIMES_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'TIMES_NAME'
                Footers = <>
                Title.Caption = #26102#27573#21517#31216
                Width = 150
              end
              item
                DisplayFormat = '00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE1'
                Footers = <>
                Title.Caption = #24320#22987#26085#26399
                Width = 50
              end
              item
                DisplayFormat = '00-00'
                EditButtons = <>
                FieldName = 'KPI_DATE2'
                Footers = <>
                Title.Caption = #32467#26463#26085#26399
                Width = 65
              end
              item
                EditButtons = <>
                FieldName = 'KPI_DATA'
                Footers = <>
                Title.Caption = #32771#26680#26631#20934
              end
              item
                EditButtons = <>
                FieldName = 'KPI_CALC'
                Footers = <>
                Title.Caption = #35745#31639#26631#20934
              end>
            DropWidth = 380
            DropHeight = 250
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = []
            DropListStyle = lsFixed
            OnSaveValue = edtTIMES_IDSaveValue
            MultiSelect = False
          end
          object edtKPI_DATA: TcxComboBox
            Tag = 1
            Left = 72
            Top = 78
            Width = 148
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Style.Color = 15395562
            TabOrder = 6
          end
          object edtKPI_CALC: TcxComboBox
            Tag = 1
            Left = 72
            Top = 102
            Width = 148
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Style.Color = 15395562
            TabOrder = 7
          end
          object edtRATIO_TYPE: TcxComboBox
            Tag = 1
            Left = 292
            Top = 102
            Width = 69
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Style.Color = 15395562
            TabOrder = 8
          end
          object edtKPI_AMT: TcxTextEdit
            Left = 72
            Top = 126
            Width = 148
            Height = 20
            Properties.ReadOnly = True
            Style.Color = clWhite
            TabOrder = 9
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 210
      Width = 522
      Height = 44
      Color = clWindow
      object Btn_Save: TRzBitBtn
        Left = 354
        Top = 11
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
        Left = 444
        Top = 11
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
    Top = 272
  end
  inherited actList: TActionList
    Left = 40
    Top = 272
  end
end
