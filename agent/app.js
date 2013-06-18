
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http')
  , execSync = require('exec-sync')
  , fs = require('fs');

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
		var bios = execSync('./bin/getBIOS.py');
		res.encoding('binary');
		res.send(bios);
	}
);

app.post('/setBIOS', 
	function(req, res) {
		fs.writeFile('/tmp/BIOS.np', req.body.BIOS, 
			function(err) {
    			if(err) {
        			console.log(err);
    			} else {
        			console.log('The BIOS file was saved!');
    			}
			}
		); 
		execSync('./bin/setBIOS.py');
		res.send('BIOS Updated');
	}
);

http.createServer(app).listen(app.get('port'), function(){
  console.log('ocp-agent listening on port ' + app.get('port'));
});
