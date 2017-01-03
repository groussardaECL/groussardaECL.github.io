<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="xhtml" doctype-public="-//W3C//DTD XHTML 1.1//EN"/>

    <xsl:template match="/option">
        <html>
            <head>
                <link rel='stylesheet' href='option1.css' />
                <link href="https://fonts.googleapis.com/css?family=Bungee|Roboto" rel="stylesheet"/>
                <title>Elèves et Profs</title>
            </head>
            <body>
                <div class="annuaire">
                    <h1>Liste des professeurs</h1>
                    <table>
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Téléphone</th>
                            <th>Email</th>
                            <th>Adresse</th>
                            <th>Ville</th>
                        </tr>
                        <xsl:for-each select="//personne[@id=(//cours/@prof)]">
                            <xsl:sort select="nom"/>
                                <tr>
                                    <td><xsl:apply-templates select="nom"/></td>
                                    <td><xsl:apply-templates select="prénom"/></td>
                                    <td><xsl:choose>
                                        <xsl:when test="phone"><xsl:apply-templates select="phone"/></xsl:when>
                                        <xsl:otherwise>NC</xsl:otherwise>
                                    </xsl:choose></td>
                                    <td>
                                        <xsl:element name="a">
                                            <xsl:attribute name="href">
                                                mailto:<xsl:value-of select="email"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="translate(email,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                        </xsl:element>
                                    </td>
                                    <td><xsl:apply-templates select="adresse"/></td>
                                    <td><xsl:apply-templates select="ville"/></td>
                                </tr>
                        </xsl:for-each>
                    </table>
                </div>

                <div class="annuaire">
                    <h1>Liste des élèves</h1>
                    <br/>
                    <table>
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Téléphone</th>
                            <th>Email</th>
                            <th>Adresse</th>
                            <th>Ville</th>
                        </tr>
                        <xsl:for-each select="//personne[@id=(//étudiant/@id)]">
                            <xsl:sort select="nom"/>
                            <tr>
                                <td><xsl:apply-templates select="nom"/></td>
                                <td><xsl:apply-templates select="prénom"/></td>
                                <td><xsl:choose>
                                    <xsl:when test="phone"><xsl:apply-templates select="phone"/></xsl:when>
                                    <xsl:otherwise>NC</xsl:otherwise>
                                </xsl:choose></td>
                                <td>
                                    <xsl:element name="a">
                                        <xsl:attribute name="href">
                                            mailto:<xsl:value-of select="email"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="translate(email,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                    </xsl:element>
                                </td>
                                <td><xsl:apply-templates select="adresse"/></td>
                                <td><xsl:apply-templates select="ville"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="adresse">
        <xsl:value-of select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:template>
</xsl:stylesheet>

