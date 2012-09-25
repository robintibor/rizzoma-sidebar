// Called when the url of a tab changes.
function disableRizzomaSidebar(callback) {
    chrome.storage.local.set({'rizzomaSidebarEnabled' : false}, callback)
}

function enableRizzomaSidebar(callback) {
    chrome.storage.local.set({'rizzomaSidebarEnabled' : true}, callback)
}

function loadRizzomaSidebar() {
    chrome.tabs.executeScript(
      null, {file: "load-sidebar.js"});
}

function removeRizzomaSidebar() {
    sidebarIFrame = document.getElementById('rizzomaSidebarIFrame');
    sidebarIFrame.parent.removeChildren(sidebarIFrame);
}

function toggleRizzomaSidebar(rizzomaSidebarEnabledObj) {
    var rizzomaSidebarEnabled = rizzomaSidebarEnabledObj.rizzomaSidebarEnabled
    if (rizzomaSidebarEnabled === true) {
        disableRizzomaSidebar(removeRizzomaSidebar)
    }
    else {
        enableRizzomaSidebar(loadRizzomaSidebar)
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