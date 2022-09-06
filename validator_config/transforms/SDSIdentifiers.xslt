<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hl7="urn:hl7-org:v3">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:include href="SharedTemplates.xslt"/>
	<!--Author: Damian Murphy -->
	<!--Version: 3.0 -->
	<!--Date Created: 1st June 2007-->
	<!--Date Modified: 21st October 2008-->
	<!--Modified By: Meena Pillai -->
	<!--Purpose: To identify the all the elements and attributes with no value.-->
	<!--Date Modified: 10th November 2011-->
	<!--Modified By: Richard Robinson -->
	<!--Purpose: addition of local-name() to correct so that it will still recognise elements which have a namespace tag-->
	<xsl:template match="/">
		<xsl:apply-templates select="/*[1]//hl7:id[@root='1.2.826.0.1285.0.2.0.65']"/>
		<xsl:apply-templates select="/*[1]//hl7:id[@root='1.2.826.0.1285.0.2.0.67']"/>
		<xsl:apply-templates select="/*[1]//hl7:id[@root='1.2.826.0.1285.0.2.0.107']"/>
	</xsl:template>
	<xsl:template name="CheckSDSIdentifiers65" match="/*[1]//hl7:id[@root='1.2.826.0.1285.0.2.0.65']">
		<xsl:for-each select="self::node()">
			<xsl:call-template name="CheckRegex">
				<xsl:with-param name="ext" select="self::node()/@extension"/>
				<xsl:with-param name="root" select="self::node()/@root"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CheckSDSIdentifiers67" match="/*[1]//hl7:id[@root='1.2.826.0.1285.0.2.0.67']">
		<xsl:for-each select="self::node()">
			<xsl:call-template name="CheckRegex">
				<xsl:with-param name="ext" select="self::node()/@extension"/>
				<xsl:with-param name="root" select="self::node()/@root"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CheckSDSIdentifiers107" match="/*[1]//hl7:id[@root='1.2.826.0.1285.0.2.0.107']">
		<xsl:for-each select="self::node()">
			<xsl:call-template name="CheckRegex">
				<xsl:with-param name="ext" select="self::node()/@extension"/>
				<xsl:with-param name="root" select="self::node()/@root"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CheckRegex">
		<xsl:param name="ext"/>
		<xsl:param name="root"/>
			<xsl:if test="not(contains(translate($ext,'0123456789','9999999999'),'999999999999'))">
				<table border="1" width="800">
					<tr>
						<th>Name: </th>
						<td>
							<font color="#0000CC">
								<b>CheckSDSIdentifiers</b>
							</font>
						</td>
					</tr>
					<tr>
						<th>Description: </th>
						<td>
							<font color="#000000">
							This checks that the SDS ID with OID 
							<xsl:value-of select="$root"/>
							 is 12 numeric chars long
						</font>
						</td>
					</tr>
					<tr>
						<th>Result:</th>
						<td>
							<xsl:element name="font">
								<xsl:attribute name="color">xFF0000</xsl:attribute>
								<b>
									<xsl:text>Failure ERROR:  "</xsl:text>
									<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
									</xsl:call-template>
									<xsl:text> has a value of "</xsl:text><xsl:value-of select="$ext"/><xsl:text>" which is an incorrect format. </xsl:text>
								</b>
							</xsl:element>
						</td>
					</tr>
				</table>
			</xsl:if>
	</xsl:template>
</xsl:stylesheet>
