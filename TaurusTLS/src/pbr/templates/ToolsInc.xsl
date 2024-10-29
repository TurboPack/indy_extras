<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:key name="GetItem" match="//Items/Item" use="@id"/>

  <xsl:template name="Comments">
    <xsl:param name="ID"/>
    <xsl:variable name="Me" select="key('GetItem',$ID)"/>

    <xsl:choose>
      <xsl:when test="//Items/General/XMLComments='0'">
        <xsl:if test="$Me/Info/Comments!=''">
<h2>Comments</h2>
<pre class="Comment">
          <xsl:value-of select="$Me/Info/Comments"/>
</pre>
<br/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$Me/Info/summary!=''">
<h2>Summary</h2>
<pre class="Comment">
          <xsl:value-of select="$Me/Info/summary"/>
</pre>
<br/>
        </xsl:if>
        <xsl:if test="$Me/Info/remarks!=''">
<h2>Remarks</h2>
<pre class="Comment">
          <xsl:value-of select="$Me/Info/remarks"/>
</pre>
<br/>
        </xsl:if>
        <xsl:if test="$Me/Info/author!=''">
<h2>Author</h2>
<pre class="Comment">
          <xsl:value-of select="$Me/Info/author"/>
</pre>
<br/>
        </xsl:if>

        <xsl:if test="$Me/Info/extra!=''">
<h2>Extra</h2>
<pre class="Comment">
          <xsl:value-of select="$Me/Info/extra"/>
</pre>
<br/>
        </xsl:if>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="MakeAnchorLink">
    <xsl:param name="filter"/>
    <xsl:param name="letter"/>

    <xsl:choose>
      <xsl:when test="count($filter) &gt; 0">
<a>
        <xsl:attribute name="href"><xsl:value-of select="concat('#',$letter,' ')"/></xsl:attribute>
        <xsl:value-of select="concat($letter,' ')"/>
</a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(' ',$letter,' ')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="Status">
    <xsl:param name="ID"/>
    <xsl:variable name="Me" select="key('GetItem',$ID)"/>
<script type="text/javascript">
    <xsl:choose>
      <xsl:when test="$Me/Path!=''">
window.status='<xsl:value-of select="concat($Me/@kind,' ',$Me/Name)"/>'
      </xsl:when>
      <xsl:otherwise>
window.status='<xsl:value-of select="concat($Me/@kind,' ',$Me/Name)"/> in <xsl:value-of select="key('GetItem',$Me/@modid)/Name"/>'
      </xsl:otherwise>
    </xsl:choose>
</script>
  </xsl:template>

  <xsl:template name="InsertName">
    <xsl:param name="ID"/>
    <xsl:param name="ModuleID"/>
    <xsl:param name="OwnerID"/>
    <xsl:param name="ShowURL" select="1"/>
    <xsl:param name="Target"/>

    <xsl:variable name="Module" select="key('GetItem',$ModuleID)"/>
    <xsl:variable name="Owner" select="key('GetItem',$OwnerID)"/>
    <xsl:variable name="Me" select="key('GetItem',$ID)"/>

    <xsl:if test="$ModuleID!=''">
      <xsl:choose>
        <xsl:when test="($ShowURL='1') and ($Module/@link='1')">
