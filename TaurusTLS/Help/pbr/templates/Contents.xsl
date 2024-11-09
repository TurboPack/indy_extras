<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="template">Contents.xsl</xsl:variable>

  <xsl:include href="FooterInc.xsl"/>
  <xsl:include href="HeaderInc.xsl"/>
  <xsl:include href="ImageInc.xsl"/>
  <xsl:include href="ToolsInc.xsl"/>
  
  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
<html>
    <xsl:call-template name="header"/>
<body>

<table border="0">
<tr>
<td>
<br/>
<h2>General</h2>
<a href="Home.{#Extension}" target="main"><b>Start Page</b></a><br/>
<a href="Overview.{#Extension}" target="main">Overview</a><br/>
<a href="Settings.{#Extension}" target="main">Settings</a><br/><br/>
<a href="ModuleIndex.{#Extension}" target="main">Module Index</a><br/>
<a href="ClassIndex.{#Extension}" target="main">Class Index</a><br/>
<a href="SubprogIndex.{#Extension}" target="main">Subprogram Index</a><br/>
<a href="IdentifierIndex.{#Extension}" target="main">Identifier Index</a><br/>

<h2>Main Module</h2>
    <xsl:call-template name="InsertName">
      <xsl:with-param name="ModuleID" select="//Items/Item[MainFile='1']/@id"/>
      <xsl:with-param name="Target" select="'main'"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="//Items/Item[(@link='1') and (@kind='Module')]"/>
      <xsl:with-param name="caption" select="'All Modules'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="Target" select="'main'"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="//Items/Item[@kind='Class']"/>
      <xsl:with-param name="caption" select="'All Classes'"/>
      <xsl:with-param name="Target" select="'main'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Interface') or (kind='Dispinterface')]"/>
      <xsl:with-param name="caption" select="'All Interfaces'"/>
      <xsl:with-param name="Target" select="'main'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
    </xsl:call-template>
</td>
</tr>
</table>
</body>
</html>
  </xsl:template>
</xsl:stylesheet>
