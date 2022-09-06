<?xml version="1.0" encoding="UTF-8"?>
<!--
		CheckEbSyncReply Checker
	
		Version 1.0, 10th October 2011
		Richard Robinson	
	
		NHS Connecting For Health NPfIT Comms & Messaging Team
		To check the message against a list of Reliable Asynchronous messges and thereby determine whether it should have SyncReply in the ebXML layer
	-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hl7="urn:hl7-org:v3" xmlns:eb="http://www.oasis-open.org/committees/ebxml-msg/schema/msg-header-2_0.xsd" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<h3>CheckEbSyncReply Checker</h3>
		<!-- Extract interaction information from the message-->
		<xsl:variable name="Header" select="*//eb:MessageHeader"/>
		<xsl:variable name="Action" select="$Header/eb:Action"/>
		<xsl:variable name="Service" select="$Header/eb:Service"/>
		<xsl:variable name="intMsgPat" select="document('./interactionMessagePatterns.xml')"/>
		<xsl:choose>
			<xsl:when test="$Header">
				<table border="0">
					<xsl:choose>
						<!-- ebXML Reliable Asynchronous Messages must have SyncReply: 2087 External Interface Specification: Appendix C: Message Validation -  count(/soap:Envelope[1]/soap:Header[1]/eb:SyncReply) = 1-->
						<xsl:when test="$intMsgPat//MESSAGE[INTERACTION=concat($Service,':',$Action) and PATTERN='ebXML Reliable Asynchronous']">
							<xsl:choose>
		<!-- Must have Sync Reply-->
								<xsl:when test="not(/*[1]//eb:SyncReply)">
									<tr>
										<td>
											<xsl:text>ERROR: </xsl:text>
											<xsl:call-template name="plotPath">
												<xsl:with-param name="forNode" select="."/>
											</xsl:call-template>
										</td>
									</tr>
									<tr>
										<td>
											<xsl:text>ebXML Reliable Asynchronous Messages must have SyncReply: 2087 External Interface Specification: Appendix C: Message Validation -  count(/soap:Envelope[1]/soap:Header[1]/eb:SyncReply) = 1</xsl:text>
										</td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
								<xsl:if test="not(/*[1]//eb:SyncReply/@soap:actor = 'http://schemas.xmlsoap.org/soap/actor/next')">
									<tr>
										<td>
											<xsl:text>ERROR: </xsl:text>
											<xsl:call-template name="plotPath">
												<xsl:with-param name="forNode" select="."/>
											</xsl:call-template>
										</td>
									</tr>
									<tr>
										<td>
											<xsl:text>This checks that the ebxml SyncReply	SOAP actor has the value 'http://schemas.xmlsoap.org/soap/actor/next' .REF TO EIS 11.5: Appendix C. Actual Value is: </xsl:text>
											<xsl:value-of select="/*[1]//eb:SyncReply/@soap:actor"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="not(/*[1]//eb:SyncReply/@eb:version = '2.0')">
									<tr>
										<td>
											<xsl:text>ERROR: </xsl:text>
											<xsl:call-template name="plotPath">
												<xsl:with-param name="forNode" select="."/>
											</xsl:call-template>
										</td>
									</tr>
									<tr>
										<td>
											<xsl:text>This checks that the ebxml SyncReply	version should have the value '2.0'. REF TO EIS 11.5: Appendix C. Actual Value is: </xsl:text>
											<xsl:value-of select="/*[1]//eb:SyncReply/@eb:version"/>
										</td>
									</tr>
								</xsl:if>
									<xsl:text>SyncReply present</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<!-- Forward Reliability Messages must NOT have SyncReply: 2087 External Interface Specification: Appendix C: Message Validation - count(/soap:Envelope[1]/soap:Header[1]/eb:SyncReply) = 0-->
						<xsl:when test="$intMsgPat//MESSAGE[INTERACTION=concat($Service,':',$Action) and PATTERN='Forward Reliable']">
							<xsl:choose>
								<xsl:when test="/*[1]//eb:SyncReply">
									<tr>
										<td>
											<xsl:text>ERROR: </xsl:text>
											<xsl:call-template name="plotPath">
												<xsl:with-param name="forNode" select="."/>
											</xsl:call-template>
										</td>
									</tr>
									<tr>
										<td>
											<xsl:text>Forward Reliability Messages must NOT have SyncReply: 2087 External Interface Specification: Appendix C: Message Validation - count(/soap:Envelope[1]/soap:Header[1]/eb:SyncReply) = 0</xsl:text>
										</td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>SyncReply absent</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<xsl:text>ERROR: No *//eb:MessageHeader</xsl:text>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" mode="serialise">
		<xsl:text>&lt;</xsl:text>
		<xsl:value-of select="name()"/>
		<xsl:for-each select="@*">
			<xsl:text> </xsl:text>
			<xsl:value-of select="name()"/>
			<xsl:text>="</xsl:text>
			<xsl:value-of select="."/>
			<xsl:text>"</xsl:text>
		</xsl:for-each>
		<xsl:text>></xsl:text>
		<xsl:apply-templates select="node()" mode="serialise"/>
		<xsl:text>&lt;/</xsl:text>
		<xsl:value-of select="name()"/>
		<xsl:text>></xsl:text>
	</xsl:template>
	<xsl:template name="plotPath">
		<xsl:param name="forNode"/>
		<xsl:if test="name($forNode)">
			<xsl:call-template name="plotPath">
				<xsl:with-param name="forNode" select="$forNode/.."/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(name($forNode) = '')">
			<xsl:text>/</xsl:text>
			<xsl:value-of select="name($forNode)"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
