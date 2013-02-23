<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="gender"/>
    <xsl:apply-templates select="birthday"/>
</xsl:template>

<xsl:template match="name">
    <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="gender">
    <xsl:choose>
        <xsl:when test=". = 1">
            <xsl:text>male</xsl:text>
        </xsl:when>
        <xsl:when test=". = 0">
            <xsl:text>female</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>other</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="birthday">
    <xsl:value-of select="."/>
</xsl:template>

<!-- Provides a warning when an element leaks -->
<xsl:template match="*">
    <xsl:message terminate="no">
        <xsl:text>Unmatched element: </xsl:text>
        <xsl:value-of select="name()"/>
    </xsl:message>
</xsl:template>

</xsl:stylesheet>
