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
    [TestCase('AValue=''$$$$$$$$$$$$$$$$''', '$$$$$$$$$$$$$$$$')]
    procedure Test_BIO_new_mem_buf(const AValue: RawByteString);
    [TestCase('AValue=''$'',AChunkLen=3', '$, 3')]
    [TestCase('AValue=''$$$$$$$$$$$$$$$$'',AChunkLen=3',
      '$$$$$$$$$$$$$$$$, 3')]
    [TestCase('AValue=''0123456789'',AChunkLen=2', '0123456789,2')]
    procedure Test_BIO_read(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [TestCase('AValue=''$$$$$$$$$$$$$$$$'',ChnkLen=3',
      '$$$$$$$$$$$$$$$$, 3')]
    [TestCase('Value=''0123456789'',AChunkLen=2', '0123456789,2')]
    procedure Test_BIO_read_ex(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [TestCase('ALength=4096,AChunkLen=256', '4096,256')]
    [TestCase('ALength=8177,AChunkLen=513', '8177,513')]
    procedure Test_Random_BIO_read(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
    [TestCase('ALength=4096,AChunkLen=256', '4096,256')]
    [TestCase('ALength=8177,AChunkLen=513', '8177,513')]
    procedure Test_Random_BIO_read_ex(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
    [TestCase('AValue=''$'',AChunkLen=3', '$, 3')]
    [TestCase('AValue=''$$$$$$$$$$$$$$$$'',AChunkLen=3',
      '$$$$$$$$$$$$$$$$, 3')]
    [TestCase('AValue=''0123456789'',AChunkLen=2', '0123456789,2')]
    procedure Test_BIO_write(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [TestCase('AValue=''$$$$$$$$$$$$$$$$'',ChnkLen=3',
      '$$$$$$$$$$$$$$$$, 3')]
    procedure Test_BIO_write_ex(const AValue: RawByteString; AChunkLen: TIdC_SIZET);
    [TestCase('ALength=4096,AChunkLen=256', '4096,256')]
    [TestCase('ALength=8177,AChunkLen=513', '8177,513')]
    procedure Test_Random_BIO_write(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
    [TestCase('ALength=4096,AChunkLen=256', '4096,256')]
    [TestCase('ALength=8177,AChunkLen=513', '8177,513')]
    procedure Test_Random_BIO_write_ex(ALength: NativeUInt; AChunkLen: TIdC_SIZET);
  end;

implementation

uses
  System.SysUtils, System.Hash, TaurusTLSExceptionHandlers;

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
    repeat
      if AChunkLen > lLen then
        AChunkLen:=lLen;
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

initialization
  TDUnitX.RegisterTestFixture(TBioReadWriteFixture);

end.
