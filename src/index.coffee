'use strict'

abstract = require 'abstract-leveldown'
gcloud   = require 'gcloud'
entity   = require 'gcloud/lib/datastore/entity'

class Datastore extends abstract.AbstractLevelDOWN
    constructor: (location) ->
        return new Datastore(location) unless @ instanceof Datastore
        super
        [@projectId, @keyFilename] = location.split(':')

    _open: (options, callback) ->
        # projectId = options.projectId or ''
        # keyFilename = options.keyFilename or ''

        @_dataset = gcloud.datastore.dataset { @projectId, @keyFilename }
        process.nextTick ->
            callback(null, @)

    # https://github.com/GoogleCloudPlatform/gcloud-node/blob/master/regression/datastore.js#L39-L63
    _put: (key, value = '', options, callback) ->
        key  = @_key(key, options)
        data = { value }
        @_dataset.save({ key, data }, callback)

    _get: (key, options, callback) ->
        key = @_key(key, options)
        @_dataset.get key, (error, entity) ->
            return callback(error) if error?

            value = entity?.data?.value

            if value?
                value = new Buffer(value) if options.asBuffer is true
                callback(null, value)
            else
                # 'NotFound' error, consistent with LevelDOWN API
                callback(new Error('NotFound')) unless value?

    _del: (key, options, callback) ->
        key = @_key(key, options)
        @_dataset.delete(key, callback)

    _key: (key, options) ->
        # datastore does not allow `0` as ID
        key = '_' + key.toString()
        @_dataset.key([options.kind or 'Level', key])

    _batch: (array, options, callback) ->
        # http://goo.gl/3LJZsc
        fn = (acc, obj, index) =>
            key = @_key(obj.key, options)

            if obj.type is 'del'
                acc.delete.push entity.keyToKeyProto key
            else
                ent = entity.entityToEntityProto({ value: obj.value or '' })
                ent.key = entity.keyToKeyProto(key)
                acc.upsert.push ent

            acc

        req =
            mutation: array.reduce(fn, { upsert: [], insert_auto_id: [], delete: [] })

        onCommit = (error) ->
            callback(error)

        if @_dataset.id
            @_dataset.requests_.push(req)
            @_dataset.requestCallbacks_.push(onCommit)
        else
            @_dataset.makeReq_('commit', req, onCommit)

module.exports = Datastore
