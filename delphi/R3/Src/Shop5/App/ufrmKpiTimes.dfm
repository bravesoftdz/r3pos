inherited frmKpiTimes: TfrmKpiTimes
  Left = 266
  Top = 212
  Caption = #26102#27573#23450#20041
  ClientHeight = 214
  ClientWidth = 529
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 529
    Height = 214
    BorderColor = clWindow
    Color = clWindow
    inherited RzPage: TRzPageControl
      Width = 519
      Height = 164
      Color = clWindow
      ParentColor = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWindow
        Caption = #26102#27573#35814#24773
        inherited RzPanel2: TRzPanel
          Width = 515
          Height = 137
          BorderColor = clWindow
          Color = clWindow
          object lab_IDX_TYPE: TRzLabel
            Left = 7
            Top = 63
            Width = 100
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
          object RzLabel2: TRzLabel
            Left = 235
            Top = 63
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
          object lab_KPI_TYPE: TLabel
            Left = 240
            Top = 63
            Width = 100
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
          object RzLabel3: TRzLabel
            Left = 468
            Top = 63
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
          object RzLabel1: TRzLabel
            Left = 7
            Top = 39
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24320#22987#26102#38388
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 240
            Top = 39
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32467#26463#26102#38388
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel4: TRzLabel
            Left = 8
            Top = 15
            Width = 100
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
            Left = 7
            Top = 87
            Width = 100
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
          object RzLabel6: TRzLabel
            Left = 235
            Top = 87
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
          object Label2: TLabel
            Left = 157
            Top = 40
            Width = 12
            Height = 12
            Caption = #26376
          end
          object Label3: TLabel
            Left = 221
            Top = 40
            Width = 12
            Height = 12
            Caption = #26085
          end
          object Label4: TLabel
            Left = 389
            Top = 40
            Width = 12
            Height = 12
            Caption = #26376
          end
          object Label5: TLabel
            Left = 453
            Top = 40
            Width = 12
            Height = 12
            Caption = #26085
          end
          object edtKPI_CALC: TcxComboBox
            Left = 346
            Top = 59
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 2
          end
          object edtKPI_DATA: TcxComboBox
            Left = 113
            Top = 59
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 1
          end
          object edtTIMES_NAME: TcxTextEdit
            Left = 113
            Top = 11
            Width = 121
            Height = 20
            TabOrder = 0
          end
          object edtRATIO_TYPE: TcxComboBox
            Left = 113
            Top = 83
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 3
          end
          object edtKPI_FLAG: TcxCheckBox
            Left = 113
            Top = 107
            Width = 121
            Height = 21
            Properties.DisplayUnchecked = 'False'
            Properties.Caption = #26159#21542#20026#20419#38144#26102#27573
            TabOrder = 4
          end
          object edtUSING_BRRW: TcxCheckBox
            Left = 347
            Top = 107
            Width = 121
            Height = 21
            Properties.DisplayUnchecked = 'False'
            Properties.Caption = #26159#21542#20801#35768#20511#37327
            TabOrder = 5
          end
          object edtKpi_Month1: TcxSpinEdit
            Left = 113
            Top = 35
            Width = 40
            Height = 20
            Properties.MaxValue = 12.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 6
            Value = 1
          end
          object edtKpi_Day1: TcxSpinEdit
            Left = 176
            Top = 35
            Width = 40
            Height = 20
            Properties.MaxValue = 31.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 7
            Value = 1
          end
          object edtKpi_Day2: TcxSpinEdit
            Left = 410
            Top = 35
            Width = 40
            Height = 20
            Properties.MaxValue = 31.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 8
            Value = 1
          end
          object edtKpi_Month2: TcxSpinEdit
            Left = 346
            Top = 35
            Width = 40
            Height = 20
            Properties.MaxValue = 12.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 9
            Value = 1
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 169
      Width = 519
      Color = clWindow
      object Btn_Save: TRzBitBtn
        Left = 357
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
        Left = 447
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
