inherited frmAnlyReport: TfrmAnlyReport
  Left = 264
  Caption = #32463#33829#20998#26512#25253#34920
  ClientWidth = 979
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 979
    inherited PageControl: TRzPageControl
      Width = 979
      FixedDimension = 21
      inherited TabSheet1: TRzTabSheet
        object RzPanel2: TRzPanel
          Left = 0
          Top = 42
          Width = 979
          Height = 287
          Align = alClient
          BorderOuter = fsNone
          BorderColor = 15461355
          BorderWidth = 10
          Color = 15461355
          TabOrder = 0
          object RzPanel3: TRzPanel
            Left = 10
            Top = 10
            Width = 959
            Height = 267
            Align = alClient
            BorderOuter = fsStatus
            BorderWidth = 2
            TabOrder = 0
            object RzPanel7: TRzPanel
              Left = 3
              Top = 3
              Width = 953
              Height = 261
              Align = alClient
              BorderOuter = fsFlat
              BorderSides = [sdLeft, sdTop]
              TabOrder = 0
              object RzToolbar1: TRzToolbar
                Left = 513
                Top = 49
                Width = 40
                Align = alNone
                AutoStyle = False
                Margin = 0
                TopMargin = 0
                BorderInner = fsNone
                BorderOuter = fsNone
                BorderSides = [sdTop]
                BorderWidth = 0
                Color = clWhite
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                Visible = False
                ToolbarControls = (
                  RzToolButton1)
                object RzToolButton1: TRzToolButton
                  Left = 0
                  Top = 0
                  Width = 35
                  Cursor = crHandPoint
                  ShowCaption = True
                  UseToolbarButtonSize = False
                  UseToolbarShowCaption = False
                  Caption = #26126#32454
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold, fsUnderline]
                  ParentFont = False
                end
              end
              object RzToolbar2: TRzToolbar
                Left = 521
                Top = 129
                Width = 48
                Align = alNone
                AutoStyle = False
                Margin = 0
                TopMargin = 0
                BorderInner = fsNone
                BorderOuter = fsNone
                BorderSides = [sdTop]
                BorderWidth = 0
                Color = clWhite
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                Visible = False
                ToolbarControls = (
                  )
                object TRzToolButton
                  Left = 0
                  Top = 0
                  Width = 35
                  Cursor = crHandPoint
                  ShowCaption = True
                  UseToolbarButtonSize = False
                  UseToolbarShowCaption = False
                  Caption = #35814#32454
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold, fsUnderline]
                  ParentFont = False
                end
              end
              object Chart2: TChart
                Left = 1
                Top = 1
                Width = 952
                Height = 260
                BackWall.Brush.Color = clWhite
                BackWall.Brush.Style = bsClear
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clBlue
                Title.Font.Height = -13
                Title.Font.Name = 'Arial'
                Title.Font.Style = []
                Title.Text.Strings = (
                  '')
                BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
                BottomAxis.Title.Font.Color = clBlack
                BottomAxis.Title.Font.Height = -12
                BottomAxis.Title.Font.Name = 'Arial'
                BottomAxis.Title.Font.Style = []
                View3D = False
                Align = alClient
                BevelOuter = bvNone
                Color = clWhite
                TabOrder = 2
                object BarSeries1: TBarSeries
                  ColorEachPoint = True
                  Marks.ArrowLength = 20
                  Marks.Style = smsValue
                  Marks.Visible = True
                  SeriesColor = 8404992
                  XValues.DateTime = False
                  XValues.Name = 'X'
                  XValues.Multiplier = 1.000000000000000000
                  XValues.Order = loAscending
                  YValues.DateTime = False
                  YValues.Name = 'Bar'
                  YValues.Multiplier = 1.000000000000000000
                  YValues.Order = loNone
                end
              end
            end
          end
        end
        object RzPanel21: TRzPanel
          Left = 0
          Top = 0
          Width = 979
          Height = 42
          Align = alTop
          BorderOuter = fsNone
          BorderColor = 15461355
          Caption = '`'
          Color = 15461355
          TabOrder = 1
          DesignSize = (
            979
            42)
          object RzPanel24: TRzPanel
            Left = 11
            Top = 11
            Width = 299
            Height = 31
            BorderOuter = fsStatus
            BorderWidth = 1
            Color = clWhite
            FlatColor = 9145227
            TabOrder = 0
            object RzPanel25: TRzPanel
              Left = 2
              Top = 2
              Width = 103
              Height = 27
              Align = alLeft
              BorderOuter = fsFlat
              BorderSides = [sdRight, sdBottom]
              FlatColor = clGray
              TabOrder = 0
              object RzBackground3: TRzBackground
                Left = 0
                Top = 0
                Width = 102
                Height = 26
                Active = True
                Align = alClient
                FrameColor = 9145227
                GradientColorStart = clWhite
                GradientColorStop = 14277081
                ImageStyle = isStretch
                ShowGradient = True
                ShowImage = False
                ShowTexture = False
              end
              object RzLabel5: TRzLabel
                Left = 0
                Top = 0
                Width = 102
                Height = 26
                Align = alClient
                Alignment = taCenter
                Caption = #32479#35745#31867#22411
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                ShadowColor = 16250871
                ShadowDepth = 1
                TextStyle = tsShadow
              end
            end
            object edtChar1Type: TcxRadioButton
              Left = 119
              Top = 8
              Width = 70
              Height = 17
              Caption = #25353#26102#38388
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = edtChar1TypeClick
            end
            object edtChar2Type: TcxRadioButton
              Left = 199
              Top = 8
              Width = 86
              Height = 17
              Caption = #25353#26143#26399
              TabOrder = 2
              OnClick = edtChar2TypeClick
            end
          end
          object RzPanel26: TRzPanel
            Left = 776
            Top = 11
            Width = 193
            Height = 31
            Anchors = [akTop, akRight]
            BorderOuter = fsStatus
            BorderWidth = 1
            Color = clWhite
            FlatColor = 9145227
            TabOrder = 1
            object RzPanel27: TRzPanel
              Left = 2
              Top = 2
              Width = 79
              Height = 27
              Align = alLeft
              BorderOuter = fsFlat
              BorderSides = [sdRight, sdBottom]
              FlatColor = clGray
              TabOrder = 0
              object RzBackground4: TRzBackground
                Left = 0
                Top = 0
                Width = 78
                Height = 26
                Active = True
                Align = alClient
                FrameColor = 9145227
                GradientColorStart = clWhite
                GradientColorStop = 14277081
                ImageStyle = isStretch
                ShowGradient = True
                ShowImage = False
                ShowTexture = False
              end
              object RzLabel6: TRzLabel
                Left = 0
                Top = 0
                Width = 78
                Height = 26
                Align = alClient
                Alignment = taCenter
                Caption = #25968#25454#28304
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                ShadowColor = 16250871
                ShadowDepth = 1
                TextStyle = tsShadow
              end
            end
            object edtDataSource: TcxComboBox
              Left = 88
              Top = 5
              Width = 91
              Height = 23
              Properties.DropDownAutoWidth = False
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                #38144#21806#37327
                #38144#21806#39069)
              Properties.OnChange = edtDataSourcePropertiesChange
              Style.Edges = []
              Style.HotTrack = False
              Style.ButtonTransparency = ebtInactive
              TabOrder = 1
            end
          end
        end
      end
    end
    inherited RzPanel11: TRzPanel
      Width = 979
      inherited RzPanel13: TRzPanel
        Width = 979
        inherited btnNav: TRzBitBtn
          Left = 1249
        end
        inherited RzBmpButton4: TRzBmpButton
          Left = 889
          Top = 18
          OnClick = RzBmpButton4Click
        end
        object barcode: TRzPanel
          Left = 180
          Top = 19
          Width = 281
          Height = 29
          Anchors = [akLeft, akTop, akRight]
          BorderOuter = fsNone
          TabOrder = 2
          DesignSize = (
            281
            29)
          object barcode_input_left: TImage
            Left = 0
            Top = 0
            Width = 6
            Height = 29
            Align = alLeft
            AutoSize = True
            Picture.Data = {
              07544269746D61707A020000424D7A0200000000000036000000280000000600
              00001D000000010018000000000044020000C30E0000C30E0000000000000000
              0000EBEBEBEBEBEBEBEBEBE6E6E6F5F5F5FCFCFC0000EBEBEBEBEBEBE1E1E1E9
              E9E9F4F4F4FBFBFB0000EBEBEBCBCBCBE0E0E0FAFAFAFFFFFFFFFFFF0000CBCB
              CBCACACAF4F4F4FFFFFFFFFFFFFFFFFF0000ABABABD9D9D9FCFCFCFFFFFFFFFF
              FFFFFFFF0000A1A1A1DDDDDDFEFEFEFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
              FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
              00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
              FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
              9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
              FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
              FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
              00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
              FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
              9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
              FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009D9D9DDDDDDD
              FEFEFEFFFFFFFFFFFFFFFFFF00009B9B9BD9D9D9FCFCFCFFFFFFFFFFFFFFFFFF
              0000979797C9C9C9F4F4F4FFFFFFFFFFFFFFFFFF00009B9B9BADADADE0E0E0FA
              FAFAFFFFFFFFFFFF0000EBEBEB929292B9B9B9DFDFDFF3F3F3FBFBFB0000EBEB
              EBEBEBEB919191ACACACC6C6C6D6D6D60000EBEBEBEBEBEBEBEBEBA2A2A29999
              999999990000}
          end
          object barcode_input_right: TImage
            Left = 276
            Top = 0
            Width = 5
            Height = 29
            Align = alRight
            AutoSize = True
            Picture.Data = {
              07544269746D617006020000424D060200000000000036000000280000000500
              00001D0000000100180000000000D0010000120B0000120B0000000000000000
              0000FCFCFCF5F5F5EBEBEBEBEBEBEBEBEB00FCFCFCFCFCFCFFFFFFEBEBEBEBEB
              EB00FFFFFFFFFFFFFDFDFDFFFFFFEBEBEB00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
              F700FFFFFFFFFFFFFFFFFFFDFDFDFDFDFD00FFFFFFFFFFFFFFFFFFFEFEFEFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFEFEFEFFFFFF00FFFFFFFFFFFFFFFFFFFCFCFCFDFD
              FD00FFFFFFFFFFFFFFFFFFF5F5F5F7F7F700FFFFFFFFFFFFFAFAFAE7E7E7E6E6
              E600FBFBFBF3F3F3DFDFDFE2E2E2EBEBEB00D6D6D6C6C6C6CBCBCBEBEBEBEBEB
              EB00AEAEAECBCBCBEBEBEBEBEBEBEBEBEB00}
          end
          object barcode_input_line: TImage
            Left = 6
            Top = 0
            Width = 270
            Height = 29
            Hint = #25195#30721#38144#21806#35831#25353' pause '#20581
            Align = alClient
            AutoSize = True
            Picture.Data = {
              07544269746D61707A020000424D7A0200000000000036000000280000000600
              00001D0000000100180000000000440200000000000000000000000000000000
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000DEDE
              DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE00009E9E9E9E9E9E9E9E9E9E9E9E9E9E
              9E9E9E9E0000}
            Stretch = True
          end
          object edtReportType: TcxComboBox
            Left = 10
            Top = 4
            Width = 71
            Height = 23
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              #25353#23458#25143
              #25353#21830#21697)
            Properties.OnChange = edtReportTypePropertiesChange
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 0
            Text = #25353#23458#25143
          end
          object edtCLIENT_ID: TzrComboBoxList
            Left = 86
            Top = 4
            Width = 183
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = False
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 1
            Text = #20840#37096#23458#25143
            InGrid = False
            KeyValue = Null
            FilterFields = 'CLIENT_NAME;CLIENT_SPELL;CLIENT_CODE;LICENSE_CODE;TELEPHONE2'
            KeyField = 'CLIENT_ID'
            ListField = 'CLIENT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'CLIENT_CODE'
                Footers = <>
                Title.Caption = #23458#25143#21495
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_NAME'
                Footers = <>
                Title.Caption = #23458#25143#21517#31216
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
            DropWidth = 314
            DropHeight = 281
            ShowTitle = True
            AutoFitColWidth = False
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnClearValue = edtCLIENT_IDClearValue
            MultiSelect = False
          end
          object edtGODS_ID: TzrComboBoxList
            Left = 87
            Top = 4
            Width = 189
            Height = 23
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = False
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonStyle = btsUltraFlat
            Style.ButtonTransparency = ebtInactive
            TabOrder = 2
            Text = #25152#26377#21830#21697
            Visible = False
            InGrid = True
            KeyValue = Null
            FilterFields = 'GODS_CODE;GODS_NAME;GODS_SPELL;BARCODE'
            KeyField = 'GODS_ID'
            ListField = 'GODS_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'GODS_NAME'
                Footers = <>
                Title.Caption = #21830#21697#21517#31216
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                Title.Caption = #36135#21495
                Width = 50
              end
              item
                EditButtons = <>
                FieldName = 'BARCODE'
                Footers = <>
                Title.Caption = #26465#30721
                Width = 65
              end>
            DropWidth = 380
            DropHeight = 250
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnClearValue = edtGODS_IDClearValue
            MultiSelect = False
          end
          object RzPanel16: TRzPanel
            Left = 83
            Top = 1
            Width = 3
            Height = 28
            BorderOuter = fsGroove
            BorderSides = [sdLeft, sdRight]
            TabOrder = 3
          end
        end
        object RzPanel14: TRzPanel
          Left = 475
          Top = 18
          Width = 387
          Height = 31
          Anchors = [akTop, akRight]
          BorderOuter = fsStatus
          BorderWidth = 1
          Color = clWhite
          FlatColor = 9145227
          TabOrder = 3
          object RzPanel15: TRzPanel
            Left = 2
            Top = 2
            Width = 63
            Height = 27
            Align = alLeft
            BorderOuter = fsFlat
            BorderSides = [sdRight, sdBottom]
            FlatColor = clGray
            TabOrder = 0
            object RzBackground7: TRzBackground
              Left = 0
              Top = 0
              Width = 62
              Height = 26
              Active = True
              Align = alClient
              FrameColor = 9145227
              GradientColorStart = clWhite
              GradientColorStop = 14277081
              ImageStyle = isStretch
              ShowGradient = True
              ShowImage = False
              ShowTexture = False
            end
            object RzLabel17: TRzLabel
              Left = 0
              Top = 0
              Width = 62
              Height = 26
              Align = alClient
              Alignment = taCenter
              Caption = #26085#26399
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              ShadowColor = 16250871
              ShadowDepth = 1
              TextStyle = tsShadow
            end
          end
          object dateFlag: TcxComboBox
            Tag = -1
            Left = 64
            Top = 4
            Width = 55
            Height = 23
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              #20170#26085
              #26412#26376
              #26412#24180
              #33258#23450#20041)
            Properties.OnChange = dateFlagPropertiesChange
            Style.BorderColor = clWindowFrame
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 1
          end
          object D1: TcxDateEdit
            Tag = -1
            Left = 121
            Top = 4
            Width = 120
            Height = 23
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 2
          end
          object RzPanel23: TRzPanel
            Left = 119
            Top = 1
            Width = 3
            Height = 28
            BorderOuter = fsGroove
            BorderSides = [sdLeft, sdRight]
            TabOrder = 3
          end
          object RzPanel22: TRzPanel
            Left = 241
            Top = 2
            Width = 26
            Height = 27
            BorderOuter = fsGroove
            BorderSides = [sdLeft, sdRight]
            TabOrder = 4
            object RzBackground8: TRzBackground
              Left = 2
              Top = 0
              Width = 22
              Height = 27
              Active = True
              Align = alClient
              FrameColor = 9145227
              GradientColorStart = clWhite
              GradientColorStop = 14277081
              ImageStyle = isStretch
              ShowGradient = True
              ShowImage = False
              ShowTexture = False
            end
            object RzLabel16: TRzLabel
              Left = 2
              Top = 0
              Width = 22
              Height = 27
              Align = alClient
              Alignment = taCenter
              Caption = #33267
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              ShadowColor = 16250871
              ShadowDepth = 1
              TextStyle = tsShadow
            end
          end
          object D2: TcxDateEdit
            Tag = -1
            Left = 266
            Top = 5
            Width = 119
            Height = 23
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 5
          end
        end
        object RzPanel1: TRzPanel
          Left = 12
          Top = 19
          Width = 157
          Height = 29
          BorderOuter = fsNone
          TabOrder = 4
          object Image1: TImage
            Left = 0
            Top = 0
            Width = 6
            Height = 29
            Align = alLeft
            AutoSize = True
            Picture.Data = {
              07544269746D61707A020000424D7A0200000000000036000000280000000600
              00001D000000010018000000000044020000C30E0000C30E0000000000000000
              0000EBEBEBEBEBEBEBEBEBE6E6E6F5F5F5FCFCFC0000EBEBEBEBEBEBE1E1E1E9
              E9E9F4F4F4FBFBFB0000EBEBEBCBCBCBE0E0E0FAFAFAFFFFFFFFFFFF0000CBCB
              CBCACACAF4F4F4FFFFFFFFFFFFFFFFFF0000ABABABD9D9D9FCFCFCFFFFFFFFFF
              FFFFFFFF0000A1A1A1DDDDDDFEFEFEFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
              FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
              00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
              FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
              9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
              FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
              FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
              00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
              FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
              9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
              FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009D9D9DDDDDDD
              FEFEFEFFFFFFFFFFFFFFFFFF00009B9B9BD9D9D9FCFCFCFFFFFFFFFFFFFFFFFF
              0000979797C9C9C9F4F4F4FFFFFFFFFFFFFFFFFF00009B9B9BADADADE0E0E0FA
              FAFAFFFFFFFFFFFF0000EBEBEB929292B9B9B9DFDFDFF3F3F3FBFBFB0000EBEB
              EBEBEBEB919191ACACACC6C6C6D6D6D60000EBEBEBEBEBEBEBEBEBA2A2A29999
              999999990000}
          end
          object Image2: TImage
            Left = 152
            Top = 0
            Width = 5
            Height = 29
            Align = alRight
            AutoSize = True
            Picture.Data = {
              07544269746D617006020000424D060200000000000036000000280000000500
              00001D0000000100180000000000D0010000120B0000120B0000000000000000
              0000FCFCFCF5F5F5EBEBEBEBEBEBEBEBEB00FCFCFCFCFCFCFFFFFFEBEBEBEBEB
              EB00FFFFFFFFFFFFFDFDFDFFFFFFEBEBEB00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
              F700FFFFFFFFFFFFFFFFFFFDFDFDFDFDFD00FFFFFFFFFFFFFFFFFFFEFEFEFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFEFEFEFFFFFF00FFFFFFFFFFFFFFFFFFFCFCFCFDFD
              FD00FFFFFFFFFFFFFFFFFFF5F5F5F7F7F700FFFFFFFFFFFFFAFAFAE7E7E7E6E6
              E600FBFBFBF3F3F3DFDFDFE2E2E2EBEBEB00D6D6D6C6C6C6CBCBCBEBEBEBEBEB
              EB00AEAEAECBCBCBEBEBEBEBEBEBEBEBEB00}
          end
          object Image3: TImage
            Left = 6
            Top = 0
            Width = 146
            Height = 29
            Hint = #25195#30721#38144#21806#35831#25353' pause '#20581
            Align = alClient
            AutoSize = True
            Picture.Data = {
              07544269746D61707A020000424D7A0200000000000036000000280000000600
              00001D0000000100180000000000440200000000000000000000000000000000
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000DEDE
              DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE00009E9E9E9E9E9E9E9E9E9E9E9E9E9E
              9E9E9E9E0000}
            Stretch = True
          end
          object sortDrop: TcxButtonEdit
            Tag = -1
            Left = 6
            Top = 4
            Width = 146
            Height = 23
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            Properties.OnButtonClick = sortDropPropertiesButtonClick
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonStyle = btsUltraFlat
            Style.ButtonTransparency = ebtInactive
            TabOrder = 0
            Text = #20840#37096#20998#31867
            OnExit = sortDropExit
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 979
    inherited lblCaption: TRzLabel
      Width = 624
      Caption = #32463#33829#20998#26512#25253#34920
    end
    inherited RzPanel12: TRzPanel
      Left = 624
      Width = 355
      inherited RzBmpButton2: TRzBmpButton [0]
        Left = 253
        Visible = False
      end
      inherited RzBmpButton1: TRzBmpButton [1]
        Left = 176
      end
      inherited RzBmpButton3: TRzBmpButton [2]
        Left = 253
      end
    end
  end
  inherited SaveDialog1: TSaveDialog
    Left = 578
    Top = 135
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    Left = 549
    Top = 135
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323020255B7768725D5C66315C6673
      3136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C71725C66305C667332305C2762345C2766325C2764335C2761315C2763
      615C2762315C2762635C2765345C6C616E67323035325C66315C66733136200D
      0A5C706172207D0D0A00}
  end
  object cdsReport1: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 462
    Top = 135
  end
  object dsReport1: TDataSource
    DataSet = cdsReport1
    Left = 491
    Top = 135
  end
  object PrintDialog1: TPrintDialog
    Left = 520
    Top = 135
  end
end
