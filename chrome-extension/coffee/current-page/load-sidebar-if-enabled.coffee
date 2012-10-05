loadRizzomaSidebar= () ->
    document.body.appendChild(document.createElement('script')).src='https://raw.github.com/robintibor/rizzoma-sidebar/master/init.js';

chrome.extension.onMessage.addListener((messageString, sender) ->
    alert("got message" + messageString);
    console.log("got message:", messageString)
)

chrome.extension.sendMessage('IS_SIDEBAR_ENABLED_FOR_THIS_TAB',
    (isSidebarEnabled) ->
        if (isSidebarEnabled)
            loadRizzomaSidebar()
)