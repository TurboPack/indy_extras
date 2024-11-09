<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="template">{#Template}</xsl:variable>

  <xsl:include href="FooterInc.xsl"/>
  <xsl:include href="HeaderInc.xsl"/>
  <xsl:include href="ImageInc.xsl"/>
  <xsl:include href="ToolsInc.xsl"/>
  <xsl:include href="TodoInc.xsl"/>

  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
<html>
    <xsl:call-template name="header"/>

<body>
<h1>Overview</h1>

<h2>Main Module</h2>
    <xsl:call-template name="InsertName">
      <xsl:with-param name="ModuleID" select="//Items/Item[MainFile='1']/@id"/>
    </xsl:call-template>

<h2>Class Hierarchy</h2>
{#TotalHier}
<br/><br/>

<h2>Module Calls</h2>
{#AllModCallsHier}
<br/><br/>

    <xsl:call-template name="todotable">
      <xsl:with-param name="caption" select="'Open Todo-items'"/>
      <xsl:with-param name="filter" select="//Todo[@done='0']"/>
      <xsl:with-param name="bCategoryColumn" select="1"/>
      <xsl:with-param name="bModuleColumn" select="1"/>
      <xsl:with-param name="bOwnerColumn" select="1"/>
      <xsl:with-param name="bPriorityColumn" select="1"/>
      <xsl:with-param name="bStatusColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="todotable">
      <xsl:with-param name="caption" select="'Done Todo-items'"/>
      <xsl:with-param name="filter" select="//Todo[@done='1']"/>
      <xsl:with-param name="bCategoryColumn" select="1"/>
      <xsl:with-param name="bModuleColumn" select="1"/>
      <xsl:with-param name="bOwnerColumn" select="1"/>
      <xsl:with-param name="bPriorityColumn" select="1"/>
      <xsl:with-param name="bStatusColumn" select="1"/>        
    </xsl:call-template>
   
    <xsl:call-template name="footer"/>
</body>
</html>
  </xsl:template>
</xsl:stylesheet>
