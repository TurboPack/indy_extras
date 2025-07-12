{ ****************************************************************************** }
{ *  TaurusTLS                                                                 * }
{ *           https://github.com/JPeterMugaas/TaurusTLS                        * }
{ *                                                                            * }
{ *  Copyright (c) 2024 - 2025 TaurusTLS Developers, All Rights Reserved       * }
{ *                                                                            * }
{ * Portions of this software are Copyright (c) 1993 – 2018,                   * }
{ * Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  * }
{ ****************************************************************************** }

{$I ..\Source\TaurusTLSCompilerDefines.inc}
{$I TaurusTLSUTCompilerDefines.inc}
/// <summary>
/// Base Test Fixture class for unit-tests
/// </summary>
unit TaurusTLS.UT.TestClasses;
{$i ..\Source\TaurusTLSLinkDefines.inc}

interface

uses
  System.SysUtils, DUnitX.TestFramework, TaurusTLS.UT.Utils;

type
  ///  <summary>
  ///  Base exception class can be used to make Assert Tests Fixtures
  ///  </summary
  EOsslBaseFixture = class(Exception);

  ///  <summary>
  ///  Base Test Fixture class for unit-tests used OpenSSL library.
  ///  This fixture automatically load OpenSSL library if its not loaded yet.
  ///  </summary
  [TestFixture]
  TOsslBaseFixture = class
  public type
    TTestFlag = (tfOssLibLoaded, tfOssLibFailed, tfGlobalFail, tfBoundary=SizeOf(Cardinal)*8-1);
    TTestFlags = set of TTestFlag;
  private class var
    FFlags: TTestFlags;
  private
    class function GetGlobalFail: boolean; static;
    class function GetOssLibFailed: boolean; static;
    class procedure SetOssLibLoaded(const Value: boolean); static;
    class procedure SetFlag(const AFlag: TTestFlag; AEnable: boolean); static;
  protected
    class function GetOssLibLoaded: boolean; static;
    class procedure SetGlobalFail(const Value: boolean); static;
    class procedure SetOssLibFailed(const Value: boolean); static;
  public
    [SetupFixture]
    ///  <summary>
    ///  The <c>SetupFixture</c> method loads the OpenSSL library
    ///  and set internal library refrerence counter to <c>1</c>,
    ///  or increments internal library refrerence counter otherwise.
    ///  </summary>
    ///  <remark>
    ///  This method can be overritten by inherited class
    ///  </remark>
    procedure SetupFixture; virtual;
    [TearDownFixture]
    ///  <summary>
    ///  The <c>TearDownFixture</c> method decrements internal library refrerence counter
    ///  and unloads the OpenSSL library when it reaches Zero.
    ///  </summary>
    ///  <remark>
    ///  This method can be overritten by inherited class
    ///  </remark>
    procedure TearDownFixture; virtual;

    ///  <summary>
    ///  The <c>CheckLoaded</c> method checks if the OpenSSL library
    ///  has loaded and raise <see ref="EOsslBaseFixture" /> if not.
    ///  </summary>
    class procedure CheckLoaded;
    ///  <summary>
    ///  The <c>CheckLoaded</c> method checks if any faulre registered which
    ///  blocks any Test Fixture execution and raise <see ref="EOsslBaseFixture" />
    ///  if any.
    ///  </summary>
    ///  <remark>
    ///  This method can be overritten by inherited class
    ///  </remark>
    class procedure CheckFailed; virtual;
    ///  <summary>
    ///  The <c>CheckLoaded</c> method checks if any faulre registered
    ///  and OpenSSL Library loased, and raise <see ref="EOsslBaseFixture" /> if any.
    ///  </summary>
    ///  <remark>
    ///  This method can be overritten by inherited class
    ///  </remark>
    class procedure CheckAllFailures; virtual;

    ///  <summary>
    ///  Displays if OpenSSL library loaded.
    ///  </summary>
    class property OssLibLoaded: boolean read GetOssLibLoaded;
    ///  <summary>
    ///  Displays if OpenSSL library is inconsitance state.
    ///  </summary>
    class property OssLibFailed: boolean read GetOssLibFailed ;
    ///  <summary>
    ///  Displays if Test Fixtures has failure which blocks
    ///  other Test Fixtures execution.
    ///  </summary>
    class property GlobalFail: boolean read GetGlobalFail;
  end;

resourcestring
  cOsslNotLoaded = 'Openssl library is not loaded. Skipping remaining tests(s)';
  cOsslLoadFailed = 'Openssl library load failed. Skipping remaining tests(s)';
  cOsslGlobalFail = 'Openssl global failure. Skipping remaining tests(s)';

implementation

uses
  System.SyncObjs;

{ TOsslTestBase }

class procedure TOsslBaseFixture.CheckAllFailures;
begin
  CheckLoaded;
  CheckFailed;
end;

class procedure TOsslBaseFixture.CheckFailed;
var
  lReason: string;

begin
  lReason:='';
  if GlobalFail then
    lReason:=cOsslGlobalFail
  else if OssLibFailed then
    lReason:=cOsslLoadFailed;
  if not lReason.IsEmpty then
    raise EOsslBaseFixture.Create(lReason);
end;

class procedure TOsslBaseFixture.CheckLoaded;
begin
  if not OssLibLoaded then
    raise EOsslBaseFixture.CreateRes(@cOsslNotLoaded);
end;

class function TOsslBaseFixture.GetGlobalFail: boolean;
begin
  Result:=tfGlobalFail in FFlags;
end;

class function TOsslBaseFixture.GetOssLibFailed: boolean;
begin
  Result:=tfOssLibFailed in FFlags;
end;

class function TOsslBaseFixture.GetOssLibLoaded: boolean;
begin
  Result:=tfOssLibLoaded in FFlags;
end;

class procedure TOsslBaseFixture.SetOssLibLoaded(const Value: boolean);
begin
  SetFlag(tfOssLibLoaded, Value);
end;

class procedure TOsslBaseFixture.SetGlobalFail(const Value: boolean);
begin
  SetFlag(tfGlobalFail, Value);
end;

class procedure TOsslBaseFixture.SetOssLibFailed(const Value: boolean);
begin
  SetFlag(tfOssLibFailed, Value);
  SetGlobalFail(True);
end;

class procedure TOsslBaseFixture.SetFlag(const AFlag: TTestFlag; AEnable: boolean);
var
  lSpinW: TSpinWait;
  lFlags: TTestFlags;
  lNewFlags: TTestFlags;

begin
  lSpinW.Reset;
  repeat
    lFlags:=FFlags;
    lNewFlags:=lFlags;
    if AEnable then
      lNewFlags:=lFlags+[AFlag]
    else
      lNewFlags:=lFlags-[AFlag];
    // Hack for SET Varibale atomic update
    cardinal((@lFlags)^):=TInterlocked.CompareExchange(cardinal((@FFlags)^),
      cardinal((@lNewFlags)^), cardinal((@lFlags)^));
    if ((AFlag in FFlags) xor (not AEnable)) then
      break;
    lSpinW.SpinCycle;
  until False;
end;

procedure TOsslBaseFixture.SetupFixture;
{$IFDEF MSWINDOWS}
  {$IFNDEF MEMLEAK_DETAILS}
var
  lDebugActive: boolean;
  {$ENDIF MEMLEAK_DETAILS}
{$ENDIF}

begin
{$IFDEF MSWINDOWS}
  {$IFDEF MEMLEAK_DETAILS}
  TFastMMDebugLog.DebugModeActive:=True;
  {$ELSE}
  lDebugActive:=TFastMMDebugLog.DebugModeActive; // To enforce linker add the TFastMMDebugLog class
  {$ENDIF MEMLEAK_DETAILS}
{$ENDIF}
  try
    SetOssLibLoaded(TOsslLoader.Load);
    CheckAllFailures;
  except
    SetGlobalFail(True);
    raise
  end;
end;

procedure TOsslBaseFixture.TearDownFixture;
begin
  if OssLibLoaded then
  try
    TOsslLoader.Unload;
  except
    SetGlobalFail(True);
    raise;
  end;
end;

initialization

end.
