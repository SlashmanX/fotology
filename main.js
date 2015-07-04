var request = require("request");

var getUrl = function(object) {
    return object.url;
};

var fotology = function(searchTerm, next) {
    var searchUrl = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=" + searchTerm.replace(/ /g, "+");
    request(searchUrl, function(error, response, body) {
        var parsed = JSON.parse(body);
        next(parsed.responseData.results.map(getUrl));
    });
};

module.exports = fotology;