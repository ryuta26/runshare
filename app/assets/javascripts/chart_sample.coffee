window.draw_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    barNum = 3
    labels = new Array(barNum)
    bgColors = new Array(barNum)
    bdColors = new Array(barNum)
    for i in [0...barNum]
        labels[0] = '累計走行距離'
        labels[1] = '月間走行距離'
        labels[2] = '週間走行距離'
        bgColors[i] = 'rgba(75, 192, 192, 0.2)'
        bdColors[i] = 'rgba(75, 192, 192, 1)'
    myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels
            datasets: [{
                label: '走行距離(km)'
                data: gon.bardata,
                backgroundColor: bgColors,
                borderColor: bdColors,
                borderWidth: 1
}]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    })