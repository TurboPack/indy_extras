unit frmAbout;

interface

uses WinApi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImage;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    VirtualImage1: TVirtualImage;
    ImageCollection1: TImageCollection;
    LinkLabel1: TLinkLabel;
    VirtualImage2: TVirtualImage;
    procedure FormCreate(Sender: TObject);
    procedure LinkLabel1Click(Sender: TObject);
    procedure VirtualImage2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation
uses ShellApi, ProgUtils;

{$R *.dfm}

procedure TAboutBox.FormCreate(Sender: TObject);

begin
  Self.Version.Caption := GetProgramVersion;
  Self.ProductName.Caption := Application.Title;
end;

procedure TAboutBox.LinkLabel1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(LinkLabel1.Hint), nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutBox.VirtualImage2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://www.indyproject.org/'), nil, nil, SW_SHOWNORMAL);
end;

end.
 