// TODO: for FreePascal, use {$PUSH} in IdSymbolDeprecatedOff.inc and {$POP} here
{$IFDEF HAS_DEPRECATED}
  {$IFDEF HAS_DIRECTIVE_WARN_DEFAULT}
    {$WARN NO_RETVAL DEFAULT}
  {$ELSE}
    {$WARN NO_RETVAL ON}
  {$ENDIF}
{$ENDIF}
{$ifdef fpc}
  {$pop}
{$endif}

