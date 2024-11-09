<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template name="footer">
<br/>
<hr/>
<br/>
<div class="footer">This document was created with <xsl:value-of select="//Items/General/AppName"/> version <xsl:value-of select="//Items/General/AppVersion"/><BR/>
<xsl:if test="//Items/General/Registered='0'">
This page was created with an <b>unregistered</b> copy of <xsl:value-of select="//Items/General/AppName"/>.
    </xsl:if>
Visit <a href="https://www.peganza.com" target="blank">Peganza</a> for more information<br/><br/>
<table>
<tr><td class="footerEmp">Template:</td><td class="footer"><xsl:value-of select="$template"/></td></tr>
<tr><td class="footerEmp">Project:</td><td class="footer"><xsl:value-of select="//Items/General/ProjectPath"/></td></tr>
<tr><td class="footerEmp">Document:</td><td class="footer">{#DocPath}</td></tr>
<tr><td class="footerEmp">Created:</td><td class="footer"><xsl:value-of select="//Items/General/DateTime"/></td></tr>
</table>
</div>
  </xsl:template>
</xsl:stylesheet>