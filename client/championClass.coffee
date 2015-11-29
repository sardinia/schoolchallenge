class @ChampionClass
  constructor: (@name, @alumsNum) ->

  @setAlumsNum: (alumsNum, id) ->
    MongoChampionClass.update(
        { "_id" : id },
        {
          $set: { "alumsNum": alumsNum }
        }
    )
    
  @setOralExamNum: (num, id) ->
    MongoChampionClass.update(
        { "_id" : id },
        {
          $set: { "oralExamNum": num }
        }
    )
    
  @setExtraPoints: (extraPoints, id) ->
    MongoChampionClass.update(
        { "_id" : id },
        {
          $set: { "extraPoints": extraPoints }
        }
    )
    
  @setVotesScore: (score, id) ->
    precidingVotesScoreRetrieved = MongoChampionClass.findOne({ "_id" : id },{"votesScore":1})
    precidingVotesScore = precidingVotesScoreRetrieved.votesScore

    precidingVotesScore = 0 if !precidingVotesScore
    
    newVotesScore = (parseInt(precidingVotesScore) + parseInt(score))
    
    MongoChampionClass.update(
        { "_id" : id },
        {
          $set: { "votesScore": newVotesScore }
        }
    )
    
  @setBalancedVotesScore: (score, id) ->
    oralExamNumRetrieved = MongoChampionClass.findOne({ "_id" : id },{"oralExamNum":1})
    oralExamNum = oralExamNumRetrieved.oralExamNum
    precidingVotesScoreRetrieved = MongoChampionClass.findOne({ "_id" : id },{"votesScore":1})
    precidingVotesScore = precidingVotesScoreRetrieved.votesScore

    oralExamNum = 1 if !oralExamNum
    precidingVotesScore = 0 if !precidingVotesScore
    
    newbalancedVotesScore = parseFloat(precidingVotesScore) / parseFloat(oralExamNum)
    
    MongoChampionClass.update(
        { "_id" : id },
        {
          $set: { "balancedVotesScore": newbalancedVotesScore }
        }
    )
    
    MongoChampionClass.update(
        { "_id" : id },
        {
          $set: { "oralExamNum": oralExamNum+1 }
        }
    )
    
  save: ->
      MongoChampionClass.insert
        name: @name
        alumnsNum: @alumnsNum