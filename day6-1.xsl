<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', ''), '\n([^\n])',' $1')"></xsl:variable>
    <xsl:variable name="qs" select="('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')"></xsl:variable>
    <xsl:template name="every">
        <xsl:param name="group"></xsl:param>
        <xsl:variable name="all">
            <xsl:for-each select="$qs">
                <xsl:variable name="q" select="." />
                <xsl:if test="count($group/person) = count($group/person/yes[@question=$q])">
                    <question>1</question>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="count($all/question)"></xsl:value-of>
    </xsl:template>
    <xsl:template match="/">
        <result>
            <xsl:variable name="groups" as="element(group)*">
                <xsl:analyze-string select="$in" regex="(.*)\n">
                    <xsl:matching-substring>
                        <group>
                            <xsl:analyze-string select="regex-group(1)" regex="(\w+)">
                                <xsl:matching-substring>
                                    <person>
                                        <xsl:analyze-string select="regex-group(1)" regex="(.)">
                                            <xsl:matching-substring>
                                                <yes question="{regex-group(1)}"></yes>
                                            </xsl:matching-substring>
                                        </xsl:analyze-string>
                                    </person>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </group>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:variable name="every">
                <xsl:for-each select="$groups">
                    <rs>
                        <xsl:call-template name="every">
                            <xsl:with-param name="group" select="."></xsl:with-param>
                        </xsl:call-template>
                    </rs>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="sum($every/rs)"></xsl:value-of>
        </result>
    </xsl:template>
</xsl:stylesheet>
