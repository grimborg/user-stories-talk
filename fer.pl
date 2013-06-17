$header = <<EOF;
<!docype html>  
<html lang="en">
	
	<head>
		<meta charset="utf-8">
		
		<title>Agile Estimation</title>
		
		<link href='http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
		
		<link rel="stylesheet" href="css/main.css">
		<link rel="stylesheet" href="css/theme/default.css" id="theme">

		<!-- For syntax highlighting -->
		<link rel="stylesheet" href="lib/css/zenburn.css">
                <style>
    h3, h4 {
	margin-bottom: 0.5em !important;
	margin-top: 0.5em !important;
    }
h2 {
    margin-bottom: 0.5em !important;
}
p {
    margin-top: 0.5em;
/*    font-size: 80%;*/
/*opacity: 0.3;*/
}

p em, li em {
    font-style: normal !important;
color: #82AEC4;
}

h3 {
color: #8FB1C2 !important;
}

ul {
    margin-bottom: 0.5em;
}

ul {
    list-style: none !important;
    padding:0;
    margin:0;
}

ul li { 
    padding-left: 1em; 
    text-indent: -.7em;
}

ul li:before {
    content: "• ";
    color: #7A75FF;
}
</style>
		<script>
			// If the query includes 'print-pdf' we'll use the PDF print sheet
			document.write( '<link rel="stylesheet" href="css/print/' + ( window.location.search.match( /print-pdf/gi ) ? 'pdf' : 'paper' ) + '.css" type="text/css" media="print">' );
		</script>

		<!--[if lt IE 9]>
		<script src="lib/js/html5shiv.js"></script>
		<![endif]-->
	</head>
	
	<body>
		
		<div class="reveal">

			<!-- Used to fade in a background when a specific slide state is reached -->
			<div class="state-background"></div>
			
			<!-- Any section element inside of this container is displayed as a slide -->
			<div class="slides">
EOF

$footer = <<EOF;
			</div>

			<!-- The navigational controls UI -->
			<aside class="controls">
				<a class="left" href="#">&#x25C4;</a>
				<a class="right" href="#">&#x25BA;</a>
				<a class="up" href="#">&#x25B2;</a>
				<a class="down" href="#">&#x25BC;</a>
			</aside>

			<!-- Presentation progress bar -->
			<div class="progress"><span></span></div>
			
		</div>

		<script src="lib/js/head.min.js"></script>
		<script src="js/reveal.min.js"></script>

		<script>
			
			// Full list of configuration options available here:
			// https://github.com/hakimel/reveal.js#configuration
			Reveal.initialize({
				controls: true,
				progress: true,
				history: true,
				
				theme: Reveal.getQueryHash().theme || 'default', // available themes are in /css/theme
				transition: Reveal.getQueryHash().transition || 'concave', // default/cube/page/concave/linear(2d)

				// Optional libraries used to extend on reveal.js
				dependencies: [
					{ src: 'lib/js/highlight.js', async: true, callback: function() { window.hljs.initHighlightingOnLoad(); } },
					{ src: 'lib/js/classList.js', condition: function() { return !document.body.classList; } },
					{ src: 'lib/js/showdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
					{ src: 'lib/js/data-markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
					{ src: '/socket.io/socket.io.js', async: true, condition: function() { return window.location.host === 'localhost:1947'; } },
					{ src: 'plugin/speakernotes/client.js', async: true, condition: function() { return window.location.host === 'localhost:1947'; } },
				]
			});
			
		</script>
<script>
//setInterval(function() {location.reload(false)}, 2000);
</script>
	</body>
</html>



EOF
print $header;
my $starting = 1;
my $after_h1 = 0;
while (<>) {
    if (/^<h1>/) {
        $after_h1 = 1;
        if (!$starting) {
            print "</section>\n";
        } else {
            $starting = 0;
        }
        print "<section>\n";
    } elsif (/^<h2>/) {
        if ($after_h1) {
            $after_h1 = 0;
        } else {
            print "</section>\n<section>\n";
        }
    } 
    print;
    $after_h1 = 0 if /\S/ and not /h1/ and not /^<p><br\/><\/p>/;
}
print "</section>";
print $footer;
