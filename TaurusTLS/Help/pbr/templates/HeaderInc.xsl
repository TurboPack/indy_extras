<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template name="header">
<head>
<link rel="stylesheet" href="DefStyle.css" type="text/css"/>
    <xsl:if test="//Items/General/IncludeJS='1'">
<script type="text/javascript" src="Funcs.js"></script>
    </xsl:if>
<title>{#IdName}</title>
</head>
  </xsl:template>
</xsl:stylesheet>
