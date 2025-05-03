  {$IFDEF HAS_DIRECTIVE_WARN_DEFAULT}
    {$WARN NO_RETVAL DEFAULT}
  {$ELSE}
    {$WARN NO_RETVAL ON}
  {$ENDIF}
{$ifdef fpc}
  {$pop}
{$endif}

