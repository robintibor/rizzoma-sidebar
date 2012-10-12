getHighestZIndex = ->
    allElements = document.getElementsByTagName("*")
    maxZIndex = 0
    for element in allElements
         zIndex = parseInt(element.style.zIndex)
         if (zIndex > maxZIndex)
            maxZIndex = zIndex
    return maxZIndex

loadRizzomaSidebar= () ->
    rizzomaIFrame = document.createElement('iframe')
    rizzomaIFrame.src = 'http://rizzoma.com/topic/?mode=mobile'
    rizzomaIFrame.id = 'rizzomaSidebarIFrame'
    rizzomaIFrame.style.position = 'fixed'
    rizzomaIFrame.style.top = '0px'
    rizzomaIFrame.style.right = '0px'
    rizzomaIFrame.style.height = '100%'
    rizzomaIFrame.style.width = '35%'
    rizzomaIFrame.style.zIndex = getHighestZIndex()
    document.body.appendChild(rizzomaIFrame)

chrome.extension.sendMessage('IS_SIDEBAR_ENABLED_FOR_THIS_TAB',
    (isSidebarEnabled) ->
        console.log("sidebar is enabled: #{isSidebarEnabled}")
        if (isSidebarEnabled)
            loadRizzomaSidebar()
)