<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hl7="urn:hl7-org:v3">
	<xsl:include href="SharedTemplates.xslt"/>
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<!--Author: Meena Pillai -->
	<!--Version: 1.0 -->
	<!--Date Created: 28th October 2008-->
	<!--Date Modified: 11th June 2009-->
	<!--Modified By: Meena Pillai -->
	<!--Purpose: To check telecom structure and content-->
	<xsl:template match="/">
		<xsl:apply-templates select="/*[1]/hl7:ControlActEvent/hl7:subject//*[name()='telecom']"/>
	</xsl:template>
	
	<xsl:template match="/*[1]/hl7:ControlActEvent/hl7:subject//*[name()='telecom']">
		<xsl:for-each select=".">
			<xsl:call-template name="CheckTel_NonNumeric"/>
			<xsl:call-template name="CheckFax_NonNumeric"/>
			<xsl:call-template name="CheckTel_Value"/>
			
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>
