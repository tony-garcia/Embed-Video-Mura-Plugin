<cfinclude template="plugin/config.cfm" />
<cfsavecontent variable="body">
<cfoutput>
<h2>#request.pluginConfig.getName()#</h2>
<p>The Embed Video plugin allows you to easily embed videos from popular video sharing services (YouTube, Yahoo, Vimeo, Metacafe). In your
Mura content using a simple tag syntax.</p>
<p>The tag can be used in pages (body and summary sections) as well as in Mura components or pretty much any display object (even within other plugins).</p>
<p>The format for the EmbedVideo tag is as follows:
<p>[EmbedVideo from:{provider} videoid:{video id} valueid:{value id} <em>width:{width}</em> <em>height:{height}</em> <em>rel:{true or false}</em>]</p>
<table border="1">
  <tr>
    <th scope="col">Attribute</th>
    <th scope="col">Required?</th>
    <th scope="col">Default</th>
    <th scope="col">Explanation</th>
  </tr>
  <tr>
    <td>from</td>
    <td>yes</td>
    <td>&nbsp;</td>
    <td>Name of video provider. Can be one of these:<br />
    YouTube, Vimeo, Yahoo, Metacafe
    </td>
  </tr>
  <tr>
    <td>videoid</td>
    <td>yes</td>
    <td>&nbsp;</td>
    <td>ID of the video, which can be obtained from the video's URL on the<br />
    provider's site (see below).</td>
  </tr>
  <tr>
    <td>valueid</td>
    <td>only for Yahoo and Metacafe</td>
    <td>&nbsp;</td>
    <td>For Yahoo and Metacafe videos, a value ID must also be indicated, which<br />
    can be obtained from the video's URL on the provider's site (see below).</td>
  </tr>
  <tr>
    <td>width</td>
    <td>no</td>
    <td>determined by plugin settings</td>
    <td>Width of video in pixels. If not specified in the tag, will use the default<br /> 
    value from the plugin global settings.</td>
  </tr>
  <tr>
    <td>height</td>
    <td>no</td>
    <td>determinted by plugin settings</td>
    <td>Height of video in pixels. If not specified in the tag, will use the default <br />
    value from the plugin global settings.</td>
  </tr>
  <tr>
    <td>rel</td>
    <td>no</td>
    <td>determinted by plugin settings</td>
    <td><strong>YouTube only:</strong> Indicates whether to display thumbnails of related <br >
	videos after the video is over (true or false). If not specified in the tag,<br /> 
	will use the default value from the global settings.</td>
  </tr>
</table>
<h3>Examples</h3>
<p><strong>YouTube</strong>: The following is an example of a video URL from www.youtube.com:</p>
<pre>http://www.youtube.com/watch?v=tgbNymZ7vqY</pre><br />
<p>To embed this video in your content, type this into the content editor:</p>
<pre>[EmbedVideo from:youtube videoid:tgbNymZ7vqY]</pre><br />
<p>The video id is the text that follows ?v= in the URL. In this case, since the height and width wasn't specified the default values will be used, which are set in the plugin configuration.</p>
<p><strong>Vimeo</strong>: The following is an example of a video URL from vimeo.com:</p>
<pre>http://vimeo.com/6988013</pre><br />
<p>The video id is the last part of the URL (after the &quot;/&quot;). To embed this video, type this:</p>
<pre>[EmbedVideo from:vimeo videoid:6988013 width:500 height:400]</pre><br />
<p>In this case, the height and width were specified, which will override the default values from the plugin's configuration.</p>
<p><strong>Yahoo</strong>: The following is an example of a video URL from video.yahoo.com:</p>
<pre>http://video.yahoo.com/watch/6261550/16249727</pre><br />
<p>For Yahoo videos, two values must be passed into the tag, the video id and the value id. The video id is the first string of numbers at appears on the URL. In the example above, the video id is 6261550. The value id is the last string of numbers, or 16249727 in the example above. So to embed this video, you would type into the content editor:</p>
<pre>[EmbedVideo from:yahoo videoid:6261550 valueid:16249727]</pre><br />
<p>Again, the default height and width would be used in this case since they were not specified in the tag.</p>
<p><strong>Metacafe</strong>: The following is an example of a video URL from www.metacafe.com:</p>
<pre>http://www.metacafe.com/watch/3768082/funny_monkeyin_the_box/</pre><br />
<p>Just as with Yahoo videos, a video id and a value id must be passed into the EmbedVideo tag. The video id is the set of numbers found in the URL, or 3768082 in the example above. The value id is the last part of the URL. In the example above, that would be funny_monkeyin_the_box. Therefore, to embed the example video, you could type in:</p>
<pre>[EmbedVideo from:metacafe videoid:3768082 valueid:funny_monkeyin_the_box width:550 height:425]</pre><br />
<h3>Important</h3>
<p>Please follow the syntax of the examples above exactly. Do not leave spaces between the colons an the attribute names/values in the tag. Also don't surround attribute values with quotes and leave no spaces between the enclosing square brackets and the tag content.</p></cfoutput>
</cfsavecontent>
<cfoutput>
#application.pluginManager.renderAdminTemplate(body=body,pageTitle=request.pluginConfig.getName())#
</cfoutput>

