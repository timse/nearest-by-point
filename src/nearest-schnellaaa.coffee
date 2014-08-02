    $win = $ window

    throttle = (fn, wait)->
        last = null
        timeoutTkn = null
        return throttled = ->
            now = +new Date
            diff = now - last
            if !last or diff > wait
                last = now
                fn()
            else
                clearTimeout timeoutTkn
                timeoutTkn = setTimeout throttled, wait - diff + 1




    viewportHeight = viewportWidth = scrollTop = scrollLeft = null

    scrollListener = ->
        scrollTop = $win.scrollTop()
        scrollLeft = $win.scrollLeft()
    resizeListener = ->
        viewportWidth = $win.width()
        viewportHeight = $win.height()
    noop = ->
    ensureListeners = ->
        ensureListeners = noop
        $win.on 'scroll', throttle scrollListener, 50
        .on 'resize', throttle resizeListener, 50

    filterFn = (left, right, top, bottom, elem)->
        boundary = elem.getBoundingClientRect()

        # if elem above viewport -> nope
        if boundary.bottom < 0
            return false

        # if elem below viewport -> nope
        if boundary.top > viewportHeight
            return false

        # if left of proxArea -> nope
        if boundary.right < left
            return false

        # if right of proxArea -> nope
        if boundary.left > right
            return false

        # if above of proxArea -> nope
        if boundary.bottom < top
            return false

        # if below of proxArea -> nope
        if boundary.top > bottom
            return false


        return true


    $.fn['nearest-schnellaaa'] = $.fn['nearestSchnellaaa'] = (x, y, prox)->
        ensureListeners()

        # expecting absolute x, y but calculating in relative dimensions
        # thus we need to substract the scrollings from the point

        x -= scrollLeft
        y -= scrollTop

        left = x - prox
        top = y - prox

        right = x + prox
        bottom = y + prox

        res = []
        for elem in @
            if filterFn(left, top, right, bottom, elem)
                res.push elem

        return $(res)














