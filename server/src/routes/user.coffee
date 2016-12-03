express = require('express');
router = express.Router();
userBiz = require('./../biz/userBiz')

router.post('/user/login', userBiz.login)

router.post(
  '/user/regist'
  userBiz.isUserExists
  userBiz.regist
)


module.exports = router;
