# we already know that we are on rizzoma.com, so lets check if we are in iframe
checkThatYouAreTheSidebar = ->
    return (window.name == 'rizzomaSidebarIFrame')

trackPageViewFromSidebarIFrame = ->
    chrome.extension.sendMessage("TRACK_SIDEBAR_PAGEVIEW");

if (checkThatYouAreTheSidebar())
    trackPageViewFromSidebarIFrame()