<a>
          <xsl:attribute name="href"><xsl:value-of select="$ModuleID"/>.{#Extension}</xsl:attribute>

          <xsl:if test="$Target!=''">
            <xsl:attribute name="target"><xsl:value-of select="$Target"/></xsl:attribute>
          </xsl:if>

          <xsl:attribute name="title"><xsl:value-of select="$Module/Path"/></xsl:attribute>
          <xsl:value-of select="$Module/Name"/>
</a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$Module/Name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <xsl:if test="($OwnerID!='')">
      <xsl:if test="$ModuleID!=''">
        <xsl:value-of select="'.'"/>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="($ShowURL='1') and ($Owner/@link='1')">
<a>
          <xsl:attribute name="href"><xsl:value-of select="$OwnerID"/>.{#Extension}</xsl:attribute>

          <xsl:if test="$Target!=''">
            <xsl:attribute name="target"><xsl:value-of select="$Target"/></xsl:attribute>
          </xsl:if>

          <xsl:if test="$ModuleID=''">
            <xsl:attribute name="title"><xsl:value-of select="concat(key('GetItem',$Owner/@modid)/Name,'.',$Owner/Name)"/></xsl:attribute>
          </xsl:if>

          <xsl:value-of select="$Owner/Name"/>
</a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$Owner/Name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <xsl:if test="$ID!=''">
      <xsl:if test="$OwnerID!=''">
        <xsl:value-of select="'.'"/>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="($ShowURL='1') and ($Me/@link='1')">
<a>
          <xsl:attribute name="href"><xsl:value-of select="$ID"/>.{#Extension}</xsl:attribute>

          <xsl:if test="$Target!=''">
            <xsl:attribute name="target"><xsl:value-of select="$Target"/></xsl:attribute>
          </xsl:if>

          <xsl:if test="$ModuleID=''">
            <xsl:choose>
              <xsl:when test="$Me/OwnerTypeID!=''">
                <xsl:attribute name="title">
                  <xsl:value-of select="concat(key('GetItem',$Me/@modid)/Name,'.',key('GetItem',$Me/OwnerTypeID)/Name,'.',$Me/Name)"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="title">
                  <xsl:value-of select="concat(key('GetItem',$Me/@modid)/Name,'.',$Me/Name)"/>
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>

          <xsl:value-of select="$Me/Name"/>
</a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$Me/Name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <xsl:if test="($ID='') and ($ModuleID='') and ($OwnerID='')">
-
    </xsl:if>
  </xsl:template>

  <xsl:template name="InsertTableCell">
    <xsl:param name="bSmallImages"/>
    <xsl:param name="ID"/>
    <xsl:param name="ModuleID"/>
    <xsl:param name="OwnerID"/>
    <xsl:param name="Target"/>
    <xsl:param name="Width"/>
    <xsl:param name="NameString"/>

<td>
    <xsl:if test="$Width!=''">
      <xsl:attribute name="width">
        <xsl:value-of select="$Width"/>%
      </xsl:attribute>
    </xsl:if>

    <xsl:if test="$bSmallImages='1'">
      <xsl:choose>
        <xsl:when test="$ID!=''">
          <xsl:call-template name="Image16">
            <xsl:with-param name="kind" select="key('GetItem',$ID)/@kind"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="Image16">
            <xsl:with-param name="kind" select="key('GetItem',$ModuleID)/@kind"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="($ID!='') or ($ModuleID!='') or ($OwnerID!='')">
        <xsl:call-template name="InsertName">
          <xsl:with-param name="ID" select="$ID"/>
          <xsl:with-param name="ModuleID" select="$ModuleID"/>
          <xsl:with-param name="OwnerID" select="$OwnerID"/>
          <xsl:with-param name="Target" select="$Target"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$NameString!=''">
            <xsl:value-of select="$NameString"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'-'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
</td>
  </xsl:template>

  <xsl:template name="table">
    <xsl:param name="caption"/>
    <xsl:param name="filter"/>
    <xsl:param name="Target"/>

    <xsl:param name="bSmallImages" select="1"/>
    <xsl:param name="bCommentsColumn"/>
    <xsl:param name="bDeclarationColumn"/>
    <xsl:param name="bModuleColumn"/>
    <xsl:param name="bNameColumn"/>
    <xsl:param name="bOwnerColumn"/>
    <xsl:param name="bOwner_NameColumn"/>
    <xsl:param name="bScopeColumn"/>
    <xsl:param name="bTypeColumn"/>

    <xsl:if test="count($filter) &gt; 0">
<h2>
      <xsl:value-of select="$caption"/>
</h2>
<table cellspacing="0" border="1" width="100%">
<tr>
      <xsl:attribute name="class">HeaderRow</xsl:attribute>

      <xsl:if test="($bNameColumn='1') or ($bOwner_NameColumn='1')">
<TH>Name</TH>
      </xsl:if>

      <xsl:if test="$bTypeColumn='1'">
<TH>Type</TH>
      </xsl:if>

      <xsl:if test="$bOwnerColumn='1'">
<TH>Owner</TH>
      </xsl:if>

      <xsl:if test="$bDeclarationColumn='1'">
<TH>Declaration</TH>
      </xsl:if>

      <xsl:if test="$bModuleColumn='1'">
<TH>Module</TH>
      </xsl:if>

      <xsl:if test="$bScopeColumn='1'">
<TH>Scope</TH>
      </xsl:if>

      <xsl:if test="$bCommentsColumn='1'">
<TH>Comments</TH>
      </xsl:if>
</tr>
      <xsl:for-each select="$filter">
        <xsl:sort select="key('GetItem',@id)/Name"/>
<tr>
        <xsl:choose>
          <xsl:when test="position() mod 2 = 1">
            <xsl:attribute name="class">OddRow</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">EvenRow</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$bNameColumn='1'">
           <xsl:call-template name="InsertTableCell">
             <xsl:with-param name="Target" select="$Target"/>
             <xsl:with-param name="ID" select="@id"/>
             <xsl:with-param name="bSmallImages" select="$bSmallImages"/>
           </xsl:call-template>
        </xsl:if>

        <xsl:if test="$bOwner_NameColumn='1'">
           <xsl:call-template name="InsertTableCell">
             <xsl:with-param name="Target" select="$Target"/>
             <xsl:with-param name="ID" select="@id"/>
             <xsl:with-param name="OwnerID" select="key('GetItem',@id)/OwnerTypeID"/>

             <xsl:with-param name="bSmallImages" select="$bSmallImages"/>
           </xsl:call-template>
        </xsl:if>

        <xsl:if test="$bOwnerColumn='1'">
           <xsl:call-template name="InsertTableCell">
             <xsl:with-param name="Target" select="$Target"/>
             <xsl:with-param name="ID" select="OwnerTypeID"/>
             <xsl:with-param name="NameString" select="OwnerTypeName"/>
           </xsl:call-template>
        </xsl:if>

        <xsl:if test="$bTypeColumn='1'">
          <xsl:call-template name="InsertTableCell">
            <xsl:with-param name="Target" select="$Target"/>
            <xsl:with-param name="ID" select="TypeID"/>
            <xsl:with-param name="NameString" select="TypeName"/>
          </xsl:call-template>
        </xsl:if>

        <xsl:if test="$bDeclarationColumn='1'">
<td>
{#DeclById<xsl:value-of select="@id"/>}
</td>
        </xsl:if>

        <xsl:if test="$bModuleColumn='1'">
           <xsl:call-template name="InsertTableCell">
             <xsl:with-param name="Target" select="$Target"/>
             <xsl:with-param name="ModuleID" select="@modid"/>
           </xsl:call-template>
        </xsl:if>

        <xsl:if test="$bScopeColumn='1'">
          <xsl:choose>
            <xsl:when test="ClaScope!=''">
<td>
              <xsl:value-of select="ClaScope"/>
</td>
            </xsl:when>
            <xsl:otherwise>
<td>
              <xsl:value-of select="Scope"/>
</td>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <xsl:if test="$bCommentsColumn='1'">
          <xsl:choose>
            <xsl:when test="Info/Comments!=''">
<td>
              <xsl:choose>
                <xsl:when test="contains(Info/Comments,'&#13;&#10;')"> <!-- we only need <pre> if multi-line comment -->
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
                  <xsl:value-of select="Info/Comments"/>
                </xsl:otherwise>
              </xsl:choose>
</td>
            </xsl:when>
            <xsl:otherwise>
<td>-</td>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
</tr>
      </xsl:for-each>
</table>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
