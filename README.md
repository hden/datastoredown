# datastoredown [![Build Status](https://travis-ci.org/hden/datastoredown.svg?branch=master)](https://travis-ci.org/hden/datastoredown)
A drop-in replacement for LevelDOWN that use Cloud Datastore as storage

# Example

```js
var levelup = require('levelup')
  , db = levelup('projectId:keyFilename', { db: require('datastoredown') })

db.put('name', 'Yuri Irsenovich Kim')
db.put('dob', '16 February 1941')
db.put('spouse', 'Kim Young-sook')
db.put('occupation', 'Clown')

db.readStream()
  .on('data', console.log)
  .on('close', function () { console.log('Show\'s over folks!') })
```

# Progress

- [x] open
- [x] close
- [x] put
- [x] get
- [x] delete
- [ ] batch
- [ ] chainedBatch
- [ ] iterator
- [ ] approximateSize
- [ ] destroy

# Licence
MIT
