inherited frmKpiIndexInfo: TfrmKpiIndexInfo
  Left = 278
  Top = 125
  Caption = #32771#26680#25351#26631
  ClientHeight = 432
  ClientWidth = 641
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 641
    Height = 432
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Top = 103
      Width = 631
      Height = 284
      ActivePage = TabSheet4
      TabIndex = 2
      OnChange = RzPageChange
      OnChanging = RzPageChanging
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #21830#21697#28165#21333
        inherited RzPanel2: TRzPanel
          Width = 627
          Height = 257
          BorderColor = clWhite
          Color = clWhite
          object Notebook1: TNotebook
            Left = 5
            Top = 5
            Width = 617
            Height = 247
            Align = alClient
            PageIndex = 1
            TabOrder = 0
            object TPage
              Left = 0
              Top = 0
              Caption = 'P0'
              object RzLabel4: TRzLabel
                Left = 192
                Top = 72
                Width = 108
                Height = 12
                Caption = #26242#26102#36824#27809#26377#21551#29992#38454#26799
              end
            end
            object TPage
              Left = 0
              Top = 0
              Caption = 'P1'
              object DBGridEh1: TDBGridEh
                Left = 0
                Top = 0
                Width = 617
                Height = 247
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = Ds_KpiGoods
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                FrozenCols = 2
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
                PopupMenu = Pm_Gods
                RowHeight = 17
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                TitleHeight = 20
                UseMultiTitle = True
                VertScrollBar.VisibleMode = sbAlwaysShowEh
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnKeyPress = DBGridEh1KeyPress
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #24207#21495
                    Width = 31
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_NAME'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21830#21697#21517#31216
                    Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721#12289#35745#37327#21333#20301#26465#30721'" '#26597#35810
                    Width = 149
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_CODE'
                    Footers = <>
                    ReadOnly = True
                    Tag = 1
                    Title.Caption = #36135#21495
                    Width = 72
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BARCODE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #26465#30721
                    Width = 93
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_ID'
                    Footers = <>
                    Title.Caption = #21333#20301
                    Width = 49
                    OnBeforeShowControl = DBGridEh2Columns4BeforeShowControl
                  end>
              end
              object fndUNIT_ID: TcxComboBox
                Left = 320
                Top = 33
                Width = 49
                Height = 20
                Properties.DropDownListStyle = lsFixedList
                Properties.OnChange = fndUNIT_IDPropertiesChange
                TabOrder = 1
                Visible = False
                OnEnter = fndUNIT_IDEnter
                OnExit = fndUNIT_IDExit
                OnKeyDown = fndUNIT_IDKeyDown
                OnKeyPress = fndUNIT_IDKeyPress
              end
            end
          end
        end
      end
      object TabSheet3: TRzTabSheet
        Color = clWhite
        Caption = #25351#26631#23646#24615
        object RzPanel3: TRzPanel
          Left = 0
          Top = 0
          Width = 627
          Height = 257
          Align = alClient
          BorderOuter = fsNone
          Color = clWindow
          TabOrder = 0
          OnResize = RzPanel3Resize
          object RzPnl_left: TRzPanel
            Left = 0
            Top = 0
            Width = 305
            Height = 257
            Align = alLeft
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 5
            Color = clWhite
            TabOrder = 0
            object RzPanel7: TRzPanel
              Left = 5
              Top = 5
              Width = 295
              Height = 26
              Align = alTop
              Alignment = taLeftJustify
              BorderOuter = fsNone
              Caption = ' '#31614#32422#31561#32423
              Color = clWhite
              TabOrder = 0
              DesignSize = (
                295
                26)
              object Btn_Left_add: TRzBitBtn
                Left = 179
                Top = 0
                Width = 56
                Height = 22
                Anchors = [akTop, akRight]
                Caption = #28155#21152
                Color = clWhite
                HighlightColor = 16026986
                HotTrack = True
                HotTrackColor = 3983359
                TextShadowDepth = 0
                TabOrder = 0
                OnClick = Btn_Left_addClick
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000110B0000110B00000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31801
                  B31801B31801B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF01B31800D21E00D21E01B318FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31800
                  D93B00D93B01B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFF01B31801B31801B31801B31800DF5900DF5901B31801B31801B31801B3
                  18FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31800E67600E67600E67600
                  E67600E67600E67600E67600E67601B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFF01B31800EC9400EC9400EC9400EC9400EC9400EC9400EC9400EC9401B3
                  18FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31801B31801B31801B31800
                  F2B200F2B201B31801B31801B31801B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF01B31800F9CF00F9CF01B318FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31800
                  FFEC00FFEC01B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF01B31801B31801B31801B318FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              end
              object Btn_Left_del: TRzBitBtn
                Left = 237
                Top = 0
                Width = 56
                Height = 22
                Anchors = [akTop, akRight]
                Caption = #21024#38500
                Color = clWhite
                HighlightColor = 16026986
                HotTrack = True
                HotTrackColor = 3983359
                TextShadowDepth = 0
                TabOrder = 1
                OnClick = Btn_Left_delClick
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E8F79EA9E1546BC73F
                  59C03A53BF4C67C297A7DCE1E6F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFC3C9ED5566CC3C52CC757AE88F92EE8F92EE7178E4334DC1405CBEB9C4
                  E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C9EF5160CD5C65E0A1A6F57E86EF5B
                  63E9595DE77D84EE9EA0F4515DD73452BAB9C4E7FFFFFFFFFFFFFFFFFFE8EAF9
                  6571D4616BE3A1ACF5545FEC505CEA4D59E94E59E64C56E65056E69EA2F45460
                  D6405CBFE2E7F5FFFFFFFFFFFFACB0EA4B56DBA2ABF65664F05266EE4D59E94D
                  59E94D59E94D59E94C58E6525AE69FA3F53450C496A6DCFFFFFFFFFFFF7378DD
                  818CEE7E91F75D73F34D59E94D59E94D59E94D59E94D59E94D59E94F5BE97B83
                  F0757BE24C64C4FFFFFFFFFFFF6569DBA1ABF77086F86882F6FFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFF4D59E95C66EA969CF13956BEFFFFFFFFFFFF696EDC
                  AFB9F97F93FA7085F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D59E95E6A
                  EE969DF13D55C0FFFFFFFFFFFF7C7FE3A5AFF59DABFA778CF0545FEC545FEC54
                  5FEC545FEC545FEC545FEC6377F2818EF4787FE9566BC9FFFFFFFFFFFFB5B5F0
                  7D83EACDD4FC8B9DFA7E93F7758AEE6C84F66C84F66C84F66C84F66379F3A4AF
                  F83E4FD0A0ABE1FFFFFFFFFFFFEBEBFB7978E3A3A7F3D4DBFD879AFA7F91F07A
                  8EF17F94F87E92F9768CF8A8B6F8636EE35868CDE6E8F7FFFFFFFFFFFFFFFFFF
                  CFCFF6706FE1AAADF2D8DCFDAEBAFA91A3FA8B9DFA9CA9FBBAC7FC707BE95462
                  CEC3C9EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFF67979E28E93EDBEC3F8CC
                  D3F9C4CBF9AAB4F46670E2646ED6C6CAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFEBEBFBB6B6F07D7FE26A6BDE686BDC7479DEAFB3EBE8E9F9FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              end
            end
            object DBGridEh2: TDBGridEh
              Left = 5
              Top = 31
              Width = 295
              Height = 221
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              DataSource = Ds_KpiLevel
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 2
              Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
              PopupMenu = Pm_Level
              RowHeight = 17
              SumList.Active = True
              TabOrder = 1
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 20
              UseMultiTitle = True
              VertScrollBar.VisibleMode = sbAlwaysShowEh
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              OnDrawColumnCell = DBGridEh2DrawColumnCell
              OnKeyPress = DBGridEh1KeyPress
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24207#21495
                  Width = 28
                end
                item
                  EditButtons = <>
                  FieldName = 'LEVEL_NAME'
                  Footers = <>
                  Title.Caption = #31561#32423#21517#31216
                  Width = 89
                end
                item
                  EditButtons = <>
                  FieldName = 'LVL_AMT'
                  Footers = <>
                  Title.Caption = #31614#32422#37327'('#21544')'
                  Width = 70
                end
                item
                  DisplayFormat = '#0.0%'
                  EditButtons = <>
                  FieldName = 'LOW_RATE'
                  Footers = <>
                  Title.Caption = #36820#21033#22522#25968
                  Width = 57
                end>
            end
          end
          object RzPnl_right: TRzPanel
            Left = 305
            Top = 0
            Width = 322
            Height = 257
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 5
            Color = clWhite
            TabOrder = 1
            object DBGridEh3: TDBGridEh
              Left = 5
              Top = 31
              Width = 312
              Height = 221
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              DataSource = Ds_KpiTimes
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 2
              Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
              PopupMenu = Pm_Times
              RowHeight = 17
              SumList.Active = True
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 20
              UseMultiTitle = True
              VertScrollBar.VisibleMode = sbAlwaysShowEh
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              OnDblClick = DBGridEh3DblClick
              OnDrawColumnCell = DBGridEh3DrawColumnCell
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24207#21495
                  Width = 30
                end
                item
                  EditButtons = <>
                  FieldName = 'TIMES_NAME'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #26102#27573#21517
                  Width = 80
                end
                item
                  DisplayFormat = '00-00'
                  EditButtons = <>
                  FieldName = 'KPI_DATE1'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24320#22987#26085#26399
                  Width = 60
                end
                item
                  DisplayFormat = '00-00'
                  EditButtons = <>
                  FieldName = 'KPI_DATE2'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #32467#26463#26085#26399
                  Width = 60
                end>
            end
            object RzPanel9: TRzPanel
              Left = 5
              Top = 5
              Width = 312
              Height = 26
              Align = alTop
              Alignment = taLeftJustify
              BorderOuter = fsNone
              Caption = ' '#26102#27573#23450#20041
              Color = clWhite
              TabOrder = 1
              DesignSize = (
                312
                26)
              object Btn_Right_add: TRzBitBtn
                Left = 140
                Top = 0
                Width = 56
                Height = 22
                Anchors = [akTop, akRight]
                Caption = #28155#21152
                Color = clWhite
                HighlightColor = 16026986
                HotTrack = True
                HotTrackColor = 3983359
                TextShadowDepth = 0
                TabOrder = 0
                OnClick = Btn_Right_addClick
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000110B0000110B00000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31801
                  B31801B31801B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF01B31800D21E00D21E01B318FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31800
                  D93B00D93B01B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFF01B31801B31801B31801B31800DF5900DF5901B31801B31801B31801B3
                  18FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31800E67600E67600E67600
                  E67600E67600E67600E67600E67601B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFF01B31800EC9400EC9400EC9400EC9400EC9400EC9400EC9400EC9401B3
                  18FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31801B31801B31801B31800
                  F2B200F2B201B31801B31801B31801B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF01B31800F9CF00F9CF01B318FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01B31800
                  FFEC00FFEC01B318FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF01B31801B31801B31801B318FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              end
              object Btn_Right_edit: TRzBitBtn
                Left = 198
                Top = 0
                Width = 56
                Height = 22
                Anchors = [akTop, akRight]
                Caption = #20462#25913
                Color = clWhite
                HighlightColor = 16026986
                HotTrack = True
                HotTrackColor = 3983359
                TextShadowDepth = 0
                TabOrder = 1
                OnClick = Btn_Right_editClick
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000EFEEEE9B9A9A
                  D1D2D2DADADAE6E6E6F5F5F5FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF94AFBE82A0B3D9D9DAC6C6C6C4C4C4D8D8D8EE
                  EEEEFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFCCDD
                  9FD4FD8EAAC0FBFBFBE5E5E5D2D2D2CECECEDBDBDBECECECF9F9F9FFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFE1EBF085B7E08FBCE98BD4E0FFFFFFFDFDFDF1
                  F1F1E3E3E3DCDCDCE1E1E1ECECECF7F7F7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
                  7AACC887D3F44FD7F5D2FCFEFFFFFFFFFFFFFFFFFFFAFAFAF0F0F0EAEAEAEAEA
                  EAF0F0F0F9F9F9FFFFFFFFFFFFFFFFFFC6DBE652BCDE7BDDFF6EE7F6FFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFEFEFEFAFAFAFAFAFAFDFDFDFFFFFFFFFFFFFFFFFF
                  FFFFFF77B5D57DE0FB67D9F6B9F8FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEDF563BFE28FEFFF69E3F5F8
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFF9CCAE985E9FA88EDFE9DF4FAFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F9FD77C8F1A3FFFF71
                  EAFEE7FBFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFC0E0FA91EAFFB1F7FAC8D4D9FFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABD3ECDB
                  D7D8A5AC9DE7EBE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFEDEDEE7F9D7544762DB4BFADFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7
                  C5B6BAC1AFB7B5C0E0E1F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F6F6A09EC94748A6A0A2F1FEFEFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFCDCDF78888DDEEEFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              end
              object Btn_Right_del: TRzBitBtn
                Left = 256
                Top = 0
                Width = 56
                Height = 22
                Anchors = [akTop, akRight]
                Caption = #21024#38500
                Color = clWhite
                HighlightColor = 16026986
                HotTrack = True
                HotTrackColor = 3983359
                TextShadowDepth = 0
                TabOrder = 2
                OnClick = Btn_Right_delClick
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E8F79EA9E1546BC73F
                  59C03A53BF4C67C297A7DCE1E6F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFC3C9ED5566CC3C52CC757AE88F92EE8F92EE7178E4334DC1405CBEB9C4
                  E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C9EF5160CD5C65E0A1A6F57E86EF5B
                  63E9595DE77D84EE9EA0F4515DD73452BAB9C4E7FFFFFFFFFFFFFFFFFFE8EAF9
                  6571D4616BE3A1ACF5545FEC505CEA4D59E94E59E64C56E65056E69EA2F45460
                  D6405CBFE2E7F5FFFFFFFFFFFFACB0EA4B56DBA2ABF65664F05266EE4D59E94D
                  59E94D59E94D59E94C58E6525AE69FA3F53450C496A6DCFFFFFFFFFFFF7378DD
                  818CEE7E91F75D73F34D59E94D59E94D59E94D59E94D59E94D59E94F5BE97B83
                  F0757BE24C64C4FFFFFFFFFFFF6569DBA1ABF77086F86882F6FFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFF4D59E95C66EA969CF13956BEFFFFFFFFFFFF696EDC
                  AFB9F97F93FA7085F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D59E95E6A
                  EE969DF13D55C0FFFFFFFFFFFF7C7FE3A5AFF59DABFA778CF0545FEC545FEC54
                  5FEC545FEC545FEC545FEC6377F2818EF4787FE9566BC9FFFFFFFFFFFFB5B5F0
                  7D83EACDD4FC8B9DFA7E93F7758AEE6C84F66C84F66C84F66C84F66379F3A4AF
                  F83E4FD0A0ABE1FFFFFFFFFFFFEBEBFB7978E3A3A7F3D4DBFD879AFA7F91F07A
                  8EF17F94F87E92F9768CF8A8B6F8636EE35868CDE6E8F7FFFFFFFFFFFFFFFFFF
                  CFCFF6706FE1AAADF2D8DCFDAEBAFA91A3FA8B9DFA9CA9FBBAC7FC707BE95462
                  CEC3C9EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFF67979E28E93EDBEC3F8CC
                  D3F9C4CBF9AAB4F46670E2646ED6C6CAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFEBEBFBB6B6F07D7FE26A6BDE686BDC7479DEAFB3EBE8E9F9FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              end
            end
          end
        end
      end
      object TabSheet4: TRzTabSheet
        Color = clWhite
        Caption = #36820#21033#35774#32622
        object RzPanel1: TRzPanel
          Left = 0
          Top = 0
          Width = 627
          Height = 257
          Align = alClient
          BorderOuter = fsNone
          BorderColor = clWhite
          BorderWidth = 5
          Color = clWhite
          TabOrder = 0
          object KpiGrid: TAdvStringGrid
            Left = 5
            Top = 5
            Width = 617
            Height = 247
            Cursor = crDefault
            Align = alClient
            ColCount = 4
            DefaultRowHeight = 20
            DefaultDrawing = False
            FixedCols = 0
            RowCount = 5
            FixedRows = 1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            GridLineWidth = 1
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
            ParentFont = False
            PopupMenu = KpiPm
            TabOrder = 0
            OnKeyPress = KpiGridKeyPress
            OnKeyUp = KpiGridKeyUp
            GridLineColor = clSilver
            ActiveCellShow = False
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = [fsBold]
            ActiveCellColor = clGray
            Bands.PrimaryColor = clInfoBk
            Bands.PrimaryLength = 1
            Bands.SecondaryColor = clWindow
            Bands.SecondaryLength = 1
            Bands.Print = False
            AutoNumAlign = False
            AutoSize = False
            VAlignment = vtaCenter
            EnhTextSize = False
            EnhRowColMove = False
            SizeWithForm = False
            Multilinecells = False
            OnGetAlignment = KpiGridGetAlignment
            OnClickCell = KpiGridClickCell
            OnCanEditCell = KpiGridCanEditCell
            OnCellsChanged = KpiGridCellsChanged
            OnGetFloatFormat = KpiGridGetFloatFormat
            DragDropSettings.OleAcceptFiles = True
            DragDropSettings.OleAcceptText = True
            SortSettings.AutoColumnMerge = False
            SortSettings.Column = 0
            SortSettings.Show = False
            SortSettings.IndexShow = False
            SortSettings.IndexColor = clYellow
            SortSettings.Full = True
            SortSettings.SingleColumn = False
            SortSettings.IgnoreBlanks = False
            SortSettings.BlankPos = blFirst
            SortSettings.AutoFormat = True
            SortSettings.Direction = sdAscending
            SortSettings.FixedCols = False
            SortSettings.NormalCellsOnly = False
            SortSettings.Row = 0
            FloatingFooter.Color = clBtnFace
            FloatingFooter.Column = 0
            FloatingFooter.FooterStyle = fsFixedLastRow
            FloatingFooter.Visible = False
            ControlLook.Color = clBlack
            ControlLook.CheckSize = 15
            ControlLook.RadioSize = 10
            ControlLook.ControlStyle = csWinXP
            ControlLook.FlatButton = False
            EnableBlink = False
            EnableHTML = True
            EnableWheel = True
            Flat = False
            Look = glTMS
            HintColor = clYellow
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SelectionRectangle = False
            SelectionResizer = False
            SelectionRTFKeep = False
            HintShowCells = False
            HintShowLargeText = False
            HintShowSizing = False
            PrintSettings.FooterSize = 0
            PrintSettings.HeaderSize = 0
            PrintSettings.Time = ppNone
            PrintSettings.Date = ppNone
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.PageNr = ppNone
            PrintSettings.Title = ppNone
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.BorderStyle = psSolid
            PrintSettings.Centered = False
            PrintSettings.RepeatFixedRows = False
            PrintSettings.RepeatFixedCols = False
            PrintSettings.LeftSize = 0
            PrintSettings.RightSize = 0
            PrintSettings.ColumnSpacing = 0
            PrintSettings.RowSpacing = 0
            PrintSettings.TitleSpacing = 0
            PrintSettings.Orientation = poPortrait
            PrintSettings.PagePrefix = 'page'
            PrintSettings.PageNumberOffset = 0
            PrintSettings.MaxPagesOffset = 0
            PrintSettings.FixedWidth = 0
            PrintSettings.FixedHeight = 0
            PrintSettings.UseFixedHeight = False
            PrintSettings.UseFixedWidth = False
            PrintSettings.FitToPage = fpNever
            PrintSettings.PageNumSep = '/'
            PrintSettings.NoAutoSize = False
            PrintSettings.NoAutoSizeRow = False
            PrintSettings.PrintGraphics = False
            HTMLSettings.Width = 100
            HTMLSettings.XHTML = False
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceDirection = adLeftRight
            Navigation.InsertPosition = pInsertBefore
            Navigation.HomeEndKey = heFirstLastColumn
            Navigation.TabToNextAtEnd = False
            Navigation.TabAdvanceDirection = adLeftRight
            ColumnSize.Location = clRegistry
            CellNode.Color = clSilver
            CellNode.NodeColor = clBlack
            CellNode.ShowTree = False
            MaxEditLength = 0
            MouseActions.DirectEdit = True
            IntelliPan = ipVertical
            URLColor = clBlack
            URLShow = False
            URLFull = False
            URLEdit = False
            ScrollType = ssNormal
            ScrollColor = clNone
            ScrollWidth = 16
            ScrollSynch = False
            ScrollProportional = False
            ScrollHints = shNone
            OemConvert = False
            FixedFooters = 0
            FixedRightCols = 0
            FixedColWidth = 48
            FixedRowHeight = 22
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FixedAsButtons = False
            FloatFormat = '%.2f'
            IntegralHeight = False
            WordWrap = False
            Lookup = False
            LookupCaseSensitive = False
            LookupHistory = False
            BackGround.Top = 0
            BackGround.Left = 0
            BackGround.Display = bdTile
            BackGround.Cells = bcNormal
            Filter = <>
            ColWidths = (
              48
              60
              71
              64)
            RowHeights = (
              22
              20
              20
              20
              20)
          end
        end
      end
      object TabSheet5: TRzTabSheet
        Color = clWhite
        Caption = #24066#22330#36153#35774#32622
        object RzPanel5: TRzPanel
          Left = 0
          Top = 0
          Width = 627
          Height = 257
          Align = alClient
          BorderOuter = fsNone
          BorderColor = clWhite
          BorderWidth = 5
          Color = clWhite
          TabOrder = 0
          object DBGridEh5: TDBGridEh
            Left = 5
            Top = 5
            Width = 617
            Height = 247
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = Ds_MktGoods
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 2
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection]
            RowHeight = 17
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            VertScrollBar.VisibleMode = sbAlwaysShowEh
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh5DrawColumnCell
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 31
              end
              item
                EditButtons = <>
                FieldName = 'GODS_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #21830#21697#21517#31216
                Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721#12289#35745#37327#21333#20301#26465#30721'" '#26597#35810
                Width = 142
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                ReadOnly = True
                Tag = 1
                Title.Caption = #36135#21495
                Width = 61
              end
              item
                EditButtons = <>
                FieldName = 'BARCODE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #26465#30721
                Width = 93
              end
              item
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                Title.Caption = #21333#20301
                Width = 52
                OnBeforeShowControl = DBGridEh5Columns4BeforeShowControl
              end
              item
                DisplayFormat = '#0.##'
                EditButtons = <>
                FieldName = 'ACTR_RATIO'
                Footers = <>
                Title.Caption = #35745#25552#31995#25968
                Width = 63
              end>
          end
          object fndUNIT_ID1: TcxComboBox
            Left = 336
            Top = 25
            Width = 57
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = fndUNIT_ID1PropertiesChange
            TabOrder = 1
            Visible = False
            OnEnter = fndUNIT_ID1Enter
            OnExit = fndUNIT_ID1Exit
            OnKeyDown = fndUNIT_ID1KeyDown
            OnKeyPress = fndUNIT_ID1KeyPress
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 387
      Width = 631
      Color = clWhite
      object Btn_Save: TRzBitBtn
        Left = 469
        Top = 11
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
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Close: TRzBitBtn
        Left = 559
        Top = 11
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
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel4: TRzPanel
      Left = 5
      Top = 5
      Width = 631
      Height = 98
      Align = alTop
      BorderOuter = fsNone
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 2
      object lab_KPI_NAME: TRzLabel
        Left = 6
        Top = 7
        Width = 90
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25351#26631#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_IDX_TYPE: TRzLabel
        Left = 6
        Top = 49
        Width = 90
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25351#26631#31867#22411
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel2: TRzLabel
        Left = 237
        Top = 49
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel1: TRzLabel
        Left = 309
        Top = 7
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel11: TRzLabel
        Left = 258
        Top = 28
        Width = 83
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25340' '#38899' '#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_KPI_TYPE: TLabel
        Left = 260
        Top = 49
        Width = 83
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #32771#26680#31867#22411
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel3: TRzLabel
        Left = 483
        Top = 49
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel9: TRzLabel
        Left = 152
        Top = 28
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel10: TRzLabel
        Left = 40
        Top = 28
        Width = 57
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #31614#32422#21333#20301
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel5: TRzLabel
        Left = 6
        Top = 70
        Width = 90
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #22791#27880
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtIDX_TYPE: TcxComboBox
        Left = 103
        Top = 45
        Width = 130
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = edtIDX_TYPEPropertiesChange
        TabOrder = 2
      end
      object edtKPI_NAME: TcxTextEdit
        Left = 103
        Top = 3
        Width = 202
        Height = 20
        Properties.MaxLength = 50
        Properties.OnChange = edtKPI_NAMEPropertiesChange
        TabOrder = 0
      end
      object edtKPI_SPELL: TcxTextEdit
        Left = 350
        Top = 24
        Width = 130
        Height = 20
        Properties.MaxLength = 50
        TabOrder = 5
      end
      object edtKPI_TYPE: TcxComboBox
        Left = 350
        Top = 45
        Width = 130
        Height = 20
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 3
      end
      object edtUNIT_NAME: TcxTextEdit
        Left = 103
        Top = 24
        Width = 43
        Height = 20
        Properties.MaxLength = 10
        Properties.OnChange = edtUNIT_NAMEPropertiesChange
        TabOrder = 1
      end
      object edtREMARK: TcxTextEdit
        Left = 103
        Top = 66
        Width = 298
        Height = 20
        Properties.MaxLength = 100
        TabOrder = 4
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 398
    Top = 293
  end
  inherited actList: TActionList
    Left = 430
    Top = 293
  end
  object CdsKpiLevel: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 47
    Top = 271
  end
  object Ds_KpiLevel: TDataSource
    DataSet = CdsKpiLevel
    Left = 79
    Top = 271
  end
  object CdsKpiIndex: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 203
  end
  object CdsKpiGoods: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 239
  end
  object Ds_KpiGoods: TDataSource
    DataSet = CdsKpiGoods
    Left = 79
    Top = 238
  end
  object Pm_Level: TPopupMenu
    Left = 18
    Top = 271
    object AddLevel: TMenuItem
      Caption = #26032#22686#31561#32423
      OnClick = AddLevelClick
    end
    object DelLevel: TMenuItem
      Caption = #21024#38500#31561#32423
      OnClick = DelLevelClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
  end
  object Pm_Gods: TPopupMenu
    Left = 19
    Top = 239
    object AddGoods: TMenuItem
      Caption = #26032#22686#21830#21697
      OnClick = AddGoodsClick
    end
    object DeleteGoods: TMenuItem
      Caption = #21024#38500#21333#21697
      OnClick = DeleteGoodsClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
  end
  object Ds_KpiTimes: TDataSource
    DataSet = CdsKpiTimes
    Left = 79
    Top = 301
  end
  object CdsKpiTimes: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 48
    Top = 302
  end
  object Pm_Times: TPopupMenu
    Left = 19
    Top = 304
    object AddKpiTimes: TMenuItem
      Caption = #26032#22686#26102#27573
      OnClick = AddKpiTimesClick
    end
    object EditKpiTimes: TMenuItem
      Caption = #20462#25913#26102#27573
      OnClick = EditKpiTimesClick
    end
    object DelKpiTimes: TMenuItem
      Caption = #21024#38500#26102#27573
      OnClick = DelKpiTimesClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
  end
  object KpiPm: TPopupMenu
    OnPopup = KpiPmPopup
    Left = 10
    Top = 400
    object AddSeqNo: TMenuItem
      Caption = #28155#21152#36798#26631#26723#20301
      OnClick = AddSeqNoClick
    end
    object ItemRatio: TMenuItem
      Caption = #32534#36753#21830#21697#21333#20301
      OnClick = ItemRatioClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Caption = #20445#23384
      OnClick = N8Click
    end
  end
  object CdsKpiRatio: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 47
    Top = 364
  end
  object CdsKpiSeqNo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 47
    Top = 332
  end
  object CdsMktGoods: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 47
    Top = 397
  end
  object Ds_MktGoods: TDataSource
    DataSet = CdsMktGoods
    Left = 79
    Top = 397
  end
end
