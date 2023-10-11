// importe les module http et fs (fileSystem) de Node.js
let http = require("http");
let fs = require('fs');

const port = 7654;

// appel a chaque requete http depuis le serveur
let handleRequest = (request, response) => {
    response.writeHead(200, {
        'Content-Type': 'text/html'
    });
    fs.readFile('./index.html', null, function (error, data) {
        if (error) {
            response.writeHead(404);
            respone.write('error file not found!');
        } else {
            response.write(data);
        }
        response.end();
    });
};

http.createServer(handleRequest).listen(port);
