require('json')

device_id = 'name of device'
broker = 'broker address'
port = 8883
username = 'username'
password = 'SharedAccessSignature'

mqtt = require('mosquitto')
client = mqtt.new(device_id,false)

client.ON_CONNECT = function(...)
  log('ON_CONNECT', ...)
  client:publish('devices/' .. device_id .. '/messages/events/', 'Connected')
  
  client:subscribe('devices/' .. device_id .. '/messages/events/')
  client:subscribe('devices/' .. device_id .. '/messages/devicebound/#')
end

client.ON_PUBLISH = function(...)
  log('ON_PUBLISH', ...)
end

client.ON_LOG = function(...)
  log('ON_LOG', ...)
end

client.ON_MESSAGE = function(mid, topic, payload)
log('ON_MESSAGE', mid, topic, payload)
values = json.pdecode(payload)
-- run a function sending variable values
end

--client.ON_MESSAGE = function(...)
 -- log('ON_MESSAGE', ...)
-- end
    
client.ON_DISCONNECT = function(...)
  log('ON_DISCONNECT', ...)
end


client:version_set(mqtt.PROTOCOL_V311)
client:tls_set('/home/ftp/azure.crt')
client:login_set(username, password)
client:connect(broker, port)

while true do
  res, err, code = client:loop()
  if not res then
    log('loop error', res, err, code)
    os.sleep(1)
  end
end
