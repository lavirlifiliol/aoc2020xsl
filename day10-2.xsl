<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" >
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="solve">
        <xsl:param name="arr"/>
        <xsl:param name="arri"/>
        <xsl:param name="ssl"/>
        <xsl:param name="prod"/>
        <xsl:variable name="d" select="$arr[$arri] - $arr[$arri - 1] = 1 and $arr[$arri + 1] - $arr[$arri] = 1 "></xsl:variable>
        <xsl:choose>
            <xsl:when test="$arri gt count($arr) - 1">
                <xsl:value-of select="format-number($prod, '0')"></xsl:value-of>
            </xsl:when>
            <xsl:when test="$d">
                <xsl:call-template name="solve">
                    <xsl:with-param name="arr" select="$arr"></xsl:with-param>
                    <xsl:with-param name="arri" select="$arri + 1"></xsl:with-param>
                    <xsl:with-param name="ssl" select="$ssl + 1"></xsl:with-param>
                    <xsl:with-param name="prod" select="$prod"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="solve">
                    <xsl:with-param name="arr" select="$arr"></xsl:with-param>
                    <xsl:with-param name="arri" select="$arri + 1"></xsl:with-param>
                    <xsl:with-param name="ssl" select="0"></xsl:with-param>
                    <!-- good enough -->
                    <xsl:with-param name="prod" select="$prod * (1, 2, 4, 7, 13, 24, 44, 81, 149, 274, 504)[$ssl + 1]"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
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
            <xsl:variable name="snumbers">
                <number>0</number>
                <xsl:for-each select="$numbers">
                    <xsl:sort select="number(.)"/>
                    <number>
                        <xsl:value-of select="."></xsl:value-of>
                    </number>
                </xsl:for-each>
                <number><xsl:value-of select="max($numbers)+3"></xsl:value-of></number>
            </xsl:variable>
            <xsl:call-template name="solve">
                <xsl:with-param name="arr" select="$snumbers/number"></xsl:with-param>
                <xsl:with-param name="arri" select="2"></xsl:with-param>
                <xsl:with-param name="ssl" select="0"></xsl:with-param>
                <xsl:with-param name="prod" select="1"></xsl:with-param>
            </xsl:call-template>
        </result>
    </xsl:template>
</xsl:stylesheet>
