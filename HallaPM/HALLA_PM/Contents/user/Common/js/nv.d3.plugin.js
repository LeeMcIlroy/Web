( function( nv ) {
  var detector = (function(){
      var agent = window.navigator.userAgent.toLowerCase();
      var device = 'pc', t0;
      if( agent.indexOf( 'android' ) > -1 ) {
        if( agent.indexOf( 'mobile' ) == -1 ) device = 'tablet';
        else device = 'mobile';
      } else if( agent.indexOf( t0 = 'ipad' ) > -1 || agent.indexOf( t0 = 'iphone' ) > -1 ) {
        device = t0 == 'ipad' ? 'tablet' : 'mobile';
      }
      return {
        device : device
      };
  })();
  nv.models.historicalBar2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var margin = {top: 0, right: 0, bottom: 0, left: 0}
          , width = null
          , height = null
          , id = Math.floor(Math.random() * 10000) //Create semi-unique ID in case user doesn't select one
          , container = null
          , x = d3.scale.linear()
          , y = d3.scale.linear()
          , getX = function(d) { return d.x }
          , getY = function(d) { return d.y }
          , forceX = []
          , forceY = [0]
          , padData = false
          , clipEdge = true
          , color = nv.utils.defaultColor()
          , xDomain
          , yDomain
          , xRange
          , yRange
          , dispatch = d3.dispatch('chartClick', 'elementClick', 'elementDblClick', 'elementMouseover', 'elementMouseout', 'elementMousemove', 'renderEnd')
          , interactive = true
          ;

      var renderWatch = nv.utils.renderWatch(dispatch, 0);

      function chart(selection) {
          selection.each(function(data) {
              renderWatch.reset();

              container = d3.select(this);
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);

              nv.utils.initSVG(container);
              data.forEach(function(series) {
                var key = series.key;
                  series.values.forEach(function(point) {
                      if( key !== undefined ) point.key = key;
                  });
              });

              // Setup Scales
              x.domain(xDomain || d3.extent(data[0].values.map(getX).concat(forceX) ));

              if (padData)
                  x.range(xRange || [availableWidth * .5 / data[0].values.length, availableWidth * (data[0].values.length - .5)  / data[0].values.length ]);
              else
                  x.range(xRange || [0, availableWidth]);

              y.domain(yDomain || d3.extent(data[0].values.map(getY).concat(forceY) ))
                  .range(yRange || [availableHeight, 0]);

              // If scale's domain don't have a range, slightly adjust to make one... so a chart can show a single data point
              if (x.domain()[0] === x.domain()[1])
                  x.domain()[0] ?
                      x.domain([x.domain()[0] - x.domain()[0] * 0.01, x.domain()[1] + x.domain()[1] * 0.01])
                      : x.domain([-1,1]);

              if (y.domain()[0] === y.domain()[1])
                  y.domain()[0] ?
                      y.domain([y.domain()[0] + y.domain()[0] * 0.01, y.domain()[1] - y.domain()[1] * 0.01])
                      : y.domain([-1,1]);

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-historicalBar-' + id).data([data[0].values]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-historicalBar-' + id);
              var defsEnter = wrapEnter.append('defs');
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-bars');
              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              container
                  .on('click', function(d,i) {
                      dispatch.chartClick({
                          data: d,
                          index: i,
                          pos: d3.event,
                          id: id
                      });
                  });

              defsEnter.append('clipPath')
                  .attr('id', 'nv-chart-clip-path-' + id)
                  .append('rect');

              wrap.select('#nv-chart-clip-path-' + id + ' rect')
                  .attr('width', availableWidth)
                  .attr('height', availableHeight);

              g.attr('clip-path', clipEdge ? 'url(#nv-chart-clip-path-' + id + ')' : '');

              var bars = wrap.select('.nv-bars').selectAll('.nv-bar')
                  .data(function(d) { return d }, function(d,i) {return getX(d,i)});
              bars.exit().remove();

              var barsEnter = bars.enter().append('g')
                  // .attr('x', 0 )
                  // .attr('y', function(d,i) {  return nv.utils.NaNtoZero(y(Math.max(0, getY(d,i)))) })
                  // .attr('height', function(d,i) { return nv.utils.NaNtoZero(Math.abs(y(getY(d,i)) - y(0))) })
                  .attr('transform', function(d,i) { return 'translate(' + (x(getX(d,i)) - availableWidth / data[0].values.length * .45) + ',' + nv.utils.NaNtoZero(y(Math.max(0, getY(d,i)))) + ')'; })
                  .on('mouseover', function(d,i) {
                      if (!interactive) return;
                      // d3.select(this).classed('hover', true);
                      dispatch.elementMouseover({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });

                  })
                  .on('mouseout', function(d,i) {
                      if (!interactive) return;
                      // d3.select(this).classed('hover', false);
                      dispatch.elementMouseout({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('mousemove', function(d,i) {
                      if (!interactive) return;
                      dispatch.elementMousemove({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('click', function(d,i) {
                      if (!interactive) return;
                      var element = this;
                      dispatch.elementClick({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill"),
                          event: d3.event,
                          element: element
                      });
                      d3.event.stopPropagation();
                  })
                  .on('dblclick', function(d,i) {
                      if (!interactive) return;
                      dispatch.elementDblClick({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                      d3.event.stopPropagation();
                  });

              bars
                  .attr('fill', function(d,i) { return color(d, i); })
                  .attr('class', function(d,i,j) { return (getY(d,i) < 0 ? 'nv-bar negative' : 'nv-bar positive') + ' nv-bar-' + j + '-' + i })
                  .watchTransition(renderWatch, 'bars')
                  // .attr('transform', function(d,i) { return 'translate(' + (x(getX(d,i)) - availableWidth / data[0].values.length * .45) + ',0)'; })
                  //TODO: better width calculations that don't assume always uniform data spacing;w
                  // .attr('width', (availableWidth / data[0].values.length) * .9 )
                  ;

              barsEnter.append('rect')
                  .attr('width', (availableWidth / data[0].values.length) * .8 )
                  .attr('height', function(d,i) { return nv.utils.NaNtoZero(Math.abs(y(getY(d,i)) - y(0))) })
                  ;
              barsEnter.append('text')
                .style('fill', function(d,i) { return color(d, i); })
                .style('fill-opacity', 1)
                .style('stroke-opacity', 0)
                .attr('text-anchor', 'middle')
                .text(function(d,i) { return d3.format(',.0f')( d.y ) })
                .attr('x', (availableWidth / data[0].values.length) * .4)
                .attr('y',  -4 )
                ;

              var barSelection =
                bars.watchTransition(renderWatch, 'bars')
                    // .attr('y', function(d,i) {
                    //     var rval = getY(d,i) < 0 ?
                    //         y(0) :
                    //             y(0) - y(getY(d,i)) < 1 ?
                    //         y(0) - 1 :
                    //         y(getY(d,i));
                    //     return nv.utils.NaNtoZero(rval);
                    // })
                    .attr('transform', function(d,i) { return 'translate(' + (x(getX(d,i)) - availableWidth / data[0].values.length * .45) + ',' + nv.utils.NaNtoZero(y(Math.max(0, getY(d,i)))) + ')'; })
                    .attr('height', function(d,i) { return nv.utils.NaNtoZero(Math.max(Math.abs(y(getY(d,i)) - y(0)),1)) });

                barSelection.select('rect')
                    .attr('width', (availableWidth / data[0].values.length) * .8 )
                    .attr('height', function(d,i) { return nv.utils.NaNtoZero(Math.abs(y(getY(d,i)) - y(0))) })
                    ;
                barSelection.select('text')
                    .attr('x', (availableWidth / data[0].values.length) * .4)
                    ;

          });

          renderWatch.renderEnd('historicalBar immediate');
          return chart;
      }

      //Create methods to allow outside functions to highlight a specific bar.
      chart.highlightPoint = function(pointIndex, isHoverOver) {
          container
              .select(".nv-bars .nv-bar-0-" + pointIndex)
              .classed("hover", isHoverOver)
          ;
      };

      chart.clearHighlights = function() {
          container
              .select(".nv-bars .nv-bar.hover")
              .classed("hover", false)
          ;
      };

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:   {get: function(){return width;}, set: function(_){width=_;}},
          height:  {get: function(){return height;}, set: function(_){height=_;}},
          forceX:  {get: function(){return forceX;}, set: function(_){forceX=_;}},
          forceY:  {get: function(){return forceY;}, set: function(_){forceY=_;}},
          padData: {get: function(){return padData;}, set: function(_){padData=_;}},
          x:       {get: function(){return getX;}, set: function(_){getX=_;}},
          y:       {get: function(){return getY;}, set: function(_){getY=_;}},
          xScale:  {get: function(){return x;}, set: function(_){x=_;}},
          yScale:  {get: function(){return y;}, set: function(_){y=_;}},
          xDomain: {get: function(){return xDomain;}, set: function(_){xDomain=_;}},
          yDomain: {get: function(){return yDomain;}, set: function(_){yDomain=_;}},
          xRange:  {get: function(){return xRange;}, set: function(_){xRange=_;}},
          yRange:  {get: function(){return yRange;}, set: function(_){yRange=_;}},
          clipEdge:    {get: function(){return clipEdge;}, set: function(_){clipEdge=_;}},
          id:          {get: function(){return id;}, set: function(_){id=_;}},
          interactive: {get: function(){return interactive;}, set: function(_){interactive=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }}
      });

      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.legend2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var margin = {top: 0, right: 0, bottom: 0, left: 0}
          , width = 400
          , height = 20
          , getKey = function(d) { return d.key }
          , keyFormatter = function (d) { return d }
          , color = nv.utils.getColor()
          , maxKeyLength = 20 //default value for key lengths
          , align = true
          , padding = 32 //define how much space between legend items. - recommend 32 for furious version
          , rightAlign = true
          , updateState = true   //If true, legend will update data.disabled and trigger a 'stateChange' dispatch.
          , radioButtonMode = false   //If true, clicking legend items will cause it to behave like a radio button. (only one can be selected at a time)
          , expanded = false
          , dispatch = d3.dispatch('legendClick', 'legendDblclick', 'legendMouseover', 'legendMouseout', 'stateChange')
          , vers = 'classic' //Options are "classic" and "furious"
          ;

      function chart(selection) {
          selection.each(function(data) {
              var availableWidth = width - margin.left - margin.right,
                  container = d3.select(this);
              nv.utils.initSVG(container);

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-legend').data([data]);
              var gEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-legend').append('g');
              var g = wrap.select('g');

              if (rightAlign)
                  wrap.attr('transform', 'translate(' + (- margin.right) + ',' + margin.top + ')');
              else
                  wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              var series = g.selectAll('.nv-series')
                  .data(function(d) {
                      if(vers != 'furious') return d;

                      return d.filter(function(n) {
                          return expanded ? true : !n.disengaged;
                      });
                  });

              var seriesEnter = series.enter().append('g').attr('class', 'nv-series no-cursor');
              var seriesShape;

              var versPadding;
              switch(vers) {
                  case 'furious' :
                      versPadding = 23;
                      break;
                  case 'classic' :
                      versPadding = 20;
              }

              if(vers == 'classic') {
                  seriesEnter.append('path')
                      .attr('d',
                          nv.utils.symbol()
                          .type(function(d) { return d.shape || 'square'; })
                          .size(function(d) { return d3.scale.linear()(d.size || 80) })
                      )
                      .style('stroke-width', 1)
                      .attr('class','nv-legend-symbol')
                      ;
                  // seriesEnter.append('circle')
                  //     .style('stroke-width', 2)
                  //     .attr('class','nv-legend-symbol')
                  //     .attr('r', 5);

                  seriesShape = series.select('.nv-legend-symbol');
              } else if (vers == 'furious') {
                  seriesEnter.append('rect')
                      .style('stroke-width', 2)
                      .attr('class','nv-legend-symbol')
                      .attr('rx', 3)
                      .attr('ry', 3);
                  seriesShape = series.select('.nv-legend-symbol');

                  seriesEnter.append('g')
                      .attr('class', 'nv-check-box')
                      .property('innerHTML','<path d="M0.5,5 L22.5,5 L22.5,26.5 L0.5,26.5 L0.5,5 Z" class="nv-box"></path><path d="M5.5,12.8618467 L11.9185089,19.2803556 L31,0.198864511" class="nv-check"></path>')
                      .attr('transform', 'translate(-10,-8)scale(0.5)');

                  var seriesCheckbox = series.select('.nv-check-box');

                  seriesCheckbox.each(function(d,i) {
                      d3.select(this).selectAll('path')
                          .attr('stroke', setTextColor(d,i));
                  });
              }

              seriesEnter.append('text')
                  .attr('text-anchor', 'start')
                  .attr('class','nv-legend-text')
                  .attr('dy', '.32em')
                  .attr('dx', '8');

              var seriesText = series.select('text.nv-legend-text');

              // series
              //     .on('mouseover', function(d,i) {
              //         dispatch.legendMouseover(d,i);  //TODO: Make consistent with other event objects
              //     })
              //     .on('mouseout', function(d,i) {
              //         dispatch.legendMouseout(d,i);
              //     })
              //     .on('click', function(d,i) {
              //         dispatch.legendClick(d,i);
              //         // make sure we re-get data in case it was modified
              //         var data = series.data();
              //         if (updateState) {
              //             if(vers =='classic') {
              //                 if (radioButtonMode) {
              //                     //Radio button mode: set every series to disabled,
              //                     //  and enable the clicked series.
              //                     data.forEach(function(series) { series.disabled = true});
              //                     d.disabled = false;
              //                 }
              //                 else {
              //                     d.disabled = !d.disabled;
              //                     if (data.every(function(series) { return series.disabled})) {
              //                         //the default behavior of NVD3 legends is, if every single series
              //                         // is disabled, turn all series' back on.
              //                         data.forEach(function(series) { series.disabled = false});
              //                     }
              //                 }
              //             } else if(vers == 'furious') {
              //                 if(expanded) {
              //                     d.disengaged = !d.disengaged;
              //                     d.userDisabled = d.userDisabled == undefined ? !!d.disabled : d.userDisabled;
              //                     d.disabled = d.disengaged || d.userDisabled;
              //                 } else if (!expanded) {
              //                     d.disabled = !d.disabled;
              //                     d.userDisabled = d.disabled;
              //                     var engaged = data.filter(function(d) { return !d.disengaged; });
              //                     if (engaged.every(function(series) { return series.userDisabled })) {
              //                         //the default behavior of NVD3 legends is, if every single series
              //                         // is disabled, turn all series' back on.
              //                         data.forEach(function(series) {
              //                             series.disabled = series.userDisabled = false;
              //                         });
              //                     }
              //                 }
              //             }
              //             dispatch.stateChange({
              //                 disabled: data.map(function(d) { return !!d.disabled }),
              //                 disengaged: data.map(function(d) { return !!d.disengaged })
              //             });
              //
              //         }
              //     })
              //     .on('dblclick', function(d,i) {
              //         if(vers == 'furious' && expanded) return;
              //         dispatch.legendDblclick(d,i);
              //         if (updateState) {
              //             // make sure we re-get data in case it was modified
              //             var data = series.data();
              //             //the default behavior of NVD3 legends, when decimal clicking one,
              //             // is to set all other series' to false, and make the decimal clicked series enabled.
              //             data.forEach(function(series) {
              //                 series.disabled = true;
              //                 if(vers == 'furious') series.userDisabled = series.disabled;
              //             });
              //             d.disabled = false;
              //             if(vers == 'furious') d.userDisabled = d.disabled;
              //             dispatch.stateChange({
              //                 disabled: data.map(function(d) { return !!d.disabled })
              //             });
              //         }
              //     });

              series.classed('nv-disabled', function(d) { return d.userDisabled });
              series.exit().remove();

              seriesText
                  .attr('fill', setTextColor)
                  .text(function (d) { return keyFormatter(getKey(d)) });

              //TODO: implement fixed-width and max-width options (max-width is especially useful with the align option)
              // NEW ALIGNING CODE, TODO: clean up
              var legendWidth = 0;
              if (align) {

                  var seriesWidths = [];
                  series.each(function(d,i) {
                      var legendText;
                      if (keyFormatter(getKey(d)) && keyFormatter(getKey(d)).length > maxKeyLength) {
                          var trimmedKey = keyFormatter(getKey(d)).substring(0, maxKeyLength);
                          legendText = d3.select(this).select('text').text(trimmedKey + "...");
                          d3.select(this).append("svg:title").text(keyFormatter(getKey(d)));
                      } else {
                          legendText = d3.select(this).select('text');
                      }
                      var nodeTextLength;
                      try {
                          nodeTextLength = legendText.node().getComputedTextLength();
                          // If the legendText is display:none'd (nodeTextLength == 0), simulate an error so we approximate, instead
                          if(nodeTextLength <= 0) throw Error();
                      }
                      catch(e) {
                          nodeTextLength = nv.utils.calcApproxTextWidth(legendText);
                      }

                      seriesWidths.push(nodeTextLength + padding);
                  });

                  var seriesPerRow = 0;
                  var columnWidths = [];
                  legendWidth = 0;

                  while ( legendWidth < availableWidth && seriesPerRow < seriesWidths.length) {
                      columnWidths[seriesPerRow] = seriesWidths[seriesPerRow];
                      legendWidth += seriesWidths[seriesPerRow++];
                  }
                  if (seriesPerRow === 0) seriesPerRow = 1; //minimum of one series per row

                  while ( legendWidth > availableWidth && seriesPerRow > 1 ) {
                      columnWidths = [];
                      seriesPerRow--;

                      for (var k = 0; k < seriesWidths.length; k++) {
                          if (seriesWidths[k] > (columnWidths[k % seriesPerRow] || 0) )
                              columnWidths[k % seriesPerRow] = seriesWidths[k];
                      }

                      legendWidth = columnWidths.reduce(function(prev, cur, index, array) {
                          return prev + cur;
                      });
                  }

                  var xPositions = [];
                  for (var i = 0, curX = 0; i < seriesPerRow; i++) {
                      xPositions[i] = curX;
                      curX += columnWidths[i];
                  }

                  series
                      .attr('transform', function(d, i) {
                          return 'translate(' + xPositions[i % seriesPerRow] + ',' + (5 + Math.floor(i / seriesPerRow) * versPadding) + ')';
                      });

                  //position legend as far right as possible within the total width
                  if (rightAlign) {
                      g.attr('transform', 'translate(' + (width - margin.right - legendWidth) + ',' + margin.top + ')');
                  }
                  else {
                      g.attr('transform', 'translate(' + (width - legendWidth) / 2 + ',' + margin.top + ')');
                  }

                  height = margin.top + margin.bottom + (Math.ceil(seriesWidths.length / seriesPerRow) * versPadding);

              } else {

                  var ypos = 5,
                      newxpos = 5,
                      maxwidth = 0,
                      xpos;
                  series
                      .attr('transform', function(d, i) {
                          var length = d3.select(this).select('text').node().getComputedTextLength() + padding;
                          xpos = newxpos;

                          if (width < margin.left + margin.right + xpos + length) {
                              newxpos = xpos = 5;
                              ypos += versPadding;
                          }

                          newxpos += length;
                          if (newxpos > maxwidth) maxwidth = newxpos;

                          if(legendWidth < xpos + maxwidth) {
                              legendWidth = xpos + maxwidth;
                          }
                          return 'translate(' + xpos + ',' + ypos + ')';
                      });

                  //position legend as far right as possible within the total width
                  g.attr('transform', 'translate(' + (width - margin.right - maxwidth) + ',' + margin.top + ')');

                  height = margin.top + margin.bottom + ypos + 15;
              }

              if(vers == 'furious') {
                  // Size rectangles after text is placed
                  seriesShape
                      .attr('width', function(d,i) {
                          return seriesText[0][i].getComputedTextLength() + 27;
                      })
                      .attr('height', 18)
                      .attr('y', -9)
                      .attr('x', -15);

                  // The background for the expanded legend (UI)
                  gEnter.insert('rect',':first-child')
                      .attr('class', 'nv-legend-bg')
                      .attr('fill', '#eee')
                      // .attr('stroke', '#444')
                      .attr('opacity',0);

                  var seriesBG = g.select('.nv-legend-bg');

                  seriesBG
                  .transition().duration(300)
                      .attr('x', -versPadding )
                      .attr('width', legendWidth + versPadding - 12)
                      .attr('height', height + 10)
                      .attr('y', -margin.top - 10)
                      .attr('opacity', expanded ? 1 : 0);


              }

              seriesShape
                  .style('fill', setBGColor)
                  .style('fill-opacity', setBGOpacity)
                  .style('stroke', setBGColor);
          });

          function setTextColor(d,i) {
              if(vers != 'furious') return '#000';
              if(expanded) {
                  return d.disengaged ? '#000' : '#fff';
              } else if (!expanded) {
                  if(!d.color) d.color = color(d,i);
                  return !!d.disabled ? d.color : '#fff';
              }
          }

          function setBGColor(d,i) {
              if(expanded && vers == 'furious') {
                  return d.disengaged ? '#eee' : d.color || color(d,i);
              } else {
                  return d.color || color(d,i);
              }
          }


          function setBGOpacity(d,i) {
              if(expanded && vers == 'furious') {
                  return 1;
              } else {
                  return !!d.disabled ? 0 : 1;
              }
          }

          return chart;
      }

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:          {get: function(){return width;}, set: function(_){width=_;}},
          height:         {get: function(){return height;}, set: function(_){height=_;}},
          key:            {get: function(){return getKey;}, set: function(_){getKey=_;}},
          keyFormatter:   {get: function(){return keyFormatter;}, set: function(_){keyFormatter=_;}},
          align:          {get: function(){return align;}, set: function(_){align=_;}},
          maxKeyLength:   {get: function(){return maxKeyLength;}, set: function(_){maxKeyLength=_;}},
          rightAlign:     {get: function(){return rightAlign;}, set: function(_){rightAlign=_;}},
          padding:        {get: function(){return padding;}, set: function(_){padding=_;}},
          updateState:    {get: function(){return updateState;}, set: function(_){updateState=_;}},
          radioButtonMode:{get: function(){return radioButtonMode;}, set: function(_){radioButtonMode=_;}},
          expanded:       {get: function(){return expanded;}, set: function(_){expanded=_;}},
          vers:           {get: function(){return vers;}, set: function(_){vers=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }}
      });

      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.legend3 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var margin = {top: 0, right: 0, bottom: 0, left: 0}
          , width = 400
          , height = 20
          , getKey = function(d) { return d.key }
          , keyFormatter = function (d) { return d }
          , color = nv.utils.getColor()
          , maxKeyLength = 20 //default value for key lengths
          , align = true
          , padding = 32 //define how much space between legend items. - recommend 32 for furious version
          , rightAlign = true
          , updateState = true   //If true, legend will update data.disabled and trigger a 'stateChange' dispatch.
          , radioButtonMode = false   //If true, clicking legend items will cause it to behave like a radio button. (only one can be selected at a time)
          , expanded = false
          , dispatch = d3.dispatch('legendClick', 'legendDblclick', 'legendMouseover', 'legendMouseout', 'stateChange')
          , vers = 'classic' //Options are "classic" and "furious"
          ;

      function chart(selection) {
          selection.each(function(data) {
              var availableWidth = width - margin.left - margin.right,
                  container = d3.select(this);
              nv.utils.initSVG(container);

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-legend').data([data]);
              var gEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-legend').append('g');
              var g = wrap.select('g');

              if (rightAlign)
                  wrap.attr('transform', 'translate(' + (- margin.right) + ',' + margin.top + ')');
              else
                  wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              var series = g.selectAll('.nv-series')
                  .data(function(d) {
                      if(vers != 'furious') return d;

                      return d.filter(function(n) {
                          return expanded ? true : !n.disengaged;
                      });
                  });

              var seriesEnter = series.enter().append('g').attr('class', 'nv-series');
              var seriesShape;

              var versPadding;
              switch(vers) {
                  case 'furious' :
                      versPadding = 23;
                      break;
                  case 'classic' :
                      versPadding = 20;
              }

              if(vers == 'classic') {
                  seriesEnter.append('path')
                      .attr('d',
                          nv.utils.symbol()
                          .type(function(d) { return d.shape || 'square'; })
                          .size(function(d) { return d3.scale.linear()(d.size || 80) })
                      )
                      .style('stroke-width', 1)
                      .attr('class','nv-legend-symbol')
                      ;
                  // seriesEnter.append('circle')
                  //     .style('stroke-width', 2)
                  //     .attr('class','nv-legend-symbol')
                  //     .attr('r', 5);

                  seriesShape = series.select('.nv-legend-symbol');
              } else if (vers == 'furious') {
                  seriesEnter.append('rect')
                      .style('stroke-width', 2)
                      .attr('class','nv-legend-symbol')
                      .attr('rx', 3)
                      .attr('ry', 3);
                  seriesShape = series.select('.nv-legend-symbol');

                  seriesEnter.append('g')
                      .attr('class', 'nv-check-box')
                      .property('innerHTML','<path d="M0.5,5 L22.5,5 L22.5,26.5 L0.5,26.5 L0.5,5 Z" class="nv-box"></path><path d="M5.5,12.8618467 L11.9185089,19.2803556 L31,0.198864511" class="nv-check"></path>')
                      .attr('transform', 'translate(-10,-8)scale(0.5)');

                  var seriesCheckbox = series.select('.nv-check-box');

                  seriesCheckbox.each(function(d,i) {
                      d3.select(this).selectAll('path')
                          .attr('stroke', setTextColor(d,i));
                  });
              }

              seriesEnter.append('text')
                  .attr('text-anchor', 'start')
                  .attr('class','nv-legend-text')
                  .attr('dy', '.32em')
                  .attr('dx', '8');

              var seriesText = series.select('text.nv-legend-text');

              series
                  .on('mouseover', function(d,i) {
                      dispatch.legendMouseover(d,i);  //TODO: Make consistent with other event objects
                  })
                  .on('mouseout', function(d,i) {
                      dispatch.legendMouseout(d,i);
                  })
                  .on('click', function(d,i) {
                      dispatch.legendClick(d,i);
                      // make sure we re-get data in case it was modified
                      var data = series.data();
                      if (updateState) {
                          if(vers =='classic') {
                              if (radioButtonMode) {
                                  //Radio button mode: set every series to disabled,
                                  //  and enable the clicked series.
                                  data.forEach(function(series) { series.disabled = true});
                                  d.disabled = false;
                              }
                              else {
                                  d.disabled = !d.disabled;
                                  if (data.every(function(series) { return series.disabled})) {
                                      //the default behavior of NVD3 legends is, if every single series
                                      // is disabled, turn all series' back on.
                                      data.forEach(function(series) { series.disabled = false});
                                  }
                              }
                          } else if(vers == 'furious') {
                              if(expanded) {
                                  d.disengaged = !d.disengaged;
                                  d.userDisabled = d.userDisabled == undefined ? !!d.disabled : d.userDisabled;
                                  d.disabled = d.disengaged || d.userDisabled;
                              } else if (!expanded) {
                                  d.disabled = !d.disabled;
                                  d.userDisabled = d.disabled;
                                  var engaged = data.filter(function(d) { return !d.disengaged; });
                                  if (engaged.every(function(series) { return series.userDisabled })) {
                                      //the default behavior of NVD3 legends is, if every single series
                                      // is disabled, turn all series' back on.
                                      data.forEach(function(series) {
                                          series.disabled = series.userDisabled = false;
                                      });
                                  }
                              }
                          }
                          dispatch.stateChange({
                              disabled: data.map(function(d) { return !!d.disabled }),
                              disengaged: data.map(function(d) { return !!d.disengaged })
                          });

                      }
                  })
                  // .on('dblclick', function(d,i) {
                  //     if(vers == 'furious' && expanded) return;
                  //     dispatch.legendDblclick(d,i);
                  //     if (updateState) {
                  //         // make sure we re-get data in case it was modified
                  //         var data = series.data();
                  //         //the default behavior of NVD3 legends, when decimal clicking one,
                  //         // is to set all other series' to false, and make the decimal clicked series enabled.
                  //         data.forEach(function(series) {
                  //             series.disabled = true;
                  //             if(vers == 'furious') series.userDisabled = series.disabled;
                  //         });
                  //         d.disabled = false;
                  //         if(vers == 'furious') d.userDisabled = d.disabled;
                  //         dispatch.stateChange({
                  //             disabled: data.map(function(d) { return !!d.disabled })
                  //         });
                  //     }
                  // })
                  ;

              series.classed('nv-disabled', function(d) { return d.userDisabled });
              series.exit().remove();

              seriesText
                  .attr('fill', setTextColor)
                  .text(function (d) { return keyFormatter(getKey(d)) });

              //TODO: implement fixed-width and max-width options (max-width is especially useful with the align option)
              // NEW ALIGNING CODE, TODO: clean up
              var legendWidth = 0;
              if (align) {

                  var seriesWidths = [];
                  series.each(function(d,i) {
                      var legendText;
                      if (keyFormatter(getKey(d)) && keyFormatter(getKey(d)).length > maxKeyLength) {
                          var trimmedKey = keyFormatter(getKey(d)).substring(0, maxKeyLength);
                          legendText = d3.select(this).select('text').text(trimmedKey + "...");
                          d3.select(this).append("svg:title").text(keyFormatter(getKey(d)));
                      } else {
                          legendText = d3.select(this).select('text');
                      }
                      var nodeTextLength;
                      try {
                          nodeTextLength = legendText.node().getComputedTextLength();
                          // If the legendText is display:none'd (nodeTextLength == 0), simulate an error so we approximate, instead
                          if(nodeTextLength <= 0) throw Error();
                      }
                      catch(e) {
                          nodeTextLength = nv.utils.calcApproxTextWidth(legendText);
                      }

                      seriesWidths.push(nodeTextLength + padding);
                  });

                  // var seriesPerRow = 0;
                  // var columnWidths = [];
                  // legendWidth = 0;
                  //
                  // while ( legendWidth < availableWidth && seriesPerRow < seriesWidths.length) {
                  //     columnWidths[seriesPerRow] = seriesWidths[seriesPerRow];
                  //     legendWidth += seriesWidths[seriesPerRow++];
                  // }
                  // if (seriesPerRow === 0) seriesPerRow = 1; //minimum of one series per row
                  //
                  // while ( legendWidth > availableWidth && seriesPerRow > 1 ) {
                  //     columnWidths = [];
                  //     seriesPerRow--;
                  //
                  //     for (var k = 0; k < seriesWidths.length; k++) {
                  //         if (seriesWidths[k] > (columnWidths[k % seriesPerRow] || 0) )
                  //             columnWidths[k % seriesPerRow] = seriesWidths[k];
                  //     }
                  //
                  //     legendWidth = columnWidths.reduce(function(prev, cur, index, array) {
                  //         return prev + cur;
                  //     });
                  // }
                  //
                  // var xPositions = [];
                  // for (var i = 0, curX = 0; i < seriesPerRow; i++) {
                  //     xPositions[i] = curX;
                  //     curX += columnWidths[i];
                  // }

                  series
                      .attr('transform', function(d, i) {
                          return 'translate(0,' + (0 + i * versPadding) + ')';
                      });

                  //position legend as far right as possible within the total width
                  if (rightAlign) {
                      g.attr('transform', 'translate(' + (width - margin.right - legendWidth + 30) + ',' + margin.top + ')');
                  }
                  else {
                      g.attr('transform', 'translate(20' + ',' + margin.top + ')');
                  }

                  height = margin.top + margin.bottom + data.length * versPadding;
              } else {

                  var ypos = 5,
                      newxpos = 5,
                      maxwidth = 0,
                      xpos;
                  series
                      .attr('transform', function(d, i) {
                          var length = d3.select(this).select('text').node().getComputedTextLength() + padding;
                          xpos = newxpos;

                          if (width < margin.left + margin.right + xpos + length) {
                              newxpos = xpos = 5;
                              ypos += versPadding;
                          }

                          newxpos += length;
                          if (newxpos > maxwidth) maxwidth = newxpos;

                          if(legendWidth < xpos + maxwidth) {
                              legendWidth = xpos + maxwidth;
                          }
                          return 'translate(' + xpos + ',' + ypos + ')';
                      });

                  //position legend as far right as possible within the total width
                  g.attr('transform', 'translate(' + (width - margin.right - maxwidth) + ',' + margin.top + ')');

                  height = margin.top + margin.bottom + ypos + 15;
              }

              if(vers == 'furious') {
                  // Size rectangles after text is placed
                  seriesShape
                      .attr('width', function(d,i) {
                          return seriesText[0][i].getComputedTextLength() + 27;
                      })
                      .attr('height', 18)
                      .attr('y', -9)
                      .attr('x', -15);

                  // The background for the expanded legend (UI)
                  gEnter.insert('rect',':first-child')
                      .attr('class', 'nv-legend-bg')
                      .attr('fill', '#eee')
                      // .attr('stroke', '#444')
                      .attr('opacity',0);

                  var seriesBG = g.select('.nv-legend-bg');

                  seriesBG
                  .transition().duration(300)
                      .attr('x', -versPadding )
                      .attr('width', legendWidth + versPadding - 12)
                      .attr('height', height + 10)
                      .attr('y', -margin.top - 10)
                      .attr('opacity', expanded ? 1 : 0);


              }

              seriesShape
                  .style('fill', setBGColor)
                  .style('fill-opacity', setBGOpacity)
                  .style('stroke', setBGColor);
          });

          function setTextColor(d,i) {
              if(vers != 'furious') return '#000';
              if(expanded) {
                  return d.disengaged ? '#000' : '#fff';
              } else if (!expanded) {
                  if(!d.color) d.color = color(d,i);
                  return !!d.disabled ? d.color : '#fff';
              }
          }

          function setBGColor(d,i) {
              if(expanded && vers == 'furious') {
                  return d.disengaged ? '#eee' : d.color || color(d,i);
              } else {
                  return d.color || color(d,i);
              }
          }


          function setBGOpacity(d,i) {
              if(expanded && vers == 'furious') {
                  return 1;
              } else {
                  return !!d.disabled ? 0 : 1;
              }
          }

          return chart;
      }

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:          {get: function(){return width;}, set: function(_){width=_;}},
          height:         {get: function(){return height;}, set: function(_){height=_;}},
          key:            {get: function(){return getKey;}, set: function(_){getKey=_;}},
          keyFormatter:   {get: function(){return keyFormatter;}, set: function(_){keyFormatter=_;}},
          align:          {get: function(){return align;}, set: function(_){align=_;}},
          maxKeyLength:   {get: function(){return maxKeyLength;}, set: function(_){maxKeyLength=_;}},
          rightAlign:     {get: function(){return rightAlign;}, set: function(_){rightAlign=_;}},
          padding:        {get: function(){return padding;}, set: function(_){padding=_;}},
          updateState:    {get: function(){return updateState;}, set: function(_){updateState=_;}},
          radioButtonMode:{get: function(){return radioButtonMode;}, set: function(_){radioButtonMode=_;}},
          expanded:       {get: function(){return expanded;}, set: function(_){expanded=_;}},
          vers:           {get: function(){return vers;}, set: function(_){vers=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }}
      });

      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.line2 = function() {
      "use strict";
      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var  scatter = nv.models.scatter2()
          ;

      var margin = {top: 0, right: 0, bottom: 0, left: 0}
          , width = 960
          , height = 500
          , container = null
          , strokeWidth = 1.5
          , color = nv.utils.defaultColor() // a function that returns a color
          , getX = function(d) { return d.x } // accessor to get the x value from a data point
          , getY = function(d) { return d.y } // accessor to get the y value from a data point
          , defined = function(d,i) { return !isNaN(getY(d,i)) && getY(d,i) !== null } // allows a line to be not continuous when it is not defined
          , isArea = function(d) { return d.area } // decides if a line is an area or just a line
          , clipEdge = false // if true, masks lines within x and y scale
          , x //can be accessed via chart.xScale()
          , y //can be accessed via chart.yScale()
          , interpolate = "linear" // controls the line interpolation
          , duration = 250
          , dispatch = d3.dispatch('elementClick', 'elementMouseover', 'elementMouseout', 'renderEnd')
          ;

      scatter
          .pointSize(10) // default size
          .pointDomain([1,100]) //set to speed up calculation, needs to be unset if there is a custom size accessor
      ;

      //============================================================


      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x0, y0 //used to store previous scales
          , renderWatch = nv.utils.renderWatch(dispatch, duration)
          ;

      //============================================================


      function chart(selection) {
          renderWatch.reset();
          renderWatch.models(scatter);
          selection.each(function(data) {
              container = d3.select(this);
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);
              nv.utils.initSVG(container);

              // Setup Scales
              x = scatter.xScale();
              y = scatter.yScale();

              x0 = x0 || x;
              y0 = y0 || y;

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-line').data([data]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-line');
              var defsEnter = wrapEnter.append('defs');
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-groups');
              gEnter.append('g').attr('class', 'nv-scatterWrap');

              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              scatter
                  .width(availableWidth)
                  .height(availableHeight);

              var scatterWrap = wrap.select('.nv-scatterWrap');
              scatterWrap.call(scatter);

              defsEnter.append('clipPath')
                  .attr('id', 'nv-edge-clip-' + scatter.id())
                  .append('rect');

              wrap.select('#nv-edge-clip-' + scatter.id() + ' rect')
                  .attr('width', availableWidth)
                  .attr('height', (availableHeight > 0) ? availableHeight : 0);

              g   .attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + scatter.id() + ')' : '');
              scatterWrap
                  .attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + scatter.id() + ')' : '');

              var groups = wrap.select('.nv-groups').selectAll('.nv-group')
                  .data(function(d) { return d }, function(d) { return d.key });
              groups.enter().append('g')
                  .style('stroke-opacity', 1e-6)
                  .style('stroke-width', function(d) { return d.strokeWidth || strokeWidth })
                  .style('fill-opacity', 1e-6);

              groups.exit().remove();

              groups
                  .attr('class', function(d,i) {
                      return (d.classed || '') + ' nv-group nv-series-' + i;
                  })
                  .classed('hover', function(d) { return d.hover })
                  .style('fill', function(d,i){ return color(d, i) })
                  .style('stroke', function(d,i){ return color(d, i)});
              groups.watchTransition(renderWatch, 'line: groups')
                  .style('stroke-opacity', 1)
                  .style('fill-opacity', function(d) { return d.fillOpacity || .5});

              var areaPaths = groups.selectAll('path.nv-area')
                  .data(function(d) { return isArea(d) ? [d] : [] }); // this is done differently than lines because I need to check if series is an area
              areaPaths.enter().append('path')
                  .attr('class', 'nv-area')
                  .attr('d', function(d) {
                      return d3.svg.area()
                          .interpolate(interpolate)
                          .defined(defined)
                          .x(function(d,i) { return nv.utils.NaNtoZero(x0(getX(d,i))) })
                          .y0(function(d,i) { return nv.utils.NaNtoZero(y0(getY(d,i))) })
                          .y1(function(d,i) { return y0( y.domain()[0] <= 0 ? y.domain()[1] >= 0 ? 0 : y.domain()[1] : y.domain()[0] ) })
                          //.y1(function(d,i) { return y0(0) }) //assuming 0 is within y domain.. may need to tweak this
                          .apply(this, [d.values])
                  });
              groups.exit().selectAll('path.nv-area')
                  .remove();

              areaPaths.watchTransition(renderWatch, 'line: areaPaths')
                  .attr('d', function(d) {
                      return d3.svg.area()
                          .interpolate(interpolate)
                          .defined(defined)
                          .x(function(d,i) { return nv.utils.NaNtoZero(x(getX(d,i))) })
                          .y0(function(d,i) { return nv.utils.NaNtoZero(y(getY(d,i))) })
                          .y1(function(d,i) { return y( y.domain()[0] <= 0 ? y.domain()[1] >= 0 ? 0 : y.domain()[1] : y.domain()[0] ) })
                          //.y1(function(d,i) { return y0(0) }) //assuming 0 is within y domain.. may need to tweak this
                          .apply(this, [d.values])
                  });

              var linePaths = groups.selectAll('path.nv-line')
                  .data(function(d) { return [d.values] });

              linePaths.enter().append('path')
                  .attr('class', 'nv-line')
                  .attr('d',
                      d3.svg.line()
                      .interpolate(interpolate)
                      .defined(defined)
                      .x(function(d,i) { return nv.utils.NaNtoZero(x0(getX(d,i))) })
                      .y(function(d,i) { return nv.utils.NaNtoZero(y0(getY(d,i))) })
              );

              linePaths.watchTransition(renderWatch, 'line: linePaths')
                  .attr('d',
                      d3.svg.line()
                      .interpolate(interpolate)
                      .defined(defined)
                      .x(function(d,i) { return nv.utils.NaNtoZero(x(getX(d,i))) })
                      .y(function(d,i) { return nv.utils.NaNtoZero(y(getY(d,i))) })
              );

              //store old scales for use in transitions on update
              x0 = x.copy();
              y0 = y.copy();
          });
          renderWatch.renderEnd('line immediate');
          return chart;
      }


      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.scatter = scatter;
      // Pass through events
      scatter.dispatch.on('elementClick', function(){ dispatch.elementClick.apply(this, arguments); });
      scatter.dispatch.on('elementMouseover', function(){ dispatch.elementMouseover.apply(this, arguments); });
      scatter.dispatch.on('elementMouseout', function(){ dispatch.elementMouseout.apply(this, arguments); });

      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:      {get: function(){return width;}, set: function(_){width=_;}},
          height:     {get: function(){return height;}, set: function(_){height=_;}},
          defined: {get: function(){return defined;}, set: function(_){defined=_;}},
          interpolate:      {get: function(){return interpolate;}, set: function(_){interpolate=_;}},
          clipEdge:    {get: function(){return clipEdge;}, set: function(_){clipEdge=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
              scatter.duration(duration);
          }},
          isArea: {get: function(){return isArea;}, set: function(_){
              isArea = d3.functor(_);
          }},
          x: {get: function(){return getX;}, set: function(_){
              getX = _;
              scatter.x(_);
          }},
          y: {get: function(){return getY;}, set: function(_){
              getY = _;
              scatter.y(_);
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
              scatter.color(color);
          }},
          valueFormat:    {get: function(){return scatter.valueFormat();}, set: function(_){
            scatter.valueFormat(_);
          }}
      });

      nv.utils.inheritOptions(chart, scatter);
      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.line3 = function() {
      "use strict";
      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var  scatter = nv.models.scatter3()
          ;

      var margin = {top: 0, right: 0, bottom: 0, left: 0}
          , width = 960
          , height = 500
          , container = null
          , strokeWidth = 1.5
          , color = nv.utils.defaultColor() // a function that returns a color
          , getX = function(d) { return d.x } // accessor to get the x value from a data point
          , getY = function(d) { return d.y } // accessor to get the y value from a data point
          , defined = function(d,i) { return !isNaN(getY(d,i)) && getY(d,i) !== null } // allows a line to be not continuous when it is not defined
          , isArea = function(d) { return d.area } // decides if a line is an area or just a line
          , clipEdge = false // if true, masks lines within x and y scale
          , x //can be accessed via chart.xScale()
          , y //can be accessed via chart.yScale()
          , interpolate = "linear" // controls the line interpolation
          , duration = 250
          , dispatch = d3.dispatch('elementClick', 'elementMouseover', 'elementMouseout', 'renderEnd')
          ;

      scatter
          .pointSize(10) // default size
          .pointDomain([1,100]) //set to speed up calculation, needs to be unset if there is a custom size accessor
      ;

      //============================================================


      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x0, y0 //used to store previous scales
          , renderWatch = nv.utils.renderWatch(dispatch, duration)
          ;

      //============================================================


      function chart(selection) {
          renderWatch.reset();
          renderWatch.models(scatter);
          selection.each(function(data) {
              container = d3.select(this);
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);
              nv.utils.initSVG(container);

              // Setup Scales
              x = scatter.xScale();
              y = scatter.yScale();

              x0 = x0 || x;
              y0 = y0 || y;

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-line').data([data]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-line');
              var defsEnter = wrapEnter.append('defs');
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-groups');
              gEnter.append('g').attr('class', 'nv-scatterWrap');

              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              scatter
                  .width(availableWidth)
                  .height(availableHeight);

              var scatterWrap = wrap.select('.nv-scatterWrap');
              scatterWrap.call(scatter);

              defsEnter.append('clipPath')
                  .attr('id', 'nv-edge-clip-' + scatter.id())
                  .append('rect');

              wrap.select('#nv-edge-clip-' + scatter.id() + ' rect')
                  .attr('width', availableWidth)
                  .attr('height', (availableHeight > 0) ? availableHeight : 0);

              g   .attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + scatter.id() + ')' : '');
              scatterWrap
                  .attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + scatter.id() + ')' : '');

              var groups = wrap.select('.nv-groups').selectAll('.nv-group')
                  .data(function(d) { return d }, function(d) { return d.key });
              groups.enter().append('g')
                  .style('stroke-opacity', 1e-6)
                  .style('stroke-width', function(d) { return d.strokeWidth || strokeWidth })
                  .style('fill-opacity', 1e-6);

              groups.exit().remove();

              groups
                  .attr('class', function(d,i) {
                      return (d.classed || '') + ' nv-group nv-series-' + i;
                  })
                  .classed('hover', function(d) { return d.hover })
                  .style('fill', function(d,i){ return color(d, i) })
                  .style('stroke', function(d,i){ return color(d, i)});
              groups.watchTransition(renderWatch, 'line: groups')
                  .style('stroke-opacity', 1)
                  .style('fill-opacity', function(d) { return d.fillOpacity || .5});

              var areaPaths = groups.selectAll('path.nv-area')
                  .data(function(d) { return isArea(d) ? [d] : [] }); // this is done differently than lines because I need to check if series is an area
              areaPaths.enter().append('path')
                  .attr('class', 'nv-area')
                  .attr('d', function(d) {
                      return d3.svg.area()
                          .interpolate(interpolate)
                          .defined(defined)
                          .x(function(d,i) { return nv.utils.NaNtoZero(x0(getX(d,i))) })
                          .y0(function(d,i) { return nv.utils.NaNtoZero(y0(getY(d,i))) })
                          .y1(function(d,i) { return y0( y.domain()[0] <= 0 ? y.domain()[1] >= 0 ? 0 : y.domain()[1] : y.domain()[0] ) })
                          //.y1(function(d,i) { return y0(0) }) //assuming 0 is within y domain.. may need to tweak this
                          .apply(this, [d.values])
                  });
              groups.exit().selectAll('path.nv-area')
                  .remove();

              areaPaths.watchTransition(renderWatch, 'line: areaPaths')
                  .attr('d', function(d) {
                      return d3.svg.area()
                          .interpolate(interpolate)
                          .defined(defined)
                          .x(function(d,i) { return nv.utils.NaNtoZero(x(getX(d,i))) })
                          .y0(function(d,i) { return nv.utils.NaNtoZero(y(getY(d,i))) })
                          .y1(function(d,i) { return y( y.domain()[0] <= 0 ? y.domain()[1] >= 0 ? 0 : y.domain()[1] : y.domain()[0] ) })
                          //.y1(function(d,i) { return y0(0) }) //assuming 0 is within y domain.. may need to tweak this
                          .apply(this, [d.values])
                  });

              var linePaths = groups.selectAll('path.nv-line')
                  .data(function(d) { return [d.values] });

              linePaths.enter().append('path')
                  .attr('class', 'nv-line')
                  .attr('d',
                      d3.svg.line()
                      .interpolate(interpolate)
                      .defined(defined)
                      .x(function(d,i) { return nv.utils.NaNtoZero(x0(getX(d,i))) })
                      .y(function(d,i) { return nv.utils.NaNtoZero(y0(getY(d,i))) })
              );

              linePaths.watchTransition(renderWatch, 'line: linePaths')
                  .attr('d',
                      d3.svg.line()
                      .interpolate(interpolate)
                      .defined(defined)
                      .x(function(d,i) { return nv.utils.NaNtoZero(x(getX(d,i))) })
                      .y(function(d,i) { return nv.utils.NaNtoZero(y(getY(d,i))) })
              );

              //store old scales for use in transitions on update
              x0 = x.copy();
              y0 = y.copy();
          });
          renderWatch.renderEnd('line immediate');
          return chart;
      }


      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.scatter = scatter;
      // Pass through events
      scatter.dispatch.on('elementClick', function(){ dispatch.elementClick.apply(this, arguments); });
      scatter.dispatch.on('elementMouseover', function(){ dispatch.elementMouseover.apply(this, arguments); });
      scatter.dispatch.on('elementMouseout', function(){ dispatch.elementMouseout.apply(this, arguments); });

      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:      {get: function(){return width;}, set: function(_){width=_;}},
          height:     {get: function(){return height;}, set: function(_){height=_;}},
          defined: {get: function(){return defined;}, set: function(_){defined=_;}},
          interpolate:      {get: function(){return interpolate;}, set: function(_){interpolate=_;}},
          clipEdge:    {get: function(){return clipEdge;}, set: function(_){clipEdge=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
              scatter.duration(duration);
          }},
          isArea: {get: function(){return isArea;}, set: function(_){
              isArea = d3.functor(_);
          }},
          x: {get: function(){return getX;}, set: function(_){
              getX = _;
              scatter.x(_);
          }},
          y: {get: function(){return getY;}, set: function(_){
              getY = _;
              scatter.y(_);
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
              scatter.color(color);
          }},
          valueFormat:    {get: function(){return scatter.valueFormat();}, set: function(_){
            scatter.valueFormat(_);
          }}
      });

      nv.utils.inheritOptions(chart, scatter);
      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.lineChart2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var lines = nv.models.line2()
          , xAxis = nv.models.axis()
          , yAxis = nv.models.axis()
          , legend = nv.models.legend3()
          , interactiveLayer = nv.interactiveGuideline()
          , tooltip = nv.models.tooltip()
          , focus = nv.models.focus(nv.models.line())
          ;

      var margin = {top: 30, right: 20, bottom: 50, left: 60}
          , marginTop = null
          , color = nv.utils.defaultColor()
          , width = null
          , height = null
          , showLegend = true
          , legendPosition = 'top'
          , showXAxis = true
          , showYAxis = true
          , rightAlignYAxis = false
          , useInteractiveGuideline = false
          , x
          , y
          , focusEnable = false
          , state = nv.utils.state()
          , defaultState = null
          , noData = null
          , dispatch = d3.dispatch('tooltipShow', 'tooltipHide', 'stateChange', 'changeState', 'renderEnd')
          , duration = 250
          ;

      // set options on sub-objects for this chart
      xAxis.orient('bottom').tickPadding(7);
      yAxis.orient(rightAlignYAxis ? 'right' : 'left');

      lines.clipEdge(true).duration(0);

      tooltip.valueFormatter(function(d, i) {
          return yAxis.tickFormat()(d, i);
      }).headerFormatter(function(d, i) {
          return xAxis.tickFormat()(d, i);
      });

      interactiveLayer.tooltip.valueFormatter(function(d, i) {
          return yAxis.tickFormat()(d, i);
      }).headerFormatter(function(d, i) {
          return xAxis.tickFormat()(d, i);
      });


      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var renderWatch = nv.utils.renderWatch(dispatch, duration);

      var stateGetter = function(data) {
          return function(){
              return {
                  active: data.map(function(d) { return !d.disabled; })
              };
          };
      };

      var stateSetter = function(data) {
          return function(state) {
              if (state.active !== undefined)
                  data.forEach(function(series,i) {
                      series.disabled = !state.active[i];
                  });
          };
      };

      function chart(selection) {
          renderWatch.reset();
          renderWatch.models(lines);
          if (showXAxis) renderWatch.models(xAxis);
          if (showYAxis) renderWatch.models(yAxis);

          selection.each(function(data) {
              var container = d3.select(this);
              nv.utils.initSVG(container);
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin) - (focusEnable ? focus.height() : 0);
              chart.update = function() {
                  if( duration === 0 ) {
                      container.call( chart );
                  } else {
                      container.transition().duration(duration).call(chart);
                  }
              };
              chart.container = this;

              state
                  .setter(stateSetter(data), chart.update)
                  .getter(stateGetter(data))
                  .update();

              // DEPRECATED set state.disabled
              state.disabled = data.map(function(d) { return !!d.disabled; });

              if (!defaultState) {
                  var key;
                  defaultState = {};
                  for (key in state) {
                      if (state[key] instanceof Array)
                          defaultState[key] = state[key].slice(0);
                      else
                          defaultState[key] = state[key];
                  }
              }

              // Display noData message if there's nothing to show.
              if (!data || !data.length || !data.filter(function(d) { return d.values.length; }).length) {
                  nv.utils.noData(chart, container);
                  return chart;
              } else {
                  container.selectAll('.nv-noData').remove();
              }

              /* Update `main' graph on brush update. */
              focus.dispatch.on("onBrush", function(extent) {
                  onBrush(extent);
              });

              // Setup Scales
              x = lines.xScale();
              y = lines.yScale();

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-lineChart').data([data]);
              var gEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-lineChart').append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-legendWrap');

              var focusEnter = gEnter.append('g').attr('class', 'nv-focus');
              focusEnter.append('g').attr('class', 'nv-background').append('rect');
              focusEnter.append('g').attr('class', 'nv-x nv-axis');
              focusEnter.append('g').attr('class', 'nv-y nv-axis');
              focusEnter.append('g').attr('class', 'nv-linesWrap');
              focusEnter.append('g').attr('class', 'nv-interactive');

              var contextEnter = gEnter.append('g').attr('class', 'nv-focusWrap');

              // Legend
              if (!showLegend) {
                  g.select('.nv-legendWrap').selectAll('*').remove();
              } else {
                  legend.width(availableWidth);

                  if (legendPosition === 'bottom') {
                      legend.rightAlign( false );

                       g.select('.nv-legendWrap')
                           .datum(data)
                           .call(legend);

                       margin.bottom = xAxis.height() - 10 + legend.height();
                       availableHeight = nv.utils.availableHeight(height, container, margin);
                       g.select('.nv-legendWrap')
                           .attr('transform', 'translate(0,' + (availableHeight + xAxis.height() - 10)  +')');
                  } else if (legendPosition === 'top') {
                       g.select('.nv-legendWrap')
                           .datum(data)
                           .call(legend);

                      if (!marginTop && legend.height() !== margin.top) {
                          margin.top = legend.height();
                          availableHeight = nv.utils.availableHeight(height, container, margin) - (focusEnable ? focus.height() : 0);
                      }

                      g.select('.nv-legendWrap')
                          .attr('transform', 'translate(0,' + (-margin.top) +')');
                  } else if (legendPosition === 'right') {
                      g.select('.nv-legendWrap')
                         .datum(data)
                         .call(legend);

                       g.select('.nv-legendWrap')
                           .attr('transform', 'translate(0,' + (availableHeight - legend.height()) / 2 +')');
                      // log(legend.width())
                      // margin.right = legend.width();
                      // availableWidth = nv.utils.availableWidth(width, container, margin);
                  }
              }

              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              if (rightAlignYAxis) {
                  g.select(".nv-y.nv-axis")
                      .attr("transform", "translate(" + availableWidth + ",0)");
              }

              //Set up interactive layer
              if (useInteractiveGuideline) {
                  interactiveLayer
                      .width(availableWidth)
                      .height(availableHeight)
                      .margin({left:margin.left, top:margin.top})
                      .svgContainer(container)
                      .xScale(x);
                  wrap.select(".nv-interactive").call(interactiveLayer);
              }

              g.select('.nv-focus .nv-background rect')
                  .attr('width', availableWidth)
                  .attr('height', availableHeight);

              lines
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(data.map(function(d,i) {
                      return d.color || color(d, i);
                  }).filter(function(d,i) { return !data[i].disabled; }));

              var linesWrap = g.select('.nv-linesWrap')
                  .datum(data.filter(function(d) { return !d.disabled; }));


              // Setup Main (Focus) Axes
              if (showXAxis) {
                  xAxis
                      .scale(x)
                      ._ticks(nv.utils.calcTicksX(availableWidth/10, data) )
                      .tickSize(-availableHeight, 0);
              }

              if (showYAxis) {
                  yAxis
                      .scale(y)
                      ._ticks( nv.utils.calcTicksY(availableHeight/36, data) )
                      .tickSize( -availableWidth, 0);
              }

              //============================================================
              // Update Axes
              //============================================================
              function updateXAxis() {
                if(showXAxis) {
                  g.select('.nv-focus .nv-x.nv-axis')
                    .transition()
                    .duration(duration)
                    .call(xAxis)
                  ;
                }
              }

              function updateYAxis() {
                if(showYAxis) {
                  g.select('.nv-focus .nv-y.nv-axis')
                    .transition()
                    .duration(duration)
                    .call(yAxis)
                  ;
                }
              }

              g.select('.nv-focus .nv-x.nv-axis')
                  .attr('transform', 'translate(0,' + availableHeight + ')');

              //============================================================
              // Update Focus
              //============================================================
              if (!focusEnable && focus.brush.extent() === null) {
                  linesWrap.call(lines);
                  updateXAxis();
                  updateYAxis();
              } else {
                  focus.width(availableWidth);
                  g.select('.nv-focusWrap')
                      .style('display', focusEnable ? 'initial' : 'none')
                      .attr('transform', 'translate(0,' + ( availableHeight + margin.bottom + focus.margin().top) + ')')
                      .datum(data.filter(function(d) { return !d.disabled; }))
                      .call(focus);
                  var extent = focus.brush.empty() ? focus.xDomain() : focus.brush.extent();
                  if (extent !== null) {
                      onBrush(extent);
                  }
              }
              //============================================================
              // Event Handling/Dispatching (in chart's scope)
              //------------------------------------------------------------

              legend.dispatch.on('stateChange', function(newState) {
                  for (var key in newState)
                      state[key] = newState[key];
                  dispatch.stateChange(state);
                  chart.update();
              });

              interactiveLayer.dispatch.on('elementMousemove', function(e) {
                  lines.clearHighlights();
                  var singlePoint, pointIndex, pointXLocation, allData = [];
                  data
                      .filter(function(series, i) {
                          series.seriesIndex = i;
                          return !series.disabled && !series.disableTooltip;
                      })
                      .forEach(function(series,i) {
                          var extent = focus.brush.extent() !== null ? (focus.brush.empty() ? focus.xScale().domain() : focus.brush.extent()) : x.domain();
                          var currentValues = series.values.filter(function(d,i) {
                              // Checks if the x point is between the extents, handling case where extent[0] is greater than extent[1]
                              // (e.g. x domain is manually set to reverse the x-axis)
                              if(extent[0] <= extent[1]) {
                                  return lines.x()(d,i) >= extent[0] && lines.x()(d,i) <= extent[1];
                              } else {
                                  return lines.x()(d,i) >= extent[1] && lines.x()(d,i) <= extent[0];
                              }
                          });

                          pointIndex = nv.interactiveBisect(currentValues, e.pointXValue, lines.x());
                          var point = currentValues[pointIndex];
                          var pointYValue = chart.y()(point, pointIndex);
                          if (pointYValue !== null) {
                              lines.highlightPoint(i, pointIndex, true);
                          }
                          if (point === undefined) return;
                          if (singlePoint === undefined) singlePoint = point;
                          if (pointXLocation === undefined) pointXLocation = chart.xScale()(chart.x()(point,pointIndex));
                          allData.push({
                              key: series.key,
                              value: pointYValue,
                              color: color(series,series.seriesIndex),
                              data: point
                          });
                      });
                  //Highlight the tooltip entry based on which point the mouse is closest to.
                  if (allData.length > 2) {
                      var yValue = chart.yScale().invert(e.mouseY);
                      var domainExtent = Math.abs(chart.yScale().domain()[0] - chart.yScale().domain()[1]);
                      var threshold = 0.03 * domainExtent;
                      var indexToHighlight = nv.nearestValueIndex(allData.map(function(d){return d.value;}),yValue,threshold);
                      if (indexToHighlight !== null)
                          allData[indexToHighlight].highlight = true;
                  }

                  var defaultValueFormatter = function(d,i) {
                      return d == null ? "N/A" : yAxis.tickFormat()(d);
                  };

                  interactiveLayer.tooltip
                      .valueFormatter(interactiveLayer.tooltip.valueFormatter() || defaultValueFormatter)
                      .data({
                          value: chart.x()( singlePoint,pointIndex ),
                          index: pointIndex,
                          series: allData
                      })();

                  interactiveLayer.renderGuideLine(pointXLocation);

              });

              interactiveLayer.dispatch.on('elementClick', function(e) {
                  var pointXLocation, allData = [];

                  data.filter(function(series, i) {
                      series.seriesIndex = i;
                      return !series.disabled;
                  }).forEach(function(series) {
                      var pointIndex = nv.interactiveBisect(series.values, e.pointXValue, chart.x());
                      var point = series.values[pointIndex];
                      if (typeof point === 'undefined') return;
                      if (typeof pointXLocation === 'undefined') pointXLocation = chart.xScale()(chart.x()(point,pointIndex));
                      var yPos = chart.yScale()(chart.y()(point,pointIndex));
                      allData.push({
                          point: point,
                          pointIndex: pointIndex,
                          pos: [pointXLocation, yPos],
                          seriesIndex: series.seriesIndex,
                          series: series
                      });
                  });

                  lines.dispatch.elementClick(allData);
              });

              interactiveLayer.dispatch.on("elementMouseout",function(e) {
                  lines.clearHighlights();
              });

              dispatch.on('changeState', function(e) {
                  if (typeof e.disabled !== 'undefined' && data.length === e.disabled.length) {
                      data.forEach(function(series,i) {
                          series.disabled = e.disabled[i];
                      });

                      state.disabled = e.disabled;
                  }
                  chart.update();
              });

              //============================================================
              // Functions
              //------------------------------------------------------------

              // Taken from crossfilter (http://square.github.com/crossfilter/)
              function resizePath(d) {
                  var e = +(d == 'e'),
                      x = e ? 1 : -1,
                      y = availableHeight / 3;
                  return 'M' + (0.5 * x) + ',' + y
                      + 'A6,6 0 0 ' + e + ' ' + (6.5 * x) + ',' + (y + 6)
                      + 'V' + (2 * y - 6)
                      + 'A6,6 0 0 ' + e + ' ' + (0.5 * x) + ',' + (2 * y)
                      + 'Z'
                      + 'M' + (2.5 * x) + ',' + (y + 8)
                      + 'V' + (2 * y - 8)
                      + 'M' + (4.5 * x) + ',' + (y + 8)
                      + 'V' + (2 * y - 8);
              }

              function onBrush(extent) {
                  // Update Main (Focus)
                  var focusLinesWrap = g.select('.nv-focus .nv-linesWrap')
                      .datum(
                      data.filter(function(d) { return !d.disabled; })
                          .map(function(d,i) {
                              return {
                                  key: d.key,
                                  area: d.area,
                                  classed: d.classed,
                                  values: d.values.filter(function(d,i) {
                                      return lines.x()(d,i) >= extent[0] && lines.x()(d,i) <= extent[1];
                                  }),
                                  disableTooltip: d.disableTooltip
                              };
                          })
                  );
                  focusLinesWrap.transition().duration(duration).call(lines);

                  // Update Main (Focus) Axes
                  updateXAxis();
                  updateYAxis();
              }
          });

          renderWatch.renderEnd('lineChart immediate');
          return chart;
      }


      //============================================================
      // Event Handling/Dispatching (out of chart's scope)
      //------------------------------------------------------------

      lines.dispatch.on('elementMouseover.tooltip', function(evt) {
          if(!evt.series.disableTooltip){
              tooltip.data(evt).hidden(false);
          }
      });

      lines.dispatch.on('elementMouseout.tooltip', function(evt) {
          tooltip.hidden(true);
      });

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      // expose chart's sub-components
      chart.dispatch = dispatch;
      chart.lines = lines;
      chart.legend = legend;
      chart.focus = focus;
      chart.xAxis = xAxis;
      chart.x2Axis = focus.xAxis
      chart.yAxis = yAxis;
      chart.y2Axis = focus.yAxis
      chart.interactiveLayer = interactiveLayer;
      chart.tooltip = tooltip;
      chart.state = state;
      chart.dispatch = dispatch;
      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:      {get: function(){return width;}, set: function(_){width=_;}},
          height:     {get: function(){return height;}, set: function(_){height=_;}},
          showLegend: {get: function(){return showLegend;}, set: function(_){showLegend=_;}},
          legendPosition: {get: function(){return legendPosition;}, set: function(_){legendPosition=_;}},
          showXAxis:      {get: function(){return showXAxis;}, set: function(_){showXAxis=_;}},
          showYAxis:    {get: function(){return showYAxis;}, set: function(_){showYAxis=_;}},
          defaultState:    {get: function(){return defaultState;}, set: function(_){defaultState=_;}},
          noData:    {get: function(){return noData;}, set: function(_){noData=_;}},
          // Focus options, mostly passed onto focus model.
          focusEnable:    {get: function(){return focusEnable;}, set: function(_){focusEnable=_;}},
          focusHeight:     {get: function(){return focus.height();}, set: function(_){focus.height(_);}},
          focusShowAxisX:    {get: function(){return focus.showXAxis();}, set: function(_){focus.showXAxis(_);}},
          focusShowAxisY:    {get: function(){return focus.showYAxis();}, set: function(_){focus.showYAxis(_);}},
          brushExtent: {get: function(){return focus.brushExtent();}, set: function(_){focus.brushExtent(_);}},

          // options that require extra logic in the setter
          focusMargin: {get: function(){return focus.margin}, set: function(_){
              if (_.top !== undefined) {
                  margin.top = _.top;
                  marginTop = _.top;
              }
              focus.margin.right  = _.right  !== undefined ? _.right  : focus.margin.right;
              focus.margin.bottom = _.bottom !== undefined ? _.bottom : focus.margin.bottom;
              focus.margin.left   = _.left   !== undefined ? _.left   : focus.margin.left;
          }},
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
              lines.duration(duration);
              focus.duration(duration);
              xAxis.duration(duration);
              yAxis.duration(duration);
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
              legend.color(color);
              lines.color(color);
              focus.color(color);
          }},
          interpolate: {get: function(){return lines.interpolate();}, set: function(_){
              lines.interpolate(_);
              focus.interpolate(_);
          }},
          xTickFormat: {get: function(){return xAxis.tickFormat();}, set: function(_){
              xAxis.tickFormat(_);
              focus.xTickFormat(_);
          }},
          yTickFormat: {get: function(){return yAxis.tickFormat();}, set: function(_){
              yAxis.tickFormat(_);
              focus.yTickFormat(_);
          }},
          x: {get: function(){return lines.x();}, set: function(_){
              lines.x(_);
              focus.x(_);
          }},
          y: {get: function(){return lines.y();}, set: function(_){
              lines.y(_);
              focus.y(_);
          }},
          rightAlignYAxis: {get: function(){return rightAlignYAxis;}, set: function(_){
              rightAlignYAxis = _;
              yAxis.orient( rightAlignYAxis ? 'right' : 'left');
          }},
          valueFormat:    {get: function(){return lines.valueFormat();}, set: function(_){
            lines.valueFormat(_);
          }},
          useInteractiveGuideline: {get: function(){return useInteractiveGuideline;}, set: function(_){
              useInteractiveGuideline = _;
              if (useInteractiveGuideline) {
                  lines.interactive(false);
                  lines.useVoronoi(false);
              }
          }}
      });

      nv.utils.inheritOptions(chart, lines);
      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.linePlusBarChart2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var lines = nv.models.line2()
          , lines2 = nv.models.line2()
          , bars = nv.models.historicalBar2()
          , bars2 = nv.models.historicalBar2()
          , xAxis = nv.models.axis()
          , x2Axis = nv.models.axis()
          , y1Axis = nv.models.axis()
          , y2Axis = nv.models.axis()
          , y3Axis = nv.models.axis()
          , y4Axis = nv.models.axis()
          , legend = nv.models.legend3()
          , brush = d3.svg.brush()
          , tooltip = nv.models.tooltip()
          ;

      var margin = {top: 30, right: 30, bottom: 30, left: 60}
          , marginTop = null
          , margin2 = {top: 0, right: 30, bottom: 20, left: 60}
          , width = null
          , height = null
          , getX = function(d) { return d.x }
          , getY = function(d) { return d.y }
          , color = nv.utils.defaultColor()
          , showLegend = true
          , focusEnable = true
          , focusShowAxisY = false
          , focusShowAxisX = true
          , focusHeight = 50
          , extent
          , brushExtent = null
          , x
          , x2
          , y1
          , y2
          , y3
          , y4
          , noData = null
          , dispatch = d3.dispatch('brush', 'stateChange', 'changeState')
          , transitionDuration = 0
          , state = nv.utils.state()
          , defaultState = null
          , legendLeftAxisHint = ''
          , legendRightAxisHint = ''
          , switchYAxisOrder = false
          ;

      lines.clipEdge(true);
      lines2.interactive(false);
      // We don't want any points emitted for the focus chart's scatter graph.
      lines2.pointActive(function(d) { return false });
      xAxis.orient('bottom').tickPadding(25);
      y1Axis.orient('left');
      y2Axis.orient('right');
      x2Axis.orient('bottom').tickPadding(5);
      y3Axis.orient('left');
      y4Axis.orient('right');

      bars.clipEdge(false);
      bars2.clipEdge(false);

      tooltip.headerEnabled(true).headerFormatter(function(d, i) {
          return xAxis.tickFormat()(d, i);
      });

      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var getBarsAxis = function() {
          return switchYAxisOrder
              ? { main: y2Axis, focus: y4Axis }
              : { main: y1Axis, focus: y3Axis }
      }

      var getLinesAxis = function() {
          return switchYAxisOrder
              ? { main: y1Axis, focus: y3Axis }
              : { main: y2Axis, focus: y4Axis }
      }

      var stateGetter = function(data) {
          return function(){
              return {
                  active: data.map(function(d) { return !d.disabled })
              };
          }
      };

      var stateSetter = function(data) {
          return function(state) {
              if (state.active !== undefined)
                  data.forEach(function(series,i) {
                      series.disabled = !state.active[i];
                  });
          }
      };

      var allDisabled = function(data) {
        return data.every(function(series) {
          return series.disabled;
        });
      }

      function chart(selection) {
          selection.each(function(data) {
              var container = d3.select(this),
                  that = this;
              nv.utils.initSVG(container);
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight1 = nv.utils.availableHeight(height, container, margin)
                      - (focusEnable ? focusHeight : 0),
                  availableHeight2 = focusHeight - margin2.top - margin2.bottom;
              var availableWidthGap = availableWidth * 1 / data[ 0 ].values.length;
              availableWidth = availableWidth - availableWidthGap;
              // log( data[ 0 ].values.length );

              chart.update = function() { container.transition().duration(transitionDuration).call(chart); };
              chart.container = this;

              state
                  .setter(stateSetter(data), chart.update)
                  .getter(stateGetter(data))
                  .update();

              // DEPRECATED set state.disableddisabled
              state.disabled = data.map(function(d) { return !!d.disabled });

              if (!defaultState) {
                  var key;
                  defaultState = {};
                  for (key in state) {
                      if (state[key] instanceof Array)
                          defaultState[key] = state[key].slice(0);
                      else
                          defaultState[key] = state[key];
                  }
              }

              // Display No Data message if there's nothing to show.
              if (!data || !data.length || !data.filter(function(d) { return d.values.length }).length) {
                  nv.utils.noData(chart, container)
                  return chart;
              } else {
                  container.selectAll('.nv-noData').remove();
              }

              // Setup Scales
              var dataBars = data.filter(function(d) { return !d.disabled && d.bar });
              var dataLines = data.filter(function(d) { return !d.bar }); // removed the !d.disabled clause here to fix Issue #240

              if (dataBars.length && !switchYAxisOrder) {
                  x = bars.xScale();
              } else {
                  x = lines.xScale();
              }

              x2 = x2Axis.scale();

              // select the scales and series based on the position of the yAxis
              y1 = switchYAxisOrder ? lines.yScale() : bars.yScale();
              y2 = switchYAxisOrder ? bars.yScale() : lines.yScale();
              y3 = switchYAxisOrder ? lines2.yScale() : bars2.yScale();
              y4 = switchYAxisOrder ? bars2.yScale() : lines2.yScale();

              var series1 = data
                  .filter(function(d) { return !d.disabled && (switchYAxisOrder ? !d.bar : d.bar) })
                  .map(function(d) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d,i), y: getY(d,i) }
                      })
                  });

              var series2 = data
                  .filter(function(d) { return !d.disabled && (switchYAxisOrder ? d.bar : !d.bar) })
                  .map(function(d) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d,i), y: getY(d,i) }
                      })
                  });

              x.range([0, availableWidth]);

              x2  .domain(d3.extent(d3.merge(series1.concat(series2)), function(d) { return d.x } ))
                  .range([0, availableWidth]);

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-linePlusBar').data([data]);
              var gEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-linePlusBar').append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-legendWrap');

              // this is the main chart
              var focusEnter = gEnter.append('g').attr('class', 'nv-focus');
              focusEnter.append('g').attr('class', 'nv-x nv-axis');
              focusEnter.append('g').attr('class', 'nv-y1 nv-axis');
              focusEnter.append('g').attr('class', 'nv-y2 nv-axis');
              focusEnter.append('g').attr('class', 'nv-barsWrap');
              focusEnter.append('g').attr('class', 'nv-linesWrap');

              // context chart is where you can focus in
              var contextEnter = gEnter.append('g').attr('class', 'nv-context');
              contextEnter.append('g').attr('class', 'nv-x nv-axis');
              contextEnter.append('g').attr('class', 'nv-y1 nv-axis');
              contextEnter.append('g').attr('class', 'nv-y2 nv-axis');
              contextEnter.append('g').attr('class', 'nv-barsWrap');
              contextEnter.append('g').attr('class', 'nv-linesWrap');
              contextEnter.append('g').attr('class', 'nv-brushBackground');
              contextEnter.append('g').attr('class', 'nv-x nv-brush');

              //============================================================
              // Legend
              //------------------------------------------------------------

              if (!showLegend) {
                  g.select('.nv-legendWrap').selectAll('*').remove();
              } else {
                  var legendWidth = 0;
                  var legendXPosition = availableWidth + availableWidthGap / 2;

                  legend.width(legendWidth);

                  g.select('.nv-legendWrap')
                      .datum(data.map(function(series) {
                          series.originalKey = series.originalKey === undefined ? series.key : series.originalKey;
                          if(switchYAxisOrder) {
                              series.key = series.originalKey + (series.bar ? legendRightAxisHint : legendLeftAxisHint);
                          } else {
                              series.key = series.originalKey + (series.bar ? legendLeftAxisHint : legendRightAxisHint);
                          }
                          return series;
                      }))
                      .call(legend);

                  if (!marginTop && legend.height() !== margin.top) {
                      margin.top = legend.height();
                      // FIXME: shouldn't this be "- (focusEnabled ? focusHeight : 0)"?
                      availableHeight1 = nv.utils.availableHeight(height, container, margin) - focusHeight;
                  }

                  g.select('.nv-legendWrap')
                      .attr('transform', 'translate(' + legendXPosition + ',' + (availableHeight1 - legend.height()) / 2 +')');
              }

              wrap.attr('transform', 'translate(' + ( margin.left + availableWidthGap * 0.5 ) + ',' + margin.top + ')');

              //============================================================
              // Context chart (focus chart) components
              //------------------------------------------------------------

              // hide or show the focus context chart
              g.select('.nv-context').style('display', focusEnable ? 'initial' : 'none');

              bars2
                  .width(availableWidth)
                  .height(availableHeight2)
                  .color(data.map(function (d, i) {
                      return d.color || color(d, i);
                  }).filter(function (d, i) {
                      return !data[i].disabled && data[i].bar
                  }));
              lines2
                  .width(availableWidth)
                  .height(availableHeight2)
                  .color(data.map(function (d, i) {
                      return d.color || color(d, i);
                  }).filter(function (d, i) {
                      return !data[i].disabled && !data[i].bar
                  }));

              var bars2Wrap = g.select('.nv-context .nv-barsWrap')
                  .datum(dataBars.length ? dataBars : [
                      {values: []}
                  ]);
              var lines2Wrap = g.select('.nv-context .nv-linesWrap')
                  .datum(allDisabled(dataLines) ?
                         [{values: []}] :
                         dataLines.filter(function(dataLine) {
                           return !dataLine.disabled;
                         }));

              g.select('.nv-context')
                  .attr('transform', 'translate(0,' + ( availableHeight1 + margin.bottom + margin2.top) + ')');

              bars2Wrap.transition().call(bars2);
              lines2Wrap.transition().call(lines2);

              // context (focus chart) axis controls
              if (focusShowAxisX) {
                  x2Axis
                      ._ticks( nv.utils.calcTicksX(availableWidth / 10, data))
                      .tickSize(-availableHeight2, 0);
                  g.select('.nv-context .nv-x.nv-axis')
                      .attr('transform', 'translate(0,' + y3.range()[0] + ')');
                  g.select('.nv-context .nv-x.nv-axis').transition()
                      .call(x2Axis);
              }

              if (focusShowAxisY) {
                  y3Axis
                      .scale(y3)
                      ._ticks( availableHeight2 / 36 )
                      .tickSize( -availableWidth, 0);
                  y4Axis
                      .scale(y4)
                      ._ticks( availableHeight2 / 36 )
                      .tickSize(dataBars.length ? 0 : -availableWidth, 0); // Show the y2 rules only if y1 has none

                  g.select('.nv-context .nv-y3.nv-axis')
                      .style('opacity', dataBars.length ? 1 : 0)
                      .attr('transform', 'translate(0,' + x2.range()[0] + ')');
                  g.select('.nv-context .nv-y2.nv-axis')
                      .style('opacity', dataLines.length ? 1 : 0)
                      .attr('transform', 'translate(' + x2.range()[1] + ',0)');

                  g.select('.nv-context .nv-y1.nv-axis').transition()
                      .call(y3Axis);
                  g.select('.nv-context .nv-y2.nv-axis').transition()
                      .call(y4Axis);
              }

              // Setup Brush
              brush.x(x2).on('brush', onBrush);

              if (brushExtent) brush.extent(brushExtent);

              var brushBG = g.select('.nv-brushBackground').selectAll('g')
                  .data([brushExtent || brush.extent()]);

              var brushBGenter = brushBG.enter()
                  .append('g');

              brushBGenter.append('rect')
                  .attr('class', 'left')
                  .attr('x', 0)
                  .attr('y', 0)
                  .attr('height', availableHeight2);

              brushBGenter.append('rect')
                  .attr('class', 'right')
                  .attr('x', 0)
                  .attr('y', 0)
                  .attr('height', availableHeight2);

              var gBrush = g.select('.nv-x.nv-brush')
                  .call(brush);
              gBrush.selectAll('rect')
                  //.attr('y', -5)
                  .attr('height', availableHeight2);
              gBrush.selectAll('.resize').append('path').attr('d', resizePath);

              //============================================================
              // Event Handling/Dispatching (in chart's scope)
              //------------------------------------------------------------

              legend.dispatch.on('stateChange', function(newState) {
                  for (var key in newState)
                      state[key] = newState[key];
                  dispatch.stateChange(state);
                  chart.update();
              });

              // Update chart from a state object passed to event handler
              dispatch.on('changeState', function(e) {
                  if (typeof e.disabled !== 'undefined') {
                      data.forEach(function(series,i) {
                          series.disabled = e.disabled[i];
                      });
                      state.disabled = e.disabled;
                  }
                  chart.update();
              });

              //============================================================
              // Functions
              //------------------------------------------------------------

              // Taken from crossfilter (http://square.github.com/crossfilter/)
              function resizePath(d) {
                  var e = +(d == 'e'),
                      x = e ? 1 : -1,
                      y = availableHeight2 / 3;
                  return 'M' + (.5 * x) + ',' + y
                      + 'A6,6 0 0 ' + e + ' ' + (6.5 * x) + ',' + (y + 6)
                      + 'V' + (2 * y - 6)
                      + 'A6,6 0 0 ' + e + ' ' + (.5 * x) + ',' + (2 * y)
                      + 'Z'
                      + 'M' + (2.5 * x) + ',' + (y + 8)
                      + 'V' + (2 * y - 8)
                      + 'M' + (4.5 * x) + ',' + (y + 8)
                      + 'V' + (2 * y - 8);
              }


              function updateBrushBG() {
                  if (!brush.empty()) brush.extent(brushExtent);
                  brushBG
                      .data([brush.empty() ? x2.domain() : brushExtent])
                      .each(function(d,i) {
                          var leftWidth = x2(d[0]) - x2.range()[0],
                              rightWidth = x2.range()[1] - x2(d[1]);
                          d3.select(this).select('.left')
                              .attr('width',  leftWidth < 0 ? 0 : leftWidth);

                          d3.select(this).select('.right')
                              .attr('x', x2(d[1]))
                              .attr('width', rightWidth < 0 ? 0 : rightWidth);
                      });
              }

              function onBrush() {
                  brushExtent = brush.empty() ? null : brush.extent();
                  extent = brush.empty() ? x2.domain() : brush.extent();
                  dispatch.brush({extent: extent, brush: brush});
                  updateBrushBG();

                  // Prepare Main (Focus) Bars and Lines
                  bars
                      .width(availableWidth)
                      .height(availableHeight1)
                      .color(data.map(function(d,i) {
                          return d.color || color(d, i);
                      }).filter(function(d,i) { return !data[i].disabled && data[i].bar }));

                  lines
                      .width(availableWidth)
                      .height(availableHeight1)
                      .color(data.map(function(d,i) {
                          return d.color || color(d, i);
                      }).filter(function(d,i) { return !data[i].disabled && !data[i].bar }));

                  var focusBarsWrap = g.select('.nv-focus .nv-barsWrap')
                      .datum(!dataBars.length ? [{values:[]}] :
                          dataBars
                              .map(function(d,i) {
                                  return {
                                      key: d.key,
                                      values: d.values.filter(function(d,i) {
                                          return bars.x()(d,i) >= extent[0] && bars.x()(d,i) <= extent[1];
                                      })
                                  }
                              })
                  );

                  var focusLinesWrap = g.select('.nv-focus .nv-linesWrap')
                      .datum(allDisabled(dataLines) ? [{values:[]}] :
                             dataLines
                             .filter(function(dataLine) { return !dataLine.disabled; })
                             .map(function(d,i) {
                                  return {
                                      area: d.area,
                                      fillOpacity: d.fillOpacity,
                                      strokeWidth: d.strokeWidth,
                                      key: d.key,
                                      values: d.values.filter(function(d,i) {
                                          return lines.x()(d,i) >= extent[0] && lines.x()(d,i) <= extent[1];
                                      })
                                  }
                              })
                  );

                  // Update Main (Focus) X Axis
                  if (dataBars.length && !switchYAxisOrder) {
                      x = bars.xScale();
                  } else {
                      x = lines.xScale();
                  }

                  xAxis
                      .scale(x)
                      ._ticks( nv.utils.calcTicksX(availableWidth/10, data) )
                      .tickSize(-availableHeight1, 0);

                  xAxis.domain([Math.ceil(extent[0]), Math.floor(extent[1])]);

                  g.select('.nv-x.nv-axis').transition().duration(transitionDuration)
                      .call(xAxis);

                  // Update Main (Focus) Bars and Lines
                  focusBarsWrap.transition().duration(transitionDuration).call(bars);
                  focusLinesWrap.transition().duration(transitionDuration).call(lines);

                  // Setup and Update Main (Focus) Y Axes
                  g.select('.nv-focus .nv-x.nv-axis')
                      .attr('transform', 'translate(0,' + y1.range()[0] + ')');

                  y1Axis
                      .scale(y1)
                      ._ticks( nv.utils.calcTicksY(availableHeight1/36, data) )
                      .tickSize(-availableWidth, 0);
                  y2Axis
                      .scale(y2)
                      ._ticks( nv.utils.calcTicksY(availableHeight1/36, data) );

                  // Show the y2 rules only if y1 has none
                  if(!switchYAxisOrder) {
                      y2Axis.tickSize(dataBars.length ? 0 : -availableWidth, 0);
                  } else {
                      y2Axis.tickSize(dataLines.length ? 0 : -availableWidth, 0);
                  }

                  // Calculate opacity of the axis
                  var barsOpacity = dataBars.length ? 1 : 0;
                  var linesOpacity = dataLines.length && !allDisabled(dataLines) ? 1 : 0;

                  var y1Opacity = switchYAxisOrder ? linesOpacity : barsOpacity;
                  var y2Opacity = switchYAxisOrder ? barsOpacity : linesOpacity;

                  g.select('.nv-focus .nv-y1.nv-axis')
                      .style('opacity', y1Opacity);
                  g.select('.nv-focus .nv-y2.nv-axis')
                      .style('opacity', y2Opacity)
                      .attr('transform', 'translate(' + x.range()[1] + ',0)');

                  g.select('.nv-focus .nv-y1.nv-axis').transition().duration(transitionDuration)
                      .call(y1Axis);
                  g.select('.nv-focus .nv-y2.nv-axis').transition().duration(transitionDuration)
                      .call(y2Axis);
              }

              onBrush();

          });

          return chart;
      }

      //============================================================
      // Event Handling/Dispatching (out of chart's scope)
      //------------------------------------------------------------

      lines.dispatch.on('elementMouseover.tooltip', function(evt) {
          tooltip
              .duration(100)
              .valueFormatter(function(d, i) {
                  return getLinesAxis().main.tickFormat()(d, i) + ( evt.point.p != undefined ? ' (' + d3.format(',.1f')( evt.point.p ) + '%)' : '' );
              })
              .data(evt)
              .hidden(false);
      });

      lines.dispatch.on('elementMouseout.tooltip', function(evt) {
          tooltip.hidden(true)
      });

      bars.dispatch.on('elementMouseover.tooltip', function(evt) {
          evt.value = chart.x()(evt.data);
          evt['series'] = {
              key: evt.data.key,
              value: chart.y()(evt.data),
              color: evt.color
          };
          tooltip
              .duration(0)
              .valueFormatter(function(d, i) {
                  return getBarsAxis().main.tickFormat()(d, i);
              })
              .data(evt)
              .hidden(false);
      });

      bars.dispatch.on('elementMouseout.tooltip', function(evt) {
          tooltip.hidden(true);
      });

      bars.dispatch.on('elementMousemove.tooltip', function(evt) {
          tooltip();
      });

      //============================================================


      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      // expose chart's sub-components
      chart.dispatch = dispatch;
      chart.legend = legend;
      chart.lines = lines;
      chart.lines2 = lines2;
      chart.bars = bars;
      chart.bars2 = bars2;
      chart.xAxis = xAxis;
      chart.x2Axis = x2Axis;
      chart.y1Axis = y1Axis;
      chart.y2Axis = y2Axis;
      chart.y3Axis = y3Axis;
      chart.y4Axis = y4Axis;
      chart.tooltip = tooltip;

      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:      {get: function(){return width;}, set: function(_){width=_;}},
          height:     {get: function(){return height;}, set: function(_){height=_;}},
          showLegend: {get: function(){return showLegend;}, set: function(_){showLegend=_;}},
          brushExtent:    {get: function(){return brushExtent;}, set: function(_){brushExtent=_;}},
          noData:    {get: function(){return noData;}, set: function(_){noData=_;}},
          focusEnable:    {get: function(){return focusEnable;}, set: function(_){focusEnable=_;}},
          focusHeight:    {get: function(){return focusHeight;}, set: function(_){focusHeight=_;}},
          focusShowAxisX:    {get: function(){return focusShowAxisX;}, set: function(_){focusShowAxisX=_;}},
          focusShowAxisY:    {get: function(){return focusShowAxisY;}, set: function(_){focusShowAxisY=_;}},
          legendLeftAxisHint:    {get: function(){return legendLeftAxisHint;}, set: function(_){legendLeftAxisHint=_;}},
          legendRightAxisHint:    {get: function(){return legendRightAxisHint;}, set: function(_){legendRightAxisHint=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              if (_.top !== undefined) {
                  margin.top = _.top;
                  marginTop = _.top;
              }
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          focusMargin: {get: function(){return margin2;}, set: function(_){
              margin2.top    = _.top    !== undefined ? _.top    : margin2.top;
              margin2.right  = _.right  !== undefined ? _.right  : margin2.right;
              margin2.bottom = _.bottom !== undefined ? _.bottom : margin2.bottom;
              margin2.left   = _.left   !== undefined ? _.left   : margin2.left;
          }},
          duration: {get: function(){return transitionDuration;}, set: function(_){
              transitionDuration = _;
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
              legend.color(color);
          }},
          x: {get: function(){return getX;}, set: function(_){
              getX = _;
              lines.x(_);
              lines2.x(_);
              bars.x(_);
              bars2.x(_);
          }},
          y: {get: function(){return getY;}, set: function(_){
              getY = _;
              lines.y(_);
              lines2.y(_);
              bars.y(_);
              bars2.y(_);
          }},
          switchYAxisOrder:    {get: function(){return switchYAxisOrder;}, set: function(_){
              // Switch the tick format for the yAxis
              if(switchYAxisOrder !== _) {
                  var y1 = y1Axis;
                  y1Axis = y2Axis;
                  y2Axis = y1;

                  var y3 = y3Axis;
                  y3Axis = y4Axis;
                  y4Axis = y3;
              }
              switchYAxisOrder=_;

              y1Axis.orient('left');
              y2Axis.orient('right');
              y3Axis.orient('left');
              y4Axis.orient('right');
          }}
      });

      nv.utils.inheritOptions(chart, lines);
      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.multiBar2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var margin = {top: 0, right: 0, bottom: 0, left: 0}
          , width = 960
          , height = 500
          , x = d3.scale.ordinal()
          , y = d3.scale.linear()
          , id = Math.floor(Math.random() * 10000) //Create semi-unique ID in case user doesn't select one
          , container = null
          , getX = function(d) { return d.x }
          , getY = function(d) { return d.y }
          , forceY = [0] // 0 is forced by default.. this makes sense for the majority of bar graphs... user can always do chart.forceY([]) to remove
          , clipEdge = true
          , stacked = false
          , stackOffset = 'zero' // options include 'silhouette', 'wiggle', 'expand', 'zero', or a custom function
          , color = nv.utils.defaultColor()
          , hideable = false
          , barColor = null // adding the ability to set the color for each rather than the whole group
          , disabled // used in conjunction with barColor to communicate from multiBarHorizontalChart what series are disabled
          , duration = 500
          , xDomain
          , yDomain
          , xRange
          , yRange
          , groupSpacing = 0.1
          , fillOpacity = 0.75
          , dispatch = d3.dispatch('chartClick', 'elementClick', 'elementDblClick', 'elementMouseover', 'elementMouseout', 'elementMousemove', 'renderEnd')
          , showValues = true
          , valueFormat = d3.format(',.0f')
          , valueColor = null
          , firstX = 0
          ;

      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x0, y0 //used to store previous scales
          , renderWatch = nv.utils.renderWatch(dispatch, duration)
          ;

      var last_datalength = 0;

      function chart(selection) {
          renderWatch.reset();
          selection.each(function(data) {
              var availableWidth = width - margin.left - margin.right,
                  availableHeight = height - margin.top - margin.bottom;

              container = d3.select(this);
              nv.utils.initSVG(container);
              var nonStackableCount = 0;
              // This function defines the requirements for render complete
              var endFn = function(d, i) {
                  if (d.series === data.length - 1 && i === data[0].values.length - 1)
                      return true;
                  return false;
              };

              if(hideable && data.length) hideable = [{
                  values: data[0].values.map(function(d) {
                          return {
                              x: d.x,
                              y: 0,
                              series: d.series,
                              size: 0.01
                          };}
                  )}];

              if (stacked) {
                  var parsed = d3.layout.stack()
                      .offset(stackOffset)
                      .values(function(d){ return d.values })
                      .y(getY)
                  (!data.length && hideable ? hideable : data);

                  parsed.forEach(function(series, i){
                      // if series is non-stackable, use un-parsed data
                      if (series.nonStackable) {
                          data[i].nonStackableSeries = nonStackableCount++;
                          parsed[i] = data[i];
                      } else {
                          // don't stack this seires on top of the nonStackable seriees
                          if (i > 0 && parsed[i - 1].nonStackable){
                              parsed[i].values.map(function(d,j){
                                  d.y0 -= parsed[i - 1].values[j].y;
                                  d.y1 = d.y0 + d.y;
                              });
                          }
                      }
                  });
                  data = parsed;
              }
              //add series index and key to each data point for reference
              data.forEach(function(series, i) {
                  series.values.forEach(function(point) {
                      point.series = i;
                      point.key = series.key;
                  });
              });

              // HACK for negative value stacking
              if (stacked && data.length > 0) {
                  data[0].values.map(function(d,i) {
                      var posBase = 0, negBase = 0;
                      data.map(function(d, idx) {
                          if (!data[idx].nonStackable) {
                              var f = d.values[i]
                              f.size = Math.abs(f.y);
                              if (f.y<0) {
                                  f.y1 = negBase;
                                  negBase = negBase - f.size;
                              } else {
                                  f.y1 = f.size + posBase;
                                  posBase = posBase + f.size;
                              }
                          }

                      });
                  });
              }
              // Setup Scales
              // remap and flatten the data for use in calculating the scales' domains
              var seriesData = (xDomain && yDomain) ? [] : // if we know xDomain and yDomain, no need to calculate
                  data.map(function(d, idx) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d,i), y: getY(d,i), y0: d.y0, y1: d.y1, idx:idx }
                      })
                  });

              x.domain(xDomain || d3.merge(seriesData).map(function(d) { return d.x }))
                  .rangeBands(xRange || [0, availableWidth], groupSpacing);

              y.domain(yDomain || d3.extent(d3.merge(seriesData).map(function(d) {
                  var domain = d.y;
                  // increase the domain range if this series is stackable
                  if (stacked && !data[d.idx].nonStackable) {
                      if (d.y > 0){
                          domain = d.y1
                      } else {
                          domain = d.y1 + d.y
                      }
                  }
                  return domain;
              }).concat(forceY)))
              .range(yRange || [availableHeight, 0]);

              // If scale's domain don't have a range, slightly adjust to make one... so a chart can show a single data point
              if (x.domain()[0] === x.domain()[1])
                  x.domain()[0] ?
                      x.domain([x.domain()[0] - x.domain()[0] * 0.01, x.domain()[1] + x.domain()[1] * 0.01])
                      : x.domain([-1,1]);

              if (y.domain()[0] === y.domain()[1])
                  y.domain()[0] ?
                      y.domain([y.domain()[0] + y.domain()[0] * 0.01, y.domain()[1] - y.domain()[1] * 0.01])
                      : y.domain([-1,1]);

              x0 = x0 || x;
              y0 = y0 || y;

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-multibar').data([data]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-multibar');
              var defsEnter = wrapEnter.append('defs');
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-groups');
              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              defsEnter.append('clipPath')
                  .attr('id', 'nv-edge-clip-' + id)
                  .append('rect');
              wrap.select('#nv-edge-clip-' + id + ' rect')
                  .attr('width', availableWidth)
                  .attr('height', availableHeight);

              g.attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + id + ')' : '');

              var groups = wrap.select('.nv-groups').selectAll('.nv-group')
                  .data(function(d) { return d }, function(d,i) { return i });
              groups.enter().append('g')
                  .style('stroke-opacity', 1e-6)
                  .style('fill-opacity', 1e-6);
              groups.exit().remove();

              groups
                  .attr('class', function(d,i) { return 'nv-group nv-series-' + i })
                  .classed('hover', function(d) { return d.hover })
                  .style('fill', function(d,i){ return color(d, i) })
                  .style('stroke', function(d,i){ return color(d, i) });
              groups
                  .style('stroke-opacity', 1)
                  .style('fill-opacity', fillOpacity);

              var bars = groups.selectAll('g.nv-bar')
                  .data(function(d) { return (hideable && !data.length) ? hideable.values : d.values });
              bars.exit().remove();

              var barsEnter = bars.enter().append('g')
                      .attr('class', function(d,i) { return getY(d,i) < 0 ? 'nv-bar negative' : 'nv-bar positive'})
                      .attr('height', 0)
		                  .attr('transform', function(d,i,j) {
		                      var left = stacked && !data[j].nonStackable ? 0 : d.series * x.rangeBand() / data.length;
		                      var top = 0;
													if( stacked ) {
														if (!data[j].nonStackable) {
															top = y(d.y1);
														} else {
															if (getY(d,i) < 0){
																top = y(0);
															} else {
																if (y(0) - y(getY(d,i)) < -1){
																	top = y(0) - 1;
																} else {
																	top = y(getY(d, i)) || 0;
																}
															}
														}
													} else {
														top = getY(d,i) < 0 ? y(0) : y(0) - y(getY(d,i)) < 1 ? y(0) - 1 : y(getY(d,i)) || 0;
													}
		                      return 'translate(' + ( left + x(getX(d,i)) ) + ', ' + top + ')'
		                  })
                  ;

              // dk
              barsEnter.append('rect')
                  // .attr('height', 0)
                  ;
              if (showValues) {
                  barsEnter.append('text')
                    .style('fill', valueColor)
                    .style('fill-opacity', 1)
                    .style('stroke-opacity', 0)
                    .attr('text-anchor', 'middle')
                    .text(function(d,i) { return d.p == undefined ? valueFormat(getY(d,i)) : valueFormat(getY(d,i)) + ' (' + d3.format(',.1f')( d.p ) + '%)' })
                    ;
              } else {
                  barsEnter.selectAll('text').remove();
              }

              bars
                  // .style('fill', function(d,i,j){ return color(d, j, i);  })
                  // .style('stroke', function(d,i,j){ return color(d, j, i); })
                  .on('mouseover', function(d,i) { //TODO: figure out why j works above, but not here
                      d3.select(this).classed('hover', true);
                      dispatch.elementMouseover({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('mouseout', function(d,i) {
                      d3.select(this).classed('hover', false);
                      dispatch.elementMouseout({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('mousemove', function(d,i) {
                      dispatch.elementMousemove({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('click', function(d,i) {
                      var element = this;
                      dispatch.elementClick({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill"),
                          event: d3.event,
                          element: element
                      });
                      d3.event.stopPropagation();
                  })
                  .on('dblclick', function(d,i) {
                      dispatch.elementDblClick({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                      d3.event.stopPropagation();
                  });

              if (barColor) {
                  if (!disabled) disabled = data.map(function() { return true });
                  bars
                      .style('fill', function(d,i,j) { return d3.rgb(barColor(d,j)); })
                      .style('stroke', function(d,i,j) { return d3.rgb(barColor(d,j)); });
              }

              var barSelection =
                  bars.watchTransition(renderWatch, 'multibar', Math.min(250, duration))
                      // .delay(function(d,i) {
                      //     return i * duration / data[0].values.length;
                      // });
              if (stacked){
                  barSelection
                      .attr('transform', function(d,i,j) {
                          var left = stacked && !data[j].nonStackable ? 0 : (j * x.rangeBand() / data.length );
                          var top = 0;
                          if (!data[j].nonStackable) {
                              top = y(d.y1);
                          } else {
                              if (getY(d,i) < 0){
                                  top = y(0);
                              } else {
                                  if (y(0) - y(getY(d,i)) < -1){
                                      top = y(0) - 1;
                                  } else {
                                      top = y(getY(d, i)) || 0;
                                  }
                              }
                          }
                          if( i == 0 && j == 0 ) firstX = left + x(getX(d,i)) + x.rangeBand() / 2 + margin.left;
                          return 'translate(' + ( left + x(getX(d,i)) ) + ', ' + top + ')'
                      })
                      .attr('width', function(d,i,j){
                          if (!data[j].nonStackable) {
                              return x.rangeBand();
                          } else {
                              // if all series are nonStacable, take the full width
                              var width = (x.rangeBand() / nonStackableCount);
                              // otherwise, nonStackable graph will be only taking the half-width
                              // of the x rangeBand
                              if (data.length !== nonStackableCount) {
                                  width = x.rangeBand()/(nonStackableCount*2);
                              }
                              return width;
                          }
                      })
                      .attr('height', function(d,i,j) {
                          if (!data[j].nonStackable) {
                              return Math.max(Math.abs(y(d.y+d.y0) - y(d.y0)), 0);
                          } else {
                              return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) || 0;
                          }
                      });
                  barSelection.select('rect')
                      .attr('x', x.rangeBand() * .01 / data.length)
                      .attr('width', function(d,i,j){
                          if (!data[j].nonStackable) {
                              return x.rangeBand();
                          } else {
                              // if all series are nonStacable, take the full width
                              var width = (x.rangeBand() / nonStackableCount);
                              // otherwise, nonStackable graph will be only taking the half-width
                              // of the x rangeBand
                              if (data.length !== nonStackableCount) {
                                  width = x.rangeBand()/(nonStackableCount*2);
                              }
                              return width;
                          }
                      })
                      .attr('height', function(d,i,j) {
                          if (!data[j].nonStackable) {
                              return Math.max(Math.abs(y(d.y+d.y0) - y(d.y0)), 0);
                          } else {
                              return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) || 0;
                          }
                      })
                      ;
                  barSelection.select('text')
                      .attr('x', x.rangeBand() / 2)
                      .attr('y', function(d,i,j) {
                          if (!data[j].nonStackable) {
                              return Math.max(Math.abs(y(d.y+d.y0) - y(d.y0)), 0) / 2 + 4;
                          } else {
                              return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) / 2 + 4 || 0;
                          }
                      })
                      ;
              } else {
                  barSelection
                      .attr('transform', function(d,i,j) {
                          var left = d.series * x.rangeBand() / data.length;

                          var top = getY(d,i) < 0 ? y(0) : y(0) - y(getY(d,i)) < 1 ? y(0) - 1 : y(getY(d,i)) || 0;

                          if( i == 0 && j == 0 ) firstX = left + x(getX(d,i)) + x.rangeBand() / 2 + margin.left;
                          return 'translate(' + ( left + x(getX(d,i)) ) + ', ' + top + ')'
                      })
                      .attr('width', x.rangeBand() / data.length)
                      .attr('height', function(d,i) {
                          return Math.max(Math.abs(y(getY(d,i)) - y(0)),1) || 0;
                      });
                  barSelection.select('rect')
                      .attr('x', x.rangeBand() * .05 / data.length)
                      .attr('width', x.rangeBand() * .9 / data.length)
                      .attr('height', function(d,i) {
                          return Math.max(Math.abs(y(getY(d,i)) - y(0)),1) || 0;
                      });
                  barSelection.select('text')
                      .attr('x', x.rangeBand() / data.length / 2)
                      .attr('y', function(d,i,j) {
                          if (!data[j].nonStackable) {
														var ypos = Math.max(Math.abs(y(getY(d)) - y(0)), 0) + 10;
                            ypos = d.y < 0 ? ypos : -2;
                            return ypos;
                          } else {
                            return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) / 2 + 4 || 0;
                          }
                      })
                      ;
              }

              //store old scales for use in transitions on update
              x0 = x.copy();
              y0 = y.copy();

              // keep track of the last data value length for transition calculations
              if (data[0] && data[0].values) {
                  last_datalength = data[0].values.length;
              }

              if (stacked && data[0].values[0].total !== undefined ){
                // 누계
                wrap = container.selectAll('g.nv-total').data([data]);
                wrap.enter().append('g').attr('class', 'nv-total');
                wrap.exit().remove();
                wrapEnter = container.select('g.nv-total');
                var tGroups = wrapEnter.selectAll('.nv-group')
                    .data(function(d) { return d[0].values }, function(d,i) { return i });
                tGroups.exit().remove();

                var tEnter = tGroups.enter().append('g')
                    .attr('class', function(d,i) { return 'nv-group nv-total-' + i });


                tEnter.append('text');
                tGroups.select('text')
                    .text(function(d,i) { return d.total.p == undefined ? valueFormat(d.total.y) : valueFormat(d.total.y) + ' (' + d3.format(',.1f')( d.total.p ) + '%)' })
                    // .style('fill', valueColor)
                    // .style('fill-opacity', 1)
                    // .style('stroke-opacity', 0)
                    .attr('text-anchor', 'middle')
                    .attr('transform', function(d,i) {
                        var left = x( d.x ) + x.rangeBand() / 2;
                        // var top = y(d.total.y > 0 ? d.total.y : 0) - 5;
                        var top = y(d.total.y2) - 5;
                        return 'translate(' + left + ', ' + top + ')'
                    });

              } else {
                container.selectAll('g.nv-total').remove();
              }

          });

          renderWatch.renderEnd('multibar total immediate');

          return chart;
      }

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;

      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:   {get: function(){return width;}, set: function(_){width=_;}},
          height:  {get: function(){return height;}, set: function(_){height=_;}},
          x:       {get: function(){return getX;}, set: function(_){getX=_;}},
          y:       {get: function(){return getY;}, set: function(_){getY=_;}},
          xScale:  {get: function(){return x;}, set: function(_){x=_;}},
          yScale:  {get: function(){return y;}, set: function(_){y=_;}},
          xDomain: {get: function(){return xDomain;}, set: function(_){xDomain=_;}},
          yDomain: {get: function(){return yDomain;}, set: function(_){yDomain=_;}},
          xRange:  {get: function(){return xRange;}, set: function(_){xRange=_;}},
          yRange:  {get: function(){return yRange;}, set: function(_){yRange=_;}},
          forceY:  {get: function(){return forceY;}, set: function(_){forceY=_;}},
          stacked: {get: function(){return stacked;}, set: function(_){stacked=_;}},
          stackOffset: {get: function(){return stackOffset;}, set: function(_){stackOffset=_;}},
          clipEdge:    {get: function(){return clipEdge;}, set: function(_){clipEdge=_;}},
          disabled:    {get: function(){return disabled;}, set: function(_){disabled=_;}},
          id:          {get: function(){return id;}, set: function(_){id=_;}},
          hideable:    {get: function(){return hideable;}, set: function(_){hideable=_;}},
          groupSpacing:{get: function(){return groupSpacing;}, set: function(_){groupSpacing=_;}},
          fillOpacity: {get: function(){return fillOpacity;}, set: function(_){fillOpacity=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }},
          barColor:  {get: function(){return barColor;}, set: function(_){
              barColor = _ ? nv.utils.getColor(_) : null;
          }},
          showValues: {get: function(){return showValues;}, set: function(_){showValues=_;}},
          valueColor:  {get: function(){return valueColor;}, set: function(_){
              valueColor = _ ? nv.utils.getColor(_) : null;
          }},
          firstX:   {get: function(){return firstX;}, set: function(_){firstX=_;}}
      });

      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.multiBar3 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var margin = {top: 0, right: 0, bottom: 0, left: 0}
          , width = 960
          , height = 500
          , x = d3.scale.ordinal()
          , y = d3.scale.linear()
          , id = Math.floor(Math.random() * 10000) //Create semi-unique ID in case user doesn't select one
          , container = null
          , getX = function(d) { return d.x }
          , getY = function(d) { return d.y }
          , forceY = [0] // 0 is forced by default.. this makes sense for the majority of bar graphs... user can always do chart.forceY([]) to remove
          , clipEdge = true
          , stacked = false
          , stackOffset = 'zero' // options include 'silhouette', 'wiggle', 'expand', 'zero', or a custom function
          , color = nv.utils.defaultColor()
          , hideable = false
          , barColor = null // adding the ability to set the color for each rather than the whole group
          , disabled // used in conjunction with barColor to communicate from multiBarHorizontalChart what series are disabled
          , duration = 500
          , xDomain
          , yDomain
          , xRange
          , yRange
          , groupSpacing = 0.1
          , groupSpacing2 = 0.5
          , fillOpacity = 0.75
          , dispatch = d3.dispatch('chartClick', 'elementClick', 'elementDblClick', 'elementMouseover', 'elementMouseout', 'elementMousemove', 'renderEnd')
          , showValues = true
          , valueFormat = d3.format(',.0f')
          , valueColor = null
          , firstX = 0
          ;

      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x0, y0 //used to store previous scales
          , renderWatch = nv.utils.renderWatch(dispatch, duration)
          ;

      var last_datalength = 0;

      function chart(selection) {
          renderWatch.reset();
          selection.each(function(data) {
              var availableWidth = width - margin.left - margin.right,
                  availableHeight = height - margin.top - margin.bottom;

              container = d3.select(this);
              nv.utils.initSVG(container);
              var nonStackableCount = 0;
              // This function defines the requirements for render complete
              var endFn = function(d, i) {
                  if (d.series === data.length - 1 && i === data[0].values.length - 1)
                      return true;
                  return false;
              };

              if(hideable && data.length) hideable = [{
                  values: data[0].values.map(function(d) {
                          return {
                              x: d.x,
                              y: 0,
                              series: d.series,
                              size: 0.01
                          };}
                  )}];

              if (stacked) {
                  var parsed = d3.layout.stack()
                      .offset(stackOffset)
                      .values(function(d){ return d.values })
                      .y(getY)
                  (!data.length && hideable ? hideable : data);

                  parsed.forEach(function(series, i){
                      // if series is non-stackable, use un-parsed data
                      if (series.nonStackable) {
                          data[i].nonStackableSeries = nonStackableCount++;
                          parsed[i] = data[i];
                      } else {
                          // don't stack this seires on top of the nonStackable seriees
                          if (i > 0 && parsed[i - 1].nonStackable){
                              parsed[i].values.map(function(d,j){
                                  d.y0 -= parsed[i - 1].values[j].y;
                                  d.y1 = d.y0 + d.y;
                              });
                          }
                      }
                  });
                  data = parsed;
              }
              //add series index and key to each data point for reference
              data.forEach(function(series, i) {
                  series.values.forEach(function(point) {
                      point.series = i;
                      point.key = series.key;
                  });
              });

              // HACK for negative value stacking
              if (stacked && data.length > 0) {
                  data[0].values.map(function(d,i) {
                      var posBase = 0, negBase = 0;
                      data.map(function(d, idx) {
                          if (!data[idx].nonStackable) {
                              var f = d.values[i]
                              f.size = Math.abs(f.y);
                              if (f.y<0) {
                                  f.y1 = negBase;
                                  negBase = negBase - f.size;
                              } else {
                                  f.y1 = f.size + posBase;
                                  posBase = posBase + f.size;
                              }
                          }

                      });
                  });
              }
              // Setup Scales
              // remap and flatten the data for use in calculating the scales' domains
              var seriesData = (xDomain && yDomain) ? [] : // if we know xDomain and yDomain, no need to calculate
                  data.map(function(d, idx) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d,i), y: getY(d,i), y0: d.y0, y1: d.y1, idx:idx }
                      })
                  });

              x.domain(xDomain || d3.merge(seriesData).map(function(d) { return d.x }))
                  .rangeBands(xRange || [0, availableWidth], groupSpacing);

              y.domain(yDomain || d3.extent(d3.merge(seriesData).map(function(d) {
                  var domain = d.y;
                  // increase the domain range if this series is stackable
                  if (stacked && !data[d.idx].nonStackable) {
                      if (d.y > 0){
                          domain = d.y1
                      } else {
                          domain = d.y1 + d.y
                      }
                  }
                  return domain;
              }).concat(forceY)))
              .range(yRange || [availableHeight, 0]);

              // If scale's domain don't have a range, slightly adjust to make one... so a chart can show a single data point
              if (x.domain()[0] === x.domain()[1])
                  x.domain()[0] ?
                      x.domain([x.domain()[0] - x.domain()[0] * 0.01, x.domain()[1] + x.domain()[1] * 0.01])
                      : x.domain([-1,1]);

              if (y.domain()[0] === y.domain()[1])
                  y.domain()[0] ?
                      y.domain([y.domain()[0] + y.domain()[0] * 0.01, y.domain()[1] - y.domain()[1] * 0.01])
                      : y.domain([-1,1]);

              x0 = x0 || x;
              y0 = y0 || y;

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-multibar').data([data]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-multibar');
              var defsEnter = wrapEnter.append('defs');
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-groups');
              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              defsEnter.append('clipPath')
                  .attr('id', 'nv-edge-clip-' + id)
                  .append('rect');
              wrap.select('#nv-edge-clip-' + id + ' rect')
                  .attr('width', availableWidth)
                  .attr('height', availableHeight);

              g.attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + id + ')' : '');

              var groups = wrap.select('.nv-groups').selectAll('.nv-group')
                  .data(function(d) { return d }, function(d,i) { return i });
              groups.enter().append('g')
                  .style('stroke-opacity', 1e-6)
                  .style('fill-opacity', 1e-6);
              groups.exit().remove();

              groups
                  .attr('class', function(d,i) { return 'nv-group nv-series-' + i })
                  .classed('hover', function(d) { return d.hover })
                  .style('fill', function(d,i){ return color(d, i) })
                  .style('stroke', function(d,i){ return color(d, i) });
              groups
                  .style('stroke-opacity', 1)
                  .style('fill-opacity', fillOpacity);

              var bars = groups.selectAll('g.nv-bar')
                  .data(function(d) { return (hideable && !data.length) ? hideable.values : d.values });
              bars.exit().remove();

              var barsEnter = bars.enter().append('g')
                      .attr('class', function(d,i) { return getY(d,i) < 0 ? 'nv-bar negative' : 'nv-bar positive'})
                      .attr('height', 0)
		                  .attr('transform', function(d,i,j) {
		                      var left = stacked && !data[j].nonStackable ? 0 : d.series * x.rangeBand() / data.length;
		                      var top = 0;
													if( stacked ) {
														if (!data[j].nonStackable) {
															top = y(d.y1);
														} else {
															if (getY(d,i) < 0){
																top = y(0);
															} else {
																if (y(0) - y(getY(d,i)) < -1){
																	top = y(0) - 1;
																} else {
																	top = y(getY(d, i)) || 0;
																}
															}
														}
													} else {
														top = getY(d,i) < 0 ? y(0) : y(0) - y(getY(d,i)) < 1 ? y(0) - 1 : y(getY(d,i)) || 0;
													}
		                      return 'translate(' + ( left + x(getX(d,i)) ) + ', ' + top + ')'
		                  })
                  ;

              // dk
              barsEnter.append('rect')
                  .attr('height', 0)
                  ;
              if (showValues) {
                  barsEnter.append('text')
                    // .style('fill', valueColor)
                    .style('fill-opacity', 1)
                    .style('stroke-opacity', 0)
                    // .attr('text-anchor', 'middle')
                    .text(function(d,i) { return d.p == undefined ? valueFormat(getY(d,i)) : valueFormat(getY(d,i)) + ' ' + d.p })
                    ;
              } else {
                  barsEnter.selectAll('text').remove();
              }

              bars
                  // .style('fill', function(d,i,j){ return color(d, j, i);  })
                  // .style('stroke', function(d,i,j){ return color(d, j, i); })
                  .on('mouseover', function(d,i) { //TODO: figure out why j works above, but not here
                      d3.select(this).classed('hover', true);
                      dispatch.elementMouseover({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('mouseout', function(d,i) {
                      d3.select(this).classed('hover', false);
                      dispatch.elementMouseout({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('mousemove', function(d,i) {
                      dispatch.elementMousemove({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                  })
                  .on('click', function(d,i) {
                      var element = this;
                      dispatch.elementClick({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill"),
                          event: d3.event,
                          element: element
                      });
                      d3.event.stopPropagation();
                  })
                  .on('dblclick', function(d,i) {
                      dispatch.elementDblClick({
                          data: d,
                          index: i,
                          color: d3.select(this).style("fill")
                      });
                      d3.event.stopPropagation();
                  });

              if (barColor) {
                  if (!disabled) disabled = data.map(function() { return true });
                  bars
                      .style('fill', function(d,i,j) { return d3.rgb(barColor(d,j)); })
                      .style('stroke', function(d,i,j) { return d3.rgb(barColor(d,j)); });
              }

              var barSelection =
                  bars.watchTransition(renderWatch, 'multibar', Math.min(250, duration))
                      .delay(function(d,i) {
                          return i * duration / data[0].values.length;
                      });
              if (stacked){
                  barSelection
                      .attr('transform', function(d,i,j) {
                          var left = stacked && !data[j].nonStackable ? 0 : (j * x.rangeBand() / data.length );
                          var top = 0;
                          if (!data[j].nonStackable) {
                              top = y(d.y1);
                          } else {
                              if (getY(d,i) < 0){
                                  top = y(0);
                              } else {
                                  if (y(0) - y(getY(d,i)) < -1){
                                      top = y(0) - 1;
                                  } else {
                                      top = y(getY(d, i)) || 0;
                                  }
                              }
                          }
                          if( i == 0 && j == 0 ) firstX = left + x(getX(d,i)) + x.rangeBand() / 2 + margin.left;
                          return 'translate(' + ( left + x(getX(d,i)) ) + ', ' + top + ')'
                      })
                      .attr('width', function(d,i,j){
                          if (!data[j].nonStackable) {
                              return x.rangeBand();
                          } else {
                              // if all series are nonStacable, take the full width
                              var width = (x.rangeBand() / nonStackableCount);
                              // otherwise, nonStackable graph will be only taking the half-width
                              // of the x rangeBand
                              if (data.length !== nonStackableCount) {
                                  width = x.rangeBand()/(nonStackableCount*2);
                              }
                              return width;
                          }
                      })
                      .attr('height', function(d,i,j) {
                          if (!data[j].nonStackable) {
                              return Math.max(Math.abs(y(d.y+d.y0) - y(d.y0)), 0);
                          } else {
                              return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) || 0;
                          }
                      });
                  barSelection.select('rect')
                      .attr('x', x.rangeBand() * .01 / data.length + x.rangeBand() * groupSpacing2 * 0.5)
                      .attr('width', function(d,i,j){
                          if (!data[j].nonStackable) {
                              return x.rangeBand() * groupSpacing2;
                          } else {
                              // if all series are nonStacable, take the full width
                              var width = (x.rangeBand() / nonStackableCount);
                              // otherwise, nonStackable graph will be only taking the half-width
                              // of the x rangeBand
                              if (data.length !== nonStackableCount) {
                                  width = x.rangeBand()/(nonStackableCount*2);
                              }
                              return width;
                          }
                      })
                      .attr('height', function(d,i,j) {
                          if (!data[j].nonStackable) {
                              return Math.max(Math.abs(y(d.y+d.y0) - y(d.y0)), 0);
                          } else {
                              return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) || 0;
                          }
                      })
                      ;
                  barSelection.select('text')
                      .attr('x', x.rangeBand() + 5 - x.rangeBand() * groupSpacing2 * 0.5)
                      .attr('y', function(d,i,j) {
                          if (!data[j].nonStackable) {
                              return Math.max(Math.abs(y(d.y+d.y0) - y(d.y0)), 0) / 2 + 4;
                          } else {
                              return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) / 2 + 4 || 0;
                          }
                      })
                      ;
              } else {
                  barSelection
                      .attr('transform', function(d,i,j) {
                          var left = d.series * x.rangeBand() / data.length;

                          var top = getY(d,i) < 0 ? y(0) : y(0) - y(getY(d,i)) < 1 ? y(0) - 1 : y(getY(d,i)) || 0;

                          if( i == 0 && j == 0 ) firstX = left + x(getX(d,i)) + x.rangeBand() / 2 + margin.left;
                          return 'translate(' + ( left + x(getX(d,i)) ) + ', ' + top + ')'
                      })
                      .attr('width', x.rangeBand() / data.length)
                      .attr('height', function(d,i) {
                          return Math.max(Math.abs(y(getY(d,i)) - y(0)),1) || 0;
                      });
                  barSelection.select('rect')
                      .attr('x', x.rangeBand() * .05 / data.length)
                      .attr('width', x.rangeBand() * .9 / data.length)
                      .attr('height', function(d,i) {
                          return Math.max(Math.abs(y(getY(d,i)) - y(0)),1) || 0;
                      });
                  barSelection.select('text')
                      .attr('x', x.rangeBand() / data.length / 2)
                      .attr('y', function(d,i,j) {
                          if (!data[j].nonStackable) {
														// var ypos = d.y0 || 0;
                            return -4;
                          } else {
                            return Math.max(Math.abs(y(getY(d,i)) - y(0)), 0) / 2 + 4 || 0;
                          }
                      })
                      ;
              }

              //store old scales for use in transitions on update
              x0 = x.copy();
              y0 = y.copy();

              // keep track of the last data value length for transition calculations
              if (data[0] && data[0].values) {
                  last_datalength = data[0].values.length;
              }

          });

          renderWatch.renderEnd('multibar total immediate');

          return chart;
      }

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;

      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:   {get: function(){return width;}, set: function(_){width=_;}},
          height:  {get: function(){return height;}, set: function(_){height=_;}},
          x:       {get: function(){return getX;}, set: function(_){getX=_;}},
          y:       {get: function(){return getY;}, set: function(_){getY=_;}},
          xScale:  {get: function(){return x;}, set: function(_){x=_;}},
          yScale:  {get: function(){return y;}, set: function(_){y=_;}},
          xDomain: {get: function(){return xDomain;}, set: function(_){xDomain=_;}},
          yDomain: {get: function(){return yDomain;}, set: function(_){yDomain=_;}},
          xRange:  {get: function(){return xRange;}, set: function(_){xRange=_;}},
          yRange:  {get: function(){return yRange;}, set: function(_){yRange=_;}},
          forceY:  {get: function(){return forceY;}, set: function(_){forceY=_;}},
          stacked: {get: function(){return stacked;}, set: function(_){stacked=_;}},
          stackOffset: {get: function(){return stackOffset;}, set: function(_){stackOffset=_;}},
          clipEdge:    {get: function(){return clipEdge;}, set: function(_){clipEdge=_;}},
          disabled:    {get: function(){return disabled;}, set: function(_){disabled=_;}},
          id:          {get: function(){return id;}, set: function(_){id=_;}},
          hideable:    {get: function(){return hideable;}, set: function(_){hideable=_;}},
          groupSpacing:{get: function(){return groupSpacing;}, set: function(_){groupSpacing=_;}},
          fillOpacity: {get: function(){return fillOpacity;}, set: function(_){fillOpacity=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }},
          barColor:  {get: function(){return barColor;}, set: function(_){
              barColor = _ ? nv.utils.getColor(_) : null;
          }},
          showValues: {get: function(){return showValues;}, set: function(_){showValues=_;}},
          valueColor:  {get: function(){return valueColor;}, set: function(_){
              valueColor = _ ? nv.utils.getColor(_) : null;
          }},
          firstX:   {get: function(){return firstX;}, set: function(_){firstX=_;}}
      });

      nv.utils.initOptions(chart);

      return chart;
  };

	nv.models.multiBarChart2 = function() {
	      "use strict";

	      //============================================================
	      // Public Variables with Default Settings
	      //------------------------------------------------------------

	      var multibar = nv.models.multiBar2()
	          , xAxis = nv.models.axis()
	          , yAxis = nv.models.axis()
	          , interactiveLayer = nv.interactiveGuideline()
	          , legend = nv.models.legend2()
	          , controls = nv.models.legend()
	          , tooltip = nv.models.tooltip()
	          ;

	      var margin = {top: 30, right: 20, bottom: 50, left: 60}
	          , marginTop = null
	          , width = null
	          , height = null
	          , color = nv.utils.defaultColor()
	          , showControls = true
	          , controlLabels = {}
	          , showLegend = true
	          , legendPosition = null
	          , showXAxis = true
	          , showYAxis = true
	          , rightAlignYAxis = false
	          , reduceXTicks = true // if false a tick will show for every data point
	          , staggerLabels = false
	          , wrapLabels = false
	          , rotateLabels = 0
	          , x //can be accessed via chart.xScale()
	          , y //can be accessed via chart.yScale()
	          , state = nv.utils.state()
	          , defaultState = null
	          , noData = null
	          , dispatch = d3.dispatch('tooltipShow', 'tooltipHide', 'stateChange', 'changeState', 'renderEnd')
	          , controlWidth = function() { return showControls ? 180 : 0 }
	          , duration = 250
	          , useInteractiveGuideline = false
	          , valueFormat = d3.format(',.0f')
	          ;

	      state.stacked = false // DEPRECATED Maintained for backward compatibility

	      multibar.stacked(false);
	      xAxis
	          .orient('bottom')
	          .tickPadding(16)
	          .showMaxMin(false)
	          .tickFormat(function(d) { return d })
	      ;
	      yAxis
	          .orient((rightAlignYAxis) ? 'right' : 'left')
	          .tickFormat(valueFormat)
	      ;

	      tooltip
	          .duration(0)
	          // .valueFormatter(function(d, i) {
	          //     return yAxis.tickFormat()(d, i);
	          // })
	          .headerFormatter(function(d, i) {
	              return xAxis.tickFormat()(d, i);
	          });

	      interactiveLayer.tooltip
	          .valueFormatter(function(d, i) {
	              return d == null ? "N/A" : yAxis.tickFormat()(d, i);
	          })
	          .headerFormatter(function(d, i) {
	              return xAxis.tickFormat()(d, i);
	          });

	      interactiveLayer.tooltip
	          .valueFormatter(function(d, i) {
	              return d == null ? "N/A" : yAxis.tickFormat()(d, i);
	          })
	          .headerFormatter(function (d, i) {
	              return xAxis.tickFormat()(d, i);
	          });

	      interactiveLayer.tooltip
	          .duration(0)
	          .valueFormatter(function(d, i) {
	              return yAxis.tickFormat()(d, i);
	          })
	          .headerFormatter(function(d, i) {
	              return xAxis.tickFormat()(d, i);
	          });

	      controls.updateState(false);

	      //============================================================
	      // Private Variables
	      //------------------------------------------------------------

	      var renderWatch = nv.utils.renderWatch(dispatch);
	      var stacked = false;

	      var stateGetter = function(data) {
	          return function(){
	              return {
	                  active: data.map(function(d) { return !d.disabled }),
	                  stacked: stacked
	              };
	          }
	      };

	      var stateSetter = function(data) {
	          return function(state) {
	              if (state.stacked !== undefined)
	                  stacked = state.stacked;
	              if (state.active !== undefined)
	                  data.forEach(function(series,i) {
	                      series.disabled = !state.active[i];
	                  });
	          }
	      };

	      function chart(selection) {
	          renderWatch.reset();
	          renderWatch.models(multibar);
	          if (showXAxis) renderWatch.models(xAxis);
	          if (showYAxis) renderWatch.models(yAxis);

	          selection.each(function(data) {
	              var container = d3.select(this),
	                  that = this;
	              nv.utils.initSVG(container);
	              var availableWidth = nv.utils.availableWidth(width, container, margin),
	                  availableHeight = nv.utils.availableHeight(height, container, margin);

	              chart.update = function() {
	                  if (duration === 0)
	                      container.call(chart);
	                  else
	                      container.transition()
	                          .duration(duration)
	                          .call(chart);
	              };
	              chart.container = this;

	              state
	                  .setter(stateSetter(data), chart.update)
	                  .getter(stateGetter(data))
	                  .update();

	              // DEPRECATED set state.disableddisabled
	              state.disabled = data.map(function(d) { return !!d.disabled });

	              if (!defaultState) {
	                  var key;
	                  defaultState = {};
	                  for (key in state) {
	                      if (state[key] instanceof Array)
	                          defaultState[key] = state[key].slice(0);
	                      else
	                          defaultState[key] = state[key];
	                  }
	              }

	              // Display noData message if there's nothing to show.
	              if (!data || !data.length || !data.filter(function(d) { return d.values.length }).length) {
	                  nv.utils.noData(chart, container)
	                  return chart;
	              } else {
	                  container.selectAll('.nv-noData').remove();
	              }

	              // Setup Scales
	              x = multibar.xScale();
	              y = multibar.yScale();

	              // Setup containers and skeleton of chart
	              var wrap = container.selectAll('g.nv-wrap.nv-multiBarWithLegend').data([data]);
	              var gEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-multiBarWithLegend').append('g');
	              var g = wrap.select('g');

	              gEnter.append('g').attr('class', 'nv-x nv-axis');
	              gEnter.append('g').attr('class', 'nv-y nv-axis');
	              gEnter.append('g').attr('class', 'nv-barsWrap');
	              gEnter.append('g').attr('class', 'nv-legendWrap');
	              gEnter.append('g').attr('class', 'nv-controlsWrap');
	              gEnter.append('g').attr('class', 'nv-interactive');

	              // Legend
	              if (!showLegend) {
	                  g.select('.nv-legendWrap').selectAll('*').remove();
	              } else {
	                  if (legendPosition === 'bottom') {
	                      legend.width(availableWidth - margin.left - margin.right);
                        legend.rightAlign( false );

	                       g.select('.nv-legendWrap')
	                           .datum(data)
	                           .call(legend);

	                       margin.bottom = xAxis.height() + legend.height();
	                       availableHeight = nv.utils.availableHeight(height, container, margin);
	                       g.select('.nv-legendWrap')
	                           .attr('transform', 'translate(0,' + (availableHeight + xAxis.height())  +')');
	                  } else {
	                      legend.width(availableWidth - controlWidth());

	                      g.select('.nv-legendWrap')
	                          .datum(data)
	                          .call(legend);

	                      if (!marginTop && legend.height() !== margin.top) {
	                          margin.top = legend.height();
	                          availableHeight = nv.utils.availableHeight(height, container, margin);
	                      }

	                      g.select('.nv-legendWrap')
	                          .attr('transform', 'translate(' + controlWidth() + ',' + (-margin.top) +')');
	                  }
	              }

	              // Controls
	              if (!showControls) {
	                   g.select('.nv-controlsWrap').selectAll('*').remove();
	              } else {
	                  var controlsData = [
	                      { key: controlLabels.grouped || 'Grouped', disabled: multibar.stacked() },
	                      { key: controlLabels.stacked || 'Stacked', disabled: !multibar.stacked() }
	                  ];

	                  controls.width(controlWidth()).color(['#444', '#444', '#444']);
	                  g.select('.nv-controlsWrap')
	                      .datum(controlsData)
	                      .attr('transform', 'translate(0,' + (-margin.top) +')')
	                      .call(controls);
	              }

	              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
	              if (rightAlignYAxis) {
	                  g.select(".nv-y.nv-axis")
	                      .attr("transform", "translate(" + availableWidth + ",0)");
	              }

	              // Main Chart Component(s)
	              multibar
	                  .disabled(data.map(function(series) { return series.disabled }))
	                  .width(availableWidth)
	                  .height(availableHeight)
	                  .color(data.map(function(d,i) {
	                      return d.color || color(d, i);
	                  }).filter(function(d,i) { return !data[i].disabled }));


	              var barsWrap = g.select('.nv-barsWrap')
	                  .datum(data.filter(function(d) { return !d.disabled }));

	              barsWrap.call(multibar);

	              // Setup Axes
	              if (showXAxis) {
	                  xAxis
	                      .scale(x)
	                      ._ticks( nv.utils.calcTicksX(availableWidth/100, data) )
	                      .tickSize(-availableHeight, 0);

	                  g.select('.nv-x.nv-axis')
	                      .attr('transform', 'translate(0,' + y.range()[0] + ')');
	                  g.select('.nv-x.nv-axis')
	                      .call(xAxis);

	                  var xTicks = g.select('.nv-x.nv-axis > g').selectAll('g');

	                  xTicks
	                      .selectAll('line, text')
	                      .style('opacity', 1)

	                  if (staggerLabels) {
	                      var getTranslate = function(x,y) {
	                          return "translate(" + x + "," + y + ")";
	                      };

	                      var staggerUp = 5, staggerDown = 17;  //pixels to stagger by
	                      // Issue #140
	                      xTicks
	                          .selectAll("text")
	                          .attr('transform', function(d,i,j) {
	                              return  getTranslate(0, (j % 2 == 0 ? staggerUp : staggerDown));
	                          });

	                      var totalInBetweenTicks = d3.selectAll(".nv-x.nv-axis .nv-wrap g g text")[0].length;
	                      g.selectAll(".nv-x.nv-axis .nv-axisMaxMin text")
	                          .attr("transform", function(d,i) {
	                              return getTranslate(0, (i === 0 || totalInBetweenTicks % 2 !== 0) ? staggerDown : staggerUp);
	                          });
	                  }

	                  if (wrapLabels) {
	                      g.selectAll('.tick text')
	                          .call(nv.utils.wrapTicks, chart.xAxis.rangeBand())
	                  }

	                  if (reduceXTicks)
	                      xTicks
	                          .filter(function(d,i) {
	                              return i % Math.ceil(data[0].values.length / (availableWidth / 100)) !== 0;
	                          })
	                          .selectAll('text, line')
	                          .style('opacity', 0);

	                  if(rotateLabels)
	                      xTicks
	                          .selectAll('.tick text')
	                          .attr('transform', 'rotate(' + rotateLabels + ' 0,0)')
	                          .style('text-anchor', rotateLabels > 0 ? 'start' : 'end');

	                  g.select('.nv-x.nv-axis').selectAll('g.nv-axisMaxMin text')
	                      .style('opacity', 1);
	              }

	              if (showYAxis) {
	                  yAxis
	                      .scale(y)
	                      ._ticks( nv.utils.calcTicksY(availableHeight/36, data) )
	                      .tickSize( -availableWidth, 0);

	                  g.select('.nv-y.nv-axis')
	                      .call(yAxis);
	              }

	              //Set up interactive layer
	              if (useInteractiveGuideline) {
	                  interactiveLayer
	                      .width(availableWidth)
	                      .height(availableHeight)
	                      .margin({left:margin.left, top:margin.top})
	                      .svgContainer(container)
	                      .xScale(x);
	                  wrap.select(".nv-interactive").call(interactiveLayer);
	              }

	              //============================================================
	              // Event Handling/Dispatching (in chart's scope)
	              //------------------------------------------------------------

	              legend.dispatch.on('stateChange', function(newState) {
	                  for (var key in newState)
	                      state[key] = newState[key];
	                  dispatch.stateChange(state);
	                  chart.update();
	              });

	              controls.dispatch.on('legendClick', function(d,i) {
	                  if (!d.disabled) return;
	                  controlsData = controlsData.map(function(s) {
	                      s.disabled = true;
	                      return s;
	                  });
	                  d.disabled = false;

	                  switch (d.key) {
	                      case 'Grouped':
	                      case controlLabels.grouped:
	                          multibar.stacked(false);
	                          break;
	                      case 'Stacked':
	                      case controlLabels.stacked:
	                          multibar.stacked(true);
	                          break;
	                  }

	                  state.stacked = multibar.stacked();
	                  dispatch.stateChange(state);
	                  chart.update();
	              });

	              // Update chart from a state object passed to event handler
	              dispatch.on('changeState', function(e) {
	                  if (typeof e.disabled !== 'undefined') {
	                      data.forEach(function(series,i) {
	                          series.disabled = e.disabled[i];
	                      });
	                      state.disabled = e.disabled;
	                  }
	                  if (typeof e.stacked !== 'undefined') {
	                      multibar.stacked(e.stacked);
	                      state.stacked = e.stacked;
	                      stacked = e.stacked;
	                  }
	                  chart.update();
	              });

	              if (useInteractiveGuideline) {
	                  interactiveLayer.dispatch.on('elementMousemove', function(e) {
	                      if (e.pointXValue == undefined) return;

	                      var singlePoint, pointIndex, pointXLocation, xValue, allData = [];
	                      data
	                          .filter(function(series, i) {
	                              series.seriesIndex = i;
	                              return !series.disabled;
	                          })
	                          .forEach(function(series,i) {
	                              pointIndex = x.domain().indexOf(e.pointXValue)

	                              var point = series.values[pointIndex];
	                              if (point === undefined) return;

	                              xValue = point.x;
	                              if (singlePoint === undefined) singlePoint = point;
	                              if (pointXLocation === undefined) pointXLocation = e.mouseX
	                              allData.push({
	                                  key: series.key,
	                                  value: chart.y()(point, pointIndex),
	                                  color: color(series,series.seriesIndex),
	                                  data: series.values[pointIndex]
	                              });
	                          });

	                      interactiveLayer.tooltip
	                          .data({
	                              value: xValue,
	                              index: pointIndex,
	                              series: allData
	                          })();

	                      interactiveLayer.renderGuideLine(pointXLocation);
	                  });

	                  interactiveLayer.dispatch.on("elementMouseout",function(e) {
	                      interactiveLayer.tooltip.hidden(true);
	                  });
	              }
	              else {
	                  multibar.dispatch.on('elementMouseover.tooltip', function(evt) {
	                      evt.value = chart.x()(evt.data);
	                      evt['series'] = {
	                          key: evt.data.key,
	                          value: valueFormat( chart.y()(evt.data) ) + ( evt.data.p != undefined ? ' (' + d3.format(',.1f')( evt.data.p ) + '%)' : '' ),
	                          color: evt.color
	                      };
	                      tooltip.data(evt).hidden(false);
	                  });

                    if( detector.device == 'pc' ) {
                      multibar.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true);
                      });
                    }

	                  multibar.dispatch.on('elementMousemove.tooltip', function(evt) {
	                      tooltip();
	                  });
	              }
	          });

	          renderWatch.renderEnd('multibarchart immediate');
	          return chart;
	      }

	      //============================================================
	      // Expose Public Variables
	      //------------------------------------------------------------

	      // expose chart's sub-components
	      chart.dispatch = dispatch;
	      chart.multibar = multibar;
	      chart.legend = legend;
	      chart.controls = controls;
	      chart.xAxis = xAxis;
	      chart.yAxis = yAxis;
	      chart.state = state;
	      chart.tooltip = tooltip;
	      chart.interactiveLayer = interactiveLayer;

	      chart.options = nv.utils.optionsFunc.bind(chart);

	      chart._options = Object.create({}, {
	          // simple options, just get/set the necessary values
	          width:      {get: function(){return width;}, set: function(_){width=_;}},
	          height:     {get: function(){return height;}, set: function(_){height=_;}},
	          showLegend: {get: function(){return showLegend;}, set: function(_){showLegend=_;}},
	          legendPosition: {get: function(){return legendPosition;}, set: function(_){legendPosition=_;}},
	          showControls: {get: function(){return showControls;}, set: function(_){showControls=_;}},
	          controlLabels: {get: function(){return controlLabels;}, set: function(_){controlLabels=_;}},
	          showXAxis:      {get: function(){return showXAxis;}, set: function(_){showXAxis=_;}},
	          showYAxis:    {get: function(){return showYAxis;}, set: function(_){showYAxis=_;}},
	          defaultState:    {get: function(){return defaultState;}, set: function(_){defaultState=_;}},
	          noData:    {get: function(){return noData;}, set: function(_){noData=_;}},
	          reduceXTicks:    {get: function(){return reduceXTicks;}, set: function(_){reduceXTicks=_;}},
	          rotateLabels:    {get: function(){return rotateLabels;}, set: function(_){rotateLabels=_;}},
	          staggerLabels:    {get: function(){return staggerLabels;}, set: function(_){staggerLabels=_;}},
	          wrapLabels:   {get: function(){return wrapLabels;}, set: function(_){wrapLabels=!!_;}},

	          // options that require extra logic in the setter
	          margin: {get: function(){return margin;}, set: function(_){
	              if (_.top !== undefined) {
	                  margin.top = _.top;
	                  marginTop = _.top;
	              }
	              margin.right  = _.right  !== undefined ? _.right  : margin.right;
	              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
	              margin.left   = _.left   !== undefined ? _.left   : margin.left;
	          }},
	          duration: {get: function(){return duration;}, set: function(_){
	              duration = _;
	              multibar.duration(duration);
	              xAxis.duration(duration);
	              yAxis.duration(duration);
	              renderWatch.reset(duration);
	          }},
	          color:  {get: function(){return color;}, set: function(_){
	              color = nv.utils.getColor(_);
	              legend.color(color);
	          }},
	          rightAlignYAxis: {get: function(){return rightAlignYAxis;}, set: function(_){
	              rightAlignYAxis = _;
	              yAxis.orient( rightAlignYAxis ? 'right' : 'left');
	          }},
	          useInteractiveGuideline: {get: function(){return useInteractiveGuideline;}, set: function(_){
	              useInteractiveGuideline = _;
	          }},
	          barColor:  {get: function(){return multibar.barColor;}, set: function(_){
	              multibar.barColor(_);
	              legend.color(_);
	          }},
	          valueColor:  {get: function(){return multibar.valueColor;}, set: function(_){
	              multibar.valueColor(_);
	          }}
	      });

	      nv.utils.inheritOptions(chart, multibar);
	      nv.utils.initOptions(chart);

	      return chart;
	  };

  nv.models.multiChart2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var margin = {top: 30, right: 20, bottom: 50, left: 60},
          marginTop = null,
          color = nv.utils.defaultColor(),
          width = null,
          height = null,
          showLegend = true,
          noData = null,
          yDomain1,
          yDomain2,
          getX = function(d) { return d.x },
          getY = function(d) { return d.y},
          interpolate = 'linear',
          useVoronoi = true,
          interactiveLayer = nv.interactiveGuideline(),
          useInteractiveGuideline = false,
          legendRightAxisHint = ' (right axis)',
          duration = 250,
          showYAxis = true
          ;

      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x = d3.scale.ordinal(),
          yScale1 = d3.scale.linear(),
          yScale2 = d3.scale.linear(),

          lines1 = nv.models.line3().yScale(yScale1).duration(duration),
          lines2 = nv.models.line().yScale(yScale2).duration(duration),

          scatters1 = nv.models.scatter().yScale(yScale1).duration(duration),
          scatters2 = nv.models.scatter().yScale(yScale2).duration(duration),

          bars1 = nv.models.multiBar2().stacked(false).yScale(yScale1).duration(duration).clipEdge(false),
          bars2 = nv.models.multiBar().stacked(false).yScale(yScale2).duration(duration),

          stack1 = nv.models.stackedArea().yScale(yScale1).duration(duration),
          stack2 = nv.models.stackedArea().yScale(yScale2).duration(duration),

          xAxis = nv.models.axis().scale(x).orient('bottom').tickPadding(5).duration(duration),
          yAxis1 = nv.models.axis().scale(yScale1).orient('left').duration(duration),
          yAxis2 = nv.models.axis().scale(yScale2).orient('right').duration(duration),

          legend = nv.models.legend3(),
          tooltip = nv.models.tooltip(),
          dispatch = d3.dispatch();

      var charts = [lines1, lines2, scatters1, scatters2, bars1, bars2, stack1, stack2];

      function chart(selection) {
          selection.each(function(data) {
              var container = d3.select(this),
                  that = this;
              nv.utils.initSVG(container);

              chart.update = function() { container.transition().call(chart); };
              chart.container = this;

              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);

              var dataLines1 = data.filter(function(d) {return d.type == 'line' && d.yAxis == 1});
              var dataLines2 = data.filter(function(d) {return d.type == 'line' && d.yAxis == 2});
              var dataScatters1 = data.filter(function(d) {return d.type == 'scatter' && d.yAxis == 1});
              var dataScatters2 = data.filter(function(d) {return d.type == 'scatter' && d.yAxis == 2});
              var dataBars1 =  data.filter(function(d) {return d.type == 'bar'  && d.yAxis == 1});
              var dataBars2 =  data.filter(function(d) {return d.type == 'bar'  && d.yAxis == 2});
              var dataStack1 = data.filter(function(d) {return d.type == 'area' && d.yAxis == 1});
              var dataStack2 = data.filter(function(d) {return d.type == 'area' && d.yAxis == 2});

              // Display noData message if there's nothing to show.
              if (!data || !data.length || !data.filter(function(d) { return d.values.length }).length) {
                  nv.utils.noData(chart, container);
                  return chart;
              } else {
                  container.selectAll('.nv-noData').remove();
              }

              var series1 = data.filter(function(d) {return !d.disabled && d.yAxis == 1})
                  .map(function(d) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d), y: getY(d) }
                      })
                  });

              var series2 = data.filter(function(d) {return !d.disabled && d.yAxis == 2})
                  .map(function(d) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d), y: getY(d) }
                      })
                  });

              // var padDataOuter = 0.1;
              // x   .domain(d3.extent(d3.merge(series1.concat(series2)), function(d) { return d.x }))
              //     .range([(availableWidth * padDataOuter +  availableWidth) / (2 *data[0].values.length), availableWidth - availableWidth * (1 + padDataOuter) / (2 * data[0].values.length)  ])
                  // .range([0, availableWidth]);
                  ;
              x   .domain(d3.merge(series1.concat(series2)).map(function(d) { return d.x }))
                  .rangeBands([0, availableWidth]);
                  // .rangeBands([(availableWidth * padDataOuter +  availableWidth) / (2 *data[0].values.length), availableWidth - availableWidth * (1 + padDataOuter) / (2 * data[0].values.length)  ])
                  // .rangeBands([0, availableWidth], groupSpacing);

              // container.selectAll('g.wrap.multiChart').remove();
              var wrap = container.selectAll('g.wrap.multiChart').data([data]);
              var gEnter = wrap.enter().append('g').attr('class', 'wrap nvd3 multiChart').append('g');
              // var gEnter = wrap.enter().append('g').attr('class', 'wrap nvd3 multiChart').append('g');

              gEnter.append('g').attr('class', 'nv-x nv-axis');
              gEnter.append('g').attr('class', 'nv-y1 nv-axis');
              gEnter.append('g').attr('class', 'nv-y2 nv-axis');
              gEnter.append('g').attr('class', 'stack1Wrap');
              gEnter.append('g').attr('class', 'stack2Wrap');
              gEnter.append('g').attr('class', 'bars1Wrap');
              gEnter.append('g').attr('class', 'bars2Wrap');
              gEnter.append('g').attr('class', 'scatters1Wrap');
              gEnter.append('g').attr('class', 'scatters2Wrap');
              gEnter.append('g').attr('class', 'lines1Wrap');
              gEnter.append('g').attr('class', 'lines2Wrap');
              gEnter.append('g').attr('class', 'legendWrap');
              gEnter.append('g').attr('class', 'nv-interactive');

              var g = wrap.select('g');

              var color_array = data.map(function(d,i) {
                  return data[i].color || color(d, i);
              });

              // Legend
              if (!showLegend) {
                  g.select('.legendWrap').selectAll('*').remove();
              } else {
                  var legendWidth = legend.align() ? availableWidth / 2 : availableWidth;
                  var legendXPosition = legend.align() ? legendWidth : 0;

                  legend.width(legendWidth);
                  legend.color(color_array);

                  g.select('.legendWrap')
                      .datum(data.map(function(series) {
                          series.originalKey = series.originalKey === undefined ? series.key : series.originalKey;
                          series.key = series.originalKey + (series.yAxis == 1 ? '' : legendRightAxisHint);
                          return series;
                      }))
                      .call(legend);

                  if (!marginTop && legend.height() !== margin.top) {
                      margin.top = legend.height();
                      availableHeight = nv.utils.availableHeight(height, container, margin);
                  }

                  g.select('.legendWrap')
                      .attr('transform', 'translate(' + ( -legendXPosition - margin.left - 20 ) + ',' + (availableHeight - legend.height()) / 2 +')');
              }

              lines1
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'line'}))
                  .valueFormat( function( d ) { return d3.format(',.0f')( d ); } );
                  // .padData(true)
                  // .padDataOuter(padDataOuter)
                  // .margin({top: margin.top, right: margin.right + bars1.firstX(), bottom: margin.bottom, left: margin.left + bars1.firstX()});
              lines2
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'line'}))
              scatters1
                  .width(availableWidth)
                  .height(availableHeight)
                  .forceY([0])
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'scatter'}));
              scatters2
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'scatter'}));
              bars1
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'bar'}));
              bars2
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'bar'}));
              stack1
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'area'}));
              stack2
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'area'}));

              g.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              g.select('.lines1Wrap').selectAll('*').remove();
              g.select('.scatters1Wrap').selectAll('*').remove();
              g.select('.bars1Wrap').selectAll('*').remove();
              g.select('.stack1Wrap').selectAll('*').remove();
              g.select('.lines2Wrap').selectAll('*').remove();
              g.select('.scatters2Wrap').selectAll('*').remove();
              g.select('.bars2Wrap').selectAll('*').remove();
              g.select('.stack2Wrap').selectAll('*').remove();

              var lines1Wrap = g.select('.lines1Wrap')
                  .datum(dataLines1.filter(function(d){return !d.disabled}));
              var scatters1Wrap = g.select('.scatters1Wrap')
                  .datum(dataScatters1.filter(function(d){return !d.disabled}));
              var bars1Wrap = g.select('.bars1Wrap')
                  .datum(dataBars1.filter(function(d){return !d.disabled}));
              var stack1Wrap = g.select('.stack1Wrap')
                  .datum(dataStack1.filter(function(d){return !d.disabled}));
              var lines2Wrap = g.select('.lines2Wrap')
                  .datum(dataLines2.filter(function(d){return !d.disabled}));
              var scatters2Wrap = g.select('.scatters2Wrap')
                  .datum(dataScatters2.filter(function(d){return !d.disabled}));
              var bars2Wrap = g.select('.bars2Wrap')
                  .datum(dataBars2.filter(function(d){return !d.disabled}));
              var stack2Wrap = g.select('.stack2Wrap')
                  .datum(dataStack2.filter(function(d){return !d.disabled}));

              var extraValue1 = dataStack1.length ? dataStack1.map(function(a){return a.values}).reduce(function(a,b){
                  return a.map(function(aVal,i){return {x: aVal.x, y: aVal.y + b[i].y}})
              }).concat([{x:0, y:0}]) : [];
              var extraValue2 = dataStack2.length ? dataStack2.map(function(a){return a.values}).reduce(function(a,b){
                  return a.map(function(aVal,i){return {x: aVal.x, y: aVal.y + b[i].y}})
              }).concat([{x:0, y:0}]) : [];

              yScale1 .domain(yDomain1 || d3.extent(d3.merge(series1).concat(extraValue1), function(d) { return d.y } ))
                  .range([0, availableHeight]);

              yScale2 .domain(yDomain2 || d3.extent(d3.merge(series2).concat(extraValue2), function(d) { return d.y } ))
                  .range([0, availableHeight]);

              lines1.yDomain(yScale1.domain());
              scatters1.yDomain(yScale1.domain());
              bars1.yDomain(yScale1.domain());
              stack1.yDomain(yScale1.domain());

              lines2.yDomain(yScale2.domain());
              scatters2.yDomain(yScale2.domain());
              bars2.yDomain(yScale2.domain());
              stack2.yDomain(yScale2.domain());

              if(dataStack1.length){d3.transition(stack1Wrap).call(stack1);}
              if(dataStack2.length){d3.transition(stack2Wrap).call(stack2);}

              if(dataBars1.length){d3.transition(bars1Wrap).call(bars1);}
              if(dataBars2.length){d3.transition(bars2Wrap).call(bars2);}

              if(dataLines1.length){d3.transition(lines1Wrap).call(lines1);}
              if(dataLines2.length){d3.transition(lines2Wrap).call(lines2);}

              if(dataScatters1.length){d3.transition(scatters1Wrap).call(scatters1);}
              if(dataScatters2.length){d3.transition(scatters2Wrap).call(scatters2);}

              xAxis
                  ._ticks( nv.utils.calcTicksX(availableWidth/100, data) )
                  .tickSize(-availableHeight, 0);

              g.select('.nv-x.nv-axis')
                  .attr('transform', 'translate(0,' + availableHeight + ')');
              d3.transition(g.select('.nv-x.nv-axis'))
                  .call(xAxis);

              if (showYAxis) {
                yAxis1
                    ._ticks( nv.utils.calcTicksY(availableHeight/36, data) )
                    .tickSize( -availableWidth, 0);


                    d3.transition(g.select('.nv-y1.nv-axis'))
                    .call(yAxis1);
              }


              if (showYAxis) {
                yAxis2
                    ._ticks( nv.utils.calcTicksY(availableHeight/36, data) )
                    .tickSize( -availableWidth, 0);

                    d3.transition(g.select('.nv-y2.nv-axis'))
                    .call(yAxis2);
              }

              g.select('.nv-y1.nv-axis')
                  .classed('nv-disabled', series1.length ? false : true)
                  .attr('transform', 'translate(' + x.range()[0] + ',0)');

              g.select('.nv-y2.nv-axis')
                  .classed('nv-disabled', series2.length ? false : true)
                  .attr('transform', 'translate(' + x.range()[1] + ',0)');

              legend.dispatch.on('stateChange', function(newState) {
                  chart.update();
              });

              if(useInteractiveGuideline){
                  interactiveLayer
                      .width(availableWidth)
                      .height(availableHeight)
                      .margin({left:margin.left, top:margin.top})
                      .svgContainer(container)
                      .xScale(x);
                  wrap.select(".nv-interactive").call(interactiveLayer);
              }

              //============================================================
              // Event Handling/Dispatching
              //------------------------------------------------------------

              function mouseover_line(evt) {
                  var yaxis = data[evt.seriesIndex].yAxis === 2 ? yAxis2 : yAxis1;
                  evt.value = evt.point.x;
                  evt.series = {
                      value: evt.point.y,
                      color: evt.point.color,
                      key: evt.series.key
                  };
                  tooltip
                      .duration(0)
                      .headerFormatter(function(d, i) {
                      	return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i) + ( evt.point.p != undefined ? ' (' + d3.format(',.1f')( evt.point.p ) + '%)' : '' );
                      })
                      .data(evt)
                      .hidden(false);
              }

              function mouseover_scatter(evt) {
                  var yaxis = data[evt.seriesIndex].yAxis === 2 ? yAxis2 : yAxis1;
                  evt.value = evt.point.x;
                  evt.series = {
                      value: evt.point.y,
                      color: evt.point.color,
                      key: evt.series.key
                  };
                  tooltip
                      .duration(100)
                      .headerFormatter(function(d, i) {
                      	return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i);
                      })
                      .data(evt)
                      .hidden(false);
              }

              function mouseover_stack(evt) {
                  var yaxis = data[evt.seriesIndex].yAxis === 2 ? yAxis2 : yAxis1;
                  evt.point['x'] = stack1.x()(evt.point);
                  evt.point['y'] = stack1.y()(evt.point);
                  tooltip
                      .duration(0)
                      .headerFormatter(function(d, i) {
                      	return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i);
                      })
                      .data(evt)
                      .hidden(false);
              }

              function mouseover_bar(evt) {
                  var yaxis = data[evt.data.series].yAxis === 2 ? yAxis2 : yAxis1;

                  evt.value = bars1.x()(evt.data);
                  evt['series'] = {
                      value: bars1.y()(evt.data),
                      color: evt.color,
                      key: evt.data.key
                  };
                  tooltip
                      .duration(0)
                      .headerFormatter(function(d, i) {
                      	return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i);
                      })
                      .data(evt)
                      .hidden(false);
              }



              function clearHighlights() {
                for(var i=0, il=charts.length; i < il; i++){
                  var chart = charts[i];
                  try {
                    chart.clearHighlights();
                  } catch(e){}
                }
              }

              function highlightPoint(serieIndex, pointIndex, b){
                for(var i=0, il=charts.length; i < il; i++){
                  var chart = charts[i];
                  try {
                    chart.highlightPoint(serieIndex, pointIndex, b);
                  } catch(e){}
                }
              }

              if(useInteractiveGuideline){
                  interactiveLayer.dispatch.on('elementMousemove', function(e) {
                      clearHighlights();
                      var singlePoint, pointIndex, pointXLocation, allData = [];
                      data
                      .filter(function(series, i) {
                          series.seriesIndex = i;
                          return !series.disabled;
                      })
                      .forEach(function(series,i) {
                          var extent = x.domain();
                          var currentValues = series.values.filter(function(d,i) {
                              return chart.x()(d,i) >= extent[0] && chart.x()(d,i) <= extent[1];
                          });

                          pointIndex = nv.interactiveBisect(currentValues, e.pointXValue, chart.x());
                          var point = currentValues[pointIndex];
                          var pointYValue = chart.y()(point, pointIndex);
                          if (pointYValue !== null) {
                              highlightPoint(i, pointIndex, true);
                          }
                          if (point === undefined) return;
                          if (singlePoint === undefined) singlePoint = point;
                          if (pointXLocation === undefined) pointXLocation = x(chart.x()(point,pointIndex));
                          allData.push({
                              key: series.key,
                              value: pointYValue,
                              color: color(series,series.seriesIndex),
                              data: point,
                              yAxis: series.yAxis == 2 ? yAxis2 : yAxis1
                          });
                      });

                      var defaultValueFormatter = function(d,i) {
                          var yAxis = allData[i].yAxis;
                          return d == null ? "N/A" : yAxis.tickFormat()(d);
                      };

                      interactiveLayer.tooltip
                          .headerFormatter(function(d, i) {
                              return xAxis.tickFormat()(d, i);
                          })
                          .valueFormatter(interactiveLayer.tooltip.valueFormatter() || defaultValueFormatter)
                          .data({
                              value: chart.x()( singlePoint,pointIndex ),
                              index: pointIndex,
                              series: allData
                          })();

                      interactiveLayer.renderGuideLine(pointXLocation);
                  });

                  interactiveLayer.dispatch.on("elementMouseout",function(e) {
                      clearHighlights();
                  });
              } else {
                  lines1.dispatch.on('elementMouseover.tooltip', mouseover_line);
                  lines2.dispatch.on('elementMouseover.tooltip', mouseover_line);
                  // if( detector.device == 'pc' ) {
                    lines1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                    lines2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                  // }

                  scatters1.dispatch.on('elementMouseover.tooltip', mouseover_scatter);
                  scatters2.dispatch.on('elementMouseover.tooltip', mouseover_scatter);
                  if( detector.device == 'pc' ) {
                    scatters1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                    scatters2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                  }

                  stack1.dispatch.on('elementMouseover.tooltip', mouseover_stack);
                  stack2.dispatch.on('elementMouseover.tooltip', mouseover_stack);
                  if( detector.device == 'pc' ) {
                    stack1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                    stack2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                  }

                  bars1.dispatch.on('elementMouseover.tooltip', mouseover_bar);
                  bars2.dispatch.on('elementMouseover.tooltip', mouseover_bar);

                  if( detector.device == 'pc' ) {
                    bars1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true);
                    });
                    bars2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true);
                    });
                  }
                  bars1.dispatch.on('elementMousemove.tooltip', function(evt) {
                      tooltip();
                  });
                  bars2.dispatch.on('elementMousemove.tooltip', function(evt) {
                      tooltip();
                  });
              }
          });

          return chart;
      }

      //============================================================
      // Global getters and setters
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.legend = legend;
      chart.lines1 = lines1;
      chart.lines2 = lines2;
      chart.scatters1 = scatters1;
      chart.scatters2 = scatters2;
      chart.bars1 = bars1;
      chart.bars2 = bars2;
      chart.stack1 = stack1;
      chart.stack2 = stack2;
      chart.xAxis = xAxis;
      chart.yAxis1 = yAxis1;
      chart.yAxis2 = yAxis2;
      chart.tooltip = tooltip;
      chart.interactiveLayer = interactiveLayer;

      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:      {get: function(){return width;}, set: function(_){width=_;}},
          height:     {get: function(){return height;}, set: function(_){height=_;}},
          showLegend: {get: function(){return showLegend;}, set: function(_){showLegend=_;}},
          yDomain1:      {get: function(){return yDomain1;}, set: function(_){yDomain1=_;}},
          yDomain2:    {get: function(){return yDomain2;}, set: function(_){yDomain2=_;}},
          noData:    {get: function(){return noData;}, set: function(_){noData=_;}},
          interpolate:    {get: function(){return interpolate;}, set: function(_){interpolate=_;}},
          legendRightAxisHint:    {get: function(){return legendRightAxisHint;}, set: function(_){legendRightAxisHint=_;}},
          fillOpacity: {get: function(){return bars1.fillOpacity();}, set: function(_){bars1.fillOpacity(_);}},
          pointsShowP: {get: function(){return lines1.pointsShowP();}, set: function(_){ lines1.pointsShowP(_);}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              if (_.top !== undefined) {
                  margin.top = _.top;
                  marginTop = _.top;
              }
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }},
          x: {get: function(){return getX;}, set: function(_){
              getX = _;
              lines1.x(_);
              lines2.x(_);
              scatters1.x(_);
              scatters2.x(_);
              bars1.x(_);
              bars2.x(_);
              stack1.x(_);
              stack2.x(_);
          }},
          y: {get: function(){return getY;}, set: function(_){
              getY = _;
              lines1.y(_);
              lines2.y(_);
              scatters1.y(_);
              scatters2.y(_);
              stack1.y(_);
              stack2.y(_);
              bars1.y(_);
              bars2.y(_);
          }},
          useVoronoi: {get: function(){return useVoronoi;}, set: function(_){
              useVoronoi=_;
              lines1.useVoronoi(_);
              lines2.useVoronoi(_);
              stack1.useVoronoi(_);
              stack2.useVoronoi(_);
          }},

          useInteractiveGuideline: {get: function(){return useInteractiveGuideline;}, set: function(_){
              useInteractiveGuideline = _;
              if (useInteractiveGuideline) {
                  lines1.interactive(false);
                  lines1.useVoronoi(false);
                  lines2.interactive(false);
                  lines2.useVoronoi(false);
                  stack1.interactive(false);
                  stack1.useVoronoi(false);
                  stack2.interactive(false);
                  stack2.useVoronoi(false);
                  scatters1.interactive(false);
                  scatters2.interactive(false);
              }
          }},

          duration: {get: function(){return duration;}, set: function(_) {
              duration = _;
              [lines1, lines2, stack1, stack2, scatters1, scatters2, xAxis, yAxis1, yAxis2].forEach(function(model){
                model.duration(duration);
              });
          }},
          showYAxis:    {get: function(){return showYAxis;}, set: function(_){showYAxis=_;}}
      });

      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.multiChart3 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var margin = {top: 30, right: 20, bottom: 50, left: 60},
          marginTop = null,
          color = nv.utils.defaultColor(),
          width = null,
          height = null,
          showLegend = true,
          noData = null,
          yDomain1,
          yDomain2,
          getX = function(d) { return d.x },
          getY = function(d) { return d.y},
          interpolate = 'linear',
          useVoronoi = true,
          interactiveLayer = nv.interactiveGuideline(),
          useInteractiveGuideline = false,
          legendRightAxisHint = ' (right axis)',
          duration = 0,
          showYAxis = true
          ;

      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x = d3.scale.ordinal(),
          yScale1 = d3.scale.linear(),
          yScale2 = d3.scale.linear(),

          lines1 = nv.models.line3().yScale(yScale1).duration(duration),
          lines2 = nv.models.line().yScale(yScale2).duration(duration),

          scatters1 = nv.models.scatter().yScale(yScale1).duration(duration),
          scatters2 = nv.models.scatter().yScale(yScale2).duration(duration),

          bars1 = nv.models.multiBar3().stacked(true).yScale(yScale1).duration(duration).clipEdge(false).groupSpacing( 0 ),
          bars2 = nv.models.multiBar().stacked(false).yScale(yScale2).duration(duration),

          stack1 = nv.models.stackedArea().yScale(yScale1).duration(duration),
          stack2 = nv.models.stackedArea().yScale(yScale2).duration(duration),

          xAxis = nv.models.axis().scale(x).orient('bottom').tickPadding(5).duration(duration),
          yAxis1 = nv.models.axis().scale(yScale1).orient('left').duration(duration),
          yAxis2 = nv.models.axis().scale(yScale2).orient('right').duration(duration),

          legend = nv.models.legend3(),
          tooltip = nv.models.tooltip(),
          dispatch = d3.dispatch();

      var charts = [lines1, lines2, scatters1, scatters2, bars1, bars2, stack1, stack2];

      function chart(selection) {
          selection.each(function(data) {
              var container = d3.select(this),
                  that = this;
              nv.utils.initSVG(container);

              chart.update = function() { container.transition().call(chart); };
              chart.container = this;

              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);

              var dataLines1 = data.filter(function(d) {return d.type == 'line' && d.yAxis == 1});
              var dataLines2 = data.filter(function(d) {return d.type == 'line' && d.yAxis == 2});
              var dataScatters1 = data.filter(function(d) {return d.type == 'scatter' && d.yAxis == 1});
              var dataScatters2 = data.filter(function(d) {return d.type == 'scatter' && d.yAxis == 2});
              var dataBars1 =  data.filter(function(d) {return d.type == 'bar'  && d.yAxis == 1});
              var dataBars2 =  data.filter(function(d) {return d.type == 'bar'  && d.yAxis == 2});
              var dataStack1 = data.filter(function(d) {return d.type == 'area' && d.yAxis == 1});
              var dataStack2 = data.filter(function(d) {return d.type == 'area' && d.yAxis == 2});

              // Display noData message if there's nothing to show.
              if (!data || !data.length || !data.filter(function(d) { return d.values.length }).length) {
                  nv.utils.noData(chart, container);
                  return chart;
              } else {
                  container.selectAll('.nv-noData').remove();
              }

              var series1 = data.filter(function(d) {return !d.disabled && d.yAxis == 1})
                  .map(function(d) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d), y: getY(d) }
                      })
                  });

              var series2 = data.filter(function(d) {return !d.disabled && d.yAxis == 2})
                  .map(function(d) {
                      return d.values.map(function(d,i) {
                          return { x: getX(d), y: getY(d) }
                      })
                  });

              // var padDataOuter = 0.1;
              // x   .domain(d3.extent(d3.merge(series1.concat(series2)), function(d) { return d.x }))
              //     .range([(availableWidth * padDataOuter +  availableWidth) / (2 *data[0].values.length), availableWidth - availableWidth * (1 + padDataOuter) / (2 * data[0].values.length)  ])
                  // .range([0, availableWidth]);
                  ;
              x   .domain(d3.merge(series1.concat(series2)).map(function(d) { return d.x }))
                  .rangeBands([0, availableWidth]);
                  // .rangeBands([(availableWidth * padDataOuter +  availableWidth) / (2 *data[0].values.length), availableWidth - availableWidth * (1 + padDataOuter) / (2 * data[0].values.length)  ])
                  // .rangeBands([0, availableWidth], groupSpacing);

              // container.selectAll('g.wrap.multiChart').remove();
              var wrap = container.selectAll('g.wrap.multiChart').data([data]);
              var gEnter = wrap.enter().append('g').attr('class', 'wrap nvd3 multiChart').append('g');
              // var gEnter = wrap.enter().append('g').attr('class', 'wrap nvd3 multiChart').append('g');

              gEnter.append('g').attr('class', 'nv-x nv-axis');
              gEnter.append('g').attr('class', 'nv-y1 nv-axis');
              gEnter.append('g').attr('class', 'nv-y2 nv-axis');
              gEnter.append('g').attr('class', 'stack1Wrap');
              gEnter.append('g').attr('class', 'stack2Wrap');
              gEnter.append('g').attr('class', 'bars1Wrap');
              gEnter.append('g').attr('class', 'bars2Wrap');
              gEnter.append('g').attr('class', 'scatters1Wrap');
              gEnter.append('g').attr('class', 'scatters2Wrap');
              gEnter.append('g').attr('class', 'lines1Wrap');
              gEnter.append('g').attr('class', 'lines2Wrap');
              gEnter.append('g').attr('class', 'legendWrap');
              gEnter.append('g').attr('class', 'nv-interactive');

              var g = wrap.select('g');

              var color_array = data.map(function(d,i) {
                  return data[i].color || color(d, i);
              });

              // Legend
              if (!showLegend) {
                  g.select('.legendWrap').selectAll('*').remove();
              } else {
                  var legendWidth = legend.align() ? availableWidth / 2 : availableWidth;
                  var legendXPosition = legend.align() ? legendWidth : 0;

                  legend.width(legendWidth);
                  legend.color(color_array);

                  g.select('.legendWrap')
                      .datum(data.map(function(series) {
                          series.originalKey = series.originalKey === undefined ? series.key : series.originalKey;
                          series.key = series.originalKey + (series.yAxis == 1 ? '' : legendRightAxisHint);
                          return series;
                      }))
                      .call(legend);

                  if (!marginTop && legend.height() !== margin.top) {
                      margin.top = legend.height();
                      availableHeight = nv.utils.availableHeight(height, container, margin);
                  }

                  g.select('.legendWrap')
                      .attr('transform', 'translate(' + legendXPosition + ',' + (availableHeight - legend.height()) / 2 +')');
                      // .attr('transform', 'translate(' + ( -legendXPosition - margin.left - 20 ) + ',' + (availableHeight - legend.height()) / 2 +')');
              }

              lines1
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'line'}))
                  .valueFormat( function( d ) { return d3.format(',.0f')( d ); } );
                  // .padData(true)
                  // .padDataOuter(padDataOuter)
                  // .margin({top: margin.top, right: margin.right + bars1.firstX(), bottom: margin.bottom, left: margin.left + bars1.firstX()});
              lines2
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'line'}))
              scatters1
                  .width(availableWidth)
                  .height(availableHeight)
                  .forceY([0])
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'scatter'}));
              scatters2
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'scatter'}));
              bars1
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'bar'}));
              bars2
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'bar'}));
              stack1
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 1 && data[i].type == 'area'}));
              stack2
                  .width(availableWidth)
                  .height(availableHeight)
                  .interpolate(interpolate)
                  .color(color_array.filter(function(d,i) { return !data[i].disabled && data[i].yAxis == 2 && data[i].type == 'area'}));

              g.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              g.select('.lines1Wrap').selectAll('*').remove();
              g.select('.scatters1Wrap').selectAll('*').remove();
              g.select('.bars1Wrap').selectAll('*').remove();
              g.select('.stack1Wrap').selectAll('*').remove();
              g.select('.lines2Wrap').selectAll('*').remove();
              g.select('.scatters2Wrap').selectAll('*').remove();
              g.select('.bars2Wrap').selectAll('*').remove();
              g.select('.stack2Wrap').selectAll('*').remove();

              var lines1Wrap = g.select('.lines1Wrap')
                  .datum(dataLines1.filter(function(d){return !d.disabled}));
              var scatters1Wrap = g.select('.scatters1Wrap')
                  .datum(dataScatters1.filter(function(d){return !d.disabled}));
              var bars1Wrap = g.select('.bars1Wrap')
                  .datum(dataBars1.filter(function(d){return !d.disabled}));
              var stack1Wrap = g.select('.stack1Wrap')
                  .datum(dataStack1.filter(function(d){return !d.disabled}));
              var lines2Wrap = g.select('.lines2Wrap')
                  .datum(dataLines2.filter(function(d){return !d.disabled}));
              var scatters2Wrap = g.select('.scatters2Wrap')
                  .datum(dataScatters2.filter(function(d){return !d.disabled}));
              var bars2Wrap = g.select('.bars2Wrap')
                  .datum(dataBars2.filter(function(d){return !d.disabled}));
              var stack2Wrap = g.select('.stack2Wrap')
                  .datum(dataStack2.filter(function(d){return !d.disabled}));

              var extraValue1 = dataStack1.length ? dataStack1.map(function(a){return a.values}).reduce(function(a,b){
                  return a.map(function(aVal,i){return {x: aVal.x, y: aVal.y + b[i].y}})
              }).concat([{x:0, y:0}]) : [];
              var extraValue2 = dataStack2.length ? dataStack2.map(function(a){return a.values}).reduce(function(a,b){
                  return a.map(function(aVal,i){return {x: aVal.x, y: aVal.y + b[i].y}})
              }).concat([{x:0, y:0}]) : [];

              yScale1 .domain(yDomain1 || d3.extent(d3.merge(series1).concat(extraValue1), function(d) { return d.y } ))
                  .range([0, availableHeight]);

              yScale2 .domain(yDomain2 || d3.extent(d3.merge(series2).concat(extraValue2), function(d) { return d.y } ))
                  .range([0, availableHeight]);

              lines1.yDomain(yScale1.domain());
              scatters1.yDomain(yScale1.domain());
              bars1.yDomain(yScale1.domain());
              stack1.yDomain(yScale1.domain());

              lines2.yDomain(yScale2.domain());
              scatters2.yDomain(yScale2.domain());
              bars2.yDomain(yScale2.domain());
              stack2.yDomain(yScale2.domain());

              if(dataStack1.length){d3.transition(stack1Wrap).call(stack1);}
              if(dataStack2.length){d3.transition(stack2Wrap).call(stack2);}

              if(dataBars1.length){d3.transition(bars1Wrap).call(bars1);}
              if(dataBars2.length){d3.transition(bars2Wrap).call(bars2);}

              if(dataLines1.length){d3.transition(lines1Wrap).call(lines1);}
              if(dataLines2.length){d3.transition(lines2Wrap).call(lines2);}

              if(dataScatters1.length){d3.transition(scatters1Wrap).call(scatters1);}
              if(dataScatters2.length){d3.transition(scatters2Wrap).call(scatters2);}

              xAxis
                  ._ticks( nv.utils.calcTicksX(availableWidth/100, data) )
                  .tickSize(-availableHeight, 0);

              g.select('.nv-x.nv-axis')
                  .attr('transform', 'translate(0,' + availableHeight + ')');
              d3.transition(g.select('.nv-x.nv-axis'))
                  .call(xAxis);

              if (showYAxis) {
                yAxis1
                    ._ticks( nv.utils.calcTicksY(availableHeight/36, data) )
                    .tickSize( -availableWidth, 0);


                    d3.transition(g.select('.nv-y1.nv-axis'))
                    .call(yAxis1);
              }


              if (showYAxis) {
                yAxis2
                    ._ticks( nv.utils.calcTicksY(availableHeight/36, data) )
                    .tickSize( -availableWidth, 0);

                    d3.transition(g.select('.nv-y2.nv-axis'))
                    .call(yAxis2);
              }

              g.select('.nv-y1.nv-axis')
                  .classed('nv-disabled', series1.length ? false : true)
                  .attr('transform', 'translate(' + x.range()[0] + ',0)');

              g.select('.nv-y2.nv-axis')
                  .classed('nv-disabled', series2.length ? false : true)
                  .attr('transform', 'translate(' + x.range()[1] + ',0)');

              legend.dispatch.on('stateChange', function(newState) {
                  chart.update();
              });

              if(useInteractiveGuideline){
                  interactiveLayer
                      .width(availableWidth)
                      .height(availableHeight)
                      .margin({left:margin.left, top:margin.top})
                      .svgContainer(container)
                      .xScale(x);
                  wrap.select(".nv-interactive").call(interactiveLayer);
              }

              //============================================================
              // Event Handling/Dispatching
              //------------------------------------------------------------

              function mouseover_line(evt) {
                  var yaxis = data[evt.seriesIndex].yAxis === 2 ? yAxis2 : yAxis1;
                  evt.value = evt.point.x;
                  evt.series = {
                      value: evt.point.y,
                      color: evt.point.color,
                      key: evt.series.key
                  };
                  tooltip
                      .duration(0)
                      .headerFormatter(function(d, i) {
                        return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i) + ( evt.point.p != undefined ? ' (' + d3.format(',.1f')( evt.point.p ) + '%)' : '' );
                      })
                      .data(evt)
                      .hidden(false);
              }

              function mouseover_scatter(evt) {
                  var yaxis = data[evt.seriesIndex].yAxis === 2 ? yAxis2 : yAxis1;
                  evt.value = evt.point.x;
                  evt.series = {
                      value: evt.point.y,
                      color: evt.point.color,
                      key: evt.series.key
                  };
                  tooltip
                      .duration(100)
                      .headerFormatter(function(d, i) {
                        return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i);
                      })
                      .data(evt)
                      .hidden(false);
              }

              function mouseover_stack(evt) {
                  var yaxis = data[evt.seriesIndex].yAxis === 2 ? yAxis2 : yAxis1;
                  evt.point['x'] = stack1.x()(evt.point);
                  evt.point['y'] = stack1.y()(evt.point);
                  tooltip
                      .duration(0)
                      .headerFormatter(function(d, i) {
                        return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i);
                      })
                      .data(evt)
                      .hidden(false);
              }

              function mouseover_bar(evt) {
                  var yaxis = data[evt.data.series].yAxis === 2 ? yAxis2 : yAxis1;

                  evt.value = bars1.x()(evt.data);
                  evt['series'] = {
                      value: bars1.y()(evt.data),
                      color: evt.color,
                      key: evt.data.key
                  };
                  tooltip
                      .duration(0)
                      .headerFormatter(function(d, i) {
                        return xAxis.tickFormat()(d, i);
                      })
                      .valueFormatter(function(d, i) {
                          return yaxis.tickFormat()(d, i);
                      })
                      .data(evt)
                      .hidden(false);
              }



              function clearHighlights() {
                for(var i=0, il=charts.length; i < il; i++){
                  var chart = charts[i];
                  try {
                    chart.clearHighlights();
                  } catch(e){}
                }
              }

              function highlightPoint(serieIndex, pointIndex, b){
                for(var i=0, il=charts.length; i < il; i++){
                  var chart = charts[i];
                  try {
                    chart.highlightPoint(serieIndex, pointIndex, b);
                  } catch(e){}
                }
              }

              if(useInteractiveGuideline){
                  interactiveLayer.dispatch.on('elementMousemove', function(e) {
                      clearHighlights();
                      var singlePoint, pointIndex, pointXLocation, allData = [];
                      data
                      .filter(function(series, i) {
                          series.seriesIndex = i;
                          return !series.disabled;
                      })
                      .forEach(function(series,i) {
                          var extent = x.domain();
                          var currentValues = series.values.filter(function(d,i) {
                              return chart.x()(d,i) >= extent[0] && chart.x()(d,i) <= extent[1];
                          });

                          pointIndex = nv.interactiveBisect(currentValues, e.pointXValue, chart.x());
                          var point = currentValues[pointIndex];
                          var pointYValue = chart.y()(point, pointIndex);
                          if (pointYValue !== null) {
                              highlightPoint(i, pointIndex, true);
                          }
                          if (point === undefined) return;
                          if (singlePoint === undefined) singlePoint = point;
                          if (pointXLocation === undefined) pointXLocation = x(chart.x()(point,pointIndex));
                          allData.push({
                              key: series.key,
                              value: pointYValue,
                              color: color(series,series.seriesIndex),
                              data: point,
                              yAxis: series.yAxis == 2 ? yAxis2 : yAxis1
                          });
                      });

                      var defaultValueFormatter = function(d,i) {
                          var yAxis = allData[i].yAxis;
                          return d == null ? "N/A" : yAxis.tickFormat()(d);
                      };

                      interactiveLayer.tooltip
                          .headerFormatter(function(d, i) {
                              return xAxis.tickFormat()(d, i);
                          })
                          .valueFormatter(interactiveLayer.tooltip.valueFormatter() || defaultValueFormatter)
                          .data({
                              value: chart.x()( singlePoint,pointIndex ),
                              index: pointIndex,
                              series: allData
                          })();

                      interactiveLayer.renderGuideLine(pointXLocation);
                  });

                  interactiveLayer.dispatch.on("elementMouseout",function(e) {
                      clearHighlights();
                  });
              } else {

                  lines1.dispatch.on('elementMouseover.tooltip', mouseover_line);
                  lines2.dispatch.on('elementMouseover.tooltip', mouseover_line);
                  if( detector.device == 'pc' ) {
                    lines1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                    lines2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                  }

                  scatters1.dispatch.on('elementMouseover.tooltip', mouseover_scatter);
                  scatters2.dispatch.on('elementMouseover.tooltip', mouseover_scatter);
                  if( detector.device == 'pc' ) {
                    scatters1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                    scatters2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                  }

                  stack1.dispatch.on('elementMouseover.tooltip', mouseover_stack);
                  stack2.dispatch.on('elementMouseover.tooltip', mouseover_stack);
                  if( detector.device == 'pc' ) {
                    stack1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                    stack2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true)
                    });
                  }

                  bars1.dispatch.on('elementMouseover.tooltip', mouseover_bar);
                  bars2.dispatch.on('elementMouseover.tooltip', mouseover_bar);

                  if( detector.device == 'pc' ) {
                    bars1.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true);
                    });
                    bars2.dispatch.on('elementMouseout.tooltip', function(evt) {
                        tooltip.hidden(true);
                    });
                  }
                  bars1.dispatch.on('elementMousemove.tooltip', function(evt) {
                      tooltip();
                  });
                  bars2.dispatch.on('elementMousemove.tooltip', function(evt) {
                      tooltip();
                  });
              }
          });

          return chart;
      }

      //============================================================
      // Global getters and setters
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.legend = legend;
      chart.lines1 = lines1;
      chart.lines2 = lines2;
      chart.scatters1 = scatters1;
      chart.scatters2 = scatters2;
      chart.bars1 = bars1;
      chart.bars2 = bars2;
      chart.stack1 = stack1;
      chart.stack2 = stack2;
      chart.xAxis = xAxis;
      chart.yAxis1 = yAxis1;
      chart.yAxis2 = yAxis2;
      chart.tooltip = tooltip;
      chart.interactiveLayer = interactiveLayer;

      chart.options = nv.utils.optionsFunc.bind(chart);

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:      {get: function(){return width;}, set: function(_){width=_;}},
          height:     {get: function(){return height;}, set: function(_){height=_;}},
          showLegend: {get: function(){return showLegend;}, set: function(_){showLegend=_;}},
          yDomain1:      {get: function(){return yDomain1;}, set: function(_){yDomain1=_;}},
          yDomain2:    {get: function(){return yDomain2;}, set: function(_){yDomain2=_;}},
          noData:    {get: function(){return noData;}, set: function(_){noData=_;}},
          interpolate:    {get: function(){return interpolate;}, set: function(_){interpolate=_;}},
          legendRightAxisHint:    {get: function(){return legendRightAxisHint;}, set: function(_){legendRightAxisHint=_;}},
          fillOpacity: {get: function(){return bars1.fillOpacity();}, set: function(_){bars1.fillOpacity(_);}},
          pointsShowP: {get: function(){return lines1.pointsShowP();}, set: function(_){ lines1.pointsShowP(_);}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              if (_.top !== undefined) {
                  margin.top = _.top;
                  marginTop = _.top;
              }
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          color:  {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }},
          x: {get: function(){return getX;}, set: function(_){
              getX = _;
              lines1.x(_);
              lines2.x(_);
              scatters1.x(_);
              scatters2.x(_);
              bars1.x(_);
              bars2.x(_);
              stack1.x(_);
              stack2.x(_);
          }},
          y: {get: function(){return getY;}, set: function(_){
              getY = _;
              lines1.y(_);
              lines2.y(_);
              scatters1.y(_);
              scatters2.y(_);
              stack1.y(_);
              stack2.y(_);
              bars1.y(_);
              bars2.y(_);
          }},
          useVoronoi: {get: function(){return useVoronoi;}, set: function(_){
              useVoronoi=_;
              lines1.useVoronoi(_);
              lines2.useVoronoi(_);
              stack1.useVoronoi(_);
              stack2.useVoronoi(_);
          }},

          useInteractiveGuideline: {get: function(){return useInteractiveGuideline;}, set: function(_){
              useInteractiveGuideline = _;
              if (useInteractiveGuideline) {
                  lines1.interactive(false);
                  lines1.useVoronoi(false);
                  lines2.interactive(false);
                  lines2.useVoronoi(false);
                  stack1.interactive(false);
                  stack1.useVoronoi(false);
                  stack2.interactive(false);
                  stack2.useVoronoi(false);
                  scatters1.interactive(false);
                  scatters2.interactive(false);
              }
          }},

          duration: {get: function(){return duration;}, set: function(_) {
              duration = _;
              [lines1, lines2, stack1, stack2, scatters1, scatters2, xAxis, yAxis1, yAxis2].forEach(function(model){
                model.duration(duration);
              });
          }},
          showYAxis:    {get: function(){return showYAxis;}, set: function(_){showYAxis=_;}}
      });

      nv.utils.initOptions(chart);

      return chart;
  };

  nv.models.pie2 = function() {
    "use strict";

    //============================================================
    // Public Variables with Default Settings
    //------------------------------------------------------------

    var margin = {top: 0, right: 0, bottom: 0, left: 0}
        , width = 500
        , height = 500
        , getX = function(d) { return d.x }
        , getY = function(d) { return d.y }
        , id = Math.floor(Math.random() * 10000) //Create semi-unique ID in case user doesn't select one
        , container = null
        , color = nv.utils.defaultColor()
        , valueFormat = d3.format(',.2f')
        , showLabels = true
        , labelsOutside = false
        , labelType = "key"
        , labelThreshold = .02 //if slice percentage is under this, don't show label
        , donut = false
        , title = false
        , title2 = false
        , growOnHover = true
        , titleOffset = 0
        , labelSunbeamLayout = false
        , startAngle = false
        , padAngle = false
        , endAngle = false
        , cornerRadius = 0
        , donutRatio = 0.5
        , duration = 250
        , arcsRadius = null
        , dispatch = d3.dispatch('chartClick', 'elementClick', 'elementDblClick', 'elementMouseover', 'elementMouseout', 'elementMousemove', 'renderEnd')
        ;

    var arcs = [];
    var arcsOver = [];

    //============================================================
    // chart function
    //------------------------------------------------------------

    var renderWatch = nv.utils.renderWatch(dispatch);

    function chart(selection) {
        renderWatch.reset();
        selection.each(function(data) {
            var availableWidth = width - margin.left - margin.right
                , availableHeight = height - margin.top - margin.bottom
                , radius = Math.min(availableWidth, availableHeight) / 2
                , arcsRadiusOuter
                , arcsRadiusInner
                ;

            container = d3.select(this)
            if (arcsRadius === null) {
                var outer = radius - radius / 10;
                var inner = donutRatio * radius;
                  arcsRadiusOuter = outer;
                  arcsRadiusInner = inner;
            } else {
                if(growOnHover){
                    arcsRadiusOuter = (arcsRadius.outer - arcsRadius.outer / 10) * radius;
                    arcsRadiusInner = (arcsRadius.inner - arcsRadius.inner / 10) * radius;
                    donutRatio = d3.min((arcsRadius.inner - arcsRadius.inner / 10));
                } else {
                    arcsRadiusOuter = arcsRadius.outer * radius;
                    arcsRadiusInner = arcsRadius.inner * radius;
                    donutRatio = d3.min(arcsRadius.inner);
                }
            }
            nv.utils.initSVG(container);

            // Setup containers and skeleton of chart
            var wrap = container.selectAll('.nv-wrap.nv-pie').data([data]);
            var wrapEnter = wrap.enter().append('g').attr('class','nvd3 nv-wrap nv-pie nv-chart-' + id);
            var gEnter = wrapEnter.append('g');
            var g = wrap.select('g');
            var g_pie = gEnter.append('g').attr('class', 'nv-pie');
            gEnter.append('g').attr('class', 'nv-pieLabels');

            wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
            g.select('.nv-pie').attr('transform', 'translate(' + availableWidth / 2 + ',' + availableHeight / 2 + ')');
            g.select('.nv-pieLabels').attr('transform', 'translate(' + availableWidth / 2 + ',' + availableHeight / 2 + ')');

            //
            container.on('click', function(d,i) {
                dispatch.chartClick({
                    data: d,
                    index: i,
                    pos: d3.event,
                    id: id
                });
            });

            arcs = [];
            arcsOver = [];

            var arc = d3.svg.arc().outerRadius(arcsRadiusOuter);
            var arcOver = d3.svg.arc().outerRadius(arcsRadiusOuter + 5);

            if (startAngle !== false) {
                arc.startAngle(startAngle);
                arcOver.startAngle(startAngle);
            }
            if (endAngle !== false) {
                arc.endAngle(endAngle);
                arcOver.endAngle(endAngle);
            }
            if (donut) {
                arc.innerRadius(arcsRadiusInner);
                arcOver.innerRadius(arcsRadiusInner);
            }

            if (arc.cornerRadius && cornerRadius) {
                arc.cornerRadius(cornerRadius);
                arcOver.cornerRadius(cornerRadius);
            }

            arcs.push(arc);
            arcsOver.push(arcOver);

            // Setup the Pie chart and choose the data element
            var pie = d3.layout.pie()
                .sort(null)
                .value(function(d) { return d.disabled ? 0 : getY(d) });

            // padAngle added in d3 3.5
            if (pie.padAngle && padAngle) {
                pie.padAngle(padAngle);
            }

            // if title is specified and donut, put it in the middle
            if (donut && title) {
                g_pie.append("text").attr('class', 'nv-pie-title');
                g_pie.append("text").attr('class', 'nv-pie-title2');

                wrap.select('.nv-pie-title')
                    .style("text-anchor", "middle")
                    .text(function (d) {
                        return title;
                    })
                    // .style("font-size", (Math.min(availableWidth, availableHeight)) * donutRatio * 2 / (title.length + 2) + "px")
                    .attr("dy", "0.4em") // trick to vertically center text
                    .attr('transform', function(d, i) {
                        return 'translate(0, '+ ( titleOffset + 12 ) + ')';
                    });

                wrap.select('.nv-pie-title2')
                    .style("text-anchor", "middle")
                    .text(function (d) {
                        return title2;
                    })
                    // .style("font-size", (Math.min(availableWidth, availableHeight)) * donutRatio * 2 / (title.length + 2) + "px")
                    .attr("dy", "-0.2em") // trick to vertically center text
                    .attr('transform', function(d, i) {
                        return 'translate(0, '+ ( titleOffset - 12 ) + ')';
                    });
            }

            var slices = wrap.select('.nv-pie').selectAll('.nv-slice').data(pie(data));
            var pieLabels = wrap.select('.nv-pieLabels').selectAll('.nv-label').data(pie(data));

            slices.exit().remove();
            pieLabels.exit().remove();

            var ae = slices.enter().append('g');
            ae.attr('class', 'nv-slice');
            ae.on('mouseover', function(d, i) {
                d3.select(this).classed('hover', true);
                if (growOnHover) {
                    d3.select(this).select("path").transition()
                        .duration(70)
                        .attr("d", arcsOver[i]);
                }
                dispatch.elementMouseover({
                    data: d.data,
                    index: i,
                    color: d3.select(this).style("fill"),
                    percent: (d.endAngle - d.startAngle) / (2 * Math.PI)
                });
            });
            ae.on('mouseout', function(d, i) {
                d3.select(this).classed('hover', false);
                if (growOnHover) {
                    d3.select(this).select("path").transition()
                        .duration(50)
                        .attr("d", arcs[i]);
                }
                dispatch.elementMouseout({data: d.data, index: i});
            });
            ae.on('mousemove', function(d, i) {
                dispatch.elementMousemove({data: d.data, index: i});
            });
            ae.on('click', function(d, i) {
                var element = this;
                dispatch.elementClick({
                    data: d.data,
                    index: i,
                    color: d3.select(this).style("fill"),
                    event: d3.event,
                    element: element
                });
            });
            ae.on('dblclick', function(d, i) {
                dispatch.elementDblClick({
                    data: d.data,
                    index: i,
                    color: d3.select(this).style("fill")
                });
            });

            slices.attr('fill', function(d,i) { return color(d.data, i); });
            slices.attr('stroke', function(d,i) { return color(d.data, i); });

            var paths = ae.append('path').each(function(d) {
                this._current = d;
            });

            slices.select('path')
                .transition()
                .duration(duration)
                .attr('d', function (d, i) { return arcs[i](d); })
                .attrTween('d', arcTween);

            if (showLabels) {
                // This does the normal label
                var labelsArc = [];
                for (var i = 0; i < 1; i++) {
                    labelsArc.push(arcs[i]);

                    if (labelsOutside) {
                        if (donut) {
                            labelsArc[i] = d3.svg.arc().outerRadius(arcs[i].outerRadius());
                            if (startAngle !== false) labelsArc[i].startAngle(startAngle);
                            // TODO: 190411
                            // if (endAngle !== false) labelsArc[i].endAngle(endAngle);
                            if (endAngle !== false) {
                              labelsArc[i].endAngle( function(d) {
                                return d.startAngle/2 + Math.PI * 2 * 0.5;
                              } )
                            };
                        }
                    } else if (!donut) {
                            labelsArc[i].innerRadius(0);
                    }
                }

                pieLabels.enter().append("g").classed("nv-label",true).each(function(d,i) {
                    var group = d3.select(this);

                    group.attr('transform', function (d, i) {
                        if (labelSunbeamLayout) {
                            d.outerRadius = arcsRadiusOuter + 10; // Set Outer Coordinate
                            d.innerRadius = arcsRadiusOuter + 15; // Set Inner Coordinate
                            var rotateAngle = (d.startAngle + d.endAngle) / 2 * (180 / Math.PI);
                            if ((d.startAngle + d.endAngle) / 2 < Math.PI) {
                                rotateAngle -= 90;
                            } else {
                                rotateAngle += 90;
                            }
                            return 'translate(' + labelsArc[i].centroid(d) + ') rotate(' + rotateAngle + ')';
                        } else {
                            d.outerRadius = radius + 10; // Set Outer Coordinate
                            d.innerRadius = radius + 40; // Set Inner Coordinate
                            d.endAngle = d.endAngle * 2;
                            return 'translate(' + labelsArc[i].centroid(d) + ')'
                        }
                    });

                    group.append('rect')
                        .style('stroke', '#fff')
                        .style('fill', '#fff')
                        .attr("rx", 3)
                        .attr("ry", 3);

                    group.append('text')
                        .style('text-anchor', labelSunbeamLayout ? ((d.startAngle + d.endAngle) / 2 < Math.PI ? 'start' : 'end') : 'middle') //center the text on it's origin or begin/end if orthogonal aligned
                        .attr("dy", 13);

                    group.append('text')
                        .style('text-anchor', labelSunbeamLayout ? ((d.startAngle + d.endAngle) / 2 < Math.PI ? 'start' : 'end') : 'middle') //center the text on it's origin or begin/end if orthogonal aligned
                        .attr("class", "key")
                        .attr("dy", -7);
                });

                var labelLocationHash = {};
                var avgHeight = 14;
                var avgWidth = 140;
                var createHashKey = function(coordinates) {
                    return Math.floor(coordinates[0]/avgWidth) * avgWidth + ',' + Math.floor(coordinates[1]/avgHeight) * avgHeight;
                };
                var getSlicePercentage = function(d) {
                    return (d.endAngle - d.startAngle) / (2 * Math.PI);
                };

                pieLabels.watchTransition(renderWatch, 'pie labels').attr('transform', function (d, i) {
                    if (labelSunbeamLayout) {
                        d.outerRadius = arcsRadiusOuter + 10; // Set Outer Coordinate
                        d.innerRadius = arcsRadiusOuter + 15; // Set Inner Coordinate
                        var rotateAngle = (d.startAngle + d.endAngle) / 2 * (180 / Math.PI);
                        if ((d.startAngle + d.endAngle) / 2 < Math.PI) {
                            rotateAngle -= 90;
                        } else {
                            rotateAngle += 90;
                        }
                        return 'translate(' + labelsArc[i].centroid(d) + ') rotate(' + rotateAngle + ')';
                    } else {
                        d.outerRadius = radius + 10; // Set Outer Coordinate
                        d.innerRadius = radius + 60; // Set Inner Coordinate
                        d.endAngle = d.endAngle * 2;

                        /*
                        Overlapping pie labels are not good. What this attempts to do is, prevent overlapping.
                        Each label location is hashed, and if a hash collision occurs, we assume an overlap.
                        Adjust the label's y-position to remove the overlap.
                        */
                        var center = labelsArc[i].centroid(d);
                        var percent = getSlicePercentage(d);
                        if (d.value && percent >= labelThreshold) {
                            var hashKey = createHashKey(center);
                            if (labelLocationHash[hashKey]) {
                                center[1] -= avgHeight;
                            }
                            labelLocationHash[createHashKey(center)] = true;
                        }
                        return 'translate(' + center + ')'
                    }
                });

                pieLabels.select(".nv-label text")
                    .style('text-anchor', function(d,i) {
                        //center the text on it's origin or begin/end if orthogonal aligned
                        return labelSunbeamLayout ? ((d.startAngle + d.endAngle) / 2 < Math.PI ? 'start' : 'end') : 'middle';
                    })
                    .text(function(d, i) {
                        var percent = getSlicePercentage(d);
                        var label = '';
                        if (!d.value || percent < labelThreshold) return '';

                        if(typeof labelType === 'function') {
                            label = labelType(d, i, {
                                'key': getX(d.data),
                                'value': getY(d.data),
                                'percent': valueFormat(percent)
                            });
                        } else {
                            switch (labelType) {
                                case 'key':
                                    label = getX(d.data);
                                    break;
                                case 'value':
                                case 'key value':
                                    label = valueFormat(getY(d.data));
                                    break;
                                case 'percent':
                                    label = d3.format('%')(percent);
                                    break;
                            }
                        }
                        return label;
                    })
                ;

                pieLabels.select(".nv-label text.key")
                    .style('text-anchor', function(d,i) {
                        //center the text on it's origin or begin/end if orthogonal aligned
                        return labelSunbeamLayout ? ((d.startAngle + d.endAngle) / 2 < Math.PI ? 'start' : 'end') : 'middle';
                    })
                    .text(function(d, i) {
                        var percent = getSlicePercentage(d);
                        var label = '';
                        if (!d.value || percent < labelThreshold) return '';
                        if (labelType != 'key value') return '';

                        label = d.data.key
                        return label;
                    })
                ;
            }


            // Computes the angle of an arc, converting from radians to degrees.
            function angle(d) {
                var a = (d.startAngle + d.endAngle) * 90 / Math.PI - 90;
                return a > 90 ? a - 180 : a;
            }

            function arcTween(a, idx) {
                a.endAngle = isNaN(a.endAngle) ? 0 : a.endAngle;
                a.startAngle = isNaN(a.startAngle) ? 0 : a.startAngle;
                if (!donut) a.innerRadius = 0;
                var i = d3.interpolate(this._current, a);
                this._current = i(0);
                return function (t) {
                    return arcs[idx](i(t));
                };
            }
        });

        renderWatch.renderEnd('pie immediate');
        return chart;
    }

    //============================================================
    // Expose Public Variables
    //------------------------------------------------------------

    chart.dispatch = dispatch;
    chart.options = nv.utils.optionsFunc.bind(chart);

    chart._options = Object.create({}, {
        // simple options, just get/set the necessary values
        arcsRadius: { get: function () { return arcsRadius; }, set: function (_) { arcsRadius = _; } },
        width:      {get: function(){return width;}, set: function(_){width=_;}},
        height:     {get: function(){return height;}, set: function(_){height=_;}},
        showLabels: {get: function(){return showLabels;}, set: function(_){showLabels=_;}},
        title:      {get: function(){return title;}, set: function(_){title=_;}},
        title2:      {get: function(){return title2;}, set: function(_){title2=_;}},
        titleOffset:    {get: function(){return titleOffset;}, set: function(_){titleOffset=_;}},
        labelThreshold: {get: function(){return labelThreshold;}, set: function(_){labelThreshold=_;}},
        valueFormat:    {get: function(){return valueFormat;}, set: function(_){valueFormat=_;}},
        x:          {get: function(){return getX;}, set: function(_){getX=_;}},
        id:         {get: function(){return id;}, set: function(_){id=_;}},
        endAngle:   {get: function(){return endAngle;}, set: function(_){endAngle=_;}},
        startAngle: {get: function(){return startAngle;}, set: function(_){startAngle=_;}},
        padAngle:   {get: function(){return padAngle;}, set: function(_){padAngle=_;}},
        cornerRadius: {get: function(){return cornerRadius;}, set: function(_){cornerRadius=_;}},
        donutRatio:   {get: function(){return donutRatio;}, set: function(_){donutRatio=_;}},
        labelsOutside: {get: function(){return labelsOutside;}, set: function(_){labelsOutside=_;}},
        labelSunbeamLayout: {get: function(){return labelSunbeamLayout;}, set: function(_){labelSunbeamLayout=_;}},
        donut:              {get: function(){return donut;}, set: function(_){donut=_;}},
        growOnHover:        {get: function(){return growOnHover;}, set: function(_){growOnHover=_;}},

        // depreciated after 1.7.1
        pieLabelsOutside: {get: function(){return labelsOutside;}, set: function(_){
            labelsOutside=_;
            nv.deprecated('pieLabelsOutside', 'use labelsOutside instead');
        }},
        // depreciated after 1.7.1
        donutLabelsOutside: {get: function(){return labelsOutside;}, set: function(_){
            labelsOutside=_;
            nv.deprecated('donutLabelsOutside', 'use labelsOutside instead');
        }},
        // deprecated after 1.7.1
        labelFormat: {get: function(){ return valueFormat;}, set: function(_) {
            valueFormat=_;
            nv.deprecated('labelFormat','use valueFormat instead');
        }},

        // options that require extra logic in the setter
        margin: {get: function(){return margin;}, set: function(_){
            margin.top    = typeof _.top    != 'undefined' ? _.top    : margin.top;
            margin.right  = typeof _.right  != 'undefined' ? _.right  : margin.right;
            margin.bottom = typeof _.bottom != 'undefined' ? _.bottom : margin.bottom;
            margin.left   = typeof _.left   != 'undefined' ? _.left   : margin.left;
        }},
        duration: {get: function(){return duration;}, set: function(_){
            duration = _;
            renderWatch.reset(duration);
        }},
        y: {get: function(){return getY;}, set: function(_){
            getY=d3.functor(_);
        }},
        color: {get: function(){return color;}, set: function(_){
            color=nv.utils.getColor(_);
        }},
        labelType:          {get: function(){return labelType;}, set: function(_){
            labelType= _ || 'key';
        }}
    });

    nv.utils.initOptions(chart);
    return chart;
  };

  nv.models.pieChart2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var pie = nv.models.pie2();
      var pie2 = nv.models.pie2();
      var tooltip = nv.models.tooltip();

      var margin = {top: 30, right: 20, bottom: 20, left: 20}
          , marginTop = null
          , width = null
          , height = null
          , showTooltipPercent = false
          , color = nv.utils.defaultColor()
          // , state = nv.utils.state()
          // , defaultState = null
          , noData = null
          , duration = 250
          , dispatch = d3.dispatch('stateChange', 'changeState','renderEnd')
          ;

      tooltip
          .duration(0)
          .headerEnabled(false)
          .valueFormatter(function(d, i) {
              return pie.valueFormat()(d, i);
              return pie2.valueFormat()(d, i);
          });

      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var renderWatch = nv.utils.renderWatch(dispatch);

      // var stateGetter = function(data) {
      //     return function(){
      //         return {
      //             active: data.map(function(d) { return !d.disabled })
      //         };
      //     }
      // };
      //
      // var stateSetter = function(data) {
      //     return function(state) {
      //         if (state.active !== undefined) {
      //             data.forEach(function (series, i) {
      //                 series.disabled = !state.active[i];
      //             });
      //         }
      //     }
      // };

      //============================================================
      // Chart function
      //------------------------------------------------------------

      function chart(selection) {
          renderWatch.reset();
          renderWatch.models(pie);
          renderWatch.models(pie2);

          selection.each(function(data) {
              var container = d3.select(this);
              nv.utils.initSVG(container);

              var that = this;
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);

              chart.update = function() { container.transition().call(chart); };
              chart.container = this;

              // state.setter(stateSetter(data), chart.update)
              //     .getter(stateGetter(data))
              //     .update();

              //set state.disabled
              // state.disabled = data.map(function(d) { return !!d.disabled });

              // if (!defaultState) {
              //     var key;
              //     defaultState = {};
              //     for (key in state) {
              //         if (state[key] instanceof Array)
              //             defaultState[key] = state[key].slice(0);
              //         else
              //             defaultState[key] = state[key];
              //     }
              // }

              // Display No Data message if there's nothing to show.
              // if (!data || !data.length) {
              //     nv.utils.noData(chart, container);
              //     return chart;
              // } else {
              //     container.selectAll('.nv-noData').remove();
              // }

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-pieChart').data([data]);
              var gEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-pieChart').append('g');
              var g = wrap.select('g');

              gEnter.append('g').attr('class', 'nv-pieWrap0');
              gEnter.append('g').attr('class', 'nv-pieWrap1');

              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              // Main Chart Component(s)
              pie.width(availableWidth).height(availableHeight);
              pie2.width(availableWidth).height(availableHeight);

              var pieWrap0 = g.select('.nv-pieWrap0').datum(data.objective);
              d3.transition(pieWrap0).call(pie);

              pie2.endAngle(function(d) {
                var ratio = data.sum[0].y / data.objective[0].y;
                return d.startAngle/2 + Math.PI * 2 * ratio;
              });

              var pieWrap1 = g.select('.nv-pieWrap1').datum(data.sum);
              d3.transition(pieWrap1).call(pie2);

              //============================================================
              // Event Handling/Dispatching (in chart's scope)
              //------------------------------------------------------------

              // legend.dispatch.on('stateChange', function(newState) {
              //     for (var key in newState) {
              //         state[key] = newState[key];
              //     }
              //     dispatch.stateChange(state);
              //     chart.update();
              // });
              //
              // // Update chart from a state object passed to event handler
              // dispatch.on('changeState', function(e) {
              //     if (typeof e.disabled !== 'undefined') {
              //         data.forEach(function(series,i) {
              //             series.disabled = e.disabled[i];
              //         });
              //         state.disabled = e.disabled;
              //     }
              //     chart.update();
              // });
          });

          renderWatch.renderEnd('pieChart immediate');
          return chart;
      }

      //============================================================
      // Event Handling/Dispatching (out of chart's scope)
      //------------------------------------------------------------

      pie.dispatch.on('elementMouseover.tooltip', function(evt) {
          evt['series'] = {
              key: chart.x()(evt.data),
              value: chart.y()(evt.data),
              color: evt.color,
              percent: evt.percent
          };
          if (!showTooltipPercent) {
              delete evt.percent;
              delete evt.series.percent;
          }
          tooltip.data(evt).hidden(false);
      });

      if( detector.device == 'pc' ) {
        pie.dispatch.on('elementMouseout.tooltip', function(evt) {
            tooltip.hidden(true);
        });
      }

      pie.dispatch.on('elementMousemove.tooltip', function(evt) {
          tooltip();
      });

      pie2.dispatch.on('elementMouseover.tooltip', function(evt) {
          evt['series'] = {
              key: chart.x()(evt.data),
              value: chart.y()(evt.data),
              color: evt.color,
              percent: evt.percent
          };
          if (!showTooltipPercent) {
              delete evt.percent;
              delete evt.series.percent;
          }
          tooltip.data(evt).hidden(false);
      });

      if( detector.device == 'pc' ) {
        pie2.dispatch.on('elementMouseout.tooltip', function(evt) {
            tooltip.hidden(true);
        });
      }

      pie2.dispatch.on('elementMousemove.tooltip', function(evt) {
          tooltip();
      });

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      // expose chart's sub-components
      chart.dispatch = dispatch;
      chart.pie = pie;
      chart.pie2 = pie2;
      chart.tooltip = tooltip;
      chart.options = nv.utils.optionsFunc.bind(chart);

      // use Object get/set functionality to map between vars and chart functions
      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:              {get: function(){return width;},                set: function(_){width=_;}},
          height:             {get: function(){return height;},               set: function(_){height=_;}},
          noData:             {get: function(){return noData;},               set: function(_){noData=_;}},
          showTooltipPercent: {get: function(){return showTooltipPercent;},   set: function(_){showTooltipPercent=_;}},
          // defaultState:       {get: function(){return defaultState;},         set: function(_){defaultState=_;}},

          donut: {get: function(){return pie.donut();}, set: function(_){
            pie.donut(_);
            pie2.donut(_);
          }},
          labelsOutside: {get: function(){return pie.labelsOutside();}, set: function(_){
            pie.labelsOutside(_);
            pie2.labelsOutside(_);
          }},
          labelType:          {get: function(){return pie.labelType();}, set: function(_){
            pie.labelType( _ || 'key' );
            pie2.labelType( _ || 'key' );
          }},
          valueFormat:    {get: function(){return pie.valueFormat();}, set: function(_){
            pie.valueFormat(_);
            pie2.valueFormat(_);
          }},
          arcsRadius:    {get: function(){return pie.arcsRadius();}, set: function(_){
            pie.arcsRadius(_[0]);
            pie2.arcsRadius(_[1]);
          }},

          // options that require extra logic in the setter
          color: {get: function(){return color;}, set: function(_){
              color = _;
              pie.color([color[0]]);
              pie2.color([color[1]]);
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
              pie.duration(duration);
              pie2.duration(duration);
          }},
          margin: {get: function(){return margin;}, set: function(_){
              if (_.top !== undefined) {
                  margin.top = _.top;
                  marginTop = _.top;
              }
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }}
      });
      nv.utils.inheritOptions(chart, pie);
      // nv.utils.inheritOptions(chart, pie2);
      nv.utils.initOptions(chart);
      return chart;
  };

  nv.models.scatter2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var positionArr;

      var margin       = {top: 0, right: 0, bottom: 0, left: 0}
          , width        = null
          , height       = null
          , color        = nv.utils.defaultColor() // chooses color
          , pointBorderColor = null
          , id           = Math.floor(Math.random() * 100000) //Create semi-unique ID incase user doesn't select one
          , container    = null
          , x            = d3.scale.linear()
          , y            = d3.scale.linear()
          , z            = d3.scale.linear() //linear because d3.svg.shape.size is treated as area
          , getX         = function(d) { return d.x } // accessor to get the x value
          , getY         = function(d) { return d.y } // accessor to get the y value
          , getSize      = function(d) { return d.size || 1} // accessor to get the point size
          , getShape     = function(d) { return d.shape || 'circle' } // accessor to get point shape
          , forceX       = [] // List of numbers to Force into the X scale (ie. 0, or a max / min, etc.)
          , forceY       = [] // List of numbers to Force into the Y scale
          , forceSize    = [] // List of numbers to Force into the Size scale
          , interactive  = true // If true, plots a voronoi overlay for advanced point intersection
          , pointActive  = function(d) { return !d.notActive } // any points that return false will be filtered out
          , padData      = false // If true, adds half a data points width to front and back, for lining up a line chart with a bar chart
          , padDataOuter = .1 //outerPadding to imitate ordinal scale outer padding
          , clipEdge     = false // if true, masks points within x and y scale
          , clipVoronoi  = true // if true, masks each point with a circle... can turn off to slightly increase performance
          , showVoronoi  = false // display the voronoi areas
          , clipRadius   = function() { return 25 } // function to get the radius for voronoi point clips
          , xDomain      = null // Override x domain (skips the calculation from data)
          , yDomain      = null // Override y domain
          , xRange       = null // Override x range
          , yRange       = null // Override y range
          , sizeDomain   = null // Override point size domain
          , sizeRange    = null
          , singlePoint  = false
          , dispatch     = d3.dispatch('elementClick', 'elementDblClick', 'elementMouseover', 'elementMouseout', 'renderEnd')
          , useVoronoi   = true
          , duration     = 250
          , interactiveUpdateDelay = 300
          , showLabels    = false
          , pointsShowY    = true
          , pointsShowKey    = false
          , pointsShowP    = false
          , pointsOffset    = { x:0, y:0 }
          , valueFormat = d3.format('.02f')
          ;


      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x0, y0, z0 // used to store previous scales
          , xDom, yDom // used to store previous domains
          , width0
          , height0
          , timeoutID
          , needsUpdate = false // Flag for when the points are visually updating, but the interactive layer is behind, to disable tooltips
          , renderWatch = nv.utils.renderWatch(dispatch, duration)
          , _sizeRange_def = [16, 256]
          , _cache = {}
          ;

      function getCache(d) {
          var key, val;
          key = d[0].series + ':' + d[1];
          val = _cache[key] = _cache[key] || {};
          return val;
      }

      function delCache(d) {
          var key, val;
          key = d[0].series + ':' + d[1];
          delete _cache[key];
      }

      function getDiffs(d) {
          var i, key, val,
              cache = getCache(d),
              diffs = false;
          for (i = 1; i < arguments.length; i += 2) {
              key = arguments[i];
              val = arguments[i + 1](d[0], d[1]);
              if (cache[key] !== val || !cache.hasOwnProperty(key)) {
                  cache[key] = val;
                  diffs = true;
              }
          }
          return diffs;
      }

      function chart(selection) {
          renderWatch.reset();
          selection.each(function(data) {
              container = d3.select(this);
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);

              nv.utils.initSVG(container);

              //add series index to each data point for reference
              data.forEach(function(series, i) {
                var key = series.key;
                  series.values.forEach(function(point) {
                      point.series = i;
                      if( key !== undefined ) point.key = key;
                  });
              });

              // Setup Scales
              var logScale = chart.yScale().name === d3.scale.log().name ? true : false;
              // remap and flatten the data for use in calculating the scales' domains
              var seriesData = (xDomain && yDomain && sizeDomain) ? [] : // if we know xDomain and yDomain and sizeDomain, no need to calculate.... if Size is constant remember to set sizeDomain to speed up performance
                  d3.merge(
                      data.map(function(d) {
                          return d.values.map(function(d,i) {
                              return { x: getX(d,i), y: getY(d,i), size: getSize(d,i) }
                          })
                      })
                  );

              x   .domain(xDomain || d3.extent(seriesData.map(function(d) { return d.x; }).concat(forceX)))

              if (padData && data[0])
                  x.range(xRange || [(availableWidth * padDataOuter +  availableWidth) / (2 *data[0].values.length), availableWidth - availableWidth * (1 + padDataOuter) / (2 * data[0].values.length)  ]);
              //x.range([availableWidth * .5 / data[0].values.length, availableWidth * (data[0].values.length - .5)  / data[0].values.length ]);
              else
                  x.range(xRange || [0, availableWidth]);

              if (logScale) {
                      var min = d3.min(seriesData.map(function(d) { if (d.y !== 0) return d.y; }));
                      y.clamp(true)
                          .domain(yDomain || d3.extent(seriesData.map(function(d) {
                              if (d.y !== 0) return d.y;
                              else return min * 0.1;
                          }).concat(forceY)))
                          // .range(yRange || [availableHeight, 0]);
              } else {
                      y.domain(yDomain || d3.extent(seriesData.map(function (d) { return d.y;}).concat(forceY)))
              }
              if (padData && data[0])
                  y.range(yRange || [availableHeight - availableHeight * (1 + padDataOuter) / (2 * data[0].values.length), (availableHeight * padDataOuter +  availableHeight) / (2 *data[0].values.length)]);
              else
                  y.range(yRange || [availableHeight, 0]);

              z   .domain(sizeDomain || d3.extent(seriesData.map(function(d) { return d.size }).concat(forceSize)))
                  .range(sizeRange || _sizeRange_def);

              // If scale's domain don't have a range, slightly adjust to make one... so a chart can show a single data point
              singlePoint = x.domain()[0] === x.domain()[1] || y.domain()[0] === y.domain()[1];

              if (x.domain()[0] === x.domain()[1])
                  x.domain()[0] ?
                      x.domain([x.domain()[0] - x.domain()[0] * 0.01, x.domain()[1] + x.domain()[1] * 0.01])
                      : x.domain([-1,1]);

              if (y.domain()[0] === y.domain()[1])
                  y.domain()[0] ?
                      y.domain([y.domain()[0] - y.domain()[0] * 0.01, y.domain()[1] + y.domain()[1] * 0.01])
                      : y.domain([-1,1]);

              if ( isNaN(x.domain()[0])) {
                  x.domain([-1,1]);
              }

              if ( isNaN(y.domain()[0])) {
                  y.domain([-1,1]);
              }

              x0 = x0 || x;
              y0 = y0 || y;
              z0 = z0 || z;

              var scaleDiff = x(1) !== x0(1) || y(1) !== y0(1) || z(1) !== z0(1);

              width0 = width0 || width;
              height0 = height0 || height;

              var sizeDiff = width0 !== width || height0 !== height;

              // Domain Diffs

              xDom = xDom || [];
              var domainDiff = xDom[0] !== x.domain()[0] || xDom[1] !== x.domain()[1];
              xDom = x.domain();

              yDom = yDom || [];
              domainDiff = domainDiff || yDom[0] !== y.domain()[0] || yDom[1] !== y.domain()[1];
              yDom = y.domain();

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-scatter').data([data]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-scatter nv-chart-' + id);
              var defsEnter = wrapEnter.append('defs');
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              wrap.classed('nv-single-point', singlePoint);
              gEnter.append('g').attr('class', 'nv-groups');
              gEnter.append('g').attr('class', 'nv-point-paths');
              wrapEnter.append('g').attr('class', 'nv-point-clips');

              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              defsEnter.append('clipPath')
                  .attr('id', 'nv-edge-clip-' + id)
                  .append('rect')
                  .attr('transform', 'translate( -10, -10)');

              wrap.select('#nv-edge-clip-' + id + ' rect')
                  .attr('width', availableWidth + 20)
                  .attr('height', (availableHeight > 0) ? availableHeight + 20 : 0);

              g.attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + id + ')' : '');

              function updateInteractiveLayer() {
                  // Always clear needs-update flag regardless of whether or not
                  // we will actually do anything (avoids needless invocations).
                  needsUpdate = false;

                  if (!interactive) return false;

                  // inject series and point index for reference into voronoi
                  if (useVoronoi === true) {
                      var vertices = d3.merge(data.map(function(group, groupIndex) {
                              return group.values
                                  .map(function(point, pointIndex) {
                                      // *Adding noise to make duplicates very unlikely
                                      // *Injecting series and point index for reference
                                      /* *Adding a 'jitter' to the points, because there's an issue in d3.geom.voronoi.
                                       */
                                      var pX = getX(point,pointIndex);
                                      var pY = getY(point,pointIndex);

                                      return [nv.utils.NaNtoZero(x(pX))+ Math.random() * 1e-4,
                                              nv.utils.NaNtoZero(y(pY))+ Math.random() * 1e-4,
                                          groupIndex,
                                          pointIndex, point]; //temp hack to add noise until I think of a better way so there are no duplicates
                                  })
                                  .filter(function(pointArray, pointIndex) {
                                      return pointActive(pointArray[4], pointIndex); // Issue #237.. move filter to after map, so pointIndex is correct!
                                  })
                          })
                      );

                      if (vertices.length == 0) return false;  // No active points, we're done
                      if (vertices.length < 3) {
                          // Issue #283 - Adding 2 dummy points to the voronoi b/c voronoi requires min 3 points to work
                          vertices.push([x.range()[0] - 20, y.range()[0] - 20, null, null]);
                          vertices.push([x.range()[1] + 20, y.range()[1] + 20, null, null]);
                          vertices.push([x.range()[0] - 20, y.range()[0] + 20, null, null]);
                          vertices.push([x.range()[1] + 20, y.range()[1] - 20, null, null]);
                      }

                      // keep voronoi sections from going more than 10 outside of graph
                      // to avoid overlap with other things like legend etc
                      var bounds = d3.geom.polygon([
                          [-10,-10],
                          [-10,height + 10],
                          [width + 10,height + 10],
                          [width + 10,-10]
                      ]);

                      var voronoi = d3.geom.voronoi(vertices).map(function(d, i) {
                          return {
                              'data': bounds.clip(d),
                              'series': vertices[i][2],
                              'point': vertices[i][3]
                          }
                      });

                      // nuke all voronoi paths on reload and recreate them
                      wrap.select('.nv-point-paths').selectAll('path').remove();
                      var pointPaths = wrap.select('.nv-point-paths').selectAll('path').data(voronoi);
                      var vPointPaths = pointPaths
                          .enter().append("svg:path")
                          .attr("d", function(d) {
                              if (!d || !d.data || d.data.length === 0)
                                  return 'M 0 0';
                              else
                                  return "M" + d.data.join(",") + "Z";
                          })
                          .attr("id", function(d,i) {
                              return "nv-path-"+i; })
                          .attr("clip-path", function(d,i) { return "url(#nv-clip-"+id+"-"+i+")"; })
                          ;

                      // good for debugging point hover issues
                      if (showVoronoi) {
                          vPointPaths.style("fill", d3.rgb(230, 230, 230))
                              .style('fill-opacity', 0.4)
                              .style('stroke-opacity', 1)
                              .style("stroke", d3.rgb(200,200,200));
                      }

                      if (clipVoronoi) {
                          // voronoi sections are already set to clip,
                          // just create the circles with the IDs they expect
                          wrap.select('.nv-point-clips').selectAll('*').remove(); // must do * since it has sub-dom
                          var pointClips = wrap.select('.nv-point-clips').selectAll('clipPath').data(vertices);
                          var vPointClips = pointClips
                              .enter().append("svg:clipPath")
                              .attr("id", function(d, i) { return "nv-clip-"+id+"-"+i;})
                              .append("svg:circle")
                              .attr('cx', function(d) { return d[0]; })
                              .attr('cy', function(d) { return d[1]; })
                              .attr('r', clipRadius);
                      }

                      var mouseEventCallback = function(el, d, mDispatch) {
                          if (needsUpdate) return 0;
                          var series = data[d.series];
                          if (series === undefined) return;
                          var point  = series.values[d.point];
                          point['color'] = color(series, d.series);

                          // standardize attributes for tooltip.
                          point['x'] = getX(point);
                          point['y'] = getY(point);

                          // can't just get box of event node since it's actually a voronoi polygon
                          var box = container.node().getBoundingClientRect();
                          var scrollTop  = window.pageYOffset || document.documentElement.scrollTop;
                          var scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;

                          var pos = {
                              left: x(getX(point, d.point)) + box.left + scrollLeft + margin.left + 10,
                              top: y(getY(point, d.point)) + box.top + scrollTop + margin.top + 10
                          };

                          mDispatch({
                              point: point,
                              series: series,
                              pos: pos,
                              relativePos: [x(getX(point, d.point)) + margin.left, y(getY(point, d.point)) + margin.top],
                              seriesIndex: d.series,
                              pointIndex: d.point,
                              event: d3.event,
                              element: el
                          });
                      };

                      pointPaths
                          .on('click', function(d) {
                              mouseEventCallback(this, d, dispatch.elementClick);
                          })
                          .on('dblclick', function(d) {
                              mouseEventCallback(this, d, dispatch.elementDblClick);
                          })
                          .on('mouseover', function(d) {
                              mouseEventCallback(this, d, dispatch.elementMouseover);
                          })
                          .on('mouseout', function(d, i) {
                              mouseEventCallback(this, d, dispatch.elementMouseout);
                          });

                  } else {
                      // add event handlers to points instead voronoi paths
                      wrap.select('.nv-groups').selectAll('.nv-group')
                          .selectAll('.nv-point')
                          //.data(dataWithPoints)
                          //.style('pointer-events', 'auto') // recativate events, disabled by css
                          .on('click', function(d,i) {
                              //nv.log('test', d, i);
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];
                              var element = this;
                              dispatch.elementClick({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top], //TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i,
                                  event: d3.event,
                                  element: element
                              });
                          })
                          .on('dblclick', function(d,i) {
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];

                              dispatch.elementDblClick({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],//TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i
                              });
                          })
                          .on('mouseover', function(d,i) {
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];

                              dispatch.elementMouseover({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],//TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i,
                                  color: color(d, i)
                              });
                          })
                          .on('mouseout', function(d,i) {
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];

                              dispatch.elementMouseout({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],//TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i,
                                  color: color(d, i)
                              });
                          });
                  }
              }

              needsUpdate = true;
              var groups = wrap.select('.nv-groups').selectAll('.nv-group')
                  .data(function(d) { return d }, function(d) { return d.key });
              groups.enter().append('g')
                  .style('stroke-opacity', 1e-6)
                  .style('fill-opacity', 1e-6);
              groups.exit()
                  .remove();
              groups
                  .attr('class', function(d,i) {
                      return (d.classed || '') + ' nv-group nv-series-' + i;
                  })
                  .classed('nv-noninteractive', !interactive)
                  .classed('hover', function(d) { return d.hover });
              groups.watchTransition(renderWatch, 'scatter: groups')
                  .style('fill', function(d,i) { return color(d, i) })
                  .style('stroke', function(d,i) { return d.pointBorderColor || pointBorderColor || color(d, i) })
                  .style('stroke-opacity', 1)
                  .style('fill-opacity', .5);
                  groups.exit().selectAll('path.nv-point')
                      .watchTransition(renderWatch, 'scatter exit')
                      .attr('transform', function(d) {
                          return 'translate(' + nv.utils.NaNtoZero(x(getX(d[0],d[1]))) + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')'
                      })
                      .remove();

              // create the points, maintaining their IDs from the original data set
              var points = groups.selectAll('g.nv-point')
                  .data(function(d) {
                      return d.values.map(
                          function (point, pointIndex) {
                              point.shape = d.pointShape;
                              return [point, pointIndex ]
                          }).filter(
                              function(pointArray, pointIndex) {
                                  return pointActive(pointArray[0], pointIndex)
                              })
                      });
              var pointsEnter = points.enter().append('g')
                  .attr('class', function (d) {
                      return 'nv-point nv-point-' + d[1] + ' hover';
                  })
                  .style('fill', function (d) { return d.color })
                  .style('stroke', function (d) { return d.color })
                  .attr('transform', function(d) {
                      return 'translate(' + nv.utils.NaNtoZero(x0(getX(d[0],d[1]))) + ',' + nv.utils.NaNtoZero(y0(getY(d[0],d[1]))) + ')'
                  });
              pointsEnter.append('path')
                  .attr('d',
                      nv.utils.symbol()
                      .type(function(d) { return getShape(d[0]); })
                      .size(function(d) { return z(getSize(d[0],d[1])) })
                  )
                  ;
              if( pointsShowY ) pointsEnter.append('text')
                  .attr('text-anchor', 'middle')
                  .text(function(d,i) { return valueFormat(d[0].y) })
                  .attr('transform', function(d) {
                      return 'translate(' + pointsOffset.x + ',' + ( pointsOffset.y + -10 ) + ')'
                  })
                  ;
              if( pointsShowKey ) pointsEnter.append('text')
                  .attr('text-anchor', 'middle')
                  .text(function(d,i) { return d[0].key })
                  .attr('transform', function(d) {
                      return 'translate(' + pointsOffset.x + ',' + ( pointsOffset.y + 4 ) + ')'
                  })
                  ;
              if( pointsShowP ) pointsEnter.append('text')
                  .attr('text-anchor', 'middle')
                  .text(function(d,i) { return '(' + d3.format(',.1f')( d[0].p ) + '%)' })
                  .attr('transform', function(d) {
                      return 'translate(' + pointsOffset.x + ',' + ( pointsOffset.y + 4 ) + ')'
                  })
                  ;
              points.exit().each(delCache).remove();
              // Update points position only if "x" or "y" have changed

              points.filter(function (d) { return scaleDiff || sizeDiff || domainDiff || getDiffs(d, 'x', getX, 'y', getY); })
                  .watchTransition(renderWatch, 'scatter points')
                  .attr('transform', function(d, i, j) {
                      //nv.log(d, getX(d[0],d[1]), x(getX(d[0],d[1])));
                      if( i == 0 && j == 0 ) positionArr = [];
                      positionArr.push( [ nv.utils.NaNtoZero(x(getX(d[0],d[1]))) + margin.left, nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + margin.top ] );
                      return 'translate(' + nv.utils.NaNtoZero(x(getX(d[0],d[1]))) + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')'
                  });

              // add label a label to scatter chart
              if(showLabels) {
                  var titles =  groups.selectAll('.nv-label')
                      .data(function(d) {
                          return d.values.map(
                              function (point, pointIndex) {
                                  return [point, pointIndex]
                              }).filter(
                                  function(pointArray, pointIndex) {
                                      return pointActive(pointArray[0], pointIndex)
                                  })
                          });

                  titles.enter().append('text')
                      .style('fill', function (d,i) {
                          return d.color })
                      .style('stroke-opacity', 0)
                      .style('fill-opacity', 1)
                      .attr('transform', function(d) {
                          var dx = nv.utils.NaNtoZero(x0(getX(d[0],d[1]))) + Math.sqrt(z(getSize(d[0],d[1]))/Math.PI) + 2;
                          return 'translate(' + dx + ',' + nv.utils.NaNtoZero(y0(getY(d[0],d[1]))) + ')';
                      })
                      .text(function(d,i){
                          return d[0].label;});

                  titles.exit().remove();
                  groups.exit().selectAll('path.nv-label')
                      .watchTransition(renderWatch, 'scatter exit')
                      .attr('transform', function(d) {
                          var dx = nv.utils.NaNtoZero(x(getX(d[0],d[1])))+ Math.sqrt(z(getSize(d[0],d[1]))/Math.PI)+2;
                          return 'translate(' + dx + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')';
                      })
                      .remove();
                 titles.each(function(d) {
                    d3.select(this)
                      .classed('nv-label', true)
                      .classed('nv-label-' + d[1], false)
                      .classed('hover',false);
                  });
                  titles.watchTransition(renderWatch, 'scatter labels')
                      .attr('transform', function(d) {
                          var dx = nv.utils.NaNtoZero(x(getX(d[0],d[1])))+ Math.sqrt(z(getSize(d[0],d[1]))/Math.PI)+2;
                          return 'translate(' + dx + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')'
                      });
              }

              // Delay updating the invisible interactive layer for smoother animation
              if( interactiveUpdateDelay ) {
                  clearTimeout(timeoutID); // stop repeat calls to updateInteractiveLayer
                  timeoutID = setTimeout(updateInteractiveLayer, interactiveUpdateDelay );
              } else {
                  updateInteractiveLayer();
              }

              //store old scales for use in transitions on update
              x0 = x.copy();
              y0 = y.copy();
              z0 = z.copy();

              width0 = width;
              height0 = height;

          });
          renderWatch.renderEnd('scatter immediate');
          return chart;
      }

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.options = nv.utils.optionsFunc.bind(chart);

      // utility function calls provided by this chart
      chart._calls = new function() {
          this.clearHighlights = function () {
              // nv.dom.write(function() {
              //     container.selectAll(".nv-point.hover").classed("hover", false);
              // });
              // return null;
          };
          this.highlightPoint = function (seriesIndex, pointIndex, isHoverOver) {
              // nv.dom.write(function() {
              //     container.select('.nv-groups')
              //       .selectAll(".nv-series-" + seriesIndex)
              //       .selectAll(".nv-point-" + pointIndex)
              //       .classed("hover", isHoverOver);
              // });
          };
      };

      // trigger calls from events too
      dispatch.on('elementMouseover.point', function(d) {
          if (interactive) chart._calls.highlightPoint(d.seriesIndex,d.pointIndex,true);
      });

      dispatch.on('elementMouseout.point', function(d) {
          if (interactive) chart._calls.highlightPoint(d.seriesIndex,d.pointIndex,false);
      });

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          positionArr:        {get: function(){return positionArr;}},
          width:        {get: function(){return width;}, set: function(_){width=_;}},
          height:       {get: function(){return height;}, set: function(_){height=_;}},
          xScale:       {get: function(){return x;}, set: function(_){x=_;}},
          yScale:       {get: function(){return y;}, set: function(_){y=_;}},
          pointScale:   {get: function(){return z;}, set: function(_){z=_;}},
          xDomain:      {get: function(){return xDomain;}, set: function(_){xDomain=_;}},
          yDomain:      {get: function(){return yDomain;}, set: function(_){yDomain=_;}},
          pointDomain:  {get: function(){return sizeDomain;}, set: function(_){sizeDomain=_;}},
          xRange:       {get: function(){return xRange;}, set: function(_){xRange=_;}},
          yRange:       {get: function(){return yRange;}, set: function(_){yRange=_;}},
          pointRange:   {get: function(){return sizeRange;}, set: function(_){sizeRange=_;}},
          forceX:       {get: function(){return forceX;}, set: function(_){forceX=_;}},
          forceY:       {get: function(){return forceY;}, set: function(_){forceY=_;}},
          forcePoint:   {get: function(){return forceSize;}, set: function(_){forceSize=_;}},
          interactive:  {get: function(){return interactive;}, set: function(_){interactive=_;}},
          pointActive:  {get: function(){return pointActive;}, set: function(_){pointActive=_;}},
          padDataOuter: {get: function(){return padDataOuter;}, set: function(_){padDataOuter=_;}},
          padData:      {get: function(){return padData;}, set: function(_){padData=_;}},
          clipEdge:     {get: function(){return clipEdge;}, set: function(_){clipEdge=_;}},
          clipVoronoi:  {get: function(){return clipVoronoi;}, set: function(_){clipVoronoi=_;}},
          clipRadius:   {get: function(){return clipRadius;}, set: function(_){clipRadius=_;}},
          showVoronoi:   {get: function(){return showVoronoi;}, set: function(_){showVoronoi=_;}},
          id:           {get: function(){return id;}, set: function(_){id=_;}},
          interactiveUpdateDelay: {get:function(){return interactiveUpdateDelay;}, set: function(_){interactiveUpdateDelay=_;}},
          showLabels: {get: function(){return showLabels;}, set: function(_){ showLabels = _;}},
          pointsShowY: {get: function(){return pointsShowY;}, set: function(_){ pointsShowY = _;}},
          pointsShowKey: {get: function(){return pointsShowKey;}, set: function(_){ pointsShowKey = _;}},
          pointsShowP: {get: function(){return pointsShowP;}, set: function(_){ pointsShowP = _;}},
          pointsOffset: {get: function(){return pointsOffset;}, set: function(_){ pointsOffset.x = _.x || 0; pointsOffset.y = _.y || 0; }},
          pointBorderColor: {get: function(){return pointBorderColor;}, set: function(_){pointBorderColor=_;}},

          // simple functor options
          x:     {get: function(){return getX;}, set: function(_){getX = d3.functor(_);}},
          y:     {get: function(){return getY;}, set: function(_){getY = d3.functor(_);}},
          pointSize: {get: function(){return getSize;}, set: function(_){getSize = d3.functor(_);}},
          pointShape: {get: function(){return getShape;}, set: function(_){getShape = d3.functor(_);}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
          }},
          color: {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }},
          useVoronoi: {get: function(){return useVoronoi;}, set: function(_){
              useVoronoi = _;
              if (useVoronoi === false) {
                  clipVoronoi = false;
              }
          }},
          valueFormat:    {get: function(){return valueFormat;}, set: function(_){
            valueFormat = _;
          }}
      });

      nv.utils.initOptions(chart);
      return chart;
  };

  nv.models.scatter3 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var positionArr;

      var margin       = {top: 0, right: 0, bottom: 0, left: 0}
          , width        = null
          , height       = null
          , color        = nv.utils.defaultColor() // chooses color
          , pointBorderColor = null
          , id           = Math.floor(Math.random() * 100000) //Create semi-unique ID incase user doesn't select one
          , container    = null
          , x            = d3.scale.ordinal()
          , y            = d3.scale.linear()
          , z            = d3.scale.linear() //linear because d3.svg.shape.size is treated as area
          , getX         = function(d) { return d.x } // accessor to get the x value
          , getY         = function(d) { return d.y } // accessor to get the y value
          , getSize      = function(d) { return d.size || 1} // accessor to get the point size
          , getShape     = function(d) { return d.shape || 'circle' } // accessor to get point shape
          , forceX       = [] // List of numbers to Force into the X scale (ie. 0, or a max / min, etc.)
          , forceY       = [] // List of numbers to Force into the Y scale
          , forceSize    = [] // List of numbers to Force into the Size scale
          , interactive  = true // If true, plots a voronoi overlay for advanced point intersection
          , pointActive  = function(d) { return !d.notActive } // any points that return false will be filtered out
          , padData      = false // If true, adds half a data points width to front and back, for lining up a line chart with a bar chart
          , padDataOuter = .1 //outerPadding to imitate ordinal scale outer padding
          , clipEdge     = false // if true, masks points within x and y scale
          , clipVoronoi  = true // if true, masks each point with a circle... can turn off to slightly increase performance
          , showVoronoi  = false // display the voronoi areas
          , clipRadius   = function() { return 25 } // function to get the radius for voronoi point clips
          , xDomain      = null // Override x domain (skips the calculation from data)
          , yDomain      = null // Override y domain
          , xRange       = null // Override x range
          , yRange       = null // Override y range
          , sizeDomain   = null // Override point size domain
          , sizeRange    = null
          , singlePoint  = false
          , dispatch     = d3.dispatch('elementClick', 'elementDblClick', 'elementMouseover', 'elementMouseout', 'renderEnd')
          , useVoronoi   = true
          , duration     = 250
          , interactiveUpdateDelay = 300
          , showLabels    = false
          , pointsShowY    = true
          , pointsShowKey    = false
          , pointsShowP    = false
          , pointsOffset    = { x:0, y:0 }
          , valueFormat = d3.format('.02f')
          ;


      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x0, y0, z0 // used to store previous scales
          , xDom, yDom // used to store previous domains
          , width0
          , height0
          , timeoutID
          , needsUpdate = false // Flag for when the points are visually updating, but the interactive layer is behind, to disable tooltips
          , renderWatch = nv.utils.renderWatch(dispatch, duration)
          , _sizeRange_def = [16, 256]
          , _cache = {}
          ;

      function getCache(d) {
          var key, val;
          key = d[0].series + ':' + d[1];
          val = _cache[key] = _cache[key] || {};
          return val;
      }

      function delCache(d) {
          var key, val;
          key = d[0].series + ':' + d[1];
          delete _cache[key];
      }

      function getDiffs(d) {
          var i, key, val,
              cache = getCache(d),
              diffs = false;
          for (i = 1; i < arguments.length; i += 2) {
              key = arguments[i];
              val = arguments[i + 1](d[0], d[1]);
              if (cache[key] !== val || !cache.hasOwnProperty(key)) {
                  cache[key] = val;
                  diffs = true;
              }
          }
          return diffs;
      }

      function chart(selection) {
          renderWatch.reset();
          selection.each(function(data) {
              container = d3.select(this);
              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);

              nv.utils.initSVG(container);

              //add series index to each data point for reference
              data.forEach(function(series, i) {
                var key = series.key;
                  series.values.forEach(function(point) {
                      point.series = i;
                      if( key !== undefined ) point.key = key;
                  });
              });

              // Setup Scales
              var logScale = chart.yScale().name === d3.scale.log().name ? true : false;
              // remap and flatten the data for use in calculating the scales' domains
              var seriesData = (xDomain && yDomain && sizeDomain) ? [] : // if we know xDomain and yDomain and sizeDomain, no need to calculate.... if Size is constant remember to set sizeDomain to speed up performance
                  d3.merge(
                      data.map(function(d) {
                          return d.values.map(function(d,i) {
                              return { x: getX(d,i), y: getY(d,i), size: getSize(d,i) }
                          })
                      })
                  );

              // x   .domain(xDomain || d3.extent(seriesData.map(function(d) { return d.x; }).concat(forceX)))
              x.domain(xDomain || seriesData.map(function(d) { return d.x }))
                  .rangeBands(xRange || [0, availableWidth]);

              x.rangeBands(xRange || [x.rangeBand() / 2, availableWidth + x.rangeBand() / 2]);

              // if (padData && data[0])
              //     x.rangeBands(xRange || [(availableWidth * padDataOuter +  availableWidth) / (2 *data[0].values.length), availableWidth - availableWidth * (1 + padDataOuter) / (2 * data[0].values.length)  ]);
              // //x.range([availableWidth * .5 / data[0].values.length, availableWidth * (data[0].values.length - .5)  / data[0].values.length ]);
              // else
              //     x.rangeBands(xRange || [0, availableWidth]);

              if (logScale) {
                      var min = d3.min(seriesData.map(function(d) { if (d.y !== 0) return d.y; }));
                      y.clamp(true)
                          .domain(yDomain || d3.extent(seriesData.map(function(d) {
                              if (d.y !== 0) return d.y;
                              else return min * 0.1;
                          }).concat(forceY)))
                          // .range(yRange || [availableHeight, 0]);
              } else {
                      y.domain(yDomain || d3.extent(seriesData.map(function (d) { return d.y;}).concat(forceY)))
              }
              if (padData && data[0])
                  y.range(yRange || [availableHeight - availableHeight * (1 + padDataOuter) / (2 * data[0].values.length), (availableHeight * padDataOuter +  availableHeight) / (2 *data[0].values.length)]);
              else
                  y.range(yRange || [availableHeight, 0]);

              z   .domain(sizeDomain || d3.extent(seriesData.map(function(d) { return d.size }).concat(forceSize)))
                  .range(sizeRange || _sizeRange_def);

              // If scale's domain don't have a range, slightly adjust to make one... so a chart can show a single data point
              singlePoint = x.domain()[0] === x.domain()[1] || y.domain()[0] === y.domain()[1];

              if (x.domain()[0] === x.domain()[1])
                  x.domain()[0] ?
                      x.domain([x.domain()[0] - x.domain()[0] * 0.01, x.domain()[1] + x.domain()[1] * 0.01])
                      : x.domain([-1,1]);

              if (y.domain()[0] === y.domain()[1])
                  y.domain()[0] ?
                      y.domain([y.domain()[0] - y.domain()[0] * 0.01, y.domain()[1] + y.domain()[1] * 0.01])
                      : y.domain([-1,1]);

              // if ( isNaN(x.domain()[0])) {
              //     x.domain([-1,1]);
              // }

              if ( isNaN(y.domain()[0])) {
                  y.domain([-1,1]);
              }

              x0 = x0 || x;
              y0 = y0 || y;
              z0 = z0 || z;

              var scaleDiff = x(1) !== x0(1) || y(1) !== y0(1) || z(1) !== z0(1);

              width0 = width0 || width;
              height0 = height0 || height;

              var sizeDiff = width0 !== width || height0 !== height;

              // Domain Diffs

              xDom = xDom || [];
              var domainDiff = xDom[0] !== x.domain()[0] || xDom[1] !== x.domain()[1];
              xDom = x.domain();

              yDom = yDom || [];
              domainDiff = domainDiff || yDom[0] !== y.domain()[0] || yDom[1] !== y.domain()[1];
              yDom = y.domain();

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-scatter').data([data]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-scatter nv-chart-' + id);
              var defsEnter = wrapEnter.append('defs');
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              wrap.classed('nv-single-point', singlePoint);
              gEnter.append('g').attr('class', 'nv-groups');
              gEnter.append('g').attr('class', 'nv-point-paths');
              wrapEnter.append('g').attr('class', 'nv-point-clips');

              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              defsEnter.append('clipPath')
                  .attr('id', 'nv-edge-clip-' + id)
                  .append('rect')
                  .attr('transform', 'translate( -10, -10)');

              wrap.select('#nv-edge-clip-' + id + ' rect')
                  .attr('width', availableWidth + 20)
                  .attr('height', (availableHeight > 0) ? availableHeight + 20 : 0);

              g.attr('clip-path', clipEdge ? 'url(#nv-edge-clip-' + id + ')' : '');

              function updateInteractiveLayer() {
                  // Always clear needs-update flag regardless of whether or not
                  // we will actually do anything (avoids needless invocations).
                  needsUpdate = false;

                  if (!interactive) return false;

                  // inject series and point index for reference into voronoi
                  if (useVoronoi === true) {
                      var vertices = d3.merge(data.map(function(group, groupIndex) {
                              return group.values
                                  .map(function(point, pointIndex) {
                                      // *Adding noise to make duplicates very unlikely
                                      // *Injecting series and point index for reference
                                      /* *Adding a 'jitter' to the points, because there's an issue in d3.geom.voronoi.
                                       */
                                      var pX = getX(point,pointIndex);
                                      var pY = getY(point,pointIndex);

                                      return [nv.utils.NaNtoZero(x(pX))+ Math.random() * 1e-4,
                                              nv.utils.NaNtoZero(y(pY))+ Math.random() * 1e-4,
                                          groupIndex,
                                          pointIndex, point]; //temp hack to add noise until I think of a better way so there are no duplicates
                                  })
                                  .filter(function(pointArray, pointIndex) {
                                      return pointActive(pointArray[4], pointIndex); // Issue #237.. move filter to after map, so pointIndex is correct!
                                  })
                          })
                      );

                      if (vertices.length == 0) return false;  // No active points, we're done
                      if (vertices.length < 3) {
                          // Issue #283 - Adding 2 dummy points to the voronoi b/c voronoi requires min 3 points to work
                          vertices.push([x.range()[0] - 20, y.range()[0] - 20, null, null]);
                          vertices.push([x.range()[1] + 20, y.range()[1] + 20, null, null]);
                          vertices.push([x.range()[0] - 20, y.range()[0] + 20, null, null]);
                          vertices.push([x.range()[1] + 20, y.range()[1] - 20, null, null]);
                      }

                      // keep voronoi sections from going more than 10 outside of graph
                      // to avoid overlap with other things like legend etc
                      var bounds = d3.geom.polygon([
                          [-10,-10],
                          [-10,height + 10],
                          [width + 10,height + 10],
                          [width + 10,-10]
                      ]);

                      var voronoi = d3.geom.voronoi(vertices).map(function(d, i) {
                          return {
                              'data': bounds.clip(d),
                              'series': vertices[i][2],
                              'point': vertices[i][3]
                          }
                      });

                      // nuke all voronoi paths on reload and recreate them
                      wrap.select('.nv-point-paths').selectAll('path').remove();
                      var pointPaths = wrap.select('.nv-point-paths').selectAll('path').data(voronoi);
                      var vPointPaths = pointPaths
                          .enter().append("svg:path")
                          .attr("d", function(d) {
                              if (!d || !d.data || d.data.length === 0)
                                  return 'M 0 0';
                              else
                                  return "M" + d.data.join(",") + "Z";
                          })
                          .attr("id", function(d,i) {
                              return "nv-path-"+i; })
                          .attr("clip-path", function(d,i) { return "url(#nv-clip-"+id+"-"+i+")"; })
                          ;

                      // good for debugging point hover issues
                      if (showVoronoi) {
                          vPointPaths.style("fill", d3.rgb(230, 230, 230))
                              .style('fill-opacity', 0.4)
                              .style('stroke-opacity', 1)
                              .style("stroke", d3.rgb(200,200,200));
                      }

                      if (clipVoronoi) {
                          // voronoi sections are already set to clip,
                          // just create the circles with the IDs they expect
                          wrap.select('.nv-point-clips').selectAll('*').remove(); // must do * since it has sub-dom
                          var pointClips = wrap.select('.nv-point-clips').selectAll('clipPath').data(vertices);
                          var vPointClips = pointClips
                              .enter().append("svg:clipPath")
                              .attr("id", function(d, i) { return "nv-clip-"+id+"-"+i;})
                              .append("svg:circle")
                              .attr('cx', function(d) { return d[0]; })
                              .attr('cy', function(d) { return d[1]; })
                              .attr('r', clipRadius);
                      }

                      var mouseEventCallback = function(el, d, mDispatch) {
                          if (needsUpdate) return 0;
                          var series = data[d.series];
                          if (series === undefined) return;
                          var point  = series.values[d.point];
                          point['color'] = color(series, d.series);

                          // standardize attributes for tooltip.
                          point['x'] = getX(point);
                          point['y'] = getY(point);

                          // can't just get box of event node since it's actually a voronoi polygon
                          var box = container.node().getBoundingClientRect();
                          var scrollTop  = window.pageYOffset || document.documentElement.scrollTop;
                          var scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;

                          var pos = {
                              left: x(getX(point, d.point)) + box.left + scrollLeft + margin.left + 10,
                              top: y(getY(point, d.point)) + box.top + scrollTop + margin.top + 10
                          };

                          mDispatch({
                              point: point,
                              series: series,
                              pos: pos,
                              relativePos: [x(getX(point, d.point)) + margin.left, y(getY(point, d.point)) + margin.top],
                              seriesIndex: d.series,
                              pointIndex: d.point,
                              event: d3.event,
                              element: el
                          });
                      };

                      pointPaths
                          .on('click', function(d) {
                              mouseEventCallback(this, d, dispatch.elementClick);
                          })
                          .on('dblclick', function(d) {
                              mouseEventCallback(this, d, dispatch.elementDblClick);
                          })
                          .on('mouseover', function(d) {
                              mouseEventCallback(this, d, dispatch.elementMouseover);
                          })
                          .on('mouseout', function(d, i) {
                              mouseEventCallback(this, d, dispatch.elementMouseout);
                          });

                  } else {
                      // add event handlers to points instead voronoi paths
                      wrap.select('.nv-groups').selectAll('.nv-group')
                          .selectAll('.nv-point')
                          //.data(dataWithPoints)
                          //.style('pointer-events', 'auto') // recativate events, disabled by css
                          .on('click', function(d,i) {
                              //nv.log('test', d, i);
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];
                              var element = this;
                              dispatch.elementClick({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top], //TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i,
                                  event: d3.event,
                                  element: element
                              });
                          })
                          .on('dblclick', function(d,i) {
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];

                              dispatch.elementDblClick({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],//TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i
                              });
                          })
                          .on('mouseover', function(d,i) {
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];

                              dispatch.elementMouseover({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],//TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i,
                                  color: color(d, i)
                              });
                          })
                          .on('mouseout', function(d,i) {
                              if (needsUpdate || !data[d.series]) return 0; //check if this is a dummy point
                              var series = data[d.series],
                                  point  = series.values[i];

                              dispatch.elementMouseout({
                                  point: point,
                                  series: series,
                                  pos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],//TODO: make this pos base on the page
                                  relativePos: [x(getX(point, i)) + margin.left, y(getY(point, i)) + margin.top],
                                  seriesIndex: d.series,
                                  pointIndex: i,
                                  color: color(d, i)
                              });
                          });
                  }
              }

              needsUpdate = true;
              var groups = wrap.select('.nv-groups').selectAll('.nv-group')
                  .data(function(d) { return d }, function(d) { return d.key });
              groups.enter().append('g')
                  .style('stroke-opacity', 1e-6)
                  .style('fill-opacity', 1e-6);
              groups.exit()
                  .remove();
              groups
                  .attr('class', function(d,i) {
                      return (d.classed || '') + ' nv-group nv-series-' + i;
                  })
                  .classed('nv-noninteractive', !interactive)
                  .classed('hover', function(d) { return d.hover });
              groups.watchTransition(renderWatch, 'scatter: groups')
                  .style('fill', function(d,i) { return color(d, i) })
                  .style('stroke', function(d,i) { return d.pointBorderColor || pointBorderColor || color(d, i) })
                  .style('stroke-opacity', 1)
                  .style('fill-opacity', .5);
                  groups.exit().selectAll('path.nv-point')
                      .watchTransition(renderWatch, 'scatter exit')
                      .attr('transform', function(d) {
                          return 'translate(' + nv.utils.NaNtoZero(x(getX(d[0],d[1]))) + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')'
                      })
                      .remove();

              // create the points, maintaining their IDs from the original data set
              var points = groups.selectAll('g.nv-point')
                  .data(function(d) {
                      return d.values.map(
                          function (point, pointIndex) {
                              point.shape = d.pointShape;
                              return [point, pointIndex ]
                          }).filter(
                              function(pointArray, pointIndex) {
                                  return pointActive(pointArray[0], pointIndex)
                              })
                      });
              var pointsEnter = points.enter().append('g')
                  .attr('class', function (d) {
                      return 'nv-point nv-point-' + d[1] + ' hover';
                  })
                  .style('fill', function (d) { return d.color })
                  .style('stroke', function (d) { return d.color })
                  .attr('transform', function(d) {
                      return 'translate(' + nv.utils.NaNtoZero(x0(getX(d[0],d[1]))) + ',' + nv.utils.NaNtoZero(y0(getY(d[0],d[1]))) + ')'
                  });
              pointsEnter.append('path')
                  .attr('d',
                      nv.utils.symbol()
                      .type(function(d) { return getShape(d[0]); })
                      .size(function(d) { return z(getSize(d[0],d[1])) })
                  )
                  ;
              if( pointsShowY ) pointsEnter.append('text')
                  .attr('text-anchor', 'middle')
                  .text(function(d,i) { return valueFormat(d[0].y) + ( d[0].p != undefined ? ' (' + d3.format(',.1f')( d[0].p ) + '%)' : '' ) })
                  .attr('transform', function(d) {
                      return 'translate(' + pointsOffset.x + ',' + ( pointsOffset.y + -8 ) + ')'
                  })
                  ;
              if( pointsShowKey ) pointsEnter.append('text')
                  .attr('text-anchor', 'middle')
                  .text(function(d,i) { return d[0].key })
                  .attr('transform', function(d) {
                      return 'translate(' + pointsOffset.x + ',' + ( pointsOffset.y + 2 ) + ')'
                  })
                  ;
              if( pointsShowP ) pointsEnter.append('text')
                  .attr('text-anchor', 'middle')
                  .text(function(d,i) { return d[0].p ?  '(' + d[0].p + '%)' : '' })
                  .attr('transform', function(d) {
                      return 'translate(' + pointsOffset.x + ',' + ( pointsOffset.y - 20 ) + ')'
                  })
                  ;
              points.exit().each(delCache).remove();
              // Update points position only if "x" or "y" have changed

              points.filter(function (d) { return scaleDiff || sizeDiff || domainDiff || getDiffs(d, 'x', getX, 'y', getY); })
                  .watchTransition(renderWatch, 'scatter points')
                  .attr('transform', function(d, i, j) {
                      //nv.log(d, getX(d[0],d[1]), x(getX(d[0],d[1])));
                      if( i == 0 && j == 0 ) positionArr = [];
                      positionArr.push( [ nv.utils.NaNtoZero(x(getX(d[0],d[1]))) + margin.left, nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + margin.top ] );
                      return 'translate(' + nv.utils.NaNtoZero(x(getX(d[0],d[1]))) + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')'
                  });

              // add label a label to scatter chart
              if(showLabels) {
                  var titles =  groups.selectAll('.nv-label')
                      .data(function(d) {
                          return d.values.map(
                              function (point, pointIndex) {
                                  return [point, pointIndex]
                              }).filter(
                                  function(pointArray, pointIndex) {
                                      return pointActive(pointArray[0], pointIndex)
                                  })
                          });

                  titles.enter().append('text')
                      .style('fill', function (d,i) {
                          return d.color })
                      .style('stroke-opacity', 0)
                      .style('fill-opacity', 1)
                      .attr('transform', function(d) {
                          var dx = nv.utils.NaNtoZero(x0(getX(d[0],d[1]))) + Math.sqrt(z(getSize(d[0],d[1]))/Math.PI) + 2;
                          return 'translate(' + dx + ',' + nv.utils.NaNtoZero(y0(getY(d[0],d[1]))) + ')';
                      })
                      .text(function(d,i){
                          return d[0].label;});

                  titles.exit().remove();
                  groups.exit().selectAll('path.nv-label')
                      .watchTransition(renderWatch, 'scatter exit')
                      .attr('transform', function(d) {
                          var dx = nv.utils.NaNtoZero(x(getX(d[0],d[1])))+ Math.sqrt(z(getSize(d[0],d[1]))/Math.PI)+2;
                          return 'translate(' + dx + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')';
                      })
                      .remove();
                 titles.each(function(d) {
                    d3.select(this)
                      .classed('nv-label', true)
                      .classed('nv-label-' + d[1], false)
                      .classed('hover',false);
                  });
                  titles.watchTransition(renderWatch, 'scatter labels')
                      .attr('transform', function(d) {
                          var dx = nv.utils.NaNtoZero(x(getX(d[0],d[1])))+ Math.sqrt(z(getSize(d[0],d[1]))/Math.PI)+2;
                          return 'translate(' + dx + ',' + nv.utils.NaNtoZero(y(getY(d[0],d[1]))) + ')'
                      });
              }

              // Delay updating the invisible interactive layer for smoother animation
              if( interactiveUpdateDelay ) {
                  clearTimeout(timeoutID); // stop repeat calls to updateInteractiveLayer
                  timeoutID = setTimeout(updateInteractiveLayer, interactiveUpdateDelay );
              } else {
                  updateInteractiveLayer();
              }

              //store old scales for use in transitions on update
              x0 = x.copy();
              y0 = y.copy();
              z0 = z.copy();

              width0 = width;
              height0 = height;

          });
          renderWatch.renderEnd('scatter immediate');
          return chart;
      }

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      chart.dispatch = dispatch;
      chart.options = nv.utils.optionsFunc.bind(chart);

      // utility function calls provided by this chart
      chart._calls = new function() {
          this.clearHighlights = function () {
              // nv.dom.write(function() {
              //     container.selectAll(".nv-point.hover").classed("hover", false);
              // });
              // return null;
          };
          this.highlightPoint = function (seriesIndex, pointIndex, isHoverOver) {
              // nv.dom.write(function() {
              //     container.select('.nv-groups')
              //       .selectAll(".nv-series-" + seriesIndex)
              //       .selectAll(".nv-point-" + pointIndex)
              //       .classed("hover", isHoverOver);
              // });
          };
      };

      // trigger calls from events too
      dispatch.on('elementMouseover.point', function(d) {
          if (interactive) chart._calls.highlightPoint(d.seriesIndex,d.pointIndex,true);
      });

      dispatch.on('elementMouseout.point', function(d) {
          if (interactive) chart._calls.highlightPoint(d.seriesIndex,d.pointIndex,false);
      });

      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          positionArr:        {get: function(){return positionArr;}},
          width:        {get: function(){return width;}, set: function(_){width=_;}},
          height:       {get: function(){return height;}, set: function(_){height=_;}},
          xScale:       {get: function(){return x;}, set: function(_){x=_;}},
          yScale:       {get: function(){return y;}, set: function(_){y=_;}},
          pointScale:   {get: function(){return z;}, set: function(_){z=_;}},
          xDomain:      {get: function(){return xDomain;}, set: function(_){xDomain=_;}},
          yDomain:      {get: function(){return yDomain;}, set: function(_){yDomain=_;}},
          pointDomain:  {get: function(){return sizeDomain;}, set: function(_){sizeDomain=_;}},
          xRange:       {get: function(){return xRange;}, set: function(_){xRange=_;}},
          yRange:       {get: function(){return yRange;}, set: function(_){yRange=_;}},
          pointRange:   {get: function(){return sizeRange;}, set: function(_){sizeRange=_;}},
          forceX:       {get: function(){return forceX;}, set: function(_){forceX=_;}},
          forceY:       {get: function(){return forceY;}, set: function(_){forceY=_;}},
          forcePoint:   {get: function(){return forceSize;}, set: function(_){forceSize=_;}},
          interactive:  {get: function(){return interactive;}, set: function(_){interactive=_;}},
          pointActive:  {get: function(){return pointActive;}, set: function(_){pointActive=_;}},
          padDataOuter: {get: function(){return padDataOuter;}, set: function(_){padDataOuter=_;}},
          padData:      {get: function(){return padData;}, set: function(_){padData=_;}},
          clipEdge:     {get: function(){return clipEdge;}, set: function(_){clipEdge=_;}},
          clipVoronoi:  {get: function(){return clipVoronoi;}, set: function(_){clipVoronoi=_;}},
          clipRadius:   {get: function(){return clipRadius;}, set: function(_){clipRadius=_;}},
          showVoronoi:   {get: function(){return showVoronoi;}, set: function(_){showVoronoi=_;}},
          id:           {get: function(){return id;}, set: function(_){id=_;}},
          interactiveUpdateDelay: {get:function(){return interactiveUpdateDelay;}, set: function(_){interactiveUpdateDelay=_;}},
          showLabels: {get: function(){return showLabels;}, set: function(_){ showLabels = _;}},
          pointsShowY: {get: function(){return pointsShowY;}, set: function(_){ pointsShowY = _;}},
          pointsShowKey: {get: function(){return pointsShowKey;}, set: function(_){ pointsShowKey = _;}},
          pointsShowP: {get: function(){return pointsShowP;}, set: function(_){ pointsShowP = _;}},
          pointsOffset: {get: function(){return pointsOffset;}, set: function(_){ pointsOffset.x = _.x || 0; pointsOffset.y = _.y || 0; }},
          pointBorderColor: {get: function(){return pointBorderColor;}, set: function(_){pointBorderColor=_;}},

          // simple functor options
          x:     {get: function(){return getX;}, set: function(_){getX = d3.functor(_);}},
          y:     {get: function(){return getY;}, set: function(_){getY = d3.functor(_);}},
          pointSize: {get: function(){return getSize;}, set: function(_){getSize = d3.functor(_);}},
          pointShape: {get: function(){return getShape;}, set: function(_){getShape = d3.functor(_);}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              margin.top    = _.top    !== undefined ? _.top    : margin.top;
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          duration: {get: function(){return duration;}, set: function(_){
              duration = _;
              renderWatch.reset(duration);
          }},
          color: {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
          }},
          useVoronoi: {get: function(){return useVoronoi;}, set: function(_){
              useVoronoi = _;
              if (useVoronoi === false) {
                  clipVoronoi = false;
              }
          }},
          valueFormat:    {get: function(){return valueFormat;}, set: function(_){
            valueFormat = _;
          }}
      });

      nv.utils.initOptions(chart);
      return chart;
  };

  nv.models.scatterChart2 = function() {
      "use strict";

      //============================================================
      // Public Variables with Default Settings
      //------------------------------------------------------------

      var scatter      = nv.models.scatter2()
          , xAxis        = nv.models.axis()
          , yAxis        = nv.models.axis()
          , legend       = nv.models.legend()
          , distX        = nv.models.distribution()
          , distY        = nv.models.distribution()
          , tooltip      = nv.models.tooltip()
          ;

      var margin       = {top: 30, right: 20, bottom: 50, left: 75}
          , marginTop = null
          , width        = null
          , height       = null
          , container    = null
          , color        = nv.utils.defaultColor()
          , x            = scatter.xScale()
          , y            = scatter.yScale()
          , showDistX    = false
          , showDistY    = false
          , showLegend   = true
          , showXAxis    = true
          , showYAxis    = true
          , rightAlignYAxis = false
          , state = nv.utils.state()
          , defaultState = null
          , dispatch = d3.dispatch('stateChange', 'changeState', 'renderEnd')
          , noData       = null
          , duration = 250
          , showLabels    = false
          ;

      scatter.xScale(x).yScale(y);
      scatter
          .pointSize(10) // default size
          .pointDomain([1,10]) //set to speed up calculation, needs to be unset if there is a custom size accessor
      xAxis
          .orient('bottom')
          .tickPadding(10)
      ;
      yAxis
          .orient((rightAlignYAxis) ? 'right' : 'left')
          .tickPadding(10)
      ;
      distX.axis('x');
      distY.axis('y');
      tooltip
          .headerFormatter(function(d, i) {
              return xAxis.tickFormat()(d, i);
          })
          .valueFormatter(function(d, i) {
              return yAxis.tickFormat()(d, i);
          });

      //============================================================
      // Private Variables
      //------------------------------------------------------------

      var x0, y0
          , renderWatch = nv.utils.renderWatch(dispatch, duration);

      var stateGetter = function(data) {
          return function(){
              return {
                  active: data.map(function(d) { return !d.disabled })
              };
          }
      };

      var stateSetter = function(data) {
          return function(state) {
              if (state.active !== undefined)
                  data.forEach(function(series,i) {
                      series.disabled = !state.active[i];
                  });
          }
      };

      function chart(selection) {
          renderWatch.reset();
          renderWatch.models(scatter);
          if (showXAxis) renderWatch.models(xAxis);
          if (showYAxis) renderWatch.models(yAxis);
          if (showDistX) renderWatch.models(distX);
          if (showDistY) renderWatch.models(distY);

          selection.each(function(data) {
              var that = this;

              container = d3.select(this);
              nv.utils.initSVG(container);

              var availableWidth = nv.utils.availableWidth(width, container, margin),
                  availableHeight = nv.utils.availableHeight(height, container, margin);

              chart.update = function() {
                  if (duration === 0)
                      container.call(chart);
                  else
                      container.transition().duration(duration).call(chart);
              };
              chart.container = this;

              state
                  .setter(stateSetter(data), chart.update)
                  .getter(stateGetter(data))
                  .update();

              // DEPRECATED set state.disableddisabled
              state.disabled = data.map(function(d) { return !!d.disabled });

              if (!defaultState) {
                  var key;
                  defaultState = {};
                  for (key in state) {
                      if (state[key] instanceof Array)
                          defaultState[key] = state[key].slice(0);
                      else
                          defaultState[key] = state[key];
                  }
              }

              // Display noData message if there's nothing to show.
              if (!data || !data.length || !data.filter(function(d) { return d.values.length }).length) {
                  nv.utils.noData(chart, container);
                  renderWatch.renderEnd('scatter immediate');
                  return chart;
              } else {
                  container.selectAll('.nv-noData').remove();
              }

              // Setup Scales
              x = scatter.xScale();
              y = scatter.yScale();

              // Setup containers and skeleton of chart
              var wrap = container.selectAll('g.nv-wrap.nv-scatterChart').data([data]);
              var wrapEnter = wrap.enter().append('g').attr('class', 'nvd3 nv-wrap nv-scatterChart nv-chart-' + scatter.id());
              var gEnter = wrapEnter.append('g');
              var g = wrap.select('g');

              // background for pointer events
              gEnter.append('rect').attr('class', 'nvd3 nv-background').style("pointer-events","none");

              gEnter.append('g').attr('class', 'nv-x nv-axis');
              gEnter.append('g').attr('class', 'nv-y nv-axis');
              gEnter.append('g').attr('class', 'nv-scatterWrap');
              gEnter.append('g').attr('class', 'nv-regressionLinesWrap');
              gEnter.append('g').attr('class', 'nv-distWrap');
              gEnter.append('g').attr('class', 'nv-legendWrap');

              if (rightAlignYAxis) {
                  g.select(".nv-y.nv-axis")
                      .attr("transform", "translate(" + availableWidth + ",0)");
              }

              // Legend
              if (!showLegend) {
                  g.select('.nv-legendWrap').selectAll('*').remove();
              } else {
                  var legendWidth = availableWidth;
                  legend.width(legendWidth);

                  wrap.select('.nv-legendWrap')
                      .datum(data)
                      .call(legend);

                  if (!marginTop && legend.height() !== margin.top) {
                      margin.top = legend.height();
                      availableHeight = nv.utils.availableHeight(height, container, margin);
                  }

                  wrap.select('.nv-legendWrap')
                      .attr('transform', 'translate(0' + ',' + (-margin.top) +')');
              }

              wrap.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

              // Main Chart Component(s)
              scatter
                  .width(availableWidth)
                  .height(availableHeight)
                  .color(data.map(function(d,i) {
                      d.color = d.color || color(d, i);
                      return d.color;
                  }).filter(function(d,i) { return !data[i].disabled }))
                  .showLabels(showLabels);

              wrap.select('.nv-scatterWrap')
                  .datum(data.filter(function(d) { return !d.disabled }))
                  .call(scatter);


              wrap.select('.nv-regressionLinesWrap')
                  .attr('clip-path', 'url(#nv-edge-clip-' + scatter.id() + ')');

              var regWrap = wrap.select('.nv-regressionLinesWrap').selectAll('.nv-regLines')
                  .data(function (d) {
                      return d;
                  });

              regWrap.enter().append('g').attr('class', 'nv-regLines');

              var regLine = regWrap.selectAll('.nv-regLine')
                  .data(function (d) {
                      return [d]
                  });

              regLine.enter()
                  .append('line').attr('class', 'nv-regLine')
                  .style('stroke-opacity', 0);

              // don't add lines unless we have slope and intercept to use
              regLine.filter(function(d) {
                  return d.intercept && d.slope;
              })
                  .watchTransition(renderWatch, 'scatterPlusLineChart: regline')
                  .attr('x1', x.range()[0])
                  .attr('x2', x.range()[1])
                  .attr('y1', function (d, i) {
                      return y(x.domain()[0] * d.slope + d.intercept)
                  })
                  .attr('y2', function (d, i) {
                      return y(x.domain()[1] * d.slope + d.intercept)
                  })
                  .style('stroke', function (d, i, j) {
                      return color(d, j)
                  })
                  .style('stroke-opacity', function (d, i) {
                      return (d.disabled || typeof d.slope === 'undefined' || typeof d.intercept === 'undefined') ? 0 : 1
                  });

              // Setup Axes
              if (showXAxis) {
                  xAxis
                      .scale(x)
                      ._ticks( nv.utils.calcTicksX(availableWidth/100, data) )
                      .tickSize( -availableHeight , 0);

                  g.select('.nv-x.nv-axis')
                      .attr('transform', 'translate(0,' + y.range()[0] + ')')
                      .call(xAxis);
              }

              if (showYAxis) {
                  yAxis
                      .scale(y)
                      ._ticks( nv.utils.calcTicksY(availableHeight/36, data) )
                      .tickSize( -availableWidth, 0);

                  g.select('.nv-y.nv-axis')
                      .call(yAxis);
              }

              // Setup Distribution
              if (showDistX) {
                  distX
                      .getData(scatter.x())
                      .scale(x)
                      .width(availableWidth)
                      .color(data.map(function(d,i) {
                          return d.color || color(d, i);
                      }).filter(function(d,i) { return !data[i].disabled }));
                  gEnter.select('.nv-distWrap').append('g')
                      .attr('class', 'nv-distributionX');
                  g.select('.nv-distributionX')
                      .attr('transform', 'translate(0,' + y.range()[0] + ')')
                      .datum(data.filter(function(d) { return !d.disabled }))
                      .call(distX);
              }

              if (showDistY) {
                  distY
                      .getData(scatter.y())
                      .scale(y)
                      .width(availableHeight)
                      .color(data.map(function(d,i) {
                          return d.color || color(d, i);
                      }).filter(function(d,i) { return !data[i].disabled }));
                  gEnter.select('.nv-distWrap').append('g')
                      .attr('class', 'nv-distributionY');
                  g.select('.nv-distributionY')
                      .attr('transform', 'translate(' + (rightAlignYAxis ? availableWidth : -distY.size() ) + ',0)')
                      .datum(data.filter(function(d) { return !d.disabled }))
                      .call(distY);
              }

              //============================================================
              // Event Handling/Dispatching (in chart's scope)
              //------------------------------------------------------------

              legend.dispatch.on('stateChange', function(newState) {
                  for (var key in newState)
                      state[key] = newState[key];
                  dispatch.stateChange(state);
                  chart.update();
              });

              // Update chart from a state object passed to event handler
              dispatch.on('changeState', function(e) {
                  if (typeof e.disabled !== 'undefined') {
                      data.forEach(function(series,i) {
                          series.disabled = e.disabled[i];
                      });
                      state.disabled = e.disabled;
                  }
                  chart.update();
              });

              // mouseover needs availableHeight so we just keep scatter mouse events inside the chart block
              scatter.dispatch.on('elementMouseout.tooltip', function(evt) {
                  tooltip.hidden(true);
                  container.select('.nv-chart-' + scatter.id() + ' .nv-series-' + evt.seriesIndex + ' .nv-distx-' + evt.pointIndex)
                      .attr('y1', 0);
                  container.select('.nv-chart-' + scatter.id() + ' .nv-series-' + evt.seriesIndex + ' .nv-disty-' + evt.pointIndex)
                      .attr('x2', distY.size());
              });

              scatter.dispatch.on('elementMouseover.tooltip', function(evt) {
                  container.select('.nv-series-' + evt.seriesIndex + ' .nv-distx-' + evt.pointIndex)
                      .attr('y1', evt.relativePos[1] - availableHeight);
                  container.select('.nv-series-' + evt.seriesIndex + ' .nv-disty-' + evt.pointIndex)
                      .attr('x2', evt.relativePos[0] + distX.size());
                  tooltip.data(evt).hidden(false);
              });

              //store old scales for use in transitions on update
              x0 = x.copy();
              y0 = y.copy();

          });

          renderWatch.renderEnd('scatter with line immediate');
          return chart;
      }

      //============================================================
      // Expose Public Variables
      //------------------------------------------------------------

      // expose chart's sub-components
      chart.dispatch = dispatch;
      chart.scatter = scatter;
      chart.legend = legend;
      chart.xAxis = xAxis;
      chart.yAxis = yAxis;
      chart.distX = distX;
      chart.distY = distY;
      chart.tooltip = tooltip;

      chart.options = nv.utils.optionsFunc.bind(chart);
      chart._options = Object.create({}, {
          // simple options, just get/set the necessary values
          width:      {get: function(){return width;}, set: function(_){width=_;}},
          height:     {get: function(){return height;}, set: function(_){height=_;}},
          container:  {get: function(){return container;}, set: function(_){container=_;}},
          showDistX:  {get: function(){return showDistX;}, set: function(_){showDistX=_;}},
          showDistY:  {get: function(){return showDistY;}, set: function(_){showDistY=_;}},
          showLegend: {get: function(){return showLegend;}, set: function(_){showLegend=_;}},
          showXAxis:  {get: function(){return showXAxis;}, set: function(_){showXAxis=_;}},
          showYAxis:  {get: function(){return showYAxis;}, set: function(_){showYAxis=_;}},
          defaultState:     {get: function(){return defaultState;}, set: function(_){defaultState=_;}},
          noData:     {get: function(){return noData;}, set: function(_){noData=_;}},
          duration:   {get: function(){return duration;}, set: function(_){duration=_;}},
          showLabels: {get: function(){return showLabels;}, set: function(_){showLabels=_;}},

          // options that require extra logic in the setter
          margin: {get: function(){return margin;}, set: function(_){
              if (_.top !== undefined) {
                  margin.top = _.top;
                  marginTop = _.top;
              }
              margin.right  = _.right  !== undefined ? _.right  : margin.right;
              margin.bottom = _.bottom !== undefined ? _.bottom : margin.bottom;
              margin.left   = _.left   !== undefined ? _.left   : margin.left;
          }},
          rightAlignYAxis: {get: function(){return rightAlignYAxis;}, set: function(_){
              rightAlignYAxis = _;
              yAxis.orient( (_) ? 'right' : 'left');
          }},
          color: {get: function(){return color;}, set: function(_){
              color = nv.utils.getColor(_);
              legend.color(color);
              distX.color(color);
              distY.color(color);
          }}
      });

      nv.utils.inheritOptions(chart, scatter);
      nv.utils.initOptions(chart);
      return chart;
  };

  nv.models.tooltip = function() {
      "use strict";

      /*
      Tooltip data. If data is given in the proper format, a consistent tooltip is generated.
      Example Format of data:
      {
          key: "Date",
          value: "August 2009",
          series: [
              {key: "Series 1", value: "Value 1", color: "#000"},
              {key: "Series 2", value: "Value 2", color: "#00f"}
          ]
      }
      */
      var id = "nvtooltip-" + Math.floor(Math.random() * 100000) // Generates a unique id when you create a new tooltip() object.
          ,   data = null
          ,   gravity = 'w'   // Can be 'n','s','e','w'. Determines how tooltip is positioned.
          ,   distance = 25 // Distance to offset tooltip from the mouse location.
          ,   snapDistance = 0   // Tolerance allowed before tooltip is moved from its current position (creates 'snapping' effect)
          ,   classes = null  // Attaches additional CSS classes to the tooltip DIV that is created.
          ,   hidden = true  // Start off hidden, toggle with hide/show functions below.
          ,   hideDelay = 200  // Delay (in ms) before the tooltip hides after calling hide().
          ,   tooltip = null // d3 select of the tooltip div.
          ,   lastPosition = { left: null, top: null } // Last position the tooltip was in.
          ,   enabled = true  // True -> tooltips are rendered. False -> don't render tooltips.
          ,   duration = 100 // Tooltip movement duration, in ms.
          ,   headerEnabled = true // If is to show the tooltip header.
          ,   nvPointerEventsClass = "nv-pointer-events-none" // CSS class to specify whether element should not have mouse events.
      ;

      // Format function for the tooltip values column.
      // d is value,
      // i is series index
      // p is point containing the value
      var valueFormatter = function(d, i, p) {
          return d;
      };

      // Format function for the tooltip header value.
      var headerFormatter = function(d) {
          return d;
      };

      var keyFormatter = function(d, i) {
          return d;
      };

      // By default, the tooltip model renders a beautiful table inside a DIV.
      // You can override this function if a custom tooltip is desired.
      var contentGenerator = function(d) {
          if (d === null) {
              return '';
          }

          var table = d3.select(document.createElement("table"));
          if (headerEnabled) {
              var theadEnter = table.selectAll("thead")
                  .data([d])
                  .enter().append("thead");

              theadEnter.append("tr")
                  .append("td")
                  .attr("colspan", 3)
                  .append("strong")
                  .classed("x-value", true)
                  .html(headerFormatter(d.value));
          }

          var tbodyEnter = table.selectAll("tbody")
              .data([d])
              .enter().append("tbody");

          var trowEnter = tbodyEnter.selectAll("tr")
                  .data(function(p) { return p.series})
                  .enter()
                  .append("tr")
                  .classed("highlight", function(p) { return p.highlight});

          trowEnter.append("td")
              .classed("legend-color-guide",true)
              .append("div")
              .style("background-color", function(p) { return p.color});

          trowEnter.append("td")
              .classed("key",true)
              .classed("total",function(p) { return !!p.total})
              .html(function(p, i) { return keyFormatter(p.key, i)});

          trowEnter.append("td")
              .classed("value",true)
              .html(function(p, i) { return valueFormatter(p.value, i, p) });

          trowEnter.filter(function (p,i) { return p.percent !== undefined }).append("td")
              .classed("percent", true)
              .html(function(p, i) { return "(" + d3.format('%')(p.percent) + ")" });

          trowEnter.selectAll("td").each(function(p) {
              if (p.highlight) {
                  var opacityScale = d3.scale.linear().domain([0,1]).range(["#fff",p.color]);
                  var opacity = 0.6;
                  d3.select(this)
                      .style("border-bottom-color", opacityScale(opacity))
                      .style("border-top-color", opacityScale(opacity))
                  ;
              }
          });

          var html = table.node().outerHTML;
          if (d.footer !== undefined)
              html += "<div class='footer'>" + d.footer + "</div>";
          return html;

      };

      /*
       Function that returns the position (relative to the viewport/document.body)
       the tooltip should be placed in.
       Should return: {
          left: <leftPos>,
          top: <topPos>
       }
       */
      var position = function() {
          var pos = {
              left: d3.event !== null ? d3.event.clientX : 0,
              top: d3.event !== null ? d3.event.clientY : 0
          };

          var client = document.body.getBoundingClientRect();
          pos.left -= client.left;
          pos.top -= client.top;

          return pos;
      };

      var dataSeriesExists = function(d) {
          if (d && d.series) {
              if (nv.utils.isArray(d.series)) {
                  return true;
              }
              // if object, it's okay just convert to array of the object
              if (nv.utils.isObject(d.series)) {
                  d.series = [d.series];
                  return true;
              }
          }
          return false;
      };

      // Calculates the gravity offset of the tooltip. Parameter is position of tooltip
      // relative to the viewport.
      var calcGravityOffset = function(pos) {
          var height = tooltip.node().offsetHeight,
              width = tooltip.node().offsetWidth,
              clientWidth = document.body.getBoundingClientRect().width, // Don't want scrollbars.
              clientHeight = document.body.getBoundingClientRect().height, // Don't want scrollbars.
              left, top, tmp;

          // calculate position based on gravity
          switch (gravity) {
              case 'e':
                  left = - width - distance;
                  top = - (height / 2);
                  if(pos.left + left < 0) left = distance;
                  if((tmp = pos.top + top) < 0) top -= tmp;
                  if((tmp = pos.top + top + height) > clientHeight) top -= tmp - clientHeight;
                  break;
              case 'w':
                  left = distance;
                  top = - (height / 2);
                  if (pos.left + left + width > clientWidth) left = - width - distance;
                  if ((tmp = pos.top + top) < 0) top -= tmp;
                  if ((tmp = pos.top + top + height) > clientHeight) top -= tmp - clientHeight;
                  break;
              case 'n':
                  left = - (width / 2) - 5; // - 5 is an approximation of the mouse's height.
                  top = distance;
                  if (pos.top + top + height > clientHeight) top = - height - distance;
                  if ((tmp = pos.left + left) < 0) left -= tmp;
                  if ((tmp = pos.left + left + width) > clientWidth) left -= tmp - clientWidth;
                  break;
              case 's':
                  left = - (width / 2);
                  top = - height - distance;
                  if (pos.top + top < 0) top = distance;
                  if ((tmp = pos.left + left) < 0) left -= tmp;
                  if ((tmp = pos.left + left + width) > clientWidth) left -= tmp - clientWidth;
                  break;
              case 'center':
                  left = - (width / 2);
                  top = - (height / 2);
                  break;
              default:
                  left = 0;
                  top = 0;
                  break;
          }

          return { 'left': left, 'top': top };
      };

      /*
       Positions the tooltip in the correct place, as given by the position() function.
       */
      var positionTooltip = function() {
          nv.dom.read(function() {
              var pos = position(),
                  gravityOffset = calcGravityOffset(pos),
                  left = pos.left + gravityOffset.left,
                  top = pos.top + gravityOffset.top;

              // delay hiding a bit to avoid flickering
              if (hidden) {
                  tooltip
                      .interrupt()
                      .transition()
                      .delay(hideDelay)
                      .duration(0)
                      .style('opacity', 0);
              } else {
                  // using tooltip.style('transform') returns values un-usable for tween
                  var old_translate = 'translate(' + lastPosition.left + 'px, ' + lastPosition.top + 'px)';
                  var new_translate = 'translate(' + Math.round(left) + 'px, ' + Math.round(top) + 'px)';
                  var translateInterpolator = d3.interpolateString(old_translate, new_translate);
                  var is_hidden = tooltip.style('opacity') < 0.1;

                  tooltip
                      .interrupt() // cancel running transitions
                      .transition()
                      .duration(is_hidden ? 0 : duration)
                      // using tween since some versions of d3 can't auto-tween a translate on a div
                      .styleTween('transform', function (d) {
                          return translateInterpolator;
                      }, 'important')
                      // Safari has its own `-webkit-transform` and does not support `transform`
                      .styleTween('-webkit-transform', function (d) {
                          return translateInterpolator;
                      })
                      .style('-ms-transform', new_translate)
                      .style('opacity', 1);
              }

              lastPosition.left = left;
              lastPosition.top = top;
          });
      };

      // Creates new tooltip container, or uses existing one on DOM.
      function initTooltip() {
          if (!tooltip || !tooltip.node()) {
              // Create new tooltip div if it doesn't exist on DOM.

              var data = [1];
              tooltip = d3.select(document.body).select('#'+id).data(data);

              tooltip.enter().append('div')
                     .attr("class", "nvtooltip " + (classes ? classes : "xy-tooltip"))
                     .attr("id", id)
                     .style("top", 0).style("left", 0)
                     .style('opacity', 0)
                     // .style('position', 'fixed')
                     .selectAll("div, table, td, tr").classed(nvPointerEventsClass, true)
                     .classed(nvPointerEventsClass, true);

              tooltip.exit().remove()
          }
      }

      // Draw the tooltip onto the DOM.
      function nvtooltip() {
          if (!enabled) return;
          if (!dataSeriesExists(data)) return;

          nv.dom.write(function () {
              initTooltip();
              // Generate data and set it into tooltip.
              // Bonus - If you override contentGenerator and return falsey you can use something like
              //         React or Knockout to bind the data for your tooltip.
              var newContent = contentGenerator(data);
              if (newContent) {
                  tooltip.node().innerHTML = newContent;
              }

              positionTooltip();
          });

          return nvtooltip;
      }

      nvtooltip.nvPointerEventsClass = nvPointerEventsClass;
      nvtooltip.options = nv.utils.optionsFunc.bind(nvtooltip);

      nvtooltip._options = Object.create({}, {
          // simple read/write options
          duration: {get: function(){return duration;}, set: function(_){duration=_;}},
          gravity: {get: function(){return gravity;}, set: function(_){gravity=_;}},
          distance: {get: function(){return distance;}, set: function(_){distance=_;}},
          snapDistance: {get: function(){return snapDistance;}, set: function(_){snapDistance=_;}},
          classes: {get: function(){return classes;}, set: function(_){classes=_;}},
          enabled: {get: function(){return enabled;}, set: function(_){enabled=_;}},
          hideDelay: {get: function(){return hideDelay;}, set: function(_){hideDelay=_;}},
          contentGenerator: {get: function(){return contentGenerator;}, set: function(_){contentGenerator=_;}},
          valueFormatter: {get: function(){return valueFormatter;}, set: function(_){valueFormatter=_;}},
          headerFormatter: {get: function(){return headerFormatter;}, set: function(_){headerFormatter=_;}},
          keyFormatter: {get: function(){return keyFormatter;}, set: function(_){keyFormatter=_;}},
          headerEnabled: {get: function(){return headerEnabled;}, set: function(_){headerEnabled=_;}},
          position: {get: function(){return position;}, set: function(_){position=_;}},

          // Deprecated options
          chartContainer: {get: function(){return document.body;}, set: function(_){
              // deprecated after 1.8.3
              nv.deprecated('chartContainer', 'feature removed after 1.8.3');
          }},
          fixedTop: {get: function(){return null;}, set: function(_){
              // deprecated after 1.8.1
              nv.deprecated('fixedTop', 'feature removed after 1.8.1');
          }},
          offset: {get: function(){return {left: 0, top: 0};}, set: function(_){
              // deprecated after 1.8.1
              nv.deprecated('offset', 'use chart.tooltip.distance() instead');
          }},

          // options with extra logic
          hidden: {get: function(){return hidden;}, set: function(_){
              if (hidden != _) {
                  hidden = !!_;
                  nvtooltip();
              }
          }},
          data: {get: function(){return data;}, set: function(_){
              // if showing a single data point, adjust data format with that
              if (_.point) {
                  _.value = _.point.x;
                  _.series = _.series || {};
                  _.series.value = _.point.y;
                  _.series.color = _.point.color || _.series.color;
              }
              data = _;
          }},

          // read only properties
          node: {get: function(){return tooltip.node();}, set: function(_){}},
          id: {get: function(){return id;}, set: function(_){}}
      });

      nv.utils.initOptions(nvtooltip);
      return nvtooltip;
  };
} )( nv );
