inherited frmImplementionTool: TfrmImplementionTool
  Left = 312
  Top = 156
  Width = 942
  Height = 592
  Caption = #25968#25454#23454#26045
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 934
    Height = 528
    inherited RzPanel2: TRzPanel
      Width = 924
      Height = 518
      inherited RzPage: TRzPageControl
        Width = 918
        Height = 512
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          inherited RzPanel3: TRzPanel
            Width = 916
            Height = 485
            object Panel2: TPanel
              Left = 5
              Top = 5
              Width = 906
              Height = 58
              Align = alTop
              Alignment = taLeftJustify
              BevelInner = bvLowered
              ParentColor = True
              TabOrder = 0
              object Label21: TLabel
                Left = 20
                Top = 10
                Width = 48
                Height = 12
                Caption = #20225#19994#21517#31216
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label12: TLabel
                Left = 21
                Top = 37
                Width = 48
                Height = 12
                Caption = #25152#23646#22320#21306
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label2: TLabel
                Left = 282
                Top = 10
                Width = 169
                Height = 12
                Caption = #25903#25345#65288#20225#19994#21517#12289#25340#38899#30721#65289#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btnOk: TRzBitBtn
                Left = 283
                Top = 27
                Width = 67
                Height = 24
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
                TabOrder = 2
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object edtREGION_ID: TzrComboBoxList
                Tag = -1
                Left = 74
                Top = 33
                Width = 149
                Height = 20
                ParentFont = False
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 1
                InGrid = False
                KeyValue = Null
                FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
                KeyField = 'CODE_ID'
                ListField = 'CODE_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CODE_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
                    Width = 115
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CODE_ID'
                    Footers = <>
                    Title.Caption = #32534#30721
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
              object edtKey: TcxTextEdit
                Left = 74
                Top = 6
                Width = 196
                Height = 20
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object RzPanel6: TRzPanel
              Left = 5
              Top = 63
              Width = 906
              Height = 417
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 1
              object Panel1: TPanel
                Left = 0
                Top = 0
                Width = 906
                Height = 417
                Align = alClient
                Caption = 'Panel1'
                TabOrder = 0
                object Grid: TDBGridEh
                  Left = 1
                  Top = 1
                  Width = 904
                  Height = 415
                  Align = alClient
                  AllowedOperations = [alopUpdateEh]
                  DataSource = cdsTenant
                  Flat = True
                  FooterColor = clWindow
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 1
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                  OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                  RowHeight = 20
                  SumList.Active = True
                  TabOrder = 0
                  TitleFont.Charset = GB2312_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -12
                  TitleFont.Name = #23435#20307
                  TitleFont.Style = []
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDrawColumnCell = GridDrawColumnCell
                  Columns = <
                    item
                      Checkboxes = True
                      EditButtons = <>
                      FieldName = 'A'
                      Footers = <>
                      KeyList.Strings = (
                        '1'
                        '0')
                      PickList.Strings = (
                        '0'
                        '1')
                      Tag = -1
                      Title.Caption = #36873#25321
                      Visible = False
                      Width = 21
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQNO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 30
                    end
                    item
                      EditButtons = <>
                      FieldName = 'TENANT_NAME'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #20225#19994#21517#31216
                      Width = 120
                    end
                    item
                      EditButtons = <>
                      FieldName = 'TENANT_SPELL'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25340#38899#30721
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      FieldName = 'LOGIN_NAME'
                      Footers = <>
                      Title.Caption = #30331#24405#21517
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      FieldName = 'LICENSE_CODE'
                      Footers = <>
                      Title.Caption = #35768#21487#35777#21495
                      Width = 90
                    end
                    item
                      EditButtons = <>
                      FieldName = 'TENANT_TYPE_NAME'
                      Footers = <>
                      Title.Caption = #20225#19994#31867#22411
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'PROD_ID'
                      Footers = <>
                      Title.Caption = #20135#21697#32534#21495
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'LEGAL_REPR'
                      Footers = <>
                      Title.Caption = #27861#20154#20195#34920
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'REGION_ID_NAME'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25152#23646#21306#22495
                      Width = 90
                    end
                    item
                      EditButtons = <>
                      FieldName = 'LINKMAN'
                      Footers = <>
                      Title.Caption = #32852#31995#20154
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'TELEPHONE'
                      Footers = <>
                      Title.Caption = #32852#31995#30005#35805
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      FieldName = 'FAXES'
                      Footers = <>
                      Title.Caption = #20256#30495
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      FieldName = 'QQ'
                      Footers = <>
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MSN'
                      Footers = <>
                      Width = 90
                    end
                    item
                      EditButtons = <>
                      FieldName = 'ADDRESS'
                      Footers = <>
                      Title.Caption = #22320#22336
                      Width = 200
                    end
                    item
                      EditButtons = <>
                      FieldName = 'REMARK'
                      Footers = <>
                      Title.Caption = #22791#27880
                      Width = 150
                    end>
                end
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 934
    inherited Image1: TImage
      Left = 187
      Width = 727
    end
    inherited Image3: TImage
      Left = 187
      Width = 727
    end
    inherited Image14: TImage
      Left = 914
    end
    inherited rzPanel5: TPanel
      Left = 187
    end
    inherited CoolBar1: TCoolBar
      Width = 167
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 167
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 167
        ButtonWidth = 55
        object ToolButton2: TToolButton
          Left = 0
          Top = 0
          Action = actUnlock
        end
        object ToolButton4: TToolButton
          Left = 55
          Top = 0
          Action = actInfo
          Caption = #29992#25143#23494#30721
        end
        object ToolButton3: TToolButton
          Left = 110
          Top = 0
          Width = 2
          Caption = 'ToolButton3'
          ImageIndex = 14
          Style = tbsSeparator
        end
        object ToolButton1: TToolButton
          Left = 112
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited actList: TActionList
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    object actUnlock: TAction
      Caption = #35299#38145
      ImageIndex = 40
      OnExecute = actUnlockExecute
    end
  end
  object cdsTenant: TDataSource
    DataSet = dsTenant
    Left = 190
    Top = 239
  end
  object dsTenant: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 222
    Top = 239
  end
end
