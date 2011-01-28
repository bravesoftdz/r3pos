inherited frmShopInfo: TfrmShopInfo
  Left = 410
  Top = 205
  Caption = #38376#24215#26723#26696
  ClientHeight = 337
  ClientWidth = 512
  Color = clWhite
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 512
    Height = 337
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 89
      Width = 502
      Height = 198
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #35814#32454#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 498
          Height = 171
          BorderColor = clWhite
          Color = clWhite
          object Label18: TLabel
            Left = 15
            Top = 11
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #36127#36131#20154
          end
          object Label16: TLabel
            Left = 259
            Top = 35
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20256#30495
          end
          object Label17: TLabel
            Left = 15
            Top = 35
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #30005#35805
          end
          object Label22: TLabel
            Left = 15
            Top = 59
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#22336
          end
          object Label26: TLabel
            Left = 15
            Top = 110
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22791#27880
          end
          object Label20: TLabel
            Left = 15
            Top = 85
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#32534
          end
          object Label25: TLabel
            Left = 259
            Top = 11
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#21306
          end
          object edtLINKMAN: TcxTextEdit
            Left = 106
            Top = 7
            Width = 120
            Height = 20
            TabOrder = 0
          end
          object edtFAXES: TcxTextEdit
            Left = 348
            Top = 31
            Width = 120
            Height = 20
            TabOrder = 3
          end
          object edtTELEPHONE: TcxTextEdit
            Left = 106
            Top = 31
            Width = 120
            Height = 20
            TabOrder = 2
          end
          object edtADDRESS: TcxTextEdit
            Left = 106
            Top = 55
            Width = 362
            Height = 20
            TabOrder = 4
          end
          object edtREMARK: TcxMemo
            Left = 106
            Top = 106
            Width = 362
            Height = 59
            TabOrder = 6
          end
          object edtPOSTALCODE: TcxTextEdit
            Left = 106
            Top = 81
            Width = 120
            Height = 20
            TabOrder = 5
          end
          object edtREGION_ID: TzrComboBoxList
            Left = 348
            Top = 7
            Width = 120
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
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
                Title.Caption = #32534#30721
                Width = 36
              end>
            DropWidth = 170
            DropHeight = 228
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 287
      Width = 502
      Height = 45
      BorderColor = clWhite
      Color = clWhite
      DesignSize = (
        502
        45)
      object btnOk: TRzBitBtn
        Left = 324
        Top = 9
        Width = 67
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnClose: TRzBitBtn
        Left = 402
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
        OnClick = btnCloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 502
      Height = 84
      Align = alTop
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 2
      object Label1: TLabel
        Left = 15
        Top = 8
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #38376#24215#20195#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 15
        Top = 32
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #38376#24215#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 228
        Top = 32
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
      object Label5: TLabel
        Left = 15
        Top = 55
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #38376#24215#20998#31867
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 228
        Top = 55
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
      object Label7: TLabel
        Left = 259
        Top = 32
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25340#38899#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 470
        Top = 32
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
      object edtSHOP_ID: TcxTextEdit
        Tag = 1
        Left = 106
        Top = 4
        Width = 90
        Height = 20
        Enabled = False
        TabOrder = 0
      end
      object edtSHOP_NAME: TcxTextEdit
        Left = 106
        Top = 28
        Width = 120
        Height = 20
        TabOrder = 1
      end
      object edtSHOP_TYPE: TcxComboBox
        Left = 106
        Top = 51
        Width = 120
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 3
      end
      object edtSHOP_SPELL: TcxTextEdit
        Left = 348
        Top = 28
        Width = 120
        Height = 20
        Enabled = False
        TabOrder = 2
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 120
    Top = 293
  end
  inherited actList: TActionList
    Left = 48
    Top = 293
  end
  object drpCompany: TADODataSet
    Parameters = <>
    Left = 86
    Top = 293
  end
  object cdsTable: TZQuery
    Params = <>
    Left = 17
    Top = 295
  end
end
