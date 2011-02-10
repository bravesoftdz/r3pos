inherited frmGoodsSortTree: TfrmGoodsSortTree
  Left = 613
  Caption = #21830#21697#20998#31867#31649#29702
  ClientHeight = 370
  ClientWidth = 513
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 513
    Height = 370
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 503
      Height = 320
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #21830#21697#20998#31867#26723#26696
        inherited RzPanel2: TRzPanel
          Width = 499
          Height = 293
          BorderColor = clWhite
          Color = clWhite
          object Label18: TLabel
            Left = 180
            Top = 29
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20998#31867#20195#30721
          end
          object Label1: TLabel
            Left = 180
            Top = 58
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20998#31867#21517#31216
          end
          object Label2: TLabel
            Left = 181
            Top = 89
            Width = 80
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25340#38899#30721
          end
          object Label11: TLabel
            Left = 393
            Top = 58
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
          object Label3: TLabel
            Left = 361
            Top = 88
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
            Width = 172
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
            Left = 413
            Top = 18
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
            TabOrder = 4
            TextStyle = tsRaised
            ThemeAware = False
            OnClick = edtSORT1Click
            NumGlyphs = 2
            Spacing = 5
          end
          object edtSORT_ID: TcxTextEdit
            Tag = 1
            Left = 271
            Top = 25
            Width = 66
            Height = 20
            TabOrder = 1
          end
          object edtSORT_NAME: TcxTextEdit
            Left = 271
            Top = 54
            Width = 122
            Height = 20
            Properties.OnChange = edtSORT_NAMEPropertiesChange
            TabOrder = 2
            OnExit = edtSORT_NAMEExit
          end
          object edtSORT_SPELL: TcxTextEdit
            Left = 271
            Top = 84
            Width = 90
            Height = 20
            Enabled = False
            Properties.OnChange = edtSORT_SPELLPropertiesChange
            TabOrder = 3
          end
          object edtSORT2: TRzBitBtn
            Left = 413
            Top = 52
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
            TabOrder = 5
            TextStyle = tsRaised
            ThemeAware = False
            OnClick = edtSORT2Click
            NumGlyphs = 2
            Spacing = 5
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 325
      Width = 503
      BorderColor = clWhite
      Color = clWhite
      object edtExit: TRzBitBtn
        Left = 426
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
        TabOrder = 3
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = edtExitClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtSave: TRzBitBtn
        Left = 179
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
      object edtDelete: TRzBitBtn
        Left = 343
        Top = 6
        Width = 70
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
        TabOrder = 2
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = edtDeleteClick
        NumGlyphs = 2
        Spacing = 5
      end
      object edtCancel: TRzBitBtn
        Left = 261
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
    Left = 200
    Top = 192
  end
  inherited actList: TActionList
    Top = 152
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
    Left = 198
    Top = 157
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
    Left = 238
    Top = 189
  end
end
