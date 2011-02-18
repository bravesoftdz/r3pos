inherited frmCardNoInput: TfrmCardNoInput
  Left = 378
  Top = 261
  BorderStyle = bsNone
  Caption = ''
  ClientHeight = 97
  ClientWidth = 297
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 297
    Height = 97
    Align = alClient
    BorderOuter = fsFlatBold
    Color = clBlack
    TabOrder = 0
    object Label3: TLabel
      Left = 15
      Top = 10
      Width = 155
      Height = 29
      Caption = #35831#36755#20837#21345#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCardNo: TcxTextEdit
      Left = 16
      Top = 46
      Width = 263
      Height = 41
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -32
      Style.Font.Name = #40657#20307
      Style.Font.Style = [fsBold]
      TabOrder = 0
      OnKeyPress = edtCardNoKeyPress
    end
  end
end
