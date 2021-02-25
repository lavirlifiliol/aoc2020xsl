<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r', '')"></xsl:variable>
    <xsl:template match="/">
        <result>
            <xsl:variable name="numbers" as="element(password)*">
                <xsl:analyze-string select="$in" regex="((\d+)-(\d+) (.): (.+))\n">
                    <xsl:matching-substring>
                        <password>
                            <policy>
                                <min><xsl:value-of select="regex-group(2)"></xsl:value-of></min>
                                <max><xsl:value-of select="regex-group(3)"></xsl:value-of></max>
                            </policy>
                            <cleantext>
                                <xsl:value-of select="replace(regex-group(5), concat('[^',regex-group(4),']'), '')"></xsl:value-of>
                            </cleantext>
                            <fulltext>
                                <xsl:value-of select="regex-group(1)"></xsl:value-of>
                            </fulltext>
                        </password>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:variable name="valid" as="element(num)*">
                <xsl:for-each select='$numbers'>
                    <xsl:if test="matches(cleantext, concat('^.{',number(policy/min),',',number(policy/max),'}$'))">
                        <num><xsl:value-of select="1"></xsl:value-of></num>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="sum($valid)"></xsl:value-of>
        </result>
    </xsl:template>
</xsl:stylesheet>
