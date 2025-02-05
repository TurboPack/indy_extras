{$IF (gsIdVersionMajor < 10)}
{$FATAL Indy Version Unssupported}
{$IFEND}
//is GetURIHost and GetProxyTargetHost supported by Indy's TIdSSLIOHandlerSocketBase
{$UNDEF GETURIHOST_SUPPORTED}
//Indy has TIdSSLVersion
{$UNDEF HAS_TIdSSLVersion}

{$UNDEF TIdC_SIZET_UNDEF}
{$UNDEF TIdLibHandle_UNDEF}

{$IF (gsIdVersionMinor > 6)}
    {$DEFINE GETURIHOST_SUPPORTED}
    {$DEFINE HAS_TIdSSLVersion}
{$ELSE}
  {$IF (gsIdVersionMinor = 6)}
    {$IF (gsIdVersionRelease < 3)}
      {$DEFINE TIdC_SIZET_UNDEF}
      {$DEFINE TIdLibHandle_UNDEF}
      {$DEFINE UTCTimeToLocalTime_UNDEF}
    {$ELSE}
      {$IF (gsIdVersionRelease > 3)}
        {$DEFINE GETURIHOST_SUPPORTED}
        {$DEFINE HAS_TIdSSLVersion}
      {$ELSE}
        {$IF ( gsIdVersionBuild > 6)}
  	      {$DEFINE GETURIHOST_SUPPORTED}
        {$IFEND}
        {$IF ( gsIdVersionBuild > 7)}
          {$DEFINE HAS_TIdSSLVersion}
        {$ELSE}
           {$IF (gsIdVersionMinor > 6)}
             {$DEFINE GETURIHOST_SUPPORTED}
             {$DEFINE HAS_TIdSSLVersion}
             {$DEFINE HAS_RAW_TO_BYTES_64_BIT}
           {$IFEND}
          {$IFEND}
       {$IFEND}
    {$IFEND}
  {$IFEND}
{$IFEND}

