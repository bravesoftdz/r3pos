inherited frmPriceOrderList: TfrmPriceOrderList
  Left = 199
  Top = 105
  Width = 841
  Height = 581
  Caption = #20419#38144#21333
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 833
    Height = 524
    inherited RzPanel2: TRzPanel
      Width = 823
      Height = 514
      inherited RzPage: TRzPageControl
        Width = 817
        Height = 508
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #20419#38144#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 815
            Height = 481
            object Splitter1: TSplitter [0]
              Left = 5
              Top = 252
              Width = 805
              Height = 6
              Cursor = crVSplit
              Align = alBottom
              Color = clBtnFace
              ParentColor = False
            end
            inherited RzPanel1: TRzPanel
              Width = 805
              Height = 68
              object RzLabel2: TRzLabel
                Left = 33
                Top = 13
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20419#38144#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 13
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 37
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #20419#38144#21333#21495
              end
              object Label1: TLabel
                Left = 201
                Top = 38
                Width = 120
                Height = 12
                Caption = #25903#25345#27169#22359','#36755#21518'4'#20301#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 9
                Width = 104
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 9
                Width = 109
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndPROM_ID: TcxTextEdit
                Left = 89
                Top = 33
                Width = 104
                Height = 20
                TabOrder = 2
              end
              object btnOk: TRzBitBtn
                Left = 552
                Top = 16
                Width = 67
                Height = 26
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
                TabOrder = 3
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSTATUS: TcxRadioGroup
                Left = 334
                Top = 4
                Width = 209
                Height = 47
                ItemIndex = 0
                Properties.Columns = 3
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end>
                TabOrder = 4
                Caption = #29366#24577
              end
            end
            inherited DBGridEh1: TDBGridEh
              Top = 73
              Width = 805
              Height = 179
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OnCellClick = DBGridEh1CellClick
              OnDblClick = DBGridEh1DblClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #21333#21495
                  Width = 113
                end
                item
                  EditButtons = <>
                  FieldName = 'BEGIN_DATE'
                  Footers = <>
                  Title.Caption = #20419#38144#26102#38388
                  Width = 148
                end
                item
                  EditButtons = <>
                  FieldName = 'END_DATE'
                  Footers = <>
                  Title.Caption = #32467#26463#26102#38388
                  Width = 144
                end
                item
                  EditButtons = <>
                  FieldName = 'PRICE_TYPE'
                  Footers = <>
                  Title.Caption = #20419#38144#26041#24335
                  Width = 104
                end
                item
                  EditButtons = <>
                  FieldName = 'AIM_FLAG'
                  Footers = <>
                  Title.Caption = #23458#25143#32676
                  Width = 98
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 163
                end>
            end
            object DBGridEh2: TDBGridEh
              Left = 5
              Top = 258
              Width = 805
              Height = 218
              Align = alBottom
              AllowedOperations = [alopUpdateEh]
              DataSource = DataSource1
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 1
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
              RowHeight = 17
              SumList.Active = True
              TabOrder = 2
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
              OnDrawColumnCell = DBGridEh2DrawColumnCell
              OnDrawFooterCell = DBGridEh2DrawFooterCell
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 31
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_NAME'
                  Footers = <>
                  Title.Caption = #21830#21697#21517#31216
                  Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721'" '#26597#35810
                  Width = 206
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_CODE'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #36135#21495
                  Width = 73
                end
                item
                  EditButtons = <>
                  FieldName = 'NEW_OUTPRICE'
                  Footers = <>
                  Title.Caption = #24403#21069#21806#20215
                  Width = 59
                end
                item
                  EditButtons = <>
                  FieldName = 'OUT_PRICE'
                  Footers = <>
                  Title.Caption = #35745#37327#21333#20301'|'#21806#20215
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'CALC_UNITS'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #35745#37327#21333#20301'|'#21333#20301
                  Width = 31
                end
                item
                  EditButtons = <>
                  FieldName = 'OUT_PRICE1'
                  Footers = <>
                  Title.Caption = #21253#35013'1|'#21806#20215
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'SMALL_UNITS'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #21253#35013'1|'#21333#20301
                  Width = 29
                end
                item
                  EditButtons = <>
                  FieldName = 'OUT_PRICE2'
                  Footers = <>
                  Title.Caption = #21253#35013'2|'#21806#20215
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'BIG_UNITS'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #21253#35013'2|'#21333#20301
                  Width = 32
                end
                item
                  Checkboxes = False
                  EditButtons = <>
                  FieldName = 'RATE_OFF'
                  Footers = <>
                  Title.Caption = #20250#21592'|'#20419#38144
                  Width = 56
                end
                item
                  DisplayFormat = '#0.00%'
                  EditButtons = <>
                  FieldName = 'AGIO_RATE'
                  Footers = <>
                  Title.Caption = #20250#21592'|'#20877#25240#29575
                  Width = 62
                end
                item
                  Alignment = taCenter
                  ButtonStyle = cbsEllipsis
                  Checkboxes = True
                  EditButtons = <>
                  FieldName = 'ISINTEGRAL'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '0')
                  PickList.Strings = (
                    #26159
                    #21542)
                  Title.Caption = #20250#21592'|'#31215#20998
                  Width = 35
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 833
    inherited Image1: TImage
      Left = 737
      Width = 87
    end
    inherited Image14: TImage
      Left = 824
    end
    inherited Image3: TImage
      Left = 737
      Width = 87
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 36
        Caption = #20419#38144#21333
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 561
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 561
          Width = 30
        end>
      inherited ToolBar1: TToolBar
        Width = 561
        object ToolButton11: TToolButton
          Left = 518
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 208
    Top = 144
  end
  inherited actList: TActionList
    inherited actPrint: TAction
      Visible = False
    end
    inherited actPreview: TAction
      Visible = False
    end
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object DataSource1: TDataSource
    DataSet = cdsDetail
    Left = 377
    Top = 338
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 225
    Top = 202
  end
  object cdsDetail: TZQuery
    FieldDefs = <>
    AfterScroll = cdsListAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 342
    Top = 336
  end
end
