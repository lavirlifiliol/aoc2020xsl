<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="fuel">
        <xsl:param name="c"></xsl:param>
        <xsl:param name="s"></xsl:param>
        <xsl:choose>
            <xsl:when test="$c &lt; 9 ">
                <number>
                    <xsl:value-of select="$s"></xsl:value-of>
                </number>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="nc" select="floor($c div 3) - 2"></xsl:variable>
                <xsl:call-template name="fuel">
                    <xsl:with-param name="c" select="$nc"></xsl:with-param>
                    <xsl:with-param name="s" select="$s + $nc"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="numbers" as="element(number)*">
                <xsl:analyze-string select="$in" regex="(.*)\n">
                    <xsl:matching-substring>
                        <xsl:call-template name="fuel">
                            <xsl:with-param name="c" select="number(regex-group(1))"></xsl:with-param>
                            <xsl:with-param name="s" select="0"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:value-of select="format-number(sum($numbers), '0')"></xsl:value-of>
        </result>
    </xsl:template>
</xsl:stylesheet>
