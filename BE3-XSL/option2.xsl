<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template match="/option">
	 <html>
	 	<link type="text/css" rel="stylesheet" href="option23.css"/>
	 	<head>
			<title>
				Fiches de notes
			</title>
		</head>
	 	<body>
	 		<div class="en-tete">
	 		<h1>Fiches de notes élèves</h1>
	 		</div>
	 		<xsl:apply-templates/>
	 	</body>
	 </html>
	</xsl:template>

	<xsl:template match="personne">
		<xsl:variable name="currentid" select= "//étudiant[@id=current()/@id]"/>
		<xsl:if test="$currentid">
			<div class="fiches-note">
				<h3>
					<xsl:value-of select="prénom"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="nom"/>
				</h3>
				<table class="table-note">
					<tr>
						<th class="titre-table-note">Cours</th>
						<th class="titre-table-note">Note</th>
						<th class="titre-table-note">Absences</th>
						<th class="titre-table-note">Appréciation</th>
					</tr>
					<xsl:for-each select="$currentid">
						<tr>
							<td class="intitule-cours"><xsl:value-of select="../@intitulé"/></td>
							<td class="note"><xsl:value-of select="note"/></td>
							<td class="absence"><xsl:value-of select="absences"/></td>
							<td class="appreciation"><xsl:value-of select="comment"/></td>
						</tr>
					</xsl:for-each>
				</table>
				<p><br/></p>
			</div>
		</xsl:if>
	</xsl:template>

	 <xsl:template match="cours">
 	</xsl:template>



</xsl:stylesheet>
