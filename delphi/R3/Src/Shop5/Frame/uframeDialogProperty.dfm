inherited frameDialogProperty: TframeDialogProperty
  Left = 360
  Top = 257
  Width = 468
  Height = 355
  ActiveControl = DBGridEh1
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = #39068#33394'/'#23610#30721
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 452
    Height = 317
    inherited RzPage: TRzPageControl
      Width = 442
      Height = 261
      TabIndex = -1
      TabStop = False
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        TabVisible = False
        Caption = #39068#33394'/'#23610#30721
        inherited RzPanel2: TRzPanel
          Width = 438
          Height = 257
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 428
            Height = 226
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            DataSource = DataSource1
            Flat = True
            FooterColor = cl3DLight
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu1
            RowHeight = 15
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            OnGetCellParams = DBGridEh1GetCellParams
            OnGetFooterParams = DBGridEh1GetFooterParams
            OnKeyPress = DBGridEh1KeyPress
            Columns = <
              item
                Alignment = taCenter
                EditButtons = <>
                FieldName = 'CODE_NAME'
                Footer.Alignment = taCenter
                Footer.Value = #21512#35745
                Footer.ValueType = fvtStaticText
                Footers = <>
                ReadOnly = True
                Title.Caption = #39068#33394
                Width = 47
              end>
          end
          object stbHint: TPanel
            Left = 5
            Top = 231
            Width = 428
            Height = 21
            Align = alBottom
            BevelOuter = bvNone
            Caption = #24403#21069#24211#23384#37327':0'
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 266
      Width = 442
      Height = 46
      object Shape2: TShape
        Left = 17
        Top = 26
        Width = 9
        Height = 13
        Brush.Color = 8947967
      end
      object Shape1: TShape
        Left = 17
        Top = 8
        Width = 9
        Height = 13
        Brush.Color = clMoneyGreen
      end
      object Label1: TLabel
        Left = 30
        Top = 8
        Width = 60
        Height = 12
        Caption = #26377#24211#23384#21830#21697
        Transparent = True
      end
      object Label2: TLabel
        Left = 30
        Top = 27
        Width = 60
        Height = 12
        Caption = #36127#24211#23384#21830#21697
        Transparent = True
      end
      object RzBitBtn2: TRzBitBtn
        Left = 343
        Top = 13
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = RzBitBtn2Click
        NumGlyphs = 2
        Spacing = 5
      end
      object btnOk: TRzBitBtn
        Left = 263
        Top = 13
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&O)'
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
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 205
    Top = 144
  end
  inherited actList: TActionList
    object actAddColor: TAction
      Caption = #28155#21152#39068#33394
    end
    object actAddSize: TAction
      Caption = #28155#21152#23610#30721
    end
  end
  object edtTable: TADODataSet
    OnCalcFields = edtTableCalcFields
    Parameters = <>
    Left = 118
    Top = 109
    object edtTableCODE_NAME: TStringField
      FieldName = 'CODE_NAME'
      Size = 30
    end
    object edtTableCODE_ID: TStringField
      FieldName = 'CODE_ID'
    end
    object edtTableSEQ_NO: TIntegerField
      FieldName = 'SEQ_NO'
    end
  end
  object DataSource1: TDataSource
    DataSet = edtTable
    Left = 158
    Top = 109
  end
  object cdsStorage: TADODataSet
    Parameters = <>
    Left = 198
    Top = 109
  end
  object PopupMenu1: TPopupMenu
    Left = 78
    Top = 54
    object N1: TMenuItem
      Action = actAddColor
    end
    object N2: TMenuItem
      Action = actAddSize
    end
  end
  object PubProperty: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 237
    Top = 107
  end
end
