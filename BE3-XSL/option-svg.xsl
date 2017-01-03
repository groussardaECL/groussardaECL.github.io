<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="xml"
                encoding="utf-8"
                doctype-public="-//W3C//DTD SVG 20010904//EN"
                doctype-system="http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"/>

    <xsl:template match="/option">

        <!-- Définition de quelques variables utiles -->
        <xsl:variable name="nbCours"><xsl:value-of select="count(cours)"/></xsl:variable>
        <xsl:variable name="marge-ext-gauche">20</xsl:variable>
        <xsl:variable name="marge-ext-haut">20</xsl:variable>
        <xsl:variable name="marge-int-gauche">50</xsl:variable>
        <xsl:variable name="marge-int-haut">50</xsl:variable>
        <xsl:variable name="largeur-cours">150</xsl:variable>
        <xsl:variable name="hauteur">300</xsl:variable>
        <xsl:variable name="hauteur-legende">200</xsl:variable>
        <xsl:variable name="zoom"><xsl:value-of select="1.3"/></xsl:variable>

        <svg xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink"
             width="100%"
             height="1000">

            <xsl:element name="g">
                <xsl:attribute name="transform">scale(<xsl:value-of select="$zoom"/><xsl:text> </xsl:text><xsl:value-of select="$zoom"/>)</xsl:attribute>

                <!-- Définition du cadre en fonction du nombre de cours-->
                <xsl:element name="rect">
                    <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche"/></xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="$marge-ext-haut"/></xsl:attribute>
                    <xsl:attribute name="width"><xsl:value-of select="$marge-int-gauche*2+$largeur-cours*$nbCours"/></xsl:attribute>
                    <xsl:attribute name="height"><xsl:value-of select="$hauteur+$marge-int-haut+$hauteur-legende"/></xsl:attribute>
                    <xsl:attribute name="fill">rgb(242,242,242)</xsl:attribute>
                    <xsl:attribute name="stroke">#696969</xsl:attribute>
                    <xsl:attribute name="stroke-width">1</xsl:attribute>
                </xsl:element>

                <!-- Element spécifiques aux cours (Intitulé et graduations) -->
                <xsl:for-each select="cours">
                    <xsl:variable name="numeroCours"><xsl:value-of select="position()"/></xsl:variable>
                    <xsl:variable name="moyenne"><xsl:value-of select="(round((sum(étudiant/note) div count(étudiant))*10)) div 10"/></xsl:variable>

                    <!-- Intitulé -->
                    <xsl:element name="g">
                        <xsl:attribute name="transform">rotate(90 <xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*(($numeroCours)-0.5)"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="$marge-ext-haut+$marge-int-haut+$hauteur"/>)</xsl:attribute>
                        <xsl:element name="text">
                            <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*(($numeroCours)-0.5)+10"/></xsl:attribute>
                            <xsl:attribute name="y"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur)+5"/></xsl:attribute>
                            <xsl:attribute name="stroke">black</xsl:attribute>
                            <xsl:attribute name="stroke-width">1</xsl:attribute>
                            <xsl:value-of select="@intitulé"/>
                        </xsl:element>
                    </xsl:element>

                    <!-- Graduations -->
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*(($numeroCours)-0.5)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+$hauteur+2"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*(($numeroCours)-0.5)"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+$hauteur"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>

                    <!-- Moyenne des notes de chaque cours -->
                    <xsl:element name="rect">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*(($numeroCours)-0.5)-10"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 22)*(22-$moyenne)"/></xsl:attribute>
                        <xsl:attribute name="width">20</xsl:attribute>
                        <xsl:attribute name="height"><xsl:value-of select="($hauteur div 22)*($moyenne)"/></xsl:attribute>
                        <xsl:attribute name="fill">red</xsl:attribute>
                        <xsl:attribute name="stroke">grey</xsl:attribute>
                        <xsl:attribute name="width-stroke">1</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*(($numeroCours)-0.5)-10"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 22)*1"/></xsl:attribute>
                        <xsl:attribute name="stroke">red</xsl:attribute>
                        <xsl:attribute name="width-stroke">1</xsl:attribute>
                        <xsl:attribute name="fill">red</xsl:attribute>
                        <xsl:value-of select="$moyenne"/>
                    </xsl:element>

                    <!-- Notes individuelles -->
                    <xsl:for-each select="étudiant">
                        <xsl:variable name="note" select="note"/>

                        <xsl:element name="circle">
                            <xsl:attribute name="cx"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*(($numeroCours)-0.5)"/></xsl:attribute>
                            <xsl:attribute name="cy"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 22)*(22-$note)"/></xsl:attribute>
                            <xsl:attribute name="r">2</xsl:attribute>
                            <xsl:attribute name="fill">black</xsl:attribute>
                        </xsl:element>


                    </xsl:for-each>

                </xsl:for-each>

                <!--Axe vertical gauche-->
                <xsl:element name="line">
                    <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche"/></xsl:attribute>
                    <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut"/></xsl:attribute>
                    <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche"/></xsl:attribute>
                    <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+$hauteur"/></xsl:attribute>
                    <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:1</xsl:attribute>
                </xsl:element>

                <!--Fléche verticale gauche-->
                <xsl:element name="polygon">
                    <xsl:attribute name="points">
                        <xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/>,<xsl:value-of select="$marge-ext-haut+$marge-int-haut"/><xsl:text> </xsl:text>
                        <xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/>,<xsl:value-of select="$marge-ext-haut+$marge-int-haut"/><xsl:text> </xsl:text>
                        <xsl:value-of select="$marge-ext-gauche+$marge-int-gauche"/>,<xsl:value-of select="$marge-ext-haut+($marge-int-haut)-4"/><xsl:text> </xsl:text>
                        <xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/>,<xsl:value-of select="$marge-ext-haut+$marge-int-haut"/><xsl:text> </xsl:text>
                        <xsl:value-of select="$marge-ext-gauche+$marge-int-gauche"/>,<xsl:value-of select="$marge-ext-haut+$marge-int-haut"/>
                    </xsl:attribute>
                </xsl:element>

                <!-- Graduations verticales -->
                <g id="graduations-verticales">

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*1"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*1"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-20"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*1"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        20
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*1"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*1"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*2"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*2"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-20"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*2"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        18
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*2"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*2"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*3"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*3"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-20"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*3"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        16
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*3"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*3"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*4"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*4"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-20"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*4"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        14
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*4"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*4"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*5"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*5"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-20"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*5"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        12
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*5"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*5"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*6"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*6"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-20"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*6"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        10
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*6"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*6"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*7"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*7"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-12"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*7"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        8
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*7"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*7"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*8"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*8"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-12"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*8"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        6
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*8"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*8"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*9"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*9"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-12"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*9"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        4
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*9"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*9"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>

                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-2"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*10"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+2"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*10"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="text">
                        <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-12"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="5+$marge-ext-haut+$marge-int-haut+($hauteur div 11)*10"/></xsl:attribute>
                        <xsl:attribute name="stroke">black</xsl:attribute>
                        <xsl:attribute name="stroke-width">1</xsl:attribute>
                        2
                    </xsl:element>
                    <xsl:element name="line">
                        <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)"/></xsl:attribute>
                        <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*10"/></xsl:attribute>
                        <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)+$largeur-cours*$nbCours"/></xsl:attribute>
                        <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+($hauteur div 11)*10"/></xsl:attribute>
                        <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:0.5</xsl:attribute>
                    </xsl:element>
                </g>


                <xsl:element name="text">
                    <xsl:attribute name="x"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche div 2"/></xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="$marge-ext-haut+$marge-int-haut div 7*4"/></xsl:attribute>
                    <xsl:attribute name="stroke">black</xsl:attribute>
                    <xsl:attribute name="stroke-width">1</xsl:attribute>
                    Notes individuelles et Moyennes
                </xsl:element>

                <!-- Axe horizontal -->
                <xsl:element name="line">
                    <xsl:attribute name="x1"><xsl:value-of select="$marge-ext-gauche+($marge-int-gauche)-0.5"/></xsl:attribute>
                    <xsl:attribute name="y1"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+$hauteur"/></xsl:attribute>
                    <xsl:attribute name="x2"><xsl:value-of select="$marge-ext-gauche+$marge-int-gauche+$largeur-cours*$nbCours"/></xsl:attribute>
                    <xsl:attribute name="y2"><xsl:value-of select="$marge-ext-haut+$marge-int-haut+$hauteur"/></xsl:attribute>
                    <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:1</xsl:attribute>
                </xsl:element>

            </xsl:element>

        </svg>

    </xsl:template>

</xsl:stylesheet>


