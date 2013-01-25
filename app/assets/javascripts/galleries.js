function initGallerific() {
	// init gallerific
	$('div.navigation').css({'width' : '40%', 'float' : 'left'});
	$('div.content').css('display', 'block');

	// Initially set opacity on thumbs and add
	// additional styling for hover effect on thumbs
	var onMouseOutOpacity = 0.5;
	$('#thumbs ul.thumbs li').opacityrollover({
		mouseOutOpacity:   onMouseOutOpacity,
		mouseOverOpacity:  1.0,
		fadeSpeed:         'fast',
		exemptionSelector: '.selected'
	});

	$('#thumbs').galleriffic({
		delay:                     3000, // in milliseconds
		numThumbs:                 8, // The number of thumbnails to show page
		preloadAhead:              40, // Set to -1 to preload all images
		enableTopPager:            true,
		enableBottomPager:         true,
		maxPagesToShow:            5,  // The maximum number of pages to display in either the top or bottom pager
		imageContainerSel:         '#slideshow', // The CSS selector for the element within which the main slideshow image should be rendered
		controlsContainerSel:      '#controls', // The CSS selector for the element within which the slideshow controls should be rendered
		captionContainerSel:       '#caption', // The CSS selector for the element within which the captions should be rendered
		loadingContainerSel:       '#loading', // The CSS selector for the element within which should be shown when an image is loading
		renderSSControls:          true, // Specifies whether the slideshow's Play and Pause links should be rendered
		renderNavControls:         true, // Specifies whether the slideshow's Next and Previous links should be rendered
		playLinkText:              'Play',
		pauseLinkText:             'Pause',
		prevLinkText:              'Previous',
		nextLinkText:              'Next',
		nextPageLinkText:          'Next &rsaquo;',
		prevPageLinkText:          '&lsaquo; Prev',
		enableHistory:             false, // Specifies whether the url's hash and the browser's history cache should update when the current slideshow image changes
		enableKeyboardNavigation:  true, // Specifies whether keyboard navigation is enabled
		autoStart:                 false, // Specifies whether the slideshow should be playing or paused when the page first loads
		syncTransitions:           false, // Specifies whether the out and in transitions occur simultaneously or distinctly
		defaultTransitionDuration: 800, // If using the default transitions, specifies the duration of the transitions
		onSlideChange:             function(prevIndex, nextIndex) {
			// 'this' refers to the gallery, which is an extension of $('#thumbs')
			this.find('ul.thumbs').children()
				.eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
				.eq(nextIndex).fadeTo('fast', 1.0);
				// increment view count
				increment(this, nextIndex);
		},
		onPageTransitionOut:       function(callback) {
			this.fadeTo('fast', 0.0, callback);
		},
		onPageTransitionIn:        function() {
			this.fadeTo('fast', 1.0);
		},
		onTransitionOut:           undefined, // accepts a delegate like such: function(slide, caption, isSync, callback) { ... }
		onTransitionIn:            undefined, // accepts a delegate like such: function(slide, caption, isSync) { ... }
		onImageAdded:              undefined, // accepts a delegate like such: function(imageData, $li) { ... }
		onImageRemoved:            undefined  // accepts a delegate like such: function(imageData, $li) { ... }
    });
}

function increment(gallery, nextIndex) {
	var u = gallery.data[nextIndex].slideUrl;
	var gal = u.substring(1, u.lastIndexOf('/'));
	var photo = u.substring(u.lastIndexOf('/') + 1);
	var request = $.ajax({
		url: '/photos/increment',
		type: "post",
		data: {'photo': photo, 'gallery': gal}
	});
}