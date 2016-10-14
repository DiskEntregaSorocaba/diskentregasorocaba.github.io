---
---

searchSection = $( '.section-search' )[0]
form = $( '.search-form' )[0]
input = form.querySelector '[name="searchinput"]'
results = $( '.search-results' )[0]

input.addEventListener 'focus', (e) ->
	form.classList.add 'focus'

input.addEventListener 'blur', (e) ->
	form.classList.remove 'focus'

form.addEventListener 'submit', (e) ->
	e.preventDefault()
	console.log HTTP.get '/data/parceiros.json', (data) ->
		console.log JSON.parse data