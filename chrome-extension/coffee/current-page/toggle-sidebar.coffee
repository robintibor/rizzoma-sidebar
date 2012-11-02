sidebarAlreadyPresentOnPage = ->
    sidebar = document.getElementById('rizzomaSidebar')
    return sidebar != null

removeSideBar = -> 
    $('#rizzomaSidebar').remove()
    resizePDFIfWeAreLookingAtPDF()
    
loadRizzomaSidebar= (url) ->
    addSidebarToPage(url)
    toggleSidebarOnClick()
    resizePDFIfWeAreLookingAtPDF()

addSidebarToPage = (url) ->
    rizzomaSidebarDiv = $("
        <div class='rizzomaSidebarToggle rizzomaSidebarToggleOpen'> </div>
        <div id='rizzomaSidebar'>
        <iframe src='#{url}' id='rizzomaSidebarIFrame'> </iframe>
        <div class='rizzomaSidebarToggle rizzomaSidebarToggleClose'> </div>
    </div>
    ")
    $('body').append(rizzomaSidebarDiv)
    
toggleSidebarOnClick = ->
    $('.rizzomaSidebarToggleClose').click(() ->
        toggleSidebar()
    )
    
    $('.rizzomaSidebarToggleOpen').click(() ->
        toggleSidebar()
    )

toggleSidebar = ->
    $('#rizzomaSidebar').toggle()
    resizePDFIfWeAreLookingAtPDF()
    # This sidebar is only there when sidebar is closed and is used to open it again!
    $('.rizzomaSidebarToggleOpen').toggle()

resizePDFIfWeAreLookingAtPDF = ->
    if (weAreLookingAtPdf())
        resizePDFForSidebar()

weAreLookingAtPdf = ->
    return $('embed').length == 1 and 
    $('embed').eq(0).attr('type') == 'application/pdf'

resizePDFForSidebar = ->
    sidebarExists = $('#rizzomaSidebarIFrame').length == 1
    sidebarVisible = $('#rizzomaSidebar').css('display') == 'block'
    if (sidebarExists and sidebarVisible)
        $('body').css('width', '54%')
    else if (sidebarExists)
        $('body').css('width', '98%')
    else
        $('body').css('width', '100%')

getURLAndLoadSidebar = ->
    chrome.extension.sendMessage('GET_CURRENT_SIDEBAR_URL',
        (sidebarURL) -> 
            if (not sidebarURL?)
                sidebarURL = 'https://rizzoma.com/topic/'
            loadRizzomaSidebar(sidebarURL)
    )

if (sidebarAlreadyPresentOnPage())
    removeSideBar()
else
    getURLAndLoadSidebar()
    
    