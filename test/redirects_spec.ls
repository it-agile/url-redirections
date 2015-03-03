require! {
    unfluff
    request
    {assertThat, equalTo}: hamjest
    async
}

httpify = (urlOrNot) ->
    if urlOrNot.indexOf('http') == 0
        return urlOrNot
    return 'http://' + urlOrNot


title = (html) -> unfluff(html).title
text = (html) -> unfluff(html).text

getHtml = (url, cb) -->
    request httpify(url), (_, __, html) -> cb(null, html)

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
        assertSameTarget 'it-agile.de', 'www.it-agile.de', done
    specify 'Agile Review subscription', (done) ->
        assertSameTarget 'www.agilereview.de', 'www.itagileshop.de/lesen/agile-review/', done
