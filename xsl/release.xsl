<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat(/entry/site_detail_url, '#release')"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="region"/>
    <xsl:apply-templates select="release_date"/>
</xsl:template>

<xsl:template match="region">
    <xsl:apply-templates select="name"/>
</xsl:template>

<xsl:template match="release_date">
    <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="name">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'gn:name'"/>
        <xsl:with-param name="object" select="."/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
