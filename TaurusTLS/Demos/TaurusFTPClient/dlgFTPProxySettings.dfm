object frmFTPProxySettings: TfrmFTPProxySettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmFTPProxySettings'
  ClientHeight = 187
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 15
  object lblProxyPort: TLabel
    Left = 18
    Top = 129
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'P&ort:'
    Enabled = False
    FocusControl = spededtProxyPort
    Layout = tlCenter
  end
  object lblProxyServerPassword: TLabel
    Left = 18
    Top = 100
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Password:'
    Enabled = False
    FocusControl = edtProxyServerPassword
    Layout = tlCenter
  end
  object lblProxyServerUserName: TLabel
    Left = 18
    Top = 71
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Username:'
    Enabled = False
    FocusControl = edtProxyServerUserName
    Layout = tlCenter
  end
  object lblProxyServerName: TLabel
    Left = 18
    Top = 42
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Proxy &Server:'
    Enabled = False
    FocusControl = edtProxyServerName
    Layout = tlCenter
  end
  object lblProxyType: TLabel
    Left = 18
    Top = 13
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = '&Type:'
    FocusControl = cboProxyType
    Layout = tlCenter
  end
  object Panel2: TPanel
    Left = 0
    Top = 153
    Width = 472
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
    TabOrder = 5
    ExplicitTop = 145
    ExplicitWidth = 470
    DesignSize = (
      472
      34)
    object OKBtn: TButton
      Left = 307
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
      Left = 388
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
  object spededtProxyPort: TSpinEdit
    Left = 97
    Top = 129
    Width = 121
    Height = 24
    Enabled = False
    MaxValue = 65535
    MinValue = 1
    TabOrder = 4
    Value = 1
  end
  object edtProxyServerPassword: TEdit
    Left = 97
    Top = 100
    Width = 369
    Height = 23
    Enabled = False
    PasswordChar = '*'
    TabOrder = 3
  end
  object edtProxyServerUserName: TEdit
    Left = 97
    Top = 71
    Width = 369
    Height = 23
    Enabled = False
    TabOrder = 2
  end
  object edtProxyServerName: TEdit
    Left = 97
    Top = 42
    Width = 369
    Height = 23
    Enabled = False
    TabOrder = 1
  end
  object cboProxyType: TComboBox
    Left = 97
    Top = 13
    Width = 369
    Height = 23
    Style = csDropDownList
    TabOrder = 0
    OnChange = cboProxyTypeChange
    Items.Strings = (
      'None'
      'Send command USER user@hostname - USER after login'
      'Send command SITE (with logon)'
      'Send command OPEN'
      'USER user@firewalluser@hostname / PASS pass@firewallpass'
      
        'First use the USER and PASS command with the firewall username a' +
        'nd password, and then with the target host username and password' +
        '.'
      'USER hostuserId@hostname firewallUsername'
      'Novell BorderManager Proxy')
  end
end
