<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat(/entry/site_detail_url, '#person')"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="gender"/>
    <xsl:apply-templates select="birth_date"/>
    <xsl:apply-templates select="country"/>
    <xsl:apply-templates select="companies"/>
    <xsl:apply-templates select="games"/>
</xsl:template>

<xsl:template match="name">
    <xsl:variable name="quoted-name">
        <xsl:text>"</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'foaf:name'"/>
        <xsl:with-param name="object" select="$quoted-name"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="gender">
    <xsl:choose>
        <xsl:when test=". = 1">
            <xsl:variable name="quoted-gender">
                <xsl:text>"male"</xsl:text>
            </xsl:variable>
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'foaf:gender'"/>
                <xsl:with-param name="object" select="$quoted-gender"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test=". = 0">
            <xsl:variable name="quoted-gender">
                <xsl:text>"female"</xsl:text>
            </xsl:variable>
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'foaf:gender'"/>
                <xsl:with-param name="object" select="$quoted-gender"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="quoted-gender">
                <xsl:text>"other"</xsl:text>
            </xsl:variable>
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'foaf:gender'"/>
                <xsl:with-param name="object" select="$quoted-gender"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="birth_date">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'xsd:date'"/>
        <xsl:with-param name="object" select="."/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="country">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'https://github.com/nlr/masws/blob/master/vocab#comesFrom'"/>
        <xsl:with-param name="object" select="."/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="companies">
    <xsl:apply-templates select="company"/>
</xsl:template>

<xsl:template match="company">
    <xsl:variable name="clean-name">
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'https://github.com/nlr/masws/blob/master/vocab#workedAt'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('http://www.giantbomb.com/', $clean-name), '/3010-'), id), '/#company')"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="games">
    <xsl:apply-templates select="game"/>
</xsl:template>

<xsl:template match="game">
    <xsl:variable name="clean-name">
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'https://github.com/nlr/masws/blob/master/vocab#developed'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('http://www.giantbomb.com/', $clean-name), '/3030-'), id), '/#company')"/>
    </xsl:call-template>
</xsl:template>


</xsl:stylesheet>
