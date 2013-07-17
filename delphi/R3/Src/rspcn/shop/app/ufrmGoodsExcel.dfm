inherited frmGoodsExcel: TfrmGoodsExcel
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    inherited RzPanel2: TRzPanel
      inherited RzPanel3: TRzPanel
        inherited rzPage: TRzPageControl
          FixedDimension = 0
          inherited TabSheet1: TRzTabSheet
            inherited RzPanel12: TRzPanel
              inherited RzLabel17: TRzLabel
                OnClick = RzLabel17Click
              end
              inherited chkHeader: TcxCheckBox
                Properties.Caption = #21551#29992#26631#39064#34892
              end
              inherited RzPanel70: TRzPanel
                inherited RzPanel71: TRzPanel
                  inherited RzLabel41: TRzLabel
                    Width = 31
                    Height = 16
                  end
                end
              end
            end
          end
          inherited TabSheet3: TRzTabSheet
            inherited RzPanel9: TRzPanel
              inherited DBGridEh2: TDBGridEh
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ID'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'FileTitle'
                    Footers = <>
                    Title.Caption = #25991#20214#23383#27573
                    Width = 195
                  end
                  item
                    EditButtons = <>
                    FieldName = 'DestTitle'
                    Footers = <>
                    Title.Caption = #30446#26631#23383#27573
                    Width = 204
                    Control = cdsDropColumn
                    OnBeforeShowControl = DBGridEh2Columns2BeforeShowControl
                  end>
              end
            end
          end
          inherited TabSheet6: TRzTabSheet
            inherited RzPanel6: TRzPanel
              inherited RzLabel10: TRzLabel
                Top = 17
              end
              inherited RzLabel12: TRzLabel
                Top = 48
              end
            end
          end
        end
      end
      inherited RzPanel4: TRzPanel
        inherited chkignore: TcxCheckBox
          Properties.Caption = #26159#21542#24573#30053#38169#35823#25968#25454
        end
      end
    end
  end
end
