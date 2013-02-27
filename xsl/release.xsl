<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:variable name="uri" select="concat('&lt;', concat(entry/release/site_detail_url, '>'))"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="release"/>
</xsl:template>

<xsl:template match="release">
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type>'"/>
        <xsl:with-param name="object" select="'&lt;https://raw.github.com/nlr/masws/master/vocab.n3#release>'"/>
    </xsl:call-template>
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
        <xsl:with-param name="predicate" select="'&lt;https://raw.github.com/nlr/masws/master/vocab.n3#isVersionOf>'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('&lt;http://www.giantbomb.com/', $clean-name), '/3030-'), id), '/#game>')"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="release_date">
    <xsl:variable name="date">
        <xsl:text>"</xsl:text>
        <xsl:value-of select="substring(., 1, 10)"/>
        <xsl:text>"</xsl:text>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://dbpedia.org/ontology/releaseDate>'"/>
        <xsl:with-param name="object" select="$date"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="region">
    <xsl:variable name="clean-name">
        <xsl:text>"</xsl:text>
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
        <xsl:text>"</xsl:text>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://dbpedia.org/property/location>'"/>
        <xsl:with-param name="object" select="$clean-name"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
