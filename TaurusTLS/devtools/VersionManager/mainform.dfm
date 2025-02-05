object frmMainForm: TfrmMainForm
  Left = 0
  Top = 0
  Caption = 'frmMainForm'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    624
    441)
  TextHeight = 15
  object lblMajorVersion: TLabel
    Left = 16
    Top = 16
    Width = 72
    Height = 15
    Caption = 'Ma&jor Version'
    FocusControl = spnMajorVersion
  end
  object Label2: TLabel
    Left = 168
    Top = 16
    Width = 73
    Height = 15
    Caption = 'M&inor Version'
    FocusControl = spnMinorVersion
  end
  object Label3: TLabel
    Left = 320
    Top = 16
    Width = 39
    Height = 15
    Caption = '&Release'
    FocusControl = spnedtRelease
  end
  object Label4: TLabel
    Left = 472
    Top = 16
    Width = 27
    Height = 15
    Caption = '&Build'
    FocusControl = spnedtBuild
  end
  object Label1: TLabel
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
    Width = 53
    Height = 15
    Caption = '&Copyright'
    FocusControl = edtCopyright
  end
  object Label5: TLabel
    Left = 16
    Top = 83
    Width = 87
    Height = 15
    Caption = 'lblProductName'
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
  end
  object edtCopyright: TEdit
    Left = 16
    Top = 216
    Width = 577
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object btnGenerateFiles: TButton
    Left = 16
    Top = 248
    Width = 153
    Height = 25
    Caption = '&Generate Files'
    TabOrder = 7
    OnClick = btnGenerateFilesClick
  end
  object edtProductName: TEdit
    Left = 16
    Top = 96
    Width = 577
    Height = 23
    TabOrder = 4
    Text = 'edtProductName'
  end
end
