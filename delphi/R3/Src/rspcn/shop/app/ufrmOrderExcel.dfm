inherited frmOrderExcel: TfrmOrderExcel
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
                    FieldName = 'DestTitle'
                    Footers = <>
                    Title.Caption = #30446#26631#23383#27573
                    Width = 204
                  end
                  item
                    EditButtons = <>
                    FieldName = 'FileTitle'
                    Footers = <>
                    Title.Caption = #25991#20214#23383#27573
                    Width = 195
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
        inherited btnExport: TRzBmpButton [2]
          Left = 20
        end
        object chkPrice: TcxCheckBox [3]
          Left = 114
          Top = 13
          Width = 205
          Height = 23
          Anchors = [akTop, akRight]
          Properties.DisplayUnchecked = 'False'
          Properties.Caption = #26159#21542#24573#30053#19981#19968#33268#21830#21697#21333#20215
          TabOrder = 4
          Visible = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnClick = chkPriceClick
        end
        inherited chkignore: TcxCheckBox [4]
          Left = 114
          Top = 12
          Properties.Caption = #26159#21542#24573#30053#38169#35823#25968#25454
        end
      end
    end
  end
end
