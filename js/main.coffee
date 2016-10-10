---
---


$ = (selector) ->
	document.querySelectorAll(selector)
_ = (nodeList, fn) ->
	if fn
		Array.prototype.map.call(nodeList, fn)
	else
		Array.prototype.slice.call(nodeList)
Element.prototype.prependChild = (child) ->
	this.insertBefore child, this.firstChild

window.$ = $
window._ = _

