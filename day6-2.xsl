<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', ''), '\n([^\n])','$1')"></xsl:variable>
    <xsl:template match="/">
        <result>
            <xsl:variable name="groups" as="element(group)*">
                <xsl:analyze-string select="$in" regex="(.*)\n">
                    <xsl:matching-substring>
                        <group>
                            <xsl:analyze-string select="regex-group(1)" regex="(.)">
                                <xsl:matching-substring>
                                    <yes><xsl:value-of select="regex-group(1)" /></yes>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </group>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:variable name="unique" as="element(group)*">
                <xsl:for-each select="$groups">
                    <group><xsl:value-of select="count(distinct-values(./yes))"/></group>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="sum($unique)"></xsl:value-of>
        </result>
    </xsl:template>
</xsl:stylesheet>
