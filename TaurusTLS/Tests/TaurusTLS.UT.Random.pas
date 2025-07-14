unit TaurusTLS.UT.Random;

interface

uses
  System.SysUtils, System.Generics.Collections,
  DUnitX.TestFramework, TaurusTLS_Random, TaurusTLS.UT.TestClasses,
  IdGlobal, IdCTypes, TaurusTLSHeaders_types;


type
  TRandomSrc = (rsPrivate, rsPublic);
  [TestFixture]
  TOSSLRandomFixture = class(TOsslBaseFixture)
  private
    function GetRandomBytes(ASource: TRandomSrc; ACtx: POSSL_LIB_CTX;
      AStrength: TIdC_UINT): TTaurusTLS_CustomOSSLRandomBytes;
    function GetOSSLRandom(ASource: TRandomSrc): TTaurusTLS_OSSLRandom;
    procedure CheckOsslResult(AResult: TIdC_INT);
    procedure RandomT<T: record>(Source: TRandomSrc; Items: TIdC_SIZET);
  public
    [TestCase('Source=rsPrivate;Items=5;Size=1024', 'rsPrivate,5,1024')]
    [TestCase('Source=rsPublic;Items=5;Size=1024', 'rsPublic,5,1024')]
    procedure RandomMemory(Source: TRandomSrc; Items, Size: TIdC_SIZET);
    [TestCase('Source=rsPrivate;Items=5;Size=1024', 'rsPrivate,5,1024')]
    [TestCase('Source=rsPublic;Items=5;Size=1024', 'rsPublic,5,1024')]
    procedure RandomBytes(Source: TRandomSrc; Items, Size: TIdC_SIZET);
    [TestCase('Source=rsPrivate;Items=5;Size=1024', 'rsPrivate,5,1024')]
    [TestCase('Source=rsPublic;Items=5;Size=1024', 'rsPublic,5,1024')]
    procedure RandomBoundary(Source: TRandomSrc; Items, Size: TIdC_SIZET);
    [TestCase('Source=rsPrivate;Items=5;Size=1024', 'rsPrivate,5,1024')]
    [TestCase('Source=rsPublic;Items=5;Size=1024', 'rsPublic,5,1024')]
    procedure RandomByte(Source: TRandomSrc; Items, Size: TIdC_SIZET);
    [TestCase('Source=rsPrivate;Items=5;Size=1024', 'rsPrivate,5,1024')]
    [TestCase('Source=rsPublic;Items=5;Size=1024', 'rsPublic,5,1024')]
    procedure RandomInt(Source: TRandomSrc; Items, Size: TIdC_SIZET);
    [TestCase('Source=rsPrivate;Items=5;Size=1024', 'rsPrivate,5,1024')]
    [TestCase('Source=rsPublic;Items=5;Size=1024', 'rsPublic,5,1024')]
    procedure RandomInt64(Source: TRandomSrc; Items, Size: TIdC_SIZET);
    [TestCase('Source=rsPrivate;Items=5;Size=1024', 'rsPrivate,5,1024')]
    [TestCase('Source=rsPublic;Items=5;Size=1024', 'rsPublic,5,1024')]
    procedure RandomExtended(Source: TRandomSrc; Items, Size: TIdC_SIZET);
  end;

  TBytesList = TList<TBytes>;

  TTools = class
    class function CompareMem(const A, B; Size: TIdC_SIZET): boolean; static;
    class procedure CompareMemTrue(const A, B; Size: TIdC_SIZET;
      Msg: string = ''); static;
    class procedure CompareMemFalse(const A, B; Size: TIdC_SIZET;
      Msg: string = ''); static;
    class procedure CompareBytesListTrue(const List: TBytesList); static;
    class procedure CompareBytesListFalse(const List: TBytesList); static;

    class procedure CompareTrue<T: record>(const A, B: T;
      Msg: string = ''); static;
    class procedure CompareFalse<T: record>(const A, B: T;
      Msg: string = ''); static;
    class procedure CompareListTrue<T: record>(const List: TList<T>); static;
    class procedure CompareListFalse<T: record>(const List: TList<T>); static;
  end;

implementation

uses
  TaurusTLSHeaders_err;

{ TTools }

class function TTools.CompareMem(const A, B; Size: TIdC_SIZET): boolean;
begin
  Result:=System.SysUtils.CompareMem(@A, @B, Size);
end;

class procedure TTools.CompareMemTrue(const A, B; Size: TIdC_SIZET; Msg: string);
begin
  Assert.IsTrue(CompareMem(A, B, Size), Format(Msg, [@A, @B]));
