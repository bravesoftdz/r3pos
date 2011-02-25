object SocketForm: TSocketForm
  Left = 396
  Top = 240
  AlphaBlendValue = 0
  AutoScroll = False
  Caption = #36890#35759#26381#21153#22120
  ClientHeight = 327
  ClientWidth = 519
  Color = clBtnFace
  Constraints.MinHeight = 373
  Constraints.MinWidth = 527
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  ScreenSnap = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 519
    Height = 327
    ActivePage = StatPage
    Align = alClient
    TabOrder = 0
    object PropPage: TTabSheet
      Caption = ' '#36873#39033
      DesignSize = (
        511
        300)
      object PortGroup: TGroupBox
        Left = 104
        Top = 5
        Width = 401
        Height = 68
        Anchors = [akLeft, akTop, akRight]
        Caption = #31471#21475
        TabOrder = 0
        DesignSize = (
          401
          68)
        object Label1: TLabel
          Left = 54
          Top = 20
          Width = 54
          Height = 12
          Alignment = taRightJustify
          Caption = #30417#21548#31471#21475':'
          FocusControl = PortNo
        end
        object PortDesc: TLabel
          Left = 8
          Top = 40
          Width = 384
          Height = 18
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = #30417#21548#31471#21475#26159#26381#21153#31471#30417#21548#23458#25143#31471#35831#27714#30340#36830#25509'ID'#21495'. '
          WordWrap = True
        end
        object PortNo: TEdit
          Left = 120
          Top = 16
          Width = 73
          Height = 20
          TabOrder = 0
          Text = '8063'
          OnExit = IntegerExit
        end
        object PortUpDown: TUpDown
          Left = 193
          Top = 16
          Width = 12
          Height = 20
          Associate = PortNo
          Min = 1
          Max = 32767
          Position = 8063
          TabOrder = 1
          Thousands = False
          OnClick = UpDownClick
        end
      end
      object ThreadGroup: TGroupBox
        Left = 104
        Top = 79
        Width = 401
        Height = 82
        Anchors = [akLeft, akTop, akRight]
        Caption = #32447#31243
        TabOrder = 1
        DesignSize = (
          401
          82)
        object Label4: TLabel
          Left = 44
          Top = 16
          Width = 66
          Height = 12
          Alignment = taRightJustify
          Caption = #32447#31243#32531#20914#25968':'
          FocusControl = ThreadSize
        end
        object ThreadDesc: TLabel
          Left = 8
          Top = 38
          Width = 385
          Height = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = #32447#31243#32531#20914#25968#25351#26368#22823#20445#30041#25351#23450#25968#30446#30340#23458#25143#31471#36830#25509#21040#32531#20914#21306#65292#26377#26032#30340#36830#25509#35831#27714#31995#32479#19981#38656#37325#22797#21019#24314#65292#21487#30452#25509#24212#29992#32531#20914#21306#32447#31243'.'
          WordWrap = True
        end
        object ThreadSize: TEdit
          Left = 120
          Top = 12
          Width = 73
          Height = 20
          TabOrder = 0
          Text = '10'
          OnExit = IntegerExit
        end
        object ThreadUpDown: TUpDown
          Left = 193
          Top = 12
          Width = 12
          Height = 20
          Associate = ThreadSize
          Max = 1000
          Position = 10
          TabOrder = 1
          Thousands = False
          OnClick = UpDownClick
        end
      end
      object TimeoutGroup: TGroupBox
        Left = 104
        Top = 173
        Width = 401
        Height = 82
        Anchors = [akLeft, akTop, akRight]
        Caption = #36229#26102
        TabOrder = 2
        DesignSize = (
          401
          82)
        object Label7: TLabel
          Left = 13
          Top = 19
          Width = 102
          Height = 12
          Alignment = taRightJustify
          Caption = #19981#27963#21160#36229#26102#65288#20998#65289':'
          FocusControl = Timeout
        end
        object TimeoutDesc: TLabel
          Left = 16
          Top = 40
          Width = 377
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = #19981#27963#21160#29366#24577#36229#36807#25351#23450#26102#38388#21518#23458#25143#31471#23558#34987#33258#21160#26029#24320#36830#25509'. (0 '#20026#26080#38480#26399#31561#24453')'
          WordWrap = True
        end
        object Timeout: TEdit
          Left = 120
          Top = 15
          Width = 73
          Height = 20
          TabOrder = 0
          Text = '0'
          OnExit = IntegerExit
        end
        object TimeoutUpDown: TUpDown
          Left = 193
          Top = 15
          Width = 12
          Height = 20
          Associate = Timeout
          Max = 32767
          Increment = 30
          TabOrder = 1
          OnClick = UpDownClick
        end
        object edtKeepAlive: TCheckBox
          Left = 216
          Top = 16
          Width = 153
          Height = 17
          Caption = #26159#21542#21551#29992#24515#36339#20445#27963#26426#21046
          TabOrder = 2
          OnClick = edtKeepAliveClick
        end
      end
      object PortList: TListBox
        Left = 8
        Top = 10
        Width = 89
        Height = 245
        ItemHeight = 12
        TabOrder = 3
        OnClick = PortListClick
      end
      object Panel1: TPanel
        Left = 8
        Top = 256
        Width = 97
        Height = 41
        BevelOuter = bvNone
        TabOrder = 4
        DesignSize = (
          97
          41)
        object ApplyButton: TButton
          Tag = -1
          Left = 0
          Top = 8
          Width = 75
          Height = 25
          Action = ApplyAction
          Anchors = [akLeft, akBottom]
          TabOrder = 0
        end
      end
    end
    object StatPage: TTabSheet
      Caption = ' '#36830#25509
      object ConnectionList: TListView
        Left = 0
        Top = 0
        Width = 511
        Height = 281
        Align = alClient
        Columns = <
          item
            Caption = #31471#21475
          end
          item
            AutoSize = True
            Caption = 'IP '#22320#22336
          end
          item
            AutoSize = True
            Caption = #20027#26426#21517
          end
          item
            AutoSize = True
            Caption = #26368#21518#32564#27963#26102#38388
          end>
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = ConnectionListColumnClick
        OnCompare = ConnectionListCompare
      end
      object UserStatus: TStatusBar
        Left = 0
        Top = 281
        Width = 511
        Height = 19
        Panels = <>
        SimplePanel = True
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25968#25454#24211
      ImageIndex = 4
    end
    object TabSheet1: TTabSheet
      Caption = ' '#20219#21153
      ImageIndex = 4
      object ListView2: TListView
        Left = 0
        Top = 0
        Width = 511
        Height = 300
        Align = alClient
        Columns = <
          item
            Caption = #31471#21475
          end
          item
            AutoSize = True
            Caption = 'IP '#22320#22336
          end
          item
            AutoSize = True
            Caption = #20027#26426#21517
          end
          item
            AutoSize = True
            Caption = #26368#21518#32564#27963#26102#38388
          end>
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = ConnectionListColumnClick
        OnCompare = ConnectionListCompare
      end
    end
    object TabSheet2: TTabSheet
      Caption = ' '#26085#24535
      ImageIndex = 4
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 511
        Height = 300
        Align = alClient
        Color = clNavy
        Font.Charset = GB2312_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu2
        TabOrder = 0
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 480
    Top = 56
    object miClose: TMenuItem
      Caption = #36864#20986#31995#32479'(&C)'
      OnClick = miCloseClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuMgr: TMenuItem
      Caption = #26381#21153#31649#29702'(&M)'
      OnClick = mnuMgrClick
    end
    object miProperties: TMenuItem
      Caption = #20027#31243#24207'(&P)'
      Default = True
      OnClick = miPropertiesClick
    end
  end
  object UpdateTimer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = UpdateTimerTimer
    Left = 464
    Top = 88
  end
  object MainMenu1: TMainMenu
    Left = 472
    Top = 120
    object miPorts: TMenuItem
      Caption = #31471#21475'(&P)'
      object miAdd: TMenuItem
        Caption = #28155#21152#31471#21475'(&A)'
        OnClick = miAddClick
      end
      object miRemove: TMenuItem
        Action = RemovePortAction
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = #20851#38381'(&E)'
        OnClick = miExitClick
      end
    end
    object Connections1: TMenuItem
      Caption = #36830#25509'(&C)'
      object miShowHostName: TMenuItem
        Action = ShowHostAction
      end
      object XMLPacket1: TMenuItem
        Action = AllowXML
      end
      object IP1: TMenuItem
        Caption = #33258#21160#21516#27493#26102#38388
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miDisconnect: TMenuItem
        Action = DisconnectAction
      end
    end
  end
  object ActionList1: TActionList
    Left = 480
    Top = 152
    object ApplyAction: TAction
      Caption = #24212#29992'(&A)'
      OnExecute = ApplyActionExecute
      OnUpdate = ApplyActionUpdate
    end
    object DisconnectAction: TAction
      Caption = #26029#24320'(&D)'
      OnExecute = miDisconnectClick
      OnUpdate = DisconnectActionUpdate
    end
    object ShowHostAction: TAction
      Caption = #26174#31034#20027#26426'(&S)'
      Checked = True
      OnExecute = ShowHostActionExecute
    end
    object RemovePortAction: TAction
      Caption = #21024#38500#31471#21475'(&R)'
      OnExecute = RemovePortActionExecute
      OnUpdate = RemovePortActionUpdate
    end
    object AllowXML: TAction
      Caption = #25509#21463'XML'#21253'(&M)'
      Checked = True
      OnExecute = AllowXMLExecute
    end
    object actRegistryService: TAction
      Caption = #27880#20876#26381#21153
    end
    object actRemoveSerivce: TAction
      Caption = #31227#38500#26381#21153
    end
    object actClearLogFile: TAction
      Caption = #28165#38500#26085#24535
    end
    object actOpenLogFile: TAction
      Caption = #25171#24320#26085#24535
    end
    object actSaveLogFile: TAction
      Caption = #20445#23384#26085#24535
    end
    object actLogFileSaveAs: TAction
      Caption = #21478#23384#20026'...'
    end
    object actSetConfig: TAction
      Caption = #32452#20214#35774#32622
    end
    object actRefreshComponment: TAction
      Caption = #21047#26032
    end
  end
  object ImageList1: TImageList
    Left = 60
    Top = 168
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEE7E7008C8C8C00393939000808080031312900424242003139
      3900393939007B737300DED6DE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8C84000000000000000000000000000000000000000000080808002929
      290039393900181821004A4A4A00D6D6D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000C6C6C600848484008484840084848400C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000003942
      4200000000000821210008212900002918000818180008212900081818000800
      000018181800424A520029212100635A5A000000000000000000000000000000
      0000000000000000000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000FF000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000000000C6C6C600000000000000000000000000848484000000
      00000000000000000000000000000000000000000000000000005A7384000010
      2900104A630000526B000839420000084200318CAD0008394200083942001029
      3100101010001818180039393900292121000000000000000000000000000000
      0000000000000000000000000000000000008484000084840000848400000000
      000000000000C6C6C60084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      FF000000840000000000C6C6C600000000000000000000000000000000000000
      0000C6C6C60000000000000000000000000000000000CEDEE70000294A00005A
      730000637B00006B8400005A5A000008420063D6FF0008394200004A63000842
      5200183142000800000029292900212931000000000000000000000000000000
      000000000000000000008484000000000000FFFF000000000000FFFF00000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      FF00000000000000000084848400000084000000000000000000848484000000
      000000000000000000000000000000000000000000006BADC60000637B000073
      8C00006B8400007B9400005A5A00000842008CE7FF00005A5A00005A7300005A
      7300084252002129310008000000424242000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400848484008484
      8400000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      84000000000084848400000084000084840000FFFF0000848400000000008484
      84000000000000000000000000000000000084848400398C9400007B94000084
      A500007B94000894B50008737300000842008CE7FF00005A7300005A73000052
      6B00004A63001831420008000000424242000000000000000000848484000000
      00008484840000000000FFFF000000000000FFFF000000000000FFFF00008484
      8400848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      00000000000000008400008484000084840000FFFF0000848400008484000000
      00000084000000000000000000000000000000000000187B94000084A5000008
      420063D6FF008CE7FF007BE7FF008CE7FF008CE7FF008CE7FF008CE7FF0063D6
      FF00318CAD00184242000000000052424A000000000000000000848484000000
      000084848400FFFF000000000000C6C6C600C6C6C600C6C6C600000000008484
      8400848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000000000000218CA5000894B5000008
      4200000842000008420000084200000842008CE7FF0000084200000842000008
      42000008420039738C0000001000848484000000000000000000848484000000
      000084848400848484000000000000000000C6C6C600C6C6C600000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484000000
      00000000000000848400008484000000000000FFFF0000848400008484000000
      000000000000C6C6C6000000000000000000000000004A9CAD000084A50039B5
      CE008CD6E700B5E7D600848C8C00000842008CE7FF00007B9400006B84000873
      730021738C004A8CBD0000102900C6BDB5000000000000000000848484000000
      00000000000084848400FFFF000000000000FFFF000000000000FFFF00008484
      8400000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000848400000000000000000000848400000000008484
      84000000000000000000000000000000000000000000ADC6CE00006B840042B5
      D600A5E7F700F7FFFF00CEE7D600000842008CE7FF0010A5C600008CAD00218C
      A5004A9CCE00318CAD0000001000000000000000000000000000848484008484
      840084848400848484008484840084848400C6C6C600C6C6C600C6C6C6000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840000000000008484000084840000000000C6C6C6000000
      0000C6C6C60000000000000000000000000000000000CEDEE700006B840021A5
      C600B5EFF700EFFFFF00B5E7D6000008420063D6FF000084A500187B9400297B
      9C00319CCE00000842008C8C840000000000000000000000000084848400FF00
      0000FF000000FF000000FF000000FF000000848484008484840084848400C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6008484
      8400000000000000000084848400000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000DEE7E7000073
      8C0052B5CE007BE7FF005ABDD6000008420000084200398C940039738C003973
      8C00000842001842420000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400000000000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FF0000008400000000000000000000000000000084848400C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000DEE7
      E70000738C0000738C000084A5002194A50021738C00216B840000526B000021
      3100396373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CEDEE700ADC6CE004A9CAD00318CAD0021738C00398C94007394AD00CEDE
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFF801FFFF0000FFFFF000FE010000
      E03FE000FC000000C1CFC000FC090000C1F78000F951000080178000C0010000
      80030000D541000098038000D221000098038000D321000098038000D9410000
      9C078001C0010000C2178001C0010000C1EFC003C0110000E01FE007FE030000
      F1FFF00FFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Left = 128
    Top = 80
    object N11: TMenuItem
      Caption = #23646#24615
      Default = True
    end
    object N4: TMenuItem
      Action = actRegistryService
    end
    object N12: TMenuItem
      Action = actSetConfig
    end
    object N5: TMenuItem
      Action = actRemoveSerivce
    end
    object N13: TMenuItem
      Caption = #29983#25104#23458#25143#31471#37197#32622#25991#20214
    end
    object N14: TMenuItem
      Action = actRefreshComponment
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object N9: TMenuItem
      Caption = #28155#21152#24080#22871
    end
    object N10: TMenuItem
      Caption = #21024#38500#24080#22871
    end
  end
  object Timer1: TTimer
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 480
    Top = 24
  end
  object PopupMenu2: TPopupMenu
    Left = 128
    Top = 176
    object MenuItem1: TMenuItem
      Action = actOpenLogFile
    end
    object MenuItem2: TMenuItem
      Action = actClearLogFile
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Action = actSaveLogFile
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'sdfsdfas|*.dll,*.ocx'
    Left = 236
    Top = 87
  end
end
