<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="goal" select="23278925"/>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="solve">
        <xsl:param name="arr"></xsl:param>
        <xsl:param name="hare"></xsl:param>
        <xsl:param name="turtle"></xsl:param>
        <xsl:variable name="res" select="sum($arr[position() gt ($turtle - 1) and position() lt ($hare + 1)])"> </xsl:variable>
        <xsl:choose>
            <xsl:when test="$hare gt count($arr)">
                ERROR
            </xsl:when>
            <xsl:when test="$res = $goal">
                <xsl:message select="concat($turtle,' ', $hare)"></xsl:message>
                <xsl:variable name="tv" select="$arr[position() gt ($turtle - 1) and position() lt ($hare + 1)]"> </xsl:variable>
                <xsl:value-of select="format-number(min($tv)+max($tv), '0')"/>
            </xsl:when>
            <xsl:when test="$res lt $goal">
                <xsl:call-template name="solve">
                    <xsl:with-param name="arr" select="$arr"></xsl:with-param>
                    <xsl:with-param name="hare" select="$hare+1"></xsl:with-param>
                    <xsl:with-param name="turtle" select="$turtle"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$res gt $goal">
                <xsl:call-template name="solve">
                    <xsl:with-param name="arr" select="$arr"></xsl:with-param>
                    <xsl:with-param name="hare" select="$hare"></xsl:with-param>
                    <xsl:with-param name="turtle" select="$turtle+1"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>ERROR2</xsl:otherwise>
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
                <xsl:with-param name="turtle" select="1"></xsl:with-param>
                <xsl:with-param name="hare" select="3"></xsl:with-param>
            </xsl:call-template>
        </result>
    </xsl:template>
</xsl:stylesheet>
