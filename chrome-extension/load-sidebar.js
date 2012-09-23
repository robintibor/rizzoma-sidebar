console.log('load rizzoma sidebar!')
function isRizzomaSidebarEnabled(callbackIfEnabled) {
    chrome.storage.local.get('rizzomaSidebarEnabled', function(result) {
    // Notify that we saved.
    if (result.rizzomaSidebarEnabled === true) {
        callbackIfEnabled();
    }
  });
}

function loadRizzomaSidebar() {
    document.body.appendChild(document.createElement('script')).src='https://raw.github.com/robintibor/rizzoma-sidebar/master/init.js';
}

function getLastRizzomaTopicURL() {

}

isRizzomaSidebarEnabled(loadRizzomaSidebar);
