-- Inital setup --
local systemID = 562398
local gpc = require("functions")
local stationName, statusCode, senderID, senderMessage
--System ID's are hard coded 6 digit numbers.
-- Start Modem and connect to GlacierNet (tm)

local modem = peripheral.find("modem") or error("No modem attached", 0)
--Channel Documentaion: 43 is the reciever port, 44 is the sender port--
modem.open(43) -- Open 43 so we can receive replies
--send establishment message and wait.
local message = (systemID+ ":"+"0"+":"+"19")
--Message format: systemID of sender+ ":" + status code + senderID of destination (servers are 19) + Message Field

--status codes: 

-- 0: Establish
-- 1: Register Ticket
-- 2: Check Ticket
-- 3: Void Ticket
modem.transmit(44, 43, message)

-- And wait for a reply
local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 43

print("Received a reply: " .. tostring(message))
--server is hardcoded with stationNames based off of systemID's
statusCode, senderID, senderMessage = gpc.parseMessage(message)
stationName = senderMessage
if statusCode == 0 then
  print("Establishment message received from server.")
  print("Server ID: " .. senderID)
  print("Station Name: " .. stationName)
end