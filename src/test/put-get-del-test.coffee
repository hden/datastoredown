'use strict'

test       = require('tap').test
testCommon = require('./testCommon')
leveldown  = require('../')
fs         = require('fs')
testBuffer = fs.readFileSync("#{__dirname}/testdata.bin")
abstract   = require('abstract-leveldown/abstract/put-get-del-test')

if require.main is module
    # https://cloud.google.com/datastore/docs/concepts/entities#Datastore_Properties_and_value_types
    # abstract.all(leveldown, test, testCommon, testBuffer, Buffer)
    abstract.setUp(leveldown, test, testCommon)
    abstract.errorKeys(test, Buffer)
    # abstract.nonErrorKeys(test)
    abstract.errorValues(test, Buffer)
    # abstract.nonErrorValues(test, Buffer)
    abstract.tearDown(test, testCommon)
