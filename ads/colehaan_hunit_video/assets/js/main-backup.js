require(['gen/core/AdController',
        'canvas/shapes/Rectangle',
        'canvas/sprites/Sprite',
        'canvas/shapes/Cluster',
        'canvas/text/TextNode',
        'gen/utils/BrowserDetector',
        'dom/video/Video',
        'gen/utils/LocalStoreUtil',
        'assets/js/Wallpaper'
    ],

    function(AdController, Rectangle, Sprite, Cluster, TextNode, BrowserDetector,Video, LocalStoreUtil, Wallpaper) {

        var preloads = {
            fonts: [{
                name: 'Josefin Sans',
                css: 'http://fonts.googleapis.com/css?family=Josefin+Sans:300'
            }, ],
            media: [],
        };

        var config = {

            preloads: preloads,

            dimensions: {
                expanded: {
                    width: '1290px',
                    height: '600px',//705
                },
                collapsed: {
                    width: '1290',
                    height: '195px',
                },
                pushDown: true,
                animate: true
            },
            metrics: {
                enabled: true
            }
        };

        var master = new AdController(config);
        var stage = master.stage;

        master.begin(function() {

            stage.container.el.parentNode.style.margin = 'auto';

            var isExpanded = false;
            var isMobile =  BrowserDetector.isMobile();
            var config = {
                adName : 'home',
                exitKey : 'exit_main',
                clickURL : 'http://ad.doubleclick.net/ddm/clk/283923081;110719632;b'
            }
            
           
            // 'http://ad.doubleclick.net/ddm/clk/283923081;110719262;a'
            // 'http://ad.doubleclick.net/ddm/clk/283923081;110719632;b'
            var autoCloseInterval;

        
            var userInteract = false;
            var wp;
           
            var divIdThatMayChangeSomeday = 'div-id-for-top-728x90';
            var r29Container = document.getElementById(divIdThatMayChangeSomeday);
            if (r29Container) {
               r29Container.style.padding = '0px';
            }

            var tempAlpha = 0;
            var createWallpaper = function(str){
                wp = new Wallpaper({
                    stage: stage,
                    overContent: true,
                    color: '#ffffff',
                    path: 'img/' + str + '.jpg',
                    fixed: false,
                    repeatY: false,
                    siteWidth: 1290,
                    onClick: function() {
                        userInteract = true;
                        if (isExpanded) {
                            collapse('auto');   
                        }
                        master.metricsDispatcher.sendExit({
                            key: config.exitKey,
                            url: config.clickURL
                        });
                    }
                });
            }



            var expand = function(mod) {
                isExpanded = true;
                c_bg.set({display : false});
                ctaClose.set({display : true});
                e_bg.set({display : true});
                if(!isMobile){
                    
                    if(wp){
                        wp.remove();
                        createWallpaper('e_wallpaper');
                    }
                }
                
                if (mod) {
                    master.expand({interact:false});
                }else{
                    master.expand();
                    if(wp){
                        wp.remove();
                    }
                }

                if(!isMobile){
                    createWallpaper('e_wallpaper')
                }
            }
            
            var collapse = function(mod) {

                isExpanded = false;
                c_bg.set({display : true});
                e_bg.set({display : false});
                ctaClose.set({display : false});
                if(!isMobile){
                    if(wp){
                        wp.remove();
                        createWallpaper('c_wallpaper');
                    }
                }
                if (mod) {
                    master.collapse({interact : false});
                }else{
                    master.collapse();
                }
         
                clearInterval(autoCloseInterval);
            }           

            var c_bg = new Sprite({
                stage: stage,
                path : 'img/c_bg.jpg',
                onClick : function(){
                    userInteract = true;
                    expand();
                }
            });


            var e_bg = new Sprite({
                stage: stage,
                path : 'img/e_bg.jpg',
                display : false,
                onClick:function(){
                    userInteract = true;
                    master.metricsDispatcher.sendExit({
                        key: config.exitKey,
                        url: config.clickURL
                    });
                    collapse('auto');
                }
            });

            var ctaClose = new Rectangle({
                stage : stage,
                width : 100,
                height : 50,
                registration : 'top right',
                x : '100%',
                y : 0,
                fillStyle : '#f00',
                alpha : 0,
                display : false,
                onClick:function(){
                     userInteract = true;
                     collapse();
                }
            })
         
            var init = function() {
                
                var rand = 1000;
                var hCookie = 'colehaan_sep_hunit_cookie_' + config.adName + rand;
                stage.canvas.canvas.set({css:{
                    position : 'relative'
                }});

                if (!LocalStoreUtil.getItem(hCookie)){
                    LocalStoreUtil.setItem(hCookie, 1, 1);
                    expand('auto');
                    autoCloseInterval = setTimeout(function(){
                        collapse('auto');
                    },10000);
                }else{
                    if(wp){wp.remove();}
                    if(!isMobile){
                        createWallpaper('c_wallpaper');
                    }
                }
            }
            
            init();

        });
    });