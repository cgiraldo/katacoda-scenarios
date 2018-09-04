<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM alpine:3.8
var requestListener = function (req, res) {
  res.writeHead(200);
  res.end('Hello, World!');
}

var server = http.createServer(requestListener);
server.listen(3000, function() { console.log("Listening on port 3000")});
</pre>
          

<pre class="file" data-target="clipboard">Test</pre>
          

<pre class="file" data-target="regex???">Test</pre>

Construye tu imagen curl de Docker clickando aquí -> `docker build -t curl .`{{execute}}
