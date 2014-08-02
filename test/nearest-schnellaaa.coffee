expect  = chai.expect
should  = chai.should()

describe "nearest-schnellaaa", ->

    describe "helpers like event listeners", ->

        describe "viewportHeight, viewportWidth, scrollTop, and scrollLeft", ->
            it 'they should all initially be set', ->
                scrollLeft.should.be.a.number
                scrollTop.should.be.a.number
                viewportWidth.should.be.a.number
                viewportHeight.should.be.a.number

        describe "scrollListener", ->

            it 'should set the variables scrollTop and scrollLeft', ->
                window.scrollLeft = window.scrollTop = null

                scrollListener()

                scrollLeft.should.be.a.number
                scrollTop.should.be.a.number

        describe "resizeListener", ->
            it 'should set the variables viewportHeight and viewportWidth', ->
                window.viewportWidth = window.viewportHeight = null

                resizeListener()

                viewportWidth.should.be.a.number
                viewportHeight.should.be.a.number

        describe "throttle", ->
            it 'should throttle the calls to a specified number of times in an interval according to the setting given', ->
                spy = sinon.spy()
                throttledSpy = throttle(spy, 50)

                throttledSpy()
                spy.should.be.calledOnce
                throttledSpy()
                spy.should.be.calledOnce

            it 'should remember if the function was called within a "waiting" period and call it again latest when the waiting period is over', (done)->
                spy = sinon.spy()
                throttledSpy = throttle(spy, 50)

                throttledSpy()
                spy.should.be.calledOnce
                throttledSpy()
                spy.should.be.calledOnce
                setTimeout ->
                    spy.should.be.calledTwice
                    done()
                , 55
        describe "ensureListeners", ->
            it 'should set the event listeners for scrolling and resize on the window if called', ->
                sinon.stub(jQuery.fn, 'on').returns($win)

                ensureListeners()
                $win.on.should.be.calledTwice

                $win.on.restore()

            it 'should only set the event listeners once, and then set itself to a noop function', ->
                sinon.stub(jQuery.fn, 'on').returns($win)

                ensureListeners()
                $win.on.should.not.be.called
                ensureListeners.should.eql(noop)

                $win.on.restore()

        describe "filterFn", ->
            describe "filterFn", ->
            stubBoundary = (elem)->
                return sinon.stub(elem, 'getBoundingClientRect')

            it 'should return true if the passed in elem is in reach of the lookup area', ->
                elem = {getBoundingClientRect: ->}
                stub = stubBoundary(elem)
                stub.returns({
                    top: 0
                    bottom: 50
                    left: 0
                    right: 50
                })

                left = 0
                top = 0
                right = 50
                bottom = 50
                filterFn(left, right, top, bottom, elem).should.be.true

            it 'should return false if the passed in elem is above the viewport - (boundary bottom is below 0 )', ->
                elem = {getBoundingClientRect: ->}
                stub = stubBoundary(elem)
                stub.returns({
                    top: 0
                    bottom: -50
                    left: 0
                    right: 50
                })

                left = 0
                top = 0
                right = 50
                bottom = 50
                filterFn(left, right, top, bottom, elem).should.be.false

            it 'should return false if the passed in elem is below the viewport - (boundary top is bigger than viewportHeight)', ->
                elem = {getBoundingClientRect: ->}
                stub = stubBoundary(elem)
                stub.returns({
                    top: viewportHeight + 100
                    bottom: 50
                    left: 0
                    right: 50
                })

                left = 0
                top = 0
                right = 50
                bottom = 50
                filterFn(left, right, top, bottom, elem).should.be.false

            it 'should return false if the passed in elem is left of the expected area (boundary right is smaller than the passed in left)', ->
                elem = {getBoundingClientRect: ->}
                stub = stubBoundary(elem)
                stub.returns({
                    top: 0
                    bottom: 50
                    left: 0
                    right: 50
                })

                left = 200
                top = 0
                right = 50
                bottom = 50
                filterFn(left, right, top, bottom, elem).should.be.false

            it 'should return false if the passed in elem is right of the expected area (boundary left is bigger than the passed in right)', ->
                elem = {getBoundingClientRect: ->}
                stub = stubBoundary(elem)
                stub.returns({
                    top: 0
                    bottom: 50
                    left: 50
                    right: 50
                })

                left = 0
                top = 0
                right = 25
                bottom = 50
                filterFn(left, right, top, bottom, elem).should.be.false

            it 'should return false if the passed in elem is above the expected area (boundary bottom is smaller than the passed in top)', ->
                elem = {getBoundingClientRect: ->}
                stub = stubBoundary(elem)
                stub.returns({
                    top: 0
                    bottom: 50
                    left: 0
                    right: 50
                })

                left = 0
                top = 100
                right = 50
                bottom = 50
                filterFn(left, right, top, bottom, elem).should.be.false

            it 'should return false if the passed in elem is below the expected area (boundary top is bigger than the passed in bottom)', ->
                elem = {getBoundingClientRect: ->}
                stub = stubBoundary(elem)
                stub.returns({
                    top: 100
                    bottom: 50
                    left: 0
                    right: 50
                })

                left = 0
                top = 0
                right = 50
                bottom = 50
                filterFn(left, right, top, bottom, elem).should.be.false

        describe "nearestSchnellaaa the main part", ->

            it 'should call ensureListeners', ->
                stub = sinon.stub(window, 'ensureListeners')

                stub.should.not.be.called
                $().nearestSchnellaaa()
                stub.should.be.called.once

                window.ensureListeners.restore()



