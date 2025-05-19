local gpc = require("functions")
local gpc_server = require("serverFunctions")
local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(44)
--as this is the server, the ports are opposite. recieve on 44, send on 43
local systemID = 0



--Wait to receive a message
local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 44
-- use the parseMessage function to extract the systemID, statusCode, senderID, and senderMessage
local statusCode, senderID, senderMessage = gpc.parseMessage(message)

if statusCode == 0 then
  print("Establishment message received from client.")
  print("Client ID: " .. senderID)
  print("Station Name: " .. senderMessage)
local stationName = gpc_server.stationNames[senderID]
    -- Send a reply back to the client
    local replyMessage = (systemID .. ":" .. "0" .. ":" .. senderID .. ":" .. stationName)
    modem.transmit(43,0, replyMessage)
end

if statusCode == 1 then
  print("Ticket registration request received from client.")
  print("Client ID: " .. senderID)
  print("Station Name: " .. senderMessage)
  -- Here you would handle the ticket registration logic
  -- For example, you could store the ticket information in a database or file
  -- and send a confirmation message back to the client
end
