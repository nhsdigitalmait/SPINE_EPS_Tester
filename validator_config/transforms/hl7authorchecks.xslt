<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hl7="urn:hl7-org:v3">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:variable name="a" select="//*[1]/hl7:ControlActEvent/hl7:author"/>
		<xsl:variable name="a1" select="//*[1]/hl7:ControlActEvent/hl7:author1"/>
		<xsl:choose>
			<xsl:when test="not($a1)">
				<xsl:text>ERROR: author1 element missing from HL7 ControlAct</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="count($a1) = 1">
						<xsl:if test="not($a1[1]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@root='1.2.826.0.1285.0.2.0.107')">
							<xsl:text>ERROR author1 id OID is wrong, expected 1.2.826.0.1285.0.2.0.107 found </xsl:text>
							<xsl:value-of select="$a1[1]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@root"/>
						</xsl:if>
						<xsl:if test="not(string-length($a1[1]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@extension)>0)">
							<xsl:text>ERROR empty author1 system id</xsl:text>
						</xsl:if>
					</xsl:when>
					<xsl:when test="count($a1) = 2">
						<xsl:if test="not($a1[1]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@root='1.2.826.0.1285.0.2.0.107')">
							<xsl:text>ERROR author1 id OID is wrong, expected 1.2.826.0.1285.0.2.0.107 found </xsl:text>
							<xsl:value-of select="$a1[1]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@root"/>
						</xsl:if>
						<xsl:if test="not(string-length($a1[1]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@extension)>0)">
							<xsl:text>ERROR empty author1 system id</xsl:text>
						</xsl:if>
						<xsl:if test="not(string-length($a1[2]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@root)>0)">
							<xsl:text>ERROR author1 id OID is empty</xsl:text>
						</xsl:if>
						<xsl:if test="not(string-length($a1[2]/hl7:AgentSystemSDS/hl7:agentSystemSDS/hl7:id/@extension)>0)">
							<xsl:text>ERROR empty author1 system id</xsl:text>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>ERROR should be 1 or 2 author1 elements, found </xsl:text>
						<xsl:value-of select="count($a1)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$a">
			<xsl:if test="count($a) > 1">
				<xsl:text>ERROR should be zero or one author1 elements</xsl:text>
			</xsl:if>
			<xsl:if test="not($a/hl7:AgentPersonSDS/hl7:id/@root='1.2.826.0.1285.0.2.0.67')">
				<xsl:text>ERROR wrong OID in author AgentPersonSDS role id. Should be 1.2.826.0.1285.0.2.0.67 found </xsl:text>
				<xsl:value-of select="$a/hl7:AgentPersonSDS/hl7:id/@root"/>
			</xsl:if>
			<xsl:if test="not(string-length($a/hl7:AgentPersonSDS/hl7:id/@extension) > 0)">
				<xsl:text>ERROR no author role id data</xsl:text>
			</xsl:if>
			<xsl:if test="not($a/hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id/@root='1.2.826.0.1285.0.2.0.65')">
				<xsl:text>ERROR wrong OID in author AgentPersonSDS userid. Should be 1.2.826.0.1285.0.2.0.65 found </xsl:text>
				<xsl:value-of select="$a/hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id/@root"/>
			</xsl:if>
			<xsl:if test="not(string-length($a/hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id/@extension) > 0)">
				<xsl:text>ERROR missing author user id</xsl:text>
			</xsl:if>
			<xsl:if test="not($a/hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id/@root='1.2.826.0.1285.0.2.0.65')">
				<xsl:text>ERROR wrong OID in author AgentPersonSDS userid. Should be 1.2.826.0.1285.0.2.0.65 found </xsl:text>
				<xsl:value-of select="$a/hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id/@root"/>
			</xsl:if>
			<xsl:if test="not(string-length($a/hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id/@extension) > 0)">
				<xsl:text>ERROR missing author user id</xsl:text>
			</xsl:if>
			<xsl:if test="not($a/hl7:AgentPersonSDS/hl7:part/hl7:partSDSRole/hl7:id/@root='1.2.826.0.1285.0.2.1.104')">
				<xsl:text>ERROR wrong OID in author part SDS role, expected 1.2.826.0.1285.0.2.1.104 found </xsl:text>
				<xsl:value-of select="$a/hl7:AgentPersonSDS/hl7:part/hl7:partSDSRole/hl7:id/@root"/>
			</xsl:if>
			<xsl:if test="not(string-length($a/hl7:AgentPersonSDS/hl7:part/hl7:partSDSRole/hl7:id/@root) > 0)">
				<xsl:text>ERROR missing author part SDSrole</xsl:text>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
