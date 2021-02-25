<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="seat-id">
        <xsl:param name="passes"></xsl:param>
        <xsl:param name="passi"></xsl:param>
        <xsl:param name="res"></xsl:param>
        <xsl:choose>
            <xsl:when test="$passi gt count($passes)">
                <xsl:value-of select="$res"></xsl:value-of>
            </xsl:when>
            <xsl:when test="($passes[$passi] = 'B') or $passes[$passi] = 'R'">
                <xsl:call-template name="seat-id">
                    <xsl:with-param name="passes" select="$passes"></xsl:with-param>
                    <xsl:with-param name="passi" select="$passi + 1"></xsl:with-param>
                    <xsl:with-param name="res" select="2 * $res + 1"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="seat-id">
                    <xsl:with-param name="passes" select="$passes"></xsl:with-param>
                    <xsl:with-param name="passi" select="$passi + 1"></xsl:with-param>
                    <xsl:with-param name="res" select="2 * $res"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="numbers" as="element(entry)*">
                <xsl:analyze-string select="$in" regex="(.*)\n">
                    <xsl:matching-substring>
                        <entry>
                            <xsl:analyze-string select="regex-group(1)" regex="(.)">
                                <xsl:matching-substring>
                                    <pass>
                                        <xsl:value-of select="regex-group(1)"></xsl:value-of>
                                    </pass>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </entry>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:variable name="ids" as="element(id)*">
                <xsl:for-each select="$numbers">
                    <xsl:variable name="thisid">
                        <xsl:call-template name="seat-id">
                            <xsl:with-param name="passes" select="pass"></xsl:with-param>
                            <xsl:with-param name="passi" select="1"></xsl:with-param>
                            <xsl:with-param name="res" select="0"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:variable>
                    <id val="{$thisid}">1</id>
                </xsl:for-each>
            </xsl:variable>
            <xsl:for-each select="1 to 1024">
                <xsl:variable name='num' select="."></xsl:variable>
                <xsl:if test="not($ids[@val=(string($num))] = '1') and $ids[@val=(string($num - 1))] = '1' and $ids[@val=(string($num + 1))] = '1'">
                    <answer>
                        <xsl:value-of select="."></xsl:value-of>
                    </answer>
                </xsl:if>
            </xsl:for-each>
        </result>
    </xsl:template>
</xsl:stylesheet>
<!--
print((lambda l:(max(l),max(i-1for i in l if i-1 not in l)))([int(bytes(48+(y in"BR")for y in i),2)//2for i in open('i')])) 

-->
