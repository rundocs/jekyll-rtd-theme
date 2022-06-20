<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom"
  exclude-result-prefixes="atom"
>
<xsl:template match="/">
<HTML>
  <BODY>
    <TABLE BORDER="2">
      <TR>
        <TD>Name</TD>
        <TD>Feed Id</TD>
        <TD>Published</TD>
      </TR>
      <xsl:apply-templates select="atom:feed/atom:entry">
        <xsl:sort select="atom:published"/>
      </xsl:apply-templates>      
    </TABLE>

  </BODY>
</HTML>
</xsl:template>

<xsl:template match="atom:feed/atom:entry">
      <TR>
        <TD><xsl:value-of select="atom:title"/></TD>              
        <TD><A><xsl:attribute name="href"><xsl:value-of select="atom:link/@href"/></xsl:attribute><xsl:value-of select="atom:id"/></A></TD>
        <TD><xsl:value-of select="atom:published"/></TD>
      </TR>
      </xsl:template>
</xsl:stylesheet>