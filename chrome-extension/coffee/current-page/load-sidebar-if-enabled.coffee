sidebarAlreadyPresentOnPage = ->
    sidebar = document.getElementById('rizzomaSidebarIFrame')
    return sidebar != null

showSideBar = ->
    $('#rizzomaSidebarIFrame').show()

loadRizzomaSidebar= (url) ->
    rizzomaIFrame = document.createElement('iframe')
    rizzomaIFrame.src = url
    rizzomaIFrame.id = 'rizzomaSidebarIFrame'
    rizzomaIFrame.style.position = 'fixed'
    rizzomaIFrame.style.top = '0px'
    rizzomaIFrame.style.right = '0px'
    rizzomaIFrame.style.height = '100%'
    rizzomaIFrame.style.width = '35%'
    rizzomaIFrame.style.zIndex = 2147483647
    document.body.appendChild(rizzomaIFrame)

checkIfSidebarIsEnabledAndShowIt = ->
    chrome.extension.sendMessage('IS_SIDEBAR_ENABLED_FOR_THIS_TAB',
        (isSidebarEnabled) ->
            if (isSidebarEnabled)
                chrome.extension.sendMessage('GET_CURRENT_SIDEBAR_URL',
                    (url) -> 
                        if (not url?)
                            url = 'https://rizzoma.com/topic/?mode=mobile'
                        loadRizzomaSidebar(url)
                )
    )

if (sidebarAlreadyPresentOnPage())
    showSideBar()
else
    checkIfSidebarIsEnabledAndShowIt()