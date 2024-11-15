{$IF gsIdVersionMajor < 10}
FATAL Indy Version Unssupported
{$IFEND}
//is GetURIHost and GetProxyTargetHost supported by Indy's TIdSSLIOHandlerSocketBase
{$UNDEF GETURIHOST_SUPPORTED}


{$IF (gsIdVersionMinor = 6)}
  {$IF (gsIdVersionRelease > 3)}
    {$DEFINE GETURIHOST_SUPPORTED}
  {$ELSE}
    {$IF ( gsIdVersionRelease = 3)}
	    {$IF ( gsIdVersionBuild > 6)}
	      {$DEFINE GETURIHOST_SUPPORTED}
	    {$IFEND}
	  {$IFEND}
  {$IFEND}
{$IFEND}
{$IF (gsIdVersionRelease > 6)}
  {$DEFINE GETURIHOST_SUPPORTED}
{$IFEND}

