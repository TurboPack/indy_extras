unit frmAbout;

interface

uses WinApi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImage,
  ProgUtils;

type
  TAboutBox = class(TThemedForm)
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
    procedure VirtualImage1Click(Sender: TObject);
    procedure VirtualImage2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation
uses ShellApi;

{$R *.dfm}

procedure TAboutBox.FormCreate(Sender: TObject);

begin
  Self.Version.Caption := GetProgramVersion;
  Self.ProductName.Caption := Application.Title;
end;

procedure TAboutBox.LinkLabel1Click(Sender: TObject);
begin
  LaunchURL(LinkLabel1.Hint);
end;

procedure TAboutBox.VirtualImage1Click(Sender: TObject);
begin
  LaunchURL('https://github.com/JPeterMugaas/TaurusTLS');
end;

procedure TAboutBox.VirtualImage2Click(Sender: TObject);
begin
  LaunchURL('https://www.indyproject.org/');
end;

end.
 
