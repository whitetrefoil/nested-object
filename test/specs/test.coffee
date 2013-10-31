should = require('chai').should()
nestedAttr = require('../../lib/nested-object')

describe 'This module,', ->
  it 'should be a function', ->
    nestedAttr.should.be.a 'function'

  describe 'when getting a nested attribute,', ->
    beforeEach ->
      @testObj1 =
        a:
          b:
            c: 'asdf'
    afterEach ->
      @testObj1 = undefined

    it 'should be able to get the first level attribute', ->
      nestedAttr(@testObj1, 'a').should.eql
        b:
          c: 'asdf'

    it 'should return the deepest property if there\'s no more deeper one', ->
      nestedAttr(@testObj1, 'a.b.c.d.e').should.eql 'asdf'

    describe 'using point separated format,', ->
      it 'should be able to get a mid-level attribute', ->
        nestedAttr(@testObj1, 'a.b').should.eql
          c: 'asdf'

      it 'should be able to get a deepest-level attribute', ->
        nestedAttr(@testObj1, 'a.b.c').should.eql 'asdf'

    describe 'using square bracket format,', ->
      it 'should be able to get a mid-level attribute', ->
        nestedAttr(@testObj1, 'a[b]').should.eql
          c: 'asdf'

      it 'should be able to get a deepest-level attribute', ->
        nestedAttr(@testObj1, 'a[b][c]').should.eql 'asdf'

    describe 'using bad (mixed) format,', ->
      it 'should be able to get a mid-level attribute', ->
        nestedAttr(@testObj1, '[].[].[..].a.[.[...[[b[.[.[]').should.eql
          c: 'asdf'

      it 'should be able to get a deepest-level attribute', ->
        nestedAttr(@testObj1, '.[][].a[].[].[].[][[.[]].[b[].[].[[].][c][].[].[].][').should.eql 'asdf'

  describe 'when setting a nested attribute,', ->
    beforeEach ->
      @testObj1 =
        a:
          b:
            c: 'asdf'
    afterEach ->
      @testObj1 = undefined

    it 'should be able to set the first level attribute', ->
      nestedAttr @testObj1, 'a', 'qwer'
      @testObj1.should.eql
        a: 'qwer'

    it 'should be able to set a non-existing level attribute', ->
      nestedAttr @testObj1, 'a.b.c.d.e.f', 'qwer'
      @testObj1.should.eql
        a:
          b:
            c:
              d:
                e:
                  f: 'qwer'

    describe 'using point separated format,', ->
      it 'should be able to get a mid-level attribute', ->
        nestedAttr @testObj1, 'a.b', 'qwer'
        @testObj1.should.eql
          a:
            b: 'qwer'

      it 'should be able to set a deepest-level attribute', ->
        nestedAttr @testObj1, 'a.b.c', 'qwer'
        @testObj1.should.eql
          a:
            b:
              c: 'qwer'

    describe 'using square bracket format,', ->
      it 'should be able to set a mid-level attribute', ->
        nestedAttr @testObj1, 'a[b]', 'qwer'
        @testObj1.should.eql
          a:
            b: 'qwer'

      it 'should be able to set a deepest-level attribute', ->
        nestedAttr @testObj1, 'a[b][c]', 'qwer'
        @testObj1.should.eql
          a:
            b:
              c: 'qwer'

    describe 'using bad (mixed) format,', ->
      it 'should be able to set a mid-level attribute', ->
        nestedAttr @testObj1, '[].[].[..].a.[.[...[[b[.[.[]', 'qwer'
        @testObj1.should.eql
          a:
            b: 'qwer'


      it 'should be able to set a deepest-level attribute', ->
        nestedAttr @testObj1, '.[][].a[].[].[].[][[.[]].[b[].[].[[].][c][].[].[].][', 'qwer'
        @testObj1.should.eql
          a:
            b:
              c: 'qwer'

