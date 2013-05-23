inherited frmAnlyReport: TfrmAnlyReport
  Left = 193
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
      OnChange = PageControlChange
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
                Title.Text.Strings = (
                  #26102#27573#20998#26512#34920)
                View3D = False
                Align = alClient
                BevelOuter = bvNone
                Color = clWhite
                TabOrder = 2
                object BarSeries1: TBarSeries
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
            end
            object edtChar2Type: TcxRadioButton
              Left = 199
              Top = 8
              Width = 86
              Height = 17
              Caption = #25353#26143#26399
              TabOrder = 2
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
          Left = 813
          Top = 18
          OnClick = RzBmpButton4Click
        end
        object barcode: TRzPanel
          Left = 12
          Top = 19
          Width = 381
          Height = 29
          Anchors = [akLeft, akTop, akRight]
          BorderOuter = fsNone
          TabOrder = 2
          DesignSize = (
            381
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
            Left = 376
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
            Width = 370
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
            Width = 283
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
            Width = 289
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
          Left = 411
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
        object list: TRzBmpButton
          Left = 931
          Top = 21
          Width = 28
          Height = 25
          GroupIndex = 1
          Down = True
          Bitmaps.Down.Data = {
            6A080000424D6A0800000000000036000000280000001C000000190000000100
            1800000000003408000000000000000000000000000000000000B4A196A58E81
            A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81AD998DD3C7C1EBEBEBA58E81DBD6CFDBD6CFDBD6CFDBD6CFDBD6CF
            DBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6
            CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFD6CFC8B4A297D4
            C8C2A58E81D9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CD
            D9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5
            CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD3CDC5AF9A8EA58E81D7D3CAD7D3CAD7
            D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CA
            D7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3
            CAD7D3CAD7D3CAA58E81A58E81D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5
            D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8
            D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8A58E81A58E
            81D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3
            CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5
            D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5A58E81A58E81D0CBC2D0CBC2D0CBC2D0CB
            C2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0
            CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2
            D0CBC2A58E81A58E81CDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8
            BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECD
            C8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BEA58E81A58E81CBC5BB
            CBC5BBCBC5BBCBC5BBCBC5BBCBC5BBCBC5BBCBC5BB7B665B7B665BCBC5BB7B66
            5B7B665B7B665B7B665B7B665B7B665B7B665B7B665BCBC5BBCBC5BBCBC5BBCB
            C5BBCBC5BBCBC5BBCBC5BBA58E81A58E81C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7
            C8C2B7C8C2B7C8C2B77B665B7B665BC8C2B77B665B7B665B7B665B7B665B7B66
            5B7B665B7B665B7B665BC8C2B7C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7A5
            8E81A58E81C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4
            C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BE
            B4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4A58E81A58E81C2BBB0C2BBB0C2
            BBB0C2BBB0C2BBB0C2BBB0C2BBB0C2BBB07B665B7B665BC2BBB07B665B7B665B
            7B665B7B665B7B665B7B665B7B665B7B665BC2BBB0C2BBB0C2BBB0C2BBB0C2BB
            B0C2BBB0C2BBB0A58E81A58E81BFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBF
            B8ACBFB8AC7B665B7B665BBFB8AC7B665B7B665B7B665B7B665B7B665B7B665B
            7B665B7B665BBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACA58E81A58E
            81BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BC
            B4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9
            BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9A58E81A58E81B9B1A5B9B1A5B9B1A5B9B1
            A5B9B1A5B9B1A5B9B1A5B9B1A57B665B7B665BB9B1A57B665B7B665B7B665B7B
            665B7B665B7B665B7B665B7B665BB9B1A5B9B1A5B9B1A5B9B1A5B9B1A5B9B1A5
            B9B1A5A58E81A58E81B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AE
            A17B665B7B665BB6AEA17B665B7B665B7B665B7B665B7B665B7B665B7B665B7B
            665BB6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1A58E81A58E81B3AB9E
            B3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB
            9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3
            AB9EB3AB9EB3AB9EB3AB9EA58E81A58E81B1A89BB1A89BB1A89BB1A89BB1A89B
            B1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A8
            9BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BA5
            8E81A58E81AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598
            AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA5
            98AEA598AEA598AEA598AEA598AEA598AEA598A58E81A58E81ACA395ACA395AC
            A395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395
            ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA3
            95ACA395ACA395A58E81A58E81AAA092AAA092AAA092AAA092AAA092AAA092AA
            A092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092
            AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092A58E81A58E
            81A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A8
            9E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90
            A89E90A89E90A89E90A89E90A89E90A58E81A58E81A69C8EA69C8EA69C8EA69C
            8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA6
            9C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8E
            A69B8DAD998DA58E81A59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B
            8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA5
            9B8CA59B8CA59B8CA59B8CA59B8CA59B8CA5988AA59184D3C7C1B4A196A58E81
            A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81B8A69CDDD4D0EBEBEB}
          Bitmaps.TransparentColor = clFuchsia
          Bitmaps.Up.Data = {
            6A080000424D6A0800000000000036000000280000001C000000190000000100
            1800000000003408000000000000000000000000000000000000CAAA95A58E81
            A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81AD998DD3C7C1EBEBEBA58E81FCF8F3F9F3EAF9F3EAF9F3EAF9F3EA
            F9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3
            EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EBF3EDE6BEACA2D4
            C8C2A58E81F9F3EBF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDF
            F5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5EC
            DFF5ECDFF5ECDFF5ECDFF5ECDFF6EEE2F2ECE5AF9A8EA58E81F9F4ECF5EDE0F5
            EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0
            F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5ED
            E0F5EDE0F9F4ECA58E81A58E81F9F4EDF6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6
            EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2
            F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F9F4EDA58E81A58E
            81F9F4EDF6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6
            EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3
            F6EEE3F6EEE3F6EEE3F6EEE3F9F4EDA58E81A58E81F9F5EEF6EFE4F6EFE4F6EF
            E4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6
            EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4
            F9F5EEA58E81A58E81FAF6EFF7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0
            E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7
            F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6FAF6EFA58E81A58E81FAF6F0
            F7F1E7F7F1E7F7F1E7F7F1E7F7F1E7F7F1E7F7F1E7A58E81A58E81F7F1E7A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81F7F1E7F7F1E7F7F1E7F7
            F1E7F7F1E7F7F1E7FAF6F0A58E81A58E81FBF7F1F8F2E9F8F2E9F8F2E9F8F2E9
            F8F2E9F8F2E9F8F2E9A58E81A58E81F8F2E9A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81F8F2E9F8F2E9F8F2E9F8F2E9F8F2E9F8F2E9FBF7F1A5
            8E81A58E81FBF7F2F8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EB
            F8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3
            EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBFBF7F2A58E81A58E81FBF8F3F9F4ECF9
            F4ECF9F4ECF9F4ECF9F4ECF9F4ECF9F4ECA58E81A58E81F9F4ECA58E81A58E81
            A58E81A58E81A58E81A58E81A58E81A58E81F9F4ECF9F4ECF9F4ECF9F4ECF9F4
            ECF9F4ECFBF8F3A58E81A58E81FBF9F4F9F5EEF9F5EEF9F5EEF9F5EEF9F5EEF9
            F5EEF9F5EEA58E81A58E81F9F5EEA58E81A58E81A58E81A58E81A58E81A58E81
            A58E81A58E81F9F5EEF9F5EEF9F5EEF9F5EEF9F5EEF9F5EEFBF9F4A58E81A58E
            81FCF9F6FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FA
            F5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0
            FAF5F0FAF5F0FAF5F0FAF5F0FCF9F6A58E81A58E81FCF9F7FAF6F2FAF6F2FAF6
            F2FAF6F2FAF6F2FAF6F2FAF6F2A58E81A58E81FAF6F2A58E81A58E81A58E81A5
            8E81A58E81A58E81A58E81A58E81FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2
            FCF9F7A58E81A58E81FCFAF7FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FBF7
            F3A58E81A58E81FBF7F3A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FCFAF7A58E81A58E81FCFBF9
            FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8
            F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FB
            F8F5FBF8F5FBF8F5FCFBF9A58E81A58E81FDFBF9FCF9F6FCF9F6FCF9F6FCF9F6
            FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9
            F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FDFBF9A5
            8E81A58E81FDFCFBFCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8
            FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFA
            F8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FDFCFBA58E81A58E81FEFCFBFDFBF9FD
            FBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9
            FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFB
            F9FDFBF9FEFCFBA58E81A58E81FEFCFCFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFD
            FBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFA
            FDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFEFCFCA58E81A58E
            81FEFDFCFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFD
            FCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFB
            FDFCFBFDFCFBFDFCFBFDFCFBFEFDFDA58E81A58E81FEFDFDFEFCFCFEFCFCFEFC
            FCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFE
            FCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFC
            F7F3F2AD998DA58E81FFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEECE6E4BBAAA0D3C7C1CAAA95A58E81
            A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81B8A69CDDD4D0EBEBEB}
          Color = clBtnFace
          Anchors = [akTop, akRight]
          TabOrder = 4
          Visible = False
        end
        object chart: TRzBmpButton
          Left = 904
          Top = 21
          Width = 28
          Height = 25
          GroupIndex = 1
          Bitmaps.Down.Data = {
            6A080000424D6A0800000000000036000000280000001C000000190000000100
            1800000000003408000000000000000000000000000000000000EBEBEBD3C7C1
            AD998DA58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81A58E81A58E81CAAA95D4C8C2B4A297D6CFC8DBD6CFDBD6CFDBD6CF
            DBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6
            CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFDBD6CFA5
            8E81AF9A8ED3CDC5D9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CD
            D9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5
            CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDD9D5CDA58E81A58E81D7D3CAD7D3CAD7
            D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CA
            D7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3CAD7D3
            CAD7D3CAD7D3CAA58E81A58E81D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5
            D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8
            D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8D5D0C8A58E81A58E
            81D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3
            CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5
            D3CEC5D3CEC5D3CEC5D3CEC5D3CEC5A58E81A58E81D0CBC2D0CBC2D0CBC2D0CB
            C2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0
            CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2D0CBC2
            D0CBC2A58E81A58E81CDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8
            BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECD
            C8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BECDC8BEA58E81A58E81CBC5BB
            CBC5BBCBC5BBCBC5BBCBC5BBCBC5BBCBC5BBA58E81A58E81A58E81CBC5BBA58E
            81A58E81A58E81CBC5BBA58E81A58E81A58E81CBC5BBCBC5BBCBC5BBCBC5BBCB
            C5BBCBC5BBCBC5BBCBC5BBA58E81A58E81C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7
            C8C2B7C8C2B7A58E81A58E81A58E81C8C2B7A58E81A58E81A58E81C8C2B7A58E
            81A58E81A58E81C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7C8C2B7A5
            8E81A58E81C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4A58E81A58E81
            A58E81C5BEB4A58E81A58E81A58E81C5BEB4A58E81A58E81A58E81C5BEB4C5BE
            B4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4C5BEB4A58E81A58E81C2BBB0C2BBB0C2
            BBB0C2BBB0C2BBB0C2BBB0C2BBB0A58E81A58E81A58E81C2BBB0A58E81A58E81
            A58E81C2BBB0A58E81A58E81A58E81C2BBB0C2BBB0C2BBB0C2BBB0C2BBB0C2BB
            B0C2BBB0C2BBB0A58E81A58E81BFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBF
            B8ACA58E81A58E81A58E81BFB8ACA58E81A58E81A58E81BFB8ACA58E81A58E81
            A58E81BFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACBFB8ACA58E81A58E
            81BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9A58E81A58E81A58E81BC
            B4A9A58E81A58E81A58E81BCB4A97B665B7B665B7B665BBCB4A9BCB4A9BCB4A9
            BCB4A9BCB4A9BCB4A9BCB4A9BCB4A9A58E81A58E81B9B1A5B9B1A5B9B1A5B9B1
            A5B9B1A5B9B1A5B9B1A57B665B7B665B7B665BB9B1A5A58E81A58E81A58E81B9
            B1A5B9B1A5B9B1A5B9B1A5B9B1A5B9B1A5B9B1A5B9B1A5B9B1A5B9B1A5B9B1A5
            B9B1A5A58E81A58E81B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AE
            A1B6AEA1B6AEA1B6AEA1A58E81A58E81A58E81B6AEA1B6AEA1B6AEA1B6AEA1B6
            AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1B6AEA1A58E81A58E81B3AB9E
            B3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9E7B66
            5B7B665B7B665BB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3AB9EB3
            AB9EB3AB9EB3AB9EB3AB9EA58E81A58E81B1A89BB1A89BB1A89BB1A89BB1A89B
            B1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A8
            9BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BB1A89BA5
            8E81A58E81AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598
            AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA598AEA5
            98AEA598AEA598AEA598AEA598AEA598AEA598A58E81A58E81ACA395ACA395AC
            A395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395
            ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA395ACA3
            95ACA395ACA395A58E81A58E81AAA092AAA092AAA092AAA092AAA092AAA092AA
            A092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092
            AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092AAA092A58E81A58E
            81A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A8
            9E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90A89E90
            A89E90A89E90A89E90A89E90A89E90A58E81AD998DA69B8DA69C8EA69C8EA69C
            8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA6
            9C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8EA69C8E
            A69C8EA58E81D3C7C1A59184A5988AA59B8CA59B8CA59B8CA59B8CA59B8CA59B
            8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA5
            9B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA59B8CA58E81EBEBEBDDD4D0
            B8A69CA58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81A58E81A58E81CAAA95}
          Bitmaps.TransparentColor = clFuchsia
          Bitmaps.Up.Data = {
            6A080000424D6A0800000000000036000000280000001C000000190000000100
            1800000000003408000000000000000000000000000000000000EBEBEBD3C7C1
            AD998DA58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81A58E81A58E81B4A196D4C8C2BEACA2F3EDE6F9F3EBF9F3EAF9F3EA
            F9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3
            EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAFCF8F3A5
            8E81AF9A8EF2ECE5F6EEE2F5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDF
            F5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF5EC
            DFF5ECDFF5ECDFF5ECDFF5ECDFF5ECDFF9F3EBA58E81A58E81F9F4ECF5EDE0F5
            EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0
            F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5EDE0F5ED
            E0F5EDE0F9F4ECA58E81A58E81F9F4EDF6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6
            EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2
            F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F9F4EDA58E81A58E
            81F9F4EDF6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6
            EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3F6EEE3
            F6EEE3F6EEE3F6EEE3F6EEE3F9F4EDA58E81A58E81F9F5EEF6EFE4F6EFE4F6EF
            E4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6
            EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4F6EFE4
            F9F5EEA58E81A58E81FAF6EFF7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0
            E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7
            F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6F7F0E6FAF6EFA58E81A58E81FAF6F0
            F7F1E7F7F1E7F7F1E7F7F1E7F7F1E7F7F1E7A58E81A58E81A58E81F7F1E7A58E
            81A58E81A58E81F7F1E7A58E81A58E81A58E81F7F1E7F7F1E7F7F1E7F7F1E7F7
            F1E7F7F1E7F7F1E7FAF6F0A58E81A58E81FBF7F1F8F2E9F8F2E9F8F2E9F8F2E9
            F8F2E9F8F2E9A58E81A58E81A58E81F8F2E9A58E81A58E81A58E81F8F2E9A58E
            81A58E81A58E81F8F2E9F8F2E9F8F2E9F8F2E9F8F2E9F8F2E9F8F2E9FBF7F1A5
            8E81A58E81FBF7F2F8F3EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBA58E81A58E81
            A58E81F8F3EBA58E81A58E81A58E81F8F3EBA58E81A58E81A58E81F8F3EBF8F3
            EBF8F3EBF8F3EBF8F3EBF8F3EBF8F3EBFBF7F2A58E81A58E81FBF8F3F9F4ECF9
            F4ECF9F4ECF9F4ECF9F4ECF9F4ECA58E81A58E81A58E81F9F4ECA58E81A58E81
            A58E81F9F4ECA58E81A58E81A58E81F9F4ECF9F4ECF9F4ECF9F4ECF9F4ECF9F4
            ECF9F4ECFBF8F3A58E81A58E81FBF9F4F9F5EEF9F5EEF9F5EEF9F5EEF9F5EEF9
            F5EEA58E81A58E81A58E81F9F5EEA58E81A58E81A58E81F9F5EEA58E81A58E81
            A58E81F9F5EEF9F5EEF9F5EEF9F5EEF9F5EEF9F5EEF9F5EEFBF9F4A58E81A58E
            81FCF9F6FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0FAF5F0A58E81A58E81A58E81FA
            F5F0A58E81A58E81A58E81FAF5F0A58E81A58E81A58E81FAF5F0FAF5F0FAF5F0
            FAF5F0FAF5F0FAF5F0FAF5F0FCF9F6A58E81A58E81FCF9F7FAF6F2FAF6F2FAF6
            F2FAF6F2FAF6F2FAF6F2A58E81A58E81A58E81FAF6F2A58E81A58E81A58E81FA
            F6F2FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2FAF6F2
            FCF9F7A58E81A58E81FCFAF7FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FBF7
            F3FBF7F3FBF7F3FBF7F3A58E81A58E81A58E81FBF7F3FBF7F3FBF7F3FBF7F3FB
            F7F3FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FBF7F3FCFAF7A58E81A58E81FCFBF9
            FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5A58E
            81A58E81A58E81FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FBF8F5FB
            F8F5FBF8F5FBF8F5FCFBF9A58E81A58E81FDFBF9FCF9F6FCF9F6FCF9F6FCF9F6
            FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9
            F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FCF9F6FDFBF9A5
            8E81A58E81FDFCFBFCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8
            FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FCFA
            F8FCFAF8FCFAF8FCFAF8FCFAF8FCFAF8FDFCFBA58E81A58E81FEFCFBFDFBF9FD
            FBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9
            FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFBF9FDFB
            F9FDFBF9FEFCFBA58E81A58E81FEFCFCFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFD
            FBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFA
            FDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFDFBFAFEFCFCA58E81A58E
            81FEFDFDFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFD
            FCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFBFDFCFB
            FDFCFBFDFCFBFDFCFBFDFCFBFEFDFCA58E81AD998DF7F3F2FEFCFCFEFCFCFEFC
            FCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFE
            FCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFCFEFCFC
            FEFDFDA58E81D3C7C1BBAAA0ECE6E4FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFEFEA58E81EBEBEBDDD4D0
            B8A69CA58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E
            81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A58E81A5
            8E81A58E81A58E81A58E81B4A196}
          Color = clBtnFace
          Anchors = [akTop, akRight]
          TabOrder = 5
          Visible = False
          OnClick = chartClick
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
      inherited RzBmpButton1: TRzBmpButton
        Left = 96
      end
      inherited RzBmpButton3: TRzBmpButton
        Left = 173
      end
      inherited RzBmpButton2: TRzBmpButton
        Left = 253
      end
      object btnPrior: TRzBmpButton
        Left = 16
        Top = 9
        Width = 72
        Height = 31
        Bitmaps.TransparentColor = clFuchsia
        Bitmaps.Up.Data = {
          5E1A0000424D5E1A0000000000003600000028000000480000001F0000000100
          180000000000281A000000000000000000000000000000000000B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B6B6B6B3B3B3ACAC
          ACA5A5A5A1A1A19F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A2A2A2A8A8A8B0B0
          B0B6B6B6B7B7B7B7B7B7B7B7B7B6B6B6B0B0B0A0A0A08B8B8B7B7B7B74747471
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          71717171717171717171717171727272767676828282959595A9A9A9B4B4B4B7
          B7B7B7B7B7B1B1B19C9C9CAAAAAAC3C3C3DADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADACECECEB4B4B48080807171718C8C8CA9A9A9B6B6B6B6B6B6ACACAC
          CCCCCCDADADADADADADBDBDBDADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADA989898717171959595B0B0B0B1B1B1D4D4D4DCDCDCDADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD8D8
          D87E7E7E808080A7A7A7BCBCBCE7E7E7DBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADABBBBBB757575A1
          A1A1C9C9C9E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAD4D4D4717171A0A0A0CBCBCBE7E7E7
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA737373A1A1A1CDCDCDE8E8E8DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DAD9D9D9797979A4A4A4CACACAECECECDBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADACBCBCB8A8A8AAC
          ACACBBBBBBEEEEEEE3E3E3DADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAAEAEAE9F9F9FB3B3B3B7B7B7CDCDCD
          EEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADACECECE9E9E9EB1B1B1B6B6B6B7B7B7B7B7B7CDCDCDE9E9E9E7E7
          E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1DEDEDEC7C7C7ACAC
          ACB1B1B1B6B6B6B7B7B7B7B7B7B7B7B7B7B7B7BBBBBBC3C3C3C6C6C6C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4B8B8B8B3B3B3B6B6B6B7B7B7B7B7B7B7
          B7B7}
        Color = clBtnFace
        Caption = #36820#22238
        TabOrder = 3
        Visible = False
        OnClick = btnPriorClick
      end
    end
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
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
    Left = 214
    Top = 275
  end
  object dsReport1: TDataSource
    DataSet = cdsReport1
    Left = 254
    Top = 275
  end
  object cdsReport2: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 214
    Top = 315
  end
  object dsReport2: TDataSource
    DataSet = cdsReport2
    Left = 254
    Top = 315
  end
end
