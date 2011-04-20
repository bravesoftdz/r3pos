inherited frameOrderToolForm: TframeOrderToolForm
  Left = 131
  Top = 51
  Width = 862
  Height = 522
  Caption = 'frameOrderToolForm'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 846
    Height = 448
    inherited RzPanel2: TRzPanel
      Width = 836
      Height = 438
      inherited RzPage: TRzPageControl
        Width = 830
        Height = 432
        Color = clWindow
        FlatColor = clBtnFace
        ParentColor = False
        ShowShadow = False
        TabColors.Shadow = 14588523
        TextColors.DisabledShadow = clNavy
        TextColors.Selected = clNavy
        OnChange = RzPageChange
        OnDblClick = RzPageDblClick
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clWindow
          Caption = #21333#25454#26597#35810#21015#34920
          inherited RzPanel3: TRzPanel
            Width = 828
            Height = 405
            BorderShadow = clWindow
            Color = clWindow
            FlatColor = clWindow
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 818
              Height = 73
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
            end
            object DBGridEh1: TDBGridEh
              Left = 5
              Top = 78
              Width = 818
              Height = 322
              Align = alClient
              AllowedOperations = []
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
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
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
    Width = 846
    inherited Image1: TImage
      Left = 542
      Width = 284
    end
    inherited Image3: TImage
      Left = 542
      Width = 284
    end
    inherited Image14: TImage
      Left = 826
    end
    inherited rzPanel5: TPanel
      Left = 542
    end
    inherited CoolBar1: TCoolBar
      Width = 522
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 522
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 522
        ButtonWidth = 43
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actFind
        end
        object ToolButton14: TToolButton
          Left = 43
          Top = 0
          Action = actPrior
        end
        object ToolButton15: TToolButton
          Left = 86
          Top = 0
          Action = actNext
        end
        object ToolButton10: TToolButton
          Left = 129
          Top = 0
          Width = 10
          ImageIndex = 10
          Style = tbsDivider
        end
        object ToolButton2: TToolButton
          Left = 139
          Top = 0
          Action = actNew
        end
        object ToolButton13: TToolButton
          Left = 182
          Top = 0
          Action = actEdit
        end
        object ToolButton3: TToolButton
          Left = 225
          Top = 0
          Action = actDelete
        end
        object ToolButton4: TToolButton
          Left = 268
          Top = 0
          Width = 12
          Caption = '`'
          ImageIndex = 3
          Style = tbsDivider
        end
        object ToolButton5: TToolButton
          Left = 280
          Top = 0
          Action = actSave
        end
        object ToolButton6: TToolButton
          Left = 323
          Top = 0
          Action = actCancel
        end
        object ToolButton7: TToolButton
          Left = 366
          Top = 0
          Width = 10
          Caption = 'ToolButton7'
          ImageIndex = 15
          Style = tbsDivider
        end
        object ToolButton12: TToolButton
          Left = 376
          Top = 0
          Action = actAudit
        end
        object ToolButton8: TToolButton
          Left = 419
          Top = 0
          Action = actPrint
        end
        object ToolButton9: TToolButton
          Left = 462
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
  object dsList: TDataSource
    DataSet = cdsList
    Left = 382
    Top = 192
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
  object cdsList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 350
    Top = 192
  end
end
