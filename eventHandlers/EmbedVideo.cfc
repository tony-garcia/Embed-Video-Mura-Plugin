<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cffunction name="onRenderEnd" output="false" returntype="void">
		<cfargument name="event">
		<cfset var output = "" />
		<cfif pluginConfig.getSetting( "isEnabled" ) eq "yes">
			<cfset output = event.getValue( "__MuraResponse__" )>
			<cfset output = parseTags( output ) />
			<cfset event.setValue( "__MuraResponse__", output ) />
		</cfif>
	</cffunction>
	
	<cffunction name="parseTags" access="private" returntype="any" output="false">
		<cfargument name="contentBody" required="true" />
		<cfset var tagBody = "" />
		<cfset var parsedContent = arguments.contentBody />
		<cfset var noMoreMatches = false />
		<cfset var startPosition = 1 />
		<cfset var tagParams = structNew() />
		<cfset var thisParam = "" />
		<cfset var tagMatch = "" />
		<cfset var paramList = "from,videoid,valueid,height,width,rel" />
		
		<cfloop condition="noMoreMatches is false">
			<cfset tagMatch = reFindNoCase( "\[EmbedVideo.+?\]",arguments.contentBody,startPosition,true ) />
			<cfif tagMatch.len[1] eq 0>
				<cfset noMoreMatches = true />
			<cfelse>
				<cftry>
					<!--- get the tag code --->
					<cfset tagBody = mid( arguments.contentBody,tagMatch.pos[1],tagMatch.len[1] ) />
					<!--- get the tag params --->
					<cfloop list="#paramList#" index="thisParam">
						<cfset tagParams[thisParam] = reFindNoCase( "#thisParam#:.+?[\] ]",tagBody,1,true ) />
						<cfif tagParams[thisParam]["pos"][1] neq 0>
							<cfset tagParams[thisParam] = right( mid( tagBody,tagParams[thisParam]["pos"][1],tagParams[thisParam]["len"][1]-1 ),tagParams[thisParam]["len"][1]-( len( thisParam )+2 ) ) />
						<cfelse>
							<cfset structDelete( tagParams,thisParam ) />	
						</cfif>
					</cfloop>
					<!--- replace tag with video embedding code --->
					<cfset parsedContent = replaceNoCase( parsedContent,tagBody,getEmbedCode( argumentCollection=tagParams ),"all" ) />
					<cfcatch type="any">
						<cfset parsedContent = replaceNoCase( parsedContent,tagBody,"An error occurred embedding video. Please check your EmbedVideo tag syntax.","all" ) />
					</cfcatch>
				</cftry>
				<!--- set counter for the next tag --->
				<cfset startPosition = tagMatch.pos[1] + len( tagBody ) />
			</cfif>
		</cfloop>
		<cfreturn parsedContent />
	</cffunction>
	
	<cffunction name="getEmbedCode" access="private" returntype="any" output="false">
		<cfargument name="from" required="true" type="string" />
		<cfargument name="videoid" required="true" type="string" />
		<cfargument name="valueid" required="false" type="string" />
		<cfargument name="rel" default="#pluginConfig.getSetting( "displayRelated" )#" />
		<cfargument name="height" default="#pluginConfig.getSetting( "defaultHeight" )#" type="numeric" />
		<cfargument name="width" default="#pluginConfig.getSetting( "defaultWidth" )#" type="numeric" />
		<cfset var code = "" />
		
		<cfswitch expression="#arguments.from#">
			<cfcase value="youtube">
				<cfsavecontent variable="code">
				<cfoutput>
					<object width="#arguments.width#" height="#arguments.height#">
						<param name="movie" value="http://www.youtube.com/v/#arguments.videoid#&hl=en&fs=1" />
						<param name="allowFullScreen" value="true" />
						<param name="allowscriptaccess" value="always" />
						<param name="wmode" value="transparent" />
						<embed src="http://www.youtube.com/v/#arguments.videoid#&hl=en&fs=1&rel=#numberFormat(arguments.rel)#" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" wmode="transparent" width="#arguments.width#" height="#arguments.height#"></embed>
					</object>
				</cfoutput>
				</cfsavecontent>
			</cfcase>
			<cfcase value="vimeo">
				<cfsavecontent variable="code">
				<cfoutput>
					<object width="#arguments.width#" height="#arguments.height#">
						<param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=#arguments.videoid#&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" />
						<param name="allowfullscreen" value="true" />
						<param name="allowscriptaccess" value="always" />
						<embed src="http://vimeo.com/moogaloop.swf?clip_id=#arguments.videoid#&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="#arguments.width#" height="#arguments.height#"></embed>
					</object>
				</cfoutput>
				</cfsavecontent>
			</cfcase>
			<cfcase value="yahoo">
				<cfif len( arguments.valueid ) is 0>
					<cfthrow type="mura.plugin.EmbedVideoPlugin" message="The valueid attribute must be passed into the EmbedVideo tag for Yahoo videos." />
				</cfif>
				<cfsavecontent variable="code">
				<cfoutput>
					 <object width="#arguments.width#" height="#arguments.height#">
					 	<param name="movie" value="http://d.yimg.com/static.video.yahoo.com/yep/YV_YEP.swf?ver=2.2.46" />
						<param name="allowFullScreen" value="true" />
						<param name="allowScriptAccess" VALUE="always" />
						<param name="bgcolor" value="##000000" />
						<param name="flashVars" value="id=#arguments.valueid#&vid=#arguments.videoid#&lang=en-us&intl=us&embed=1" />
						<embed src="http://d.yimg.com/static.video.yahoo.com/yep/YV_YEP.swf?ver=2.2.46" type="application/x-shockwave-flash" width="#arguments.width#" height="#arguments.height#" allowFullScreen="true" AllowScriptAccess="always" bgcolor="##000000" flashVars="id=#arguments.valueid#&vid=#arguments.videoid#&lang=en-us&intl=us&embed=1" >
						</embed>
					</object>
				</cfoutput>
				</cfsavecontent>
			</cfcase>
			<cfcase value="metacafe">
				<cfif len( arguments.valueid ) is 0>
					<cfthrow type="mura.plugin.EmbedVideoPlugin" message="The valueid attribute must be passed into the EmbedVideo tag for Metacafe videos." />
				</cfif>
				<cfsavecontent variable="code">
				<cfoutput>
					<object width="#arguments.width#" height="#arguments.height#">
						<param name="movie" value="http://www.metacafe.com/fplayer/#arguments.videoid#/#arguments.valueid#.swf" />
						<param name="allowFullScreen" value="true" />
						<param name="allowScriptAccess" value="always" />
						<param name="wmode" value="transparent" />
						<embed src="http://www.metacafe.com/fplayer/#arguments.videoid#/#arguments.valueid#.swf" width="#arguments.width#" height="#arguments.height#" wmode="transparent" allowFullScreen="true" allowScriptAccess="always" name="Metacafe_#arguments.videoid#" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"></embed>
					</object>
				</cfoutput>
				</cfsavecontent>
			</cfcase>
			<cfcase value="liveleak">
				<cfsavecontent variable="code">
				<cfoutput>
					<object width="#arguments.width#" height="#arguments.height#">
						<param name="movie" value="http://www.liveleak.com/e/#arguments.videoid#" />
						<param name="wmode" value="transparent" />
						<param name="allowscriptaccess" value="always" />
						<embed src="http://www.liveleak.com/e/#arguments.videoid#" type="application/x-shockwave-flash" wmode="transparent" allowscriptaccess="always" width="#arguments.width#" height="#arguments.height#" />
					</object>
				</cfoutput>
				</cfsavecontent>
			</cfcase>
		</cfswitch>
		<cfreturn code />
	</cffunction>

</cfcomponent>