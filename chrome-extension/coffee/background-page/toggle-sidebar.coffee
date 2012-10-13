# Listen to brower action icon click :)
chrome.browserAction.onClicked.addListener( ->
        getSelectedTab(toggleRizzomaSidebar)
)

getSelectedTab = (callback) ->
    chrome.tabs.getSelected(callback)

toggleRizzomaSidebar = (tab) ->
    console.log("toggling tab: #{tab}")
    tabId = tab.id
    if (sideBarIsEnabledForTab(tabId))
        console.log("disabling tab: #{tab}")
        disableRizzomaSidebar(tabId)
        hideRizzomaSideBar()
    else
        console.log("enabling tab: #{tab}")
        enableRizzomaSideBar(tabId)
        loadRizzomaSidebar()

sideBarIsEnabledForTab = (tabId) ->
    return sessionStorage["sidebar.tab[#{tabId}].enabled"] == 'true'

enableRizzomaSideBar = (tabId) ->
    sessionStorage["sidebar.tab[#{tabId}].enabled"] = 'true'

disableRizzomaSidebar = (tabId) ->
    sessionStorage["sidebar.tab[#{tabId}].enabled"] = 'false'

loadRizzomaSidebar = ->
    chrome.tabs.executeScript(null, {file: "js/current-page/load-sidebar.js"})

hideRizzomaSideBar = ->
    chrome.tabs.executeScript(null, {file: "js/hide-sidebar.js"})



