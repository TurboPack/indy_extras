unit TaurusTLS.UT.SSLContainersHelpers;

interface

uses
  System.Classes, System.SysUtils, System.IOUtils,
  DUnitX.TestFramework, DUnitX.Types,
  DUnitX.InternalDataProvider, DUnitX.TestDataProvider,
  IdGlobal, IdCTypes,
  TaurusTLS.UT.TestClasses, TaurusTLS_SSLContainersHelpers;

type
  TStreamFactory = class
    // Initializes AStream with content of ABytes
    class function SetupStream(AStream: TStream; ABytes: TBytes): TStream;
      overload; static;
    // Initializes AStream with bytes array converted from HexEncoded string
    class function SetupStream(AStream: TStream; AHexStr: UnicodeString): TStream;
      overload; static;
    // Creates new TMemoryStream instance and allocate memory buffer
    /// of specified size
    class function NewMemoryStream(ASize: Int64 = 0): TStream; static;
    // Creates new TBytesStream instance and allocate empty memory buffer
    /// of specified size
    class function NewBytesStream(ASize: NativeUInt = 0): TStream; overload; static;
    // Creates new TBytesStream instance and initialize it with content of
    // specified bytes array
    class function NewBytesStream(ABytes: TBytes): TStream; overload; static;
    // Creates a new TFileStream instance with specified file mode
    class function NewFileStream(AFileName: string; AMode: word): TStream; static;
    // Saves content of TStream to a file
    class procedure SaveToFile(AFileName: string; AHexStr: UnicodeString;
      AMode: word = fmCreate+fmShareDenyWrite); static;
    // Converts HexEncoded string to bytes array and saves it into file.
    class function SaveToFileTempFile(AHexStr: UnicodeString): string; static;
  end;

//  Hex-encoded UTF16LE string constants for tests cases.
const
  cTestString = // 'Test string'
    '5400650073007400200073007400720069006E006700';
  cLatinChars = // Latin Supplement symbols for CP_1252
    'A100A200A300A400A500A600A700A800A900AA00AB00AC00'+
    'AD00AE00AF00B000B100B200B300B400B500B600B700B800'+
    'B900BA00BB00BC00BD00BE00BF00C000C100C200C300C400'+
    'C500C600C700C800C900CA00CB00CC00CD00CE00CF00D000'+
    'D100D200D300D400D500D600D700D800D900DA00DB00DC00'+
    'DD00DE00DF00E000E100E200E300E400E500E600E700E800'+
    'E900EA00EB00EC00ED00EE00EF00F000F100F200F300F400'+
    'F500F600F700F800F900FA00FB00FC00FD00FE00FF00';
  cCyrChars = // Cyrillyc symols for CP_1251
    '10041104120413041404150416041704180419041A041B04'+
    '1C041D041E041F0420042104220423042404250426042704'+
    '280429042A042B042C042D042E042F043004310432043304'+
    '3404350436043704380439043A043B043C043D043E043F04'+
    '40044104420443044404450446044704480449044A044B04'+
    '4C044D044E044F04';
  cGreekChars = // Greek symbols for CP_1253
    '90039103920393039403950396039703980399039A039B03'+
    '9C039D039E039F03A003A103A303A403A503A603A703A803'+
    'A903AA03AB03AC03AD03AE03AF03B003B103B203B303B403'+
    'B503B603B703B803B903BA03BB03BC03BD03BE03BF03C003'+
    'C103C203C303C403C503C603C703C803C903CA03CB03CC03'+
    'CD03CE03';

  cRBTestString = // 'Test string' in a single byte hex encoding
    '5465737420737472696E67';
  cRBLatinChars = // Latin Supplement for CP_1252 a single byte hex encoding
    'A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8'+
    'B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0'+
    'D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8'+
    'E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF';
  cRBCyrChars = // Cyrillyc symols for CP_1251 in a single-byte encoding
    'C0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7'+
    'D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEF'+
    'F0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF';
  cRBGreekChars = // Greek symbols for CP_1253 in a single-byte encoding
    'C0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D3D4D5D6D7D8'+
    'D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0'+
    'F1F2F3F4F5F6F7F8F9FAFBFCFDFE';

  cUTF8TestString = // 'Test string' in UTF8 encoding
    '54657374737472696E67';
  cUTF8LatinChars =
    'C2A1C2A2C2A3C2A4C2A5C2A6C2A7C2A8C2A9C2AAC2ABC2AC'+
    'C2ADC2AEC2AFC2B0C2B1C2B2C2B3C2B4C2B5C2B6C2B7C2B8'+
    'C2B9C2BAC2BBC2BCC2BDC2BEC2BFC380C381C382C383C384'+
    'C385C386C387C388C389C38AC38BC38CC38DC38EC38FC390'+
    'C391C392C393C394C395C396C397C398C399C39AC39BC39C'+
    'C39DC39EC39FC3A0C3A1C3A2C3A3C3A4C3A5C3A6C3A7C3A8'+
    'C3A9C3AAC3ABC3ACC3ADC3AEC3AFC3B0C3B1C3B2C3B3C3B4'+
    'C3B5C3B6C3B7C3B8C3B9C3BAC3BBC3BCC3BDC3BEC3BF';
  cUTF8CyrChars = // Cyrillyc symbols in UTF8 encoding
    'D090D091D092D093D094D095D096D097D098D099D09AD09B'+
    'D09CD09DD09ED09FD0A0D0A1D0A2D0A3D0A4D0A5D0A6D0A7'+
    'D0A8D0A9D0AAD0ABD0ACD0ADD0AED0AFD0B0D0B1D0B2D0B3'+
    'D0B4D0B5D0B6D0B7D0B8D0B9D0BAD0BBD0BCD0BDD0BED0BF'+
    'D180D181D182D183D184D185D186D187D188D189D18AD18B'+
    'D18CD18DD18ED18F';
  cUTF8GreekChars = // Greek symbols in UTF8 encoding
    'CE90CE91CE92CE93CE94CE95CE96CE97CE98CE99CE9ACE9B'+
    'CE9CCE9DCE9ECE9FCEA0CEA1CEA3CEA4CEA5CEA6CEA7CEA8'+
    'CEA9CEAACEABCEACCEADCEAECEAFCEB0CEB1CEB2CEB3CEB4'+
    'CEB5CEB6CEB7CEB8CEB9CEBACEBBCEBCCEBDCEBECEBFCF80'+
    'CF81CF82CF83CF84CF85CF86CF87CF88CF89CF8ACF8BCF8C'+
    'CF8DCF8E';

