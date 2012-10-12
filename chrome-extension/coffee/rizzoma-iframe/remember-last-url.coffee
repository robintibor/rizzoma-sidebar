console.log('loaded last url js!')
console.log('last url', sessionStorage['lastURL'])
# we already know that we are on rizzoma.com, so lets check if we are in iframe
checkThatYouAreTheSidebar = ->
    return (window.name == 'rizzomaSidebarIFrame')
    
rememberLastUrlOnChange = ->
    window.onbeforeunload = () ->
        chrome.extension.sendMessage("CURRENT_URL: #{window.location.href}?mode=mobile")
        return undefined

if (checkThatYouAreTheSidebar())
    rememberLastUrlOnChange()
    