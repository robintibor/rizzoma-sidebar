chrome.extension.onMessage.addListener((messageString, sender, sendResponse) ->
    handleMessage(messageString, sender, sendResponse)
)

handleMessage = (messageString, sender, sendResponse) ->
    if (messageString[..11] == 'CURRENT_URL:')
        URL = messageString[13..]
        handleNewURL(URL)
    else if (messageString == 'GET_CURRENT_SIDEBAR_URL')
        handleGetCurrentSidebarURL(sendResponse)
    else if (messageString == "TRACK_SIDEBAR_PAGEVIEW")
        trackPageViewFromSidebarIFrame()

handleNewURL = (url) ->
    sessionStorage["sidebar.lastUrl"] = url
    
handleGetCurrentSidebarURL = (sendResponseFunction) ->
    url = sessionStorage["sidebar.lastUrl"]
    sendResponseFunction(url)

trackPageViewFromSidebarIFrame = ->
    # this should work since google analytics already included by background page 
    # (even with correct Account ID)...
    _gaq.push(['_trackPageview', '/sidebar_extension/sidebar_iframe.html'])
