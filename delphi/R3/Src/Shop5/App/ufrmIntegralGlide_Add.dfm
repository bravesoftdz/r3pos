inherited frmIntegralGlide_Add: TfrmIntegralGlide_Add
  Left = 451
  Top = 236
  Caption = #22686#36865#31215#20998
  ClientHeight = 358
  ClientWidth = 522
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 522
    Height = 358
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 512
      Height = 301
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #22686#36865#31215#20998
        inherited RzPanel2: TRzPanel
          Width = 508
          Height = 274
          BorderColor = clWhite
          Color = clWhite
          object Label1: TLabel
            Left = 19
            Top = 162
            Width = 52
            Height = 12
            Caption = #25688#35201#35828#26126
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Bevel1: TBevel
            Left = 75
            Top = 167
            Width = 409
            Height = 2
          end
          object Label2: TLabel
            Left = 20
            Top = 9
            Width = 52
            Height = 12
            Caption = #20250#21592#36164#26009
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Bevel2: TBevel
            Left = 76
            Top = 14
            Width = 409
            Height = 2
          end
          object Label3: TLabel
            Left = 32
            Top = 33
            Width = 36
            Height = 12
            Caption = #20250#21592#21495
          end
          object Label4: TLabel
            Left = 20
            Top = 57
            Width = 48
            Height = 12
            Caption = #20250#21592#21517#31216
          end
          object Label5: TLabel
            Left = 20
            Top = 86
            Width = 52
            Height = 12
            Caption = #21487#29992#31215#20998
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 214
            Top = 86
            Width = 52
            Height = 12
            Caption = #32047#35745#31215#20998
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label7: TLabel
            Left = 214
            Top = 57
            Width = 48
            Height = 12
            Caption = #20250#21592#31561#32423
          end
          object Label8: TLabel
            Left = 20
            Top = 114
            Width = 48
            Height = 12
            Caption = #20817#25442#26041#24335
          end
          object Label9: TLabel
            Left = 20
            Top = 138
            Width = 48
            Height = 12
            Caption = #22686#36865#31215#20998
          end
          object labUnit: TLabel
            Left = 201
            Top = 138
            Width = 12
            Height = 12
            Caption = #20998
          end
          object edtGLIDE_INFO: TcxMemo
            Left = 19
            Top = 181
            Width = 466
            Height = 78
            TabOrder = 7
          end
          object edtIC_CARDNO: TcxTextEdit
            Tag = 1
            Left = 76
            Top = 28
            Width = 121
            Height = 20
            TabStop = False
            TabOrder = 0
          end
          object edtCLIENT_NAME: TcxTextEdit
            Tag = 1
            Left = 76
            Top = 52
            Width = 121
            Height = 20
            TabStop = False
            TabOrder = 1
          end
          object edtINTEGRAL: TcxTextEdit
            Tag = 1
            Left = 76
            Top = 81
            Width = 121
            Height = 20
            TabStop = False
            TabOrder = 3
          end
          object edtACCU_INTEGRAL: TcxTextEdit
            Tag = 1
            Left = 270
            Top = 81
            Width = 121
            Height = 20
            TabStop = False
            TabOrder = 4
          end
          object edtPRICE_NAME: TcxTextEdit
            Tag = 1
            Left = 270
            Top = 52
            Width = 121
            Height = 20
            TabStop = False
            TabOrder = 2
          end
          object edtINTEGRAL_FLAG: TcxComboBox
            Left = 76
            Top = 110
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = edtINTEGRAL_FLAGPropertiesChange
            TabOrder = 5
          end
          object edtFLAG_AMT: TcxSpinEdit
            Left = 76
            Top = 134
            Width = 121
            Height = 20
            Properties.ValueType = vtFloat
            Properties.OnChange = edtFLAG_AMTPropertiesChange
            TabOrder = 6
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 306
      Width = 512
      Height = 47
      BorderColor = clWhite
      Color = clWhite
      object btnOK: TRzBitBtn
        Left = 302
        Top = 14
        Caption = #22686#36865'(&O)'
        Color = 15791348
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        TabOrder = 0
        OnClick = btnOKClick
      end
      object btnCancel: TRzBitBtn
        Left = 395
        Top = 14
        Cancel = True
        ModalResult = 2
        Caption = #20851#38381'(&C)'
        Color = 15791348
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        TabOrder = 1
        OnClick = btnCancelClick
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 44
    Top = 326
  end
  inherited actList: TActionList
    Left = 75
    Top = 326
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 14
    Top = 326
  end
end
