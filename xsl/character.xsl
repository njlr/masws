<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat(/entry/site_detail_url, '#character')"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="gender"/>
    <xsl:apply-templates select="birthday"/>
</xsl:template>

<xsl:template match="name">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'foaf:name'"/>
        <xsl:with-param name="object" select="."/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="gender">
    <xsl:choose>
        <xsl:when test=". = 1">
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'foaf:gender'"/>
                <xsl:with-param name="object" select="'male'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test=". = 0">
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'foaf:gender'"/>
                <xsl:with-param name="object" select="'female'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'foaf:gender'"/>
                <xsl:with-param name="object" select="'other'"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<xsl:template match="birthday">
    <xsl:value-of select="."/>
</xsl:template>

<xsl:template name="statement">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="object"/>
    <xsl:value-of select="$uri"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$predicate"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$object"/>
    <xsl:text> .&#xa;</xsl:text>
</xsl:template>

<!-- Provides a warning when an element leaks -->
<xsl:template match="*">
    <xsl:message terminate="no">
        <xsl:text>Unmatched element: </xsl:text>
        <xsl:value-of select="name()"/>
    </xsl:message>
</xsl:template>

</xsl:stylesheet>
