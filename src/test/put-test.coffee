'use strict'

test       = require('tap').test
testCommon = require('./testCommon')
leveldown  = require('../')
abstract   = require('abstract-leveldown/abstract/put-test')

if require.main is module
    abstract.all(leveldown, test, testCommon)
