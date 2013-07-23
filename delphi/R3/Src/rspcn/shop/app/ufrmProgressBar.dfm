inherited frmProgressBar: TfrmProgressBar
  Left = 744
  Top = 431
  Caption = 'frmStocksCalc'
  ClientHeight = 190
  ClientWidth = 359
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    Width = 359
    Height = 162
    object ProgressBar1: TRzProgressBar
      Left = 45
      Top = 56
      Width = 273
      BorderInner = fsFlat
      BorderOuter = fsFlatRounded
      BorderWidth = 0
      InteriorOffset = 0
      PartsComplete = 0
      Percent = 0
      TotalParts = 0
    end
  end
  inherited pnlAddressBar: TPanel
    Width = 359
    inherited Image3: TImage
      Width = 351
    end
    inherited RzLabel1: TRzLabel
      Width = 7
      Caption = ''
    end
    inherited Image1: TImage
      Left = 355
    end
    inherited RzFormShape1: TRzFormShape
      Width = 359
    end
    object RzLabel26: TRzLabel [5]
      Left = 10
      Top = 7
      Width = 61
      Height = 16
      Alignment = taCenter
      Caption = #25968#25454#20445#23384
      Transparent = True
      Layout = tlCenter
      ShadowColor = 16250871
      ShadowDepth = 1
      TextStyle = tsShadow
    end
    inherited btnClose: TRzBmpButton
      Left = 330
    end
    inherited RzBmpButton4: TRzBmpButton
      Left = 278
      Visible = False
    end
    inherited btnWindow: TRzBmpButton
      Left = 304
      Visible = False
    end
  end
end
