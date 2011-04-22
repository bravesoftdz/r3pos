inherited frmCardNoInput: TfrmCardNoInput
  Left = 378
  Top = 261
  BorderStyle = bsNone
  Caption = ''
  ClientHeight = 122
  ClientWidth = 330
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 330
    Height = 122
    Align = alClient
    BorderOuter = fsFlatBold
    BorderShadow = clActiveCaption
    BorderWidth = 2
    Color = clBlack
    FlatColor = clTeal
    TabOrder = 0
    object Label3: TLabel
      Left = 15
      Top = 13
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
      Top = 57
      Width = 297
      Height = 32
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -24
      Style.Font.Name = #40657#20307
      Style.Font.Style = [fsBold]
      TabOrder = 0
      ImeMode = imClose
      OnKeyPress = edtCardNoKeyPress
    end
  end
end
