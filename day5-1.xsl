<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="max-seat">
        <xsl:param name="entries"></xsl:param>
        <xsl:param name="entryi"></xsl:param>
        <xsl:param name="max"></xsl:param>
        <xsl:variable name="seat-id">
            <xsl:call-template name="seat-id">
                <xsl:with-param name="passes" select="$entries[$entryi]/pass"></xsl:with-param>
                <xsl:with-param name="passi" select="1"></xsl:with-param>
                <xsl:with-param name="res" select="0"></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$entryi gt count($entries)">
                <xsl:value-of select="$max"></xsl:value-of>
            </xsl:when>
            <xsl:when test="number($seat-id) gt $max">
                <xsl:call-template name="max-seat">
                    <xsl:with-param name="entries" select="$entries"></xsl:with-param>
                    <xsl:with-param name="entryi" select="$entryi + 1"></xsl:with-param>
                    <xsl:with-param name="max" select="number($seat-id)"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="max-seat">
                    <xsl:with-param name="entries" select="$entries"></xsl:with-param>
                    <xsl:with-param name="entryi" select="$entryi + 1"></xsl:with-param>
                    <xsl:with-param name="max" select="$max"></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
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
            <xsl:call-template name="max-seat">
                <xsl:with-param name="entries" select="$numbers"></xsl:with-param>
                <xsl:with-param name="entryi" select="1"></xsl:with-param>
                <xsl:with-param name="max" select="0"></xsl:with-param>
            </xsl:call-template>
        </result>
    </xsl:template>
</xsl:stylesheet>
