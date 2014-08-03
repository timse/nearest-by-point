# Welcome to the jQuery-Plugin "Nearest Schnellaaa"

The *nearest-schnellaaa* jQuery plugin filters a jQuery selection to only those elements that are touched by a specified area.

## Why nearest schnellaaa
While other plugins may exist that tackle the same issue, this plugin is limited in features but build with speed in mind.

## Basic Usage
After loading the plugin with your jQuery you can easily call it on a jQuery-selection like so:
```
    $('<some selector>').nearestSchnelllaa(x, y, proximity)
```
the return value of that call is a filterd selection of the passed in selection based on which elements are near to the specified point.

### Function signature with `x`, `y`, and `proximity`
The params expected by `nearestSchnelllaa` are x, y of the point (relative to the viewport - see the example below to see what i mean) and a proximity which is added to the x and y to specify the area in which to look for an element.
If `o` was the point specified by `x` and `y`, and `proximity` was 3 the lookup area would be something like this:

       xxxxxxx 
       xxxxxxx 
       xxxoxxx 
       xxxxxxx 
       xxxxxxx 

Of course a radius would be better than a square here, but then again its about speed and there is no speed in calculating touchpoints with a circle in mind :)

### Example use case
Lets say you want to give all elements of a certain selection an extra class for highlighting once they are close to the mousepointer, you could do something like this:
	
    var $possibleHighlighterElems = $('.elems-to-be-highlighted');
    var $lastHighlightedElems = $();
    var proximity = 150;
    var highlightingClass = 'highlight';
    $(document).on('mousemove', function(e){
        // get x and y relative to the viewport - this is what nearestSchnellaaa expects - otherwise it behaves funny at best
        x = e.clientX;
        y = e.clientY;

        // remove the old highlights
        $lastHighlightedElems.removeClass(highlightingClass);
        // store the current selection for the next round
        $lastHighlightedElems.nearestSchnelllaa(x, y, proximity)
            .addClass(highlightingClass);
    });


**IMPORTANT**: It is important to specify `x` and `y` *relative* to the viewport and not to the document. Use `event.clientX` and `event.clientY` for that!
In case you dont have an `event` object, calculate it yourself :).
