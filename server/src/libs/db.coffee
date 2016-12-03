Datastore = require('nedb')
config = require('./../config/config')

db={}
dbPath = config.dbFilePath

db.users= new Datastore(dbPath+'users.db')
db.users.loadDatabase();
db.tasks= new Datastore(dbPath+'tasks.db')
db.tasks.loadDatabase();
module.exports=db