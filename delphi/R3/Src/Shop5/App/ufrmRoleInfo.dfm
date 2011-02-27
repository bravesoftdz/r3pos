inherited frmRoleInfo: TfrmRoleInfo
  Left = 295
  Top = 218
  Caption = #35282#33394#26723#26696
  ClientHeight = 315
  ClientWidth = 403
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 403
    Height = 315
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 393
      Height = 265
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #32844#21153#26723#26696
        inherited RzPanel2: TRzPanel
          Width = 389
          Height = 238
          BorderColor = clWhite
          Color = clWhite
          object Label1: TLabel
            Left = 17
            Top = 20
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #35282#33394#20195#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 178
            Top = 20
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
            Left = 17
            Top = 56
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #35282#33394#21517#31216
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 247
            Top = 56
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
            Left = 17
            Top = 92
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
            Left = 247
            Top = 92
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
          object Label26: TLabel
            Left = 17
            Top = 129
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25551#36848
          end
          object Label5: TLabel
            Left = 370
            Top = 142
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
          object edtROLE_ID: TcxTextEdit
            Tag = 1
            Left = 106
            Top = 16
            Width = 71
            Height = 20
            TabOrder = 0
          end
          object edtROLE_NAME: TcxTextEdit
            Left = 106
            Top = 52
            Width = 140
            Height = 20
            Properties.OnChange = edtDUTY_NAMEPropertiesChange
            TabOrder = 1
          end
          object edtROLE_SPELL: TcxTextEdit
            Left = 106
            Top = 88
            Width = 140
            Height = 20
            TabStop = False
            TabOrder = 2
          end
          object edtREMARK: TcxMemo
            Left = 106
            Top = 125
            Width = 263
            Height = 43
            TabOrder = 3
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 270
      Width = 393
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 237
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
        Left = 316
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
  end
  inherited mmMenu: TMainMenu
    Left = 520
    Top = 64
  end
  inherited actList: TActionList
    Left = 520
    Top = 16
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select * from SYS_DEFINE where COMP_ID='#39'----'#39' or COMP_ID=:COMP_I' +
        'D and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
    Left = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
  end
end
