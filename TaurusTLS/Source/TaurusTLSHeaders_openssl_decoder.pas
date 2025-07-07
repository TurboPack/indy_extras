/// <exclude />
(* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_asyncerr.h2pas
  It should not be modified directly. All changes should be made to TaurusTLSHeaders_asyncerr.h2pas
  and this file regenerated. TaurusTLSHeaders_asyncerr.h2pas is distributed with the full Indy
  Distribution.
*)

{$I TaurusTLSCompilerDefines.inc}
{$I TaurusTLSLinkDefines.inc}
{$IFNDEF USE_OPENSSL}
{ error Should not compile if USE_OPENSSL is not defined!!! }
{$ENDIF}
{ ****************************************************************************** }
{ *  TaurusTLS                                                                 * }
{ *           https://github.com/JPeterMugaas/TaurusTLS                        * }
{ *                                                                            * }
{ *  Copyright (c) 2025 TaurusTLS Developers, All Rights Reserved              * }
{ *                                                                            * }
{ * Portions of this software are Copyright (c) 1993 – 2018,                   * }
{ * Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  * }
{ ****************************************************************************** }
unit TaurusTLSHeaders_openssl_decoder;

interface
uses
  IdCTypes,
  IdGlobal,
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  TaurusTLSConsts,
{$ENDIF}
  TaurusTLSHeaders_core,
  TaurusTLSHeaders_types;

type
  POSSL_DECODER_INSTANCE = Pointer;

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
{$ELSE}
{$ENDIF}

implementation
uses
  classes,
  TaurusTLSExceptionHandlers
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
    , TaurusTLSLoader
{$ENDIF};

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

{$I TaurusTLSNoRetValOff.inc}
{$I TaurusTLSNoRetValOn.inc}

{$I TaurusTLSUnusedParamOff.inc}
procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT;
  const AFailed: TStringList);
begin

end;

{$I TaurusTLSUnusedParamOn.inc}

procedure Unload;
begin

end;

initialization

Register_SSLLoader(@Load, 'LibCrypto');
Register_SSLUnloader(@Unload);
{$ENDIF}

end.
