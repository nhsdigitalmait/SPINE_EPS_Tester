<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2005/xpath-functions" xmlns:w="urn:warlock-org:cfh:message-tools">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!--Author: Ravi Natarajan -->
	<!--Version: 7.0 -->
	<!--Date Created: 30th July 2007-->
	<!--Date Modified: 12th July 2010-->
	<!--Modified By: Meena Pillai -->
	<!--Purpose: To transform the text ouput of OMVT in to a html report highlighting the errors.-->
	<xsl:template match="/">
		<xsl:if test="/w:ValidationResults/w:staticValidation/w:checking">
			<html>
				<head>
					<title>Static Validation Report</title>
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
						border-top: black 1px solid;
						border-left: black 1px solid;
						border-right: black 1px solid;
						border-bottom: black 1px solid;
						border-collapse: collapse;
						margin-left:10pt;
						
					}			
					
					table.header
					{
						
						border-top: 4BACC6 3px solid;
						border-right: 4BACC6 3px solid;
						border-bottom: 4BACC6 3px solid;
						
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
						border-style: solid;
						border-color: 4BACC6;
						border-width: 2px;
						padding: 3pt 3pt 3pt 3pt;
						vertical-align: top;
					}
					
					td.success {
						border-width: 1;
						border-style: solid;
						font-weight: bold;
						color: green;
						text-align: left;
					}
					td.failure {
						color: red;
						border-width: 1;
						border-style: solid;
						font-weight: bold;
						text-align: left;
					}
					td.warning {
						color: brown;
						border-width: 1;
						border-style: solid;
						font-weight: bold;
						text-align: left;
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
				<table>
				<xsl:variable name="day" select="day-from-date(current-date())"/>
					<xsl:variable name="month" select="month-from-date(current-date())"/>
					<xsl:variable name="year" select="year-from-date(current-date())"/>
					<xsl:variable name="hour" select="hours-from-time(current-time())"/>
					<xsl:variable name="minute" select="minutes-from-time(current-time())"/>
					<xsl:variable name="second" select="seconds-from-time(current-time())"/>
						<tr>
							<td class="header" colspan="3">
								<b>
									<span style="font-size:14pt">OMVT2 Validation Report Summary</span>
								</b>
							</td>
						</tr>
						<tr>
							<td>
								<b>Date/Time Validated:</b>
							</td>
							<td>
								<b>Ruleset Name used:</b>
							</td>
							<td>
								<b>Ruleset Version used:</b>
							</td>
						</tr>
						<tr>
							<td>
								<b>
									<span style="color:#0070C0">
										<xsl:value-of select="$day"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="$month"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="$year"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="$hour"/>
										<xsl:text>:</xsl:text>
										<xsl:value-of select="$minute"/>
										<xsl:text>:</xsl:text>
										<xsl:value-of select="format-number($second,'###')"/>
									</span>
								</b>
							</td>
							<td>
								<b>
									<span style="color:#0070C0">
										<xsl:value-of select="/w:ValidationResults/w:ConfigurationRuleSet/@name"/>
									</span>
								</b>
							</td>
							<td>
								<b>
									<span style="color:#0070C0">
										<xsl:value-of select="/w:ValidationResults/w:ConfigurationRuleSet/@version"/>
									</span>
								</b>
							</td>
						</tr>
						<tr>
							<td colspan="3" class="header">
								<b>Overall Validation Results:</b>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<xsl:if test="/w:ValidationResults/w:staticValidationsResult/@pass='success'">
									<span style="color:green; font-weight:bold">
										<xsl:value-of select="/w:ValidationResults/@HL7MessageID"/>
										<xsl:text> </xsl:text> Successfully passed OMVT2 validation</span>
								</xsl:if>
								<xsl:if test="/w:ValidationResults/w:staticValidationsResult/@pass='warning'">
									<span style="color:brown; font-weight:bold">
										<xsl:value-of select="/w:ValidationResults/@HL7MessageID"/>
										<xsl:text> </xsl:text>Passed OMVT2 validation with warnings</span>
								</xsl:if>
								<xsl:if test="/w:ValidationResults/w:staticValidationsResult/@pass='failure'">
									<span style="color:red; font-weight:bold">
										<xsl:value-of select="/w:ValidationResults/@HL7MessageID"/>
										<xsl:text> </xsl:text> Failed OMVT2 validation </span>
								</xsl:if>
							</td>
						</tr>
					</table>
					<br/>
					<table class="heading">
						<h4>OMVT2 Validation Checks Performed</h4>
						<ol>
							<xsl:for-each select="/w:ValidationResults/w:staticValidation/w:checking">
								<xsl:sort select="w:checkingResult/@pass"/>
								<!--<xsl:sort select="@name">
						</xsl:sort>-->
								<xsl:variable name="v_current" select="."/>
								<xsl:variable name="v_position" select="position()"/>
								<li>
									<h4>
										<xsl:attribute name="style">color:
							<xsl:choose><xsl:when test="$v_current/w:checkingResult/@pass='success'">green</xsl:when><xsl:when test="$v_current/w:checkingResult/@pass='warning'">brown</xsl:when><xsl:when test="$v_current/w:checkingResult/@pass='failure'">red</xsl:when></xsl:choose></xsl:attribute>
										<a>
											<xsl:attribute name="href"><xsl:text>#_Toc_Section_</xsl:text><xsl:value-of select="string(number($v_position))"/></xsl:attribute>
											<xsl:value-of select="@name"/>
										</a>
										<xsl:choose>
											<xsl:when test="$v_current/w:checkingResult/@pass='success'">
												<img src="success.ico" alt=""/>
											</xsl:when>
											<xsl:when test="$v_current/w:checkingResult/@pass='warning'">
												<img src="warning.ico" alt=""/>
											</xsl:when>
											<xsl:when test="$v_current/w:checkingResult/@pass='failure'">
												<img src="failure.ico" alt=""/>
											</xsl:when>
										</xsl:choose>
										<!--<xsl:if test="$v_current/w:checkResult">
								<xsl:text> : </xsl:text><xsl:value-of select="$v_current/w:checkResult/@pass"/>
							</xsl:if>-->
									</h4>
								</li>
							</xsl:for-each>
						</ol>
						<hr/>
						<xsl:for-each select="/w:ValidationResults/w:staticValidation/w:checking">
							<xsl:sort select="w:checkingResult/@pass"/>
							<!--<xsl:sort select="@name">
						</xsl:sort>-->
							<xsl:variable name="v_position" select="position()"/>
							<tr>
								<td>
									<xsl:call-template name="Checking">
										<xsl:with-param name="checking" select="."/>
										<xsl:with-param name="p_position" select="$v_position"/>
									</xsl:call-template>
								</td>
							</tr>
							<hr/>
						</xsl:for-each>
					</table>
				</body>
			</html>
		</xsl:if>
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
			<xsl:value-of select="$checking/@name"/>
		</h2>
		<table>
			<thead class="header">
				<tr>
					<td style="width:10%">Details</td>
					<td style="width: 90%">Description</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>Overall Result: </th>
					<xsl:element name="td">
						<xsl:choose>
							<xsl:when test="$checking/w:checkingResult/@pass = 'failure'">
								<font color="#FF0000" size="3">
									<b>
										<xsl:value-of select="$checking/w:checkingResult/@pass"/>
									</b>
								</font>
							</xsl:when>
							<xsl:otherwise>
								<font color="#009966" size="3">
									<b>
										<xsl:value-of select="$checking/w:checkingResult/@pass"/>
									</b>
								</font>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</tr>
				<tr>
					<th>Name: </th>
					<xsl:element name="td">
						<xsl:value-of select="$checking/w:check/@name"/>
					</xsl:element>
				</tr>
				<xsl:if test="$checking/w:check/w:document">
					<tr>
						<th>Description: </th>
						<xsl:element name="td">
							<xsl:copy-of select="$checking/w:check/w:document"/>
						</xsl:element>
					</tr>
				</xsl:if>
				<tr>
					<th>Type: </th>
					<xsl:element name="td">
						<xsl:value-of select="$checking/w:check/@type"/>
					</xsl:element>
				</tr>
				<!--xsl:if test="./w:check/@type!='schemaValidation'    and ./w:check/@type!='xslt' "-->
				<xsl:if test=" not ( $checking/w:check/@type='schemaValidation'  or 
					( $checking/w:check/@type='xslt'   or  $checking/w:check/@type='hl7xslt'   or       $checking/w:check/@type='ebxmlxslt' or  $checking/w:check/@type='soapxslt'  )) ">
					<tr>
						<xsl:if test="$checking/w:checkResult/@value">
							<th rowspan="2">Test: </th>
						</xsl:if>
						<xsl:if test="not($checking/w:checkResult/@value)">
							<th>Test: </th>
						</xsl:if>
						<xsl:element name="td">
							<xsl:value-of select="$checking/w:check/w:test"/>
						</xsl:element>
					</tr>
					<xsl:if test="$checking/w:checkResult/@value">
						<tr>
							<xsl:element name="td">
								<xsl:attribute name="class"><xsl:value-of select="$checking/w:checkResult/@pass"/></xsl:attribute>
								<xsl:value-of select="$checking/w:checkResult/@value"/>
							</xsl:element>
						</tr>
					</xsl:if>
				</xsl:if>
				<tr>
					<th>Result:</th>
					<xsl:element name="td">
						<xsl:attribute name="class"><xsl:value-of select="$checking/w:checkResult/@pass"/></xsl:attribute>
					</xsl:element>
					<xsl:value-of select="$checking/w:checkResult"/>
				</tr>
				<xsl:if test="$checking/w:document">
					<tr>
						<th>Message Specific Rule Information:</th>
						<xsl:element name="td">
							<xsl:value-of select="$checking/w:document"/>
						</xsl:element>
					</tr>
				</xsl:if>
				<xsl:if test="$checking/w:check/@type='schemaValidation'  or 
				(  $checking/w:check/@type='xslt'   or  $checking/w:check/@type='hl7xslt'   or       $checking/w:check/@type='ebxmlxslt' or  $checking/w:check/@type='soapxslt'  ) ">
					<tr>
						<th>Details:  </th>
						<xsl:element name="td">
							<xsl:attribute name="class"><xsl:value-of select="$checking/w:checkResult/@pass"/></xsl:attribute>
							<xsl:choose>
								<xsl:when test="$checking/w:check/@type='schemaValidation' ">
									<table>
										<tbody>
											<xsl:call-template name="split_schema_error">
												<xsl:with-param name="p_string" select="$checking/w:checkResult"/>
											</xsl:call-template>
										</tbody>
									</table>
								</xsl:when>
								<xsl:otherwise>
									<blockquote>
										<xsl:copy-of select="$checking/w:checkResult"/>
									</blockquote>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</tr>
				</xsl:if>
				<xsl:if test="$checking/w:thenCheckings">
					<tr>
						<th>then</th>
						<xsl:element name="td">
							<table>
								<tbody>
									<xsl:for-each select="$checking/w:thenCheckings/w:checking">
										<tr>
											<xsl:element name="td">
												<xsl:call-template name="Checking">
													<xsl:with-param name="checking" select="."/>
												</xsl:call-template>
											</xsl:element>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</xsl:element>
					</tr>
				</xsl:if>
				<xsl:if test="$checking/w:elseCheckings">
					<tr>
						<th>else</th>
						<xsl:element name="td">
							<table>
								<tbody>
									<xsl:for-each select="$checking/w:elseCheckings/w:checking">
										<tr>
											<xsl:element name="td">
												<xsl:call-template name="Checking">
													<xsl:with-param name="checking" select="."/>
												</xsl:call-template>
											</xsl:element>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</xsl:element>
					</tr>
				</xsl:if>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="split_schema_error">
		<xsl:param name="p_string"/>
		<xsl:variable name="v_error">
			<xsl:choose>
				<xsl:when test="substring-before($p_string,'ERROR')">
					<xsl:value-of select="substring-before($p_string,'ERROR')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="string-length($v_error) &gt; 0">
			<tr>
				<xsl:element name="td">
					<xsl:value-of select="substring-before($v_error,'Reason')"/>
				</xsl:element>
				<xsl:element name="td">
					<xsl:value-of select="concat('Reason',substring-after($v_error,'Reason'))"/>
				</xsl:element>
			</tr>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="string-length(substring-after($p_string,'ERROR')) &gt; 0">
				<xsl:call-template name="split_schema_error">
					<xsl:with-param name="p_string" select="substring-after($p_string,'ERROR')">
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
