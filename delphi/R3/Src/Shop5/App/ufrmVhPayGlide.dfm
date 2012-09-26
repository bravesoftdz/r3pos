inherited frmVhPayGlide: TfrmVhPayGlide
  Left = 341
  Caption = #31036#21048#32467#31639
  ClientHeight = 307
  ClientWidth = 504
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 504
    Height = 307
    inherited RzPage: TRzPageControl
      Width = 494
      Height = 257
      ActivePage = TabSheet5
      ParentColor = False
      TabIndex = 1
      OnChange = RzPageChange
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Caption = #25195#30721#24405#20837
        inherited RzPanel2: TRzPanel
          Width = 490
          Height = 230
          Color = clWhite
          object RzPanel1: TRzPanel
            Left = 5
            Top = 5
            Width = 480
            Height = 106
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clInactiveCaption
            TabOrder = 0
            object lblInput: TLabel
              Left = 11
              Top = 8
              Width = 63
              Height = 20
              Caption = #38450#20266#30721
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -20
              Font.Name = #40657#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labNO: TLabel
              Left = 82
              Top = 39
              Width = 49
              Height = 14
              Caption = #38450#20266#30721':'
              Font.Charset = GB2312_CHARSET
              Font.Color = clFuchsia
              Font.Height = -14
              Font.Name = #40657#20307
              Font.Style = []
              ParentFont = False
            end
            object labPRC: TLabel
              Left = 67
              Top = 62
              Width = 63
              Height = 14
              Caption = #31036#21048#38754#20540':'
              Font.Charset = GB2312_CHARSET
              Font.Color = clFuchsia
              Font.Height = -14
              Font.Name = #40657#20307
              Font.Style = []
              ParentFont = False
            end
            object edtInput: TcxTextEdit
              Left = 82
              Top = 5
              Width = 391
              Height = 27
              ParentFont = False
              Style.BorderStyle = ebsThick
              Style.Font.Charset = GB2312_CHARSET
              Style.Font.Color = clNavy
              Style.Font.Height = -19
              Style.Font.Name = #40657#20307
              Style.Font.Style = [fsBold]
              TabOrder = 0
              OnKeyPress = edtInputKeyPress
            end
          end
          object RzPanel3: TRzPanel
            Left = 5
            Top = 111
            Width = 480
            Height = 114
            Align = alBottom
            BorderOuter = fsNone
            BorderShadow = clMenu
            TabOrder = 1
            object RzPageControl1: TRzPageControl
              Left = 0
              Top = 0
              Width = 480
              Height = 114
              ActivePage = TabSheet2
              Align = alClient
              ParentShowHint = False
              ShowHint = False
              TabIndex = 0
              TabOrder = 0
              FixedDimension = 18
              object TabSheet2: TRzTabSheet
                Caption = #35814#32454#20449#24687
                object labMNY: TLabel
                  Left = 30
                  Top = 67
                  Width = 75
                  Height = 20
                  Caption = #32467'  '#20313':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object labAMOUNT: TLabel
                  Left = 244
                  Top = 67
                  Width = 75
                  Height = 20
                  Caption = #24352'  '#25968':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object LabPayMny: TLabel
                  Left = 30
                  Top = 23
                  Width = 75
                  Height = 20
                  Caption = #24635'  '#35745':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object LabRecvMny: TLabel
                  Left = 244
                  Top = 23
                  Width = 75
                  Height = 20
                  Caption = #24050'  '#20184':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
              end
              object TabSheet3: TRzTabSheet
                Caption = #35814#32454#20449#24687
                object labClientId: TLabel
                  Left = 30
                  Top = 10
                  Width = 75
                  Height = 20
                  Caption = #23458'  '#25143':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object LabGlideNo: TLabel
                  Left = 31
                  Top = 42
                  Width = 74
                  Height = 20
                  Caption = #35746#21333#21495':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object LabAmount1: TLabel
                  Left = 274
                  Top = 76
                  Width = 75
                  Height = 20
                  Caption = #24352'  '#25968':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object LabSumMny: TLabel
                  Left = 30
                  Top = 76
                  Width = 75
                  Height = 20
                  Caption = #24635'  '#35745':'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -20
                  Font.Name = #40657#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
              end
            end
          end
        end
      end
      object TabSheet5: TRzTabSheet
        Caption = #31036#21048#21015#34920
        object RzPanel4: TRzPanel
          Left = 0
          Top = 0
          Width = 490
          Height = 230
          Align = alClient
          BorderOuter = fsNone
          BorderWidth = 5
          TabOrder = 0
          object DBGridEh1: TDBGridEh
            Left = 5
            Top = 5
            Width = 480
            Height = 220
            Align = alClient
            AllowedOperations = []
            DataSource = DsVhpay
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
            ReadOnly = True
            RowHeight = 20
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
                FieldName = 'CREA_DATE'
                Footers = <>
                Title.Caption = #25903#20184#26102#38388
                Width = 114
              end
              item
                EditButtons = <>
                FieldName = 'BARCODE'
                Footers = <>
                Title.Caption = #38450#20266#30721
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'VOUCHER_TYPE'
                Footers = <>
                Title.Caption = #31036#21048#31867#22411
                Width = 57
              end
              item
                EditButtons = <>
                FieldName = 'VOUCHER_PRC'
                Footers = <>
                Title.Caption = #38754#20540
                Width = 50
              end
              item
                EditButtons = <>
                FieldName = 'REMARK'
                Footers = <>
                Title.Caption = #22791#27880
                Width = 74
              end>
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 262
      Width = 494
      object Btn_Update: TRzBitBtn
        Left = 337
        Top = 10
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #25764#28040'(&D)'
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
        OnClick = Btn_UpdateClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Close: TRzBitBtn
        Left = 422
        Top = 10
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
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Save: TRzBitBtn
        Left = 338
        Top = 10
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #30830#23450'(&S)'
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
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 16
    Top = 240
  end
  inherited actList: TActionList
    Left = 46
    Top = 240
  end
  object CdsVhPay: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 76
    Top = 240
  end
  object CdsVhpayGlide: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 135
    Top = 240
  end
  object DsVhpay: TDataSource
    DataSet = CdsVhpayGlide
    Left = 167
    Top = 240
  end
end
