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
    Height = 518
    inherited RzPanel2: TRzPanel
      Width = 823
      Height = 508
      inherited RzPage: TRzPageControl
        Width = 817
        Height = 502
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #20419#38144#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 815
            Height = 475
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
              Height = 397
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
                  FieldName = 'PRICE_ID'
                  Footers = <>
                  Title.Caption = #20419#38144#33539#22260
                  Width = 111
                end
                item
                  EditButtons = <>
                  FieldName = 'GoodSum'
                  Footers = <>
                  Title.Caption = #20419#38144#21830#21697#25968
                  Width = 71
                end
                item
                  EditButtons = <>
                  FieldName = 'ShopSum'
                  Footers = <>
                  Title.Caption = #20419#38144#38376#24215#25968
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 163
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
      Left = 581
      Width = 232
    end
    inherited Image3: TImage
      Left = 581
      Width = 232
    end
    inherited Image14: TImage
      Left = 813
    end
    inherited rzPanel5: TPanel
      Left = 581
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
          Width = 48
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
end
