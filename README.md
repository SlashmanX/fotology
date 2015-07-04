# Fotology
Fotology is a simple way to get the urls of images via Google Image Search.

To find pictures of cats:
```javascript
var fotology = require("fotology");
fotology("cats", function(imageURLs){
    for (i in imageURLs)
        console.log imageURLs[i];
});
```