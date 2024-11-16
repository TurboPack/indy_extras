unit TaurusTLS_Utils;

interface
{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}
{$I TaurusTLSCompilerDefines.inc}
{$i TaurusTLSLinkDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdGlobalProtocols,
  TaurusTLSHeaders_asn1,
  TaurusTLSHeaders_evp,
  TaurusTLSHeaders_ossl_typ,
  TaurusTLSHeaders_x509v3,
  Classes;

type
  TIdSSLEVP_MD = record
    _Length: TIdC_UINT;
    MD: Array [0 .. EVP_MAX_MD_SIZE - 1] of TIdAnsiChar;
  end;

function ANS1_STRING_ToHexStr(a : PASN1_STRING) : String;
function ASN1_OBJECT_ToStr(a: PASN1_OBJECT): String;
function LogicalAnd(a, B: Integer): Boolean;
function BytesToHexString(APtr: Pointer; ALen: Integer): String;
function MDAsString(const AMD: TIdSSLEVP_MD): String;
function ASN1_Time_Decode(const A: PASN1_TIME;
  out year, month, day, hour, min, sec: Word;
  out tz_hour, tz_min: Integer): Boolean;

function ASN1TimeToDateTime(A : PASN1_TIME) : TDateTime;

function ASN1_ToIPAddress(const a: PASN1_OCTET_STRING): String;
function DirName(const ADirName: PX509_NAME): String;
function GeneralNameToStr(const AGN: PGENERAL_NAME): String;

implementation

uses TaurusTLSHeaders_bio, TaurusTLSHeaders_objects, TaurusTLSHeaders_x509,
  SysUtils;

function LogicalAnd(a, B: Integer): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := (a and B) = B;
end;

function ANS1_STRING_ToHexStr(a : PASN1_STRING) : String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LPtr: PAnsiChar;
  LLen: TIdC_INT;
begin
  Result := '';
  if Assigned(a) then
  begin
    LPtr := PAnsiChar(ASN1_STRING_get0_data(a));
    LLen := ASN1_STRING_length(a);
    Result := BytesToHexString(LPtr, LLen);
  end;
end;

function BytesToHexString(APtr: Pointer; ALen: Integer): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i: Integer;
  LPtr: PByte;
begin
  Result := '';
  LPtr := PByte(APtr);
  for i := 0 to ALen - 1 do
  begin
    if i <> 0 then
    begin
      Result := Result + ':'; { Do not Localize }
    end;
    Result := Result + IndyFormat('%.2x', [LPtr^]);
    Inc(LPtr);
  end;
end;

function MDAsString(const AMD: TIdSSLEVP_MD): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i: TIdC_UINT;
begin
  Result := '';
  for i := 0 to AMD._Length - 1 do
  begin
    if i <> 0 then
    begin
      Result := Result + ':'; { Do not Localize }
    end;
    Result := Result + IndyFormat('%.2x', [Byte(AMD.MD[i])]);
    { do not localize }
  end;
end;

function ASN1_OBJECT_ToStr(a: PASN1_OBJECT): String;
var
  LBuf: array [0 .. 1024] of TIdAnsiChar;
begin
  OBJ_obj2txt(@LBuf[0], 1024, a, 0);
  Result := String(LBuf);
end;

function ASN1_Time_Decode(const A: PASN1_TIME;
  out year, month, day, hour, min, sec: Word;
  out tz_hour, tz_min: Integer): Boolean;
var
  i, tz_dir: Integer;
  time_str: string;
{$IFNDEF USE_MARSHALLED_PTRS}
{$IFNDEF STRING_IS_ANSI}
  LTemp: AnsiString;
{$ENDIF}
{$ENDIF}
begin
  year := 0;
  month := 1;
  day := 1;
  hour := 0;
  min := 0;
  sec := 0;
  tz_hour := 0;
  tz_min := 0;
  Result := False; { default is to return with an error indication }
  if A^._Length < 12 then
  begin
    Exit;
  end;
{$IFDEF USE_MARSHALLED_PTRS}
  time_str := TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(UTCtime^.data),
    UTCtime^._length);
{$ELSE}
{$IFDEF STRING_IS_ANSI}
  SetString(time_str, PAnsiChar(A^.data), A^._length);
{$ELSE}
  SetString(LTemp, PAnsiChar(A^.data), A^._Length);
  { Note: UTCtime is a type defined by OpenSSL and hence is ansistring and not UCS-2 }
  // TODO: do we need to use SetCodePage() here?
  time_str := String(LTemp); // explicit convert to Unicode
{$ENDIF}
{$ENDIF}
  // Check if first 12 chars are numbers
  if not IsNumeric(time_str, 12) then
  begin
    Exit;
  end;
  // Convert time from string to number
  year := IndyStrToInt(Copy(time_str, 1, 2)) + 1900;
  month := IndyStrToInt(Copy(time_str, 3, 2));
  day := IndyStrToInt(Copy(time_str, 5, 2));
  hour := IndyStrToInt(Copy(time_str, 7, 2));
  min := IndyStrToInt(Copy(time_str, 9, 2));
  sec := IndyStrToInt(Copy(time_str, 11, 2));
  // Fix year. This function is Y2k but isn't compatible with Y2k5 :-(    {Do not Localize}
  if year < 1950 then
  begin
    Inc(year, 100);
  end;
  // Check TZ
  tz_hour := 0;
  tz_min := 0;
  if CharIsInSet(time_str, 13, '-+') then
  begin { Do not Localize }
    tz_dir := iif(CharEquals(time_str, 13, '-'), -1, 1); { Do not Localize }
    for i := 14 to 18 do
    begin // Check if numbers are numbers
      if i = 16 then
      begin
        Continue;
      end;
      if not IsNumeric(time_str[i]) then
      begin
        Exit;
      end;
    end;
    tz_hour := IndyStrToInt(Copy(time_str, 14, 15)) * tz_dir;
    tz_min := IndyStrToInt(Copy(time_str, 17, 18)) * tz_dir;
  end;
  Result := True; { everthing OK }
