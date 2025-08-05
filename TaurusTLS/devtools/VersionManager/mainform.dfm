object frmMainForm: TfrmMainForm
  Left = 0
  Top = 0
  Caption = 'frmMainForm'
  ClientHeight = 379
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    624
    379)
  TextHeight = 15
  object lblMajorVersion: TLabel
    Left = 16
    Top = 16
    Width = 75
    Height = 15
    Caption = 'Ma&jor Version:'
    FocusControl = spnMajorVersion
  end
  object lblMinorVersion: TLabel
    Left = 168
    Top = 16
    Width = 76
    Height = 15
    Caption = 'M&inor Version:'
    FocusControl = spnMinorVersion
  end
  object lblRelease: TLabel
    Left = 320
    Top = 16
    Width = 42
    Height = 15
    Caption = '&Release:'
    FocusControl = spnedtRelease
  end
  object lblBuild: TLabel
    Left = 472
    Top = 16
    Width = 30
    Height = 15
    Caption = '&Build:'
    FocusControl = spnedtBuild
  end
  object lblCompanyName: TLabel
    Left = 16
    Top = 144
    Width = 90
    Height = 15
    Caption = 'Company Name:'
    FocusControl = edtCompanyName
  end
  object lblCopyright: TLabel
    Left = 16
    Top = 200
    Width = 56
    Height = 15
    Caption = '&Copyright:'
    FocusControl = edtCopyright
  end
  object lblProductName: TLabel
    Left = 16
    Top = 83
    Width = 90
    Height = 15
    Caption = 'lblProductName:'
  end
  object spnMajorVersion: TSpinEdit
    Left = 16
    Top = 32
    Width = 121
    Height = 24
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object spnMinorVersion: TSpinEdit
    Left = 168
    Top = 32
    Width = 121
    Height = 24
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object spnedtRelease: TSpinEdit
    Left = 320
    Top = 32
    Width = 121
    Height = 24
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object spnedtBuild: TSpinEdit
    Left = 472
    Top = 32
    Width = 121
    Height = 24
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object edtCompanyName: TEdit
    Left = 16
    Top = 157
    Width = 577
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
    ExplicitWidth = 575
  end
  object edtCopyright: TEdit
    Left = 16
    Top = 216
    Width = 577
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
    ExplicitWidth = 575
  end
  object btnGenerateFiles: TButton
    Left = 16
    Top = 347
    Width = 153
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Generate Files'
    TabOrder = 7
    OnClick = btnGenerateFilesClick
    ExplicitTop = 339
  end
  object edtProductName: TEdit
    Left = 16
    Top = 96
    Width = 577
    Height = 23
    TabOrder = 4
  end
  object mmoLog: TMemo
    Left = 16
    Top = 245
    Width = 577
    Height = 89
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 8
    WordWrap = False
  end
end
