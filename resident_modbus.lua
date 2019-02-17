require('luamodbus')
 if not mb then
    mb = luamodbus.tcp()
    mb:open('xxx.xxx.xxx.xxx', 502)
    mb:connect()
 end
  
value = grp.getvalue('x/x/x')

status = mb:readregisters(x, dt.uint16)

writevalue = mb:writeregisters(x, value)