type
  [TestFixture]
  [Category('Wiper')]
  // Verifies TWiper class methods
  TWiperFixture = class
  public
    [TestCase('Empty', '')]
    [TestCase('Single_byte', 'e2')]
    [TestCase('''Test string''', cTestString)]
    [TestCase('Latin_Chars', cLatinChars)]
    [TestCase('Cyrillic_Chars', cCyrChars)]
    [TestCase('Greek_Chars', cGreekChars)]
    // Verifies TWipeTestTool.CheckWiped with bytes array
    procedure WipeBytes(AHexStr: string);

    [TestCase('Empty', '')]
    [TestCase('Latin_Chars', cLatinChars)]
    // Verifies TWipeTestTool.CheckWiped with AnsiString
    procedure WipeAnsiStr(AHexStr: string);

    [TestCase('Empty', '')]
    [TestCase('''Test string''', cTestString)]
    [TestCase('Latin_Chars', cLatinChars)]
    [TestCase('Cyrillic_Chars', cCyrChars)]
    [TestCase('Greek_Chars', cGreekChars)]
    // Verifies TWipeTestTool.CheckWiped with UTF8String
    procedure WipeUTF8Str(AHexStr: string);

    [TestCase('Empty', '')]
    [TestCase('Single_byte', 'e2')]
    [TestCase('''Test string''', cTestString)]
    [TestCase('Latin_Chars', cLatinChars)]
    // Verifies TWipeTestTool.CheckWiped with RawByteString
    procedure WipeRawByteStr(AHexStr: string);

    [TestCase('Empty', '')]
    [TestCase('Single_char', '0020')]
    [TestCase('''Test string''', cTestString)]
    [TestCase('Latin_Chars', cLatinChars)]
    [TestCase('Cyrillic_Chars', cCyrChars)]
    [TestCase('Greek_Chars', cGreekChars)]
    // Verifies TWipeTestTool.CheckWiped with UnicodeString
    procedure WipeUnicodeStr(AHexStr: string);
  end;

  [TestFixture]
  [Category('BytesHelper')]
  // Verifies TBytesFactory methods
  TBytesHelpersFixture = class
  public
    [TestCase('Empty_WithoutTermNull',',False')]
    [TestCase('Empty_WithTermNull',',True')]
    [TestCase('English_WithoutTermNull', cTestString+',False')]
    [TestCase('English_WithTermNull', cTestString+',True')]
    [TestCase('Latin_WithoutTermNull', cLatinChars+',False')]
    [TestCase('Latin_WithTermNull', cLatinChars+',True')]
    [TestCase('Cyrillic_WithoutTermNull', cCyrChars+',False')]
    [TestCase('Cyrillic_WithTermNull', cCyrChars+',True')]
    [TestCase('Greek_WithoutTermNull', cGreekChars+',False')]
    [TestCase('Greek_WithTermNull', cGreekChars+',True')]
    // Verifies TBytesFactory.Create method with UnicodeString
    procedure CreateUnicodeStr(AHexStr: string; AWithTrailingNull: boolean);

    [TestCase('CP_ACP_Empty_WithoutTermNull',',False,0')]
    [TestCase('CP_ACP_Empty_WithTermNull',',True,0')]
    [TestCase('CP_ACP_English_WithoutTermNull', cTestString+',False,0')]
    [TestCase('CP_ACP_English_WithTermNull', cTestString+',True,0')]
    [TestCase('CP_1252_Latin_WithoutTermNull', cLatinChars+',False,1252')]
    [TestCase('CP_1252_Latin_WithTermNull', cLatinChars+',True,1252')]
    [TestCase('CP_1251_Cyrillic_WithoutTermNull', cCyrChars+',False,1251')]
    [TestCase('CP_1251_Cyrillic_WithTermNull', cCyrChars+',True,1251')]
    [TestCase('CP_1253_Greek_WithoutTermNull', cGreekChars+',False,1253')]
    [TestCase('CP_1253_Greek_WithTermNull', cGreekChars+',True,1253')]
    // Verifies TBytesFactory.Create method with AnsiString
    procedure CreateAnsiStr(AHexStr: string; AWithTrailingNull: boolean;
      ACodePage: cardinal = CP_ACP);

    [TestCase('Empty_WithoutTermNull',',False')]
    [TestCase('Empty_WithTermNull',',True')]
    [TestCase('English_WithoutTermNull', cTestString+',False')]
    [TestCase('English_WithTermNull', cTestString+',True')]
    [TestCase('Latin_WithoutTermNull', cLatinChars+',False')]
    [TestCase('Latin_WithTermNull', cLatinChars+',True')]
    [TestCase('Cyrillic_WithoutTermNull', cCyrChars+',False')]
    [TestCase('Cyrillic_WithTermNull', cCyrChars+',True')]
    [TestCase('Greek_WithoutTermNull', cGreekChars+',False')]
    [TestCase('Greek_WithTermNull', cGreekChars+',True')]
    // Verifies TBytesFactory.Create method with UTF8String
    procedure CreateUTF8Str(AHexStr: string; AWithTrailingNull: boolean);

    [TestCase('Empty_WithoutTermNull',',False')]
    [TestCase('Empty_WithTermNull',',True')]
    [TestCase('English_WithoutTermNull', cTestString+',False')]
    [TestCase('English_WithTermNull', cTestString+',True')]
    [TestCase('Latin_WithoutTermNull', cLatinChars+',False')]
    [TestCase('Latin_WithTermNull', cLatinChars+',True')]
    [TestCase('Cyrillic_WithoutTermNull', cCyrChars+',False')]
    [TestCase('Cyrillic_WithTermNull', cCyrChars+',True')]
    [TestCase('Greek_WithoutTermNull', cGreekChars+',False')]
    [TestCase('Greek_WithTermNull', cGreekChars+',True')]
    // Verifies TBytesFactory.CreateAndWipe method with UnicodeString
    procedure CreateAndWipeUnicodeStr(AHexStr: string; AWithTrailingNull: boolean);

    [TestCase('English_WithoutTermNull', cRBTestString+',False')]
    [TestCase('English_WithTermNull', cRBTestString+',True')]
    [TestCase('Lanin_WithoutTermNull', cRBLatinChars+',False')]
    [TestCase('Latin_WithTermNull', cRBLatinChars+',True')]
    [TestCase('Cyrillic_WithoutTermNull', cRBCyrChars+',False')]
    [TestCase('Cyrillic_WithTermNull', cRBCyrChars+',True')]
    [TestCase('Greek_WithoutTermNull', cRBGreekChars+',False')]
    [TestCase('Greek_WithTermNull', cRBGreekChars+',True')]
    // Verifies TBytesFactory.CreateAndWipe method with RawByteString
    procedure CreateAndWipeRBStr(AHexStr: string; AWithTrailingNull: boolean);

    [TestCase('CP_ACP_Empty_WithoutTermNull',',False,0')]
    [TestCase('CP_ACP_Empty_WithTermNull',',True,0')]
    [TestCase('CP_ACP_English_WithoutTermNull', cTestString+',False,0')]
    [TestCase('CP_ACP_English_WithTermNull', cTestString+',True,0')]
    [TestCase('CP_1252_Latin_WithoutTermNull', cLatinChars+',False,1252')]
    [TestCase('CP_1252_Latin_WithTermNull', cLatinChars+',True,1252')]
    [TestCase('CP_1251_Cyrillic_WithoutTermNull', cCyrChars+',False,1251')]
    [TestCase('CP_1251_Cyrillic_WithTermNull', cCyrChars+',True,1251')]
    [TestCase('CP_1253_Greek_WithoutTermNull', cGreekChars+',False,1253')]
    [TestCase('CP_1253_Greek_WithTermNull', cGreekChars+',True,1253')]
    // Verifies TBytesFactory.CreateAndWipe method with AnsiString
    procedure CreateAndWipeAnsiStr(AHexStr: string; AWithTrailingNull: boolean;
      ACodePage: cardinal = CP_ACP);

    [TestCase('Empty_WithoutTermNull',',False')]
    [TestCase('Empty_WithTermNull',',True')]
    [TestCase('English_WithoutTermNull', cTestString+',False')]
    [TestCase('English_WithTermNull', cTestString+',True')]
    [TestCase('Latin_WithoutTermNull', cLatinChars+',False')]
    [TestCase('Latin_WithTermNull', cLatinChars+',True')]
    [TestCase('Cyrillic_WithoutTermNull', cCyrChars+',False')]
    [TestCase('Cyrillic_WithTermNull', cCyrChars+',True')]
    [TestCase('Greek_WithoutTermNull', cGreekChars+',False')]
    [TestCase('Greek_WithTermNull', cGreekChars+',True')]
    // Verifies TBytesFactory.CreateAndWipe method with UTF8String
    procedure CreateAndWipeUTF8Str(AHexStr: string; AWithTrailingNull: boolean);

    [TestCase('Empty_WithoutTermNull',',False')]
    [TestCase('Empty_WithTermNull',',True')]
    [TestCase('English_WithoutTermNull', cTestString+',False')]
    [TestCase('English_WithTermNull', cTestString+',True')]
    [TestCase('Latin_WithoutTermNull', cLatinChars+',False')]
    [TestCase('Latin_WithTermNull', cLatinChars+',True')]
    [TestCase('Cyrillic_WithoutTermNull', cCyrChars+',False')]
    [TestCase('Cyrillic_WithTermNull', cCyrChars+',True')]
    [TestCase('Greek_WithoutTermNull', cGreekChars+',False')]
    [TestCase('Greek_WithTermNull', cGreekChars+',True')]
    // Verifies TBytesFactory.CreateAsUTF8 method with UnicodeString
    procedure CreateAsUTF8UnicodeStr(AHexStr: string; AWithTrailingNull: boolean);

    [TestCase('CP_ACP_Empty_WithoutTermNull',',False,0')]
    [TestCase('CP_ACP_Empty_WithTermNull',',True,0')]
    [TestCase('CP_ACP_English_WithoutTermNull', cTestString+',False,0')]
    [TestCase('CP_ACP_English_WithTermNull', cTestString+',True,0')]
    [TestCase('CP_1252_Latin_WithoutTermNull', cLatinChars+',False,1252')]
    [TestCase('CP_1252_Latin_WithTermNull', cLatinChars+',True,1252')]
    [TestCase('CP_1251_Cyrillic_WithoutTermNull', cCyrChars+',False,1251')]
    [TestCase('CP_1251_Cyrillic_WithTermNull', cCyrChars+',True,1251')]
    [TestCase('CP_1253_Greek_WithoutTermNull', cGreekChars+',False,1253')]
    [TestCase('CP_1253_Greek_WithTermNull', cGreekChars+',True,1253')]
    // Verifies TBytesFactory.CreateAsUTF8 method with AnsiString
    procedure CreateAsUTF8AnsiStr(AHexStr: string; AWithTrailingNull: boolean;
      ACodePage: cardinal = CP_ACP);

    [TestCase('Empty_WithoutTermNull',',False')]
    [TestCase('Empty_WithTermNull',',True')]
    [TestCase('English_WithoutTermNull', cTestString+',False')]
    [TestCase('English_WithTermNull', cTestString+',True')]
    [TestCase('Latin_WithoutTermNull', cLatinChars+',False')]
    [TestCase('Latin_WithTermNull', cLatinChars+',True')]
    [TestCase('Cyrillic_WithoutTermNull', cCyrChars+',False')]
    [TestCase('Cyrillic_WithTermNull', cCyrChars+',True')]
    [TestCase('Greek_WithoutTermNull', cGreekChars+',False')]
    [TestCase('Greek_WithTermNull', cGreekChars+',True')]
    // Verifies TBytesFactory.CreateAsUTF8AndWipe method with UnicodeString
    procedure CreateAsUTF8AndWipeUnicodeStr(AHexStr: string;
      AWithTrailingNull: boolean);

    [TestCase('CP_ACP_Empty_WithoutTermNull',',False,0')]
    [TestCase('CP_ACP_Empty_WithTermNull',',True,0')]
    [TestCase('CP_ACP_English_WithoutTermNull', cTestString+',False,0')]
    [TestCase('CP_ACP_English_WithTermNull', cTestString+',True,0')]
    [TestCase('CP_1252_Latin_WithoutTermNull', cLatinChars+',False,1252')]
    [TestCase('CP_1252_Latin_WithTermNull', cLatinChars+',True,1252')]
    [TestCase('CP_1251_Cyrillic_WithoutTermNull', cCyrChars+',False,1251')]
    [TestCase('CP_1251_Cyrillic_WithTermNull', cCyrChars+',True,1251')]
    [TestCase('CP_1253_Greek_WithoutTermNull', cGreekChars+',False,1253')]
    [TestCase('CP_1253_Greek_WithTermNull', cGreekChars+',True,1253')]
    // Verifies TBytesFactory.CreateAsUTF8AndWipe method with AnsiString
    procedure CreateAsUTF8AndWipeAnsiStr(AHexStr: string; AWithTrailingNull: boolean;
      ACodePage: cardinal = CP_ACP);
  end;

  [TestFixture]
  [Category('BytesHelperStream')]
  // Verifies TBytesFactory stream methods
  TBytesHelpersStreamFixture = class
  public type
    TTrailingNulls = TBytesFactory.TTrailingNulls;
  private
    FStream: TStream;
    procedure FreeStream;
    procedure SetStream(AStream: TStream);
  protected
    // CHeck whether FStream is ready for use
    procedure CheckStream;
    property Stream: TStream read FStream write SetStream;
  public
    [Teardown]
    procedure Teardown;

    [TestCase('Empty_WithoutTermNull',',0,0,0')]
    [TestCase('Empty_WithOneTermNull',',0,0,1')]
    [TestCase('Empty_WithTwoTermNulls',',0,0,2')]
    [TestCase('English_WithoutTermNull_ReadAll', cTestString+',0,0,0')]
    [TestCase('English_WithTwoTermNulls_ReadAll', cTestString+',0,0,2')]
    [TestCase('English_WithoutTermNull_Read_2_6', cTestString+',2,6,0')]
    [TestCase('English_WithTwoTermNulls_Read_1_8', cTestString+',1,8,2')]
    [TestCase('Latin_WithoutTermNull_Read_8_64', cLatinChars+',0,8,64')]
    [TestCase('Latin_WithOneTermNull_Read_16_32', cLatinChars+',1,16,32')]
    // Verifies TBytesFactory.Create method with TStream parameter
    procedure CreateFromStream(AHexStr: UnicodeString; AOffset, ACount: Int64;
      AAddTrailingNulls: TTrailingNulls);

    [AutoNameTestCase('256,248,16,2')]
    [AutoNameTestCase('256,272,256,1')]
    [AutoNameTestCase('256,272,0,2')]
    // Verifies TBytesFactory.Create method attemting to read
    // out of the stream size
    procedure CreateFormStreamOutOfRange(ASize, AReadOffset, AReadCount: Int64;
      AAddTrailingNulls: TTrailingNulls);

    [TestCase('Empty_WithoutTermNull',',0,0,0')]
    [TestCase('Empty_WithOneTermNull',',0,0,1')]
    [TestCase('Empty_WithTwoTermNulls',',0,0,2')]
    [TestCase('English_WithoutTermNull_ReadAll', cTestString+',0,0,0')]
    [TestCase('English_WithTwoTermNulls_ReadAll', cTestString+',0,0,2')]
    [TestCase('English_WithoutTermNull_Read_2_6', cTestString+',2,6,0')]
    [TestCase('English_WithTwoTermNulls_Read_1_8', cTestString+',1,8,2')]
    [TestCase('Latin_WithoutTermNull_Read_8_64', cLatinChars+',0,8,64')]
    [TestCase('Latin_WithOneTermNull_Read_16_32', cLatinChars+',1,16,32')]
    // Verifies TBytesFactory.CreateAndWipeMemBuf method
    procedure CreateFromStreamAndWipe(AHexStr: UnicodeString;
      AOffset, ACount: Int64; AAddTrailingNulls: TTrailingNulls);
  end;

