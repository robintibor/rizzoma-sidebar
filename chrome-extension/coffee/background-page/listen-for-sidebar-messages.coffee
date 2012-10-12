chrome.extension.onMessage.addListener((messageString, sender, sendResponse) ->
    handleMessage(messageString, sender, sendResponse)
)

handleMessage = (messageString, sender, sendResponse) ->
    alert("message: #{messageString}")
    if (messageString == 'IS_SIDEBAR_ENABLED_FOR_THIS_TAB')
        handleSidebarEnabled(sender, sendResponse)
    else if (messageString[..11] == 'CURRENT_URL:')
        URL = messageString[13..]
        handleNewURL(URL, sender)
        
handleSidebarEnabled = (sender, sendResponseFunction) ->
    console.log("asking if sidebar is enabled!", sender)
    tabId = sender.tab.id
    sidebarEnabled = sessionStorage["sidebar.tab[#{tabId}].enabled"] == 'true'
    sendResponseFunction(sidebarEnabled)

handleNewURL = (url, sender) ->
    tabId = sender.tab.id
    sessionStorage["sidebar.tab[#{tabId}].lastUrl"] = url