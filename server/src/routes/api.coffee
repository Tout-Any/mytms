express = require('express');
router = express.Router();

router.get('/faq', (req, res, next) ->
  res.send('I am fine  你好吗');
)

module.exports = router;
