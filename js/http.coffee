---
---
do ->

	HTTP = 
		ajax: (options)->
			type = options.type.toUpperCase()
			request = new XMLHttpRequest();
			request.open type, options.url, true
			request.onload = ->
				options.success(request.responseText) if request.status >= 200 && request.status < 400
			request.onerror = options.error
			if type is 'POST'
				request.setRequestHeader 'Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8'
				request.send options.data
			else
				request.send()
			request
		get: (url, callback)->
			this.ajax
				type    : 'GET'
				url     : url
				success : callback
				
		post: (url, data, callback)->
			this.ajax
				type    : 'POST'
				url     : url
				data    : data
				success : callback

	window.HTTP = HTTP
