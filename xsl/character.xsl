<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat(/entry/site_detail_url, '#character')"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="gender"/>
    <xsl:apply-templates select="friends"/>
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
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'foaf:birthday'"/>
        <xsl:with-param name="object" select="."/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="friends">
    <xsl:apply-templates select="friend"/>
</xsl:template>

<xsl:template match="friend">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'https://github.com/nlr/masws/blob/master/vocab#friend'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('http://www.giantbomb.com/', name), '/3005-'), id), '#character')"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
