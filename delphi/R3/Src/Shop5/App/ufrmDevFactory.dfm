object frmDevFactory: TfrmDevFactory
  Left = 547
  Top = 243
  BorderStyle = bsDialog
  Caption = #25910#38134#35774#22791#21442#25968
  ClientHeight = 244
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object btnOK: TRzBitBtn
    Left = 141
    Top = 206
    Width = 71
    ModalResult = 1
    Caption = #30830#23450'(&O)'
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TRzBitBtn
    Left = 229
    Top = 206
    Width = 71
    Cancel = True
    ModalResult = 2
    Caption = #21462#28040'(&C)'
    Color = 15791348
    HighlightColor = 16026986
    HotTrack = True
    HotTrackColor = 3983359
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 337
    Height = 193
    ActivePage = TabSheet4
    Align = alTop
    TabOrder = 2
    object TabSheet4: TTabSheet
      Caption = #22522#30784#35774#32622
      ImageIndex = 3
      object Bevel4: TBevel
        Left = 4
        Top = 3
        Width = 320
        Height = 159
        Shape = bsFrame
      end
      object Label1: TLabel
        Left = 20
        Top = 105
        Width = 48
        Height = 12
        Caption = #23567#31080#35828#26126
      end
      object edtAutoRunPos: TcxCheckBox
        Left = 16
        Top = 18
        Width = 257
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #36719#20214#21551#21160#26102#26159#21542#31435#21363#21551#21160#25910#27454#26426
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object chkCloseDayPrinted: TcxCheckBox
        Left = 16
        Top = 44
        Width = 157
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20132#29677#32467#36134#26102#26159#21542#25171#21360#23567#31080
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtCloseDayPrintFlag: TcxComboBox
        Left = 174
        Top = 44
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
        Left = 16
        Top = 71
        Width = 155
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #38144#21806#32467#36134#26102#26159#21542#25171#21360#23567#31080
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object cxPrintFormat: TcxComboBox
        Left = 174
        Top = 71
        Width = 79
        Height = 20
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #23567#31080
          #21333#25454)
        TabOrder = 4
      end
      object edtFOOTER: TcxMemo
        Left = 76
        Top = 101
        Width = 223
        Height = 43
        Lines.Strings = (
          #25964#35831#20445#30041#23567#31080','#20197#20316#21806#21518#20381#25454)
        TabOrder = 5
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    object TabSheet1: TTabSheet
      Caption = #23567#31080#25171#21360#26426
      ImageIndex = 1
      object Bevel2: TBevel
        Left = 4
        Top = 3
        Width = 320
        Height = 159
        Shape = bsFrame
      end
      object Label9: TLabel
        Left = 176
        Top = 33
        Width = 60
        Height = 12
        Caption = #36208#32440#34917#31354#34892
      end
      object Label10: TLabel
        Left = 17
        Top = 61
        Width = 48
        Height = 12
        Caption = #25171#21360#32440#23485
      end
      object Label4: TLabel
        Left = 18
        Top = 33
        Width = 60
        Height = 12
        Caption = #25171#21360#26426#31471#21475
      end
      object Label3: TLabel
        Left = 187
        Top = 62
        Width = 48
        Height = 12
        Caption = #22797#21046#25171#21360
      end
      object Label6: TLabel
        Left = 17
        Top = 117
        Width = 48
        Height = 12
        Caption = #25171#21360#21697#21517
      end
      object Label11: TLabel
        Left = 17
        Top = 89
        Width = 48
        Height = 12
        Caption = #25171#21360#26631#39064
      end
      object cxNullRow: TcxSpinEdit
        Left = 244
        Top = 29
        Width = 51
        Height = 20
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtPRINTERWIDTH: TcxComboBox
        Left = 72
        Top = 57
        Width = 89
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          '57.5'#177'0.5mm'
          '79.5'#177'0.5mm')
        TabOrder = 1
      end
      object edtTicketPrintComm: TcxComboBox
        Left = 83
        Top = 29
        Width = 78
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
          #35843#35797#27169#24335)
        TabOrder = 2
      end
      object edtTicketCopy: TcxSpinEdit
        Left = 244
        Top = 58
        Width = 51
        Height = 20
        TabOrder = 3
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object edtTICKET_PRINT_NAME: TcxComboBox
        Left = 72
        Top = 113
        Width = 137
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
        Left = 72
        Top = 85
        Width = 137
        Height = 20
        TabOrder = 5
        Text = 'edtTitle'
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
    end
    object TabSheet2: TTabSheet
      Caption = #39038#23458#26174#31034#23631
      ImageIndex = 1
      object Label5: TLabel
        Left = 27
        Top = 29
        Width = 84
        Height = 12
        Caption = #39038#23458#26174#31034#23631#31471#21475
      end
      object Label7: TLabel
        Left = 89
        Top = 53
        Width = 24
        Height = 12
        Caption = #36895#29575
      end
      object Bevel1: TBevel
        Left = 4
        Top = 3
        Width = 320
        Height = 159
        Shape = bsFrame
      end
      object cxDisplay: TcxComboBox
        Left = 124
        Top = 26
        Width = 73
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
        Left = 124
        Top = 49
        Width = 73
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
    object TabSheet3: TTabSheet
      Caption = #38065#31665#35774#32622
      ImageIndex = 2
      object Label8: TLabel
        Left = 28
        Top = 33
        Width = 72
        Height = 12
        Caption = #38065#31665#25511#21046#24320#20851
      end
      object Label2: TLabel
        Left = 76
        Top = 57
        Width = 24
        Height = 12
        Caption = #36895#29575
      end
      object Bevel3: TBevel
        Left = 4
        Top = 3
        Width = 320
        Height = 159
        Shape = bsFrame
      end
      object cxCashBox: TcxComboBox
        Left = 108
        Top = 29
        Width = 73
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
        Left = 108
        Top = 53
        Width = 73
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
  end
end
