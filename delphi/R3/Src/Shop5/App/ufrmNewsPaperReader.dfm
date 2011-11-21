inherited frmNewPaperReader: TfrmNewPaperReader
  Left = 504
  Top = 140
  BorderStyle = bsDialog
  Caption = #20449#24687#20114#21160
  ClientHeight = 555
  ClientWidth = 789
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 789
    Height = 555
    Align = alClient
    BorderOuter = fsNone
    Color = clWhite
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 0
      Top = 37
      Width = 789
      Height = 488
      Align = alClient
      BorderOuter = fsNone
      BorderSides = [sdLeft]
      BorderColor = clTeal
      Color = 16182753
      TabOrder = 0
      object RzPanel6: TRzPanel
        Left = 156
        Top = 19
        Width = 633
        Height = 469
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
          Width = 623
          Height = 459
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
            object DBGridEh1: TDBGridEh
              Left = 0
              Top = 0
              Width = 623
              Height = 441
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
              OnGetCellParams = DBGridEh1GetCellParams
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'B'
                  Footers = <>
                  Width = 8
                end
                item
                  EditButtons = <>
                  FieldName = 'MSG_TITLE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Width = 395
                end
                item
                  EditButtons = <>
                  FieldName = 'MSG_SOURCE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Width = 120
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'ISSUE_DATE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Width = 80
                end
                item
                  EditButtons = <>
                  FieldName = 'MSG_INFO'
                  Footers = <>
                  Width = 40
                end
                item
                  EditButtons = <>
                  FieldName = 'A'
                  Footers = <>
                  Width = 8
                end>
            end
          end
          object TabContents: TRzTabSheet
            Color = clWhite
            Caption = 'TabContents'
            object RzPanel4: TRzPanel
              Left = 0
              Top = 0
              Width = 623
              Height = 441
              Align = alClient
              BorderOuter = fsNone
              BorderColor = clWhite
              Color = clWhite
              TabOrder = 0
              object RzPanel5: TRzPanel
                Left = 0
                Top = 0
                Width = 623
                Height = 49
                Align = alTop
                BorderOuter = fsNone
                BorderSides = [sdBottom]
                BorderColor = 16765589
                BorderWidth = 1
                Color = clWhite
                TabOrder = 0
                DesignSize = (
                  623
                  49)
                object labTitle: TLabel
                  Left = 1
                  Top = 1
                  Width = 621
                  Height = 47
                  Align = alClient
                  Alignment = taCenter
                  Color = clWhite
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 8146444
                  Font.Height = -24
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentColor = False
                  ParentFont = False
                end
                object btnReturn: TRzBmpButton
                  Left = 539
                  Top = 17
                  Width = 58
                  Height = 17
                  Cursor = crHandPoint
                  GroupIndex = 1
                  Bitmaps.TransparentColor = clOlive
                  Color = clBtnHighlight
                  Anchors = []
                  TabOrder = 0
                  OnClick = btnReturnClick
                end
              end
              object RzPanel11: TRzPanel
                Left = 0
                Top = 396
                Width = 623
                Height = 45
                Align = alBottom
                BorderOuter = fsNone
                BorderSides = [sdTop]
                BorderColor = 16765589
                BorderWidth = 1
                Color = clWhite
                TabOrder = 1
                DesignSize = (
                  623
                  45)
                object btnRead: TRzBmpButton
                  Left = 264
                  Top = 13
                  Width = 69
                  Height = 21
                  Cursor = crHandPoint
                  GroupIndex = 1
                  Bitmaps.TransparentColor = clOlive
                  Color = clBtnHighlight
                  Anchors = []
                  TabOrder = 0
                  OnClick = btnReadClick
                end
              end
              object RzPanel12: TRzPanel
                Left = 0
                Top = 49
                Width = 623
                Height = 347
                Align = alClient
                BevelWidth = 2
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 3
                Color = clWhite
                TabOrder = 2
                object labPublishDate: TLabel
                  Left = 3
                  Top = 332
                  Width = 617
                  Height = 12
                  Align = alBottom
                  Alignment = taRightJustify
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object edtContents: TRichEdit
                  Left = 3
                  Top = 3
                  Width = 617
                  Height = 329
                  Align = alClient
                  BorderStyle = bsNone
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  TabOrder = 0
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
        Height = 469
        Align = alLeft
        BorderOuter = fsNone
        BorderSides = [sdTop, sdRight]
        BorderColor = 16765589
        BorderWidth = 1
        Color = 16182753
        TabOrder = 1
        object btn_Message0: TRzBmpButton
          Left = 1
          Top = 0
          Width = 155
          Height = 31
          GroupIndex = 1
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Caption = #28040#24687
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
      end
      object RzPanel10: TRzPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 19
        Align = alTop
        BorderOuter = fsNone
        BorderSides = []
        BorderColor = 16765589
        BorderWidth = 1
        Color = 16182753
        TabOrder = 2
        DesignSize = (
          789
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
          Width = 622
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
      Width = 789
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
        Width = 787
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
      end
    end
    object RzPanel7: TRzPanel
      Left = 0
      Top = 526
      Width = 789
      Height = 29
      Align = alBottom
      BorderOuter = fsButtonUp
      BorderSides = [sdTop]
      Color = 16767656
      TabOrder = 2
      DesignSize = (
        789
        29)
      object btn_Close: TRzBmpButton
        Left = 685
        Top = 6
        Width = 69
        Height = 21
        Bitmaps.TransparentColor = clOlive
        Color = clBtnHighlight
        Anchors = [akRight, akBottom]
        TabOrder = 0
        OnClick = btn_CloseClick
      end
    end
    object RzPanel8: TRzPanel
      Left = 0
      Top = 525
      Width = 789
      Height = 1
      Align = alBottom
      BorderOuter = fsNone
      Color = 16762229
      TabOrder = 3
    end
  end
  inherited mmMenu: TMainMenu
    Left = 0
    Top = 496
  end
  inherited actList: TActionList
    Left = 32
    Top = 496
  end
  object DsNewsPaper: TDataSource
    DataSet = CdsNewsPaper
    Left = 66
    Top = 496
  end
  object CdsNewsPaper: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 98
    Top = 496
  end
end
