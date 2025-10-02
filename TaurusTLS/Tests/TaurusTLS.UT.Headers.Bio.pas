unit TaurusTLS.UT.Headers.Bio;

interface

uses
  DUnitX.TestFramework, TaurusTLS.UT.TestClasses,
  IdGlobal, IdCTypes, TaurusTLSHeaders_types, TaurusTLSHeaders_bio;

type
  [TestFixture]
  [Category('BIO')]
  TBioReadWriteFixture = class(TOsslBaseFixture)
  protected type
    TBIO_ReadProc = reference to function(const ABio: PBio;
      var AData; AChunkLen: TIdC_SIZET): TIdC_SIZET;
    TBIO_WriteProc = reference to function(const ABio: PBio;
      const AData; AChunkLen: TIdC_SIZET): TIdC_SIZET;
  protected
    class function GetRandomStr(ALen: TIdC_SIZET):RawByteString; static; inline;
    procedure Do_BIO_read(const AValue: RawByteString; AChunkLen: TIdC_SIZET;
      ABioProc: TBIO_ReadProc);
    procedure Do_BIO_write(const AValue: RawByteString; AChunkLen: TIdC_SIZET;
      ABioProc: TBIO_WriteProc);
  public
    [AutoNameTestCase('$$$$$$$$$$$$$$$$')]
    procedure Test_BIO_new_mem_buf(const AValue: RawByteString);
    [AutoNameTestCase('$$$$$$$$$$$$$$$$')]
    procedure Test_BIO_new_mem_ref(const AValue: RawByteString);
    [AutoNameTestCase('$,3')]
    [AutoNameTestCase('$$$$$$$$$$$$$$$$,3')]
    [AutoNameTestCase('0123456789,2')]
    procedure Test_BIO_read(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('$$$$$$$$$$$$$$$$, 3')]
    [AutoNameTestCase('0123456789,2')]
    procedure Test_BIO_read_ex(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('4096,256')]
    [AutoNameTestCase('8177,513')]
    procedure Test_Random_BIO_read(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('4096,256')]
    [AutoNameTestCase('8177,513')]
    procedure Test_Random_BIO_read_ex(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('$,3')]
    [AutoNameTestCase('$$$$$$$$$$$$$$$$, 3')]
    [AutoNameTestCase('0123456789,2')]
    procedure Test_BIO_write(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('$$$$$$$$$$$$$$$$, 3')]
    procedure Test_BIO_write_ex(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('4096,256')]
    [AutoNameTestCase('8177,513')]
    procedure Test_Random_BIO_write(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('4096,256')]
    [AutoNameTestCase('8177,513')]
    procedure Test_Random_BIO_write_ex(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
    [AutoNameTestCase('host:service, BIO_PARSE_PRIO_HOST')]
    [AutoNameTestCase('host:, BIO_PARSE_PRIO_HOST')]
    [AutoNameTestCase(':service, BIO_PARSE_PRIO_HOST')]
    procedure Test_BIO_parse_hostserv(AHostServicePair: RawByteString;
      APriority: BIO_hostserv_priorities);
  end;

implementation

uses
  System.AnsiStrings, System.SysUtils, System.Hash,
  TaurusTLSExceptionHandlers, TaurusTLSHeaders_crypto;

{ TBioReadWriteDixture }

class function TBioReadWriteFixture.GetRandomStr(ALen: TIdC_SIZET): RawByteString;
begin
  Result:=THash.GetRandomString(ALen);
end;

procedure TBioReadWriteFixture.Do_BIO_read(const AValue: RawByteString;
  AChunkLen: TIdC_SIZET; ABioProc: TBIO_ReadProc);
var
  lBio: PBIO;
  lLen: TIdC_INT;
  lPos: TIdC_INT;
  lRemainLen, lTestLen: TIdC_SIZET;
  lReadLen: TIdC_SIZET;
  lData, lTest: RawByteString;

begin
  lBio:=nil;
  Assert.AreNotEqual<TIdC_SIZET>(0, AChunkLen, 'AChunkLen = 0');
  lLen:=Length(AValue);
  Assert.AreNotEqual<TIdC_SIZET>(0, lLen, 'Lenght(AValue) = 0');
  try
    lBio:=BIO_new_mem_buf(AValue[1], lLen);
    Assert.IsNotNull(lBio, 'lBio is ''nil''');
    lPos:=1;
    lRemainLen:=lLen;
    if AChunkLen > lLen then
      AChunkLen:=lLen;
    repeat
      lTestLen:=lRemainLen;
      if lTestLen > AChunkLen then
        lTestLen:=AChunkLen;

      SetLength(lData, AChunkLen);
      lReadLen:=ABioProc(lBio, lData[1], AChunkLen);
      Assert.AreEqual<TIdC_SIZET>(lTestLen, lReadLen, 'BIO_read');
      SetLength(lData, lReadLen);
      lTest:=Copy(AValue, lPos, lTestLen);
      Assert.AreEqual(lTest, lData, '''lTest'' and ''lData'' are not equal');

      Inc(lPos, lReadLen);
      Assert.IsTrue(lPos <= lLen+1, 'Read outside the boundary: lPos > lLen');
      Dec(lRemainLen, lReadLen);
    until lRemainLen < 1;
    // Force to read outside the buffer size
    SetLength(lData, AChunkLen);
    lReadLen:=ABioProc(lBio, lData[1], AChunkLen);
    Assert.AreEqual<TIdC_SIZET>(0, lReadLen, 'Read outside the boundary: lReadLen');
  finally
    BIO_free(lBio);
  end;
end;

procedure TBioReadWriteFixture.Do_BIO_write(const AValue: RawByteString;
  AChunkLen: TIdC_SIZET; ABioProc: TBIO_WriteProc);
var
  lBio: PBIO;
  lLen: TIdC_INT;
  lPos: TIdC_INT;
  lTestLen: TIdC_SIZET;
  lWriteLen, lBufLen: TIdC_SIZET;
  lBufPtr: Pointer;

begin
  lBio:=nil;
  Assert.AreNotEqual<TIdC_SIZET>(0, AChunkLen, 'AChunkLen = 0');
  lLen:=Length(AValue);
  Assert.AreNotEqual<TIdC_SIZET>(0, lLen, 'Lenght(AValue) = 0');
  try
//    lBio:=BIO_new_mem_buf(AValue, lLen);
    lBio:=BIO_new(BIO_s_mem());
    Assert.IsNotNull(lBio, 'lBio is ''nil''');
    lPos:=0;
    repeat
      lTestLen:=lLen-lPos;
      if lTestLen > AChunkLen then
        lTestLen:=AChunkLen;

      lWriteLen:=ABioProc(lBio, AValue[lPos+1], lTestLen);
      Assert.AreEqual<TIdC_SIZET>(lTestLen, lWriteLen, 'BIO_write');
      lBufLen:=BIO_get_mem_data(lBio, lBufPtr);
      Inc(lPos, lWriteLen);
      Assert.IsTrue(lPos <= lBufLen,
        'Write Buffer shoreter than current position (lPos > lBufLen)');
      Assert.IsTrue(CompareMem(@AValue[1], lBufPtr, lPos),
        'Source and Write Buffer are not equal.)');
    until lPos >= lLen;
  finally
    BIO_free(lBio);
  end;
end;

procedure TBioReadWriteFixture.Test_BIO_new_mem_buf(const AValue: RawByteString);
var
  lBio: PBIO;
  lLen, lDataLen: TIdC_INT;
  lData: Pointer;

begin
  lBio:=nil;
  lLen:=Length(AValue);
  Assert.AreNotEqual<TIdC_INT>(0, lLen, 'Lenght(AValue) = 0');
  try
    lBio:=BIO_new_mem_buf(AValue[1], lLen);
    Assert.IsNotNull(lBio, 'lBio is ''nil''');
    lDataLen:=BIO_get_mem_data(lBio, lData);
    Assert.AreEqual<TIdC_INT>(lLen, lDataLen, 'BIO_get_mem_data(lBio, lData) <> 1');
    Assert.AreEqual<pointer>(@AValue[1], lData, '@AValue and lData are not equal');
  finally
    BIO_free(lBio);
  end;
end;

type
  // https://github.com/openssl/openssl/blob/bde55d421b1f49e31248c240efe50ff1f0d24141/include/openssl/buffer.h#L42
  PBUF_MEMM = ^TBUF_MEMM;
  TBUF_MEMM = record
    length: TIdC_SIZET;
    data: PIdAnsiChar;
    max: TIdC_SIZET;
    flags: TIdC_UINT;
  end;

procedure TBioReadWriteFixture.Test_BIO_new_mem_ref(const AValue: RawByteString);
var
  lBio: PBIO;
  lLen: TIdC_INT;
  lRef: PBUF_MEM;
  lData: PIdAnsiChar;

begin
  lBio:=nil;
  lLen:=Length(AValue);
  Assert.AreNotEqual<TIdC_INT>(0, lLen, 'Lenght(AValue) = 0');
  try
    lBio:=BIO_new_mem_buf(AValue[1], lLen);
    Assert.IsNotNull(lBio, 'lBio is ''nil''');
    Assert.AreEqual<TIdC_INT>(1, BIO_get_mem_ptr(lBio, lRef), 'BIO_get_mem_ptr');
    Assert.AreEqual<TIdC_INT>(lLen, PBUF_MEMM(lRef)^.length,
      '@AValue[1] <> PBUF_MEMM(lRef)^.length');
    Assert.AreEqual<pointer>(@AValue[1], PBUF_MEMM(lRef)^.data,
      '@AValue[1] <> PBUF_MEMM(lRef)^.data');
  finally
    BIO_free(lBio);
  end;
end;

procedure TBioReadWriteFixture.Test_BIO_read(const AValue: RawByteString;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_read(AValue, AChunkLen,
    function(const ABio: PBio;
      var AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    begin
      Result:=BIO_read(ABio, AData, AChunkLen);
    end
  );
end;

procedure TBioReadWriteFixture.Test_Random_BIO_read(ALength: NativeUInt;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_read(GetRandomStr(ALength), AChunkLen,
    function(const ABio: PBio;
      var AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    begin
      Result:=BIO_read(ABio, AData, AChunkLen);
    end
  );
end;

procedure TBioReadWriteFixture.Test_BIO_read_ex(const AValue: RawByteString;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_read(AValue, AChunkLen,
    function(const ABio: PBio;
      var AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    begin
      BIO_read_ex(ABio, AData, AChunkLen, Result);
    end
  );
end;

procedure TBioReadWriteFixture.Test_Random_BIO_read_ex(ALength: NativeUInt;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_read(GetRandomStr(ALength), AChunkLen,
    function(const ABio: PBio;
      var AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    begin
      BIO_read_ex(ABio, AData, AChunkLen, Result);
    end
  );
end;

procedure TBioReadWriteFixture.Test_BIO_write(const AValue: RawByteString;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_write(AValue, AChunkLen,
    function(const ABio: PBio;
      const AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    var
      lResult: TIdC_SSIZET;
    begin
      lResult:=BIO_write(ABio, AData, AChunkLen);
      if lResult < 0 then
        ETaurusTLSAPICryptoError.RaiseException
      else
        Result:=lResult;
    end
  );
end;

procedure TBioReadWriteFixture.Test_BIO_write_ex(const AValue: RawByteString;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_write(AValue, AChunkLen,
    function(const ABio: PBio;
      const AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    var
      lResult: TIdC_SSIZET;
    begin
      lResult:=BIO_write_ex(ABio, AData, AChunkLen, Result);
      Assert.AreEqual<TIdC_SSIZET>(1, lResult, 'BIO_write_ex');
    end
  );
end;

procedure TBioReadWriteFixture.Test_Random_BIO_write(ALength: NativeUInt;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_write(GetRandomStr(ALength), AChunkLen,
    function(const ABio: PBio;
      const AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    var
      lResult: TIdC_SSIZET;
    begin
      lResult:=BIO_write(ABio, AData, AChunkLen);
      if lResult < 0 then
        ETaurusTLSAPICryptoError.RaiseException
      else
        Result:=lResult;
    end
  );
end;

procedure TBioReadWriteFixture.Test_Random_BIO_write_ex(ALength: NativeUInt;
  AChunkLen: TIdC_SIZET);
begin
  Do_BIO_write(GetRandomStr(ALength), AChunkLen,
    function(const ABio: PBio;
      const AData; AChunkLen: TIdC_SIZET): TIdC_SIZET
    var
      lResult: TIdC_SSIZET;
    begin
      lResult:=BIO_write_ex(ABio, AData, AChunkLen, Result);
      Assert.AreEqual<TIdC_SSIZET>(1, lResult, 'BIO_write_ex');
    end
  );
end;


// This test is not designed for a IPv6 address in the 'host' part yet.
// This test verifies that paramerers values are passed to the 'BIO_parse_hostserv'
// and returned from correctly.
procedure TBioReadWriteFixture.Test_BIO_parse_hostserv(
  AHostServicePair: RawByteString; APriority: BIO_hostserv_priorities);

  procedure Compare(AStr: RawByteString; AChars: PIdAnsiChar; AItem: string);
  begin
    if Assigned(AChars) then
    begin
      Assert.AreEqual(0, System.AnsiStrings.StrComp(PAnsiChar(AStr), AChars),
        Format('Returned %s part is not equal to input value'+
          '''%s'' <> ''%s''', [AItem, AChars, AStr]));
    end
    else
      Assert.IsEmpty(AStr,
        Format('Returned %s part is empty, but should be ''%s''', [AItem, AStr]));
  end;

var
  lStrings: TArray<string>;
  lPair: string;
  lHost, lService: RawByteString;
  lHostOut, lServiceOut: PIdAnsiChar;
  lLen: integer;

begin
  lPair:=AHostServicePair;
  lLen:=Length(lPair);
  Assert.AreNotEqual<TIdC_INT>(0, lLen, 'Lenght(AHostServicePair) = 0');
  Assert.AreNotEqual(':', lPair, 'AHostServicePair should not be '':''');
  lStrings:=lPair.Split([':']);
  lLen:=Length(lStrings);
  Assert.AreEqual(2, lLen,
    Format('AHostServicePair should consists of 1 or 2 elements'+
      ' devided by '':''. Actually it consists of %d elements', [lLen]));
  lHost:=lStrings[0];
  lService:=lStrings[1];
  try
    Assert.AreEqual<TIdC_INT>(1, BIO_parse_hostserv(PIdAnsiChar(AHostServicePair),
      lHostOut, lServiceOut, APriority), 'BIO_parse_hostserv');
    Compare(lHost, lHostOut, 'host');
    Compare(lService, lServiceOut, 'service');
  finally
    if Assigned(lHostOut) then
      OPENSSL_free(lHostOut);
    if Assigned(lServiceOut) then
      OPENSSL_free(lServiceOut);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TBioReadWriteFixture);

end.
