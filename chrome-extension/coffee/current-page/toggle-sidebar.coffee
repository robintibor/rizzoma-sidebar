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
    #makeSidebarResizable()

addSidebarToPage = (url) ->
    rizzomaSidebarDiv = $("<div id='rizzomaSidebar'>
        <iframe src='#{url}' id='rizzomaSidebarIFrame'> </iframe>
        <div id='rizzomaSidebarToggle'> </div>
    </div>")
    $('body').append(rizzomaSidebarDiv)
    
toggleSidebarOnClick = ->
    $('#rizzomaSidebarToggle').click(() ->
        $('#rizzomaSidebarIFrame').toggle()
        resizePDFIfWeAreLookingAtPDF())

resizePDFIfWeAreLookingAtPDF = ->
    if(weAreLookingAtPdf())
        resizePDFForSidebar()

weAreLookingAtPdf = ->
    return $('embed').length == 1 and $('embed').eq(0).attr('type') == 'application/pdf'

resizePDFForSidebar = ->
    sidebarExists = $('#rizzomaSidebarIFrame').length == 1
    sidebarVisible = $('#rizzomaSidebarIFrame').css('display') == 'block'
    if (sidebarExists and sidebarVisible)
        $('body').css('width', '64%')
    else if (sidebarExists)
        $('body').css('width', '98%')
    else
        $('body').css('width', '100%')
###
makeSidebarResizable = ->
    $('#rizzomaSidebar').mousedown(resizeSidebarOnMouseMove)
    $('#rizzomaSidebar').mouseup(dontResizeSidebarOnMouseMove)

resizeSidebarOnMouseMove = ->
    $('#rizzomaSidebar').mousemove(resizeSidebarToMouseCursor)

resizeSidebarToMouseCursor = (event) ->
    newWidth = $(window).width() + $(window).scrollLeft() - event.clientX + 10
    $('#rizzomaSidebar').css('width', "#{newWidth}px")
    console.log("newWidth #{newWidth}")
    console.log("mouse move", event)

dontResizeSidebarOnMouseMove = ->
    console.log("unbinding mouse move event")
    $('#rizzomaSidebar').off('mousemove')
###

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
    
    