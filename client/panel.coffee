Session.set 'insertVote', 0

Template.panel.helpers
    isSelected: ->
        if Session.get('insertVote') == true
            'active'
        else
            Session.set 'isVoteSelected', false
    isClassSelected: ->
        if Session.get('isClassSelected') == @_id
            'active' 
    isVoteSelected: ->
        if Session.get 'isClassSelected'
            'active'
    allClasses: ->
        MongoChampionClass.find({})
    
Template.panel.events
    'click .item': ->
        Session.set('isClassSelected',@_id)
    'click .voto':(e) ->
        score = $(e.target).html()
        ChampionClass.setVotesScore(score, Session.get('isClassSelected'))
        ChampionClass.setBalancedVotesScore(score, Session.get('isClassSelected'))
        Session.set 'insertVote', false
    'click .newClasse button': ->
        nomeclasse = $("#inputCreazione").val()
        numeroAlunni = 20
        oggettoClasse = new ChampionClass(nomeclasse, numeroAlunni)
        oggettoClasse.save()