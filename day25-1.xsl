<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="card" select="15733400"/>
    <xsl:variable name="door" select="6408062"/>
    <xsl:template name="dlog">
        <xsl:param name="base"></xsl:param>
        <xsl:param name="num"></xsl:param>
        <xsl:param name="class"></xsl:param>
        <xsl:param name="guess"></xsl:param>
        <xsl:param name="exp"></xsl:param>
        <xsl:choose>
            <xsl:when test="$guess mod $class = $num">
                <xsl:value-of select="$exp"></xsl:value-of>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="dlog">
                    <xsl:with-param name="base" select="$base"></xsl:with-param>
                    <xsl:with-param name="num" select="$num"></xsl:with-param>
                    <xsl:with-param name="class" select="$class"></xsl:with-param>
                    <xsl:with-param name="guess" select="$guess * $base mod $class"></xsl:with-param>
                    <xsl:with-param name="exp" select="$exp + 1"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="modpow">
        <xsl:param name="base"></xsl:param>
        <xsl:param name="exp"></xsl:param>
        <xsl:param name="class"></xsl:param>
        <xsl:param name="res"></xsl:param>
        <xsl:choose>
            <xsl:when test="$exp = 0">
                <xsl:value-of select="$res"/>
            </xsl:when>
            <xsl:when test="$exp mod 2 = 1">
                <xsl:call-template name="modpow">
                    <xsl:with-param name="base" select="$base * $base mod $class"></xsl:with-param>
                    <xsl:with-param name="exp" select="floor($exp div 2)"></xsl:with-param>
                    <xsl:with-param name="class" select="$class"></xsl:with-param>
                    <xsl:with-param name="res" select="$res * $base mod $class"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="modpow">
                    <xsl:with-param name="base" select="$base * $base mod $class"></xsl:with-param>
                    <xsl:with-param name="exp" select="floor($exp div 2)"></xsl:with-param>
                    <xsl:with-param name="class" select="$class"></xsl:with-param>
                    <xsl:with-param name="res" select="$res"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match='/'>
        <xsl:variable name="loop">
            <xsl:call-template name="dlog">
                <xsl:with-param name="base" select="7"></xsl:with-param>
                <xsl:with-param name="num" select="$card"></xsl:with-param>
                <xsl:with-param name="class" select="20201227"></xsl:with-param>
                <xsl:with-param name="guess" select="1"></xsl:with-param>
                <xsl:with-param name="exp" select="0"></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <res>
            <xsl:call-template name="modpow">
                <xsl:with-param name="base" select="$door"></xsl:with-param>
                <xsl:with-param name="exp" select="$loop"></xsl:with-param>
                <xsl:with-param name="class" select="20201227"></xsl:with-param>
                <xsl:with-param name="res" select="1"></xsl:with-param>
            </xsl:call-template>
        </res>
    </xsl:template>
</xsl:stylesheet>