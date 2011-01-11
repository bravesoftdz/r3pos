object Form1: TForm1
  Left = 192
  Top = 160
  Width = 870
  Height = 500
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 600
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 192
    Width = 320
    Height = 225
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 600
    Top = 144
    Width = 75
    Height = 25
    Caption = 'open'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 600
    Top = 184
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 24
    Top = 32
    Width = 241
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object Button4: TButton
    Left = 24
    Top = 70
    Width = 75
    Height = 25
    Caption = 'filter'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 104
    Top = 70
    Width = 75
    Height = 25
    Caption = 'locate'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 184
    Top = 70
    Width = 75
    Height = 25
    Caption = 'updatestatus'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 600
    Top = 224
    Width = 75
    Height = 25
    Caption = 'transsave'
    TabOrder = 8
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 600
    Top = 264
    Width = 75
    Height = 25
    Caption = 'sqlsave'
    TabOrder = 9
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 600
    Top = 304
    Width = 75
    Height = 25
    Caption = 'ExecSQL'
    TabOrder = 10
    OnClick = Button9Click
  end
  object ZQuery1: TZQuery
    UpdateObject = ZUpdateSQL1
    SQL.Strings = (
      'select * from CUSTOMER')
    Params = <>
    Left = 336
    Top = 216
  end
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 248
    Top = 120
  end
  object ADOConnection1: TADOConnection
    Left = 472
    Top = 152
  end
  object ZUpdateSQL1: TZUpdateSQL
    ModifySQL.Strings = (
      'UPDATE CUSTOMER set CUST_NO=:CUST_NO WHERE CUST_NO=:OLD_CUST_NO')
    UseSequenceFieldForRefreshSQL = False
    Left = 368
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUST_NO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_CUST_NO'
        ParamType = ptUnknown
      end>
  end
end
