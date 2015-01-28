// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var abstract, leveldown, test, testCommon;

  test = require('tap').test;

  testCommon = require('./testCommon');

  leveldown = require('../');

  abstract = require('abstract-leveldown/abstract/del-test');

  if (require.main === module) {
    abstract.setUp(leveldown, test, testCommon);
    abstract.args(test);
    abstract.tearDown(test, testCommon);
  }

}).call(this);