end;

function ASN1TimeToDateTime(A : PASN1_TIME) : TDateTime;
var
  year: Word;
  month: Word;
  day: Word;
  hour: Word;
  min: Word;
  sec: Word;
  tz_h: Integer;
  tz_m: Integer;
begin
  Result := 0;
  if ASN1_Time_Decode(A, year, month, day, hour, min, sec, tz_h, tz_m) then
  begin
    Result := EncodeDate(year, month, day) + EncodeTime(hour, min, sec, 0);
    Result := Result + ( tz_m / (60 * 24));
    Result := Result + ( tz_h / 24.0);
    Result := UTCTimeToLocalTime(Result);
  end;
end;

function DirName(const ADirName: PX509_NAME): String;
var
  i, Le_count: TIdC_INT;
  LE: PX509_NAME_ENTRY;
  LASN1: PASN1_STRING;
  LOBJ: PASN1_OBJECT;
  LPtr: PAnsiChar;
begin
  Result := '';
  Le_count := X509_NAME_entry_count(ADirName);

  for i := 0 to Le_count - 1 do
  begin
    LE := X509_NAME_get_entry(ADirName, i);
    LOBJ := X509_NAME_ENTRY_get_object(LE);
    LASN1 := X509_NAME_ENTRY_get_data(LE);
    LPtr := PAnsiChar(ASN1_STRING_get0_data(LASN1));
    Result := Result + ' ' + ASN1_OBJECT_ToStr(LOBJ) + ' = ' +
      String(LPtr) + ';';
  end;
  Result := Trim(Result);
end;

function ASN1_ToIPAddress(const a: PASN1_OCTET_STRING): String;
{$IFDEF USE_INLINE}inline; {$ENDIF}
var
  LIPv6: TIdIPv6Address;
  i: Integer;
begin
  Result := '';
  if a._length = 4 then
  begin
    Result := IntToStr(a.Data[0]) + '.' + IntToStr(a.Data[1]) + '.' +
      IntToStr(a.Data[2]) + '.' + IntToStr(a.Data[3]);
  end
  else
  begin
    if a._length = 16 then
    begin

      for i := 0 to 7 do
      begin
        LIPv6[i] := (a.Data[i * 2] shl 8) + (a.Data[(i * 2) + 1]);
      end;
      Result := IdGlobal.IPv6AddressToStr(LIPv6);
    end;
  end;
end;

function GeneralNameToStr(const AGN: PGENERAL_NAME): String;
begin
  Result := '';
  case AGN.type_ of
    GEN_OTHERNAME:
      Result := 'Other Name';
    GEN_EMAIL:
      begin
        Result := 'E-Mail: ' + String(PAnsiChar(AGN.d.rfc822Name.Data));
      end;
    GEN_DNS:
      begin
        Result := 'DNS: ' + String(PAnsiChar(AGN.d.dNSName.Data));
      end;
    GEN_X400:
      begin
        Result := 'X400';
      end;
    GEN_DIRNAME:
      begin
        Result := 'Dir Name: ' + DirName(AGN.d.directoryName);
      end;
    GEN_EDIPARTY:
      begin
        Result := 'EDI Party';
      end;
    GEN_URI:
      begin
        Result := 'URI: ' +
          String(PIdAnsiChar(AGN.d.uniformResourceIdentifier.Data));
      end;
    GEN_IPADD:
      begin
        Result := 'IP Address: ' + ASN1_ToIPAddress(AGN.d.iPAddress);
      end;
    GEN_RID:
      Result := 'Registered ID: ' + ASN1_OBJECT_ToStr(AGN.d.rid);
  end;
end;

end.
