removeSidebar = -> 
    $('#rizzomaSidebar').remove()
    $('#rizzomaSidebarMaximizer').remove()
    resizePDFIfWeAreLookingAtPDF()

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

removeSidebar()