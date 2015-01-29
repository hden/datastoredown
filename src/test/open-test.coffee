'use strict'

test       = require('tap').test
testCommon = require('./testCommon')
leveldown  = require('../')
abstract   = require('abstract-leveldown/abstract/open-test')

if require.main is module
    abstract.setUp(test, testCommon)
    abstract.args(leveldown, test, testCommon)
    abstract.open(leveldown, test, testCommon)
    abstract.tearDown(test, testCommon)
