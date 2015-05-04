/**
 * @class
 * @name dom.expand.Wallpaper
 * @description Functionality for a wallpaper for a site.
 * @example var wp = new Wallpaper({
 *     stage: stage,
 *     path: 'img/wallpaper1.jpg',
 *     color: '#000000',
 *     onClick: function(){
 *        console.log('Wallpaper clicked, should clickthrough!');
 *     },
 * });
 * @requires gen.utils.StringUtil
 * @requires gen.net.ImageLoader
 * @requires dom.primitives.BaseElem
 * @requires gen.utils.EventDispatcher
 * @requires dom.mixins.Environment
 * @requires canvas.responsive.RuleUtil
 * @requires dom.utils.Detector
 * @property {Object} stage - AdScript stage object. 
 * @property {Boolean} fixed - Is the Wallpaper fixed or is it possible to scroll past it? 
 * @property {Boolean} repeatX - Repeat the Wallpaper horizontally? 
 * @property {Boolean} repeatY - Repeat the Wallpaper vertiaclly? 
 * @property {String} color - Background color. 
 * @property {Boolean} clickable - Is the Wallpaper clickable? 
 * @property {Object} lSidebar - The left click area DOM element. 
 * @property {Object} rSidebar - The right click area DOM element. 
 * @property {Number} siteWidth - The width of the content area of the site. 
 * @param {Object} options
 * @public
 */
