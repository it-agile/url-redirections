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

describe 'Url redirections:' ->
    redirections =
        'it-agile.de': 'www.it-agile.de'
        'www.agilereview.de': 'www.itagileshop.de/lesen/agile-review/'

    for let alias, target of redirections
        specify "#alias → #target", (done) ->
            assertSameTarget alias, target, done
