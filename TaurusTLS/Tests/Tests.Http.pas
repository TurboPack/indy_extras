unit Tests.Http;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TestHttp = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure BasicConnection;
  end;

implementation

procedure TestHttp.Setup;
begin
//Todo
end;

procedure TestHttp.TearDown;
begin
//Todo
end;

procedure TestHttp.BasicConnection;
begin
//Todo
end;

initialization
  TDUnitX.RegisterTestFixture(TestHttp);
end.
