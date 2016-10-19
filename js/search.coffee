---
---

searchSection = $( '.section-search' )[0]
form = $( '.search-form' )[0]
input = form.querySelector '[name="searchinput"]'
resultsContainer = $( '.search-results' )[0]

window.index = lunr () ->
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
				'' + a + ' ' + b.categoria + ' ' + b.produtos.reduce (c, d) ->
						'' + c + ' ' + d.nome + ' ' + d.desc
					, ""
			, ""
	window.index.add newItem

displaySearchResults = (query, results, data) ->
	resultsContainer.innerHTML = '<p>Pesquisando por <em>' + query + '</em></p>'
	if results.length
		resultsOutput = ''
		resultsItems = results.map (r) ->
			data[r.ref]
		resultsItems.forEach (r) ->
			content = ''
			content += '<div data-cell="1of3" class="logo"><img src="' + r.logo + '" alt="' + r.title + '"></div>'
			content += '<div data-cell="2of3">'
			content += '<h4 class="title"><a href="' + r.url + '">' + r.title + '</a></h4>' +
			'<div class="meta">' +
			'<p>' + '<span class="telefone">' + r.telefone + '</span>'
			content += '<br><small class="horario">Atende ' + r.horario + '</small>' if r.horario
			content += '</p></div>' +
			'<p>' + r.content.replace(/^(.{100}[^\s]*).*/, "$1&hellip;") + '</p>' +
			'</div>'
			resultsOutput += '<article class="resultado"><div data-grid="row spacing">' + content + '</div> </article>'
		resultsContainer.innerHTML += '<div data-grid="cols-2 spacing">' + resultsOutput + '</div>'
	else
		resultsContainer.innerHTML += '<p>Desculpe! Nenhum resultado foi encontrado. Tente pesquisar outros termos.</p>'

search = (e) ->
	e.preventDefault()
	searchTerm = input.value
	if searchTerm
		resultsContainer.innerHTML = '<p>Analisando...</p>'
		results = window.index.search searchTerm
		displaySearchResults searchTerm, results, window.data
	else
		resultsContainer.innerHTML = '<p>Digite o que você está procurando.</p><p>Exemplo: <em>pizza de calabresa</em></p>'

input.addEventListener 'focus', (e) ->
	form.classList.add 'focus'

input.addEventListener 'blur', (e) ->
	form.classList.remove 'focus'

form.addEventListener 'submit', search


