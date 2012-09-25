chrome.extension.onMessage.addListener(function(string) {
    alert("got message :" + string)
})