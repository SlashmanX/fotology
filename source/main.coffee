request = require 'request'
Promise = require 'bluebird'

# will be used when mapping the images to get their urls
getUrl = (object) -> object.unescapedUrl

# look at the README.md for full documentation
module.exports = (searchTerm, options) ->
	return new Promise((resolve, reject) =>
		###
		To keep it simple, options is not a needed input.
		That means that it is possible for only 2 inputs to
		be passed, which would mean that options was the callback,
		so make the 2nd input the callback and reset options.
		###
		if not options?
			options = {}

		# set default options
		# XXX: options are the options to fotology, not image search
		# image search options are set later as their own variables
		options.safe = options.safe or "moderate"
		options.size = options.size or "any"
		options.color = options.color or "any" # will remove invalid colours later
		options.language = options.language or "en"
		options.limit = options.limit or 5

		# process safety
		switch options.safe
			when true  then safety = "active"
			when false then safety = "off"
			else            safety = options.safe

		# process size
		switch options.size
			when "small"  then size = "icon"
			when "medium" then size = "media"
			when "large"  then size = "xxlarge"
			when "huge"   then size = "huge"
			else               size = "any"

		# process colour
		possibleColors = [
			"black",
			"blue",
			"brown",
			"gray",
			"green",
			"orange",
			"pink",
			"purple",
			"red",
			"teal",
			"white",
			"yellow"
		]
		if options.color in possibleColors then color = options.color else "any"

		# process language
		language = options.language.substring(0, 1).toLowerCase()

		limit = options.limit

		searchPrefix = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0"
		searchUrl = "#{searchPrefix}&q=#{searchTerm}&imgsz=#{size}&safe=#{safety}&hl=#{language}&imgcolor=#{color}&rsz=#{limit}"

		request searchUrl, (error, response, body) ->
			parsed = JSON.parse body
			images = parsed.responseData.results
			urls = images.map getUrl
			return resolve(urls)
	)
