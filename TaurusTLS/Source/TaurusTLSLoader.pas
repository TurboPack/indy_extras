{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}

unit TaurusTLSLoader;

{$IFDEF MSWINDOWS}
{$DEFINE WINDOWS}
{$ENDIF}

{$i TaurusTLSCompilerDefines.inc}
{$i TaurusTLSLinkDefines.inc}

interface

uses
  Classes, IdGlobal, IdCTypes;

type
  { IOpenSSLLoader }

  IOpenSSLLoader = interface
    ['{BBB0F670-CC26-42BC-A9E0-33647361941A}']

    function GetOpenSSLPath: string;
    function GetSSLLibVersions: string;
    procedure SetOpenSSLPath(const Value: string);
    function GetFailedToLoad: TStringList;

    function Load: Boolean;
    procedure SetSSLLibVersions(const AValue: string);
    procedure Unload;

    property SSLLibVersions: string read GetSSLLibVersions write SetSSLLibVersions;
    property OpenSSLPath: string read GetOpenSSLPath write SetOpenSSLPath;
    property FailedToLoad: TStringList read GetFailedToLoad;
  end;

  TOpenSSLLoadProc = procedure(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);
  TOpenSSLUnloadProc = procedure;

function GetOpenSSLLoader: IOpenSSLLoader;


procedure Register_SSLLoader(LoadProc: TOpenSSLLoadProc; const module_name: string);
procedure Register_SSLUnloader(UnloadProc: TOpenSSLUnloadProc);

implementation

uses
  TaurusTLSExceptionHandlers,
  TaurusTLS_ResourceStrings

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
  {$IFDEF WINDOWS},Windows{$ENDIF}
  {$IFDEF FPC},dynlibs{$ENDIF}

  ,TaurusTLSConsts,
  IdThreadSafe,
  SysUtils
{$ENDIF}
  ;

{$if not declared(NilHandle)}
const
  NilHandle : TIdLibHandle = 0;
{$ifend}

var
  GOpenSSLLoader: IOpenSSLLoader = nil;
  GLibCryptoLoadList: TList = nil;
  GLibSSLLoadList: TList = nil;
  GUnLoadList: TList = nil;

function GetOpenSSLLoader: IOpenSSLLoader;
begin
  Result := GOpenSSLLoader;
end;

procedure Register_SSLLoader(LoadProc: TOpenSSLLoadProc; const module_name: string);
begin
  if GLibCryptoLoadList = nil then
    GLibCryptoLoadList := TList.Create;
  if GLibSSLLoadList = nil then
     GLibSSLLoadList := TList.Create;

  if module_name = 'LibCrypto' then
    GLibCryptoLoadList.Add(@LoadProc)
  else
  if module_name = 'LibSSL' then
    GLibSSLLoadList.Add(@LoadProc)
  else
    raise ETaurusTLSError.CreateFmt(ROSUnrecognisedLibName,[module_name]);
end;

procedure Register_SSLUnloader(UnloadProc: TOpenSSLUnloadProc);
begin
  if GUnLoadList = nil then
    GUnLoadList := TList.Create;
  GUnLoadList.Add(@UnloadProc);