implementation

{ TWiperFixture }

procedure TWiperFixture.WipeBytes(AHexStr: string);
var
  lBytes: TBytes;
  lLen: NativeUInt;

begin
  THexStrTestTool.FromHex(AHexStr, lBytes);
  lLen:=Length(lBytes);
  TWiper.Wipe(lBytes);
  TWipeTestTool.CheckWiped(lBytes, lLen);
end;

procedure TWiperFixture.WipeAnsiStr(AHexStr: string);
var
  lStr: AnsiString;

begin
  THexStrTestTool.FromHex(AHexStr, CP_ACP, lStr);
  TWiper.Wipe(lStr);
  TWipeTestTool.CheckWiped(lStr);
end;

procedure TWiperFixture.WipeRawByteStr(AHexStr: string);
var
  lStr: RawByteString;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  TWiper.Wipe(lStr);
  TWipeTestTool.CheckWiped(lStr);
end;

procedure TWiperFixture.WipeUTF8Str(AHexStr: string);
var
  lStr: UTF8String;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  TWiper.Wipe(lStr);
  TWipeTestTool.CheckWiped(AnsiString(lStr));
end;

procedure TWiperFixture.WipeUnicodeStr(AHexStr: string);
var
  lStr: UnicodeString;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  TWiper.Wipe(lStr);
  TWipeTestTool.CheckWiped(lStr);
