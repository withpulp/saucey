AdScript.define('main', [
    "dom/primitives/Elem",
	"dom/video/Video",
	"dom/shapes/DomSprite",
	"dom/expand/Wallpaper",
	"gen/utils/LocalStoreUtil",
	"canvas/shapes/Rectangle",
	"canvas/utils/Detector",
	"canvas/sprites/Sprite",
	"gen/utils/BrowserDetector",
	"gen/core/AdController"
], function(Elem, Video, DomSprite, Wallpaper, LocalStoreUtil, Rectangle, Detector, Sprite, BrowserDetector, AdController) {
    var ad = new AdController();
    var stage = ad.stage;
    var preloads = {
        media: [], // 'img/image_name.png'
        fonts: [] // { name: 'Pacifico', css: 'http://fonts.googleapis.com/css?family=Pacifico', fontLoadTimeout: 9000 } 
    };
    var customKeys = ad.tag.custom; // The customKeys object allows you to reference your configured custom key-value pairs.

    ad.begin(preloads, function() {
        // ***** BEGIN AD CODE ******

		//ADSCRIPT_SHAPES_START
		//ADSCRIPT_SHAPES_END
		var divIdThatMayChangeSomeday = 'div-id-for-top-728x90';
		var r29Container = document.getElementById(divIdThatMayChangeSomeday);
		if (r29Container) {
			r29Container.style.padding = '0px';
		}
		
		var isExpanded = false;
		var isPlaying = false;
		var canClick = true;
		var autoCloseInterval;
		var isMobile = BrowserDetector.isMobile();
		var clickURL = customKeys.clickTag;
		var userInteract = false;
		var finish_animate = true;
		var vidLeft = 276;
		var vidTop = 170;
		var videoW = 557;
		var videoH = 312;
		var video;
		var videoName = 'video';
		var tempAlpha = 0;
		var soundOn = false;
		
		var wp;
		
		var collapsedBG = new Sprite({
		    path : 'img/c_bg.jpg',
		    alpha : 0,
		    onClick : function() {
		        expand();
		    }
		});
		var openBtn = new Sprite({
			registration : 'top right',
			path : 'img/open.png',
			x : '100%',
		    y : 0
		});
		var expandedBG = new Sprite({
			path : 'img/e_bg.jpg',
			display : false,
			y : 0,
			onLoaded : function() {
			    init();
			},
			onClick : function() {
				ad.metricsDispatcher.sendExit({
					key : 'main',
					url : clickURL
				});
				collapse('auto');
			}
		});
		
		var hitArea = new Rectangle({
		    width: '100%',
		    height: '100%',
		    onClick: function(evt) {
		        userInteract = true;
		        if (isExpanded) {
		            ad.metricsDispatcher.sendExit({
		                key: 'main',
		                url: clickURL
		            });
		            collapse('auto');
		        } else {
		            expand();
		        }
		    }
		});
		
		var playPause = new Elem({
		    type : 'div',
		    insert : 'above',
		    x : vidLeft + videoW  - 30,
			y : vidTop + videoH - 32,
			css : {
			    zIndex : 1
			},
		onClick : function() {
		    console.log('playpause clicked');
		    if (canClick) {
		        togglePlay();
		        canClick = false;
		    }
		    
		    setTimeout(function(){
		        canClick = true;
		    }, 1000);
		    
		}
		});
		playPause.hide();
		
		var play = new DomSprite({
			path : 'img/play.png',
			insert : {
			    type : 'child',
			    target : playPause.el
			}
		});
		
		var pause = new DomSprite({
			path : 'img/pause.png',
			insert : {
			    type : 'child',
			    target : playPause.el
			}
		});
		
		var tablet_display = true;
		if (isMobile) {
		    tablet_display = false;
		}
		
		var muteBtn = new DomSprite({
			path: 'img/mute.png',
			//registration : 'center',
			x : vidLeft + videoW  - 70,
			y : vidTop + videoH - 36,
			insert : 'above',
			css : {
			    zIndex : 1
			},
			onClick : function() {
			    toggleMute('mute');
			}
		});
		
		var unMuteBtn = new DomSprite({
			path: 'img/unmute.png',
			//registration: 'center',
			x : vidLeft + videoW  - 70,
			y : vidTop + videoH - 36,
			insert : 'above',
			css : {
			    zIndex : 1
			},
			onClick : function() {
			    toggleMute('unmute');
			}
		});
		
		var closeBtn = new Sprite({
			registration : 'top right',
			path : 'img/close.png',
			x : '100%',
		    y : 0,
			onClick : function() {
				collapse();
			},
			display : false
		});
		
		var togglePlay = function(str) {
		    if (play.display) {
				play.hide();
				pause.show();
				video.play();
			}else{
				play.show();
				pause.hide();
				video.pause();
			}
			
			userInteract = true;
			clearInterval(autoCloseInterval);
		}
		
		var toggleMute = function(str) {
		    if (str === 'mute') {
				soundOn = false;
				muteBtn.hide();
				unMuteBtn.show();
				video.mute();
			}else{
				soundOn = true;
				muteBtn.show();
				unMuteBtn.hide();
				video.unmute();
			}
			
			userInteract = true;
			clearInterval(autoCloseInterval);
		}
		
		var createVideo = function(mod) {
		    if(!video){
				video = new Video({
					stage: stage,
					name: videoName,
					coverImage: 'img/poster.jpg',
					path: ['vid/'+ videoName +'.mp4', 'vid/' + videoName + '.webm'],
					insert: 'above',
					controls : false,
					x : vidLeft,
					y : vidTop,
					width: videoW,
					height: videoH,
					onLoaded: function() {
						if (!isMobile) {
							video.play('auto');
							if (!soundOn) {
								video.mute('auto');
							}
						}
					},
					onPlay: function() {
					    setTimeout(function(){
					        isPlaying = true;
					    }, 1000);
						playPause.show();
					    play.hide();
						pause.show();
						if (isMobile) {
							clearInterval(autoCloseInterval);
						}
					},
					onEnded : function() {
					    isPlaying = false;
						if(!userInteract){
						    setTimeout(function(){
						        collapse('auto')
						    }, 500);
						}
					},
					onClick : function() {
					    if (isPlaying) {
					        ad.metricsDispatcher.sendExit({
		                        key: 'main',
		                        url: clickURL
		                    });
		                    collapse('auto');
					    }
					}
				});
				coverImage = video.player.coverImage;
				coverImage.set({
				    css : {
				        zIndex : 2
				    }
				});
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
				height: (str == 'c_wallpaper') ? 705 : 600,
				onClick: function() {
					userInteract = true;
					ad.metricsDispatcher.sendExit({
						key: 'main',
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
			    display : true,
			    alpha : 0
			});
			expandedBG.tween({
			    alpha : 1,
			    duration : 300,
			    onComplete : function() {
			        closeBtn.set({
		        		display : true
		        	});
		        	createVideo();
			    }
			});
			collapsedBG.tween({
			    alpha : 0,
			    duration : 300,
			    onComplete : function() {
			        collapsedBG.set({
			            display : false
			        });
			    }
			});
		    
			if(soundOn){
				if(video) {
				    video.unmute('auto');
				}
				
				if (tablet_display) {
				    muteBtn.show();
				}else{
				    muteBtn.hide();
				}
				unMuteBtn.hide();
			}else{
				if(video){
				    video.mute('auto');
				}
			    muteBtn.hide();
			    if (tablet_display) {
			        unMuteBtn.show();
			    }else{
			        unMuteBtn.hide();
			    }
			}
			
		}
		
		var collapse = function(mod) {
			isExpanded = false;
			isPlaying = false;
			
			if (mod) {
			    ad.collapse({interact : false});
			}else{
				ad.collapse();
			}
			
			clearInterval(autoCloseInterval);
			
		    if(!isMobile){
			    if(wp){
			        wp.remove();
			    }
			    createWallpaper('c_wallpaper');
		    }
		    
			expandedBG.tween({
				alpha : 0,
				duration : 300,
				onComplete : function() {
				    expandedBG.set({
				        display : false
				    });
				}
			});
			collapsedBG.set({
				display : true,
				alpha : 0
			});
			collapsedBG.tween({
			    alpha : 1,
			    duration : 300
			});
			closeBtn.set({
				display : false
			});
			
			if (video) {
			    video.remove();
		    	video = undefined;
			}
		}
		
		var init = function() {
		    var cookie ='banana_republic_r29_newbr1';// + Math.round(Math.random()*100000);
		
			if (!LocalStoreUtil.getItem(cookie)){
				LocalStoreUtil.setItem(cookie, 1, 1);
				soundOn = false;
				expand('auto');
				autoCloseInterval = setInterval(function() {
				    collapse('auto');
				}, 15000);
			}else{
			    if(!isMobile){
		            createWallpaper('c_wallpaper');
			    }
				soundOn = true;
				collapsedBG.set({
					display : true,
					alpha : 0
				});
				collapsedBG.tween({
				    alpha : 1,
				    duration : 300
				});
			}
		};
		
		

        // ***** END AD CODE *****
    });
});