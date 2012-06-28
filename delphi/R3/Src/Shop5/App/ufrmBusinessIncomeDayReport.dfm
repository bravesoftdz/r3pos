inherited frmBusinessIncomeDayReport: TfrmBusinessIncomeDayReport
  Left = 528
  Top = 112
  Width = 1003
  Height = 559
  Caption = #33829#19994#25910#20837#26085#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 995
    Height = 495
    inherited RzPanel2: TRzPanel
      Width = 985
      Height = 485
      inherited RzPage: TRzPageControl
        Width = 780
        Height = 479
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          inherited RzPanel3: TRzPanel
            Width = 778
            Height = 452
            inherited Panel4: TPanel
              Width = 768
              Height = 442
              inherited w1: TRzPanel
                Width = 768
                Height = 105
              end
              inherited RzPanel7: TRzPanel
                Top = 105
                Width = 768
                Height = 337
                inherited DBGridEh1: TDBGridEh
                  Width = 764
                  Height = 333
                  Columns = <
                    item
                      EditButtons = <>
                      Footers = <>
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 783
        Height = 479
        inherited Panel2: TPanel
          Height = 447
          inherited Panel5: TPanel
            Height = 332
            inherited rzShowColumns: TRzCheckList
              Height = 328
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 995
    inherited Image3: TImage
      Width = 213
    end
    inherited Image14: TImage
      Left = 975
    end
    inherited Image1: TImage
      Left = 563
    end
  end
  inherited actList: TActionList
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323020255B7768725D5C66315C6673
      3136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C71725C66305C667332305C2762345C2766325C2764335C2761315C2763
      615C2762315C2762635C2765345C6C616E67323035325C66315C66733136200D
      0A5C706172207D0D0A00}
  end
end
