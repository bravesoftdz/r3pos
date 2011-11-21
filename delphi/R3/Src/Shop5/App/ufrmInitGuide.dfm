inherited frmInitGuide: TfrmInitGuide
  Left = 482
  BorderStyle = bsNone
  Caption = #21021#22987#21270
  ClientHeight = 366
  ClientWidth = 562
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 562
    Height = 366
    Align = alClient
    BorderOuter = fsNone
    BorderColor = 16440232
    BorderHighlight = 16440232
    BorderShadow = 16440232
    BorderWidth = 1
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 1
      Top = 1
      Width = 560
      Height = 40
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 0
      object RzFormShape1: TRzFormShape
        Left = 0
        Top = 0
        Width = 560
        Height = 40
      end
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 560
        Height = 40
        Align = alClient
        ParentShowHint = False
        ShowHint = False
      end
      object Image2: TImage
        Left = 7
        Top = 12
        Width = 16
        Height = 16
        AutoSize = True
        Stretch = True
      end
      object Label16: TLabel
        Left = 28
        Top = 12
        Width = 98
        Height = 14
        Caption = #31995#32479#21021#22987#21270#21521#23548
        Color = clWhite
        Font.Charset = GB2312_CHARSET
        Font.Color = clWhite
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
    end
    object RzPanel3: TRzPanel
      Left = 1
      Top = 326
      Width = 560
      Height = 39
      Align = alBottom
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 1
      object btn_Start: TRzBmpButton
        Left = 440
        Top = 3
        Height = 25
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        TabOrder = 0
        OnClick = btn_StartClick
      end
      object btn_Prev: TRzBmpButton
        Left = 339
        Top = 3
        Height = 25
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        TabOrder = 1
        OnClick = btn_PrevClick
      end
      object btn_End: TRzBmpButton
        Left = 440
        Top = 3
        Height = 25
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        TabOrder = 3
        OnClick = btn_EndClick
      end
      object btn_Next: TRzBmpButton
        Left = 440
        Top = 3
        Height = 25
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        TabOrder = 2
        OnClick = btn_NextClick
      end
    end
    object RzPanel4: TRzPanel
      Left = 1
      Top = 41
      Width = 560
      Height = 285
      Align = alClient
      BorderOuter = fsNone
      TabOrder = 2
      object RzBackground1: TRzBackground
        Left = 0
        Top = 0
        Width = 560
        Height = 89
        Active = True
        Align = alTop
        GradientColorStart = 15910234
        GradientColorStop = clWhite
        ImageStyle = isCenter
        ShowGradient = True
        ShowImage = False
        ShowTexture = False
      end
      object RzBackground3: TRzBackground
        Left = 0
        Top = 89
        Width = 560
        Height = 196
        Active = True
        Align = alClient
        GradientColorStart = clWhite
        GradientColorStop = clWhite
        ImageStyle = isCenter
        ShowGradient = True
        ShowImage = False
        ShowTexture = False
      end
      object RzPanel5: TRzPanel
        Left = 7
        Top = 14
        Width = 546
        Height = 265
        BorderOuter = fsFlatRounded
        Color = clWhite
        TabOrder = 0
        object Rz_page: TRzPageControl
          Left = 2
          Top = 2
          Width = 542
          Height = 261
          ActivePage = TabSheet5
          Align = alClient
          FlatColor = clWhite
          ShowFullFrame = False
          ShowShadow = False
          TabIndex = 4
          TabOrder = 0
          FixedDimension = 18
          object TabSheet1: TRzTabSheet
            Color = clWhite
            Caption = #24320#22987#21521#23548
            object Panel1: TPanel
              Left = 0
              Top = 0
              Width = 542
              Height = 242
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object Label2: TLabel
                Left = 152
                Top = 19
                Width = 252
                Height = 20
                Caption = #27426#36814#20351#29992#31995#32479#21021#22987#21270#21521#23548#65281
                Font.Charset = GB2312_CHARSET
                Font.Color = 7446527
                Font.Height = -20
                Font.Name = #24188#22278
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label17: TLabel
                Left = 74
                Top = 54
                Width = 228
                Height = 12
                Caption = #31532#19968#27425#20351#29992#26102#65292#35831#26681#25454#21521#23548#25552#31034#35748#30495#36873#25321#12290
                WordWrap = True
              end
              object Label18: TLabel
                Left = 114
                Top = 85
                Width = 166
                Height = 98
                Caption = #21451#24773#25552#31034'<'#27493#39588'>'#65306#13#13'1.'#35774#32622#31995#32479#21551#29992#26085#26399#65307#13#13'2.'#35774#32622#32463#33829#33539#22260#65307#13#13'3.'#35774#32622#24050#36830#25509#30828#20214#35774#22791#65307
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
            end
          end
          object TabSheet2: TRzTabSheet
            Color = clWhite
            Caption = #26159#21542#21551#29992
            object RzPanel7: TRzPanel
              Left = 0
              Top = 0
              Width = 542
              Height = 242
              Align = alClient
              BorderOuter = fsNone
              Color = clWhite
              TabOrder = 0
              object Label8: TLabel
                Left = 90
                Top = 29
                Width = 48
                Height = 12
                Caption = #21551#29992#26085#26399
              end
              object RzLabel1: TRzLabel
                Left = 109
                Top = 87
                Width = 312
                Height = 36
                Caption = #35774#32622#32463#33829#33539#22260#21518#65292#31995#32479#23558#20026#20320#33258#21160#23548#20837#24120#29992#22522#30784#36164#26009#65292#13#13#20943#23569#20320#30340#21021#22987#21270#24037#20316#37327
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object RzLabel2: TRzLabel
                Left = 108
                Top = 167
                Width = 221
                Height = 36
                Caption = #22914#26524#20320#30340#30005#33041#26377#22806#25509#35774#22791#65292#35831#25171#19978#21246';'#13#13#20363#65306#23567#31080#25171#21360#26426#12289#39038#23458#26174#31034#23631#12289#38065#31665#31561
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object edtIsData: TcxCheckBox
                Left = 88
                Top = 64
                Width = 156
                Height = 21
                Properties.DisplayUnchecked = 'False'
                Properties.Caption = #35774#32622#32463#33829#33539#22260
                State = cbsChecked
                TabOrder = 0
              end
              object edtIsDevice: TcxCheckBox
                Left = 88
                Top = 144
                Width = 161
                Height = 21
                Properties.DisplayUnchecked = 'False'
                Properties.Caption = #35774#32622#24050#36830#25509#30828#20214#35774#22791
                State = cbsChecked
                TabOrder = 1
              end
              object edtUSING_DATE: TcxDateEdit
                Left = 142
                Top = 25
                Width = 121
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                TabOrder = 2
              end
            end
          end
          object TabSheet3: TRzTabSheet
            Color = clWhite
            Caption = #36164#26009#24211
            object RzPanel8: TRzPanel
              Left = 0
              Top = 0
              Width = 542
              Height = 242
              Align = alClient
              BorderOuter = fsNone
              Color = clWhite
              TabOrder = 0
              object RzPanel9: TRzPanel
                Left = 5
                Top = 3
                Width = 274
                Height = 234
                BorderOuter = fsFlatRounded
                Color = clWhite
                TabOrder = 0
                object RzLabel3: TRzLabel
                  Left = 4
                  Top = 5
                  Width = 264
                  Height = 180
                  Caption = 
                    #13#13'    '#35831#22312#21491#36793#30340#21015#34920#20013#36873#25321#20320#25152#32463#33829#30340#21830#21697#33539#22260#65292#13#13#31995#32479#23558#33258#21160#23548#20837#30456#20851#22522#30784#36164#26009';'#31995#32479#25552#20379'120'#22810#19975#20010#13#13#21830#21697#26465#30721#24211#65292#22312#32500#25252#21830 +
                    #21697#26102#21047#20837#26465#30721#31995#32479#23558#33258#21160#26174#13#13#31034#26465#30721#30456#20851#36164#26009#12290#13#13'   '#23548#20837#36164#26009#22914#19979#65306#13#13'   1.'#23548#20837#21830#21697#20998#31867#24211';'#13'    '#13'   2.'#23548#20837#24120#29992 +
                    #30340#35745#37327#21333#20301';'
                end
              end
              object rzCheckTree: TRzCheckTree
                Left = 285
                Top = 4
                Width = 258
                Height = 232
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                FrameVisible = True
                Indent = 19
                ParentFont = False
                RowSelect = True
                SelectionPen.Color = clBtnShadow
                StateImages = rzCheckTree.CheckImages
                TabOrder = 1
              end
            end
          end
          object TabSheet4: TRzTabSheet
            Color = clWhite
            Caption = #21442#25968#35774#32622
            object RzPanel6: TRzPanel
              Left = 0
              Top = 0
              Width = 542
              Height = 242
              Align = alClient
              BorderOuter = fsNone
              Color = clWhite
              TabOrder = 0
              object RzGroupBox1: TRzGroupBox
                Left = 274
                Top = 8
                Width = 255
                Height = 153
                Caption = #23567#31080#25171#21360#26426
                Color = clWhite
                TabOrder = 0
                object Label9: TLabel
                  Left = 6
                  Top = 64
                  Width = 60
                  Height = 12
                  Caption = #36208#32440#34917#31354#34892
                end
                object Label10: TLabel
                  Left = 18
                  Top = 41
                  Width = 48
                  Height = 12
                  Caption = #25171#21360#32440#23485
                end
                object Label4: TLabel
                  Left = 6
                  Top = 18
                  Width = 60
                  Height = 12
                  Caption = #25171#21360#26426#31471#21475
                end
                object Label5: TLabel
                  Left = 18
                  Top = 87
                  Width = 48
                  Height = 12
                  Caption = #22797#21046#25171#21360
                end
                object Label7: TLabel
                  Left = 18
                  Top = 133
                  Width = 48
                  Height = 12
                  Caption = #25171#21360#21697#21517
                end
                object Label11: TLabel
                  Left = 18
                  Top = 110
                  Width = 48
                  Height = 12
                  Caption = #25171#21360#26631#39064
                end
                object cxNullRow: TcxSpinEdit
                  Left = 73
                  Top = 60
                  Width = 121
                  Height = 20
                  TabOrder = 0
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object edtPRINTERWIDTH: TcxComboBox
                  Left = 73
                  Top = 37
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    '57.5'#177'0.5mm'
                    '79.5'#177'0.5mm')
                  TabOrder = 1
                end
                object edtTicketPrintComm: TcxComboBox
                  Left = 73
                  Top = 14
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #27809#23433#35013
                    'LPT1'
                    'LPT2'
                    'LPT3'
                    'LPT4'
                    'COM1'
                    'COM2'
                    'COM3'
                    'COM4'
                    'COM5'
                    'COM6'
                    'COM7'
                    'COM8'
                    'COM9'
                    'COM10'
                    'COM11'
                    'COM12'
                    'COM13'
                    'COM14'
                    'COM15'
                    'COM16'
                    'COM17'
                    'COM18'
                    'COM19'
                    'COM20'
                    'COM21'
                    'COM22'
                    'COM23'
                    'COM24'
                    'COM25'
                    'Windows'#39537#21160
                    #35843#35797#27169#24335)
                  TabOrder = 2
                end
                object edtTicketCopy: TcxSpinEdit
                  Left = 73
                  Top = 83
                  Width = 121
                  Height = 20
                  TabOrder = 3
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object edtTICKET_PRINT_NAME: TcxComboBox
                  Left = 73
                  Top = 129
                  Width = 175
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #21697#21517
                    #21697#21517'+'#36135#21495
                    #21697#21517'+'#26465#30721
                    #21697#21517'+'#35268#26684
                    #21697#21517'+'#35268#26684'+'#36135#21495
                    #21697#21517'+'#35268#26684'+'#26465#30721)
                  TabOrder = 4
                end
                object edtTitle: TcxTextEdit
                  Left = 73
                  Top = 106
                  Width = 175
                  Height = 20
                  TabOrder = 5
                  Text = 'edtTitle'
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
              end
              object RzGroupBox2: TRzGroupBox
                Left = 12
                Top = 168
                Width = 255
                Height = 63
                Caption = #39038#23458#26174#31034#23631
                Color = clWhite
                TabOrder = 1
                object Label12: TLabel
                  Left = 8
                  Top = 17
                  Width = 84
                  Height = 12
                  Caption = #39038#23458#26174#31034#23631#31471#21475
                end
                object Label13: TLabel
                  Left = 67
                  Top = 42
                  Width = 24
                  Height = 12
                  Caption = #36895#29575
                end
                object cxDisplay: TcxComboBox
                  Left = 93
                  Top = 14
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #27809#23433#35013
                    'COM1'
                    'COM2'
                    'COM3'
                    'COM4'
                    'COM5'
                    'COM6'
                    'COM7'
                    'COM8'
                    'COM9')
                  TabOrder = 0
                end
                object cxDisplayBaudRate: TcxComboBox
                  Left = 93
                  Top = 38
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    '2400'
                    '9600'
                    '115200')
                  TabOrder = 1
                end
              end
              object RzGroupBox3: TRzGroupBox
                Left = 274
                Top = 168
                Width = 255
                Height = 63
                Caption = #38065#31665#35774#32622
                Color = clWhite
                TabOrder = 2
                object Label14: TLabel
                  Left = 9
                  Top = 16
                  Width = 72
                  Height = 12
                  Caption = #38065#31665#25511#21046#24320#20851
                end
                object Label15: TLabel
                  Left = 57
                  Top = 41
                  Width = 24
                  Height = 12
                  Caption = #36895#29575
                end
                object cxCashBox: TcxComboBox
                  Left = 89
                  Top = 12
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #27809#23433#35013
                    #25509#25171#21360#26426
                    'COM1'
                    'COM2'
                    'COM3'
                    'COM4'
                    'COM5'
                    'COM6'
                    'COM7'
                    'COM8'
                    'COM9')
                  TabOrder = 0
                end
                object cxCashBoxRate: TcxComboBox
                  Left = 89
                  Top = 37
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    '2400'
                    '9600'
                    '115200')
                  TabOrder = 1
                end
              end
              object RzGroupBox4: TRzGroupBox
                Left = 12
                Top = 8
                Width = 255
                Height = 153
                Caption = #22522#30784#35774#32622
                Color = clWhite
                TabOrder = 3
                object Label3: TLabel
                  Left = 11
                  Top = 86
                  Width = 48
                  Height = 12
                  Caption = #23567#31080#35828#26126
                end
                object edtAutoRunPos: TcxCheckBox
                  Left = 7
                  Top = 15
                  Width = 199
                  Height = 21
                  Properties.DisplayUnchecked = 'False'
                  Properties.Caption = #36719#20214#21551#21160#26102#26159#21542#31435#21363#21551#21160#25910#27454#26426
                  TabOrder = 0
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object chkCloseDayPrinted: TcxCheckBox
                  Left = 7
                  Top = 37
                  Width = 157
                  Height = 21
                  Properties.DisplayUnchecked = 'False'
                  Properties.Caption = #20132#29677#32467#36134#26102#26159#21542#25171#21360#23567#31080
                  TabOrder = 1
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object edtCloseDayPrintFlag: TcxComboBox
                  Left = 165
                  Top = 37
                  Width = 79
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #25171#21360#37329#39069
                    #25171#21360#26126#32454)
                  TabOrder = 2
                end
                object cxSavePrint: TcxCheckBox
                  Left = 7
                  Top = 61
                  Width = 155
                  Height = 21
                  Properties.DisplayUnchecked = 'False'
                  Properties.Caption = #38144#21806#32467#36134#26102#26159#21542#25171#21360#23567#31080
                  TabOrder = 3
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object cxPrintFormat: TcxComboBox
                  Left = 165
                  Top = 61
                  Width = 79
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #23567#31080
                    #21333#25454)
                  TabOrder = 4
                end
                object edtFOOTER: TcxMemo
                  Left = 12
                  Top = 102
                  Width = 234
                  Height = 43
                  Lines.Strings = (
                    #25964#35831#20445#30041#23567#31080','#20197#20316#21806#21518#20381#25454)
                  TabOrder = 5
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
              end
            end
          end
          object TabSheet5: TRzTabSheet
            Color = clWhite
            Caption = #32467#26463#21521#23548
            object Label6: TLabel
              Left = 72
              Top = 88
              Width = 410
              Height = 60
              Caption = #24685#21916#24744#65281#24744#24050#25104#21151#23436#25104#31995#32479#21021#22987#21270#35774#32622#21521#23548'.'#13#13#24744#29616#22312#21487#20197#24320#22987#20351#29992#26412#31995#32479#20102#65281
              Font.Charset = GB2312_CHARSET
              Font.Color = 7446527
              Font.Height = -20
              Font.Name = #24188#22278
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 16
    Top = 368
  end
  inherited actList: TActionList
    Left = 48
    Top = 368
  end
  object CdsUsing: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 81
    Top = 367
  end
end
