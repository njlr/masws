<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<!-- Stores the URI as a variable -->
<xsl:variable name="uri" select="concat('&lt;', concat(/entry/site_detail_url, '#franchise>'))"/> 

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<!-- Matches the entry element. Generates the type relation. -->
<xsl:template match="entry">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type>'"/> 
        <xsl:with-param name="object" select="'&lt;https://raw.github.com/nlr/masws/master/vocab.n3#franchise>'"/> 
    </xsl:call-template>
    <xsl:apply-templates select="name"/> 
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
        <xsl:with-param name="predicate" select="'&lt;http://xmlns.com/foaf/0.1/#name>'"/>
        <xsl:with-param name="object" select="$quoted-name"/>
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
        <xsl:with-param name="predicate" select="'&lt;https://raw.github.com/nlr/masws/master/vocab.n3#includes>'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('&lt;http://www.giantbomb.com/', $clean-name), '/3030-'), id), '/#game>')"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
