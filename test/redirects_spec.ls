require! {
	unfluff
	request
	{assertThat, equalTo}: hamjest
	async
}

title = (html) ->
	unfluff(html).title

getTitle = (url, cb) -->
	request url, (_, __, html) -> cb(null, title(html))

assertSameTarget = (aliasUrl, targetUrl, done) ->
	async.parallel [
		getTitle(aliasUrl)
		getTitle(targetUrl)
	], (_, results) ->
		assertThat results[0], equalTo results[1]
		done()

describe 'it-agile.de redirects' ->
	specify 'host without www', (done) ->
		assertSameTarget 'http://it-agile.de', 'http://www.it-agile.de', done
