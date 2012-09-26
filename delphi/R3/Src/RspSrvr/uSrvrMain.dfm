object SocketForm: TSocketForm
  Left = 379
  Top = 193
  AlphaBlendValue = 0
  AutoScroll = False
  Caption = #36890#35759#26381#21153#22120
  ClientHeight = 326
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 519
    Height = 326
    ActivePage = PropPage
    Align = alClient
    TabOrder = 0
    OnChange = PagesChange
    object PropPage: TTabSheet
      Caption = ' '#36873#39033
      DesignSize = (
        511
        299)
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
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
        Height = 280
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
            Caption = #29992#25143
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
        Top = 280
        Width = 511
        Height = 19
        Panels = <>
        SimplePanel = True
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25968#25454#24211
      ImageIndex = 4
      object dbList: TListView
        Left = 0
        Top = 0
        Width = 511
        Height = 299
        Align = alClient
        Columns = <
          item
            Caption = #36830#25509#21495
          end
          item
            AutoSize = True
            Caption = #20027#26426#21517#31216
          end
          item
            AutoSize = True
            Caption = #35828#26126
          end>
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmuDbConfig
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = ConnectionListColumnClick
        OnCompare = ConnectionListCompare
        OnDblClick = dbListDblClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = ' '#20219#21153
      ImageIndex = 4
      object TaskList: TListView
        Left = 0
        Top = 0
        Width = 511
        Height = 299
        Align = alClient
        Columns = <
          item
            Caption = #20219#21153#21495
          end
          item
            AutoSize = True
            Caption = #20219#21153#21517#31216
          end
          item
            AutoSize = True
            Caption = #35843#24230#26102#38388
          end
          item
            AutoSize = True
            Caption = #26368#21518#32564#27963#26102#38388
          end>
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pupTask
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = ConnectionListColumnClick
        OnCompare = ConnectionListCompare
      end
    end
    object TabLog: TTabSheet
      Caption = ' '#26085#24535
      ImageIndex = 4
      object Memo1: TMemo
        Left = 0
        Top = 25
        Width = 511
        Height = 274
        Align = alClient
        Color = clNavy
        Font.Charset = GB2312_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        ParentFont = False
        PopupMenu = pmuLogFile
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object chkDebug: TCheckBox
          Left = 8
          Top = 4
          Width = 97
          Height = 17
          Caption = #26174#31034#35843#35797#26085#24535
          TabOrder = 0
          OnClick = chkDebugClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #29366#24577
      ImageIndex = 5
      DesignSize = (
        511
        299)
      object GroupBox1: TGroupBox
        Left = 8
        Top = 13
        Width = 479
        Height = 71
        Anchors = [akLeft, akTop, akRight]
        Caption = #32447#31243#27744
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
        object Label2: TLabel
          Left = 26
          Top = 22
          Width = 66
          Height = 12
          Caption = #24403#21069#32447#31243#25968':'
        end
        object Label3: TLabel
          Left = 26
          Top = 44
          Width = 66
          Height = 12
          Caption = #36816#34892#32447#31243#25968':'
        end
        object Label10: TLabel
          Left = 170
          Top = 22
          Width = 66
          Height = 12
          Caption = #26368#22823#32447#31243#25968':'
        end
        object Label11: TLabel
          Left = 170
          Top = 43
          Width = 66
          Height = 12
          Caption = #25191#34892#33021#21147#20540':'
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 93
        Width = 479
        Height = 72
        Anchors = [akLeft, akTop, akRight]
        Caption = #25968#25454#24211
        Color = clBtnFace
        ParentColor = False
        TabOrder = 1
        object Label5: TLabel
          Left = 26
          Top = 22
          Width = 66
          Height = 12
          Caption = #32531#20914#36830#25509#25968':'
        end
        object Label6: TLabel
          Left = 26
          Top = 44
          Width = 66
          Height = 12
          Caption = #38145#23450#36830#25509#25968':'
        end
        object Label15: TLabel
          Left = 227
          Top = 44
          Width = 6
          Height = 12
          Alignment = taRightJustify
          Caption = ':'
        end
        object Label14: TLabel
          Left = 168
          Top = 22
          Width = 78
          Height = 12
          Caption = #26368#22823#25191#34892#24310#26102':'
        end
        object Label18: TLabel
          Left = 168
          Top = 44
          Width = 78
          Height = 12
          Caption = #24179#22343#25191#34892#25928#29575':'
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 176
        Width = 479
        Height = 71
        Anchors = [akLeft, akTop, akRight]
        Caption = #23458#25143#31471
        Color = clBtnFace
        ParentColor = False
        TabOrder = 2
        object Label8: TLabel
          Left = 25
          Top = 22
          Width = 66
          Height = 12
          Caption = #31561#24453#25351#20196#25968':'
        end
        object Label9: TLabel
          Left = 308
          Top = 44
          Width = 78
          Height = 12
          Caption = #31561#24453#26368#22823#26102#38271':'
        end
        object Label12: TLabel
          Left = 166
          Top = 44
          Width = 66
          Height = 12
          Caption = #26368#22823#36830#25509#25968':'
        end
        object Label13: TLabel
          Left = 166
          Top = 22
          Width = 66
          Height = 12
          Caption = #24403#21069#36830#25509#25968':'
        end
        object Label16: TLabel
          Left = 25
          Top = 43
          Width = 66
          Height = 12
          Caption = #26368#22823#24182#21457#25968':'
        end
        object Label17: TLabel
          Left = 308
          Top = 22
          Width = 78
          Height = 12
          Caption = #35831#27714#25351#20196#24635#25968':'
        end
      end
    end
  end
  object pmuSystem: TPopupMenu
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
  end
  object UpdateTimer: TTimer
    Enabled = False
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
        Caption = #36864#20986'(&E)'
        OnClick = miExitClick
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
      OnExecute = actClearLogFileExecute
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
    object actfrmAddDb: TAction
      Caption = #28155#21152#36830#25509
      OnExecute = actfrmAddDbExecute
    end
    object actfrmDeleteDb: TAction
      Caption = #21024#38500#36830#25509
      OnExecute = actfrmDeleteDbExecute
    end
    object actfrmDbConfig: TAction
      Caption = #23646#24615
      OnExecute = actfrmDbConfigExecute
    end
    object actPlugInClose: TAction
      Caption = #20851#38381#25554#20214
      OnExecute = actPlugInCloseExecute
    end
    object actPlugInExecute: TAction
      Caption = #31435#21363#25191#34892
      OnExecute = actPlugInExecuteExecute
    end
    object actShowPlugIn: TAction
      Caption = #31649#29702#25554#20214
      OnExecute = actShowPlugInExecute
    end
    object actPlugInTimer: TAction
      Caption = #25554#20214#35843#24230
      OnExecute = actPlugInTimerExecute
    end
    object actPlugInLoad: TAction
      Caption = #35013#36733#25554#20214
      OnExecute = actPlugInLoadExecute
    end
    object actPlugInThreadRun: TAction
      Caption = #21518#21488#25191#34892
      OnExecute = actPlugInThreadRunExecute
    end
  end
  object pmuLogFile: TPopupMenu
    Left = 56
    Top = 176
    object N6: TMenuItem
      Caption = #22797#21046
      OnClick = N6Click
    end
    object MenuItem2: TMenuItem
      Action = actClearLogFile
      Caption = #28165#23631
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'sdfsdfas|*.dll,*.ocx'
    Left = 412
    Top = 47
  end
  object pmuDbConfig: TPopupMenu
    Left = 40
    Top = 136
    object MenuItem3: TMenuItem
      Action = actfrmDbConfig
      Default = True
    end
    object MenuItem5: TMenuItem
      Caption = '-'
    end
    object MenuItem4: TMenuItem
      Action = actfrmAddDb
    end
    object N2: TMenuItem
      Action = actfrmDeleteDb
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object N13: TMenuItem
      Caption = #21019#24314#36134#22871
    end
  end
  object pupTask: TPopupMenu
    Left = 184
    Top = 176
    object N5: TMenuItem
      Action = actPlugInExecute
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = actPlugInTimer
    end
    object N8: TMenuItem
      Action = actShowPlugIn
    end
    object N11: TMenuItem
      Action = actPlugInLoad
    end
    object N9: TMenuItem
      Action = actPlugInClose
    end
  end
  object RzTrayIcon1: TRzTrayIcon
    Animate = True
    Enabled = False
    PopupMenu = pmuSystem
    Left = 332
    Top = 174
  end
  object ZSQLMonitor1: TZSQLMonitor
    MaxTraceCount = 100
    OnTrace = ZSQLMonitor1Trace
    Left = 60
    Top = 103
  end
end
