# Listen to brower action icon click :)
chrome.browserAction.onClicked.addListener( ->
        toggleSidebar()
)

toggleSidebar = ->
    # first load jquery, then own script...
    chrome.tabs.executeScript(null, { file: "js/lib/jquery-1.8.2.js" }, () -> 
        chrome.tabs.insertCSS(null, { file: "css/current-page/toggle-bar.css" }, () ->
            chrome.tabs.executeScript(null, { file: "js/current-page/toggle-sidebar.js" } )
        )
    )
