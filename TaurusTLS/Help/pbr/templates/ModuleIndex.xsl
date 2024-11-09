<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="template">{#Template}</xsl:variable>

  <xsl:include href="FooterInc.xsl"/>
  <xsl:include href="HeaderInc.xsl"/>
  <xsl:include href="ImageInc.xsl"/>
  <xsl:include href="ToolsInc.xsl"/>

  <xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>

  <xsl:template name="MakeTable">
    <xsl:param name="filter"/>
    <xsl:param name="letter"/>

    <xsl:if test="count($filter) &gt; 0">
<tr>
      <xsl:attribute name="class">LetterRow</xsl:attribute>
<td>
      <xsl:attribute name="colspan">2</xsl:attribute>
      <xsl:attribute name="class">BigLetter</xsl:attribute>
<a>
      <xsl:attribute name="name"><xsl:value-of select="$letter"/></xsl:attribute>
</a>
      <xsl:value-of select="$letter"/>
</td>
</tr>
      <xsl:for-each select="$filter">
        <xsl:sort select="Name"/>
<tr>
        <xsl:choose>
          <xsl:when test="position() mod 2 = 1">
            <xsl:attribute name="class">OddRow</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">EvenRow</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:call-template name="InsertTableCell">
          <xsl:with-param name="bSmallImages" select="1"/>
          <xsl:with-param name="ModuleID" select="@modid"/>
          <xsl:with-param name="Width" select="10"/>
        </xsl:call-template>
<td>
        <xsl:choose>
          <xsl:when test="Info/Comments!=''">
<pre>
            <xsl:choose>
              <xsl:when test="position() mod 2 = 1">
                <xsl:attribute name="class">OddRowTable</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="class">EvenRowTable</xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:value-of select="Info/Comments"/>
</pre>
          </xsl:when>
          <xsl:otherwise>
-
          </xsl:otherwise>
        </xsl:choose>
</td>
</tr>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/">
<html>
    <xsl:call-template name="header"/>
<body>
<h1>Module Index</h1>
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'a') or (substring(Name,1,1) = 'A'))]"/>
      <xsl:with-param name="letter" select="'A'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'b') or (substring(Name,1,1) = 'B'))]"/>
      <xsl:with-param name="letter" select="'B'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'c') or (substring(Name,1,1) = 'C'))]"/>
      <xsl:with-param name="letter" select="'C'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'd') or (substring(Name,1,1) = 'D'))]"/>
      <xsl:with-param name="letter" select="'D'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'e') or (substring(Name,1,1) = 'E'))]"/>
      <xsl:with-param name="letter" select="'E'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'f') or (substring(Name,1,1) = 'F'))]"/>
      <xsl:with-param name="letter" select="'F'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'g') or (substring(Name,1,1) = 'G'))]"/>
      <xsl:with-param name="letter" select="'G'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'h') or (substring(Name,1,1) = 'H'))]"/>
      <xsl:with-param name="letter" select="'H'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'i') or (substring(Name,1,1) = 'I'))]"/>
      <xsl:with-param name="letter" select="'I'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'j') or (substring(Name,1,1) = 'J'))]"/>
      <xsl:with-param name="letter" select="'J'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'k') or (substring(Name,1,1) = 'K'))]"/>
      <xsl:with-param name="letter" select="'K'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'l') or (substring(Name,1,1) = 'L'))]"/>
      <xsl:with-param name="letter" select="'L'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'm') or (substring(Name,1,1) = 'M'))]"/>
      <xsl:with-param name="letter" select="'M'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'n') or (substring(Name,1,1) = 'N'))]"/>
      <xsl:with-param name="letter" select="'N'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'o') or (substring(Name,1,1) = 'O'))]"/>
      <xsl:with-param name="letter" select="'O'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'p') or (substring(Name,1,1) = 'P'))]"/>
      <xsl:with-param name="letter" select="'P'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'q') or (substring(Name,1,1) = 'Q'))]"/>
      <xsl:with-param name="letter" select="'Q'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'r') or (substring(Name,1,1) = 'R'))]"/>
      <xsl:with-param name="letter" select="'R'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 's') or (substring(Name,1,1) = 'S'))]"/>
      <xsl:with-param name="letter" select="'S'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 't') or (substring(Name,1,1) = 'T'))]"/>
      <xsl:with-param name="letter" select="'T'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'u') or (substring(Name,1,1) = 'U'))]"/>
      <xsl:with-param name="letter" select="'U'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'v') or (substring(Name,1,1) = 'V'))]"/>
      <xsl:with-param name="letter" select="'V'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'w') or (substring(Name,1,1) = 'W'))]"/>
      <xsl:with-param name="letter" select="'W'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'x') or (substring(Name,1,1) = 'X'))]"/>
      <xsl:with-param name="letter" select="'X'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'y') or (substring(Name,1,1) = 'Y'))]"/>
      <xsl:with-param name="letter" select="'Y'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'z') or (substring(Name,1,1) = 'Z'))]"/>
      <xsl:with-param name="letter" select="'Z'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeAnchorLink">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = '_'))]"/>
      <xsl:with-param name="letter" select="'_'"/>
    </xsl:call-template>
