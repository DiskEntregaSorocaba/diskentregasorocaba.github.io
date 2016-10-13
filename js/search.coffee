---
---


formArray = _( $ '.search-form' )

formArray.forEach (form) ->

	input = form.querySelector '[name="searchinput"]'

	input.addEventListener 'focus', (e) ->
		form.classList.add 'focus'

	input.addEventListener 'blur', (e) ->
		form.classList.remove 'focus'

	form.addEventListener 'submit', (e) ->
		e.preventDefault()
		console.log HTTP.get '/data/parceiros.json', (data) ->
			console.log JSON.parse data