end;

{ TStreamFactory }

class function TStreamFactory.SetupStream(AStream: TStream;
  ABytes: TBytes): TStream;
begin
  Assert.IsNotNull(AStream, 'AStream shouldn''t be ''nil''.');
  Result:=AStream;
  AStream.Size:=0;
  AStream.Write(ABytes, Length(ABytes));
end;

class function TStreamFactory.SetupStream(AStream: TStream;
  AHexStr: UnicodeString): TStream;
var
  lBytes: TBytes;

begin
  Result:=AStream;
  THexStrTestTool.FromHex(AHexStr, lBytes);
  SetupStream(AStream, lBytes);
end;

class function TStreamFactory.NewMemoryStream(ASize: Int64): TStream;
begin
  Result:=TMemoryStream.Create;
  TMemoryStream(Result).SetSize(ASize);
end;

class function TStreamFactory.NewBytesStream(ASize: NativeUInt): TStream;
var
  lBytes: TBytes;

begin
  SetLength(lBytes, ASize);
  Result:=NewBytesStream(lBytes);
end;

class function TStreamFactory.NewBytesStream(ABytes: TBytes): TStream;
begin
  Result:=TBytesStream.Create(ABytes);
end;

class function TStreamFactory.NewFileStream(AFileName: string;
  AMode: word): TStream;
