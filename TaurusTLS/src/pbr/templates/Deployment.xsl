<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:variable name="template">Home.xsl</xsl:variable>
  <xsl:include href="FooterInc.xsl"/>
  <xsl:include href="HeaderInc.xsl"/>
  <xsl:include href="ImageInc.xsl"/>
  <xsl:include href="ToolsInc.xsl"/>
  <xsl:include href="TodoInc.xsl"/>
  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>
  <xsl:template match="/">
    <xsl:variable name="General" select="//Items/General"/>
    <html>
      <xsl:call-template name="header"/>
      <body>
        <h1>Deploying Your Applications</h1>
        <p><b>TaurusTLS</b> requires OpenSSL version 1.1.1 or greater.  On some systems, 
        OpenSSL is installed by default, on others, you have to link it statically, or you have to redistribue
        precompiled shared libraries.</p>
        <h2>Windows 32-bit</h2>
        <p>For Windows 32-bit, we provide pre-compiled .DLL libraries you can redistribute at 
        <a href="https://github.com/JPeterMugaas/TaurusTLS/tree/main/OpenSSL-Binaries">https://github.com/JPeterMugaas/TaurusTLS/tree/main/OpenSSL-Binaries</a>.  
        You should redistribute the following files (depending upon OpenSSL version) in same directory as your executable:</p>
        <table>
          <theader>
            <tr>
              <th>OpenSSL 1.1.1</th>
              <th>OpenSSL 3.x</th>
            </tr>
          </theader>
          <tbody>
            <tr>
              <td>libcrypto-1_1.dll</td>
              <td>libcrypto-3.dll</td>
            </tr>
            <tr>
              <td>libssl-1_1.dll</td>
              <td>libssl-3.dll</td>
            </tr>
          </tbody>
        </table>
        <p>We also recommend deploying openssl.exe so that users may perform various TLS related tasks such as generating certificate requests and generating self-signed certificates.</p>
        <h2>Windows 64-bit</h2>
        <p>For Windows 64-bit, we provide pre-compiled .DLL libraries you can redistribute at 
        <a href="https://github.com/JPeterMugaas/TaurusTLS/tree/main/OpenSSL-Binaries">https://github.com/JPeterMugaas/TaurusTLS/tree/main/OpenSSL-Binaries</a>.  
        You should redistribute the following files:</p>
        <table>
          <theader>
            <tr>
              <th>OpenSSL 1.1.1</th>
              <th>OpenSSL 3.x</th>
            </tr>
          </theader>
          <tbody>
            <tr>
              <td>libcrypto-1_1-x64.dll</td>
              <td>libcrypto-3-x64.dll</td>
            </tr>
            <tr>
              <td>libssl-1_1-x64.dll</td>
              <td>libssl-3-x64.dll</td>
            </tr>
          </tbody>
        </table>
        <p>We also recommend deploying openssl.exe so that users may perform various TLS related tasks such as generating certificate requests and generating self-signed certificates.</p>
        <h2>Linux</h2>
        <p>Most modern Linux distributions already include the OpenSSL library or users can easily install it using their respective packaging systems.  You should document that your application requires OpenSSL.</p>
        <h2>MacOSX</h2>
        <p>MacOS includes the OpenSSL library.  However, we recommend that your users upgrade it to more recent versions using <a href="https://www.macports.org/">MacPorts</a> or <a href="https://brew.sh/">Homebrew</a>.  You
        should document that your application requires OpenSSL.</p>
        <h2>iOS</h2>
        <p>OpenSSL is statically linked into your executable.</p>
        <h2>Android</h2>
        <p>OpenSSL is statically linked into your executable.</p>
        <xsl:if test="$General/Registered='0'">
          <p>
This is a <b>non-registered</b> version - some hyperlinks are missing. All identifiers (except units) that have names starting with any of the letters
"A", "D", "G", "J", "M", "P", "S", "V" and "Z" are <b>NOT linked</b>. Some of the identifiers are also written with scrambled names.
A few lines in the middle of source listings are somewhat scrambled.
</p>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="$General/ProjectPath!=''">
            <h2>Project</h2>
            <xsl:value-of select="$General/ProjectPath"/>
          </xsl:when>
          <xsl:otherwise>
            <h2>Source Path</h2>
            <xsl:value-of select="$General/DirectSourcePath"/>
          </xsl:otherwise>
        </xsl:choose>
        <h2>Main Module</h2>
        <xsl:call-template name="InsertName">
          <xsl:with-param name="ModuleID" select="//Items/Item[MainFile='1']/@id"/>
        </xsl:call-template>
        <xsl:if test="$General/Description!=''">
          <h2>Description</h2>
          <xsl:value-of select="$General/Description"/>
        </xsl:if>
        <xsl:call-template name="footer"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
