<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Provides a number of helper templates for generating Turtle -->

<xsl:output method="text"/>

<!-- Use to create a single line of Turtle (n3) -->
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

<!-- Performs a replacement of ppattern with prepalcement on ptext -->
<!-- Particularly useful when sanitizing text -->
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

<!-- Helper variables -->
<xsl:variable name="dq">
    <xsl:text>"</xsl:text>
</xsl:variable>
<xsl:variable name="dq2">
    <xsl:text>"</xsl:text>
</xsl:variable>
<xsl:variable name="colon">
    <xsl:text>:</xsl:text>
</xsl:variable>
<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<!-- Cleans up a name for use as part of a URL -->
<xsl:template name="clean-name">
    <xsl:param name="name"/>
    <xsl:variable name="i">
        <xsl:call-template name="replace">
            <xsl:with-param name="ptext" select="translate($name, $uppercase, $lowercase)"/>
            <xsl:with-param name="ppattern" select="' '"/>
            <xsl:with-param name="preplacement" select="'-'"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="j">
        <xsl:call-template name="replace">
            <xsl:with-param name="ptext" select="$i"/>
            <xsl:with-param name="ppattern" select="'$dq'"/>
            <xsl:with-param name="preplacement" select="''"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="k">
        <xsl:call-template name="replace">
            <xsl:with-param name="ptext" select="$j"/>
            <xsl:with-param name="ppattern" select="'$dq2'"/>
            <xsl:with-param name="preplacement" select="''"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="l">
        <xsl:call-template name="replace">
            <xsl:with-param name="ptext" select="$k"/>
            <xsl:with-param name="ppattern" select="$dq2"/>
            <xsl:with-param name="preplacement" select="''"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="m">
        <xsl:call-template name="replace">
            <xsl:with-param name="ptext" select="$l"/>
            <xsl:with-param name="ppattern" select="$colon"/>
            <xsl:with-param name="preplacement" select="''"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="replace">
        <xsl:with-param name="ptext" select="$m"/>
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

