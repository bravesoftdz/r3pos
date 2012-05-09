inherited frameContractToolForm: TframeContractToolForm
  Left = 447
  Top = 198
  Width = 876
  Height = 489
  Caption = 'frameContractToolForm'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 868
    Height = 425
    inherited RzPanel2: TRzPanel
      Width = 858
      Height = 415
      inherited RzPage: TRzPageControl
        Width = 852
        Height = 409
        UseColoredTabs = True
        OnChange = RzPageChange
        OnDblClick = RzPageDblClick
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clWhite
          Caption = #21512#21516#26597#35810#21015#34920
          inherited RzPanel3: TRzPanel
            Width = 850
            Height = 382
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 840
              Height = 73
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
            end
            object DBGridEh1: TDBGridEh
              Left = 5
              Top = 78
              Width = 840
              Height = 299
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              Color = clWhite
              DataSource = dsList
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              ReadOnly = True
              RowHeight = 20
              TabOrder = 1
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
              OnDrawColumnCell = DBGridEh1DrawColumnCell
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 868
    inherited Image3: TImage
      Left = 536
      Width = 292
    end
    inherited Image14: TImage
      Left = 848
    end
    inherited Image1: TImage
      Left = 828
    end
    inherited rzPanel5: TPanel
      Left = 536
    end
    inherited CoolBar1: TCoolBar
      Width = 516
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 516
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 516
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
        object ToolButton3: TToolButton
          Left = 86
          Top = 0
          Action = actNext
        end
        object ToolButton4: TToolButton
          Left = 129
          Top = 0
          Width = 10
          Caption = 'ToolButton4'
          ImageIndex = 9
          Style = tbsDivider
        end
        object ToolButton5: TToolButton
          Left = 139
          Top = 0
          Action = actNew
        end
        object ToolButton6: TToolButton
          Left = 182
          Top = 0
          Action = actEdit
        end
        object ToolButton7: TToolButton
          Left = 225
          Top = 0
          Action = actDelete
        end
        object ToolButton8: TToolButton
          Left = 268
          Top = 0
          Width = 10
          Caption = 'ToolButton8'
          ImageIndex = 3
          Style = tbsDivider
        end
        object ToolButton9: TToolButton
          Left = 278
          Top = 0
          Action = actSave
        end
        object ToolButton10: TToolButton
          Left = 321
          Top = 0
          Action = actCancel
        end
        object ToolButton11: TToolButton
          Left = 364
          Top = 0
          Width = 10
          Caption = 'ToolButton11'
          ImageIndex = 16
          Style = tbsDivider
        end
        object ToolButton12: TToolButton
          Left = 374
          Top = 0
          Action = actAudit
        end
        object ToolButton13: TToolButton
          Left = 417
          Top = 0
          Action = actPrint
        end
        object ToolButton14: TToolButton
          Left = 460
          Top = 0
          Action = actPreview
          DropdownMenu = ppmReport
          Style = tbsDropDown
        end
      end
    end
  end
  inherited actList: TActionList
    inherited actNew: TAction
      OnExecute = actNewExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
    inherited actEdit: TAction
      Caption = #20462#25913
      OnExecute = actEditExecute
    end
    inherited actSave: TAction
      OnExecute = actSaveExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
    inherited actPrint: TAction
      OnExecute = actPrintExecute
    end
    inherited actPreview: TAction
      OnExecute = actPreviewExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    inherited actAudit: TAction
      OnExecute = actAuditExecute
    end
    object actPrior: TAction
      Caption = #19978#19968#21333
      ImageIndex = 11
      OnExecute = actPriorExecute
    end
    object actNext: TAction
      Caption = #19979#19968#21333
      ImageIndex = 8
      OnExecute = actNextExecute
    end
  end
  object ppmReport: TPopupMenu
    OnPopup = ppmReportPopup
    Left = 622
    Top = 71
    object mnmFormer0: TMenuItem
      OnClick = mnmFormer5Click
    end
    object mnmFormer1: TMenuItem
      Tag = 1
      OnClick = mnmFormer5Click
    end
    object mnmFormer2: TMenuItem
      Tag = 2
      OnClick = mnmFormer5Click
    end
    object mnmFormer3: TMenuItem
      Tag = 3
      OnClick = mnmFormer5Click
    end
    object mnmFormer4: TMenuItem
      Tag = 4
      OnClick = mnmFormer5Click
    end
    object mnmFormer5: TMenuItem
      Tag = 5
      OnClick = mnmFormer5Click
    end
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 305
    Top = 230
  end
  object cdsList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 337
    Top = 230
  end
end
