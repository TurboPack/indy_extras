<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:key name="GetItem" match="//Items/Item" use="@id"/>

  <xsl:template name="reftable">

    <xsl:param name="caption"/>
    <xsl:param name="filter"/>
    <xsl:param name="Target"/>
    <xsl:param name="bModuleColumn" select="1"/>
    <xsl:param name="bReferrerColumn" select="1"/>
    
    <xsl:variable name="NumItems" select="count($filter)"/> 
      <xsl:if test="$NumItems &gt; 0">
<h2>
      <xsl:value-of select="$caption"/> (<xsl:value-of select="$NumItems"/>)
</h2>
<table cellspacing="0" border="1" width="100%">
<tr>
      <xsl:attribute name="CLASS">RefHeaderRow</xsl:attribute>

      <xsl:if test="$bModuleColumn='1'">
<th>Module (line)</th> 
      </xsl:if>

      <xsl:if test="$bReferrerColumn='1'">
<th>Referrer</th> 
      </xsl:if>

</tr>
      <xsl:for-each select="$filter">
        <xsl:sort select="key('GetItem',@modid)/Name"/>
<tr>
        <xsl:choose>
          <xsl:when test="position() mod 2 = 1">
            <xsl:attribute name="class">RefOddRow</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">RefEvenRow</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$bModuleColumn='1'">
<td>
<a> 
          <xsl:attribute name="href">
            <xsl:value-of select="@modid"/>.{#Extension}#L<xsl:value-of select="@line"/>
          </xsl:attribute>
          
          <xsl:if test="$Target!=''">
            <xsl:attribute name="target">$Target</xsl:attribute>
          </xsl:if>
          
          <xsl:attribute name="title">Click here to jump to location</xsl:attribute>
          <xsl:value-of select="concat(key('GetItem',@modid)/Name,' (',@line,')')"/>
</a>
</td>
        </xsl:if>
        
        <xsl:if test="$bReferrerColumn='1'">
<td>
          <xsl:choose> 
            <xsl:when test="key('GetItem',Item/@id)/Name!=''">        
              <xsl:call-template name="InsertName">
                <xsl:with-param name="ID" select="Item/@id"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
- 
            </xsl:otherwise>
          </xsl:choose>
</td>           
        </xsl:if>
</tr>    
      </xsl:for-each>
</table>
    </xsl:if>
  </xsl:template>          
</xsl:stylesheet>
