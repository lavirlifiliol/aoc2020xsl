<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:variable name="bags">
        <xsl:analyze-string select="$in" regex="(\w+ \w+) bags contain (.+)\n">
            <xsl:matching-substring>
                <bag color="{regex-group(1)}">
                    <xsl:analyze-string select="regex-group(2)" regex="(\d+) (\w+ \w+) bags?[,.]">
                        <xsl:matching-substring>
                            <xsl:if test="not(regex-group(1) = 'no other')">
                                <content color="{regex-group(2)}" count="{regex-group(1)}"></content>
                            </xsl:if>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </bag>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    <xsl:template name="forcontent">
        <xsl:param name="contents"></xsl:param>
        <xsl:param name="contentsi"></xsl:param>
        <xsl:param name="count"></xsl:param>
        <xsl:choose>
            <xsl:when test="$contentsi gt count($contents)">
                <r><xsl:value-of select="$count"></xsl:value-of></r>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="res">
                    <xsl:call-template name="bag">
                        <xsl:with-param name="bag" select="$contents[$contentsi]"></xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:call-template name="forcontent">
                    <xsl:with-param name="contents" select="$contents"></xsl:with-param>
                    <xsl:with-param name="contentsi" select="$contentsi + 1" ></xsl:with-param>
                    <xsl:with-param name="count" select="$res * number($contents[$contentsi]/@count) + number($count) "> </xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="bag">
        <xsl:param name="bag"></xsl:param>
        <xsl:variable name="contents" select="$bags/bag[@color=string($bag/@color)]/content"/>
        <xsl:choose>
            <xsl:when test="count($contents)=0">
                <r><xsl:value-of select="1"></xsl:value-of></r>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="res">
                    <xsl:call-template name="forcontent">
                        <xsl:with-param name="contents" select="$contents"></xsl:with-param>
                        <xsl:with-param name="contentsi" select="1"></xsl:with-param>
                        <xsl:with-param name="count" select="0"></xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <r><xsl:value-of select="1+$res"></xsl:value-of></r>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="res">
                <xsl:call-template name="bag">
                    <xsl:with-param name="bag" select="$bags/bag[@color='shiny gold']"></xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="sum($res/r)-1"/>
        </result>
    </xsl:template>
</xsl:stylesheet>
