local function parseMessage(message)
    local destID, statusCode, senderID, senderMessage = string.match(message, "(%d+):(%d+):(%d+):(%w+)")
    destID = tonumber(destID)
    statusCode = tonumber(statusCode)
    senderID = tonumber(senderID)
    senderMessage = tostring(senderMessage)
    if destID == systemID then
      return statusCode, senderID, senderMessage
    else
      return nil
    end
  end

  return {
    parseMessage = parseMessage,
  }