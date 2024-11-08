# TaurusTLS
Copyright (c) 2024 TaurusTLS Developers
All Rights Reserved
## General Information

TaurusTLS is an attempt to make OpenSSL 1.1.1 and OpenSSL 3.x compatible support for Indy - Internet Direct.  It provides headers for OpenSSL 1.1.1 and OpenSSL 3x plus two components for Delphi and C++Builder.  Those components are:

- TTaurusTLSIOHandlerSocket - enables TLS in a TIdTCPClientCustom descendant. 
- TTaurusTLSServerIOHandler - enables TLS in a TIdCustomTCPServer descendant

Both components are in the TaurusTLS.pas unit and the components are available on the IDE palette page, 
“TaurusTLS”.

## License
TaurusTLS is dual licensed. You can review which license better suits your needs, and use that license. You can even change your mind later if you have previously chosen one.

The TaurusTLS Modified BSD license is a very no nonsense license that allows you to do almost anything you want with TaurusTLS provided you provide proper attribution.  Details are available in the Modified_BSD_LICENSE.md file included in the with this source-code.
 
To make it easier and consistent for JEDI users, we also offer an MPL license v1.1.  Details are available in the LICENSE_MPL_1_1.txt file included with this source-code.
## Deploying Your Applications

TaurusTLS does require OpenSSL 1.1.1 or OpenSSL 3.x.  

On MacOS and Linux, OpenSSL is usually installed by default.  We recommend that developers document this requirement in case users need to install updated versions of OpenSSL.

On Windows, OpenSSL is not installed by default so you have to redistribute it along with your software.   You can choose to either deploy OpenSSL 1.1.1 or an OpenSSL 3.x version.  As of this writing, the 3.x versions are 3.0.15, 3.1.7, 3.2.3, 3.3.2, and 3.4.0.  Pre-compiled .DLL’s for these versions are available at https://github.com/JPeterMugaas/TaurusTLS/tree/main/OpenSSL-Binaries .  For Win32 applications, you need to redistribute the following:

OpenSSL 1.1.1
- libcrypto-1_1.dll	
- libssl-1_1.dll
- openssl.exe

OpenSSL 3.x
- libcrypto-3.dll
- libssl-3.dll
- openssl.exe

For Win64 applications, you need to redistribute the following:

OpenSSL 1.1.1	
- libcrypto-1_1-x64.dll	
- libssl-1_1-x64.dll
- openssl.exe

OpenSSL 3.x
- libcrypto-1_1-x64.dll
- libssl-1_1-x64.dll
- openssl.exe

## Demo Programs

Taurus TLS includes 2 demo programs.  
### TaurusTLS\src\demos\FTPServer\TaurusFTPServer.dproj  

This is a FTP Server with TLS enabled that runs in the Windows console.  This program has been tested with the following FTP clients:
- WS_FTP Professional - https://www.progress.com/resources/papers/ws-ftp-pro-data-sheet
- SmartFTP - https://www.smartftp.com/en-us/
- WinSCP - https://winscp.net/eng/index.php
- FileZilla - https://filezilla-project.org/

This program requires a certificate to run.  Instructions for creating a self-signed certificate are available at https://www.baeldung.com/openssl-self-signed-cert .  You then need to create a server.ini file in the executable directory that enables the certificate that has the following lines:

```
[Certificate]
CertificateFile=[path to your public certificate file]
KeyFile=[path to your private SSL key]
Password=[password for your private SSL key]
```

## TaurusTLS\demos\TaurusFTPClient\TaurusFTPClient.dproj  
This is a fully-functional FTP client that is multi threaded using the VCL Framework.   It has been tested with the following servers:
- CompleteFTP - https://enterprisedt.com/products/completeftp/
- RaidenFTPD - https://www.raidenftpd.com/
- Xlight FTP Server - https://www.xlightftpd.com/

No special configuration is required and the program generates it’s own INI files for storing FTP server information and default settings.  You may need to configure the program if you have a firewall/proxy setup or are behind a NAT and wish to use PORT transfers.
## Credits

### Tony Whyman

for providing the OpenSSL headers that TaurusTLS is based upon
### Chad Z. Hower (Kudzu) and the Indy Pit Crew

author of the original code that was modified to create TaurusTLS.
## Third Party Notices

Portions of this software are Copyright (c) 1993 – 2018, Chad Z. Hower 
(Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

1. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation, about box and/or other materials provided with the distribution.

2. No personal names or organizations names associated with the Indy project may be used to endorse or promote products derived from this software without specific prior written permission of the specific individual or organization.

THIS SOFTWARE IS PROVIDED BY Chad Z. Hower (Kudzu) and the Indy Pit Crew “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
