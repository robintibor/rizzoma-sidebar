chrome.extension.onMessage.addListener((messageString, sender, sendResponse) ->
    handleMessage(messageString, sender, sendResponse)
)

handleMessage = (messageString, sender, sendResponse) ->
    if (messageString == 'IS_SIDEBAR_ENABLED_FOR_THIS_TAB')
        console.log("asking if sidebar is enabled!", sender)
        tabId = sender.tab.id
        sidebarEnabled = localStorage["sidebarEnabled:tab#{tabId}"] == 'true'
        sendResponse(sidebarEnabled)