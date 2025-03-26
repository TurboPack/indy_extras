unit ProgUtils;

interface

uses Vcl.ComCtrls;

procedure ScrollToTop(ARichEdit: TRichEdit);
procedure ScrollToEnd(ARichEdit: TRichEdit);
function LeftJustify(const AText: String; ALen: Integer): string;
function RightJustify(const AText: String; ALen: Integer): String;
function IsValidIP(const Aaddress: String): Boolean;
function DlgCaptionToFormCaption(const ACaption : String) : String;

function GetProgramVersion : String;

implementation

uses WinAPI.Messages, IdIPAddress, TaurusTLSHeaders_x509,
TaurusTLSHeaders_x509_vfy, System.SysUtils;

function GetProgramVersion : String;
var LMajor, LMinor, LBuild : Cardinal;
begin
  GetProductVersion(ParamStr(0), LMajor, LMinor, LBuild);
  Result := IntToStr(LMajor)+'.'+IntToStr(LMinor)+'.'+IntToStr(LBuild);

end;

function DlgCaptionToFormCaption(const ACaption : String) : String;
var i : Integer;
begin
  Result := StringReplace(ACaption,'&','',[]);
  //remove trailing ...
  for i := Length(Result) downto 1 do
  begin
    if Result[i] = '.' then
    begin
      Delete(Result,i,1);
    end
    else
    begin
      break;
    end;
  end;
end;

function IsValidIP(const Aaddress: String): Boolean;
var
  LIP: TIdIPAddress;
begin
  LIP := TIdIPAddress.MakeAddressObject(Aaddress);
  Result := Assigned(LIP);
  if Result then
  begin
    FreeAndNil(LIP);
  end;
end;

function LeftJustify(const AText: String; ALen: Integer): string;
begin
  Result := '';
  if ALen > Length(AText) then
  begin
    Result := AText + StringOfChar(' ', ALen - Length(AText));
  end
  else
  begin
    Result := AText;
  end;
end;

function RightJustify(const AText: String; ALen: Integer): String;
begin
  Result := '';
  if ALen > Length(AText) then
  begin
    Result := StringOfChar(' ',ALen - Length(AText)) + AText;
  end
  else
  begin
    Result := AText;
  end;
end;

procedure ScrollToEnd(ARichEdit: TRichEdit);
var
  isSelectionHidden: Boolean;
begin
    ARichEdit.SelStart := ARichEdit.Perform(WinAPI.Messages.EM_LINEINDEX, ARichEdit.Lines.Count, 0);
    // Set caret at end
    isSelectionHidden := ARichEdit.HideSelection;
    try
      ARichEdit.HideSelection := False;
      ARichEdit.Perform(WinAPI.Messages.EM_SCROLLCARET, 0, 0); // Scroll to caret
    finally
      ARichEdit.HideSelection := isSelectionHidden;
    end;
end;

procedure ScrollToTop(ARichEdit: TRichEdit);
var
  isSelectionHidden: Boolean;
begin
    ARichEdit.SelStart := ARichEdit.Perform(WinAPI.Messages.EM_LINEINDEX, 0, 0); // Set caret at end
    isSelectionHidden := ARichEdit.HideSelection;
    try
      ARichEdit.HideSelection := False;
      ARichEdit.Perform(WinAPI.Messages.EM_SCROLLCARET, 0, 0); // Scroll to caret
    finally
      ARichEdit.HideSelection := isSelectionHidden;
    end;
end;

end.
