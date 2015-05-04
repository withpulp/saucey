//ADSCRIPT_SHAPES_START
//ADSCRIPT_SHAPES_END


var videoName = 'video';
stage.container.el.parentNode.style.margin = 'auto';
stage.canvas.set({
    css: {
        position: 'relative'
    }
});

var isExpanded = false;
var autoCloseInterval;
var isMobile = BrowserDetector.isMobile();
var clickURL = customKeys.clickTag || 'http://ad.doubleclick.net/ddm/clk/288255429;115107671;j';
var userInteract = false;
var finish_animate = true;
var vidLeft = 681;
var vidTop = 130;
var videoW = 626;
var videoH = 354;
var video;
var tempAlpha = 0;
var soundOn = false;

var divIdThatMayChangeSomeday = 'div-id-for-top-728x90';
var r29Container = document.getElementById(divIdThatMayChangeSomeday);x
if (r29Container) {
	r29Container.style.padding = '0px';
}

var wp;

var collapsedBG = new Sprite({
    stage : stage,
    path : 'img/c_bg.jpg',
    // display : false,
    onClick : function() {
        expand();
    }
});


var expandedBG = new Sprite({
	stage : stage,
	path : 'img/e_bg.png',
	display : false,
	y : 0,
	onClick : function() {
		ad.metricsDispatcher.sendExit({
			key : 'Main',
			url : clickURL
		});
		collapse('auto');
	}
});

var hitArea = new Rectangle({
    stage: stage,
    width: '100%',
    height: '100%',
    onClick: function(evt) {
        userInteract = true;
        if (isExpanded) {
            ad.metricsDispatcher.sendExit({
                key: 'Main',
                url: clickURL
            });
            collapse('auto');
        } else {
            expand();
        }
    }
});

var play = new Sprite({
	path : 'img/play.png',
	registration : 'center',
	display : false,
	stage : stage,
});
var pause = new Sprite({
	path : 'img/pause.png',
	registration : 'center',
	display : false,
	stage : stage,
});
var playHit = new Rectangle({
	stage : stage,
	fillStyle : '#ff0000',
	alpha : 0,
	width : 30,
	height : 30,
	registration : 'center',
});
var playPause = new Cluster({
	shapes : [play, pause, playHit],
	x : vidLeft + videoW  - 30,
	y : vidTop + videoH - 30,
	stage : stage,
	onClick : function() {
		if (play.display) {
			play.set({
				display : false
			});
			pause.set({
				display : true
			});
			video.play();
		}else{
			play.set({
				display : true
			});
			pause.set({
				display : false
			});
			video.pause();
		}
		
		userInteract = true;
		clearInterval(autoCloseInterval);
	}
});

var tablet_display = true;
if (isMobile) tablet_display = false;

var muteBtn = new Sprite({
	stage: stage,
	path: 'img/mute.png',
	registration : 'center',
	display : false,
});

var unMuteBtn = new Sprite({
	stage: stage,
	path: 'img/unmute.png',
	registration: 'center',
	display: false
});
var muteHit = new Rectangle({
	stage : stage,
	fillStyle : '#ffff00',
	alpha : 0,
	width : 30,
	height : 30,
	registration : 'center',
});

var muteUnmute = new Cluster({
	stage : stage,
	shapes : [muteBtn, unMuteBtn, muteHit],
	x : vidLeft + videoW  - 60,
	y : vidTop + videoH - 30,
	display : false,
	onClick : function() {
		if (muteBtn.display) {
			soundOn = false;
			muteBtn.set({
				display : false
			});
			unMuteBtn.set({
				display : true
			});
			video.mute();
		}else{
			console.log(' unmute now1')
			soundOn = true;
			muteBtn.set({
				display : true
			});
			unMuteBtn.set({
				display : false
			});
		//replaySound.set({display : false});
			video.unmute();
		}
		
		userInteract = true;
		clearInterval(autoCloseInterval);
	}
});

