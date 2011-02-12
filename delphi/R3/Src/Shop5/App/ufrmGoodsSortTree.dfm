inherited frmGoodsSortTree: TfrmGoodsSortTree
  Left = 613
  Caption = ''
  ClientHeight = 370
  ClientWidth = 434
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 434
    Height = 370
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 424
      Height = 320
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = ''
        inherited RzPanel2: TRzPanel
          Width = 420
          Height = 293
          BorderColor = clWhite
          Color = clWhite
          object Label1: TLabel
            Left = 180
            Top = 37
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20998#31867#21517#31216
          end
          object Label2: TLabel
            Left = 181
            Top = 68
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25340#38899#30721
          end
          object Label11: TLabel
            Left = 393
            Top = 37
            Width = 6
            Height = 12
            Alignment = taRightJustify
            Caption = '*'
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object rzTree: TRzTreeView
            Left = 5
            Top = 5
            Width = 196
            Height = 283
            SelectionPen.Color = clBtnShadow
            Align = alLeft
            DragMode = dmAutomatic
            FrameVisible = True
            HideSelection = False
            Indent = 19
            PopupMenu = PopupMenu1
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            OnChange = rzTreeChange
            OnDragOver = rzTreeDragOver
            OnEndDrag = rzTreeEndDrag
            OnKeyDown = rzTreeKeyDown
            OnStartDrag = rzTreeStartDrag
          end
          object edtSORT1: TRzBitBtn
            Left = 212
            Top = 99
            Width = 83
            Height = 26
            Anchors = [akTop, akRight]
            Caption = #28155#21152#21516#32423'(&A)'
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
            TabOrder = 3
            TextStyle = tsRaised
            ThemeAware = False
            OnClick = edtSORT1Click
            NumGlyphs = 2
            Spacing = 5
          end
          object edtSORT_NAME: TcxTextEdit
            Left = 271
            Top = 33
            Width = 122
            Height = 20
            Properties.OnChange = edtSORT_NAMEPropertiesChange
            TabOrder = 1
            OnExit = edtSORT_NAMEExit
          end
          object edtSORT_SPELL: TcxTextEdit
            Left = 271
            Top = 63
            Width = 90
            Height = 20
            Enabled = False
            Properties.OnChange = edtSORT_SPELLPropertiesChange
            TabOrder = 2
          end
          object edtSORT2: TRzBitBtn
            Left = 212
            Top = 130
            Width = 83
            Height = 26
            Anchors = [akTop, akRight]
            Caption = #28155#21152#19979#32423'(&N)'
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
            TabOrder = 4
            TextStyle = tsRaised
            ThemeAware = False
            OnClick = edtSORT2Click
            NumGlyphs = 2
            Spacing = 5
          end
          object edtDelete: TRzBitBtn
            Left = 326
            Top = 130
            Width = 83
            Height = 26
            Anchors = [akTop, akRight]
            Caption = #21024#38500'(&D)'
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
            TabOrder = 5
            TextStyle = tsRaised
            ThemeAware = False
            OnClick = edtDeleteClick
            NumGlyphs = 2
            Spacing = 5
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 325
      Width = 424
      BorderColor = clWhite
      Color = clWhite
      object edtExit: TRzBitBtn
        Left = 349
        Top = 6
        Width = 70
        Height = 26
        Caption = #20851#38381'(&C)'
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
        TabOrder = 2
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = edtExitClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtSave: TRzBitBtn
        Left = 184
        Top = 6
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
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
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = edtSaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtCancel: TRzBitBtn
        Left = 266
        Top = 6
        Width = 70
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #21462#28040'(&R)'
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
        OnClick = edtCancelClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 215
    Top = 288
  end
  inherited actList: TActionList
    Left = 255
    Top = 248
    object CtrlUp: TAction
      Caption = #21521#19978
      OnExecute = CtrlUpExecute
    end
    object CtrlDown: TAction
      Caption = #21521#19979
      OnExecute = CtrlDownExecute
    end
    object CtrlHome: TAction
      Caption = #32622#39030
      OnExecute = CtrlHomeExecute
    end
    object CtrlEnd: TAction
      Caption = #32622#24213
      OnExecute = CtrlEndExecute
    end
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 213
    Top = 253
    object N1: TMenuItem
      Action = CtrlUp
    end
    object N2: TMenuItem
      Action = CtrlDown
    end
    object N3: TMenuItem
      Action = CtrlHome
    end
    object N4: TMenuItem
      Action = CtrlEnd
    end
  end
  object cdsGoodSort: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 253
    Top = 285
  end
end
