inherited frmSysDefine: TfrmSysDefine
  Left = 453
  Top = 212
  Width = 434
  Height = 323
  BorderIcons = [biSystemMenu]
  Caption = #31995#32479#21442#25968#35774#32622
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl [0]
    Left = 0
    Top = 0
    Width = 418
    Height = 242
    ActivePage = tabBasic
    Align = alClient
    TabOrder = 0
    object tabBasic: TTabSheet
      Caption = #22522#30784#21442#25968
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 410
        Height = 215
        Align = alClient
        Shape = bsFrame
      end
      object Label5: TLabel
        Left = 18
        Top = 13
        Width = 48
        Height = 12
        Caption = #21551#29992#26085#26399
      end
      object edtUSING_DATE: TcxDateEdit
        Left = 70
        Top = 9
        Width = 121
        Height = 20
        TabOrder = 0
      end
      object edtZERO_OUT: TcxCheckBox
        Left = 222
        Top = 9
        Width = 153
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20801#35768#38646#24211#23384#20986#24211
        TabOrder = 1
      end
      object GroupBox2: TGroupBox
        Left = 18
        Top = 36
        Width = 196
        Height = 77
        Caption = #25104#26412#26680#31639
        TabOrder = 2
        object Label24: TLabel
          Left = 10
          Top = 24
          Width = 48
          Height = 12
          Caption = #25104#26412#31867#22411
        end
        object chkCheckAudit: TCheckBox
          Left = 11
          Top = 48
          Width = 134
          Height = 17
          Caption = #26376#26410#26159#21542#24378#21046#30424#28857
          TabOrder = 0
        end
        object edtCALC_FLAG: TcxComboBox
          Left = 63
          Top = 20
          Width = 114
          Height = 20
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #31227#21160#21152#26435#24179#22343
            #26085#31227#21160#21152#26435#24179#22343
            #26376#31227#21160#21152#26435#24179#22343)
          TabOrder = 1
        end
      end
      object GroupBox5: TGroupBox
        Left = 18
        Top = 120
        Width = 196
        Height = 81
        Caption = #26376#32467#36873#39033
        TabOrder = 3
        object edtRECK_OPTION1: TcxRadioButton
          Left = 16
          Top = 21
          Width = 113
          Height = 17
          Caption = #26376#24213#32467#24080
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object edtRECK_OPTION2: TcxRadioButton
          Left = 16
          Top = 50
          Width = 145
          Height = 17
          Caption = #27599#26376#30340'        '#21495#32467#24080
          TabOrder = 1
        end
        object edtRECK_DAY: TcxSpinEdit
          Left = 75
          Top = 48
          Width = 41
          Height = 20
          Properties.MaxValue = 28.000000000000000000
          Properties.MinValue = 26.000000000000000000
          TabOrder = 2
          Value = 28
        end
      end
      object GroupBox6: TGroupBox
        Left = 226
        Top = 36
        Width = 169
        Height = 77
        Caption = #36755#20837#36873#39033
        TabOrder = 4
        object Label18: TLabel
          Left = 12
          Top = 24
          Width = 48
          Height = 12
          Caption = #36755#20837#26041#24335
        end
        object edtINPUT_MODE: TcxComboBox
          Left = 66
          Top = 21
          Width = 82
          Height = 20
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #26465#30721#36755#20837
            #36135#21495#36755#20837)
          TabOrder = 0
        end
        object edtDECIAMOUNT: TcxCheckBox
          Left = 8
          Top = 47
          Width = 153
          Height = 21
          Properties.DisplayUnchecked = 'False'
          Properties.ReadOnly = False
          Properties.Caption = #20801#35768#36755#20837#23567#25968#30340#25968#37327
          TabOrder = 1
        end
      end
    end
    object tabStock: TTabSheet
      Caption = #20107#21153#25552#37266
      ImageIndex = 1
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 410
        Height = 215
        Align = alClient
        Shape = bsFrame
      end
      object Label13: TLabel
        Left = 30
        Top = 13
        Width = 96
        Height = 12
        Caption = #21551#29992#20250#21592#29983#26085#25552#31034
      end
      object Label14: TLabel
        Left = 30
        Top = 59
        Width = 96
        Height = 12
        Caption = #21551#29992#20179#24211#39044#35686#25552#31034
      end
      object BirthDayLb: TLabel
        Left = 160
        Top = 13
        Width = 24
        Height = 12
        Caption = #25552#21069
      end
      object BirthDayLb1: TLabel
        Left = 238
        Top = 13
        Width = 12
        Height = 12
        Caption = #22825
      end
      object ContinuLb: TLabel
        Left = 160
        Top = 35
        Width = 24
        Height = 12
        Caption = #25552#21069
      end
      object ContinuLb1: TLabel
        Left = 238
        Top = 35
        Width = 12
        Height = 12
        Caption = #22825
      end
      object Label15: TLabel
        Left = 30
        Top = 35
        Width = 96
        Height = 12
        Caption = #21551#29992#20250#21592#32493#20250#25552#37266
      end
      object BirthDays: TcxSpinEdit
        Left = 186
        Top = 9
        Width = 50
        Height = 20
        Properties.MaxValue = 100.000000000000000000
        TabOrder = 0
        Value = 2
      end
      object ContinuDays: TcxSpinEdit
        Left = 186
        Top = 31
        Width = 50
        Height = 20
        Properties.MaxValue = 100.000000000000000000
        TabOrder = 1
        Value = 10
      end
      object IsBirthDay: TcxCheckBox
        Left = 8
        Top = 9
        Width = 21
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = IsBirthDayPropertiesChange
        Properties.Caption = ''
        State = cbsChecked
        TabOrder = 2
      end
      object IsContinu: TcxCheckBox
        Left = 8
        Top = 30
        Width = 21
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = IsContinuPropertiesChange
        Properties.Caption = ''
        State = cbsChecked
        TabOrder = 3
      end
      object IsStorage: TcxCheckBox
        Left = 8
        Top = 55
        Width = 21
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = ''
        State = cbsChecked
        TabOrder = 4
      end
      object edtAUDIT_HINT: TcxCheckBox
        Left = 8
        Top = 81
        Width = 153
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #24453#23457#26680#21333#25454#25552#37266
        TabOrder = 5
      end
      object edtPLANDATE_HINT: TcxCheckBox
        Left = 8
        Top = 105
        Width = 153
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #21040#36135#21457#36135#25552#37266
        TabOrder = 6
      end
      object edtACCOUNT_HINT: TcxCheckBox
        Left = 8
        Top = 129
        Width = 153
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #25910#20184#24080#27454#25552#37266
        TabOrder = 7
      end
    end
    object TabSheet1: TTabSheet
      Caption = #26465#30721#35774#32622
      ImageIndex = 2
      object Bevel5: TBevel
        Left = 0
        Top = 0
        Width = 410
        Height = 215
        Align = alClient
        Shape = bsFrame
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 337
        Height = 137
        Caption = #25955#35013#26465#30721#35774#32622
        TabOrder = 0
        object Label7: TLabel
          Left = 16
          Top = 32
          Width = 48
          Height = 12
          Caption = #26631' '#35782' '#30721
        end
        object Label9: TLabel
          Left = 16
          Top = 56
          Width = 48
          Height = 12
          Caption = #21830#21697#20195#30721
        end
        object Label10: TLabel
          Left = 22
          Top = 80
          Width = 42
          Height = 12
          Caption = #25968#25454#27573'1'
        end
        object Label11: TLabel
          Left = 22
          Top = 104
          Width = 42
          Height = 12
          Caption = #25968#25454#27573'2'
        end
        object Label16: TLabel
          Left = 222
          Top = 80
          Width = 36
          Height = 12
          Caption = #20301#23567#25968
        end
        object Label17: TLabel
          Left = 222
          Top = 104
          Width = 36
          Height = 12
          Caption = #20301#23567#25968
        end
        object edtFlag: TcxTextEdit
          Left = 71
          Top = 28
          Width = 82
          Height = 20
          TabOrder = 0
        end
        object edtDEC1: TcxTextEdit
          Left = 195
          Top = 76
          Width = 25
          Height = 20
          TabOrder = 1
        end
        object edtDEC2: TcxTextEdit
          Left = 195
          Top = 100
          Width = 25
          Height = 20
          TabOrder = 2
        end
        object RzBitBtn1: TRzBitBtn
          Left = 185
          Top = 35
          Width = 59
          Height = 22
          Caption = #40664#35748
          Color = 15791348
          HighlightColor = 16026986
          HotTrack = True
          HotTrackColor = 3983359
          TabOrder = 3
          OnClick = RzBitBtn1Click
        end
        object edtID: TcxComboBox
          Left = 71
          Top = 51
          Width = 82
          Height = 20
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '1'#20301#25968
            '2'#20301#25968
            '3'#20301#25968
            '4'#20301#25968
            '5'#20301#25968
            '6'#20301#25968)
          TabOrder = 4
        end
        object edtID1: TcxComboBox
          Left = 71
          Top = 76
          Width = 58
          Height = 20
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #26080
            #21333#20215
            #37329#39069
            #25968#37327)
          TabOrder = 5
        end
        object edtID2: TcxComboBox
          Left = 71
          Top = 100
          Width = 58
          Height = 20
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #26080
            #21333#20215
            #37329#39069
            #25968#37327)
          TabOrder = 6
        end
        object edtLEN1: TcxComboBox
          Left = 129
          Top = 76
          Width = 65
          Height = 20
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '1'#20301#25968
            '2'#20301#25968
            '3'#20301#25968
            '4'#20301#25968
            '5'#20301#25968
            '6'#20301#25968)
          TabOrder = 7
        end
        object edtLEN2: TcxComboBox
          Left = 129
          Top = 100
          Width = 65
          Height = 20
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '1'#20301#25968
            '2'#20301#25968
            '3'#20301#25968
            '4'#20301#25968
            '5'#20301#25968
            '6'#20301#25968)
          TabOrder = 8
        end
      end
      object edtDUPBARCODE: TcxCheckBox
        Left = 6
        Top = 155
        Width = 283
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #26159#21542#20801#35768#26465#30721#37325#22797#20351#29992#65288#21363#19968#30721#22810#21697#65289
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = #38144#21806#21442#25968
      ImageIndex = 3
      object Bevel3: TBevel
        Left = 0
        Top = 0
        Width = 410
        Height = 215
        Align = alClient
        Shape = bsFrame
      end
      object Label21: TLabel
        Left = 19
        Top = 129
        Width = 114
        Height = 12
        Caption = #20445#30041#23567#25968'         '#20301
      end
      object Label8: TLabel
        Left = 152
        Top = 129
        Width = 48
        Height = 12
        Caption = #36827#20301#27861#21017
      end
      object Label22: TLabel
        Left = 19
        Top = 161
        Width = 72
        Height = 12
        Caption = #32467#24080#26102#25273#38646#33267
      end
      object Label4: TLabel
        Left = 20
        Top = 16
        Width = 72
        Height = 12
        Caption = #40664#35748#31080#25454#31867#22411
      end
      object edtPosDight: TcxSpinEdit
        Left = 73
        Top = 125
        Width = 41
        Height = 20
        Properties.MaxValue = 3.000000000000000000
        TabOrder = 0
        Value = 2
      end
      object edtCARRYRULE: TcxComboBox
        Left = 204
        Top = 125
        Width = 119
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #22235#33293#20116#20837
          #22235#36827#20116#12289#20061#36827#21313
          #30452#25509#33293#21435#23567#25968#20301
          #22235#33293#20445#20116#20845#20837)
        TabOrder = 1
      end
      object GroupBox3: TGroupBox
        Left = 18
        Top = 40
        Width = 191
        Height = 73
        Caption = #38144#39033#31246#29575
        TabOrder = 2
        object Label2: TLabel
          Left = 20
          Top = 45
          Width = 48
          Height = 12
          Caption = #22320#31246#31246#29575
        end
        object Label12: TLabel
          Left = 20
          Top = 22
          Width = 48
          Height = 12
          Caption = #22269#31246#31246#29575
        end
        object edtRTL_RATE2: TcxSpinEdit
          Left = 75
          Top = 39
          Width = 65
          Height = 20
          Properties.Increment = 0.010000000000000000
          Properties.MaxValue = 100.000000000000000000
          Properties.ValueType = vtFloat
          TabOrder = 0
          Value = 0.050000000000000000
        end
        object edtRTL_RATE3: TcxSpinEdit
          Left = 75
          Top = 18
          Width = 65
          Height = 20
          Properties.Increment = 0.010000000000000000
          Properties.MaxValue = 100.000000000000000000
          Properties.ValueType = vtFloat
          TabOrder = 1
          Value = 0.170000000000000000
        end
      end
      object edtRTL_INV_FLAG: TcxComboBox
        Left = 105
        Top = 12
        Width = 104
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #25910#27454#25910#31080
          #26222#36890#21457#31080
          #22686#20540#31246#31080)
        TabOrder = 3
      end
      object chkSaveSalesPrint: TcxCheckBox
        Left = 14
        Top = 184
        Width = 179
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20445#23384#26102#26159#21542#31435#21363#25171#21360#21333#25454
        TabOrder = 4
      end
      object edtPOSCALCDIGHT: TcxComboBox
        Left = 100
        Top = 157
        Width = 53
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #20998
          #35282
          #20803
          #21313
          #30334)
        TabOrder = 5
      end
      object edtGUIDE_USER: TcxCheckBox
        Left = 230
        Top = 12
        Width = 147
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.ReadOnly = False
        Properties.Caption = #27809#26377#36755#20837#23548#36141#21592#33021#32467#36134
        TabOrder = 6
      end
      object GroupBox7: TGroupBox
        Left = 232
        Top = 40
        Width = 162
        Height = 73
        Caption = #25209#21457#26102#20215#26684#21462#21521
        TabOrder = 7
        object edtOutLevel1: TcxRadioButton
          Left = 3
          Top = 18
          Width = 143
          Height = 17
          Caption = #25209#21457#26102#21462#24403#21069#25209#21457#20215#26684
          TabOrder = 0
        end
        object edtOutLevel2: TcxRadioButton
          Left = 3
          Top = 43
          Width = 143
          Height = 17
          Caption = #25209#21457#26102#21462#26368#36817#19968#27425#21806#20215'  '
          TabOrder = 1
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #36827#36135#21442#25968
      ImageIndex = 4
      object Bevel4: TBevel
        Left = 0
        Top = 0
        Width = 410
        Height = 215
        Align = alClient
        Shape = bsFrame
      end
      object Label3: TLabel
        Left = 20
        Top = 23
        Width = 72
        Height = 12
        Caption = #40664#35748#31080#25454#31867#22411
      end
      object GroupBox4: TGroupBox
        Left = 18
        Top = 52
        Width = 191
        Height = 89
        Caption = #36827#39033#31246#29575
        TabOrder = 0
        object Label1: TLabel
          Left = 20
          Top = 53
          Width = 48
          Height = 12
          Caption = #22320#31246#31246#29575
        end
        object Label6: TLabel
          Left = 20
          Top = 30
          Width = 48
          Height = 12
          Caption = #22269#31246#31246#29575
        end
        object edtIN_RATE2: TcxSpinEdit
          Left = 75
          Top = 47
          Width = 65
          Height = 20
          Properties.Increment = 0.010000000000000000
          Properties.MaxValue = 100.000000000000000000
          Properties.ValueType = vtFloat
          TabOrder = 0
          Value = 0.050000000000000000
        end
        object edtIN_RATE3: TcxSpinEdit
          Left = 75
          Top = 26
          Width = 65
          Height = 20
          Properties.Increment = 0.010000000000000000
          Properties.MaxValue = 100.000000000000000000
          Properties.ValueType = vtFloat
          TabOrder = 1
          Value = 0.170000000000000000
        end
      end
      object edtIN_INV_FLAG: TcxComboBox
        Left = 105
        Top = 20
        Width = 104
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #25910#27454#25910#31080
          #26222#36890#21457#31080
          #22686#20540#31246#31080)
        TabOrder = 1
      end
      object chkSaveStockPrint: TcxCheckBox
        Left = 14
        Top = 160
        Width = 163
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20445#23384#26102#26159#21542#31435#21363#25171#21360#21333#25454
        TabOrder = 2
      end
      object GroupBox8: TGroupBox
        Left = 216
        Top = 52
        Width = 185
        Height = 89
        Caption = #36827#36135#26102#20215#26684#21462#21521
        TabOrder = 3
        object edtInLevel1: TcxRadioButton
          Left = 8
          Top = 24
          Width = 129
          Height = 17
          Caption = #36827#36135#26102#21462#21442#32771#36827#20215'      '
          TabOrder = 0
        end
        object edtInLevel2: TcxRadioButton
          Left = 8
          Top = 48
          Width = 129
          Height = 17
          Caption = #36827#36135#26102#21462#26368#26032#36827#20215
          TabOrder = 1
        end
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 242
    Width = 418
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOK: TRzBitBtn
      Left = 230
      Top = 10
      Action = acComfir
      Caption = #30830#23450'(&O)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
    end
    object btnCancel: TRzBitBtn
      Left = 315
      Top = 10
      Cancel = True
      ModalResult = 2
      Action = acCancel
      Caption = #21462#28040'(&C)'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 1
    end
  end
  inherited mmMenu: TMainMenu
    Left = 296
    Top = 184
  end
  inherited actList: TActionList
    Left = 264
    Top = 184
    object acComfir: TAction
      Caption = #30830#23450'(&O)'
      OnExecute = acComfirExecute
    end
    object acCancel: TAction
      Caption = #21462#28040'(&C)'
      OnExecute = acCancelExecute
    end
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 232
    Top = 183
  end
end
