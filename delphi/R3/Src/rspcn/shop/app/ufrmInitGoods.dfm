inherited frmInitGoods: TfrmInitGoods
  Left = 256
  Top = 72
  Caption = 'frmInitGoods'
  ClientHeight = 604
  ClientWidth = 939
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 939
    Height = 604
    inherited webForm: TRzPanel
      Width = 939
      Height = 604
      inherited bkgImage: TImage
        Width = 939
        Height = 604
      end
      object RzPanel1: TRzPanel
        Left = 288
        Top = 102
        Width = 600
        Height = 460
        BorderOuter = fsFlatRounded
        TabOrder = 0
        object RzPanel2: TRzPanel
          Left = 173
          Top = 2
          Width = 425
          Height = 456
          Align = alRight
          BorderOuter = fsNone
          TabOrder = 0
          object rzPage: TRzPageControl
            Left = 0
            Top = 0
            Width = 425
            Height = 456
            ActivePage = TabSheet1
            Align = alClient
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabIndex = 0
            TabOrder = 0
            FixedDimension = 19
            object TabSheet1: TRzTabSheet
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
              object RzPanel4: TRzPanel
                Left = 30
                Top = 16
                Width = 370
                Height = 57
                BorderOuter = fsGroove
                TabOrder = 3
                object RzLabel5: TRzLabel
                  Left = 17
                  Top = 6
                  Width = 80
                  Height = 19
                  Caption = #31532#19968#27493#65306
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -19
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object RzLabel6: TRzLabel
                  Left = 40
                  Top = 35
                  Width = 72
                  Height = 12
                  Caption = #36873#25321#21830#21697#31867#22411
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
              end
            end
            object TabSheet2: TRzTabSheet
              Caption = #21830#21697#23646#24615
              object Label5: TLabel
                Left = 222
                Top = 120
                Width = 53
                Height = 13
                Alignment = taRightJustify
                Caption = #26465' '#24418' '#30721
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label11: TLabel
                Left = 28
                Top = 120
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = #21830#21697#36135#21495
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel
                Left = 28
                Top = 160
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = #21830#21697#21517#31216
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label30: TLabel
                Left = 28
                Top = 200
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = #35745#37327#21333#20301
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                Left = 28
                Top = 240
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = #26631#20934#36827#20215
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label10: TLabel
                Left = 223
                Top = 240
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = #26631#20934#21806#20215
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object lblSORT_ID1: TLabel
                Left = 223
                Top = 200
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = #21830#21697#20998#31867
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object edtBARCODE1: TcxTextEdit
                Left = 285
                Top = 115
                Width = 116
                Height = 21
                Properties.MaxLength = 30
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtGODS_CODE: TcxTextEdit
                Left = 90
                Top = 115
                Width = 115
                Height = 21
                Properties.MaxLength = 20
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtGODS_NAME: TcxTextEdit
                Left = 90
                Top = 155
                Width = 310
                Height = 21
                Properties.MaxLength = 50
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtCALC_UNITS: TzrComboBoxList
                Left = 90
                Top = 195
                Width = 116
                Height = 21
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
                Height = 21
                TabOrder = 5
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtNEW_OUTPRICE: TcxTextEdit
                Left = 285
                Top = 235
                Width = 116
                Height = 21
                TabOrder = 6
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtSORT_ID1: TzrComboBoxList
                Left = 285
                Top = 195
                Width = 116
                Height = 21
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 4
                InGrid = False
                KeyValue = Null
                FilterFields = 'SORT_NAME;SORT_SPELL;SORT_ID'
                KeyField = 'SORT_ID'
                ListField = 'SORT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SORT_NAME'
                    Footers = <>
                    Title.Caption = #21333#20301#21517#31216
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SORT_ID'
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
              object edtMoreUnits: TcxCheckBox
                Left = 25
                Top = 280
                Width = 150
                Height = 21
                Properties.DisplayUnchecked = 'False'
                Properties.OnChange = edtMoreUnitsPropertiesChange
                Properties.Caption = #21551#29992#22810#21253#35013#31649#29702
                TabOrder = 7
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzPanel5: TRzPanel
                Left = 30
                Top = 16
                Width = 370
                Height = 57
                BorderOuter = fsGroove
                TabOrder = 8
                object RzLabel1: TRzLabel
                  Left = 17
                  Top = 6
                  Width = 80
                  Height = 19
                  Caption = #31532#20108#27493#65306
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -19
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object RzLabel2: TRzLabel
                  Left = 40
                  Top = 35
                  Width = 72
                  Height = 12
                  Caption = #36755#20837#21830#21697#20449#24687
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
              end
            end
            object TabSheet3: TRzTabSheet
              Caption = #21830#21697#21253#35013
              object GroupBox1: TGroupBox
                Left = 30
                Top = 100
                Width = 370
                Height = 125
                Caption = #23567#21253#35013
                TabOrder = 0
                object Label4: TLabel
                  Left = 32
                  Top = 30
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = #21253#35013#21333#20301
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label6: TLabel
                  Left = 32
                  Top = 90
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = #25442#31639#31995#25968
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label9: TLabel
                  Left = 32
                  Top = 60
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = #21253#35013#26465#30721
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object edtSMALL_UNITS: TzrComboBoxList
                  Left = 92
                  Top = 25
                  Width = 70
                  Height = 21
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 0
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
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object edtSMALLTO_CALC: TcxTextEdit
                  Left = 92
                  Top = 85
                  Width = 180
                  Height = 21
                  TabOrder = 1
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object edtBARCODE2: TcxTextEdit
                  Left = 92
                  Top = 55
                  Width = 180
                  Height = 21
                  Properties.MaxLength = 30
                  TabOrder = 2
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object edtDefault1: TcxCheckBox
                  Left = 170
                  Top = 25
                  Width = 121
                  Height = 21
                  Properties.DisplayUnchecked = 'False'
                  Properties.Caption = #35774#20026#31649#29702#21333#20301
                  TabOrder = 3
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  OnClick = edtDefault1Click
                end
              end
              object GroupBox2: TGroupBox
                Left = 30
                Top = 240
                Width = 370
                Height = 125
                Caption = #22823#21253#35013
                TabOrder = 1
                object Label12: TLabel
                  Left = 32
                  Top = 30
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = #21253#35013#21333#20301
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label14: TLabel
                  Left = 32
                  Top = 90
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = #25442#31639#31995#25968
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label16: TLabel
                  Left = 32
                  Top = 60
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = #21253#35013#26465#30721
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object edtBIG_UNITS: TzrComboBoxList
                  Left = 92
                  Top = 25
                  Width = 70
                  Height = 21
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 0
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
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object edtBIGTO_CALC: TcxTextEdit
                  Left = 92
                  Top = 85
                  Width = 180
                  Height = 21
                  TabOrder = 1
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object edtBARCODE3: TcxTextEdit
                  Left = 92
                  Top = 55
                  Width = 180
                  Height = 21
                  Properties.MaxLength = 30
                  TabOrder = 2
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
                object edtDefault2: TcxCheckBox
                  Left = 170
                  Top = 25
                  Width = 121
                  Height = 21
                  Properties.DisplayUnchecked = 'False'
                  Properties.Caption = #35774#20026#31649#29702#21333#20301
                  TabOrder = 3
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  OnClick = edtDefault2Click
                end
              end
              object RzPanel6: TRzPanel
                Left = 30
                Top = 16
                Width = 370
                Height = 57
                BorderOuter = fsGroove
                TabOrder = 2
                object RzLabel3: TRzLabel
                  Left = 17
                  Top = 6
                  Width = 80
                  Height = 19
                  Caption = #31532#19977#27493#65306
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -19
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object RzLabel4: TRzLabel
                  Left = 40
                  Top = 35
                  Width = 96
                  Height = 12
                  Caption = #36755#20837#21830#21697#21253#35013#20449#24687
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
              end
            end
          end
        end
        object RzPanel3: TRzPanel
          Left = 170
          Top = 418
          Width = 425
          Height = 40
          BorderOuter = fsFlat
          BorderSides = [sdTop]
          TabOrder = 1
          DesignSize = (
            425
            40)
          object btnNext: TRzBitBtn
            Left = 339
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
            Left = 232
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
          Left = 2
          Top = 2
          Width = 175
          Height = 456
          Align = alLeft
          BorderOuter = fsFlat
          BorderSides = [sdRight]
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
  object cdsSmallBarCode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 362
    Top = 472
  end
  object cdsGoodsRelation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 394
    Top = 472
  end
  object cdsBigBarCode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 426
    Top = 472
  end
  object cdsBarCode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 458
    Top = 472
  end
  object SortDataSet: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 492
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
