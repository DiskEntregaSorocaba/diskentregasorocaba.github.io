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

resultsContainer.say = (strOut, clear) ->
	if clear is true or not strOut
		this.parentNode.classList.remove 'active'
		this.innerHTML = ''
	if strOut
		this.parentNode.classList.add 'active'
		this.innerHTML += strOut

displaySearchResults = (query, results, data) ->
	resultsContainer.say '<p>Pesquisando por <em>' + query + '</em></p>', true
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
			resultsOutput += '<article class="resultado"><div data-grid="spacing">' + content + '</div> </article>'
		resultsContainer.say '<div data-grid="cols-2">' + resultsOutput + '</div>'
	else
		resultsContainer.say '<p>Desculpe! Nenhum resultado foi encontrado. Tente pesquisar outros termos.</p>'

search = (e) ->
	e.preventDefault()
	searchTerm = input.value
	if searchTerm
		resultsContainer.say '<p>Analisando...</p>', true
		results = window.index.search searchTerm
		displaySearchResults searchTerm, results, window.data
	else
		resultsContainer.say '<p>Digite o que você está procurando.</p><p>Exemplo: <em>pizza de calabresa</em></p>', true

input.addEventListener 'focus', (e) ->
	form.classList.add 'focus'

input.addEventListener 'blur', (e) ->
	form.classList.remove 'focus'

form.addEventListener 'submit', search


