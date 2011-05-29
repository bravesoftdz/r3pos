inherited frmTenantInfo: TfrmTenantInfo
  Left = 568
  Top = 261
  Caption = #20225#19994#20449#24687
  ClientHeight = 332
  ClientWidth = 521
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 521
    Height = 332
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 147
      Width = 511
      Height = 140
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #35814#32454#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 507
          Height = 113
          BorderColor = clWhite
          Color = clWhite
          object Label7: TLabel
            Left = -5
            Top = 16
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
          object Label11: TLabel
            Left = 268
            Top = 16
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
          object Label9: TLabel
            Left = -5
            Top = 39
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
            Left = 268
            Top = 39
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
          object Label13: TLabel
            Left = -5
            Top = 87
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 268
            Top = 63
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
          object Label20: TLabel
            Left = -5
            Top = 63
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20027#39029
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtLEGAL_REPR: TcxTextEdit
            Tag = 7
            Left = 86
            Top = 12
            Width = 121
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 0
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtFAXES: TcxTextEdit
            Tag = 8
            Left = 359
            Top = 12
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 4
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtLINKMAN: TcxTextEdit
            Tag = 9
            Left = 86
            Top = 35
            Width = 121
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 1
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtTELEPHONE: TcxTextEdit
            Tag = 10
            Left = 359
            Top = 35
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 5
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtADDRESS: TcxTextEdit
            Tag = 11
            Left = 86
            Top = 83
            Width = 183
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 3
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtPOSTALCODE: TcxTextEdit
            Tag = 12
            Left = 359
            Top = 59
            Width = 121
            Height = 20
            Properties.MaxLength = 6
            TabOrder = 6
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtHOMEPAGE: TcxTextEdit
            Tag = 12
            Left = 86
            Top = 59
            Width = 183
            Height = 20
            Properties.MaxLength = 6
            TabOrder = 2
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 287
      Width = 511
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 345
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
        Left = 428
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
      Width = 511
      Height = 142
      Align = alTop
      BorderOuter = fsNone
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 2
      object Label1: TLabel
        Left = -4
        Top = 19
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #27880#20876#24080#21495
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = -4
        Top = 43
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
        Left = 274
        Top = 43
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
        Left = 210
        Top = 19
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
        Left = 21
        Top = 67
        Width = 55
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
        Left = 211
        Top = 67
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
      object Label8: TLabel
        Left = 484
        Top = 67
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
      object Label12: TLabel
        Left = 269
        Top = 67
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #32463#33829#35768#21487#35777#21495
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = -4
        Top = 91
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #27880#20876#23494#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 484
        Top = 91
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
        Left = -4
        Top = 115
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
        Left = 211
        Top = 115
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
        Left = 269
        Top = 91
        Width = 80
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25152#23646#22320#21306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 224
        Top = 19
        Width = 72
        Height = 12
        Caption = #20363':celeb.net'
      end
      object Label23: TLabel
        Left = 211
        Top = 91
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
        Left = 294
        Top = 43
        Width = 55
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
      object Label25: TLabel
        Left = 484
        Top = 43
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
      object edtLOGIN_NAME: TcxTextEdit
        Left = 87
        Top = 15
        Width = 121
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtTENANT_NAME: TcxTextEdit
        Tag = 1
        Left = 87
        Top = 39
        Width = 185
        Height = 20
        Properties.MaxLength = 50
        Properties.OnChange = edtTENANT_NAMEPropertiesChange
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtSHORT_TENANT_NAME: TcxTextEdit
        Tag = 2
        Left = 87
        Top = 63
        Width = 121
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 2
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtLICENSE_CODE: TcxTextEdit
        Tag = 3
        Left = 360
        Top = 63
        Width = 121
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 6
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtPASSWRD: TcxTextEdit
        Tag = 4
        Left = 87
        Top = 87
        Width = 121
        Height = 20
        Properties.EchoMode = eemPassword
        Properties.MaxLength = 25
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtPASSWRD1: TcxTextEdit
        Tag = 5
        Left = 87
        Top = 111
        Width = 121
        Height = 20
        Properties.EchoMode = eemPassword
        Properties.MaxLength = 25
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtREGION_ID: TzrComboBoxList
        Tag = 6
        Left = 360
        Top = 87
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 7
        InGrid = False
        KeyValue = Null
        FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_ID'
            Footers = <>
            Title.Caption = #20195#30721
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #22320#22495#21517#31216
            Width = 122
          end>
        DropWidth = 160
        DropHeight = 200
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object edtTENANT_SPELL: TcxTextEdit
        Tag = 2
        Left = 360
        Top = 39
        Width = 121
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 5
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 35
    Top = 300
  end
  inherited actList: TActionList
    Left = 66
    Top = 300
  end
  object CdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 5
    Top = 300
  end
end