var closeBtn = new Rectangle({
	stage : stage,
	registration : 'top right',
	fillStyle : '#ff0',
	width : 100,
	height : 80,
	x : '100%',
	alpha: tempAlpha,
	onClick : function() {
		collapse();
	},
	display : false
});

var createVideo = function() {
	if(!video){
		video = new Video({
			stage: stage,
			name: 'main_video',
			coverImage: 'img/' + 'poster' +'.jpg',
			path: ['vid/'+ videoName +'.mp4', 'vid/' + videoName + '.webm'],
			insert: 'below',
			controls : false,
			css: {
				position: 'absolute',
				left : vidLeft + 'px',
				top : vidTop + 'px',
				width: videoW + 'px',
				height: videoH + 'px'
			},
			onLoaded: function() {
				if (!isMobile) {
					video.play('auto');
					if (!soundOn) {
						video.mute('auto');
					}
				}
			},
			onPlay: function() {
				play.set({
					display : false
				});
				pause.set({
					display : true
				});
				playPause.set({
					display : true
				});
				if (isMobile) {
					clearInterval(autoCloseInterval);
				}
			},
			onEnded : function() {
				if(!userInteract){
				autoCloseInterval = setInterval(function(){collapse('auto')}, 500);
				}
				
			}
		});
		coverImage = video.player.coverImage;
         if(coverImage){
            console.log('-------coverimage here')
            coverImage.el.style.left = vidLeft + 'px';
            coverImage.el.style.top = vidTop + 'px'
            coverImage.el.width = videoW;
            coverImage.el.height = videoH;
         }
	}

	
}

var createWallpaper = function(str){
	wp = new Wallpaper({
		stage: stage,
		overContent: true,
		color: '#ffffff',
		path: 'img/' + str + '.jpg',
		fixed: false,
		repeatY: false,
		siteWidth: 1288,
		height: (str == 'c_wallpaper') ? 705 : 739,
		onClick: function() {
			userInteract = true;
			ad.metricsDispatcher.sendExit({
				key: 'Main',
				url: clickURL
			});
			if (isExpanded) {
				collapse('auto');
			}
		}
	});
	 

}


var expand = function(mod) {
	isExpanded = true;
	
	if (mod) {
	ad.expand({interact:false});
	}else{
		ad.expand();
		if(wp)wp.remove();
	}
	
	if(!isMobile){
	    createWallpaper('e_wallpaper');   
	}
	
	expandedBG.set({
		display : true
	});
	collapsedBG.set({
		display : false
	});
	closeBtn.set({
		display : true
	});
	if(!isMobile){
	    muteUnmute.set({display : true});
	}
    
    
	if(soundOn){
		if(video)video.unmute();
		muteBtn.set({display : tablet_display});
	    unMuteBtn.set({display : false});
	}else{
		if(video)video.mute();
	    muteBtn.set({display : false});
	    unMuteBtn.set({display : tablet_display});
	}
	createVideo();
// 	video.mute('auto');
}

var collapse = function(mod) {
	isExpanded = false;
	
	if (mod) {
	ad.collapse({interact : false});
	}else{
		ad.collapse();
	}
	
	clearInterval(autoCloseInterval);
	
    if(!isMobile){
	    if(wp)wp.remove();
	    createWallpaper('c_wallpaper');
    }
    
	expandedBG.set({
		display : false
	});
	collapsedBG.set({
		display : true
	});
	
	closeBtn.set({
		display : false
	});
	
	video.remove();
	video = undefined;
	
	playPause.set({
		display : false
	});
	muteUnmute.set({
		display : false
	});
}

var init = function() {
    var cookie ='Gap_SpringisWeird_2015_Marquee_cookie_v3_test6';

	if (!LocalStoreUtil.getItem(cookie)){
		LocalStoreUtil.setItem(cookie, 1, 1);
		soundOn = false;
		expand('auto');
// 		autoCloseInterval = setInterval(function(){
// 			collapse('auto');
// 		}, 15000);
	}else{
	    if(!isMobile){
            createWallpaper('c_wallpaper');
	    }
		soundOn = true;
		collapsedBG.set({
			display : true
		});
	}
};

init();

