{$IFDEF HAS_DEPRECATED}
  {$WARN NO_RETVAL OFF}
{$ENDIF}
{$ifdef fpc}
  {$push}
  {$warn 5024 off} //disable unused parameter
  {$warn 05033 off} //disable no return values
{$endif}
