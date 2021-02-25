<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:my="https://www.w3schools.com/furniture">


    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:variable name="bags">
        <xsl:analyze-string select="$in" regex="(\w+ \w+) bags contain (.+)\n">
            <xsl:matching-substring>
                <bag color="{regex-group(1)}">
                    <xsl:analyze-string select="regex-group(2)" regex="(\w+ \w+) bags?[,.]">
                        <xsl:matching-substring>
                            <xsl:if test="not(regex-group(1) = 'no other')">
                                <content color="{regex-group(1)}"></content>
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
        <xsl:choose>
            <xsl:when test="$contentsi gt count($contents)">
                <r>0</r>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="res" select="my:bagn($contents[$contentsi])">
<!--                    <xsl:call-template name="bag">
                        <xsl:with-param name="bag" select="$contents[$contentsi]"></xsl:with-param>
                    </xsl:call-template>
                -->
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$res='1'">
                        <r>1</r>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="forcontent">
                            <xsl:with-param name="contents" select="$contents"></xsl:with-param>
                            <xsl:with-param name="contentsi" select="$contentsi + 1" ></xsl:with-param>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:function name="my:bagn" cache="yes">


        <xsl:param name="bag"></xsl:param>
        <xsl:variable name="contents" select="$bags/bag[@color=string($bag/@color)]/content"/>
        <xsl:choose>
            <xsl:when test="count($contents)=0">
                <r>0</r>
            </xsl:when>
            <xsl:when test="$bag/@color='shiny gold'">
                <r>1</r>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="forcontent">
                    <xsl:with-param name="contents" select="$contents"></xsl:with-param>
                    <xsl:with-param name="contentsi" select="1"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:template match="/">
        <result>
            <xsl:variable name="res">
                <xsl:for-each select="$bags/bag">
                <xsl:copy-of select="my:bagn(.)"></xsl:copy-of>
<!--                    <xsl:call-template name="bag">
                        <xsl:with-param name="bag" select="."></xsl:with-param>
                    </xsl:call-template>
                -->
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="sum($res/r)-1"/>
        </result>
    </xsl:template>
</xsl:stylesheet>
