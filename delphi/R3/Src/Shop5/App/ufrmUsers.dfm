inherited frmUsers: TfrmUsers
  Left = 416
  Top = 187
  Width = 744
  Height = 484
  Caption = #29992#25143#26723#26696#31649#29702
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 736
    Height = 420
    inherited RzPanel2: TRzPanel
      Width = 726
      Height = 410
      inherited RzPage: TRzPageControl
        Width = 720
        Height = 404
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #29992#25143#26723#26696#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 718
            Height = 377
            object RzPanel1: TRzPanel
              Left = 5
              Top = 41
              Width = 708
              Height = 331
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object DBGridEh1: TDBGridEh
                Left = 5
                Top = 5
                Width = 698
                Height = 302
                Align = alClient
                DataSource = Ds_Users
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                FrozenCols = 1
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
                PopupMenu = PopupMenu1
                ReadOnly = True
                RowHeight = 20
                TabOrder = 0
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
                OnDblClick = actEditExecute
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnGetCellParams = DBGridEh1GetCellParams
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SEQ_NO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 30
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'ACCOUNT'
                    Footers = <>
                    Title.Caption = #29992#25143#36134#21495
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #29992#25143#22995#21517
                  end
                  item
                    EditButtons = <>
                    FieldName = 'COMP_NAME'
                    Footers = <>
                    Title.Caption = #25152#22312#38376#24215
                    Width = 94
                  end
                  item
                    EditButtons = <>
                    FieldName = 'DUTY_IDS'
                    Footers = <>
                    Title.Caption = #32844#21153
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SEX'
                    Footers = <>
                    KeyList.Strings = (
                      '0'
                      '1'
                      '2')
                    PickList.Strings = (
                      #22899
                      #30007
                      #20445#23494)
                    Title.Caption = #24615#21035
                    Width = 40
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'MOBILE'
                    Footers = <>
                    Title.Caption = #31227#21160#30005#35805
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'OFFI_TELE'
                    Footers = <>
                    Title.Caption = #21150#20844#30005#35805
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'FAMI_TELE'
                    Footers = <>
                    Title.Caption = #23478#24237#30005#35805
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'EMAIL'
                    Footers = <>
                    Title.Caption = #30005#23376#37038#31665
                    Width = 130
                  end>
              end
              object stbPanel: TPanel
                Left = 5
                Top = 307
                Width = 698
                Height = 19
                Align = alBottom
                BevelOuter = bvNone
                Color = clWhite
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object Label2: TLabel
                  Left = 4
                  Top = 8
                  Width = 7
                  Height = 12
                end
              end
            end
            object RzPanel6: TRzPanel
              Left = 5
              Top = 5
              Width = 708
              Height = 36
              Align = alTop
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 1
              DesignSize = (
                708
                36)
              object Panel1: TPanel
                Left = 0
                Top = 0
                Width = 113
                Height = 30
                Alignment = taRightJustify
                BevelInner = bvLowered
                Caption = '  '#26597#35810#20851#20581#23383
                Color = 12698049
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object Panel2: TPanel
                Left = 111
                Top = 0
                Width = 607
                Height = 30
                Alignment = taLeftJustify
                Anchors = [akLeft, akTop, akRight, akBottom]
                BevelInner = bvLowered
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentColor = True
                ParentFont = False
                TabOrder = 1
                object Label1: TLabel
                  Left = 299
                  Top = 10
                  Width = 247
                  Height = 12
                  Caption = #25903#25345#65288#29992#25143#22995#21517#12289#25340#38899#30721#12289#29992#25143#36134#21495#65289#26597#35810
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clNavy
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object edtKey: TcxTextEdit
                  Left = 8
                  Top = 5
                  Width = 196
                  Height = 20
                  Properties.OnChange = edtKeyPropertiesChange
                  TabOrder = 0
                  OnKeyDown = edtKeyKeyDown
                end
                object btnOk: TRzBitBtn
                  Left = 218
                  Top = 3
                  Width = 67
                  Height = 24
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
                  TabOrder = 1
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 736
    inherited Image1: TImage
      Left = 527
      Width = 200
    end
    inherited Image14: TImage
      Left = 727
    end
    inherited Image3: TImage
      Left = 527
      Width = 200
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #29992#25143#26723#26696
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 351
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 351
          Width = 30
        end>
      inherited ToolBar1: TToolBar
        Width = 351
        ButtonHeight = 30
        ButtonWidth = 43
        object But_Add: TToolButton
          Left = 0
          Top = 0
          Action = actNew
        end
        object But_Edit: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
          Caption = #20462#25913
        end
        object But_Info: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
          Caption = #35814#32454
        end
        object But_Delete: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton2: TToolButton
          Left = 172
          Top = 0
          Width = 7
          Caption = 'ToolButton2'
          ImageIndex = 3
          Style = tbsDivider
        end
        object ToolButton4: TToolButton
          Left = 179
          Top = 0
          Action = actRights
        end
        object But_Print: TToolButton
          Left = 222
          Top = 0
          Action = actPrint
        end
        object But_Preview: TToolButton
          Left = 265
          Top = 0
          Action = actPreview
        end
        object ToolButton3: TToolButton
          Left = 308
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 24
    Top = 306
  end
  inherited actList: TActionList
    Left = 56
    Top = 306
    inherited actNew: TAction
      OnExecute = actNewExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
    inherited actEdit: TAction
      OnExecute = actEditExecute
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
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    object actRights: TAction
      Caption = #25480#26435
      ImageIndex = 31
      ShortCut = 16466
      OnExecute = actRightsExecute
    end
  end
  object Ds_Users: TDataSource
    DataSet = Cds_Users
    Left = 56
    Top = 336
  end
  object PopupMenu1: TPopupMenu
    Left = 238
    Top = 155
    object N1: TMenuItem
      Caption = #25480#26435
      OnClick = N1Click
    end
  end
  object frfUsers: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 312
    Top = 209
    ReportForm = {
      180000003C0E0000180000FFFF01000100FFFFFFFFFF09000000340800009A0B
      00000000000000000000000000000000000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00BE000000F6020000140000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      3B0100000500D2B3CDB7310002010000000024000000F6020000460000003000
      020001000000000000000000FFFFFF1F00000000000000000000000000FFFF00
      0000000002000000010000000000000001000000C80000001400000001000000
      0000000200A00100000500D2B3BDC53100020100000000F6000000F602000015
      0000003000030001000000000000000000FFFFFF1F0000000000000000000000
      0000FFFF000000000002000000010000000000000001000000C8000000140000
      000100000000000000002802000005004D656D6F320002002601000025000000
      A5000000180000000300020001000000000000000500FFFFFF1F2E0200000000
      0001000B00D3C320BBA720B5B520B0B800000000FFFF00000000000200000001
      000000000400CBCECCE500100000000200000000000A00000086000200000000
      00FFFFFF0000000002000000000000000000AA02000006004D656D6F33340002
      004A01000054000000240000001600000003000F0001000000000000000000FF
      FFFF1F2E02000000000001000400D0D4B1F000000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000008600020000
      000000FFFFFF00000000020000000000000000003003000006004D656D6F3336
      0002007100000054000000410000001600000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000800D3C3BBA7D0D5C3FB00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      008600020000000000FFFFFF0000000002000000000000000000B20300000600
      4D656D6F33370002001201000054000000380000001600000003000F00010000
      00000000000000FFFFFF1F2E02000000000001000400D6B0CEF100000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000200000000000A
      0000008600020000000000FFFFFF000000000200000000000000000034040000
      06004D656D6F353500020014000000540000001B0000001600000003000F0001
      000000000000000000FFFFFF1F2E02000000000001000400D0F2BAC500000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000B904
      000005004D656D6F370002002F00000054000000420000001600000003000F00
      01000000000000000000FFFFFF1F2E02000000000001000800D3C3BBA7D5CBBA
      C500000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      0200000000000A0000000100020000000000FFFFFF0000000002000000000000
      0000003D05000005004D656D6F3600020014000000BE0000001B000000140000
      0003000F0001000000000000000000FFFFFF1F2E020000000000010007005B4C
      494E45235D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A0000000000000000000A0000008600020000000000FFFFFF00000000020000
      00000000000000C205000005004D656D6F35000200B200000054000000600000
      001600000003000F0001000000000000000000FFFFFF1F2E0200000000000100
      0800CBF9D4DAC3C5B5EA00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF0000
      0000020000000000000000004706000005004D656D6F390002006E0100005400
      0000540000001600000003000F0001000000000000000000FFFFFF1F2E020000
      00000001000800D2C6B6AFB5E7BBB000000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000000100020000000000
      FFFFFF0000000002000000000000000000CD06000006004D656D6F3132000200
      C201000054000000540000001600000003000F0001000000000000000000FFFF
      FF1F2E02000000000001000800B0ECB9ABB5E7BBB000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000200000000000A0000000100
      020000000000FFFFFF00000000020000000000000000006407000006004D656D
      6F32340002003002000024000000B20000001300000003000000010000000000
      00000000FFFFFF1F2E02000000000001001900B5DA5B50414745235D2F5B544F
      54414C50414745535DD2B32000000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000090000008600020000000000FFFFFF
      0000000002000000000000000000FA07000006004D656D6F3134000200100200
      00F6000000D2000000130000000300000001000000000000000000FFFFFF1F2E
      02000000000001001800B4F2D3A1C8D5C6DAA3BA5B446174655D20205B54696D
      655D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000008600020000000000FFFFFF00000000020000000000
      000000008008000006004D656D6F313500020016020000540000006300000016
      00000003000F0001000000000000000000FFFFFF1F2E02000000000001000800
      BCD2CDA5B5E7BBB000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000200000000000A0000000100020000000000FFFFFF00000000
      020000000000000000000609000006004D656D6F313700020079020000540000
      00690000001600000003000F0001000000000000000000FFFFFF1F2E02000000
      000001000800B5E7D7D3D3CACFE400000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000200000000000A0000000100020000000000FF
      FFFF00000000020000000000000000008909000005004D656D6F310002004A01
      0000BE000000240000001400000003000F0001000000000000000000FFFFFF1F
      2E020000000000010006005BD0D4B1F05D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF0000000002000000000000000000100A000005004D656D6F330002
      0071000000BE000000410000001400000003000F0001000000000000000000FF
      FFFF1F2E02000000000001000A005BD3C3BBA7D0D5C3FB5D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      008600020000000000FFFFFF0000000002000000000000000000930A00000500
      4D656D6F3400020012010000BE000000380000001400000003000F0001000000
      000000000000FFFFFF1F2E020000000000010006005BD6B0CEF15D00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000020000000000
      0A0000008600020000000000FFFFFF00000000020000000000000000001A0B00
      0005004D656D6F380002002F000000BE000000420000001400000003000F0001
      000000000000000000FFFFFF1F2E02000000000001000A005BD3C3BBA7D5CBBA
      C55D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      000200000000000A0000000100020000000000FFFFFF00000000020000000000
      00000000A20B000006004D656D6F3130000200B2000000BE0000006000000014
      00000003000F0001000000000000000000FFFFFF1F2E02000000000001000A00
      5BCBF9D4DAC3C5B5EA5D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF0000
      0000020000000000000000002A0C000006004D656D6F31310002006E010000BE
      000000540000001400000003000F0001000000000000000000FFFFFF1F2E0200
      0000000001000A005BD2C6B6AFB5E7BBB05D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000000100020000
      000000FFFFFF0000000002000000000000000000B20C000006004D656D6F3133
      000200C2010000BE000000540000001400000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000A005BB0ECB9ABB5E7BBB05D00000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000200000000000A
      0000000100020000000000FFFFFF00000000020000000000000000003A0D0000
      06004D656D6F313600020016020000BE000000630000001400000003000F0001
      000000000000000000FFFFFF1F2E02000000000001000A005BBCD2CDA5B5E7BB
      B05D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      000200000000000A0000000100020000000000FFFFFF00000000020000000000
      00000000C20D000006004D656D6F313800020079020000BE0000006900000014
      00000003000F0001000000000000000000FFFFFF1F2E02000000000001000A00
      5BB5E7D7D3D3CACFE45D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF0000
      00000200000000000000FEFEFF060000000A00205661726961626C6573000000
      000200736C0014006364735F436867426F64792E22534C30303030220002006A
      650014006364735F436867426F64792E224A4530303030220004006B68796800
      000000040079687A68000000000200647A000000000000000000000000FDFF01
      00000000}
  end
  object Cds_Users: TZQuery
    AfterScroll = Cds_UsersAfterScroll
    Params = <>
    Left = 62
    Top = 240
  end
end
