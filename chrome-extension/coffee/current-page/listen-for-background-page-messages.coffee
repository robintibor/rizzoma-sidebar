chrome.extension.onMessage.addListener((messageString, sender, sendResponse) ->
    handleMessage(messageString, sender, sendResponse)
)

handleMessage = (messageString, sender, sendResponse) ->
    if (messageString == 'IS_SIDEBAR_OPEN?')
        sidebarStatus = determineSidebarStatus()
        sendResponse(sidebarStatus)
            
determineSidebarStatus = ->
    sidebar = $('#rizzomaSidebar')
    sidebarExists =  sidebar.length > 0
    if (sidebarExists)
        barForOpeningSidebar = $('#rizzomaSidebarMaximizer')
        sidebarIsVisible = sidebar.is(":visible") or
            barForOpeningSidebar.is(":visible")
    else
        sidebarIsVisible = false
    return {
        visible: sidebarIsVisible,
        inserted: sidebarExists
    }