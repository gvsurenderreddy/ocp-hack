/* jslint node: true */
"use strict";

var execSync = require('exec-sync');
module.exports = {
    getBIOS: function () {
        return execSync('./bin/getBIOS.py');
    },
    setBIOS: function (callback) {
        var e = execSync('./bin/setBIOS.py');
        return true;
    }
};