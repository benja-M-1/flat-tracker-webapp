var gzippo = require('gzippo');
var express = require('express');
var morgan = require('morgan');
var app = express();

app.use(morgan('dev'));
app.use(gzippo.staticGzip("" + __dirname + "/www"));
app.disable('x-powered-by');
app.listen(process.env.PORT || 8000);