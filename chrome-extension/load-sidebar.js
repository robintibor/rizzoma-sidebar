console.log('load rizzoma sidebar!!')
function isRizzomaSidebarEnabled(callbackIfEnabled) {
    chrome.storage.local.get('rizzomaSidebarEnabled', function(result) {
    // Notify that we saved.
    if (result.rizzomaSidebarEnabled === true) {
        callbackIfEnabled();
    }
  });
}

function loadRizzomaSidebar() {
    chrome.extension.sendMessage('request from contentscript load sidebar')
    document.body.appendChild(document.createElement('script')).src='https://raw.github.com/robintibor/rizzoma-sidebar/master/init.js';
        /*var node = 
            document.adoptNode(bg.document.getElementById("ContentBlock1"), 
            true); */
    setTimeout(testAccessingIFrame, 1000)
}

function testAccessingIFrame() {
    sidebarIFrame = document.getElementById('rizzomaSidebarIFrame');
    console.log('iframe', sidebarIFrame);
}

function getLastRizzomaTopicURL() {

}

isRizzomaSidebarEnabled(loadRizzomaSidebar);
