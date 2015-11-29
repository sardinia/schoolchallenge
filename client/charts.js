// myTemplate.js
Template.board.topClasses = function() {
    
    var allClasses = MongoChampionClass.find({});
    var seriesArray = [];
    allClasses.forEach(function(entry) {
        console.log(entry);
        var extraPoints = (typeof(entry.extraPoints) != 'undefined')? entry.extraPoints : 0 ;
        var balancedVotesScore = (typeof(entry.balancedVotesScore) != 'undefined')? entry.balancedVotesScore : 0 ;
        var temp = {
            name: entry.name,
            data: [extraPoints + balancedVotesScore]
        }
        seriesArray.push(temp);
    });

    return {
            chart: {
            type: 'column'
        },
        
        title: {
            text: ''
        },
        
        credits: {
            enabled: false
        },
        
        xAxis: {
            categories: [
                'Classi'
            ]
        },
        
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        
        series: seriesArray
    };
};