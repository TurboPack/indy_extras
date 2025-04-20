object frmNATSettings: TfrmNATSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmNATSettings'
  ClientHeight = 138
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  DesignSize = (
    374
    138)
  TextHeight = 15
  object lblMaximumPort: TLabel
    Left = 226
    Top = 76
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'M&aximum:'
    FocusControl = spnedtPortMaximum
    Layout = tlCenter
    ExplicitLeft = 230
  end
  object lblMinPort: TLabel
    Left = 18
    Top = 76
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = '&Minimum:'
    FocusControl = spnedtPortMinimum
    Layout = tlCenter
  end
  object lblPorts: TLabel
    Left = 18
    Top = 47
    Width = 348
    Height = 23
    Alignment = taCenter
    AutoSize = False
    Caption = 'Data Port Range for PORT/EPRT transfers.'
    Layout = tlCenter
  end
  object lblNATIPAddress: TLabel
    Left = 18
    Top = 13
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = '&IP Address:'
    FocusControl = edtExternalIPAddress
    Layout = tlCenter
  end
  object Panel2: TPanel
    Left = 0
    Top = 104
    Width = 374
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
    TabOrder = 3
    ExplicitTop = 96
    ExplicitWidth = 372
    DesignSize = (
      374
      34)
    object OKBtn: TButton
      Left = 209
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 290
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object spnedtPortMaximum: TSpinEdit
    Left = 290
    Top = 76
    Width = 75
    Height = 24
    Anchors = [akTop, akRight]
    MaxValue = 65535
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = spnedtPortMaximumChange
  end
  object spnedtPortMinimum: TSpinEdit
    Left = 105
    Top = 76
    Width = 75
    Height = 24
    MaxValue = 65535
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = spnedtPortMinimumChange
  end
  object edtExternalIPAddress: TEdit
    Left = 105
    Top = 13
    Width = 259
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    TextHint = 'Leave empty unless you are behind a NAT'
    OnChange = edtExternalIPAddressChange
  end
end
