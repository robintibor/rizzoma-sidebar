chrome.extension.onMessage.addListener((messageString, sender, sendResponse) ->
    handleMessage(messageString, sender, sendResponse)
)

handleMessage = (messageString, sender, sendResponse) ->
    if (messageString == 'IS_SIDEBAR_ENABLED_FOR_THIS_TAB')
        handleSidebarEnabled(sender, sendResponse)
    else if (messageString[..11] == 'CURRENT_URL:')
        URL = messageString[13..]
        handleNewURL(URL)
    else if (messageString == 'GET_CURRENT_SIDEBAR_URL')
        handleGetCurrentSidebarURL(sendResponse)
        
handleSidebarEnabled = (sender, sendResponseFunction) ->
    tabId = sender.tab.id
    sidebarEnabled = sessionStorage["sidebar.tab[#{tabId}].enabled"] == 'true'
    sendResponseFunction(sidebarEnabled)

handleNewURL = (url) ->
    sessionStorage["sidebar.lastUrl"] = url
    
handleGetCurrentSidebarURL = (sendResponseFunction) ->
    url = sessionStorage["sidebar.lastUrl"]
    sendResponseFunction(url)