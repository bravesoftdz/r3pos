inherited frmCustomerExcel: TfrmCustomerExcel
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    inherited RzPanel2: TRzPanel
      inherited RzPanel3: TRzPanel
        inherited rzPage: TRzPageControl
          FixedDimension = 0
          inherited TabSheet1: TRzTabSheet
            inherited RzPanel12: TRzPanel
              inherited chkHeader: TcxCheckBox
                Properties.Caption = #21551#29992#26631#39064#34892
              end
              inherited RzPanel7: TRzPanel
                inherited Image4: TImage
                  OnClick = Image4Click
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
              object RzLabel14: TRzLabel
                Left = 22
                Top = 212
                Width = 397
                Height = 39
                Caption = #27880#24847#20107#39033#65306#13'1'#12289#25991#20214#20013#30340#31354#34892#65292#21024#38500#26102#24517#39035#26159#21024#38500#35813#34892#65292#19981#33021#21482#21024#38500#35813#34892#30340#20869#23481#65307#13'2'#12289#25991#20214#20013#30340#31354#21015#65292#19981#29992#30340#20063#24517#39035#21024#38500#65307
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
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
