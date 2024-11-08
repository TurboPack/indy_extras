<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:variable name="template">{#Template}</xsl:variable>

  <xsl:include href="FooterInc.xsl"/>
  <xsl:include href="HeaderInc.xsl"/>
  <xsl:include href="ToolsInc.xsl"/>
  <xsl:include href="TodoInc.xsl"/>
  <xsl:include href="ImageInc.xsl"/>

  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="Me" select="//Items/Item[@id='{#selfID}']"/>    
    <xsl:variable name="ItemsInMe" select="//Items/Item[@modid='{#selfID}']"/>
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

    <xsl:if test="$Me/Path!=''">
<h2>Path</h2>
      <xsl:value-of select="$Me/Path"/>
<br/><br/>
    </xsl:if>

    <xsl:if test="$Me/Modified!=''">
<h2>Last Modified</h2>
      <xsl:value-of select="$Me/Modified"/>
<br/><br/>
    </xsl:if>

    <xsl:call-template name="Comments">
      <xsl:with-param name="ID" select="'{#selfID}'"/>
    </xsl:call-template>

    <xsl:if test="//Items/General/IncludeSourceCode='1'">
		<xsl:if test="$Me/HasIni='1'">
<h2>Initialization Code</h2>
<pre class="Code">{#init}</pre>
		</xsl:if>

		<xsl:if test="$Me/HasFin='1'">
<h2>Finalization Code</h2>
<pre class="Code">{#fin}</pre>
		</xsl:if>

		<xsl:if test="{#selfHasSource}='1'">
			<xsl:if test="$Me/HasMain='1'">
<h2>Main Code</h2>
<pre class="Code">{#maincode}</pre>
			</xsl:if>
		</xsl:if>
    </xsl:if>

    <xsl:call-template name="todotable">
      <xsl:with-param name="caption" select="concat('Open Todo-items for ',$Me/Name)"/>
      <xsl:with-param name="filter" select="$Me/Todos/Todo[@done='0']"/>
      <xsl:with-param name="bCategoryColumn" select="1"/>
      <xsl:with-param name="bOwnerColumn" select="1"/>
      <xsl:with-param name="bPriorityColumn" select="1"/>
      <xsl:with-param name="bStatusColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="todotable">
      <xsl:with-param name="caption" select="concat('Done Todo-items for ',$Me/Name)"/>
      <xsl:with-param name="filter" select="$Me/Todos/Todo[@done='1']"/>
      <xsl:with-param name="bCategoryColumn" select="1"/>
      <xsl:with-param name="bOwnerColumn" select="1"/>
      <xsl:with-param name="bPriorityColumn" select="1"/>
      <xsl:with-param name="bStatusColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$Me/Used/Item[@interface='1']"/>
      <xsl:with-param name="caption" select="'Units Used in Interface'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$Me/Used/Item[@interface='0']"/>
      <xsl:with-param name="caption" select="'Units Used in Implementation'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Class']"/>
      <xsl:with-param name="caption" select="'Classes'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Interface']"/>
      <xsl:with-param name="caption" select="'Interfaces'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Dispinterface']"/>
      <xsl:with-param name="caption" select="'Dispinterfaces'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Procedure']"/>
      <xsl:with-param name="caption" select="'Procedures'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bOwnerColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Function']"/>
      <xsl:with-param name="caption" select="'Functions'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bOwnerColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Type']"/>
      <xsl:with-param name="caption" select="'Types (non-class, non-interface)'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bTypeColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[(@kind='Variable') and ((Scope='Interfaced') or (Scope='Global'))]"/>
      <xsl:with-param name="caption" select="'Global Variables'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
      <xsl:with-param name="bTypeColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[(@kind='Constant') or (@kind='Typed Constant')]"/>
      <xsl:with-param name="caption" select="'Constants'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:call-template name="table">
      <xsl:with-param name="filter" select="$ItemsInMe[@kind='Resourcestring']"/>
      <xsl:with-param name="caption" select="'Resourcestrings'"/>
      <xsl:with-param name="bNameColumn" select="1"/>
      <xsl:with-param name="bDeclarationColumn" select="1"/>
      <xsl:with-param name="bScopeColumn" select="1"/>
      <xsl:with-param name="bCommentsColumn" select="1"/>
    </xsl:call-template>

    <xsl:if test="{#selfHasSource}='1'">
<br/>
<hr/>
<h2>Module Source</h2>
<pre class="Code">{#source}</pre>
    </xsl:if>
<h2>Module Calls (2 levels)</h2>
{#ModCallsHier2}
    <!-- we do not need this for the main module -->
    <xsl:if test="$Me/HasMain!='1'">
<h2>Module Called-By (2 levels)</h2>
{#ModCalledByHier2}
    </xsl:if>
    <xsl:call-template name="footer"/>
</body>
</html>
  </xsl:template>
</xsl:stylesheet>
