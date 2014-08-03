/*!
* nearest-schnellaaa - jQuery plugin to find filter a selection of elements to only those near a certain point
* v0.0.3 - 2014-08-03 9:19:49 AM UTC
* Copyright (c) 2014 timse; Licensed 
*/
 ;(function($){
;var $win, ensureListeners, filterFn, noop, resizeListener, throttle, viewportHeight, viewportWidth;

$win = $(window);

throttle = function(fn, wait) {
  var last, throttled, timeoutTkn;
  last = null;
  timeoutTkn = null;
  return throttled = function() {
    var diff, now;
    now = +(new Date);
    diff = now - last;
    if (!last || diff > wait) {
      last = now;
      return fn();
    } else {
      clearTimeout(timeoutTkn);
      return timeoutTkn = setTimeout(throttled, wait - diff + 1);
    }
  };
};

viewportHeight = viewportWidth = null;

resizeListener = function() {
  viewportWidth = $win.width();
  viewportHeight = $win.height();
};

resizeListener();

noop = function() {};

ensureListeners = function() {
  ensureListeners = noop;
  $win.on('resize', throttle(resizeListener, 50));
};

filterFn = function(left, right, top, bottom, elem) {
  var boundary;
  boundary = elem.getBoundingClientRect();
  if (boundary.bottom < 0) {
    return false;
  }
  if (boundary.top > viewportHeight) {
    return false;
  }
  if (boundary.right < left) {
    return false;
  }
  if (boundary.left > right) {
    return false;
  }
  if (boundary.bottom < top) {
    return false;
  }
  if (boundary.top > bottom) {
    return false;
  }
  return true;
};

$.fn['nearest-schnellaaa'] = $.fn['nearestSchnellaaa'] = function(x, y, prox) {
  var bottom, elem, left, res, right, top, _i, _len;
  ensureListeners();
  left = x - prox;
  top = y - prox;
  right = x + prox;
  bottom = y + prox;
  res = [];
  for (_i = 0, _len = this.length; _i < _len; _i++) {
    elem = this[_i];
    if (filterFn(left, top, right, bottom, elem)) {
      res.push(elem);
    }
  }
  return $(res);
};
;}(window.jQuery));
