<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template name="run">
        <xsl:param name="insns" />
        <xsl:param name="iptr" />
        <xsl:param name="acc" />
        <xsl:param name="visited" />
        <xsl:message select="$iptr"></xsl:message>
        <xsl:variable name="insn" select="$insns/insn[@idx=string($iptr)][1]" />
        <xsl:variable name="nexti">
            <xsl:choose>
                <xsl:when test="$insn/@kind='acc'">
                    <xsl:value-of select="$iptr + 1"></xsl:value-of>
                </xsl:when>
                <xsl:when test="$insn/@kind='nop'">
                    <xsl:value-of select="$iptr + 1"></xsl:value-of>
                </xsl:when>
                <xsl:when test="$insn/@kind='jmp'">
                    <xsl:value-of select="$iptr + $insn/@num"></xsl:value-of>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$visited/visited[@val=string($nexti)]/@val">
            </xsl:when>
            <xsl:when test="number($iptr) gt max($insns/insn/@idx)">
                <right>
                    <xsl:value-of select="$acc"></xsl:value-of>
                </right>
            </xsl:when>
            <xsl:when test="($insn/@kind)='acc'">
                <xsl:call-template name="run">
                    <xsl:with-param name="insns" select="$insns"></xsl:with-param>
                    <xsl:with-param name="iptr" select="$nexti"></xsl:with-param>
                    <xsl:with-param name="acc" select="$acc + $insn/@num"></xsl:with-param>
                    <xsl:with-param name="visited">
                        <xsl:copy-of select="$visited"></xsl:copy-of>
                        <visited val="{$nexti}"></visited>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="($insn/@kind)='nop'">
                <xsl:call-template name="run">
                    <xsl:with-param name="insns" select="$insns"></xsl:with-param>
                    <xsl:with-param name="iptr" select="$nexti"></xsl:with-param>
                    <xsl:with-param name="acc" select="$acc"></xsl:with-param>
                    <xsl:with-param name="visited">
                        <xsl:copy-of select="$visited"></xsl:copy-of>
                        <visited val="{$nexti}"></visited>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="($insn/@kind)='jmp'">
                <xsl:call-template name="run">
                    <xsl:with-param name="insns" select="$insns"></xsl:with-param>
                    <xsl:with-param name="iptr" select="$nexti"></xsl:with-param>
                    <xsl:with-param name="acc" select="$acc"></xsl:with-param>
                    <xsl:with-param name="visited">
                        <xsl:copy-of select="$visited"></xsl:copy-of>
                        <visited val="{$nexti}"></visited>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <wrong>otherwise</wrong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="insns" as="element(insn)*">
                <xsl:analyze-string select="$in" regex="(nop|acc|jmp) ([+-]\d+)\n">
                    <xsl:matching-substring>
                        <insn kind="{regex-group(1)}" num="{number(regex-group(2))}">
                            <xsl:attribute name="idx">
                                <xsl:number value="position()" />
                            </xsl:attribute>
                        </insn>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:for-each select="$insns[@kind='jmp']">
                <xsl:call-template name="run">
                    <xsl:with-param name="insns">
                        <insn kind="nop" num="0" idx="{@idx}"></insn>
                        <xsl:copy-of select="$insns"></xsl:copy-of>
                    </xsl:with-param>
                    <xsl:with-param name="iptr" select="1"></xsl:with-param>
                    <xsl:with-param name="acc" select="0"></xsl:with-param>
                    <xsl:with-param name="visited">
                        <visited val="1"></visited>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
        </result>
    </xsl:template>
</xsl:stylesheet>
