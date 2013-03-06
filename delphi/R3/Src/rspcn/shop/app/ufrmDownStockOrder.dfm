inherited frmDownStockOrder: TfrmDownStockOrder
  Left = 163
  Top = 118
  Caption = #21367#28895#20837#24211
  ClientHeight = 570
  ClientWidth = 1015
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 1015
    Height = 570
    inherited webForm: TRzPanel
      Width = 1015
      Height = 570
      inherited bkgImage: TImage
        Width = 1015
        Height = 570
      end
      object RzPanel1: TRzPanel
        Left = 201
        Top = 96
        Width = 634
        Height = 361
        BorderOuter = fsFlatRounded
        TabOrder = 0
        object RzPanel2: TRzPanel
          Left = 2
          Top = 2
          Width = 630
          Height = 41
          Align = alTop
          BorderOuter = fsFlat
          BorderSides = [sdBottom]
          TabOrder = 0
          object RzLabel1: TRzLabel
            Left = 15
            Top = 13
            Width = 114
            Height = 15
            Caption = #24403#21069#26377'   '#24352#35746#21333
          end
          object RzLabel2: TRzLabel
            Left = 63
            Top = 12
            Width = 20
            Height = 15
            Alignment = taCenter
            AutoSize = False
            Caption = '1'
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -15
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object RzPanel3: TRzPanel
          Left = 2
          Top = 318
          Width = 630
          Height = 41
          Align = alBottom
          BorderOuter = fsFlat
          BorderSides = [sdTop]
          TabOrder = 1
          DesignSize = (
            630
            41)
          object btnOK: TRzBitBtn
            Left = 535
            Top = 8
            Width = 70
            Height = 28
            Anchors = [akTop]
            Caption = #21367#28895#20837#24211
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
            OnClick = btnOKClick
            NumGlyphs = 2
            Spacing = 5
          end
        end
        object RzPanel4: TRzPanel
          Left = 2
          Top = 43
          Width = 630
          Height = 275
          Align = alClient
          BorderOuter = fsNone
          TabOrder = 2
          object DBGridEh1: TDBGridEh
            Left = 0
            Top = 0
            Width = 630
            Height = 275
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            AutoFitColWidths = True
            DataSource = OrderDataSource
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clBlack
            FooterFont.Height = -15
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 2
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
            PopupMenu = PopupMenu1
            RowHeight = 20
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -15
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            TitleHeight = 20
            UseMultiTitle = True
            IsDrawNullRow = False
            CurrencySymbol = #65509
            DecimalNumber = 2
            DigitalNumber = 12
            OnDrawColumnCell = DBGridEh1DrawColumnCell
            OnTitleClick = DBGridEh1TitleClick
            Columns = <
              item
                Checkboxes = True
                Color = clBtnFace
                EditButtons = <>
                FieldName = 'SELFLAG'
                Footers = <>
                KeyList.Strings = (
                  '1'
                  '0')
                PickList.Strings = (
                  '0'
                  '1')
                Tag = -1
                Title.Caption = #36873#25321
                Width = 35
              end
              item
                Color = clBtnFace
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                ReadOnly = True
                Title.Caption = #24207#21495
                Width = 35
              end
              item
                EditButtons = <>
                FieldName = 'ARR_DATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #36865#36798#26085#26399
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'INDE_DATE'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35746#36135#26085#26399
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_NAME'
                Footers = <>
                ReadOnly = True
                Title.Caption = #20379#24212#21830
                Width = 180
              end
              item
                EditButtons = <>
                FieldName = 'INDE_AMT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35746#36135#25968#37327
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'INDE_MNY'
                Footers = <>
                ReadOnly = True
                Title.Caption = #35746#36135#37329#39069
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'NEED_AMT'
                Footers = <>
                ReadOnly = True
                Title.Caption = #38656#27714#25968#37327
                Width = 70
              end>
          end
        end
      end
    end
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 258
    Top = 422
  end
  object OrderDataSource: TDataSource
    DataSet = cdsTable
    Left = 323
    Top = 424
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 417
    Top = 258
    object N1: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#36873
      ImageIndex = 46
      ShortCut = 16449
      OnClick = N1Click
    end
    object N2: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#21453#36873
      ShortCut = 16450
      OnClick = N2Click
    end
    object N3: TMenuItem
      AutoHotkeys = maManual
      Caption = #20840#19981#36873
      ShortCut = 16452
      OnClick = N3Click
    end
  end
end
