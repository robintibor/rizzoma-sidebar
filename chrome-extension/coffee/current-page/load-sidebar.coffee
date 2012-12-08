sidebarAlreadyPresentOnPage = ->
    sidebar = document.getElementById('rizzomaSidebar')
    return sidebar != null

getURLAndLoadSidebar = ->
    chrome.extension.sendMessage('GET_CURRENT_SIDEBAR_URL',
        (sidebarURL) -> 
            if (not sidebarURL?)
                sidebarURL = 'https://rizzoma.com/topic/a8700fe865f677f7571d5b171c21492d/'
            loadRizzomaSidebar(sidebarURL)
    )

loadRizzomaSidebar= (url) ->
    if (sidebarAlreadyPresentOnPage())
        return
    addSidebarToPage(url)
    toggleSidebarOnClick()
    resizePDFIfWeAreLookingAtPDF()

addSidebarToPage = (url) ->
    rizzomaSidebarDiv = $("
        <div id='rizzomaSidebarMaximizer' class='rizzomaSidebarToggle rizzomaSidebarToggleOpen'> </div>
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

lastUserActivity = -1

loadSidebarAfterTimeWithoutUserActivity = ->
    $(document).on('scroll.rizzomasidebar mousedown.rizzomasidebar keypress.rizzomasidebar', 
        () ->
            lastUserActivity = Date.now()
    )
    setTimeout(loadSidebarIfNoScrollHappened, 4000)

loadSidebarIfNoScrollHappened = ->
    milliSecSinceLastUserActivity = (Date.now() - lastUserActivity) 
    if (milliSecSinceLastUserActivity > 4000)
        $(document).off('.rizzomasidebar')
        if (insertingInvisibleSidebar) # could be turned off from outside :)
            getURLAndLoadSidebar()
    else
        setTimeout(loadSidebarIfNoScrollHappened, 400 - milliSecSinceLastUserActivity)

if (not sidebarAlreadyPresentOnPage())
    if (insertingInvisibleSidebar? and insertingInvisibleSidebar == true) # this variable is set to true from outside, from extension-setup.coffee :)
        loadSidebarAfterTimeWithoutUserActivity()
    else
        getURLAndLoadSidebar()