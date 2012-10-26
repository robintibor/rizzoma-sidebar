lastURL = window.location.href
# we already know that we are on rizzoma.com, so lets check if we are in iframe
checkThatYouAreTheSidebar = ->
    return (window.name == 'rizzomaSidebarIFrame')

updateURLIfChanged = ->
    if (lastURL != window.location.href)
        lastURL = window.location.href
        sendCurrentMobileURLToExtension()

sendCurrentMobileURLToExtension = ->
    chrome.extension.sendMessage("CURRENT_URL: #{window.location.href}")

rememberLastUrlOnChange = ->
    setInterval(updateURLIfChanged, 100)
    window.onbeforeunload = () ->
        sendCurrentMobileURLToExtension()
        return undefined

if (checkThatYouAreTheSidebar())
    rememberLastUrlOnChange()
    