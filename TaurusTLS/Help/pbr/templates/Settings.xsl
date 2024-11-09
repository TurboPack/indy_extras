<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="template">Settings.xsl</xsl:variable>

  <xsl:include href="FooterInc.xsl"/>
  <xsl:include href="HeaderInc.xsl"/>

  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="General" select="//Items/General"/>    
<html>
    <xsl:call-template name="header"/>
<body>
<h1>Settings</h1>
    <xsl:choose>
      <xsl:when test="$General/ProjectPath!=''">
<h3>Project:</h3>
        <xsl:value-of select="$General/ProjectPath"/><BR/><xsl:text>&#10;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
<h3>Source Path:</h3>
        <xsl:value-of select="$General/DirectSourcePath"/><BR/><xsl:text>&#10;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="$General/Description!=''"> 
<h3>Description</h3>
      <xsl:value-of select="$General/Description"/><BR/><xsl:text>&#10;</xsl:text>
    </xsl:if>

<h3>Main source file</h3>
    <xsl:value-of select="$General/MainPath"/><BR/><xsl:text>&#10;</xsl:text>

<h3>Created</h3>
This documentation was created at <xsl:value-of select="$General/DateTime"/><BR/><xsl:text>&#10;</xsl:text>

<h3>Output folder</h3>
    <xsl:value-of select="$General/OutputFolder"/><BR/><xsl:text>&#10;</xsl:text>

<h3>Default templates</h3>
    <xsl:choose>
      <xsl:when test="$General/DefaultTemplates='1'">
Yes
      </xsl:when>
      <xsl:otherwise>
No
      </xsl:otherwise>
    </xsl:choose>
<br/><xsl:text>&#10;</xsl:text>

    <xsl:if test="$General/TemplatesFolder!=''">
<h3>Templates folder</h3>
      <xsl:value-of select="$General/TemplatesFolder"/><BR/><xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="count($General/PrimaryTemplates/Item) &gt; 0">
<h3>Primary templates</h3>
      <xsl:for-each select="$General/PrimaryTemplates/Item">
        <xsl:value-of select="current()"/><BR/><xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <h3>Compiler:</h3>
    <xsl:value-of select="$General/Compiler"/><BR/><xsl:text>&#10;</xsl:text>

<h3>File types parsed:</h3>
    <xsl:value-of select="$General/FilesParsedMode"/><BR/><xsl:text>&#10;</xsl:text>

<h3>Files parsed:</h3>
    <xsl:value-of select="$General/FilesParsed"/><BR/><xsl:text>&#10;</xsl:text>
    <xsl:if test="count($General/SearchFolders/Item) &gt; 0">
<h3>Search folders:</h3>
      <xsl:for-each select="$General/SearchFolders/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="count($General/ExcludedSearchFolders/Item) &gt; 0">
<h3>Excluded search folders:</h3>
      <xsl:for-each select="$General/ExcludedSearchFolders/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="count($General/ExcludedFiles/Item) &gt; 0">
<h3>Excluded files:</h3>
      <xsl:for-each select="$General/ExcludedFiles/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="count($General/ExcludedFolders/Item) &gt; 0">
<h3>Excluded for reporting:</h3>
      <xsl:for-each select="$General/ExcludedFolders/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="count($General/NameSpaces/Item) &gt; 0">
<h3>Namespaces</h3>
      <xsl:for-each select="$General/NameSpaces/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="$General/DefaultNameSpace!=''">
<h3>Default namespace</h3>
      <xsl:value-of select="$General/DefaultNameSpace"/><BR/><xsl:text>&#10;</xsl:text>
    </xsl:if>

    <xsl:if test="count($General/Predefined/Item) &gt; 0">
<h3>Predefined:</h3>
      <xsl:for-each select="$General/Predefined/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="count($General/Directives/Item) &gt; 0">
<h3>Conditional defines:</h3>
      <xsl:for-each select="$General/Directives/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="count($General/UnitAliases/Item) &gt; 0">
<h3>Unit aliases:</h3>
      <xsl:for-each select="$General/UnitAliases/Item">
        <xsl:value-of select="current()"/><BR/>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
    </xsl:if>

    <xsl:call-template name="footer"/>
</body>
</html>
  </xsl:template>
</xsl:stylesheet>
