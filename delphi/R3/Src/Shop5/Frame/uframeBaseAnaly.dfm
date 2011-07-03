inherited frameBaseAnaly: TframeBaseAnaly
  Left = 192
  Top = 106
  Width = 798
  Height = 568
  Caption = #20998#26512#22522#31867
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 790
    Height = 504
    inherited RzPanel2: TRzPanel
      Width = 780
      Height = 494
      inherited RzPage: TRzPageControl
        Width = 774
        Height = 488
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #20998#26512#22270#31034
          inherited RzPanel3: TRzPanel
            Width = 772
            Height = 461
            BorderColor = clWhite
            object Panel4: TPanel
              Left = 5
              Top = 5
              Width = 762
              Height = 451
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object w1: TRzPanel
                Left = 0
                Top = 0
                Width = 762
                Height = 81
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                Color = clWhite
                TabOrder = 0
              end
              object RzPanel7: TRzPanel
                Left = 0
                Top = 81
                Width = 762
                Height = 370
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 790
    inherited Image1: TImage
      Left = 350
      Width = 420
    end
    inherited Image3: TImage
      Left = 350
      Width = 420
    end
    inherited Image14: TImage
      Left = 770
    end
    inherited rzPanel5: TPanel
      Left = 350
    end
    inherited CoolBar1: TCoolBar
      Width = 330
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 330
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 330
        ButtonWidth = 43
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actFind
        end
        object ToolButton2: TToolButton
          Left = 43
          Top = 0
          Action = actPrior
        end
        object ToolButton6: TToolButton
          Left = 86
          Top = 0
          Caption = #26174#31034#21015
          ImageIndex = 30
          Visible = False
        end
        object ToolButton5: TToolButton
          Left = 129
          Top = 0
          Width = 8
          Caption = 'ToolButton5'
          ImageIndex = 14
          Style = tbsSeparator
        end
        object ToolButton3: TToolButton
          Left = 137
          Top = 0
          Action = actExport
          Style = tbsDropDown
        end
        object ToolButton9: TToolButton
          Left = 193
          Top = 0
          Action = actPrint
        end
        object ToolButton10: TToolButton
          Left = 236
          Top = 0
          Action = actPreview
        end
        object ToolButton8: TToolButton
          Left = 279
          Top = 0
          Width = 8
          Caption = 'ToolButton8'
          ImageIndex = 16
          Style = tbsSeparator
        end
        object ToolButton4: TToolButton
          Left = 287
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 120
    Top = 80
  end
  inherited actList: TActionList
    Left = 152
    Top = 80
    object actFilter: TAction
      Caption = #26597#25214
      ImageIndex = 43
      OnExecute = actFilterExecute
    end
    object actExport: TAction
      Caption = #23548#20986
      ImageIndex = 4
    end
    object actPrior: TAction
      Caption = #36820#22238
      ImageIndex = 49
      OnExecute = actPriorExecute
    end
    object actFindNext: TAction
      Caption = #26597#25214#19979#19968#20010
    end
  end
  object dsadoReport1: TDataSource
    DataSet = adoReport1
    Left = 169
    Top = 330
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Excel '#25991#20214'|*.xls'
    Left = 341
    Top = 212
  end
  object adoReport1: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 168
    Top = 300
  end
end
