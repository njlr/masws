<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"/>

<xsl:template name="statement">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="object"/>
    <xsl:value-of select="$subject"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$predicate"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$object"/>
    <xsl:text> .&#xa;</xsl:text>
</xsl:template>

<xsl:template name="replace">
    <xsl:param name="ptext"/>
    <xsl:param name="ppattern"/>
    <xsl:param name="preplacement"/>
    <xsl:choose>
        <xsl:when test="not(contains($ptext, $ppattern))">
            <xsl:value-of select="$ptext"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="substring-before($ptext, $ppattern)"/>
            <xsl:value-of select="$preplacement"/>
            <xsl:call-template name="replace">
                <xsl:with-param name="ptext" select="substring-after($ptext, $ppattern)"/>
                <xsl:with-param name="ppattern" select="$ppattern"/>
                <xsl:with-param name="preplacement" select="$preplacement"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="clean-name">
    <xsl:param name="name"/>
    <xsl:variable name="i">
        <xsl:call-template name="replace">
            <xsl:with-param name="ptext" select="$name"/>
            <xsl:with-param name="ppattern" select="' '"/>
            <xsl:with-param name="preplacement" select="'-'"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="replace">
        <xsl:with-param name="ptext" select="$i"/>
        <xsl:with-param name="ppattern" select="'.'"/>
        <xsl:with-param name="preplacement" select="''"/>
    </xsl:call-template>
</xsl:template>

<!-- Provides a warning when an element leaks -->
<xsl:template match="*">
    <xsl:message terminate="no">
        <xsl:text>Unmatched element: </xsl:text>
        <xsl:value-of select="name()"/>
    </xsl:message>
</xsl:template>

</xsl:stylesheet>
