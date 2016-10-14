---
---

searchSection = $( '.section-search' )[0]
form = $( '.search-form' )[0]
input = form.querySelector '[name="searchinput"]'
resultsContainer = $( '.search-results' )[0]

displaySearchResults = (query, results, data) ->
	resultsContainer.innerHTML = '<p>Resultados para <strong>' + query + '</strong></p>'
	resultsItems = results.map (r) ->
		data[r.ref]
	resultsItems.forEach (r) ->
		resultsContainer.innerHTML += '<article><p>' + r.title + '</p></article>'

input.addEventListener 'focus', (e) ->
	form.classList.add 'focus'

input.addEventListener 'blur', (e) ->
	form.classList.remove 'focus'

form.addEventListener 'submit', (e) ->
	e.preventDefault()
	searchTerm = input.value
	resultsContainer.innerHTML = '<p>Analisando...</p>'
	
	idx = lunr () ->
		this.ref 'id'
		this.field 'title', { boost : 10 }
		this.field 'endereco'
		this.field 'bairro'
		this.field 'cidade'
		this.field 'horario'
		this.field 'telefone'
		this.field 'content'
		this.field 'produtos', { boost : 5 }

	window.data.forEach (parceiro, index) ->
		newItem =
			id       : index
			title    : parceiro.title
			endereco : parceiro.endereco
			bairro   : parceiro.bairro
			cidade   : parceiro.cidade
			horario  : parceiro.horario
			telefone : parceiro.telefone
			content  : parceiro.content
			produtos : parceiro.produtos.reduce (a, b) ->
				a + b
				# especificar a função de redução para textos
		console.log newItem
		idx.add newItem

	results = idx.search searchTerm
	displaySearchResults searchTerm, results, window.data
