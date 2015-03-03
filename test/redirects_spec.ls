require! {
	unfluff
	request
	{assertThat, equalTo}: hamjest
	async
}

title = (html) -> unfluff(html).title
text = (html) -> unfluff(html).text

getHtml = (url, cb) -->
	request url, (_, __, html) -> cb(null, html)
getTitle = (url, cb) -->
	request url, (_, __, html) -> cb(null, title(html))

assertSameTarget = (aliasUrl, targetUrl, done) ->
	async.parallel [
		getHtml(aliasUrl)
		getHtml(targetUrl)
	], (_, [aliasHtml, targetHtml]) ->
		assertThat title(aliasHtml), equalTo title(targetHtml)
		assertThat text(aliasHtml), equalTo text(targetHtml)
		done()

describe 'it-agile.de redirects' ->
	specify 'host without www', (done) ->
		assertSameTarget 'http://it-agile.de', 'http://www.it-agile.de', done
	specify 'Agile Review subscription', (done) ->
		assertSameTarget 'http://www.agilereview.de', 'http://www.itagileshop.de/lesen/agile-review/', done
