'use strict'
gcloud      = require 'gcloud'
fs          = require 'fs'
projectId   = process.env.GCLOUD_TESTS_PROJECT_ID
keyFilename = "#{__dirname}/../key.json"

exports.location = exports.lastLocation = ->
    "#{projectId}:#{keyFilename}"

exports.cleanup = (callback) ->
    ds = gcloud.datastore.dataset {projectId, keyFilename}
    q  = ds.createQuery('Level')
    ds.runQuery q, (error, results) ->
        return callback(error) if error?
        keys = results.map (d) ->
            d.key

        ds.delete(keys, callback)

exports.setUp = (t) ->
    exports.cleanup (error) ->
        t.error(error, 'cleanup returned an error')
        t.end()

exports.tearDown = (t) ->
    exports.setUp(t) # same cleanup!

exports.collectEntries = (iterator, callback) ->
    data = []
    next = ->
        iterator.next (error, key, value) ->
            return callback(error) if error?

            unless arguments.length
                return iterator.end (error) ->
                    callback(error, data)

            data.push {key, value}
            setTimeout next, 0

    next()
