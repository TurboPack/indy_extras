
# TaurusTLS

Copyright (c) 2025 TaurusTLS Developers
All Rights Reserved

## General Information

TaurusTLS provides OpenSSL 1.1.1 and 3.x support for Indy - Internet Direct.  It includes headers plus two components for Delphi and C++Builder.  Those components are:

- TTaurusTLSIOHandlerSocket - Enables TLS in a TIdTCPClientCustom descendant.
- TTaurusTLSServerIOHandler - Enables TLS in a TIdCustomTCPServer descendant.

Both components are in the TaurusTLS.pas unit and the components are available on the IDE palette page, “TaurusTLS”.

TaurusTLS supports the following operating systems:

- Linux
- MacOS
- Windows

## License

TaurusTLS is dual licensed. You can review which license better suits your needs, and use that license.  You can even change your mind later if you have previously chosen one.

The TaurusTLS Modified BSD license is a very no nonsense license that allows you to do almost anything you want with TaurusTLS provided you provide proper attribution.  Details are available in the Modified_BSD_LICENSE.md file included in the with this source-code.

To make it easier and consistent for JEDI users, we also offer an MPL license v1.1.  Details are available in the LICENSE_MPL_1_1.txt file included with this source-code.

## RAD Studio Installation

### For Indy Included with Delphi

1. Open TaurusAll.groupproj in the TaurusTLS\Packages\12AndAbove\Delphi folder.
2. Compile TaurusTLS_RT.
3. Compile TaurusTLS_DT and install it in the IDE.

You may install TaurusTLS into the 64-bit Integrated Development Environment (IDE) using the same procedure.

### For Indy that was Upgraded from the Website

1. Set the INDY_PATH environment variable for your user account to the location where Indy is located.
2. Open TaurusForIndy290All.groupproj in the TaurusTLS\Packages\12AndAbove\Delphi folder.
3. Compile TaurusTLS_RTForIndy290.
4. Compile TaurusTLS_DTForIndy290 and install it in the IDE.

You may install TaurusTLS into the 64-bit Integrated Development Environment (IDE) using the same procedure.

## Lazarus Installation

1. Open taurustlsldsgn.lpk from the TaurusTLS/Packages/Lazarus.
2. From "Required Packages", open "TaurusTLSRT" and compile it.
3. Then compile the main package itself and install it in the IDE.

## Deploying Your Applications

TaurusTLS requires OpenSSL 1.1.1 or OpenSSL 3.x.  

### Linux

On Linux, OpenSSL is usually installed by default.  We recommend that developers document this requirement in case users need to install updated versions of OpenSSL.

### MacOS

On MacOS, the default OpenSSL version is LibreSSL and that may NOT work.  You can install OpenSSL alongside LibreSSL using the instructions at:

<https://secdops.com/blog/using-openssl-alongside-the-default-libressl-on-macos/>

### Windows

On Windows, OpenSSL is not installed by default so you have to redistribute it along with your software by placing the library files in the same directory as your executable.   You can choose to either deploy OpenSSL 1.1.1 (not recommended) or an OpenSSL 3.x version.  As of this writing, the current OpenSSL 3.x versions are 3.0.16, 3.1.8, 3.2.4, 3.3.3, 3.4.1, and 3.5.0.  Pre-compiled .DLL’s for these versions are available at <https://github.com/JPeterMugaas/OpenSSL-Distribution/tree/main/binaries/Windows> and <https://github.com/TurboPack/OpenSSL-Distribution/tree/main/binaries/Windows> .  

For Win32 applications, you need to redistribute the following:

OpenSSL 1.1.1  (not recommended because OpenSSL 1.1.1 has reached its end of life)

- libcrypto-1_1.dll
- libssl-1_1.dll
- openssl.exe

OpenSSL 3.x

- libcrypto-3.dll
- libssl-3.dll
- openssl.exe

For Win64 applications, you need to redistribute the following:

OpenSSL 1.1.1  (not recommended because OpenSSL 1.1.1 has reached its end of life)

- libcrypto-1_1-x64.dll
- libssl-1_1-x64.dll
- openssl.exe

OpenSSL 3.x

