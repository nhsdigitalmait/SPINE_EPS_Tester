<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hl7="urn:hl7-org:v3">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:include href="SharedTemplates.xslt"/>
	<!--Author: Damian Murphy -->
	<!--Version: 3.0 -->
	<!--Date Created: 1st June 2007-->
	<!--Date Modified: 21st October 2008-->
	<!--Purpose: To identify the all the elements and attributes with no value.-->
	<!--Modified By: Meena Pillai -->
	<!--Date Modified: 10th November 2011-->
	<!--Modified By: Richard Robinson -->
	<!--Purpose: addition of local-name() to correct so that it will still recognise elements which have a namespace tag-->
	<xsl:template match="/">
		<xsl:apply-templates select="//@*"/>
		<xsl:apply-templates select="//*[not(local-name()='streetAddressLine') and not(@*) and not(text()) and not(child::*)]"/>
	</xsl:template>
	<xsl:template name="CheckBlankAttributes_DoesNotExist" match="//@*">
		<xsl:for-each select="self::node()">
			<xsl:if test=".=''">
				<table border="1" width="800">
					<tr>
						<th>Name: </th>
						<td>
							<font color="#0000CC">
								<b>CheckBlankAttributes_DoesNotExist</b>
							</font>
						</td>
					</tr>
					<tr>
						<th>Description: </th>
						<td>
							<font color="#000000">
							This checks that all the attributes contain a value.
						</font>
						</td>
					</tr>
					<tr>
						<th>Result:</th>
						<td>
							<xsl:element name="font">
								<xsl:attribute name="color">xFF0000</xsl:attribute>
								<b>
									<xsl:text>Failure error: The attribute needs to have a value.</xsl:text>
								</b>
								<xsl:text>&lt;br/></xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
							</xsl:element>
						</td>
					</tr>
				</table>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CheckBlankElements_DoesNotExist" match="//*[not(local-name()='streetAddressLine') and not(@*) and not(text()) and not(child::*)]">
		<xsl:for-each select="self::node()">
			<xsl:if test="self::node()=''">
				<table border="1" width="800">
					<tr>
						<th>Name: </th>
						<td>
							<font color="#0000CC">
								<b>CheckBlankElements_DoesNotExist</b>
							</font>
						</td>
					</tr>
					<tr>
						<th>Description: </th>
						<td>
							<font color="#000000">
							This checks that all the element contains a value.
						</font>
						</td>
					</tr>
					<tr>
						<th>Result:</th>
						<td>
							<xsl:element name="font">
								<xsl:attribute name="color">xFF0000</xsl:attribute>
								<b>
									<xsl:text>Failure error: The element needs to have a value.</xsl:text>
								</b>
								<xsl:text>&lt;br/></xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
							</xsl:element>
						</td>
					</tr>
				</table>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
