{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 - 2025 TaurusTLS Developers, All Rights Reserved       *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}
{$I TaurusTLSCompilerDefines.inc}
///   <summary>
///   Implements various helpers classes for classes used in the
///   TaurusTLS_SSLContainers unit.
///   </summary>

unit TaurusTLS_SSLContainersHelpers;
{$I TaurusTLSLinkDefines.inc}

interface

uses
  Classes, SysUtils,
  IdGlobal, IdCTypes;

type
  ///  <summary>
  ///  Implements set of methods to <c>wipe out</c> (fill with zeros)
  ///  various data types
  ///  </summary>
  TWiper = class
  protected
    class procedure Wipe(APtr: pointer; ALen: TIdC_SIZET);
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  public
    ///  <summary>
    ///  Fills with <c>zeros</c> variable of
    ///  RawByteString type.
    ///  </summary>
    ///  <param name="AStr">
    ///  A string of RawByteString type.
    ///  </param>
    class procedure Wipe(var AStr: RawByteString);
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Fills with <c>zeros</c> variable of
    ///  <see cref="AnsiString" /> type.
    ///  </summary>
    ///  <param name="AStr">
    ///  A string of <see cref="AnsiString" /> type.
    ///  </param>
    class procedure Wipe(var AStr: AnsiString);
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Fills with <c>zeros</c> variable of
    ///  UTF8String type.
    ///  </summary>
    ///  <param name="AStr">
    ///  A string of UTF8String type.
    ///  </param>
    class procedure Wipe(var AStr: UTF8String);
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Fills with <c>zeros</c> variable of
    ///  <see cref="UnicodeString" /> type.
    ///  </summary>
    ///  <param name="AStr">
    ///  A string of <see cref="UnicodeString" /> type.
    ///  </param>
    class procedure Wipe(var AStr: UnicodeString);
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Fills with <c>zeros</c> variable of
    ///  TBytes type.
    ///  </summary>
    ///  <param name="AData">
    ///  An <c>array of bytes</c> variable (TBytes type).
    ///  </param>
    class procedure Wipe(var AData: TBytes);
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  end;

  ///  <summary>
  ///  Adds set of methods to initialze instances of TBytes
  ///  with various sources
  ///  </summary>
  TBytesFactory = class
  public type
    /// <summary>
    ///  Number of trailing null bytes to add to the <c>array of bytes</c>
    ///  to represent it as a <see cref="PAnsiChar" /> or <see cref="PWideChar" />
    ///  null-terminated string.
    ///  </summary>
    TTrailingNulls = 0..2;
  protected
    ///  <summary>
    ///  Creates <c>array of bytes</c> from content of
    ///  <see cref="UnicodeString" />.
    ///  </summary>
    ///  <param name="AStr">
    ///  An <see cref="UnicodeString" /> which content is copied to the
    ///  <c>array of bytes</c>.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value bytes at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="UnicodeString" />.
    ///  </param>
    ///  <returns>
    ///  <c>Array of bytes</c> filled with content of <see cref="UnicodeString" />.
    ///  Size of <c>array</c> is equal <c>length(AStr)*2</c> if
    ///  <c>AWithTrailingNull</c> parameter value is <c>False</c>,
    ///  or it's equal to <c>(length(AStr)+1)*2</c> otherwise.
    ///  </returns>
    class function CreateUnicode(const AStr: UnicodeString;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates <c>array of bytes</c> from content of
    ///  <see cref="AnsiString" />.
    ///  </summary>
    ///  <param name="AStr">
    ///  An <see cref="AnsiString" /> which content is copied to the
    ///  <c>array of bytes</c>.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="AnsiString" />.
    ///  </param>
    ///  <returns>
    ///  <c>Array of bytes</c> filled with content of <see cref="AnsiString" />.
    ///  Size of <c>array</c> is equal <c>length(AStr)</c> if
    ///  <c>AWithTrailingNull</c> parameter value is <c>False</c>,
    ///  or it's equal to <c>length(AStr)+1</c> otherwise.
    ///  </returns>
    class function CreateAnsi(const AStr: AnsiString;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}
    ///  <summary>
    ///  Converts content of <c>Unicode null-terminated string</c> to the
    ///  <c>array of bytes</c> representing <c>Unicode characters</c> in
    ///  <c>UTF8</c> encoding.
    ///  <remarks>
    ///  This method fills temporary conversion buffer with zeros.
    ///  </remarks>
    ///  </summary>
    ///  <param name="AStr">
    ///  A pointer to the <see cref="UnicodeString" /> null-terminated string.
    ///  </param>
    ///  <param name="ALen">
    ///  A number of <c>Unicode characters</c> to be converted.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value bytes at the end of TBytes
    ///  array. Adding these bytes allows to represent TBytes array
    ///  as null-terminated <see cref="UnicodeString" />.
    ///  </param>
    ///  <returns>
    ///  <c>Array of bytes</c> filled with content of <see cref="UnicodeString" />.
    ///  converted to the sequence of bytes in <c>UTF8 encoding</c>.
    ///  Size of <c>array</c> is vary depending on characters in the <c>AStr</c>
    ///  and <c>AWithTrailingNull</c> parameters.
    ///  </returns>
    class function UnicodeToUTF8(AStr: PWideChar; ALen: integer;
      AWithTrailingNull: boolean): TBytes; static;

    class function CreateFromStream(const AStream: TStream;
      out ABytes: TBytes; ACount: NativeUInt;
      AAddTrailingNulls: TTrailingNulls = 0): NativeUInt;
      overload; static;

    ///  <summary>
    ///  Converts content of <c>Ansi null-terminated string</c> to the
    ///  <c>array of bytes</c> representing <c>Unicode characters</c> in
    ///  <c>UTF8</c> encoding.
    ///  <remarks>
    ///  This method fills temporary conversion buffer with zeros.
    ///  </remarks>
    ///  </summary>
    ///  <param name="AStr">
    ///  A pointer to the <see cref="AnsiString" /> null-terminated string.
    ///  </param>
    ///  <param name="ALen">
    ///  A number of <c>characters</c> to be converted.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value bytes at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="AnsiString" />.
    ///  </param>
    ///  <param name="cp">
    ///  A <c>CodePage</c> of <c>AStr</c> string.
    ///  </param>
    ///  <param name="AWipe">
    ///  Indicates whether a method should fills a temporary converion
    ///  buffer(s) with zeros.
    ///  </param>
    ///  <returns>
    ///  <c>Array of bytes</c> filled with content of <see cref="AnsiString" />.
    ///  converted to the sequence of bytes in <c>UTF8 encoding</c>.
    ///  Size of <c>array</c> is vary depending on CodePage of the <c>AStr</c>
    ///  parameter and <c>AWithTrailingNull</c> parameter values.
    ///  </returns>
{$IFDEF DCC}
    class function AnsiToUTF8(AStr: PAnsiChar; ALen: integer;
      AWithTrailingNull: boolean; cp: cardinal; AWipe: boolean = False): TBytes;
{$ELSE}
    class function AnsiToUTF8(AStr: PAnsiChar; ALen: integer;
      AWithTrailingNull: boolean; cp: TSystemCodePage ;
      AWipe: boolean = False): TBytes;
{$ENDIF}
      static;
    ///  <summary>
    ///  Creates instance of TBytes and copies number of
    ///  <c>ALen</c> bytes from the memory pointed with <c>AData</c>
    ///  into created TBytes array.
    ///  </summary>
    ///  <param name="AData">
    ///  Pointer to the memory region which will be copied to the TBytes
    ///  array.
    ///  </param>
    ///  <param name="ADataLen">
    ///  Number of bytes to be copied from <c>AData</c> into <c>array of bytes</c>.
    ///  </param>
    ///  <param name="AResultLen">
    ///  Size of created array. <br /> If <c>AResultLen</c> is <c>0</c>
    ///  the length of returned <c>array of bytes</c> will be equal
    ///  value of <c>ADataLen</c> parameter.
    ///  copied to it
    ///  </param>
    ///  <remarks>
    ///  Function returns empty array when <c>AData</c> parameter is <c>nil</c>
    ///  </remarks>
    ///  <returns>
    ///  An <c>array of bytes</c> initialized with <c>ADataLen</c> bytes
    ///  from the address pointed in <c>AData</c>
    ///  </returns>
    class function Create(const AData: pointer; ADataLen: NativeUInt;
       AResultLen: NativeUInt = 0): TBytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  public

    ///  <summary>
    ///  Creates instance of TBytes, converts content of
    ///  <c>AStr</c> string to <see cref="UnicodeString" /> and copies its
    ///  conntent into created TBytes array.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="UnicodeString" /> which will be copied to the TBytes
    ///  array.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value bytes at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="UnicodeString" />.
    ///  </param>
    ///  <returns>
    ///  <c>Array of bytes</c> filled with content of <see cref="UnicodeString" />.
    ///  Size of <c>array</c> is a twice bigger than length of <c>AStr</c> as
    ///  each <c>Unicode character</c> occupies two <c>bytes</c>.
    ///  </returns>
    class function Create(const AStr: UnicodeString; AWithTrailingNull: boolean): TBytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, copies conntent of <c>AStr</c>
    ///  into created TBytes array.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="AnsiString" /> which will be copied to the TBytes
    ///  array.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="AnsiString" />.
    ///  </param>
    class function Create(const AStr: AnsiString; AWithTrailingNull: boolean): TBytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes andcopies conntent of <c>AStr</c>
    ///  into created TBytes array.
    ///  </summary>
    ///  <param name="AStr">
    ///  A UTF8String which will be copied to the TBytes
    ///  array.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated UTF8String.
    ///  </param>
    class function Create(const AStr: UTF8String; AWithTrailingNull: boolean): TBytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, converts content of
    ///  <c>AStr</c> string to <see cref="UnicodeString" />, copies its
    ///  conntent into created TBytes array, and fills
    ///  the origianl string with <c>zeros</c>.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="UnicodeString" /> which will be copied to the TBytes
    ///  array.
    ///  The <c>AStr</c> will be filled with <c>zeros</c> after metod returns.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="UnicodeString" />.
    ///  </param>
    class function CreateAndWipe(var AStr: UnicodeString;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, copies conntent of <c>AStr</c>
    ///  into created TBytes array, and fills
    ///  the origianl string with <c>zeros</c>.
    ///  </summary>
    ///  <param name="AStr">
    ///  A RawByteString which will be copied to the TBytes
    ///  array.
    ///  The <c>AStr</c> will be filled with <c>zeros</c> after metod returns.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="AnsiString" />.
    ///  </param>
    class function CreateAndWipe(var AStr: RawByteString;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, copies conntent of <c>AStr</c>
    ///  into created TBytes array, and fills
    ///  the origianl string with <c>zeros</c>.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="AnsiString" /> which will be copied to the TBytes
    ///  array.
    ///  The <c>AStr</c> will be filled with <c>zeros</c> after metod returns.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="AnsiString" />.
    ///  </param>
    class function CreateAndWipe(var AStr: AnsiString;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, copies conntent of <c>AStr</c>
    ///  into created TBytes array, and fills
    ///  the origianl string with <c>zeros</c>.
    ///  </summary>
    ///  <param name="AStr">
    ///  A UTF8String which will be copied to the TBytes
    ///  array.
    ///  The <c>AStr</c> will be filled with <c>zeros</c> after metod returns.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated UTF8String.
    ///  </param>
    class function CreateAndWipe(var AStr: UTF8String;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, converts content of
    ///  <c>AStr</c> string to UTF8String and copies its
    ///  conntent into created TBytes array.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="UnicodeString" /> which will be converted to <c>UTF8</c>
    ///  format and stored it in the the TBytes array.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="UnicodeString" />.
    ///  </param>
    class function CreateAsUTF8(const AStr: UnicodeString;
      AWithTrailingNull: boolean): TBytes; overload; static;

    ///  <summary>
    ///  Creates instance of TBytes, converts content of
    ///  <c>AStr</c> string to UTF8String and copies its
    ///  conntent into created TBytes array.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="AnsiString" /> which will be converted to <c>UTF8</c>
    ///  format using <c>CodePage</c> in parameter <c>cp</c>,
    ///  and stored it in the the TBytes array.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="AnsiString" />.
    ///  </param>
{$IFDEF DCC}
    class function CreateAsUTF8(const AStr: AnsiString;
      AWithTrailingNull: boolean): TBytes; overload; static;
{$ELSE}
    class function CreateAsUTF8(const AStr: AnsiString;
      AWithTrailingNull: boolean): TBytes; overload; static;
{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, converts content of
    ///  <c>AStr</c> string to UTF8String, copies its
    ///  conntent into created TBytes array, and fills
    ///  the origianl string with <c>zeros</c>.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="UnicodeString" /> which will be converted to <c>UTF8</c>
    ///  format and stored it in the the TBytes array.
    ///  The <c>AStr</c> will be filled with <c>zeros</c> after metod returns.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="UnicodeString" />.
    ///  </param>
    class function CreateAsUTF8AndWipe(var AStr: UnicodeString;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes, converts content of
    ///  <c>AStr</c> string to UTF8String, copies its
    ///  conntent into created TBytes array, and fills
    ///  the origianl string with <c>zeros</c>.
    ///  </summary>
    ///  <param name="AStr">
    ///  A <see cref="AnsiString" /> which will be converted to <c>UTF8</c>
    ///  format and stored it in the the TBytes array.
    ///  The <c>AStr</c> will be filled with <c>zeros</c> after metod returns.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Indicates whether to add a zero-value byte at the end of TBytes
    ///  array. Adding this byte allows to represent TBytes array
    ///  as null-terminated <see cref="AnsiString" />.
    ///  </param>
    class function CreateAsUTF8AndWipe(var AStr: AnsiString;
      AWithTrailingNull: boolean): TBytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    /// <summary>
    ///  Creates instance of TBytes with lenght of <c>ACount</c>,
    ///  copies number of <c>bytes</c> from the <c>AStream</c> into
    ///  created TBytes array.
    ///  <para>
    ///  Method copies <c>ACount</c> bytes from the stream specified
    ///  by <c>AStream</c> into the <c>array of bytes</c>. It then moves
    ///  the current position by <c>ACount</c> bytes and returns
    ///  the instance of TBytes.
    ///  </para>
    ///  <para>
    ///  If <c>ACount</c> is 0, method sets <c>AStream</c> position to 0 before reading
    ///  and then copies the entire contents of <c>AStream</c> into
    ///  the <c>array of bytes</c>.
    ///  If <c>ACount</c> is greater than 0, method reads from the current position
    ///  in <c>AStream</c>.
    ///  </para>
    ///  </summary>
    ///  <param name="AStream">
    ///  A TStream which content is copied to the
    ///  the <c>array of bytes</c>.
    ///  </param>
    ///  <param name="ACount">
    ///  Number of <c>bytes</c> to copy from the <c>AStream</c>.
    ///  </param>
    ///  <param name="AAddTrailingNulls">
    ///  Indicates how many trailing null characters to add to the
    ///  <c>array of bytes</c>. Non-zero parameter value allows to cast
    ///  returning <c>array of bytes</c> as null-terminated string.
    ///  <remarks>
    ///  Allowed values are between <c>0</c> and <c>2</c>.
    ///  * <c>0</c> - no null-terminated symbols are added after content
    ///  * <c>1</c> - a single terminated symbols are added after content
    ///  to allow represent the <c>array of bytes</c> as a single-byte or
    ///  multibyte-encoded character string.
    ///  * <c>2</c> - two zero bytes are added after content
    ///  to allow represent the <c>array of bytes</c> as a Unicode (UTF16)
    ///  character string. <br />
    ///  Please note that the content length must have even number of bytes.
    ///  </remarks>
    ///  </param>
    class function Create(const AStream: TStream; ACount: NativeInt;
      AAddTrailingNulls: TTrailingNulls = 0): TBytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates instance of TBytes with lenght of <c>ACount</c>,
    ///  copies number of <c>bytes</c> from the <c>AStream</c> into
    ///  created TBytes array.
    ///  This method fills the memory buffer of instance
    ///  of TMemoryStream class and its descendant(s) with <c>zeros</c>.
    ///  <para>
    ///  Method copies <c>ACount</c> bytes from the stream specified
    ///  by <c>AStream</c> into the <c>array of bytes</c>. It then moves
    ///  the current position by <c>ACount</c> bytes and returns it.
    ///  If <c>AStream</c> as the instance of TMemoryStream,
    ///  method fills TMemoryStream.Memory with zeros
    ///  <c>ACount</c> of bytes starting the initial <c>AStream.Position</c>.
    ///  </para>
    ///  <para>
    ///  If <c>ACount</c> is 0, method sets <c>AStream</c> position to 0 before reading
    ///  and then copies the entire contents of <c>AStream</c> into
    ///  the <c>array of bytes</c> then and returns it.
    ///  If <c>AStream</c> as the instance of TMemoryStream,
    ///  method fills entire TMemoryStream.Memory with zeros.
    ///  If <c>ACount</c> is greater than 0, method reads from the current position
    ///  in <c>AStream</c>.
    ///  </para>
    ///  </summary>
    ///  <param name="AStream">
    ///  A TStream which content is copied to the
    ///  the <c>array of bytes</c>.
    ///  </param>
    ///  <param name="ACount">
    ///  Number of <c>bytes</c> to copy from the <c>AStream</c>.
    ///  </param>
    ///  <param name="AAddTrailingNulls">
    ///  Indicates how many trailing null characters to add to the
    ///  <c>array of bytes</c>. Non-zero parameter value allows to cast
    ///  returning <c>array of bytes</c> as null-terminated string.
    ///  <remarks>
    ///  Allowed values are between <c>0</c> and <c>2</c>.
    ///  * <c>0</c> - no null-terminated symbols are added after content
    ///  * <c>1</c> - a single terminated symbols are added after content
    ///  to allow represent the <c>array of bytes</c> as a single-byte or
    ///  multibyte-encoded character string.
    ///  * <c>2</c> - two zero bytes are added after content
    ///  to allow represent the <c>array of bytes</c> as a Unicode (UTF16)
    ///  character string. <br />
    ///  Please note that the content length must have even number of bytes.
    ///  </remarks>
    ///  </param>
    class function CreateAndWipeMemBuf(const AStream: TStream;
      ACount: NativeInt; AAddTrailingNulls: TTrailingNulls = 0): TBytes;
      overload; static;
  end;

implementation

uses
{$IFDEF DCC}
  System.SysConst,
{$ENDIF}
{$IFDEF FPC}
  rtlconsts,
{$ENDIF}
  TaurusTLS_ResourceStrings;

type
  TStreamHelper = class helper for TStream
    procedure WipeMemoryData(AStart, ACount: Int64);
  end;

{ TStreamHelper }

procedure TStreamHelper.WipeMemoryData(AStart, ACount: Int64);
var
  lStartPos: PByte;

begin
  if not (Self is TMemoryStream) then
    Exit;
  if (AStart+ACount > Size) then
    raise EStreamError.Create(RSMSG_TMemoryStreamWipeOutOfRange);
  lStartPos:=PByte(TMemoryStream(Self).Memory)+AStart;
  TWiper.Wipe(lStartPos, ACount);
end;

{ TWiper }

class procedure TWiper.Wipe(APtr: pointer; ALen: TIdC_SIZET);
begin
  if ALen > 0 then
    FillChar(APtr^, ALen, $0);
end;

class procedure TWiper.Wipe(var AStr: RawByteString);
begin
  // Check if AStr is constant
  if StringRefCount(AStr) >= 0 then
    Wipe(PAnsiChar(AStr), Length(AStr)*SizeOf(AnsiChar));
end;

class procedure TWiper.Wipe(var AStr: UTF8String);
begin
  Wipe(RawByteString(AStr));
end;

class procedure TWiper.Wipe(var AStr: AnsiString);
begin
  Wipe(RawByteString(AStr));
end;

class procedure TWiper.Wipe(var AStr: UnicodeString);
begin
  // Check if AStr is constant
  if StringRefCount(AStr) >= 0 then
    Wipe(PWideChar(AStr), Length(AStr)*SizeOf(WideChar));
end;

class procedure TWiper.Wipe(var AData: TBytes);
var
  lLen: NativeUInt;

begin
  lLen:=Length(AData);
  if lLen > 0 then
    Wipe(PByte(AData), lLen);
end;

{ TBytesHelper }

class function TBytesFactory.CreateUnicode(const AStr: UnicodeString;
  AWithTrailingNull: boolean): TBytes;
var
  lDataLen, lResultLen: NativeUInt;
  lPtr: PWideChar;

begin
  lDataLen:=Length(AStr)*SizeOf(WideChar);
  if lDataLen = 0  then
    lPtr:=nil
  else
    lPtr:=PWideChar(Astr);
  lResultLen:=lDataLen;
  if AWithTrailingNull then
    Inc(lResultLen, SizeOf(WideChar));
  Result:=Create(lPtr, lDataLen, lResultLen);
end;

class function TBytesFactory.CreateAnsi(const AStr: AnsiString;
  AWithTrailingNull: boolean): TBytes;
var
  lDataLen, lResultLen: NativeUInt;
  lPtr: PAnsiChar;

begin
  lDataLen:=Length(AStr)*SizeOf(AnsiChar);
  if lDataLen = 0  then
    lPtr:=nil
  else
    lPtr:=PAnsiChar(Astr);
  lResultLen:=lDataLen;
  if AWithTrailingNull then
    Inc(lResultLen, SizeOf(AnsiChar));
  Result:=Create(lPtr, lDataLen, lResultLen);
end;

class function TBytesFactory.UnicodeToUTF8(AStr: PWideChar; ALen: integer;
  AWithTrailingNull: boolean): TBytes;
{$IFDEF DCC}
var
  lULen, lAdjLen: integer;

begin
  if ALen > 0 then
  begin
    lULen := LocaleCharsFromUnicode(CP_UTF8, 0, AStr, ALen, nil, 0, nil, nil);
    if lULen = 0 then
      raise EEncodingError.Create(RSMSG_UTF8NoMapping);
  end
  else
    lULen:=0;
  lAdjLen := lULen;
  if AWithTrailingNull then
    Inc(lAdjLen);
  SetLength(Result, lAdjLen);
  if lULen > 0 then
    LocaleCharsFromUnicode(CP_UTF8, 0, AStr, ALen, PAnsiChar(Result),
      lAdjLen, nil, nil);
end;
{$ELSE}
var
  lTmp: RawByteString;
  lLen, lAdjLen: SizeUInt;

begin
//  if ALen <= 0 then
//    Exit;
  lLen:=ALen*SizeOf(WideChar);
{$WARN 5091 off}
  WideStringManager.Unicode2AnsiMoveProc(AStr, lTmp, CP_UTF8, ALen);
{$WARN 5091 on}
  try
    lAdjLen:=lLen;
    if AWithTrailingNull then
       Inc(lAdjLen, SizeOf(WideChar));
{$WARN 5093 off}
    SetLength(Result, lAdjLen);
{$WARN 5093 on}
    Move(PChar(lTmp)^, Result[0], lLen);
  finally
    TWiper.Wipe(AStr, lLen);
  end;
end;
{$ENDIF}

{$IFDEF DCC}
class function TBytesFactory.AnsiToUTF8(AStr: PAnsiChar; ALen: integer;
  AWithTrailingNull: boolean; cp: cardinal; AWipe: boolean): TBytes;
var
  lWLen, lAdjLen: integer;
  lTmp: TBytes;

begin
  if cp = CP_UTF8 then
  begin
    lAdjLen:=ALen;
    if AWithTrailingNull then
      Inc(lAdjLen);
    SetLength(Result, lAdjLen);
    if ALen > 0 then
      Move(AStr^, Result[0], ALen);
  end
  else
  if ALen = 0 then
  begin
    if AWithTrailingNull then
      SetLength(Result, 1)
  end
  else
  begin
    lWLen:=UnicodeFromLocaleChars(cp, 0, AStr, ALen, NIL, 0);
    if lWLen = 0 then
      raise EEncodingError.Create(RSMSG_UnicodeNoMapping)
    else
    begin
      SetLength(lTmp, lWLen*SizeOf(WideChar));
      try
        UnicodeFromLocaleChars(cp, 0, AStr, ALen, PWideChar(PByte(lTmp)), lWLen);
        Result:=UnicodeToUTF8(PWideChar(PByte(lTmp)), lWLen, AWithTrailingNull);
      finally
        if AWipe then
          TWiper.Wipe(lTmp);
      end;
    end;
  end;
end;
{$ELSE}
class function TBytesFactory.AnsiToUTF8(AStr: PAnsiChar; ALen: integer;
  AWithTrailingNull: boolean; cp: TSystemCodePage ; AWipe: boolean): TBytes;
var
  lULen: integer;
  lUStr: UnicodeString;

begin
{$WARN 5091 off}
  widestringmanager.Ansi2UnicodeMoveProc(AStr, cp, lUStr, ALen);
{$WARN 5091 on}
  try
    lULen:=Length(lUStr);
    Result:=UnicodeToUTF8(PWideChar(lUstr), lULen, AWithTrailingNull);
  finally
    if AWipe then
      TWiper.Wipe(lUStr);
  end;
end;
{$ENDIF}

class function TBytesFactory.Create(const AData: pointer;
  ADataLen, AResultLen: NativeUInt): TBytes;
begin
  if AResultLen = 0 then
    AResultLen:=ADataLen
  else
  if ADataLen > AResultLen then
    raise ERangeError.CreateRes(@SRangeError);
{$IFDEF FPC}
  {$WARN 5093 off}
{$ENDIF}
  SetLength(Result, AResultLen);
{$IFDEF FPC}
  {$WARN 5093 on}
{$ENDIF}
  if Assigned(AData) then
    Move(AData^, Result[0], ADataLen);
end;

class function TBytesFactory.Create(const AStr: UnicodeString;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=CreateUnicode(AStr, AWithTrailingNull);
end;

class function TBytesFactory.Create(const AStr: AnsiString;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=CreateAnsi(AStr, AWithTrailingNull);
end;

class function TBytesFactory.Create(const AStr: UTF8String;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=CreateAnsi(AnsiString(AStr), AWithTrailingNull);
end;

class function TBytesFactory.CreateAndWipe(var AStr: UnicodeString;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=Create(AStr, AWithTrailingNull);
  TWiper.Wipe(AStr);
end;

class function TBytesFactory.CreateAndWipe(var AStr: RawByteString;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=CreateAndWipe(AnsiString(AStr), AWithTrailingNull);
end;

class function TBytesFactory.CreateAndWipe(var AStr: AnsiString;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=Create(AnsiString(AStr), AWithTrailingNull);
  TWiper.Wipe(AStr);
end;

class function TBytesFactory.CreateAndWipe(var AStr: UTF8String;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=Create(Astr, AWithTrailingNull);
  TWiper.Wipe(AStr);
end;

class function TBytesFactory.CreateAsUTF8(
  const AStr: UnicodeString; AWithTrailingNull: boolean): TBytes;
begin
  Result:=UnicodeToUTF8(PWideChar(AStr), Length(AStr), AWithTrailingNull);
end;

{$IFDEF DCC}
class function TBytesFactory.CreateAsUTF8(const AStr: AnsiString;
  AWithTrailingNull: boolean): TBytes;
{$ELSE}
class function TBytesFactory.CreateAsUTF8(const AStr: AnsiString;
  AWithTrailingNull: boolean): TBytes;
{$ENDIF}
begin
  Result:=AnsiToUTF8(PAnsiChar(AStr), Length(AStr), AWithTrailingNull,
    StringCodePage(AStr), False);
end;

class function TBytesFactory.CreateAsUTF8AndWipe(var AStr: UnicodeString;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=CreateAsUTF8(AStr, AWithTrailingNull);
  TWiper.Wipe(AStr);
end;

class function TBytesFactory.CreateAsUTF8AndWipe(var AStr: AnsiString;
  AWithTrailingNull: boolean): TBytes;
begin
  Result:=CreateAsUTF8(AStr, AWithTrailingNull);
  TWiper.Wipe(AStr);
end;

class function TBytesFactory.CreateFromStream(const AStream: TStream;
  out ABytes: TBytes; ACount: NativeUInt;
  AAddTrailingNulls: TTrailingNulls = 0): NativeUInt;
begin
  if (ACount <= 0) and (not Assigned(AStream)) then
    ACount:=AStream.Size;
  Result:=ACount;
{$IFDEF FPC}
  {$WARN 5092 off}
{$ENDIF}
  SetLength(ABytes, ACount+AAddTrailingNulls);
{$IFDEF FPC}
  {$WARN 5092 on}
{$ENDIF}
  if Result > 0 then
    Result:=AStream.Read(ABytes, ACount);
  if Result < ACount then
    SetLength(ABytes, Result+AAddTrailingNulls);
end;

class function TBytesFactory.Create(const AStream: TStream;
  ACount: NativeInt; AAddTrailingNulls: TTrailingNulls): TBytes;
begin
  CreateFromStream(AStream, Result, ACount, AAddTrailingNulls);
end;

class function TBytesFactory.CreateAndWipeMemBuf(const AStream: TStream;
  ACount: NativeInt; AAddTrailingNulls: TTrailingNulls): TBytes;
var
  lPos: Int64;

begin
  lPos:=AStream.Position;
  AStream.WipeMemoryData(lPos,
    CreateFromStream(AStream, Result, ACount, AAddTrailingNulls));

end;

end.