end;

class procedure TTools.CompareMemFalse(const A, B; Size: TIdC_SIZET;
  Msg: string);
begin
  Assert.IsFalse(CompareMem(A, B, Size), Format(Msg, [@A, @B]));
end;

class procedure TTools.CompareBytesListTrue(const List: TBytesList);
begin
  var lCount:=List.Count;
  for var x := 0 to lCount - 1 do
    for var y := x + 1 to lCount - 1 do
    begin
      var lBytesA:=List.Items[x];
      var lBytesB:=List.Items[y];
      CompareMemTrue(lBytesA[0], lBytesB[0], Length(lBytesA),
        Format('List.Items[%d] is equal to List.Items[%d]', [x, y]));
    end;
end;

class procedure TTools.CompareTrue<T>(const A, B: T; Msg: string = '');
begin
  CompareMemTrue(A, B, SizeOf(T), Msg);
end;

class procedure TTools.CompareFalse<T>(const A, B: T; Msg: string = '');
begin
  CompareMemFalse(A, B, SizeOf(T), Msg);
end;

class procedure TTools.CompareListTrue<T>(const List: TList<T>);
begin
  var lCount:=List.Count;
  for var x := 0 to lCount - 1 do
    for var y := x + 1 to lCount - 1 do
    begin
      var lA:=List.Items[x];
      var lB:=List.Items[y];
      CompareTrue<T>(lA, lB,
        Format('List.Items[%d] is equal to List.Items[%d]', [x, y]));
    end;
end;

class procedure TTools.CompareListFalse<T>(const List: TList<T>);
begin
  var lCount:=List.Count;
  for var x := 0 to lCount - 2 do
    for var y := Succ(x) to lCount - 1 do
    begin
      var lA:=List.Items[x];
      var lB:=List.Items[y];
      CompareFalse<T>(lA, lB,
        Format('List.Items[%d] is equal to List.Items[%d]', [x, y]));
    end;
end;

class procedure TTools.CompareBytesListFalse(const List: TBytesList);
begin
  var lCount:=List.Count;
  for var x := 0 to lCount - 2 do
    for var y := Succ(x) to lCount - 1 do
    begin
      var lBytesA:=List.Items[x];
      var lBytesB:=List.Items[y];
      CompareMemFalse(lBytesA[0], lBytesB[0], Length(lBytesA),
        Format('List.Items[%d] is equal to List.Items[%d]', [x, y]));
    end;
end;

{ TOSSLRandomFixture }

function TOSSLRandomFixture.GetRandomBytes(ASource: TRandomSrc;
  ACtx: POSSL_LIB_CTX; AStrength: TIdC_UINT): TTaurusTLS_CustomOSSLRandomBytes;
begin
  case ASource of
    rsPrivate:
      Result:=TTaurusTLS_OSSLPrivateRandomBytes.Create(ACtx, AStrength);
    rsPublic:
      Result:=TTaurusTLS_OSSLPublicRandomBytes.Create(ACtx, AStrength);
  end;
end;

function TOSSLRandomFixture.GetOSSLRandom(
  ASource: TRandomSrc): TTaurusTLS_OSSLRandom;
begin
  case ASource of
    rsPrivate:
      Result:=TTaurusTLS_OSSLRandom.PrivateRandom;
    rsPublic:
      Result:=TTaurusTLS_OSSLRandom.PublicRandom;
  end;
end;

procedure TOSSLRandomFixture.RandomMemory(Source: TRandomSrc; Items, Size: TIdC_SIZET);
begin
  Assert.IsTrue(Items > 0, 'Items value must be greater than 0.');
  Assert.IsTrue(Size >= 2, 'Size value must be greater or equal 2.');
  var lList: TBytesList:=nil;
  try
    lList:=TList<TBytes>.Create;
    for var i:=0 to Items-1 do
    begin
      var lBytes: TBytes;
      SetLength(lBytes, Size);
      CheckOsslResult(GetOSSLRandom(Source).Random(PByte(@lBytes[0])^, Size));
      lList.Add(lBytes);
    end;

    TTools.CompareBytesListFalse(lList);
  finally
    FreeAndNil(lList);
  end;
end;

procedure TOSSLRandomFixture.RandomT<T>(Source: TRandomSrc; Items: TIdC_SIZET);
var
  lList: TList<T>;
  var i, x, y: TIdC_SIZET;
