AdScript.define('XaxisCube', 
    ['canvas/shapes/Rectangle',
    'canvas/sprites/Sprite',
    'canvas/shapes/Cluster',
    'canvas/text/TextNode',
    'app/ui/Prism',
    'components/IE9Prism'], 
    function(Rectangle, Sprite, Cluster, TextNode, Prism, IE9Prism) {
    var XaxisCube = function(options) {
        var self = this;
        
        var ad = options.ad;
        var stage = ad.stage;

        var panels = options.panels !== undefined ? options.panels : [];
        var numPanels = options.panels !== undefined ? options.panels.length : 0;
        var panelLabels = options.panelLabels !== undefined ? options.panelLabels : [];
        var shouldAutoRotate = options.autoRotate !== undefined ? options.autoRotate : false;
        
        var menu = options.menu !== undefined ? options.menu : {};
        var showMenu = menu.display !== undefined ? menu.display : true;
        var menuColor = menu.backgroundColor !== undefined ? menu.backgroundColor : '#0cbee7';
        var fontColor = menu.fontColor !== undefined ? menu.fontColor : '#ffffff';
        var highlightColor = menu.highlightColor !== undefined ? menu.highlightColor : '#0d3247';
        var fontFamily = menu.fontFamily !== undefined ? menu.fontFamily : 'Arial, Helvetica';
        var fontStyle = menu.fontStyle !== undefined ? menu.fontStyle : 'bold';
        var fontSize = menu.fontSize !== undefined ? menu.fontSize : 15;
        var textAlign = menu.textAlign !== undefined ? menu.textAlign : 'left';
        
        var autoRotateInterval; //Interval to auto rotate the cube
        
        var isSupported = false;
        
        var currentPanel = 0;
        
        //For the dragger box
        var startX;
        var startRot = 0;
        var lastRot = 0;
        self.isDragging = false;
        
        // If we were inside an iframe but could not bust, the perspective
        // is set as flat so it doesnt look odd.
        var perspective = ad.tag.busterfail ? 'flat' : 'mild';
        
        //--------------------------------------------------------------
        //Navigation elements will only be visible on one panel at a time
        var navigation = new Cluster({
            shapes : []
        });
        var rightArrow;
        var leftArrow;
        var menuBtn;

        if (options.rightArrow) {
            rightArrow = new Sprite({
                path : options.rightArrow.path || options.rightArrow,
                width : options.rightArrow.width,
                height : options.rightArrow.height,
                registration : 'right',
                x : '100%',
                y : '50%',
                onClick : function() {
                    var newPanel = currentPanel + 1;
                    if (newPanel === numPanels) {
                        newPanel = 0;
                    }
                    animateToPanel(newPanel, 1, 'arrow');
                }
            });
            navigation.add(rightArrow);
        }
        if (options.leftArrow) {
            leftArrow = new Sprite({
                path : options.leftArrow.path || options.leftArrow,
                width : options.leftArrow.width,
                height : options.leftArrow.height,
                registration : 'left',
                y : '50%',
                onClick : function() {
                    var newPanel = currentPanel - 1;
                    if (newPanel === -1) {
                        newPanel = numPanels - 1;
                    }
                    animateToPanel(newPanel, -1, 'arrow');
                }
            });
            navigation.add(leftArrow);
        }
        
        //If menu == true and a menu button is provided, create the menu button
        if (showMenu && options.menuButton !== undefined) {
            menuBtn = new Sprite({
                path : options.menuButton.path || options.menuButton,
                width : options.menuButton.width,
                height : options.menuButton.height,
                registration : 'top right',
                x : '100%',
                percentageOffsetX : -6,
                y : 6,
                onClick : function() {
                    openMenu();
                }
            });
        }else if (showMenu) {
            //Draw the menu button
            var btnBG = new Rectangle({
                fillStyle : menuColor,
                width : 30,
                height : 30
            });
            var line1 = new Rectangle({
                fillStyle : fontColor,
                width : 18,
                height : 2,
                x : 6, 
                y : 8
            });
            var line2 = new Rectangle({
                fillStyle : fontColor,
                width : 18,
                height : 2,
                x : 6, 
                y : 14
            });
            var line3 = new Rectangle({
                fillStyle : fontColor,
                width : 18,
                height : 2,
                x : 6, 
                y : 20
            });
            menuBtn = new Cluster({
                shapes : [btnBG, line1, line2, line3],
                x : '100%',
                percentageOffsetX : -38,
                y : 8,
                onClick : function() {
                    openMenu();
                }
            });
        }else{
            menuBtn = new Rectangle({
                width : 1,
                height : 1,
                display : false
            });
        }

        navigation.add(menuBtn);
        
        //This can be created no matter what
        var menuBG = new Rectangle({
            width : '100%',
            height : '100%',
            fillStyle : menuColor,
            alpha : .95,
            onClick : function() {
                collapseMenu();
            }
        });

        //Create the close button
        var menuClose;

        //If this is not provided, make a default close button
        if (options.menuClose !== undefined) {
            menuClose = new Sprite({
                path : options.menuClose.path || options.menuClose,
                width : options.menuClose.width,
                height : options.menuClose.height,
                registration : 'top right',
                x : '100%',
                percentageOffsetX : -8,
                y : 8,
                onClick : function() {
                    collapseMenu();
                }
            });
        }else{
            menuClose = new TextNode({
                text : 'X',
                fontFamily : 'Arial',
                fontSize : 18,
                fillStyle : fontColor,
                registration : 'top right',
                x : '100%',
                percentageOffsetX : -8,
                onClick : function() {
                    collapseMenu();
                }
            });
        }
        
        var expandedMenu = new Cluster({
            shapes : [menuBG, menuClose],
            display : false
        });
        navigation.add(expandedMenu);

        for (var i=0; i < panels.length; i++) {

            if (panelLabels[i] === undefined) {
                panelLabels[i] = 'Panel ' + (i+1)
            }
            
            var tn = new TextNode({
                text : panelLabels[i],
                fillStyle : fontColor,
                fontFamily : fontFamily,
                fontStyle : fontStyle,
                fontSize : fontSize,
                x : 8,
                maxWidth : menuBG.width - 16,
                textAlign : textAlign,
                y : 40 + i * 30,
                data : {
                    id : i
                },
                onTriggerOver : function() {
                    this.set({
                        fillStyle : highlightColor
                    });
                },
                onTriggerOut : function() {
                    this.set({
                        fillStyle : fontColor
                    });
                },
                onClick : function() {
                    if (this.data.id != currentPanel) {
                        animateToPanel(this.data.id, 1, 'menu');
                    }
                    
                    expandedMenu.tween({
                        alpha : 0,
                        duration : 300,
                        onComplete : function() {
                            expandedMenu.set({
                                display : false
                            });
                        }
                    });
                    menuBtn.set({
                        display : true
                    });
                }
            });
            expandedMenu.add(tn);
        }
            
        //--------------------------------------------------------------
        

        //--------------------------------------------------------------
        // The draggable box to enable rotating of the prism on swipe.
        var dragger = new Rectangle({
                name: 'dragger',
                x: 0, y: 0,
                width: '100%', height: '100%',
                fillStyle: '#ff0000',
                alpha: 0,
                draggable: true,
                display : true,
                onStartDrag: function() {
                    self.isDragging = true;

                    start = 0;
                    startRot = lastRot;
                },
                onDrag: function() {
                    var diff = dragger.x - start;
                    lastRot = startRot - diff;
                    p.setRotation(lastRot);

                    if (options.onDrag) {
                        options.onDrag({
                            rotation : lastRot
                        });
                    }
                },
                onStopDrag: function() {
                    self.isDragging = false;

                    start = null;
                    this.set({
                        x: 0, y: 0,
                    });

                    // When we stop dragging, we animate to the closest
                    // panel with the shortest possible distance. Could also
                    // have some logic that has a shorted duration tween
                    // based on how far away the closest panel is.
                    var info = p.getClosestPanel();
                    animateToPanel(info.panel, info.diff > 0 ? 1 : -1, 'drag');
                }
            });
        //--------------------------------------------------------------
        
        // -----------------------------------
        // The actual prism configuration and initialization.
        var p = new Prism({
            stage: stage,
            perspective: perspective,
            perspectiveOffset : options.perspectiveOffset,
            //overflow : 'hidden',
            onSupported: function() {
                // Some prism enabling logic here!
                isSupported = true;
            },
            onNotSupported: function() {
                // Some fallback logic here!
                isSupported = false;
            },

            // Define the panels. Should be an array of arrays of shapes.
            // The number of arrays defines the number of panels in the prism.
            panels: panels
        });
        
        if (!isSupported) {
            p = new IE9Prism({
                ad : ad,
                panels : panels
            });
        }
        
        // -----------------------------------
        
        // -----------------------------------
        // Animating function that also activates a panel after animation.
        // Assumes that the prism has already been defined.
        var animateToPanel = function(num, dir, trig) {
            currentPanel = num % numPanels; //This ensures the panel does not try to animate to a panel that doesn't exist

            if (!p.animating) {
                p.animate({
                    easing: 'easeInOutQuad',
                    duration : 500,
                    id: currentPanel,
                    direction: dir,
                    onComplete: function() {
                        p.setActivePanel(currentPanel);
                        p.addToPanel(dragger, currentPanel);
                        dragger.set({
                            display : true
                        });
                        p.addToPanel(navigation, currentPanel);
                        lastRot = p.getRotation();
                    }
                });
            }

            if (options.onNavigate) {
                options.onNavigate({
                    direction : dir > 0 ? 'right' : 'left',
                    panel : currentPanel,
                    panelLabel : panelLabels[currentPanel],
                    trigger : trig
                });
            }
        }
        
        var autoRotate = function() {
            var nextPanel = currentPanel + 1;
            
            //If the cube has animated through all panels, stop auto rotation
            if (nextPanel === numPanels) {
                clearInterval(autoRotateInterval);
            }

            animateToPanel(nextPanel, 1, 'auto');
        }

        var collapseMenu = function() {
            if (options.onMenuInteract) {
                options.onMenuInteract({
                    state : 'close'
                });
            }
            expandedMenu.tween({
                alpha : 0,
                duration : 300,
                onComplete : function() {
                    expandedMenu.set({
                        display : false
                    });
                }
            });
            menuBtn.set({
                display : true
            });
        }

        var openMenu = function() {
            if (options.onMenuInteract) {
                options.onMenuInteract({
                    state : 'open'
                });
            }
            expandedMenu.set({
                display : true,
                alpha : 0
            });
            expandedMenu.tween({
                alpha : 1,
                duration : 300,
                onComplete : function() {
                    menuBtn.set({
                        display : false
                    });
                }
            });
        }
        
        //If the ad is interacted with in any way, stop auto rotation
        ad.onTriggerDown = function() {
            clearInterval(autoRotateInterval);
        };
            
        if (shouldAutoRotate) {
            autoRotateInterval = setInterval(autoRotate, 3000);
        }
    };

    return XaxisCube;

});
