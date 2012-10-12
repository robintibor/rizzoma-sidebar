# Listen to brower action icon click :)
chrome.browserAction.onClicked.addListener( ->
        getSidebarStatus(toggleRizzomaSidebar)
)

getSidebarStatus = (callback) ->
    chrome.tabs.getSelected((tab) -> getSidebarStatusForTab(tab, callback))

getSidebarStatusForTab = (tab, callback) ->
    tabId = tab.id
    if (sessionStorage["sidebar.tab[#{tabId}].enabled"] == 'true')
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
    sessionStorage["sidebar.tab[#{tabId}].enabled"] = 'true'

loadRizzomaSidebar = ->
    chrome.tabs.executeScript(null, {file: "js/current-page/load-sidebar-if-enabled.js"})

disableRizzomaSidebar = (tabId) ->
    sessionStorage["sidebar.tab[#{tabId}].enabled"] = 'false'

removeRizzomaSidebar = ->
    chrome.tabs.executeScript(null, {file: "js/remove-sidebar.js"})



