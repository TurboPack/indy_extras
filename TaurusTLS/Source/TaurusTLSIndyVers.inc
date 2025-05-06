{$IF (gsIdVersionMajor < 10)}
{$FATAL Indy Version Unssupported}
{$IFEND}

{$IF (gsIdVersionMinor > 6)}
{$ELSE}
  {$IF (gsIdVersionMinor = 6)}
    {$IF (gsIdVersionRelease < 3)}
      {$DEFINE TIdC_SIZET_UNDEF}
      {$DEFINE UTCTimeToLocalTime_UNDEF}
    {$ELSE}
      {$IF (gsIdVersionRelease > 2)}
        {$DEFINE GETURIHOST_SUPPORTED}
      {$IFEND}
      {$IF (gsIdVersionRelease > 3)}
        {$DEFINE HAS_TIdSSLVersion}
      {$ELSE}
        {$IF ( gsIdVersionBuild > 6)}
  	      {$DEFINE GETURIHOST_SUPPORTED}
        {$IFEND}
           {$IF (gsIdVersionMinor > 6)}
             {$DEFINE GETURIHOST_SUPPORTED}
             {$DEFINE HAS_TIdSSLVersion}
             {$DEFINE HAS_RAW_TO_BYTES_64_BIT}
           {$IFEND}
       {$IFEND}
    {$IFEND}
  {$IFEND}
{$IFEND}

