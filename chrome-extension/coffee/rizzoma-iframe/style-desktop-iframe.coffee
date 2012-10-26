checkThatYouAreTheSidebar = ->
    return (window.name == 'rizzomaSidebarIFrame')

applyStylesToMakeRizzomaFitIntoSidebar = ->
    minimizeTopicListIfOpen()
    shrinkEditorSizeOnceEditorLoaded()

minimizeTopicListIfOpen = ->
    $(document).ready( ->
        $('.js-topics.active').click()
    )

shrinkEditorSizeOnceEditorLoaded = ->
    if ($('.js-wave-blips').length > 0)
        $('.js-wave-blips').width('440px')
    else
        setTimeout(shrinkEditorSizeOnceEditorLoaded, 50)
        
    

if (checkThatYouAreTheSidebar())
    applyStylesToMakeRizzomaFitIntoSidebar()