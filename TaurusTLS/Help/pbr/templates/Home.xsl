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
        <h1>Start Page</h1>
        <p><b>Welcome to TaurusTLS</b> - An attempt to make <a href="https://www.openssl.org/">OpenSSL 1.1.1 and OpenSSL 3.x</a> compatible support for <a href="https://www.indyproject.org/">Indy - Internet Direct</a></p>
        <p>TaurusTLS includes</p>
        <ul>
          <li>Pascal Headers for OpenSSL that either load OpenSSL dynamically, static load, or statically link depending upon platform and compiler</li>
          <li><img src="images/TTaurusTLSIOHandlerSocket.png" alt=""/><b>TaurusTLSIOHandlerSocket</b> - for enabling TLS in a TIdTCPClientCustom descendant</li>
          <li><img src="images/TTaurusTLSServerIOHandler.png" alt=""/><b>TTaurusTLSServerIOHandler</b> - for enabling TLS in a TIdCustomTCPServer descendant</li>
        </ul>
        <p>For updates, please visit the GitHub repository at <a href="https://github.com/JPeterMugaas/TaurusTLS">https://github.com/JPeterMugaas/TaurusTLS</a></p>
        <p>
          <a href="https://www.indyproject.org/">
            <img src="images/BuiltWIndy.gif" alt="Built with Indy (Internet Direct)"/>
          </a>
        </p>
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
