inherited frmInitGoods: TfrmInitGoods
  Left = 126
  Top = 156
  Caption = 'frmInitGoods'
  ClientHeight = 661
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Height = 661
    inherited webForm: TRzPanel
      Height = 661
      inherited bkgImage: TImage
        Height = 661
      end
      object RzPanel1: TRzPanel
        Left = 314
        Top = 185
        Width = 666
        Height = 361
        BorderOuter = fsFlatRounded
        TabOrder = 0
        object RzPanel2: TRzPanel
          Left = 2
          Top = 2
          Width = 662
          Height = 306
          Align = alTop
          BorderOuter = fsNone
          TabOrder = 0
          object rzPage: TRzPageControl
            Left = 0
            Top = 0
            Width = 662
            Height = 306
            ActivePage = TabSheet1
            Align = alClient
            TabIndex = 0
            TabOrder = 0
            FixedDimension = 21
            object TabSheet1: TRzTabSheet
              Caption = #24320#22987#21521#23548
              object lblInput: TLabel
                Left = 137
                Top = 81
                Width = 100
                Height = 23
                Caption = #26465#30721#36755#20837
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -23
                Font.Name = #40657#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object edtInput: TcxTextEdit
                Left = 241
                Top = 77
                Width = 236
                Height = 23
                ParentFont = False
                Style.BorderStyle = ebsThick
                TabOrder = 0
              end
            end
            object TabSheet2: TRzTabSheet
              Caption = #21830#21697#23646#24615
            end
          end
        end
        object RzPanel3: TRzPanel
          Left = 2
          Top = 307
          Width = 662
          Height = 52
          Align = alBottom
          BorderOuter = fsNone
          TabOrder = 1
          object btnNext: TRzBitBtn
            Left = 554
            Top = 14
            Width = 86
            Height = 29
            Caption = #19979#19968#27493
            TabOrder = 0
            OnClick = btnNextClick
            Spacing = 5
          end
          object btnPrev: TRzBitBtn
            Left = 443
            Top = 14
            Width = 87
            Height = 29
            Caption = #19978#19968#27493
            TabOrder = 1
            OnClick = btnPrevClick
            Spacing = 5
          end
        end
      end
    end
  end
  object cdsGoods: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 298
    Top = 434
  end
  object cdsBarcode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 330
    Top = 434
  end
  object cdsRelation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 362
    Top = 434
  end
end
