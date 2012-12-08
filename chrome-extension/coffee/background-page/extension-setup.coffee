# Listen to brower action icon click :)
lastActiveTabId = null
lastTimeOfIconClick = 0

chrome.browserAction.onClicked.addListener( ->
    rememberThatUserClickedIcon()
    toggleSidebarInCurrentTab()
)

rememberThatUserClickedIcon = ->
    if (userClickedIconFirstTime())
        setUpHandlersForInsertingInvisibleSidebar()
    lastTimeOfIconClick = Date.now()

userClickedIconFirstTime = ->
    return lastTimeOfIconClick == 0

toggleSidebarInCurrentTab = ->
    getSidebarStatus(removeShowOrLoadSidebar)

getSidebarStatus = (callback) ->
    getActiveTabId((tabId) ->
        askIfSideBarIsOpen(tabId, callback)
    )
        
getActiveTabId = (callback) ->
    chrome.tabs.query(
        {
            active: true,
            currentWindow:true
            url: "*://*/*"
        },
        (selectedTabs) ->
            if (selectedTabs.length > 0)
                callback(selectedTabs[0].id)
            else
                callback(null)
    )

askIfSideBarIsOpen = (tabId, callback) ->
    if (tabId?)
        chrome.tabs.sendMessage(tabId, "IS_SIDEBAR_OPEN?",
            (sidebarState) ->
                callback(sidebarState)
        )
    else
        callback({noSiteForSidebar: true})

removeShowOrLoadSidebar = (sidebarState) ->
    if (sidebarState.noSiteForSidebar?)
        return
    else if (sidebarState.visible)
        removeSidebar()
    else if (sidebarState.inserted)
        showSidebar()
    else
        insertingSidebarDirectly()

insertingSidebarDirectly = ->
    chrome.tabs.executeScript(null, { code: "insertingInvisibleSidebar = false" }, () ->
        chrome.tabs.insertCSS(null, { code: "#rizzomaSidebar { display: block;}" },
            loadSidebar
        )
    )
    

loadSidebar = ->
    # first load jquery, then own script...
    chrome.tabs.executeScript(null, { file: "js/lib/jquery-1.8.2.js" }, () -> 
        chrome.tabs.insertCSS(null, { file: "css/current-page/toggle-bar.css" }, () ->
            chrome.tabs.executeScript(null, { file: "js/current-page/load-sidebar.js" } )
        )
    )

showSidebar = ->
    chrome.tabs.insertCSS(null, { code: "#rizzomaSidebar { display: block;}" })

removeSidebar =->
    chrome.tabs.executeScript(null, { file: "js/lib/jquery-1.8.2.js" }, () -> 
        chrome.tabs.executeScript(null, { file: "js/current-page/remove-sidebar.js" }
        )
    )

setUpHandlersForInsertingInvisibleSidebar = ->
    setUpHandlerWhenCurrentTabIsUpdated()
    setUpHandlerWhenNewTabIsActivated()

setUpHandlerWhenCurrentTabIsUpdated = ->
  chrome.tabs.onUpdated.addListener(
        (tabId, changeInfo, tab) ->
            if (userHasClickedIconRecently() and tab.active and changeInfo.status == 'complete')
                insertSidebarIfNotPresent()
    )

userHasClickedIconRecently = ->
    minutesSinceLastIconClick = (Date.now() - lastTimeOfIconClick) / (60 * 1000)
    return minutesSinceLastIconClick < 10

insertSidebarIfNotPresent = ->
    getSidebarStatus(checkIfSidebarShouldBePreloaded)

checkIfSidebarShouldBePreloaded = (sidebarStatus) ->
    if (not sidebarStatus.inserted)
        insertInvisibleSidebar()
    
insertInvisibleSidebar = () ->
    chrome.tabs.insertCSS(null, { code: "#rizzomaSidebar { display: none;}" }, () ->
        chrome.tabs.executeScript(null, { code: "insertingInvisibleSidebar = true" },
            loadSidebar
        )
    )

setUpHandlerWhenNewTabIsActivated = ->
    chrome.tabs.onActivated.addListener(
        (tabInfo) ->
            if (userHasClickedIconRecently())
                insertSidebarIfNotPresent()
                removeInvisibleSidebarFromLastActiveTab(tabInfo.tabId)
                lastActiveTabId = tabInfo.tabId
    )

removeInvisibleSidebarFromLastActiveTab = (activeTabId) ->
    previousTabBecameInactive = (lastActiveTabId != null and lastActiveTabId != activeTabId)
    if (previousTabBecameInactive)
        removeInvisibleSidebarFromTab(lastActiveTabId)

removeInvisibleSidebarFromTab = (tabId) ->
   chrome.tabs.executeScript(tabId, { file: "js/lib/jquery-1.8.2.js" }, () -> 
        chrome.tabs.executeScript(tabId, { code: 
            "insertingInvisibleSidebar = false;
            if (!$('#rizzomaSidebar, #rizzomaSidebarMaximizer').is(':visible')) {
                 $('#rizzomaSidebar, #rizzomaSidebarMaximizer').remove();}" }
        )
    )
    
