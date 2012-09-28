function getHighestZIndex() {
    var allElements = document.getElementsByTagName("*");
    var maxZIndex = 0;
    for (var i = 0, max = allElements.length; i < max; i++) {
         element = allElements[i];
         zIndex = parseInt(element.style.zIndex)
         if (zIndex > maxZIndex)
            maxZIndex = zIndex
    }
    return maxZIndex;
}


var rizzomaIFrame = document.createElement('iframe');
rizzomaIFrame.src = 'http://rizzoma.com/topic/?mode=mobile';
rizzomaIFrame.id = 'rizzomaSidebarIFrame'
rizzomaIFrame.style.position = 'fixed';
rizzomaIFrame.style.top = '0px';
rizzomaIFrame.style.right = '0px';
rizzomaIFrame.style.height = '100%';
rizzomaIFrame.style.width = '35%';
rizzomaIFrame.style.zIndex = getHighestZIndex();
document.body.appendChild(rizzomaIFrame);