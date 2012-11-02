checkThatYouAreTheSidebar = ->
    return (window.name == 'rizzomaSidebarIFrame')

applyStylesToMakeRizzomaFitIntoSidebar = ->
    minimizeTopicListIfOpen()
    appendCSSToFitIntoSidebar()

minimizeTopicListIfOpen = ->
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
    cssLocation = chrome.extension.getURL('css/current-page/rizzoma-i-frame.css')
    $('head').append("<link rel='stylesheet' href='#{cssLocation}' type='text/css' />")
        
if (checkThatYouAreTheSidebar())
    applyStylesToMakeRizzomaFitIntoSidebar()