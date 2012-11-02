checkThatYouAreTheSidebar = ->
    return (window.name == 'rizzomaSidebarIFrame')

applyStylesToMakeRizzomaFitIntoSidebar = ->
    minimizeTopicListIfOpen()
    appendCSSToFitIntoSidebar()

minimizeTopicListIfOpen = ->
    console.log("checking topic list");
    if (topicListExists())
        minimizeTopicList()
    else
        setTimeout(minimizeTopicListIfOpen, 50)

topicListExists = ->
    return $('.js-topics.active').length > 0

minimizeTopicList = ->
    # click on topic list to minimize it!
    $('.js-topics.active').click()

appendCSSToFitIntoSidebar = ->
    # apply local css file from extension!
    cssLocation = chrome.extension.getURL('css/current-page/rizzomaIFrame.css')
    $('head').append("<link rel='stylesheet' href='#{cssLocation}' type='text/css' />")
        
console.log("URL!!:", chrome.extension.getURL('ohyes.png'))
if (checkThatYouAreTheSidebar())
    applyStylesToMakeRizzomaFitIntoSidebar()