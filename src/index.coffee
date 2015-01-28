'use strict'

abstract = require 'abstract-leveldown'
gcloud   = require 'gcloud'

class Datastore extends abstract.AbstractLevelDOWN
    constructor: (location) ->
        return new Datastore(location) unless @ instanceof Datastore
        super
        [@projectId, @keyFilename] = location.split(':')

    _open: (options, callback) ->
        # projectId = options.projectId or ''
        # keyFilename = options.keyFilename or ''

        @_dataset = gcloud.datastore.dataset {@projectId, @keyFilename}
        process.nextTick ->
            callback(null, @)

    # https://github.com/GoogleCloudPlatform/gcloud-node/blob/master/regression/datastore.js#L39-L63
    _put: (key, value, options, callback) ->
        key  = @_key(key, options)
        data = {value}
        @_dataset.save({key, data}, callback)

    _get: (key, options, callback) ->
        key = @_key(key, options)
        @_dataset.get key, (error, entity) ->
            return callback(error) if error?

            value = entity?.data?.value or ''

            if value?
                callback(null, value)
            else
                # 'NotFound' error, consistent with LevelDOWN API
                callback(new Error('NotFound')) unless value?

    _del: (key, options, callback) ->
        key = @_key(key, options)
        @_dataset.delete(key, callback)

    _key: (key, options) ->
        @_dataset.key([options.kind or 'Level', key])

module.exports = Datastore
