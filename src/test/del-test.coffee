'use strict'

test       = require('tap').test
testCommon = require('./testCommon')
leveldown  = require('../')
abstract   = require('abstract-leveldown/abstract/del-test')

if require.main is module
    abstract.setUp(leveldown, test, testCommon)
    abstract.args(test)
    # https://cloud.google.com/developers/articles/balancing-strong-and-eventual-consistency-with-google-cloud-datastore/
    # abstract.del(test)
    abstract.tearDown(test, testCommon)
