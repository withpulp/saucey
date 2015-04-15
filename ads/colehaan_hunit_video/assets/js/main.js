require(['gen/core/AdController',
        'canvas/shapes/Rectangle',
        'canvas/sprites/Sprite',
        'canvas/shapes/Cluster',
        'canvas/text/TextNode',
        'gen/utils/BrowserDetector',
        'dom/video/Video',
        'gen/utils/LocalStoreUtil',
    ],

    function(ad, Rectangle, Sprite, Cluster, TextNode, BrowserDetector,Video, LocalStoreUtil) {

        var preloads = {
            fonts: [],
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

        ad.configure(config);
        var stage = ad.stage;

        ad.begin(function() {
            var isExpanded = false;
            var expand  = function () {
                if (isExpanded === false) {
                    isExpanded = true;
                    ad.expand();
                }
            }

            var collapse = function () {
                if (isExpanded === true){
                    isExpanded = false;
                    ad.collapse;
                }
            }

            var background = new Rectangle ({
                width: "100%",
                height: "100%",
                fillStyle: "#16a085",
                onClick: function() {
                    expand();
                }
            });

            var open_btn = new Rectangle ({
                // x: '100%',
                registration: 'left',
                fillStyle: '#0ff',
                height: 50,
                width: 50,
            });

            var c_background = new Sprite({
                path: 'img/c_bg.jpg',
            })

        });
    });