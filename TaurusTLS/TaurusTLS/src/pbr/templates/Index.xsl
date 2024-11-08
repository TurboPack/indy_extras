<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>
  <xsl:template match="/">
<html>
<head>
<title></title>
<frameset cols="180,*">
<frame border="1" frameborder="yes" marginheight="0" marginwidth="0" name="menu" target="main" scrolling="yes" src="Contents.{#Extension}"/>
<frame border="1" frameborder="yes" name="main" src="Home.{#Extension}"/>
<noframes>Your browser does not support frames!</noframes>
</frameset>
</head>
</html>
  </xsl:template>
</xsl:stylesheet>