begin
  Result:=TFileStream.Create(AFileName, AMode);
end;

class procedure TStreamFactory.SaveToFile(AFileName: string;
  AHexStr: UnicodeString; AMode: word);
var
  lStream: TStream;

begin
  lStream:=nil;
  try
    lStream:=NewFileStream(AFileName, AMode);
    SetupStream(lStream, AHexStr);
  finally
    lStream.Free;
  end;
end;

class function TStreamFactory.SaveToFileTempFile(
  AHexStr: UnicodeString): string;
var
  lFileName: string;

begin
  lFileName:=TPath.GetTempFileName;
  try
    SaveToFile(lFileName, AHexStr, fmOpenWrite+fmShareExclusive)
  except
    TFile.Delete(lFileName);
  end;

end;

{ TBytesHelpersFixture }

procedure TBytesHelpersFixture.CreateUnicodeStr(AHexStr: string;
  AWithTrailingNull: boolean);
var
  lStr: string;
  lBytes: TBytes;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  lBytes:=TBytesFactory.Create(lStr, AWithTrailingNull);
  Assert.IsTrue(not Odd(Length(lBytes)), 'Array length must be even.');
  TBytesValidator.AreEqual(lBytes, lStr, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAnsiStr(AHexStr: string;
  AWithTrailingNull: boolean; ACodePage: cardinal);
var
  lStr: AnsiString;
  lBytes: TBytes;

begin
  THexStrTestTool.FromHex(AHexStr, ACodePage, lStr);
  lBytes:=TBytesFactory.Create(lStr, AWithTrailingNull);
  TBytesValidator.AreEqual(lBytes, RawByteString(lStr), AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateUTF8Str(AHexStr: string;
  AWithTrailingNull: boolean);
var
  lStr: UTF8String;
  lBytes: TBytes;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  lBytes:=TBytesFactory.Create(lStr, AWithTrailingNull);
  TBytesValidator.AreEqual(lBytes, RawByteString(lStr), AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAndWipeUnicodeStr(AHexStr: string;
  AWithTrailingNull: boolean);
var
  lBytes: TBytes;
  lStr, lCopyStr: string;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  THexStrTestTool.FromHex(AHexStr, lCopyStr);
  lBytes:=TBytesFactory.CreateAndWipe(lCopyStr, AWithTrailingNull);
  TWipeTestTool.CheckWiped(lCopyStr);
  Assert.IsTrue(not Odd(Length(lBytes)), 'Array length must be even.');
  TBytesValidator.AreEqual(lBytes, lStr, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAndWipeRBStr(AHexStr: string;
  AWithTrailingNull: boolean);
var
  lBytes: TBytes;
  lStr, lCopyStr: RawByteString;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  THexStrTestTool.FromHex(AHexStr, lCopyStr);
  lBytes:=TBytesFactory.CreateAndWipe(lCopyStr, AWithTrailingNull);
  TWipeTestTool.CheckWiped(lCopyStr);
  TBytesValidator.AreEqual(lBytes, lStr, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAndWipeAnsiStr(AHexStr: string;
  AWithTrailingNull: boolean; ACodePage: cardinal);
var
  lBytes: TBytes;
  lStr, lCopyStr: AnsiString;

begin
  THexStrTestTool.FromHex(AHexStr, ACodePage, lStr);
  THexStrTestTool.FromHex(AHexStr, ACodePage, lCopyStr);
  lBytes:=TBytesFactory.CreateAndWipe(lCopyStr, AWithTrailingNull);
  TWipeTestTool.CheckWiped(lCopyStr);
  TBytesValidator.AreEqual(lBytes, lStr, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAndWipeUTF8Str(AHexStr: string;
  AWithTrailingNull: boolean);
var
  lBytes: TBytes;
  lStr, lCopyStr: UTF8String;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  THexStrTestTool.FromHex(AHexStr, lCopyStr);
  lBytes:=TBytesFactory.CreateAndWipe(lCopyStr, AWithTrailingNull);
  TWipeTestTool.CheckWiped(AnsiString(lCopyStr));
  TBytesValidator.AreEqual(lBytes, lStr, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAsUTF8UnicodeStr(AHexStr: string;
  AWithTrailingNull: boolean);
var
  lBytes: TBytes;
  lStr: string;
  lUTF8Str: UTF8String;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  THexStrTestTool.FromHex(AHexStr, lUTF8Str);
  lBytes:=TBytesFactory.CreateAsUTF8(lStr, AWithTrailingNull);
  TBytesValidator.AreEqual(lBytes, lUTF8Str, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAsUTF8AnsiStr(AHexStr: string;
  AWithTrailingNull: boolean; ACodePage: cardinal = CP_ACP);
var
  lBytes: TBytes;
  lStr: AnsiString;
  lUTF8Str: UTF8String;

begin
  THexStrTestTool.FromHex(AHexStr, ACodePage, lStr);
  THexStrTestTool.FromHex(AHexStr, lUTF8Str);
  lBytes:=TBytesFactory.CreateAsUTF8(lStr, AWithTrailingNull);
  TBytesValidator.AreEqual(lBytes, lUTF8Str, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAsUTF8AndWipeUnicodeStr(AHexStr: string;
  AWithTrailingNull: boolean);
var
  lBytes: TBytes;
  lStr, lCopyStr: string;
  lUTF8Str: UTF8String;

begin
  THexStrTestTool.FromHex(AHexStr, lStr);
  THexStrTestTool.FromHex(AHexStr, lCopyStr);
  THexStrTestTool.FromHex(AHexStr, lUTF8Str);
  lBytes:=TBytesFactory.CreateAsUTF8AndWipe(lCopyStr, AWithTrailingNull);
  TWipeTestTool.CheckWiped(lCopyStr);
  TBytesValidator.AreEqual(lBytes, lUTF8Str, AWithTrailingNull);
end;

procedure TBytesHelpersFixture.CreateAsUTF8AndWipeAnsiStr(AHexStr: string;
  AWithTrailingNull: boolean; ACodePage: cardinal);
var
  lBytes: TBytes;
  lStr, lCopyStr: AnsiString;
  lUTF8Str: UTF8String;

begin
  THexStrTestTool.FromHex(AHexStr, ACodePage, lStr);
  THexStrTestTool.FromHex(AHexStr, ACodePage, lCopyStr);
  THexStrTestTool.FromHex(AHexStr, lUTF8Str);
  lBytes:=TBytesFactory.CreateAsUTF8AndWipe(lCopyStr, AWithTrailingNull);
  TWipeTestTool.CheckWiped(lCopyStr);
  TBytesValidator.AreEqual(lBytes, lUTF8Str, AWithTrailingNull);
end;

{ TBytesHelpersStreamFixture }

procedure TBytesHelpersStreamFixture.CheckStream;
begin
  Assert.IsNotNull(FStream, 'Stream is ''nil''. Unable to execute test.');
end;

procedure TBytesHelpersStreamFixture.FreeStream;
var
  lFileName: string;

begin
  if not Assigned(FStream) then
    Exit;
  if FStream is TFileStream then
    lFileName:=TFileStream(FStream).FileName
  else
    lFileName:='';
  try
    FreeAndNil(FStream);
  finally
    if not lFileName.IsEmpty then
      TFile.Delete(lFileName);
  end;
end;

procedure TBytesHelpersStreamFixture.SetStream(AStream: TStream);
begin
  if AStream = FStream then
    Exit;
  FreeStream;
  FStream:=AStream;
  CheckStream;
end;

procedure TBytesHelpersStreamFixture.Teardown;
begin
  FreeStream;
end;

procedure TBytesHelpersStreamFixture.CreateFromStream(AHexStr: UnicodeString;
  AOffset, ACount: Int64; AAddTrailingNulls: TTrailingNulls);
var
  lBytes, lReadBytes: TBytes;
  lBLen: NativeUInt;

begin
  THexStrTestTool.FromHex(AHexStr, lBytes);
  lBLen:=Length(lBytes);
  if (AOffset = 0) and (ACount = 0) then
    ACount:=lBLen;
  Assert.IsTrue(lBLen >= AOffset+ACount,
    Format('Read size is bigger than source data. Source Size: %d bytes, '+
      'Read request is between %d and %d bytes.',
      [lBLen, AOffset, AOffset+ACount]));

  Stream:=TStreamFactory.NewBytesStream(lBytes);
  Stream.Position:=AOffset;
  lReadBytes:=TBytesFactory.Create(Stream, ACount, AAddTrailingNulls);
  Assert.AreEqual<Int64>(ACount, Length(lReadBytes)-AAddTrailingNulls,
    'Number of requested and actaully read bytes are not equal.');

  TBytesValidator.CalcOffsetAndSize(Stream, AOffset, ACount);
  TBytesValidator.AreEqual(lReadBytes, lBytes, AOffset, AAddTrailingNulls);
end;

procedure TBytesHelpersStreamFixture.CreateFormStreamOutOfRange(ASize,
  AReadOffset, AReadCount: Int64; AAddTrailingNulls: TTrailingNulls);
var
  lBytes, lReadBytes: TBytes;
  i: NativeUInt;

begin
  Assert.IsTrue(ASize > 0,
    'ASize should be greater than zero. Test can''t be executed.');
  // Initialize test bytes array
  SetLength(lBytes, ASize);
  Randomize;
  for i:=Low(byte) to ASize-1 do
    lBytes[i]:=Byte(Random(255));

  // Create, initialize and position TByteStream
  Stream:=TStreamFactory.NewBytesStream(lBytes);
  Stream.Position:=AReadOffset;
  lReadBytes:=TBytesFactory.Create(Stream, AReadCount, AAddTrailingNulls);

  // Calculate expected Read offset and Read count based on the Stream size
  TBytesValidator.CalcOffsetAndSize(Stream, AReadOffset, AReadCount);
  // Compare lReadBytes array and subarry from lBytes starting AReadOffset positon
  TBytesValidator.AreEqual(lReadBytes, lBytes, AReadOffset, AAddTrailingNulls);
end;

procedure TBytesHelpersStreamFixture.CreateFromStreamAndWipe(
  AHexStr: UnicodeString; AOffset, ACount: Int64;
  AAddTrailingNulls: TTrailingNulls);
var
  lBytes, lCopyBytes, lReadBytes: TBytes;
  lBLen, lReadLen: Int64;

begin
  THexStrTestTool.FromHex(AHexStr, lBytes);
  THexStrTestTool.FromHex(AHexStr, lCopyBytes);
  lBLen:=Length(lBytes);
  if (AOffset = 0) and (ACount = 0) then
    ACount:=lBLen;
  Assert.IsTrue(lBLen >= AOffset+ACount,
    Format('Read size is bigger than source data. Source Size: %d bytes, '+
      'Read request is between %d and %d bytes.',
      [lBLen, AOffset, AOffset+ACount]));

  Stream:=TStreamFactory.NewBytesStream(lBytes);
  Stream.Position:=AOffset;
  lReadBytes:=TBytesFactory.CreateAndWipeMemBuf(Stream, ACount, AAddTrailingNulls);
  lReadLen:=Length(lReadBytes);
  Assert.AreEqual<Int64>(ACount, Length(lReadBytes)-AAddTrailingNulls,
    'Number of requested and actaully read bytes are not equal.');

  TBytesValidator.CalcOffsetAndSize(lCopyBytes, AOffset, ACount);
  TBytesValidator.AreEqual(lReadBytes, lCopyBytes, AOffset, AAddTrailingNulls);

  TWipeTestTool.CheckWiped(lBytes, AOffset, ACount);
  TBytesValidator.AreEqual(lBytes, lCopyBytes, 0, 0, AOffset);
  TBytesValidator.AreEqual(lBytes, lCopyBytes,
    AOffset+lReadLen-AAddTrailingNulls, AOffset+lReadLen-AAddTrailingNulls,
    lBLen-AOffset-lReadLen-AAddTrailingNulls);
end;

// To avoid false positive "memory leak" error we explicitly initialize
// TEncoding.Unicode.
procedure InitEncoding;
begin
  TEncoding.Unicode;
end;


initialization
  TDUnitX.RegisterTestFixture(TWiperFixture);
  TDUnitX.RegisterTestFixture(TBytesHelpersFixture);
  TDUnitX.RegisterTestFixture(TBytesHelpersStreamFixture);

  InitEncoding;

end.
