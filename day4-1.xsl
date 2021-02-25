<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"></xsl:output>
    <xsl:variable name="in" select="replace(unparsed-text('file:///C:/Users/adamh/OneDrive/Dokumenty/xslstuff/in.txt'), '\r\n', ' ')"></xsl:variable>
    <xsl:template match="/">
        <result>
            <xsl:variable name="numbers" as="element(number)*">
                <xsl:analyze-string select="$in" regex="(.*?)  ">
                    <xsl:matching-substring>
                        <xsl:variable name="test-str" select="replace(concat(regex-group(1), ' '), '\n', ' ')"></xsl:variable>
                        <xsl:if test="
                        matches($test-str, 'byr:(?:19[2-9][0-9]|200[012]) ') and
                        matches($test-str, 'iyr:(?:201[0-9]|2020) ') and
                        matches($test-str, 'eyr:(?:202[0-9]|2030) ') and
                        matches($test-str, 'hgt:(?:(?:1[5-8][0-9]|19[0-3])cm|(?:59|6[0-9]|7[0-6])in) ') and
                        matches($test-str, 'hcl:#[0-9a-f]{6} ') and
                        matches($test-str, 'ecl:(?:amb|blu|brn|gry|grn|hzl|oth) ') and
                        matches($test-str, 'pid:[0-9]{9} ')
                        ">
                            <number> 1 </number>
                        <xsl:message select="replace($test-str, '\n', ' ')"/>
                        </xsl:if>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:variable>
            <xsl:value-of select="count($numbers)"></xsl:value-of>
        </result>
    </xsl:template>
</xsl:stylesheet>
<!-- (?=.*byr:(?:19[2-9][0-9]|200[012]) )(?=.*iyr:(?:201[0-9]|2020) )(?=hgt:(?:(?:1[5-8][0-9]|19[0-3])cm|(?:59|6[0-9]|7[0-6])in) )(?=hcl:#[0-9a-f]{6} )(?=ecl:(?:amb|blu|brn|gry|grn|hzl|oth) )(?=pid:[0-9]{9} )-->
<!-- byr=(?:19[2-9][0-9]|200[0-2])(?: cid=\d+)? ecl=(?:amb|blu|brn|gry|grn|hzl|oth) eyr=(?:202[0-9]|2030) hcl=#[0-9a-f]{6} hgt=(?:(?:(?:59|6[0-9]|7[0-6])in)|(?:(?:1[5-8][0-9]|19[0-3])cm)) iyr=(?:201[0-9]|2020) pid=\d{9} -->