begin
  Assert.IsTrue(Items > 2, 'Items value must be greater than 2.');
  lList:=nil;
  try
    lList:=TList<T>.Create;
    for i:=0 to Items-1 do
    begin
      var lVal: T;
      CheckOsslResult(GetOSSLRandom(Source).Random<T>(lVal));
      lList.Add(lVal);
    end;

    for x := 0 to Items-2 do
      for y := Succ(x) to Items-1 do
        Assert.AreNotEqual(lList[x], lList[y],
          Format('Elements %d and %d are equal.', [x, y]));
  finally
    lList.Free;
  end;
end;

procedure TOSSLRandomFixture.RandomBytes(Source: TRandomSrc; Items, Size: TIdC_SIZET);
begin
  Assert.IsTrue(Items > 0, 'Items value must be greater than 0.');
  Assert.IsTrue(Size >= 2, 'Size value must be greater or equal 2.');
  var lList: TBytesList:=nil;
  try
    lList:=TList<TBytes>.Create;
    for var i:=0 to Items-1 do
    begin
      var lBytes: TBytes;
      SetLength(lBytes, Size);
      CheckOsslResult(GetOSSLRandom(Source).Random(lBytes, Size));
      lList.Add(lBytes);
    end;

    TTools.CompareBytesListFalse(lList);
  finally
    FreeAndNil(lList);
  end;
end;

procedure TOSSLRandomFixture.CheckOsslResult(AResult: TIdC_INT);
begin
  var lErrStr := '';
  if AResult <> 1 then
    lErrStr := Format('OpenSSL Error: %x', [ERR_get_error]);
  Assert.AreEqual(1, AResult, lErrStr);
end;

procedure TOSSLRandomFixture.RandomBoundary(Source: TRandomSrc;
  Items, Size: TIdC_SIZET);
const
  cExt = 4;

type
  TNonZeroSet = set of 0..cExt;

var
  lBytes: TBytes;
  lLowLeft, lLowRight, lHighLeft, lHighRight: TNonZeroSet;

  procedure CheckZeros(Idx, Count: TIdC_SIZET; var AResult: TNonZeroSet);
  begin
    for var i:=0 to Count-1 do // check if any zeros are in the last 4 bytes
      if (lBytes[Idx+i] <> 0) then
        Include(AResult, i);
  end;

begin
  Assert.IsTrue(Items > 2, 'Items value must be greater than 2.');
  Assert.IsTrue(Size >= cExt*2,
    Format('Size value must be greater or equal %d.', [cExt*2]));
  Assert.IsTrue(Size <= High(TIdC_SIZET)-cExt,
    Format('Size value must be greater or equal %d.', [High(TIdC_SIZET)-cExt]));
  SetLength(lBytes, Size+cExt*2);
  lLowLeft:=[]; lLowRight:=[];
  lHighLeft:=[]; lHighRight:=[];

  for var i := 0 to Items-1 do
  begin
    CheckOsslResult(GetOSSLRandom(Source).Random(PByte(@lBytes[cExt])^, Size));
    CheckZeros(0, cExt, lLowLeft);
    CheckZeros(cExt, cExt, lLowRight);
    CheckZeros(Size, cExt, lHighLeft);
    CheckZeros(Size+cExt, cExt, lHighRight);

  end;
  Assert.IsTrue(lLowLeft = [], 'Random procedure overfill lower boundary.');
  Assert.IsTrue(lLowRight <> [], 'Random procedure underfill lower boundary.');
  Assert.IsTrue(lHighLeft <> [], 'Random procedure underfill upper boundary.');
  Assert.IsTrue(lHighRight = [], 'Random procedure overfill upper boundary.')
end;

procedure TOSSLRandomFixture.RandomByte(Source: TRandomSrc; Items, Size: TIdC_SIZET);
begin
  RandomT<byte>(Source,Items);
end;

procedure TOSSLRandomFixture.RandomInt(Source: TRandomSrc; Items, Size: TIdC_SIZET);
begin
  RandomT<integer>(Source,Items);
end;

procedure TOSSLRandomFixture.RandomInt64(Source: TRandomSrc; Items, Size: TIdC_SIZET);
begin
  RandomT<Int64>(Source,Items);
end;

procedure TOSSLRandomFixture.RandomExtended(Source: TRandomSrc; Items, Size: TIdC_SIZET);
begin
  RandomT<extended>(Source,Items);
end;

initialization
  TDUnitX.RegisterTestFixture(TOSSLRandomFixture);

end.