- libcrypto-3-x64.dll
- libssl-3-x64.dll
- openssl.exe

## Component Reference

TaurusTLS includes a component reference in "Compiled HTML Help file (.chm)" format in the Help\chm directory.

## Demo Programs

Taurus TLS includes 4 demo programs.  

### TaurusTLS\src\demos\FTPServer\TaurusFTPServer.dproj  

This is a FTP Server with TLS enabled that runs in the Windows console.  This program has been tested with the following FTP clients:

- FileZilla - <https://filezilla-project.org/>
- SmartFTP - <https://www.smartftp.com/en-us/>
- WinSCP - <https://winscp.net/eng/index.php>
- WS_FTP Professional - <https://www.progress.com/resources/papers/ws-ftp-pro-data-sheet>

This program requires a certificate to run.  Instructions for creating a self-signed certificate are available at [https://technotes.shemyak.com/posts/min-openssl-cnf/](https://technotes.shemyak.com/posts/min-openssl-cnf/).  You then need to create a server.ini file in the executable directory that enables the certificate that has the following lines:

```text
[Certificate]
CertificateFile=[path to your public certificate file]
KeyFile=[path to your private SSL key]
Password=[password for your private SSL key]
```

You can also do the following:

1. Copy the OpenSSL .dll's and openssl.exe to the directory where the FTP server demo .exe is built.  Usually that is \\$\(platform\)\\Debug or \\$\(platform\)\\Release.
2. Run the makecert.bat to generate a self-signed certificate.  Just answer the prompts and the certificate is generated.
3. Run the FTP Server .exe and it will create a default server.ini file that points to the certificate files generated in Step 2.

### TaurusTLS\demos\TaurusFTPClient\TaurusFTPClient.dproj  

This is a fully functional Delphi-only FTP client that is multi-threaded using the VCL Framework.  It has been tested with the following servers:

- CompleteFTP - <https://enterprisedt.com/products/completeftp/>
- FileZilla Server - <https://filezilla-project.org/>
- ProFTPD - <http://www.proftpd.org/>
- PureFTPD - <https://www.pureftpd.org/>
- vsftpd - <https://security.appspot.com/vsftpd.html>
- Xlight FTP Server - <https://www.xlightftpd.com/>

No special configuration is required, and the program generates its own INI files for storing FTP server information and default settings.  You may need to configure the program if you have a firewall/proxy setup or are behind a NAT and wish to use PORT transfers.

### TaurusTLS\demos\TaurusFTPConsole\taurusftp.dpr and taurusftp.lpr

This is a fully functional cross-platform console FTP client that can be built with both Delphi and Lazaurus.  It has been tested with the following servers:

- CompleteFTP - <https://enterprisedt.com/products/completeftp/>
- FileZilla Server - <https://filezilla-project.org/>
- ProFTPD - <http://www.proftpd.org/>
- PureFTPD - <https://www.pureftpd.org/>
- vsftpd - <https://security.appspot.com/vsftpd.html>
- Xlight FTP Server - <https://www.xlightftpd.com/>

For help using the client, just use the "help" command.

### TaurusTLS\Demos\TaurusHTTPServer\taurusHTTPServer.dpr and taurusHTTPServer.lpr

This is a minimal HTTP Server that only replies with a 200 code and an empty page.  This program is used for testing the server component for cross-platform usage.  This program requires a certificate file (domain.crt) and a private key file (domain.key) that has to generated by the openssl.exe program.

## Credits

### Tony Whyman

for providing the OpenSSL headers that TaurusTLS is based upon

### Chad Z. Hower (Kudzu) and the Indy Pit Crew

author of the original code that was modified to create TaurusTLS.

## Third Party Notices

Portions of this software are Copyright (c) 1993 – 2018, Chad Z. Hower
(Kudzu) and the Indy Pit Crew – <https://www.indyproject.org/>

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

1. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation, about box and/or other materials provided with the distribution.

2. No personal names or organizations names associated with the Indy project may be used to endorse or promote products derived from this software without specific prior written permission of the specific individual or organization.

THIS SOFTWARE IS PROVIDED BY Chad Z. Hower (Kudzu) and the Indy Pit Crew “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
