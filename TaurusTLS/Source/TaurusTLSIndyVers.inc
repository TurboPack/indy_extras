{$IF (gsIdVersionMajor < 10)}
FATAL Indy Version Unssupported
{$IFEND}
//is GetURIHost and GetProxyTargetHost supported by Indy's TIdSSLIOHandlerSocketBase
{$UNDEF GETURIHOST_SUPPORTED}
//Indy has TIdSSLVersion
{$UNDEF HAS_TIdSSLVersion}

{$IF (gsIdVersionMinor = 6)}
  {$IF (gsIdVersionRelease > 3)}
    {$DEFINE GETURIHOST_SUPPORTED}
    {$DEFINE HAS_TIdSSLVersion}
  {$ELSE}
    {$IF ( gsIdVersionBuild > 6)}
	    {$DEFINE GETURIHOST_SUPPORTED}
    {$IFEND}
    {$IF ( gsIdVersionBuild > 7)}
      {$DEFINE HAS_TIdSSLVersion}
    {$IFEND}
  {$IFEND}
{$ELSE}
  {$IF (gsIdVersionMinor > 6)}
    {$DEFINE GETURIHOST_SUPPORTED}
    {$DEFINE HAS_TIdSSLVersion}
  {$IFEND}
{$IFEND}
{$IF (gsIdVersionRelease > 6)}
  {$DEFINE GETURIHOST_SUPPORTED}
{$IFEND}

