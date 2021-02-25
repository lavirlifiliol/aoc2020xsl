<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="has2020">
        <xsl:param name="n"></xsl:param>
        <xsl:param name="ns"></xsl:param>
        <xsl:for-each select="$ns">
            <xsl:if test="$n + . = 2020">
                <answer>
                    <xsl:value-of select="$n * ."></xsl:value-of>
                </answer>
                <debug>
                    <a>
                        <xsl:value-of select="$n"></xsl:value-of>
                    </a>
                    <a>
                        <xsl:value-of select="."></xsl:value-of>
                    </a>
                </debug>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="numbers" as="element(number)*">
                <xsl:analyze-string select="$in" regex="(.*)\n">
                    <xsl:matching-substring>
                        <number>
                            <xsl:value-of select="number(regex-group(1))"></xsl:value-of>
                        </number>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
        <xsl:for-each select="$numbers">
            <xsl:call-template name="has2020">
                <xsl:with-param name="n" select="."></xsl:with-param>
                <xsl:with-param name="ns" select="$numbers"></xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
        </result>
    </xsl:template>
</xsl:stylesheet>
