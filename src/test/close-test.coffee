'use strict'

test       = require('tap').test
testCommon = require('./testCommon')
leveldown  = require('../')
abstract   = require('abstract-leveldown/abstract/close-test')

if require.main is module
    abstract.close(leveldown, test, testCommon)
