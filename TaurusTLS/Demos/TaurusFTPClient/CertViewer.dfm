object frmCertViewer: TfrmCertViewer
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmCertViewer'
  ClientHeight = 377
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBtnText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    556
    377)
  TextHeight = 15
  object lblErrorMessage: TLabel
    Left = 8
    Top = 8
    Width = 528
    Height = 74
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    FocusControl = redtCertView
    WordWrap = True
    ExplicitWidth = 542
  end
  object lblAcceptThisCertificate: TLabel
    Left = 8
    Top = 88
    Width = 119
    Height = 15
    Caption = 'A&ccept this certificate?'
    FocusControl = redtCertView
  end
  object Panel2: TPanel
    Left = 0
    Top = 343
    Width = 556
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    ExplicitTop = 335
    ExplicitWidth = 554
    DesignSize = (
      556
      34)
    object OKBtn: TButton
      Left = 383
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Yes'
      Default = True
      ModalResult = 6
      TabOrder = 0
      ExplicitLeft = 381
    end
    object CancelBtn: TButton
      Left = 464
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&No'
      ModalResult = 7
      TabOrder = 1
      ExplicitLeft = 462
    end
  end
  object redtCertView: TRichEdit
    Left = 8
    Top = 104
    Width = 528
    Height = 209
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Lucida Console'
    Font.Style = []
    Lines.Strings = (
      'redtCertView')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WantTabs = True
    WantReturns = False
    WordWrap = False
    ExplicitWidth = 526
    ExplicitHeight = 201
  end
  object chkacceptOnlyOnce: TCheckBox
    Left = 8
    Top = 320
    Width = 528
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Accept Certificate Only Once'
    Checked = True
    State = cbChecked
    TabOrder = 1
    ExplicitTop = 312
    ExplicitWidth = 526
  end
end
