Session.setDefault 'insertVote', false

allClasses = MongoChampionClass.find({})

Template.header.events
    'click button': ->
        Session.set('insertVote',!Session.get('insertVote'))

Template.board.helpers
    allClasses: allClasses
        
Template.news.helpers
    local: ->
        Session.get("newsLocal")
    national: ->
        console.log Session.get("newsLocal")
        Session.get("newsNational")

Meteor.setInterval( ->
        newsLocal       =  MongoNews.findOne({type:'local'},{sort: {pubDate: -1}})
        newsNational    =  MongoNews.findOne({type:'national'},{sort: {pubDate: -1}})
        Session.set("newsLocal", newsLocal )
        Session.set("newsNational", newsNational )
    , 10000 )