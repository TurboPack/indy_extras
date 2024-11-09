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
    <xsl:variable name="ItemsInMe" select="//Items/Item[OwnerTypeID='{#selfID}']"/>
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

    <xsl:if test="$Me/InheritsID!=''">
<h2>Inherits from</h2>
      <xsl:call-template name="InsertName">
        <xsl:with-param name="ID" select="$Me/InheritsID"/>
      </xsl:call-template>
<br/><br/>
    </xsl:if>

    <xsl:if test="$Me/InheritsName!=''">
<h2>Inherits from</h2>
      <xsl:value-of select="$Me/InheritsName"/>
<br/><br/>
    </xsl:if>

    <xsl:if test="count($Me/InheritedBy/Item) &gt; 0">
<h2>Inherited by</h2>
      <xsl:for-each select="key('GetItem',$Me/InheritedBy/Item/@id)">
        <xsl:call-template name="InsertName">
          <xsl:with-param name="ID" select="@id"/>
        </xsl:call-template>
<br/>
        <xsl:text>&#13;&#10;</xsl:text> <!-- so the resulting HTML is readable -->
      </xsl:for-each>
<br/>
    </xsl:if>

<h2>Declaration</h2>
<pre CLASS="Dec">
{#Decl}
</pre>

    <xsl:if test="$Me/IsFormClass='1'">
<h2>DFM Objects</h2>
{#DfmHier}
    </xsl:if>

<h2>Class Hierarchy</h2>
{#UpDownHier}

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Field']"/>
      <xsl:with-param name="caption" select="'Class Fields'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bTypeColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Property']"/>
      <xsl:with-param name="caption" select="'Properties'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bTypeColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Operator']"/>
      <xsl:with-param name="caption" select="'Operators'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bTypeColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Constructor']"/>
      <xsl:with-param name="caption" select="'Constructors'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Destructor']"/>
      <xsl:with-param name="caption" select="'Destructors'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
    </xsl:call-template>
                             
    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[(@kind='Procedure') or (@kind='Function')]"/>
      <xsl:with-param name="caption" select="'Methods'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="reftable">
      <xsl:with-param name="caption" select="'Referenced By'"/>
      <xsl:with-param name="filter" select="$Me/RefBy/Loc"/>
    </xsl:call-template>

    <xsl:call-template name="footer"/>
</body>
</html>
  </xsl:template>
</xsl:stylesheet>
