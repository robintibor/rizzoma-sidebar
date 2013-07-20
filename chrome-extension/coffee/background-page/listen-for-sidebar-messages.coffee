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
    localStorage["sidebar.lastUrl"] = url
    
handleGetCurrentSidebarURL = (sendResponseFunction) ->
    url = getCurrentSidebarURL()
    sendResponseFunction(url)

getCurrentSidebarURL = ->
    if localStorage["sidebar.lastUrl"]?
        return localStorage["sidebar.lastUrl"]
    else
        introductionTopicURL = 'https://rizzoma.com/topic/a8700fe865f677f7571d5b171c21492d/'
        return introductionTopicURL

trackPageViewFromSidebarIFrame = ->
    # this should work since google analytics already included by background page 
    # (even with correct Account ID)...
    _gaq.push(['_trackPageview', '/sidebar_extension/sidebar_iframe.html'])
