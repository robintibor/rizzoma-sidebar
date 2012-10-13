sidebarAlreadyPresentOnPage = ->
    sidebar = document.getElementById('rizzomaSidebar')
    return sidebar != null

removeSideBar = -> 
    $('#rizzomaSidebar').remove()
    
loadRizzomaSidebar= (url) ->
    addSidebarToPage(url)
    toggleSidebarOnClick()
    makeSidebarResizable()

addSidebarToPage = (url) ->
    rizzomaSidebarDiv = $("<div id='rizzomaSidebar'>
        <iframe src='#{url}' id='rizzomaSidebarIFrame'> </iframe>
        <div id='rizzomaSidebarToggle'> </div>
    </div>")
    $('body').append(rizzomaSidebarDiv)
    
toggleSidebarOnClick = ->
    $('#rizzomaSidebarToggle').click(() ->
        $('#rizzomaSidebarIFrame').toggle())

makeSidebarResizable = ->

getURLAndLoadSidebar = ->
    chrome.extension.sendMessage('GET_CURRENT_SIDEBAR_URL',
        (url) -> 
            if (not url?)
                url = 'https://rizzoma.com/topic/?mode=mobile'
            loadRizzomaSidebar(url)
    )

if (sidebarAlreadyPresentOnPage())
    removeSideBar()
else
    getURLAndLoadSidebar()
    
    