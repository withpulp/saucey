//ADSCRIPT_SHAPES_START
var background = new Rectangle({
	height : "100%",
	width : "100%",
	fillStyle : "#fff",
	onClick : function() {
	    ad.metricsDispatcher.sendExit({
	        key : 'main',
	        url : 'http://ad.doubleclick.net/ddm/clk/289337367;115705614;n'
	    });
	}
});
var headerBG = new Rectangle({
	height : 105,
	width : "100%",
	fillStyle : "#6bda99"
});
var headerLogos = new Sprite({
	path : "img/header_logos.png"
});
var obsessions = new Sprite({
	x : 70,
	y : 120,
	path : "img/r29_obsessions.png"
});
var productGrid = new Cluster({
    y : 150,
    shapes : []
});

var stroke = new Rectangle({
	width : "100%",
	height : "100%",
	strokeStyle : "black",
	fillStyle : "rgba(0,0,0,0)",
	lineWidth : 2
});
//ADSCRIPT_SHAPES_END
var isMobile = BrowserDetector.isMobile();
var imageWidth = 150;
var imageHeight = 150;
var columns = 2;
var imageArr = [];

var products = [
    {key : 'sunglasses', url : 'http://bananarepublic.gap.com/browse/category.do?cid=38536&departmentRedirect=true#department=136'},
    {key : 'jacket', url : 'http://ad.doubleclick.net/ddm/clk/289533949;115705614;r'},
    {key : 'chino', url : 'http://ad.doubleclick.net/ddm/clk/289534522;115705614;f'},
    {key : 'booties', url : 'http://ad.doubleclick.net/ddm/clk/289538432;115705614;j'},
    {key : 'dress', url : 'http://ad.doubleclick.net/ddm/clk/289533958;115705614;r'},
    {key : 'vest', url : 'http://ad.doubleclick.net/ddm/clk/289542317;115705614;g'},
];

var hideOverlays = function(img) {
    for (var i=0; i < imageArr.length; i++) {
        if (imageArr[i] !== img) {
            imageArr[i].hideOverlay();
        }
    }
}

var init = function() {
    var row = 0;
    var column = 0;
    
    for (var i=0; i<products.length; i++) {
        column = i % columns;
        var img = new RollImage({
            product : products[i],
            width : imageWidth,
            height : imageHeight,
            x : column * imageWidth,
            y : row * imageHeight,
            onTriggerOver : function() {
                hideOverlays(this);
                this.showOverlay();
                ad.metricsDispatcher.sendCounter({
                    key : 'hover.' + this.key
                });
            },
            onTriggerOut : function() {
                this.hideOverlay();
            },
            onClick : function() {
                console.log(this.detailShown);
                if (isMobile){ //On tablet, first click shows detail, second exits
                    if (this.detailShown) { //If the detail is already shown
                        ad.metricsDispatcher.sendExit({
                            key : 'exit.' + this.key,
                            url : this.url
                        });
                        hideOverlays();
                    }else{
                        hideOverlays(this);
                        this.showOverlay();
                        ad.metricsDispatcher.sendCounter({
                            key : 'hover.' + this.key
                        });
                    }
                }else{ //On desktop, click through
                    ad.metricsDispatcher.sendExit({
                        key : 'exit.' + this.key,
                        url : this.url
                    });
                    hideOverlays();
                }
            }
        });
        productGrid.add(img);
        imageArr.push(img);
        
        if (column === columns - 1) {
            row++;
        }
    }
}

init();