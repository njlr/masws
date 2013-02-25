<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat('&lt;', concat(/entry/site_detail_url, '#character>'))"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="gender"/>
    <xsl:apply-templates select="friends"/>
    <xsl:apply-templates select="enemies"/>
</xsl:template>

<xsl:template match="name">
    <xsl:variable name="quoted-name">
        <xsl:text>"</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://xmlns.com/foaf/0.1/#name>'"/>
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
                <xsl:with-param name="predicate" select="'&lt;http://xmlns.com/foaf/0.1/#gender>'"/>
                <xsl:with-param name="object" select="$quoted-gender"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test=". = 0">
            <xsl:variable name="quoted-gender">
                <xsl:text>"female"</xsl:text>
            </xsl:variable>
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'&lt;http://xmlns.com/foaf/0.1/#gender>'"/>
                <xsl:with-param name="object" select="$quoted-gender"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="quoted-gender">
                <xsl:text>"other"</xsl:text>
            </xsl:variable>
            <xsl:call-template name="statement">
                <xsl:with-param name="subject" select="$uri"/>
                <xsl:with-param name="predicate" select="'&lt;http://xmlns.com/foaf/0.1/#gender>'"/>
                <xsl:with-param name="object" select="$quoted-gender"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="friends">
    <xsl:apply-templates select="friend"/>
</xsl:template>

<xsl:template match="friend">
    <xsl:variable name="clean-name">
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;https://github.com/nlr/masws/blob/master/vocab#friend>'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('&lt;http://www.giantbomb.com/', $clean-name), '/3005-'), id), '/#character>')"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="enemies">
    <xsl:apply-templates select="enemy"/>
</xsl:template>

<xsl:template match="enemy">
    <xsl:variable name="clean-name">
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;https://github.com/nlr/masws/blob/master/vocab#foe>'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('&lt;http://www.giantbomb.com/', $clean-name), '/3005-'), id), '/#character>')"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
