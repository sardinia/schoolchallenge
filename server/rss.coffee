if Meteor.isServer
  readFeed = ->
    feedUrl = [
      "http://www.ansa.it/sito/ansait_rss.xml"
      "http://www.ansa.it/sito/notizie/sport/calcio/calcio_rss.xml"
      "http://www.ansa.it/sardegna/notizie/sardegna_rss.xml"
      "http://www.ansa.it/canale_motori/notizie/motori_rss.xml"
      "http://www.ansa.it/europa/notizie/rss.xml"
      "http://www.ansa.it/sito/notizie/cultura/cinema/cinema_rss.xml"
      "http://www.ansa.it/sito/notizie/sport/sport_rss.xml"
      "http://www.ansa.it/sito/notizie/politica/politica_rss.xml"
      "http://www.ansa.it/sito/notizie/cronaca/cronaca_rss.xml"
    ]
    show = feedUrl[Math.floor(Math.random() * feedUrl.length)];
    console.log 'load feed',show
    feedData = Scrape.feed show
    for k,item of feedData.items
      if MongoNews.find({title:item.title}).count() == 0
        console.log item.title
        item.type = 'national'
        MongoNews.insert item
  readFeed()
  feed = Meteor.setInterval readFeed, 100000