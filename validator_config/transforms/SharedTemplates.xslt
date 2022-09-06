<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hl7="urn:hl7-org:v3">
	
	<!--Author: Meena Pillai -->
	<!--Version: 2.2 -->
	<!--Date Created: 6th August 2007-->
	<!--Date Modified: 13th January 2010-->
	<!--Purpose: To check that data within PDS General Update complies to MIM and compliance document constraints such as:
		1. An element with updateMode = 'altered' or 'removed' and the below characteristics must have an id
			with the @root = '2.16.840.1.113883.2.1.3.2.4.18.1' and @extension which contains the PDS object 
			Identifier.-->
			
		<xsl:template name="CheckTel_NonNumeric">
		<xsl:for-each select="self::node()[contains(@value,'tel:')]">
			<xsl:if test="self::node()[not(contains(@value,';ext'))]">
			<xsl:for-each select="self::node()[contains(@value,'tel:')][translate(substring-after(@value,'tel:'),'0123456789+-','')]/@value">
				<table border="1" width="800">
					<tr>
						<th>Name: </th>
						<td>
							<font color="#0000CC">
								<b>CheckTel_NonNumeric_DoesNotExist</b>
							</font>
						</td>
					</tr>
					<tr>
						<th>Description: </th>
						<td>
							<font color="#000000">
							This checks that the telecom element containing tel has a numeric value.
						</font>
						</td>
					</tr>
					<tr>
						<th>Result:</th>
						<td>
							<xsl:element name="font">
								<xsl:attribute name="color">xFF0000</xsl:attribute>
								<b>
									<xsl:text>Failure error: The telecom element with tel: prefix must be followed by a numeric value and must not contain any spaces.</xsl:text>
								</b>
								<p>
									<b>Telecom value found:</b>
										<xsl:value-of select="."/>
								</p>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
							</xsl:element>
						</td>
					</tr>
				</table>
		</xsl:for-each>
			
			</xsl:if>
		
		</xsl:for-each>
		
	</xsl:template>
	
		<xsl:template name="CheckFax_NonNumeric">
			<xsl:for-each select="self::node()[contains(@value,'fax:')]">
			<xsl:if test="self::node()[not(contains(@value,';ext'))]">
		<xsl:for-each select="self::node()[contains(@value,'fax:')][translate(substring-after(@value,'fax:'),'0123456789+-','')]/@value">
				<table border="1" width="800">
					<tr>
						<th>Name: </th>
						<td>
							<font color="#0000CC">
								<b>CheckFax_NonNumeric_DoesNotExist</b>
							</font>
						</td>
					</tr>
					<tr>
						<th>Description: </th>
						<td>
							<font color="#000000">
							This checks that the telecom element containing fax has a numeric value and does not contain any spaces.
						</font>
						</td>
					</tr>
					<tr>
						<th>Result:</th>
						<td>
							<xsl:element name="font">
								<xsl:attribute name="color">xFF0000</xsl:attribute>
								<b>
									<xsl:text>Failure error: The telecom element with fax: prefix must be followed by a numeric value and must not contain any spaces.</xsl:text>
								</b>
								<p>
									<b>Fax value found:</b>
										<xsl:value-of select="."/>
								</p>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
							</xsl:element>
						</td>
					</tr>
				</table>
				</xsl:for-each>
				</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CheckTel_Value">
		<xsl:for-each select="self::node()[not(starts-with(@value,'tel') or  starts-with(@value,'fax:') or starts-with(@value,'mailto:') or  starts-with(@value,'textphone:'))]/@value">
				<table border="1" width="800">
					<tr>
						<th>Name: </th>
						<td>
							<font color="#0000CC">
								<b>CheckTel_Value</b>
							</font>
						</td>
					</tr>
					<tr>
						<th>Description: </th>
						<td>
							<font color="#000000">
							This checks that the telecom numeric value is preceded by either of the values tel:, fax:,mailto: or textphone.
						</font>
						</td>
					</tr>
					<tr>
						<th>Result:</th>
						<td>
							<xsl:element name="font">
								<xsl:attribute name="color">xFF0000</xsl:attribute>
								<b>
									<xsl:text>Failure error: The telecom numeric value must be preceded with either tel:,fax:,mailto: or textphone</xsl:text>
								</b>
								<p>
									<b>Telecom value found:</b>
										<xsl:value-of select="."/>
								</p>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
							</xsl:element>
						</td>
					</tr>
				</table>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="plotPath">
		<xsl:param name="forNode"/>
		<xsl:if test="name($forNode)">
			<xsl:call-template name="plotPath">
				<xsl:with-param name="forNode" select="$forNode/.."/>
			</xsl:call-template>
			<xsl:text>/</xsl:text>
		</xsl:if>
		<xsl:value-of select="name($forNode)"/>
	</xsl:template>
</xsl:stylesheet>
