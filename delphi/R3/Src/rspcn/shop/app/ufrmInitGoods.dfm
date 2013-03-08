inherited frmInitGoods: TfrmInitGoods
  Left = 55
  Top = 16
  Caption = #21830#21697#21021#22987#21270#21521#23548
  ClientHeight = 662
  ClientWidth = 1241
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 1241
    Height = 662
    inherited webForm: TRzPanel
      Width = 1241
      Height = 662
      inherited bkgImage: TImage
        Width = 1241
        Height = 662
      end
      object RzPanel1: TRzPanel
        Left = 328
        Top = 126
        Width = 616
        Height = 460
        BorderOuter = fsFlatRounded
        BorderWidth = 2
        TabOrder = 0
        object RzPanel2: TRzPanel
          Left = 187
          Top = 4
          Width = 425
          Height = 452
          Align = alRight
          BorderInner = fsFlatRounded
          BorderOuter = fsNone
          BorderSides = []
          TabOrder = 0
          object rzPage: TRzPageControl
            Left = 0
            Top = 0
            Width = 425
            Height = 452
            ActivePage = TabSheet1
            Align = alClient
            Color = clWindow
            UseColoredTabs = True
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabIndex = 0
            TabOrder = 0
            FixedDimension = 21
            object TabSheet1: TRzTabSheet
              Color = clWhite
              Caption = #24320#22987#21521#23548
              object lblInput: TLabel
                Left = 45
                Top = 200
                Width = 84
                Height = 20
                Caption = #26465#30721#36755#20837
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -20
                Font.Name = #40657#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object RzLabel1: TRzLabel
                Left = 20
                Top = 20
                Width = 100
                Height = 24
                Caption = #31532#19968#27493#65306
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object RzLabel2: TRzLabel
                Left = 60
                Top = 60
                Width = 90
                Height = 15
                Caption = #36873#25321#21830#21697#31867#22411
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object edtGOODS_OPTION1: TcxRadioButton
                Left = 45
                Top = 130
                Width = 113
                Height = 17
                Caption = #26377#26465#30721#21830#21697
                Checked = True
                TabOrder = 0
                TabStop = True
                OnClick = edtGOODS_OPTION1Click
              end
              object edtGOODS_OPTION2: TcxRadioButton
                Left = 250
                Top = 130
                Width = 113
                Height = 17
                Caption = #26080#26465#30721#21830#21697
                TabOrder = 1
                OnClick = edtGOODS_OPTION2Click
              end
              object edtInput: TcxTextEdit
                Left = 146
                Top = 195
                Width = 204
                Height = 27
                ParentFont = False
                Style.BorderStyle = ebsThick
                Style.Font.Charset = GB2312_CHARSET
                Style.Font.Color = clNavy
                Style.Font.Height = -19
                Style.Font.Name = #40657#20307
                Style.Font.Style = [fsBold]
                TabOrder = 2
                OnKeyPress = edtInputKeyPress
              end
            end
            object TabSheet2: TRzTabSheet
              Color = clWindow
              Caption = #21830#21697#23646#24615
              object Label5: TLabel
                Left = 214
                Top = 120
                Width = 61
                Height = 15
                Alignment = taRightJustify
                Caption = #26465' '#24418' '#30721
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label11: TLabel
                Left = 20
                Top = 120
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #21830#21697#36135#21495
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel
                Left = 20
                Top = 160
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #21830#21697#21517#31216
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label30: TLabel
                Left = 20
                Top = 200
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #35745#37327#21333#20301
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                Left = 20
                Top = 240
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #26631#20934#36827#20215
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label10: TLabel
                Left = 215
                Top = 240
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #26631#20934#21806#20215
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object lblSORT_ID1: TLabel
                Left = 215
                Top = 200
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #21830#21697#20998#31867
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzLabel3: TRzLabel
                Left = 20
                Top = 20
                Width = 100
                Height = 24
                Caption = #31532#20108#27493#65306
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object RzLabel4: TRzLabel
                Left = 60
                Top = 60
                Width = 120
                Height = 15
                Caption = #22635#20889#21830#21697#23646#24615#20449#24687
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object edtBARCODE1: TcxTextEdit
                Left = 285
                Top = 115
                Width = 116
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtGODS_CODE: TcxTextEdit
                Left = 90
                Top = 115
                Width = 115
                Height = 23
                Properties.MaxLength = 20
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtGODS_NAME: TcxTextEdit
                Left = 90
                Top = 155
                Width = 310
                Height = 23
                Properties.MaxLength = 50
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtCALC_UNITS: TzrComboBoxList
                Left = 90
                Top = 195
                Width = 116
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 3
                InGrid = False
                KeyValue = Null
                FilterFields = 'UNIT_NAME;UNIT_SPELL;UNIT_ID'
                KeyField = 'UNIT_ID'
                ListField = 'UNIT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_NAME'
                    Footers = <>
                    Title.Caption = #21333#20301#21517#31216
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_ID'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Visible = False
                    Width = 50
                  end>
                DropWidth = 100
                DropHeight = 120
                ShowTitle = False
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
              object edtNEW_INPRICE: TcxTextEdit
                Left = 90
                Top = 235
                Width = 116
                Height = 23
                TabOrder = 4
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtNEW_OUTPRICE: TcxTextEdit
                Left = 285
                Top = 235
                Width = 116
                Height = 23
                TabOrder = 5
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtMoreUnits: TcxCheckBox
                Left = 17
                Top = 280
                Width = 150
                Height = 23
                Properties.DisplayUnchecked = 'False'
                Properties.OnChange = edtMoreUnitsPropertiesChange
                Properties.Caption = #21551#29992#22810#21253#35013#31649#29702
                TabOrder = 6
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtSORT_ID: TcxButtonEdit
                Left = 285
                Top = 195
                Width = 116
                Height = 23
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = True
                Properties.OnButtonClick = edtSORT_IDPropertiesButtonClick
                Style.BorderStyle = ebsUltraFlat
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.ButtonStyle = btsUltraFlat
                TabOrder = 7
              end
              object edtSORT_ID1: TcxTextEdit
                Left = 285
                Top = 275
                Width = 116
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 8
                Visible = False
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object TabSheet3: TRzTabSheet
              Color = clWindow
              Caption = #21830#21697#21253#35013
              object RzLabel5: TRzLabel
                Left = 20
                Top = 20
                Width = 100
                Height = 24
                Caption = #31532#19977#27493#65306
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object RzLabel6: TRzLabel
                Left = 60
                Top = 60
                Width = 120
                Height = 15
                Caption = #22635#20889#21830#21697#21253#35013#20449#24687
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label9: TLabel
                Left = 54
                Top = 165
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #21253#35013#26465#30721
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 54
                Top = 195
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #25442#31639#31995#25968
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label4: TLabel
                Left = 54
                Top = 135
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #21253#35013#21333#20301
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label16: TLabel
                Left = 54
                Top = 290
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #21253#35013#26465#30721
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label14: TLabel
                Left = 54
                Top = 320
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #25442#31639#31995#25968
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label12: TLabel
                Left = 54
                Top = 260
                Width = 60
                Height = 15
                Alignment = taRightJustify
                Caption = #21253#35013#21333#20301
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzLabel7: TRzLabel
                Left = 25
                Top = 105
                Width = 45
                Height = 15
                Caption = #23567#21253#35013
              end
              object RzLabel8: TRzLabel
                Left = 25
                Top = 230
                Width = 45
                Height = 15
                Caption = #22823#21253#35013
              end
              object Bevel1: TBevel
                Left = 75
                Top = 111
                Width = 300
                Height = 2
                Shape = bsTopLine
              end
              object Bevel2: TBevel
                Left = 75
                Top = 236
                Width = 300
                Height = 2
                Shape = bsTopLine
              end
              object lblSMALL_NOTE: TLabel
                Left = 245
                Top = 195
                Width = 60
                Height = 15
                Caption = #31995#25968#25552#31034
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Visible = False
              end
              object lblBIG_NOTE: TLabel
                Left = 245
                Top = 320
                Width = 60
                Height = 15
                Caption = #31995#25968#25552#31034
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Visible = False
              end
              object edtSMALLTO_CALC: TcxTextEdit
                Left = 122
                Top = 190
                Width = 116
                Height = 23
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtSMALL_UNITS: TzrComboBoxList
                Left = 122
                Top = 130
                Width = 70
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtSMALL_UNITSPropertiesChange
                TabOrder = 1
                InGrid = False
                KeyValue = Null
                FilterFields = 'UNIT_NAME;UNIT_SPELL;UNIT_ID'
                KeyField = 'UNIT_ID'
                ListField = 'UNIT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_NAME'
                    Footers = <>
                    Title.Caption = #21333#20301#21517#31216
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_ID'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Visible = False
                    Width = 50
                  end>
                DropWidth = 100
                DropHeight = 120
                ShowTitle = False
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                OnSaveValue = edtSMALL_UNITSSaveValue
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
              object edtDefault1: TcxCheckBox
                Left = 200
                Top = 130
                Width = 121
                Height = 23
                Properties.DisplayUnchecked = 'False'
                Properties.Caption = #35774#20026#31649#29702#21333#20301
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnClick = edtDefault1Click
              end
              object edtBARCODE2: TcxTextEdit
                Left = 122
                Top = 160
                Width = 116
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 3
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtDefault2: TcxCheckBox
                Left = 200
                Top = 255
                Width = 121
                Height = 23
                Properties.DisplayUnchecked = 'False'
                Properties.Caption = #35774#20026#31649#29702#21333#20301
                TabOrder = 4
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnClick = edtDefault2Click
              end
              object edtBIGTO_CALC: TcxTextEdit
                Left = 122
                Top = 315
                Width = 116
                Height = 23
                TabOrder = 5
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtBIG_UNITS: TzrComboBoxList
                Left = 122
                Top = 255
                Width = 70
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtBIG_UNITSPropertiesChange
                TabOrder = 6
                InGrid = False
                KeyValue = Null
                FilterFields = 'UNIT_NAME;UNIT_SPELL;UNIT_ID'
                KeyField = 'UNIT_ID'
                ListField = 'UNIT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_NAME'
                    Footers = <>
                    Title.Caption = #21333#20301#21517#31216
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_ID'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Visible = False
                    Width = 50
                  end>
                DropWidth = 100
                DropHeight = 120
                ShowTitle = False
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                OnSaveValue = edtBIG_UNITSSaveValue
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
              object edtBARCODE3: TcxTextEdit
                Left = 122
                Top = 285
                Width = 116
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 7
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
          end
        end
        object RzPanel3: TRzPanel
          Left = 188
          Top = 414
          Width = 421
          Height = 42
          BorderOuter = fsFlat
          BorderSides = [sdBottom]
          Color = clWhite
          TabOrder = 1
          DesignSize = (
            421
            42)
          object btnNext: TRzBitBtn
            Left = 335
            Top = 7
            Width = 70
            Height = 28
            Anchors = [akTop]
            Caption = #19979#19968#27493
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            HighlightColor = 14276036
            HotTrack = True
            HotTrackColor = 3983359
            HotTrackColorType = htctActual
            ParentFont = False
            TextShadowColor = clWhite
            TextShadowDepth = 4
            TabOrder = 0
            TabStop = False
            ThemeAware = False
            OnClick = btnNextClick
            NumGlyphs = 2
            Spacing = 5
          end
          object btnPrev: TRzBitBtn
            Left = 255
            Top = 7
            Width = 70
            Height = 28
            Anchors = [akTop]
            Caption = #19978#19968#27493
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            HighlightColor = 14276036
            HotTrack = True
            HotTrackColor = 3983359
            HotTrackColorType = htctActual
            ParentFont = False
            TextShadowColor = clWhite
            TextShadowDepth = 4
            TabOrder = 1
            TabStop = False
            ThemeAware = False
            OnClick = btnPrevClick
            NumGlyphs = 2
            Spacing = 5
          end
        end
        object RzPanel7: TRzPanel
          Left = 4
          Top = 4
          Width = 180
          Height = 452
          Align = alLeft
          BorderOuter = fsFlat
          Color = clWhite
          TabOrder = 2
        end
      end
    end
  end
  object cdsGoodsInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 330
    Top = 472
  end
  object cdsGoodsRelation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 394
    Top = 472
  end
  object cdsBarCode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 458
    Top = 472
  end
  object edtTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 526
    Top = 472
  end
end
