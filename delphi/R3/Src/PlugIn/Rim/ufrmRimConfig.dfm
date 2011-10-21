object frmRimConfig: TfrmRimConfig
  Left = 363
  Top = 170
  BorderStyle = bsDialog
  Caption = 'RIM'#25509#21475#21442#25968
  ClientHeight = 240
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 141
    Top = 195
    Width = 75
    Height = 25
    Caption = #30830#35748'(&O)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 229
    Top = 195
    Width = 75
    Height = 25
    Caption = #21462#28040'(&C)'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 412
    Height = 56
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 24
      Top = 14
      Width = 48
      Height = 12
      Caption = #26381#21153#22320#22336
    end
    object Label2: TLabel
      Left = 82
      Top = 35
      Width = 163
      Height = 13
      Caption = #20363#65306'http://10.73.39.121:9081/rim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 81
      Top = 9
      Width = 265
      Height = 20
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 56
    Width = 412
    Height = 121
    Align = alTop
    TabOrder = 3
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 410
      Height = 47
      Align = alTop
      Caption = #20107#21153#21442#25968#35774#32622
      TabOrder = 0
      object chkTWO_PHASE_COMMIT: TCheckBox
        Left = 13
        Top = 18
        Width = 137
        Height = 17
        Caption = #26159#21542#21551#29992#20998#24067#24335#20107#21153
        TabOrder = 0
      end
      object chkCUST_PSWD: TCheckBox
        Left = 224
        Top = 14
        Width = 169
        Height = 17
        Caption = #21551#29992#23458#25143#23494#30721
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 48
      Width = 410
      Height = 73
      Align = alTop
      Caption = #28040#36153#32773#21442#25968
      TabOrder = 1
      object Label3: TLabel
        Left = 207
        Top = 48
        Width = 114
        Height = 12
        Caption = #19978#25253'Rim'#28040#36153#32773#29366#24577#65306
      end
      object CB_VipUpload: TCheckBox
        Left = 12
        Top = 21
        Width = 312
        Height = 18
        Caption = #31105#29992#19978#25253'R3'#32456#31471#28040#36153#32773#65288'R3'#32456#31471#37319#38598#30340#28040#36153#32773#19981#19978#25253#65289
        TabOrder = 0
      end
      object CB_USE_SM_CARD: TCheckBox
        Left = 13
        Top = 44
        Width = 168
        Height = 18
        Caption = #21551#29992#28040#36153#32773#65288#21830#30431#21345#19978#25253#65289
        TabOrder = 1
      end
      object Edt_VipStatus: TcxComboBox
        Left = 319
        Top = 43
        Width = 69
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        Properties.Items.Strings = (
          '00'
          '03')
        TabOrder = 2
      end
    end
  end
end
