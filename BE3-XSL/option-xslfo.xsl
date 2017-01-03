<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" version="1.0" indent="yes"></xsl:output>

	<xsl:template match="/option">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master
						master-name="page-unique"
						page-height="29.7cm"
						page-width="21cm"
						margin-top="0.5cm"
						margin-bottom="0.5cm"
						margin-left="2.5cm"
						margin-right="1cm">
					<fo:region-body margin-top="1.6cm" margin-bottom="1.6cm"></fo:region-body>
					<fo:region-before extent="1.5cm"></fo:region-before>
					<fo:region-after extent="1.5cm"></fo:region-after>
				</fo:simple-page-master>
			</fo:layout-master-set>

			<!-- On se réfère à la "page-unique" -->

			<fo:page-sequence master-reference="page-unique"
							  font-family="Georgia"
							  color="#000088">

				<!-- Titre du document -->
				<fo:static-content flow-name="xsl-region-before">
					<fo:block text-align="center"
							  font-weight="bold"
							  font-size="12pt">
						Coordonnées des élèves et professeurs
					</fo:block>
				</fo:static-content>

				<!-- Pied de page -->
				<fo:static-content flow-name="xsl-region-after"
								   text-align="center"
								   font-style="italic"
								   font-size="10pt">
					<fo:block space-before="1em">
						Mise en page simple
					</fo:block>
					<fo:block>
						BE 3 - XML
					</fo:block>
				</fo:static-content>

				<!-- Corps du doc -->
				<fo:flow flow-name="xsl-region-body"
						 font-size="9pt"
						 font-family="Georgia"
						 font-style="italic"
						 text-align="justify">

					<xsl:apply-templates></xsl:apply-templates>

				</fo:flow>

			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Pour la table Personnes -->
	<xsl:template match="personnes">
		<!-- Titre de la table -->
		<fo:block font-style="normal"
				  font-weight="bold"
				  color="#880000">
			Coordonnées
		</fo:block>
		<!-- Définition du tableau -->
		<fo:table table-layout="fixed"
				  text-align="center"
				  space-before="1em"
				  border="solid 0.5pt #000088">
			<fo:table-column column-number="1" column-width="2.6cm">
			</fo:table-column>
			<fo:table-column column-number="2" column-width="2.6cm">
			</fo:table-column>
			<fo:table-column column-number="3" column-width="2.6cm">
			</fo:table-column>
			<fo:table-column column-number="4" column-width="2.6cm">
			</fo:table-column>
			<fo:table-column column-number="5" column-width="2.6cm">
			</fo:table-column>
			<fo:table-column column-number="6" column-width="2.6cm">
			</fo:table-column>

			<!-- Corps du tableau -->
			<fo:table-body>

				<!-- Première ligne du tableau -->
				<fo:table-row>
					<fo:table-cell>
						<fo:block>Prénom</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Nom</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Tél</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Email</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Adresse</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Ville</fo:block>
					</fo:table-cell>
				</fo:table-row>

				<!-- Autres lignes -->

				<xsl:apply-templates></xsl:apply-templates>


			</fo:table-body>
		</fo:table>

	</xsl:template>

	<xsl:template match="personne">
		<fo:table-row>
			<fo:table-cell>
				<fo:block><xsl:apply-templates select="prénom"></xsl:apply-templates></fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block><xsl:apply-templates select="nom"></xsl:apply-templates></fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block><xsl:apply-templates select="phone"></xsl:apply-templates></fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block><xsl:apply-templates select="email"></xsl:apply-templates></fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block><xsl:apply-templates select="adresse"></xsl:apply-templates></fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block><xsl:apply-templates select="ville"></xsl:apply-templates></fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template match="cours">
	</xsl:template>


</xsl:stylesheet>