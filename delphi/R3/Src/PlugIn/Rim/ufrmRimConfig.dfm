object frmRimConfig: TfrmRimConfig
  Left = 213
  Top = 124
  BorderStyle = bsDialog
  Caption = 'RIM'#25509#21475#21442#25968
  ClientHeight = 411
  ClientWidth = 516
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 516
    Height = 366
    ActivePage = TabSheet1
    Align = alClient
    TabHeight = 22
    TabOrder = 0
    object tabStock: TTabSheet
      Caption = '  '#31995#32479#21442#25968'  '
      ImageIndex = 1
      object GB_ITEM: TGroupBox
        Left = 0
        Top = 0
        Width = 169
        Height = 334
        Align = alLeft
        Caption = #19978#25253#36873#39033
        TabOrder = 0
        object CB_1: TCheckBox
          Left = 12
          Top = 18
          Width = 71
          Height = 15
          Caption = #19978#25253#24211#23384
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object CB_2: TCheckBox
          Left = 12
          Top = 37
          Width = 95
          Height = 18
          Caption = #19978#25253#38144#21806#27719#24635
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object CB_3: TCheckBox
          Left = 12
          Top = 59
          Width = 71
          Height = 18
          Caption = #19979#36733#28040#24687
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object CB_4: TCheckBox
          Left = 12
          Top = 81
          Width = 113
          Height = 18
          Caption = #21516#27493#28040#36153#32773'(Vip)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object CB_5: TCheckBox
          Left = 12
          Top = 104
          Width = 70
          Height = 18
          Caption = #19979#36733'wsdl'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object CB_6: TCheckBox
          Left = 12
          Top = 127
          Width = 96
          Height = 18
          Caption = #21516#27493#38382#21367#35843#26597
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object CB_7: TCheckBox
          Left = 12
          Top = 151
          Width = 108
          Height = 18
          Caption = #19978#25253#21830#21697#26085#21488#36134
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object CB_8: TCheckBox
          Left = 12
          Top = 175
          Width = 91
          Height = 18
          Caption = #19979#36733'Rim'#21442#25968
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object GB_liushui: TGroupBox
          Left = 2
          Top = 193
          Width = 165
          Height = 139
          Align = alBottom
          TabOrder = 8
          object CB_9: TCheckBox
            Left = 10
            Top = 11
            Width = 111
            Height = 18
            Caption = #19978#25253#21830#21697#26376#21488#36134
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object CB_10: TCheckBox
            Left = 10
            Top = 33
            Width = 96
            Height = 18
            Caption = #19978#25253#20837#24211#27969#27700
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object CB_11: TCheckBox
            Left = 10
            Top = 53
            Width = 96
            Height = 18
            Caption = #19978#25253#38144#21806#27969#27700
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object CB_12: TCheckBox
            Left = 10
            Top = 74
            Width = 142
            Height = 18
            Caption = #19978#25253#35843#25320#27969#27700#65288#35843#20837#65289
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object CB_13: TCheckBox
            Left = 10
            Top = 96
            Width = 142
            Height = 18
            Caption = #19978#25253#35843#25320#27969#27700#65288#35843#20986#65289
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object CB_14: TCheckBox
            Left = 10
            Top = 117
            Width = 95
            Height = 18
            Caption = #19978#25253#35843#25972#27969#27700
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
        end
      end
      object GroupBox4: TGroupBox
        Left = 169
        Top = 0
        Width = 339
        Height = 334
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object GroupBox1: TGroupBox
          Left = 2
          Top = 14
          Width = 335
          Height = 54
          Align = alTop
          Caption = #20107#21153#21442#25968#35774#32622
          TabOrder = 0
          object chkTWO_PHASE_COMMIT: TCheckBox
            Left = 13
            Top = 21
            Width = 131
            Height = 17
            Caption = #26159#21542#21551#29992#20998#24067#24335#20107#21153
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = '  '#25554#20214#21442#25968'  '
      ImageIndex = 2
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 508
        Height = 81
        Align = alTop
        Caption = #28040#36153#32773#21442#25968
        TabOrder = 0
        object Label3: TLabel
          Left = 235
          Top = 52
          Width = 114
          Height = 12
          Caption = #19978#25253'Rim'#28040#36153#32773#29366#24577#65306
        end
        object CB_VipUpload: TCheckBox
          Left = 12
          Top = 23
          Width = 190
          Height = 18
          Caption = #31105#29992#19978#25253'R3'#32456#31471#37319#38598#24405#20837#28040#36153#32773
          TabOrder = 0
        end
        object CB_USE_SM_CARD: TCheckBox
          Left = 12
          Top = 49
          Width = 164
          Height = 18
          Caption = #21551#29992#28040#36153#32773#65288#21830#30431#21345#19978#25253#65289
          TabOrder = 1
        end
        object Edt_VipStatus: TcxComboBox
          Left = 347
          Top = 47
          Width = 78
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          Properties.Items.Strings = (
            '00'
            '03')
          TabOrder = 2
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 81
        Width = 508
        Height = 253
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object GroupBox6: TGroupBox
          Left = 0
          Top = 71
          Width = 508
          Height = 73
          Align = alTop
          Caption = #26085#21488#36134#25554#20214#21442#25968
          TabOrder = 0
          object CB_USE_CALC_RCKDAY: TCheckBox
            Left = 8
            Top = 34
            Width = 202
            Height = 18
            Caption = #21551#29992#26085#21488#36134#19978#25253#21069#33258#21160#35797#31639#26085#21488#36134
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBox7: TGroupBox
          Left = 0
          Top = 0
          Width = 508
          Height = 71
          Align = alTop
          Caption = #23545#29031#25554#20214#21442#25968
          TabOrder = 1
          object CB_AUTO_DOWN_BASEINFO: TCheckBox
            Left = 7
            Top = 29
            Width = 218
            Height = 18
            Caption = #21551#29992#23545#29031#21069#33258#21160#19979#36733'Rsp'#22522#30784#25968#25454
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '  '#32456#31471#19978#25253#35774#32622'  '
      ImageIndex = 3
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 508
        Height = 74
        Align = alTop
        Caption = 'WDSL'#21442#25968
        TabOrder = 0
        object chkCUST_PSWD: TCheckBox
          Left = 371
          Top = 24
          Width = 94
          Height = 17
          Caption = #21551#29992#23458#25143#23494#30721
          TabOrder = 0
        end
        object Panel1: TPanel
          Left = 2
          Top = 14
          Width = 367
          Height = 47
          BevelOuter = bvNone
          TabOrder = 1
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
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 74
        Width = 508
        Height = 65
        Align = alTop
        Caption = #28040#24687#25554#20214#21442#25968
        TabOrder = 1
        object CB_AUTO_DOWN_ORDER: TCheckBox
          Left = 10
          Top = 26
          Width = 155
          Height = 18
          Caption = #21551#29992#33258#21160#21040#36135#30830#35748#28040#24687
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 366
    Width = 516
    Height = 45
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object BtnOk: TButton
      Left = 193
      Top = 10
      Width = 75
      Height = 25
      Caption = #30830#35748'(&O)'
      TabOrder = 0
      OnClick = BtnOkClick
    end
    object BtnClose: TButton
      Left = 273
      Top = 10
      Width = 75
      Height = 25
      Caption = #21462#28040'(&C)'
      TabOrder = 1
      OnClick = BtnCloseClick
    end
  end
end
