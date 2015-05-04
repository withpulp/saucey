AdScript.define('IE9Prism', [
    'canvas/shapes/Rectangle',
    'canvas/sprites/Sprite',
    'canvas/shapes/Cluster',
    'canvas/text/TextNode',
    'app/ui/Prism'
], function(Rectangle, Sprite, Cluster, TextNode, Prism) {
    var IE9Prism = function(options) {
        var self = this;
        var ad = options.ad;
        var stage = ad.stage;
        var panels;
        var currentPanel = 0;
        var offset;
        var strip;

        var init = function() {
            self.animating = false;
            initPanels();
        }

        var initPanels = function() {
            panels = [];
            strip = new Cluster({
                shapes : []
            });

            for (var i=0; i<options.panels.length; i++) {
                var clusterX = i * 100 + '%';
                if (i === options.panels.length - 1) {
                    clusterX = '-100%'
                }
                var cluster = new Cluster({
                    x : clusterX,
                    shapes : options.panels[i]
                });
                panels.push(cluster);
                strip.add(cluster);
            }
        };

        var construct = function() {
            console.log(offset);
        }

        var reposition = function() {
            //Current panel should be at zero
            console.log('current panel', currentPanel);

            //Set the strip back at zero
            strip.set({
                x : 0
            });

            //Reorder the strip so there is one panel on either side
            for (var i=0; i<panels.length; i++) {
                var newX = (i-currentPanel) * 100 + '%'
                panels[i].set({
                    x : newX
                });
            }

            if (currentPanel === panels.length - 1) {
                panels[0].set({
                    x : '100%'
                });
            }else if (currentPanel === 0) {
                panels[panels.length -1].set({
                    x : '-100%'
                });
            }

            self.animating = false;
        }

        this.animate = function(options) {
            self.animating = true;

            //In case we need to move more than one panel over
            var oldPanel = currentPanel;
            var newPanel = options.id;
            currentPanel = options.id;
            
            var cw = stage.container.getWidth();
            var pct = (cw - Math.abs(strip.x)) / cw;
            
            strip.tween({
                x : -panels[newPanel].x,
                duration : pct * options.duration,
                onComplete : function() {
                    reposition();
                    if (options.onComplete) {
                        options.onComplete();
                    }
                }
            });

        }

        this.getRotation = function() {
            return 0;
        }

        this.setRotation = function(pos) {
            strip.set({
                x : -pos
            });
        }

        this.getClosestPanel = function() {
            var dir = strip.x > 0 ? -1 : 1;
            var panel = currentPanel + dir;

            if (panel < 0) {
                panel = panels.length - 1;
            }else if (panel === panels.length) {
                panel = 0;
            }
            
            return {
                panel: panel,
                diff: dir
            };
        }

        this.addToPanel = function() {

        }

        this.setActivePanel = function() {

        }

        init();
    };

    return IE9Prism;

});
