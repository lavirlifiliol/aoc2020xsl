<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:variable name="preamble" select="25"/>
    <xsl:template name="isin2sum">
        <xsl:param name="arr"></xsl:param>
        <xsl:param name="n"></xsl:param>
        <xsl:for-each select="$arr">
            <xsl:variable name="here" select="@num"></xsl:variable>
            <xsl:if test="$arr[@num=string($n - $here)]">
                <R>1</R>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="solve">
        <xsl:param name="arr"></xsl:param>
        <xsl:param name="arri"></xsl:param>
        <xsl:variable name="res">
            <xsl:call-template name="isin2sum">
                <xsl:with-param name="arr" select="$arr[position() gt ($arri - $preamble - 1) and position() lt $arri]"></xsl:with-param>
                <xsl:with-param name="n" select="number($arr[$arri])"></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
            <xsl:message select="$res"></xsl:message>
        <xsl:choose>
            <xsl:when test="$arri gt count($arr)">
                ERROR
            </xsl:when>
            <xsl:when test="$res != ''">
                <xsl:call-template name="solve">
                    <xsl:with-param name="arr" select="$arr"></xsl:with-param>
                    <xsl:with-param name="arri" select="$arri + 1"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="format-number(number($arr[$arri]), '0')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="numbers">
                <xsl:analyze-string select="$in" regex="(.*)\n">
                    <xsl:matching-substring>
                        <number num="{number(regex-group(1))}"><xsl:value-of select="number(regex-group(1))"></xsl:value-of></number>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:call-template name="solve">
                <xsl:with-param name="arr" select="$numbers/number"></xsl:with-param>
                <xsl:with-param name="arri" select="$preamble+1"></xsl:with-param>
            </xsl:call-template>
        </result>
    </xsl:template>
</xsl:stylesheet>
