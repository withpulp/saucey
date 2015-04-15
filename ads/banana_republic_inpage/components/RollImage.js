AdScript.define('RollImage', [
    'canvas/shapes/Rectangle',
    'canvas/shapes/Cluster',
    'canvas/sprites/Sprite'
], function(Rectangle, Cluster, Sprite) {
    var RollImage = function(options) {
        options = options || {};
        var self = this;

        var imageWidth = options.width || 150;
        var imageHeight = options.height || 150;
        
        var productName = options.product.key;
        var url = options.product.url;
        
        var image;
        var overlay;
        
        self.detailShown = false;
        self.key = productName;
        self.url = url;
        
        var init = function(options) {
        	// inherit from 'super' class
            Cluster.call(self, options);
            addDisplayItems();
		}
		
		var addDisplayItems = function() {
		    image = new Sprite({
		        path : 'img/' + productName + '.jpg'
		    });
		    self.add(image);
		    
		    overlay = new Sprite({
		        path : 'img/' + productName + '.png',
		        alpha : 0
		    });
		    self.add(overlay);
		    
		    var stroke = new Rectangle({
		        width : imageWidth,
		        height : imageHeight,
		        strokeStyle : '#d4d4d4',
		        lineWidth : 1
		    });
		    self.add(stroke);
		}
		
		self.showOverlay = function() {
		    self.detailShown = true;
		    
		    overlay.tween({
		        alpha : 1,
		        duration : 300,
		        easing : 'easeInOutQuad'
		    });
		}
		
		self.hideOverlay = function() {
		    self.detailShown = false;
		    
		    overlay.tween({
		        alpha : 0,
		        duration : 300,
		        easing : 'easeInOutQuad'
		    });
		}
		
		init(options);
    };

    return RollImage;

});
