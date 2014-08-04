expect  = chai.expect
should  = chai.should()

describe "nearest-schnellaaa", ->

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
                filterFn(left, top, right, bottom, elem).should.be.true

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
                filterFn(left, top, right, bottom, elem).should.be.false

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
                filterFn(left, top, right, bottom, elem).should.be.false

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
                filterFn(left, top, right, bottom, elem).should.be.false

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
                filterFn(left, top, right, bottom, elem).should.be.false



