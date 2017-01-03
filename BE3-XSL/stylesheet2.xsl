<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="xhtml" doctype-public="-//W3C//DTD XHTML 1.1//EN"/>

    <xsl:template match="/">
        <html>
            <head>
                <link rel='stylesheet' href='css-stylesheet2.css' />
                <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css' />
                <link href="https://fonts.googleapis.com/css?family=Bungee|Roboto" rel="stylesheet"/>
                <title>Notes</title>
            </head>
            <body>
                <div class="col-md-8">
                    <h1>Notes des élèves</h1>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="personne">
        <xsl:variable name="etudiants" select="//étudiant[@id=current()/@id]"/>
        <xsl:if test="$etudiants">
            <div class="row">
                Notes de <xsl:apply-templates select="nom"/> <xsl:apply-templates select="prénom"/>
            </div>
            <div class="row">
                nom du cours
            </div>
            <div class="row">
                <div class="col-md-1">
                    Note
                </div>
                <div class="col-md-1">
                    Absence
                </div>
                <div class="col-md-1">
                    Commentaires
                </div>
            </div>
        </xsl:if>
    </xsl:template>
        </div>
    </div>
</xsl:stylesheet>
