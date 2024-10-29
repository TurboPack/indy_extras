<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:variable name="template">{#Template}</xsl:variable>
  <xsl:key name="GetItem" match="//Items/Item" use="@id"/>

  <xsl:include href="FooterInc.xsl"/>
  <xsl:include href="HeaderInc.xsl"/>
  <xsl:include href="ToolsInc.xsl"/>
  <xsl:include href="ImageInc.xsl"/>
  <xsl:include href="RefInc.xsl"/>

  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="Me" select="//Items/Item[@id='{#selfID}']"/>    
    <xsl:variable name="MyModule" select="key('GetItem',$Me/@modid)"/>
<html>
    <xsl:call-template name="header"/>
<body>
    <xsl:call-template name="Status">
      <xsl:with-param name="ID" select="'{#selfID}'"/>
    </xsl:call-template>
<h2>
    <xsl:call-template name="Image32">
      <xsl:with-param name="kind" select="$Me/@kind"/>
    </xsl:call-template>

    <xsl:value-of select="$Me/@kind"/>
</h2>
<span class="IdHeader">
    <xsl:call-template name="InsertName">
      <xsl:with-param name="ID" select="'{#selfID}'"/>
      <xsl:with-param name="ShowURL" select="0"/>
    </xsl:call-template>
</span>
<br/><br/>
    <xsl:if test="count($Me/Directives/Item) &gt; 0">
<h2>Directives</h2>
      <xsl:for-each select="$Me/Directives/Item">
        <xsl:value-of select="current()"/>
<br/>
        <xsl:text>&#13;&#10;</xsl:text> <!-- so the resulting HTML is readable -->
      </xsl:for-each>
<br/>
    </xsl:if>

    <xsl:if test="$Me/TypeID!=''">
<h2>Type</h2>
      <xsl:call-template name="InsertName">
        <xsl:with-param name="ID" select="$Me/TypeID"/>
      </xsl:call-template>
<br/><br/>
    </xsl:if>

    <xsl:if test="$Me/TypeName!=''">
<h2>Type</h2>
      <xsl:value-of select="$Me/TypeName"/>
<br/><br/>
    </xsl:if>

    <xsl:if test="$Me/@modid!=''">
<h2>Module</h2>
    <xsl:call-template name="InsertName">
      <xsl:with-param name="ModuleID" select="$Me/@modid"/>
    </xsl:call-template>
<br/><br/>
    </xsl:if>

    <xsl:if test="$MyModule/Modified!=''">
<h2>Last Modified</h2>
      <xsl:value-of select="$MyModule/Modified"/>
<br/><br/>
    </xsl:if>

    <xsl:call-template name="Comments">
      <xsl:with-param name="ID" select="'{#selfID}'"/>
    </xsl:call-template>

    <xsl:if test="$Me/Scope!=''">
<h2>Scope</h2>
      <xsl:value-of select="$Me/Scope"/>
<br/><br/>
    </xsl:if>

    <xsl:if test="$Me/ClaScope!=''">
<h2>Visibility</h2>
      <xsl:value-of select="$Me/ClaScope"/>
<br/><br/>
    </xsl:if>

    <xsl:if test="$Me/OwnerTypeID!=''">
<h2>Owner</h2>
      <xsl:call-template name="InsertName">
        <xsl:with-param name="ID" select="$Me/OwnerTypeID"/>
      </xsl:call-template>
<br/><br/>
    </xsl:if>

    <xsl:if test="$Me/OwnerTypeName!=''">
<h2>Owner</h2>
      <xsl:value-of select="$Me/OwnerTypeName"/>
<br/><br/>
    </xsl:if>

    <h2>Declaration</h2>
<pre class="Dec">{#Decl}</pre>
    <xsl:call-template name="reftable">
      <xsl:with-param name="caption" select="'Referenced By'"/>
      <xsl:with-param name="filter" select="$Me/RefBy/Loc"/>
    </xsl:call-template>

    <xsl:call-template name="footer"/>
</body>
</html>
  </xsl:template>
</xsl:stylesheet>
