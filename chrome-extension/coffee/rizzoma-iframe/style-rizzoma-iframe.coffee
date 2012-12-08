checkThatYouAreTheSidebar = ->
    return (window.name == 'rizzomaSidebarIFrame')

applyStylesToMakeRizzomaFitIntoSidebar = ->
    minimizeTopicListIfOpen()
    minimizeTopicListOnClickOfTopic()
    appendCSSToFitIntoSidebar()

minimizeTopicListIfOpen = ->
    if (topicTabExists())
        minimizeTopicList()
    else
        setTimeout(minimizeTopicListIfOpen, 50)

minimizeTopicListOnClickOfTopic = () ->
    $(document).on('click', 'a.js-search-result', () ->
        $('.js-topics.active').click()
    )

topicTabExists = ->
    return $('.js-topics.tab').length > 0

minimizeTopicList = ->
    # click on topic list to minimize it!
    $('.js-topics.active').click()

appendCSSToFitIntoSidebar = ->
    # apply local css file from extension!
    cssLocation = chrome.extension.getURL('css/current-page/rizzoma-i-frame.css')
    $('head').append("<link rel='stylesheet' href='#{cssLocation}' type='text/css' />")
        
if (checkThatYouAreTheSidebar())
    applyStylesToMakeRizzomaFitIntoSidebar()