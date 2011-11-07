inherited frmMMLogin: TfrmMMLogin
  Left = 314
  Top = 80
  Caption = 'frmMMLogin'
  ClientHeight = 272
  ClientWidth = 410
  Color = clFuchsia
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgk_tt: TRzPanel
    Width = 410
    Height = 104
    Anchors = []
    inherited bkg_01: TImage
      Height = 104
      Align = alNone
      AutoSize = False
      Visible = False
    end
    inherited bkg_02: TImage
      Left = 422
      Top = 160
      Height = 104
      Align = alNone
      AutoSize = False
      Visible = False
    end
    inherited bkg_top: TRzPanel
      Left = 0
      Width = 410
      Height = 104
      Anchors = []
      BorderOuter = fsNone
      Transparent = True
      DesignSize = (
        410
        104)
      object imgLogin: TImage [0]
        Left = 0
        Top = 0
        Width = 410
        Height = 105
        AutoSize = True
      end
      inherited RzFormShape1: TRzFormShape [1]
        Top = 0
        Width = 410
        Height = 104
        AutoSize = True
      end
      inherited bkg_f1: TRzBackground [2]
        Left = 219
        Top = 130
        Width = 280
        Visible = False
      end
      inherited formLogo: TImage [3]
        Visible = False
      end
      inherited RzSeparator1: TRzSeparator
        Top = 192
        Width = 410
        Align = alNone
        Visible = False
      end
    end
    inherited sysMinimized: TRzBmpButton
      Left = 81
    end
    inherited sysMaximized: TRzBmpButton
      Left = 29
    end
    inherited sysClose: TRzBmpButton
      Left = 353
    end
  end
  inherited bkg_bb: TRzPanel
    Top = 235
    Width = 410
    Height = 37
    inherited RzPanel10: TRzPanel
      Width = 6
      Height = 37
      inherited bkg_03: TImage
        Top = 0
        Width = 6
        Height = 37
      end
    end
    inherited RzPanel11: TRzPanel
      Left = 404
      Width = 6
      Height = 37
      inherited bkg_04: TImage
        Top = 0
        Width = 6
        Height = 37
      end
    end
    inherited bkg_bottom: TRzPanel
      Left = 6
      Width = 398
      Height = 37
      BorderOuter = fsNone
      inherited RzSeparator3: TRzSeparator
        Top = 37
        Width = 398
        Height = 0
        Visible = False
      end
      inherited bkg_f2: TRzBackground
        Width = 0
        Height = 37
        Visible = False
      end
      object Image3: TImage
        Left = 0
        Top = 0
        Width = 398
        Height = 37
        Align = alClient
        Stretch = True
      end
      object cxBtnOk: TRzBmpButton
        Left = 265
        Top = 7
        Width = 78
        Height = 24
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        Caption = #30331#24405'(&O)'
        TabOrder = 0
        OnClick = cxBtnOkClick
      end
      object cxBtnSetup: TRzBmpButton
        Left = 58
        Top = 7
        Width = 78
        Height = 24
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        Caption = #35774#32622'(&S)'
        TabOrder = 1
        OnClick = cxBtnSetupClick
      end
    end
  end
  inherited bkg: TRzPanel
    Top = 104
    Width = 410
    Height = 131
    BorderSides = [sdRight]
    inherited bkg_pnl: TRzPanel
      Left = 0
      Width = 409
      Height = 131
      BorderSides = [sdRight]
      object Image2: TImage
        Left = 0
        Top = 0
        Width = 408
        Height = 131
        Align = alClient
        AutoSize = True
      end
      object Label4: TLabel
        Left = 139
        Top = 20
        Width = 60
        Height = 12
        Caption = #30331#24405#26085#26399#65306
        Transparent = True
      end
      object lblName: TLabel
        Left = 139
        Top = 42
        Width = 60
        Height = 12
        Caption = #29992' '#25143' '#21517#65306
        Transparent = True
      end
      object lblPass: TLabel
        Left = 139
        Top = 64
        Width = 60
        Height = 12
        Caption = #30331#24405#23494#30721#65306
        Transparent = True
      end
      object edtOPER_DATE: TcxDateEdit
        Left = 199
        Top = 16
        Width = 152
        Height = 20
        Properties.DateOnError = deToday
        TabOrder = 0
      end
      object cxedtPasswrd: TcxTextEdit
        Left = 199
        Top = 60
        Width = 152
        Height = 20
        Properties.EchoMode = eemPassword
        TabOrder = 1
        OnKeyPress = cxedtPasswrdKeyPress
      end
      object cxcbSave: TcxCheckBox
        Left = 281
        Top = 90
        Width = 73
        Height = 21
        ParentColor = False
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #20445#23384#30331#24405
        State = cbsChecked
        Style.Color = 16428113
        TabOrder = 2
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      end
      object cxcbOffline: TcxCheckBox
        Left = 195
        Top = 90
        Width = 73
        Height = 21
        ParentColor = False
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #31163#32447#30331#24405
        Style.Color = 16428113
        TabOrder = 3
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      end
      object cxedtUsers: TcxComboBox
        Left = 199
        Top = 38
        Width = 152
        Height = 20
        TabOrder = 4
      end
      object logoStatus: TPanel
        Left = 113
        Top = 0
        Width = 295
        Height = 130
        BevelOuter = bvNone
        Caption = #27491#22312#30331#24405'...'
        Color = 16621644
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        Visible = False
      end
    end
  end
end
