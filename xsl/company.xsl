<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat('&lt;', concat(/entry/site_detail_url, '#company>'))"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
    <xsl:apply-templates select="developed_games"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://www.w3.org/TR/rdf-schema/#type>'"/>
        <xsl:with-param name="object" select="'&lt;http://dbpedia.org/ontology/Organisation>'"/>
    </xsl:call-template>
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="developed_games"/>
    <xsl:apply-templates select="published_games"/>
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

<xsl:template match="developed_games">
    <xsl:apply-templates select="game" mode="dev"/>
</xsl:template>

<xsl:template match="published_games">
    <xsl:apply-templates select="game" mode="pub"/>
</xsl:template>

<xsl:template match="game" mode="dev">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://dbpedia.org/ontology/developer>'"/>
        <xsl:with-param name="object" select="concat('&lt;', concat(site_detail_url, '#game>'))"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="game" mode="pub">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://dbpedia.org/ontology/publisher>'"/>
        <xsl:with-param name="object" select="concat('&lt;', concat(site_detail_url, '#game>'))"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
