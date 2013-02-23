<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/response/results">
    <xsl:element name="entry">
        <xsl:copy-of select="*"/>
    </xsl:element>
</xsl:template>

<!-- The default behaviour of xsl is to output all unmatched elements. This suppresses that default. -->
<xsl:template match="text()"/>

</xsl:stylesheet>
