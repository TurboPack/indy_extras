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
        <h1>Lincense</h1>
        <p>TaurusTLS is dual licensed. You can review which license better suits your needs, and use that license.</p>
        <p>Licenses</p>
        <ul>
          <li>The <a href="#NodifiedBSD">TaurusTLS Modified BSD license</a> is a very no nonsense license that allows you to do almost anything you want with TaurusTLS provided you provide proper attribution. </li>
          <li>To make it easier and consistent for JEDI users, we also offer an <a href="https://www.mozilla.org/en-US/MPL/1.1/">MPL license v1.1</a>.</li>
        </ul>
        <h2><a id="NodifiedBSD">TaurusTLS Modified BSD license</a></h2>
        <h3>Copyright</h3>
        <p>Portions of this software are Copyright (c) 2024 TaurusTLS Developers – <a href="https://github.com/JPeterMugaas/TaurusTLS">https://github.com/JPeterMugaas/TaurusTLS</a></p>
        <h3>License</h3>
        <p>Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:</p>
        <ul>
          <li>Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.</li>
          <li>Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation, about box and/or other materials provided with the distribution.</li>
          <li>No personal names or organizations names associated with the TaurusTLS project may be used to endorse or promote products derived from this software without specific prior written permission of the specific individual or organizations</li>
        </ul>
        <p>THIS SOFTWARE IS PROVIDED BY TaurusTLS Developers “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
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
