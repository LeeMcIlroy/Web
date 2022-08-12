var MYAPP = MYAPP || {};

// log :
(function () {
    var IS_DEBUG = true;
    window.console = window['console'] ? window['console'] : { log: function () { } };
    window.log = window['log'] ? window['log'] : function () {
        if (!IS_DEBUG) return;
        window.console.info(arguments[0]);
        if (arguments[0] == 'debug') debugger;
    };
})();

// MYAPP의 프로퍼티 중복 방지
MYAPP.namespace = function (str) {
    var parts = str.split("."),
		parent = MYAPP,
		i;

    // 처음에 중복되는 전역 객체명은 제거
    if (parts[0] === "MYAPP") {
        parts = parts.slice(1);
    }

    for (i = 0; i < parts.length; i++) {
        // 프로퍼티가 존재하지 않으면 생성한다.
        if (typeof parent[parts[i]] === "undefined") {
            parent[parts[i]] = {};
        } else {
            throw new Error((parts[i - 1] || "MYAPP") + " 부모객체에 이미 " + parts[i] + " 객체가 존재합니다.");
        }

        parent = parent[parts[i]];
    }
    return parent;
};

//------------------------MYAPP 시작------------------------------
(function (app, $) {

    // COMMON function
    app.namespace("common");
    app.common = (function () {
        var _init = function () {
            app.lnb.init();
            app.graphControl.init();
            app.commentScroll.init();
            app.resizeTrigger();
            app.tooltip();
        };

        return {
            init: _init
        }
    })();

    // lnb
    app.namespace("lnb");
    app.lnb = (function () {
        var $window, $body, $header, $container, $lnb, $depth1A, $depth2, $btn_fold;
        var minWidth = 1200,
			time = 400,
			lnbOriWidth = 250,
			lnbChaWidth = 50,
			preventClick = false, // 1200픽셀 이하일 때 메뉴 클릭 방지
			preW,
			scrollLeft,
			scrollTop;

        var _init = function () {
            $window = $(window);
            $body = $("body");
            $header = $("#header");
            $container = $("#container");
            $lnb = $("#lnb");
            $depth1A = $lnb.find(".depth1>li>a");
            $depth2 = $lnb.find(".depth2");
            $btn_fold = $lnb.find(".btn_fold");

            $lnb.mCustomScrollbar({
                theme: "minimal",
                scrollInertia: 200
            });

            $window.on("load resize", function () {
                var w = $window.width();
                if (w == preW) return;
                preW = w;

                if (w < minWidth) {
                    _lnbFold();
                    preventClick = true;
                } else {
                    // _lnbFold();
                    // _lnbOpen();
                    _lnbUnFold();
                    preventClick = false;
                }
            });

            $depth1A.click(function (e) {
                e.preventDefault();
                var $this = $(this);

                if (preventClick) {
                    _lnbOpen($this.parent().index());
                    return;
                } else { // 1200px 이상
                    if ($this.hasClass("open")) {
                        $this.removeClass("open");
                        $this.parent().find(".depth2").stop().slideUp(time);
                    } else {
                        $this.addClass("open");
                        $this.parent().find(".depth2").stop().slideDown(time);
                    }
                }
            });

            $btn_fold.click(function (e) { //1200px 이하
                e.preventDefault();
                if ($lnb.hasClass("fold")) {
                    _lnbOpen();
                } else {
                    _lnbFold();
                }
            });
        };

        var _lnbFold = function () {
            $depth1A.removeClass("open");
            $depth2.stop().slideUp(time);
            TweenMax.set($header, { "className": "+=fold" });
            TweenMax.set($lnb, { "className": "+=fold" });
            TweenMax.set($container, { "className": "+=fold" });

            // TweenMax.set( $body, { "overflow": "auto" } );
            TweenMax.set($body, { "position": "static", "width": "auto" });
            $window.scrollLeft(scrollLeft);
            $window.scrollTop(scrollTop);

            TweenMax.to($lnb, 0.4, { "width": lnbChaWidth, ease: "Quint.easeOut" });
            TweenMax.set($lnb, { "className": "+=fold" });

            preventClick = true;
        }

        var _lnbUnFold = function () { //1200px 이상
            TweenMax.set($header, { "className": "-=fold" });
            TweenMax.set($lnb, { "className": "-=fold" });
            TweenMax.set($container, { "className": "-=fold" });
            TweenMax.set($depth1A, { "className": "+=open" });


            $depth2.stop().slideDown(400);
            TweenMax.to($lnb, 0.4, { "width": lnbOriWidth, ease: "Quint.easeOut" });

            preventClick = false;
        }

        var _lnbOpen = function (id) { //1200px 이하
            TweenMax.set($header, { "className": "-=fold" });
            TweenMax.set($lnb, { "className": "-=fold" });
            TweenMax.set($container, { "className": "-=fold" });
            TweenMax.set($depth1A, { "className": "-=open" });
            TweenMax.to($lnb, 0.4, { "width": lnbOriWidth, ease: "Quint.easeOut" });

            // TweenMax.set( $body, { "overflow": "hidden" } );
            scrollLeft = $window.scrollLeft();
            scrollTop = $window.scrollTop();

            TweenMax.set($body, { "position": "fixed", "width": "100%", left: -scrollLeft, top: -scrollTop });

            $depth1A.each(function (i) {
                if (id == i) {
                    $(this).addClass("open");
                    $(this).parent().find(".depth2").stop().slideDown(time);
                    return false;
                }
                if (id == undefined && $(this).hasClass("on")) {
                    $(this).addClass("open");
                    $(this).parent().find(".depth2").stop().slideDown(time);
                    return false;
                };

            });
            // app.graph.adManager.update();

            preventClick = false;
        }

        return {
            init: _init
        }
    })();

    // 강제 resize trigger
    app.namespace("resizeTrigger");
    app.resizeTrigger = (function () {
        var ev = document.createEvent('UIEvents');
        ev.initUIEvent('resize', true, false, window, 0);
        return function () {
            window.dispatchEvent(ev);
        }
    })();

    // graph tooltip 제거
    app.namespace("tooltip");
    app.tooltipRemove = function () {
        $('.nvtooltip.xy-tooltip').css('opacity', 0);
    };
    app.tooltip = function () {
        var $w = $(window);
        $w.on('touchstart', function (e) {
            app.tooltipRemove();
        });
        $w.on('scroll', function (e) {
            app.tooltipRemove();
        });
    };

    // 레이어 띄우기
    app.namespace("layerControl");
    app.layerControl = (function () {
        var $mask;

        // 레이어 노출
        var _layerShow = function (layerId) {
            $mask = $("#mask");
            $mask.fadeTo("fast", 0.8);
            TweenMax.set($(layerId), { "display": "block", "x": "-50%", "y": "-51%", delay: 0.05 });

        }

        // 레이어 숨김
        var _layerHide = function (layerId) {
            $mask = $("#mask");
            $mask.fadeOut("fast");
            TweenMax.set($(layerId), { "display": "none" });
        }

        return {
            layerShow: _layerShow,
            layerHide: _layerHide
        }
    })();

    // graphControl
    app.namespace("graphControl");
    app.graphControl = (function () {
        var $graphLink;

        var _init = function () {
            $graphLink = $(".graph_box_wrap h2>a");
            $graphLink.click(function (e) {
                e.preventDefault();
                var $this = $(this);
                if ($this.parent().parent().hasClass("open")) {
                    _accordion.close($this);
                } else {
                    var r = '';
                    $this.parent().parent('.graph_box_wrap').find('.chart ').each(function (i) {
                        var $this = $(this);
                        r += i == 0 ? '' : ',';
                        r += $this.data().chart || '';
                    });
                    _accordion.open($this, r);
                }
            });
            // $graphLink.each( function(i){
            // 	if( i == 0 ) return;
            // 	_accordion.close($(this), 0);
            // });
            //$(".graph_box_wrap:first").find(">h2>a").trigger("click");
        };

        var _accordion = {
            open: function (ele, chart) {
                var $ele = ele;
                // $ele.parent().parent().find(".graph_box").css('visibility', 'visible');
                $ele.parent().parent().find(".graph_box").stop().slideDown(300);
                $ele.parent().parent().addClass("open");
                // app.resizeTrigger();
                // log( app.graph.adManager.getList() );
                if (chart != '') app.graph.adManager.update(chart);

            },
            close: function (ele, time) {
                var $ele = ele;

                $ele.parent().parent().find(".graph_box").stop().slideUp(time || 300);
                $ele.parent().parent().removeClass("open");
            }
        };

        return {
            init: _init
        }
    })();

    // table
    app.namespace("table");
    app.table = (function () {
        var _setScroll = function (ele) {
            var $ele = ele;

            $(window).on("load", function () {
                $ele.mCustomScrollbar({
                    axis: "x",
                    theme: "dark-thin",
                    scrollInertia: 500,
                    advanced: { autoExpandHorizontalScroll: true }
                });

            })
        };

        return {
            setScroll: _setScroll
        }
    })();

    // FORM style
    app.namespace("form");
    app.form = (function () {

        var _styleSelect = function (ele) {
            var $ele = ele;

            $ele.each(function (i) {
                if ($(this).find("option:selected")) {
                    var txt = $(this).find("option:selected").text();
                    $(this).siblings("span").text(txt);
                }
            });

            $ele.on({
                "focusin": function () {
                    $(this).parent("label").addClass("on");
                },
                "focusout": function () {
                    $(this).parent("label").removeClass("on");
                },
                "change": function () {
                    var val = $(this).children("option:selected").text();
                    $(this).siblings("span").text(val);
                }
            });
        };

        var _styleFile = function (ele) {
            var $ele = ele;

            $ele.change(function () {
                var name = $(this).val();
                var val = name.substring(name.lastIndexOf("\\") + 1);

                $(this).siblings("span").text(val);
            });
        };

        var _datePicker = function (inputId) {
            $(inputId).datepicker({
                showOn: "button",
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                buttonText: "<i class='fa fa-calendar'></i>",
                dateFormat: "yy-mm-dd"
            });
        }

        var _datePickerTime = function (inputId) {
            $(inputId).datepicker({
                showOn: "button",
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                buttonText: "<i class='fa fa-calendar'></i>",
                dateFormat: "yy-mm-dd hh:nn", // yy-mm-dd / yy-mm-dd hh:nn
                changeTime: true, // true 이면 시간 UI 생김
                changeTimeType: "select" // input 이면 input[type=text] type, select 이면 selectbox 형태
            });
        }

        return {
            styleSelect: _styleSelect,
            styleFile: _styleFile,
            datePicker: _datePicker,
            datePickerTime: _datePickerTime
        }
    })();

    // TAB
    app.namespace("tab");
    app.tab = (function () {
        var _init = function (ele) {
            var $this = ele;
            var prev;

            $this.find("a").click(function (e) {
                e.preventDefault();
                var $this = $(this);

                if (prev) {
                    prev.parent().removeClass("on");
                    TweenMax.set($(prev.attr("href")), { "opacity": 0, "display": "none" });
                }

                $this.parent().addClass("on");
                TweenMax.set($($this.attr("href")), { "display": "block" });
                TweenMax.to($($this.attr("href")), 0.8, { "opacity": 1 });

                prev = $this;

                // app.resizeTrigger();
                // app.graph.adManager.update();
                var chart = '';
                $($this.attr('href')).find('.chart ').each(function (i) {
                    var $this = $(this);
                    if ($this.data().chart == undefined) return;
                    chart += i == 0 ? '' : ',';
                    chart += $this.data().chart;
                });
                if (chart != '') app.graph.adManager.update(chart);

                app.tooltipRemove();
            });

            $this.find("li:nth-child(1) a").trigger("click");
        };

        return {
            init: _init
        }
    })();

    // commentScroll
    app.namespace("commentScroll");
    app.commentScroll = (function () {
        var $commentScroll;

        var _init = function () {
            $commentScroll = $("#layerComment .comment_list_scroll");
            $(window).on("load", function () {
                $commentScroll.mCustomScrollbar({
                    theme: "dark",
                    scrollInertia: 500
                });

            });
        };

        return {
            init: _init
        }
    })();

    // graph
    app.namespace('graph');

    app.graph.adManager = (function () {
        var list = [],
			total = 0;

        return {
            add: function ($k, $v) {
                if (list[$k] != undefined) return log("Dk : list에 이미 " + $k + "값이 존재합니다.");
                list[list[$k] = list.length] = { key: $k, value: $v };
                $($k).data('chart', $k);
            },

            del: function ($k) {
                if (list[$k] == undefined) return log("Dk : list에 " + $k + "값이 존재하지 않습니다.");
                var t0 = list[$k],
					k;
                list.splice(t0, 1), delete list[$k];
                for (k in list) list[k] >= t0 ? list[k] -= 1 : 0;
            },

            getList: function () {
                return list;
            },

            update: function ($k) {
                if ($k == undefined) {
                    var i = list.length;
                    while (i--) list[i].value();
                } else {
                    var arr = $k.split(',')
                    arr.map(function (k) {
                        list[list[k]].value();
                    });
                }
            }
        }
    })();

    app.graph.graphFillOpacity = 1;
    app.graph.barColor = ['#004098', '#009DE4', '#6F7784', '#5756CE', '#F09A37', '#EA4E3D', '#09A38C', '#76D672', '#BD9A00', '#a8b3c5', '#167bc1', '#364660'];

    // graph symbolMap diamond2
    nv.utils.symbolMap.set('diamond2', function (size) {
        size = Math.sqrt(size);
        return 'M0,' + (-size / 1.6) +
			'L' + (size / 1.6) + ',0 ' +
			'0,' + (size / 1.6) + ' ' +
			(-size / 1.6) + ',' + '0Z';
    });

    app.graph.type1 = function (data, sel) {
        // config
        var margin = { top: 90, right: 10, bottom: 20, left: 50 },
			padding = 0.3,
			titleHeight = 40;

        var $con = $(sel);
        var chart = d3.select(sel).append('svg')
			.append('g')
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        var xAxis = d3.svg.axis()
			.orient("top")
			.tickFormat(function (d) { return ''; });

        var xAxisG = chart.append("g").attr("class", "x axis");

        var titleG = chart.append("g").attr("class", "titles");

        var planG = chart.append("g").attr("class", "plans");
        planG.append('line').attr("class", "domain");
        planG.append('rect').attr("class", "categoryBg").attr("x", -50).attr("width", 50);
        planG.append('text').attr("class", "category").attr("x", -38).text('계획');
        planG.append('text').attr("class", "total");

        var gapG = chart.append("g").attr("class", "gaps");
        gapG.append('line').attr("class", "domain");
        gapG.append('rect').attr("class", "categoryBg").attr("x", -50).attr("width", 50);
        gapG.append('text').attr("class", "category").attr("x", -38).text('차이');

        var resultG = chart.append("g").attr("class", "results");
        resultG.append('line').attr("class", "domain");
        resultG.append('rect').attr("class", "categoryBg").attr("x", -50).attr("width", 50);
        resultG.append('text').attr("class", "category").attr("x", -38).text('실적');
        resultG.append('text').attr("class", "total");

        var fcfG = chart.append('g').attr('class', 'fcf');
        fcfG.append('rect').attr('class', 'bg');
        fcfG.append('rect').attr('class', 'titleBg');
        fcfG.append('text').attr('class', 'title').text('Free Cash Flow');

        var draw = function () {
            var availableWidth = $con.width() - margin.left - margin.right;
            var availableHeight = $con.height() - margin.top - margin.bottom - titleHeight / 2;

            // x
            var x = d3.scale.ordinal()
				.rangeRoundBands([0, availableWidth], padding);
            x.domain(data.plan.map(function (d) {
                return d.name;
            }));

            // xAxis
            (function () {
                xAxis.scale(x);

                xAxisG
					.attr("transform", "translate(0," + 0 + ")")
					.call(xAxis);
            })();

            // title
            (function () {
                var title = titleG.selectAll(".title")
					.data(data.plan);
                title.exit().remove();

                var titleEnter = title.enter().append("g")
					.attr("class", function (d) {
					    return "title " + d.class;
					});

                title.attr("transform", function (d) {
                    return "translate(" + x(d.name) + ",0)";
                });

                titleEnter.append("rect");
                title.select("rect")
					.attr("y", function (d) {
					    return titleHeight / -2;
					})
					.attr("height", function (d) {
					    return titleHeight;
					})
					.attr("width", x.rangeBand());

                var text = titleEnter.append("text");
                text.append("tspan")
					.attr("class", "t0");
                title.select('tspan.t0').attr("x", x.rangeBand() / 2)
					.attr("y", function (d) {
					    return titleHeight / -2 + titleHeight / 2 - 6;
					})
					.attr("dy", function (d) {
					    return d.name1 == undefined ? ".75em" : ".2em";
					})
					.text(function (d) {
					    return d.name0;
					});

                text.append("tspan")
					.attr("class", "t1");
                title.select('tspan.t1').attr("x", x.rangeBand() / 2)
					.attr("y", function (d) {
					    return titleHeight / -2 + titleHeight / 2 - 6;
					})
					.attr("dy", function (d) {
					    return "1.4em";
					})
					.text(function (d) {
					    return d.name1;
					});
            })();

            // bar
            var makeBar = function (data, g, y) {
                y.domain([d3.min(data, function (d) {
                    return d.start < d.end ? d.start : d.end;
                }), d3.max(data, function (d) {
                    return d.start > d.end ? d.start : d.end;
                })]);

                var bar = g.selectAll(".bar")
					.data(data);
                bar.exit().remove();

                var barEnter = bar.enter().append("g")
					.attr("class", function (d) {
					    return "bar " + d.class
					});

                bar.attr("transform", function (d) {
                    return "translate(" + x(d.name) + ",0)";
                });

                barEnter.append("rect");
                bar.select('rect').attr("y", function (d) {
                    return y(Math.max(d.start, d.end));
                })
					.attr("height", function (d, i) {
					    return i == 8 ? 0 : Math.abs(y(d.start) - y(d.end));
					})
					.attr("width", x.rangeBand());

                barEnter.append("text");
                bar.select('text').attr("x", x.rangeBand() / 2)
					.attr("y", function (d) {
					    return (d.class.indexOf('negative') > -1) ? y(d.start) : y(d.end);
					})
					.attr("dy", function (d) {
					    return '-.3em'
					    // return( ( d.class.indexOf( 'negative' ) > -1 ) ? '' : '-' ) + ".75em"
					})
					.text(function (d, i) {
					    return d3.format(',.0f')(i == 8 ? d.value : d.end - d.start);
					});

                barEnter.filter(function (d) {
                    return d.class.indexOf('noline') <= -1;
                }).append("line");
                bar.select('line').attr("class", "connector")
					.attr("x1", x.rangeBand() + 5)
					.attr("y1", function (d) {
					    return y(d.end)
					})
					.attr("x2", x.rangeBand() / (1 - padding) - 5)
					.attr("y2", function (d) {
					    return y(d.end)
					});
            };

            // plan
            (function () {
                var y = d3.scale.linear().range([availableHeight * 0.35, 0]);
                planG.attr("transform", "translate(0," + (titleHeight / 2 + availableHeight * 0.1) + ")");
                planG.select('rect.categoryBg')
					.attr("height", availableHeight * 0.42)
					.attr("y", availableHeight * -0.08);
                planG.select('text.category')
					.attr("y", availableHeight * 0.35 / 2 - 5);
                planG.select('text.total')
					.attr("x", x(data.plan[3].name) + x.rangeBand() / 2)
					.attr("y", availableHeight * -0.08 + 15)
					.text('FCF ' + d3.format(',.0f')(data.fcfPlan));
                planG.select('line')
					.attr("y1", availableHeight * 0.35)
					.attr("y2", availableHeight * 0.35)
					.attr("x2", availableWidth);

                makeBar(data.plan, planG, y);
            })();

            // result
            (function () {
                var y = d3.scale.linear().range([availableHeight * 0.35, 0]);
                resultG.attr("transform", "translate(0," + (titleHeight / 2 + availableHeight * 0.65) + ")");
                resultG.select('rect.categoryBg')
					.attr("height", availableHeight * 0.42)
					.attr("y", availableHeight * -0.08);
                resultG.select('text.category')
					.attr("y", availableHeight * 0.35 / 2 - 5);
                resultG.select('text.total')
					.attr("x", x(data.plan[3].name) + x.rangeBand() / 2)
					.attr("y", availableHeight * -0.08 + 15)
					.text('FCF ' + d3.format(',.0f')(data.fcfResult));
                resultG.select('line')
					.attr("y1", availableHeight * 0.35)
					.attr("y2", availableHeight * 0.35)
					.attr("x2", availableWidth);

                makeBar(data.result, resultG, y);
            })();

            // gap
            (function () {
                var y = d3.scale.linear().range([availableHeight * 0.1, 0]);
                gapG.attr("transform", "translate(0," + (titleHeight / 2 + availableHeight * 0.45) + ")");
                gapG.select('rect.categoryBg')
					.attr("height", availableHeight * 0.09)
					.attr("y", availableHeight * 0.01);
                gapG.select('text.category')
					.attr("dy", availableHeight * 0.1 / 2 + 5);
                gapG.select('line')
					.attr("y1", availableHeight * 0.1)
					.attr("y2", availableHeight * 0.1)
					.attr("x2", availableWidth);

                var gap = gapG.selectAll(".gap")
					.data(data.gap);
                gap.exit().remove();

                var gapEnter = gap.enter().append("g")
					.attr("class", "gap");

                gap.attr("transform", function (d) {
                    return "translate(" + x(d.name) + ",0)";
                });

                gapEnter.append("text");
                gap.select('text').attr("x", x.rangeBand() / 2)
					.attr("y", availableHeight * 0.1 / 2 + 5)
					.text(function (d) {
					    return d3.format("+,.0f")(d.value);
					});

            })();

            // fcfG
            (function () {
                var boxW = x.rangeBand();
                var x0 = x(data.plan[0].name);
                var x1 = x(data.plan[1].name);
                var boxGap = x1 - x0 - boxW;
                fcfG.attr("transform", "translate(" + (x1 - boxGap / 2) + "," + -70 + ")");
                fcfG.select('rect.bg')
					.attr("width", (x1 - x0) * 5)
					.attr("height", availableHeight + margin.top + 15)
                fcfG.select('rect.titleBg')
					.attr("width", 160)
					.attr("height", 40)
					.attr("x", ((x1 - x0) * 5 - 160) / 2)
					.attr("y", -20)
                fcfG.select('text.title')
					.attr("x", (x1 - x0) * 5 / 2)
					.attr("y", 4)
            })();
        };

        draw();

        nv.utils.windowResize(draw);

        app.graph.adManager.add(sel, draw);
    };

    app.graph.type2 = function (data, sel) {
        nv.addGraph(function () {
            var chart = nv.models.multiBarChart2()
				.barColor(app.graph.barColor)
				.duration(300)
				.margin({ top: 30, right: 0, bottom: 0, left: 0 })
				.groupSpacing(0.2)
				.legendPosition('bottom')
				.reduceXTicks(false)
				.showControls(false)
				.clipEdge(false)
				.fillOpacity(app.graph.graphFillOpacity)
				.valueColor('#e6e6e6')
				.stacked(true)
            // .useInteractiveGuideline( true )
            // .showYAxis(false)
            // .showLegend(false)
            ;

            (function () {
                var total;
                total = data[0].values.map(function (obj) {
                    return { y2: 0 };
                });

                data.forEach(function (obj, i) {
                    obj.values.forEach(function (obj, j) {
                        if (obj.y > 0) {
                            total[j].y2 += obj.y;
                        }
                    });
                });

                data = data.map(function (obj, i) {
                    obj.values.map(function (obj, j) {
                        obj.total.y2 = total[j].y2;
                        return obj;
                    });
                    return obj;
                });
            })();

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type3 = function (data0, data1, sel) {
        app.graph.type2(data0, sel + ' .chart_type2');
        app.graph.type12(data1, sel + ' .chart_type12');

        var $sel = {
            con: $(sel),
            bt: $(sel + ' .bt_percentage'),
            percentage: $(sel + ' .percentage')
        };
        var toggle = false;
        $sel.percentage.css({ 'opacity': 0, 'visibility': 'hidden' });

        $sel.bt.on('click', function (e) {
            e.preventDefault();
            toggle = !toggle;
            if (toggle) {
                $sel.bt.addClass('on');
                $sel.percentage.css({ 'opacity': 1, 'visibility': 'visible' });
            } else {
                $sel.bt.removeClass('on');
                $sel.percentage.css({ 'opacity': 0, 'visibility': 'hidden' });
            }
            app.tooltipRemove();
        });
    };

    app.graph.type4 = function (data, sel) {
        nv.addGraph(function () {
            var chart = nv.models.multiBarChart2()
				.barColor(app.graph.barColor)
				.duration(300)
				.margin({ top: 20, right: 0, bottom: 0, left: 0 })
				.showYAxis(false)
				.groupSpacing(0.1)
				.legendPosition('bottom')
				.reduceXTicks(false)
				.showControls(false)
				.clipEdge(false)
				.fillOpacity(app.graph.graphFillOpacity)
				.valueColor('#707070')
            // .showLegend(false)
            // .stacked(true)
            ;

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type5 = function (data, sel) {
        nv.addGraph(function () {
            var chart = nv.models.lineChart2()
				.options({
				    duration: 300,
				    useInteractiveGuideline: true
				})
				.padData(true)
				.padDataOuter(-0.5)
				.clipEdge(false)
				.margin({ top: 30, right: 80, bottom: 30, left: 0 })
				.showYAxis(true)
				.pointsShowP(true)
				.pointsOffset({ y: -10 })
				.legendPosition('right');

            chart.xAxis
				.tickFormat(function (d) { return d + 'Q' })
            // .axisLabelDistance( 20 )
            // .staggerLabels( true )
            ;

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type6 = function (data, sel, navi) {
        var popArr = [];
        var colorObj = { '지주부문': '#02429a', '자동차부문': '#aea375', '건설부문': '#838790' };
        var colorArr = data.map(function (obj, i) {
            return colorObj[obj.union];
        });

        nv.addGraph(function () {
            var chart = nv.models.scatterChart2()
				.margin({ top: 40, right: 170, bottom: 80, left: 50 })
				.showLegend(false)
				.pointsShowY(false)
				.pointsShowKey(true)
				.pointsOffset({ y: -22 })
				.color(colorArr)
				.duration(300)
				.forceX([50, 150])
				.forceY([80, 120])
            // .showDistX(true)
            // .showDistY(true)
            // .useVoronoi(true)
            ;

            chart.xAxis
				.tickFormat(function (d) { return d + '%' })
				.tickValues([50, 100, 150])
				.showMaxMin(false);
            chart.yAxis
				.tickFormat(function (d) { return d + '%' })
				.tickValues([80, 90, 100, 110, 120])
				.showMaxMin(false);

            chart.tooltip.enabled(false);

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            // 말풍선
            var $wrap = $(sel);
            data.forEach(function (obj, i) {
                var d = obj.values[0];

                var $pop = $('<div></div>');
                $pop.addClass('nvtooltip');
                $wrap.append($pop);

                var formatComma = d3.format(",");
                var formatPercent0 = function (d) { return d == 0 ? 'N/A' : d3.format(",.0f")(d) + '%'; };
                var formatPercent1 = function (d) { return d3.format(",.1f")(d) + '%'; };
                var str = '<table><tbody>';
                str += '<tr><td colspan="2" class="title">' + obj.key + '</td></tr>';
                str += '<tr><td class="key">' + d.v1.k + '</td><td class="value">' + formatComma(d.v1.v) + ' (' + formatPercent0(d.y1) + ')</td></tr>';
                str += '<tr><td class="key">' + d.v0.k + '</td><td class="value">' + formatComma(d.v0.v) + ' (' + formatPercent0(d.x1) + ')</td></tr>';
                str += '<tr><td class="key">' + d.v2.k + '</td><td class="value">' + formatPercent1(d.v2.v) + '</td></tr>';
                str += '</tbody></table>';
                $pop.html(str);

                $pop.on('mouseenter', function (e) {
                    $(this).css('zIndex', 10001);
                });
                $pop.on('mouseleave', function (e) {
                    $(this).css('zIndex', 10000);
                });
                $pop.hide();

                popArr[i] = $pop;
            });

            chart.dispatch.on('renderEnd', function () {
                // console.log('Render Complete');
                var pos = chart.positionArr();
                popArr.forEach(function ($pop, i) {
                    $pop.css({ left: pos[i][0] + chart.margin().left + 10, top: pos[i][1] + chart.margin().top + 10 });
                });
            });

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });

        // navi
        (function () {
            var $sel = {
                navi: $(navi),
                ul: $(navi + '>ul'),
                li: $(navi + '>ul>li')
            };

            var $clone = $sel.li.eq(0).clone();
            $sel.ul.empty();

            data.forEach(function (obj, i) {
                var $li = $clone.clone();
                $li.find('>a').html('<span></span>' + obj.key);
                $li.find('>a>span').css('backgroundColor', colorArr[i]);
                $sel.ul.append($li);
            });
            $sel.li = $(navi + '>ul>li');
            $sel.a = $(navi + '>ul>li>a');

            $sel.a.each(function (i) {
                var $a = $(this);
                var toggle = false;
                // $a.addClass( 'on' );
                $a.on('click', function (e) {
                    e.preventDefault();
                    toggle = !toggle;
                    if (toggle) {
                        $a.addClass('on');
                        popArr[i].show();
                    } else {
                        $a.removeClass('on');
                        popArr[i].hide();
                    }
                });
            });
        })();
    };

    app.graph.type7 = function (data, sel, format) {
        nv.addGraph(function () {
            var chart = nv.models.lineChart2()
				.options({
				    duration: 300,
				    useInteractiveGuideline: true
				})
				.padData(true)
				.padDataOuter(0)
				.clipEdge(false)
				.margin({ top: 20, right: 80, bottom: 30, left: 10 })
				.legendPosition('right')
				.valueFormat(function (d) { return d3.format(format || ',.1f')(d) + '%'; })
            // .showLegend(false)
            // .showYAxis(false)
            ;

            // chart sub-models (ie. xAxis, yAxis, etc) when accessed directly, return themselves, not the parent chart, so need to chain separately
            chart.xAxis
				.tickFormat(function (d) { return (d == 0 ? 12 : d) + '월' })
            // .axisLabelDistance(20)
            // .staggerLabels(true)
            ;
            chart.yAxis
				.tickFormat(function (d) { return d3.format(',.1f')(d) + '%'; });

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type8 = function (data, sel, color) {
        nv.addGraph(function () {
            var chart = nv.models.pieChart2()
				.margin({ top: 60, right: 0, bottom: 40, left: 0 })
				.x(function (d) { return d.key })
				.y(function (d) { return d.y })
				.donut(true)
				.color(['#e1e4e9', color])
				.labelsOutside(true)
				.labelType("key value")
				.valueFormat(function (d) { return d3.format(',.0f')(d) + '억'; })
				.arcsRadius([
					{ inner: 0.7, outer: 1 },
					{ inner: 0.7, outer: 1 }
				])
            // .labelSunbeamLayout(true)
            // .showLabels(false)
            // .growOnHover(false)
            ;

            chart.title(d3.format(',.0f')(data.objective[0].y == 0 ? 0 : (data.sum[0].y / data.objective[0].y * 100)) + "%");
            chart.title2(data.title);

            d3.select(sel).append('svg')
				.datum(data)
				// .datum(data.values)
				// .transition().duration(1200)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type9 = function (data, sel, type) {
        nv.addGraph(function () {
            var chart = nv.models.linePlusBarChart2()
				.clipEdge(false)
				.margin({ top: 20, right: 100, bottom: 40, left: 0 })
				.color(['#009de4', '#c112ae'])
				.focusEnable(false)
				.pointShape('square')
				.pointSize(20)
				.pointsShowP(true)
				.pointsOffset({ x: 24, y: 18 })
				.valueFormat(function (d) { return d3.format(',.0f')(d); })
            // .padData(true)
            // .padDataOuter(0)
            ;

            if (type == undefined) chart.xAxis.tickFormat(function (d) { return d + '월'; });
            else if (type == 1) chart.xAxis.tickFormat(function (d) { return "'" + d.toString().substr(2, 4) + '년'; });
            // chart.yAxis
            //   .tickFormat( function( d ) { return d3.format(',.0f')( d ); } )
            // ;

            chart.y1Axis.tickFormat(function (d) { return d3.format(',.0f')(d); });
            chart.y2Axis.tickFormat(function (d) { return d3.format(',.0f')(d); });
            // chart.bars.forceY([ 0 ]).padData(false);

            // chart.x2Axis.tickFormat(function(d) {
            //     return d3.time.format('%x')(new Date(d))
            // }).showMaxMin(false);

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type10 = function (data, sel) {
        nv.addGraph(function () {
            var chart = nv.models.multiChart3()
				.margin({ top: 0, right: 100, bottom: 30, left: 0 })
				// .groupSpacing( 0.5 )
				// .legendPosition( 'bottom' )
				// .reduceXTicks( false )
				// .showControls( false )
				// .clipEdge( false )
				.fillOpacity(app.graph.graphFillOpacity)
				.duration(0)
            // .stacked( true )
            // .valueColor( '#000000' )
            // .showYAxis(false)
            // .showLegend(false)
            ;

            data.map(function (obj, i) {
                obj.type = ['bar', 'bar', 'line'][i];
                obj.color = ['#009de4', '#6F7784', '#c112ae'][i];
                obj.yAxis = 1;
                return obj;
            });

            chart.xAxis
				.tickPadding(20)
				.tickFormat(function (d) { return "'" + d.toString().substr(2, 4) + '년' });

            chart.yAxis1
				.tickFormat(function (d) { return d3.format(',.0f')(d); });

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type11 = function (data, sel, unit) {
        nv.addGraph(function () {
            var chart = nv.models.lineChart2()
				.options({
				    duration: 300,
				    useInteractiveGuideline: true
				})
				.padData(true)
				.padDataOuter(-0.5)
				.clipEdge(false)
				.margin({ top: 20, right: 10, bottom: 30, left: 10 })
				.showYAxis(true)
				.showLegend(false)
				.valueFormat(function (d) { return d3.format(unit == undefined ? ',.1f' : ',.0f')(d) + (unit == undefined ? '%' : unit); })
            // .legendPosition( 'right' )
            // .pointsOffset({y:-10})
            ;

            chart.xAxis
				.tickFormat(function (d) { return "'" + d.toString().substr(2, 4) + '년' })
            // .axisLabelDistance(20)
            // .staggerLabels(true)
            ;
            chart.yAxis
				.tickFormat(function (d) { return d3.format(unit == undefined ? ',.1f' : ',.0f')(d) + (unit == undefined ? '%' : unit); });

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type12 = function (data, sel) {
        var arcsRadius = data.map(function () {
            return { inner: 0.63, outer: 1 };
        });

        nv.addGraph(function () {
            var chart = nv.models.pieChart()
				.margin({ top: 35, right: 30, bottom: 30, left: 30 })
				.x(function (d) { return d.key })
				.y(function (d) { return d.y })
				.donut(true)
				.color(app.graph.barColor)
				.labelType("value")
				.showLegend(false)
				.valueFormat(function (d) { return d3.format(',.0f')(d) + '%'; })
				.arcsRadius(arcsRadius)
				.labelsOutside(true)
            // .labelSunbeamLayout(true)
            // .showLabels(false)
            // .growOnHover(false)
            ;

            // chart.title( '비중' );

            d3.select(sel).append('svg')
				.datum(data)
				// .datum(data.values)
				// .transition().duration(1200)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type13 = function (data, sel) {
        var r = { loaded: false };
        nv.addGraph(function () {
            var chart = nv.models.multiChart2()
				.margin({ top: 40, right: 0, bottom: 30, left: 100 })
				.showYAxis(false)
				.fillOpacity(app.graph.graphFillOpacity)
            // .pointsShowP( true )
            // .pointsShowY(false)
            ;

            chart.xAxis
				.tickPadding(20)
				.showMaxMin(false)
            // .tickFormat( function( d ) { return d3.format( ',f' )( d ) + '월' } )
            ;
            chart.yAxis1.tickFormat(d3.format(',.0f'));

            var chartData = d3.select(sel).append('svg')
				.datum(data)
				// .datum(data.values)
				// .transition().duration(1200)
				.call(chart);

            nv.utils.windowResize(chart.update);

            r.loaded = true;
            r.chart = chart;
            r.update = function (data) {
                chartData.datum(data).call(chart);
                chartData.datum(data).call(chart);
                // chart.update();
            };

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });

        return r;
    };

    app.graph.type14 = function (data, sel) {
        nv.addGraph(function () {
            var chart = nv.models.lineChart2()
				.options({
				    duration: 300,
				    useInteractiveGuideline: true
				})
				.padData(true)
				.padDataOuter(-0.5)
				.clipEdge(false)
				.margin({ top: 20, right: 10, bottom: 30, left: 10 })
				.showYAxis(true)
				.showLegend(false)
				.valueFormat(function (d) { return d3.format(',.0f')(d); })
            // .legendPosition( 'right' )
            // .pointsOffset({y:-10})
            ;

            chart.xAxis
				.tickFormat(function (d) { return (d == 0 ? 12 : d) + '월' })
            // .axisLabelDistance(20)
            // .staggerLabels(true)
            ;
            chart.yAxis
				.tickFormat(function (d) { return d3.format(',.0f')(d); });

            d3.select(sel).append('svg')
				.datum(data)
				.call(chart);

            nv.utils.windowResize(chart.update);

            app.graph.adManager.add(sel, chart.update);

            return chart;
        });
    };

    app.graph.type15 = function (data, sel) {
        var $ul = $(sel);
        var $clone = $ul.find('li').clone();
        $ul.empty();

        data.forEach(function (obj, i) {
            var $li = $clone.clone().appendTo($ul);
            $li.find('.rect').css('backgroundColor', app.graph.barColor[i]);
            $li.find('.txt').text(obj.key);
        });
    };

    // makeTable
    app.namespace('makeTable');
    app.makeTable = function (data, sel) {
        var _dataFormat = function (data) {
            data.map(function (obj) {
                for (var k in obj) {
                    if (k == 'year') continue;
                    obj[k] = d3.format(',')(obj[k]);
                }
                return obj;
            });
            return data;
        };

        var r = {
            app: new Vue({ el: sel, data: { list: _dataFormat(data) } }),
            update: function (data) {
                this.app.list = _dataFormat(data);
            }
        };
        return r;
    };

    // trend
    app.namespace('trendData');
    app.trendData = (function () {
        var _isLocal = false;
        //var _isLocal = true;
        var _isLoading = false;
        var _url;
        var getLevel, getTrend;


        _url = (function () {
            var localUrl = {
                cashFlowLevel: '/Contents/user/local/Trend_Analysis/Level_Cash_Flow.json',
                palLevel: '/Contents/user/local/Trend_Analysis/Level_Pal.json',
                financialLevel: '/Contents/user/local/Trend_Analysis/Level_Financial.json',
                investLevel: '/Contents/user/local/Trend_Analysis/Level_Invest.json',
                cashFlow: '/Contents/user/local/Trend_Analysis/Cash_Flow.json',
                pal: '/Contents/user/local/Trend_Analysis/Pal.json',
                financial: '/Contents/user/local/Trend_Analysis/Financial.json',
                invest: '/Contents/user/local/Trend_Analysis/Invest.json'
            };
            var serverUrl = {
                cashFlowLevel: '/Trend_Analysis/Cash_Flow/CashFlowLevel',
                palLevel: '/Trend_Analysis/Pal/PalLevel',
                financialLevel: '/Trend_Analysis/Financial/FinancialLevel',
                investLevel: '/Trend_Analysis/Invest/InvestLevel',
                cashFlow: '/Trend_Analysis/Cash_Flow/CashFlowData',
                pal: '/Trend_Analysis/Pal/PalData',
                financial: '/Trend_Analysis/Financial/FinancialData',
                invest: '/Trend_Analysis/Invest/InvestData'
            }
            return _isLocal ? localUrl : serverUrl;
        })();

        getLevel = function (id, cb) {
            log('ajax getLevel ---------------------------------');
            log(id);
            _isLoading = true;
            $.ajax({
                url: _url[id + 'Level'],
                method: 'GET',
                dataType: 'json'
            }).done(function (data) {
                _isLoading = false;
                cb(data);
            }).fail(function () {
                log("getLevel fail");
                _isLoading = false;
            });
        };

        getTrend = function (id, formData, cb) {
            log('ajax getTrend ---------------------------------');
            // log( formData );
            _isLoading = true;
            $.ajax({
                url: _url[id],
                method: 'GET',
                data: formData,
                dataType: 'json'
            }).done(function (data) {
                _isLoading = false;
                cb(data);
            }).fail(function () {
                log("getTrend fail");
                _isLoading = false;
            });
        };

        return {
            isLoading: function () { return _isLoading; },
            getLevel: getLevel,
            getTrend: getTrend
        }

    })();

    app.namespace('trendSetting');
    app.trendSetting = (function () {
        var _isInitialized;
        var sel;
        var init;
        var Trend;
        var _setting;
        var Level;
        var Period;

        init = function (id, trend) {
            if (_isInitialized) return;
            _isInitialized = true;

            sel = {
                level: '#trend_level',
                period: '#trend_period',
                $form: $('.trend_wrap form')
            };

            Trend = trend;

            app.trendData.getLevel(id, function (data) {
                Level.init(data.level);
                Period.init(data.period);

                sel.$form.css('opacity', 1);

                /*셀렉트박스 스타일*/
                MYAPP.form.styleSelect($(".style_select select"));

                _setting();
            });
        };

        _setting = function () {
            var r = '';
            Level.getId().map(function (str, i) {
                r += 'level' + i + '=' + str + '&';
            });
            r += sel.$form.serialize();
            Trend.load(r);
        };

        Level = (function () {
            var init, getId;
            var _initData, _initVue;
            var _data;
            var _app;
            var _actId1 = 0,
				_actId2 = 0,
				_actId3 = 0;
            var _iconArr = ['group', 'sector', 'company', 'unit'];

            init = function (d) {
                _data = _initData(d);
                _initVue();
            };

            _initData = function (d) {
                d.map(function (obj1, i) {
                    obj1.ico = 'ico ico_' + _iconArr[obj1.id];
                    obj1.isOn = i == 0 ? true : false;
                    obj1.width = (100 / d.length) + '%';
                    obj1.subId = -1;
                    if (obj1.sub) {
                        obj1.subId = 0;
                        obj1.sub.map(function (obj2, j) {
                            obj2.isOn = j == 0 ? true : false;
                            obj2.subId = -1;
                            if (obj2.sub) {
                                obj2.subId = 0;
                                obj2.sub.map(function (obj3, i) {
                                    obj3.isOn = i == 0 ? true : false;
                                });
                            }
                        });
                    };
                });

                return d;
            };

            _initVue = function () {
                _app = new Vue({
                    el: sel.level,
                    data: {
                        group: _data[_actId1].id == '0' ? false : true,
                        depth1: _data,
                        depth2: _data[_actId1].sub ? _data[_actId1].sub : {},
                        depth3: _data[_actId1].sub && _data[_actId1].sub[_actId2] && _data[_actId1].sub[_actId2].sub ? _data[_actId1].sub[_actId2].sub : {}
                    },
                    methods: {
                        clickDepth1: function (id) {
                            // log( 'click d1 : ' + id );
                            _actId1 = id;
                            _actId2 = this.depth1[_actId1].subId;
                            // this.actId1 = id;
                            _data.map(function (obj, i) {
                                obj.isOn = i == id ? true : false;
                            });
                            this.depth2 = _data[_actId1].sub ? _data[_actId1].sub : {};
                            this.depth3 = this.depth2[_actId2] && this.depth2[_actId2].sub ? this.depth2[_actId2].sub : {};
                            this.group = _data[_actId1].id == '0' ? false : true;
                        },
                        clickDepth2: function (id) {
                            // log( 'click d2 : ' + id );
                            _actId2 = id;
                            this.depth1[_actId1].subId = id;
                            this.depth2.map(function (obj, i) {
                                obj.isOn = i == id ? true : false;
                            });
                            this.depth3 = this.depth2[id].sub ? this.depth2[id].sub : {};
                        },
                        clickDepth3: function (id) {
                            // log( 'click d3 : ' + id );
                            _actId3 = id;
                            this.depth2[_actId2].subId = id;
                            this.depth3.map(function (obj, i) {
                                obj.isOn = i == id ? true : false;
                            });
                        }
                    }
                });
            };

            getId = function () {
                var actDepth1, actDepth2;
                var id1, id2, id3;
                var subId1, subId2;
                actDepth1 = _app.depth1[_actId1];
                subId1 = actDepth1.subId;
                actDepth2 = _app.depth2[subId1];
                subId2 = subId1 == -1 ? -1 : actDepth2.subId;

                id1 = actDepth1.id;
                id2 = subId1 == -1 ? 'none' : actDepth2.id;
                id3 = subId2 == -1 ? 'none' : _app.depth3[subId2].id;
                return [id1, id2, id3];
            };

            return {
                init: init,
                getId: getId
            }
        })();

        Period = (function () {
            var init;
            var _initVue, _getList, _validate;
            var _data;
            var _app;
            var _addEvent;

            init = function (period) {
                _initVue(period);
            };

            _getList = function (start, end) {
                var r = [];
                var i;
                var leng = end - start + 1;
                for (i = 0; i < leng; i++) {
                    r.push({ value: start + i, text: start + i + '년' });
                }
                return r;
            };

            _initVue = function (period) {
                // year, quater, month_period, month_select
                _app = new Vue({
                    el: sel.period,
                    data: {
                        type: 'year',
                        select: {
                            year: _getList(period.year[0], period.year[1]),
                            quater: _getList(period.quater[0], period.quater[1]),
                            month_period: _getList(period.month_period[0], period.month_period[1]),
                            month_select: _getList(period.month_select[0], period.month_select[1])
                        }
                    },
                    methods: {
                        okClick: function () {
                            if (app.trendData.isLoading()) return;
                            if (!_validate()) return;
                            _setting();
                        }
                    }
                });
            };

            _validate = function () {
                switch (_app.type) {
                    case 'quater':
                        if ($('input[ type=checkbox ][ name=quater ]:checked').length > 0) return true;
                        else return alert('분기 선택을 해 주세요.');
                        break;

                    case 'month_select':
                        if ($('input[ type=checkbox ][ name=month_select_m ]:checked').length > 0) return true;
                        else return alert('월 선택을 해 주세요.');
                        break;
                }
                return true;
            };

            return {
                init: init
            }
        })();

        return {
            init: init
        }
    })();

    app.namespace('trendCashFlow');
    app.trendCashFlow = (function () {
        var _isInitialized;
        var load;
        var _data;
        var _initData, _init, _update;
        var _graph1, _table3, _graph6;

        load = function (formData) {
            app.trendData.getTrend('cashFlow', formData, function (d) {
                _data = _initData(d);
                if (!_isInitialized) _init();
                else _update();
            });
        };

        _initData = function (dataTrend) {
            // chart1
            dataTrend.data1.map(function (obj, i) {
                obj.type = ['bar', 'bar', 'bar', 'line', 'line'][i];
                obj.color = ['#009de3', '#5575a8', '#6F7784', '#c112ae', '#eb6100'][i];
                obj.yAxis = 1;
                return obj;
            });
            dataTrend.data1[2].disabled = true;
            dataTrend.data1[4].disabled = true;

            // chart6
            dataTrend.data6.map(function (obj, i) {
                obj.type = ['line', 'line'][i];
                obj.color = ['#014099', '#009de3'][i];
                obj.yAxis = 1;
                return obj;
            });

            return dataTrend;
        };

        _init = function () {
            _isInitialized = true;

            _graph1 = MYAPP.graph.type13(_data.data1, '#chart1');
            _table3 = MYAPP.makeTable(_data.data3, '#chart3');
            _graph6 = MYAPP.graph.type13(_data.data6, '#chart6');
        };

        _update = function () {
            _graph1.update(_data.data1);
            _table3.update(_data.data3);
            _graph6.update(_data.data6);
        };

        return {
            load: load
        }
    })();

    app.namespace('trendPal');
    app.trendPal = (function () {
        var _isInitialized;
        var load;
        var _data;
        var _initData, _init, _update;
        var _graph1, _graph2;

        load = function (formData) {
            app.trendData.getTrend('pal', formData, function (d) {
                _data = _initData(d);
                if (!_isInitialized) _init();
                else _update();
            });
        };

        _initData = function (dataTrend) {
            // chart1
            dataTrend.data1.map(function (obj, i) {
                obj.type = ['line'][i];
                obj.color = ['#014099'][i];
                obj.yAxis = 1;
                return obj;
            });

            // chart2
            dataTrend.data2.map(function (obj, i) {
                obj.type = ['line', 'line'][i];
                obj.color = ['#014099', '#920783'][i];
                obj.yAxis = 1;
                return obj;
            });

            return dataTrend;
        };

        _init = function () {
            _isInitialized = true;

            _graph1 = MYAPP.graph.type13(_data.data1, '#chart1');
            _graph2 = MYAPP.graph.type13(_data.data2, '#chart2');
        };

        _update = function () {
            _graph1.update(_data.data1);
            _graph2.update(_data.data2);
        };

        return {
            load: load
        }
    })();

    app.namespace('trendFinancial');
    app.trendFinancial = (function () {
        var _isInitialized;
        var load;
        var _data;
        var _initData, _init, _update;
        var _graph1, _table4, _graph6, _table7;

        load = function (formData) {
            app.trendData.getTrend('financial', formData, function (d) {
                _data = _initData(d);
                if (!_isInitialized) _init();
                else _update();
            });
        };

        _initData = function (dataTrend) {
            // chart1
            dataTrend.data1.map(function (obj, i) {
                obj.type = ['line', 'line', 'line'][i];
                obj.color = ['#009de3', '#014099', '#920783'][i];
                obj.yAxis = 1;
                return obj;
            });

            // chart6
            dataTrend.data6.map(function (obj, i) {
                obj.type = ['line', 'line', 'line'][i];
                obj.color = ['#009de3', '#014099', '#920783'][i];
                obj.yAxis = 1;
                return obj;
            });

            return dataTrend;
        };

        _init = function () {
            _isInitialized = true;

            _graph1 = MYAPP.graph.type13(_data.data1, '#chart1');
            _table4 = MYAPP.makeTable(_data.data4, '#chart4');
            _graph6 = MYAPP.graph.type13(_data.data6, '#chart6');
            _table7 = MYAPP.makeTable(_data.data7, '#chart7');
        };

        _update = function () {
            _graph1.update(_data.data1);
            _table4.update(_data.data4);
            _graph6.update(_data.data6);
            _table7.update(_data.data7);
        };

        return {
            load: load
        }
    })();

    app.namespace('trendInvest');
    app.trendInvest = (function () {
        var _isInitialized;
        var load;
        var _data;
        var _initData, _init, _update, _checkBu;
        var _graph1, _graph2, _table5;

        load = function (formData) {
            app.trendData.getTrend('invest', formData, function (d) {
                _data = _initData(d);
                if (!_isInitialized) _init();
                else _update();
            });
            _checkBu(formData);
        };

        _initData = function (dataTrend) {
            // chart1
            dataTrend.data1.map(function (obj, i) {
                obj.type = ['line'][i];
                obj.color = ['#014099'][i];
                obj.yAxis = 1;
                return obj;
            });

            // chart2
            dataTrend.data2.map(function (obj, i) {
                obj.type = ['line'][i];
                obj.color = ['#920783'][i];
                obj.yAxis = 1;
                return obj;
            });

            return dataTrend;
        };

        _init = function () {
            _isInitialized = true;
           
            _graph1 = MYAPP.graph.type13(_data.data1, '#chart1');
            _graph2 = MYAPP.graph.type13(_data.data2, '#chart2');
            _table5 = MYAPP.makeTable(_data.data5, '#chart5');
        };

        _update = function () {
           // alert(JSON.stringify(_data.data1));
            _graph1.update(_data.data1);
            _graph2.update(_data.data2);
            _table5.update(_data.data5);
        };

        _checkBu = function (formData) {
            var $graph_box_wrap0 = $('#graph_box_wrap0');
            _checkBu = function (formData) {
                var id = formData.split('level0=')[1].charAt(0);
                id == 3 ? $graph_box_wrap0.hide() : $graph_box_wrap0.show();
            };
            _checkBu(formData);
            return _checkBu;
        };

        return {
            load: load
        }
    })();

    // main
    app.namespace('main');
    app.main = (function () {
        var _isInitialized;
        var init;

        init = function () {
            if (_isInitialized) return;
            _isInitialized = true;

            app.main.List.init();
            app.main.Stock.init();
            app.main.Exchange.init();
            app.main.Interest.init();
        };

        return {
            init: init
        }
    })();

    app.main.List = (function () {
        var init;
        var $sel;

        init = function () {
            $sel = { tbl_scroll: $('#container .tbl_scroll') };
            $sel.tbl_scroll.mCustomScrollbar({
                axis: 'y',
                theme: 'dark-thin',
                scrollInertia: 500,
                advanced: { autoExpandHorizontalScroll: true }
            });
        };

        return {
            init: init
        }
    })();

    app.main.Date = (function () {
        var getToday, getPast;
        var _setDate, _getR, _getPastMonth;

        _setDate = function (d) {
            var r = {};
            r.yyyy = d.getFullYear();
            r.mm = d.getMonth() + 1; //January is 0!
            r.dd = d.getDate();
            r.hr = d.getHours();
            r.mn = d.getMinutes();

            r.dd = r.dd < 10 ? '0' + r.dd : r.dd;
            r.mm = r.mm < 10 ? '0' + r.mm : r.mm;

            r.ymd = r.yyyy + '' + r.mm + '' + r.dd;
            r.ymd2 = r.yyyy + '/' + r.mm + '/' + r.dd;
            r.full = r.yyyy + '/' + r.mm + '/' + r.dd + ' ' + r.hr + ':' + r.mn;

            return r;
        };

        _getR = function (r) {
            return r.yyyy + '' + r.mm + '' + r.dd;
        };

        getToday = function (gap) {
            var d = new Date();
            d.setDate(d.getDate() + (gap || 0));
            var r = _setDate(d);
            return r;
        };

        _getPastMonth = function (d, m) {
            d.setMonth(d.getMonth() - m);
            var r = _setDate(d);
            return r;
        };

        getPast = function (d) {
            var r = [
				// { name: 'yesterday', date: getToday( -1 ) },
				{ name: 'm3', date: _getPastMonth(d, 3) },
				{ name: 'm6', date: _getPastMonth(d, 3) },
				{ name: 'm9', date: _getPastMonth(d, 3) },
				{ name: 'm12', date: _getPastMonth(d, 3) }
            ];
            return r;
        };

        return {
            getToday: getToday,
            getPast: getPast
        }
    })();

    app.main.Data = (function () {
        var _isLoading = false;
        var _url;
        var getStock, getExchange, getInterest;

        _url = {
            stock: '/Main/krx',
            exchange: '/Main/koreaexim',
            interest: '/Main/bok'
        };

        getStock = function (code, cb) {
            log('ajax getStock ---------------------------------');
            _isLoading = true;
            $.ajax({
                url: _url.stock + '?code=' + code,
                method: 'GET'
            }).done(function (data) {
                _isLoading = false;
                cb(data);
            }).fail(function (e) {
                log("getStock fail");
                log(_url.stock + '?code=' + code);
                _isLoading = false;
            });
        };

        getExchange = function (date, cb) {
            log('ajax getExchange ---------------------------------');
            var auth = 'O7ZSAh9oz5Mtl9C1I8OwSIMfKRiiD8GD';
            _isLoading = true;
            $.ajax({
                url: _url.exchange + '?authkey=' + auth + '&searchdate=' + date + '&data=AP01',
                method: 'GET',
                dataType: 'json'
            }).done(function (data) {
                _isLoading = false;
                cb(data);
            }).fail(function (e) {
                log("getExchange fail");
                log(_url.exchange + '?authkey=' + auth + '&searchdate=' + date + '&data=AP01');
                _isLoading = false;
            });
        };

        getInterest = function (code, sDate, eDate, cb) {
            log('ajax getInterest ---------------------------------');
            var auth = 'A1Q6X0S2V6SUB34SWSXH';
            _isLoading = true;
            $.ajax({
                url: _url.interest + '?data=StatisticSearch/' + auth + '/json/kr/1/10/060Y001/DD/' + sDate + '/' + eDate + '/' + code + '/',
                method: 'GET',
                dataType: 'json'
            }).done(function (data) {
                _isLoading = false;
                cb(data);
            }).fail(function (e) {
                log("getInterest fail");
                log(_url.interest + '?data=StatisticSearch/' + auth + '/xml/kr/1/10/060Y001/DD/' + sDate + '/' + eDate + '/' + code + '/');
                _isLoading = false;
            });
        };

        return {
            getStock: getStock,
            getExchange: getExchange,
            getInterest: getInterest
        }

    })();

    app.main.Stock = (function () {
        var init;
        var $sel;
        var _initSelect, _load, _loadComplete;
        var _companyData = {
            hallaGroup: [{ name: '한라홀딩스', code: '060980' }, { name: '만도', code: '204320' }, { name: '㈜한라', code: '014790' }],
            mando: [{ name: '현대모비스', code: '012330' }, { name: 'S&T 모티브', code: '064960' }, { name: '에스엘', code: '005850' }],
            halla: [{ name: '한신공영', code: '004960' }, { name: '계룡건설', code: '013580' }, { name: '태영건설', code: '009410' }]
        };

        init = function () {
            $sel = {
                select: $('.main_box.stock .p_right select'),
                querytime: $('.main_box.stock .p_right .querytime'),
                stock: $('.main_box.stock .stock_content'),
                loading: $('.main_box.stock .loading')
            };

            _initSelect();
            _load($sel.select.val());
        };

        _initSelect = function () {
            $sel.select.on('change', function (e) {
                _load($(this).val());
            });
        };

        _load = function (gr) {
            var list = _companyData[gr];
            var leng = list.length;
            var count = 0;
            var dataArr = [];
            $sel.querytime.text('');
            list.forEach(function (obj, i) {
                var $stock = $sel.stock.eq(i);
                var arr = ['name', 'code', 'CurJuka', 'DungRak', 'Debi_num', 'Debi_p'];
                arr.forEach(function (str) { $stock.find('.' + str).text('-'); });

                app.main.Data.getStock(obj.code, function (data) {
                    var r = {};
                    var mark = { 1: '▲', 2: '▲', 3: '-', 4: '▼', 5: '▼' };
                    var xml = $('<xml>' + data + '</xml>');
                    var TBL_StockInfo, CurJuka, PrevJuka;

                    TBL_StockInfo = xml.find('TBL_StockInfo');
                    CurJuka = TBL_StockInfo.attr('CurJuka').replace(/,/g, "");
                    PrevJuka = TBL_StockInfo.attr('PrevJuka').replace(/,/g, "");

                    r.querytime = xml.find('stockprice').attr('querytime');
                    r.myJangGubun = xml.find('stockInfo ').attr('myJangGubun');
                    r.name = obj.name;
                    r.code = obj.code;
                    r.JongName = TBL_StockInfo.attr('JongName');
                    r.CurJuka = CurJuka ? d3.format(',')(CurJuka) : '-';
                    r.DungRak = mark[TBL_StockInfo.attr('DungRak')];
                    r.Debi_num = d3.format(',')(Math.abs(CurJuka - PrevJuka));
                    r.Debi_p = d3.format(',.2f')((CurJuka - PrevJuka) / PrevJuka * 100 || 0);

                    dataArr[i] = r;
                    count++;
                    log('Stock count : ' + count);
                    if (count == leng) _loadComplete(dataArr);
                });
            });
            $sel.select.prop('disabled', true);
            // $sel.loading.css( 'visibility', 'visible' );
            TweenLite.to($sel.loading, 0.2, { autoAlpha: 1, ease: Power2.easeOut });
        };

        _loadComplete = function (data) {
            log('_loadComplete Stock');
            $sel.querytime.text(data[0].querytime + ' 기준(' + data[0].myJangGubun + ')');
            data.forEach(function (obj, i) {
                var $stock = $sel.stock.eq(i);
                var arr = ['name', 'code', 'CurJuka', 'DungRak', 'Debi_num', 'Debi_p'];
                arr.forEach(function (str) { $stock.find('.' + str).text(obj[str]); });
            });
            $sel.select.prop('disabled', false);
            TweenLite.to($sel.loading, 0.5, { autoAlpha: 0, ease: Power2.easeOut });
        };

        return {
            init: init
        }
    })();

    app.main.Exchange = (function () {
        var init;
        var $sel;
        var _load, _loadComplete, _draw;

        init = function () {
            $sel = {
                p_right: $('.main_box.exchange .p_right'),
                exchange: $('.main_box.exchange .exchange_content'),
                loading: $('.main_box.exchange .loading')
            };

            _load();
        };

        _load = function () {
            var today = app.main.Date.getToday();

            var load = function (gap, cb) {
                var day = app.main.Date.getToday(gap);
                app.main.Data.getExchange(day.ymd, function (data) {
                    if (data.length) {
                        cb(data, day, gap);
                    } else {
                        if (gap < -20) return;
                        load(--gap, cb);
                    }
                });
            };

            load(0, function (dataToday, day, gap) {
                log('Exchange count : ' + 1);
                $sel.p_right.text(day.full + ' 기준');

                load(--gap, function (dataYesterday, day) {
                    log('Exchange count : ' + 2);
                    var data = _loadComplete(dataToday, dataYesterday);
                    _draw(data);
                });
            });
        };

        _loadComplete = function (dataToday, dataYesterday) {
            var nation = [{ name: '미국', cur_unit: 'USD' }, { name: '유럽연합', cur_unit: 'EUR' }, { name: '중국', cur_unit: 'CNH' }, { name: '일본', cur_unit: 'JPY' }];
            var r = [],
				today = {},
				yesterday = {};

            nation.forEach(function (nationObj, i) {
                var modeling = function (accumulator, obj) {
                    obj.cur_unit.indexOf(nationObj.cur_unit) > -1 ? accumulator[nationObj.cur_unit] = obj : accumulator;
                    return accumulator;
                };
                dataToday.reduce(modeling, today);
                dataYesterday.reduce(modeling, yesterday);
            });

            nation.forEach(function (nationObj, i) {
                var obj = {};
                var cur, prev;
                cur = today[nationObj.cur_unit].deal_bas_r.replace(/,/g, "");;
                prev = yesterday[nationObj.cur_unit].deal_bas_r.replace(/,/g, "");;

                obj.name = nationObj.name;
                obj.cur_unit = nationObj.cur_unit;
                obj.deal_bas_r = d3.format(',')(cur);
                obj.prev = d3.format(',')(prev);
                obj.DungRak = cur < prev ? '▼' : cur > prev ? '▲' : '-';
                obj.Debi_num = d3.format(',.2f')(Math.abs(cur - prev));
                obj.Debi_p = d3.format(',.2f')((cur - prev) / prev * 100 || 0);

                r[i] = obj;
            });
            return r;
        };

        _draw = function (data) {
            log('_loadComplete Exchange');
            data.forEach(function (obj, i) {
                var $exchange = $sel.exchange.eq(i);
                var arr = ['name', 'cur_unit', 'deal_bas_r', 'DungRak', 'Debi_num', 'Debi_p'];
                arr.forEach(function (str) { $exchange.find('.' + str).text(obj[str]); });
                $exchange.find('.flag img').attr('src', '/Contents/user/Common/img/exchange_flag_' + obj['cur_unit'] + '.png');
            });
            TweenLite.to($sel.loading, 0.5, { autoAlpha: 0, ease: Power2.easeOut });
        };

        return {
            init: init
        }
    })();

    app.main.Interest = (function () {
        var init;
        var $sel;
        var _load, _draw;

        init = function () {
            $sel = {
                p_right: $('.main_box.interest .p_right'),
                interest: $('.main_box.interest .interest_content'),
                loading: $('.main_box.interest .loading')
            };

            _load();
        };

        _load = function () {
            var r;
            var type = ['010300000', '010200000', '010502000']; // '회사채(3년,AA-)', '국고채(3년)', 'CD(91일)'
            var calcDate = function (str) {
                return {
                    yyyy: str.substring(0, 4),
                    mm: str.substring(4, 6),
                    dd: str.substring(6, 8)
                }
            };
            var loadComplete = function (data, i) {
                var d = data.StatisticSearch.row[data.StatisticSearch.row.length - 1];
                var date = calcDate(d.TIME);
                r[i][0] = {
                    title: d.ITEM_NAME1,
                    num: d.DATA_VALUE,
                    time: date.yyyy + '/' + date.mm + '/' + date.dd
                };
                return date;
            };
            var loadFirst = function () {
                var count = 0;
                var leng = type.length;
                r = type.map(function (code, i) {
                    app.main.Data.getInterest(code, app.main.Date.getToday(-11).ymd, app.main.Date.getToday(-1).ymd, function (data) {
                        var date = loadComplete(data, i);
                        count++;
                        log('Interest first count : ' + count);
                        if (count == leng) loadNext(date);
                    });
                    return [];
                });
            };
            var loadNext = function (date) {
                $sel.p_right.text(date.yyyy + '/' + date.mm + '/' + date.dd + ' 기준');

                var past = app.main.Date.getPast(new Date(date.yyyy, date.mm - 1, date.dd));
                var count = 0;
                var leng = type.length * past.length;
                type.forEach(function (code, i) {
                    return past.map(function (obj, j) {
                        app.main.Data.getInterest(code, obj.date.ymd, obj.date.ymd, function (data) {
                            if (data.RESULT == undefined) {
                                var d = data.StatisticSearch.row[data.StatisticSearch.row.length - 1];
                                var date = calcDate(d.TIME);
                                r[i][j + 1] = {
                                    title: d.ITEM_NAME1,
                                    num: d.DATA_VALUE,
                                    time: obj.date.ymd2
                                };
                            } else {
                                r[i][j + 1] = {
                                    title: '-',
                                    num: '-',
                                    time: obj.date.ymd2
                                };
                            }
                            count++;
                            log('Interest count : ' + count);
                            if (count == leng) _draw(r);
                        });
                    });
                });
            };
            loadFirst();
        };

        _draw = function (data) {
            log('_loadComplete Interest');
            // log( data );
            data.forEach(function (arr, i) {
                var $interest = $sel.interest.eq(i);
                var $tbody = $interest.find('tbody').empty();
                arr.forEach(function (obj, j) {
                    if (j == 0) {
                        $interest.find('th.title').text(obj.title);
                        $interest.find('th.num').text(obj.num);
                    } else {
                        $tbody.append('<tr> <td>' + obj.time + '</td> <td class="num">' + obj.num + '</td> </tr>');
                    }
                });
            });
            TweenLite.to($sel.loading, 0.5, { autoAlpha: 0, ease: Power2.easeOut });
        };

        return {
            init: init
        }
    })();


})(MYAPP || {}, jQuery);
//------------------------MYAPP 종료------------------------------
