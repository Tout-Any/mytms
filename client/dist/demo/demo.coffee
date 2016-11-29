num=1
isRight =true
obj =
  a:5
  b:'abc'
  getA:->
    @a

console.log(obj.getA())
age =17
#函数定义
func = ->
  obj.a+num

#函数默认值
func2 =(name,age=20) ->
  console.log(name+':'+age)
  name+age

#简单if
str='abc'
str += '123' if isRight
#标准if else
if str is 'abc'
   str+='123'
else if str is 'abc'
  str +='aaa'
#范围判断
isStudent = 10<age<20

#数组定义
arr=[23,12,43,322]

for item in arr
  console.log(item)
  item+=5

