(function() {
    'use strict';

    (function(exports) {
        var _separatePath = function(string) {
            return string
                .replace(/]/g, '')
                .replace(/^[\.\[]+/, '')
                .replace(/[\.\[]+$/, '')
                .replace(/[\.\[]+/g, '[')
                .split('[');
        };

        var _getNested = function(obj, path) {
            switch (path.length) {
            case 0:
                return obj;
            default:
                var name = path.shift();
                if (typeof obj[name] !== 'object') {
                    return obj[name];
                } else {
                    return _getNested(obj[name], path);
                }
            }
        };

        var _setNested = function(obj, path, val) {
            switch (path.length) {
            case 0:
                throw new Error('Something is wrong :(');
            case 1:
                obj[path[0]] = val;
                return obj[path[0]];
            default:
                var name = path.shift();
                if (typeof obj[name] !== 'object') {
                    obj[name] = {};
                }
                return _setNested(obj[name], path, val);
            }
        };

        var nestedAttr = function(obj, path, val) {
            if (typeof path === 'string') { path = _separatePath(path); }
            return (arguments.length > 2)
                ? _setNested(obj, path, val)
                : _getNested(obj, path);
        };

        exports(nestedAttr, 'nestedAttr');
    }).call(this
        , function(exports, name) {
            if (typeof module === 'object' && module.exports != null) {
                module.exports = exports;
            } else if (typeof define === 'function') {
                define(exports);
            } else {
                this[name] = exports;
            }
        });

}).call(this);
