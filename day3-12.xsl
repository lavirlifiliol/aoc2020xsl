<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="slide">
        <xsl:param name="grid"/>
        <xsl:param name="w"/>
        <xsl:param name="h"/>
        <xsl:param name="dx"/>
        <xsl:param name="dy"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:param name="r"/>
        <xsl:variable name="nx" as="element(r)">
            <r>
                <xsl:choose>
                    <xsl:when test="$x + $dx gt $w">
                        <xsl:value-of select="$x - $w + $dx"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$x + $dx"/>
                    </xsl:otherwise>
                </xsl:choose>
            </r>
        </xsl:variable>
        <xsl:variable name="nr" as="element(r)">
            <r>
                        <xsl:message>
                            <debug>
                                <a>
                                    <xsl:value-of select="$grid[$y+$dy]/col[number($nx)]"></xsl:value-of>
                                </a>
                                <a>
                                    <xsl:value-of select="concat($y + $dy,' ',$nx)"></xsl:value-of>
                                </a>
                            </debug>
                        </xsl:message>
                <xsl:choose>
                    <xsl:when test="$grid[$y+$dy]/col[number($nx)] = '#'">
                        <xsl:value-of select="$r + 1"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$r"/>
                    </xsl:otherwise>
                </xsl:choose>
            </r>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$y = $h">
                <xsl:value-of select="$r"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="slide">
                    <xsl:with-param name="grid" select="$grid"></xsl:with-param>
                    <xsl:with-param name="w" select="$w"></xsl:with-param>
                    <xsl:with-param name="h" select="$h"></xsl:with-param>
                    <xsl:with-param name="dx" select="$dx"></xsl:with-param>
                    <xsl:with-param name="dy" select="$dy"></xsl:with-param>
                    <xsl:with-param name="x" select="number($nx)"></xsl:with-param>
                    <xsl:with-param name="y" select="$y+$dy"></xsl:with-param>
                    <xsl:with-param name="r" select="number($nr)"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="grid" as="element(row)*">
                <xsl:analyze-string select="$in" regex="(.*)\n">
                    <xsl:matching-substring>
                        <row>
                            <xsl:analyze-string select="regex-group(1)" regex="(.)">
                                <xsl:matching-substring>
                                    <col>
                                        <xsl:value-of select="regex-group(1)"></xsl:value-of>
                                    </col>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </row>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:variable name="w" select="count($grid[1]/col)"/>
            <xsl:variable name="h" select="count($grid)"/>
            <xsl:variable name="slope1" as="xs:integer">
                <xsl:call-template name="slide">
                    <xsl:with-param name="grid" select="$grid"></xsl:with-param>
                    <xsl:with-param name="w" select="$w"></xsl:with-param>
                    <xsl:with-param name="h" select="$h"></xsl:with-param>
                    <xsl:with-param name="dx" select="1"></xsl:with-param>
                    <xsl:with-param name="dy" select="1"></xsl:with-param>
                    <xsl:with-param name="x" select="0"></xsl:with-param>
                    <xsl:with-param name="y" select="0"></xsl:with-param>
                    <xsl:with-param name="r" select="0"></xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="slope2" as="xs:integer">
                <xsl:call-template name="slide">
                    <xsl:with-param name="grid" select="$grid"></xsl:with-param>
                    <xsl:with-param name="w" select="$w"></xsl:with-param>
                    <xsl:with-param name="h" select="$h"></xsl:with-param>
                    <xsl:with-param name="dx" select="3"></xsl:with-param>
                    <xsl:with-param name="dy" select="1"></xsl:with-param>
                    <xsl:with-param name="x" select="-2"></xsl:with-param>
                    <xsl:with-param name="y" select="0"></xsl:with-param>
                    <xsl:with-param name="r" select="0"></xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="slope3" as="xs:integer">
                <xsl:call-template name="slide">
                    <xsl:with-param name="grid" select="$grid"></xsl:with-param>
                    <xsl:with-param name="w" select="$w"></xsl:with-param>
                    <xsl:with-param name="h" select="$h"></xsl:with-param>
                    <xsl:with-param name="dx" select="5"></xsl:with-param>
                    <xsl:with-param name="dy" select="1"></xsl:with-param>
                    <xsl:with-param name="x" select="-4"></xsl:with-param>
                    <xsl:with-param name="y" select="0"></xsl:with-param>
                    <xsl:with-param name="r" select="0"></xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="slope4" as="xs:integer">
                <xsl:call-template name="slide">
                    <xsl:with-param name="grid" select="$grid"></xsl:with-param>
                    <xsl:with-param name="w" select="$w"></xsl:with-param>
                    <xsl:with-param name="h" select="$h"></xsl:with-param>
                    <xsl:with-param name="dx" select="7"></xsl:with-param>
                    <xsl:with-param name="dy" select="1"></xsl:with-param>
                    <xsl:with-param name="x" select="-6"></xsl:with-param>
                    <xsl:with-param name="y" select="0"></xsl:with-param>
                    <xsl:with-param name="r" select="0"></xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="slope5" as="xs:integer">
                <xsl:call-template name="slide">
                    <xsl:with-param name="grid" select="$grid"></xsl:with-param>
                    <xsl:with-param name="w" select="$w"></xsl:with-param>
                    <xsl:with-param name="h" select="$h"></xsl:with-param>
                    <xsl:with-param name="dx" select="1"></xsl:with-param>
                    <xsl:with-param name="dy" select="2"></xsl:with-param>
                    <xsl:with-param name="x" select="0"></xsl:with-param>
                    <xsl:with-param name="y" select="-1"></xsl:with-param>
                    <xsl:with-param name="r" select="0"></xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <answer>
                <xsl:value-of select="$slope1 * $slope2 * $slope3 * $slope4 * $slope5"></xsl:value-of>
            </answer>
            <debug>
                <a>
                    <xsl:value-of select="$slope1"></xsl:value-of>
                </a>
                <a>
                    <xsl:value-of select="$slope2"></xsl:value-of>
                </a>
                <a>
                    <xsl:value-of select="$slope3"></xsl:value-of>
                </a>
                <a>
                    <xsl:value-of select="$slope4"></xsl:value-of>
                </a>
                <a>
                    <xsl:value-of select="$slope5"></xsl:value-of>
                </a>
            </debug>
        </result>
    </xsl:template>
</xsl:stylesheet>
