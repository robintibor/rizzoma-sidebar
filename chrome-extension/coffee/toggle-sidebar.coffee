# Called when the url of a tab changes.
disableRizzomaSidebar = (tabId) ->
    localStorage["sidebarEnabled:tab#{tabId}"] = 'false'

enableRizzomaSidebar = (tabId) ->
    localStorage["sidebarEnabled:tab#{tabId}"] = 'true'

loadRizzomaSidebar = ->
    chrome.tabs.executeScript(null, {file: "js/load-sidebar.js"})

removeRizzomaSidebar = ->
    sidebarIFrame = document.getElementById('rizzomaSidebarIFrame');
    sidebarIFrame.parent.removeChildren(sidebarIFrame);

toggleRizzomaSidebar = (rizzomaSidebarEnabled, tabId) ->
    if (rizzomaSidebarEnabled == true)
        disableRizzomaSidebar(tabId)
        removeRizzomaSidebar()
    else
        enableRizzomaSidebar(tabId)
        loadRizzomaSidebar()

getSidebarStatusForTab = (tab, callback) ->
    tabId = tab.id
    if (localStorage["sidebarEnabled:tab#{tabId}"] == 'true')
        callback(true, tabId)
    else
        callback(false, tabId)

getSidebarStatus = (callback) ->
    chrome.tabs.getSelected((tab) -> getSidebarStatusForTab(tab, callback))

chrome.browserAction.onClicked.addListener( ->
        getSidebarStatus(toggleRizzomaSidebar)
)