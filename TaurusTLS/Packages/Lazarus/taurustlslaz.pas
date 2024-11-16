{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit TaurusTLSLaz;

{$warn 5023 off : no warning about unused units}
interface

uses
  TaurusTLS_Dsn_Register, TaurusTLS_Dsn_AboutDlg, 
  TaurusTLS_Dsn_ComponentEditor, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('TaurusTLS_Dsn_Register', @TaurusTLS_Dsn_Register.Register);
  RegisterUnit('TaurusTLS_Dsn_ComponentEditor', 
    @TaurusTLS_Dsn_ComponentEditor.Register);
end;

initialization
  RegisterPackage('TaurusTLSLaz', @Register);
end.
