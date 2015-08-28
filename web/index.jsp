<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX JSP Servelts</title>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

</script>
<script type="text/javascript">
$(function () {

    var seriesOptions = [];
    $.getJSON('Grafico', function(data) {

        // Populate series
        for (i = 0; i < data.DeltaRealTime.length; i++){
            seriesOptions[i] = {
                name: data.DeltaRealTime[i].name,
                data: [data.DeltaRealTime[i].key, parseFloat(data.DeltaRealTime[i].value)]
            };
        }

        $('#container').highcharts({
            chart: {
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,

                events: {
                    load: function() {

                        // set up the updating of the chart each second
                        setInterval(function() {

                            $.getJSON('Grafico', function(data) {
                                // Populate series
                                for (i = 0; i < data.DeltaRealTime.length; i++){
                                    var chart = $('#container').highcharts();
                                    chart.series[i].addPoint([data.DeltaRealTime[i].key, parseFloat(data.DeltaRealTime[i].value)]);
                                }
                            });
                        }, 1000);
                    }
                }
            },
            title: {
                text: "Valori Delta"
            },
            xAxis: {
                title: {
                    text: 'Campione'
                }
            },
            yAxis: {
                labels: {
                    format: '{value:.1f}'
                },
                title: {
                    text: 'Delta(f)'
                },
            },
            series: seriesOptions
        });
    });
});
</script>
</head>
<body>
	<h2>Ejemplo de AJAX con JSP y Servelts</h2>
	<div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
</body>
</html>
