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
        <!-- google analytics script!! :)) -->
        <script type='text/javascript'>
              var _gaq = _gaq || [];
              _gaq.push(['_setAccount', 'UA-22635528-7']);
              _gaq.push(['_trackPageview']);
            
              (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
              })();
            
            </script>
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
                introductionTopicURL = 'https://rizzoma.com/topic/a8700fe865f677f7571d5b171c21492d/'
                sidebarURL = introductionTopicURL
            loadRizzomaSidebar(sidebarURL)
    )

if (sidebarAlreadyPresentOnPage())
    removeSideBar()
else
    getURLAndLoadSidebar()
    
    