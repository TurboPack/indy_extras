<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:key name="GetItem" match="//Items/Item" use="@id"/>

  <xsl:template name="todotable">
    <xsl:param name="caption"/>
    <xsl:param name="filter"/>
    <xsl:param name="Target"/>
    <xsl:param name="bTodoColumn" select="1"/>
    <xsl:param name="bCategoryColumn"/>
    <xsl:param name="bModuleColumn"/>
    <xsl:param name="bOwnerColumn"/>
    <xsl:param name="bPriorityColumn"/>
    <xsl:param name="bStatusColumn"/>

    <xsl:variable name="NumItems" select="count($filter)"/>
    <xsl:if test="$NumItems &gt; 0">
<h2>
      <xsl:value-of select="$caption"/> (<xsl:value-of select="$NumItems"/>)
</h2>
<table cellspacing="0" border="1" width="100%">
<tr>
      <xsl:attribute name="class">TodoHeaderRow</xsl:attribute>
      <xsl:if test="$bTodoColumn='1'">
<th>Text</th> 
      </xsl:if>
      
      <xsl:if test="$bModuleColumn='1'">
<th>Module</th> 
      </xsl:if>
     
      <xsl:if test="$bCategoryColumn='1'">
<th>Category</th> 
      </xsl:if>

      <xsl:if test="$bOwnerColumn='1'">
<th>Owner</th> 
      </xsl:if>
     
      <xsl:if test="$bPriorityColumn='1'">
<th>Priority</th> 
      </xsl:if>
    
      <xsl:if test="$bStatusColumn='1'">
<th>Status</th> 
      </xsl:if>
</tr>
      <xsl:for-each select="$filter">
        <xsl:sort select="Text"/>
<tr>
        <xsl:choose>
          <xsl:when test="position() mod 2 = 1">
            <xsl:attribute name="class">TodoOddRow</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">TodoEvenRow</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$bTodoColumn='1'">
<td>
          <xsl:choose>
            <xsl:when test="@line!='-1'">
<a> 
              <xsl:attribute name="href">
                <xsl:value-of select="@modid"/>.{#Extension}#L<xsl:value-of select="@line"/>
              </xsl:attribute>
                      
              <xsl:if test="$Target!=''">
                <xsl:attribute name="target">$Target</xsl:attribute>
              </xsl:if>
                      
              <xsl:attribute name="title">Click here to jump to location</xsl:attribute>
              <xsl:value-of select="Text"/>
</a>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="Text"/>           
            </xsl:otherwise>
          </xsl:choose>
</td>
        </xsl:if>

        <xsl:if test="$bModuleColumn='1'">
<td>
          <xsl:choose>
            <xsl:when test="key('GetItem',@modid)/Name!=''">
<a>
              <xsl:attribute name="href"><xsl:value-of select="@modid"/>.{#Extension}</xsl:attribute>
              <xsl:if test="$Target!=''">
                <xsl:attribute name="target">$Target</xsl:attribute>
              </xsl:if>

              <xsl:attribute name="title"><xsl:value-of select="key('GetItem',@modid)/Path"/></xsl:attribute>
              <xsl:value-of select="key('GetItem',@modid)/Name"/>
</a>
            </xsl:when>
            <xsl:otherwise>
-
            </xsl:otherwise>
          </xsl:choose>  
</td>
        </xsl:if>

        <xsl:if test="$bCategoryColumn='1'">
          <xsl:choose>
            <xsl:when test="Category!=''">
<td>
              <xsl:value-of select="Category"/>
</td>           
            </xsl:when>
            <xsl:otherwise>
<td>-</td>           
            </xsl:otherwise>
          </xsl:choose>  
        </xsl:if>

        <xsl:if test="$bOwnerColumn='1'">
          <xsl:choose>
            <xsl:when test="Owner!=''">
<td>
              <xsl:value-of select="Owner"/>
</td>
            </xsl:when>
            <xsl:otherwise>
<td>-</td>           
            </xsl:otherwise>
          </xsl:choose>  
        </xsl:if>

        <xsl:if test="$bPriorityColumn='1'">
          <xsl:choose>
            <xsl:when test="Priority!='0'">
<td>
              <xsl:value-of select="Priority"/>
</td>           
            </xsl:when>
            <xsl:otherwise>
<td>-</td>           
            </xsl:otherwise>
          </xsl:choose>  
        </xsl:if>

        <xsl:if test="$bStatusColumn='1'">
          <xsl:choose>
            <xsl:when test="@done='1'">
<td>Done</td>           
            </xsl:when>
            <xsl:otherwise>
<td>Open</td>           
            </xsl:otherwise>
          </xsl:choose>  
        </xsl:if>
</tr>    
      </xsl:for-each>
</table>
    </xsl:if>
  </xsl:template>          
</xsl:stylesheet>
