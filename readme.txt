The Embed Video plugin allows you to easily embed videos from popular video sharing services (YouTube, Yahoo, Vimeo, Metacafe, LiveLeak) in 
your Mura content using a simple tag syntax.
The tag can be used in pages (body and summary sections) as well as in Mura components or pretty much any display object (even within other plugins).

The format for the EmbedVideo tag is as follows:
[EmbedVideo from:{provider} videoid:{video id} valueid:{value id} width:{width} height:{height} rel:{true or false}]

Examples

YouTube: 
The following is an example of a video URL from www.youtube.com:

http://www.youtube.com/watch?v=tgbNymZ7vqY

To embed this video in your content, type this into the content editor:

[EmbedVideo from:youtube videoid:tgbNymZ7vqY]

The video id is the text that follows ?v= in the URL. In this case, since the height and width wasn't specified the default values will be used, 
which are set in the plugin configuration. Also, the "rel" attribute (rel:{true or false}) indicates whether to display thumbnails of related 
videos after the video is over. If not specified in the tag, the default value from the global settings will be used.

Vimeo: 
The following is an example of a video URL from vimeo.com:

http://vimeo.com/6988013

The video id is the last part of the URL (after the "/"). To embed this video, type this:

[EmbedVideo from:vimeo videoid:6988013 width:500 height:400]

In this case, the height and width were specified, which will override the default values from the plugin's configuration.

Yahoo:
The following is an example of a video URL from video.yahoo.com:

http://video.yahoo.com/watch/6261550/16249727

For Yahoo videos, two values must be passed into the tag, the video id and the value id. The video id is the first string of numbers at appears 
on the URL. In the example above, the video id is 6261550. The value id is the last string of numbers, or 16249727 in the example above. So to 
embed this video, you would type into the content editor:

[EmbedVideo from:yahoo videoid:6261550 valueid:16249727]

Again, the default height and width would be used in this case since they were not specified in the tag.

Metacafe: 
The following is an example of a video URL from www.metacafe.com:

http://www.metacafe.com/watch/3768082/funny_monkeyin_the_box/

Just as with Yahoo videos, a video id and a value id must be passed into the EmbedVideo tag. The video id is the set of numbers found in the URL, 
or 3768082 in the example above. The value id is the last part of the URL. In the example above, that would be funny_monkeyin_the_box. Therefore, 
to embed the example video, you could type in:

[EmbedVideo from:metacafe videoid:3768082 valueid:funny_monkeyin_the_box width:550 height:425]

LiveLeak: 
The following is an example of a video URL from www.liveleak.com:

http://www.liveleak.com/view?i=d73_1280863671

The video id is the text that follows ?i= in the URL (in this case, d73_1280863671). Therefore, to embed the example video, you could type in:

[EmbedVideo from:liveleak videoid:d73_1280863671]

IMPORTANT

Please follow the syntax of the examples above exactly. Do not leave spaces between the colons an the attribute names/values in the tag. Also 
don't surround attribute values with quotes and leave no spaces between the enclosing square brackets and the tag content.

VERSION HISTORY:
1.0		Initial release December 16, 2009

1.0.1	February 20, 2010
		Added "Display Related Videos" global setting and "rel" tag attribute to indicate whether to display thumbnails of related videos at the end of YouTube video.
		Tag can now be used within components and other display objects.
1.0.2	August 5, 2010
		Added support for videos from www.liveleak.com (requested by "Jonas")