end;

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
type

  { TOpenSSLLoader }

  TOpenSSLLoader = class(TInterfacedObject, IOpenSSLLoader)
  {$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
    FLibCrypto: TIdLibHandle;
    FLibSSL: TIdLibHandle;
    FOpenSSLPath: string;
    FFailed: TStringList;
    FSSLLibVersions: string;
    FLibraryLoaded: TIdThreadSafeBoolean;
    FFailedToLoad: boolean;
    function FindLibrary(const LibName, LibVersions: string): TIdLibHandle;
    function GetSSLLibVersions: string;
    procedure SetSSLLibVersions(const AValue: string);
    function GetOpenSSLPath: string;
    procedure SetOpenSSLPath(const Value: string);
    function GetFailedToLoad: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    function Load: Boolean;
    procedure Unload;

    property OpenSSLPath: string read GetOpenSSLPath write SetOpenSSLPath;
    property FailedToLoad: TStringList read GetFailedToLoad;
  end;

{ TOpenSSLLoader }

constructor TOpenSSLLoader.Create;
begin
  inherited;
  FFailed := TStringList.Create();
  FLibraryLoaded := TIdThreadSafeBoolean.Create;
  FSSLLibVersions := DefaultLibVersions;
  OpenSSLPath := GetEnvironmentVariable(TaurusTLSLibraryPath)
end;

destructor TOpenSSLLoader.Destroy;
begin
  if FLibraryLoaded <> nil then
    FLibraryLoaded.Free;
  if FFailed <> nil then
    FFailed.Free;
  inherited;
end;

function DoLoadLibrary(const FullLibName: string): TIdLibHandle;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SafeLoadLibrary(FullLibName, {$IFDEF WINDOWS}SEM_FAILCRITICALERRORS {$ELSE} 0 {$ENDIF});
end;

function TOpenSSLLoader.FindLibrary(const LibName, LibVersions: string): TIdLibHandle;
var LibVersionsList: TStringList;
  i: integer;
begin
{Important!!!

Do not load something named libcrypt.dll because that will cause
an access violation.  That is part of the LibreOpenSSL package.}
  {$IFNDEF WINDOWS}
  Result := DoLoadLibrary(OpenSSLPath + LibName);
  if (Result = NilHandle) and (LibVersions <> '') then
  begin
  {$ELSE}
    Result := NilHandle;
  {$ENDIF}
    LibVersionsList := TStringList.Create;
    try
      LibVersionsList.Delimiter := DirListDelimiter;
      LibVersionsList.StrictDelimiter := true;
      LibVersionsList.DelimitedText := LibVersions; {Split list on delimiter}
      for i := 0 to LibVersionsList.Count - 1 do
      begin
        Result := DoLoadLibrary(OpenSSLPath + LibName + LibVersionsList[i]);
        if Result <> NilHandle then
          break;
      end;
    finally
      LibVersionsList.Free;
    end;
  {$IFNDEF WINDOWS}
  end;
  {$ENDIF}
end;


function TOpenSSLLoader.Load: Boolean;
type
  TOpenSSL_version_num = function: TIdC_ULONG; cdecl;

var i: integer;
    OpenSSL_version_num: TOpenSSL_version_num;
    SSLVersionNo: TIdC_ULONG;

begin                                  //FI:C101
  Result := not FFailedToLoad;
  if not Result then
    Exit;
  FLibraryLoaded.Lock();
  try
    if not FLibraryLoaded.Value then
    begin
      FLibCrypto := FindLibrary(CLibCryptoBase + LibSuffix,FSSLLibVersions);
      FLibSSL := FindLibrary(CLibSSLBase + LibSuffix,FSSLLibVersions);
      Result := not (FLibCrypto = IdNilHandle);
      if Result then begin
        Result := not (FLibSSL = IdNilHandle);
      end;
      {$IFDEF WINDOWS}
      if not Result then
      begin
        {try the legacy dll names}
        FLibCrypto := FindLibrary(LegacyLibCrypto,'');
        FLibSSL := FindLibrary(LegacyLibssl,'');
        Result := not (FLibCrypto = IdNilHandle);
        if Result then begin
          Result := not (FLibSSL = IdNilHandle);
        end;
      end;
      {$ENDIF}
      if not Result then
        Exit;

      {Load Version number}
      OpenSSL_version_num := LoadLibFunction(FLibCrypto, 'OpenSSL_version_num');
      if not assigned(OpenSSL_version_num) then
          OpenSSL_version_num := LoadLibFunction(FLibCrypto, 'SSLeay');
      if not assigned(OpenSSL_version_num) then
        raise ETaurusTLSError.Create(ROSSLCantGetSSLVersionNo);

      SSLVersionNo := OpenSSL_version_num();
      if SSLVersionNo < min_supported_ssl_version then
        raise ETaurusTLSError.CreateFmt(RSOSSUnsupportedVersion,[SSLVersionNo]);

      SSLVersionNo := SSLVersionNo shr 12;


      for i := 0 to GLibCryptoLoadList.Count - 1 do
        TOpenSSLLoadProc(GLibCryptoLoadList[i])(FLibCrypto,SSLVersionNo,FFailed);

      for i := 0 to GLibSSLLoadList.Count - 1 do
         TOpenSSLLoadProc(GLibSSLLoadList[i])(FLibSSL,SSLVersionNo,FFailed);

    end;
    FLibraryLoaded.Value := true;
  finally
    FLibraryLoaded.Unlock();
  end;
end;

function TOpenSSLLoader.GetSSLLibVersions: string;
begin
  Result := FSSLLibVersions;
end;

procedure TOpenSSLLoader.SetSSLLibVersions(const AValue: string);
begin
  FSSLLibVersions := AValue;
end;

function TOpenSSLLoader.GetOpenSSLPath: string;
begin
  Result := FOpenSSLPath
end;

procedure TOpenSSLLoader.SetOpenSSLPath(const Value: string);
begin
  if Value = '' then
    FOpenSSLPath := ''
  else
    FOpenSSLPath := IncludeTrailingPathDelimiter(Value);
end;

function TOpenSSLLoader.GetFailedToLoad: TStringList;
begin
  Result := FFailed;
end;

procedure TOpenSSLLoader.Unload;
var i: integer;
begin                            //FI:C101
  FLibraryLoaded.Lock();
  try
    if FLibraryLoaded.Value  then
    begin
      for i := 0 to GUnLoadList.Count - 1 do
         TOpenSSLUnloadProc(GUnLoadList[i]);

      FFailed.Clear();

      if FLibSSL <> NilHandle then
        FreeLibrary(FLibSSL);
      if FLibCrypto <> NilHandle then
        FreeLibrary(FLibCrypto);
      FLibSSL := NilHandle;
      FLibCrypto := NilHandle;
    end;
    FFailedToLoad := false;
    FLibraryLoaded.Value := false;
  finally
    FLibraryLoaded.Unlock();
  end;
end;

{$ENDIF}

initialization
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
  GOpenSSLLoader := TOpenSSLLoader.Create();
{$ENDIF}

finalization
  if GLibCryptoLoadList <> nil then GLibCryptoLoadList.Free;
  if GLibSSLLoadList <> nil then GLibSSLLoadList.Free;
  if GUnLoadList <> nil then GUnLoadList.Free;
end.
