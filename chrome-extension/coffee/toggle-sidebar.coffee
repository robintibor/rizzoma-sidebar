# Listen to brower action icon click :)
chrome.browserAction.onClicked.addListener( ->
        getSidebarStatus(toggleRizzomaSidebar)
)

getSidebarStatus = (callback) ->
    chrome.tabs.getSelected((tab) -> getSidebarStatusForTab(tab, callback))

getSidebarStatusForTab = (tab, callback) ->
    tabId = tab.id
    if (localStorage["sidebarEnabled:tab#{tabId}"] == 'true')
        callback(true, tabId)
    else
        callback(false, tabId)

toggleRizzomaSidebar = (rizzomaSidebarEnabled, tabId) ->
    if (rizzomaSidebarEnabled == true)
        disableRizzomaSidebar(tabId)
        removeRizzomaSidebar()
    else
        enableRizzomaSidebar(tabId)
        loadRizzomaSidebar()

enableRizzomaSidebar = (tabId) ->
    localStorage["sidebarEnabled:tab#{tabId}"] = 'true'

loadRizzomaSidebar = ->
    chrome.tabs.executeScript(null, {file: "js/load-sidebar.js"})

disableRizzomaSidebar = (tabId) ->
    localStorage["sidebarEnabled:tab#{tabId}"] = 'false'

removeRizzomaSidebar = ->
    chrome.tabs.executeScript(null, {file: "js/remove-sidebar.js"})



