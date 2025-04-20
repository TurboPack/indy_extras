unit WindowsDarkMode;

{
BSD 3-Clause License

Copyright (c) 2025, Ian Barker

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Modified by J. Peter Mugaas
}

interface
{$I TaurusTLSCompilerDefines.inc}

  // Checks the Windows registry to see if Windows Dark Mode is enabled
  function DarkModeIsEnabled: boolean;

  // Automatically sets a Dark Mode theme is Windows is running in Dark Mode
  // To use:
  //   1. Got to project properties
  //   2. Select appearance and choose two or more themes.  Note down the names!
  //   3. In your FormCreate (or wherever) put the following line:
  //      SetAppropriateThemeMode(**name_of_the_dark_theme**, **namme_of_the_non_dark_theme**);
  //
  //      For example:
  //      SetAppropriateThemeMode('Carbon', 'Windows10');
  //
  procedure SetAppropriateThemeMode(const DarkModeThemeName, LightModeThemeName: string);

  // Sets either a Dark Mode or non Dark mode theme based in the "AsDarkMode" boolean
  // For example:
  //     SetSpecificThemeMode(False, 'TheDarkModeThemeName', 'TheLightModeThemeName');
  //     Would change the application theme to the theme with the name 'TheLightModeThemeName'
  //     if it exists.
  //
  procedure SetSpecificThemeMode(const AsDarkMode: Boolean; const DarkModeThemeName, LightModeThemeName: string);


implementation
uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,       // for the pre-defined registry key constants
  System.Win.Registry,  // for the registry read access
{$ENDIF}
  VCL.themes;           // Used for access to TStyleManager

procedure SetAppropriateThemeMode(const DarkModeThemeName, LightModeThemeName: string);
begin
  SetSpecificThemeMode(DarkModeIsEnabled, DarkModeThemeName, LightModeThemeName);
end;

procedure SetSpecificThemeMode(const AsDarkMode: Boolean; const DarkModeThemeName, LightModeThemeName: string);
{$IFNDEF USE_INLINE_VAR}
var
  ChosenTheme: string;
{$ENDIF}
begin
  {$IFDEF USE_INLINE_VAR}
  var
    ChosenTheme: string;
  {$ENDIF}
  if AsDarkMode then
    ChosenTheme := DarkModeThemeName
  else
    ChosenTheme := LightModeThemeName;
  TStyleManager.TrySetStyle(ChosenTheme, False);
end;

function DarkModeIsEnabled: boolean;
{$IFDEF MSWINDOWS}
const
  TheKey   = 'Software\Microsoft\Windows\CurrentVersion\Themes\Personalize\';
  TheValue = 'AppsUseLightTheme';
var
  Reg: TRegistry;
{$ENDIF}
begin

  Result := False;  // There is no dark side - the Jedi are victorious!

// This relies on a registry setting only available on MS Windows
// If the developer has somehow managed to get to this point then tell
// them not to do this!
{$IFNDEF MSWINDOWS}
{$MESSAGE WARN '"DarkModeIsEnabled" will only work on MS Windows targets'}
{$ELSE}
  Reg    := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(TheKey) then
      if Reg.OpenKey(TheKey, False) then
      try
        if Reg.ValueExists(TheValue) then
          Result := Reg.ReadInteger(TheValue) = 0;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
{$ENDIF}
end;

end.
