<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:w="urn:warlock-org:cfh:message-tools">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<!--<author>
		<name>Meena Pillai</name>
		<organisation>NHS/CfH/NIC</organisation>
		<contact>mailto:meena.pillai@nhs.net</contact>
		<date>26th June 2007</date>
	</author>-->
	<xsl:template match="/">
		<xsl:if test="/w:MessageValidatorConfiguration/w:checks">
			<html>
				<head>
					<title>Static Validation Report Documentation</title>
					<style type="text/css">
				body {
						background: #fff;
						margin: 0;
						padding: 0;
						font-family: arial, helvetica, Sans-Serif;
						font-size: 0.9em;
						color: #000;
					}
					table
					{
						border-right: black 1px solid;
						border-top: black 1px solid;
						border-left: black 1px solid;
						border-bottom: black 1px solid;
						border-collapse: collapse;
						margin-left:10pt;
						width: 80%;
						
					}					
					tbody
					{
						font-size: smaller;
					}
					th {
						width: 50pt;
						text-align: left;
						border-width: 1;
						border-style: solid;
					}
					td
					{
						border-style: solid;
						border-color: black;
						border-width: 1px;
						padding: 3pt 3pt 3pt 3pt;
						vertical-align: top;
					}
					
					td.header
					{
						background: #E5E5E5;
					}
					thead.header
					{
						background: #E5E5E5;
					}
				</style>
				</head>
				<body>
					<table.heading width="400" border="0">
						<tr>
							<td style="width:90%">
								<h3>
									<font color="#FF0000">
										<xsl:value-of select="/w:MessageValidatorConfiguration/@name"/>
									</font>  OMVT 2 Configuration File Documentation
					</h3>
							</td>
						</tr>
					</table.heading>
					<h3>
						<u>Rules Set Index</u>
					</h3>
					<xsl:for-each select="/w:MessageValidatorConfiguration/w:checks/w:check/@name">
						<xsl:variable name="Rule" select="@name"/>
						<xsl:call-template name="RuleIndex">
							<xsl:with-param name="Rule" select="."/>
						</xsl:call-template>
					</xsl:for-each>
					<xsl:for-each select="/w:MessageValidatorConfiguration/w:checks/w:check/@name">
						<xsl:variable name="Rule" select="@name"/>
						<xsl:call-template name="RuleDescription">
							<xsl:with-param name="Rule" select="."/>
						</xsl:call-template>
					</xsl:for-each>
				</body>
			</html>
		</xsl:if>
	</xsl:template>
	<xsl:template name="RuleIndex">
		<xsl:param name="Rule"/>
		<xsl:variable name="v_current" select="."/>
		<xsl:variable name="v_position" select="position()"/>
		<h4>
			<a>
				<xsl:attribute name="href"><xsl:text>#_Toc_Section_</xsl:text><xsl:value-of select="$v_position"/></xsl:attribute>
				<xsl:value-of select="$Rule"/>
			</a>
		</h4>
	</xsl:template>
	<xsl:template name="RuleDescription">
		<xsl:param name="Rule"/>
		<xsl:variable name="v_position" select="position()"/>
		<tr>
			<td>
				<xsl:call-template name="Checking">
					<xsl:with-param name="checking" select="$Rule"/>
					<xsl:with-param name="p_position" select="$v_position"/>
				</xsl:call-template>
			</td>
		</tr>
		<hr/>
	</xsl:template>
	<xsl:template name="Checking">
		<xsl:param name="checking"/>
		<xsl:param name="p_position"/>
		<h2>
			<a>
				<xsl:attribute name="name"><xsl:text>_Toc_Section_</xsl:text><xsl:value-of select="string(number($p_position))"/></xsl:attribute>
			</a>
			<xsl:value-of select="string(number($p_position))"/>
			<xsl:text>  </xsl:text>
			<xsl:value-of select="$checking"/>
		</h2>
		<table>
			<thead class="header">
				<tr>
					<td style="width:10%">Details</td>
					<td style="width: 60%">Description</td>
					<td style="width:30%">Messages Applied to</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>Name: </th>
					<xsl:element name="td">
					<xsl:element name="font">
					<xsl:attribute name="size">4px</xsl:attribute>
					<xsl:element name="b">
						<xsl:value-of select="$checking"/>
					</xsl:element>
					</xsl:element>
					</xsl:element>
					<xsl:element name="td">
						<xsl:attribute name="rowspan"><xsl:value-of select="3"/></xsl:attribute>
						<xsl:for-each select="//w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/@name=$checking] | //w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/w:ifSuccess/w:checking/@name=$checking] | //w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/w:ifNotSuccess/w:checking/@name=$checking] | //w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/w:ifSuccess/w:checking/@name=$checking] | //w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/w:ifSuccess/w:checking/w:ifSuccess/w:checking/@name=$checking] | //w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/w:ifNotSuccess/w:checking/w:ifNotSuccess/w:checking/@name=$checking] | /w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/w:ifSuccess/w:checking/w:ifNotSuccess/w:checking/@name=$checking] | /w:MessageValidatorConfiguration/w:staticValidations/w:staticValidation[w:checking/w:ifNotSuccess/w:checking/w:ifSuccess/w:checking/@name=$checking]">
							<xsl:for-each select="@applyto">
								<font color="#FF0000">
									<xsl:value-of select="."/>
								</font>
								<br/>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:element>
				</tr>
			</tbody>
			<tbody>
				<xsl:if test="$checking/../w:document">
					<tr>
						<th>Description: </th>
						<xsl:element name="td">
							<xsl:copy-of select="$checking/../w:document"/>
						</xsl:element>
					</tr>
				</xsl:if>
				<tr>
					<th>Type: </th>
					<xsl:element name="td">
						<xsl:value-of select="$checking/../@type"/>
					</xsl:element>
				</tr>
				<tr>
					<th>XPath: </th>
					<xsl:element name="td">
						<xsl:value-of select="$checking/../w:test/w:match"/>
					</xsl:element>
				</tr>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet>
