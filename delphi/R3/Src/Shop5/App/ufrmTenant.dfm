inherited frmTenant: TfrmTenant
  Left = 336
  Top = 195
  BorderStyle = bsDialog
  Caption = #20225#19994#27880#20876
  ClientHeight = 357
  ClientWidth = 497
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzPage: TRzPageControl [0]
    Left = 0
    Top = 0
    Width = 497
    Height = 357
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    FixedDimension = 18
    object TabSheet1: TRzTabSheet
      Caption = #20225#19994#30331#24405
      object lblName: TLabel
        Left = 43
        Top = 83
        Width = 60
        Height = 12
        Caption = #29992#25143#24080#21495#65306
      end
      object lblPass: TLabel
        Left = 43
        Top = 107
        Width = 60
        Height = 12
        Caption = #25805#20316#21475#20196#65306
      end
      object cxedtPasswrd: TcxTextEdit
        Left = 103
        Top = 102
        Width = 112
        Height = 20
        Properties.EchoMode = eemPassword
        TabOrder = 0
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      end
      object cxTextEdit1: TcxTextEdit
        Left = 103
        Top = 79
        Width = 114
        Height = 20
        Properties.EchoMode = eemPassword
        TabOrder = 1
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = #27880#20876#20225#19994
      DesignSize = (
        493
        335)
      object Label1: TLabel
        Left = 15
        Top = 24
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #30331#24405#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 15
        Top = 45
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20225#19994#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 307
        Top = 45
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
      object Label2: TLabel
        Left = 199
        Top = 24
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
        Top = 66
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20225#19994#31616#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 220
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
      object Label7: TLabel
        Left = 15
        Top = 87
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #27861#20154#20195#34920
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 220
        Top = 87
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
      object Label9: TLabel
        Left = 15
        Top = 163
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #32852#31995#20154
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 15
        Top = 184
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #32852#31995#30005#35805
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 15
        Top = 205
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20256#30495
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 15
        Top = 226
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #32593#31449#22320#22336
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 15
        Top = 247
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #32852#31995#22320#22336
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 15
        Top = 269
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #37038#32534
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 15
        Top = 108
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #30331#24405#23494#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 220
        Top = 108
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
      object Label17: TLabel
        Left = 15
        Top = 129
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20877#27425#36755#20837#23494#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 220
        Top = 129
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
      object RzLabel1: TRzLabel
        Left = 336
        Top = 21
        Width = 144
        Height = 84
        Caption = #35828#26126#65306#13#13'1'#12289#24102'*'#21495#20026#24517#39035#36755#20837#36873#39033#12290#13#13'2'#12289#35831#27491#30830#36755#20837#30456#20851#20449#24687#12290#13#13'3'#12289
      end
      object edtLOGIN_NAME: TcxTextEdit
        Tag = 1
        Left = 106
        Top = 20
        Width = 90
        Height = 20
        TabOrder = 0
      end
      object edtTENANT_NAME: TcxTextEdit
        Left = 106
        Top = 41
        Width = 199
        Height = 20
        TabOrder = 1
      end
      object edtTENANT_SHORT_NAME: TcxTextEdit
        Left = 106
        Top = 62
        Width = 111
        Height = 20
        TabOrder = 2
      end
      object edtLEGAL_REPR: TcxTextEdit
        Left = 106
        Top = 83
        Width = 111
        Height = 20
        TabOrder = 3
      end
      object edtLINKMAN: TcxTextEdit
        Left = 106
        Top = 159
        Width = 111
        Height = 20
        TabOrder = 4
      end
      object edtTELEPHONE: TcxTextEdit
        Left = 106
        Top = 180
        Width = 135
        Height = 20
        TabOrder = 5
      end
      object edtFAXES: TcxTextEdit
        Left = 106
        Top = 201
        Width = 111
        Height = 20
        TabOrder = 6
      end
      object edtHOMEPAGE: TcxTextEdit
        Left = 106
        Top = 222
        Width = 199
        Height = 20
        TabOrder = 7
      end
      object edtADDRESS: TcxTextEdit
        Left = 106
        Top = 243
        Width = 199
        Height = 20
        TabOrder = 8
      end
      object edtPOSTALCODE: TcxTextEdit
        Left = 106
        Top = 265
        Width = 71
        Height = 20
        TabOrder = 9
      end
      object cxTextEdit2: TcxTextEdit
        Left = 106
        Top = 104
        Width = 111
        Height = 20
        TabOrder = 10
      end
      object cxTextEdit3: TcxTextEdit
        Left = 106
        Top = 125
        Width = 111
        Height = 20
        TabOrder = 11
      end
      object btnOk: TRzBitBtn
        Left = 220
        Top = 297
        Width = 71
        Height = 29
        Anchors = [akTop, akRight]
        Caption = #27880#20876'(&O)'
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
        TabOrder = 12
        TextStyle = tsRaised
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
      object btnClose: TRzBitBtn
        Left = 330
        Top = 185
        Width = 70
        Height = 29
        Anchors = [akTop, akRight]
        Caption = #30331#24405'(&L)'
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
        TabOrder = 13
        TextStyle = tsRaised
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 368
  end
  inherited actList: TActionList
    Left = 456
    Top = 112
  end
end
