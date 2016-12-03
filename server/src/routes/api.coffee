express = require('express');
router = express.Router();
db = require('./../libs/db')

router.get('/faq', (req, res, next) ->
  console.log('进入faq')
  db.users.insert({username:'tom'},(err,user)->
     return next(err) if err
     console.log(user)
     res.json(user)
     return

  )
)
module.exports = router;
