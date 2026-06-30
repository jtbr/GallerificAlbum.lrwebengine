
# Gallerific HTML5 Lightroom Web Album

Thanks for downloading the Gallerific Web Album Plugin for Adobe Lightroom! Hope you enjoy it.

### Installation:

1) Unzip the `GallerificAlbum.lrwebengine` folder and copy this to the Lightroom `Web Galleries` folder. This folder can be opened within Lightroom preferences (Win: *Edit->Preferences*, Mac: *Lightroom->Preferences*) by clicking on the "Show Lightroom Presets Folder" button, then opening `Web Galleries`.
	* On *Mac* this is located under: `/Users/username/Library/Application Support/Adobe/Lightroom/Web Galleries/`
	* On *Windows Vista/7/8/10*, this is normally under: `C:\Users\username\AppData\Roaming\Adobe\Lightroom\Web Galleries\`
	* On *Windows XP* this is normally under: `C:\Documents and Settings\username\Application Data\Adobe\Lightroom\Web Galleries\`
1) Recommended but optional: Install the set of templates ("skins") for albums by copying the `Gallerific-Templates` folder into the `Web Templates` folder under the `Lightroom` presets folder. These will give you a good idea of output options and possible color schemes.
1) (Re-)Start Lightroom; the Gallerific gallery should appear in the list at the top right under the Web workflow

### Usage:

* As with any web album, select the images you wish to export using the **Library** view in Lightroom. Be sure they have all the metadata you want to include in the album. When you're happy with the images and their order, open the **Web** view.
* Select the `Gallerific HTML5 Gallery` from the Layout style at the top right.
* In the Web view, choose the options you want. Enter titles, descriptions, customize your image captions and use a custom logo, and choose where they appear. Customize your color scheme and how images will appear. Choose the size of the gallery image slide and an expanded full size image to be generated, as well as caption metadata and watermark to include. You can use the **Preview in Browser** button to check out your album's appearance. And then simply **Export to disk** or **Upload** (to a server via FTP/SFTP) the complete album when you're ready! The resulting HTML pages and supporting files will be generated in the folder or server location you selected. 
	* You can view them on your local computer by opening the file `index.html` in a web browser. The generated folder can then be loaded onto a web server for access via the web or just copied to a shared folder or CD/DVD/thumb drive to share with others.
* [More details about creating web albums in general are available from Adobe](https://helpx.adobe.com/lightroom/help/creating-web-galleries-basic-workflow.html).

### Tips and configuration options:

* Most but not all of the options are reflected in the preview within Lightroom. *Only 8 images are generated for previews within in Lightroom*, to prevent previews from taking too long to generate.

* The appearance of the album depends on the size of the device/browser it is viewed on. This "responsive" design means that when the width is less than 770px (as on most tablets/phones in portrait mode), it will show a concise thumbnail bar that scrolls on the bottom. Otherwise the thumbnails will appear on the left. The number of columns will vary depending upon the page size, as will the size of the main image.

* As a user, there are various ways to navigate the album:
   * **Left / right arrows** go to the previous / next image. 
   * **Swiping left or right** on the image will go to the next or previous image on touch devices.
   * **Clicking/tapping on the image** will go to the next image. Clicking/tapping on the next or previous image links will also take you there.
   * Pressing **Home, End, or Space** will show the first, last or next image.
   * **PgUp / PgDn will** go to the previous page of thumbnails (or scroll the bottom thumbnail bar commensurately).
   * **Swiping up or down** on the column thumbnail view will go to the next or previous page of thumbnails. 
   * **Swiping left or right** on the bottom thumbnail bar will scroll through the thumbnails. Tapping / clicking on the left/right arrow will scroll also scroll thumbnail bar, as will **operating the mouse wheel** with the bar in focus.
   * The **Pinch-out gesture** (spreading two fingers) on an image will load the full size image on touch devices, as will clicking/tapping the "Full Size Image" link in the caption.
   * Once the full size image is open, you must use the browser 'Back' functionality (ie, backspace, alt(cmd)-left, swipe from left edge on iOS, etc.) to return to the album (unfortunately I don't know any easy way around this).
   * And finally, pressing the play slideshow button will navigate the images all by itself.

* If serving the gallery from a web server, it is strongly recommended to use gzip compression on the server serving these pages. Gallerific has been optimized with this in mind. See [here](http://betterexplained.com/articles/how-to-optimize-your-site-with-gzip-compression/) for more info.

* The image sizes are for the main image (slide) and full size image (loaded when clicking the full size image link in the caption). For normal screens, I like 720 for the slide size, but if you'll have a lot of viewers with high resolution screens, or "Retina" style screens (where each logical pixel is more than one actual pixel), then it makes sense to use a higher value (possibly twice that). Since images will never be scaled up, this ensures they will be large enough to fill the screen, and on retina displays, they'll lead to a crisper image. But the downside is that larger images are slower to load and take up more bandwidth, so are worse especially where broadband connections are unavailable. 

* The download all feature will save a .zip file of either the "large" or "full" size images. It may not work for large albums (where the full size images total more than ~400mb). The actual limit depends upon the browser. As of this writing current versions of browsers can support [up to 500-800Mb](https://github.com/eligrey/FileSaver.js#supported-browsers). The download link icon will not be shown on Apple iOS or when running locally, because file save will not work on iOS, and it's not very useful locally (instead just zip the directory manually) -- plus Chrome and IE block it locally as a security precaution. Internet Explorer 9 and below are not supported, and neither are certain older browsers; in these cases a message will be displayed asking them to upgrade or use another browser. Current versions of Chrome, Firefox, Opera, Safari, Edge, and Internet Explorer are all supported (when the gallery is loaded from a web server). There is no additional compression applied beyond that already provided by jpeg images.

* In some cases the album is represented by an image when it is shared via social media (facebook/email/twitter/etc). This image can be chosen by specifying the index value of the image, which is the count starting from 1 at the beginning of the album.

* The "Destination URL path to gallery" is the preferred, canonical URL path to the final location where the gallery is expected to be hosted on the web. This path is the one that will contain the gallery's index.html file and im/ and res/ directories. It is used for social media and search engines, to generate previews and consolidate the various ways that a page might be accessed. For these functions to work correctly, it's important that the URL not redirect somewhere else. 

* The markup option allows you to include arbitrary invisible markup to the body of the generated web album. It can be useful for including web fonts, web analytics, etc. Note that it must be valid HTML script. 

* The font family stacks are ordered lists (preferred to less-preferred) and can include web fonts (such as [these from Google](https://www.google.com/fonts)) if you have included markup for them above, for example: 
   ```html
   <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">
   ```
	[Here are some tips for choosing font stacks.](https://www.smashingmagazine.com/2009/09/complete-guide-to-css-font-stacks/)

* The background repeat property controls how images are repeated, and is [defined here](https://developer.mozilla.org/en-US/docs/Web/CSS/background-repeat).

* You may want to disable "Facebook like" for several reasons: 1) It requires a popup overlay to work. 2) It's fickle; Facebook is notoriously guarded about the like button and it may not work for your site depending upon things like where it is hosted. 3) You may prefer to link to your Facebook profile and encourage people to like that instead of your galleries. Most 'likes' are of internal Facebook 'pages' or 'posts'.
	* Note that "Facebook like" may not work on pages that are hosted on shared hosts such as amazon web services. This is due to facebook's overzealous anti-spam software. 

* Links to a map are available for any image with a GPS location, or any image with a City and either a State or a Country. If both GPS locations and cities are selected and an image has both, then the GPS location will be used. If the city is used, a combination of all available sublocation, city, state, and country fields will be used for geolocation.

* All the strings that are used in the generated web album (e.g. *Next Photo*, *Play Slideshow*, ...) are customizable. If you are targeting a language other than the one used by Lightroom, you may find it helpful to copy the default strings for that other language from the `TranslatedStrings.txt` file in the `strings` subdirectory for the given language. The relevant strings are below the line `--[[Custom strings]]`. If you make a complete translation into another language, let me know! I'd be happy to include it in the next release.

* Generally, you can save images at quality level 65-75 without noticible degradation, and wouldn't want any higher or images will be too slow to load. Another option, and one I prefer, is to save them at 95 or so quality (nearly lossless) from Lightroom, and then do postprocessing on the generated images using [mozjpeg](https://github.com/mozilla/mozjpeg), which can achieve much higher compression ratios without noticeable artifacts. This is the approach I take with my [automated deployment tool](http://trialstravails.blogspot.com/2015/07/deploying-website-to-amazon-s3.html).

* Even if you disable "Full size image" links, full size images will still be generated (this is a limitation of Lightroom), but at thumbnail size. You could delete them from the `im/fl/` folder after generation if you want.

##### For more information and updates, please visit [the Gallerific home page](http://trialstravails.blogspot.com/2015/07/gallerific.html).

###### Generated with dillinger.io
