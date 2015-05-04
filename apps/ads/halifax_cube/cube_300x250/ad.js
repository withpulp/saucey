var clickURL = 'http://www.halifax.co.uk/';

//ADSCRIPT_SHAPES_START

//-------PANEL 1------//
var background1 = new Rectangle({
	x : "0%",
	y : "0%",
	height : "100%",
	width : "100%",
	fillStyle : "#f0f5f7",
	onClick : function() {
	    if (!cube.isDragging) {
	        ad.metricsDispatcher.sendExit({
                key : 'background1',
                url : clickURL
            });
	    }
	}
});
var bottom1 = new Sprite({
    path : 'img/bottom.jpg',
    width : 300,
    height : 59,
    registration : 'bottom left',
    y : '100%'
});
var logo1 = new Sprite({
    path : 'img/logo.png',
    width : 58,
    height : 30,
    x : 6,
    y : 6
});
var copy1_1 = new TextNode({
    registration : 'top',
    x : '50%',
    y : 45,
    maxWidth : 230,
    textAlign : 'center',
    text : '£500 ON US TO MAKE YOUR MOVE EASIER.',
    fontFamily : 'Helvetica, Arial',
    fontStyle : 'bold',
    fillStyle : '#15569c',
    fontSize : 18
});
var copy1_2 = new TextNode({
    registration : 'top',
    x : '50%',
    y : 100,
    maxWidth : 240,
    textAlign : 'center',
    fillStyle : '#999999',
    text : 'For home movers and first time buyers who take out a qualifying mortgage between 9th March and 3rd May 2015. £500 is paid through your conveyancer on completion. Exclusions apply.'
});
var stroke1 = new Rectangle({
    width : '100%',
    height : '100%',
    strokeStyle : '#b5cad3',
    lineWidth : 2
});

//---------------PANEL 2---------------//
var background2 = new Rectangle({
	x : "0%",
	y : "0%",
	height : "100%",
	width : "100%",
	fillStyle : "#f0f5f7",
	onClick : function() {
	    if (!cube.isDragging) {
	        ad.metricsDispatcher.sendExit({
                key : 'background2',
                url : clickURL
            });
	    }
	}
});
var bottom2 = new Sprite({
    path : 'img/bottom2.jpg',
    width : 300,
    height : 61,
    registration : 'bottom left',
    y : '100%'
});
var logo2 = new Sprite({
    path : 'img/logo.png',
    width : 58,
    height : 30,
    x : 6,
    y : 6
});

var stroke2 = new Rectangle({
    width : '100%',
    height : '100%',
    strokeStyle : '#b5cad3',
    lineWidth : 2
});

//---------------PANEL 3------------------//
var background3 = new Rectangle({
	x : "0%",
	y : "0%",
	height : "100%",
	width : "100%",
	fillStyle : "#f0f5f7",
	onClick : function() {
	    if (!cube.isDragging) {
	        ad.metricsDispatcher.sendExit({
                key : 'background3',
                url : clickURL
            });
	    }
	}
});
var bottom3 = new Sprite({
    path : 'img/bottom3.jpg',
    width : 300,
    height : 59,
    registration : 'bottom left',
    y : '100%'
});
var copy3_1 = new TextNode({
    registration : 'top',
    x : '50%',
    y : 190,
    maxWidth : 280,
    textAlign : 'center',
    text : 'HALIFAX\nThe people who give you extra',
    fontFamily : 'Helvetica, Arial',
    fontStyle : 'bold',
    fillStyle : '#15569c',
    fontSize : 18
});
var logo3 = new Sprite({
    path : 'img/logo.png',
    width : 58,
    height : 30,
    x : 6,
    y : 6
});
var stroke3 = new Rectangle({
    width : '100%',
    height : '100%',
    strokeStyle : '#b5cad3',
    lineWidth : 2
});

//---------------PANEL 4------------------//
var background4 = new Sprite({
	path : 'img/halifax.jpg',
	onClick : function() {
	    if (!cube.isDragging) {
	        ad.metricsDispatcher.sendExit({
                key : 'background4',
                url : clickURL
            });
	    }
	}
});

//ADSCRIPT_SHAPES_END
stage.container.el.style.textAlign = 'left';

//Set up videos
var videos = [];

//Video size and positioning
var origW = 640; //Original width of video
var origH = 360; //Original height of video
var videoW = 222;
var videoH = Math.round((videoW / origW) * origH);
var vidLeft = 39;
var vidTop = 60;

var video1 = new Video({
    name: 'video_1',
    path: ['vid/video1.mp4', 'vid/video1.webm'],
    insert: 'above',
    controls: true,
    width: videoW,
    height: videoH,
    x : 300,
    y : 250,
});
video1.hide();
videos.push(video1);

//Video thumbnail that will be attached to the panel. When clicked, the video will be shown.
var canvasVideo1 = new Sprite({
    path : 'img/poster1.jpg',
    width : videoW,
    height : videoH,
    x : vidLeft,
    y : vidTop,
    onClick : function() {
        showVideo(video1);
        video1.play();
    }
});

var video2 = new Video({
    name: 'video_2',
    path: ['vid/video2.mp4', 'vid/video2.webm'],
    insert: 'above',
    controls: true,
    width: videoW,
    height: videoH,
    x : 300,
    y : 250,
});
video2.hide();
videos.push(video2);

//Video thumbnail that will be attached to the panel. When clicked, the video will be shown.
var canvasVideo2 = new Sprite({
    path : 'img/poster2.jpg',
    width : videoW,
    height : videoH,
    x : vidLeft,
    y : vidTop,
    onClick : function() {
        showVideo(video2);
        video2.play();
    }
});

var cube = new XaxisCube({
    ad : ad,
    panels : [
        [background1, bottom1, logo1, copy1_1, copy1_2, stroke1],
        [background2, bottom2, canvasVideo1, logo2, stroke2],
        [background3, bottom3, logo3, canvasVideo2, copy3_1, stroke3],
        [background4]
    ],
    menu : {
        //backgroundColor : 'white',
        //fontColor : '#666666',
        //highlightColor : 'black',
        //fontFamily : 'Arial',
        //fontStyle : 'bold',
        //fontSize : 16,
        textAlign : 'right',
        //display : true
    },
    panelLabels : ['Panel One', 'Panel Two', 'Panel Three', 'Panel Four'],
    rightArrow : {
        path : 'img/arrow_right.png',
        width : 30,
        height : 20
    },
    leftArrow : {
        path : 'img/arrow_left.png',
        width : 30,
        height : 20
    },
    menuButton : {
        path : 'img/menuBtn.png',
        width : 30,
        height : 30
    },
    menuClose : {
        path : 'img/menu_close.png',
        width : 62,
        height : 20
    },
    autoRotate : true,
    onMenuInteract : function(evt) {
        console.log(evt);
        //evt.state
        checkVideos();
    },
    onDrag : function(evt) {
        console.log(evt);
        //evt.rotation
        checkVideos();
    },
    onNavigate : function(evt) {
        checkVideos();
        console.log(evt);
    }
});

var checkVideos = function() {
    for (var i=0; i<videos.length; i++) {
        if (videos[i].display) {
            hideVideo(videos[i]);
        }
    }
}

var hideVideo = function(video) {
    video.set({
        y : 250
    });
    video.hide();
    video.pause('auto');
}

var showVideo = function(video) {
    video.set({
        x : vidLeft,
        y : vidTop
    });
    video.show();
}