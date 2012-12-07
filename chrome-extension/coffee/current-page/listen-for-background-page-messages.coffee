chrome.extension.onMessage.addListener((messageString, sender, sendResponse) ->
    handleMessage(messageString, sender, sendResponse)
)

handleMessage = (messageString, sender, sendResponse) ->
    if (messageString == 'IS_SIDEBAR_OPEN?')
        sidebarStatus = determineSidebarStatus()
        console.log("sidebar open asked")
        sendResponse(sidebarStatus)
            
determineSidebarStatus = ->
    sidebar = document.getElementById('rizzomaSidebar')
    sidebarExists =  sidebar != null
    if (sidebarExists)
        barForClosingSidebar = document.getElementById('rizzomaSidebarMinimizer')
        sidebarIsVisible = sidebar.style.display != 'none' or
            barForClosingSidebar.style.display != 'none'
    else
        sidebarIsVisible = false
    return {
        visible: sidebarIsVisible,
        inserted: sidebarExists
    }