<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template match="/">
        <result>
            <xsl:variable name="numbers" as="element(password)*">
                <xsl:analyze-string select="$in" regex="(\d+)-(\d+) (.): (.+)\n">
                    <xsl:matching-substring>
                        <password>
                            <xsl:variable name="letter" select="regex-group(3)" />
                            <xsl:variable name="posa" select="number(regex-group(1))" />
                            <xsl:variable name="posb" select="number(regex-group(2))" />
                            <xsl:variable name="text" select="regex-group(4)" />
                            <posa>
                                <xsl:value-of select="number(matches($text,concat('^.{',$posa - 1, '}', $letter)))" />
                            </posa>
                            <posb>
                                <xsl:value-of select="number(matches($text,concat('^.{',$posb - 1, '}', $letter)))" />
                            </posb>
                        </password>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:variable name="res" as="element(number)*">
                <xsl:for-each select='$numbers'>
                    <number><xsl:value-of select="number(posa + posb = 1)"></xsl:value-of></number>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="sum($res)"/>
        </result>
    </xsl:template>
</xsl:stylesheet>