define([
    'gen/utils/StringUtil',
    'gen/net/ImageLoader',
    'dom/primitives/BaseElem',
    'gen/utils/EventDispatcher',
    'dom/mixins/Environment',
    'canvas/responsive/RuleUtil',
    'dom/utils/Detector'
    ], function(StringUtil, ImageLoader, BaseElem, EventDispatcher, EnvironmentMixin, RuleUtil, Detector){
    var Wallpaper = function(options){
        
        var self = this;

        // Original values of the body when the wallpaper is disabled.
        var disabledValues = {};

        // Values of the body and other elements when the wallpaper is enabled.
        var enabledValues = {};

        // Last known screen size.
        var lastScreenInfo;

        var init = function(){
            self.stage = options.stage;
            lastScreenInfo = null;

            self.fixed = options.fixed !== undefined ? options.fixed : true;
            self.repeatX =  options.repeatX !== undefined ? options.repeatX : false;
            self.repeatY =  options.repeatY !== undefined ? options.repeatY : false;
            self.color = options.color || false;
            self.clickable = false;
            self.lSidebar = undefined;
            self.rSidebar = undefined;
            // Add autodetection of site width later
            self.siteWidth = options.siteWidth || 0;
            self.overContent = options.overContent || false;

            if (options.path) {
                RuleUtil.constructRules(self, options);
                RuleUtil.applyRules(self.stage.container, self.rules, options);

                ImageLoader.load(options, onload);
            }
            else {
                onload({});
            }
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#addValue
         * @description 
         * @param name
         * @param value
         * @param style
         * @private
         */
        var addValue = function(name, value, style){
            enabledValues[name] = value;
            disabledValues[name] = style[name];
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#setStaticBackground
         * @description 
         * @private
         */
        var setStaticBackground = function(){
            var computedStyle = window.getComputedStyle(document.body);

            if (self.color) {
                addValue('backgroundColor', self.color, computedStyle);
            }
            
            if (self.path) {
                addValue('backgroundPosition', '50% 0%', computedStyle);
                addValue('backgroundImage', 'url(' + self.path + ')', computedStyle);

                if (self.fixed) {
                    addValue('backgroundAttachment', 'fixed', computedStyle);
                }

                var repeatStr = '';
                repeatStr += self.repeatX ? 'repeat' : 'no-repeat';
                repeatStr += ' ';
                repeatStr += self.repeatY ? 'repeat' : 'no-repeat';

                addValue('backgroundRepeat', repeatStr, computedStyle);
            }
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#getClickAreaWidth
         * @description Returns the width of the click area.
         * @param {Number} screenWidth - Width of the current window. 
         * @param {Number} siteWidth - Width of the site's content area. 
         * @public
         * @return  {Number}
         */
        this.getClickAreaWidth = function(screenWidth, siteWidth) {
            return (Math.max((screenWidth - siteWidth) / 2, 0)) + 'px';
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#getSidebarOptions
         * @description 
         * @param target
         * @param width
         * @param height
         * @param onClick
         * @private
         * @return  
         */
        var getSidebarOptions = function(width, height, onClick) {
            var firstDomElem = document.body.childNodes[0];
            var insert = {
                target: self.overContent ? document.body : firstDomElem,
                type: self.overContent? 'child' : 'below',
            };

            var opts = {
                stage: self.stage,
                type: 'div',
                insert: insert,
                css: {
                    position: 'fixed',
                    top: '0px',
                    width: width,
                    height: height,
                },
                onClick: onClick ? onClick : null,
            };

            if (self.overContent) {
                opts.css.backgroundColor = enabledValues.backgroundColor;
                opts.css.backgroundRepeat = enabledValues.backgroundRepeat;
                opts.css.backgroundImage = enabledValues.backgroundImage;
            }

            return opts;
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#createSidebars
         * @description 
         * @private
         */
        var createSidebars = function() {
            lastScreenInfo = EnvironmentMixin.getScreenInfo();
            var width = self.getClickAreaWidth(lastScreenInfo.width, self.siteWidth);

            //self.lSidebar = new BaseElem(getSidebarOptions(width, lastScreenInfo.height + 'px', options.onClick));
            self.lSidebar = new BaseElem(getSidebarOptions(width, 705 + 'px', options.onClick));
            self.lSidebar.el.style.left = '0px';
            //self.rSidebar = new BaseElem(getSidebarOptions(width, lastScreenInfo.height + 'px', options.onClick));
            self.rSidebar = new BaseElem(getSidebarOptions(width, 705 + 'px', options.onClick));
            self.rSidebar.el.style.right = '0px';

            EventDispatcher.dispatch(self.stage.container.el, 'ADD_WINDOWRESIZESUBSCRIBER', {
                notify: onWindowResize
            });

            if (self.overContent) {
                EventDispatcher.dispatch(self.stage.container.el, 'ADD_SCROLLSUBSCRIBER', {
                    notify: onScroll
                });

                var top = Detector.topZIndex();

                self.lSidebar.el.style.zIndex = top + 1000;
                self.rSidebar.el.style.zIndex = top + 1010;
            }

            resizeSidebars(lastScreenInfo);
        };

        var onWindowResize = function(screenInfo) {
            lastScreenInfo = screenInfo;
            resizeSidebars(screenInfo);
        };

        var onScroll = function(evt, x, y) {
            if (!self.fixed && self.img) {
                // Vertical position of background image is limited to page scroll height.
                // This stops the bouncy scroll on OSX and iOS from looking strange.
                var limitedToTop = Math.max(0, y);
                var maxScroll = EnvironmentMixin.getPageHeight() - lastScreenInfo.height;
                var limitedToBottom = Math.min(limitedToTop, maxScroll);
                var newY = -limitedToBottom;

                updateSidebarBackgroundPos(self.lSidebar, null, newY);
                updateSidebarBackgroundPos(self.rSidebar, null, newY);
            }
        };

        var updateSidebarBackgroundPos = function(sidebar, x, y) {
            sidebar.x = x !== null ? x : sidebar.x;
            sidebar.y = y !== null ? y: sidebar.y;
            //Added by JT
            sidebar.el.style.top = sidebar.y + 'px';
            sidebar.el.style.backgroundPosition = (sidebar.x ? sidebar.x + 'px ' : '0') + '0';
            //sidebar.el.style.backgroundPosition = (sidebar.x ? sidebar.x + 'px ' : '0 ') + (sidebar.y ? sidebar.y + 'px' : '0');
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#resizeClickArea
         * @description 
         * @param screenSize
         * @private
         */
        var resizeSidebars = function(screenSize) {
            var width = self.getClickAreaWidth(screenSize.width, self.siteWidth);
            var lpos = ((screenSize.width - (self.img ? self.img.width : 0)) / 2);
            
            self.lSidebar.set({
                css: {
                    width: width,
                    //height: screenSize.height + 'px',
                    height : 705
                }
            });

            self.rSidebar.set({
                css: {
                    width: width,
                    //height: screenSize.height + 'px',
                    height : 705
                }
            });

            if (self.img) {
                updateSidebarBackgroundPos(self.lSidebar, Math.ceil(lpos), null);    
                updateSidebarBackgroundPos(self.rSidebar, Math.floor(lpos) - parseInt(width, 10) - self.siteWidth, null);    
            }
            
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#onload
         * @description 
         * @param loadInfo
         * @private
         */
        var onload = function(loadInfo) {
            self.img = loadInfo.img;
            self.path = loadInfo.path;

            // Add canvas background later
            setStaticBackground();

            if (options.onClick || self.overContent) {
                if (options.onClick) {
                    self.clickable = true;
                }
                self.hasSidebars = true;
                createSidebars();
            }

            if (window.scrollY !== 0) {
                onScroll({}, window.scrollX, window.scrollY);
            }

            self.enable();

            if (options.onLoaded) {
                options.onLoaded.call(self);
            }
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#disable
         * @description Disable and
         * @public
         */
        this.disable = function(){
            self.enabled = false;
            for (var value in disabledValues) {
                document.body.style[value] = disabledValues[value];
            }

            if (self.lSidebar) {
                self.lSidebar.hide();
            }
            if (self.rSidebar) {
                self.rSidebar.hide();
            }
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#enable
         * @description 
         * @public
         */
        this.enable = function(){
            self.enabled = true;
            for (var value in enabledValues) {
                document.body.style[value] = enabledValues[value];
            }

            if (self.lSidebar) {
                self.lSidebar.show();
            }

            if (self.rSidebar) {
                self.rSidebar.show();
            }
        };

        /**
         * @function
         * @name dom.expand.Wallpaper#remove
         * @description 
         * @public
         */
        this.remove = function(){
            if (self.enabled) {
                self.disable();
            }

            if (self.lSidebar) {
                self.lSidebar.remove();
            }
            if (self.lSidebar) {
                self.rSidebar.remove();
            }
        };

        init();
    };

    return Wallpaper;
});