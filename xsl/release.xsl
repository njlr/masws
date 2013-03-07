<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="./utils.xsl"/> 

<xsl:output method="text"/>

<xsl:template match="/">
    <xsl:apply-templates select="entry"/>
</xsl:template>

<xsl:template match="entry">
    <xsl:apply-templates select="release"/>
</xsl:template>

<!-- Matches the release element. Generates the type relation. -->
<xsl:template match="release">
    <!-- Stores the URI as a variable -->
    <xsl:variable name="uri" select="concat('&lt;', concat(site_detail_url, '>'))"/>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://www.w3.org/TR/rdf-schema/#type>'"/>
        <xsl:with-param name="object" select="'&lt;https://raw.github.com/nlr/masws/master/vocab.n3#release>'"/>
    </xsl:call-template>
    <!-- game -->
    <xsl:variable name="game-name">
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="name"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;https://raw.github.com/nlr/masws/master/vocab.n3#isVersionOf>'"/>
        <xsl:with-param name="object" select="concat(concat(concat(concat('&lt;http://www.giantbomb.com/', $game-name), '/3030-'), id), '/#game>')"/>
    </xsl:call-template>
    <!-- release date -->
    <xsl:variable name="date">
        <xsl:text>"</xsl:text>
        <xsl:value-of select="substring(release_date, 1, 10)"/>
        <xsl:text>"</xsl:text>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://dbpedia.org/ontology/releaseDate>'"/>
        <xsl:with-param name="object" select="$date"/>
    </xsl:call-template>
    <!-- region -->
    <xsl:variable name="region-name">
        <xsl:text>"</xsl:text>
        <xsl:call-template name="clean-name">
            <xsl:with-param name="name" select="region/name"/>
        </xsl:call-template>
        <xsl:text>"</xsl:text>
    </xsl:variable>
    <xsl:call-template name="statement">
        <xsl:with-param name="subject" select="$uri"/>
        <xsl:with-param name="predicate" select="'&lt;http://dbpedia.org/property/location>'"/>
        <xsl:with-param name="object" select="$region-name"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
