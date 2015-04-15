AdScript.define('ThumbGallery', [
    'canvas/shapes/Cluster',
	'canvas/shapes/Rectangle',
	'canvas/shapes/Polygon',
	'canvas/sprites/Sprite',
	'canvas/text/TextNode'
], function(Cluster, Rectangle, Polygon, Sprite, TextNode) {
    var ThumbGallery = function(options) {
        options = options || {};
        var self = this;

        var thumbH = options.thumbHeight || 20;
        var thumbW = options.thumbWidth || 20;

        var imgArr = options.images;

        var images = [];
        var thumbs = [];

		//----------------------------------------------------------------------
		//
		// PRIVATE METHODS
		//
		//----------------------------------------------------------------------
		
		var init = function(options) {
        	// inherit from 'super' class
            Cluster.call(self, options);
            addDisplayItems();
		}

		var addDisplayItems = function() {
			var spacer = (options.width - thumbW * imgArr.length) / (imgArr.length -1);
			var availH = options.height - thumbH - spacer;

			//Create thumbnails for each image
			for (var i=0; i<imgArr.length; i++) {
				var thumbMask = new Rectangle({
					width : thumbW,
					height : thumbH,
					fillStyle : 'red'
				});
				self.add(thumbMask);
				var thumb = new Sprite({
					path : imgArr[i],
					clipObjects : [thumbMask],
					onLoaded : function() {
						var scale = Math.max(thumbW / this.width, thumbH / this.height);
						this.set({
							scaleX : scale,
							scaleY : scale,
						});
						this.set({
							x : Math.round((thumbW - this.scaledWidth) / 2)
						});
					}
				});
				var thumbCluster = new Cluster({
					shapes : [thumb],
					alpha : i === 0 ? 1 : .5,
					data : {
						id : i
					},
					x : Math.round(i * (thumbW + spacer)),
					y : availH + spacer,
					onClick : function() {
						//Show the big image
						showImage(this.data.id);
					}
				});
				self.add(thumbCluster);
				thumbs.push(thumbCluster);

				var imageMask = new Rectangle({
					width : options.width,
					height : availH,
					fillStyle : 'red'
				});
				self.add(imageMask);

				//Create the big image
				var image = new Sprite({
					path : imgArr[i],
					clipObjects : [imageMask],
					onLoaded : function() {
						var imageScale = Math.max(options.width / this.width, availH / this.height);
						this.set({
							scaleX : imageScale,
							scaleY : imageScale,
						});
						this.set({
							x : Math.round((options.width - this.scaledWidth) / 2),
							y : Math.round((availH- this.scaledHeight) / 2)
						});
					}
				});
				var imageCluster = new Cluster({
					shapes : [image],
					alpha : i === 0 ? 1 : 0,
					data : {
						id : i
					}
				});
				self.add(imageCluster);
				images.push(imageCluster);
			}

		}

		var showImage = function(id) {
			var dur = 500;
			var easing = 'easeInOutQuad';

			for (var i=0; i<images.length; i++) {
				if (i === id) {
					images[i].tween({
						alpha : 1,
						duration : dur,
						easing : easing
					});
					thumbs[i].tween({
						alpha : 1,
						duration : dur,
						easing : easing
					});
				}else{
					images[i].tween({
						alpha : 0,
						duration : dur,
						easing : easing
					});
					thumbs[i].tween({
						alpha : .5,
						duration : dur,
						easing : easing
					});
				}
			}
		}

		//----------------------------------------------------------------------
		//
		// PUBLIC METHODS
		//
		//----------------------------------------------------------------------


		init(options);
    };

    return ThumbGallery;

});
