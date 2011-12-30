inherited frmMktPlanOrderList: TfrmMktPlanOrderList
  Left = 256
  Top = 204
  Caption = #32463#38144#21512#21516
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited RzPanel2: TRzPanel
      inherited RzPage: TRzPageControl
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          inherited RzPanel3: TRzPanel
            inherited RzPanel1: TRzPanel
              Height = 113
              object RzLabel2: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #31614#32422#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel4: TRzLabel
                Left = 33
                Top = 65
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #32463' '#38144' '#21830
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 86
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #21333'    '#21495
              end
              object Label1: TLabel
                Left = 201
                Top = 87
                Width = 120
                Height = 12
                Caption = #25903#25345#27169#22359','#36755#21518'4'#20301#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel
                Left = 33
                Top = 44
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object Label2: TLabel
                Left = 34
                Top = 24
                Width = 48
                Height = 12
                Caption = #32463' '#25163' '#20154
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 0
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 0
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndCLIENT_ID: TzrComboBoxList
                Left = 89
                Top = 61
                Width = 236
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 2
                InGrid = False
                KeyValue = Null
                FilterFields = 'CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
                KeyField = 'CLIENT_ID'
                ListField = 'CLIENT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_CODE'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_NAME'
                    Footers = <>
                    Title.Caption = #20379#24212#21830#21517#31216
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LINKMAN'
                    Footers = <>
                    Title.Caption = #32852#31995#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TELEPHONE2'
                    Footers = <>
                    Title.Caption = #32852#31995#30005#35805
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'LICENSE_CODE'
                    Footers = <>
                    Title.Caption = #35777#20214#21495
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ADDRESS'
                    Footers = <>
                    Title.Caption = #22320#22336
                    Width = 150
                  end>
                DropWidth = 236
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = False
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndGLIDE_NO: TcxTextEdit
                Left = 89
                Top = 82
                Width = 104
                Height = 20
                TabOrder = 3
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndDEPT_ID: TzrComboBoxList
                Left = 89
                Top = 40
                Width = 236
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 4
                InGrid = False
                KeyValue = Null
                FilterFields = 'DEPT_NAME;DEPT_SPELL'
                KeyField = 'DEPT_ID'
                ListField = 'DEPT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'DEPT_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object btnOk: TRzBitBtn
                Left = 336
                Top = 72
                Width = 67
                Height = 26
                Action = actFind
                Caption = #26597#35810
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
                TabOrder = 5
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndPLAN_USER: TzrComboBoxList
                Left = 89
                Top = 20
                Width = 236
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 6
                InGrid = False
                KeyValue = Null
                FilterFields = 'ACCOUNT;USER_NAME;USER_SPELL'
                KeyField = 'USER_ID'
                ListField = 'USER_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCOUNT'
                    Footers = <>
                    Title.Caption = #24080#21495
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #22995#21517
                    Width = 130
                  end>
                DropWidth = 180
                DropHeight = 150
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            inherited DBGridEh1: TDBGridEh
              Top = 118
              Height = 248
              OnDblClick = DBGridEh1DblClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 30
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #27969#27700#21495
                  Width = 100
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_ID_TEXT'
                  Footers = <>
                  Title.Caption = #32463#38144#21830
                  Width = 120
                end
                item
                  EditButtons = <>
                  FieldName = 'DEPT_ID_TEXT'
                  Footers = <>
                  Title.Caption = #25152#23646#37096#38376
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_USER_TEXT'
                  Footers = <>
                  Title.Caption = #32463#25163#20154
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_DATE'
                  Footers = <>
                  Title.Caption = #31614#32422#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'BEGIN_DATE'
                  Footers = <>
                  Title.Caption = #24320#22987#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'END_DATE'
                  Footers = <>
                  Title.Caption = #32467#26463#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_AMT'
                  Footers = <>
                  Title.Caption = #21512#35745#25968#37327
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_MNY'
                  Footers = <>
                  Title.Caption = #21512#35745#37329#39069
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'BOND_MNY'
                  Footers = <>
                  Title.Caption = #20445#35777#37329
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'BUDG_MNY'
                  Footers = <>
                  Title.Caption = #24066#22330#36153#39044#31639
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #25805#20316#26102#38388
                  Width = 120
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER'
                  Footers = <>
                  Title.Caption = #25805#20316#20154#21592
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_USER'
                  Footers = <>
                  Title.Caption = #23457#26680#20154#21592
                  Width = 60
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    inherited Image3: TImage
      Left = 593
      Width = 227
    end
    inherited rzPanel5: TPanel
      Left = 593
    end
    inherited CoolBar1: TCoolBar
      Width = 573
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 573
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 573
        object ToolButton15: TToolButton
          Left = 520
          Top = 0
          Width = 10
          Caption = 'ToolButton15'
          ImageIndex = 10
          Style = tbsDivider
        end
        object ToolButton16: TToolButton
          Left = 530
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 240
    Top = 232
  end
  inherited actList: TActionList
    Left = 272
    Top = 232
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
  end
  inherited ppmReport: TPopupMenu
    Left = 382
    Top = 231
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfMktPlanOrderList: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    OnGetValue = frfMktPlanOrderListGetValue
    Left = 425
    Top = 230
    ReportForm = {18000000}
  end
end
