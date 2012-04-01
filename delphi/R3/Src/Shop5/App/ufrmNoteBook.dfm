inherited frmNoteBook: TfrmNoteBook
  Left = 229
  Top = 154
  BorderStyle = bsDialog
  Caption = #25105#30340#35760#20107#26412
  ClientHeight = 453
  ClientWidth = 632
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 632
    Height = 453
    Align = alClient
    BorderOuter = fsNone
    Color = clWhite
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 0
      Top = 37
      Width = 632
      Height = 386
      Align = alClient
      BorderOuter = fsNone
      BorderSides = [sdLeft]
      BorderColor = clTeal
      Color = 16182753
      TabOrder = 0
      object RzPanel6: TRzPanel
        Left = 156
        Top = 19
        Width = 476
        Height = 367
        Align = alClient
        BevelWidth = 2
        BorderOuter = fsNone
        BorderSides = [sdLeft]
        BorderColor = clWhite
        BorderShadow = clWhite
        BorderWidth = 5
        Color = clWhite
        TabOrder = 0
        object RzPage: TRzPageControl
          Left = 5
          Top = 5
          Width = 466
          Height = 357
          ActivePage = TabContents
          Align = alClient
          FlatColor = clWhite
          ShowCardFrame = False
          TabColors.Shadow = clWhite
          TabIndex = 1
          TabOrder = 0
          TabStyle = tsDoubleSlant
          TextColors.DisabledShadow = clBtnHighlight
          UseGradients = False
          FixedDimension = 18
          object TabTittle: TRzTabSheet
            Color = clWhite
            Caption = 'TabTittle'
            PopupMenu = Pm_NoteBook
            object DBGridEh1: TDBGridEh
              Left = 0
              Top = 0
              Width = 466
              Height = 339
              Align = alClient
              AllowedOperations = []
              AutoFitColWidths = True
              BorderStyle = bsNone
              DataSource = DsNewsPaper
              FixedColor = clAqua
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgColumnResize, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              PopupMenu = Pm_NoteBook
              ReadOnly = True
              RowHeight = 23
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleLines = 1
              VertScrollBar.VisibleMode = sbNeverShowEh
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              OnCellClick = DBGridEh1CellClick
              OnDblClick = DBGridEh1DblClick
              OnDrawColumnCell = DBGridEh1DrawColumnCell
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'B'
                  Footers = <>
                  Width = 8
                end
                item
                  EditButtons = <>
                  FieldName = 'NB_TITLE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #26631#39064
                  Width = 301
                end
                item
                  EditButtons = <>
                  FieldName = 'NB_TYPE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #31867#22411
                  Width = 38
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'NB_DATE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #26085#26399
                  Width = 68
                end
                item
                  Alignment = taCenter
                  EditButtons = <>
                  FieldName = 'NB_INFO'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #35814#24773
                  Width = 47
                end
                item
                  EditButtons = <>
                  FieldName = 'A'
                  Footers = <>
                  Width = 10
                end>
            end
          end
          object TabContents: TRzTabSheet
            Color = clWhite
            Caption = 'TabContents'
            object RzPanel4: TRzPanel
              Left = 0
              Top = 0
              Width = 466
              Height = 339
              Align = alClient
              BorderOuter = fsNone
              BorderColor = clWhite
              Color = clWhite
              TabOrder = 0
              object RzPanel5: TRzPanel
                Left = 0
                Top = 0
                Width = 466
                Height = 59
                Align = alTop
                BorderOuter = fsNone
                BorderSides = [sdBottom]
                BorderColor = 16765589
                BorderWidth = 1
                Color = clWhite
                TabOrder = 2
                DesignSize = (
                  466
                  59)
                object lab_IDX_TYPE: TRzLabel
                  Left = 229
                  Top = 35
                  Width = 46
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #31867'  '#22411
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel2: TRzLabel
                  Left = 379
                  Top = 35
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
                object RzLabel3: TRzLabel
                  Left = 6
                  Top = 35
                  Width = 46
                  Height = 12
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = #20998'  '#31867
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzLabel4: TRzLabel
                  Left = 203
                  Top = 35
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
                object Label1: TLabel
                  Left = 16
                  Top = 13
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #26631'  '#39064
                end
                object RzLabel1: TRzLabel
                  Left = 379
                  Top = 12
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
                object btnReturn: TRzBmpButton
                  Left = 404
                  Top = 9
                  Width = 58
                  Height = 17
                  Cursor = crHandPoint
                  GroupIndex = 1
                  Bitmaps.TransparentColor = clOlive
                  Color = clBtnHighlight
                  Anchors = []
                  TabOrder = 3
                  OnClick = btnReturnClick
                end
                object edtNB_TYPE: TcxComboBox
                  Left = 279
                  Top = 31
                  Width = 98
                  Height = 20
                  Properties.DropDownListStyle = lsFixedList
                  Properties.OnChange = edtNB_TYPEPropertiesChange
                  TabOrder = 2
                  OnKeyPress = edtNB_TYPEKeyPress
                end
                object edtNB_GROUP: TcxComboBox
                  Left = 56
                  Top = 31
                  Width = 144
                  Height = 20
                  Properties.DropDownListStyle = lsFixedList
                  Properties.OnChange = edtNB_GROUPPropertiesChange
                  TabOrder = 1
                end
                object edtNB_TITLE: TcxTextEdit
                  Left = 56
                  Top = 8
                  Width = 321
                  Height = 20
                  Properties.OnChange = edtNB_TITLEPropertiesChange
                  Style.Color = clWindow
                  TabOrder = 0
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                end
              end
              object RzPanel11: TRzPanel
                Left = 0
                Top = 277
                Width = 466
                Height = 62
                Align = alBottom
                BorderOuter = fsNone
                BorderSides = [sdTop]
                BorderColor = 16765589
                BorderWidth = 1
                Color = clWhite
                TabOrder = 0
                object lblSTOCK_DATE: TLabel
                  Left = 320
                  Top = 41
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #26085'  '#26399
                end
                object Label2: TLabel
                  Left = 321
                  Top = 14
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #31614'  '#21517
                end
                object LblMsg: TLabel
                  Left = 3
                  Top = 5
                  Width = 132
                  Height = 12
                  Caption = #35760#24405#20869#23481#38271#24230#36229#38271'(255);'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object edtNB_DATE: TcxDateEdit
                  Left = 364
                  Top = 37
                  Width = 96
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.OnChange = edtNB_DATEPropertiesChange
                  TabOrder = 1
                end
                object edtUSER_ID: TzrComboBoxList
                  Left = 364
                  Top = 10
                  Width = 96
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  Properties.OnChange = edtUSER_IDPropertiesChange
                  TabOrder = 0
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
                  Buttons = [zbNew]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
              end
              object RzPanel12: TRzPanel
                Left = 0
                Top = 59
                Width = 466
                Height = 218
                Align = alClient
                BevelWidth = 2
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 3
                Color = clWhite
                TabOrder = 1
                object edtNB_TEXT: TRichEdit
                  Left = 3
                  Top = 3
                  Width = 460
                  Height = 212
                  Align = alClient
                  BorderStyle = bsNone
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  TabOrder = 0
                  OnChange = edtNB_TEXTChange
                  OnKeyPress = edtNB_TEXTKeyPress
                end
              end
            end
          end
        end
      end
      object RzPanel9: TRzPanel
        Left = 0
        Top = 19
        Width = 156
        Height = 367
        Align = alLeft
        BorderOuter = fsNone
        BorderSides = [sdTop, sdRight]
        BorderColor = 16765589
        BorderWidth = 1
        Color = 16182753
        PopupMenu = Pm_NB_Group
        TabOrder = 1
        object btn_Message0: TRzBmpButton
          Left = 1
          Top = 0
          Width = 155
          Height = 31
          GroupIndex = 1
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Caption = #20250#35758#32426#35201
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btn_Message0Click
        end
        object btn_Message1: TRzBmpButton
          Left = 1
          Top = 30
          Width = 155
          Height = 31
          GroupIndex = 1
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Caption = #20844#21578
          TabOrder = 1
          OnClick = btn_Message1Click
        end
        object btn_Message2: TRzBmpButton
          Left = 1
          Top = 60
          Width = 155
          Height = 31
          GroupIndex = 1
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Caption = #25919#31574
          TabOrder = 2
          OnClick = btn_Message2Click
        end
        object btn_Message3: TRzBmpButton
          Left = 1
          Top = 90
          Width = 155
          Height = 31
          GroupIndex = 1
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Caption = #24191#21578
          TabOrder = 3
          OnClick = btn_Message3Click
        end
        object btn_Message4: TRzBmpButton
          Left = 1
          Top = 120
          Width = 155
          Height = 31
          GroupIndex = 1
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Caption = #25552#37266
          TabOrder = 4
          OnClick = btn_Message4Click
        end
        object btn_Message5: TRzBmpButton
          Left = 1
          Top = 150
          Width = 155
          Height = 31
          GroupIndex = 1
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Caption = #25552#37266
          TabOrder = 5
          OnClick = btn_Message5Click
        end
      end
      object RzPanel10: TRzPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 19
        Align = alTop
        BorderOuter = fsNone
        BorderSides = []
        BorderColor = 16765589
        BorderWidth = 1
        Color = 16182753
        TabOrder = 2
        DesignSize = (
          632
          19)
        object Image2: TImage
          Left = 149
          Top = 3
          Width = 21
          Height = 23
        end
        object Image3: TImage
          Left = 170
          Top = 5
          Width = 465
          Height = 14
          Anchors = [akLeft, akTop, akRight, akBottom]
          ParentShowHint = False
          ShowHint = False
          Stretch = True
        end
      end
    end
    object RzPanel3: TRzPanel
      Left = 0
      Top = 0
      Width = 632
      Height = 37
      Align = alTop
      BevelWidth = 2
      BorderOuter = fsNone
      BorderColor = 16763780
      BorderWidth = 1
      TabOrder = 1
      object RzBackground1: TRzBackground
        Left = 1
        Top = 1
        Width = 630
        Height = 35
        Active = True
        Align = alClient
        Anchors = []
        DragMode = dmAutomatic
        FrameColor = clAppWorkSpace
        GradientColorStart = clBtnHighlight
        GradientColorStop = 16440232
        GradientSmoothFactor = 3
        ImageStyle = isCenter
        ShowGradient = True
        ShowImage = False
        ShowTexture = False
      end
      object Image1: TImage
        Left = 19
        Top = 7
        Width = 84
        Height = 30
        Picture.Data = {
          07544269746D6170BE1D0000424DBE1D00000000000036000000280000005400
          00001E0000000100180000000000881D0000120B0000120B0000000000000000
          0000EDCB93F5E8D5F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F5E8D5EFCB
          90EABF75F4E5CEF6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F4E5CEEABF75F6D49EF0CD94
          EDCB92F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1EDCB92F0CD94F6D59FF6D59FEABD72F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1EABE74F6D7A3F6D59EF6D59EE9BB6DF6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1
          F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6ED
          E1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6EDE1F6
          EDE1F6EDE1F6EDE1E9BB6DF6D6A1F6D49EF6D49EE9BB6DF6EDE2F6EDE2F6EDE2
          F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6ED
          E2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6
          EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2
          F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6ED
          E2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6
          EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2
          F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6EDE2F6ED
          E2F6EDE2E9BB6DF6D6A0F6D49FF6D49FE9BB6DF7EEE3F7EEE3F7EEE3F7EEE3F7
          EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3
          F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EE
          E3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7
          EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3
          F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EE
          E3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7
          EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3F7EEE3
          E9BB6DF6D6A1F7D6A0F7D6A0E9BB6DF7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EF
          E4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7
          EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4
          F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EF
          E4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7
          EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4
          F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EF
          E4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4F7EFE4E9BB6DF7
          D7A3F7D7A3F7D7A3E9BB6DF7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5
          F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EF
          E5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7
          EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5
          F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EF
          E5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7
          EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5
          F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5F7EFE5E9BB6DF7D8A5F7D8
          A5F7D8A5E9BB6DF8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8
          F0E6F8F0E68F5A008F5A008F5A008F5A00F8F0E6F8F0E6F8F0E6F8F0E68F5A00
          8F5A008F5A00F8F0E68F5A008F5A00F8F0E68F5A008F5A008F5A008F5A008F5A
          008F5A008F5A00F8F0E6F8F0E68F5A008F5A008F5A008F5A008F5A008F5A008F
          5A008F5A008F5A008F5A00F8F0E6F8F0E6F8F0E6F8F0E68F5A008F5A008F5A00
          8F5A00F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0
          E68F5A008F5A00F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8
          F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6F8F0E6E9BB6DF7DAA7F7DAA9F7DAA9
          E9BB6DF8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1
          E7F8F1E7F8F1E78F5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A008F
          5A008F5A008F5A008F5A008F5A008F5A008F5A00F8F1E7F8F1E7F8F1E78F5A00
          8F5A00F8F1E7F8F1E7F8F1E78F5A008F5A008F5A008F5A00F8F1E7F8F1E7F8F1
          E7F8F1E78F5A008F5A00F8F1E7F8F1E7F8F1E7F8F1E7F8F1E78F5A008F5A00F8
          F1E7F8F1E78F5A008F5A00F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E78F5A00
          8F5A00F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1
          E7F8F1E7F8F1E7F8F1E7F8F1E7F8F1E7E9BB6DF7DAABF8DCABF8DCABE9BB6DF9
          F2E9F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9
          F9F2E98F5A008F5A00F9F2E9F9F2E98F5A008F5A008F5A00F9F2E98F5A008F5A
          008F5A008F5A00F9F2E98F5A008F5A00F9F2E9F9F2E9F9F2E98F5A008F5A00F9
          F2E9F9F2E9F9F2E98F5A008F5A008F5A008F5A00F9F2E9F9F2E9F9F2E9F9F2E9
          8F5A008F5A00F9F2E9F9F2E98F5A008F5A008F5A008F5A008F5A008F5A008F5A
          008F5A008F5A00F9F2E98F5A008F5A008F5A008F5A008F5A008F5A008F5A008F
          5A008F5A008F5A008F5A008F5A00F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9F9F2E9
          F9F2E9F9F2E9F9F2E9F9F2E9E9BB6DF8DCAEF8DDB0F8DDB0E9BB6DF9F3EAF9F3
          EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EA8F5A008F5A008F
          5A008F5A00F9F3EAF9F3EAF9F3EA8F5A008F5A008F5A00F9F3EAF9F3EA8F5A00
          8F5A00F9F3EA8F5A008F5A00F9F3EAF9F3EA8F5A008F5A008F5A00F9F3EAF9F3
          EAF9F3EA8F5A008F5A008F5A008F5A00F9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9
          F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EA8F5A008F5A00F9F3EAF9F3EA8F5A00
          8F5A00F9F3EAF9F3EA8F5A008F5A008F5A00F9F3EA8F5A008F5A00F9F3EA8F5A
          008F5A008F5A00F9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9F3EAF9
          F3EAF9F3EAF9F3EAE9BB6DF8DEB1F9DFB3F9DFB3E9BB6DFAF4ECFAF4ECFAF4EC
          FAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4EC8F5A008F5A
          008F5A008F5A008F5A008F5A00FAF4EC8F5A008F5A00FAF4EC8F5A008F5A008F
          5A008F5A008F5A00FAF4EC8F5A008F5A008F5A008F5A00FAF4ECFAF4ECFAF4EC
          8F5A008F5A008F5A008F5A00FAF4ECFAF4ECFAF4EC8F5A008F5A00FAF4ECFAF4
          EC8F5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A008F
          5A00FAF4ECFAF4EC8F5A008F5A00FAF4EC8F5A008F5A008F5A008F5A00FAF4EC
          FAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4ECFAF4
          ECFAF4ECE9BB6DF9DFB3F9E0B7F9E0B7E9BB6DFBF5EEFBF5EEFBF5EEFBF5EEFB
          F5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EE8F5A008F5A00FBF5EE
          FBF5EE8F5A008F5A00FBF5EEFBF5EEFBF5EEFBF5EE8F5A008F5A00FBF5EE8F5A
          008F5A008F5A008F5A00FBF5EE8F5A008F5A00FBF5EEFBF5EEFBF5EE8F5A008F
          5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A00FBF5EEFBF5EEFBF5EE
          FBF5EEFBF5EEFBF5EE8F5A008F5A00FBF5EEFBF5EE8F5A008F5A00FBF5EEFBF5
          EEFBF5EEFBF5EE8F5A008F5A008F5A008F5A008F5A00FBF5EEFBF5EEFBF5EEFB
          F5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EEFBF5EE
          E9BB6DF9E0B7F9E2BBF9E2BBE9BB6DFBF6EFFBF6EFFBF6EFFBF6EFFBF6EFFBF6
          EFFBF5EFFBF6EFFBF6EFFBF6EF8F5A008F5A008F5A008F5A008F5A008F5A008F
          5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A00FBF6EF8F5A008F5A00
          8F5A008F5A00FBF6EF8F5A008F5A00FBF6EF8F5A008F5A008F5A008F5A00FBF6
          EFFBF6EFFBF6EFFBF6EFFBF6EF8F5A008F5A00FBF6EFFBF6EFFBF6EF8F5A008F
          5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A00FBF6EFFBF6EFFBF6EF
          FBF6EFFBF6EF8F5A008F5A008F5A008F5A00FBF6EFFBF5EFFBF6EFFBF6EFFBF6
          EFFBF6EFFBF6EFFBF6EFFBF6EFFBF6EFFBF6EFFBF6EFFBF6EFFBF6EFE9BB6DF9
          E2BBF9E4BFF9E4BFE9BB6DFCF7F1FCF6F1FCF7F1FCF6F1FCF7F1FCF6F1FCF7F1
          FCF6F1FCF6F1FCF6F1FCF6F1FCF6F18F5A008F5A00FCF6F1FCF6F18F5A008F5A
          00FCF6F1FCF6F1FCF6F1FCF6F18F5A008F5A008F5A008F5A008F5A008F5A008F
          5A008F5A008F5A008F5A00FCF7F1FCF7F1FCF7F1FCF7F1FCF7F1FCF7F1FCF7F1
          FCF7F1FCF7F1FCF7F18F5A008F5A00FCF7F1FCF7F1FCF7F18F5A008F5A00FCF7
          F18F5A008F5A00FCF7F1FCF7F18F5A008F5A00FCF7F18F5A008F5A008F5A008F
          5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A008F5A00FCF7F1FCF7F1
          FCF7F1FCF7F1FCF7F1FCF7F1FCF7F1FCF7F1FCF7F1FCF7F1E9BB6DF9E4C1FAEB
          D0FAEBD0E9BB6DFCF8F2FCF8F2FCF8F2FCF8F2FCF7F2FCF8F2FCF8F2FCF8F2FC
          F8F2FCF8F28F5A008F5A008F5A008F5A00FCF8F2FCF8F28F5A008F5A00FCF8F2
          8F5A008F5A00FCF8F2FCF8F28F5A008F5A00FCF8F2FCF8F2FCF8F28F5A008F5A
          00FCF8F2FCF8F2FCF8F2FCF8F2FCF8F28F5A008F5A00FCF8F2FCF8F2FCF8F2FC
          F8F2FCF8F28F5A008F5A00FCF8F2FCF8F28F5A008F5A008F5A008F5A008F5A00
          8F5A008F5A008F5A008F5A008F5A008F5A00FCF8F2FCF8F2FCF8F2FCF8F2FCF8
          F28F5A008F5A00FCF8F2FCF8F2FCF8F2FCF8F2FCF8F2FCF8F2FCF8F2FCF8F2FC
          F7F2FCF8F2FCF8F2FCF8F2FCF8F2FCF8F2FCF8F2E9BB6DFAEBD1FAEDD5FAEDD5
          E9BB6DFDF9F4FDF9F4FDF9F4FDF9F4FDF8F4FDF8F4FDF8F4FDF9F4FDF9F4FDF9
          F4FDF9F4FDF9F4FDF9F48F5A008F5A008F5A008F5A008F5A008F5A008F5A00FD
          F9F4FDF9F4FDF9F48F5A008F5A00FDF9F4FDF9F4FDF9F48F5A008F5A00FDF9F4
          FDF9F4FDF9F4FDF9F48F5A008F5A00FDF9F48F5A008F5A008F5A008F5A008F5A
          008F5A008F5A00FDF9F4FDF9F4FDF9F4FDF9F4FDF9F4FDF9F48F5A008F5A00FD
          F9F4FDF9F4FDF9F4FDF9F4FDF9F4FDF9F4FDF9F4FDF9F4FDF9F4FDF9F48F5A00
          8F5A00FDF9F4FDF8F4FDF8F4FDF9F4FDF9F4FDF9F4FDF9F4FDF8F4FDF9F4FDF9
          F4FDF9F4FDF8F4FDF9F4FDF9F4FDF9F4E9BB6DFAEDD5FBEED7FBEED7E9BB6DFD
          FAF5FDFAF5FDFAF5FDFAF5FDFAF4FDF9F5FDFAF5FDF9F5FDF9F5FDF9F5FDF9F5
          FDF9F5FDF9F5FDF9F5FDF9F5FDF9F5FDF9F5FDF9F5FDF9F5FDF9F5FDF9F5FDF9
          F5FDF9F5FDF9F5FDF9F5FDF9F5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FD
          FAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5
          FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFA
          F5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FD
          FAF5FDF9F5FDFAF5FDF9F5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5FDFAF5
          FDFAF5FDF9F5FDFAF5FDFAF5E9BB6DFBEFD7FBEFDAFBEFDAE9BB6DFEFBF6FEFB
          F6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FE
          FBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6
          FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFB
          F6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FE
          FBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6
          FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFBF6FEFAF6FEFB
          F6FEFBF6FEFBF6FEFBF6FEFBF6FEFAF6FEFAF6FEFBF6FEFBF6FEFBF6FEFBF6FE
          FBF6FEFBF6FEFBF6E9BB6DFBEFDAFCF0DDFCF0DDE9BB6DFEFBF7FEFBF7FEFBF7
          FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFB
          F7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FE
          FBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7
          FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFB
          F7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FE
          FBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFAF7FEFBF7FEFBF7
          FEFBF7FEFBF7FEFBF7FEFAF7FEFAF7FEFBF7FEFBF7FEFBF7FEFBF7FEFBF7FEFB
          F7FEFBF7E9BB6DFCF1DDFCF2E1FCF2E1E9BB6DFEFCF8FEFCF8FEFCF8FEFCF8FE
          FCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8
          FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFB
          F8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FE
          FBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFBF8FEFCF8
          FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFC
          F8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FE
          FBF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8FEFCF8
          E9BB6DFCF3E1FCF3E4FCF3E4E9BB6DFFFDF9FFFCF9FFFDF9FFFDF9FFFDF9FFFD
          F9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FF
          FDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFCF9FFFDF9
          FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFD
          F9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FF
          FDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9
          FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFD
          F9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9FFFDF9E9BB6DFC
          F3E4FCF5E7FCF5E7E9BB6DFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFCFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAE9BB6DFCF4E7FDF5
          E8FDF5E8E9BB6DFFFDFAFFFCFAFFFDFAFFFDFAFFFCFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFCFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFCFAFFFCFAFFFCFAFFFCFAFFFCFAE9BB6DFDF6E8FDF6EAFDF6EA
          EBC077FBF5EAFFFDFAFFFCFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFDFAF5FDFAF5FDFAF5FDFAF5FCF6EBEABF76FDF6EAFDF6EBFDF6EBF3D8ADEE
          CB92FEFCF8FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFCFAFFFDFAFEFCF9FDFAF6
          FDFAF6FDFAF6FDFAF5EECD94F3D8ACFDF6EAFDF6EBFDF6EBFDF6EBF1D4A3EDC7
          87FBF3E7FEFBF8FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFF
          FDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFA
          FFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFFFD
          FAFFFDFAFFFDFAFFFDFAFFFDFAFFFDFAFEFBF8FDF9F4FDF8F3FDF8F3FDF8F3FB
          F2E6EDC787F1D4A3FDF6EAFDF6EAFDF6EAFDF6EAFDF6EBFDF6EBF3D9AFEBC179
          E9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB
          6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9
          BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6D
          E9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB
          6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9
          BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6D
          E9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DE9BB6DEBC179F3D9
          AFFDF6EAFDF6EAFDF6EA}
      end
    end
    object RzPanel7: TRzPanel
      Left = 0
      Top = 424
      Width = 632
      Height = 29
      Align = alBottom
      BorderOuter = fsButtonUp
      BorderSides = [sdTop]
      Color = 16767656
      TabOrder = 2
      DesignSize = (
        632
        29)
      object btn_Close: TRzBmpButton
        Left = 528
        Top = 6
        Width = 69
        Height = 21
        Bitmaps.TransparentColor = clOlive
        Color = clBtnHighlight
        Anchors = [akRight, akBottom]
        TabOrder = 1
        OnClick = btn_CloseClick
      end
      object BtnNew: TRzBmpButton
        Left = 453
        Top = 6
        Width = 69
        Height = 21
        Bitmaps.TransparentColor = clOlive
        Color = clBtnHighlight
        Anchors = [akRight, akBottom]
        TabOrder = 0
      end
      object Btn_new: TRzBmpButton
        Left = 69
        Top = 8
        Width = 69
        Height = 21
        Bitmaps.Hot.Data = {
          46110000424D4611000000000000360000002800000045000000150000000100
          18000000000010110000120B0000120B00000000000000000000FEDBACE6C79E
          D6A25ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D6A25EE6C79EFEDAA900E7C9A2E6B65AFCD562FEDA63FEDA63FEDA63FEDA63FE
          DA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63
          FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA
          63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FE
          DA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63
          FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA
          63FEDA63FEDA63FEDA63FEDA63FEDA63FCD562E6B65AE6C79E00D6A25EFCD25D
          FDEAB5FEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF1
          D2FEF1D2FEF1D2FEF1D2FEF1D2FEF1D2FEF1D2F9EEC5F8EBC0F7EABCF8EBC0F8
          EBC0F9EEC5F9EEC5FBEFCAFAF2CDFEF1D2FEF1D2FEF3D5FEF4D8FEF4D8FEF4D8
          FEF4D8FEF4D8FEF4D8FEF4D8FEF4D8FEF3D5FEF3D5FEF1D2FAF2CDFAF2CAFAF2
          CAF9EEC5FCF2C2FCF2C2FCF2BDFAF2BCFAF2BCFAF2BCFAEDB5F9E9B1F9E9B1F8
          E6AFF8E6AFF6E5AAF9E6ABF6E5AAF6E5AAF6E5AAF5E2A6F5E2A6F5E2A6F5E2A6
          F3DE93FCD25DD6A25E00D2994EFCD25DFDEAC1FCDE9CFCDE9CFCDE9CFCDE9CFC
          DE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CF9DB95F4D78C
          F3D686F3D686F3D686F5D789F5D789F5D789F7D88DF7D88DF6D990F7DB93F9DB
          95F9DD97FADE99FCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFA
          DE99FADE99FADE99FAE19AFAE19AFAE19AF9E69BF9E69BF9E69BF9E99DF9E99D
          F9E595F9DB87F6D884F6D884F6D884F5D683F5D683F5D683F5D683F5D683F3D5
          81F3D581F3D581F3D581F2D47FF1D37EF2DD9AFCD25DD2994E00D2994EFDCF57
          FDE6B8FAD991FBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD7
          8CF9D686F5D47FF2D179F2D179F2D179F2D179F2D179F4D27CF4D27CF4D27CF5
          D47FF5D47FF5D47FF5D683F9D686F9D686F9D686FBD689FBD689FBD689FBD689
          FBD689FBD689FBD689FBD689FBD689FBD689FBD689FBD78CFADC8EFADC8EF9DF
          8DF9E595F9E595F9E595F9E595F9DB87F6D57AF6D57AF6D279F6D279F6D279F4
          D177F4D177F4D177F4D177F2D076F2D076F2D076F2CE73F2CE73F2CD72F2D076
          F3DA95FDCF57D2994E00D2994EFCCB54FCE4B2FAD386FAD181FAD181FAD181FA
          D181FAD181FAD181FAD181F6CF7AF4CD72F3CC6FF3CC6FF2CD72F2CD72F2CD72
          F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE
          73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2
          CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F9E595F9DF8DF6D279F5CF72
          F5CF72F5CF72F5CF72F4CE71F4CE71F4CE71F5CD70F3CC6FF3CC6FF3CC6FF2CB
          6DF2CB6DF1CA6BF1CA6BF1CA6BF2CB6DF3DA95FCCB54D2994E00D2994EFCCB54
          FDE3B0FAD181FACE7BFACE7BFACE7BFACF7CF9CE7AF6CB72F3C86BF1C96AF3CA
          6BF3CA6BF2CB6DF2CB6DF3CC6FF3CC6FF3CC6FF4CD72F4CD72F4CD72F4CD72F4
          CD72F4CD72F4CD72F4CD72000000000000F4CD72F4CD72F4CD72F4CD72F4CD72
          000000F4CD72F4CD72000000000000F4CD72F4CD72000000F4CD72F4CD720000
          00F4CD72F6D57AF6CE6FF6CE6FF6CE6FF6CD6FF5CC6EF5CC6EF5CC6EF4CA6CF4
          CA6CF3CA6BF4C96BF3CA6BF3C869F3C869F1C868F1C866F1C866F1C866F1CA6B
          F8E0A5FCCB54D2994E00D2994EFCC750FCE0ACFACD7BFACC76FACC76F9CB72F4
          C96BF1C765F1C765F3C766F1C868F1C868F3C869F3C869F3CA6BF4CA6CF4CA6C
          F4CA6CF5CB6EF3CC6FF3CC6F000000F3CC6FF3CC6F000000F3CC6FF3CC6F0000
          00F3CC6F000000F3CC6F000000F3CC6FF3CC6F000000F3CC6FF3CC6FF3CC6F00
          0000F3CC6F000000000000000000000000F3CC6FF7CC6CF7CC6CF7CC6CF5CA6A
          F5CA6AF5CA6AF5CA69F5CA69F4C968F4C968F3C866F3C866F3C866F2C665F2C6
          65F2C564F1C663F1C663F1C563F6CB72FBDDA5FCC750D2994E00D2994EFCC750
          FCE0ACFACD78F9C86EF3C766F1C563F1C563F2C564F2C665F2C665F3C766F3C7
          68F3C869F3C869F4C96BF4C96BF4CA6CF5CB6EF5CB6EF5CC6EF6CC70F7CC6C00
          0000F7CC6CF7CC6C000000F7CC6C000000F7CC6C000000F7CC6B000000F7CB6B
          F7CB6B000000F6CB6AF6CB6AF6CA6A000000F6CA69000000F6CA69F6CA690000
          00F6CA69F6CA69F6CA69F6CA69F6C968F6C968F5C766F5C766F3C866F5C766F4
          C665F3C663F3C663F3C663F3C563F2C461F2C461F1C460F1C35FF6C768F9CA74
          FBDDA5FCC750D2994E00D2994EFCC750FBDDA5F3C86BF1C563F3C563F2C564F2
          C564F2C665F3C766F3C766F3C768F3C869F3C869F4C96BF4CA6CF4CA6CF5CB6E
          F5CB6EF6CC70F6CD72F6CD72F7C96AF7C96A000000F7C96AF7C96AF7C96A0000
          00000000F7C96A000000F7C969F7C969F7C969F6C969000000F6C969F6C96800
          0000F6C968000000F6C968F6C968000000F6C968F6C968F6C968F6C968F6C768
          F6C768F5C766F5C766F5C766F4C564F4C564F4C564F3C563F3C563F2C461F1C4
          60F1C35FF1C35FF4C564F9C86EF9CA74FBDDA5FCC750D2994E00D2994EFCC750
          F3D68FF3C768F2C564F2C665F2C665F3C766F3C768F3C768F3C869F3C869F4C9
          6BF4CA6CF4CA6CF5CB6EF5CB6EF6CC70F6CD72F6CE73F6CE73F7CE75F7C96AF7
          C96AF7C96AF7C96AF7C96AF7C96A000000F7C96AF7C96AF7C96AF7C96AF7C96A
          F7C96AF7C96A000000F7C96AF7C96A000000F7C96A000000F7C96AF7C96A0000
          00F7C96AF7C96AF7C96AF6C768F6C768F6C768F5C766F5C766F4C665F4C665F4
          C564F3C563F3C563F2C461F2C461F1C460F1C360F2C461F9C86EF9C86EF9CA74
          FBDDA5FCC750D2994E00D2994EFCC750F3D691F3C768F2C665F3C766F3C766F3
          C768F3C869F3C869F4C96BF4CA6CF4CA6CF5CB6EF5CC6EF6CC70F6CD72F6CE73
          F6CE73F7CE75F7D077F8D078F7C96A000000F7C96A000000F7C96AF7C96A0000
          00F7C96AF7C96AF7C96A000000F7C96AF7C96AF7C96A000000F7C96AF7C96A00
          0000F7C96A000000F7C96AF7C96A000000F7C96AF7C96AF7C96AF6C768F6C768
          F5C766F5C766F5C766F4C665F4C564F4C564F3C563F2C461F2C461F2C461F1C3
          60F1C460F8C76CF9C86EFAC86FF9CA74FBDDA5FCC750D2994E00D2994EFCD25D
          F5E2A6F4D78CF5D789F4D78CF4D78CF7D88DF7D88DF6D990F6D990F6D990F7DB
          93F7DB93F7DB93F9DB95F9DB95F9DD97F9DD97F9DD97F9DD97F9DD97000000F9
          DD98F9DD98FADE98000000FADE98FADE99FADE99FADE99000000FADE99FADE98
          FADD97FADD96000000F9DC95F9DB94000000F8DA91000000F8D98FF7D98F0000
          00F7D88DF7D88DF7D88DF7D88DF7D88DF7D88DF7D88DF5D789F5D789F5D789F5
          D789F4D486F4D486F4D486F3D384F3D384FAD991FBDB99FBDB99FBDB99FADE9E
          FDE9C1FCD25DD2994E00D2994EFCD25DF5E3AFF5DA93F5DA93F5DA93F6DA95F6
          DC96F6DC96F6DC96F7DD9AF7DD9AF7DD9AF7DD9AF7DD9AF9E19DF9E19DF9E19D
          F9E19EF9E19EF9E19EF9E29FF9E29FF9E29FF9E2A0FAE3A0FAE3A0000000FAE3
          A1FAE4A1000000FAE4A2FAE4A2FAE4A2FAE4A2FAE4A2000000FAE4A2FAE4A200
          0000FAE4A1000000FAE29FF9E09B000000F9DC96F8DB94F8DB94F9DB94F7DB93
          F7DB93F6D990F6D990F6D990F6D990F6D990F3D68FF4D78CF3D68BF3D68BF6DA
          95FBDEA1FBDEA1FBDEA1FCDEA3FCDFA6FDEBC5FCD25DD2994E00D2994EFCD562
          F7E5B4F6DE9DF6DE9DF7DD9AF6DE9DF6DE9DF9E19DF9E2A2F9E2A2F9E2A2F9E2
          A2F9E2A2FBE4A4FBE4A4FAE6A6FBE4A4FAE6A7FAE6A6FAE6A6FAE6A6FAE6A6FA
          E6A6FAE6A6000000000000000000000000000000000000000000000000FAE6A6
          000000000000000000000000000000000000FBE7A8000000FBE4A6FAE2A20000
          00FADE9EF8DD9BF9DE9DFADE9DF7DD9AF7DD9AF7DD9AF7DD9AF6DB98F6DB98F6
          DA95F6DA95F3DA95F5DA93F7DD9AFDE2ADFDE2ADFDE2ADFDE2ADFDE2ADFDE3B0
          FEEECDFCD562D2994E00D2994EFED966F9EAB9F5E2A6F8E0A5F8E3A9F8E3A9F8
          E3A9F8E3A9F9E6ABF9E6ABF9E6ABF9E6ABFAE8ADFAE8ADFAE8ADFAE8ADFBEBB0
          FBEBB0FBEBB0FBEBB0FBEBB0FBEBB0000000FBEBB0FBEBB0FBEBB0FBEBB00000
          00FBEBB0FBEBB0FBEBB0FBEBB0FBEBB0FBEBB0FBEBB0000000FBEBB0FBEBB0FB
          EBB0FBEBB0000000000000000000000000F8E0A6F8E1A7F8E2A8F8E0A5F8E0A5
          F8E0A5F6DFA2F6DFA2F6DFA2F6DFA2F6DE9DF6DE9DF6DE9DF6DE9DFCE6B5FDE6
          B8FDE6B8FDE6B8FDE6B8FDE6B8FDE8BBFEF1D2FED966D2994E00D2994EFED966
          F8EBC0F8E6AFF8E6AFF8E6AFF9E6B1F9E9B1F9E9B1F9E9B1F9E9B1FBEBB4FBEB
          B4FBEBB4FBEBB4FCEDB5FCEDB5FCEDB5FCEDB5FCEDB5FDF0B6FDF0B6000000FD
          F0B6FDF0B6FDF0B6FDF0B6FDF0B6000000FDF0B6FDF0B6FDF0B6FDF0B6FDF0B6
          FDF0B6FDF0B6000000FDF0B6FDF0B6FDF0B6FDF0B6FDF0B6FDEDB6FBEBB4FAEA
          B3FAE6B1F9E5AFF9E5B0F8E6AFF8E3ADF8E3ADF8E3ADF8E3A9F8E3A9F8E3A9F5
          E2A6F5E2A6F5E2A6F9E7B9FEEAC1FEEAC1FEEAC2FEEAC2FEEAC2FEEAC2FDEBC5
          FEF4D8FED966D2994E00D2994EFBD96BF9EEC5F9EAB9F9EAB9F9EAB9FAECBBFA
          ECBBFAECBBFAECBBFBEEBCFBEEBCFBEEBCFBEEBCFBEEBCFDF0BAFCF2BDFCF2BD
          FCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BD0000000000000000
          00000000000000000000FCF2BDFCF2BDFCF2BDFCF2BD000000FCF2BDFCF2BDFC
          F2BDFCF2BDFCF2BDFCF1BEFBEFBDFBEEBDFAE9BEF9E8BCF9E8BCF9E7B9F9E7B9
          F9E7B9F7E5B4F7E5B4F7E5B4F7E5B4F5E3AFF5E3AFF9E8BDFEEECFFEEECFFEEE
          CFFEEECFFEEECFFEEECFFEEECFFEEECFFDF5E0FBD96BD2994E00D6A25EFBD96B
          FAEDB5FAF2CAFAF2CDFAF2CDFAF2CDFBF5CEFBF5CEFBF5CEFBF5CEFBF6D1FBF6
          D1FBF6D1FBF6D1FCF7D1FCF7D1FDF9D3FDF9D3FCF7D1FDF9D3FDF9D3FDF9D3FD
          F9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3
          FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D4FDF8D4FDF8
          D4FCF5DFFBF3DAFBF3DBF9F2D6F9F2D6F9F2D6F8F0D2F8F0D2F7EFD0F7EECCF7
          EECCF8EFCEFEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7
          FEF1CAFBD96BD6A25E00E7C9A2E6B65AFBD96BFFDF70FFDF70FFDF70FFDF70FF
          DF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70
          FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF
          70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FF
          DF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70
          FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF
          70FFDF70FFDF70FFDF70FFDF70FFDF70FBD96BE6B65AE7C9A200FFDBAAE7C9A2
          D7A461D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D7A461E7C9A2FFDCAB00}
        Bitmaps.TransparentColor = clOlive
        Bitmaps.Up.Data = {
          46110000424D4611000000000000360000002800000045000000150000000100
          1800000000001011000000000000000000000000000000000000FEDBACE6C79D
          D6A35FD2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D6A35FE6C79DFEDAA900E7C9A1E4BD8DF8E4D1FCECDFFCECDFFCECDFFCECDFFC
          ECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDF
          FCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCEC
          DFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFC
          ECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDF
          FCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCEC
          DFFCECDFFCECDFFCECDFFCECDFFCECDFF8E4D1E4BD8DE7C89F00D6A15DF6E1CC
          F8E3D0F7DEC8F7DEC8F7DFC9F7DFC9F8DFCAF8DFCAF8E0CBF8E0CBF8E0CCF8E1
          CCF8E1CDF8E2CEF8E2CEF8E2CFF8E3D0F8E3D1F9E4D1F9E4D2F9E4D2F9E5D3F9
          E5D3F9E5D4F9E6D5F9E6D5F9E6D5F9E6D6F9E7D6F9E7D7F9E7D7F9E7D7F9E7D7
          F9E7D7F9E7D7F9E7D7F9E7D7F9E7D7F9E7D6F9E7D6F9E6D6F9E6D5F9E6D5F9E6
          D4F9E5D4F9E5D3F9E4D3F9E4D2F9E4D1F8E3D1F8E3D0F8E2CFF8E2CEF8E2CEF8
          E1CDF8E1CCF8E0CCF8E0CBF8E0CBF8E0CAF8DFCAF7DFC9F7DFC9F7DEC8F7DEC8
          F8E3D0F6E1CCD6A15D00D2994EF7E3D0F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4
          D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BC
          F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7
          BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4
          D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BC
          F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7
          BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF7E3D0D2994E00D2994EF6E0CB
          F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2
          B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2
          D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4
          F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2
          B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2
          D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4
          F2D2B4F6E0CBD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3000000000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          000000F2D1B3F2D1B3000000000000F2D1B3F2D1B3000000F2D1B3F2D1B30000
          00F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3000000F2D1B3F2D1B30000
          00F2D1B3000000F2D1B3000000F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B300
          0000F2D1B3000000000000000000000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B300
          0000F2D1B3F2D1B3000000F2D1B3000000F2D1B3000000F2D1B3000000F2D1B3
          F2D1B3000000F2D1B3F2D1B3F2D1B3000000F2D1B3000000F2D1B3F2D1B30000
          00F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B30000
          00000000F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B300
          0000F2D1B3000000F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3000000F2D1B3F2D1B3000000F2D1B3000000F2D1B3F2D1B30000
          00F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3000000F2D1B3F2D1B30000
          00F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B300
          0000F2D1B3000000F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EFCE9D9
          FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0
          C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8000000FB
          E0C8FBE0C8FBE0C8000000FBE0C8FBE0C8FBE0C8FBE0C8000000FBE0C8FBE0C8
          FBE0C8FBE0C8000000FBE0C8FBE0C8000000FBE0C8000000FBE0C8FBE0C80000
          00FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FB
          E0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8
          FBE0C8FCE9D9D2994E00D2994EFDEBDBFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFC
          E3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CC
          FCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CC000000FCE3
          CCFCE3CC000000FCE3CCFCE3CCFCE3CCFCE3CCFCE3CC000000FCE3CCFCE3CC00
          0000FCE3CC000000FCE3CCFCE3CC000000FCE3CCFCE3CCFCE3CCFCE3CCFCE3CC
          FCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3
          CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFDEBDBD2994E00D2994EFDEEDE
          FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6
          D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FC
          E6D0FCE6D0000000000000000000000000000000000000000000000000FCE6D0
          000000000000000000000000000000000000FCE6D0000000FCE6D0FCE6D00000
          00FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FC
          E6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0
          FCE6D0FDEEDED2994E00D2994EFEEFE2FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FD
          E8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5
          FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5000000FDE8D5FDE8D5FDE8D5FDE8D50000
          00FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5000000FDE8D5FDE8D5FD
          E8D5FDE8D5000000000000000000000000FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5
          FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8
          D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FEEFE2D2994E00D2994EFEF1E5
          FEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEB
          DAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDA000000FE
          EBDAFEEBDAFEEBDAFEEBDAFEEBDA000000FEEBDAFEEBDAFEEBDAFEEBDAFEEBDA
          FEEBDAFEEBDA000000FEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEB
          DAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFE
          EBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDA
          FEEBDAFEF1E5D2994E00D2994EFEF3E8FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFE
          EEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE
          FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE0000000000000000
          00000000000000000000FEEEDEFEEEDEFEEEDEFEEEDE000000FEEEDEFEEEDEFE
          EEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE
          FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEE
          DEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEF3E8D2994E00D6A15DFBEDDE
          FFF3E7FFF1E3FFF1E3FFF2E3FFF2E3FFF2E4FFF2E4FFF2E4FFF2E4FFF2E5FFF2
          E5FFF3E5FFF3E6FFF3E6FFF3E6FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FF
          F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7
          FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3
          E7FFF3E7FFF4E9FFF4E8FFF4E8FFF4E8FFF4E7FFF3E7FFF3E7FFF3E6FFF3E6FF
          F3E6FFF3E5FFF2E5FFF2E5FFF2E4FFF2E4FFF2E4FFF2E4FFF2E3FFF2E3FFF1E3
          FFF3E7FBEDDED6A15D00E7C9A1E6C59BFAF4ECFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF4ECE6C59BE7C9A100FFDBAAE8CAA3
          D7A461D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D7A461E8CAA3FFDCAB00}
        Color = clBtnHighlight
        Anchors = [akRight, akBottom]
        TabOrder = 2
        Visible = False
      end
      object Btn_save: TRzBmpButton
        Left = 157
        Top = 8
        Width = 69
        Height = 21
        Bitmaps.Hot.Data = {
          46110000424D4611000000000000360000002800000045000000150000000100
          18000000000010110000120B0000120B00000000000000000000FEDBACE6C79E
          D6A25ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D6A25EE6C79EFEDAA900E7C9A2E6B65AFCD562FEDA63FEDA63FEDA63FEDA63FE
          DA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63
          FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA
          63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FE
          DA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63
          FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA
          63FEDA63FEDA63FEDA63FEDA63FEDA63FCD562E6B65AE6C79E00D6A25EFCD25D
          FDEAB5FEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF1
          D2FEF1D2FEF1D2FEF1D2FEF1D2FEF1D2FEF1D2F9EEC5F8EBC0F7EABCF8EBC0F8
          EBC0F9EEC5F9EEC5FBEFCAFAF2CDFEF1D2FEF1D2FEF3D5FEF4D8FEF4D8FEF4D8
          FEF4D8FEF4D8FEF4D8FEF4D8FEF4D8FEF3D5FEF3D5FEF1D2FAF2CDFAF2CAFAF2
          CAF9EEC5FCF2C2FCF2C2FCF2BDFAF2BCFAF2BCFAF2BCFAEDB5F9E9B1F9E9B1F8
          E6AFF8E6AFF6E5AAF9E6ABF6E5AAF6E5AAF6E5AAF5E2A6F5E2A6F5E2A6F5E2A6
          F3DE93FCD25DD6A25E00D2994EFCD25DFDEAC1FCDE9CFCDE9CFCDE9CFCDE9CFC
          DE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CF9DB95F4D78C
          F3D686F3D686F3D686F5D789F5D789F5D789F7D88DF7D88DF6D990F7DB93F9DB
          95F9DD97FADE99FCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFCDD9AFA
          DE99FADE99FADE99FAE19AFAE19AFAE19AF9E69BF9E69BF9E69BF9E99DF9E99D
          F9E595F9DB87F6D884F6D884F6D884F5D683F5D683F5D683F5D683F5D683F3D5
          81F3D581F3D581F3D581F2D47FF1D37EF2DD9AFCD25DD2994E00D2994EFDCF57
          FDE6B8FAD991FBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD7
          8CF9D686F5D47FF2D179F2D179F2D179F2D179F2D179F4D27CF4D27CF4D27CF5
          D47FF5D47FF5D47FF5D683F9D686F9D686F9D686FBD689FBD689FBD689FBD689
          FBD689FBD689FBD689FBD689FBD689FBD689FBD689FBD78CFADC8EFADC8EF9DF
          8DF9E595F9E595F9E595F9E595F9DB87F6D57AF6D57AF6D279F6D279F6D279F4
          D177F4D177F4D177F4D177F2D076F2D076F2D076F2CE73F2CE73F2CD72F2D076
          F3DA95FDCF57D2994E00D2994EFCCB54FCE4B2FAD386FAD181FAD181FAD181FA
          D181FAD181FAD181FAD181F6CF7AF4CD72F3CC6FF3CC6FF2CD72F2CD72F2CD72
          F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE
          73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2
          CE73F2CE73F2CE73F2CE73F2CE73F2CE73F2CE73F9E595F9DF8DF6D279F5CF72
          F5CF72F5CF72F5CF72F4CE71F4CE71F4CE71F5CD70F3CC6FF3CC6FF3CC6FF2CB
          6DF2CB6DF1CA6BF1CA6BF1CA6BF2CB6DF3DA95FCCB54D2994E00D2994EFCCB54
          FDE3B0FAD181FACE7BFACE7BFACE7BFACF7CF9CE7AF6CB72F3C86BF1C96AF3CA
          6BF3CA6BF2CB6DF2CB6DF3CC6FF3CC6FF3CC6FF4CD72F4CD72F4CD72F4CD72F4
          CD72000000F4CD72F4CD72F4CD72F4CD72000000F4CD72F4CD72F4CD72F4CD72
          F4CD72F4CD72000000F4CD72F4CD72F4CD72000000000000F4CD72F4CD72F4CD
          72F4CD72F6D57AF6CE6FF6CE6FF6CE6FF6CD6FF5CC6EF5CC6EF5CC6EF4CA6CF4
          CA6CF3CA6BF4C96BF3CA6BF3C869F3C869F1C868F1C866F1C866F1C866F1CA6B
          F8E0A5FCCB54D2994E00D2994EFCC750FCE0ACFACD7BFACC76FACC76F9CB72F4
          C96BF1C765F1C765F3C766F1C868F1C868F3C869F3C869F3CA6BF4CA6CF4CA6C
          F4CA6CF5CB6EF3CC6FF3CC6FF3CC6FF3CC6F000000F3CC6F000000F3CC6FF3CC
          6F000000F3CC6FF3CC6F000000F3CC6FF3CC6FF3CC6F000000F3CC6FF3CC6FF3
          CC6FF3CC6F000000F3CC6FF3CC6FF3CC6FF3CC6FF7CC6CF7CC6CF7CC6CF5CA6A
          F5CA6AF5CA6AF5CA69F5CA69F4C968F4C968F3C866F3C866F3C866F2C665F2C6
          65F2C564F1C663F1C663F1C563F6CB72FBDDA5FCC750D2994E00D2994EFCC750
          FCE0ACFACD78F9C86EF3C766F1C563F1C563F2C564F2C665F2C665F3C766F3C7
          68F3C869F3C869F4C96BF4C96BF4CA6CF5CB6EF5CB6EF5CC6EF6CC70F7CC6CF7
          CC6C000000F7CC6CF7CC6C000000F7CC6C000000F7CC6C000000F7CB6BF7CB6B
          F7CB6BF6CB6A000000F6CB6AF6CA6AF6CA69F6CA69000000F6CA69F6CA69F6CA
          69F6CA69F6CA69F6CA69F6CA69F6C968F6C968F5C766F5C766F3C866F5C766F4
          C665F3C663F3C663F3C663F3C563F2C461F2C461F1C460F1C35FF6C768F9CA74
          FBDDA5FCC750D2994E00D2994EFCC750FBDDA5F3C86BF1C563F3C563F2C564F2
          C564F2C665F3C766F3C766F3C768F3C869F3C869F4C96BF4CA6CF4CA6CF5CB6E
          F5CB6EF6CC70F6CD72F6CD72F7C96AF7C96A000000F7C96AF7C96AF7C96A0000
          00000000000000F7C96AF7C969F7C969F7C969F6C969000000F6C969F6C968F6
          C968F6C968000000F6C968F6C968F6C968F6C968F6C968F6C968F6C968F6C768
          F6C768F5C766F5C766F5C766F4C564F4C564F4C564F3C563F3C563F2C461F1C4
          60F1C35FF1C35FF4C564F9C86EF9CA74FBDDA5FCC750D2994E00D2994EFCC750
          F3D68FF3C768F2C564F2C665F2C665F3C766F3C768F3C768F3C869F3C869F4C9
          6BF4CA6CF4CA6CF5CB6EF5CB6EF6CC70F6CD72F6CE73F6CE73F7CE75F7C96AF7
          C96A000000F7C96AF7C96AF7C96AF7C96A000000F7C96AF7C96AF7C96AF7C96A
          000000F7C96A000000F7C96A0000000000000000000000000000000000000000
          00F7C96AF7C96AF7C96AF6C768F6C768F6C768F5C766F5C766F4C665F4C665F4
          C564F3C563F3C563F2C461F2C461F1C460F1C360F2C461F9C86EF9C86EF9CA74
          FBDDA5FCC750D2994E00D2994EFCC750F3D691F3C768F2C665F3C766F3C766F3
          C768F3C869F3C869F4C96BF4CA6CF4CA6CF5CB6EF5CC6EF6CC70F6CD72F6CE73
          F6CE73F7CE75F7D077F8D078F7C96AF7C96A000000F7C96A0000000000000000
          00000000000000000000000000F7C96AF7C96A000000000000F7C96AF7C96AF7
          C96AF7C96A000000F7C96AF7C96AF7C96AF7C96AF7C96AF7C96AF6C768F6C768
          F5C766F5C766F5C766F4C665F4C564F4C564F3C563F2C461F2C461F2C461F1C3
          60F1C460F8C76CF9C86EFAC86FF9CA74FBDDA5FCC750D2994E00D2994EFCD25D
          F5E2A6F4D78CF5D789F4D78CF4D78CF7D88DF7D88DF6D990F6D990F6D990F7DB
          93F7DB93F7DB93F9DB95F9DB95F9DD97F9DD97F9DD97F9DD97F9DD97000000F9
          DD98000000FADE98FADE98FADE98FADE99000000FADE99FADE99FADE99FADE98
          FADD97FADD96000000F9DC95F9DB94F8DB92F8DA91F8DA90000000F7D98FF7D8
          8EF7D88DF7D88DF7D88DF7D88DF7D88DF7D88DF7D88DF5D789F5D789F5D789F5
          D789F4D486F4D486F4D486F3D384F3D384FAD991FBDB99FBDB99FBDB99FADE9E
          FDE9C1FCD25DD2994E00D2994EFCD25DF5E3AFF5DA93F5DA93F5DA93F6DA95F6
          DC96F6DC96F6DC96F7DD9AF7DD9AF7DD9AF7DD9AF7DD9AF9E19DF9E19DF9E19D
          F9E19EF9E19EF9E19EF9E29FF9E29F000000000000FAE3A0FAE3A00000000000
          00000000000000000000FAE4A2FAE4A2FAE4A2FAE4A2000000FAE4A2FAE4A200
          0000000000000000000000000000F9DE9AF9DC96F8DB94F8DB94F9DB94F7DB93
          F7DB93F6D990F6D990F6D990F6D990F6D990F3D68FF4D78CF3D68BF3D68BF6DA
          95FBDEA1FBDEA1FBDEA1FCDEA3FCDFA6FDEBC5FCD25DD2994E00D2994EFCD562
          F7E5B4F6DE9DF6DE9DF7DD9AF6DE9DF6DE9DF9E19DF9E2A2F9E2A2F9E2A2F9E2
          A2F9E2A2FBE4A4FBE4A4FAE6A6FBE4A4FAE6A7FAE6A6FAE6A6FAE6A6FAE6A6FA
          E6A6000000FAE6A6FAE6A6000000FAE6A6FAE6A6FAE6A6000000FAE6A6FAE6A6
          FAE6A6FAE6A7FAE7A7000000FAE7A7FBE7A8FBE7A8FBE7A8FBE4A6FAE2A2FADF
          9FFADE9EF8DD9BF9DE9DFADE9DF7DD9AF7DD9AF7DD9AF7DD9AF6DB98F6DB98F6
          DA95F6DA95F3DA95F5DA93F7DD9AFDE2ADFDE2ADFDE2ADFDE2ADFDE2ADFDE3B0
          FEEECDFCD562D2994E00D2994EFED966F9EAB9F5E2A6F8E0A5F8E3A9F8E3A9F8
          E3A9F8E3A9F9E6ABF9E6ABF9E6ABF9E6ABFAE8ADFAE8ADFAE8ADFAE8ADFBEBB0
          FBEBB0FBEBB0FBEBB0FBEBB0FBEBB0FBEBB0000000FBEBB0FBEBB0000000FBEB
          B0FBEBB0FBEBB0000000FBEBB0FBEBB000000000000000000000000000000000
          0000000000000000000000000000000000F8E0A6F8E1A7F8E2A8F8E0A5F8E0A5
          F8E0A5F6DFA2F6DFA2F6DFA2F6DFA2F6DE9DF6DE9DF6DE9DF6DE9DFCE6B5FDE6
          B8FDE6B8FDE6B8FDE6B8FDE6B8FDE8BBFEF1D2FED966D2994E00D2994EFED966
          F8EBC0F8E6AFF8E6AFF8E6AFF9E6B1F9E9B1F9E9B1F9E9B1F9E9B1FBEBB4FBEB
          B4FBEBB4FBEBB4FCEDB5FCEDB5FCEDB5FCEDB5FCEDB5FDF0B6FDF0B6FDF0B6FD
          F0B6FDF0B6000000FDF0B6000000000000000000000000000000FDF0B6FDF0B6
          FDF0B6FDF0B6FDF0B6FDF0B6000000FDF0B6FDF0B6FDF0B6FDEDB6FBEBB4FAEA
          B3FAE6B1F9E5AFF9E5B0F8E6AFF8E3ADF8E3ADF8E3ADF8E3A9F8E3A9F8E3A9F5
          E2A6F5E2A6F5E2A6F9E7B9FEEAC1FEEAC1FEEAC2FEEAC2FEEAC2FEEAC2FDEBC5
          FEF4D8FED966D2994E00D2994EFBD96BF9EEC5F9EAB9F9EAB9F9EAB9FAECBBFA
          ECBBFAECBBFAECBBFBEEBCFBEEBCFBEEBCFBEEBCFBEEBCFDF0BAFCF2BDFCF2BD
          FCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BD000000FCF2BDFCF2BDFCF2
          BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BDFCF2BD000000FC
          F2BDFCF2BDFCF2BDFCF1BEFBEFBDFBEEBDFAE9BEF9E8BCF9E8BCF9E7B9F9E7B9
          F9E7B9F7E5B4F7E5B4F7E5B4F7E5B4F5E3AFF5E3AFF9E8BDFEEECFFEEECFFEEE
          CFFEEECFFEEECFFEEECFFEEECFFEEECFFDF5E0FBD96BD2994E00D6A25EFBD96B
          FAEDB5FAF2CAFAF2CDFAF2CDFAF2CDFBF5CEFBF5CEFBF5CEFBF5CEFBF6D1FBF6
          D1FBF6D1FBF6D1FCF7D1FCF7D1FDF9D3FDF9D3FCF7D1FDF9D3FDF9D3FDF9D3FD
          F9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3
          FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D3FDF9D4FDF8D4FDF8
          D4FCF5DFFBF3DAFBF3DBF9F2D6F9F2D6F9F2D6F8F0D2F8F0D2F7EFD0F7EECCF7
          EECCF8EFCEFEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7
          FEF1CAFBD96BD6A25E00E7C9A2E6B65AFBD96BFFDF70FFDF70FFDF70FFDF70FF
          DF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70
          FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF
          70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FF
          DF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70
          FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF
          70FFDF70FFDF70FFDF70FFDF70FFDF70FBD96BE6B65AE7C9A200FFDBAAE7C9A2
          D7A461D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D7A461E7C9A2FFDCAB00}
        Bitmaps.TransparentColor = clOlive
        Bitmaps.Up.Data = {
          46110000424D4611000000000000360000002800000045000000150000000100
          1800000000001011000000000000000000000000000000000000FEDBACE6C79D
          D6A35FD2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D6A35FE6C79DFEDAA900E7C9A1E4BD8DF8E4D1FCECDFFCECDFFCECDFFCECDFFC
          ECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDF
          FCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCEC
          DFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFC
          ECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDF
          FCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCEC
          DFFCECDFFCECDFFCECDFFCECDFFCECDFF8E4D1E4BD8DE7C89F00D6A15DF6E1CC
          F8E3D0F7DEC8F7DEC8F7DFC9F7DFC9F8DFCAF8DFCAF8E0CBF8E0CBF8E0CCF8E1
          CCF8E1CDF8E2CEF8E2CEF8E2CFF8E3D0F8E3D1F9E4D1F9E4D2F9E4D2F9E5D3F9
          E5D3F9E5D4F9E6D5F9E6D5F9E6D5F9E6D6F9E7D6F9E7D7F9E7D7F9E7D7F9E7D7
          F9E7D7F9E7D7F9E7D7F9E7D7F9E7D7F9E7D6F9E7D6F9E6D6F9E6D5F9E6D5F9E6
          D4F9E5D4F9E5D3F9E4D3F9E4D2F9E4D1F8E3D1F8E3D0F8E2CFF8E2CEF8E2CEF8
          E1CDF8E1CCF8E0CCF8E0CBF8E0CBF8E0CAF8DFCAF7DFC9F7DFC9F7DEC8F7DEC8
          F8E3D0F6E1CCD6A15D00D2994EF7E3D0F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4
          D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BC
          F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7
          BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4
          D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BC
          F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7
          BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF7E3D0D2994E00D2994EF6E0CB
          F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2
          B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2
          D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4
          F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2
          B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2
          D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4
          F2D2B4F6E0CBD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3000000000000F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3000000F2D1B3F2D1
          B3000000F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2
          D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3000000F2D1B3F2D1B3000000F2D1B3000000F2D1B3000000F2D1B3F2D1B3
          F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B30000
          00000000000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2
          D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3
          000000F2D1B3000000F2D1B30000000000000000000000000000000000000000
          00F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
          D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3000000F2D1B30000000000000000
          00000000000000000000000000F2D1B3F2D1B3000000000000F2D1B3F2D1B3F2
          D1B3F2D1B3000000F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
          F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
          B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EFCE9D9
          FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0
          C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8000000FB
          E0C8000000FBE0C8FBE0C8FBE0C8FBE0C8000000FBE0C8FBE0C8FBE0C8FBE0C8
          FBE0C8FBE0C8000000FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8000000FBE0C8FBE0
          C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FB
          E0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8
          FBE0C8FCE9D9D2994E00D2994EFDEBDBFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFC
          E3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CC
          FCE3CCFCE3CCFCE3CCFCE3CCFCE3CC000000000000FCE3CCFCE3CC0000000000
          00000000000000000000FCE3CCFCE3CCFCE3CCFCE3CC000000FCE3CCFCE3CC00
          0000000000000000000000000000FCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CC
          FCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3
          CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFDEBDBD2994E00D2994EFDEEDE
          FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6
          D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FC
          E6D0000000FCE6D0FCE6D0000000FCE6D0FCE6D0FCE6D0000000FCE6D0FCE6D0
          FCE6D0FCE6D0FCE6D0000000FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6
          D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FC
          E6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0
          FCE6D0FDEEDED2994E00D2994EFEEFE2FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FD
          E8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5
          FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5000000FDE8D5FDE8D5000000FDE8
          D5FDE8D5FDE8D5000000FDE8D5FDE8D500000000000000000000000000000000
          0000000000000000000000000000000000FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5
          FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8
          D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FEEFE2D2994E00D2994EFEF1E5
          FEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEB
          DAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFE
          EBDAFEEBDA000000FEEBDA000000000000000000000000000000FEEBDAFEEBDA
          FEEBDAFEEBDAFEEBDAFEEBDA000000FEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEB
          DAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFE
          EBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDA
          FEEBDAFEF1E5D2994E00D2994EFEF3E8FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFE
          EEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE
          FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE000000FEEEDEFEEEDEFEEE
          DEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE000000FE
          EEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE
          FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEE
          DEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEF3E8D2994E00D6A15DFBEDDE
          FFF3E7FFF1E3FFF1E3FFF2E3FFF2E3FFF2E4FFF2E4FFF2E4FFF2E4FFF2E5FFF2
          E5FFF3E5FFF3E6FFF3E6FFF3E6FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FF
          F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7
          FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3
          E7FFF3E7FFF4E9FFF4E8FFF4E8FFF4E8FFF4E7FFF3E7FFF3E7FFF3E6FFF3E6FF
          F3E6FFF3E5FFF2E5FFF2E5FFF2E4FFF2E4FFF2E4FFF2E4FFF2E3FFF2E3FFF1E3
          FFF3E7FBEDDED6A15D00E7C9A1E6C59BFAF4ECFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF4ECE6C59BE7C9A100FFDBAAE8CAA3
          D7A461D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
          4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
          994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
          D7A461E8CAA3FFDCAB00}
        Color = clBtnHighlight
        Anchors = [akRight, akBottom]
        TabOrder = 3
        Visible = False
      end
    end
    object RzPanel8: TRzPanel
      Left = 0
      Top = 423
      Width = 632
      Height = 1
      Align = alBottom
      BorderOuter = fsNone
      Color = 16762229
      TabOrder = 3
    end
  end
  inherited mmMenu: TMainMenu
    Left = 16
    Top = 304
  end
  inherited actList: TActionList
    Left = 48
    Top = 304
    object ActNewNB: TAction
      OnExecute = ActNewNBExecute
    end
    object ActEditNB: TAction
      Caption = #20445#23384
      OnExecute = ActEditNBExecute
    end
    object ActSaveNB: TAction
      OnExecute = ActSaveNBExecute
    end
    object ActDeleteNB: TAction
      Caption = #21024#38500
      OnExecute = ActDeleteNBExecute
    end
  end
  object DsNewsPaper: TDataSource
    DataSet = CdsNoteBook
    Left = 82
    Top = 240
  end
  object CdsNoteBook: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 50
    Top = 240
  end
  object Pm_NB_Group: TPopupMenu
    Left = 16
    Top = 328
    object Edit_Group: TMenuItem
      Caption = #20998#31867#32500#25252
      OnClick = Edit_GroupClick
    end
  end
  object NoteBookType: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 10
    Top = 392
  end
  object Pm_NoteBook: TPopupMenu
    OnPopup = Pm_NoteBookPopup
    Left = 104
    Top = 328
    object NewNote: TMenuItem
      Caption = #28155#21152
      OnClick = NewNoteClick
    end
    object DelNote: TMenuItem
      Caption = #21024#38500
      OnClick = DelNoteClick
    end
  end
  object CdsNoteBookInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 106
    Top = 392
  end
end
