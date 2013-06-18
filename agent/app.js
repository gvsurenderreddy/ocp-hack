
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http')
  , execSync = require('exec-sync');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/getBIOS', 
	function(req, res){ 
		var bios = execSync('./bin/getBIOS.py')
		res.send(bios);
	}
);

app.set('/setBIOS', 
	function(req, res) {
		res.send('Testes 123')
	}
);

http.createServer(app).listen(app.get('port'), function(){
  console.log('ocp-agent listening on port ' + app.get('port'));
});
