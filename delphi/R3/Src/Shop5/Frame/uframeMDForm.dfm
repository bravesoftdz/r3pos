inherited frameMDForm: TframeMDForm
  Left = 381
  Caption = #29238#23376#31383#20307#27169#29256
  Menu = nil
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object bgPanel: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 541
    Height = 376
    Align = alClient
    BorderInner = fsFlatRounded
    BorderOuter = fsNone
    BorderWidth = 3
    TabOrder = 0
  end
  inherited actList: TActionList
    object actNew: TAction
      Caption = #26032#22686
      ImageIndex = 0
    end
    object actDelete: TAction
      Caption = #21024#38500
      ImageIndex = 2
    end
    object actEdit: TAction
      Caption = #32534#36753
      ImageIndex = 1
    end
    object actSave: TAction
      Caption = #20445#23384
      ImageIndex = 14
    end
    object actCancel: TAction
      Caption = #21462#28040
      ImageIndex = 14
    end
    object actExit: TAction
      Caption = ' '#36864#20986' '
      ImageIndex = 13
      OnExecute = actExitExecute
    end
    object actPrint: TAction
      Caption = #25171#21360
      ImageIndex = 10
    end
    object actPreview: TAction
      Caption = #39044#35272
      ImageIndex = 9
    end
    object actFind: TAction
      Caption = #26597#35810
      ImageIndex = 12
    end
    object actInfo: TAction
      Caption = #35814#36848
      ImageIndex = 34
    end
    object actAudit: TAction
      Caption = #23457#26680
      ImageIndex = 46
    end
  end
end
