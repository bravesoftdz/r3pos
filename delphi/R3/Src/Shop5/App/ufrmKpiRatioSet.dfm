inherited frmKpiRatioSet: TfrmKpiRatioSet
  Left = 383
  Top = 193
  Caption = #36820#21033#31995#25968#23450#20041
  ClientHeight = 257
  ClientWidth = 563
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 563
    Height = 257
    BorderColor = clWindow
    Color = clWindow
    inherited RzPage: TRzPageControl
      Width = 553
      Height = 207
      Color = clWindow
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWindow
        Caption = #36820#21033#31995#25968
        inherited RzPanel2: TRzPanel
          Width = 549
          Height = 180
          BorderColor = clWindow
          Color = clWindow
          object RzLabel3: TRzLabel
            Left = 15
            Top = 23
            Width = 60
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
            Left = 15
            Top = 49
            Width = 60
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
          object Label33: TLabel
            Left = 27
            Top = 112
            Width = 48
            Height = 12
            Alignment = taRightJustify
            Caption = #21830#21697#21517#31216
          end
          object Label30: TLabel
            Left = 281
            Top = 112
            Width = 24
            Height = 12
            Alignment = taRightJustify
            Caption = #21333#20301
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel8: TRzLabel
            Left = 256
            Top = 50
            Width = 49
            Height = 11
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
          object RzLabel5: TRzLabel
            Left = 256
            Top = 24
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
            Left = 386
            Top = 23
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
          object RzLabel9: TRzLabel
            Left = 15
            Top = 74
            Width = 60
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
          object RzLabel10: TRzLabel
            Left = 385
            Top = 112
            Width = 56
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36820#21033#31995#25968
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel2: TRzLabel
            Left = 251
            Top = 74
            Width = 53
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
          object edtTIMES_NAME: TcxTextEdit
            Tag = 1
            Left = 77
            Top = 45
            Width = 148
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 0
          end
          object edt_UNIT_ID: TzrComboBoxList
            Tag = 100
            Left = 307
            Top = 108
            Width = 70
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
            FilterFields = 'UNIT_NAME;UNIT_SPELL;UNIT_ID'
            KeyField = 'UNIT_ID'
            ListField = 'UNIT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'UNIT_NAME'
                Footers = <>
                Title.Caption = #21333#20301#21517#31216
                Width = 50
              end
              item
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                Title.Caption = #20195#30721
                Visible = False
                Width = 50
              end>
            DropWidth = 100
            DropHeight = 120
            ShowTitle = False
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            MultiSelect = False
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          end
          object edtLVL_AMT: TcxTextEdit
            Tag = 1
            Left = 307
            Top = 19
            Width = 70
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 2
          end
          object edtLOW_RATE: TcxTextEdit
            Tag = 1
            Left = 444
            Top = 19
            Width = 70
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 3
          end
          object edtKPI_RATIO: TcxTextEdit
            Tag = 1
            Left = 443
            Top = 108
            Width = 70
            Height = 20
            Properties.ReadOnly = False
            Style.Color = 15395562
            TabOrder = 4
          end
          object edtKPI_CALC: TcxComboBox
            Tag = 1
            Left = 77
            Top = 70
            Width = 148
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Style.Color = 15395562
            TabOrder = 5
          end
          object edtKPI_DATA: TcxComboBox
            Tag = 1
            Left = 307
            Top = 45
            Width = 207
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Style.Color = 15395562
            TabOrder = 6
          end
          object edtRATIO_TYPE: TcxComboBox
            Tag = 1
            Left = 307
            Top = 70
            Width = 207
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Style.Color = 15395562
            TabOrder = 7
          end
          object edt_GODS_ID: TcxTextEdit
            Tag = 1
            Left = 79
            Top = 108
            Width = 146
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 8
          end
          object edtLEVEL_ID: TcxTextEdit
            Tag = 1
            Left = 78
            Top = 18
            Width = 147
            Height = 20
            Properties.ReadOnly = True
            Style.Color = 15395562
            TabOrder = 9
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 212
      Width = 553
      Color = clWindow
      object Btn_Save: TRzBitBtn
        Left = 391
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
        Left = 481
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
