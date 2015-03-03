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
	], (_, results) ->
		assertThat title(results[0]), equalTo title(results[1])
		assertThat text(results[0]), equalTo text(results[1])
		done()

describe 'it-agile.de redirects' ->
	specify 'host without www', (done) ->
		assertSameTarget 'http://it-agile.de', 'http://www.it-agile.de', done
	specify 'Agile Review subscription', (done) ->
		assertSameTarget 'http://www.agilereview.de/abo', 'http://www.itagileshop.de/lesen/agile-review/', done
