/*!
* nearest-by-point - jQuery plugin to find filter a selection of elements to only those near a certain point
* v0.0.8 - 2014-08-07 12:27:00 PM UTC
* Copyright (c) 2014 timse; Licensed 
*/
 ;(function($){
;var $win, filterFn;

$win = $(window);

filterFn = function(left, top, right, bottom, elem) {
  var boundary;
  boundary = elem.getBoundingClientRect();
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

$.fn['nearestByPoint'] = function(x, y, prox) {
  var bottom, elem, left, res, right, top, _i, _len;
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
