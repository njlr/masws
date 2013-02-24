<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat(/entry/site_detail_url, '#release')"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="game"/>
    <xsl:apply-templates select="region"/>
    <xsl:apply-templates select="release_date"/>
</xsl:template>

<xsl:template match="game">
    <xsl:variable name="clean-name">
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'https://github.com/nlr/masws/blob/master/vocab#isVersionOf'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('http://www.giantbomb.com/', $clean-name), '/3030-'), id), '/#game')"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="release_date">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'xsd:date'"/>
        <xsl:with-param name="object" select="."/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="region">
    <xsl:variable name="clean-name">
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'https://github.com/nlr/masws/blob/master/vocab#releasedIn'"/>
        <xsl:with-param name="object" select="$clean-name"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
