    $win = $ window

    filterFn = (left, right, top, bottom, elem)->
        boundary = elem.getBoundingClientRect()

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

        left = x - prox
        top = y - prox

        right = x + prox
        bottom = y + prox

        res = []
        for elem in @
            if filterFn(left, top, right, bottom, elem)
                res.push elem

        return $(res)














