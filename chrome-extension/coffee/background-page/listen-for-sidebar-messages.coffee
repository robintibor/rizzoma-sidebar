chrome.extension.onMessage.addListener((messageString, sender, sendResponse) ->
    handleMessage(messageString, sender, sendResponse)
)

handleMessage = (messageString, sender, sendResponse) ->
    if (messageString[..11] == 'CURRENT_URL:')
        URL = messageString[13..]
        handleNewURL(URL)
    else if (messageString == 'GET_CURRENT_SIDEBAR_URL')
        handleGetCurrentSidebarURL(sendResponse)

handleNewURL = (url) ->
    sessionStorage["sidebar.lastUrl"] = url
    
handleGetCurrentSidebarURL = (sendResponseFunction) ->
    url = sessionStorage["sidebar.lastUrl"]
    sendResponseFunction(url)