<br/><br/>
<table cellspacing="0" border="1" width="100%">
<tr>
    <xsl:attribute name="class">HeaderRow</xsl:attribute>
<th>Name</th>
<th>Comments</th>
</tr>
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'a') or (substring(Name,1,1) = 'A'))]"/>
      <xsl:with-param name="letter" select="'A'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'b') or (substring(Name,1,1) = 'B'))]"/>
      <xsl:with-param name="letter" select="'B'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'c') or (substring(Name,1,1) = 'C'))]"/>
      <xsl:with-param name="letter" select="'C'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'd') or (substring(Name,1,1) = 'D'))]"/>
      <xsl:with-param name="letter" select="'D'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'e') or (substring(Name,1,1) = 'E'))]"/>
      <xsl:with-param name="letter" select="'E'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'f') or (substring(Name,1,1) = 'F'))]"/>
      <xsl:with-param name="letter" select="'F'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'g') or (substring(Name,1,1) = 'G'))]"/>
      <xsl:with-param name="letter" select="'G'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'h') or (substring(Name,1,1) = 'H'))]"/>
      <xsl:with-param name="letter" select="'H'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'i') or (substring(Name,1,1) = 'I'))]"/>
      <xsl:with-param name="letter" select="'I'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'j') or (substring(Name,1,1) = 'J'))]"/>
      <xsl:with-param name="letter" select="'J'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'k') or (substring(Name,1,1) = 'K'))]"/>
      <xsl:with-param name="letter" select="'K'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'l') or (substring(Name,1,1) = 'L'))]"/>
      <xsl:with-param name="letter" select="'L'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'm') or (substring(Name,1,1) = 'M'))]"/>
      <xsl:with-param name="letter" select="'M'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'n') or (substring(Name,1,1) = 'N'))]"/>
      <xsl:with-param name="letter" select="'N'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'o') or (substring(Name,1,1) = 'O'))]"/>
      <xsl:with-param name="letter" select="'O'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'p') or (substring(Name,1,1) = 'P'))]"/>
      <xsl:with-param name="letter" select="'P'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'q') or (substring(Name,1,1) = 'Q'))]"/>
      <xsl:with-param name="letter" select="'Q'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'r') or (substring(Name,1,1) = 'R'))]"/>
      <xsl:with-param name="letter" select="'R'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 's') or (substring(Name,1,1) = 'S'))]"/>
      <xsl:with-param name="letter" select="'S'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 't') or (substring(Name,1,1) = 'T'))]"/>
      <xsl:with-param name="letter" select="'T'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'u') or (substring(Name,1,1) = 'U'))]"/>
      <xsl:with-param name="letter" select="'U'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'v') or (substring(Name,1,1) = 'V'))]"/>
      <xsl:with-param name="letter" select="'V'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'w') or (substring(Name,1,1) = 'W'))]"/>
      <xsl:with-param name="letter" select="'W'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'x') or (substring(Name,1,1) = 'X'))]"/>
      <xsl:with-param name="letter" select="'X'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'y') or (substring(Name,1,1) = 'Y'))]"/>
      <xsl:with-param name="letter" select="'Y'"/>
    </xsl:call-template>
    
    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = 'z') or (substring(Name,1,1) = 'Z'))]"/>
      <xsl:with-param name="letter" select="'Z'"/>
    </xsl:call-template>

    <xsl:call-template name="MakeTable">
      <xsl:with-param name="filter" select="//Items/Item[(@kind='Module') and (@link='1') and ((substring(Name,1,1) = '_'))]"/>
      <xsl:with-param name="letter" select="'_'"/>
    </xsl:call-template>
</table>
    <xsl:call-template name="footer"/>
</body>
</html>
  </xsl:template>
</xsl:stylesheet>
