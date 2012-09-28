chrome.extension.onMessage.addListener((messageString, sender) ->
    handleMessage(messageString, sender)
)

handleMessage = (messageString, sender) ->
    if (messageString == 'IS_SIDEBAR_ENABLED')
        console.log('asking if sidebar is enabled!')