// Called when the url of a tab changes.
function disableRizzomaSidebar() {
    chrome.storage.local.set({'rizzomaSidebarEnabled' : false}, null)
}

function enableRizzomaSidebar() {
    chrome.storage.local.set({'rizzomaSidebarEnabled' : true}, null)
}

function loadRizzomaSidebar() {
    chrome.tabs.executeScript(
      null, {file: "load-sidebar.js"});
}

function removeRizzomaSidebar() {
    
}

function toggleRizzomaSidebar(rizzomaSidebarEnabledObj) {
    var rizzomaSidebarEnabled = rizzomaSidebarEnabledObj.rizzomaSidebarEnabled
    if (rizzomaSidebarEnabled === true) {
        disableRizzomaSidebar()
        removeRizzomaSidebar()
    }
    else {
        enableRizzomaSidebar()
        loadRizzomaSidebar()
    }
  // If the letter 'g' is found in the tab's URL...
}

function getSidebarStatus(callback) {
    chrome.storage.local.get('rizzomaSidebarEnabled', callback)
};

chrome.browserAction.onClicked.addListener(
    function() {
        getSidebarStatus(toggleRizzomaSidebar)
    }
);