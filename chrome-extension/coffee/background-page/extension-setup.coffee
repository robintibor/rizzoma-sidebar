# Listen to brower action icon click :)
chrome.browserAction.onClicked.addListener( ->
    toggleSidebarInCurrentTab()
)

toggleSidebarInCurrentTab = ->
    getActiveTabId((tabId) ->
        askIfSideBarIsOpen(tabId, removeShowOrLoadSidebar)
    )

getActiveTabId = (callback) ->
    chrome.tabs.query(
        {
            active: true,
            currentWindow:true
        },
        (selectedTabs) ->
            callback(selectedTabs[0].id)
    )
            

askIfSideBarIsOpen = (tabId, callback) ->
    chrome.tabs.sendMessage(tabId, "IS_SIDEBAR_OPEN?",
        (sidebarState) ->
            callback(sidebarState)
    )

removeShowOrLoadSidebar = (sidebarState) ->
    if (sidebarState.visible)
        console.log("sidebar visible")
        removeSidebar()
    else if (sidebarState.inserted)
        console.log("sidebar inserted")
    else
        loadSidebar()
        console.log("sidebar not inserted")

loadSidebar = ->
    # first load jquery, then own script...
    chrome.tabs.executeScript(null, { file: "js/lib/jquery-1.8.2.js" }, () -> 
        chrome.tabs.insertCSS(null, { file: "css/current-page/toggle-bar.css" }, () ->
            chrome.tabs.executeScript(null, { file: "js/current-page/load-sidebar.js" } )
        )
    )

removeSidebar =->
    chrome.tabs.executeScript(null, { file: "js/lib/jquery-1.8.2.js" }, () -> 
        chrome.tabs.executeScript(null, { file: "js/current-page/remove-sidebar.js" }
        )
    )

chrome.tabs.onUpdated.addListener(
    (tabId, changeInfo, tab) ->
        if (tab.active)
            insertInvisibleSidebar()
       # console.log("updated tab #{tabId}", tab, changeInfo)
    #    console.log("active: #{tab.active}")
);

insertInvisibleSidebar = () ->
    console.log("inserting invisible sidebar")
    loadSidebar()
    """
    chrome.tabs.insertCSS(null, { code: "body { background-color: yellow;}" }, 
        () ->
            loadSidebar()
    )"""

