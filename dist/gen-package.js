(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}




var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log = F2(function(tag, value)
{
	return value;
});

var _Debug_log_UNUSED = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString(value)
{
	return '<internals>';
}

function _Debug_toString_UNUSED(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash_UNUSED(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.br.ap === region.a6.ap)
	{
		return 'on line ' + region.br.ap;
	}
	return 'on lines ' + region.br.ap + ' through ' + region.a6.ap;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**_UNUSED/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**_UNUSED/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**/
	if (typeof x.$ === 'undefined')
	//*/
	/**_UNUSED/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0 = 0;
var _Utils_Tuple0_UNUSED = { $: '#0' };

function _Utils_Tuple2(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2_UNUSED(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3_UNUSED(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr(c) { return c; }
function _Utils_chr_UNUSED(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



var _List_Nil = { $: 0 };
var _List_Nil_UNUSED = { $: '[]' };

function _List_Cons(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons_UNUSED(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**_UNUSED/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap_UNUSED(value) { return { $: 0, a: value }; }
function _Json_unwrap_UNUSED(value) { return value.a; }

function _Json_wrap(value) { return value; }
function _Json_unwrap(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);




// STRINGS


var _Parser_isSubString = F5(function(smallString, offset, row, col, bigString)
{
	var smallLength = smallString.length;
	var isGood = offset + smallLength <= bigString.length;

	for (var i = 0; isGood && i < smallLength; )
	{
		var code = bigString.charCodeAt(offset);
		isGood =
			smallString[i++] === bigString[offset++]
			&& (
				code === 0x000A /* \n */
					? ( row++, col=1 )
					: ( col++, (code & 0xF800) === 0xD800 ? smallString[i++] === bigString[offset++] : 1 )
			)
	}

	return _Utils_Tuple3(isGood ? offset : -1, row, col);
});



// CHARS


var _Parser_isSubChar = F3(function(predicate, offset, string)
{
	return (
		string.length <= offset
			? -1
			:
		(string.charCodeAt(offset) & 0xF800) === 0xD800
			? (predicate(_Utils_chr(string.substr(offset, 2))) ? offset + 2 : -1)
			:
		(predicate(_Utils_chr(string[offset]))
			? ((string[offset] === '\n') ? -2 : (offset + 1))
			: -1
		)
	);
});


var _Parser_isAsciiCode = F3(function(code, offset, string)
{
	return string.charCodeAt(offset) === code;
});



// NUMBERS


var _Parser_chompBase10 = F2(function(offset, string)
{
	for (; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (code < 0x30 || 0x39 < code)
		{
			return offset;
		}
	}
	return offset;
});


var _Parser_consumeBase = F3(function(base, offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var digit = string.charCodeAt(offset) - 0x30;
		if (digit < 0 || base <= digit) break;
		total = base * total + digit;
	}
	return _Utils_Tuple2(offset, total);
});


var _Parser_consumeBase16 = F2(function(offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (0x30 <= code && code <= 0x39)
		{
			total = 16 * total + code - 0x30;
		}
		else if (0x41 <= code && code <= 0x46)
		{
			total = 16 * total + code - 55;
		}
		else if (0x61 <= code && code <= 0x66)
		{
			total = 16 * total + code - 87;
		}
		else
		{
			break;
		}
	}
	return _Utils_Tuple2(offset, total);
});



// FIND STRING


var _Parser_findSubString = F5(function(smallString, offset, row, col, bigString)
{
	var newOffset = bigString.indexOf(smallString, offset);
	var target = newOffset < 0 ? bigString.length : newOffset + smallString.length;

	while (offset < target)
	{
		var code = bigString.charCodeAt(offset++);
		code === 0x000A /* \n */
			? ( col=1, row++ )
			: ( col++, (code & 0xF800) === 0xD800 && offset++ )
	}

	return _Utils_Tuple3(newOffset, row, col);
});



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.cu,
		impl.$7,
		impl.dg,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**_UNUSED/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (!node.$) {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === -2) {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$EQ = 1;
var $elm$core$Basics$GT = 2;
var $elm$core$Basics$LT = 0;
var $elm$core$Result$Err = function (a) {
	return {$: 1, a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 3, a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 0, a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 2, a: a};
};
var $elm$core$Basics$False = 1;
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 0, a: a};
};
var $elm$core$Maybe$Nothing = {$: 1};
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 0:
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 1) {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 1:
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 2:
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 0, a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 1, a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 0, a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.o) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.q),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.q);
		} else {
			var treeLen = builder.o * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.s) : builder.s;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.o);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.q) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.q);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{s: nodeList, o: (len / $elm$core$Array$branchFactor) | 0, q: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = 0;
var $elm$core$Result$isOk = function (result) {
	if (!result.$) {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Decode$decodeValue = _Json_run;
var $elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, obj) {
					var k = _v0.a;
					var v = _v0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(0),
			pairs));
};
var $elm$json$Json$Encode$string = _Json_wrap;
var $author$project$Elm$Gen$onFailureSend = _Platform_outgoingPort(
	'onFailureSend',
	function ($) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'description',
					$elm$json$Json$Encode$string($.b$)),
					_Utils_Tuple2(
					'title',
					$elm$json$Json$Encode$string($.di))
				]));
	});
var $author$project$Elm$Gen$error = function (err) {
	return $author$project$Elm$Gen$onFailureSend(err);
};
var $author$project$Elm$Gen$encodeFile = function (file) {
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'path',
				$elm$json$Json$Encode$string(file.bi)),
				_Utils_Tuple2(
				'contents',
				$elm$json$Json$Encode$string(file.a0))
			]));
};
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $elm$json$Json$Encode$list = F2(
	function (func, entries) {
		return _Json_wrap(
			A3(
				$elm$core$List$foldl,
				_Json_addEntry(func),
				_Json_emptyArray(0),
				entries));
	});
var $author$project$Elm$Gen$onSuccessSend = _Platform_outgoingPort(
	'onSuccessSend',
	$elm$json$Json$Encode$list($elm$core$Basics$identity));
var $author$project$Elm$Gen$files = function (list) {
	return $author$project$Elm$Gen$onSuccessSend(
		A2($elm$core$List$map, $author$project$Elm$Gen$encodeFile, list));
};
var $author$project$Generate$Docs = function (a) {
	return {$: 0, a: a};
};
var $author$project$Generate$ElmSource = function (a) {
	return {$: 1, a: a};
};
var $elm$project_metadata_utils$Elm$Docs$Module = F6(
	function (name, comment, unions, aliases, values, binops) {
		return {ah: aliases, bI: binops, aj: comment, I: name, aq: unions, Z: values};
	});
var $elm$project_metadata_utils$Elm$Docs$Alias = F4(
	function (name, comment, args, tipe) {
		return {aX: args, aj: comment, I: name, aU: tipe};
	});
var $elm$json$Json$Decode$andThen = _Json_andThen;
var $elm$json$Json$Decode$fail = _Json_fail;
var $elm$parser$Parser$DeadEnd = F3(
	function (row, col, problem) {
		return {a_: col, bk: problem, bo: row};
	});
var $elm$parser$Parser$problemToDeadEnd = function (p) {
	return A3($elm$parser$Parser$DeadEnd, p.bo, p.a_, p.bk);
};
var $elm$parser$Parser$Advanced$bagToList = F2(
	function (bag, list) {
		bagToList:
		while (true) {
			switch (bag.$) {
				case 0:
					return list;
				case 1:
					var bag1 = bag.a;
					var x = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2($elm$core$List$cons, x, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
				default:
					var bag1 = bag.a;
					var bag2 = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2($elm$parser$Parser$Advanced$bagToList, bag2, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
			}
		}
	});
var $elm$parser$Parser$Advanced$run = F2(
	function (_v0, src) {
		var parse = _v0;
		var _v1 = parse(
			{a_: 1, f: _List_Nil, h: 1, e: 0, bo: 1, d: src});
		if (!_v1.$) {
			var value = _v1.b;
			return $elm$core$Result$Ok(value);
		} else {
			var bag = _v1.b;
			return $elm$core$Result$Err(
				A2($elm$parser$Parser$Advanced$bagToList, bag, _List_Nil));
		}
	});
var $elm$parser$Parser$run = F2(
	function (parser, source) {
		var _v0 = A2($elm$parser$Parser$Advanced$run, parser, source);
		if (!_v0.$) {
			var a = _v0.a;
			return $elm$core$Result$Ok(a);
		} else {
			var problems = _v0.a;
			return $elm$core$Result$Err(
				A2($elm$core$List$map, $elm$parser$Parser$problemToDeadEnd, problems));
		}
	});
var $elm$parser$Parser$Done = function (a) {
	return {$: 1, a: a};
};
var $elm$parser$Parser$Forbidden = 0;
var $elm$project_metadata_utils$Elm$Type$Lambda = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$parser$Parser$Loop = function (a) {
	return {$: 0, a: a};
};
var $elm$project_metadata_utils$Elm$Type$Record = F2(
	function (a, b) {
		return {$: 4, a: a, b: b};
	});
var $elm$project_metadata_utils$Elm$Type$Type = F2(
	function (a, b) {
		return {$: 3, a: a, b: b};
	});
var $elm$project_metadata_utils$Elm$Type$Var = function (a) {
	return {$: 0, a: a};
};
var $elm$parser$Parser$Advanced$Bad = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$Good = F3(
	function (a, b, c) {
		return {$: 0, a: a, b: b, c: c};
	});
var $elm$parser$Parser$Advanced$Parser = $elm$core$Basics$identity;
var $elm$parser$Parser$Advanced$andThen = F2(
	function (callback, _v0) {
		var parseA = _v0;
		return function (s0) {
			var _v1 = parseA(s0);
			if (_v1.$ === 1) {
				var p = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			} else {
				var p1 = _v1.a;
				var a = _v1.b;
				var s1 = _v1.c;
				var _v2 = callback(a);
				var parseB = _v2;
				var _v3 = parseB(s1);
				if (_v3.$ === 1) {
					var p2 = _v3.a;
					var x = _v3.b;
					return A2($elm$parser$Parser$Advanced$Bad, p1 || p2, x);
				} else {
					var p2 = _v3.a;
					var b = _v3.b;
					var s2 = _v3.c;
					return A3($elm$parser$Parser$Advanced$Good, p1 || p2, b, s2);
				}
			}
		};
	});
var $elm$parser$Parser$andThen = $elm$parser$Parser$Advanced$andThen;
var $elm$parser$Parser$ExpectingSymbol = function (a) {
	return {$: 8, a: a};
};
var $elm$parser$Parser$Advanced$Token = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$AddRight = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$DeadEnd = F4(
	function (row, col, problem, contextStack) {
		return {a_: col, bV: contextStack, bk: problem, bo: row};
	});
var $elm$parser$Parser$Advanced$Empty = {$: 0};
var $elm$parser$Parser$Advanced$fromState = F2(
	function (s, x) {
		return A2(
			$elm$parser$Parser$Advanced$AddRight,
			$elm$parser$Parser$Advanced$Empty,
			A4($elm$parser$Parser$Advanced$DeadEnd, s.bo, s.a_, x, s.f));
	});
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$parser$Parser$Advanced$isSubString = _Parser_isSubString;
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $elm$core$Basics$not = _Basics_not;
var $elm$parser$Parser$Advanced$token = function (_v0) {
	var str = _v0.a;
	var expecting = _v0.b;
	var progress = !$elm$core$String$isEmpty(str);
	return function (s) {
		var _v1 = A5($elm$parser$Parser$Advanced$isSubString, str, s.e, s.bo, s.a_, s.d);
		var newOffset = _v1.a;
		var newRow = _v1.b;
		var newCol = _v1.c;
		return _Utils_eq(newOffset, -1) ? A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : A3(
			$elm$parser$Parser$Advanced$Good,
			progress,
			0,
			{a_: newCol, f: s.f, h: s.h, e: newOffset, bo: newRow, d: s.d});
	};
};
var $elm$parser$Parser$Advanced$symbol = $elm$parser$Parser$Advanced$token;
var $elm$parser$Parser$symbol = function (str) {
	return $elm$parser$Parser$Advanced$symbol(
		A2(
			$elm$parser$Parser$Advanced$Token,
			str,
			$elm$parser$Parser$ExpectingSymbol(str)));
};
var $elm$project_metadata_utils$Elm$Type$arrow = $elm$parser$Parser$symbol('->');
var $elm$parser$Parser$Advanced$backtrackable = function (_v0) {
	var parse = _v0;
	return function (s0) {
		var _v1 = parse(s0);
		if (_v1.$ === 1) {
			var x = _v1.b;
			return A2($elm$parser$Parser$Advanced$Bad, false, x);
		} else {
			var a = _v1.b;
			var s1 = _v1.c;
			return A3($elm$parser$Parser$Advanced$Good, false, a, s1);
		}
	};
};
var $elm$parser$Parser$backtrackable = $elm$parser$Parser$Advanced$backtrackable;
var $elm$project_metadata_utils$Elm$Type$comma = $elm$parser$Parser$symbol(',');
var $elm$core$Basics$always = F2(
	function (a, _v0) {
		return a;
	});
var $elm$parser$Parser$Advanced$map2 = F3(
	function (func, _v0, _v1) {
		var parseA = _v0;
		var parseB = _v1;
		return function (s0) {
			var _v2 = parseA(s0);
			if (_v2.$ === 1) {
				var p = _v2.a;
				var x = _v2.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			} else {
				var p1 = _v2.a;
				var a = _v2.b;
				var s1 = _v2.c;
				var _v3 = parseB(s1);
				if (_v3.$ === 1) {
					var p2 = _v3.a;
					var x = _v3.b;
					return A2($elm$parser$Parser$Advanced$Bad, p1 || p2, x);
				} else {
					var p2 = _v3.a;
					var b = _v3.b;
					var s2 = _v3.c;
					return A3(
						$elm$parser$Parser$Advanced$Good,
						p1 || p2,
						A2(func, a, b),
						s2);
				}
			}
		};
	});
var $elm$parser$Parser$Advanced$ignorer = F2(
	function (keepParser, ignoreParser) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$always, keepParser, ignoreParser);
	});
var $elm$parser$Parser$ignorer = $elm$parser$Parser$Advanced$ignorer;
var $elm$parser$Parser$Advanced$keeper = F2(
	function (parseFunc, parseArg) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$apL, parseFunc, parseArg);
	});
var $elm$parser$Parser$keeper = $elm$parser$Parser$Advanced$keeper;
var $elm$core$Set$Set_elm_builtin = $elm$core$Basics$identity;
var $elm$core$Dict$RBEmpty_elm_builtin = {$: -2};
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $elm$core$Set$empty = $elm$core$Dict$empty;
var $elm$project_metadata_utils$Elm$Type$isInnerVarChar = function (_char) {
	return $elm$core$Char$isAlphaNum(_char) || (_char === '_');
};
var $elm$parser$Parser$ExpectingVariable = {$: 7};
var $elm$parser$Parser$Advanced$isSubChar = _Parser_isSubChar;
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === -2) {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1) {
					case 0:
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 1:
						return $elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var $elm$core$Dict$member = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$get, key, dict);
		if (!_v0.$) {
			return true;
		} else {
			return false;
		}
	});
var $elm$core$Set$member = F2(
	function (key, _v0) {
		var dict = _v0;
		return A2($elm$core$Dict$member, key, dict);
	});
var $elm$core$String$slice = _String_slice;
var $elm$parser$Parser$Advanced$varHelp = F7(
	function (isGood, offset, row, col, src, indent, context) {
		varHelp:
		while (true) {
			var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, offset, src);
			if (_Utils_eq(newOffset, -1)) {
				return {a_: col, f: context, h: indent, e: offset, bo: row, d: src};
			} else {
				if (_Utils_eq(newOffset, -2)) {
					var $temp$isGood = isGood,
						$temp$offset = offset + 1,
						$temp$row = row + 1,
						$temp$col = 1,
						$temp$src = src,
						$temp$indent = indent,
						$temp$context = context;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					src = $temp$src;
					indent = $temp$indent;
					context = $temp$context;
					continue varHelp;
				} else {
					var $temp$isGood = isGood,
						$temp$offset = newOffset,
						$temp$row = row,
						$temp$col = col + 1,
						$temp$src = src,
						$temp$indent = indent,
						$temp$context = context;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					src = $temp$src;
					indent = $temp$indent;
					context = $temp$context;
					continue varHelp;
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$variable = function (i) {
	return function (s) {
		var firstOffset = A3($elm$parser$Parser$Advanced$isSubChar, i.br, s.e, s.d);
		if (_Utils_eq(firstOffset, -1)) {
			return A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, i.a7));
		} else {
			var s1 = _Utils_eq(firstOffset, -2) ? A7($elm$parser$Parser$Advanced$varHelp, i.bb, s.e + 1, s.bo + 1, 1, s.d, s.h, s.f) : A7($elm$parser$Parser$Advanced$varHelp, i.bb, firstOffset, s.bo, s.a_ + 1, s.d, s.h, s.f);
			var name = A3($elm$core$String$slice, s.e, s1.e, s.d);
			return A2($elm$core$Set$member, name, i.bn) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, i.a7)) : A3($elm$parser$Parser$Advanced$Good, true, name, s1);
		}
	};
};
var $elm$parser$Parser$variable = function (i) {
	return $elm$parser$Parser$Advanced$variable(
		{a7: $elm$parser$Parser$ExpectingVariable, bb: i.bb, bn: i.bn, br: i.br});
};
var $elm$project_metadata_utils$Elm$Type$var = function (isFirst) {
	return $elm$parser$Parser$variable(
		{bb: $elm$project_metadata_utils$Elm$Type$isInnerVarChar, bn: $elm$core$Set$empty, br: isFirst});
};
var $elm$project_metadata_utils$Elm$Type$lowVar = $elm$project_metadata_utils$Elm$Type$var($elm$core$Char$isLower);
var $elm$parser$Parser$Advanced$Append = F2(
	function (a, b) {
		return {$: 2, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$oneOfHelp = F3(
	function (s0, bag, parsers) {
		oneOfHelp:
		while (true) {
			if (!parsers.b) {
				return A2($elm$parser$Parser$Advanced$Bad, false, bag);
			} else {
				var parse = parsers.a;
				var remainingParsers = parsers.b;
				var _v1 = parse(s0);
				if (!_v1.$) {
					var step = _v1;
					return step;
				} else {
					var step = _v1;
					var p = step.a;
					var x = step.b;
					if (p) {
						return step;
					} else {
						var $temp$s0 = s0,
							$temp$bag = A2($elm$parser$Parser$Advanced$Append, bag, x),
							$temp$parsers = remainingParsers;
						s0 = $temp$s0;
						bag = $temp$bag;
						parsers = $temp$parsers;
						continue oneOfHelp;
					}
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$oneOf = function (parsers) {
	return function (s) {
		return A3($elm$parser$Parser$Advanced$oneOfHelp, s, $elm$parser$Parser$Advanced$Empty, parsers);
	};
};
var $elm$parser$Parser$oneOf = $elm$parser$Parser$Advanced$oneOf;
var $elm$parser$Parser$Advanced$chompWhileHelp = F5(
	function (isGood, offset, row, col, s0) {
		chompWhileHelp:
		while (true) {
			var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, offset, s0.d);
			if (_Utils_eq(newOffset, -1)) {
				return A3(
					$elm$parser$Parser$Advanced$Good,
					_Utils_cmp(s0.e, offset) < 0,
					0,
					{a_: col, f: s0.f, h: s0.h, e: offset, bo: row, d: s0.d});
			} else {
				if (_Utils_eq(newOffset, -2)) {
					var $temp$isGood = isGood,
						$temp$offset = offset + 1,
						$temp$row = row + 1,
						$temp$col = 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				} else {
					var $temp$isGood = isGood,
						$temp$offset = newOffset,
						$temp$row = row,
						$temp$col = col + 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$chompWhile = function (isGood) {
	return function (s) {
		return A5($elm$parser$Parser$Advanced$chompWhileHelp, isGood, s.e, s.bo, s.a_, s);
	};
};
var $elm$parser$Parser$chompWhile = $elm$parser$Parser$Advanced$chompWhile;
var $elm$project_metadata_utils$Elm$Type$spaces = $elm$parser$Parser$chompWhile(
	function (_char) {
		return _char === ' ';
	});
var $elm$parser$Parser$Advanced$succeed = function (a) {
	return function (s) {
		return A3($elm$parser$Parser$Advanced$Good, false, a, s);
	};
};
var $elm$parser$Parser$succeed = $elm$parser$Parser$Advanced$succeed;
var $elm$project_metadata_utils$Elm$Type$extension = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed($elm$core$Maybe$Just),
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$backtrackable($elm$project_metadata_utils$Elm$Type$lowVar),
						$elm$parser$Parser$backtrackable($elm$project_metadata_utils$Elm$Type$spaces)),
					$elm$parser$Parser$symbol('|')),
				$elm$project_metadata_utils$Elm$Type$spaces)),
			$elm$parser$Parser$succeed($elm$core$Maybe$Nothing)
		]));
var $elm$parser$Parser$Advanced$lazy = function (thunk) {
	return function (s) {
		var _v0 = thunk(0);
		var parse = _v0;
		return parse(s);
	};
};
var $elm$parser$Parser$lazy = $elm$parser$Parser$Advanced$lazy;
var $elm$parser$Parser$Advanced$loopHelp = F4(
	function (p, state, callback, s0) {
		loopHelp:
		while (true) {
			var _v0 = callback(state);
			var parse = _v0;
			var _v1 = parse(s0);
			if (!_v1.$) {
				var p1 = _v1.a;
				var step = _v1.b;
				var s1 = _v1.c;
				if (!step.$) {
					var newState = step.a;
					var $temp$p = p || p1,
						$temp$state = newState,
						$temp$callback = callback,
						$temp$s0 = s1;
					p = $temp$p;
					state = $temp$state;
					callback = $temp$callback;
					s0 = $temp$s0;
					continue loopHelp;
				} else {
					var result = step.a;
					return A3($elm$parser$Parser$Advanced$Good, p || p1, result, s1);
				}
			} else {
				var p1 = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p || p1, x);
			}
		}
	});
var $elm$parser$Parser$Advanced$loop = F2(
	function (state, callback) {
		return function (s) {
			return A4($elm$parser$Parser$Advanced$loopHelp, false, state, callback, s);
		};
	});
var $elm$parser$Parser$Advanced$map = F2(
	function (func, _v0) {
		var parse = _v0;
		return function (s0) {
			var _v1 = parse(s0);
			if (!_v1.$) {
				var p = _v1.a;
				var a = _v1.b;
				var s1 = _v1.c;
				return A3(
					$elm$parser$Parser$Advanced$Good,
					p,
					func(a),
					s1);
			} else {
				var p = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			}
		};
	});
var $elm$parser$Parser$map = $elm$parser$Parser$Advanced$map;
var $elm$parser$Parser$Advanced$Done = function (a) {
	return {$: 1, a: a};
};
var $elm$parser$Parser$Advanced$Loop = function (a) {
	return {$: 0, a: a};
};
var $elm$parser$Parser$toAdvancedStep = function (step) {
	if (!step.$) {
		var s = step.a;
		return $elm$parser$Parser$Advanced$Loop(s);
	} else {
		var a = step.a;
		return $elm$parser$Parser$Advanced$Done(a);
	}
};
var $elm$parser$Parser$loop = F2(
	function (state, callback) {
		return A2(
			$elm$parser$Parser$Advanced$loop,
			state,
			function (s) {
				return A2(
					$elm$parser$Parser$map,
					$elm$parser$Parser$toAdvancedStep,
					callback(s));
			});
	});
var $elm$core$Tuple$pair = F2(
	function (a, b) {
		return _Utils_Tuple2(a, b);
	});
var $elm$project_metadata_utils$Elm$Type$capVar = $elm$project_metadata_utils$Elm$Type$var($elm$core$Char$isUpper);
var $elm$parser$Parser$Advanced$mapChompedString = F2(
	function (func, _v0) {
		var parse = _v0;
		return function (s0) {
			var _v1 = parse(s0);
			if (_v1.$ === 1) {
				var p = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			} else {
				var p = _v1.a;
				var a = _v1.b;
				var s1 = _v1.c;
				return A3(
					$elm$parser$Parser$Advanced$Good,
					p,
					A2(
						func,
						A3($elm$core$String$slice, s0.e, s1.e, s0.d),
						a),
					s1);
			}
		};
	});
var $elm$parser$Parser$Advanced$getChompedString = function (parser) {
	return A2($elm$parser$Parser$Advanced$mapChompedString, $elm$core$Basics$always, parser);
};
var $elm$parser$Parser$getChompedString = $elm$parser$Parser$Advanced$getChompedString;
var $elm$project_metadata_utils$Elm$Type$qualifiedCapVarHelp = function (_v0) {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(
						$elm$parser$Parser$Loop(0)),
					$elm$parser$Parser$symbol('.')),
				$elm$project_metadata_utils$Elm$Type$capVar),
				$elm$parser$Parser$succeed(
				$elm$parser$Parser$Done(0))
			]));
};
var $elm$project_metadata_utils$Elm$Type$qualifiedCapVar = $elm$parser$Parser$getChompedString(
	A2(
		$elm$parser$Parser$ignorer,
		$elm$project_metadata_utils$Elm$Type$capVar,
		A2($elm$parser$Parser$loop, 0, $elm$project_metadata_utils$Elm$Type$qualifiedCapVarHelp)));
var $elm$parser$Parser$Advanced$revAlways = F2(
	function (_v0, b) {
		return b;
	});
var $elm$parser$Parser$Advanced$skip = F2(
	function (iParser, kParser) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$parser$Parser$Advanced$revAlways, iParser, kParser);
	});
var $elm$parser$Parser$Advanced$sequenceEndForbidden = F5(
	function (ender, ws, parseItem, sep, revItems) {
		var chompRest = function (item) {
			return A5(
				$elm$parser$Parser$Advanced$sequenceEndForbidden,
				ender,
				ws,
				parseItem,
				sep,
				A2($elm$core$List$cons, item, revItems));
		};
		return A2(
			$elm$parser$Parser$Advanced$skip,
			ws,
			$elm$parser$Parser$Advanced$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$Advanced$skip,
						sep,
						A2(
							$elm$parser$Parser$Advanced$skip,
							ws,
							A2(
								$elm$parser$Parser$Advanced$map,
								function (item) {
									return $elm$parser$Parser$Advanced$Loop(
										A2($elm$core$List$cons, item, revItems));
								},
								parseItem))),
						A2(
						$elm$parser$Parser$Advanced$map,
						function (_v0) {
							return $elm$parser$Parser$Advanced$Done(
								$elm$core$List$reverse(revItems));
						},
						ender)
					])));
	});
var $elm$parser$Parser$Advanced$sequenceEndMandatory = F4(
	function (ws, parseItem, sep, revItems) {
		return $elm$parser$Parser$Advanced$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$Advanced$map,
					function (item) {
						return $elm$parser$Parser$Advanced$Loop(
							A2($elm$core$List$cons, item, revItems));
					},
					A2(
						$elm$parser$Parser$Advanced$ignorer,
						parseItem,
						A2(
							$elm$parser$Parser$Advanced$ignorer,
							ws,
							A2($elm$parser$Parser$Advanced$ignorer, sep, ws)))),
					A2(
					$elm$parser$Parser$Advanced$map,
					function (_v0) {
						return $elm$parser$Parser$Advanced$Done(
							$elm$core$List$reverse(revItems));
					},
					$elm$parser$Parser$Advanced$succeed(0))
				]));
	});
var $elm$parser$Parser$Advanced$sequenceEndOptional = F5(
	function (ender, ws, parseItem, sep, revItems) {
		var parseEnd = A2(
			$elm$parser$Parser$Advanced$map,
			function (_v0) {
				return $elm$parser$Parser$Advanced$Done(
					$elm$core$List$reverse(revItems));
			},
			ender);
		return A2(
			$elm$parser$Parser$Advanced$skip,
			ws,
			$elm$parser$Parser$Advanced$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$Advanced$skip,
						sep,
						A2(
							$elm$parser$Parser$Advanced$skip,
							ws,
							$elm$parser$Parser$Advanced$oneOf(
								_List_fromArray(
									[
										A2(
										$elm$parser$Parser$Advanced$map,
										function (item) {
											return $elm$parser$Parser$Advanced$Loop(
												A2($elm$core$List$cons, item, revItems));
										},
										parseItem),
										parseEnd
									])))),
						parseEnd
					])));
	});
var $elm$parser$Parser$Advanced$sequenceEnd = F5(
	function (ender, ws, parseItem, sep, trailing) {
		var chompRest = function (item) {
			switch (trailing) {
				case 0:
					return A2(
						$elm$parser$Parser$Advanced$loop,
						_List_fromArray(
							[item]),
						A4($elm$parser$Parser$Advanced$sequenceEndForbidden, ender, ws, parseItem, sep));
				case 1:
					return A2(
						$elm$parser$Parser$Advanced$loop,
						_List_fromArray(
							[item]),
						A4($elm$parser$Parser$Advanced$sequenceEndOptional, ender, ws, parseItem, sep));
				default:
					return A2(
						$elm$parser$Parser$Advanced$ignorer,
						A2(
							$elm$parser$Parser$Advanced$skip,
							ws,
							A2(
								$elm$parser$Parser$Advanced$skip,
								sep,
								A2(
									$elm$parser$Parser$Advanced$skip,
									ws,
									A2(
										$elm$parser$Parser$Advanced$loop,
										_List_fromArray(
											[item]),
										A3($elm$parser$Parser$Advanced$sequenceEndMandatory, ws, parseItem, sep))))),
						ender);
			}
		};
		return $elm$parser$Parser$Advanced$oneOf(
			_List_fromArray(
				[
					A2($elm$parser$Parser$Advanced$andThen, chompRest, parseItem),
					A2(
					$elm$parser$Parser$Advanced$map,
					function (_v0) {
						return _List_Nil;
					},
					ender)
				]));
	});
var $elm$parser$Parser$Advanced$sequence = function (i) {
	return A2(
		$elm$parser$Parser$Advanced$skip,
		$elm$parser$Parser$Advanced$token(i.br),
		A2(
			$elm$parser$Parser$Advanced$skip,
			i.bq,
			A5(
				$elm$parser$Parser$Advanced$sequenceEnd,
				$elm$parser$Parser$Advanced$token(i.a6),
				i.bq,
				i.bc,
				$elm$parser$Parser$Advanced$token(i.bp),
				i.bx)));
};
var $elm$parser$Parser$Advanced$Forbidden = 0;
var $elm$parser$Parser$Advanced$Mandatory = 2;
var $elm$parser$Parser$Advanced$Optional = 1;
var $elm$parser$Parser$toAdvancedTrailing = function (trailing) {
	switch (trailing) {
		case 0:
			return 0;
		case 1:
			return 1;
		default:
			return 2;
	}
};
var $elm$parser$Parser$Expecting = function (a) {
	return {$: 0, a: a};
};
var $elm$parser$Parser$toToken = function (str) {
	return A2(
		$elm$parser$Parser$Advanced$Token,
		str,
		$elm$parser$Parser$Expecting(str));
};
var $elm$parser$Parser$sequence = function (i) {
	return $elm$parser$Parser$Advanced$sequence(
		{
			a6: $elm$parser$Parser$toToken(i.a6),
			bc: i.bc,
			bp: $elm$parser$Parser$toToken(i.bp),
			bq: i.bq,
			br: $elm$parser$Parser$toToken(i.br),
			bx: $elm$parser$Parser$toAdvancedTrailing(i.bx)
		});
};
var $elm$project_metadata_utils$Elm$Type$Tuple = function (a) {
	return {$: 2, a: a};
};
var $elm$project_metadata_utils$Elm$Type$tuplize = function (args) {
	if (args.b && (!args.b.b)) {
		var arg = args.a;
		return arg;
	} else {
		return $elm$project_metadata_utils$Elm$Type$Tuple(args);
	}
};
var $elm$project_metadata_utils$Elm$Type$chompArgs = function (revArgs) {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$map,
				function (arg) {
					return $elm$parser$Parser$Loop(
						A2($elm$core$List$cons, arg, revArgs));
				},
				A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed($elm$core$Basics$identity),
						$elm$parser$Parser$backtrackable($elm$project_metadata_utils$Elm$Type$spaces)),
					$elm$project_metadata_utils$Elm$Type$cyclic$term())),
				A2(
				$elm$parser$Parser$map,
				function (_v2) {
					return $elm$parser$Parser$Done(
						$elm$core$List$reverse(revArgs));
				},
				$elm$parser$Parser$succeed(0))
			]));
};
var $elm$project_metadata_utils$Elm$Type$recordEndHelp = function (revFields) {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(
							function (f) {
								return $elm$parser$Parser$Loop(
									A2($elm$core$List$cons, f, revFields));
							}),
						$elm$project_metadata_utils$Elm$Type$comma),
					$elm$project_metadata_utils$Elm$Type$spaces),
				A2(
					$elm$parser$Parser$ignorer,
					$elm$project_metadata_utils$Elm$Type$cyclic$field(),
					$elm$project_metadata_utils$Elm$Type$spaces)),
				A2(
				$elm$parser$Parser$keeper,
				$elm$parser$Parser$succeed(
					function (_v1) {
						return $elm$parser$Parser$Done(
							$elm$core$List$reverse(revFields));
					}),
				$elm$parser$Parser$symbol('}'))
			]));
};
var $elm$project_metadata_utils$Elm$Type$tipeHelp = function (t) {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$map,
				$elm$project_metadata_utils$Elm$Type$Lambda(t),
				$elm$project_metadata_utils$Elm$Type$cyclic$arrowAndType()),
				$elm$parser$Parser$succeed(t)
			]));
};
function $elm$project_metadata_utils$Elm$Type$cyclic$arrowAndType() {
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed($elm$core$Basics$identity),
					$elm$parser$Parser$backtrackable($elm$project_metadata_utils$Elm$Type$spaces)),
				$elm$project_metadata_utils$Elm$Type$arrow),
			$elm$project_metadata_utils$Elm$Type$spaces),
		$elm$project_metadata_utils$Elm$Type$cyclic$tipe());
}
function $elm$project_metadata_utils$Elm$Type$cyclic$tipeTerm() {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2($elm$parser$Parser$map, $elm$project_metadata_utils$Elm$Type$Var, $elm$project_metadata_utils$Elm$Type$lowVar),
				A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed($elm$project_metadata_utils$Elm$Type$Type),
					$elm$project_metadata_utils$Elm$Type$qualifiedCapVar),
				A2($elm$parser$Parser$loop, _List_Nil, $elm$project_metadata_utils$Elm$Type$chompArgs)),
				$elm$project_metadata_utils$Elm$Type$cyclic$record(),
				$elm$project_metadata_utils$Elm$Type$cyclic$tuple()
			]));
}
function $elm$project_metadata_utils$Elm$Type$cyclic$term() {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2($elm$parser$Parser$map, $elm$project_metadata_utils$Elm$Type$Var, $elm$project_metadata_utils$Elm$Type$lowVar),
				A2(
				$elm$parser$Parser$map,
				function (name) {
					return A2($elm$project_metadata_utils$Elm$Type$Type, name, _List_Nil);
				},
				$elm$project_metadata_utils$Elm$Type$qualifiedCapVar),
				$elm$project_metadata_utils$Elm$Type$cyclic$record(),
				$elm$project_metadata_utils$Elm$Type$cyclic$tuple()
			]));
}
function $elm$project_metadata_utils$Elm$Type$cyclic$record() {
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(
						F2(
							function (ext, fs) {
								return A2($elm$project_metadata_utils$Elm$Type$Record, fs, ext);
							})),
					$elm$parser$Parser$symbol('{')),
				$elm$project_metadata_utils$Elm$Type$spaces),
			$elm$project_metadata_utils$Elm$Type$extension),
		$elm$project_metadata_utils$Elm$Type$cyclic$recordEnd());
}
function $elm$project_metadata_utils$Elm$Type$cyclic$recordEnd() {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$andThen,
				function (f) {
					return A2(
						$elm$parser$Parser$loop,
						_List_fromArray(
							[f]),
						$elm$project_metadata_utils$Elm$Type$recordEndHelp);
				},
				A2(
					$elm$parser$Parser$ignorer,
					$elm$project_metadata_utils$Elm$Type$cyclic$field(),
					$elm$project_metadata_utils$Elm$Type$spaces)),
				A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed(_List_Nil),
				$elm$parser$Parser$symbol('}'))
			]));
}
function $elm$project_metadata_utils$Elm$Type$cyclic$field() {
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed($elm$core$Tuple$pair),
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					A2($elm$parser$Parser$ignorer, $elm$project_metadata_utils$Elm$Type$lowVar, $elm$project_metadata_utils$Elm$Type$spaces),
					$elm$parser$Parser$symbol(':')),
				$elm$project_metadata_utils$Elm$Type$spaces)),
		$elm$project_metadata_utils$Elm$Type$cyclic$tipe());
}
function $elm$project_metadata_utils$Elm$Type$cyclic$tuple() {
	return A2(
		$elm$parser$Parser$map,
		$elm$project_metadata_utils$Elm$Type$tuplize,
		$elm$parser$Parser$sequence(
			{
				a6: ')',
				bc: $elm$project_metadata_utils$Elm$Type$cyclic$tipe(),
				bp: ',',
				bq: $elm$project_metadata_utils$Elm$Type$spaces,
				br: '(',
				bx: 0
			}));
}
function $elm$project_metadata_utils$Elm$Type$cyclic$tipe() {
	return $elm$parser$Parser$lazy(
		function (_v0) {
			return A2(
				$elm$parser$Parser$andThen,
				$elm$project_metadata_utils$Elm$Type$tipeHelp,
				$elm$project_metadata_utils$Elm$Type$cyclic$tipeTerm());
		});
}
var $elm$project_metadata_utils$Elm$Type$arrowAndType = $elm$project_metadata_utils$Elm$Type$cyclic$arrowAndType();
$elm$project_metadata_utils$Elm$Type$cyclic$arrowAndType = function () {
	return $elm$project_metadata_utils$Elm$Type$arrowAndType;
};
var $elm$project_metadata_utils$Elm$Type$tipeTerm = $elm$project_metadata_utils$Elm$Type$cyclic$tipeTerm();
$elm$project_metadata_utils$Elm$Type$cyclic$tipeTerm = function () {
	return $elm$project_metadata_utils$Elm$Type$tipeTerm;
};
var $elm$project_metadata_utils$Elm$Type$term = $elm$project_metadata_utils$Elm$Type$cyclic$term();
$elm$project_metadata_utils$Elm$Type$cyclic$term = function () {
	return $elm$project_metadata_utils$Elm$Type$term;
};
var $elm$project_metadata_utils$Elm$Type$record = $elm$project_metadata_utils$Elm$Type$cyclic$record();
$elm$project_metadata_utils$Elm$Type$cyclic$record = function () {
	return $elm$project_metadata_utils$Elm$Type$record;
};
var $elm$project_metadata_utils$Elm$Type$recordEnd = $elm$project_metadata_utils$Elm$Type$cyclic$recordEnd();
$elm$project_metadata_utils$Elm$Type$cyclic$recordEnd = function () {
	return $elm$project_metadata_utils$Elm$Type$recordEnd;
};
var $elm$project_metadata_utils$Elm$Type$field = $elm$project_metadata_utils$Elm$Type$cyclic$field();
$elm$project_metadata_utils$Elm$Type$cyclic$field = function () {
	return $elm$project_metadata_utils$Elm$Type$field;
};
var $elm$project_metadata_utils$Elm$Type$tuple = $elm$project_metadata_utils$Elm$Type$cyclic$tuple();
$elm$project_metadata_utils$Elm$Type$cyclic$tuple = function () {
	return $elm$project_metadata_utils$Elm$Type$tuple;
};
var $elm$project_metadata_utils$Elm$Type$tipe = $elm$project_metadata_utils$Elm$Type$cyclic$tipe();
$elm$project_metadata_utils$Elm$Type$cyclic$tipe = function () {
	return $elm$project_metadata_utils$Elm$Type$tipe;
};
var $elm$project_metadata_utils$Elm$Type$parse = function (source) {
	return A2($elm$parser$Parser$run, $elm$project_metadata_utils$Elm$Type$tipe, source);
};
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$project_metadata_utils$Elm$Type$decoderHelp = function (string) {
	var _v0 = $elm$project_metadata_utils$Elm$Type$parse(string);
	if (_v0.$ === 1) {
		var error = _v0.a;
		return $elm$json$Json$Decode$fail('TODO');
	} else {
		var actualType = _v0.a;
		return $elm$json$Json$Decode$succeed(actualType);
	}
};
var $elm$json$Json$Decode$string = _Json_decodeString;
var $elm$project_metadata_utils$Elm$Type$decoder = A2($elm$json$Json$Decode$andThen, $elm$project_metadata_utils$Elm$Type$decoderHelp, $elm$json$Json$Decode$string);
var $elm$json$Json$Decode$field = _Json_decodeField;
var $elm$json$Json$Decode$list = _Json_decodeList;
var $elm$json$Json$Decode$map4 = _Json_map4;
var $elm$project_metadata_utils$Elm$Docs$aliasDecoder = A5(
	$elm$json$Json$Decode$map4,
	$elm$project_metadata_utils$Elm$Docs$Alias,
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'comment', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$field,
		'args',
		$elm$json$Json$Decode$list($elm$json$Json$Decode$string)),
	A2($elm$json$Json$Decode$field, 'type', $elm$project_metadata_utils$Elm$Type$decoder));
var $elm$project_metadata_utils$Elm$Docs$Binop = F5(
	function (name, comment, tipe, associativity, precedence) {
		return {bH: associativity, aj: comment, I: name, Y: precedence, aU: tipe};
	});
var $elm$project_metadata_utils$Elm$Docs$Left = 0;
var $elm$project_metadata_utils$Elm$Docs$None = 1;
var $elm$project_metadata_utils$Elm$Docs$Right = 2;
var $elm$project_metadata_utils$Elm$Docs$toAssoc = function (str) {
	switch (str) {
		case 'left':
			return $elm$json$Json$Decode$succeed(0);
		case 'non':
			return $elm$json$Json$Decode$succeed(1);
		case 'right':
			return $elm$json$Json$Decode$succeed(2);
		default:
			return $elm$json$Json$Decode$fail('expecting one of the following values: left, non, right');
	}
};
var $elm$project_metadata_utils$Elm$Docs$assocDecoder = A2($elm$json$Json$Decode$andThen, $elm$project_metadata_utils$Elm$Docs$toAssoc, $elm$json$Json$Decode$string);
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $elm$json$Json$Decode$map5 = _Json_map5;
var $elm$project_metadata_utils$Elm$Docs$binopDecoder = A6(
	$elm$json$Json$Decode$map5,
	$elm$project_metadata_utils$Elm$Docs$Binop,
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'comment', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'type', $elm$project_metadata_utils$Elm$Type$decoder),
	A2($elm$json$Json$Decode$field, 'associativity', $elm$project_metadata_utils$Elm$Docs$assocDecoder),
	A2($elm$json$Json$Decode$field, 'precedence', $elm$json$Json$Decode$int));
var $elm$json$Json$Decode$map6 = _Json_map6;
var $elm$project_metadata_utils$Elm$Docs$Union = F4(
	function (name, comment, args, tags) {
		return {aX: args, aj: comment, I: name, dh: tags};
	});
var $elm$json$Json$Decode$index = _Json_decodeIndex;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $elm$project_metadata_utils$Elm$Docs$tagDecoder = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (a, b) {
			return _Utils_Tuple2(a, b);
		}),
	A2($elm$json$Json$Decode$index, 0, $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$index,
		1,
		$elm$json$Json$Decode$list($elm$project_metadata_utils$Elm$Type$decoder)));
var $elm$project_metadata_utils$Elm$Docs$unionDecoder = A5(
	$elm$json$Json$Decode$map4,
	$elm$project_metadata_utils$Elm$Docs$Union,
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'comment', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$field,
		'args',
		$elm$json$Json$Decode$list($elm$json$Json$Decode$string)),
	A2(
		$elm$json$Json$Decode$field,
		'cases',
		$elm$json$Json$Decode$list($elm$project_metadata_utils$Elm$Docs$tagDecoder)));
var $elm$project_metadata_utils$Elm$Docs$Value = F3(
	function (name, comment, tipe) {
		return {aj: comment, I: name, aU: tipe};
	});
var $elm$json$Json$Decode$map3 = _Json_map3;
var $elm$project_metadata_utils$Elm$Docs$valueDecoder = A4(
	$elm$json$Json$Decode$map3,
	$elm$project_metadata_utils$Elm$Docs$Value,
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'comment', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'type', $elm$project_metadata_utils$Elm$Type$decoder));
var $elm$project_metadata_utils$Elm$Docs$decoder = A7(
	$elm$json$Json$Decode$map6,
	$elm$project_metadata_utils$Elm$Docs$Module,
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'comment', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$field,
		'unions',
		$elm$json$Json$Decode$list($elm$project_metadata_utils$Elm$Docs$unionDecoder)),
	A2(
		$elm$json$Json$Decode$field,
		'aliases',
		$elm$json$Json$Decode$list($elm$project_metadata_utils$Elm$Docs$aliasDecoder)),
	A2(
		$elm$json$Json$Decode$field,
		'values',
		$elm$json$Json$Decode$list($elm$project_metadata_utils$Elm$Docs$valueDecoder)),
	A2(
		$elm$json$Json$Decode$field,
		'binops',
		$elm$json$Json$Decode$list($elm$project_metadata_utils$Elm$Docs$binopDecoder)));
var $elm$json$Json$Decode$map = _Json_map1;
var $elm$json$Json$Decode$oneOf = _Json_oneOf;
var $author$project$Generate$flagsDecoder = $elm$json$Json$Decode$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$json$Json$Decode$map,
			$author$project$Generate$Docs,
			A2(
				$elm$json$Json$Decode$field,
				'docs',
				$elm$json$Json$Decode$list($elm$project_metadata_utils$Elm$Docs$decoder))),
			A2(
			$elm$json$Json$Decode$map,
			$author$project$Generate$ElmSource,
			A2(
				$elm$json$Json$Decode$field,
				'elmSource',
				$elm$json$Json$Decode$list($elm$json$Json$Decode$string)))
		]));
var $author$project$Elm$Field = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $author$project$Elm$field = $author$project$Elm$Field;
var $author$project$Internal$Compiler$Expression = $elm$core$Basics$identity;
var $stil4m$elm_syntax$Elm$Syntax$Expression$Literal = function (a) {
	return {$: 11, a: a};
};
var $author$project$Internal$Compiler$getInnerAnnotation = function (_v0) {
	var details = _v0;
	return details.c;
};
var $author$project$Internal$Compiler$Annotation = $elm$core$Basics$identity;
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3($elm$core$List$foldr, $elm$core$List$cons, ys, xs);
		}
	});
var $elm$core$List$concat = function (lists) {
	return A3($elm$core$List$foldr, $elm$core$List$append, _List_Nil, lists);
};
var $elm$core$List$concatMap = F2(
	function (f, list) {
		return $elm$core$List$concat(
			A2($elm$core$List$map, f, list));
	});
var $author$project$Internal$Compiler$getAnnotationImports = function (_v0) {
	var details = _v0;
	return details.a;
};
var $stil4m$elm_syntax$Elm$Syntax$Node$Node = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange = {
	a6: {bP: 0, bo: 0},
	br: {bP: 0, bo: 0}
};
var $author$project$Internal$Compiler$nodify = function (exp) {
	return A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, exp);
};
var $author$project$Internal$Compiler$nodifyAll = $elm$core$List$map($author$project$Internal$Compiler$nodify);
var $author$project$Elm$Annotation$typed = F3(
	function (mod, name, args) {
		return {
			c: A2(
				$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
				$author$project$Internal$Compiler$nodify(
					_Utils_Tuple2(mod, name)),
				$author$project$Internal$Compiler$nodifyAll(
					A2($elm$core$List$map, $author$project$Internal$Compiler$getInnerAnnotation, args))),
			a: A2($elm$core$List$concatMap, $author$project$Internal$Compiler$getAnnotationImports, args)
		};
	});
var $author$project$Elm$Annotation$string = A3($author$project$Elm$Annotation$typed, _List_Nil, 'String', _List_Nil);
var $author$project$Elm$string = function (literal) {
	return {
		c: $elm$core$Result$Ok(
			$author$project$Internal$Compiler$getInnerAnnotation($author$project$Elm$Annotation$string)),
		b: $stil4m$elm_syntax$Elm$Syntax$Expression$Literal(literal),
		a: _List_Nil,
		g: false
	};
};
var $author$project$Elm$Annotation$list = function (inner) {
	return A3(
		$author$project$Elm$Annotation$typed,
		_List_Nil,
		'List',
		_List_fromArray(
			[inner]));
};
var $author$project$Generate$local = _List_Nil;
var $stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue = F2(
	function (a, b) {
		return {$: 3, a: a, b: b};
	});
var $author$project$Internal$Compiler$sanitize = function (str) {
	switch (str) {
		case 'in':
			return 'in_';
		case 'type':
			return 'type_';
		case 'case':
			return 'case_';
		case 'let':
			return 'let_';
		case 'module':
			return 'module_';
		case 'exposing':
			return 'exposing_';
		default:
			return str;
	}
};
var $author$project$Elm$valueWith = F3(
	function (mod, name, ann) {
		return {
			c: $elm$core$Result$Ok(
				$author$project$Internal$Compiler$getInnerAnnotation(ann)),
			b: A2(
				$stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue,
				mod,
				$author$project$Internal$Compiler$sanitize(name)),
			a: A2(
				$elm$core$List$cons,
				mod,
				$author$project$Internal$Compiler$getAnnotationImports(ann)),
			g: false
		};
	});
var $author$project$Generate$thisModuleName = A3(
	$author$project$Elm$valueWith,
	$author$project$Generate$local,
	'moduleName_',
	$author$project$Elm$Annotation$list($author$project$Elm$Annotation$string));
var $author$project$Generate$elmAnnotation = _List_fromArray(
	['Elm', 'Annotation']);
var $elm$core$String$length = _String_length;
var $elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			$elm$core$String$slice,
			n,
			$elm$core$String$length(string),
			string);
	});
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$core$String$toUpper = _String_toUpper;
var $author$project$Internal$Compiler$formatType = function (str) {
	return _Utils_ap(
		$elm$core$String$toUpper(
			A2($elm$core$String$left, 1, str)),
		A2($elm$core$String$dropLeft, 1, str));
};
var $author$project$Elm$Annotation$named = F2(
	function (mod, name) {
		return {
			c: A2(
				$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
				$author$project$Internal$Compiler$nodify(
					_Utils_Tuple2(
						mod,
						$author$project$Internal$Compiler$formatType(name))),
				_List_Nil),
			a: _List_fromArray(
				[mod])
		};
	});
var $author$project$Generate$annotationType = A2($author$project$Elm$Annotation$named, $author$project$Generate$elmAnnotation, 'Annotation');
var $author$project$Elm$Gen$Elm$Annotation$moduleName_ = _List_fromArray(
	['Elm', 'Annotation']);
var $author$project$Elm$Annotation$namedWith = F3(
	function (mod, name, args) {
		return {
			c: A2(
				$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
				$author$project$Internal$Compiler$nodify(
					_Utils_Tuple2(
						mod,
						$author$project$Internal$Compiler$formatType(name))),
				$author$project$Internal$Compiler$nodifyAll(
					A2($elm$core$List$map, $author$project$Internal$Compiler$getInnerAnnotation, args))),
			a: A2(
				$elm$core$List$cons,
				mod,
				A2($elm$core$List$concatMap, $author$project$Internal$Compiler$getAnnotationImports, args))
		};
	});
var $author$project$Elm$Gen$Elm$Annotation$bool = A3(
	$author$project$Elm$valueWith,
	$author$project$Elm$Gen$Elm$Annotation$moduleName_,
	'bool',
	A3(
		$author$project$Elm$Annotation$namedWith,
		_List_fromArray(
			['Elm', 'Annotation']),
		'Annotation',
		_List_Nil));
var $elm$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (n <= 0) {
				return list;
			} else {
				if (!list.b) {
					return list;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs;
					n = $temp$n;
					list = $temp$list;
					continue drop;
				}
			}
		}
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$Application = function (a) {
	return {$: 1, a: a};
};
var $author$project$Internal$Compiler$FunctionAppliedToTooManyArgs = {$: 4};
var $stil4m$elm_syntax$Elm$Syntax$Node$value = function (_v0) {
	var v = _v0.b;
	return v;
};
var $author$project$Internal$Compiler$denode = $stil4m$elm_syntax$Elm$Syntax$Node$value;
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation = F2(
	function (a, b) {
		return {$: 6, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record = function (a) {
	return {$: 4, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled = function (a) {
	return {$: 3, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit = {$: 2};
var $author$project$Internal$Compiler$getField = F4(
	function (name, val, fields, captured) {
		getField:
		while (true) {
			if (!fields.b) {
				return $elm$core$Result$Err('Could not find ' + name);
			} else {
				var top = fields.a;
				var remain = fields.b;
				var _v1 = $author$project$Internal$Compiler$denode(top);
				var topFieldName = _v1.a;
				var topFieldVal = _v1.b;
				var topName = $author$project$Internal$Compiler$denode(topFieldName);
				var topVal = $author$project$Internal$Compiler$denode(topFieldVal);
				if (_Utils_eq(topName, name)) {
					return $elm$core$Result$Ok(
						_Utils_Tuple2(
							topVal,
							_Utils_ap(captured, remain)));
				} else {
					var $temp$name = name,
						$temp$val = val,
						$temp$fields = remain,
						$temp$captured = A2($elm$core$List$cons, top, captured);
					name = $temp$name;
					val = $temp$val;
					fields = $temp$fields;
					captured = $temp$captured;
					continue getField;
				}
			}
		}
	});
var $elm$core$Dict$Black = 1;
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: -1, a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$Red = 0;
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === -1) && (!right.a)) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === -1) && (!left.a)) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					0,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, 1, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 1, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === -1) && (!left.a)) && (left.d.$ === -1)) && (!left.d.a)) {
				var _v5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _v6 = left.d;
				var _v7 = _v6.a;
				var llK = _v6.b;
				var llV = _v6.c;
				var llLeft = _v6.d;
				var llRight = _v6.e;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					0,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, 1, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 1, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === -2) {
			return A5($elm$core$Dict$RBNode_elm_builtin, 0, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1) {
				case 0:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 1:
					return A5($elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3($elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var $elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _v0 = A3($elm$core$Dict$insertHelp, key, value, dict);
		if ((_v0.$ === -1) && (!_v0.a)) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, 1, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $author$project$Internal$Compiler$unifiableFields = F4(
	function (vars, one, two, unified) {
		unifiableFields:
		while (true) {
			var _v27 = _Utils_Tuple2(one, two);
			if (!_v27.a.b) {
				if (!_v27.b.b) {
					return _Utils_Tuple2(
						vars,
						$elm$core$Result$Ok(
							$author$project$Internal$Compiler$nodifyAll(
								$elm$core$List$reverse(unified))));
				} else {
					return _Utils_Tuple2(
						vars,
						$elm$core$Result$Err('Mismatched numbers of type variables'));
				}
			} else {
				var _v28 = _v27.a;
				var oneX = _v28.a;
				var oneRemain = _v28.b;
				var twoFields = _v27.b;
				var _v29 = $author$project$Internal$Compiler$denode(oneX);
				var oneFieldName = _v29.a;
				var oneFieldVal = _v29.b;
				var oneName = $author$project$Internal$Compiler$denode(oneFieldName);
				var oneVal = $author$project$Internal$Compiler$denode(oneFieldVal);
				var _v30 = A4($author$project$Internal$Compiler$getField, oneName, oneVal, twoFields, _List_Nil);
				if (!_v30.$) {
					var _v31 = _v30.a;
					var matchingFieldVal = _v31.a;
					var remainingTwo = _v31.b;
					var _v32 = A3($author$project$Internal$Compiler$unifiableHelper, vars, oneVal, matchingFieldVal);
					var newVars = _v32.a;
					var unifiedField = _v32.b;
					var $temp$vars = newVars,
						$temp$one = oneRemain,
						$temp$two = remainingTwo,
						$temp$unified = A2($elm$core$List$cons, unifiedField, unified);
					vars = $temp$vars;
					one = $temp$one;
					two = $temp$two;
					unified = $temp$unified;
					continue unifiableFields;
				} else {
					var notFound = _v30.a;
					return _Utils_Tuple2(
						vars,
						$elm$core$Result$Err('Could not find ' + oneName));
				}
			}
		}
	});
var $author$project$Internal$Compiler$unifiableHelper = F3(
	function (vars, one, two) {
		unifiableHelper:
		while (true) {
			switch (one.$) {
				case 0:
					var varName = one.a;
					var _v8 = A2($elm$core$Dict$get, varName, vars);
					if (_v8.$ === 1) {
						return _Utils_Tuple2(
							A3($elm$core$Dict$insert, varName, two, vars),
							$elm$core$Result$Ok(two));
					} else {
						var found = _v8.a;
						if (!two.$) {
							var varNameB = two.a;
							var _v10 = A2($elm$core$Dict$get, varNameB, vars);
							if (_v10.$ === 1) {
								return _Utils_Tuple2(
									A3($elm$core$Dict$insert, varNameB, found, vars),
									$elm$core$Result$Ok(two));
							} else {
								var foundTwo = _v10.a;
								var $temp$vars = vars,
									$temp$one = found,
									$temp$two = foundTwo;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiableHelper;
							}
						} else {
							var $temp$vars = vars,
								$temp$one = found,
								$temp$two = two;
							vars = $temp$vars;
							one = $temp$one;
							two = $temp$two;
							continue unifiableHelper;
						}
					}
				case 1:
					var oneName = one.a;
					var oneContents = one.b;
					switch (two.$) {
						case 1:
							var twoName = two.a;
							var twoContents = two.b;
							if (_Utils_eq(
								$author$project$Internal$Compiler$denode(oneName),
								$author$project$Internal$Compiler$denode(twoName))) {
								var _v12 = A4($author$project$Internal$Compiler$unifiableLists, vars, oneContents, twoContents, _List_Nil);
								if (!_v12.b.$) {
									var newVars = _v12.a;
									var unifiedContent = _v12.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Ok(
											A2($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed, twoName, unifiedContent)));
								} else {
									var newVars = _v12.a;
									var err = _v12.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Err(err));
								}
							} else {
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Err('Unable to unify container!'));
							}
						case 0:
							var b = two.a;
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Ok(one));
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err('Unable to unify container!'));
					}
				case 2:
					switch (two.$) {
						case 0:
							var b = two.a;
							var _v14 = A2($elm$core$Dict$get, b, vars);
							if (_v14.$ === 1) {
								return _Utils_Tuple2(
									A3($elm$core$Dict$insert, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v14.a;
								var $temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiableHelper;
							}
						case 2:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Ok($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit));
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err('Unable to unify units!'));
					}
				case 3:
					var valsA = one.a;
					switch (two.$) {
						case 0:
							var b = two.a;
							var _v16 = A2($elm$core$Dict$get, b, vars);
							if (_v16.$ === 1) {
								return _Utils_Tuple2(
									A3($elm$core$Dict$insert, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v16.a;
								var $temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiableHelper;
							}
						case 3:
							var valsB = two.a;
							var _v17 = A4($author$project$Internal$Compiler$unifiableLists, vars, valsA, valsB, _List_Nil);
							if (!_v17.b.$) {
								var newVars = _v17.a;
								var unified = _v17.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Ok(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(unified)));
							} else {
								var newVars = _v17.a;
								var err = _v17.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Err(err));
							}
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err('Unable to unify tuples!'));
					}
				case 4:
					var fieldsA = one.a;
					switch (two.$) {
						case 0:
							var b = two.a;
							var _v19 = A2($elm$core$Dict$get, b, vars);
							if (_v19.$ === 1) {
								return _Utils_Tuple2(
									A3($elm$core$Dict$insert, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v19.a;
								var $temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiableHelper;
							}
						case 4:
							var fieldsB = two.a;
							var _v20 = A4($author$project$Internal$Compiler$unifiableFields, vars, fieldsA, fieldsB, _List_Nil);
							if (!_v20.b.$) {
								var newVars = _v20.a;
								var unifiedFields = _v20.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Ok(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(unifiedFields)));
							} else {
								var newVars = _v20.a;
								var err = _v20.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Err(err));
							}
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err('Unable to unify function with non function type!'));
					}
				case 5:
					var reVarName = one.a;
					var fieldsA = one.b;
					switch (two.$) {
						case 0:
							var b = two.a;
							var _v22 = A2($elm$core$Dict$get, b, vars);
							if (_v22.$ === 1) {
								return _Utils_Tuple2(
									A3($elm$core$Dict$insert, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v22.a;
								var $temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiableHelper;
							}
						case 4:
							var fieldsB = two.a;
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err('Unable to unify function with non function type!'));
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err('Unable to unify function with non function type!'));
					}
				default:
					var oneA = one.a;
					var oneB = one.b;
					switch (two.$) {
						case 0:
							var b = two.a;
							var _v24 = A2($elm$core$Dict$get, b, vars);
							if (_v24.$ === 1) {
								return _Utils_Tuple2(
									A3($elm$core$Dict$insert, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v24.a;
								var $temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiableHelper;
							}
						case 6:
							var twoA = two.a;
							var twoB = two.b;
							var _v25 = A3(
								$author$project$Internal$Compiler$unifiableHelper,
								vars,
								$author$project$Internal$Compiler$denode(oneA),
								$author$project$Internal$Compiler$denode(twoA));
							if (!_v25.b.$) {
								var aVars = _v25.a;
								var unifiedA = _v25.b.a;
								var _v26 = A3(
									$author$project$Internal$Compiler$unifiableHelper,
									aVars,
									$author$project$Internal$Compiler$denode(oneB),
									$author$project$Internal$Compiler$denode(twoB));
								if (!_v26.b.$) {
									var bVars = _v26.a;
									var unifiedB = _v26.b.a;
									return _Utils_Tuple2(
										bVars,
										$elm$core$Result$Ok(
											A2(
												$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
												$author$project$Internal$Compiler$nodify(unifiedA),
												$author$project$Internal$Compiler$nodify(unifiedB))));
								} else {
									var otherwise = _v26;
									return otherwise;
								}
							} else {
								var otherwise = _v25;
								return otherwise;
							}
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err('Unable to unify function with non function type!'));
					}
			}
		}
	});
var $author$project$Internal$Compiler$unifiableLists = F4(
	function (vars, one, two, unified) {
		unifiableLists:
		while (true) {
			var _v0 = _Utils_Tuple2(one, two);
			_v0$3:
			while (true) {
				if (!_v0.a.b) {
					if (!_v0.b.b) {
						return _Utils_Tuple2(
							vars,
							$elm$core$Result$Ok(
								$author$project$Internal$Compiler$nodifyAll(
									$elm$core$List$reverse(unified))));
					} else {
						break _v0$3;
					}
				} else {
					if (_v0.b.b) {
						if ((!_v0.a.b.b) && (!_v0.b.b.b)) {
							var _v1 = _v0.a;
							var oneX = _v1.a;
							var _v2 = _v0.b;
							var twoX = _v2.a;
							var _v3 = A3(
								$author$project$Internal$Compiler$unifiableHelper,
								vars,
								$author$project$Internal$Compiler$denode(oneX),
								$author$project$Internal$Compiler$denode(twoX));
							if (!_v3.b.$) {
								var newVars = _v3.a;
								var un = _v3.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Ok(
										$author$project$Internal$Compiler$nodifyAll(
											$elm$core$List$reverse(
												A2($elm$core$List$cons, un, unified)))));
							} else {
								var newVars = _v3.a;
								var err = _v3.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Err(err));
							}
						} else {
							var _v4 = _v0.a;
							var oneX = _v4.a;
							var oneRemain = _v4.b;
							var _v5 = _v0.b;
							var twoX = _v5.a;
							var twoRemain = _v5.b;
							var _v6 = A3(
								$author$project$Internal$Compiler$unifiableHelper,
								vars,
								$author$project$Internal$Compiler$denode(oneX),
								$author$project$Internal$Compiler$denode(twoX));
							if (!_v6.b.$) {
								var newVars = _v6.a;
								var un = _v6.b.a;
								var $temp$vars = newVars,
									$temp$one = oneRemain,
									$temp$two = twoRemain,
									$temp$unified = A2($elm$core$List$cons, un, unified);
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								unified = $temp$unified;
								continue unifiableLists;
							} else {
								var newVars = _v6.a;
								var err = _v6.b.a;
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Err(err));
							}
						}
					} else {
						break _v0$3;
					}
				}
			}
			return _Utils_Tuple2(
				vars,
				$elm$core$Result$Err('Mismatched numbers of type variables'));
		}
	});
var $author$project$Internal$Compiler$unifiable = F2(
	function (one, two) {
		var _v0 = A3($author$project$Internal$Compiler$unifiableHelper, $elm$core$Dict$empty, one, two);
		var result = _v0.b;
		var _v1 = function () {
			if (!result.$) {
				return _Utils_Tuple2(one, two);
			} else {
				return _Utils_Tuple2(one, two);
			}
		}();
		return result;
	});
var $author$project$Internal$Compiler$applyTypeHelper = F2(
	function (fn, args) {
		applyTypeHelper:
		while (true) {
			if (fn.$ === 6) {
				var one = fn.a;
				var two = fn.b;
				if (!args.b) {
					return $elm$core$Result$Ok(fn);
				} else {
					var top = args.a;
					var rest = args.b;
					var _v2 = A2(
						$author$project$Internal$Compiler$unifiable,
						$author$project$Internal$Compiler$denode(one),
						top);
					if (!_v2.$) {
						if (!rest.b) {
							return $elm$core$Result$Ok(
								$author$project$Internal$Compiler$denode(two));
						} else {
							var $temp$fn = $author$project$Internal$Compiler$denode(two),
								$temp$args = rest;
							fn = $temp$fn;
							args = $temp$args;
							continue applyTypeHelper;
						}
					} else {
						var err = _v2.a;
						return $elm$core$Result$Err(_List_Nil);
					}
				}
			} else {
				var _final = fn;
				if (!args.b) {
					return $elm$core$Result$Ok(fn);
				} else {
					return $elm$core$Result$Err(
						_List_fromArray(
							[$author$project$Internal$Compiler$FunctionAppliedToTooManyArgs]));
				}
			}
		}
	});
var $author$project$Internal$Compiler$extractListAnnotation = F2(
	function (expressions, annotations) {
		extractListAnnotation:
		while (true) {
			if (!expressions.b) {
				return $elm$core$Result$Ok(
					$elm$core$List$reverse(annotations));
			} else {
				var top = expressions.a;
				var remain = expressions.b;
				var _v1 = top.c;
				if (!_v1.$) {
					var ann = _v1.a;
					var $temp$expressions = remain,
						$temp$annotations = A2($elm$core$List$cons, ann, annotations);
					expressions = $temp$expressions;
					annotations = $temp$annotations;
					continue extractListAnnotation;
				} else {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				}
			}
		}
	});
var $author$project$Internal$Compiler$applyType = F2(
	function (_v0, args) {
		var exp = _v0;
		var _v1 = exp.c;
		if (_v1.$ === 1) {
			var err = _v1.a;
			return $elm$core$Result$Err(err);
		} else {
			var topAnnotation = _v1.a;
			var _v2 = A2($author$project$Internal$Compiler$extractListAnnotation, args, _List_Nil);
			if (!_v2.$) {
				var types = _v2.a;
				return A2($author$project$Internal$Compiler$applyTypeHelper, topAnnotation, types);
			} else {
				var err = _v2.a;
				return $elm$core$Result$Err(err);
			}
		}
	});
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $elm$core$List$filter = F2(
	function (isGood, list) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, xs) {
					return isGood(x) ? A2($elm$core$List$cons, x, xs) : xs;
				}),
			_List_Nil,
			list);
	});
var $author$project$Elm$getExpression = function (_v0) {
	var exp = _v0;
	return exp.b;
};
var $author$project$Elm$getImports = function (_v0) {
	var exp = _v0;
	return exp.a;
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression = function (a) {
	return {$: 14, a: a};
};
var $author$project$Elm$parens = function (expr) {
	return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
		$author$project$Internal$Compiler$nodify(expr));
};
var $author$project$Elm$apply = F2(
	function (top, allArgs) {
		var exp = top;
		var args = A2(
			$elm$core$List$filter,
			function (_v0) {
				var arg = _v0;
				return !arg.g;
			},
			allArgs);
		return {
			c: A2($author$project$Internal$Compiler$applyType, top, args),
			b: $stil4m$elm_syntax$Elm$Syntax$Expression$Application(
				$author$project$Internal$Compiler$nodifyAll(
					A2(
						$elm$core$List$cons,
						exp.b,
						A2(
							$elm$core$List$map,
							A2($elm$core$Basics$composeL, $author$project$Elm$parens, $author$project$Elm$getExpression),
							args)))),
			a: _Utils_ap(
				exp.a,
				A2($elm$core$List$concatMap, $author$project$Elm$getImports, args)),
			g: false
		};
	});
var $author$project$Elm$Annotation$function = F2(
	function (anns, _return) {
		return {
			c: A3(
				$elm$core$List$foldr,
				F2(
					function (ann, fn) {
						return A2(
							$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
							$author$project$Internal$Compiler$nodify(ann),
							$author$project$Internal$Compiler$nodify(fn));
					}),
				$author$project$Internal$Compiler$getInnerAnnotation(_return),
				A2($elm$core$List$map, $author$project$Internal$Compiler$getInnerAnnotation, anns)),
			a: _Utils_ap(
				$author$project$Internal$Compiler$getAnnotationImports(_return),
				A2($elm$core$List$concatMap, $author$project$Internal$Compiler$getAnnotationImports, anns))
		};
	});
var $author$project$Elm$Annotation$tuple = F2(
	function (one, two) {
		return {
			c: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(
				$author$project$Internal$Compiler$nodifyAll(
					_List_fromArray(
						[
							$author$project$Internal$Compiler$getInnerAnnotation(one),
							$author$project$Internal$Compiler$getInnerAnnotation(two)
						]))),
			a: _Utils_ap(
				$author$project$Internal$Compiler$getAnnotationImports(one),
				$author$project$Internal$Compiler$getAnnotationImports(two))
		};
	});
var $author$project$Elm$Gen$Elm$Annotation$extensible = F2(
	function (arg1, arg2) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$Annotation$moduleName_,
				'extensible',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Elm$Annotation$string,
							$author$project$Elm$Annotation$list(
							A2(
								$author$project$Elm$Annotation$tuple,
								$author$project$Elm$Annotation$string,
								A3(
									$author$project$Elm$Annotation$namedWith,
									_List_fromArray(
										['Elm', 'Annotation']),
									'Annotation',
									_List_Nil)))
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2]));
	});
var $author$project$Elm$Gen$Elm$Annotation$float = A3(
	$author$project$Elm$valueWith,
	$author$project$Elm$Gen$Elm$Annotation$moduleName_,
	'float',
	A3(
		$author$project$Elm$Annotation$namedWith,
		_List_fromArray(
			['Elm', 'Annotation']),
		'Annotation',
		_List_Nil));
var $author$project$Elm$Gen$Elm$Annotation$function = F2(
	function (arg1, arg2) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$Annotation$moduleName_,
				'function',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Elm$Annotation$list(
							A3(
								$author$project$Elm$Annotation$namedWith,
								_List_fromArray(
									['Elm', 'Annotation']),
								'Annotation',
								_List_Nil)),
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil)
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2]));
	});
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Elm$Gen$Elm$Annotation$int = A3(
	$author$project$Elm$valueWith,
	$author$project$Elm$Gen$Elm$Annotation$moduleName_,
	'int',
	A3(
		$author$project$Elm$Annotation$namedWith,
		_List_fromArray(
			['Elm', 'Annotation']),
		'Annotation',
		_List_Nil));
var $stil4m$elm_syntax$Elm$Syntax$Expression$ListExpr = function (a) {
	return {$: 19, a: a};
};
var $elm$core$Result$map = F2(
	function (func, ra) {
		if (!ra.$) {
			var a = ra.a;
			return $elm$core$Result$Ok(
				func(a));
		} else {
			var e = ra.a;
			return $elm$core$Result$Err(e);
		}
	});
var $author$project$Elm$toList = function (_v0) {
	var exp = _v0;
	return $author$project$Internal$Compiler$nodify(exp.b);
};
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType = function (a) {
	return {$: 0, a: a};
};
var $author$project$Internal$Compiler$MismatchedList = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $author$project$Internal$Compiler$unifyHelper = F2(
	function (exps, existing) {
		unifyHelper:
		while (true) {
			if (!exps.b) {
				return $elm$core$Result$Ok(existing);
			} else {
				var top = exps.a;
				var remain = exps.b;
				var _v1 = top.c;
				if (!_v1.$) {
					var ann = _v1.a;
					var _v2 = A2($author$project$Internal$Compiler$unifiable, ann, existing);
					if (_v2.$ === 1) {
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									A2($author$project$Internal$Compiler$MismatchedList, ann, existing)
								]));
					} else {
						var _new = _v2.a;
						var $temp$exps = remain,
							$temp$existing = _new;
						exps = $temp$exps;
						existing = $temp$existing;
						continue unifyHelper;
					}
				} else {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				}
			}
		}
	});
var $author$project$Internal$Compiler$unify = function (exps) {
	if (!exps.b) {
		return $elm$core$Result$Ok(
			$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType('a'));
	} else {
		var top = exps.a;
		var remain = exps.b;
		var _v1 = top.c;
		if (!_v1.$) {
			var ann = _v1.a;
			return A2($author$project$Internal$Compiler$unifyHelper, remain, ann);
		} else {
			var err = _v1.a;
			return $elm$core$Result$Err(err);
		}
	}
};
var $author$project$Elm$list = function (exprs) {
	return {
		c: A2(
			$elm$core$Result$map,
			function (inner) {
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
					$author$project$Internal$Compiler$nodify(
						_Utils_Tuple2(_List_Nil, 'List')),
					_List_fromArray(
						[
							$author$project$Internal$Compiler$nodify(inner)
						]));
			},
			$author$project$Internal$Compiler$unify(exprs)),
		b: $stil4m$elm_syntax$Elm$Syntax$Expression$ListExpr(
			A2($elm$core$List$map, $author$project$Elm$toList, exprs)),
		a: A2($elm$core$List$concatMap, $author$project$Elm$getImports, exprs),
		g: false
	};
};
var $author$project$Elm$Gen$Elm$Annotation$list = function (arg1) {
	return A2(
		$author$project$Elm$apply,
		A3(
			$author$project$Elm$valueWith,
			$author$project$Elm$Gen$Elm$Annotation$moduleName_,
			'list',
			A2(
				$author$project$Elm$Annotation$function,
				_List_fromArray(
					[
						A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil)
					]),
				A3(
					$author$project$Elm$Annotation$namedWith,
					_List_fromArray(
						['Elm', 'Annotation']),
					'Annotation',
					_List_Nil))),
		_List_fromArray(
			[arg1]));
};
var $author$project$Elm$Gen$Elm$Annotation$maybe = function (arg1) {
	return A2(
		$author$project$Elm$apply,
		A3(
			$author$project$Elm$valueWith,
			$author$project$Elm$Gen$Elm$Annotation$moduleName_,
			'maybe',
			A2(
				$author$project$Elm$Annotation$function,
				_List_fromArray(
					[
						A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil)
					]),
				A3(
					$author$project$Elm$Annotation$namedWith,
					_List_fromArray(
						['Elm', 'Annotation']),
					'Annotation',
					_List_Nil))),
		_List_fromArray(
			[arg1]));
};
var $author$project$Elm$Gen$Elm$Annotation$namedWith = F3(
	function (arg1, arg2, arg3) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$Annotation$moduleName_,
				'namedWith',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Elm$Annotation$list($author$project$Elm$Annotation$string),
							$author$project$Elm$Annotation$string,
							$author$project$Elm$Annotation$list(
							A3(
								$author$project$Elm$Annotation$namedWith,
								_List_fromArray(
									['Elm', 'Annotation']),
								'Annotation',
								_List_Nil))
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2, arg3]));
	});
var $author$project$Elm$Gen$Elm$Annotation$record = function (arg1) {
	return A2(
		$author$project$Elm$apply,
		A3(
			$author$project$Elm$valueWith,
			$author$project$Elm$Gen$Elm$Annotation$moduleName_,
			'record',
			A2(
				$author$project$Elm$Annotation$function,
				_List_fromArray(
					[
						$author$project$Elm$Annotation$list(
						A2(
							$author$project$Elm$Annotation$tuple,
							$author$project$Elm$Annotation$string,
							A3(
								$author$project$Elm$Annotation$namedWith,
								_List_fromArray(
									['Elm', 'Annotation']),
								'Annotation',
								_List_Nil)))
					]),
				A3(
					$author$project$Elm$Annotation$namedWith,
					_List_fromArray(
						['Elm', 'Annotation']),
					'Annotation',
					_List_Nil))),
		_List_fromArray(
			[arg1]));
};
var $author$project$Elm$Gen$Elm$Annotation$string = A3(
	$author$project$Elm$valueWith,
	$author$project$Elm$Gen$Elm$Annotation$moduleName_,
	'string',
	A3(
		$author$project$Elm$Annotation$namedWith,
		_List_fromArray(
			['Elm', 'Annotation']),
		'Annotation',
		_List_Nil));
var $elm$core$List$takeReverse = F3(
	function (n, list, kept) {
		takeReverse:
		while (true) {
			if (n <= 0) {
				return kept;
			} else {
				if (!list.b) {
					return kept;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs,
						$temp$kept = A2($elm$core$List$cons, x, kept);
					n = $temp$n;
					list = $temp$list;
					kept = $temp$kept;
					continue takeReverse;
				}
			}
		}
	});
var $elm$core$List$takeTailRec = F2(
	function (n, list) {
		return $elm$core$List$reverse(
			A3($elm$core$List$takeReverse, n, list, _List_Nil));
	});
var $elm$core$List$takeFast = F3(
	function (ctr, n, list) {
		if (n <= 0) {
			return _List_Nil;
		} else {
			var _v0 = _Utils_Tuple2(n, list);
			_v0$1:
			while (true) {
				_v0$5:
				while (true) {
					if (!_v0.b.b) {
						return list;
					} else {
						if (_v0.b.b.b) {
							switch (_v0.a) {
								case 1:
									break _v0$1;
								case 2:
									var _v2 = _v0.b;
									var x = _v2.a;
									var _v3 = _v2.b;
									var y = _v3.a;
									return _List_fromArray(
										[x, y]);
								case 3:
									if (_v0.b.b.b.b) {
										var _v4 = _v0.b;
										var x = _v4.a;
										var _v5 = _v4.b;
										var y = _v5.a;
										var _v6 = _v5.b;
										var z = _v6.a;
										return _List_fromArray(
											[x, y, z]);
									} else {
										break _v0$5;
									}
								default:
									if (_v0.b.b.b.b && _v0.b.b.b.b.b) {
										var _v7 = _v0.b;
										var x = _v7.a;
										var _v8 = _v7.b;
										var y = _v8.a;
										var _v9 = _v8.b;
										var z = _v9.a;
										var _v10 = _v9.b;
										var w = _v10.a;
										var tl = _v10.b;
										return (ctr > 1000) ? A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A2($elm$core$List$takeTailRec, n - 4, tl))))) : A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A3($elm$core$List$takeFast, ctr + 1, n - 4, tl)))));
									} else {
										break _v0$5;
									}
							}
						} else {
							if (_v0.a === 1) {
								break _v0$1;
							} else {
								break _v0$5;
							}
						}
					}
				}
				return list;
			}
			var _v1 = _v0.b;
			var x = _v1.a;
			return _List_fromArray(
				[x]);
		}
	});
var $elm$core$List$take = F2(
	function (n, list) {
		return A3($elm$core$List$takeFast, 0, n, list);
	});
var $author$project$Elm$Gen$Elm$Annotation$triple = F3(
	function (arg1, arg2, arg3) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$Annotation$moduleName_,
				'triple',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil),
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil),
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil)
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2, arg3]));
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$TupledExpression = function (a) {
	return {$: 13, a: a};
};
var $elm$core$Result$map2 = F3(
	function (func, ra, rb) {
		if (ra.$ === 1) {
			var x = ra.a;
			return $elm$core$Result$Err(x);
		} else {
			var a = ra.a;
			if (rb.$ === 1) {
				var x = rb.a;
				return $elm$core$Result$Err(x);
			} else {
				var b = rb.a;
				return $elm$core$Result$Ok(
					A2(func, a, b));
			}
		}
	});
var $author$project$Internal$Compiler$noImports = function (tipe) {
	return {c: tipe, a: _List_Nil};
};
var $author$project$Elm$tuple = F2(
	function (_v0, _v1) {
		var one = _v0;
		var two = _v1;
		return {
			c: A3(
				$elm$core$Result$map2,
				F2(
					function (oneA, twoA) {
						return $author$project$Internal$Compiler$getInnerAnnotation(
							A2(
								$author$project$Elm$Annotation$tuple,
								$author$project$Internal$Compiler$noImports(oneA),
								$author$project$Internal$Compiler$noImports(twoA)));
					}),
				one.c,
				two.c),
			b: $stil4m$elm_syntax$Elm$Syntax$Expression$TupledExpression(
				$author$project$Internal$Compiler$nodifyAll(
					_List_fromArray(
						[one.b, two.b]))),
			a: _Utils_ap(one.a, two.a),
			g: false
		};
	});
var $author$project$Elm$Gen$Elm$Annotation$tuple = F2(
	function (arg1, arg2) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$Annotation$moduleName_,
				'tuple',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil),
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil)
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2]));
	});
var $author$project$Elm$Gen$Elm$Annotation$unit = A3(
	$author$project$Elm$valueWith,
	$author$project$Elm$Gen$Elm$Annotation$moduleName_,
	'unit',
	A3(
		$author$project$Elm$Annotation$namedWith,
		_List_fromArray(
			['Elm', 'Annotation']),
		'Annotation',
		_List_Nil));
var $author$project$Elm$Gen$Elm$Annotation$var = function (arg1) {
	return A2(
		$author$project$Elm$apply,
		A3(
			$author$project$Elm$valueWith,
			$author$project$Elm$Gen$Elm$Annotation$moduleName_,
			'var',
			A2(
				$author$project$Elm$Annotation$function,
				_List_fromArray(
					[$author$project$Elm$Annotation$string]),
				A3(
					$author$project$Elm$Annotation$namedWith,
					_List_fromArray(
						['Elm', 'Annotation']),
					'Annotation',
					_List_Nil))),
		_List_fromArray(
			[arg1]));
};
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (!maybe.$) {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $author$project$Generate$chompLambdas = F2(
	function (exps, tipe) {
		chompLambdas:
		while (true) {
			if (tipe.$ === 1) {
				var one = tipe.a;
				var two = tipe.b;
				var $temp$exps = A2(
					$elm$core$List$cons,
					$author$project$Generate$typeToExpression(one),
					exps),
					$temp$tipe = two;
				exps = $temp$exps;
				tipe = $temp$tipe;
				continue chompLambdas;
			} else {
				return A2(
					$author$project$Elm$Gen$Elm$Annotation$function,
					$author$project$Elm$list(
						$elm$core$List$reverse(exps)),
					$author$project$Generate$typeToExpression(tipe));
			}
		}
	});
var $author$project$Generate$namedWithType = F2(
	function (name, types) {
		var frags = A2($elm$core$String$split, '.', name);
		_v8$6:
		while (true) {
			if ((frags.b && frags.b.b) && (!frags.b.b.b)) {
				switch (frags.a) {
					case 'List':
						if (frags.b.a === 'List') {
							var _v9 = frags.b;
							if (types.b && (!types.b.b)) {
								var inner = types.a;
								return $author$project$Elm$Gen$Elm$Annotation$list(
									$author$project$Generate$typeToExpression(inner));
							} else {
								return $author$project$Elm$Gen$Elm$Annotation$unit;
							}
						} else {
							break _v8$6;
						}
					case 'Maybe':
						if (frags.b.a === 'Maybe') {
							var _v11 = frags.b;
							if (types.b && (!types.b.b)) {
								var inner = types.a;
								return $author$project$Elm$Gen$Elm$Annotation$maybe(
									$author$project$Generate$typeToExpression(inner));
							} else {
								return $author$project$Elm$Gen$Elm$Annotation$unit;
							}
						} else {
							break _v8$6;
						}
					case 'Basics':
						switch (frags.b.a) {
							case 'Int':
								var _v13 = frags.b;
								return $author$project$Elm$Gen$Elm$Annotation$int;
							case 'Float':
								var _v14 = frags.b;
								return $author$project$Elm$Gen$Elm$Annotation$float;
							case 'Bool':
								var _v15 = frags.b;
								return $author$project$Elm$Gen$Elm$Annotation$bool;
							default:
								break _v8$6;
						}
					case 'String':
						if (frags.b.a === 'String') {
							var _v16 = frags.b;
							return $author$project$Elm$Gen$Elm$Annotation$string;
						} else {
							break _v8$6;
						}
					default:
						break _v8$6;
				}
			} else {
				break _v8$6;
			}
		}
		var fragsLength = $elm$core$List$length(frags);
		var typeName = A2(
			$elm$core$Maybe$withDefault,
			name,
			$elm$core$List$head(
				A2($elm$core$List$drop, fragsLength - 1, frags)));
		return A3(
			$author$project$Elm$Gen$Elm$Annotation$namedWith,
			$author$project$Elm$list(
				A2(
					$elm$core$List$map,
					$author$project$Elm$string,
					A2($elm$core$List$take, fragsLength - 1, frags))),
			$author$project$Elm$string(typeName),
			$author$project$Elm$list(
				A2($elm$core$List$map, $author$project$Generate$typeToExpression, types)));
	});
var $author$project$Generate$typeToExpression = function (elmType) {
	switch (elmType.$) {
		case 0:
			var string = elmType.a;
			return $author$project$Elm$Gen$Elm$Annotation$var(
				$author$project$Elm$string(string));
		case 1:
			var one = elmType.a;
			var two = elmType.b;
			return A2(
				$author$project$Generate$chompLambdas,
				_List_fromArray(
					[
						$author$project$Generate$typeToExpression(one)
					]),
				two);
		case 2:
			var types = elmType.a;
			_v1$3:
			while (true) {
				if (!types.b) {
					return $author$project$Elm$Gen$Elm$Annotation$unit;
				} else {
					if (types.b.b) {
						if (!types.b.b.b) {
							var one = types.a;
							var _v2 = types.b;
							var two = _v2.a;
							return A2(
								$author$project$Elm$Gen$Elm$Annotation$tuple,
								$author$project$Generate$typeToExpression(one),
								$author$project$Generate$typeToExpression(two));
						} else {
							if (!types.b.b.b.b) {
								var one = types.a;
								var _v3 = types.b;
								var two = _v3.a;
								var _v4 = _v3.b;
								var three = _v4.a;
								return A3(
									$author$project$Elm$Gen$Elm$Annotation$triple,
									$author$project$Generate$typeToExpression(one),
									$author$project$Generate$typeToExpression(two),
									$author$project$Generate$typeToExpression(three));
							} else {
								break _v1$3;
							}
						}
					} else {
						break _v1$3;
					}
				}
			}
			return A3($author$project$Elm$valueWith, $author$project$Generate$elmAnnotation, 'unit', $author$project$Generate$annotationType);
		case 3:
			var name = elmType.a;
			var types = elmType.b;
			return A2($author$project$Generate$namedWithType, name, types);
		default:
			var fields = elmType.a;
			var maybeExtensible = elmType.b;
			if (maybeExtensible.$ === 1) {
				return $author$project$Elm$Gen$Elm$Annotation$record(
					$author$project$Elm$list(
						A2(
							$elm$core$List$map,
							function (_v6) {
								var fieldName = _v6.a;
								var fieldType = _v6.b;
								return A2(
									$author$project$Elm$tuple,
									$author$project$Elm$string(fieldName),
									$author$project$Generate$typeToExpression(fieldType));
							},
							fields)));
			} else {
				var base = maybeExtensible.a;
				return A2(
					$author$project$Elm$Gen$Elm$Annotation$extensible,
					$author$project$Elm$string(base),
					$author$project$Elm$list(
						A2(
							$elm$core$List$map,
							function (_v7) {
								var fieldName = _v7.a;
								var fieldType = _v7.b;
								return A2(
									$author$project$Elm$tuple,
									$author$project$Elm$string(fieldName),
									$author$project$Generate$typeToExpression(fieldType));
							},
							fields)));
			}
	}
};
var $author$project$Elm$Gen$Elm$moduleName_ = _List_fromArray(
	['Elm']);
var $author$project$Elm$Gen$Elm$valueWith = F3(
	function (arg1, arg2, arg3) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$moduleName_,
				'valueWith',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Elm$Annotation$list($author$project$Elm$Annotation$string),
							$author$project$Elm$Annotation$string,
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil)
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm']),
						'Expression',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2, arg3]));
	});
var $author$project$Generate$valueWith = F3(
	function (mod, name, annotation) {
		return A3(
			$author$project$Elm$Gen$Elm$valueWith,
			mod,
			name,
			$author$project$Generate$typeToExpression(annotation));
	});
var $author$project$Generate$blockToIdField = function (block) {
	switch (block.$) {
		case 0:
			var str = block.a;
			return $elm$core$Maybe$Nothing;
		case 1:
			var union = block.a;
			return $elm$core$Maybe$Nothing;
		case 2:
			var alias = block.a;
			return $elm$core$Maybe$Nothing;
		case 3:
			var value = block.a;
			return $elm$core$Maybe$Just(
				A2(
					$author$project$Elm$field,
					value.I,
					A3(
						$author$project$Generate$valueWith,
						$author$project$Generate$thisModuleName,
						$author$project$Elm$string(value.I),
						value.aU)));
		case 4:
			var binop = block.a;
			return $elm$core$Maybe$Nothing;
		default:
			var str = block.a;
			return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Internal$Compiler$Declaration = F3(
	function (a, b, c) {
		return {$: 0, a: a, b: b, c: c};
	});
var $stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration = function (a) {
	return {$: 0, a: a};
};
var $author$project$Internal$Compiler$NotExposed = {$: 0};
var $elm$core$String$toLower = _String_toLower;
var $author$project$Internal$Compiler$formatValue = function (str) {
	var formatted = _Utils_eq(
		$elm$core$String$toUpper(str),
		str) ? $elm$core$String$toLower(str) : _Utils_ap(
		$elm$core$String$toLower(
			A2($elm$core$String$left, 1, str)),
		A2($elm$core$String$dropLeft, 1, str));
	return $author$project$Internal$Compiler$sanitize(formatted);
};
var $elm$core$Maybe$map = F2(
	function (f, maybe) {
		if (!maybe.$) {
			var value = maybe.a;
			return $elm$core$Maybe$Just(
				f(value));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $author$project$Internal$Compiler$nodifyMaybe = $elm$core$Maybe$map($author$project$Internal$Compiler$nodify);
var $author$project$Elm$declaration = F2(
	function (name, _v0) {
		var body = _v0;
		return A3(
			$author$project$Internal$Compiler$Declaration,
			$author$project$Internal$Compiler$NotExposed,
			body.a,
			$stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(
				{
					bX: $author$project$Internal$Compiler$nodify(
						{
							bG: _List_Nil,
							b: $author$project$Internal$Compiler$nodify(body.b),
							I: $author$project$Internal$Compiler$nodify(
								$author$project$Internal$Compiler$formatValue(name))
						}),
					aw: $author$project$Internal$Compiler$nodifyMaybe($elm$core$Maybe$Nothing),
					db: function () {
						var _v1 = body.c;
						if (!_v1.$) {
							var sig = _v1.a;
							return $elm$core$Maybe$Just(
								$author$project$Internal$Compiler$nodify(
									{
										I: $author$project$Internal$Compiler$nodify(
											$author$project$Internal$Compiler$formatValue(name)),
										aV: $author$project$Internal$Compiler$nodify(sig)
									}));
						} else {
							return $elm$core$Maybe$Nothing;
						}
					}()
				}));
	});
var $author$project$Internal$Compiler$Exposed = function (a) {
	return {$: 1, a: a};
};
var $author$project$Internal$Compiler$expose = function (decl) {
	if (decl.$ === 1) {
		return decl;
	} else {
		var imports = decl.b;
		var body = decl.c;
		return A3(
			$author$project$Internal$Compiler$Declaration,
			$author$project$Internal$Compiler$Exposed(
				{am: false, ao: $elm$core$Maybe$Nothing}),
			imports,
			body);
	}
};
var $author$project$Elm$expose = $author$project$Internal$Compiler$expose;
var $author$project$Internal$Compiler$fullModName = function (name) {
	return A2($elm$core$String$join, '.', name);
};
var $elm$core$Set$insert = F2(
	function (key, _v0) {
		var dict = _v0;
		return A3($elm$core$Dict$insert, key, 0, dict);
	});
var $author$project$Elm$addImports = F3(
	function (self, newImports, _v0) {
		addImports:
		while (true) {
			var set = _v0.a;
			var deduped = _v0.b;
			if (!newImports.b) {
				return _Utils_Tuple2(set, deduped);
			} else {
				var _new = newImports.a;
				var remain = newImports.b;
				var full = $author$project$Internal$Compiler$fullModName(_new);
				if (A2($elm$core$Set$member, full, set) || _Utils_eq(
					full,
					$author$project$Internal$Compiler$fullModName(self))) {
					var $temp$self = self,
						$temp$newImports = remain,
						$temp$_v0 = _Utils_Tuple2(set, deduped);
					self = $temp$self;
					newImports = $temp$newImports;
					_v0 = $temp$_v0;
					continue addImports;
				} else {
					var $temp$self = self,
						$temp$newImports = remain,
						$temp$_v0 = _Utils_Tuple2(
						A2($elm$core$Set$insert, full, set),
						A2($elm$core$List$cons, _new, deduped));
					self = $temp$self;
					newImports = $temp$newImports;
					_v0 = $temp$_v0;
					continue addImports;
				}
			}
		}
	});
var $author$project$Elm$reduceDeclarationImports = F3(
	function (self, decs, imports) {
		reduceDeclarationImports:
		while (true) {
			if (!decs.b) {
				return imports;
			} else {
				if (decs.a.$ === 1) {
					var remain = decs.b;
					var $temp$self = self,
						$temp$decs = remain,
						$temp$imports = imports;
					self = $temp$self;
					decs = $temp$decs;
					imports = $temp$imports;
					continue reduceDeclarationImports;
				} else {
					var _v1 = decs.a;
					var newImports = _v1.b;
					var body = _v1.c;
					var remain = decs.b;
					var $temp$self = self,
						$temp$decs = remain,
						$temp$imports = A3($author$project$Elm$addImports, self, newImports, imports);
					self = $temp$self;
					decs = $temp$decs;
					imports = $temp$imports;
					continue reduceDeclarationImports;
				}
			}
		}
	});
var $stil4m$elm_syntax$Elm$Syntax$Exposing$All = function (a) {
	return {$: 0, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit = function (a) {
	return {$: 1, a: a};
};
var $author$project$Internal$Comments$Markdown = function (a) {
	return {$: 0, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Module$NormalModule = function (a) {
	return {$: 0, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Module$PortModule = function (a) {
	return {$: 1, a: a};
};
var $author$project$Internal$Comments$Comment = $elm$core$Basics$identity;
var $author$project$Internal$Comments$addPart = F2(
	function (_v0, part) {
		var parts = _v0;
		return A2($elm$core$List$cons, part, parts);
	});
var $author$project$Internal$Comments$emptyComment = _List_Nil;
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (!_v0.$) {
			var x = _v0.a;
			return A2($elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var $elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			$elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var $stil4m$elm_syntax$Elm$Syntax$Exposing$FunctionExpose = function (a) {
	return {$: 1, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose = function (a) {
	return {$: 3, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$TypeOrAliasExpose = function (a) {
	return {$: 2, a: a};
};
var $author$project$Internal$Compiler$getExposed = function (decls) {
	return A2(
		$elm$core$List$filterMap,
		function (decl) {
			if (decl.$ === 1) {
				return $elm$core$Maybe$Nothing;
			} else {
				var exp = decl.a;
				var decBody = decl.c;
				if (!exp.$) {
					return $elm$core$Maybe$Nothing;
				} else {
					var details = exp.a;
					switch (decBody.$) {
						case 0:
							var fn = decBody.a;
							var fnName = $author$project$Internal$Compiler$denode(
								function ($) {
									return $.I;
								}(
									$author$project$Internal$Compiler$denode(fn.bX)));
							return $elm$core$Maybe$Just(
								$stil4m$elm_syntax$Elm$Syntax$Exposing$FunctionExpose(fnName));
						case 1:
							var synonym = decBody.a;
							var aliasName = $author$project$Internal$Compiler$denode(synonym.I);
							return $elm$core$Maybe$Just(
								$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeOrAliasExpose(aliasName));
						case 2:
							var myType = decBody.a;
							var typeName = $author$project$Internal$Compiler$denode(myType.I);
							return details.am ? $elm$core$Maybe$Just(
								$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
									{
										I: typeName,
										cV: $elm$core$Maybe$Just($stil4m$elm_syntax$Elm$Syntax$Range$emptyRange)
									})) : $elm$core$Maybe$Just(
								$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeOrAliasExpose(typeName));
						case 3:
							var myPort = decBody.a;
							var typeName = $author$project$Internal$Compiler$denode(myPort.I);
							return $elm$core$Maybe$Just(
								$stil4m$elm_syntax$Elm$Syntax$Exposing$FunctionExpose(typeName));
						case 4:
							var infix = decBody.a;
							return $elm$core$Maybe$Nothing;
						default:
							return $elm$core$Maybe$Nothing;
					}
				}
			}
		},
		decls);
};
var $author$project$Internal$Compiler$declName = function (decl) {
	if (decl.$ === 1) {
		return $elm$core$Maybe$Nothing;
	} else {
		var exp = decl.a;
		var decBody = decl.c;
		switch (decBody.$) {
			case 0:
				var fn = decBody.a;
				return $elm$core$Maybe$Just(
					$author$project$Internal$Compiler$denode(
						function ($) {
							return $.I;
						}(
							$author$project$Internal$Compiler$denode(fn.bX))));
			case 1:
				var synonym = decBody.a;
				return $elm$core$Maybe$Just(
					$author$project$Internal$Compiler$denode(synonym.I));
			case 2:
				var myType = decBody.a;
				return $elm$core$Maybe$Just(
					$author$project$Internal$Compiler$denode(myType.I));
			case 3:
				var myPort = decBody.a;
				return $elm$core$Maybe$Just(
					$author$project$Internal$Compiler$denode(myPort.I));
			case 4:
				var infix = decBody.a;
				return $elm$core$Maybe$Nothing;
			default:
				return $elm$core$Maybe$Nothing;
		}
	}
};
var $author$project$Internal$Compiler$matchName = F2(
	function (one, two) {
		if (one.$ === 1) {
			if (two.$ === 1) {
				return true;
			} else {
				return false;
			}
		} else {
			var oneName = one.a;
			if (two.$ === 1) {
				return false;
			} else {
				var twoName = two.a;
				return _Utils_eq(oneName, twoName);
			}
		}
	});
var $author$project$Internal$Compiler$groupExposing = function (items) {
	return A3(
		$elm$core$List$foldr,
		F2(
			function (_v0, acc) {
				var maybeGroup = _v0.a;
				var name = _v0.b;
				if (!acc.b) {
					return _List_fromArray(
						[
							{
							ao: maybeGroup,
							cM: _List_fromArray(
								[name])
						}
						]);
				} else {
					var top = acc.a;
					var groups = acc.b;
					return A2($author$project$Internal$Compiler$matchName, maybeGroup, top.ao) ? A2(
						$elm$core$List$cons,
						{
							ao: top.ao,
							cM: A2($elm$core$List$cons, name, top.cM)
						},
						groups) : A2(
						$elm$core$List$cons,
						{
							ao: maybeGroup,
							cM: _List_fromArray(
								[name])
						},
						acc);
				}
			}),
		_List_Nil,
		items);
};
var $elm$core$List$sortBy = _List_sortBy;
var $author$project$Internal$Compiler$getExposedGroups = function (decls) {
	return $author$project$Internal$Compiler$groupExposing(
		A2(
			$elm$core$List$sortBy,
			function (_v3) {
				var group = _v3.a;
				if (group.$ === 1) {
					return 'zzzzzzzzz';
				} else {
					var name = group.a;
					return name;
				}
			},
			A2(
				$elm$core$List$filterMap,
				function (decl) {
					if (decl.$ === 1) {
						return $elm$core$Maybe$Nothing;
					} else {
						var exp = decl.a;
						var decBody = decl.c;
						if (!exp.$) {
							return $elm$core$Maybe$Nothing;
						} else {
							var details = exp.a;
							var _v2 = $author$project$Internal$Compiler$declName(decl);
							if (_v2.$ === 1) {
								return $elm$core$Maybe$Nothing;
							} else {
								var name = _v2.a;
								return $elm$core$Maybe$Just(
									_Utils_Tuple2(details.ao, name));
							}
						}
					}
				},
				decls)));
};
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $author$project$Internal$Compiler$hasPorts = function (decls) {
	return A2(
		$elm$core$List$any,
		function (decl) {
			if (decl.$ === 1) {
				return false;
			} else {
				var exp = decl.a;
				var decBody = decl.c;
				if (!exp.$) {
					return false;
				} else {
					if (decBody.$ === 3) {
						var myPort = decBody.a;
						return true;
					} else {
						return false;
					}
				}
			}
		},
		decls);
};
var $author$project$Internal$Compiler$builtIn = function (name) {
	_v0$4:
	while (true) {
		if (name.b && (!name.b.b)) {
			switch (name.a) {
				case 'List':
					return true;
				case 'Maybe':
					return true;
				case 'String':
					return true;
				case 'Basics':
					return true;
				default:
					break _v0$4;
			}
		} else {
			break _v0$4;
		}
	}
	return false;
};
var $author$project$Internal$Compiler$findAlias = F2(
	function (modName, aliases) {
		findAlias:
		while (true) {
			if (!aliases.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var _v1 = aliases.a;
				var aliasModName = _v1.a;
				var alias = _v1.b;
				var remain = aliases.b;
				if (_Utils_eq(modName, aliasModName)) {
					return $elm$core$Maybe$Just(alias);
				} else {
					var $temp$modName = modName,
						$temp$aliases = remain;
					modName = $temp$modName;
					aliases = $temp$aliases;
					continue findAlias;
				}
			}
		}
	});
var $author$project$Internal$Compiler$makeImport = F2(
	function (aliases, name) {
		if (!name.b) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v1 = A2($author$project$Internal$Compiler$findAlias, name, aliases);
			if (_v1.$ === 1) {
				return $author$project$Internal$Compiler$builtIn(name) ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(
					{
						b9: $elm$core$Maybe$Nothing,
						be: $elm$core$Maybe$Nothing,
						ay: $author$project$Internal$Compiler$nodify(name)
					});
			} else {
				var alias = _v1.a;
				return $elm$core$Maybe$Just(
					{
						b9: $elm$core$Maybe$Nothing,
						be: $elm$core$Maybe$Just(
							$author$project$Internal$Compiler$nodify(
								_List_fromArray(
									[alias]))),
						ay: $author$project$Internal$Compiler$nodify(name)
					});
			}
		}
	});
var $the_sett$elm_pretty_printer$Internals$Concatenate = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Pretty$append = F2(
	function (doc1, doc2) {
		return A2(
			$the_sett$elm_pretty_printer$Internals$Concatenate,
			function (_v0) {
				return doc1;
			},
			function (_v1) {
				return doc2;
			});
	});
var $elm_community$basics_extra$Basics$Extra$flip = F3(
	function (f, b, a) {
		return A2(f, a, b);
	});
var $the_sett$elm_pretty_printer$Pretty$a = $elm_community$basics_extra$Basics$Extra$flip($the_sett$elm_pretty_printer$Pretty$append);
var $the_sett$elm_pretty_printer$Internals$Line = F2(
	function (a, b) {
		return {$: 4, a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Pretty$line = A2($the_sett$elm_pretty_printer$Internals$Line, ' ', '');
var $the_sett$elm_pretty_printer$Internals$Empty = {$: 0};
var $the_sett$elm_pretty_printer$Pretty$empty = $the_sett$elm_pretty_printer$Internals$Empty;
var $the_sett$elm_pretty_printer$Pretty$join = F2(
	function (sep, docs) {
		join:
		while (true) {
			if (!docs.b) {
				return $the_sett$elm_pretty_printer$Pretty$empty;
			} else {
				if (!docs.a.$) {
					var _v1 = docs.a;
					var ds = docs.b;
					var $temp$sep = sep,
						$temp$docs = ds;
					sep = $temp$sep;
					docs = $temp$docs;
					continue join;
				} else {
					var d = docs.a;
					var ds = docs.b;
					var step = F2(
						function (x, rest) {
							if (!x.$) {
								return rest;
							} else {
								var doc = x;
								return A2(
									$the_sett$elm_pretty_printer$Pretty$append,
									sep,
									A2($the_sett$elm_pretty_printer$Pretty$append, doc, rest));
							}
						});
					var spersed = A3($elm$core$List$foldr, step, $the_sett$elm_pretty_printer$Pretty$empty, ds);
					return A2($the_sett$elm_pretty_printer$Pretty$append, d, spersed);
				}
			}
		}
	});
var $the_sett$elm_pretty_printer$Pretty$lines = $the_sett$elm_pretty_printer$Pretty$join($the_sett$elm_pretty_printer$Pretty$line);
var $author$project$Internal$Compiler$denodeMaybe = $elm$core$Maybe$map($author$project$Internal$Compiler$denode);
var $author$project$Internal$Compiler$denodeAll = $elm$core$List$map($author$project$Internal$Compiler$denode);
var $the_sett$elm_pretty_printer$Internals$Text = F2(
	function (a, b) {
		return {$: 3, a: a, b: b};
	});
var $elm$core$String$cons = _String_cons;
var $elm$core$String$fromChar = function (_char) {
	return A2($elm$core$String$cons, _char, '');
};
var $the_sett$elm_pretty_printer$Pretty$char = function (c) {
	return A2(
		$the_sett$elm_pretty_printer$Internals$Text,
		$elm$core$String$fromChar(c),
		$elm$core$Maybe$Nothing);
};
var $the_sett$elm_pretty_printer$Pretty$surround = F3(
	function (left, right, doc) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$append,
			A2($the_sett$elm_pretty_printer$Pretty$append, left, doc),
			right);
	});
var $the_sett$elm_pretty_printer$Pretty$parens = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char('('),
		$the_sett$elm_pretty_printer$Pretty$char(')'),
		doc);
};
var $the_sett$elm_pretty_printer$Pretty$string = function (val) {
	return A2($the_sett$elm_pretty_printer$Internals$Text, val, $elm$core$Maybe$Nothing);
};
var $author$project$Internal$Write$prettyTopLevelExpose = function (tlExpose) {
	switch (tlExpose.$) {
		case 0:
			var val = tlExpose.a;
			return $the_sett$elm_pretty_printer$Pretty$parens(
				$the_sett$elm_pretty_printer$Pretty$string(val));
		case 1:
			var val = tlExpose.a;
			return $the_sett$elm_pretty_printer$Pretty$string(val);
		case 2:
			var val = tlExpose.a;
			return $the_sett$elm_pretty_printer$Pretty$string(val);
		default:
			var exposedType = tlExpose.a;
			var _v1 = exposedType.cV;
			if (_v1.$ === 1) {
				return $the_sett$elm_pretty_printer$Pretty$string(exposedType.I);
			} else {
				return A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$string('(..)'),
					$the_sett$elm_pretty_printer$Pretty$string(exposedType.I));
			}
	}
};
var $author$project$Internal$Write$prettyTopLevelExposes = function (exposes) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$join,
		$the_sett$elm_pretty_printer$Pretty$string(', '),
		A2($elm$core$List$map, $author$project$Internal$Write$prettyTopLevelExpose, exposes));
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$InfixExpose = function (a) {
	return {$: 0, a: a};
};
var $author$project$Internal$ImportsAndExposing$combineTopLevelExposes = function (exposes) {
	if (!exposes.b) {
		return $stil4m$elm_syntax$Elm$Syntax$Exposing$InfixExpose('');
	} else {
		var hd = exposes.a;
		var tl = exposes.b;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (exp, result) {
					var _v1 = _Utils_Tuple2(exp, result);
					if (_v1.a.$ === 3) {
						var typeExpose = _v1.a.a;
						var _v2 = typeExpose.cV;
						if (!_v2.$) {
							return exp;
						} else {
							return result;
						}
					} else {
						if (_v1.b.$ === 3) {
							var typeExpose = _v1.b.a;
							var _v3 = typeExpose.cV;
							if (!_v3.$) {
								return result;
							} else {
								return exp;
							}
						} else {
							return result;
						}
					}
				}),
			hd,
			tl);
	}
};
var $author$project$Internal$ImportsAndExposing$topLevelExposeName = function (tle) {
	switch (tle.$) {
		case 0:
			var val = tle.a;
			return val;
		case 1:
			var val = tle.a;
			return val;
		case 2:
			var val = tle.a;
			return val;
		default:
			var exposedType = tle.a;
			return exposedType.I;
	}
};
var $author$project$Internal$ImportsAndExposing$groupByExposingName = function (innerImports) {
	var _v0 = function () {
		if (!innerImports.b) {
			return _Utils_Tuple3(
				'',
				_List_Nil,
				_List_fromArray(
					[_List_Nil]));
		} else {
			var hd = innerImports.a;
			return A3(
				$elm$core$List$foldl,
				F2(
					function (exp, _v2) {
						var currName = _v2.a;
						var currAccum = _v2.b;
						var accum = _v2.c;
						var nextName = $author$project$Internal$ImportsAndExposing$topLevelExposeName(exp);
						return _Utils_eq(nextName, currName) ? _Utils_Tuple3(
							currName,
							A2($elm$core$List$cons, exp, currAccum),
							accum) : _Utils_Tuple3(
							nextName,
							_List_fromArray(
								[exp]),
							A2($elm$core$List$cons, currAccum, accum));
					}),
				_Utils_Tuple3(
					$author$project$Internal$ImportsAndExposing$topLevelExposeName(hd),
					_List_Nil,
					_List_Nil),
				innerImports);
		}
	}();
	var hdGroup = _v0.b;
	var remGroups = _v0.c;
	return $elm$core$List$reverse(
		A2($elm$core$List$cons, hdGroup, remGroups));
};
var $elm$core$List$sortWith = _List_sortWith;
var $author$project$Internal$ImportsAndExposing$topLevelExposeOrder = F2(
	function (tlel, tler) {
		var _v0 = _Utils_Tuple2(tlel, tler);
		if (!_v0.a.$) {
			if (!_v0.b.$) {
				return A2(
					$elm$core$Basics$compare,
					$author$project$Internal$ImportsAndExposing$topLevelExposeName(tlel),
					$author$project$Internal$ImportsAndExposing$topLevelExposeName(tler));
			} else {
				return 0;
			}
		} else {
			if (!_v0.b.$) {
				return 2;
			} else {
				return A2(
					$elm$core$Basics$compare,
					$author$project$Internal$ImportsAndExposing$topLevelExposeName(tlel),
					$author$project$Internal$ImportsAndExposing$topLevelExposeName(tler));
			}
		}
	});
var $author$project$Internal$ImportsAndExposing$sortAndDedupExposings = function (tlExposings) {
	return A2(
		$elm$core$List$map,
		$author$project$Internal$ImportsAndExposing$combineTopLevelExposes,
		$author$project$Internal$ImportsAndExposing$groupByExposingName(
			A2($elm$core$List$sortWith, $author$project$Internal$ImportsAndExposing$topLevelExposeOrder, tlExposings)));
};
var $the_sett$elm_pretty_printer$Pretty$space = $the_sett$elm_pretty_printer$Pretty$char(' ');
var $author$project$Internal$Write$prettyExposing = function (exposing_) {
	var exposings = function () {
		if (!exposing_.$) {
			return $the_sett$elm_pretty_printer$Pretty$parens(
				$the_sett$elm_pretty_printer$Pretty$string('..'));
		} else {
			var tll = exposing_.a;
			return $the_sett$elm_pretty_printer$Pretty$parens(
				$author$project$Internal$Write$prettyTopLevelExposes(
					$author$project$Internal$ImportsAndExposing$sortAndDedupExposings(
						$author$project$Internal$Compiler$denodeAll(tll))));
		}
	}();
	return A2(
		$the_sett$elm_pretty_printer$Pretty$a,
		exposings,
		A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('exposing')));
};
var $author$project$Internal$Write$prettyMaybe = F2(
	function (prettyFn, maybeVal) {
		return A2(
			$elm$core$Maybe$withDefault,
			$the_sett$elm_pretty_printer$Pretty$empty,
			A2($elm$core$Maybe$map, prettyFn, maybeVal));
	});
var $author$project$Internal$Write$dot = $the_sett$elm_pretty_printer$Pretty$string('.');
var $author$project$Internal$Write$prettyModuleName = function (name) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$join,
		$author$project$Internal$Write$dot,
		A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, name));
};
var $author$project$Internal$Write$prettyModuleNameAlias = function (name) {
	if (!name.b) {
		return $the_sett$elm_pretty_printer$Pretty$empty;
	} else {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			A2(
				$the_sett$elm_pretty_printer$Pretty$join,
				$author$project$Internal$Write$dot,
				A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, name)),
			$the_sett$elm_pretty_printer$Pretty$string('as '));
	}
};
var $author$project$Internal$Write$prettyImport = function (import_) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$join,
		$the_sett$elm_pretty_printer$Pretty$space,
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('import'),
				$author$project$Internal$Write$prettyModuleName(
				$author$project$Internal$Compiler$denode(import_.ay)),
				A2(
				$author$project$Internal$Write$prettyMaybe,
				$author$project$Internal$Write$prettyModuleNameAlias,
				$author$project$Internal$Compiler$denodeMaybe(import_.be)),
				A2(
				$author$project$Internal$Write$prettyMaybe,
				$author$project$Internal$Write$prettyExposing,
				$author$project$Internal$Compiler$denodeMaybe(import_.b9))
			]));
};
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $author$project$Internal$ImportsAndExposing$denode = $stil4m$elm_syntax$Elm$Syntax$Node$value;
var $author$project$Internal$ImportsAndExposing$denodeMaybe = $elm$core$Maybe$map($author$project$Internal$ImportsAndExposing$denode);
var $author$project$Internal$ImportsAndExposing$denodeAll = $elm$core$List$map($author$project$Internal$ImportsAndExposing$denode);
var $author$project$Internal$ImportsAndExposing$nodify = function (exp) {
	return A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, exp);
};
var $author$project$Internal$ImportsAndExposing$nodifyAll = $elm$core$List$map($author$project$Internal$ImportsAndExposing$nodify);
var $author$project$Internal$ImportsAndExposing$joinExposings = F2(
	function (left, right) {
		var _v0 = _Utils_Tuple2(left, right);
		if (!_v0.a.$) {
			var range = _v0.a.a;
			return $stil4m$elm_syntax$Elm$Syntax$Exposing$All(range);
		} else {
			if (!_v0.b.$) {
				var range = _v0.b.a;
				return $stil4m$elm_syntax$Elm$Syntax$Exposing$All(range);
			} else {
				var leftNodes = _v0.a.a;
				var rightNodes = _v0.b.a;
				return $stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					$author$project$Internal$ImportsAndExposing$nodifyAll(
						A2(
							$elm$core$List$append,
							$author$project$Internal$ImportsAndExposing$denodeAll(leftNodes),
							$author$project$Internal$ImportsAndExposing$denodeAll(rightNodes))));
			}
		}
	});
var $author$project$Internal$ImportsAndExposing$joinMaybeExposings = F2(
	function (maybeLeft, maybeRight) {
		var _v0 = _Utils_Tuple2(maybeLeft, maybeRight);
		if (_v0.a.$ === 1) {
			if (_v0.b.$ === 1) {
				var _v1 = _v0.a;
				var _v2 = _v0.b;
				return $elm$core$Maybe$Nothing;
			} else {
				var _v4 = _v0.a;
				var right = _v0.b.a;
				return $elm$core$Maybe$Just(right);
			}
		} else {
			if (_v0.b.$ === 1) {
				var left = _v0.a.a;
				var _v3 = _v0.b;
				return $elm$core$Maybe$Just(left);
			} else {
				var left = _v0.a.a;
				var right = _v0.b.a;
				return $elm$core$Maybe$Just(
					A2($author$project$Internal$ImportsAndExposing$joinExposings, left, right));
			}
		}
	});
var $author$project$Internal$ImportsAndExposing$nodifyMaybe = $elm$core$Maybe$map($author$project$Internal$ImportsAndExposing$nodify);
var $elm_community$maybe_extra$Maybe$Extra$or = F2(
	function (ma, mb) {
		if (ma.$ === 1) {
			return mb;
		} else {
			return ma;
		}
	});
var $author$project$Internal$ImportsAndExposing$sortAndDedupExposing = function (exp) {
	if (!exp.$) {
		var range = exp.a;
		return $stil4m$elm_syntax$Elm$Syntax$Exposing$All(range);
	} else {
		var nodes = exp.a;
		return $stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
			$author$project$Internal$ImportsAndExposing$nodifyAll(
				$author$project$Internal$ImportsAndExposing$sortAndDedupExposings(
					$author$project$Internal$ImportsAndExposing$denodeAll(nodes))));
	}
};
var $author$project$Internal$ImportsAndExposing$combineImports = function (innerImports) {
	if (!innerImports.b) {
		return {
			b9: $elm$core$Maybe$Nothing,
			be: $elm$core$Maybe$Nothing,
			ay: $author$project$Internal$ImportsAndExposing$nodify(_List_Nil)
		};
	} else {
		var hd = innerImports.a;
		var tl = innerImports.b;
		var combinedImports = A3(
			$elm$core$List$foldl,
			F2(
				function (imp, result) {
					return {
						b9: $author$project$Internal$ImportsAndExposing$nodifyMaybe(
							A2(
								$author$project$Internal$ImportsAndExposing$joinMaybeExposings,
								$author$project$Internal$ImportsAndExposing$denodeMaybe(imp.b9),
								$author$project$Internal$ImportsAndExposing$denodeMaybe(result.b9))),
						be: A2($elm_community$maybe_extra$Maybe$Extra$or, imp.be, result.be),
						ay: imp.ay
					};
				}),
			hd,
			tl);
		return _Utils_update(
			combinedImports,
			{
				b9: A2(
					$elm$core$Maybe$map,
					A2(
						$elm$core$Basics$composeR,
						$author$project$Internal$ImportsAndExposing$denode,
						A2($elm$core$Basics$composeR, $author$project$Internal$ImportsAndExposing$sortAndDedupExposing, $author$project$Internal$ImportsAndExposing$nodify)),
					combinedImports.b9)
			});
	}
};
var $author$project$Internal$ImportsAndExposing$groupByModuleName = function (innerImports) {
	var _v0 = function () {
		if (!innerImports.b) {
			return _Utils_Tuple3(
				_List_Nil,
				_List_Nil,
				_List_fromArray(
					[_List_Nil]));
		} else {
			var hd = innerImports.a;
			return A3(
				$elm$core$List$foldl,
				F2(
					function (imp, _v2) {
						var currName = _v2.a;
						var currAccum = _v2.b;
						var accum = _v2.c;
						var nextName = $author$project$Internal$ImportsAndExposing$denode(imp.ay);
						return _Utils_eq(nextName, currName) ? _Utils_Tuple3(
							currName,
							A2($elm$core$List$cons, imp, currAccum),
							accum) : _Utils_Tuple3(
							nextName,
							_List_fromArray(
								[imp]),
							A2($elm$core$List$cons, currAccum, accum));
					}),
				_Utils_Tuple3(
					$author$project$Internal$ImportsAndExposing$denode(hd.ay),
					_List_Nil,
					_List_Nil),
				innerImports);
		}
	}();
	var hdGroup = _v0.b;
	var remGroups = _v0.c;
	return $elm$core$List$reverse(
		A2($elm$core$List$cons, hdGroup, remGroups));
};
var $author$project$Internal$ImportsAndExposing$sortAndDedupImports = function (imports) {
	var impName = function (imp) {
		return $author$project$Internal$ImportsAndExposing$denode(imp.ay);
	};
	return A2(
		$elm$core$List$map,
		$author$project$Internal$ImportsAndExposing$combineImports,
		$author$project$Internal$ImportsAndExposing$groupByModuleName(
			A2($elm$core$List$sortBy, impName, imports)));
};
var $author$project$Internal$Write$prettyImports = function (imports) {
	return $the_sett$elm_pretty_printer$Pretty$lines(
		A2(
			$elm$core$List$map,
			$author$project$Internal$Write$prettyImport,
			$author$project$Internal$ImportsAndExposing$sortAndDedupImports(imports)));
};
var $author$project$Internal$Write$importsPretty = function (imports) {
	if (!imports.b) {
		return $the_sett$elm_pretty_printer$Pretty$line;
	} else {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$line,
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$author$project$Internal$Write$prettyImports(imports))));
	}
};
var $author$project$Internal$Write$prettyComments = function (comments) {
	if (!comments.b) {
		return $the_sett$elm_pretty_printer$Pretty$empty;
	} else {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$line,
				$the_sett$elm_pretty_printer$Pretty$lines(
					A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, comments))));
	}
};
var $the_sett$elm_pretty_printer$Internals$Nest = F2(
	function (a, b) {
		return {$: 2, a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Pretty$nest = F2(
	function (depth, doc) {
		return A2(
			$the_sett$elm_pretty_printer$Internals$Nest,
			depth,
			function (_v0) {
				return doc;
			});
	});
var $author$project$Internal$Write$prettyDocumentation = function (docs) {
	return $the_sett$elm_pretty_printer$Pretty$string(docs);
};
var $the_sett$elm_pretty_printer$Internals$Union = F2(
	function (a, b) {
		return {$: 5, a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Internals$flatten = function (doc) {
	flatten:
	while (true) {
		switch (doc.$) {
			case 1:
				var doc1 = doc.a;
				var doc2 = doc.b;
				return A2(
					$the_sett$elm_pretty_printer$Internals$Concatenate,
					function (_v1) {
						return $the_sett$elm_pretty_printer$Internals$flatten(
							doc1(0));
					},
					function (_v2) {
						return $the_sett$elm_pretty_printer$Internals$flatten(
							doc2(0));
					});
			case 2:
				var i = doc.a;
				var doc1 = doc.b;
				return A2(
					$the_sett$elm_pretty_printer$Internals$Nest,
					i,
					function (_v3) {
						return $the_sett$elm_pretty_printer$Internals$flatten(
							doc1(0));
					});
			case 5:
				var doc1 = doc.a;
				var doc2 = doc.b;
				var $temp$doc = doc1;
				doc = $temp$doc;
				continue flatten;
			case 4:
				var hsep = doc.a;
				return A2($the_sett$elm_pretty_printer$Internals$Text, hsep, $elm$core$Maybe$Nothing);
			case 6:
				var fn = doc.a;
				var $temp$doc = fn(0);
				doc = $temp$doc;
				continue flatten;
			case 7:
				var fn = doc.a;
				var $temp$doc = fn(0);
				doc = $temp$doc;
				continue flatten;
			default:
				var x = doc;
				return x;
		}
	}
};
var $the_sett$elm_pretty_printer$Pretty$group = function (doc) {
	return A2(
		$the_sett$elm_pretty_printer$Internals$Union,
		$the_sett$elm_pretty_printer$Internals$flatten(doc),
		doc);
};
var $author$project$Internal$Write$isNakedCompound = function (typeAnn) {
	switch (typeAnn.$) {
		case 1:
			if (!typeAnn.b.b) {
				return false;
			} else {
				var args = typeAnn.b;
				return true;
			}
		case 6:
			return true;
		default:
			return false;
	}
};
var $elm$core$Tuple$mapBoth = F3(
	function (funcA, funcB, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			funcA(x),
			funcB(y));
	});
var $author$project$Internal$Write$prettyModuleNameDot = F2(
	function (aliases, name) {
		if (!name.b) {
			return $the_sett$elm_pretty_printer$Pretty$empty;
		} else {
			var _v1 = A2($author$project$Internal$Compiler$findAlias, name, aliases);
			if (_v1.$ === 1) {
				return A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$author$project$Internal$Write$dot,
					A2(
						$the_sett$elm_pretty_printer$Pretty$join,
						$author$project$Internal$Write$dot,
						A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, name)));
			} else {
				var alias = _v1.a;
				return A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$author$project$Internal$Write$dot,
					$the_sett$elm_pretty_printer$Pretty$string(alias));
			}
		}
	});
var $the_sett$elm_pretty_printer$Pretty$separators = function (sep) {
	return $the_sett$elm_pretty_printer$Pretty$join(
		A2($the_sett$elm_pretty_printer$Internals$Line, sep, sep));
};
var $the_sett$elm_pretty_printer$Pretty$words = $the_sett$elm_pretty_printer$Pretty$join($the_sett$elm_pretty_printer$Pretty$space);
var $author$project$Internal$Write$prettyFieldTypeAnn = F2(
	function (aliases, _v8) {
		var name = _v8.a;
		var ann = _v8.b;
		return $the_sett$elm_pretty_printer$Pretty$group(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string(name),
									$the_sett$elm_pretty_printer$Pretty$string(':')
								])),
							A2($author$project$Internal$Write$prettyTypeAnnotation, aliases, ann)
						]))));
	});
var $author$project$Internal$Write$prettyFunctionTypeAnnotation = F3(
	function (aliases, left, right) {
		var expandLeft = function (ann) {
			if (ann.$ === 6) {
				return A2($author$project$Internal$Write$prettyTypeAnnotationParens, aliases, ann);
			} else {
				return A2($author$project$Internal$Write$prettyTypeAnnotation, aliases, ann);
			}
		};
		var innerFnTypeAnn = F2(
			function (innerLeft, innerRight) {
				var rightSide = expandRight(
					$author$project$Internal$Compiler$denode(innerRight));
				if (rightSide.b) {
					var hd = rightSide.a;
					var tl = rightSide.b;
					return A2(
						$elm$core$List$cons,
						expandLeft(
							$author$project$Internal$Compiler$denode(innerLeft)),
						A2(
							$elm$core$List$cons,
							$the_sett$elm_pretty_printer$Pretty$words(
								_List_fromArray(
									[
										$the_sett$elm_pretty_printer$Pretty$string('->'),
										hd
									])),
							tl));
				} else {
					return _List_Nil;
				}
			});
		var expandRight = function (ann) {
			if (ann.$ === 6) {
				var innerLeft = ann.a;
				var innerRight = ann.b;
				return A2(innerFnTypeAnn, innerLeft, innerRight);
			} else {
				return _List_fromArray(
					[
						A2($author$project$Internal$Write$prettyTypeAnnotation, aliases, ann)
					]);
			}
		};
		return $the_sett$elm_pretty_printer$Pretty$group(
			$the_sett$elm_pretty_printer$Pretty$lines(
				A2(innerFnTypeAnn, left, right)));
	});
var $author$project$Internal$Write$prettyGenericRecord = F3(
	function (aliases, paramName, fields) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			$the_sett$elm_pretty_printer$Pretty$words(
				_List_fromArray(
					[
						$the_sett$elm_pretty_printer$Pretty$string('{'),
						$the_sett$elm_pretty_printer$Pretty$string(paramName)
					])));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		var addBarToFirst = function (exprs) {
			if (!exprs.b) {
				return _List_Nil;
			} else {
				var hd = exprs.a;
				var tl = exprs.b;
				return A2(
					$elm$core$List$cons,
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						hd,
						$the_sett$elm_pretty_printer$Pretty$string('| ')),
					tl);
			}
		};
		if (!fields.b) {
			return $the_sett$elm_pretty_printer$Pretty$string('{}');
		} else {
			return $the_sett$elm_pretty_printer$Pretty$group(
				A3(
					$the_sett$elm_pretty_printer$Pretty$surround,
					$the_sett$elm_pretty_printer$Pretty$empty,
					close,
					A2(
						$the_sett$elm_pretty_printer$Pretty$nest,
						4,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							A2(
								$the_sett$elm_pretty_printer$Pretty$separators,
								', ',
								addBarToFirst(
									A2(
										$elm$core$List$map,
										$author$project$Internal$Write$prettyFieldTypeAnn(aliases),
										A2(
											$elm$core$List$map,
											A2($elm$core$Tuple$mapBoth, $author$project$Internal$Compiler$denode, $author$project$Internal$Compiler$denode),
											fields)))),
							open))));
		}
	});
var $author$project$Internal$Write$prettyRecord = F2(
	function (aliases, fields) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('{'));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!fields.b) {
			return $the_sett$elm_pretty_printer$Pretty$string('{}');
		} else {
			return $the_sett$elm_pretty_printer$Pretty$group(
				A3(
					$the_sett$elm_pretty_printer$Pretty$surround,
					open,
					close,
					A2(
						$the_sett$elm_pretty_printer$Pretty$separators,
						', ',
						A2(
							$elm$core$List$map,
							$author$project$Internal$Write$prettyFieldTypeAnn(aliases),
							A2(
								$elm$core$List$map,
								A2($elm$core$Tuple$mapBoth, $author$project$Internal$Compiler$denode, $author$project$Internal$Compiler$denode),
								fields)))));
		}
	});
var $author$project$Internal$Write$prettyTupled = F2(
	function (aliases, anns) {
		return $the_sett$elm_pretty_printer$Pretty$parens(
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$space,
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					A2(
						$the_sett$elm_pretty_printer$Pretty$join,
						$the_sett$elm_pretty_printer$Pretty$string(', '),
						A2(
							$elm$core$List$map,
							$author$project$Internal$Write$prettyTypeAnnotation(aliases),
							$author$project$Internal$Compiler$denodeAll(anns))),
					$the_sett$elm_pretty_printer$Pretty$space)));
	});
var $author$project$Internal$Write$prettyTypeAnnotation = F2(
	function (aliases, typeAnn) {
		switch (typeAnn.$) {
			case 0:
				var val = typeAnn.a;
				return $the_sett$elm_pretty_printer$Pretty$string(val);
			case 1:
				var fqName = typeAnn.a;
				var anns = typeAnn.b;
				return A3($author$project$Internal$Write$prettyTyped, aliases, fqName, anns);
			case 2:
				return $the_sett$elm_pretty_printer$Pretty$string('()');
			case 3:
				var anns = typeAnn.a;
				return A2($author$project$Internal$Write$prettyTupled, aliases, anns);
			case 4:
				var recordDef = typeAnn.a;
				return A2(
					$author$project$Internal$Write$prettyRecord,
					aliases,
					$author$project$Internal$Compiler$denodeAll(recordDef));
			case 5:
				var paramName = typeAnn.a;
				var recordDef = typeAnn.b;
				return A3(
					$author$project$Internal$Write$prettyGenericRecord,
					aliases,
					$author$project$Internal$Compiler$denode(paramName),
					$author$project$Internal$Compiler$denodeAll(
						$author$project$Internal$Compiler$denode(recordDef)));
			default:
				var fromAnn = typeAnn.a;
				var toAnn = typeAnn.b;
				return A3($author$project$Internal$Write$prettyFunctionTypeAnnotation, aliases, fromAnn, toAnn);
		}
	});
var $author$project$Internal$Write$prettyTypeAnnotationParens = F2(
	function (aliases, typeAnn) {
		return $author$project$Internal$Write$isNakedCompound(typeAnn) ? $the_sett$elm_pretty_printer$Pretty$parens(
			A2($author$project$Internal$Write$prettyTypeAnnotation, aliases, typeAnn)) : A2($author$project$Internal$Write$prettyTypeAnnotation, aliases, typeAnn);
	});
var $author$project$Internal$Write$prettyTyped = F3(
	function (aliases, fqName, anns) {
		var argsDoc = $the_sett$elm_pretty_printer$Pretty$words(
			A2(
				$elm$core$List$map,
				$author$project$Internal$Write$prettyTypeAnnotationParens(aliases),
				$author$project$Internal$Compiler$denodeAll(anns)));
		var _v0 = $author$project$Internal$Compiler$denode(fqName);
		var moduleName = _v0.a;
		var typeName = _v0.b;
		var typeDoc = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(typeName),
			A2($author$project$Internal$Write$prettyModuleNameDot, aliases, moduleName));
		return $the_sett$elm_pretty_printer$Pretty$words(
			_List_fromArray(
				[typeDoc, argsDoc]));
	});
var $author$project$Internal$Write$prettyValueConstructor = F2(
	function (aliases, cons) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			$the_sett$elm_pretty_printer$Pretty$group(
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$string(
							$author$project$Internal$Compiler$denode(cons.I)),
							$the_sett$elm_pretty_printer$Pretty$lines(
							A2(
								$elm$core$List$map,
								$author$project$Internal$Write$prettyTypeAnnotationParens(aliases),
								$author$project$Internal$Compiler$denodeAll(cons.bG)))
						]))));
	});
var $author$project$Internal$Write$prettyValueConstructors = F2(
	function (aliases, constructors) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$join,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$string('| '),
				$the_sett$elm_pretty_printer$Pretty$line),
			A2(
				$elm$core$List$map,
				$author$project$Internal$Write$prettyValueConstructor(aliases),
				constructors));
	});
var $author$project$Internal$Write$prettyCustomType = F2(
	function (aliases, type_) {
		var customTypePretty = A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$author$project$Internal$Write$prettyValueConstructors,
					aliases,
					$author$project$Internal$Compiler$denodeAll(type_.bU)),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$string('= '),
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$line,
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('type'),
									$the_sett$elm_pretty_printer$Pretty$string(
									$author$project$Internal$Compiler$denode(type_.I)),
									$the_sett$elm_pretty_printer$Pretty$words(
									A2(
										$elm$core$List$map,
										$the_sett$elm_pretty_printer$Pretty$string,
										$author$project$Internal$Compiler$denodeAll(type_.a9)))
								]))))));
		return $the_sett$elm_pretty_printer$Pretty$lines(
			_List_fromArray(
				[
					A2(
					$author$project$Internal$Write$prettyMaybe,
					$author$project$Internal$Write$prettyDocumentation,
					$author$project$Internal$Compiler$denodeMaybe(type_.aw)),
					customTypePretty
				]));
	});
var $author$project$Internal$Write$adjustExpressionParentheses = F2(
	function (context, expression) {
		var shouldRemove = function (expr) {
			var _v3 = _Utils_Tuple3(context.V, context.U, expr);
			_v3$1:
			while (true) {
				if (_v3.a) {
					return true;
				} else {
					switch (_v3.c.$) {
						case 1:
							if (_v3.b) {
								break _v3$1;
							} else {
								return (context.Y < 11) ? true : false;
							}
						case 3:
							if (_v3.b) {
								break _v3$1;
							} else {
								var _v4 = _v3.c;
								return true;
							}
						case 7:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 8:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 9:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 10:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 11:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 12:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 13:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 18:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 19:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 20:
							if (_v3.b) {
								break _v3$1;
							} else {
								var _v5 = _v3.c;
								return true;
							}
						case 21:
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 22:
							if (_v3.b) {
								break _v3$1;
							} else {
								var _v6 = _v3.c;
								return true;
							}
						default:
							if (_v3.b) {
								break _v3$1;
							} else {
								return false;
							}
					}
				}
			}
			return true;
		};
		var removeParens = function (expr) {
			if (expr.$ === 14) {
				var innerExpr = expr.a;
				return shouldRemove(
					$author$project$Internal$Compiler$denode(innerExpr)) ? removeParens(
					$author$project$Internal$Compiler$denode(innerExpr)) : expr;
			} else {
				return expr;
			}
		};
		var addParens = function (expr) {
			var _v1 = _Utils_Tuple3(context.V, context.U, expr);
			_v1$4:
			while (true) {
				if ((!_v1.a) && (!_v1.b)) {
					switch (_v1.c.$) {
						case 15:
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$author$project$Internal$Compiler$nodify(expr));
						case 16:
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$author$project$Internal$Compiler$nodify(expr));
						case 17:
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$author$project$Internal$Compiler$nodify(expr));
						case 4:
							var _v2 = _v1.c;
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$author$project$Internal$Compiler$nodify(expr));
						default:
							break _v1$4;
					}
				} else {
					break _v1$4;
				}
			}
			return expr;
		};
		return addParens(
			removeParens(expression));
	});
var $the_sett$elm_pretty_printer$Internals$Column = function (a) {
	return {$: 7, a: a};
};
var $the_sett$elm_pretty_printer$Pretty$column = $the_sett$elm_pretty_printer$Internals$Column;
var $the_sett$elm_pretty_printer$Internals$Nesting = function (a) {
	return {$: 6, a: a};
};
var $the_sett$elm_pretty_printer$Pretty$nesting = $the_sett$elm_pretty_printer$Internals$Nesting;
var $the_sett$elm_pretty_printer$Pretty$align = function (doc) {
	return $the_sett$elm_pretty_printer$Pretty$column(
		function (currentColumn) {
			return $the_sett$elm_pretty_printer$Pretty$nesting(
				function (indentLvl) {
					return A2($the_sett$elm_pretty_printer$Pretty$nest, currentColumn - indentLvl, doc);
				});
		});
};
var $Chadtech$elm_bool_extra$Bool$Extra$any = $elm$core$List$any($elm$core$Basics$identity);
var $elm$core$Basics$modBy = _Basics_modBy;
var $author$project$Internal$Write$decrementIndent = F2(
	function (currentIndent, spaces) {
		var modded = A2($elm$core$Basics$modBy, 4, currentIndent - spaces);
		return (!modded) ? 4 : modded;
	});
var $author$project$Internal$Write$doubleLines = $the_sett$elm_pretty_printer$Pretty$join(
	A2($the_sett$elm_pretty_printer$Pretty$a, $the_sett$elm_pretty_printer$Pretty$line, $the_sett$elm_pretty_printer$Pretty$line));
var $author$project$Internal$Write$escapeChar = function (val) {
	switch (val) {
		case '\\':
			return '\\\\';
		case '\'':
			return '\\\'';
		case '\t':
			return '\\t';
		case '\n':
			return '\\n';
		default:
			var c = val;
			return $elm$core$String$fromChar(c);
	}
};
var $elm$core$String$fromFloat = _String_fromNumber;
var $the_sett$elm_pretty_printer$Internals$copy = F2(
	function (i, s) {
		return (!i) ? '' : _Utils_ap(
			s,
			A2($the_sett$elm_pretty_printer$Internals$copy, i - 1, s));
	});
var $the_sett$elm_pretty_printer$Pretty$hang = F2(
	function (spaces, doc) {
		return $the_sett$elm_pretty_printer$Pretty$align(
			A2($the_sett$elm_pretty_printer$Pretty$nest, spaces, doc));
	});
var $the_sett$elm_pretty_printer$Pretty$indent = F2(
	function (spaces, doc) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$hang,
			spaces,
			A2(
				$the_sett$elm_pretty_printer$Pretty$append,
				$the_sett$elm_pretty_printer$Pretty$string(
					A2($the_sett$elm_pretty_printer$Internals$copy, spaces, ' ')),
				doc));
	});
var $elm$core$Tuple$mapSecond = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			x,
			func(y));
	});
var $author$project$Internal$Write$optionalGroup = F2(
	function (flag, doc) {
		return flag ? doc : $the_sett$elm_pretty_printer$Pretty$group(doc);
	});
var $author$project$Internal$Write$precedence = function (symbol) {
	switch (symbol) {
		case '>>':
			return 9;
		case '<<':
			return 9;
		case '^':
			return 8;
		case '*':
			return 7;
		case '/':
			return 7;
		case '//':
			return 7;
		case '%':
			return 7;
		case 'rem':
			return 7;
		case '+':
			return 6;
		case '-':
			return 6;
		case '++':
			return 5;
		case '::':
			return 5;
		case '==':
			return 4;
		case '/=':
			return 4;
		case '<':
			return 4;
		case '>':
			return 4;
		case '<=':
			return 4;
		case '>=':
			return 4;
		case '&&':
			return 3;
		case '||':
			return 2;
		case '|>':
			return 0;
		case '<|':
			return 0;
		default:
			return 0;
	}
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$ParenthesizedPattern = function (a) {
	return {$: 14, a: a};
};
var $author$project$Internal$Write$adjustPatternParentheses = F2(
	function (isTop, pattern) {
		var shouldRemove = function (pat) {
			var _v5 = _Utils_Tuple2(isTop, pat);
			_v5$2:
			while (true) {
				switch (_v5.b.$) {
					case 12:
						if (!_v5.a) {
							var _v6 = _v5.b;
							return false;
						} else {
							break _v5$2;
						}
					case 13:
						var _v7 = _v5.b;
						return false;
					default:
						break _v5$2;
				}
			}
			return isTop;
		};
		var removeParens = function (pat) {
			if (pat.$ === 14) {
				var innerPat = pat.a;
				return shouldRemove(
					$author$project$Internal$Compiler$denode(innerPat)) ? removeParens(
					$author$project$Internal$Compiler$denode(innerPat)) : pat;
			} else {
				return pat;
			}
		};
		var addParens = function (pat) {
			var _v1 = _Utils_Tuple2(isTop, pat);
			_v1$2:
			while (true) {
				if (!_v1.a) {
					switch (_v1.b.$) {
						case 12:
							if (_v1.b.b.b) {
								var _v2 = _v1.b;
								var _v3 = _v2.b;
								return $stil4m$elm_syntax$Elm$Syntax$Pattern$ParenthesizedPattern(
									$author$project$Internal$Compiler$nodify(pat));
							} else {
								break _v1$2;
							}
						case 13:
							var _v4 = _v1.b;
							return $stil4m$elm_syntax$Elm$Syntax$Pattern$ParenthesizedPattern(
								$author$project$Internal$Compiler$nodify(pat));
						default:
							break _v1$2;
					}
				} else {
					break _v1$2;
				}
			}
			return pat;
		};
		return addParens(
			removeParens(pattern));
	});
var $the_sett$elm_pretty_printer$Pretty$braces = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char('{'),
		$the_sett$elm_pretty_printer$Pretty$char('}'),
		doc);
};
var $author$project$Internal$Write$quotes = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char('\"'),
		$the_sett$elm_pretty_printer$Pretty$char('\"'),
		doc);
};
var $author$project$Internal$Write$singleQuotes = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char('\''),
		$the_sett$elm_pretty_printer$Pretty$char('\''),
		doc);
};
var $elm$core$String$fromList = _String_fromList;
var $rtfeldman$elm_hex$Hex$unsafeToDigit = function (num) {
	unsafeToDigit:
	while (true) {
		switch (num) {
			case 0:
				return '0';
			case 1:
				return '1';
			case 2:
				return '2';
			case 3:
				return '3';
			case 4:
				return '4';
			case 5:
				return '5';
			case 6:
				return '6';
			case 7:
				return '7';
			case 8:
				return '8';
			case 9:
				return '9';
			case 10:
				return 'a';
			case 11:
				return 'b';
			case 12:
				return 'c';
			case 13:
				return 'd';
			case 14:
				return 'e';
			case 15:
				return 'f';
			default:
				var $temp$num = num;
				num = $temp$num;
				continue unsafeToDigit;
		}
	}
};
var $rtfeldman$elm_hex$Hex$unsafePositiveToDigits = F2(
	function (digits, num) {
		unsafePositiveToDigits:
		while (true) {
			if (num < 16) {
				return A2(
					$elm$core$List$cons,
					$rtfeldman$elm_hex$Hex$unsafeToDigit(num),
					digits);
			} else {
				var $temp$digits = A2(
					$elm$core$List$cons,
					$rtfeldman$elm_hex$Hex$unsafeToDigit(
						A2($elm$core$Basics$modBy, 16, num)),
					digits),
					$temp$num = (num / 16) | 0;
				digits = $temp$digits;
				num = $temp$num;
				continue unsafePositiveToDigits;
			}
		}
	});
var $rtfeldman$elm_hex$Hex$toString = function (num) {
	return $elm$core$String$fromList(
		(num < 0) ? A2(
			$elm$core$List$cons,
			'-',
			A2($rtfeldman$elm_hex$Hex$unsafePositiveToDigits, _List_Nil, -num)) : A2($rtfeldman$elm_hex$Hex$unsafePositiveToDigits, _List_Nil, num));
};
var $author$project$Internal$Write$prettyPatternInner = F3(
	function (aliases, isTop, pattern) {
		var _v0 = A2($author$project$Internal$Write$adjustPatternParentheses, isTop, pattern);
		switch (_v0.$) {
			case 0:
				return $the_sett$elm_pretty_printer$Pretty$string('_');
			case 1:
				return $the_sett$elm_pretty_printer$Pretty$string('()');
			case 2:
				var val = _v0.a;
				return $author$project$Internal$Write$singleQuotes(
					$the_sett$elm_pretty_printer$Pretty$string(
						$author$project$Internal$Write$escapeChar(val)));
			case 3:
				var val = _v0.a;
				return $author$project$Internal$Write$quotes(
					$the_sett$elm_pretty_printer$Pretty$string(val));
			case 4:
				var val = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(
					$elm$core$String$fromInt(val));
			case 5:
				var val = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(
					$rtfeldman$elm_hex$Hex$toString(val));
			case 6:
				var val = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(
					$elm$core$String$fromFloat(val));
			case 7:
				var vals = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$parens(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$space,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							A2(
								$the_sett$elm_pretty_printer$Pretty$join,
								$the_sett$elm_pretty_printer$Pretty$string(', '),
								A2(
									$elm$core$List$map,
									A2($author$project$Internal$Write$prettyPatternInner, aliases, true),
									$author$project$Internal$Compiler$denodeAll(vals))),
							$the_sett$elm_pretty_printer$Pretty$space)));
			case 8:
				var fields = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$braces(
					A3(
						$the_sett$elm_pretty_printer$Pretty$surround,
						$the_sett$elm_pretty_printer$Pretty$space,
						$the_sett$elm_pretty_printer$Pretty$space,
						A2(
							$the_sett$elm_pretty_printer$Pretty$join,
							$the_sett$elm_pretty_printer$Pretty$string(', '),
							A2(
								$elm$core$List$map,
								$the_sett$elm_pretty_printer$Pretty$string,
								$author$project$Internal$Compiler$denodeAll(fields)))));
			case 9:
				var hdPat = _v0.a;
				var tlPat = _v0.b;
				return $the_sett$elm_pretty_printer$Pretty$words(
					_List_fromArray(
						[
							A3(
							$author$project$Internal$Write$prettyPatternInner,
							aliases,
							false,
							$author$project$Internal$Compiler$denode(hdPat)),
							$the_sett$elm_pretty_printer$Pretty$string('::'),
							A3(
							$author$project$Internal$Write$prettyPatternInner,
							aliases,
							false,
							$author$project$Internal$Compiler$denode(tlPat))
						]));
			case 10:
				var listPats = _v0.a;
				if (!listPats.b) {
					return $the_sett$elm_pretty_printer$Pretty$string('[]');
				} else {
					var open = A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$space,
						$the_sett$elm_pretty_printer$Pretty$string('['));
					var close = A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$string(']'),
						$the_sett$elm_pretty_printer$Pretty$space);
					return A3(
						$the_sett$elm_pretty_printer$Pretty$surround,
						open,
						close,
						A2(
							$the_sett$elm_pretty_printer$Pretty$join,
							$the_sett$elm_pretty_printer$Pretty$string(', '),
							A2(
								$elm$core$List$map,
								A2($author$project$Internal$Write$prettyPatternInner, aliases, false),
								$author$project$Internal$Compiler$denodeAll(listPats))));
				}
			case 11:
				var _var = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(_var);
			case 12:
				var qnRef = _v0.a;
				var listPats = _v0.b;
				return $the_sett$elm_pretty_printer$Pretty$words(
					A2(
						$elm$core$List$cons,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$string(qnRef.I),
							A2($author$project$Internal$Write$prettyModuleNameDot, aliases, qnRef.ay)),
						A2(
							$elm$core$List$map,
							A2($author$project$Internal$Write$prettyPatternInner, aliases, false),
							$author$project$Internal$Compiler$denodeAll(listPats))));
			case 13:
				var pat = _v0.a;
				var name = _v0.b;
				return $the_sett$elm_pretty_printer$Pretty$words(
					_List_fromArray(
						[
							A3(
							$author$project$Internal$Write$prettyPatternInner,
							aliases,
							false,
							$author$project$Internal$Compiler$denode(pat)),
							$the_sett$elm_pretty_printer$Pretty$string('as'),
							$the_sett$elm_pretty_printer$Pretty$string(
							$author$project$Internal$Compiler$denode(name))
						]));
			default:
				var pat = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$parens(
					A3(
						$author$project$Internal$Write$prettyPatternInner,
						aliases,
						true,
						$author$project$Internal$Compiler$denode(pat)));
		}
	});
var $author$project$Internal$Write$prettyArgs = F2(
	function (aliases, args) {
		return $the_sett$elm_pretty_printer$Pretty$words(
			A2(
				$elm$core$List$map,
				A2($author$project$Internal$Write$prettyPatternInner, aliases, false),
				args));
	});
var $elm$core$String$replace = F3(
	function (before, after, string) {
		return A2(
			$elm$core$String$join,
			after,
			A2($elm$core$String$split, before, string));
	});
var $author$project$Internal$Write$escape = function (val) {
	return A3(
		$elm$core$String$replace,
		'\t',
		'\\t',
		A3(
			$elm$core$String$replace,
			'\n',
			'\\n',
			A3(
				$elm$core$String$replace,
				'\"',
				'\\\"',
				A3($elm$core$String$replace, '\\', '\\\\', val))));
};
var $author$project$Internal$Write$prettyLiteral = function (val) {
	return $author$project$Internal$Write$quotes(
		$the_sett$elm_pretty_printer$Pretty$string(
			$author$project$Internal$Write$escape(val)));
};
var $author$project$Internal$Write$prettyPattern = F2(
	function (aliases, pattern) {
		return A3($author$project$Internal$Write$prettyPatternInner, aliases, true, pattern);
	});
var $author$project$Internal$Write$prettySignature = F2(
	function (aliases, sig) {
		return $the_sett$elm_pretty_printer$Pretty$group(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string(
									$author$project$Internal$Compiler$denode(sig.I)),
									$the_sett$elm_pretty_printer$Pretty$string(':')
								])),
							A2(
							$author$project$Internal$Write$prettyTypeAnnotation,
							aliases,
							$author$project$Internal$Compiler$denode(sig.aV))
						]))));
	});
var $the_sett$elm_pretty_printer$Pretty$tightline = A2($the_sett$elm_pretty_printer$Internals$Line, '', '');
var $elm$core$Bitwise$and = _Bitwise_and;
var $elm$core$Bitwise$shiftRightBy = _Bitwise_shiftRightBy;
var $elm$core$String$repeatHelp = F3(
	function (n, chunk, result) {
		return (n <= 0) ? result : A3(
			$elm$core$String$repeatHelp,
			n >> 1,
			_Utils_ap(chunk, chunk),
			(!(n & 1)) ? result : _Utils_ap(result, chunk));
	});
var $elm$core$String$repeat = F2(
	function (n, chunk) {
		return A3($elm$core$String$repeatHelp, n, chunk, '');
	});
var $elm$core$String$padLeft = F3(
	function (n, _char, string) {
		return _Utils_ap(
			A2(
				$elm$core$String$repeat,
				n - $elm$core$String$length(string),
				$elm$core$String$fromChar(_char)),
			string);
	});
var $author$project$Internal$Write$toHexString = function (val) {
	var padWithZeros = function (str) {
		var length = $elm$core$String$length(str);
		return (length < 2) ? A3($elm$core$String$padLeft, 2, '0', str) : (((length > 2) && (length < 4)) ? A3($elm$core$String$padLeft, 4, '0', str) : (((length > 4) && (length < 8)) ? A3($elm$core$String$padLeft, 8, '0', str) : str));
	};
	return '0x' + padWithZeros(
		$elm$core$String$toUpper(
			$rtfeldman$elm_hex$Hex$toString(val)));
};
var $author$project$Internal$Write$topContext = {U: false, V: true, Y: 11};
var $elm$core$List$unzip = function (pairs) {
	var step = F2(
		function (_v0, _v1) {
			var x = _v0.a;
			var y = _v0.b;
			var xs = _v1.a;
			var ys = _v1.b;
			return _Utils_Tuple2(
				A2($elm$core$List$cons, x, xs),
				A2($elm$core$List$cons, y, ys));
		});
	return A3(
		$elm$core$List$foldr,
		step,
		_Utils_Tuple2(_List_Nil, _List_Nil),
		pairs);
};
var $author$project$Internal$Write$prettyApplication = F3(
	function (aliases, indent, exprs) {
		var _v30 = A2(
			$elm$core$Tuple$mapSecond,
			$Chadtech$elm_bool_extra$Bool$Extra$any,
			$elm$core$List$unzip(
				A2(
					$elm$core$List$map,
					A3(
						$author$project$Internal$Write$prettyExpressionInner,
						aliases,
						{U: false, V: false, Y: 11},
						4),
					$author$project$Internal$Compiler$denodeAll(exprs))));
		var prettyExpressions = _v30.a;
		var alwaysBreak = _v30.b;
		return _Utils_Tuple2(
			A2(
				$author$project$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A2(
						$the_sett$elm_pretty_printer$Pretty$nest,
						indent,
						$the_sett$elm_pretty_printer$Pretty$lines(prettyExpressions)))),
			alwaysBreak);
	});
var $author$project$Internal$Write$prettyCaseBlock = F3(
	function (aliases, indent, caseBlock) {
		var prettyCase = function (_v29) {
			var pattern = _v29.a;
			var expr = _v29.b;
			return A2(
				$the_sett$elm_pretty_printer$Pretty$indent,
				indent,
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					A2(
						$the_sett$elm_pretty_printer$Pretty$indent,
						4,
						A4(
							$author$project$Internal$Write$prettyExpressionInner,
							aliases,
							$author$project$Internal$Write$topContext,
							4,
							$author$project$Internal$Compiler$denode(expr)).a),
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$line,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$string(' ->'),
							A2(
								$author$project$Internal$Write$prettyPattern,
								aliases,
								$author$project$Internal$Compiler$denode(pattern))))));
		};
		var patternsPart = $author$project$Internal$Write$doubleLines(
			A2($elm$core$List$map, prettyCase, caseBlock.ai));
		var casePart = function () {
			var _v28 = A4(
				$author$project$Internal$Write$prettyExpressionInner,
				aliases,
				$author$project$Internal$Write$topContext,
				4,
				$author$project$Internal$Compiler$denode(caseBlock.b));
			var caseExpression = _v28.a;
			var alwaysBreak = _v28.b;
			return A2(
				$author$project$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							A2(
							$the_sett$elm_pretty_printer$Pretty$nest,
							indent,
							A2(
								$author$project$Internal$Write$optionalGroup,
								alwaysBreak,
								$the_sett$elm_pretty_printer$Pretty$lines(
									_List_fromArray(
										[
											$the_sett$elm_pretty_printer$Pretty$string('case'),
											caseExpression
										])))),
							$the_sett$elm_pretty_printer$Pretty$string('of')
						])));
		}();
		return _Utils_Tuple2(
			$the_sett$elm_pretty_printer$Pretty$align(
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[casePart, patternsPart]))),
			true);
	});
var $author$project$Internal$Write$prettyExpression = F2(
	function (aliases, expression) {
		return A4($author$project$Internal$Write$prettyExpressionInner, aliases, $author$project$Internal$Write$topContext, 4, expression).a;
	});
var $author$project$Internal$Write$prettyExpressionInner = F4(
	function (aliases, context, indent, expression) {
		var _v26 = A2($author$project$Internal$Write$adjustExpressionParentheses, context, expression);
		switch (_v26.$) {
			case 0:
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string('()'),
					false);
			case 1:
				var exprs = _v26.a;
				return A3($author$project$Internal$Write$prettyApplication, aliases, indent, exprs);
			case 2:
				var symbol = _v26.a;
				var dir = _v26.b;
				var exprl = _v26.c;
				var exprr = _v26.d;
				return A6($author$project$Internal$Write$prettyOperatorApplication, aliases, indent, symbol, dir, exprl, exprr);
			case 3:
				var modl = _v26.a;
				var val = _v26.b;
				return _Utils_Tuple2(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$string(val),
						A2($author$project$Internal$Write$prettyModuleNameDot, aliases, modl)),
					false);
			case 4:
				var exprBool = _v26.a;
				var exprTrue = _v26.b;
				var exprFalse = _v26.c;
				return A5($author$project$Internal$Write$prettyIfBlock, aliases, indent, exprBool, exprTrue, exprFalse);
			case 5:
				var symbol = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$parens(
						$the_sett$elm_pretty_printer$Pretty$string(symbol)),
					false);
			case 6:
				var symbol = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(symbol),
					false);
			case 7:
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(
						$elm$core$String$fromInt(val)),
					false);
			case 8:
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(
						$author$project$Internal$Write$toHexString(val)),
					false);
			case 9:
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(
						$elm$core$String$fromFloat(val)),
					false);
			case 10:
				var expr = _v26.a;
				var _v27 = A4(
					$author$project$Internal$Write$prettyExpressionInner,
					aliases,
					$author$project$Internal$Write$topContext,
					4,
					$author$project$Internal$Compiler$denode(expr));
				var prettyExpr = _v27.a;
				var alwaysBreak = _v27.b;
				return _Utils_Tuple2(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						prettyExpr,
						$the_sett$elm_pretty_printer$Pretty$string('-')),
					alwaysBreak);
			case 11:
				var val = _v26.a;
				return _Utils_Tuple2(
					$author$project$Internal$Write$prettyLiteral(val),
					false);
			case 12:
				var val = _v26.a;
				return _Utils_Tuple2(
					$author$project$Internal$Write$singleQuotes(
						$the_sett$elm_pretty_printer$Pretty$string(
							$author$project$Internal$Write$escapeChar(val))),
					false);
			case 13:
				var exprs = _v26.a;
				return A3($author$project$Internal$Write$prettyTupledExpression, aliases, indent, exprs);
			case 14:
				var expr = _v26.a;
				return A3($author$project$Internal$Write$prettyParenthesizedExpression, aliases, indent, expr);
			case 15:
				var letBlock = _v26.a;
				return A3($author$project$Internal$Write$prettyLetBlock, aliases, indent, letBlock);
			case 16:
				var caseBlock = _v26.a;
				return A3($author$project$Internal$Write$prettyCaseBlock, aliases, indent, caseBlock);
			case 17:
				var lambda = _v26.a;
				return A3($author$project$Internal$Write$prettyLambdaExpression, aliases, indent, lambda);
			case 18:
				var setters = _v26.a;
				return A2($author$project$Internal$Write$prettyRecordExpr, aliases, setters);
			case 19:
				var exprs = _v26.a;
				return A3($author$project$Internal$Write$prettyList, aliases, indent, exprs);
			case 20:
				var expr = _v26.a;
				var field = _v26.b;
				return A3($author$project$Internal$Write$prettyRecordAccess, aliases, expr, field);
			case 21:
				var field = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(field),
					false);
			case 22:
				var _var = _v26.a;
				var setters = _v26.b;
				return A4($author$project$Internal$Write$prettyRecordUpdateExpression, aliases, indent, _var, setters);
			default:
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string('glsl'),
					true);
		}
	});
var $author$project$Internal$Write$prettyFun = F2(
	function (aliases, fn) {
		return $the_sett$elm_pretty_printer$Pretty$lines(
			_List_fromArray(
				[
					A2(
					$author$project$Internal$Write$prettyMaybe,
					$author$project$Internal$Write$prettyDocumentation,
					$author$project$Internal$Compiler$denodeMaybe(fn.aw)),
					A2(
					$author$project$Internal$Write$prettyMaybe,
					$author$project$Internal$Write$prettySignature(aliases),
					$author$project$Internal$Compiler$denodeMaybe(fn.db)),
					A2(
					$author$project$Internal$Write$prettyFunctionImplementation,
					aliases,
					$author$project$Internal$Compiler$denode(fn.bX))
				]));
	});
var $author$project$Internal$Write$prettyFunctionImplementation = F2(
	function (aliases, impl) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$author$project$Internal$Write$prettyExpression,
					aliases,
					$author$project$Internal$Compiler$denode(impl.b)),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$string(
								$author$project$Internal$Compiler$denode(impl.I)),
								A2(
								$author$project$Internal$Write$prettyArgs,
								aliases,
								$author$project$Internal$Compiler$denodeAll(impl.bG)),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							])))));
	});
var $author$project$Internal$Write$prettyIfBlock = F5(
	function (aliases, indent, exprBool, exprTrue, exprFalse) {
		var innerIfBlock = F3(
			function (innerExprBool, innerExprTrue, innerExprFalse) {
				var truePart = A2(
					$the_sett$elm_pretty_printer$Pretty$indent,
					indent,
					A4(
						$author$project$Internal$Write$prettyExpressionInner,
						aliases,
						$author$project$Internal$Write$topContext,
						4,
						$author$project$Internal$Compiler$denode(innerExprTrue)).a);
				var ifPart = function () {
					var _v25 = A4(
						$author$project$Internal$Write$prettyExpressionInner,
						aliases,
						$author$project$Internal$Write$topContext,
						4,
						$author$project$Internal$Compiler$denode(innerExprBool));
					var prettyBoolExpr = _v25.a;
					var alwaysBreak = _v25.b;
					return A2(
						$author$project$Internal$Write$optionalGroup,
						alwaysBreak,
						$the_sett$elm_pretty_printer$Pretty$lines(
							_List_fromArray(
								[
									A2(
									$the_sett$elm_pretty_printer$Pretty$nest,
									indent,
									A2(
										$author$project$Internal$Write$optionalGroup,
										alwaysBreak,
										$the_sett$elm_pretty_printer$Pretty$lines(
											_List_fromArray(
												[
													$the_sett$elm_pretty_printer$Pretty$string('if'),
													A4(
													$author$project$Internal$Write$prettyExpressionInner,
													aliases,
													$author$project$Internal$Write$topContext,
													4,
													$author$project$Internal$Compiler$denode(innerExprBool)).a
												])))),
									$the_sett$elm_pretty_printer$Pretty$string('then')
								])));
				}();
				var falsePart = function () {
					var _v24 = $author$project$Internal$Compiler$denode(innerExprFalse);
					if (_v24.$ === 4) {
						var nestedExprBool = _v24.a;
						var nestedExprTrue = _v24.b;
						var nestedExprFalse = _v24.c;
						return A3(innerIfBlock, nestedExprBool, nestedExprTrue, nestedExprFalse);
					} else {
						return _List_fromArray(
							[
								A2(
								$the_sett$elm_pretty_printer$Pretty$indent,
								indent,
								A4(
									$author$project$Internal$Write$prettyExpressionInner,
									aliases,
									$author$project$Internal$Write$topContext,
									4,
									$author$project$Internal$Compiler$denode(innerExprFalse)).a)
							]);
					}
				}();
				var elsePart = A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$string('else'),
					$the_sett$elm_pretty_printer$Pretty$line);
				var context = $author$project$Internal$Write$topContext;
				if (!falsePart.b) {
					return _List_Nil;
				} else {
					if (!falsePart.b.b) {
						var falseExpr = falsePart.a;
						return _List_fromArray(
							[ifPart, truePart, elsePart, falseExpr]);
					} else {
						var hd = falsePart.a;
						var tl = falsePart.b;
						return A2(
							$elm$core$List$append,
							_List_fromArray(
								[
									ifPart,
									truePart,
									$the_sett$elm_pretty_printer$Pretty$words(
									_List_fromArray(
										[elsePart, hd]))
								]),
							tl);
					}
				}
			});
		var prettyExpressions = A3(innerIfBlock, exprBool, exprTrue, exprFalse);
		return _Utils_Tuple2(
			$the_sett$elm_pretty_printer$Pretty$align(
				$the_sett$elm_pretty_printer$Pretty$lines(prettyExpressions)),
			true);
	});
var $author$project$Internal$Write$prettyLambdaExpression = F3(
	function (aliases, indent, lambda) {
		var _v22 = A4(
			$author$project$Internal$Write$prettyExpressionInner,
			aliases,
			$author$project$Internal$Write$topContext,
			4,
			$author$project$Internal$Compiler$denode(lambda.b));
		var prettyExpr = _v22.a;
		var alwaysBreak = _v22.b;
		return _Utils_Tuple2(
			A2(
				$author$project$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A2(
						$the_sett$elm_pretty_printer$Pretty$nest,
						indent,
						$the_sett$elm_pretty_printer$Pretty$lines(
							_List_fromArray(
								[
									A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									$the_sett$elm_pretty_printer$Pretty$string(' ->'),
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										$the_sett$elm_pretty_printer$Pretty$words(
											A2(
												$elm$core$List$map,
												A2($author$project$Internal$Write$prettyPatternInner, aliases, false),
												$author$project$Internal$Compiler$denodeAll(lambda.aX))),
										$the_sett$elm_pretty_printer$Pretty$string('\\'))),
									prettyExpr
								]))))),
			alwaysBreak);
	});
var $author$project$Internal$Write$prettyLetBlock = F3(
	function (aliases, indent, letBlock) {
		return _Utils_Tuple2(
			$the_sett$elm_pretty_printer$Pretty$align(
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$string('let'),
							A2(
							$the_sett$elm_pretty_printer$Pretty$indent,
							indent,
							$author$project$Internal$Write$doubleLines(
								A2(
									$elm$core$List$map,
									A2($author$project$Internal$Write$prettyLetDeclaration, aliases, indent),
									$author$project$Internal$Compiler$denodeAll(letBlock.b_)))),
							$the_sett$elm_pretty_printer$Pretty$string('in'),
							A4(
							$author$project$Internal$Write$prettyExpressionInner,
							aliases,
							$author$project$Internal$Write$topContext,
							4,
							$author$project$Internal$Compiler$denode(letBlock.b)).a
						]))),
			true);
	});
var $author$project$Internal$Write$prettyLetDeclaration = F3(
	function (aliases, indent, letDecl) {
		if (!letDecl.$) {
			var fn = letDecl.a;
			return A2($author$project$Internal$Write$prettyFun, aliases, fn);
		} else {
			var pattern = letDecl.a;
			var expr = letDecl.b;
			return A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$the_sett$elm_pretty_printer$Pretty$indent,
					indent,
					A4(
						$author$project$Internal$Write$prettyExpressionInner,
						aliases,
						$author$project$Internal$Write$topContext,
						4,
						$author$project$Internal$Compiler$denode(expr)).a),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								A3(
								$author$project$Internal$Write$prettyPatternInner,
								aliases,
								false,
								$author$project$Internal$Compiler$denode(pattern)),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							]))));
		}
	});
var $author$project$Internal$Write$prettyList = F3(
	function (aliases, indent, exprs) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('['));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(']'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!exprs.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('[]'),
				false);
		} else {
			var _v20 = A2(
				$elm$core$Tuple$mapSecond,
				$Chadtech$elm_bool_extra$Bool$Extra$any,
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						A3(
							$author$project$Internal$Write$prettyExpressionInner,
							aliases,
							$author$project$Internal$Write$topContext,
							A2($author$project$Internal$Write$decrementIndent, indent, 2)),
						$author$project$Internal$Compiler$denodeAll(exprs))));
			var prettyExpressions = _v20.a;
			var alwaysBreak = _v20.b;
			return _Utils_Tuple2(
				A2(
					$author$project$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							open,
							close,
							A2($the_sett$elm_pretty_printer$Pretty$separators, ', ', prettyExpressions)))),
				alwaysBreak);
		}
	});
var $author$project$Internal$Write$prettyOperatorApplication = F6(
	function (aliases, indent, symbol, dir, exprl, exprr) {
		return (symbol === '<|') ? A6($author$project$Internal$Write$prettyOperatorApplicationLeft, aliases, indent, symbol, dir, exprl, exprr) : A6($author$project$Internal$Write$prettyOperatorApplicationRight, aliases, indent, symbol, dir, exprl, exprr);
	});
var $author$project$Internal$Write$prettyOperatorApplicationLeft = F6(
	function (aliases, indent, symbol, _v16, exprl, exprr) {
		var context = {
			U: true,
			V: false,
			Y: $author$project$Internal$Write$precedence(symbol)
		};
		var _v17 = A4(
			$author$project$Internal$Write$prettyExpressionInner,
			aliases,
			context,
			4,
			$author$project$Internal$Compiler$denode(exprr));
		var prettyExpressionRight = _v17.a;
		var alwaysBreakRight = _v17.b;
		var _v18 = A4(
			$author$project$Internal$Write$prettyExpressionInner,
			aliases,
			context,
			4,
			$author$project$Internal$Compiler$denode(exprl));
		var prettyExpressionLeft = _v18.a;
		var alwaysBreakLeft = _v18.b;
		var alwaysBreak = alwaysBreakLeft || alwaysBreakRight;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				A2(
					$author$project$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$lines(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$words(
								_List_fromArray(
									[
										prettyExpressionLeft,
										$the_sett$elm_pretty_printer$Pretty$string(symbol)
									])),
								prettyExpressionRight
							])))),
			alwaysBreak);
	});
var $author$project$Internal$Write$prettyOperatorApplicationRight = F6(
	function (aliases, indent, symbol, _v11, exprl, exprr) {
		var expandExpr = F3(
			function (innerIndent, context, expr) {
				if (expr.$ === 2) {
					var sym = expr.a;
					var left = expr.c;
					var right = expr.d;
					return A4(innerOpApply, false, sym, left, right);
				} else {
					return _List_fromArray(
						[
							A4($author$project$Internal$Write$prettyExpressionInner, aliases, context, innerIndent, expr)
						]);
				}
			});
		var innerOpApply = F4(
			function (isTop, sym, left, right) {
				var innerIndent = A2(
					$author$project$Internal$Write$decrementIndent,
					4,
					$elm$core$String$length(symbol) + 1);
				var leftIndent = isTop ? indent : innerIndent;
				var context = {
					U: '<|' === sym,
					V: false,
					Y: $author$project$Internal$Write$precedence(sym)
				};
				var rightSide = A3(
					expandExpr,
					innerIndent,
					context,
					$author$project$Internal$Compiler$denode(right));
				if (rightSide.b) {
					var _v14 = rightSide.a;
					var hdExpr = _v14.a;
					var hdBreak = _v14.b;
					var tl = rightSide.b;
					return A2(
						$elm$core$List$append,
						A3(
							expandExpr,
							leftIndent,
							context,
							$author$project$Internal$Compiler$denode(left)),
						A2(
							$elm$core$List$cons,
							_Utils_Tuple2(
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									hdExpr,
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										$the_sett$elm_pretty_printer$Pretty$space,
										$the_sett$elm_pretty_printer$Pretty$string(sym))),
								hdBreak),
							tl));
				} else {
					return _List_Nil;
				}
			});
		var _v12 = A2(
			$elm$core$Tuple$mapSecond,
			$Chadtech$elm_bool_extra$Bool$Extra$any,
			$elm$core$List$unzip(
				A4(innerOpApply, true, symbol, exprl, exprr)));
		var prettyExpressions = _v12.a;
		var alwaysBreak = _v12.b;
		return _Utils_Tuple2(
			A2(
				$author$project$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A2(
						$the_sett$elm_pretty_printer$Pretty$join,
						A2($the_sett$elm_pretty_printer$Pretty$nest, indent, $the_sett$elm_pretty_printer$Pretty$line),
						prettyExpressions))),
			alwaysBreak);
	});
var $author$project$Internal$Write$prettyParenthesizedExpression = F3(
	function (aliases, indent, expr) {
		var open = $the_sett$elm_pretty_printer$Pretty$string('(');
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(')'),
			$the_sett$elm_pretty_printer$Pretty$tightline);
		var _v10 = A4(
			$author$project$Internal$Write$prettyExpressionInner,
			aliases,
			$author$project$Internal$Write$topContext,
			A2($author$project$Internal$Write$decrementIndent, indent, 1),
			$author$project$Internal$Compiler$denode(expr));
		var prettyExpr = _v10.a;
		var alwaysBreak = _v10.b;
		return _Utils_Tuple2(
			A2(
				$author$project$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A3(
						$the_sett$elm_pretty_printer$Pretty$surround,
						open,
						close,
						A2($the_sett$elm_pretty_printer$Pretty$nest, 1, prettyExpr)))),
			alwaysBreak);
	});
var $author$project$Internal$Write$prettyRecordAccess = F3(
	function (aliases, expr, field) {
		var _v9 = A4(
			$author$project$Internal$Write$prettyExpressionInner,
			aliases,
			$author$project$Internal$Write$topContext,
			4,
			$author$project$Internal$Compiler$denode(expr));
		var prettyExpr = _v9.a;
		var alwaysBreak = _v9.b;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$string(
					$author$project$Internal$Compiler$denode(field)),
				A2($the_sett$elm_pretty_printer$Pretty$a, $author$project$Internal$Write$dot, prettyExpr)),
			alwaysBreak);
	});
var $author$project$Internal$Write$prettyRecordExpr = F2(
	function (aliases, setters) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('{'));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!setters.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('{}'),
				false);
		} else {
			var _v8 = A2(
				$elm$core$Tuple$mapSecond,
				$Chadtech$elm_bool_extra$Bool$Extra$any,
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						$author$project$Internal$Write$prettySetter(aliases),
						$author$project$Internal$Compiler$denodeAll(setters))));
			var prettyExpressions = _v8.a;
			var alwaysBreak = _v8.b;
			return _Utils_Tuple2(
				A2(
					$author$project$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							open,
							close,
							A2($the_sett$elm_pretty_printer$Pretty$separators, ', ', prettyExpressions)))),
				alwaysBreak);
		}
	});
var $author$project$Internal$Write$prettyRecordUpdateExpression = F4(
	function (aliases, indent, _var, setters) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			$the_sett$elm_pretty_printer$Pretty$words(
				_List_fromArray(
					[
						$the_sett$elm_pretty_printer$Pretty$string('{'),
						$the_sett$elm_pretty_printer$Pretty$string(
						$author$project$Internal$Compiler$denode(_var))
					])));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		var addBarToFirst = function (exprs) {
			if (!exprs.b) {
				return _List_Nil;
			} else {
				var hd = exprs.a;
				var tl = exprs.b;
				return A2(
					$elm$core$List$cons,
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						hd,
						$the_sett$elm_pretty_printer$Pretty$string('| ')),
					tl);
			}
		};
		if (!setters.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('{}'),
				false);
		} else {
			var _v5 = A2(
				$elm$core$Tuple$mapSecond,
				$Chadtech$elm_bool_extra$Bool$Extra$any,
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						$author$project$Internal$Write$prettySetter(aliases),
						$author$project$Internal$Compiler$denodeAll(setters))));
			var prettyExpressions = _v5.a;
			var alwaysBreak = _v5.b;
			return _Utils_Tuple2(
				A2(
					$author$project$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							$the_sett$elm_pretty_printer$Pretty$empty,
							close,
							A2(
								$the_sett$elm_pretty_printer$Pretty$nest,
								indent,
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									A2(
										$the_sett$elm_pretty_printer$Pretty$separators,
										', ',
										addBarToFirst(prettyExpressions)),
									open))))),
				alwaysBreak);
		}
	});
var $author$project$Internal$Write$prettySetter = F2(
	function (aliases, _v2) {
		var fld = _v2.a;
		var val = _v2.b;
		var _v3 = A4(
			$author$project$Internal$Write$prettyExpressionInner,
			aliases,
			$author$project$Internal$Write$topContext,
			4,
			$author$project$Internal$Compiler$denode(val));
		var prettyExpr = _v3.a;
		var alwaysBreak = _v3.b;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				A2(
					$author$project$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$lines(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$words(
								_List_fromArray(
									[
										$the_sett$elm_pretty_printer$Pretty$string(
										$author$project$Internal$Compiler$denode(fld)),
										$the_sett$elm_pretty_printer$Pretty$string('=')
									])),
								prettyExpr
							])))),
			alwaysBreak);
	});
var $author$project$Internal$Write$prettyTupledExpression = F3(
	function (aliases, indent, exprs) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('('));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(')'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!exprs.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('()'),
				false);
		} else {
			var _v1 = A2(
				$elm$core$Tuple$mapSecond,
				$Chadtech$elm_bool_extra$Bool$Extra$any,
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						A3(
							$author$project$Internal$Write$prettyExpressionInner,
							aliases,
							$author$project$Internal$Write$topContext,
							A2($author$project$Internal$Write$decrementIndent, indent, 2)),
						$author$project$Internal$Compiler$denodeAll(exprs))));
			var prettyExpressions = _v1.a;
			var alwaysBreak = _v1.b;
			return _Utils_Tuple2(
				A2(
					$author$project$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							open,
							close,
							A2($the_sett$elm_pretty_printer$Pretty$separators, ', ', prettyExpressions)))),
				alwaysBreak);
		}
	});
var $author$project$Internal$Write$prettyDestructuring = F3(
	function (aliases, pattern, expr) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			$the_sett$elm_pretty_printer$Pretty$lines(
				_List_fromArray(
					[
						$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								A2($author$project$Internal$Write$prettyPattern, aliases, pattern),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							])),
						A2($author$project$Internal$Write$prettyExpression, aliases, expr)
					])));
	});
var $author$project$Internal$Write$prettyInfix = function (infix_) {
	var dirToString = function (direction) {
		switch (direction) {
			case 0:
				return 'left';
			case 1:
				return 'right';
			default:
				return 'non';
		}
	};
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('infix'),
				$the_sett$elm_pretty_printer$Pretty$string(
				dirToString(
					$author$project$Internal$Compiler$denode(infix_.b1))),
				$the_sett$elm_pretty_printer$Pretty$string(
				$elm$core$String$fromInt(
					$author$project$Internal$Compiler$denode(infix_.Y))),
				$the_sett$elm_pretty_printer$Pretty$parens(
				$the_sett$elm_pretty_printer$Pretty$string(
					$author$project$Internal$Compiler$denode(infix_.cW))),
				$the_sett$elm_pretty_printer$Pretty$string('='),
				$the_sett$elm_pretty_printer$Pretty$string(
				$author$project$Internal$Compiler$denode(infix_.cl))
			]));
};
var $author$project$Internal$Write$prettyPortDeclaration = F2(
	function (aliases, sig) {
		return $the_sett$elm_pretty_printer$Pretty$words(
			_List_fromArray(
				[
					$the_sett$elm_pretty_printer$Pretty$string('port'),
					A2($author$project$Internal$Write$prettySignature, aliases, sig)
				]));
	});
var $author$project$Internal$Write$prettyTypeAlias = F2(
	function (aliases, tAlias) {
		var typeAliasPretty = A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$author$project$Internal$Write$prettyTypeAnnotation,
					aliases,
					$author$project$Internal$Compiler$denode(tAlias.aV)),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$string('type alias'),
								$the_sett$elm_pretty_printer$Pretty$string(
								$author$project$Internal$Compiler$denode(tAlias.I)),
								$the_sett$elm_pretty_printer$Pretty$words(
								A2(
									$elm$core$List$map,
									$the_sett$elm_pretty_printer$Pretty$string,
									$author$project$Internal$Compiler$denodeAll(tAlias.a9))),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							])))));
		return $the_sett$elm_pretty_printer$Pretty$lines(
			_List_fromArray(
				[
					A2(
					$author$project$Internal$Write$prettyMaybe,
					$author$project$Internal$Write$prettyDocumentation,
					$author$project$Internal$Compiler$denodeMaybe(tAlias.aw)),
					typeAliasPretty
				]));
	});
var $author$project$Internal$Write$prettyElmSyntaxDeclaration = F2(
	function (aliases, decl) {
		switch (decl.$) {
			case 0:
				var fn = decl.a;
				return A2($author$project$Internal$Write$prettyFun, aliases, fn);
			case 1:
				var tAlias = decl.a;
				return A2($author$project$Internal$Write$prettyTypeAlias, aliases, tAlias);
			case 2:
				var type_ = decl.a;
				return A2($author$project$Internal$Write$prettyCustomType, aliases, type_);
			case 3:
				var sig = decl.a;
				return A2($author$project$Internal$Write$prettyPortDeclaration, aliases, sig);
			case 4:
				var infix_ = decl.a;
				return $author$project$Internal$Write$prettyInfix(infix_);
			default:
				var pattern = decl.a;
				var expr = decl.b;
				return A3(
					$author$project$Internal$Write$prettyDestructuring,
					aliases,
					$author$project$Internal$Compiler$denode(pattern),
					$author$project$Internal$Compiler$denode(expr));
		}
	});
var $author$project$Internal$Write$prettyDeclarations = F2(
	function (aliases, decls) {
		return A3(
			$elm$core$List$foldl,
			F2(
				function (decl, doc) {
					if (decl.$ === 1) {
						var content = decl.a;
						return A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$line,
							A2(
								$the_sett$elm_pretty_printer$Pretty$a,
								$the_sett$elm_pretty_printer$Pretty$string(content + '\n\n'),
								doc));
					} else {
						var innerDecl = decl.c;
						return A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$line,
							A2(
								$the_sett$elm_pretty_printer$Pretty$a,
								$the_sett$elm_pretty_printer$Pretty$line,
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									$the_sett$elm_pretty_printer$Pretty$line,
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										A2($author$project$Internal$Write$prettyElmSyntaxDeclaration, aliases, innerDecl),
										doc))));
					}
				}),
			$the_sett$elm_pretty_printer$Pretty$empty,
			decls);
	});
var $author$project$Internal$Comments$delimeters = function (doc) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$a,
		$the_sett$elm_pretty_printer$Pretty$string('-}'),
		A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				doc,
				$the_sett$elm_pretty_printer$Pretty$string('{-| '))));
};
var $author$project$Internal$Comments$getParts = function (_v0) {
	var parts = _v0;
	return $elm$core$List$reverse(parts);
};
var $author$project$Internal$Comments$DocTags = function (a) {
	return {$: 2, a: a};
};
var $author$project$Internal$Comments$fitAndSplit = F2(
	function (width, tags) {
		if (!tags.b) {
			return _List_Nil;
		} else {
			var t = tags.a;
			var ts = tags.b;
			var _v1 = A3(
				$elm$core$List$foldl,
				F2(
					function (tag, _v2) {
						var allSplits = _v2.a;
						var curSplit = _v2.b;
						var remaining = _v2.c;
						return (_Utils_cmp(
							$elm$core$String$length(tag),
							remaining) < 1) ? _Utils_Tuple3(
							allSplits,
							A2($elm$core$List$cons, tag, curSplit),
							remaining - $elm$core$String$length(tag)) : _Utils_Tuple3(
							_Utils_ap(
								allSplits,
								_List_fromArray(
									[
										$elm$core$List$reverse(curSplit)
									])),
							_List_fromArray(
								[tag]),
							width - $elm$core$String$length(tag));
					}),
				_Utils_Tuple3(
					_List_Nil,
					_List_fromArray(
						[t]),
					width - $elm$core$String$length(t)),
				ts);
			var splitsExceptLast = _v1.a;
			var lastSplit = _v1.b;
			return _Utils_ap(
				splitsExceptLast,
				_List_fromArray(
					[
						$elm$core$List$reverse(lastSplit)
					]));
		}
	});
var $elm$core$List$sort = function (xs) {
	return A2($elm$core$List$sortBy, $elm$core$Basics$identity, xs);
};
var $author$project$Internal$Comments$mergeDocTags = function (innerParts) {
	var _v0 = A3(
		$elm$core$List$foldr,
		F2(
			function (part, _v1) {
				var accum = _v1.a;
				var context = _v1.b;
				if (context.$ === 1) {
					if (part.$ === 2) {
						var tags = part.a;
						return _Utils_Tuple2(
							accum,
							$elm$core$Maybe$Just(tags));
					} else {
						var otherPart = part;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, otherPart, accum),
							$elm$core$Maybe$Nothing);
					}
				} else {
					var contextTags = context.a;
					if (part.$ === 2) {
						var tags = part.a;
						return _Utils_Tuple2(
							accum,
							$elm$core$Maybe$Just(
								_Utils_ap(contextTags, tags)));
					} else {
						var otherPart = part;
						return _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								otherPart,
								A2(
									$elm$core$List$cons,
									$author$project$Internal$Comments$DocTags(
										$elm$core$List$sort(contextTags)),
									accum)),
							$elm$core$Maybe$Nothing);
					}
				}
			}),
		_Utils_Tuple2(_List_Nil, $elm$core$Maybe$Nothing),
		innerParts);
	var partsExceptMaybeFirst = _v0.a;
	var maybeFirstPart = _v0.b;
	if (maybeFirstPart.$ === 1) {
		return partsExceptMaybeFirst;
	} else {
		var tags = maybeFirstPart.a;
		return A2(
			$elm$core$List$cons,
			$author$project$Internal$Comments$DocTags(
				$elm$core$List$sort(tags)),
			partsExceptMaybeFirst);
	}
};
var $author$project$Internal$Comments$layoutTags = F2(
	function (width, parts) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (part, _v0) {
					var accumParts = _v0.a;
					var accumDocTags = _v0.b;
					if (part.$ === 2) {
						var tags = part.a;
						var splits = A2($author$project$Internal$Comments$fitAndSplit, width, tags);
						return _Utils_Tuple2(
							_Utils_ap(
								A2($elm$core$List$map, $author$project$Internal$Comments$DocTags, splits),
								accumParts),
							_Utils_ap(accumDocTags, splits));
					} else {
						var otherPart = part;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, otherPart, accumParts),
							accumDocTags);
					}
				}),
			_Utils_Tuple2(_List_Nil, _List_Nil),
			$author$project$Internal$Comments$mergeDocTags(parts));
	});
var $the_sett$elm_pretty_printer$Internals$NLine = F3(
	function (a, b, c) {
		return {$: 2, a: a, b: b, c: c};
	});
var $the_sett$elm_pretty_printer$Internals$NNil = {$: 0};
var $the_sett$elm_pretty_printer$Internals$NText = F3(
	function (a, b, c) {
		return {$: 1, a: a, b: b, c: c};
	});
var $the_sett$elm_pretty_printer$Internals$fits = F2(
	function (w, normal) {
		fits:
		while (true) {
			if (w < 0) {
				return false;
			} else {
				switch (normal.$) {
					case 0:
						return true;
					case 1:
						var text = normal.a;
						var innerNormal = normal.b;
						var $temp$w = w - $elm$core$String$length(text),
							$temp$normal = innerNormal(0);
						w = $temp$w;
						normal = $temp$normal;
						continue fits;
					default:
						return true;
				}
			}
		}
	});
var $the_sett$elm_pretty_printer$Internals$better = F4(
	function (w, k, doc, doc2Fn) {
		return A2($the_sett$elm_pretty_printer$Internals$fits, w - k, doc) ? doc : doc2Fn(0);
	});
var $the_sett$elm_pretty_printer$Internals$best = F3(
	function (width, startCol, x) {
		var be = F3(
			function (w, k, docs) {
				be:
				while (true) {
					if (!docs.b) {
						return $the_sett$elm_pretty_printer$Internals$NNil;
					} else {
						switch (docs.a.b.$) {
							case 0:
								var _v1 = docs.a;
								var i = _v1.a;
								var _v2 = _v1.b;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = ds;
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							case 1:
								var _v3 = docs.a;
								var i = _v3.a;
								var _v4 = _v3.b;
								var doc = _v4.a;
								var doc2 = _v4.b;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i,
										doc(0)),
									A2(
										$elm$core$List$cons,
										_Utils_Tuple2(
											i,
											doc2(0)),
										ds));
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							case 2:
								var _v5 = docs.a;
								var i = _v5.a;
								var _v6 = _v5.b;
								var j = _v6.a;
								var doc = _v6.b;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i + j,
										doc(0)),
									ds);
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							case 3:
								var _v7 = docs.a;
								var i = _v7.a;
								var _v8 = _v7.b;
								var text = _v8.a;
								var maybeTag = _v8.b;
								var ds = docs.b;
								return A3(
									$the_sett$elm_pretty_printer$Internals$NText,
									text,
									function (_v9) {
										return A3(
											be,
											w,
											k + $elm$core$String$length(text),
											ds);
									},
									maybeTag);
							case 4:
								var _v10 = docs.a;
								var i = _v10.a;
								var _v11 = _v10.b;
								var vsep = _v11.b;
								var ds = docs.b;
								return A3(
									$the_sett$elm_pretty_printer$Internals$NLine,
									i,
									vsep,
									function (_v12) {
										return A3(
											be,
											w,
											i + $elm$core$String$length(vsep),
											ds);
									});
							case 5:
								var _v13 = docs.a;
								var i = _v13.a;
								var _v14 = _v13.b;
								var doc = _v14.a;
								var doc2 = _v14.b;
								var ds = docs.b;
								return A4(
									$the_sett$elm_pretty_printer$Internals$better,
									w,
									k,
									A3(
										be,
										w,
										k,
										A2(
											$elm$core$List$cons,
											_Utils_Tuple2(i, doc),
											ds)),
									function (_v15) {
										return A3(
											be,
											w,
											k,
											A2(
												$elm$core$List$cons,
												_Utils_Tuple2(i, doc2),
												ds));
									});
							case 6:
								var _v16 = docs.a;
								var i = _v16.a;
								var fn = _v16.b.a;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i,
										fn(i)),
									ds);
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							default:
								var _v17 = docs.a;
								var i = _v17.a;
								var fn = _v17.b.a;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i,
										fn(k)),
									ds);
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
						}
					}
				}
			});
		return A3(
			be,
			width,
			startCol,
			_List_fromArray(
				[
					_Utils_Tuple2(0, x)
				]));
	});
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $the_sett$elm_pretty_printer$Internals$layout = function (normal) {
	var layoutInner = F2(
		function (normal2, acc) {
			layoutInner:
			while (true) {
				switch (normal2.$) {
					case 0:
						return acc;
					case 1:
						var text = normal2.a;
						var innerNormal = normal2.b;
						var maybeTag = normal2.c;
						var $temp$normal2 = innerNormal(0),
							$temp$acc = A2($elm$core$List$cons, text, acc);
						normal2 = $temp$normal2;
						acc = $temp$acc;
						continue layoutInner;
					default:
						var i = normal2.a;
						var sep = normal2.b;
						var innerNormal = normal2.c;
						var norm = innerNormal(0);
						if (norm.$ === 2) {
							var $temp$normal2 = innerNormal(0),
								$temp$acc = A2($elm$core$List$cons, '\n' + sep, acc);
							normal2 = $temp$normal2;
							acc = $temp$acc;
							continue layoutInner;
						} else {
							var $temp$normal2 = innerNormal(0),
								$temp$acc = A2(
								$elm$core$List$cons,
								'\n' + (A2($the_sett$elm_pretty_printer$Internals$copy, i, ' ') + sep),
								acc);
							normal2 = $temp$normal2;
							acc = $temp$acc;
							continue layoutInner;
						}
				}
			}
		});
	return $elm$core$String$concat(
		$elm$core$List$reverse(
			A2(layoutInner, normal, _List_Nil)));
};
var $the_sett$elm_pretty_printer$Pretty$pretty = F2(
	function (w, doc) {
		return $the_sett$elm_pretty_printer$Internals$layout(
			A3($the_sett$elm_pretty_printer$Internals$best, w, 0, doc));
	});
var $author$project$Internal$Comments$prettyCode = function (val) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$indent,
		4,
		$the_sett$elm_pretty_printer$Pretty$string(val));
};
var $author$project$Internal$Comments$prettyMarkdown = function (val) {
	return $the_sett$elm_pretty_printer$Pretty$string(val);
};
var $author$project$Internal$Comments$prettyTags = function (tags) {
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('@docs'),
				A2(
				$the_sett$elm_pretty_printer$Pretty$join,
				$the_sett$elm_pretty_printer$Pretty$string(', '),
				A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, tags))
			]));
};
var $author$project$Internal$Comments$prettyCommentPart = function (part) {
	switch (part.$) {
		case 0:
			var val = part.a;
			return $author$project$Internal$Comments$prettyMarkdown(val);
		case 1:
			var val = part.a;
			return $author$project$Internal$Comments$prettyCode(val);
		default:
			var tags = part.a;
			return $author$project$Internal$Comments$prettyTags(tags);
	}
};
var $author$project$Internal$Comments$prettyFileComment = F2(
	function (width, comment) {
		var _v0 = A2(
			$author$project$Internal$Comments$layoutTags,
			width,
			$author$project$Internal$Comments$getParts(comment));
		var parts = _v0.a;
		var splits = _v0.b;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$pretty,
				width,
				$author$project$Internal$Comments$delimeters(
					$the_sett$elm_pretty_printer$Pretty$lines(
						A2($elm$core$List$map, $author$project$Internal$Comments$prettyCommentPart, parts)))),
			splits);
	});
var $author$project$Internal$Write$prettyDefaultModuleData = function (moduleData) {
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('module'),
				$author$project$Internal$Write$prettyModuleName(
				$author$project$Internal$Compiler$denode(moduleData.ay)),
				$author$project$Internal$Write$prettyExposing(
				$author$project$Internal$Compiler$denode(moduleData.b9))
			]));
};
var $author$project$Internal$Write$prettyEffectModuleData = function (moduleData) {
	var prettyCmdAndSub = F2(
		function (maybeCmd, maybeSub) {
			var _v0 = _Utils_Tuple2(maybeCmd, maybeSub);
			if (!_v0.a.$) {
				if (!_v0.b.$) {
					var cmdName = _v0.a.a;
					var subName = _v0.b.a;
					return $elm$core$Maybe$Just(
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('where { command ='),
									$the_sett$elm_pretty_printer$Pretty$string(cmdName),
									$the_sett$elm_pretty_printer$Pretty$string(','),
									$the_sett$elm_pretty_printer$Pretty$string('subscription ='),
									$the_sett$elm_pretty_printer$Pretty$string(subName),
									$the_sett$elm_pretty_printer$Pretty$string('}')
								])));
				} else {
					var cmdName = _v0.a.a;
					var _v3 = _v0.b;
					return $elm$core$Maybe$Just(
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('where { command ='),
									$the_sett$elm_pretty_printer$Pretty$string(cmdName),
									$the_sett$elm_pretty_printer$Pretty$string('}')
								])));
				}
			} else {
				if (_v0.b.$ === 1) {
					var _v1 = _v0.a;
					var _v2 = _v0.b;
					return $elm$core$Maybe$Nothing;
				} else {
					var _v4 = _v0.a;
					var subName = _v0.b.a;
					return $elm$core$Maybe$Just(
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('where { subscription ='),
									$the_sett$elm_pretty_printer$Pretty$string(subName),
									$the_sett$elm_pretty_printer$Pretty$string('}')
								])));
				}
			}
		});
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('effect module'),
				$author$project$Internal$Write$prettyModuleName(
				$author$project$Internal$Compiler$denode(moduleData.ay)),
				A2(
				$author$project$Internal$Write$prettyMaybe,
				$elm$core$Basics$identity,
				A2(
					prettyCmdAndSub,
					$author$project$Internal$Compiler$denodeMaybe(moduleData.bQ),
					$author$project$Internal$Compiler$denodeMaybe(moduleData.df))),
				$author$project$Internal$Write$prettyExposing(
				$author$project$Internal$Compiler$denode(moduleData.b9))
			]));
};
var $author$project$Internal$Write$prettyPortModuleData = function (moduleData) {
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('port module'),
				$author$project$Internal$Write$prettyModuleName(
				$author$project$Internal$Compiler$denode(moduleData.ay)),
				$author$project$Internal$Write$prettyExposing(
				$author$project$Internal$Compiler$denode(moduleData.b9))
			]));
};
var $author$project$Internal$Write$prettyModule = function (mod) {
	switch (mod.$) {
		case 0:
			var defaultModuleData = mod.a;
			return $author$project$Internal$Write$prettyDefaultModuleData(defaultModuleData);
		case 1:
			var defaultModuleData = mod.a;
			return $author$project$Internal$Write$prettyPortModuleData(defaultModuleData);
		default:
			var effectModuleData = mod.a;
			return $author$project$Internal$Write$prettyEffectModuleData(effectModuleData);
	}
};
var $author$project$Internal$Write$prepareLayout = F2(
	function (width, file) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			A2($author$project$Internal$Write$prettyDeclarations, file.ah, file.b_),
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$author$project$Internal$Write$importsPretty(file.a),
				function (doc) {
					var _v0 = file.a$;
					if (_v0.$ === 1) {
						return doc;
					} else {
						var fileComment = _v0.a;
						var _v1 = A2($author$project$Internal$Comments$prettyFileComment, width, fileComment);
						var fileCommentStr = _v1.a;
						var innerTags = _v1.b;
						return A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$line,
							A2(
								$the_sett$elm_pretty_printer$Pretty$a,
								$author$project$Internal$Write$prettyComments(
									_List_fromArray(
										[fileCommentStr])),
								doc));
					}
				}(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$line,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$line,
							$author$project$Internal$Write$prettyModule(file.cO))))));
	});
var $author$project$Internal$Write$pretty = F2(
	function (width, file) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$pretty,
			width,
			A2($author$project$Internal$Write$prepareLayout, width, file));
	});
var $author$project$Internal$Write$write = $author$project$Internal$Write$pretty(80);
var $author$project$Elm$render = F2(
	function (toDocComment, fileDetails) {
		var mod = fileDetails.cO;
		var exposedGroups = $author$project$Internal$Compiler$getExposedGroups(fileDetails.R);
		var exposed = $author$project$Internal$Compiler$getExposed(fileDetails.R);
		var body = $author$project$Internal$Write$write(
			{
				ah: fileDetails.ah,
				a$: $elm$core$Maybe$Just(
					A2(
						$author$project$Internal$Comments$addPart,
						$author$project$Internal$Comments$emptyComment,
						$author$project$Internal$Comments$Markdown(
							toDocComment(exposedGroups)))),
				b_: fileDetails.R,
				a: A2(
					$elm$core$List$filterMap,
					$author$project$Internal$Compiler$makeImport(fileDetails.ah),
					fileDetails.a),
				cO: ($author$project$Internal$Compiler$hasPorts(fileDetails.R) ? $stil4m$elm_syntax$Elm$Syntax$Module$PortModule : $stil4m$elm_syntax$Elm$Syntax$Module$NormalModule)(
					{
						b9: function () {
							if (!exposed.b) {
								return $author$project$Internal$Compiler$nodify(
									$stil4m$elm_syntax$Elm$Syntax$Exposing$All($stil4m$elm_syntax$Elm$Syntax$Range$emptyRange));
							} else {
								return $author$project$Internal$Compiler$nodify(
									$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
										$author$project$Internal$Compiler$nodifyAll(exposed)));
							}
						}(),
						ay: $author$project$Internal$Compiler$nodify(mod)
					})
			});
		return {
			a0: body,
			bi: A2($elm$core$String$join, '/', mod) + '.elm'
		};
	});
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $author$project$Elm$fileWith = F3(
	function (mod, options, decs) {
		return A2(
			$author$project$Elm$render,
			options.b3,
			{
				ah: options.ah,
				R: decs,
				a: A3(
					$author$project$Elm$reduceDeclarationImports,
					mod,
					decs,
					_Utils_Tuple2($elm$core$Set$empty, _List_Nil)).b,
				ax: '',
				cO: mod
			});
	});
var $author$project$Elm$Gen$Elm$apply = F2(
	function (arg1, arg2) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$moduleName_,
				'apply',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm']),
							'Expression',
							_List_Nil),
							$author$project$Elm$Annotation$list(
							A3(
								$author$project$Elm$Annotation$namedWith,
								_List_fromArray(
									['Elm']),
								'Expression',
								_List_Nil))
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm']),
						'Expression',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2]));
	});
var $author$project$Generate$apply = F2(
	function (fn, args) {
		return A2(
			$author$project$Elm$Gen$Elm$apply,
			fn,
			$author$project$Elm$list(args));
	});
var $author$project$Generate$argName = function (index) {
	return 'arg' + $elm$core$String$fromInt(index);
};
var $author$project$Generate$elm = _List_fromArray(
	['Elm']);
var $author$project$Generate$expressionType = A2($author$project$Elm$Annotation$named, $author$project$Generate$elm, 'Expression');
var $author$project$Elm$Annotation$record = function (fields) {
	return {
		c: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(
			$author$project$Internal$Compiler$nodifyAll(
				A2(
					$elm$core$List$map,
					function (_v0) {
						var name = _v0.a;
						var ann = _v0.b;
						return _Utils_Tuple2(
							$author$project$Internal$Compiler$nodify(
								$author$project$Internal$Compiler$formatValue(name)),
							$author$project$Internal$Compiler$nodify(
								$author$project$Internal$Compiler$getInnerAnnotation(ann)));
					},
					fields))),
		a: A2(
			$elm$core$List$concatMap,
			A2($elm$core$Basics$composeR, $elm$core$Tuple$second, $author$project$Internal$Compiler$getAnnotationImports),
			fields)
	};
};
var $author$project$Generate$asArgumentTypeHelper = function (tipe) {
	_v0$3:
	while (true) {
		switch (tipe.$) {
			case 1:
				var one = tipe.a;
				var two = tipe.b;
				return A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Generate$asArgumentTypeHelper(one)
						]),
					$author$project$Generate$asArgumentTypeHelper(two));
			case 3:
				if (((tipe.a === 'List.List') && tipe.b.b) && (!tipe.b.b.b)) {
					var _v1 = tipe.b;
					var inner = _v1.a;
					return $author$project$Elm$Annotation$list(
						$author$project$Generate$asArgumentTypeHelper(inner));
				} else {
					break _v0$3;
				}
			case 4:
				if (tipe.b.$ === 1) {
					var fields = tipe.a;
					var _v2 = tipe.b;
					return $author$project$Elm$Annotation$record(
						A2(
							$elm$core$List$map,
							function (_v3) {
								var fieldName = _v3.a;
								var fieldType = _v3.b;
								var fieldAnnotation = $author$project$Generate$asArgumentTypeHelper(fieldType);
								return _Utils_Tuple2(fieldName, fieldAnnotation);
							},
							fields));
				} else {
					break _v0$3;
				}
			default:
				break _v0$3;
		}
	}
	return $author$project$Generate$expressionType;
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern = function (a) {
	return {$: 11, a: a};
};
var $author$project$Elm$Pattern$var = function (name) {
	return $stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern(name);
};
var $author$project$Generate$asArgument = F2(
	function (index, tipe) {
		return _Utils_Tuple2(
			$author$project$Generate$asArgumentTypeHelper(tipe),
			$author$project$Elm$Pattern$var(
				$author$project$Generate$argName(index)));
	});
var $author$project$Elm$Gen$Elm$field = F2(
	function (arg1, arg2) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$moduleName_,
				'field',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Elm$Annotation$string,
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm']),
							'Expression',
							_List_Nil)
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm']),
						'Field',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2]));
	});
var $author$project$Internal$Compiler$CouldNotFindField = function (a) {
	return {$: 7, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccess = F2(
	function (a, b) {
		return {$: 20, a: a, b: b};
	});
var $author$project$Elm$getField = F2(
	function (selector, fields) {
		getField:
		while (true) {
			if (!fields.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var nodifiedTop = fields.a;
				var remain = fields.b;
				var _v1 = $author$project$Internal$Compiler$denode(nodifiedTop);
				var fieldname = _v1.a;
				var contents = _v1.b;
				if (_Utils_eq(
					$author$project$Internal$Compiler$denode(fieldname),
					selector)) {
					return $elm$core$Maybe$Just(
						$author$project$Internal$Compiler$denode(contents));
				} else {
					var $temp$selector = selector,
						$temp$fields = remain;
					selector = $temp$selector;
					fields = $temp$fields;
					continue getField;
				}
			}
		}
	});
var $author$project$Elm$get = F2(
	function (selector, _v0) {
		var expr = _v0;
		return {
			c: function () {
				var _v1 = expr.c;
				_v1$2:
				while (true) {
					if (!_v1.$) {
						switch (_v1.a.$) {
							case 4:
								var fields = _v1.a.a;
								var _v2 = A2(
									$author$project$Elm$getField,
									$author$project$Internal$Compiler$formatValue(selector),
									fields);
								if (!_v2.$) {
									var ann = _v2.a;
									return $elm$core$Result$Ok(ann);
								} else {
									return $elm$core$Result$Err(
										_List_fromArray(
											[
												$author$project$Internal$Compiler$CouldNotFindField(selector)
											]));
								}
							case 5:
								var _v3 = _v1.a;
								var name = _v3.a;
								var fields = _v3.b;
								var _v4 = A2(
									$author$project$Elm$getField,
									$author$project$Internal$Compiler$formatValue(selector),
									$author$project$Internal$Compiler$denode(fields));
								if (!_v4.$) {
									var ann = _v4.a;
									return $elm$core$Result$Ok(ann);
								} else {
									return $elm$core$Result$Err(
										_List_fromArray(
											[
												$author$project$Internal$Compiler$CouldNotFindField(selector)
											]));
								}
							default:
								break _v1$2;
						}
					} else {
						break _v1$2;
					}
				}
				var otherwise = _v1;
				return otherwise;
			}(),
			b: A2(
				$stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccess,
				$author$project$Internal$Compiler$nodify(expr.b),
				$author$project$Internal$Compiler$nodify(
					$author$project$Internal$Compiler$formatValue(selector))),
			a: expr.a,
			g: false
		};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression = function (a) {
	return {$: 17, a: a};
};
var $author$project$Elm$lambda = F3(
	function (argBaseName, argType, toExpression) {
		var arg1 = A3($author$project$Elm$valueWith, _List_Nil, argBaseName, argType);
		var _v0 = toExpression(arg1);
		var expr = _v0;
		return {
			c: function () {
				var _v1 = expr.c;
				if (_v1.$ === 1) {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				} else {
					var _return = _v1.a;
					return $elm$core$Result$Ok(
						A3(
							$elm$core$List$foldr,
							F2(
								function (ann, fnbody) {
									return A2(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
										$author$project$Internal$Compiler$nodify(ann),
										$author$project$Internal$Compiler$nodify(fnbody));
								}),
							_return,
							_List_fromArray(
								[
									$author$project$Internal$Compiler$getInnerAnnotation(argType)
								])));
				}
			}(),
			b: $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
				{
					aX: _List_fromArray(
						[
							$author$project$Internal$Compiler$nodify(
							$stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern(argBaseName))
						]),
					b: $author$project$Internal$Compiler$nodify(expr.b)
				}),
			a: expr.a,
			g: false
		};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$UnitExpr = {$: 0};
var $author$project$Internal$Compiler$skip = {
	c: $elm$core$Result$Err(_List_Nil),
	b: $stil4m$elm_syntax$Elm$Syntax$Expression$UnitExpr,
	a: _List_Nil,
	g: true
};
var $author$project$Elm$pass = $author$project$Internal$Compiler$skip;
var $author$project$Elm$Gen$Elm$lambda = F3(
	function (arg1, arg2, arg3) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$moduleName_,
				'lambda',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Elm$Annotation$string,
							A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm', 'Annotation']),
							'Annotation',
							_List_Nil),
							A2(
							$author$project$Elm$Annotation$function,
							_List_fromArray(
								[
									A3(
									$author$project$Elm$Annotation$namedWith,
									_List_fromArray(
										['Elm']),
									'Expression',
									_List_Nil)
								]),
							A3(
								$author$project$Elm$Annotation$namedWith,
								_List_fromArray(
									['Elm']),
								'Expression',
								_List_Nil))
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm']),
						'Expression',
						_List_Nil))),
			_List_fromArray(
				[
					arg1,
					arg2,
					arg3($author$project$Elm$pass)
				]));
	});
var $author$project$Elm$Gen$Elm$list = function (arg1) {
	return A2(
		$author$project$Elm$apply,
		A3(
			$author$project$Elm$valueWith,
			$author$project$Elm$Gen$Elm$moduleName_,
			'list',
			A2(
				$author$project$Elm$Annotation$function,
				_List_fromArray(
					[
						$author$project$Elm$Annotation$list(
						A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm']),
							'Expression',
							_List_Nil))
					]),
				A3(
					$author$project$Elm$Annotation$namedWith,
					_List_fromArray(
						['Elm']),
					'Expression',
					_List_Nil))),
		_List_fromArray(
			[arg1]));
};
var $author$project$Elm$Gen$Elm$record = function (arg1) {
	return A2(
		$author$project$Elm$apply,
		A3(
			$author$project$Elm$valueWith,
			$author$project$Elm$Gen$Elm$moduleName_,
			'record',
			A2(
				$author$project$Elm$Annotation$function,
				_List_fromArray(
					[
						$author$project$Elm$Annotation$list(
						A3(
							$author$project$Elm$Annotation$namedWith,
							_List_fromArray(
								['Elm']),
							'Field',
							_List_Nil))
					]),
				A3(
					$author$project$Elm$Annotation$namedWith,
					_List_fromArray(
						['Elm']),
					'Expression',
					_List_Nil))),
		_List_fromArray(
			[arg1]));
};
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord = F2(
	function (a, b) {
		return {$: 5, a: a, b: b};
	});
var $author$project$Elm$Annotation$extensible = F2(
	function (base, fields) {
		return {
			c: A2(
				$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord,
				$author$project$Internal$Compiler$nodify(
					$author$project$Internal$Compiler$formatValue(base)),
				$author$project$Internal$Compiler$nodify(
					$author$project$Internal$Compiler$nodifyAll(
						A2(
							$elm$core$List$map,
							function (_v0) {
								var name = _v0.a;
								var ann = _v0.b;
								return _Utils_Tuple2(
									$author$project$Internal$Compiler$nodify(name),
									$author$project$Internal$Compiler$nodify(
										$author$project$Internal$Compiler$getInnerAnnotation(ann)));
							},
							fields)))),
			a: A2(
				$elm$core$List$concatMap,
				A2($elm$core$Basics$composeR, $elm$core$Tuple$second, $author$project$Internal$Compiler$getAnnotationImports),
				fields)
		};
	});
var $author$project$Elm$Annotation$triple = F3(
	function (one, two, three) {
		return {
			c: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(
				$author$project$Internal$Compiler$nodifyAll(
					_List_fromArray(
						[
							$author$project$Internal$Compiler$getInnerAnnotation(one),
							$author$project$Internal$Compiler$getInnerAnnotation(two),
							$author$project$Internal$Compiler$getInnerAnnotation(three)
						]))),
			a: _Utils_ap(
				$author$project$Internal$Compiler$getAnnotationImports(one),
				_Utils_ap(
					$author$project$Internal$Compiler$getAnnotationImports(two),
					$author$project$Internal$Compiler$getAnnotationImports(three)))
		};
	});
var $author$project$Elm$Annotation$unit = {c: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit, a: _List_Nil};
var $author$project$Elm$Annotation$var = function (a) {
	return {
		c: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(
			$author$project$Internal$Compiler$formatValue(a)),
		a: _List_Nil
	};
};
var $author$project$Generate$typeToAnnotation = function (elmType) {
	switch (elmType.$) {
		case 0:
			var string = elmType.a;
			return $author$project$Elm$Annotation$var(string);
		case 1:
			var one = elmType.a;
			var two = elmType.b;
			return A2(
				$author$project$Elm$Annotation$function,
				_List_fromArray(
					[
						$author$project$Generate$typeToAnnotation(one)
					]),
				$author$project$Generate$typeToAnnotation(two));
		case 2:
			var types = elmType.a;
			_v1$3:
			while (true) {
				if (!types.b) {
					return $author$project$Elm$Annotation$unit;
				} else {
					if (types.b.b) {
						if (!types.b.b.b) {
							var one = types.a;
							var _v2 = types.b;
							var two = _v2.a;
							return A2(
								$author$project$Elm$Annotation$tuple,
								$author$project$Generate$typeToAnnotation(one),
								$author$project$Generate$typeToAnnotation(two));
						} else {
							if (!types.b.b.b.b) {
								var one = types.a;
								var _v3 = types.b;
								var two = _v3.a;
								var _v4 = _v3.b;
								var three = _v4.a;
								return A3(
									$author$project$Elm$Annotation$triple,
									$author$project$Generate$typeToAnnotation(one),
									$author$project$Generate$typeToAnnotation(two),
									$author$project$Generate$typeToAnnotation(three));
							} else {
								break _v1$3;
							}
						}
					} else {
						break _v1$3;
					}
				}
			}
			return $author$project$Elm$Annotation$unit;
		case 3:
			var name = elmType.a;
			var types = elmType.b;
			return A3(
				$author$project$Elm$Annotation$namedWith,
				_List_Nil,
				name,
				A2($elm$core$List$map, $author$project$Generate$typeToAnnotation, types));
		default:
			var fields = elmType.a;
			var maybeExtensible = elmType.b;
			if (maybeExtensible.$ === 1) {
				return $author$project$Elm$Annotation$record(
					A2(
						$elm$core$List$map,
						$elm$core$Tuple$mapSecond($author$project$Generate$typeToAnnotation),
						fields));
			} else {
				var base = maybeExtensible.a;
				return A2(
					$author$project$Elm$Annotation$extensible,
					base,
					A2(
						$elm$core$List$map,
						$elm$core$Tuple$mapSecond($author$project$Generate$typeToAnnotation),
						fields));
			}
	}
};
var $author$project$Elm$valueFrom = F2(
	function (mod, name) {
		return {
			c: $elm$core$Result$Err(_List_Nil),
			b: A2(
				$stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue,
				mod,
				$author$project$Internal$Compiler$sanitize(name)),
			a: _List_fromArray(
				[mod]),
			g: false
		};
	});
var $author$project$Elm$value = $author$project$Elm$valueFrom(_List_Nil);
var $author$project$Generate$getArgumentUnpacker = F3(
	function (freshCount, tipe, value) {
		_v0$3:
		while (true) {
			switch (tipe.$) {
				case 1:
					var one = tipe.a;
					var two = tipe.b;
					var varName = 'lambdaArg' + $elm$core$String$fromInt(freshCount);
					var f = A3(
						$author$project$Generate$getArgumentUnpacker,
						freshCount + 1,
						two,
						A2(
							$author$project$Elm$apply,
							value,
							_List_fromArray(
								[
									$author$project$Elm$value(varName)
								])));
					return A3(
						$author$project$Elm$Gen$Elm$lambda,
						$author$project$Elm$string(varName),
						$author$project$Generate$typeToExpression(one),
						function (arg) {
							return A3(
								$author$project$Elm$lambda,
								varName,
								$author$project$Generate$typeToAnnotation(one),
								function (_v1) {
									return f;
								});
						});
				case 3:
					if (((tipe.a === 'List.List') && tipe.b.b) && (!tipe.b.b.b)) {
						var _v2 = tipe.b;
						var inner = _v2.a;
						var f = A3($author$project$Generate$getArgumentUnpacker, freshCount, inner, value);
						return $author$project$Elm$Gen$Elm$list(f);
					} else {
						break _v0$3;
					}
				case 4:
					if (tipe.b.$ === 1) {
						var fields = tipe.a;
						var _v3 = tipe.b;
						return $author$project$Elm$Gen$Elm$record(
							$author$project$Elm$list(
								A2(
									$elm$core$List$map,
									function (_v4) {
										var fieldName = _v4.a;
										var fieldType = _v4.b;
										return A2(
											$author$project$Elm$Gen$Elm$field,
											$author$project$Elm$string(fieldName),
											A3(
												$author$project$Generate$getArgumentUnpacker,
												freshCount,
												fieldType,
												A2($author$project$Elm$get, fieldName, value)));
									},
									fields)));
					} else {
						break _v0$3;
					}
				default:
					break _v0$3;
			}
		}
		return value;
	});
var $author$project$Generate$asValue = F2(
	function (index, tipe) {
		return A3(
			$author$project$Generate$getArgumentUnpacker,
			0,
			tipe,
			A2(
				$author$project$Elm$valueFrom,
				$author$project$Generate$local,
				$author$project$Generate$argName(index)));
	});
var $author$project$Generate$captureFunction = F2(
	function (tipe, captured) {
		captureFunction:
		while (true) {
			if (tipe.$ === 1) {
				var one = tipe.a;
				var two = tipe.b;
				var $temp$tipe = two,
					$temp$captured = {
					bG: A2(
						$elm$core$List$cons,
						A2($author$project$Generate$asArgument, captured.O, one),
						captured.bG),
					O: captured.O + 1,
					Z: A2(
						$elm$core$List$cons,
						A2($author$project$Generate$asValue, captured.O, one),
						captured.Z)
				};
				tipe = $temp$tipe;
				captured = $temp$captured;
				continue captureFunction;
			} else {
				return {
					bG: A2(
						$elm$core$List$cons,
						A2($author$project$Generate$asArgument, captured.O, tipe),
						captured.bG),
					O: captured.O + 1,
					Z: A2(
						$elm$core$List$cons,
						A2($author$project$Generate$asValue, captured.O, tipe),
						captured.Z)
				};
			}
		}
	});
var $author$project$Elm$functionWith = F3(
	function (name, args, _v0) {
		var body = _v0;
		return A3(
			$author$project$Internal$Compiler$Declaration,
			$author$project$Internal$Compiler$NotExposed,
			_Utils_ap(
				A2(
					$elm$core$List$concatMap,
					A2($elm$core$Basics$composeR, $elm$core$Tuple$first, $author$project$Internal$Compiler$getAnnotationImports),
					args),
				body.a),
			$stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(
				{
					bX: $author$project$Internal$Compiler$nodify(
						{
							bG: $author$project$Internal$Compiler$nodifyAll(
								A2($elm$core$List$map, $elm$core$Tuple$second, args)),
							b: $author$project$Internal$Compiler$nodify(body.b),
							I: $author$project$Internal$Compiler$nodify(
								$author$project$Internal$Compiler$formatValue(name))
						}),
					aw: $author$project$Internal$Compiler$nodifyMaybe($elm$core$Maybe$Nothing),
					db: function () {
						var _v1 = body.c;
						if (!_v1.$) {
							var _return = _v1.a;
							return $elm$core$Maybe$Just(
								$author$project$Internal$Compiler$nodify(
									{
										I: $author$project$Internal$Compiler$nodify(
											$author$project$Internal$Compiler$formatValue(name)),
										aV: $author$project$Internal$Compiler$nodify(
											$author$project$Internal$Compiler$getInnerAnnotation(
												A2(
													$author$project$Elm$Annotation$function,
													A2($elm$core$List$map, $elm$core$Tuple$first, args),
													$author$project$Internal$Compiler$noImports(_return))))
									}));
						} else {
							return $elm$core$Maybe$Nothing;
						}
					}()
				}));
	});
var $stil4m$elm_syntax$Elm$Syntax$Declaration$AliasDeclaration = function (a) {
	return {$: 1, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Declaration$CustomTypeDeclaration = function (a) {
	return {$: 2, a: a};
};
var $author$project$Internal$Compiler$documentation = F2(
	function (doc, decl) {
		if (decl.$ === 1) {
			return decl;
		} else {
			var exp = decl.a;
			var imports = decl.b;
			var body = decl.c;
			var str = '{-|' + (doc + '-}');
			switch (body.$) {
				case 0:
					var func = body.a;
					return A3(
						$author$project$Internal$Compiler$Declaration,
						exp,
						imports,
						$stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(
							_Utils_update(
								func,
								{
									aw: $elm$core$Maybe$Just(
										$author$project$Internal$Compiler$nodify(str))
								})));
				case 1:
					var typealias = body.a;
					return A3(
						$author$project$Internal$Compiler$Declaration,
						exp,
						imports,
						$stil4m$elm_syntax$Elm$Syntax$Declaration$AliasDeclaration(
							_Utils_update(
								typealias,
								{
									aw: $elm$core$Maybe$Just(
										$author$project$Internal$Compiler$nodify(str))
								})));
				case 2:
					var typeDecl = body.a;
					return A3(
						$author$project$Internal$Compiler$Declaration,
						exp,
						imports,
						$stil4m$elm_syntax$Elm$Syntax$Declaration$CustomTypeDeclaration(
							_Utils_update(
								typeDecl,
								{
									aw: $elm$core$Maybe$Just(
										$author$project$Internal$Compiler$nodify(str))
								})));
				case 3:
					var sig = body.a;
					return decl;
				case 4:
					return decl;
				default:
					return decl;
			}
		}
	});
var $author$project$Elm$withDocumentation = $author$project$Internal$Compiler$documentation;
var $author$project$Elm$withType = F2(
	function (ann, _v0) {
		var exp = _v0;
		return _Utils_update(
			exp,
			{
				c: $elm$core$Result$Ok(
					$author$project$Internal$Compiler$getInnerAnnotation(ann)),
				a: _Utils_ap(
					exp.a,
					$author$project$Internal$Compiler$getAnnotationImports(ann))
			});
	});
var $author$project$Generate$generateBlocks = function (block) {
	switch (block.$) {
		case 0:
			var str = block.a;
			return _List_Nil;
		case 1:
			var union = block.a;
			return _List_Nil;
		case 2:
			var alias = block.a;
			return _List_Nil;
		case 3:
			var value = block.a;
			var _v1 = value.aU;
			if (_v1.$ === 1) {
				var one = _v1.a;
				var two = _v1.b;
				var captured = A2(
					$author$project$Generate$captureFunction,
					two,
					{
						bG: _List_fromArray(
							[
								A2($author$project$Generate$asArgument, 1, one)
							]),
						O: 2,
						Z: _List_fromArray(
							[
								A2($author$project$Generate$asValue, 1, one)
							])
					});
				return _List_fromArray(
					[
						$author$project$Elm$expose(
						A2(
							$author$project$Elm$withDocumentation,
							value.aj,
							A3(
								$author$project$Elm$functionWith,
								value.I,
								$elm$core$List$reverse(
									A2($elm$core$List$drop, 1, captured.bG)),
								A2(
									$author$project$Elm$withType,
									$author$project$Generate$expressionType,
									A2(
										$author$project$Generate$apply,
										A3(
											$author$project$Generate$valueWith,
											$author$project$Generate$thisModuleName,
											$author$project$Elm$string(value.I),
											value.aU),
										$elm$core$List$reverse(
											A2($elm$core$List$drop, 1, captured.Z)))))))
					]);
			} else {
				return _List_fromArray(
					[
						$author$project$Elm$expose(
						A2(
							$author$project$Elm$withDocumentation,
							value.aj,
							A2(
								$author$project$Elm$declaration,
								value.I,
								A2(
									$author$project$Elm$withType,
									$author$project$Generate$expressionType,
									A3(
										$author$project$Generate$valueWith,
										$author$project$Generate$thisModuleName,
										$author$project$Elm$string(value.I),
										value.aU)))))
					]);
			}
		case 4:
			var binop = block.a;
			return _List_Nil;
		default:
			var str = block.a;
			return _List_Nil;
	}
};
var $author$project$Elm$lambdaWith = F2(
	function (args, _v0) {
		var expr = _v0;
		return {
			c: function () {
				var _v1 = expr.c;
				if (_v1.$ === 1) {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				} else {
					var _return = _v1.a;
					return $elm$core$Result$Ok(
						A3(
							$elm$core$List$foldr,
							F2(
								function (ann, fnbody) {
									return A2(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
										$author$project$Internal$Compiler$nodify(ann),
										$author$project$Internal$Compiler$nodify(fnbody));
								}),
							_return,
							A2(
								$elm$core$List$map,
								A2($elm$core$Basics$composeL, $author$project$Internal$Compiler$getInnerAnnotation, $elm$core$Tuple$second),
								args)));
				}
			}(),
			b: $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
				{
					aX: $author$project$Internal$Compiler$nodifyAll(
						A2($elm$core$List$map, $elm$core$Tuple$first, args)),
					b: $author$project$Internal$Compiler$nodify(expr.b)
				}),
			a: expr.a,
			g: false
		};
	});
var $author$project$Internal$Compiler$DuplicateFieldInRecord = function (a) {
	return {$: 5, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr = function (a) {
	return {$: 18, a: a};
};
var $author$project$Internal$Compiler$SomeOtherIssue = {$: 1};
var $author$project$Elm$record = function (fields) {
	var unified = A3(
		$elm$core$List$foldl,
		F2(
			function (_v2, found) {
				var unformattedFieldName = _v2.a;
				var exp = _v2.b;
				var fieldName = $author$project$Internal$Compiler$formatValue(unformattedFieldName);
				return {
					S: function () {
						if (A2($elm$core$Set$member, fieldName, found.au)) {
							return A2(
								$elm$core$List$cons,
								$author$project$Internal$Compiler$DuplicateFieldInRecord(fieldName),
								found.S);
						} else {
							var _v3 = exp.c;
							if (_v3.$ === 1) {
								if (!_v3.a.b) {
									return A2($elm$core$List$cons, $author$project$Internal$Compiler$SomeOtherIssue, found.S);
								} else {
									var errs = _v3.a;
									return _Utils_ap(errs, found.S);
								}
							} else {
								var ann = _v3.a;
								return found.S;
							}
						}
					}(),
					an: function () {
						var _v4 = exp.c;
						if (_v4.$ === 1) {
							var err = _v4.a;
							return found.an;
						} else {
							var ann = _v4.a;
							return A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									$author$project$Internal$Compiler$formatValue(fieldName),
									ann),
								found.an);
						}
					}(),
					as: A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							$author$project$Internal$Compiler$nodify(fieldName),
							$author$project$Internal$Compiler$nodify(exp.b)),
						found.as),
					a: _Utils_ap(exp.a, found.a),
					au: A2($elm$core$Set$insert, fieldName, found.au)
				};
			}),
		{S: _List_Nil, an: _List_Nil, as: _List_Nil, a: _List_Nil, au: $elm$core$Set$empty},
		fields);
	return {
		c: function () {
			var _v0 = unified.S;
			if (!_v0.b) {
				return $elm$core$Result$Ok(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(
						$author$project$Internal$Compiler$nodifyAll(
							A2(
								$elm$core$List$map,
								function (_v1) {
									var name = _v1.a;
									var ann = _v1.b;
									return _Utils_Tuple2(
										$author$project$Internal$Compiler$nodify(name),
										$author$project$Internal$Compiler$nodify(ann));
								},
								$elm$core$List$reverse(unified.an)))));
			} else {
				var errs = _v0;
				return $elm$core$Result$Err(errs);
			}
		}(),
		b: $stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr(
			$author$project$Internal$Compiler$nodifyAll(
				$elm$core$List$reverse(unified.as))),
		a: unified.a,
		g: false
	};
};
var $author$project$Generate$generateTypeBuilderRecordHelper = function (block) {
	switch (block.$) {
		case 0:
			var str = block.a;
			return $elm$core$Maybe$Nothing;
		case 1:
			var union = block.a;
			var _v1 = union.dh;
			if (!_v1.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				return $elm$core$Maybe$Just(
					A2(
						$author$project$Elm$field,
						union.I,
						$author$project$Elm$record(
							A2(
								$elm$core$List$map,
								function (_v2) {
									var name = _v2.a;
									var tags = _v2.b;
									if (!tags.b) {
										return A2(
											$author$project$Elm$field,
											name,
											A3(
												$author$project$Generate$valueWith,
												$author$project$Generate$thisModuleName,
												$author$project$Elm$string(name),
												A2(
													$elm$project_metadata_utils$Elm$Type$Type,
													union.I,
													A2($elm$core$List$map, $elm$project_metadata_utils$Elm$Type$Var, union.aX))));
									} else {
										return A2(
											$author$project$Elm$field,
											name,
											A2(
												$author$project$Elm$lambdaWith,
												A2(
													$elm$core$List$indexedMap,
													F2(
														function (i, tag) {
															return _Utils_Tuple2(
																$author$project$Elm$Pattern$var(
																	'ar' + $elm$core$String$fromInt(i)),
																$author$project$Generate$expressionType);
														}),
													tags),
												A2(
													$author$project$Generate$apply,
													A3(
														$author$project$Generate$valueWith,
														$author$project$Generate$thisModuleName,
														$author$project$Elm$string(name),
														A2(
															$elm$project_metadata_utils$Elm$Type$Type,
															union.I,
															A2($elm$core$List$map, $elm$project_metadata_utils$Elm$Type$Var, union.aX))),
													A2(
														$elm$core$List$indexedMap,
														F2(
															function (i, tag) {
																return A2(
																	$author$project$Elm$withType,
																	$author$project$Generate$expressionType,
																	$author$project$Elm$value(
																		'ar' + $elm$core$String$fromInt(i)));
															}),
														tags))));
									}
								},
								union.dh))));
			}
		case 2:
			var alias = block.a;
			return $elm$core$Maybe$Nothing;
		case 3:
			var value = block.a;
			return $elm$core$Maybe$Nothing;
		case 4:
			var binop = block.a;
			return $elm$core$Maybe$Nothing;
		default:
			var str = block.a;
			return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Generate$generateTypeBuilderRecord = F2(
	function (blocks, fields) {
		generateTypeBuilderRecord:
		while (true) {
			if (!blocks.b) {
				return $author$project$Elm$expose(
					A2(
						$author$project$Elm$declaration,
						'make_',
						$author$project$Elm$record(fields)));
			} else {
				var top = blocks.a;
				var remain = blocks.b;
				var _v1 = $author$project$Generate$generateTypeBuilderRecordHelper(top);
				if (_v1.$ === 1) {
					var $temp$blocks = remain,
						$temp$fields = fields;
					blocks = $temp$blocks;
					fields = $temp$fields;
					continue generateTypeBuilderRecord;
				} else {
					var field = _v1.a;
					var $temp$blocks = remain,
						$temp$fields = A2($elm$core$List$cons, field, fields);
					blocks = $temp$blocks;
					fields = $temp$fields;
					continue generateTypeBuilderRecord;
				}
			}
		}
	});
var $author$project$Elm$Gen$Elm$Annotation$named = F2(
	function (arg1, arg2) {
		return A2(
			$author$project$Elm$apply,
			A3(
				$author$project$Elm$valueWith,
				$author$project$Elm$Gen$Elm$Annotation$moduleName_,
				'named',
				A2(
					$author$project$Elm$Annotation$function,
					_List_fromArray(
						[
							$author$project$Elm$Annotation$list($author$project$Elm$Annotation$string),
							$author$project$Elm$Annotation$string
						]),
					A3(
						$author$project$Elm$Annotation$namedWith,
						_List_fromArray(
							['Elm', 'Annotation']),
						'Annotation',
						_List_Nil))),
			_List_fromArray(
				[arg1, arg2]));
	});
var $author$project$Generate$annotationNamed = F2(
	function (name, tags) {
		if (!tags.b) {
			return A2(
				$author$project$Elm$Gen$Elm$Annotation$named,
				$author$project$Generate$thisModuleName,
				$author$project$Elm$string(name));
		} else {
			var nonEmpty = tags;
			return A2(
				$author$project$Elm$lambdaWith,
				A2(
					$elm$core$List$indexedMap,
					F2(
						function (i, arg) {
							return _Utils_Tuple2(
								$author$project$Elm$Pattern$var(
									'arg' + $elm$core$String$fromInt(i)),
								A2($author$project$Elm$Annotation$named, $author$project$Generate$elmAnnotation, 'Annotation'));
						}),
					nonEmpty),
				A3(
					$author$project$Elm$Gen$Elm$Annotation$namedWith,
					$author$project$Generate$thisModuleName,
					$author$project$Elm$string(name),
					$author$project$Elm$list(
						A2(
							$elm$core$List$indexedMap,
							F2(
								function (i, arg) {
									return A2(
										$author$project$Elm$withType,
										A2($author$project$Elm$Annotation$named, $author$project$Generate$elmAnnotation, 'Annotation'),
										$author$project$Elm$value(
											'arg' + $elm$core$String$fromInt(i)));
								}),
							nonEmpty))));
		}
	});
var $author$project$Generate$generateTypeRecordHelper = function (block) {
	switch (block.$) {
		case 0:
			var str = block.a;
			return $elm$core$Maybe$Nothing;
		case 1:
			var union = block.a;
			return $elm$core$Maybe$Just(
				A2(
					$author$project$Elm$field,
					union.I,
					A2($author$project$Generate$annotationNamed, union.I, union.aX)));
		case 2:
			var alias = block.a;
			return $elm$core$Maybe$Just(
				A2(
					$author$project$Elm$field,
					alias.I,
					A2($author$project$Generate$annotationNamed, alias.I, alias.aX)));
		case 3:
			var value = block.a;
			return $elm$core$Maybe$Nothing;
		case 4:
			var binop = block.a;
			return $elm$core$Maybe$Nothing;
		default:
			var str = block.a;
			return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Generate$generateTypeRecord = F2(
	function (blocks, fields) {
		generateTypeRecord:
		while (true) {
			if (!blocks.b) {
				return $author$project$Elm$expose(
					A2(
						$author$project$Elm$declaration,
						'types_',
						$author$project$Elm$record(fields)));
			} else {
				var top = blocks.a;
				var remain = blocks.b;
				var _v1 = $author$project$Generate$generateTypeRecordHelper(top);
				if (_v1.$ === 1) {
					var $temp$blocks = remain,
						$temp$fields = fields;
					blocks = $temp$blocks;
					fields = $temp$fields;
					continue generateTypeRecord;
				} else {
					var field = _v1.a;
					var $temp$blocks = remain,
						$temp$fields = A2($elm$core$List$cons, field, fields);
					blocks = $temp$blocks;
					fields = $temp$fields;
					continue generateTypeRecord;
				}
			}
		}
	});
var $elm$project_metadata_utils$Elm$Docs$MarkdownBlock = function (a) {
	return {$: 0, a: a};
};
var $elm$project_metadata_utils$Elm$Docs$AliasBlock = function (a) {
	return {$: 2, a: a};
};
var $elm$project_metadata_utils$Elm$Docs$BinopBlock = function (a) {
	return {$: 4, a: a};
};
var $elm$project_metadata_utils$Elm$Docs$UnionBlock = function (a) {
	return {$: 1, a: a};
};
var $elm$project_metadata_utils$Elm$Docs$UnknownBlock = function (a) {
	return {$: 5, a: a};
};
var $elm$project_metadata_utils$Elm$Docs$ValueBlock = function (a) {
	return {$: 3, a: a};
};
var $elm$core$String$dropRight = F2(
	function (n, string) {
		return (n < 1) ? string : A3($elm$core$String$slice, 0, -n, string);
	});
var $elm$project_metadata_utils$Elm$Docs$find = F4(
	function (toBlock, name, entries, fallback) {
		find:
		while (true) {
			if (!entries.b) {
				return fallback;
			} else {
				var entry = entries.a;
				var rest = entries.b;
				if (_Utils_eq(entry.I, name)) {
					return toBlock(entry);
				} else {
					var $temp$toBlock = toBlock,
						$temp$name = name,
						$temp$entries = rest,
						$temp$fallback = fallback;
					toBlock = $temp$toBlock;
					name = $temp$name;
					entries = $temp$entries;
					fallback = $temp$fallback;
					continue find;
				}
			}
		}
	});
var $elm$core$String$startsWith = _String_startsWith;
var $elm$project_metadata_utils$Elm$Docs$nameToBlock = F2(
	function (docs, docsName) {
		var name = A2($elm$core$String$startsWith, '(', docsName) ? A2(
			$elm$core$String$dropLeft,
			1,
			A2($elm$core$String$dropRight, 1, docsName)) : docsName;
		return A4(
			$elm$project_metadata_utils$Elm$Docs$find,
			$elm$project_metadata_utils$Elm$Docs$ValueBlock,
			name,
			docs.Z,
			A4(
				$elm$project_metadata_utils$Elm$Docs$find,
				$elm$project_metadata_utils$Elm$Docs$BinopBlock,
				name,
				docs.bI,
				A4(
					$elm$project_metadata_utils$Elm$Docs$find,
					$elm$project_metadata_utils$Elm$Docs$UnionBlock,
					name,
					docs.aq,
					A4(
						$elm$project_metadata_utils$Elm$Docs$find,
						$elm$project_metadata_utils$Elm$Docs$AliasBlock,
						name,
						docs.ah,
						$elm$project_metadata_utils$Elm$Docs$UnknownBlock(name)))));
	});
var $elm$core$String$trim = _String_trim;
var $elm$core$String$trimLeft = _String_trimLeft;
var $elm$core$String$words = _String_words;
var $elm$project_metadata_utils$Elm$Docs$partsToBlocks = F2(
	function (docs, parts) {
		if (!parts.b) {
			return _List_Nil;
		} else {
			var part = parts.a;
			var otherParts = parts.b;
			var _v1 = $elm$core$String$words(
				$elm$core$String$trim(part));
			if (!_v1.b) {
				return _List_fromArray(
					[
						$elm$project_metadata_utils$Elm$Docs$MarkdownBlock(
						A2($elm$core$String$join, ',', parts))
					]);
			} else {
				if (!_v1.b.b) {
					var name = _v1.a;
					return A2(
						$elm$core$List$cons,
						A2($elm$project_metadata_utils$Elm$Docs$nameToBlock, docs, name),
						A2($elm$project_metadata_utils$Elm$Docs$partsToBlocks, docs, otherParts));
				} else {
					var name = _v1.a;
					return _List_fromArray(
						[
							A2($elm$project_metadata_utils$Elm$Docs$nameToBlock, docs, name),
							$elm$project_metadata_utils$Elm$Docs$MarkdownBlock(
							A2(
								$elm$core$String$join,
								',',
								A2(
									$elm$core$List$cons,
									A2(
										$elm$core$String$dropLeft,
										$elm$core$String$length(name),
										$elm$core$String$trimLeft(part)),
									otherParts)))
						]);
				}
			}
		}
	});
var $elm$project_metadata_utils$Elm$Docs$chunkToBlocks = F2(
	function (docs, chunk) {
		return A2(
			$elm$project_metadata_utils$Elm$Docs$partsToBlocks,
			docs,
			A2($elm$core$String$split, ',', chunk));
	});
var $elm$project_metadata_utils$Elm$Docs$toBlocks = function (docs) {
	var _v0 = A2($elm$core$String$split, '\n@docs ', docs.aj);
	if (!_v0.b) {
		return _List_Nil;
	} else {
		var firstMarkdown = _v0.a;
		var docsChunks = _v0.b;
		return A2(
			$elm$core$List$cons,
			$elm$project_metadata_utils$Elm$Docs$MarkdownBlock(firstMarkdown),
			A2(
				$elm$core$List$concatMap,
				$elm$project_metadata_utils$Elm$Docs$chunkToBlocks(docs),
				docsChunks));
	}
};
var $author$project$Generate$moduleToFile = function (docs) {
	var sourceModName = A2($elm$core$String$split, '.', docs.I);
	var modNameBlock = $author$project$Elm$expose(
		A2(
			$author$project$Elm$withDocumentation,
			' The name of this module. ',
			A2(
				$author$project$Elm$declaration,
				'moduleName_',
				$author$project$Elm$list(
					A2($elm$core$List$map, $author$project$Elm$string, sourceModName)))));
	var modName = A2(
		$elm$core$List$cons,
		'Elm',
		A2($elm$core$List$cons, 'Gen', sourceModName));
	var blocks = $elm$project_metadata_utils$Elm$Docs$toBlocks(docs);
	var ids = $author$project$Elm$expose(
		A2(
			$author$project$Elm$withDocumentation,
			' Every value/function in this module in case you need to refer to it directly. ',
			A2(
				$author$project$Elm$declaration,
				'id_',
				$author$project$Elm$record(
					A2($elm$core$List$filterMap, $author$project$Generate$blockToIdField, blocks)))));
	return A3(
		$author$project$Elm$fileWith,
		modName,
		{
			ah: _List_fromArray(
				[
					_Utils_Tuple2(
					_List_fromArray(
						['Elm', 'Annotation']),
					'Type')
				]),
			b3: function (docGroups) {
				return '';
			}
		},
		A2(
			$elm$core$List$cons,
			modNameBlock,
			A2(
				$elm$core$List$cons,
				A2($author$project$Generate$generateTypeRecord, blocks, _List_Nil),
				A2(
					$elm$core$List$cons,
					A2($author$project$Generate$generateTypeBuilderRecord, blocks, _List_Nil),
					_Utils_ap(
						A2($elm$core$List$concatMap, $author$project$Generate$generateBlocks, blocks),
						_List_fromArray(
							[ids]))))));
};
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $elm$core$Platform$Sub$none = $elm$core$Platform$Sub$batch(_List_Nil);
var $stil4m$elm_syntax$Elm$Processing$ProcessContext = $elm$core$Basics$identity;
var $stil4m$elm_syntax$Elm$Processing$init = $elm$core$Dict$empty;
var $stil4m$elm_syntax$Elm$Parser$State$State = $elm$core$Basics$identity;
var $stil4m$elm_syntax$Elm$Parser$State$emptyState = {a$: _List_Nil, T: _List_Nil};
var $stil4m$elm_syntax$Elm$Syntax$File$File = F4(
	function (moduleDefinition, imports, declarations, comments) {
		return {a$: comments, b_: declarations, a: imports, cO: moduleDefinition};
	});
var $stil4m$elm_syntax$Combine$Parser = $elm$core$Basics$identity;
var $stil4m$elm_syntax$Combine$andMap = F2(
	function (_v0, _v1) {
		var rp = _v0;
		var lp = _v1;
		return function (state) {
			return A2(
				$elm$parser$Parser$andThen,
				function (_v2) {
					var newState = _v2.a;
					var a = _v2.b;
					return A2(
						$elm$parser$Parser$map,
						$elm$core$Tuple$mapSecond(a),
						rp(newState));
				},
				lp(state));
		};
	});
var $stil4m$elm_syntax$Elm$Parser$State$getComments = function (_v0) {
	var s = _v0;
	return $elm$core$List$reverse(s.a$);
};
var $stil4m$elm_syntax$Combine$succeed = function (res) {
	return function (state) {
		return $elm$parser$Parser$succeed(
			_Utils_Tuple2(state, res));
	};
};
var $stil4m$elm_syntax$Combine$withState = function (f) {
	return function (state) {
		return function (_v0) {
			var p = _v0;
			return p(state);
		}(
			f(state));
	};
};
var $stil4m$elm_syntax$Elm$Parser$File$collectComments = $stil4m$elm_syntax$Combine$withState(
	A2($elm$core$Basics$composeR, $stil4m$elm_syntax$Elm$Parser$State$getComments, $stil4m$elm_syntax$Combine$succeed));
var $stil4m$elm_syntax$Combine$choice = function (xs) {
	return function (state) {
		return $elm$parser$Parser$oneOf(
			A2(
				$elm$core$List$map,
				function (_v0) {
					var x = _v0;
					return x(state);
				},
				xs));
	};
};
var $stil4m$elm_syntax$Elm$Syntax$Declaration$Destructuring = F2(
	function (a, b) {
		return {$: 5, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Range$Range = F2(
	function (start, end) {
		return {a6: end, br: start};
	});
var $elm$core$Maybe$map2 = F3(
	function (func, ma, mb) {
		if (ma.$ === 1) {
			return $elm$core$Maybe$Nothing;
		} else {
			var a = ma.a;
			if (mb.$ === 1) {
				return $elm$core$Maybe$Nothing;
			} else {
				var b = mb.a;
				return $elm$core$Maybe$Just(
					A2(func, a, b));
			}
		}
	});
var $stil4m$elm_syntax$Elm$Syntax$Range$compareLocations = F2(
	function (left, right) {
		return (_Utils_cmp(left.bo, right.bo) < 0) ? 0 : ((_Utils_cmp(left.bo, right.bo) > 0) ? 2 : A2($elm$core$Basics$compare, left.bP, right.bP));
	});
var $stil4m$elm_syntax$Elm$Syntax$Range$sortLocations = $elm$core$List$sortWith($stil4m$elm_syntax$Elm$Syntax$Range$compareLocations);
var $stil4m$elm_syntax$Elm$Syntax$Range$combine = function (ranges) {
	var starts = $stil4m$elm_syntax$Elm$Syntax$Range$sortLocations(
		A2(
			$elm$core$List$map,
			function ($) {
				return $.br;
			},
			ranges));
	var ends = $elm$core$List$reverse(
		$stil4m$elm_syntax$Elm$Syntax$Range$sortLocations(
			A2(
				$elm$core$List$map,
				function ($) {
					return $.a6;
				},
				ranges)));
	return A2(
		$elm$core$Maybe$withDefault,
		$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
		A3(
			$elm$core$Maybe$map2,
			$stil4m$elm_syntax$Elm$Syntax$Range$Range,
			$elm$core$List$head(starts),
			$elm$core$List$head(ends)));
};
var $stil4m$elm_syntax$Elm$Syntax$Node$combine = F3(
	function (f, a, b) {
		var r1 = a.a;
		var r2 = b.a;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$combine(
				_List_fromArray(
					[r1, r2])),
			A2(f, a, b));
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$CaseBlock = F2(
	function (expression, cases) {
		return {ai: cases, b: expression};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$CaseExpression = function (a) {
	return {$: 16, a: a};
};
var $stil4m$elm_syntax$Combine$Done = function (a) {
	return {$: 1, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$Function = F3(
	function (documentation, signature, declaration) {
		return {bX: declaration, aw: documentation, db: signature};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$FunctionImplementation = F3(
	function (name, _arguments, expression) {
		return {bG: _arguments, b: expression, I: name};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$IfBlock = F3(
	function (a, b, c) {
		return {$: 4, a: a, b: b, c: c};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$Lambda = F2(
	function (args, expression) {
		return {aX: args, b: expression};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$LetBlock = F2(
	function (declarations, expression) {
		return {b_: declarations, b: expression};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$LetDestructuring = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$LetExpression = function (a) {
	return {$: 15, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$LetFunction = function (a) {
	return {$: 0, a: a};
};
var $stil4m$elm_syntax$Combine$Loop = function (a) {
	return {$: 0, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$Negation = function (a) {
	return {$: 10, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$Operator = function (a) {
	return {$: 6, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$PrefixOperator = function (a) {
	return {$: 5, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$RecordUpdateExpression = F2(
	function (a, b) {
		return {$: 22, a: a, b: b};
	});
var $stil4m$elm_syntax$Combine$andThen = F2(
	function (f, _v0) {
		var p = _v0;
		return function (state) {
			return A2(
				$elm$parser$Parser$andThen,
				function (_v1) {
					var s = _v1.a;
					var a = _v1.b;
					return function (_v2) {
						var x = _v2;
						return x(s);
					}(
						f(a));
				},
				p(state));
		};
	});
var $stil4m$elm_syntax$Combine$backtrackable = function (_v0) {
	var p = _v0;
	return function (state) {
		return $elm$parser$Parser$backtrackable(
			p(state));
	};
};
var $elm$parser$Parser$token = function (str) {
	return $elm$parser$Parser$Advanced$token(
		$elm$parser$Parser$toToken(str));
};
var $stil4m$elm_syntax$Combine$string = function (s) {
	return function (state) {
		return A2(
			$elm$parser$Parser$map,
			function (x) {
				return _Utils_Tuple2(state, x);
			},
			$elm$parser$Parser$getChompedString(
				$elm$parser$Parser$token(s)));
	};
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$caseToken = $stil4m$elm_syntax$Combine$string('case');
var $stil4m$elm_syntax$Elm$Syntax$Expression$CharLiteral = function (a) {
	return {$: 12, a: a};
};
var $elm$parser$Parser$Problem = function (a) {
	return {$: 12, a: a};
};
var $elm$parser$Parser$Advanced$problem = function (x) {
	return function (s) {
		return A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A2($elm$parser$Parser$Advanced$fromState, s, x));
	};
};
var $elm$parser$Parser$problem = function (msg) {
	return $elm$parser$Parser$Advanced$problem(
		$elm$parser$Parser$Problem(msg));
};
var $stil4m$elm_syntax$Combine$fail = function (m) {
	return function (state) {
		return A2(
			$elm$parser$Parser$map,
			function (x) {
				return _Utils_Tuple2(state, x);
			},
			$elm$parser$Parser$problem(m));
	};
};
var $elm$parser$Parser$UnexpectedChar = {$: 11};
var $elm$parser$Parser$Advanced$chompIf = F2(
	function (isGood, expecting) {
		return function (s) {
			var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, s.e, s.d);
			return _Utils_eq(newOffset, -1) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : (_Utils_eq(newOffset, -2) ? A3(
				$elm$parser$Parser$Advanced$Good,
				true,
				0,
				{a_: 1, f: s.f, h: s.h, e: s.e + 1, bo: s.bo + 1, d: s.d}) : A3(
				$elm$parser$Parser$Advanced$Good,
				true,
				0,
				{a_: s.a_ + 1, f: s.f, h: s.h, e: newOffset, bo: s.bo, d: s.d}));
		};
	});
var $elm$parser$Parser$chompIf = function (isGood) {
	return A2($elm$parser$Parser$Advanced$chompIf, isGood, $elm$parser$Parser$UnexpectedChar);
};
var $stil4m$elm_syntax$Combine$fromCore = function (p) {
	return function (state) {
		return A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(
				function (v) {
					return _Utils_Tuple2(state, v);
				}),
			p);
	};
};
var $elm$core$String$foldr = _String_foldr;
var $elm$core$String$toList = function (string) {
	return A3($elm$core$String$foldr, $elm$core$List$cons, _List_Nil, string);
};
var $stil4m$elm_syntax$Combine$Char$satisfy = function (pred) {
	return $stil4m$elm_syntax$Combine$fromCore(
		A2(
			$elm$parser$Parser$andThen,
			function (s) {
				var _v0 = $elm$core$String$toList(s);
				if (!_v0.b) {
					return $elm$parser$Parser$succeed($elm$core$Maybe$Nothing);
				} else {
					var c = _v0.a;
					return $elm$parser$Parser$succeed(
						$elm$core$Maybe$Just(c));
				}
			},
			$elm$parser$Parser$getChompedString(
				$elm$parser$Parser$chompIf(pred))));
};
var $stil4m$elm_syntax$Combine$Char$anyChar = A2(
	$stil4m$elm_syntax$Combine$andThen,
	A2(
		$elm$core$Basics$composeR,
		$elm$core$Maybe$map($stil4m$elm_syntax$Combine$succeed),
		$elm$core$Maybe$withDefault(
			$stil4m$elm_syntax$Combine$fail('expected any character'))),
	$stil4m$elm_syntax$Combine$Char$satisfy(
		$elm$core$Basics$always(true)));
var $stil4m$elm_syntax$Combine$Char$char = function (c) {
	return A2(
		$stil4m$elm_syntax$Combine$andThen,
		A2(
			$elm$core$Basics$composeR,
			$elm$core$Maybe$map($stil4m$elm_syntax$Combine$succeed),
			$elm$core$Maybe$withDefault(
				$stil4m$elm_syntax$Combine$fail(
					'expected \'' + ($elm$core$String$fromList(
						_List_fromArray(
							[c])) + '\'')))),
		$stil4m$elm_syntax$Combine$Char$satisfy(
			$elm$core$Basics$eq(c)));
};
var $stil4m$elm_syntax$Combine$map = F2(
	function (f, _v0) {
		var p = _v0;
		return function (state) {
			return A2(
				$elm$parser$Parser$map,
				function (_v1) {
					var s = _v1.a;
					var a = _v1.b;
					return _Utils_Tuple2(
						s,
						f(a));
				},
				p(state));
		};
	});
var $stil4m$elm_syntax$Combine$continueWith = F2(
	function (target, dropped) {
		return A2(
			$stil4m$elm_syntax$Combine$andMap,
			target,
			A2(
				$stil4m$elm_syntax$Combine$map,
				F2(
					function (b, a) {
						return A2($elm$core$Basics$always, a, b);
					}),
				dropped));
	});
var $stil4m$elm_syntax$Combine$ignore = F2(
	function (dropped, target) {
		return A2(
			$stil4m$elm_syntax$Combine$andMap,
			dropped,
			A2($stil4m$elm_syntax$Combine$map, $elm$core$Basics$always, target));
	});
var $stil4m$elm_syntax$Combine$or = F2(
	function (_v0, _v1) {
		var lp = _v0;
		var rp = _v1;
		return function (state) {
			return $elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						lp(state),
						rp(state)
					]));
		};
	});
var $elm$core$String$any = _String_any;
var $elm$core$Char$fromCode = _Char_fromCode;
var $elm$core$Basics$pow = _Basics_pow;
var $rtfeldman$elm_hex$Hex$fromStringHelp = F3(
	function (position, chars, accumulated) {
		fromStringHelp:
		while (true) {
			if (!chars.b) {
				return $elm$core$Result$Ok(accumulated);
			} else {
				var _char = chars.a;
				var rest = chars.b;
				switch (_char) {
					case '0':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated;
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '1':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + A2($elm$core$Basics$pow, 16, position);
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '2':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (2 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '3':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (3 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '4':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (4 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '5':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (5 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '6':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (6 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '7':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (7 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '8':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (8 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case '9':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (9 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case 'a':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (10 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case 'b':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (11 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case 'c':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (12 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case 'd':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (13 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case 'e':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (14 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					case 'f':
						var $temp$position = position - 1,
							$temp$chars = rest,
							$temp$accumulated = accumulated + (15 * A2($elm$core$Basics$pow, 16, position));
						position = $temp$position;
						chars = $temp$chars;
						accumulated = $temp$accumulated;
						continue fromStringHelp;
					default:
						var nonHex = _char;
						return $elm$core$Result$Err(
							$elm$core$String$fromChar(nonHex) + ' is not a valid hexadecimal character.');
				}
			}
		}
	});
var $elm$core$Result$mapError = F2(
	function (f, result) {
		if (!result.$) {
			var v = result.a;
			return $elm$core$Result$Ok(v);
		} else {
			var e = result.a;
			return $elm$core$Result$Err(
				f(e));
		}
	});
var $elm$core$List$tail = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(xs);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $rtfeldman$elm_hex$Hex$fromString = function (str) {
	if ($elm$core$String$isEmpty(str)) {
		return $elm$core$Result$Err('Empty strings are not valid hexadecimal strings.');
	} else {
		var result = function () {
			if (A2($elm$core$String$startsWith, '-', str)) {
				var list = A2(
					$elm$core$Maybe$withDefault,
					_List_Nil,
					$elm$core$List$tail(
						$elm$core$String$toList(str)));
				return A2(
					$elm$core$Result$map,
					$elm$core$Basics$negate,
					A3(
						$rtfeldman$elm_hex$Hex$fromStringHelp,
						$elm$core$List$length(list) - 1,
						list,
						0));
			} else {
				return A3(
					$rtfeldman$elm_hex$Hex$fromStringHelp,
					$elm$core$String$length(str) - 1,
					$elm$core$String$toList(str),
					0);
			}
		}();
		var formatError = function (err) {
			return A2(
				$elm$core$String$join,
				' ',
				_List_fromArray(
					['\"' + (str + '\"'), 'is not a valid hexadecimal string because', err]));
		};
		return A2($elm$core$Result$mapError, formatError, result);
	}
};
var $elm$core$Result$withDefault = F2(
	function (def, result) {
		if (!result.$) {
			var a = result.a;
			return a;
		} else {
			return def;
		}
	});
var $stil4m$elm_syntax$Elm$Parser$Tokens$escapedCharValue = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed('\''),
			$elm$parser$Parser$symbol('\'')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed('\"'),
			$elm$parser$Parser$symbol('\"')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed('\n'),
			$elm$parser$Parser$symbol('n')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed('\t'),
			$elm$parser$Parser$symbol('t')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed('\u000D'),
			$elm$parser$Parser$symbol('r')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed('\\'),
			$elm$parser$Parser$symbol('\\')),
			A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(
						A2(
							$elm$core$Basics$composeR,
							$elm$core$String$toLower,
							A2(
								$elm$core$Basics$composeR,
								$rtfeldman$elm_hex$Hex$fromString,
								A2(
									$elm$core$Basics$composeR,
									$elm$core$Result$withDefault(0),
									$elm$core$Char$fromCode)))),
					$elm$parser$Parser$symbol('u')),
				$elm$parser$Parser$symbol('{')),
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$getChompedString(
					$elm$parser$Parser$chompWhile(
						function (c) {
							return A2(
								$elm$core$String$any,
								$elm$core$Basics$eq(c),
								'0123456789ABCDEFabcdef');
						})),
				$elm$parser$Parser$symbol('}')))
		]));
var $elm$core$List$singleton = function (value) {
	return _List_fromArray(
		[value]);
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$quotedSingleQuote = $stil4m$elm_syntax$Combine$fromCore(
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed(
				A2(
					$elm$core$Basics$composeR,
					$elm$core$String$toList,
					A2(
						$elm$core$Basics$composeR,
						$elm$core$List$head,
						$elm$core$Maybe$withDefault(' ')))),
			$elm$parser$Parser$symbol('\'')),
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed(
								A2($elm$core$Basics$composeR, $elm$core$List$singleton, $elm$core$String$fromList)),
							$elm$parser$Parser$symbol('\\')),
						$stil4m$elm_syntax$Elm$Parser$Tokens$escapedCharValue),
						$elm$parser$Parser$getChompedString(
						$elm$parser$Parser$chompIf(
							$elm$core$Basics$always(true)))
					])),
			$elm$parser$Parser$symbol('\''))));
var $stil4m$elm_syntax$Elm$Parser$Tokens$characterLiteral = A2(
	$stil4m$elm_syntax$Combine$or,
	$stil4m$elm_syntax$Elm$Parser$Tokens$quotedSingleQuote,
	A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Combine$Char$char('\''),
		A2(
			$stil4m$elm_syntax$Combine$continueWith,
			$stil4m$elm_syntax$Combine$Char$anyChar,
			$stil4m$elm_syntax$Combine$Char$char('\''))));
var $stil4m$elm_syntax$Elm$Parser$Node$asPointerLocation = function (_v0) {
	var line = _v0.ap;
	var column = _v0.bP;
	return {bP: column, bo: line};
};
var $stil4m$elm_syntax$Combine$app = function (_v0) {
	var inner = _v0;
	return inner;
};
var $elm$parser$Parser$Advanced$getPosition = function (s) {
	return A3(
		$elm$parser$Parser$Advanced$Good,
		false,
		_Utils_Tuple2(s.bo, s.a_),
		s);
};
var $elm$parser$Parser$getPosition = $elm$parser$Parser$Advanced$getPosition;
var $stil4m$elm_syntax$Combine$withLocation = function (f) {
	return function (state) {
		return A2(
			$elm$parser$Parser$andThen,
			function (loc) {
				return A2(
					$stil4m$elm_syntax$Combine$app,
					f(loc),
					state);
			},
			A2(
				$elm$parser$Parser$map,
				function (_v0) {
					var row = _v0.a;
					var col = _v0.b;
					return {bP: col, ap: row};
				},
				$elm$parser$Parser$getPosition));
	};
};
var $stil4m$elm_syntax$Elm$Parser$Node$parser = function (p) {
	return $stil4m$elm_syntax$Combine$withLocation(
		function (start) {
			return A2(
				$stil4m$elm_syntax$Combine$andMap,
				$stil4m$elm_syntax$Combine$withLocation(
					function (end) {
						return $stil4m$elm_syntax$Combine$succeed(
							{
								a6: $stil4m$elm_syntax$Elm$Parser$Node$asPointerLocation(end),
								br: $stil4m$elm_syntax$Elm$Parser$Node$asPointerLocation(start)
							});
					}),
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					p,
					$stil4m$elm_syntax$Combine$succeed(
						F2(
							function (v, r) {
								return A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, v);
							}))));
		});
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$charLiteralExpression = $stil4m$elm_syntax$Elm$Parser$Node$parser(
	A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Expression$CharLiteral, $stil4m$elm_syntax$Elm$Parser$Tokens$characterLiteral));
var $stil4m$elm_syntax$Elm$Parser$Tokens$elseToken = $stil4m$elm_syntax$Combine$string('else');
var $stil4m$elm_syntax$Elm$Parser$State$currentIndent = function (_v0) {
	var indents = _v0.T;
	return A2(
		$elm$core$Maybe$withDefault,
		0,
		$elm$core$List$head(indents));
};
var $stil4m$elm_syntax$Elm$Parser$State$expectedColumn = A2(
	$elm$core$Basics$composeR,
	$stil4m$elm_syntax$Elm$Parser$State$currentIndent,
	$elm$core$Basics$add(1));
var $stil4m$elm_syntax$Elm$Syntax$Pattern$AllPattern = {$: 0};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$AsPattern = F2(
	function (a, b) {
		return {$: 13, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Pattern$CharPattern = function (a) {
	return {$: 2, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$ListPattern = function (a) {
	return {$: 10, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$NamedPattern = F2(
	function (a, b) {
		return {$: 12, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Pattern$QualifiedNameRef = F2(
	function (moduleName, name) {
		return {ay: moduleName, I: name};
	});
var $stil4m$elm_syntax$Elm$Syntax$Pattern$StringPattern = function (a) {
	return {$: 3, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$TuplePattern = function (a) {
	return {$: 7, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$UnConsPattern = F2(
	function (a, b) {
		return {$: 9, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Pattern$UnitPattern = {$: 1};
var $stil4m$elm_syntax$Combine$between = F3(
	function (lp, rp, p) {
		return A2(
			$stil4m$elm_syntax$Combine$ignore,
			rp,
			A2($stil4m$elm_syntax$Combine$continueWith, p, lp));
	});
var $elm$core$Set$fromList = function (list) {
	return A3($elm$core$List$foldl, $elm$core$Set$insert, $elm$core$Set$empty, list);
};
var $elm$core$Basics$ge = _Utils_ge;
var $miniBill$elm_unicode$Unicode$isAlphaNum = function (c) {
	var code = $elm$core$Char$toCode(c);
	return (code < 256) ? (((code >= 48) && (code <= 57)) || (((code >= 65) && (code <= 90)) || (((code >= 97) && (code <= 122)) || ((code === 170) || (((code >= 178) && (code <= 179)) || ((code === 181) || (((code >= 185) && (code <= 186)) || (((code >= 188) && (code <= 190)) || (((code >= 192) && (code <= 214)) || (((code >= 216) && (code <= 246)) || ((code >= 248) && (code <= 255)))))))))))) : ((code < 42785) ? ((code < 4303) ? ((code < 2748) ? ((code < 1983) ? ((code < 1375) ? ((code < 894) ? (((code >= 256) && (code <= 705)) || (((code >= 710) && (code <= 721)) || (((code >= 736) && (code <= 740)) || (((code >= 880) && (code <= 884)) || (((code >= 886) && (code <= 887)) || (((code >= 890) && (code <= 893)) || ((!A2($elm$core$Basics$modBy, 2, code)) && ((code >= 748) && (code <= 750))))))))) : ((code === 895) || ((code === 902) || (((code >= 904) && (code <= 1013)) || (((code >= 1015) && (code <= 1153)) || (((code >= 1162) && (code <= 1327)) || (((code >= 1329) && (code <= 1366)) || (code === 1369)))))))) : ((code < 1764) ? (((code >= 1376) && (code <= 1416)) || (((code >= 1488) && (code <= 1522)) || (((code >= 1568) && (code <= 1610)) || (((code >= 1632) && (code <= 1641)) || (((code >= 1646) && (code <= 1647)) || (((code >= 1649) && (code <= 1747)) || (code === 1749))))))) : (((code >= 1765) && (code <= 1766)) || (((code >= 1774) && (code <= 1788)) || ((code === 1791) || ((code === 1808) || (((code >= 1810) && (code <= 1839)) || (((code >= 1869) && (code <= 1957)) || (code === 1969))))))))) : ((code < 2405) ? ((code < 2087) ? (((code >= 1984) && (code <= 2026)) || (((code >= 2036) && (code <= 2037)) || ((code === 2042) || (((code >= 2048) && (code <= 2069)) || ((code === 2074) || (code === 2084)))))) : ((code === 2088) || (((code >= 2112) && (code <= 2136)) || (((code >= 2144) && (code <= 2247)) || (((code >= 2308) && (code <= 2361)) || ((code === 2365) || ((code === 2384) || ((code >= 2392) && (code <= 2401))))))))) : ((code < 2547) ? (((code >= 2406) && (code <= 2415)) || (((code >= 2417) && (code <= 2432)) || (((code >= 2437) && (code <= 2489)) || ((code === 2493) || ((code === 2510) || (((code >= 2524) && (code <= 2529)) || ((code >= 2534) && (code <= 2545)))))))) : (((code >= 2548) && (code <= 2553)) || ((code === 2556) || (((code >= 2565) && (code <= 2617)) || (((code >= 2649) && (code <= 2654)) || (((code >= 2662) && (code <= 2671)) || (((code >= 2674) && (code <= 2676)) || ((code >= 2693) && (code <= 2745))))))))))) : ((code < 3429) ? ((code < 3159) ? ((code < 2907) ? ((code === 2749) || (((code >= 2768) && (code <= 2785)) || (((code >= 2790) && (code <= 2799)) || ((code === 2809) || (((code >= 2821) && (code <= 2873)) || (code === 2877)))))) : (((code >= 2908) && (code <= 2913)) || (((code >= 2918) && (code <= 2927)) || (((code >= 2929) && (code <= 2935)) || (((code >= 2947) && (code <= 3001)) || ((code === 3024) || (((code >= 3046) && (code <= 3058)) || ((code >= 3077) && (code <= 3133))))))))) : ((code < 3301) ? (((code >= 3160) && (code <= 3169)) || (((code >= 3174) && (code <= 3183)) || (((code >= 3192) && (code <= 3198)) || ((code === 3200) || (((code >= 3205) && (code <= 3257)) || ((code === 3261) || ((code >= 3294) && (code <= 3297)))))))) : (((code >= 3302) && (code <= 3311)) || (((code >= 3313) && (code <= 3314)) || (((code >= 3332) && (code <= 3386)) || ((code === 3389) || ((code === 3406) || (((code >= 3412) && (code <= 3414)) || ((code >= 3416) && (code <= 3425)))))))))) : ((code < 3871) ? ((code < 3663) ? (((code >= 3430) && (code <= 3448)) || (((code >= 3450) && (code <= 3455)) || (((code >= 3461) && (code <= 3526)) || (((code >= 3558) && (code <= 3567)) || (((code >= 3585) && (code <= 3632)) || (((code >= 3634) && (code <= 3635)) || ((code >= 3648) && (code <= 3654)))))))) : (((code >= 3664) && (code <= 3673)) || (((code >= 3713) && (code <= 3760)) || (((code >= 3762) && (code <= 3763)) || (((code >= 3773) && (code <= 3780)) || ((code === 3782) || (((code >= 3792) && (code <= 3801)) || ((code >= 3804) && (code <= 3840))))))))) : ((code < 4192) ? (((code >= 3872) && (code <= 3891)) || (((code >= 3904) && (code <= 3948)) || (((code >= 3976) && (code <= 3980)) || (((code >= 4096) && (code <= 4138)) || (((code >= 4159) && (code <= 4169)) || (((code >= 4176) && (code <= 4181)) || ((code >= 4186) && (code <= 4189)))))))) : ((code === 4193) || (((code >= 4197) && (code <= 4198)) || (((code >= 4206) && (code <= 4208)) || (((code >= 4213) && (code <= 4225)) || ((code === 4238) || (((code >= 4240) && (code <= 4249)) || ((code >= 4256) && (code <= 4301)))))))))))) : ((code < 8177) ? ((code < 6783) ? ((code < 5983) ? ((code < 5120) ? (((code >= 4304) && (code <= 4346)) || (((code >= 4348) && (code <= 4954)) || (((code >= 4969) && (code <= 4988)) || (((code >= 4992) && (code <= 5007)) || (((code >= 5024) && (code <= 5109)) || ((code >= 5112) && (code <= 5117))))))) : (((code >= 5121) && (code <= 5740)) || (((code >= 5743) && (code <= 5759)) || (((code >= 5761) && (code <= 5786)) || (((code >= 5792) && (code <= 5866)) || (((code >= 5870) && (code <= 5905)) || (((code >= 5920) && (code <= 5937)) || ((code >= 5952) && (code <= 5969))))))))) : ((code < 6175) ? (((code >= 5984) && (code <= 6000)) || (((code >= 6016) && (code <= 6067)) || ((code === 6103) || ((code === 6108) || (((code >= 6112) && (code <= 6121)) || (((code >= 6128) && (code <= 6137)) || ((code >= 6160) && (code <= 6169)))))))) : (((code >= 6176) && (code <= 6276)) || (((code >= 6279) && (code <= 6312)) || (((code >= 6314) && (code <= 6430)) || (((code >= 6470) && (code <= 6601)) || (((code >= 6608) && (code <= 6618)) || (((code >= 6656) && (code <= 6678)) || ((code >= 6688) && (code <= 6740)))))))))) : ((code < 7405) ? ((code < 7085) ? (((code >= 6784) && (code <= 6809)) || ((code === 6823) || (((code >= 6917) && (code <= 6963)) || (((code >= 6981) && (code <= 6987)) || (((code >= 6992) && (code <= 7001)) || ((code >= 7043) && (code <= 7072))))))) : (((code >= 7086) && (code <= 7141)) || (((code >= 7168) && (code <= 7203)) || (((code >= 7232) && (code <= 7241)) || (((code >= 7245) && (code <= 7293)) || (((code >= 7296) && (code <= 7304)) || (((code >= 7312) && (code <= 7359)) || ((code >= 7401) && (code <= 7404))))))))) : ((code < 8007) ? (((code >= 7406) && (code <= 7411)) || (((code >= 7413) && (code <= 7414)) || ((code === 7418) || (((code >= 7424) && (code <= 7615)) || (((code >= 7680) && (code <= 7957)) || (((code >= 7960) && (code <= 7965)) || ((code >= 7968) && (code <= 8005)))))))) : (((code >= 8008) && (code <= 8013)) || (((code >= 8016) && (code <= 8023)) || (((code >= 8025) && (code <= 8124)) || ((code === 8126) || (((code >= 8130) && (code <= 8140)) || (((code >= 8144) && (code <= 8155)) || ((code >= 8160) && (code <= 8172))))))))))) : ((code < 11630) ? ((code < 8516) ? ((code < 8454) ? (((code >= 8178) && (code <= 8188)) || (((code >= 8304) && (code <= 8305)) || (((code >= 8308) && (code <= 8313)) || (((code >= 8319) && (code <= 8329)) || (((code >= 8336) && (code <= 8348)) || (code === 8450)))))) : ((code === 8455) || (((code >= 8458) && (code <= 8467)) || ((code === 8469) || (((code >= 8473) && (code <= 8477)) || (((code >= 8490) && (code <= 8493)) || (((code >= 8495) && (code <= 8505)) || (((code >= 8508) && (code <= 8511)) || ((!A2($elm$core$Basics$modBy, 2, code)) && ((code >= 8484) && (code <= 8488))))))))))) : ((code < 11311) ? (((code >= 8517) && (code <= 8521)) || ((code === 8526) || (((code >= 8528) && (code <= 8585)) || (((code >= 9312) && (code <= 9371)) || (((code >= 9450) && (code <= 9471)) || (((code >= 10102) && (code <= 10131)) || ((code >= 11264) && (code <= 11310)))))))) : (((code >= 11312) && (code <= 11358)) || (((code >= 11360) && (code <= 11492)) || (((code >= 11499) && (code <= 11502)) || (((code >= 11506) && (code <= 11507)) || ((code === 11517) || (((code >= 11520) && (code <= 11565)) || ((code >= 11568) && (code <= 11623)))))))))) : ((code < 12831) ? ((code < 12352) ? ((code === 11631) || (((code >= 11648) && (code <= 11742)) || ((code === 11823) || (((code >= 12293) && (code <= 12295)) || (((code >= 12321) && (code <= 12329)) || (((code >= 12337) && (code <= 12341)) || ((code >= 12344) && (code <= 12348)))))))) : (((code >= 12353) && (code <= 12438)) || (((code >= 12445) && (code <= 12447)) || (((code >= 12449) && (code <= 12538)) || (((code >= 12540) && (code <= 12686)) || (((code >= 12690) && (code <= 12693)) || (((code >= 12704) && (code <= 12735)) || ((code >= 12784) && (code <= 12799))))))))) : ((code < 42191) ? (((code >= 12832) && (code <= 12841)) || (((code >= 12872) && (code <= 12879)) || (((code >= 12881) && (code <= 12895)) || (((code >= 12928) && (code <= 12937)) || (((code >= 12977) && (code <= 12991)) || (((code >= 13312) && (code <= 19903)) || ((code >= 19968) && (code <= 42124)))))))) : (((code >= 42192) && (code <= 42237)) || (((code >= 42240) && (code <= 42508)) || (((code >= 42512) && (code <= 42539)) || (((code >= 42560) && (code <= 42606)) || (((code >= 42623) && (code <= 42653)) || (((code >= 42656) && (code <= 42735)) || ((code >= 42775) && (code <= 42783))))))))))))) : ((code < 69958) ? ((code < 65855) ? ((code < 43696) ? ((code < 43260) ? ((code < 43019) ? (((code >= 42786) && (code <= 42888)) || (((code >= 42891) && (code <= 42943)) || (((code >= 42946) && (code <= 42954)) || (((code >= 42997) && (code <= 43009)) || (((code >= 43011) && (code <= 43013)) || ((code >= 43015) && (code <= 43018))))))) : (((code >= 43020) && (code <= 43042)) || (((code >= 43056) && (code <= 43061)) || (((code >= 43072) && (code <= 43123)) || (((code >= 43138) && (code <= 43187)) || (((code >= 43216) && (code <= 43225)) || (((code >= 43250) && (code <= 43255)) || (code === 43259)))))))) : ((code < 43493) ? (((code >= 43261) && (code <= 43262)) || (((code >= 43264) && (code <= 43301)) || (((code >= 43312) && (code <= 43334)) || (((code >= 43360) && (code <= 43388)) || (((code >= 43396) && (code <= 43442)) || (((code >= 43471) && (code <= 43481)) || ((code >= 43488) && (code <= 43492)))))))) : (((code >= 43494) && (code <= 43560)) || (((code >= 43584) && (code <= 43586)) || (((code >= 43588) && (code <= 43595)) || (((code >= 43600) && (code <= 43609)) || (((code >= 43616) && (code <= 43638)) || ((code === 43642) || ((code >= 43646) && (code <= 43695)))))))))) : ((code < 63743) ? ((code < 43761) ? ((code === 43697) || (((code >= 43701) && (code <= 43702)) || (((code >= 43705) && (code <= 43709)) || ((code === 43712) || (((code >= 43714) && (code <= 43741)) || ((code >= 43744) && (code <= 43754))))))) : (((code >= 43762) && (code <= 43764)) || (((code >= 43777) && (code <= 43822)) || (((code >= 43824) && (code <= 43866)) || (((code >= 43868) && (code <= 43881)) || (((code >= 43888) && (code <= 44002)) || (((code >= 44016) && (code <= 44025)) || ((code >= 44032) && (code <= 55291))))))))) : ((code < 65135) ? (((code >= 63744) && (code <= 64217)) || (((code >= 64256) && (code <= 64279)) || ((code === 64285) || (((code >= 64287) && (code <= 64296)) || (((code >= 64298) && (code <= 64433)) || (((code >= 64467) && (code <= 64829)) || ((code >= 64848) && (code <= 65019)))))))) : (((code >= 65136) && (code <= 65276)) || (((code >= 65296) && (code <= 65305)) || (((code >= 65313) && (code <= 65338)) || (((code >= 65345) && (code <= 65370)) || (((code >= 65382) && (code <= 65500)) || (((code >= 65536) && (code <= 65786)) || ((code >= 65799) && (code <= 65843))))))))))) : ((code < 68223) ? ((code < 66775) ? ((code < 66383) ? (((code >= 65856) && (code <= 65912)) || (((code >= 65930) && (code <= 65931)) || (((code >= 66176) && (code <= 66256)) || (((code >= 66273) && (code <= 66299)) || (((code >= 66304) && (code <= 66339)) || ((code >= 66349) && (code <= 66378))))))) : (((code >= 66384) && (code <= 66421)) || (((code >= 66432) && (code <= 66461)) || (((code >= 66464) && (code <= 66511)) || (((code >= 66513) && (code <= 66517)) || (((code >= 66560) && (code <= 66717)) || (((code >= 66720) && (code <= 66729)) || ((code >= 66736) && (code <= 66771))))))))) : ((code < 67834) ? (((code >= 66776) && (code <= 66811)) || (((code >= 66816) && (code <= 66915)) || (((code >= 67072) && (code <= 67669)) || (((code >= 67672) && (code <= 67702)) || (((code >= 67705) && (code <= 67742)) || (((code >= 67751) && (code <= 67759)) || ((code >= 67808) && (code <= 67829)))))))) : (((code >= 67835) && (code <= 67867)) || (((code >= 67872) && (code <= 67897)) || (((code >= 67968) && (code <= 68023)) || (((code >= 68028) && (code <= 68096)) || (((code >= 68112) && (code <= 68149)) || (((code >= 68160) && (code <= 68168)) || ((code >= 68192) && (code <= 68222)))))))))) : ((code < 69215) ? ((code < 68471) ? (((code >= 68224) && (code <= 68255)) || (((code >= 68288) && (code <= 68295)) || (((code >= 68297) && (code <= 68324)) || (((code >= 68331) && (code <= 68335)) || (((code >= 68352) && (code <= 68405)) || (((code >= 68416) && (code <= 68437)) || ((code >= 68440) && (code <= 68466)))))))) : (((code >= 68472) && (code <= 68497)) || (((code >= 68521) && (code <= 68527)) || (((code >= 68608) && (code <= 68680)) || (((code >= 68736) && (code <= 68786)) || (((code >= 68800) && (code <= 68850)) || (((code >= 68858) && (code <= 68899)) || ((code >= 68912) && (code <= 68921))))))))) : ((code < 69713) ? (((code >= 69216) && (code <= 69246)) || (((code >= 69248) && (code <= 69289)) || (((code >= 69296) && (code <= 69445)) || (((code >= 69457) && (code <= 69460)) || (((code >= 69552) && (code <= 69579)) || (((code >= 69600) && (code <= 69622)) || ((code >= 69635) && (code <= 69687)))))))) : (((code >= 69714) && (code <= 69743)) || (((code >= 69763) && (code <= 69807)) || (((code >= 69840) && (code <= 69864)) || (((code >= 69872) && (code <= 69881)) || (((code >= 69891) && (code <= 69926)) || (((code >= 69942) && (code <= 69951)) || (code === 69956))))))))))) : ((code < 73647) ? ((code < 71295) ? ((code < 70479) ? ((code < 70112) ? (((code >= 69959) && (code <= 70002)) || ((code === 70006) || (((code >= 70019) && (code <= 70066)) || (((code >= 70081) && (code <= 70084)) || (((code >= 70096) && (code <= 70106)) || (code === 70108)))))) : (((code >= 70113) && (code <= 70132)) || (((code >= 70144) && (code <= 70187)) || (((code >= 70272) && (code <= 70312)) || (((code >= 70320) && (code <= 70366)) || (((code >= 70384) && (code <= 70393)) || (((code >= 70405) && (code <= 70457)) || (code === 70461)))))))) : ((code < 70854) ? ((code === 70480) || (((code >= 70493) && (code <= 70497)) || (((code >= 70656) && (code <= 70708)) || (((code >= 70727) && (code <= 70730)) || (((code >= 70736) && (code <= 70745)) || (((code >= 70751) && (code <= 70831)) || ((code >= 70852) && (code <= 70853)))))))) : ((code === 70855) || (((code >= 70864) && (code <= 70873)) || (((code >= 71040) && (code <= 71086)) || (((code >= 71128) && (code <= 71131)) || (((code >= 71168) && (code <= 71215)) || ((code === 71236) || ((code >= 71248) && (code <= 71257)))))))))) : ((code < 72271) ? ((code < 71839) ? (((code >= 71296) && (code <= 71338)) || ((code === 71352) || (((code >= 71360) && (code <= 71369)) || (((code >= 71424) && (code <= 71450)) || (((code >= 71472) && (code <= 71483)) || ((code >= 71680) && (code <= 71723))))))) : (((code >= 71840) && (code <= 71922)) || (((code >= 71935) && (code <= 71983)) || (((code >= 72016) && (code <= 72025)) || (((code >= 72096) && (code <= 72144)) || ((code === 72192) || (((code >= 72203) && (code <= 72242)) || ((code === 72250) || ((A2($elm$core$Basics$modBy, 2, code) === 1) && (((code >= 71999) && (code <= 72001)) || ((code >= 72161) && (code <= 72163)))))))))))) : ((code < 72959) ? ((code === 72272) || (((code >= 72284) && (code <= 72329)) || ((code === 72349) || (((code >= 72384) && (code <= 72750)) || ((code === 72768) || (((code >= 72784) && (code <= 72812)) || ((code >= 72818) && (code <= 72847)))))))) : (((code >= 72960) && (code <= 73008)) || ((code === 73030) || (((code >= 73040) && (code <= 73049)) || (((code >= 73056) && (code <= 73097)) || ((code === 73112) || (((code >= 73120) && (code <= 73129)) || ((code >= 73440) && (code <= 73458))))))))))) : ((code < 120571) ? ((code < 93759) ? ((code < 92767) ? ((code === 73648) || (((code >= 73664) && (code <= 73684)) || (((code >= 73728) && (code <= 74649)) || (((code >= 74752) && (code <= 74862)) || (((code >= 74880) && (code <= 78894)) || ((code >= 82944) && (code <= 92766))))))) : (((code >= 92768) && (code <= 92777)) || (((code >= 92880) && (code <= 92909)) || (((code >= 92928) && (code <= 92975)) || (((code >= 92992) && (code <= 92995)) || (((code >= 93008) && (code <= 93017)) || (((code >= 93019) && (code <= 93025)) || ((code >= 93027) && (code <= 93071))))))))) : ((code < 119647) ? (((code >= 93760) && (code <= 93846)) || (((code >= 93952) && (code <= 94026)) || ((code === 94032) || (((code >= 94099) && (code <= 94177)) || ((code === 94179) || (((code >= 94208) && (code <= 113817)) || ((code >= 119520) && (code <= 119539)))))))) : (((code >= 119648) && (code <= 119672)) || (((code >= 119808) && (code <= 120092)) || (((code >= 120094) && (code <= 120144)) || (((code >= 120146) && (code <= 120485)) || (((code >= 120488) && (code <= 120512)) || (((code >= 120514) && (code <= 120538)) || ((code >= 120540) && (code <= 120570)))))))))) : ((code < 123631) ? ((code < 120771) ? (((code >= 120572) && (code <= 120596)) || (((code >= 120598) && (code <= 120628)) || (((code >= 120630) && (code <= 120654)) || (((code >= 120656) && (code <= 120686)) || (((code >= 120688) && (code <= 120712)) || (((code >= 120714) && (code <= 120744)) || ((code >= 120746) && (code <= 120770)))))))) : (((code >= 120772) && (code <= 120779)) || (((code >= 120782) && (code <= 120831)) || (((code >= 123136) && (code <= 123180)) || (((code >= 123191) && (code <= 123197)) || (((code >= 123200) && (code <= 123209)) || ((code === 123214) || ((code >= 123584) && (code <= 123627))))))))) : ((code < 126124) ? (((code >= 123632) && (code <= 123641)) || (((code >= 124928) && (code <= 125124)) || (((code >= 125127) && (code <= 125135)) || (((code >= 125184) && (code <= 125251)) || ((code === 125259) || (((code >= 125264) && (code <= 125273)) || ((code >= 126065) && (code <= 126123)))))))) : (((code >= 126125) && (code <= 126127)) || (((code >= 126129) && (code <= 126253)) || (((code >= 126255) && (code <= 126269)) || (((code >= 126464) && (code <= 126651)) || (((code >= 127232) && (code <= 127244)) || (((code >= 130032) && (code <= 130041)) || ((code >= 131072) && (code <= 201546))))))))))))));
};
var $miniBill$elm_unicode$Unicode$isLower = function (c) {
	var code = $elm$core$Char$toCode(c);
	return (code < 256) ? (((code >= 97) && (code <= 122)) || ((code === 181) || (((code >= 223) && (code <= 246)) || ((code >= 248) && (code <= 255))))) : ((code < 8457) ? ((code < 1006) ? ((code < 453) ? ((code < 408) ? (((code >= 311) && (code <= 312)) || (((code >= 328) && (code <= 329)) || (((code >= 382) && (code <= 384)) || ((code === 392) || (((code >= 396) && (code <= 397)) || ((code === 402) || ((code === 405) || ((!A2($elm$core$Basics$modBy, 2, code)) ? (((code >= 314) && (code <= 326)) || ((code >= 378) && (code <= 380))) : (((code >= 257) && (code <= 309)) || (((code >= 331) && (code <= 375)) || ((code >= 387) && (code <= 389)))))))))))) : (((code >= 409) && (code <= 411)) || ((code === 414) || ((code === 424) || (((code >= 426) && (code <= 427)) || ((code === 429) || ((code === 432) || (((code >= 441) && (code <= 442)) || (((code >= 445) && (code <= 447)) || ((!A2($elm$core$Basics$modBy, 2, code)) ? ((code >= 436) && (code <= 438)) : ((code >= 417) && (code <= 421)))))))))))) : ((code < 590) ? ((code === 454) || ((code === 457) || (((code >= 476) && (code <= 477)) || (((code >= 495) && (code <= 496)) || (((code >= 563) && (code <= 569)) || ((code === 572) || (((code >= 575) && (code <= 576)) || ((code === 578) || ((!A2($elm$core$Basics$modBy, 2, code)) ? ((code >= 460) && (code <= 474)) : (((code >= 479) && (code <= 493)) || (((code >= 499) && (code <= 501)) || (((code >= 505) && (code <= 561)) || ((code >= 583) && (code <= 589)))))))))))))) : (((code >= 591) && (code <= 659)) || (((code >= 661) && (code <= 687)) || ((code === 887) || (((code >= 891) && (code <= 893)) || ((code === 912) || (((code >= 940) && (code <= 974)) || (((code >= 976) && (code <= 977)) || (((code >= 981) && (code <= 983)) || ((A2($elm$core$Basics$modBy, 2, code) === 1) && (((code >= 881) && (code <= 883)) || ((code >= 985) && (code <= 1005)))))))))))))) : ((code < 7934) ? ((code < 4303) ? (((code >= 1007) && (code <= 1011)) || ((code === 1013) || ((code === 1016) || (((code >= 1019) && (code <= 1020)) || (((code >= 1072) && (code <= 1119)) || (((code >= 1230) && (code <= 1231)) || (((code >= 1376) && (code <= 1416)) || ((!A2($elm$core$Basics$modBy, 2, code)) ? ((code >= 1218) && (code <= 1228)) : (((code >= 1121) && (code <= 1153)) || (((code >= 1163) && (code <= 1215)) || ((code >= 1233) && (code <= 1327)))))))))))) : (((code >= 4304) && (code <= 4346)) || (((code >= 4349) && (code <= 4351)) || (((code >= 5112) && (code <= 5117)) || (((code >= 7296) && (code <= 7304)) || (((code >= 7424) && (code <= 7467)) || (((code >= 7531) && (code <= 7543)) || (((code >= 7545) && (code <= 7578)) || (((code >= 7829) && (code <= 7837)) || ((A2($elm$core$Basics$modBy, 2, code) === 1) && (((code >= 7681) && (code <= 7827)) || ((code >= 7839) && (code <= 7933))))))))))))) : ((code < 8079) ? (((code >= 7935) && (code <= 7943)) || (((code >= 7952) && (code <= 7957)) || (((code >= 7968) && (code <= 7975)) || (((code >= 7984) && (code <= 7991)) || (((code >= 8000) && (code <= 8005)) || (((code >= 8016) && (code <= 8023)) || (((code >= 8032) && (code <= 8039)) || ((code >= 8048) && (code <= 8071))))))))) : (((code >= 8080) && (code <= 8087)) || (((code >= 8096) && (code <= 8103)) || (((code >= 8112) && (code <= 8119)) || ((code === 8126) || (((code >= 8130) && (code <= 8135)) || (((code >= 8144) && (code <= 8151)) || (((code >= 8160) && (code <= 8167)) || ((code >= 8178) && (code <= 8183)))))))))))) : ((code < 65344) ? ((code < 11381) ? ((code < 8517) ? ((code === 8458) || (((code >= 8462) && (code <= 8463)) || ((code === 8467) || ((code === 8495) || ((code === 8500) || ((code === 8505) || ((code >= 8508) && (code <= 8509)))))))) : (((code >= 8518) && (code <= 8521)) || ((code === 8526) || ((code === 8580) || (((code >= 11312) && (code <= 11358)) || ((code === 11361) || (((code >= 11365) && (code <= 11366)) || ((code === 11377) || (((code >= 11379) && (code <= 11380)) || ((!A2($elm$core$Basics$modBy, 2, code)) && ((code >= 11368) && (code <= 11372)))))))))))) : ((code < 42926) ? (((code >= 11382) && (code <= 11387)) || (((code >= 11491) && (code <= 11492)) || ((code === 11507) || (((code >= 11520) && (code <= 11565)) || (((code >= 42799) && (code <= 42801)) || (((code >= 42865) && (code <= 42872)) || ((code === 42897) || (((code >= 42899) && (code <= 42901)) || ((!A2($elm$core$Basics$modBy, 2, code)) ? (((code >= 11500) && (code <= 11502)) || (((code >= 42874) && (code <= 42876)) || ((code >= 42892) && (code <= 42894)))) : (((code >= 11393) && (code <= 11489)) || (((code >= 42561) && (code <= 42605)) || (((code >= 42625) && (code <= 42651)) || (((code >= 42787) && (code <= 42797)) || (((code >= 42803) && (code <= 42863)) || (((code >= 42879) && (code <= 42887)) || ((code >= 42903) && (code <= 42921))))))))))))))))) : ((code === 42927) || ((code === 42947) || ((code === 42998) || ((code === 43002) || (((code >= 43824) && (code <= 43866)) || (((code >= 43872) && (code <= 43880)) || (((code >= 43888) && (code <= 43967)) || (((code >= 64256) && (code <= 64279)) || ((!A2($elm$core$Basics$modBy, 2, code)) ? ((code >= 42952) && (code <= 42954)) : ((code >= 42933) && (code <= 42943))))))))))))) : ((code < 120301) ? ((code < 119885) ? (((code >= 65345) && (code <= 65370)) || (((code >= 66600) && (code <= 66639)) || (((code >= 66776) && (code <= 66811)) || (((code >= 68800) && (code <= 68850)) || (((code >= 71872) && (code <= 71903)) || (((code >= 93792) && (code <= 93823)) || ((code >= 119834) && (code <= 119859)))))))) : (((code >= 119886) && (code <= 119911)) || (((code >= 119938) && (code <= 119963)) || (((code >= 119990) && (code <= 120015)) || (((code >= 120042) && (code <= 120067)) || (((code >= 120094) && (code <= 120119)) || (((code >= 120146) && (code <= 120171)) || (((code >= 120198) && (code <= 120223)) || ((code >= 120250) && (code <= 120275)))))))))) : ((code < 120629) ? (((code >= 120302) && (code <= 120327)) || (((code >= 120354) && (code <= 120379)) || (((code >= 120406) && (code <= 120431)) || (((code >= 120458) && (code <= 120485)) || (((code >= 120514) && (code <= 120538)) || (((code >= 120540) && (code <= 120545)) || (((code >= 120572) && (code <= 120596)) || ((code >= 120598) && (code <= 120603))))))))) : (((code >= 120630) && (code <= 120654)) || (((code >= 120656) && (code <= 120661)) || (((code >= 120688) && (code <= 120712)) || (((code >= 120714) && (code <= 120719)) || (((code >= 120746) && (code <= 120770)) || (((code >= 120772) && (code <= 120777)) || ((code === 120779) || ((code >= 125218) && (code <= 125251)))))))))))));
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$reservedList = _List_fromArray(
	['module', 'exposing', 'import', 'as', 'if', 'then', 'else', 'let', 'in', 'case', 'of', 'port', 'type', 'where']);
var $stil4m$elm_syntax$Elm$Parser$Tokens$functionName = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$variable(
		{
			bb: function (c) {
				return $miniBill$elm_unicode$Unicode$isAlphaNum(c) || (c === '_');
			},
			bn: $elm$core$Set$fromList($stil4m$elm_syntax$Elm$Parser$Tokens$reservedList),
			br: $miniBill$elm_unicode$Unicode$isLower
		}));
var $elm$parser$Parser$ExpectingKeyword = function (a) {
	return {$: 9, a: a};
};
var $elm$parser$Parser$Advanced$keyword = function (_v0) {
	var kwd = _v0.a;
	var expecting = _v0.b;
	var progress = !$elm$core$String$isEmpty(kwd);
	return function (s) {
		var _v1 = A5($elm$parser$Parser$Advanced$isSubString, kwd, s.e, s.bo, s.a_, s.d);
		var newOffset = _v1.a;
		var newRow = _v1.b;
		var newCol = _v1.c;
		return (_Utils_eq(newOffset, -1) || (0 <= A3(
			$elm$parser$Parser$Advanced$isSubChar,
			function (c) {
				return $elm$core$Char$isAlphaNum(c) || (c === '_');
			},
			newOffset,
			s.d))) ? A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : A3(
			$elm$parser$Parser$Advanced$Good,
			progress,
			0,
			{a_: newCol, f: s.f, h: s.h, e: newOffset, bo: newRow, d: s.d});
	};
};
var $elm$parser$Parser$keyword = function (kwd) {
	return $elm$parser$Parser$Advanced$keyword(
		A2(
			$elm$parser$Parser$Advanced$Token,
			kwd,
			$elm$parser$Parser$ExpectingKeyword(kwd)));
};
var $stil4m$elm_syntax$Combine$lazy = function (t) {
	return function (state) {
		return $elm$parser$Parser$lazy(
			function (_v0) {
				return function (_v1) {
					var t_ = _v1;
					return t_(state);
				}(
					t(0));
			});
	};
};
var $elm$parser$Parser$Nestable = 1;
var $elm$parser$Parser$Advanced$findSubString = _Parser_findSubString;
var $elm$parser$Parser$Advanced$fromInfo = F4(
	function (row, col, x, context) {
		return A2(
			$elm$parser$Parser$Advanced$AddRight,
			$elm$parser$Parser$Advanced$Empty,
			A4($elm$parser$Parser$Advanced$DeadEnd, row, col, x, context));
	});
var $elm$parser$Parser$Advanced$chompUntil = function (_v0) {
	var str = _v0.a;
	var expecting = _v0.b;
	return function (s) {
		var _v1 = A5($elm$parser$Parser$Advanced$findSubString, str, s.e, s.bo, s.a_, s.d);
		var newOffset = _v1.a;
		var newRow = _v1.b;
		var newCol = _v1.c;
		return _Utils_eq(newOffset, -1) ? A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A4($elm$parser$Parser$Advanced$fromInfo, newRow, newCol, expecting, s.f)) : A3(
			$elm$parser$Parser$Advanced$Good,
			_Utils_cmp(s.e, newOffset) < 0,
			0,
			{a_: newCol, f: s.f, h: s.h, e: newOffset, bo: newRow, d: s.d});
	};
};
var $elm$core$Basics$neq = _Utils_notEqual;
var $elm$parser$Parser$Advanced$isChar = function (_char) {
	return true;
};
var $elm$parser$Parser$Advanced$nestableHelp = F5(
	function (isNotRelevant, open, close, expectingClose, nestLevel) {
		return A2(
			$elm$parser$Parser$Advanced$skip,
			$elm$parser$Parser$Advanced$chompWhile(isNotRelevant),
			$elm$parser$Parser$Advanced$oneOf(
				_List_fromArray(
					[
						(nestLevel === 1) ? close : A2(
						$elm$parser$Parser$Advanced$andThen,
						function (_v0) {
							return A5($elm$parser$Parser$Advanced$nestableHelp, isNotRelevant, open, close, expectingClose, nestLevel - 1);
						},
						close),
						A2(
						$elm$parser$Parser$Advanced$andThen,
						function (_v1) {
							return A5($elm$parser$Parser$Advanced$nestableHelp, isNotRelevant, open, close, expectingClose, nestLevel + 1);
						},
						open),
						A2(
						$elm$parser$Parser$Advanced$andThen,
						function (_v2) {
							return A5($elm$parser$Parser$Advanced$nestableHelp, isNotRelevant, open, close, expectingClose, nestLevel);
						},
						A2($elm$parser$Parser$Advanced$chompIf, $elm$parser$Parser$Advanced$isChar, expectingClose))
					])));
	});
var $elm$parser$Parser$Advanced$nestableComment = F2(
	function (open, close) {
		var oStr = open.a;
		var oX = open.b;
		var cStr = close.a;
		var cX = close.b;
		var _v0 = $elm$core$String$uncons(oStr);
		if (_v0.$ === 1) {
			return $elm$parser$Parser$Advanced$problem(oX);
		} else {
			var _v1 = _v0.a;
			var openChar = _v1.a;
			var _v2 = $elm$core$String$uncons(cStr);
			if (_v2.$ === 1) {
				return $elm$parser$Parser$Advanced$problem(cX);
			} else {
				var _v3 = _v2.a;
				var closeChar = _v3.a;
				var isNotRelevant = function (_char) {
					return (!_Utils_eq(_char, openChar)) && (!_Utils_eq(_char, closeChar));
				};
				var chompOpen = $elm$parser$Parser$Advanced$token(open);
				return A2(
					$elm$parser$Parser$Advanced$ignorer,
					chompOpen,
					A5(
						$elm$parser$Parser$Advanced$nestableHelp,
						isNotRelevant,
						chompOpen,
						$elm$parser$Parser$Advanced$token(close),
						cX,
						1));
			}
		}
	});
var $elm$parser$Parser$Advanced$multiComment = F3(
	function (open, close, nestable) {
		if (!nestable) {
			return A2(
				$elm$parser$Parser$Advanced$ignorer,
				$elm$parser$Parser$Advanced$token(open),
				$elm$parser$Parser$Advanced$chompUntil(close));
		} else {
			return A2($elm$parser$Parser$Advanced$nestableComment, open, close);
		}
	});
var $elm$parser$Parser$Advanced$Nestable = 1;
var $elm$parser$Parser$Advanced$NotNestable = 0;
var $elm$parser$Parser$toAdvancedNestable = function (nestable) {
	if (!nestable) {
		return 0;
	} else {
		return 1;
	}
};
var $elm$parser$Parser$multiComment = F3(
	function (open, close, nestable) {
		return A3(
			$elm$parser$Parser$Advanced$multiComment,
			$elm$parser$Parser$toToken(open),
			$elm$parser$Parser$toToken(close),
			$elm$parser$Parser$toAdvancedNestable(nestable));
	});
var $stil4m$elm_syntax$Elm$Parser$Comments$multilineCommentInner = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$getChompedString(
		A3($elm$parser$Parser$multiComment, '{-', '-}', 1)));
var $stil4m$elm_syntax$Elm$Parser$State$addComment = F2(
	function (pair, _v0) {
		var s = _v0;
		return _Utils_update(
			s,
			{
				a$: A2($elm$core$List$cons, pair, s.a$)
			});
	});
var $stil4m$elm_syntax$Combine$modifyState = function (f) {
	return function (state) {
		return $elm$parser$Parser$succeed(
			_Utils_Tuple2(
				f(state),
				0));
	};
};
var $stil4m$elm_syntax$Elm$Parser$Comments$addCommentToState = function (p) {
	return A2(
		$stil4m$elm_syntax$Combine$andThen,
		function (pair) {
			return A2(
				$stil4m$elm_syntax$Combine$continueWith,
				$stil4m$elm_syntax$Combine$succeed(0),
				$stil4m$elm_syntax$Combine$modifyState(
					$stil4m$elm_syntax$Elm$Parser$State$addComment(pair)));
		},
		p);
};
var $stil4m$elm_syntax$Elm$Parser$Comments$parseComment = function (commentParser) {
	return $stil4m$elm_syntax$Elm$Parser$Comments$addCommentToState(
		$stil4m$elm_syntax$Elm$Parser$Node$parser(commentParser));
};
var $stil4m$elm_syntax$Elm$Parser$Comments$multilineComment = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return $stil4m$elm_syntax$Elm$Parser$Comments$parseComment($stil4m$elm_syntax$Elm$Parser$Comments$multilineCommentInner);
	});
var $stil4m$elm_syntax$Elm$Parser$Whitespace$untilNewlineToken = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$getChompedString(
		$elm$parser$Parser$chompWhile(
			function (c) {
				return (c !== '\u000D') && (c !== '\n');
			})));
var $stil4m$elm_syntax$Elm$Parser$Comments$singleLineComment = $stil4m$elm_syntax$Elm$Parser$Comments$parseComment(
	A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$Whitespace$untilNewlineToken,
		A2(
			$stil4m$elm_syntax$Combine$andMap,
			$stil4m$elm_syntax$Combine$string('--'),
			$stil4m$elm_syntax$Combine$succeed($elm$core$Basics$append))));
var $stil4m$elm_syntax$Elm$Parser$Layout$anyComment = A2($stil4m$elm_syntax$Combine$or, $stil4m$elm_syntax$Elm$Parser$Comments$singleLineComment, $stil4m$elm_syntax$Elm$Parser$Comments$multilineComment);
var $stil4m$elm_syntax$Combine$many = function (p) {
	var helper = function (_v2) {
		var oldState = _v2.a;
		var items = _v2.b;
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						function (_v0) {
							var newState = _v0.a;
							var item = _v0.b;
							return $elm$parser$Parser$Loop(
								_Utils_Tuple2(
									newState,
									A2($elm$core$List$cons, item, items)));
						}),
					A2($stil4m$elm_syntax$Combine$app, p, oldState)),
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						return $elm$parser$Parser$Done(
							_Utils_Tuple2(
								oldState,
								$elm$core$List$reverse(items)));
					},
					$elm$parser$Parser$succeed(0))
				]));
	};
	return function (state) {
		return A2(
			$elm$parser$Parser$loop,
			_Utils_Tuple2(state, _List_Nil),
			helper);
	};
};
var $stil4m$elm_syntax$Combine$many1 = function (p) {
	return A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Combine$many(p),
		A2(
			$stil4m$elm_syntax$Combine$andMap,
			p,
			$stil4m$elm_syntax$Combine$succeed($elm$core$List$cons)));
};
var $stil4m$elm_syntax$Elm$Parser$Whitespace$many1Spaces = $stil4m$elm_syntax$Combine$fromCore(
	A2(
		$elm$parser$Parser$ignorer,
		$elm$parser$Parser$token(' '),
		$elm$parser$Parser$chompWhile(
			function (c) {
				return c === ' ';
			})));
var $stil4m$elm_syntax$Elm$Parser$Whitespace$realNewLine = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$getChompedString(
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed(0),
				$elm$parser$Parser$oneOf(
					_List_fromArray(
						[
							$elm$parser$Parser$chompIf(
							$elm$core$Basics$eq('\u000D')),
							$elm$parser$Parser$succeed(0)
						]))),
			$elm$parser$Parser$symbol('\n'))));
var $stil4m$elm_syntax$Elm$Parser$Layout$verifyIndent = function (f) {
	return $stil4m$elm_syntax$Combine$withState(
		function (s) {
			return $stil4m$elm_syntax$Combine$withLocation(
				function (l) {
					return A2(
						f,
						$stil4m$elm_syntax$Elm$Parser$State$expectedColumn(s),
						l.bP) ? $stil4m$elm_syntax$Combine$succeed(0) : $stil4m$elm_syntax$Combine$fail(
						'Expected higher indent than ' + $elm$core$String$fromInt(l.bP));
				});
		});
};
var $stil4m$elm_syntax$Elm$Parser$Layout$layout = A2(
	$stil4m$elm_syntax$Combine$continueWith,
	$stil4m$elm_syntax$Elm$Parser$Layout$verifyIndent(
		F2(
			function (stateIndent, current) {
				return _Utils_cmp(stateIndent, current) < 0;
			})),
	$stil4m$elm_syntax$Combine$many1(
		$stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					$stil4m$elm_syntax$Elm$Parser$Layout$anyComment,
					A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[$stil4m$elm_syntax$Elm$Parser$Whitespace$many1Spaces, $stil4m$elm_syntax$Elm$Parser$Layout$anyComment])),
					$stil4m$elm_syntax$Combine$many1($stil4m$elm_syntax$Elm$Parser$Whitespace$realNewLine)),
					$stil4m$elm_syntax$Elm$Parser$Whitespace$many1Spaces
				]))));
var $stil4m$elm_syntax$Combine$maybe = function (_v0) {
	var p = _v0;
	return function (state) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						var c = _v1.a;
						var v = _v1.b;
						return _Utils_Tuple2(
							c,
							$elm$core$Maybe$Just(v));
					},
					p(state)),
					$elm$parser$Parser$succeed(
					_Utils_Tuple2(state, $elm$core$Maybe$Nothing))
				]));
	};
};
var $stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides = function (x) {
	return A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
		A2(
			$stil4m$elm_syntax$Combine$continueWith,
			x,
			$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout)));
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$FloatPattern = function (a) {
	return {$: 6, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$HexPattern = function (a) {
	return {$: 5, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$IntPattern = function (a) {
	return {$: 4, a: a};
};
var $elm$parser$Parser$ExpectingBinary = {$: 4};
var $elm$parser$Parser$ExpectingFloat = {$: 5};
var $elm$parser$Parser$ExpectingHex = {$: 2};
var $elm$parser$Parser$ExpectingInt = {$: 1};
var $elm$parser$Parser$ExpectingNumber = {$: 6};
var $elm$parser$Parser$ExpectingOctal = {$: 3};
var $elm$core$Result$fromMaybe = F2(
	function (err, maybe) {
		if (!maybe.$) {
			var v = maybe.a;
			return $elm$core$Result$Ok(v);
		} else {
			return $elm$core$Result$Err(err);
		}
	});
var $elm$parser$Parser$Advanced$consumeBase = _Parser_consumeBase;
var $elm$parser$Parser$Advanced$consumeBase16 = _Parser_consumeBase16;
var $elm$parser$Parser$Advanced$bumpOffset = F2(
	function (newOffset, s) {
		return {a_: s.a_ + (newOffset - s.e), f: s.f, h: s.h, e: newOffset, bo: s.bo, d: s.d};
	});
var $elm$parser$Parser$Advanced$chompBase10 = _Parser_chompBase10;
var $elm$parser$Parser$Advanced$isAsciiCode = _Parser_isAsciiCode;
var $elm$parser$Parser$Advanced$consumeExp = F2(
	function (offset, src) {
		if (A3($elm$parser$Parser$Advanced$isAsciiCode, 101, offset, src) || A3($elm$parser$Parser$Advanced$isAsciiCode, 69, offset, src)) {
			var eOffset = offset + 1;
			var expOffset = (A3($elm$parser$Parser$Advanced$isAsciiCode, 43, eOffset, src) || A3($elm$parser$Parser$Advanced$isAsciiCode, 45, eOffset, src)) ? (eOffset + 1) : eOffset;
			var newOffset = A2($elm$parser$Parser$Advanced$chompBase10, expOffset, src);
			return _Utils_eq(expOffset, newOffset) ? (-newOffset) : newOffset;
		} else {
			return offset;
		}
	});
var $elm$parser$Parser$Advanced$consumeDotAndExp = F2(
	function (offset, src) {
		return A3($elm$parser$Parser$Advanced$isAsciiCode, 46, offset, src) ? A2(
			$elm$parser$Parser$Advanced$consumeExp,
			A2($elm$parser$Parser$Advanced$chompBase10, offset + 1, src),
			src) : A2($elm$parser$Parser$Advanced$consumeExp, offset, src);
	});
var $elm$parser$Parser$Advanced$finalizeInt = F5(
	function (invalid, handler, startOffset, _v0, s) {
		var endOffset = _v0.a;
		var n = _v0.b;
		if (handler.$ === 1) {
			var x = handler.a;
			return A2(
				$elm$parser$Parser$Advanced$Bad,
				true,
				A2($elm$parser$Parser$Advanced$fromState, s, x));
		} else {
			var toValue = handler.a;
			return _Utils_eq(startOffset, endOffset) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				_Utils_cmp(s.e, startOffset) < 0,
				A2($elm$parser$Parser$Advanced$fromState, s, invalid)) : A3(
				$elm$parser$Parser$Advanced$Good,
				true,
				toValue(n),
				A2($elm$parser$Parser$Advanced$bumpOffset, endOffset, s));
		}
	});
var $elm$core$String$toFloat = _String_toFloat;
var $elm$parser$Parser$Advanced$finalizeFloat = F6(
	function (invalid, expecting, intSettings, floatSettings, intPair, s) {
		var intOffset = intPair.a;
		var floatOffset = A2($elm$parser$Parser$Advanced$consumeDotAndExp, intOffset, s.d);
		if (floatOffset < 0) {
			return A2(
				$elm$parser$Parser$Advanced$Bad,
				true,
				A4($elm$parser$Parser$Advanced$fromInfo, s.bo, s.a_ - (floatOffset + s.e), invalid, s.f));
		} else {
			if (_Utils_eq(s.e, floatOffset)) {
				return A2(
					$elm$parser$Parser$Advanced$Bad,
					false,
					A2($elm$parser$Parser$Advanced$fromState, s, expecting));
			} else {
				if (_Utils_eq(intOffset, floatOffset)) {
					return A5($elm$parser$Parser$Advanced$finalizeInt, invalid, intSettings, s.e, intPair, s);
				} else {
					if (floatSettings.$ === 1) {
						var x = floatSettings.a;
						return A2(
							$elm$parser$Parser$Advanced$Bad,
							true,
							A2($elm$parser$Parser$Advanced$fromState, s, invalid));
					} else {
						var toValue = floatSettings.a;
						var _v1 = $elm$core$String$toFloat(
							A3($elm$core$String$slice, s.e, floatOffset, s.d));
						if (_v1.$ === 1) {
							return A2(
								$elm$parser$Parser$Advanced$Bad,
								true,
								A2($elm$parser$Parser$Advanced$fromState, s, invalid));
						} else {
							var n = _v1.a;
							return A3(
								$elm$parser$Parser$Advanced$Good,
								true,
								toValue(n),
								A2($elm$parser$Parser$Advanced$bumpOffset, floatOffset, s));
						}
					}
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$number = function (c) {
	return function (s) {
		if (A3($elm$parser$Parser$Advanced$isAsciiCode, 48, s.e, s.d)) {
			var zeroOffset = s.e + 1;
			var baseOffset = zeroOffset + 1;
			return A3($elm$parser$Parser$Advanced$isAsciiCode, 120, zeroOffset, s.d) ? A5(
				$elm$parser$Parser$Advanced$finalizeInt,
				c.cy,
				c.cq,
				baseOffset,
				A2($elm$parser$Parser$Advanced$consumeBase16, baseOffset, s.d),
				s) : (A3($elm$parser$Parser$Advanced$isAsciiCode, 111, zeroOffset, s.d) ? A5(
				$elm$parser$Parser$Advanced$finalizeInt,
				c.cy,
				c.bg,
				baseOffset,
				A3($elm$parser$Parser$Advanced$consumeBase, 8, baseOffset, s.d),
				s) : (A3($elm$parser$Parser$Advanced$isAsciiCode, 98, zeroOffset, s.d) ? A5(
				$elm$parser$Parser$Advanced$finalizeInt,
				c.cy,
				c.aY,
				baseOffset,
				A3($elm$parser$Parser$Advanced$consumeBase, 2, baseOffset, s.d),
				s) : A6(
				$elm$parser$Parser$Advanced$finalizeFloat,
				c.cy,
				c.a7,
				c.cv,
				c.cf,
				_Utils_Tuple2(zeroOffset, 0),
				s)));
		} else {
			return A6(
				$elm$parser$Parser$Advanced$finalizeFloat,
				c.cy,
				c.a7,
				c.cv,
				c.cf,
				A3($elm$parser$Parser$Advanced$consumeBase, 10, s.e, s.d),
				s);
		}
	};
};
var $elm$parser$Parser$number = function (i) {
	return $elm$parser$Parser$Advanced$number(
		{
			aY: A2($elm$core$Result$fromMaybe, $elm$parser$Parser$ExpectingBinary, i.aY),
			a7: $elm$parser$Parser$ExpectingNumber,
			cf: A2($elm$core$Result$fromMaybe, $elm$parser$Parser$ExpectingFloat, i.cf),
			cq: A2($elm$core$Result$fromMaybe, $elm$parser$Parser$ExpectingHex, i.cq),
			cv: A2($elm$core$Result$fromMaybe, $elm$parser$Parser$ExpectingInt, i.cv),
			cy: $elm$parser$Parser$ExpectingNumber,
			bg: A2($elm$core$Result$fromMaybe, $elm$parser$Parser$ExpectingOctal, i.bg)
		});
};
var $stil4m$elm_syntax$Elm$Parser$Numbers$raw = F3(
	function (floatf, intf, hexf) {
		return $elm$parser$Parser$number(
			{
				aY: $elm$core$Maybe$Nothing,
				cf: $elm$core$Maybe$Just(floatf),
				cq: $elm$core$Maybe$Just(hexf),
				cv: $elm$core$Maybe$Just(intf),
				bg: $elm$core$Maybe$Nothing
			});
	});
var $stil4m$elm_syntax$Elm$Parser$Numbers$number = F3(
	function (floatf, intf, hexf) {
		return $stil4m$elm_syntax$Combine$fromCore(
			A3($stil4m$elm_syntax$Elm$Parser$Numbers$raw, floatf, intf, hexf));
	});
var $stil4m$elm_syntax$Elm$Parser$Patterns$numberPart = A3($stil4m$elm_syntax$Elm$Parser$Numbers$number, $stil4m$elm_syntax$Elm$Syntax$Pattern$FloatPattern, $stil4m$elm_syntax$Elm$Syntax$Pattern$IntPattern, $stil4m$elm_syntax$Elm$Syntax$Pattern$HexPattern);
var $stil4m$elm_syntax$Combine$parens = A2(
	$stil4m$elm_syntax$Combine$between,
	$stil4m$elm_syntax$Combine$string('('),
	$stil4m$elm_syntax$Combine$string(')'));
var $stil4m$elm_syntax$Elm$Syntax$Pattern$RecordPattern = function (a) {
	return {$: 8, a: a};
};
var $stil4m$elm_syntax$Combine$sepBy1 = F2(
	function (sep, p) {
		return A2(
			$stil4m$elm_syntax$Combine$andMap,
			$stil4m$elm_syntax$Combine$many(
				A2($stil4m$elm_syntax$Combine$continueWith, p, sep)),
			A2(
				$stil4m$elm_syntax$Combine$andMap,
				p,
				$stil4m$elm_syntax$Combine$succeed($elm$core$List$cons)));
	});
var $stil4m$elm_syntax$Elm$Parser$Patterns$recordPart = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return $stil4m$elm_syntax$Elm$Parser$Node$parser(
			A2(
				$stil4m$elm_syntax$Combine$map,
				$stil4m$elm_syntax$Elm$Syntax$Pattern$RecordPattern,
				A3(
					$stil4m$elm_syntax$Combine$between,
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Combine$string('{')),
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Combine$string('}'),
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout)),
					A2(
						$stil4m$elm_syntax$Combine$sepBy1,
						$stil4m$elm_syntax$Combine$string(','),
						$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
							$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName))))));
	});
var $stil4m$elm_syntax$Combine$sepBy = F2(
	function (sep, p) {
		return A2(
			$stil4m$elm_syntax$Combine$or,
			A2($stil4m$elm_syntax$Combine$sepBy1, sep, p),
			$stil4m$elm_syntax$Combine$succeed(_List_Nil));
	});
var $elm$parser$Parser$Advanced$getOffset = function (s) {
	return A3($elm$parser$Parser$Advanced$Good, false, s.e, s);
};
var $elm$parser$Parser$getOffset = $elm$parser$Parser$Advanced$getOffset;
var $stil4m$elm_syntax$Elm$Parser$Tokens$stringLiteral = function () {
	var helper = function (s) {
		return s.H ? A2(
			$elm$parser$Parser$map,
			function (v) {
				return $elm$parser$Parser$Loop(
					_Utils_update(
						s,
						{
							H: false,
							l: A2(
								$elm$core$List$cons,
								$elm$core$String$fromList(
									_List_fromArray(
										[v])),
								s.l)
						}));
			},
			$stil4m$elm_syntax$Elm$Parser$Tokens$escapedCharValue) : $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(
							$elm$core$String$concat(
								$elm$core$List$reverse(s.l)));
					},
					$elm$parser$Parser$symbol('\"')),
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						return $elm$parser$Parser$Loop(
							_Utils_update(
								s,
								{H: true, l: s.l}));
					},
					$elm$parser$Parser$getChompedString(
						$elm$parser$Parser$symbol('\\'))),
					A2(
					$elm$parser$Parser$andThen,
					function (_v2) {
						var start = _v2.a;
						var value = _v2.b;
						var end = _v2.c;
						return _Utils_eq(start, end) ? $elm$parser$Parser$problem('Expected a string character or a double quote') : $elm$parser$Parser$succeed(
							$elm$parser$Parser$Loop(
								_Utils_update(
									s,
									{
										l: A2($elm$core$List$cons, value, s.l)
									})));
					},
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$keeper,
							A2(
								$elm$parser$Parser$keeper,
								$elm$parser$Parser$succeed(
									F3(
										function (start, value, end) {
											return _Utils_Tuple3(start, value, end);
										})),
								$elm$parser$Parser$getOffset),
							$elm$parser$Parser$getChompedString(
								$elm$parser$Parser$chompWhile(
									function (c) {
										return (c !== '\"') && (c !== '\\');
									}))),
						$elm$parser$Parser$getOffset))
				]));
	};
	return $stil4m$elm_syntax$Combine$fromCore(
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed($elm$core$Basics$identity),
				$elm$parser$Parser$symbol('\"')),
			A2(
				$elm$parser$Parser$loop,
				{H: false, l: _List_Nil},
				helper)));
}();
var $miniBill$elm_unicode$Unicode$isUpper = function (c) {
	var code = $elm$core$Char$toCode(c);
	return (code < 256) ? (((code >= 65) && (code <= 90)) || (((code >= 192) && (code <= 214)) || ((code >= 216) && (code <= 222)))) : ((code < 8167) ? ((code < 578) ? ((code < 429) ? ((code < 402) ? (((code >= 376) && (code <= 377)) || (((code >= 385) && (code <= 386)) || ((code === 388) || (((code >= 390) && (code <= 391)) || (((code >= 393) && (code <= 395)) || (((code >= 398) && (code <= 401)) || ((!A2($elm$core$Basics$modBy, 2, code)) ? (((code >= 256) && (code <= 310)) || ((code >= 330) && (code <= 374))) : (((code >= 313) && (code <= 327)) || ((code >= 379) && (code <= 381)))))))))) : (((code >= 403) && (code <= 404)) || (((code >= 406) && (code <= 408)) || (((code >= 412) && (code <= 413)) || (((code >= 415) && (code <= 416)) || (((code >= 422) && (code <= 423)) || ((code === 425) || ((code === 428) || ((!A2($elm$core$Basics$modBy, 2, code)) && ((code >= 418) && (code <= 420))))))))))) : ((code < 457) ? (((code >= 430) && (code <= 431)) || (((code >= 433) && (code <= 435)) || ((code === 437) || (((code >= 439) && (code <= 440)) || ((code === 444) || ((code === 452) || (code === 455))))))) : ((code === 458) || ((code === 497) || ((code === 500) || (((code >= 502) && (code <= 504)) || (((code >= 570) && (code <= 571)) || (((code >= 573) && (code <= 574)) || ((code === 577) || ((!A2($elm$core$Basics$modBy, 2, code)) ? (((code >= 478) && (code <= 494)) || ((code >= 506) && (code <= 562))) : ((code >= 461) && (code <= 475)))))))))))) : ((code < 1328) ? ((code < 974) ? (((code >= 579) && (code <= 582)) || ((code === 886) || ((code === 895) || ((code === 902) || (((code >= 904) && (code <= 911)) || (((code >= 913) && (code <= 939)) || ((!A2($elm$core$Basics$modBy, 2, code)) && (((code >= 584) && (code <= 590)) || ((code >= 880) && (code <= 882)))))))))) : ((code === 975) || (((code >= 978) && (code <= 980)) || ((code === 1012) || ((code === 1015) || (((code >= 1017) && (code <= 1018)) || (((code >= 1021) && (code <= 1071)) || (((code >= 1216) && (code <= 1217)) || ((!A2($elm$core$Basics$modBy, 2, code)) ? (((code >= 984) && (code <= 1006)) || (((code >= 1120) && (code <= 1152)) || (((code >= 1162) && (code <= 1214)) || ((code >= 1232) && (code <= 1326))))) : ((code >= 1219) && (code <= 1229))))))))))) : ((code < 7991) ? (((code >= 1329) && (code <= 1366)) || (((code >= 4256) && (code <= 4301)) || (((code >= 5024) && (code <= 5109)) || (((code >= 7312) && (code <= 7359)) || (((code >= 7944) && (code <= 7951)) || (((code >= 7960) && (code <= 7965)) || (((code >= 7976) && (code <= 7983)) || ((!A2($elm$core$Basics$modBy, 2, code)) && (((code >= 7680) && (code <= 7828)) || ((code >= 7838) && (code <= 7934))))))))))) : (((code >= 7992) && (code <= 7999)) || (((code >= 8008) && (code <= 8013)) || (((code >= 8025) && (code <= 8031)) || (((code >= 8040) && (code <= 8047)) || (((code >= 8120) && (code <= 8123)) || (((code >= 8136) && (code <= 8139)) || ((code >= 8152) && (code <= 8155))))))))))) : ((code < 42996) ? ((code < 11263) ? ((code < 8468) ? (((code >= 8168) && (code <= 8172)) || (((code >= 8184) && (code <= 8187)) || ((code === 8450) || ((code === 8455) || (((code >= 8459) && (code <= 8461)) || ((code >= 8464) && (code <= 8466))))))) : ((code === 8469) || (((code >= 8473) && (code <= 8477)) || (((code >= 8490) && (code <= 8493)) || (((code >= 8496) && (code <= 8499)) || (((code >= 8510) && (code <= 8511)) || ((code === 8517) || ((code === 8579) || ((!A2($elm$core$Basics$modBy, 2, code)) && ((code >= 8484) && (code <= 8488))))))))))) : ((code < 11505) ? (((code >= 11264) && (code <= 11310)) || ((code === 11360) || (((code >= 11362) && (code <= 11364)) || (((code >= 11373) && (code <= 11376)) || ((code === 11378) || ((code === 11381) || (((code >= 11390) && (code <= 11392)) || ((!A2($elm$core$Basics$modBy, 2, code)) ? ((code >= 11394) && (code <= 11490)) : (((code >= 11367) && (code <= 11371)) || ((code >= 11499) && (code <= 11501))))))))))) : ((code === 11506) || (((code >= 42877) && (code <= 42878)) || (((code >= 42922) && (code <= 42926)) || (((code >= 42928) && (code <= 42932)) || ((code === 42946) || (((code >= 42948) && (code <= 42951)) || ((code === 42953) || ((!A2($elm$core$Basics$modBy, 2, code)) ? (((code >= 42560) && (code <= 42604)) || (((code >= 42624) && (code <= 42650)) || (((code >= 42786) && (code <= 42798)) || (((code >= 42802) && (code <= 42862)) || (((code >= 42880) && (code <= 42886)) || (((code >= 42896) && (code <= 42898)) || (((code >= 42902) && (code <= 42920)) || ((code >= 42934) && (code <= 42942))))))))) : (((code >= 42873) && (code <= 42875)) || ((code >= 42891) && (code <= 42893))))))))))))) : ((code < 120119) ? ((code < 93759) ? ((code === 42997) || (((code >= 65313) && (code <= 65338)) || (((code >= 66560) && (code <= 66599)) || (((code >= 66736) && (code <= 66771)) || (((code >= 68736) && (code <= 68786)) || ((code >= 71840) && (code <= 71871))))))) : (((code >= 93760) && (code <= 93791)) || (((code >= 119808) && (code <= 119833)) || (((code >= 119860) && (code <= 119885)) || (((code >= 119912) && (code <= 119937)) || (((code >= 119964) && (code <= 119989)) || (((code >= 120016) && (code <= 120041)) || ((code >= 120068) && (code <= 120092))))))))) : ((code < 120487) ? (((code >= 120120) && (code <= 120144)) || (((code >= 120172) && (code <= 120197)) || (((code >= 120224) && (code <= 120249)) || (((code >= 120276) && (code <= 120301)) || (((code >= 120328) && (code <= 120353)) || (((code >= 120380) && (code <= 120405)) || ((code >= 120432) && (code <= 120457)))))))) : (((code >= 120488) && (code <= 120512)) || (((code >= 120546) && (code <= 120570)) || (((code >= 120604) && (code <= 120628)) || (((code >= 120662) && (code <= 120686)) || (((code >= 120720) && (code <= 120744)) || ((code === 120778) || ((code >= 125184) && (code <= 125217))))))))))));
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$typeName = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$variable(
		{
			bb: function (c) {
				return $miniBill$elm_unicode$Unicode$isAlphaNum(c) || (c === '_');
			},
			bn: $elm$core$Set$fromList($stil4m$elm_syntax$Elm$Parser$Tokens$reservedList),
			br: $miniBill$elm_unicode$Unicode$isUpper
		}));
var $stil4m$elm_syntax$Elm$Parser$Base$typeIndicator = function () {
	var helper = function (_v0) {
		var n = _v0.a;
		var xs = _v0.b;
		return $stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					A2(
					$stil4m$elm_syntax$Combine$andThen,
					function (t) {
						return helper(
							_Utils_Tuple2(
								t,
								A2($elm$core$List$cons, n, xs)));
					},
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$Tokens$typeName,
						$stil4m$elm_syntax$Combine$string('.'))),
					$stil4m$elm_syntax$Combine$succeed(
					_Utils_Tuple2(n, xs))
				]));
	};
	return A2(
		$stil4m$elm_syntax$Combine$map,
		function (_v1) {
			var t = _v1.a;
			var xs = _v1.b;
			return _Utils_Tuple2(
				$elm$core$List$reverse(xs),
				t);
		},
		A2(
			$stil4m$elm_syntax$Combine$andThen,
			function (t) {
				return helper(
					_Utils_Tuple2(t, _List_Nil));
			},
			$stil4m$elm_syntax$Elm$Parser$Tokens$typeName));
}();
var $stil4m$elm_syntax$Elm$Parser$Patterns$variablePart = $stil4m$elm_syntax$Elm$Parser$Node$parser(
	A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern, $stil4m$elm_syntax$Elm$Parser$Tokens$functionName));
var $stil4m$elm_syntax$Elm$Parser$Patterns$qualifiedPattern = function (consumeArgs) {
	return A2(
		$stil4m$elm_syntax$Combine$andThen,
		function (_v0) {
			var range = _v0.a;
			var _v1 = _v0.b;
			var mod = _v1.a;
			var name = _v1.b;
			return A2(
				$stil4m$elm_syntax$Combine$map,
				function (args) {
					return A2(
						$stil4m$elm_syntax$Elm$Syntax$Node$Node,
						$stil4m$elm_syntax$Elm$Syntax$Range$combine(
							A2(
								$elm$core$List$cons,
								range,
								A2(
									$elm$core$List$map,
									function (_v2) {
										var r = _v2.a;
										return r;
									},
									args))),
						A2(
							$stil4m$elm_syntax$Elm$Syntax$Pattern$NamedPattern,
							A2($stil4m$elm_syntax$Elm$Syntax$Pattern$QualifiedNameRef, mod, name),
							args));
				},
				consumeArgs ? $stil4m$elm_syntax$Combine$many(
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$qualifiedPatternArg())) : $stil4m$elm_syntax$Combine$succeed(_List_Nil));
		},
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
			$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Base$typeIndicator)));
};
var $stil4m$elm_syntax$Elm$Parser$Patterns$tryToCompose = function (x) {
	return A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					A2(
					$stil4m$elm_syntax$Combine$map,
					function (y) {
						return A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $stil4m$elm_syntax$Elm$Syntax$Pattern$AsPattern, x, y);
					},
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Elm$Parser$Layout$layout,
							$stil4m$elm_syntax$Combine$fromCore(
								$elm$parser$Parser$keyword('as'))))),
					A2(
					$stil4m$elm_syntax$Combine$map,
					function (y) {
						return A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $stil4m$elm_syntax$Elm$Syntax$Pattern$UnConsPattern, x, y);
					},
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$pattern(),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							$stil4m$elm_syntax$Combine$fromCore(
								$elm$parser$Parser$symbol('::'))))),
					$stil4m$elm_syntax$Combine$succeed(x)
				])),
		$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout));
};
function $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$pattern() {
	return A2(
		$stil4m$elm_syntax$Combine$andThen,
		$stil4m$elm_syntax$Elm$Parser$Patterns$tryToCompose,
		$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$composablePattern());
}
function $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$composablePattern() {
	return $stil4m$elm_syntax$Combine$choice(
		_List_fromArray(
			[
				$stil4m$elm_syntax$Elm$Parser$Patterns$variablePart,
				$stil4m$elm_syntax$Elm$Parser$Patterns$qualifiedPattern(true),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Pattern$StringPattern, $stil4m$elm_syntax$Elm$Parser$Tokens$stringLiteral)),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Pattern$CharPattern, $stil4m$elm_syntax$Elm$Parser$Tokens$characterLiteral)),
				$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Patterns$numberPart),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$map,
					$elm$core$Basics$always($stil4m$elm_syntax$Elm$Syntax$Pattern$UnitPattern),
					$stil4m$elm_syntax$Combine$fromCore(
						$elm$parser$Parser$symbol('()')))),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$map,
					$elm$core$Basics$always($stil4m$elm_syntax$Elm$Syntax$Pattern$AllPattern),
					$stil4m$elm_syntax$Combine$fromCore(
						$elm$parser$Parser$symbol('_')))),
				$stil4m$elm_syntax$Elm$Parser$Patterns$recordPart,
				$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$listPattern(),
				$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$parensPattern()
			]));
}
function $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$qualifiedPatternArg() {
	return $stil4m$elm_syntax$Combine$choice(
		_List_fromArray(
			[
				$stil4m$elm_syntax$Elm$Parser$Patterns$variablePart,
				$stil4m$elm_syntax$Elm$Parser$Patterns$qualifiedPattern(false),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Pattern$StringPattern, $stil4m$elm_syntax$Elm$Parser$Tokens$stringLiteral)),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Pattern$CharPattern, $stil4m$elm_syntax$Elm$Parser$Tokens$characterLiteral)),
				$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Patterns$numberPart),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$map,
					$elm$core$Basics$always($stil4m$elm_syntax$Elm$Syntax$Pattern$UnitPattern),
					$stil4m$elm_syntax$Combine$fromCore(
						$elm$parser$Parser$symbol('()')))),
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$map,
					$elm$core$Basics$always($stil4m$elm_syntax$Elm$Syntax$Pattern$AllPattern),
					$stil4m$elm_syntax$Combine$fromCore(
						$elm$parser$Parser$symbol('_')))),
				$stil4m$elm_syntax$Elm$Parser$Patterns$recordPart,
				$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$listPattern(),
				$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$parensPattern()
			]));
}
function $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$listPattern() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v5) {
			return $stil4m$elm_syntax$Elm$Parser$Node$parser(
				A3(
					$stil4m$elm_syntax$Combine$between,
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Combine$string('[')),
					$stil4m$elm_syntax$Combine$string(']'),
					A2(
						$stil4m$elm_syntax$Combine$map,
						$stil4m$elm_syntax$Elm$Syntax$Pattern$ListPattern,
						A2(
							$stil4m$elm_syntax$Combine$sepBy,
							$stil4m$elm_syntax$Combine$string(','),
							$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
								$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$pattern())))));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$parensPattern() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v3) {
			return $stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$map,
					function (c) {
						if (c.b && (!c.b.b)) {
							var x = c.a;
							return $stil4m$elm_syntax$Elm$Syntax$Pattern$ParenthesizedPattern(x);
						} else {
							return $stil4m$elm_syntax$Elm$Syntax$Pattern$TuplePattern(c);
						}
					},
					$stil4m$elm_syntax$Combine$parens(
						A2(
							$stil4m$elm_syntax$Combine$sepBy,
							$stil4m$elm_syntax$Combine$string(','),
							$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
								$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$pattern())))));
		});
}
var $stil4m$elm_syntax$Elm$Parser$Patterns$pattern = $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$pattern();
$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$pattern = function () {
	return $stil4m$elm_syntax$Elm$Parser$Patterns$pattern;
};
var $stil4m$elm_syntax$Elm$Parser$Patterns$composablePattern = $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$composablePattern();
$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$composablePattern = function () {
	return $stil4m$elm_syntax$Elm$Parser$Patterns$composablePattern;
};
var $stil4m$elm_syntax$Elm$Parser$Patterns$qualifiedPatternArg = $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$qualifiedPatternArg();
$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$qualifiedPatternArg = function () {
	return $stil4m$elm_syntax$Elm$Parser$Patterns$qualifiedPatternArg;
};
var $stil4m$elm_syntax$Elm$Parser$Patterns$listPattern = $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$listPattern();
$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$listPattern = function () {
	return $stil4m$elm_syntax$Elm$Parser$Patterns$listPattern;
};
var $stil4m$elm_syntax$Elm$Parser$Patterns$parensPattern = $stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$parensPattern();
$stil4m$elm_syntax$Elm$Parser$Patterns$cyclic$parensPattern = function () {
	return $stil4m$elm_syntax$Elm$Parser$Patterns$parensPattern;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$functionArgument = $stil4m$elm_syntax$Elm$Parser$Patterns$pattern;
var $stil4m$elm_syntax$Elm$Syntax$Signature$Signature = F2(
	function (name, typeAnnotation) {
		return {I: name, aV: typeAnnotation};
	});
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$Eager = 0;
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$Lazy = 1;
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$asTypeAnnotation = F2(
	function (x, xs) {
		var value = x.b;
		if (!xs.b) {
			return value;
		} else {
			return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(
				A2($elm$core$List$cons, x, xs));
		}
	});
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$genericTypeAnnotation = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return $stil4m$elm_syntax$Elm$Parser$Node$parser(
			A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType, $stil4m$elm_syntax$Elm$Parser$Tokens$functionName));
	});
var $stil4m$elm_syntax$Elm$Parser$Layout$Indented = 1;
var $stil4m$elm_syntax$Elm$Parser$Layout$Strict = 0;
var $elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			$elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var $stil4m$elm_syntax$Elm$Parser$State$storedColumns = function (_v0) {
	var indents = _v0.T;
	return A2(
		$elm$core$List$map,
		$elm$core$Basics$add(1),
		indents);
};
var $stil4m$elm_syntax$Elm$Parser$Layout$compute = $stil4m$elm_syntax$Combine$withState(
	function (s) {
		return $stil4m$elm_syntax$Combine$withLocation(
			function (l) {
				var known = A2(
					$elm$core$List$cons,
					1,
					$stil4m$elm_syntax$Elm$Parser$State$storedColumns(s));
				return A2($elm$core$List$member, l.bP, known) ? $stil4m$elm_syntax$Combine$succeed(0) : $stil4m$elm_syntax$Combine$succeed(1);
			});
	});
var $stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout = A2(
	$stil4m$elm_syntax$Combine$continueWith,
	$stil4m$elm_syntax$Elm$Parser$Layout$compute,
	$stil4m$elm_syntax$Combine$many(
		$stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					$stil4m$elm_syntax$Elm$Parser$Layout$anyComment,
					A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								$stil4m$elm_syntax$Elm$Parser$Whitespace$many1Spaces,
								$stil4m$elm_syntax$Elm$Parser$Layout$anyComment,
								$stil4m$elm_syntax$Combine$succeed(0)
							])),
					$stil4m$elm_syntax$Combine$many1($stil4m$elm_syntax$Elm$Parser$Whitespace$realNewLine)),
					$stil4m$elm_syntax$Elm$Parser$Whitespace$many1Spaces
				]))));
var $stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayoutWith = F2(
	function (onStrict, onIndented) {
		return A2(
			$stil4m$elm_syntax$Combine$andThen,
			function (ind) {
				if (!ind) {
					return onStrict(0);
				} else {
					return onIndented(0);
				}
			},
			$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout);
	});
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotationNoFn = function (mode) {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v7) {
			return $stil4m$elm_syntax$Combine$choice(
				_List_fromArray(
					[
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$parensTypeAnnotation(),
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typedTypeAnnotation(mode),
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$genericTypeAnnotation,
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordTypeAnnotation()
					]));
		});
};
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typedTypeAnnotation = function (mode) {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v0) {
			var nodeRanges = $elm$core$List$map(
				function (_v6) {
					var r = _v6.a;
					return r;
				});
			var genericHelper = function (items) {
				return A2(
					$stil4m$elm_syntax$Combine$or,
					A2(
						$stil4m$elm_syntax$Combine$andThen,
						function (next) {
							return A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
								A2(
									$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayoutWith,
									function (_v1) {
										return $stil4m$elm_syntax$Combine$succeed(
											$elm$core$List$reverse(
												A2($elm$core$List$cons, next, items)));
									},
									function (_v2) {
										return genericHelper(
											A2($elm$core$List$cons, next, items));
									}));
						},
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotationNoFn(1)),
					$stil4m$elm_syntax$Combine$succeed(
						$elm$core$List$reverse(items)));
			};
			return A2(
				$stil4m$elm_syntax$Combine$andThen,
				function (original) {
					var tir = original.a;
					return A2(
						$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayoutWith,
						function (_v3) {
							return $stil4m$elm_syntax$Combine$succeed(
								A2(
									$stil4m$elm_syntax$Elm$Syntax$Node$Node,
									tir,
									A2($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed, original, _List_Nil)));
						},
						function (_v4) {
							if (!mode) {
								return A2(
									$stil4m$elm_syntax$Combine$map,
									function (args) {
										return A2(
											$stil4m$elm_syntax$Elm$Syntax$Node$Node,
											$stil4m$elm_syntax$Elm$Syntax$Range$combine(
												A2(
													$elm$core$List$cons,
													tir,
													nodeRanges(args))),
											A2($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed, original, args));
									},
									genericHelper(_List_Nil));
							} else {
								return $stil4m$elm_syntax$Combine$succeed(
									A2(
										$stil4m$elm_syntax$Elm$Syntax$Node$Node,
										tir,
										A2($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed, original, _List_Nil)));
							}
						});
				},
				$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Base$typeIndicator));
		});
};
function $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$parensTypeAnnotation() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v14) {
			var commaSep = $stil4m$elm_syntax$Combine$many(
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation(),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							$stil4m$elm_syntax$Combine$string(',')))));
			var nested = A2(
				$stil4m$elm_syntax$Combine$andMap,
				commaSep,
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
					A2(
						$stil4m$elm_syntax$Combine$andMap,
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation(),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Parser$TypeAnnotation$asTypeAnnotation)))));
			return $stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								A2(
								$stil4m$elm_syntax$Combine$map,
								$elm$core$Basics$always($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit),
								$stil4m$elm_syntax$Combine$string(')')),
								A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$string(')'),
								nested)
							])),
					$stil4m$elm_syntax$Combine$string('(')));
		});
}
function $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldDefinition() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v13) {
			return A2(
				$stil4m$elm_syntax$Combine$andMap,
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation(),
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						A2(
							$stil4m$elm_syntax$Combine$continueWith,
							$stil4m$elm_syntax$Combine$string(':'),
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout)))),
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout)),
					$stil4m$elm_syntax$Combine$succeed($elm$core$Tuple$pair)));
		});
}
function $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldsTypeAnnotation() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v12) {
			return A2(
				$stil4m$elm_syntax$Combine$sepBy,
				$stil4m$elm_syntax$Combine$string(','),
				$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
					$stil4m$elm_syntax$Elm$Parser$Node$parser(
						$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldDefinition())));
		});
}
function $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordTypeAnnotation() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v11) {
			var nextField = A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout,
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation(),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$string(':'),
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
								A2(
									$stil4m$elm_syntax$Combine$andMap,
									$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
									A2(
										$stil4m$elm_syntax$Combine$ignore,
										$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
										A2(
											$stil4m$elm_syntax$Combine$ignore,
											$stil4m$elm_syntax$Combine$string(','),
											$stil4m$elm_syntax$Combine$succeed(
												F2(
													function (a, b) {
														return _Utils_Tuple2(a, b);
													}))))))))));
			var additionalRecordFields = function (items) {
				return $stil4m$elm_syntax$Combine$choice(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Combine$andThen,
							function (next) {
								return additionalRecordFields(
									A2($elm$core$List$cons, next, items));
							},
							$stil4m$elm_syntax$Elm$Parser$Node$parser(nextField)),
							$stil4m$elm_syntax$Combine$succeed(
							$elm$core$List$reverse(items))
						]));
			};
			return $stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								A2(
								$stil4m$elm_syntax$Combine$continueWith,
								$stil4m$elm_syntax$Combine$succeed(
									$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(_List_Nil)),
								$stil4m$elm_syntax$Combine$string('}')),
								A2(
								$stil4m$elm_syntax$Combine$andThen,
								function (fname) {
									return $stil4m$elm_syntax$Combine$choice(
										_List_fromArray(
											[
												A2(
												$stil4m$elm_syntax$Combine$ignore,
												$stil4m$elm_syntax$Combine$string('}'),
												A2(
													$stil4m$elm_syntax$Combine$andMap,
													$stil4m$elm_syntax$Elm$Parser$Node$parser(
														$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldsTypeAnnotation()),
													A2(
														$stil4m$elm_syntax$Combine$ignore,
														$stil4m$elm_syntax$Combine$string('|'),
														$stil4m$elm_syntax$Combine$succeed(
															$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord(fname))))),
												A2(
												$stil4m$elm_syntax$Combine$ignore,
												$stil4m$elm_syntax$Combine$string('}'),
												A2(
													$stil4m$elm_syntax$Combine$andThen,
													function (ta) {
														return A2(
															$stil4m$elm_syntax$Combine$map,
															$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record,
															additionalRecordFields(
																_List_fromArray(
																	[
																		A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $elm$core$Tuple$pair, fname, ta)
																	])));
													},
													A2(
														$stil4m$elm_syntax$Combine$ignore,
														$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
														A2(
															$stil4m$elm_syntax$Combine$continueWith,
															$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation(),
															A2(
																$stil4m$elm_syntax$Combine$ignore,
																$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
																$stil4m$elm_syntax$Combine$string(':'))))))
											]));
								},
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
									$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName)))
							])),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Combine$string('{'))));
		});
}
function $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v8) {
			return A2(
				$stil4m$elm_syntax$Combine$andThen,
				function (typeRef) {
					return A2(
						$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayoutWith,
						function (_v9) {
							return $stil4m$elm_syntax$Combine$succeed(typeRef);
						},
						function (_v10) {
							return A2(
								$stil4m$elm_syntax$Combine$or,
								A2(
									$stil4m$elm_syntax$Combine$map,
									function (ta) {
										return A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation, typeRef, ta);
									},
									A2(
										$stil4m$elm_syntax$Combine$continueWith,
										$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation(),
										A2(
											$stil4m$elm_syntax$Combine$ignore,
											$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
											$stil4m$elm_syntax$Combine$string('->')))),
								$stil4m$elm_syntax$Combine$succeed(typeRef));
						});
				},
				$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotationNoFn(0));
		});
}
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$parensTypeAnnotation = $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$parensTypeAnnotation();
$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$parensTypeAnnotation = function () {
	return $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$parensTypeAnnotation;
};
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$recordFieldDefinition = $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldDefinition();
$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldDefinition = function () {
	return $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$recordFieldDefinition;
};
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$recordFieldsTypeAnnotation = $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldsTypeAnnotation();
$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordFieldsTypeAnnotation = function () {
	return $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$recordFieldsTypeAnnotation;
};
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$recordTypeAnnotation = $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordTypeAnnotation();
$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$recordTypeAnnotation = function () {
	return $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$recordTypeAnnotation;
};
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotation = $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation();
$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$cyclic$typeAnnotation = function () {
	return $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotation;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$functionSignatureFromVarPointer = function (varPointer) {
	return A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotation,
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
			A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Combine$string(':'),
				$stil4m$elm_syntax$Combine$succeed(
					function (ta) {
						return A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $stil4m$elm_syntax$Elm$Syntax$Signature$Signature, varPointer, ta);
					}))));
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$GLSLExpression = function (a) {
	return {$: 23, a: a};
};
var $elm$parser$Parser$NotNestable = 0;
var $stil4m$elm_syntax$Elm$Parser$Declarations$glslExpression = function () {
	var start = '[glsl|';
	var end = '|]';
	return $stil4m$elm_syntax$Elm$Parser$Node$parser(
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Combine$string(end),
			A2(
				$stil4m$elm_syntax$Combine$map,
				A2(
					$elm$core$Basics$composeR,
					$elm$core$String$dropLeft(
						$elm$core$String$length(start)),
					$stil4m$elm_syntax$Elm$Syntax$Expression$GLSLExpression),
				$stil4m$elm_syntax$Combine$fromCore(
					$elm$parser$Parser$getChompedString(
						A3($elm$parser$Parser$multiComment, start, end, 0))))));
}();
var $stil4m$elm_syntax$Elm$Parser$Tokens$ifToken = $stil4m$elm_syntax$Combine$string('if');
var $stil4m$elm_syntax$Elm$Parser$Tokens$allowedOperatorTokens = _List_fromArray(
	['+', '-', ':', '/', '*', '>', '<', '=', '/', '&', '^', '%', '|', '!', '.', '#', '$', '≡', '~', '?', '@']);
var $stil4m$elm_syntax$Elm$Parser$Tokens$excludedOperators = _List_fromArray(
	[':', '->', '--', '=']);
var $stil4m$elm_syntax$Combine$Char$oneOf = function (cs) {
	return A2(
		$stil4m$elm_syntax$Combine$andThen,
		A2(
			$elm$core$Basics$composeR,
			$elm$core$Maybe$map($stil4m$elm_syntax$Combine$succeed),
			$elm$core$Maybe$withDefault(
				$stil4m$elm_syntax$Combine$fail(
					'expected one of \'' + ($elm$core$String$fromList(cs) + '\'')))),
		$stil4m$elm_syntax$Combine$Char$satisfy(
			function (a) {
				return A2($elm$core$List$member, a, cs);
			}));
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$operatorTokenFromList = function (allowedChars) {
	return A2(
		$stil4m$elm_syntax$Combine$andThen,
		function (m) {
			return A2($elm$core$List$member, m, $stil4m$elm_syntax$Elm$Parser$Tokens$excludedOperators) ? $stil4m$elm_syntax$Combine$fail('operator is not allowed') : $stil4m$elm_syntax$Combine$succeed(m);
		},
		A2(
			$stil4m$elm_syntax$Combine$map,
			$elm$core$String$fromList,
			$stil4m$elm_syntax$Combine$many1(
				$stil4m$elm_syntax$Combine$Char$oneOf(allowedChars))));
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$infixOperatorToken = $stil4m$elm_syntax$Elm$Parser$Tokens$operatorTokenFromList($stil4m$elm_syntax$Elm$Parser$Tokens$allowedOperatorTokens);
var $stil4m$elm_syntax$Elm$Parser$Layout$layoutStrict = A2(
	$stil4m$elm_syntax$Combine$continueWith,
	$stil4m$elm_syntax$Elm$Parser$Layout$verifyIndent(
		F2(
			function (stateIndent, current) {
				return _Utils_eq(stateIndent, current);
			})),
	$stil4m$elm_syntax$Combine$many1(
		$stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					$stil4m$elm_syntax$Elm$Parser$Layout$anyComment,
					A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$succeed(0),
					$stil4m$elm_syntax$Combine$many1($stil4m$elm_syntax$Elm$Parser$Whitespace$realNewLine)),
					$stil4m$elm_syntax$Elm$Parser$Whitespace$many1Spaces
				]))));
var $stil4m$elm_syntax$Elm$Parser$Declarations$liftRecordAccess = function (e) {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v0) {
			return A2(
				$stil4m$elm_syntax$Combine$or,
				A2(
					$stil4m$elm_syntax$Combine$andThen,
					$stil4m$elm_syntax$Elm$Parser$Declarations$liftRecordAccess,
					A2(
						$stil4m$elm_syntax$Combine$map,
						function (f) {
							return A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccess, e, f);
						},
						A2(
							$stil4m$elm_syntax$Combine$continueWith,
							$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
							$stil4m$elm_syntax$Combine$string('.')))),
				$stil4m$elm_syntax$Combine$succeed(e));
		});
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$multiLineStringLiteral = function () {
	var helper = function (s) {
		return s.H ? A2(
			$elm$parser$Parser$map,
			function (v) {
				return $elm$parser$Parser$Loop(
					_Utils_update(
						s,
						{
							H: false,
							l: A2(
								$elm$core$List$cons,
								$elm$core$String$fromChar(v),
								s.l)
						}));
			},
			$stil4m$elm_syntax$Elm$Parser$Tokens$escapedCharValue) : $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(
							$elm$core$String$concat(
								$elm$core$List$reverse(s.l)));
					},
					$elm$parser$Parser$symbol('\"\"\"')),
					A2(
					$elm$parser$Parser$map,
					function (v) {
						return $elm$parser$Parser$Loop(
							_Utils_update(
								s,
								{
									Q: s.Q + 1,
									l: A2($elm$core$List$cons, v, s.l)
								}));
					},
					$elm$parser$Parser$getChompedString(
						$elm$parser$Parser$symbol('\"'))),
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						return $elm$parser$Parser$Loop(
							_Utils_update(
								s,
								{Q: s.Q + 1, H: true, l: s.l}));
					},
					$elm$parser$Parser$getChompedString(
						$elm$parser$Parser$symbol('\\'))),
					A2(
					$elm$parser$Parser$andThen,
					function (_v2) {
						var start = _v2.a;
						var value = _v2.b;
						var end = _v2.c;
						return _Utils_eq(start, end) ? $elm$parser$Parser$problem('Expected a string character or a triple double quote') : $elm$parser$Parser$succeed(
							$elm$parser$Parser$Loop(
								_Utils_update(
									s,
									{
										Q: s.Q + 1,
										l: A2($elm$core$List$cons, value, s.l)
									})));
					},
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$keeper,
							A2(
								$elm$parser$Parser$keeper,
								$elm$parser$Parser$succeed(
									F3(
										function (start, value, end) {
											return _Utils_Tuple3(start, value, end);
										})),
								$elm$parser$Parser$getOffset),
							$elm$parser$Parser$getChompedString(
								$elm$parser$Parser$chompWhile(
									function (c) {
										return (c !== '\"') && (c !== '\\');
									}))),
						$elm$parser$Parser$getOffset))
				]));
	};
	return $stil4m$elm_syntax$Combine$fromCore(
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed($elm$core$Basics$identity),
				$elm$parser$Parser$symbol('\"\"\"')),
			A2(
				$elm$parser$Parser$loop,
				{Q: 0, H: false, l: _List_Nil},
				helper)));
}();
var $stil4m$elm_syntax$Elm$Parser$Declarations$literalExpression = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return $stil4m$elm_syntax$Elm$Parser$Node$parser(
			A2(
				$stil4m$elm_syntax$Combine$map,
				$stil4m$elm_syntax$Elm$Syntax$Expression$Literal,
				A2($stil4m$elm_syntax$Combine$or, $stil4m$elm_syntax$Elm$Parser$Tokens$multiLineStringLiteral, $stil4m$elm_syntax$Elm$Parser$Tokens$stringLiteral)));
	});
var $stil4m$elm_syntax$Combine$loop = F2(
	function (init, stepper) {
		var wrapper = function (_v3) {
			var oldState = _v3.a;
			var v = _v3.b;
			var _v0 = stepper(v);
			var p = _v0;
			return A2(
				$elm$parser$Parser$map,
				function (_v1) {
					var newState = _v1.a;
					var r = _v1.b;
					if (!r.$) {
						var l = r.a;
						return $elm$parser$Parser$Loop(
							_Utils_Tuple2(newState, l));
					} else {
						var d = r.a;
						return $elm$parser$Parser$Done(
							_Utils_Tuple2(newState, d));
					}
				},
				p(oldState));
		};
		return function (state) {
			return A2(
				$elm$parser$Parser$loop,
				_Utils_Tuple2(state, init),
				wrapper);
		};
	});
var $stil4m$elm_syntax$Elm$Parser$Whitespace$manySpaces = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$chompWhile(
		function (c) {
			return c === ' ';
		}));
var $stil4m$elm_syntax$Elm$Syntax$Expression$Floatable = function (a) {
	return {$: 9, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$Hex = function (a) {
	return {$: 8, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$Integer = function (a) {
	return {$: 7, a: a};
};
var $stil4m$elm_syntax$Elm$Parser$Numbers$forgivingNumber = F3(
	function (floatf, intf, hexf) {
		return $stil4m$elm_syntax$Combine$fromCore(
			$elm$parser$Parser$backtrackable(
				A3($stil4m$elm_syntax$Elm$Parser$Numbers$raw, floatf, intf, hexf)));
	});
var $stil4m$elm_syntax$Elm$Parser$Declarations$numberExpression = $stil4m$elm_syntax$Elm$Parser$Node$parser(
	A3($stil4m$elm_syntax$Elm$Parser$Numbers$forgivingNumber, $stil4m$elm_syntax$Elm$Syntax$Expression$Floatable, $stil4m$elm_syntax$Elm$Syntax$Expression$Integer, $stil4m$elm_syntax$Elm$Syntax$Expression$Hex));
var $stil4m$elm_syntax$Elm$Parser$Tokens$ofToken = $stil4m$elm_syntax$Combine$string('of');
var $stil4m$elm_syntax$Elm$Parser$Tokens$allowedPrefixOperatorTokens = A2($elm$core$List$cons, ',', $stil4m$elm_syntax$Elm$Parser$Tokens$allowedOperatorTokens);
var $stil4m$elm_syntax$Elm$Parser$Tokens$prefixOperatorToken = $stil4m$elm_syntax$Elm$Parser$Tokens$operatorTokenFromList($stil4m$elm_syntax$Elm$Parser$Tokens$allowedPrefixOperatorTokens);
var $stil4m$elm_syntax$Elm$Syntax$Node$range = function (_v0) {
	var r = _v0.a;
	return r;
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccessFunction = function (a) {
	return {$: 21, a: a};
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$recordAccessFunctionExpression = $stil4m$elm_syntax$Elm$Parser$Node$parser(
	A2(
		$stil4m$elm_syntax$Combine$map,
		A2(
			$elm$core$Basics$composeR,
			$elm$core$Basics$append('.'),
			$stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccessFunction),
		A2(
			$stil4m$elm_syntax$Combine$continueWith,
			$stil4m$elm_syntax$Elm$Parser$Tokens$functionName,
			$stil4m$elm_syntax$Combine$string('.'))));
var $stil4m$elm_syntax$Elm$Parser$Declarations$reference = function () {
	var justFunction = A2(
		$stil4m$elm_syntax$Combine$map,
		function (v) {
			return _Utils_Tuple2(_List_Nil, v);
		},
		$stil4m$elm_syntax$Elm$Parser$Tokens$functionName);
	var helper = function (_v0) {
		var n = _v0.a;
		var xs = _v0.b;
		return $stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								A2(
								$stil4m$elm_syntax$Combine$andThen,
								function (t) {
									return helper(
										_Utils_Tuple2(
											t,
											A2($elm$core$List$cons, n, xs)));
								},
								$stil4m$elm_syntax$Elm$Parser$Tokens$typeName),
								A2(
								$stil4m$elm_syntax$Combine$map,
								function (t) {
									return _Utils_Tuple2(
										t,
										A2($elm$core$List$cons, n, xs));
								},
								$stil4m$elm_syntax$Elm$Parser$Tokens$functionName)
							])),
					$stil4m$elm_syntax$Combine$string('.')),
					$stil4m$elm_syntax$Combine$succeed(
					_Utils_Tuple2(n, xs))
				]));
	};
	var recurring = A2(
		$stil4m$elm_syntax$Combine$map,
		function (_v1) {
			var t = _v1.a;
			var xs = _v1.b;
			return _Utils_Tuple2(
				$elm$core$List$reverse(xs),
				t);
		},
		A2(
			$stil4m$elm_syntax$Combine$andThen,
			function (t) {
				return helper(
					_Utils_Tuple2(t, _List_Nil));
			},
			$stil4m$elm_syntax$Elm$Parser$Tokens$typeName));
	return $stil4m$elm_syntax$Combine$choice(
		_List_fromArray(
			[recurring, justFunction]));
}();
var $stil4m$elm_syntax$Elm$Parser$Declarations$referenceExpression = $stil4m$elm_syntax$Elm$Parser$Node$parser(
	A2(
		$stil4m$elm_syntax$Combine$map,
		function (_v0) {
			var xs = _v0.a;
			var x = _v0.b;
			return A2($stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue, xs, x);
		},
		$stil4m$elm_syntax$Elm$Parser$Declarations$reference));
var $stil4m$elm_syntax$Elm$Parser$Tokens$thenToken = $stil4m$elm_syntax$Combine$string('then');
var $stil4m$elm_syntax$Elm$Parser$Ranges$asPointerLocation = function (_v0) {
	var line = _v0.ap;
	var column = _v0.bP;
	return {bP: column, bo: line};
};
var $stil4m$elm_syntax$Elm$Parser$Ranges$withCurrentPoint = function (p) {
	return $stil4m$elm_syntax$Combine$withLocation(
		function (start) {
			var k = $stil4m$elm_syntax$Elm$Parser$Ranges$asPointerLocation(start);
			return p(
				{a6: k, br: k});
		});
};
var $stil4m$elm_syntax$Elm$Parser$State$popIndent = function (_v0) {
	var s = _v0;
	return _Utils_update(
		s,
		{
			T: A2($elm$core$List$drop, 1, s.T)
		});
};
var $stil4m$elm_syntax$Elm$Parser$State$pushIndent = F2(
	function (x, _v0) {
		var s = _v0;
		return _Utils_update(
			s,
			{
				T: A2($elm$core$List$cons, x, s.T)
			});
	});
var $stil4m$elm_syntax$Elm$Parser$State$pushColumn = F2(
	function (col, state) {
		return A2($stil4m$elm_syntax$Elm$Parser$State$pushIndent, col - 1, state);
	});
var $stil4m$elm_syntax$Elm$Parser$Declarations$withIndentedState = function (p) {
	return $stil4m$elm_syntax$Combine$withLocation(
		function (location) {
			return A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Combine$modifyState($stil4m$elm_syntax$Elm$Parser$State$popIndent),
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					p,
					$stil4m$elm_syntax$Combine$modifyState(
						$stil4m$elm_syntax$Elm$Parser$State$pushColumn(location.bP))));
		});
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$functionWithNameNode = function (pointer) {
	var functionImplementationFromVarPointer = function (varPointer) {
		return A2(
			$stil4m$elm_syntax$Combine$andMap,
			$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
			A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$string('='),
					A2(
						$stil4m$elm_syntax$Combine$andMap,
						$stil4m$elm_syntax$Combine$many(
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
								$stil4m$elm_syntax$Elm$Parser$Declarations$functionArgument)),
						$stil4m$elm_syntax$Combine$succeed(
							F2(
								function (args, expr) {
									return A2(
										$stil4m$elm_syntax$Elm$Syntax$Node$Node,
										$stil4m$elm_syntax$Elm$Syntax$Range$combine(
											_List_fromArray(
												[
													$stil4m$elm_syntax$Elm$Syntax$Node$range(varPointer),
													$stil4m$elm_syntax$Elm$Syntax$Node$range(expr)
												])),
										A3($stil4m$elm_syntax$Elm$Syntax$Expression$FunctionImplementation, varPointer, args, expr));
								}))))));
	};
	var functionWithoutSignature = function (varPointer) {
		return A2(
			$stil4m$elm_syntax$Combine$map,
			A2($stil4m$elm_syntax$Elm$Syntax$Expression$Function, $elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing),
			functionImplementationFromVarPointer(varPointer));
	};
	var fromParts = F2(
		function (sig, decl) {
			return {
				bX: decl,
				aw: $elm$core$Maybe$Nothing,
				db: $elm$core$Maybe$Just(sig)
			};
		});
	var functionWithSignature = function (varPointer) {
		return A2(
			$stil4m$elm_syntax$Combine$andThen,
			function (sig) {
				return A2(
					$stil4m$elm_syntax$Combine$map,
					fromParts(sig),
					A2(
						$stil4m$elm_syntax$Combine$andThen,
						functionImplementationFromVarPointer,
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							A2(
								$stil4m$elm_syntax$Combine$continueWith,
								$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layoutStrict)))));
			},
			$stil4m$elm_syntax$Elm$Parser$Declarations$functionSignatureFromVarPointer(varPointer));
	};
	return $stil4m$elm_syntax$Combine$choice(
		_List_fromArray(
			[
				functionWithSignature(pointer),
				functionWithoutSignature(pointer)
			]));
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$letDestructuringDeclarationWithPattern = function (p) {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v7) {
			return A2(
				$stil4m$elm_syntax$Combine$andMap,
				$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$string('='),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							$stil4m$elm_syntax$Combine$succeed(
								$stil4m$elm_syntax$Elm$Syntax$Expression$LetDestructuring(p))))));
		});
};
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseBlock() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v25) {
			return A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Elm$Parser$Tokens$ofToken,
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
					A2($stil4m$elm_syntax$Combine$continueWith, $stil4m$elm_syntax$Elm$Parser$Layout$layout, $stil4m$elm_syntax$Elm$Parser$Tokens$caseToken)));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseExpression() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v23) {
			return A2(
				$stil4m$elm_syntax$Combine$andThen,
				function (_v24) {
					var start = _v24.a;
					return A2(
						$stil4m$elm_syntax$Combine$map,
						function (cb) {
							return A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								$stil4m$elm_syntax$Elm$Syntax$Range$combine(
									A2(
										$elm$core$List$cons,
										start,
										A2(
											$elm$core$List$map,
											A2($elm$core$Basics$composeR, $elm$core$Tuple$second, $stil4m$elm_syntax$Elm$Syntax$Node$range),
											cb.ai))),
								$stil4m$elm_syntax$Elm$Syntax$Expression$CaseExpression(cb));
						},
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							A2(
								$stil4m$elm_syntax$Combine$continueWith,
								$stil4m$elm_syntax$Elm$Parser$Declarations$withIndentedState(
									$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatements()),
								$stil4m$elm_syntax$Elm$Parser$Layout$layout),
							A2(
								$stil4m$elm_syntax$Combine$andMap,
								$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseBlock(),
								$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$Expression$CaseBlock))));
				},
				$stil4m$elm_syntax$Elm$Parser$Node$parser(
					$stil4m$elm_syntax$Combine$succeed(0)));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatement() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v22) {
			return A2(
				$stil4m$elm_syntax$Combine$andMap,
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						A2(
							$stil4m$elm_syntax$Combine$continueWith,
							$stil4m$elm_syntax$Combine$string('->'),
							$stil4m$elm_syntax$Combine$maybe(
								A2($stil4m$elm_syntax$Combine$or, $stil4m$elm_syntax$Elm$Parser$Layout$layout, $stil4m$elm_syntax$Elm$Parser$Layout$layoutStrict))))),
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					$stil4m$elm_syntax$Elm$Parser$Patterns$pattern,
					$stil4m$elm_syntax$Combine$succeed($elm$core$Tuple$pair)));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatements() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v21) {
			var helper = function (last) {
				return $stil4m$elm_syntax$Combine$withState(
					function (s) {
						return $stil4m$elm_syntax$Combine$withLocation(
							function (l) {
								return _Utils_eq(
									$stil4m$elm_syntax$Elm$Parser$State$expectedColumn(s),
									l.bP) ? $stil4m$elm_syntax$Combine$choice(
									_List_fromArray(
										[
											A2(
											$stil4m$elm_syntax$Combine$map,
											function (c) {
												return $stil4m$elm_syntax$Combine$Loop(
													A2($elm$core$List$cons, c, last));
											},
											$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatement()),
											$stil4m$elm_syntax$Combine$succeed(
											$stil4m$elm_syntax$Combine$Done(
												$elm$core$List$reverse(last)))
										])) : $stil4m$elm_syntax$Combine$succeed(
									$stil4m$elm_syntax$Combine$Done(
										$elm$core$List$reverse(last)));
							});
					});
			};
			return A2(
				$stil4m$elm_syntax$Combine$andThen,
				function (v) {
					return A2($stil4m$elm_syntax$Combine$loop, v, helper);
				},
				A2(
					$stil4m$elm_syntax$Combine$map,
					$elm$core$List$singleton,
					$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatement()));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v15) {
			return A2(
				$stil4m$elm_syntax$Combine$andThen,
				function (first) {
					var complete = function (rest) {
						if (!rest.b) {
							return $stil4m$elm_syntax$Combine$succeed(first);
						} else {
							if (rest.a.b.$ === 6) {
								var _v20 = rest.a;
								return $stil4m$elm_syntax$Combine$fail('Expression should not end with an operator');
							} else {
								return $stil4m$elm_syntax$Combine$succeed(
									A2(
										$stil4m$elm_syntax$Elm$Syntax$Node$Node,
										$stil4m$elm_syntax$Elm$Syntax$Range$combine(
											A2(
												$elm$core$List$cons,
												$stil4m$elm_syntax$Elm$Syntax$Node$range(first),
												A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Syntax$Node$range, rest))),
										$stil4m$elm_syntax$Elm$Syntax$Expression$Application(
											A2(
												$elm$core$List$cons,
												first,
												$elm$core$List$reverse(rest)))));
							}
						}
					};
					var promoter = function (rest) {
						return A2(
							$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayoutWith,
							function (_v16) {
								return complete(rest);
							},
							function (_v17) {
								return A2(
									$stil4m$elm_syntax$Combine$or,
									A2(
										$stil4m$elm_syntax$Combine$andThen,
										function (next) {
											return promoter(
												A2($elm$core$List$cons, next, rest));
										},
										$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expressionNotApplication()),
									complete(rest));
							});
					};
					if (first.b.$ === 6) {
						return $stil4m$elm_syntax$Combine$fail('Expression should not start with an operator');
					} else {
						return promoter(_List_Nil);
					}
				},
				$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expressionNotApplication());
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expressionNotApplication() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v14) {
			return A2(
				$stil4m$elm_syntax$Combine$andThen,
				$stil4m$elm_syntax$Elm$Parser$Declarations$liftRecordAccess,
				$stil4m$elm_syntax$Combine$choice(
					_List_fromArray(
						[
							$stil4m$elm_syntax$Elm$Parser$Declarations$numberExpression,
							$stil4m$elm_syntax$Elm$Parser$Declarations$referenceExpression,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$ifBlockExpression(),
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$tupledExpression(),
							$stil4m$elm_syntax$Elm$Parser$Declarations$recordAccessFunctionExpression,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$operatorExpression(),
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letExpression(),
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$lambdaExpression(),
							$stil4m$elm_syntax$Elm$Parser$Declarations$literalExpression,
							$stil4m$elm_syntax$Elm$Parser$Declarations$charLiteralExpression,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$recordExpression(),
							$stil4m$elm_syntax$Elm$Parser$Declarations$glslExpression,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$listExpression(),
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseExpression()
						])));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$ifBlockExpression() {
	return $stil4m$elm_syntax$Elm$Parser$Ranges$withCurrentPoint(
		function (current) {
			return A2(
				$stil4m$elm_syntax$Combine$continueWith,
				$stil4m$elm_syntax$Combine$lazy(
					function (_v13) {
						return A2(
							$stil4m$elm_syntax$Combine$andMap,
							A2(
								$stil4m$elm_syntax$Combine$continueWith,
								$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
								A2($stil4m$elm_syntax$Combine$continueWith, $stil4m$elm_syntax$Elm$Parser$Layout$layout, $stil4m$elm_syntax$Elm$Parser$Tokens$elseToken)),
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
								A2(
									$stil4m$elm_syntax$Combine$andMap,
									$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
									A2(
										$stil4m$elm_syntax$Combine$ignore,
										$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
										A2(
											$stil4m$elm_syntax$Combine$ignore,
											$stil4m$elm_syntax$Elm$Parser$Tokens$thenToken,
											A2(
												$stil4m$elm_syntax$Combine$ignore,
												$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
												A2(
													$stil4m$elm_syntax$Combine$andMap,
													$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
													A2(
														$stil4m$elm_syntax$Combine$ignore,
														$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
														$stil4m$elm_syntax$Combine$succeed(
															F3(
																function (condition, ifTrue, ifFalse) {
																	return A2(
																		$stil4m$elm_syntax$Elm$Syntax$Node$Node,
																		{
																			a6: $stil4m$elm_syntax$Elm$Syntax$Node$range(ifFalse).a6,
																			br: current.br
																		},
																		A3($stil4m$elm_syntax$Elm$Syntax$Expression$IfBlock, condition, ifTrue, ifFalse));
																}))))))))));
					}),
				$stil4m$elm_syntax$Elm$Parser$Tokens$ifToken);
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$lambdaExpression() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v12) {
			return $stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
						$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
							$stil4m$elm_syntax$Combine$string('->'))),
					A2(
						$stil4m$elm_syntax$Combine$andMap,
						A2(
							$stil4m$elm_syntax$Combine$sepBy1,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							$stil4m$elm_syntax$Elm$Parser$Declarations$functionArgument),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$string('\\'),
								$stil4m$elm_syntax$Combine$succeed(
									F2(
										function (args, expr) {
											return $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
												A2($stil4m$elm_syntax$Elm$Syntax$Expression$Lambda, args, expr));
										})))))));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBlock() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v11) {
			return A2(
				$stil4m$elm_syntax$Combine$ignore,
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$string('in'),
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[$stil4m$elm_syntax$Elm$Parser$Layout$layout, $stil4m$elm_syntax$Elm$Parser$Whitespace$manySpaces]))),
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Elm$Parser$Declarations$withIndentedState(
						$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBody()),
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$Layout$layout,
						$stil4m$elm_syntax$Combine$string('let'))));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBody() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v8) {
			var blockElement = A2(
				$stil4m$elm_syntax$Combine$andThen,
				function (_v9) {
					var r = _v9.a;
					var p = _v9.b;
					if (p.$ === 11) {
						var v = p.a;
						return A2(
							$stil4m$elm_syntax$Combine$map,
							$stil4m$elm_syntax$Elm$Syntax$Expression$LetFunction,
							$stil4m$elm_syntax$Elm$Parser$Declarations$functionWithNameNode(
								A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, v)));
					} else {
						return $stil4m$elm_syntax$Elm$Parser$Declarations$letDestructuringDeclarationWithPattern(
							A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, p));
					}
				},
				$stil4m$elm_syntax$Elm$Parser$Patterns$pattern);
			return A2(
				$stil4m$elm_syntax$Combine$andMap,
				$stil4m$elm_syntax$Combine$many(
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Elm$Parser$Node$parser(blockElement))),
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					$stil4m$elm_syntax$Elm$Parser$Node$parser(blockElement),
					$stil4m$elm_syntax$Combine$succeed($elm$core$List$cons)));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letExpression() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v6) {
			return $stil4m$elm_syntax$Elm$Parser$Ranges$withCurrentPoint(
				function (current) {
					return A2(
						$stil4m$elm_syntax$Combine$andMap,
						A2(
							$stil4m$elm_syntax$Combine$continueWith,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
							$stil4m$elm_syntax$Elm$Parser$Layout$layout),
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBlock(),
							$stil4m$elm_syntax$Combine$succeed(
								F2(
									function (decls, expr) {
										return A2(
											$stil4m$elm_syntax$Elm$Syntax$Node$Node,
											{
												a6: $stil4m$elm_syntax$Elm$Syntax$Node$range(expr).a6,
												br: current.br
											},
											$stil4m$elm_syntax$Elm$Syntax$Expression$LetExpression(
												A2($stil4m$elm_syntax$Elm$Syntax$Expression$LetBlock, decls, expr)));
									}))));
				});
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$listExpression() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v5) {
			var innerExpressions = A2(
				$stil4m$elm_syntax$Combine$map,
				$stil4m$elm_syntax$Elm$Syntax$Expression$ListExpr,
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					$stil4m$elm_syntax$Combine$many(
						A2(
							$stil4m$elm_syntax$Combine$continueWith,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
								$stil4m$elm_syntax$Combine$string(',')))),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
							$stil4m$elm_syntax$Combine$succeed($elm$core$List$cons)))));
			return $stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								A2(
								$stil4m$elm_syntax$Combine$map,
								$elm$core$Basics$always(
									$stil4m$elm_syntax$Elm$Syntax$Expression$ListExpr(_List_Nil)),
								$stil4m$elm_syntax$Combine$string(']')),
								A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$string(']'),
								innerExpressions)
							])),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Combine$string('['))));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$operatorExpression() {
	var negationExpression = $stil4m$elm_syntax$Combine$lazy(
		function (_v4) {
			return A2(
				$stil4m$elm_syntax$Combine$map,
				$stil4m$elm_syntax$Elm$Syntax$Expression$Negation,
				A2(
					$stil4m$elm_syntax$Combine$andThen,
					$stil4m$elm_syntax$Elm$Parser$Declarations$liftRecordAccess,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								$stil4m$elm_syntax$Elm$Parser$Declarations$referenceExpression,
								$stil4m$elm_syntax$Elm$Parser$Declarations$numberExpression,
								$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$tupledExpression()
							]))));
		});
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v3) {
			return $stil4m$elm_syntax$Combine$choice(
				_List_fromArray(
					[
						$stil4m$elm_syntax$Elm$Parser$Node$parser(
						A2(
							$stil4m$elm_syntax$Combine$continueWith,
							$stil4m$elm_syntax$Combine$choice(
								_List_fromArray(
									[
										negationExpression,
										A2(
										$stil4m$elm_syntax$Combine$ignore,
										$stil4m$elm_syntax$Elm$Parser$Layout$layout,
										$stil4m$elm_syntax$Combine$succeed(
											$stil4m$elm_syntax$Elm$Syntax$Expression$Operator('-')))
									])),
							$stil4m$elm_syntax$Combine$string('-'))),
						$stil4m$elm_syntax$Elm$Parser$Node$parser(
						A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Expression$Operator, $stil4m$elm_syntax$Elm$Parser$Tokens$infixOperatorToken))
					]));
		});
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$recordExpression() {
	return $stil4m$elm_syntax$Elm$Parser$Node$parser(
		$stil4m$elm_syntax$Combine$lazy(
			function (_v2) {
				var recordField = $stil4m$elm_syntax$Elm$Parser$Node$parser(
					A2(
						$stil4m$elm_syntax$Combine$andMap,
						$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$string('='),
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
									A2(
										$stil4m$elm_syntax$Combine$andMap,
										$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
										$stil4m$elm_syntax$Combine$succeed($elm$core$Tuple$pair)))))));
				var recordFields = A2(
					$stil4m$elm_syntax$Combine$andMap,
					$stil4m$elm_syntax$Combine$many(
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							A2(
								$stil4m$elm_syntax$Combine$continueWith,
								recordField,
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
									$stil4m$elm_syntax$Combine$string(','))))),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							recordField,
							$stil4m$elm_syntax$Combine$succeed($elm$core$List$cons))));
				var recordUpdateSyntaxParser = function (fname) {
					return A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$string('}'),
						A2(
							$stil4m$elm_syntax$Combine$map,
							function (e) {
								return A2($stil4m$elm_syntax$Elm$Syntax$Expression$RecordUpdateExpression, fname, e);
							},
							A2(
								$stil4m$elm_syntax$Combine$continueWith,
								recordFields,
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
									$stil4m$elm_syntax$Combine$string('|')))));
				};
				var recordContents = A2(
					$stil4m$elm_syntax$Combine$andThen,
					function (fname) {
						return $stil4m$elm_syntax$Combine$choice(
							_List_fromArray(
								[
									recordUpdateSyntaxParser(fname),
									A2(
									$stil4m$elm_syntax$Combine$andThen,
									function (fieldUpdate) {
										return $stil4m$elm_syntax$Combine$choice(
											_List_fromArray(
												[
													A2(
													$stil4m$elm_syntax$Combine$map,
													$elm$core$Basics$always(
														$stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr(
															_List_fromArray(
																[fieldUpdate]))),
													$stil4m$elm_syntax$Combine$string('}')),
													A2(
													$stil4m$elm_syntax$Combine$ignore,
													$stil4m$elm_syntax$Combine$string('}'),
													A2(
														$stil4m$elm_syntax$Combine$map,
														function (fieldUpdates) {
															return $stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr(
																A2($elm$core$List$cons, fieldUpdate, fieldUpdates));
														},
														A2(
															$stil4m$elm_syntax$Combine$continueWith,
															recordFields,
															A2(
																$stil4m$elm_syntax$Combine$ignore,
																$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
																$stil4m$elm_syntax$Combine$string(',')))))
												]));
									},
									A2(
										$stil4m$elm_syntax$Combine$ignore,
										$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
										A2(
											$stil4m$elm_syntax$Combine$continueWith,
											A2(
												$stil4m$elm_syntax$Combine$map,
												function (e) {
													return A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $elm$core$Tuple$pair, fname, e);
												},
												$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression()),
											A2(
												$stil4m$elm_syntax$Combine$ignore,
												$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
												$stil4m$elm_syntax$Combine$string('=')))))
								]));
					},
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName)));
				return A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								A2(
								$stil4m$elm_syntax$Combine$map,
								$elm$core$Basics$always(
									$stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr(_List_Nil)),
								$stil4m$elm_syntax$Combine$string('}')),
								recordContents
							])),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
						$stil4m$elm_syntax$Combine$string('{')));
			}));
}
function $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$tupledExpression() {
	return $stil4m$elm_syntax$Combine$lazy(
		function (_v0) {
			var commaSep = $stil4m$elm_syntax$Combine$many(
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
					A2(
						$stil4m$elm_syntax$Combine$continueWith,
						$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							$stil4m$elm_syntax$Combine$string(',')))));
			var closingParen = $stil4m$elm_syntax$Combine$fromCore(
				$elm$parser$Parser$symbol(')'));
			var asExpression = F2(
				function (x, xs) {
					if (!xs.b) {
						return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(x);
					} else {
						return $stil4m$elm_syntax$Elm$Syntax$Expression$TupledExpression(
							A2($elm$core$List$cons, x, xs));
					}
				});
			var nested = A2(
				$stil4m$elm_syntax$Combine$andMap,
				commaSep,
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
					A2(
						$stil4m$elm_syntax$Combine$andMap,
						$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression(),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
							$stil4m$elm_syntax$Combine$succeed(asExpression)))));
			return $stil4m$elm_syntax$Elm$Parser$Node$parser(
				A2(
					$stil4m$elm_syntax$Combine$continueWith,
					$stil4m$elm_syntax$Combine$choice(
						_List_fromArray(
							[
								A2(
								$stil4m$elm_syntax$Combine$map,
								$elm$core$Basics$always($stil4m$elm_syntax$Elm$Syntax$Expression$UnitExpr),
								closingParen),
								$stil4m$elm_syntax$Combine$backtrackable(
								A2(
									$stil4m$elm_syntax$Combine$map,
									$stil4m$elm_syntax$Elm$Syntax$Expression$PrefixOperator,
									A2($stil4m$elm_syntax$Combine$ignore, closingParen, $stil4m$elm_syntax$Elm$Parser$Tokens$prefixOperatorToken))),
								A2($stil4m$elm_syntax$Combine$ignore, closingParen, nested)
							])),
					$stil4m$elm_syntax$Combine$fromCore(
						$elm$parser$Parser$symbol('('))));
		});
}
var $stil4m$elm_syntax$Elm$Parser$Declarations$caseBlock = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseBlock();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseBlock = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$caseBlock;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$caseExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$caseExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$caseStatement = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatement();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatement = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$caseStatement;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$caseStatements = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatements();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$caseStatements = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$caseStatements;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$expression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$expression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$expressionNotApplication = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expressionNotApplication();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$expressionNotApplication = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$expressionNotApplication;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$ifBlockExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$ifBlockExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$ifBlockExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$ifBlockExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$lambdaExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$lambdaExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$lambdaExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$lambdaExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$letBlock = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBlock();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBlock = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$letBlock;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$letBody = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBody();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letBody = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$letBody;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$letExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$letExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$letExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$listExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$listExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$listExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$listExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$operatorExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$operatorExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$operatorExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$operatorExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$recordExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$recordExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$recordExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$recordExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$tupledExpression = $stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$tupledExpression();
$stil4m$elm_syntax$Elm$Parser$Declarations$cyclic$tupledExpression = function () {
	return $stil4m$elm_syntax$Elm$Parser$Declarations$tupledExpression;
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$destructuringDeclaration = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return A2(
			$stil4m$elm_syntax$Combine$andMap,
			$stil4m$elm_syntax$Elm$Parser$Declarations$expression,
			A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Elm$Parser$Layout$layout,
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$string('='),
					A2(
						$stil4m$elm_syntax$Combine$andMap,
						$stil4m$elm_syntax$Elm$Parser$Patterns$pattern,
						$stil4m$elm_syntax$Combine$succeed(
							F2(
								function (x, y) {
									return A3($stil4m$elm_syntax$Elm$Syntax$Node$combine, $stil4m$elm_syntax$Elm$Syntax$Declaration$Destructuring, x, y);
								}))))));
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$functionRange = function (_function) {
	return $stil4m$elm_syntax$Elm$Syntax$Range$combine(
		_List_fromArray(
			[
				function () {
				var _v0 = _function.aw;
				if (!_v0.$) {
					var documentation = _v0.a;
					return $stil4m$elm_syntax$Elm$Syntax$Node$range(documentation);
				} else {
					return A2(
						$elm$core$Maybe$withDefault,
						function (_v3) {
							var r = _v3.a;
							return r;
						}(
							$stil4m$elm_syntax$Elm$Syntax$Node$value(_function.bX).I),
						A2(
							$elm$core$Maybe$map,
							function (_v1) {
								var value = _v1.b;
								var _v2 = value.I;
								var r = _v2.a;
								return r;
							},
							_function.db));
				}
			}(),
				function (_v4) {
				var r = _v4.a;
				return r;
			}(
				$stil4m$elm_syntax$Elm$Syntax$Node$value(_function.bX).b)
			]));
};
var $stil4m$elm_syntax$Elm$Parser$Declarations$function = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return A2(
			$stil4m$elm_syntax$Combine$map,
			function (f) {
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$Node$Node,
					$stil4m$elm_syntax$Elm$Syntax$Expression$functionRange(f),
					$stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(f));
			},
			A2(
				$stil4m$elm_syntax$Combine$andThen,
				$stil4m$elm_syntax$Elm$Parser$Declarations$functionWithNameNode,
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
					$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName))));
	});
var $stil4m$elm_syntax$Elm$Syntax$Declaration$InfixDeclaration = function (a) {
	return {$: 4, a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Infix$Infix = F4(
	function (direction, precedence, operator, _function) {
		return {b1: direction, cl: _function, cW: operator, Y: precedence};
	});
var $stil4m$elm_syntax$Elm$Syntax$Infix$Left = 0;
var $stil4m$elm_syntax$Elm$Syntax$Infix$Non = 2;
var $stil4m$elm_syntax$Elm$Syntax$Infix$Right = 1;
var $stil4m$elm_syntax$Elm$Parser$Infix$infixDirection = $stil4m$elm_syntax$Combine$choice(
	_List_fromArray(
		[
			A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Combine$string('right'),
			$stil4m$elm_syntax$Combine$succeed(1)),
			A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Combine$string('left'),
			$stil4m$elm_syntax$Combine$succeed(0)),
			A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Combine$string('non'),
			$stil4m$elm_syntax$Combine$succeed(2))
		]));
var $elm$parser$Parser$Advanced$int = F2(
	function (expecting, invalid) {
		return $elm$parser$Parser$Advanced$number(
			{
				aY: $elm$core$Result$Err(invalid),
				a7: expecting,
				cf: $elm$core$Result$Err(invalid),
				cq: $elm$core$Result$Err(invalid),
				cv: $elm$core$Result$Ok($elm$core$Basics$identity),
				cy: invalid,
				bg: $elm$core$Result$Err(invalid)
			});
	});
var $elm$parser$Parser$int = A2($elm$parser$Parser$Advanced$int, $elm$parser$Parser$ExpectingInt, $elm$parser$Parser$ExpectingInt);
var $stil4m$elm_syntax$Combine$Num$int = $stil4m$elm_syntax$Combine$fromCore($elm$parser$Parser$int);
var $stil4m$elm_syntax$Elm$Parser$Infix$infixDefinition = A2(
	$stil4m$elm_syntax$Combine$andMap,
	$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
	A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Elm$Parser$Layout$layout,
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Combine$string('='),
			A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Elm$Parser$Layout$layout,
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					$stil4m$elm_syntax$Elm$Parser$Node$parser(
						$stil4m$elm_syntax$Combine$parens($stil4m$elm_syntax$Elm$Parser$Tokens$prefixOperatorToken)),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Elm$Parser$Layout$layout,
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Combine$Num$int),
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Elm$Parser$Layout$layout,
								A2(
									$stil4m$elm_syntax$Combine$andMap,
									$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Infix$infixDirection),
									A2(
										$stil4m$elm_syntax$Combine$ignore,
										$stil4m$elm_syntax$Elm$Parser$Layout$layout,
										A2(
											$stil4m$elm_syntax$Combine$ignore,
											$stil4m$elm_syntax$Combine$fromCore(
												$elm$parser$Parser$keyword('infix')),
											$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$Infix$Infix))))))))))));
var $stil4m$elm_syntax$Elm$Parser$Declarations$infixDeclaration = $stil4m$elm_syntax$Elm$Parser$Ranges$withCurrentPoint(
	function (current) {
		return A2(
			$stil4m$elm_syntax$Combine$map,
			function (inf) {
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$Node$Node,
					$stil4m$elm_syntax$Elm$Syntax$Range$combine(
						_List_fromArray(
							[
								current,
								$stil4m$elm_syntax$Elm$Syntax$Node$range(inf.cl)
							])),
					$stil4m$elm_syntax$Elm$Syntax$Declaration$InfixDeclaration(inf));
			},
			$stil4m$elm_syntax$Elm$Parser$Infix$infixDefinition);
	});
var $stil4m$elm_syntax$Elm$Syntax$Declaration$PortDeclaration = function (a) {
	return {$: 3, a: a};
};
var $stil4m$elm_syntax$Elm$Parser$Tokens$portToken = $stil4m$elm_syntax$Combine$string('port');
var $stil4m$elm_syntax$Elm$Parser$Declarations$signature = A2(
	$stil4m$elm_syntax$Combine$andMap,
	A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotation,
		A2(
			$stil4m$elm_syntax$Combine$continueWith,
			$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
			$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
				$stil4m$elm_syntax$Combine$string(':')))),
	A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName),
		$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$Signature$Signature)));
var $stil4m$elm_syntax$Elm$Parser$Declarations$portDeclaration = $stil4m$elm_syntax$Elm$Parser$Ranges$withCurrentPoint(
	function (current) {
		return A2(
			$stil4m$elm_syntax$Combine$map,
			function (sig) {
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$Node$Node,
					$stil4m$elm_syntax$Elm$Syntax$Range$combine(
						_List_fromArray(
							[
								current,
								function (_v0) {
								var r = _v0.a;
								return r;
							}(sig.aV)
							])),
					$stil4m$elm_syntax$Elm$Syntax$Declaration$PortDeclaration(sig));
			},
			A2(
				$stil4m$elm_syntax$Combine$continueWith,
				$stil4m$elm_syntax$Elm$Parser$Declarations$signature,
				A2($stil4m$elm_syntax$Combine$ignore, $stil4m$elm_syntax$Elm$Parser$Layout$layout, $stil4m$elm_syntax$Elm$Parser$Tokens$portToken)));
	});
var $stil4m$elm_syntax$Elm$Parser$Typings$DefinedAlias = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Parser$Typings$DefinedType = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Type$Type = F4(
	function (documentation, name, generics, constructors) {
		return {bU: constructors, aw: documentation, a9: generics, I: name};
	});
var $stil4m$elm_syntax$Elm$Syntax$TypeAlias$TypeAlias = F4(
	function (documentation, name, generics, typeAnnotation) {
		return {aw: documentation, a9: generics, I: name, aV: typeAnnotation};
	});
var $stil4m$elm_syntax$Elm$Parser$Typings$genericList = $stil4m$elm_syntax$Combine$many(
	A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$functionName)));
var $stil4m$elm_syntax$Elm$Parser$Typings$typePrefix = A2(
	$stil4m$elm_syntax$Combine$continueWith,
	$stil4m$elm_syntax$Elm$Parser$Layout$layout,
	$stil4m$elm_syntax$Combine$string('type'));
var $stil4m$elm_syntax$Elm$Syntax$Type$ValueConstructor = F2(
	function (name, _arguments) {
		return {bG: _arguments, I: name};
	});
var $stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotationNonGreedy = $stil4m$elm_syntax$Combine$choice(
	_List_fromArray(
		[
			$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$parensTypeAnnotation,
			$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typedTypeAnnotation(1),
			$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$genericTypeAnnotation,
			$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$recordTypeAnnotation
		]));
var $stil4m$elm_syntax$Elm$Parser$Typings$valueConstructor = A2(
	$stil4m$elm_syntax$Combine$andThen,
	function (tnn) {
		var range = tnn.a;
		var complete = function (args) {
			return $stil4m$elm_syntax$Combine$succeed(
				A2(
					$stil4m$elm_syntax$Elm$Syntax$Node$Node,
					$stil4m$elm_syntax$Elm$Syntax$Range$combine(
						A2(
							$elm$core$List$cons,
							range,
							A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Syntax$Node$range, args))),
					A2($stil4m$elm_syntax$Elm$Syntax$Type$ValueConstructor, tnn, args)));
		};
		var argHelper = function (xs) {
			return A2(
				$stil4m$elm_syntax$Combine$continueWith,
				$stil4m$elm_syntax$Combine$choice(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Combine$andThen,
							function (ta) {
								return A2(
									$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayoutWith,
									function (_v0) {
										return $stil4m$elm_syntax$Combine$succeed(
											$elm$core$List$reverse(
												A2($elm$core$List$cons, ta, xs)));
									},
									function (_v1) {
										return argHelper(
											A2($elm$core$List$cons, ta, xs));
									});
							},
							$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotationNonGreedy),
							$stil4m$elm_syntax$Combine$succeed(
							$elm$core$List$reverse(xs))
						])),
				$stil4m$elm_syntax$Combine$succeed(0));
		};
		return A2(
			$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayoutWith,
			function (_v2) {
				return complete(_List_Nil);
			},
			function (_v3) {
				return A2(
					$stil4m$elm_syntax$Combine$andThen,
					complete,
					argHelper(_List_Nil));
			});
	},
	A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$typeName),
		$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$Type$ValueConstructor)));
var $stil4m$elm_syntax$Elm$Parser$Typings$valueConstructors = A2(
	$stil4m$elm_syntax$Combine$sepBy1,
	A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
		$stil4m$elm_syntax$Combine$string('|')),
	$stil4m$elm_syntax$Elm$Parser$Typings$valueConstructor);
var $stil4m$elm_syntax$Elm$Parser$Typings$typeDefinition = $stil4m$elm_syntax$Elm$Parser$Ranges$withCurrentPoint(
	function (start) {
		return A2(
			$stil4m$elm_syntax$Combine$continueWith,
			$stil4m$elm_syntax$Combine$choice(
				_List_fromArray(
					[
						A2(
						$stil4m$elm_syntax$Combine$map,
						function (typeAlias) {
							return A2(
								$stil4m$elm_syntax$Elm$Parser$Typings$DefinedAlias,
								$stil4m$elm_syntax$Elm$Syntax$Range$combine(
									_List_fromArray(
										[
											start,
											$stil4m$elm_syntax$Elm$Syntax$Node$range(typeAlias.aV)
										])),
								typeAlias);
						},
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							$stil4m$elm_syntax$Elm$Parser$TypeAnnotation$typeAnnotation,
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Combine$string('='),
									A2(
										$stil4m$elm_syntax$Combine$andMap,
										$stil4m$elm_syntax$Elm$Parser$Typings$genericList,
										A2(
											$stil4m$elm_syntax$Combine$ignore,
											$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
											A2(
												$stil4m$elm_syntax$Combine$andMap,
												A2(
													$stil4m$elm_syntax$Combine$ignore,
													$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
													$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$typeName)),
												A2(
													$stil4m$elm_syntax$Combine$ignore,
													A2(
														$stil4m$elm_syntax$Combine$continueWith,
														$stil4m$elm_syntax$Elm$Parser$Layout$layout,
														$stil4m$elm_syntax$Combine$string('alias')),
													$stil4m$elm_syntax$Combine$succeed(
														$stil4m$elm_syntax$Elm$Syntax$TypeAlias$TypeAlias($elm$core$Maybe$Nothing)))))))))),
						A2(
						$stil4m$elm_syntax$Combine$map,
						function (tipe) {
							return A2(
								$stil4m$elm_syntax$Elm$Parser$Typings$DefinedType,
								$stil4m$elm_syntax$Elm$Syntax$Range$combine(
									A2(
										$elm$core$List$cons,
										start,
										A2(
											$elm$core$List$map,
											function (_v0) {
												var r = _v0.a;
												return r;
											},
											tipe.bU))),
								tipe);
						},
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							$stil4m$elm_syntax$Elm$Parser$Typings$valueConstructors,
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
									$stil4m$elm_syntax$Combine$string('=')),
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
									A2(
										$stil4m$elm_syntax$Combine$andMap,
										$stil4m$elm_syntax$Elm$Parser$Typings$genericList,
										A2(
											$stil4m$elm_syntax$Combine$ignore,
											$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
											A2(
												$stil4m$elm_syntax$Combine$andMap,
												$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$typeName),
												$stil4m$elm_syntax$Combine$succeed(
													$stil4m$elm_syntax$Elm$Syntax$Type$Type($elm$core$Maybe$Nothing)))))))))
					])),
			$stil4m$elm_syntax$Elm$Parser$Typings$typePrefix);
	});
var $stil4m$elm_syntax$Elm$Parser$Declarations$declaration = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return $stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					$stil4m$elm_syntax$Elm$Parser$Declarations$infixDeclaration,
					$stil4m$elm_syntax$Elm$Parser$Declarations$function,
					A2(
					$stil4m$elm_syntax$Combine$map,
					function (v) {
						if (!v.$) {
							var r = v.a;
							var t = v.b;
							return A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								r,
								$stil4m$elm_syntax$Elm$Syntax$Declaration$CustomTypeDeclaration(t));
						} else {
							var r = v.a;
							var a = v.b;
							return A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								r,
								$stil4m$elm_syntax$Elm$Syntax$Declaration$AliasDeclaration(a));
						}
					},
					$stil4m$elm_syntax$Elm$Parser$Typings$typeDefinition),
					$stil4m$elm_syntax$Elm$Parser$Declarations$portDeclaration,
					$stil4m$elm_syntax$Elm$Parser$Declarations$destructuringDeclaration
				]));
	});
var $stil4m$elm_syntax$Elm$Parser$File$fileDeclarations = $stil4m$elm_syntax$Combine$many(
	A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layoutStrict),
		$stil4m$elm_syntax$Elm$Parser$Declarations$declaration));
var $stil4m$elm_syntax$Elm$Syntax$Import$Import = F3(
	function (moduleName, moduleAlias, exposingList) {
		return {b9: exposingList, be: moduleAlias, ay: moduleName};
	});
var $stil4m$elm_syntax$Elm$Parser$Tokens$asToken = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$keyword('as'));
var $stil4m$elm_syntax$Elm$Parser$Expose$functionExpose = $stil4m$elm_syntax$Elm$Parser$Node$parser(
	A2($stil4m$elm_syntax$Combine$map, $stil4m$elm_syntax$Elm$Syntax$Exposing$FunctionExpose, $stil4m$elm_syntax$Elm$Parser$Tokens$functionName));
var $stil4m$elm_syntax$Combine$while = function (pred) {
	return function (state) {
		return A2(
			$elm$parser$Parser$map,
			function (x) {
				return _Utils_Tuple2(state, x);
			},
			$elm$parser$Parser$getChompedString(
				$elm$parser$Parser$chompWhile(pred)));
	};
};
var $stil4m$elm_syntax$Elm$Parser$Expose$infixExpose = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return $stil4m$elm_syntax$Elm$Parser$Node$parser(
			A2(
				$stil4m$elm_syntax$Combine$map,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$InfixExpose,
				$stil4m$elm_syntax$Combine$parens(
					$stil4m$elm_syntax$Combine$while(
						$elm$core$Basics$neq(')')))));
	});
var $stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType = F2(
	function (name, open) {
		return {I: name, cV: open};
	});
var $stil4m$elm_syntax$Elm$Syntax$Node$map = F2(
	function (f, _v0) {
		var r = _v0.a;
		var a = _v0.b;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			r,
			f(a));
	});
var $stil4m$elm_syntax$Elm$Parser$Expose$typeExpose = A2(
	$stil4m$elm_syntax$Combine$andThen,
	function (tipe) {
		return $stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					A2(
					$stil4m$elm_syntax$Combine$map,
					function (openRange) {
						return A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$combine(
								_List_fromArray(
									[
										$stil4m$elm_syntax$Elm$Syntax$Node$range(tipe),
										openRange
									])),
							$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
								A2(
									$stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType,
									$stil4m$elm_syntax$Elm$Syntax$Node$value(tipe),
									$elm$core$Maybe$Just(openRange))));
					},
					A2(
						$stil4m$elm_syntax$Combine$map,
						$stil4m$elm_syntax$Elm$Syntax$Node$range,
						$stil4m$elm_syntax$Elm$Parser$Node$parser(
							$stil4m$elm_syntax$Combine$parens(
								$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
									$stil4m$elm_syntax$Combine$string('..')))))),
					$stil4m$elm_syntax$Combine$succeed(
					A2($stil4m$elm_syntax$Elm$Syntax$Node$map, $stil4m$elm_syntax$Elm$Syntax$Exposing$TypeOrAliasExpose, tipe))
				]));
	},
	A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$typeName)));
var $stil4m$elm_syntax$Elm$Parser$Expose$exposable = $stil4m$elm_syntax$Combine$lazy(
	function (_v0) {
		return $stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[$stil4m$elm_syntax$Elm$Parser$Expose$typeExpose, $stil4m$elm_syntax$Elm$Parser$Expose$infixExpose, $stil4m$elm_syntax$Elm$Parser$Expose$functionExpose]));
	});
var $stil4m$elm_syntax$Elm$Parser$Ranges$withRange = function (p) {
	return $stil4m$elm_syntax$Combine$withLocation(
		function (start) {
			return A2(
				$stil4m$elm_syntax$Combine$andMap,
				$stil4m$elm_syntax$Combine$withLocation(
					function (end) {
						return $stil4m$elm_syntax$Combine$succeed(
							{
								a6: $stil4m$elm_syntax$Elm$Parser$Ranges$asPointerLocation(end),
								br: $stil4m$elm_syntax$Elm$Parser$Ranges$asPointerLocation(start)
							});
					}),
				p);
		});
};
var $stil4m$elm_syntax$Elm$Parser$Expose$exposingListInner = A2(
	$stil4m$elm_syntax$Combine$or,
	$stil4m$elm_syntax$Elm$Parser$Ranges$withRange(
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
				$stil4m$elm_syntax$Combine$string('..')),
			$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$Exposing$All))),
	A2(
		$stil4m$elm_syntax$Combine$map,
		$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit,
		A2(
			$stil4m$elm_syntax$Combine$sepBy,
			$stil4m$elm_syntax$Combine$Char$char(','),
			$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides($stil4m$elm_syntax$Elm$Parser$Expose$exposable))));
var $stil4m$elm_syntax$Elm$Parser$Expose$exposeListWith = $stil4m$elm_syntax$Combine$parens(
	A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout,
		A2($stil4m$elm_syntax$Combine$continueWith, $stil4m$elm_syntax$Elm$Parser$Expose$exposingListInner, $stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout)));
var $stil4m$elm_syntax$Elm$Parser$Tokens$exposingToken = $stil4m$elm_syntax$Combine$string('exposing');
var $stil4m$elm_syntax$Elm$Parser$Expose$exposeDefinition = A2(
	$stil4m$elm_syntax$Combine$continueWith,
	$stil4m$elm_syntax$Elm$Parser$Expose$exposeListWith,
	A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layout),
		$stil4m$elm_syntax$Elm$Parser$Tokens$exposingToken));
var $stil4m$elm_syntax$Elm$Parser$Tokens$importToken = $stil4m$elm_syntax$Combine$fromCore(
	$elm$parser$Parser$keyword('import'));
var $stil4m$elm_syntax$Elm$Parser$Base$moduleName = A2(
	$stil4m$elm_syntax$Combine$sepBy1,
	$stil4m$elm_syntax$Combine$string('.'),
	$stil4m$elm_syntax$Elm$Parser$Tokens$typeName);
var $stil4m$elm_syntax$Elm$Parser$Imports$setupNode = F2(
	function (start, imp) {
		var allRanges = _List_fromArray(
			[
				$elm$core$Maybe$Just(start),
				$elm$core$Maybe$Just(
				$stil4m$elm_syntax$Elm$Syntax$Node$range(imp.ay)),
				A2($elm$core$Maybe$map, $stil4m$elm_syntax$Elm$Syntax$Node$range, imp.b9),
				A2($elm$core$Maybe$map, $stil4m$elm_syntax$Elm$Syntax$Node$range, imp.be)
			]);
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$combine(
				A2($elm$core$List$filterMap, $elm$core$Basics$identity, allRanges)),
			imp);
	});
var $stil4m$elm_syntax$Elm$Parser$Imports$importDefinition = function () {
	var parseExposingDefinition = F2(
		function (mod, asDef) {
			return $stil4m$elm_syntax$Combine$choice(
				_List_fromArray(
					[
						A2(
						$stil4m$elm_syntax$Combine$map,
						A2(
							$elm$core$Basics$composeR,
							$elm$core$Maybe$Just,
							A2($stil4m$elm_syntax$Elm$Syntax$Import$Import, mod, asDef)),
						$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Expose$exposeDefinition)),
						$stil4m$elm_syntax$Combine$succeed(
						A3($stil4m$elm_syntax$Elm$Syntax$Import$Import, mod, asDef, $elm$core$Maybe$Nothing))
					]));
		});
	var importAndModuleName = A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Base$moduleName),
		A2($stil4m$elm_syntax$Combine$continueWith, $stil4m$elm_syntax$Elm$Parser$Layout$layout, $stil4m$elm_syntax$Elm$Parser$Tokens$importToken));
	var asDefinition = A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Base$moduleName),
		A2($stil4m$elm_syntax$Combine$continueWith, $stil4m$elm_syntax$Elm$Parser$Layout$layout, $stil4m$elm_syntax$Elm$Parser$Tokens$asToken));
	var parseAsDefinition = function (mod) {
		return $stil4m$elm_syntax$Combine$choice(
			_List_fromArray(
				[
					A2(
					$stil4m$elm_syntax$Combine$andThen,
					A2(
						$elm$core$Basics$composeR,
						$elm$core$Maybe$Just,
						parseExposingDefinition(mod)),
					A2($stil4m$elm_syntax$Combine$ignore, $stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout, asDefinition)),
					A2(parseExposingDefinition, mod, $elm$core$Maybe$Nothing)
				]));
	};
	return A2(
		$stil4m$elm_syntax$Combine$andThen,
		function (_v0) {
			var start = _v0.a;
			return A2(
				$stil4m$elm_syntax$Combine$map,
				$stil4m$elm_syntax$Elm$Parser$Imports$setupNode(start),
				A2(
					$stil4m$elm_syntax$Combine$andThen,
					parseAsDefinition,
					A2($stil4m$elm_syntax$Combine$ignore, $stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout, importAndModuleName)));
		},
		$stil4m$elm_syntax$Elm$Parser$Node$parser(
			$stil4m$elm_syntax$Combine$succeed(0)));
}();
var $stil4m$elm_syntax$Elm$Syntax$Module$EffectModule = function (a) {
	return {$: 2, a: a};
};
var $stil4m$elm_syntax$Elm$Parser$Modules$effectWhereClause = A2(
	$stil4m$elm_syntax$Combine$andMap,
	A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Tokens$typeName),
		$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides(
			$stil4m$elm_syntax$Combine$string('='))),
	A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$Tokens$functionName,
		$stil4m$elm_syntax$Combine$succeed($elm$core$Tuple$pair)));
var $stil4m$elm_syntax$Elm$Parser$Modules$whereBlock = A2(
	$stil4m$elm_syntax$Combine$map,
	function (pairs) {
		return {
			bQ: A2(
				$elm$core$Maybe$map,
				$elm$core$Tuple$second,
				$elm$core$List$head(
					A2(
						$elm$core$List$filter,
						A2(
							$elm$core$Basics$composeR,
							$elm$core$Tuple$first,
							$elm$core$Basics$eq('command')),
						pairs))),
			df: A2(
				$elm$core$Maybe$map,
				$elm$core$Tuple$second,
				$elm$core$List$head(
					A2(
						$elm$core$List$filter,
						A2(
							$elm$core$Basics$composeR,
							$elm$core$Tuple$first,
							$elm$core$Basics$eq('subscription')),
						pairs)))
		};
	},
	A3(
		$stil4m$elm_syntax$Combine$between,
		$stil4m$elm_syntax$Combine$string('{'),
		$stil4m$elm_syntax$Combine$string('}'),
		A2(
			$stil4m$elm_syntax$Combine$sepBy1,
			$stil4m$elm_syntax$Combine$string(','),
			$stil4m$elm_syntax$Elm$Parser$Layout$maybeAroundBothSides($stil4m$elm_syntax$Elm$Parser$Modules$effectWhereClause))));
var $stil4m$elm_syntax$Elm$Parser$Modules$effectWhereClauses = A2(
	$stil4m$elm_syntax$Combine$continueWith,
	$stil4m$elm_syntax$Elm$Parser$Modules$whereBlock,
	A2(
		$stil4m$elm_syntax$Combine$continueWith,
		$stil4m$elm_syntax$Elm$Parser$Layout$layout,
		$stil4m$elm_syntax$Combine$string('where')));
var $stil4m$elm_syntax$Elm$Parser$Tokens$moduleToken = $stil4m$elm_syntax$Combine$string('module');
var $stil4m$elm_syntax$Elm$Parser$Modules$effectModuleDefinition = function () {
	var createEffectModule = F3(
		function (name, whereClauses, exp) {
			return $stil4m$elm_syntax$Elm$Syntax$Module$EffectModule(
				{bQ: whereClauses.bQ, b9: exp, ay: name, df: whereClauses.df});
		});
	return A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Expose$exposeDefinition),
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Elm$Parser$Layout$layout,
			A2(
				$stil4m$elm_syntax$Combine$andMap,
				$stil4m$elm_syntax$Elm$Parser$Modules$effectWhereClauses,
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Elm$Parser$Layout$layout,
					A2(
						$stil4m$elm_syntax$Combine$andMap,
						$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Base$moduleName),
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Elm$Parser$Layout$layout,
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Elm$Parser$Tokens$moduleToken,
								A2(
									$stil4m$elm_syntax$Combine$ignore,
									$stil4m$elm_syntax$Elm$Parser$Layout$layout,
									A2(
										$stil4m$elm_syntax$Combine$ignore,
										$stil4m$elm_syntax$Combine$string('effect'),
										$stil4m$elm_syntax$Combine$succeed(createEffectModule))))))))));
}();
var $stil4m$elm_syntax$Elm$Syntax$Module$DefaultModuleData = F2(
	function (moduleName, exposingList) {
		return {b9: exposingList, ay: moduleName};
	});
var $stil4m$elm_syntax$Elm$Parser$Modules$normalModuleDefinition = A2(
	$stil4m$elm_syntax$Combine$map,
	$stil4m$elm_syntax$Elm$Syntax$Module$NormalModule,
	A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Expose$exposeDefinition),
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Elm$Parser$Layout$layout,
			A2(
				$stil4m$elm_syntax$Combine$andMap,
				$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Base$moduleName),
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Elm$Parser$Layout$layout,
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Elm$Parser$Tokens$moduleToken,
						$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$Module$DefaultModuleData)))))));
var $stil4m$elm_syntax$Elm$Parser$Modules$portModuleDefinition = A2(
	$stil4m$elm_syntax$Combine$map,
	$stil4m$elm_syntax$Elm$Syntax$Module$PortModule,
	A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Expose$exposeDefinition),
		A2(
			$stil4m$elm_syntax$Combine$ignore,
			$stil4m$elm_syntax$Elm$Parser$Layout$layout,
			A2(
				$stil4m$elm_syntax$Combine$andMap,
				$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Base$moduleName),
				A2(
					$stil4m$elm_syntax$Combine$ignore,
					$stil4m$elm_syntax$Elm$Parser$Layout$layout,
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Elm$Parser$Tokens$moduleToken,
						A2(
							$stil4m$elm_syntax$Combine$ignore,
							$stil4m$elm_syntax$Elm$Parser$Layout$layout,
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Elm$Parser$Tokens$portToken,
								$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$Module$DefaultModuleData)))))))));
var $stil4m$elm_syntax$Elm$Parser$Modules$moduleDefinition = $stil4m$elm_syntax$Combine$choice(
	_List_fromArray(
		[$stil4m$elm_syntax$Elm$Parser$Modules$normalModuleDefinition, $stil4m$elm_syntax$Elm$Parser$Modules$portModuleDefinition, $stil4m$elm_syntax$Elm$Parser$Modules$effectModuleDefinition]));
var $stil4m$elm_syntax$Elm$Parser$File$file = A2(
	$stil4m$elm_syntax$Combine$ignore,
	$stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout,
	A2(
		$stil4m$elm_syntax$Combine$andMap,
		$stil4m$elm_syntax$Elm$Parser$File$collectComments,
		A2(
			$stil4m$elm_syntax$Combine$andMap,
			$stil4m$elm_syntax$Elm$Parser$File$fileDeclarations,
			A2(
				$stil4m$elm_syntax$Combine$ignore,
				$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layoutStrict),
				A2(
					$stil4m$elm_syntax$Combine$andMap,
					$stil4m$elm_syntax$Combine$many(
						A2($stil4m$elm_syntax$Combine$ignore, $stil4m$elm_syntax$Elm$Parser$Layout$optimisticLayout, $stil4m$elm_syntax$Elm$Parser$Imports$importDefinition)),
					A2(
						$stil4m$elm_syntax$Combine$ignore,
						$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layoutStrict),
						A2(
							$stil4m$elm_syntax$Combine$andMap,
							$stil4m$elm_syntax$Elm$Parser$Node$parser($stil4m$elm_syntax$Elm$Parser$Modules$moduleDefinition),
							A2(
								$stil4m$elm_syntax$Combine$ignore,
								$stil4m$elm_syntax$Combine$maybe($stil4m$elm_syntax$Elm$Parser$Layout$layoutStrict),
								$stil4m$elm_syntax$Combine$succeed($stil4m$elm_syntax$Elm$Syntax$File$File)))))))));
var $stil4m$elm_syntax$Elm$Internal$RawFile$Raw = $elm$core$Basics$identity;
var $stil4m$elm_syntax$Elm$Internal$RawFile$fromFile = $elm$core$Basics$identity;
var $stil4m$elm_syntax$Combine$runParser = F3(
	function (_v0, st, s) {
		var p = _v0;
		return A2(
			$elm$parser$Parser$run,
			p(st),
			s);
	});
var $elm$parser$Parser$ExpectingEnd = {$: 10};
var $elm$parser$Parser$Advanced$end = function (x) {
	return function (s) {
		return _Utils_eq(
			$elm$core$String$length(s.d),
			s.e) ? A3($elm$parser$Parser$Advanced$Good, false, 0, s) : A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A2($elm$parser$Parser$Advanced$fromState, s, x));
	};
};
var $elm$parser$Parser$end = $elm$parser$Parser$Advanced$end($elm$parser$Parser$ExpectingEnd);
var $stil4m$elm_syntax$Combine$end = function (state) {
	return A2(
		$elm$parser$Parser$map,
		function (x) {
			return _Utils_Tuple2(state, x);
		},
		$elm$parser$Parser$end);
};
var $stil4m$elm_syntax$Elm$Parser$withEnd = function (p) {
	return A2(
		$stil4m$elm_syntax$Combine$ignore,
		$stil4m$elm_syntax$Combine$withLocation(
			function (_v0) {
				return $stil4m$elm_syntax$Combine$end;
			}),
		p);
};
var $stil4m$elm_syntax$Elm$Parser$parse = function (input) {
	var _v0 = A3(
		$stil4m$elm_syntax$Combine$runParser,
		$stil4m$elm_syntax$Elm$Parser$withEnd($stil4m$elm_syntax$Elm$Parser$File$file),
		$stil4m$elm_syntax$Elm$Parser$State$emptyState,
		input + '\n');
	if (!_v0.$) {
		var _v1 = _v0.a;
		var r = _v1.b;
		return $elm$core$Result$Ok(
			$stil4m$elm_syntax$Elm$Internal$RawFile$fromFile(r));
	} else {
		var s = _v0.a;
		return $elm$core$Result$Err(s);
	}
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$OperatorApplication = F4(
	function (a, b, c, d) {
		return {$: 2, a: a, b: b, c: c, d: d};
	});
var $stil4m$elm_syntax$Elm$Processing$expressionOperators = function (_v0) {
	var expression = _v0.b;
	if (expression.$ === 6) {
		var s = expression.a;
		return $elm$core$Maybe$Just(s);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		if (!maybeValue.$) {
			var value = maybeValue.a;
			return callback(value);
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $elm_community$list_extra$List$Extra$dropWhile = F2(
	function (predicate, list) {
		dropWhile:
		while (true) {
			if (!list.b) {
				return _List_Nil;
			} else {
				var x = list.a;
				var xs = list.b;
				if (predicate(x)) {
					var $temp$predicate = predicate,
						$temp$list = xs;
					predicate = $temp$predicate;
					list = $temp$list;
					continue dropWhile;
				} else {
					return list;
				}
			}
		}
	});
var $elm_community$list_extra$List$Extra$takeWhile = function (predicate) {
	var takeWhileMemo = F2(
		function (memo, list) {
			takeWhileMemo:
			while (true) {
				if (!list.b) {
					return $elm$core$List$reverse(memo);
				} else {
					var x = list.a;
					var xs = list.b;
					if (predicate(x)) {
						var $temp$memo = A2($elm$core$List$cons, x, memo),
							$temp$list = xs;
						memo = $temp$memo;
						list = $temp$list;
						continue takeWhileMemo;
					} else {
						return $elm$core$List$reverse(memo);
					}
				}
			}
		});
	return takeWhileMemo(_List_Nil);
};
var $stil4m$elm_syntax$Elm$Processing$findNextSplit = F2(
	function (dict, exps) {
		var assocDirection = A2(
			$elm$core$Maybe$withDefault,
			1,
			A2(
				$elm$core$Maybe$map,
				$stil4m$elm_syntax$Elm$Syntax$Node$value,
				$elm$core$List$head(
					A2(
						$elm$core$List$map,
						A2(
							$elm$core$Basics$composeR,
							$elm$core$Tuple$second,
							function ($) {
								return $.b1;
							}),
						$elm$core$Dict$toList(dict)))));
		var prefix = function () {
			if (!assocDirection) {
				return $elm$core$List$reverse(
					A2(
						$elm$core$List$drop,
						1,
						A2(
							$elm_community$list_extra$List$Extra$dropWhile,
							function (x) {
								return _Utils_eq(
									$elm$core$Maybe$Nothing,
									A2(
										$elm$core$Maybe$andThen,
										function (key) {
											return A2($elm$core$Dict$get, key, dict);
										},
										$stil4m$elm_syntax$Elm$Processing$expressionOperators(x)));
							},
							$elm$core$List$reverse(exps))));
			} else {
				return A2(
					$elm_community$list_extra$List$Extra$takeWhile,
					function (x) {
						return _Utils_eq(
							$elm$core$Maybe$Nothing,
							A2(
								$elm$core$Maybe$andThen,
								function (key) {
									return A2($elm$core$Dict$get, key, dict);
								},
								$stil4m$elm_syntax$Elm$Processing$expressionOperators(x)));
					},
					exps);
			}
		}();
		var suffix = A2(
			$elm$core$List$drop,
			$elm$core$List$length(prefix) + 1,
			exps);
		return A2(
			$elm$core$Maybe$map,
			function (x) {
				return _Utils_Tuple3(prefix, x, suffix);
			},
			A2(
				$elm$core$Maybe$andThen,
				function (x) {
					return A2($elm$core$Dict$get, x, dict);
				},
				A2(
					$elm$core$Maybe$andThen,
					$stil4m$elm_syntax$Elm$Processing$expressionOperators,
					$elm$core$List$head(
						A2(
							$elm$core$List$drop,
							$elm$core$List$length(prefix),
							exps)))));
	});
var $elm$core$Dict$isEmpty = function (dict) {
	if (dict.$ === -2) {
		return true;
	} else {
		return false;
	}
};
var $elm$core$Dict$fromList = function (assocs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, dict) {
				var key = _v0.a;
				var value = _v0.b;
				return A3($elm$core$Dict$insert, key, value, dict);
			}),
		$elm$core$Dict$empty,
		assocs);
};
var $elm$core$Basics$min = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) < 0) ? x : y;
	});
var $elm$core$List$minimum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$min, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $stil4m$elm_syntax$Elm$Processing$lowestPrecedence = function (input) {
	return $elm$core$Dict$fromList(
		A2(
			$elm$core$Maybe$withDefault,
			_List_Nil,
			A2(
				$elm$core$Maybe$map,
				function (m) {
					return A2(
						$elm$core$List$filter,
						A2(
							$elm$core$Basics$composeR,
							$elm$core$Tuple$second,
							A2(
								$elm$core$Basics$composeR,
								function ($) {
									return $.Y;
								},
								A2(
									$elm$core$Basics$composeR,
									$stil4m$elm_syntax$Elm$Syntax$Node$value,
									$elm$core$Basics$eq(m)))),
						input);
				},
				$elm$core$List$minimum(
					A2(
						$elm$core$List$map,
						A2(
							$elm$core$Basics$composeR,
							$elm$core$Tuple$second,
							A2(
								$elm$core$Basics$composeR,
								function ($) {
									return $.Y;
								},
								$stil4m$elm_syntax$Elm$Syntax$Node$value)),
						input)))));
};
var $stil4m$elm_syntax$Elm$Processing$fixApplication = F2(
	function (operators, expressions) {
		var ops = $stil4m$elm_syntax$Elm$Processing$lowestPrecedence(
			A2(
				$elm$core$List$map,
				function (x) {
					return _Utils_Tuple2(
						x,
						A2(
							$elm$core$Maybe$withDefault,
							{
								b1: A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, 0),
								cl: A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, 'todo'),
								cW: A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, x),
								Y: A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, 5)
							},
							A2($elm$core$Dict$get, x, operators)));
				},
				A2($elm$core$List$filterMap, $stil4m$elm_syntax$Elm$Processing$expressionOperators, expressions)));
		var fixExprs = function (exps) {
			if (exps.b && (!exps.b.b)) {
				var _v2 = exps.a;
				var x = _v2.b;
				return x;
			} else {
				return $stil4m$elm_syntax$Elm$Syntax$Expression$Application(exps);
			}
		};
		var divideAndConquer = function (exps) {
			return $elm$core$Dict$isEmpty(ops) ? fixExprs(exps) : A2(
				$elm$core$Maybe$withDefault,
				fixExprs(exps),
				A2(
					$elm$core$Maybe$map,
					function (_v0) {
						var p = _v0.a;
						var infix = _v0.b;
						var s = _v0.c;
						return A4(
							$stil4m$elm_syntax$Elm$Syntax$Expression$OperatorApplication,
							$stil4m$elm_syntax$Elm$Syntax$Node$value(infix.cW),
							$stil4m$elm_syntax$Elm$Syntax$Node$value(infix.b1),
							A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								$stil4m$elm_syntax$Elm$Syntax$Range$combine(
									A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Syntax$Node$range, p)),
								divideAndConquer(p)),
							A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								$stil4m$elm_syntax$Elm$Syntax$Range$combine(
									A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Syntax$Node$range, s)),
								divideAndConquer(s)));
					},
					A2($stil4m$elm_syntax$Elm$Processing$findNextSplit, ops, exps)));
		};
		return divideAndConquer(expressions);
	});
var $stil4m$elm_syntax$Elm$Inspector$Post = function (a) {
	return {$: 3, a: a};
};
var $stil4m$elm_syntax$Elm$Inspector$Continue = {$: 1};
var $stil4m$elm_syntax$Elm$Inspector$defaultConfig = {az: $stil4m$elm_syntax$Elm$Inspector$Continue, aA: $stil4m$elm_syntax$Elm$Inspector$Continue, aB: $stil4m$elm_syntax$Elm$Inspector$Continue, aC: $stil4m$elm_syntax$Elm$Inspector$Continue, aD: $stil4m$elm_syntax$Elm$Inspector$Continue, aE: $stil4m$elm_syntax$Elm$Inspector$Continue, aF: $stil4m$elm_syntax$Elm$Inspector$Continue, aG: $stil4m$elm_syntax$Elm$Inspector$Continue, aH: $stil4m$elm_syntax$Elm$Inspector$Continue, aI: $stil4m$elm_syntax$Elm$Inspector$Continue, aJ: $stil4m$elm_syntax$Elm$Inspector$Continue, aK: $stil4m$elm_syntax$Elm$Inspector$Continue, aL: $stil4m$elm_syntax$Elm$Inspector$Continue, aM: $stil4m$elm_syntax$Elm$Inspector$Continue, aN: $stil4m$elm_syntax$Elm$Inspector$Continue, aO: $stil4m$elm_syntax$Elm$Inspector$Continue, aP: $stil4m$elm_syntax$Elm$Inspector$Continue, aQ: $stil4m$elm_syntax$Elm$Inspector$Continue};
var $stil4m$elm_syntax$Elm$Inspector$actionLambda = function (act) {
	switch (act.$) {
		case 0:
			return F3(
				function (_v1, _v2, c) {
					return c;
				});
		case 1:
			return F3(
				function (f, _v3, c) {
					return f(c);
				});
		case 2:
			var g = act.a;
			return F3(
				function (f, x, c) {
					return f(
						A2(g, x, c));
				});
		case 3:
			var g = act.a;
			return F3(
				function (f, x, c) {
					return A2(
						g,
						x,
						f(c));
				});
		default:
			var g = act.a;
			return F3(
				function (f, x, c) {
					return A3(g, f, x, c);
				});
	}
};
var $stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation = F3(
	function (config, typeAnnotation, context) {
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aQ,
			A2($stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotationInner, config, typeAnnotation),
			typeAnnotation,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotationInner = F3(
	function (config, _v0, context) {
		var typeRefence = _v0.b;
		switch (typeRefence.$) {
			case 1:
				var typeArgs = typeRefence.b;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation(config),
					context,
					typeArgs);
			case 3:
				var typeAnnotations = typeRefence.a;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation(config),
					context,
					typeAnnotations);
			case 4:
				var recordDefinition = typeRefence.a;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation(config),
					context,
					A2(
						$elm$core$List$map,
						A2($elm$core$Basics$composeR, $stil4m$elm_syntax$Elm$Syntax$Node$value, $elm$core$Tuple$second),
						recordDefinition));
			case 5:
				var recordDefinition = typeRefence.b;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation(config),
					context,
					A2(
						$elm$core$List$map,
						A2($elm$core$Basics$composeR, $stil4m$elm_syntax$Elm$Syntax$Node$value, $elm$core$Tuple$second),
						$stil4m$elm_syntax$Elm$Syntax$Node$value(recordDefinition)));
			case 6:
				var left = typeRefence.a;
				var right = typeRefence.b;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation(config),
					context,
					_List_fromArray(
						[left, right]));
			case 2:
				return context;
			default:
				return context;
		}
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectSignature = F3(
	function (config, node, context) {
		var signature = node.b;
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aN,
			A2($stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation, config, signature.aV),
			node,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectCase = F3(
	function (config, caze, context) {
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.az,
			A2($stil4m$elm_syntax$Elm$Inspector$inspectExpression, config, caze.b),
			caze,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectDestructuring = F3(
	function (config, destructuring, context) {
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aA,
			function (c) {
				return A3(
					$stil4m$elm_syntax$Elm$Inspector$inspectExpression,
					config,
					$stil4m$elm_syntax$Elm$Syntax$Node$value(destructuring).b,
					c);
			},
			destructuring,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectExpression = F3(
	function (config, node, context) {
		var expression = node.b;
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aB,
			A2($stil4m$elm_syntax$Elm$Inspector$inspectInnerExpression, config, expression),
			node,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectFunction = F3(
	function (config, node, context) {
		var _function = node.b;
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aD,
			A2(
				$elm$core$Basics$composeR,
				A2(
					$stil4m$elm_syntax$Elm$Inspector$inspectExpression,
					config,
					$stil4m$elm_syntax$Elm$Syntax$Node$value(_function.bX).b),
				A2(
					$elm$core$Maybe$withDefault,
					$elm$core$Basics$identity,
					A2(
						$elm$core$Maybe$map,
						$stil4m$elm_syntax$Elm$Inspector$inspectSignature(config),
						_function.db))),
			node,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectInnerExpression = F3(
	function (config, expression, context) {
		switch (expression.$) {
			case 0:
				return context;
			case 3:
				var moduleName = expression.a;
				var functionOrVal = expression.b;
				return A4(
					$stil4m$elm_syntax$Elm$Inspector$actionLambda,
					config.aE,
					$elm$core$Basics$identity,
					_Utils_Tuple2(moduleName, functionOrVal),
					context);
			case 5:
				return context;
			case 6:
				return context;
			case 8:
				return context;
			case 7:
				return context;
			case 9:
				return context;
			case 10:
				var x = expression.a;
				return A3($stil4m$elm_syntax$Elm$Inspector$inspectExpression, config, x, context);
			case 11:
				return context;
			case 12:
				return context;
			case 20:
				var ex1 = expression.a;
				var key = expression.b;
				return A4(
					$stil4m$elm_syntax$Elm$Inspector$actionLambda,
					config.aL,
					A2($stil4m$elm_syntax$Elm$Inspector$inspectExpression, config, ex1),
					_Utils_Tuple2(ex1, key),
					context);
			case 21:
				return context;
			case 23:
				return context;
			case 1:
				var expressionList = expression.a;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectExpression(config),
					context,
					expressionList);
			case 2:
				var op = expression.a;
				var dir = expression.b;
				var left = expression.c;
				var right = expression.d;
				return A4(
					$stil4m$elm_syntax$Elm$Inspector$actionLambda,
					config.aJ,
					function (base) {
						return A3(
							$elm$core$List$foldl,
							$stil4m$elm_syntax$Elm$Inspector$inspectExpression(config),
							base,
							_List_fromArray(
								[left, right]));
					},
					{b1: dir, cG: left, cW: op, c9: right},
					context);
			case 4:
				var e1 = expression.a;
				var e2 = expression.b;
				var e3 = expression.c;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectExpression(config),
					context,
					_List_fromArray(
						[e1, e2, e3]));
			case 13:
				var expressionList = expression.a;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectExpression(config),
					context,
					expressionList);
			case 14:
				var inner = expression.a;
				return A3($stil4m$elm_syntax$Elm$Inspector$inspectExpression, config, inner, context);
			case 15:
				var letBlock = expression.a;
				var next = A2(
					$elm$core$Basics$composeR,
					A2($stil4m$elm_syntax$Elm$Inspector$inspectLetDeclarations, config, letBlock.b_),
					A2($stil4m$elm_syntax$Elm$Inspector$inspectExpression, config, letBlock.b));
				return A4($stil4m$elm_syntax$Elm$Inspector$actionLambda, config.aI, next, letBlock, context);
			case 16:
				var caseBlock = expression.a;
				var context2 = A3($stil4m$elm_syntax$Elm$Inspector$inspectExpression, config, caseBlock.b, context);
				var context3 = A3(
					$elm$core$List$foldl,
					F2(
						function (a, b) {
							return A3($stil4m$elm_syntax$Elm$Inspector$inspectCase, config, a, b);
						}),
					context2,
					caseBlock.ai);
				return context3;
			case 17:
				var lambda = expression.a;
				return A4(
					$stil4m$elm_syntax$Elm$Inspector$actionLambda,
					config.aH,
					A2($stil4m$elm_syntax$Elm$Inspector$inspectExpression, config, lambda.b),
					lambda,
					context);
			case 19:
				var expressionList = expression.a;
				return A3(
					$elm$core$List$foldl,
					$stil4m$elm_syntax$Elm$Inspector$inspectExpression(config),
					context,
					expressionList);
			case 18:
				var expressionStringList = expression.a;
				return A3(
					$elm$core$List$foldl,
					F2(
						function (a, b) {
							return A3(
								$stil4m$elm_syntax$Elm$Inspector$inspectExpression,
								config,
								$stil4m$elm_syntax$Elm$Syntax$Node$value(a).b,
								b);
						}),
					context,
					expressionStringList);
			default:
				var name = expression.a;
				var updates = expression.b;
				return A4(
					$stil4m$elm_syntax$Elm$Inspector$actionLambda,
					config.aM,
					function (c) {
						return A3(
							$elm$core$List$foldl,
							F2(
								function (a, b) {
									return A3(
										$stil4m$elm_syntax$Elm$Inspector$inspectExpression,
										config,
										$stil4m$elm_syntax$Elm$Syntax$Node$value(a).b,
										b);
								}),
							c,
							updates);
					},
					_Utils_Tuple2(name, updates),
					context);
		}
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectLetDeclaration = F3(
	function (config, _v0, context) {
		var range = _v0.a;
		var declaration = _v0.b;
		if (!declaration.$) {
			var _function = declaration.a;
			return A3(
				$stil4m$elm_syntax$Elm$Inspector$inspectFunction,
				config,
				A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, range, _function),
				context);
		} else {
			var pattern = declaration.a;
			var expression = declaration.b;
			return A3(
				$stil4m$elm_syntax$Elm$Inspector$inspectDestructuring,
				config,
				A2(
					$stil4m$elm_syntax$Elm$Syntax$Node$Node,
					range,
					_Utils_Tuple2(pattern, expression)),
				context);
		}
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectLetDeclarations = F3(
	function (config, declarations, context) {
		return A3(
			$elm$core$List$foldl,
			$stil4m$elm_syntax$Elm$Inspector$inspectLetDeclaration(config),
			context,
			declarations);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectPortDeclaration = F3(
	function (config, signature, context) {
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aK,
			A2($stil4m$elm_syntax$Elm$Inspector$inspectSignature, config, signature),
			signature,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectValueConstructor = F3(
	function (config, _v0, context) {
		var valueConstructor = _v0.b;
		return A3(
			$elm$core$List$foldl,
			$stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation(config),
			context,
			valueConstructor.bG);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectTypeInner = F3(
	function (config, typeDecl, context) {
		return A3(
			$elm$core$List$foldl,
			$stil4m$elm_syntax$Elm$Inspector$inspectValueConstructor(config),
			context,
			typeDecl.bU);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectType = F3(
	function (config, tipe, context) {
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aO,
			A2(
				$stil4m$elm_syntax$Elm$Inspector$inspectTypeInner,
				config,
				$stil4m$elm_syntax$Elm$Syntax$Node$value(tipe)),
			tipe,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectTypeAlias = F3(
	function (config, pair, context) {
		var typeAlias = pair.b;
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aP,
			A2($stil4m$elm_syntax$Elm$Inspector$inspectTypeAnnotation, config, typeAlias.aV),
			pair,
			context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectDeclaration = F3(
	function (config, _v0, context) {
		var r = _v0.a;
		var declaration = _v0.b;
		switch (declaration.$) {
			case 0:
				var _function = declaration.a;
				return A3(
					$stil4m$elm_syntax$Elm$Inspector$inspectFunction,
					config,
					A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, _function),
					context);
			case 1:
				var typeAlias = declaration.a;
				return A3(
					$stil4m$elm_syntax$Elm$Inspector$inspectTypeAlias,
					config,
					A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, typeAlias),
					context);
			case 2:
				var typeDecl = declaration.a;
				return A3(
					$stil4m$elm_syntax$Elm$Inspector$inspectType,
					config,
					A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, typeDecl),
					context);
			case 3:
				var signature = declaration.a;
				return A3(
					$stil4m$elm_syntax$Elm$Inspector$inspectPortDeclaration,
					config,
					A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, signature),
					context);
			case 4:
				var inf = declaration.a;
				return A4(
					$stil4m$elm_syntax$Elm$Inspector$actionLambda,
					config.aG,
					$elm$core$Basics$identity,
					A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, r, inf),
					context);
			default:
				var pattern = declaration.a;
				var expresion = declaration.b;
				return A3(
					$stil4m$elm_syntax$Elm$Inspector$inspectDestructuring,
					config,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$Node$Node,
						r,
						_Utils_Tuple2(pattern, expresion)),
					context);
		}
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectDeclarations = F3(
	function (config, declarations, context) {
		return A3(
			$elm$core$List$foldl,
			$stil4m$elm_syntax$Elm$Inspector$inspectDeclaration(config),
			context,
			declarations);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectImport = F3(
	function (config, imp, context) {
		return A4($stil4m$elm_syntax$Elm$Inspector$actionLambda, config.aF, $elm$core$Basics$identity, imp, context);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspectImports = F3(
	function (config, imports, context) {
		return A3(
			$elm$core$List$foldl,
			$stil4m$elm_syntax$Elm$Inspector$inspectImport(config),
			context,
			imports);
	});
var $stil4m$elm_syntax$Elm$Inspector$inspect = F3(
	function (config, file, context) {
		return A4(
			$stil4m$elm_syntax$Elm$Inspector$actionLambda,
			config.aC,
			A2(
				$elm$core$Basics$composeR,
				A2($stil4m$elm_syntax$Elm$Inspector$inspectImports, config, file.a),
				A2($stil4m$elm_syntax$Elm$Inspector$inspectDeclarations, config, file.b_)),
			file,
			context);
	});
var $stil4m$elm_syntax$Elm$Processing$Documentation$isDocumentationForRange = F2(
	function (range, _v0) {
		var commentRange = _v0.a;
		var commentText = _v0.b;
		if (A2($elm$core$String$startsWith, '{-|', commentText)) {
			var functionStartRow = range.br.bo;
			return _Utils_eq(commentRange.a6.bo + 1, functionStartRow);
		} else {
			return false;
		}
	});
var $stil4m$elm_syntax$Elm$Processing$Documentation$findDocumentationForRange = F2(
	function (range, comments) {
		findDocumentationForRange:
		while (true) {
			if (!comments.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var comment = comments.a;
				var restOfComments = comments.b;
				if (A2($stil4m$elm_syntax$Elm$Processing$Documentation$isDocumentationForRange, range, comment)) {
					return $elm$core$Maybe$Just(comment);
				} else {
					var $temp$range = range,
						$temp$comments = restOfComments;
					range = $temp$range;
					comments = $temp$comments;
					continue findDocumentationForRange;
				}
			}
		}
	});
var $stil4m$elm_syntax$Elm$Processing$Documentation$replaceDeclaration = F2(
	function (_v0, _v1) {
		var r1 = _v0.a;
		var _new = _v0.b;
		var r2 = _v1.a;
		var old = _v1.b;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			r2,
			_Utils_eq(r1, r2) ? _new : old);
	});
var $stil4m$elm_syntax$Elm$Processing$Documentation$onFunction = F2(
	function (_v0, file) {
		var functionRange = _v0.a;
		var _function = _v0.b;
		var _v1 = A2($stil4m$elm_syntax$Elm$Processing$Documentation$findDocumentationForRange, functionRange, file.a$);
		if (!_v1.$) {
			var doc = _v1.a;
			var docRange = doc.a;
			var docString = doc.b;
			return _Utils_update(
				file,
				{
					a$: A2(
						$elm$core$List$filter,
						$elm$core$Basics$neq(doc),
						file.a$),
					b_: A2(
						$elm$core$List$map,
						$stil4m$elm_syntax$Elm$Processing$Documentation$replaceDeclaration(
							A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								functionRange,
								$stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(
									_Utils_update(
										_function,
										{
											aw: $elm$core$Maybe$Just(
												A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, docRange, docString))
										})))),
						file.b_)
				});
		} else {
			return file;
		}
	});
var $stil4m$elm_syntax$Elm$Processing$Documentation$onType = F2(
	function (_v0, file) {
		var r = _v0.a;
		var customType = _v0.b;
		var _v1 = A2($stil4m$elm_syntax$Elm$Processing$Documentation$findDocumentationForRange, r, file.a$);
		if (!_v1.$) {
			var doc = _v1.a;
			var docRange = doc.a;
			var docString = doc.b;
			return _Utils_update(
				file,
				{
					a$: A2(
						$elm$core$List$filter,
						$elm$core$Basics$neq(doc),
						file.a$),
					b_: A2(
						$elm$core$List$map,
						$stil4m$elm_syntax$Elm$Processing$Documentation$replaceDeclaration(
							A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								r,
								$stil4m$elm_syntax$Elm$Syntax$Declaration$CustomTypeDeclaration(
									_Utils_update(
										customType,
										{
											aw: $elm$core$Maybe$Just(
												A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, docRange, docString))
										})))),
						file.b_)
				});
		} else {
			return file;
		}
	});
var $stil4m$elm_syntax$Elm$Processing$Documentation$onTypeAlias = F2(
	function (_v0, file) {
		var r = _v0.a;
		var typeAlias = _v0.b;
		var _v1 = A2($stil4m$elm_syntax$Elm$Processing$Documentation$findDocumentationForRange, r, file.a$);
		if (!_v1.$) {
			var doc = _v1.a;
			var docRange = doc.a;
			var docString = doc.b;
			return _Utils_update(
				file,
				{
					a$: A2(
						$elm$core$List$filter,
						$elm$core$Basics$neq(doc),
						file.a$),
					b_: A2(
						$elm$core$List$map,
						$stil4m$elm_syntax$Elm$Processing$Documentation$replaceDeclaration(
							A2(
								$stil4m$elm_syntax$Elm$Syntax$Node$Node,
								r,
								$stil4m$elm_syntax$Elm$Syntax$Declaration$AliasDeclaration(
									_Utils_update(
										typeAlias,
										{
											aw: $elm$core$Maybe$Just(
												A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, docRange, docString))
										})))),
						file.b_)
				});
		} else {
			return file;
		}
	});
var $stil4m$elm_syntax$Elm$Processing$Documentation$postProcess = function (file) {
	return A3(
		$stil4m$elm_syntax$Elm$Inspector$inspect,
		_Utils_update(
			$stil4m$elm_syntax$Elm$Inspector$defaultConfig,
			{
				aD: $stil4m$elm_syntax$Elm$Inspector$Post($stil4m$elm_syntax$Elm$Processing$Documentation$onFunction),
				aO: $stil4m$elm_syntax$Elm$Inspector$Post($stil4m$elm_syntax$Elm$Processing$Documentation$onType),
				aP: $stil4m$elm_syntax$Elm$Inspector$Post($stil4m$elm_syntax$Elm$Processing$Documentation$onTypeAlias)
			}),
		file,
		file);
};
var $stil4m$elm_syntax$Elm$Interface$operators = $elm$core$List$filterMap(
	function (i) {
		if (i.$ === 3) {
			var o = i.a;
			return $elm$core$Maybe$Just(o);
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $stil4m$elm_syntax$Elm$Syntax$Exposing$operator = function (t) {
	if (!t.$) {
		var s = t.a;
		return $elm$core$Maybe$Just(s);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$operators = function (l) {
	return A2($elm$core$List$filterMap, $stil4m$elm_syntax$Elm$Syntax$Exposing$operator, l);
};
var $stil4m$elm_syntax$Elm$Processing$buildSingle = F2(
	function (imp, moduleIndex) {
		var _v0 = imp.b9;
		if (_v0.$ === 1) {
			return _List_Nil;
		} else {
			if (!_v0.a.b.$) {
				var _v1 = _v0.a;
				return A2(
					$elm$core$List$map,
					function (x) {
						return _Utils_Tuple2(
							$stil4m$elm_syntax$Elm$Syntax$Node$value(x.cW),
							x);
					},
					$stil4m$elm_syntax$Elm$Interface$operators(
						A2(
							$elm$core$Maybe$withDefault,
							_List_Nil,
							A2(
								$elm$core$Dict$get,
								$stil4m$elm_syntax$Elm$Syntax$Node$value(imp.ay),
								moduleIndex))));
			} else {
				var _v2 = _v0.a;
				var l = _v2.b.a;
				var selectedOperators = $stil4m$elm_syntax$Elm$Syntax$Exposing$operators(
					A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Syntax$Node$value, l));
				return A2(
					$elm$core$List$filter,
					A2(
						$elm$core$Basics$composeR,
						$elm$core$Tuple$first,
						function (elem) {
							return A2($elm$core$List$member, elem, selectedOperators);
						}),
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(
								$stil4m$elm_syntax$Elm$Syntax$Node$value(x.cW),
								x);
						},
						$stil4m$elm_syntax$Elm$Interface$operators(
							A2(
								$elm$core$Maybe$withDefault,
								_List_Nil,
								A2(
									$elm$core$Dict$get,
									$stil4m$elm_syntax$Elm$Syntax$Node$value(imp.ay),
									moduleIndex)))));
			}
		}
	});
var $stil4m$elm_syntax$Elm$DefaultImports$defaults = _List_fromArray(
	[
		{
		b9: $elm$core$Maybe$Just(
			A2(
				$stil4m$elm_syntax$Elm$Syntax$Node$Node,
				$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$All($stil4m$elm_syntax$Elm$Syntax$Range$emptyRange))),
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Basics']))
	},
		{
		b9: $elm$core$Maybe$Just(
			A2(
				$stil4m$elm_syntax$Elm$Syntax$Node$Node,
				$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
								A2($stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType, 'List', $elm$core$Maybe$Nothing))),
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$InfixExpose('::'))
						])))),
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['List']))
	},
		{
		b9: $elm$core$Maybe$Just(
			A2(
				$stil4m$elm_syntax$Elm$Syntax$Node$Node,
				$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
								A2(
									$stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType,
									'Maybe',
									$elm$core$Maybe$Just($stil4m$elm_syntax$Elm$Syntax$Range$emptyRange))))
						])))),
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Maybe']))
	},
		{
		b9: $elm$core$Maybe$Just(
			A2(
				$stil4m$elm_syntax$Elm$Syntax$Node$Node,
				$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
								A2(
									$stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType,
									'Result',
									$elm$core$Maybe$Just($stil4m$elm_syntax$Elm$Syntax$Range$emptyRange))))
						])))),
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Result']))
	},
		{
		b9: $elm$core$Maybe$Nothing,
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['String']))
	},
		{
		b9: $elm$core$Maybe$Nothing,
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Tuple']))
	},
		{
		b9: $elm$core$Maybe$Nothing,
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Debug']))
	},
		{
		b9: $elm$core$Maybe$Just(
			A2(
				$stil4m$elm_syntax$Elm$Syntax$Node$Node,
				$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
								A2($stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType, 'Program', $elm$core$Maybe$Nothing)))
						])))),
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Platform']))
	},
		{
		b9: $elm$core$Maybe$Just(
			A2(
				$stil4m$elm_syntax$Elm$Syntax$Node$Node,
				$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
								A2($stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType, 'Cmd', $elm$core$Maybe$Nothing))),
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$InfixExpose('!'))
						])))),
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Platform', 'Cmd']))
	},
		{
		b9: $elm$core$Maybe$Just(
			A2(
				$stil4m$elm_syntax$Elm$Syntax$Node$Node,
				$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
				$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					_List_fromArray(
						[
							A2(
							$stil4m$elm_syntax$Elm$Syntax$Node$Node,
							$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
							$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
								A2($stil4m$elm_syntax$Elm$Syntax$Exposing$ExposedType, 'Sub', $elm$core$Maybe$Nothing)))
						])))),
		be: $elm$core$Maybe$Nothing,
		ay: A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			$stil4m$elm_syntax$Elm$Syntax$Range$emptyRange,
			_List_fromArray(
				['Platform', 'Sub']))
	}
	]);
var $stil4m$elm_syntax$Elm$RawFile$imports = function (_v0) {
	var file = _v0;
	return A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Syntax$Node$value, file.a);
};
var $stil4m$elm_syntax$Elm$Processing$tableForFile = F2(
	function (rawFile, _v0) {
		var moduleIndex = _v0;
		return $elm$core$Dict$fromList(
			A2(
				$elm$core$List$concatMap,
				function (a) {
					return A2($stil4m$elm_syntax$Elm$Processing$buildSingle, a, moduleIndex);
				},
				_Utils_ap(
					$stil4m$elm_syntax$Elm$DefaultImports$defaults,
					$stil4m$elm_syntax$Elm$RawFile$imports(rawFile))));
	});
var $stil4m$elm_syntax$Elm$Processing$visitExpression = F3(
	function (visitor, context, expression) {
		var inner = A2($stil4m$elm_syntax$Elm$Processing$visitExpressionInner, visitor, context);
		return A3(
			A2(
				$elm$core$Maybe$withDefault,
				F3(
					function (_v4, nest, expr) {
						return nest(expr);
					}),
				visitor),
			context,
			inner,
			expression);
	});
var $stil4m$elm_syntax$Elm$Processing$visitExpressionInner = F3(
	function (visitor, context, _v2) {
		var range = _v2.a;
		var expression = _v2.b;
		var subVisit = A2($stil4m$elm_syntax$Elm$Processing$visitExpression, visitor, context);
		return function (newExpr) {
			return A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, range, newExpr);
		}(
			function () {
				switch (expression.$) {
					case 1:
						var expressionList = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$Application(
							A2($elm$core$List$map, subVisit, expressionList));
					case 2:
						var op = expression.a;
						var dir = expression.b;
						var left = expression.c;
						var right = expression.d;
						return A4(
							$stil4m$elm_syntax$Elm$Syntax$Expression$OperatorApplication,
							op,
							dir,
							subVisit(left),
							subVisit(right));
					case 4:
						var e1 = expression.a;
						var e2 = expression.b;
						var e3 = expression.c;
						return A3(
							$stil4m$elm_syntax$Elm$Syntax$Expression$IfBlock,
							subVisit(e1),
							subVisit(e2),
							subVisit(e3));
					case 13:
						var expressionList = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$TupledExpression(
							A2($elm$core$List$map, subVisit, expressionList));
					case 14:
						var expr1 = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
							subVisit(expr1));
					case 15:
						var letBlock = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$LetExpression(
							{
								b_: A3($stil4m$elm_syntax$Elm$Processing$visitLetDeclarations, visitor, context, letBlock.b_),
								b: subVisit(letBlock.b)
							});
					case 16:
						var caseBlock = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$CaseExpression(
							{
								ai: A2(
									$elm$core$List$map,
									$elm$core$Tuple$mapSecond(subVisit),
									caseBlock.ai),
								b: subVisit(caseBlock.b)
							});
					case 17:
						var lambda = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
							_Utils_update(
								lambda,
								{
									b: subVisit(lambda.b)
								}));
					case 18:
						var expressionStringList = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr(
							A2(
								$elm$core$List$map,
								$stil4m$elm_syntax$Elm$Syntax$Node$map(
									$elm$core$Tuple$mapSecond(subVisit)),
								expressionStringList));
					case 19:
						var expressionList = expression.a;
						return $stil4m$elm_syntax$Elm$Syntax$Expression$ListExpr(
							A2($elm$core$List$map, subVisit, expressionList));
					case 22:
						var name = expression.a;
						var updates = expression.b;
						return A2(
							$stil4m$elm_syntax$Elm$Syntax$Expression$RecordUpdateExpression,
							name,
							A2(
								$elm$core$List$map,
								$stil4m$elm_syntax$Elm$Syntax$Node$map(
									$elm$core$Tuple$mapSecond(subVisit)),
								updates));
					default:
						return expression;
				}
			}());
	});
var $stil4m$elm_syntax$Elm$Processing$visitFunctionDecl = F3(
	function (visitor, context, _function) {
		var newFunctionDeclaration = A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$map,
			A2($stil4m$elm_syntax$Elm$Processing$visitFunctionDeclaration, visitor, context),
			_function.bX);
		return _Utils_update(
			_function,
			{bX: newFunctionDeclaration});
	});
var $stil4m$elm_syntax$Elm$Processing$visitFunctionDeclaration = F3(
	function (visitor, context, functionDeclaration) {
		var newExpression = A3($stil4m$elm_syntax$Elm$Processing$visitExpression, visitor, context, functionDeclaration.b);
		return _Utils_update(
			functionDeclaration,
			{b: newExpression});
	});
var $stil4m$elm_syntax$Elm$Processing$visitLetDeclaration = F3(
	function (visitor, context, _v0) {
		var range = _v0.a;
		var declaration = _v0.b;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			range,
			function () {
				if (!declaration.$) {
					var _function = declaration.a;
					return $stil4m$elm_syntax$Elm$Syntax$Expression$LetFunction(
						A3($stil4m$elm_syntax$Elm$Processing$visitFunctionDecl, visitor, context, _function));
				} else {
					var pattern = declaration.a;
					var expression = declaration.b;
					return A2(
						$stil4m$elm_syntax$Elm$Syntax$Expression$LetDestructuring,
						pattern,
						A3($stil4m$elm_syntax$Elm$Processing$visitExpression, visitor, context, expression));
				}
			}());
	});
var $stil4m$elm_syntax$Elm$Processing$visitLetDeclarations = F3(
	function (visitor, context, declarations) {
		return A2(
			$elm$core$List$map,
			A2($stil4m$elm_syntax$Elm$Processing$visitLetDeclaration, visitor, context),
			declarations);
	});
var $stil4m$elm_syntax$Elm$Processing$visitDeclaration = F3(
	function (visitor, context, _v0) {
		var range = _v0.a;
		var declaration = _v0.b;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			range,
			function () {
				if (!declaration.$) {
					var _function = declaration.a;
					return $stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(
						A3($stil4m$elm_syntax$Elm$Processing$visitFunctionDecl, visitor, context, _function));
				} else {
					return declaration;
				}
			}());
	});
var $stil4m$elm_syntax$Elm$Processing$visitDeclarations = F3(
	function (visitor, context, declarations) {
		return A2(
			$elm$core$List$map,
			A2($stil4m$elm_syntax$Elm$Processing$visitDeclaration, visitor, context),
			declarations);
	});
var $stil4m$elm_syntax$Elm$Processing$visit = F3(
	function (visitor, context, file) {
		var newDeclarations = A3($stil4m$elm_syntax$Elm$Processing$visitDeclarations, visitor, context, file.b_);
		return _Utils_update(
			file,
			{b_: newDeclarations});
	});
var $stil4m$elm_syntax$Elm$Processing$process = F2(
	function (processContext, rawFile) {
		var file = rawFile;
		var table = A2($stil4m$elm_syntax$Elm$Processing$tableForFile, rawFile, processContext);
		var operatorFixed = A3(
			$stil4m$elm_syntax$Elm$Processing$visit,
			$elm$core$Maybe$Just(
				F3(
					function (context, inner, expression) {
						return inner(
							function () {
								if (expression.b.$ === 1) {
									var r = expression.a;
									var args = expression.b.a;
									return A2(
										$stil4m$elm_syntax$Elm$Syntax$Node$Node,
										r,
										A2($stil4m$elm_syntax$Elm$Processing$fixApplication, context, args));
								} else {
									return expression;
								}
							}());
					})),
			table,
			file);
		var documentationFixed = $stil4m$elm_syntax$Elm$Processing$Documentation$postProcess(operatorFixed);
		return documentationFixed;
	});
var $author$project$DocsFromSource$toDocType = function (annotation) {
	switch (annotation.$) {
		case 0:
			var _var = annotation.a;
			return $elm$project_metadata_utils$Elm$Type$Var(_var);
		case 1:
			var modName = annotation.a;
			var inner = annotation.b;
			var typeName = function () {
				var _v1 = $author$project$Internal$Compiler$denode(modName);
				if (!_v1.a.b) {
					var valName = _v1.b;
					return valName;
				} else {
					var mod = _v1.a;
					var valName = _v1.b;
					return A2($elm$core$String$join, '.', mod) + ('.' + valName);
				}
			}();
			return A2(
				$elm$project_metadata_utils$Elm$Type$Type,
				typeName,
				A2(
					$elm$core$List$map,
					A2($elm$core$Basics$composeR, $author$project$Internal$Compiler$denode, $author$project$DocsFromSource$toDocType),
					inner));
		case 2:
			return $elm$project_metadata_utils$Elm$Type$Tuple(_List_Nil);
		case 3:
			var inner = annotation.a;
			return $elm$project_metadata_utils$Elm$Type$Tuple(
				A2(
					$elm$core$List$map,
					A2($elm$core$Basics$composeL, $author$project$DocsFromSource$toDocType, $author$project$Internal$Compiler$denode),
					inner));
		case 4:
			var fields = annotation.a;
			return A2(
				$elm$project_metadata_utils$Elm$Type$Record,
				A2(
					$elm$core$List$map,
					function (f) {
						var _v2 = $author$project$Internal$Compiler$denode(f);
						var name = _v2.a;
						var fieldAnnotation = _v2.b;
						return _Utils_Tuple2(
							$author$project$Internal$Compiler$denode(name),
							$author$project$DocsFromSource$toDocType(
								$author$project$Internal$Compiler$denode(fieldAnnotation)));
					},
					fields),
				$elm$core$Maybe$Nothing);
		case 5:
			var recordName = annotation.a;
			var fields = annotation.b;
			return A2(
				$elm$project_metadata_utils$Elm$Type$Record,
				A2(
					$elm$core$List$map,
					function (f) {
						var _v3 = $author$project$Internal$Compiler$denode(f);
						var name = _v3.a;
						var fieldAnnotation = _v3.b;
						return _Utils_Tuple2(
							$author$project$Internal$Compiler$denode(name),
							$author$project$DocsFromSource$toDocType(
								$author$project$Internal$Compiler$denode(fieldAnnotation)));
					},
					$author$project$Internal$Compiler$denode(fields)),
				$elm$core$Maybe$Just(
					$author$project$Internal$Compiler$denode(recordName)));
		default:
			var one = annotation.a;
			var two = annotation.b;
			return A2(
				$elm$project_metadata_utils$Elm$Type$Lambda,
				$author$project$DocsFromSource$toDocType(
					$author$project$Internal$Compiler$denode(one)),
				$author$project$DocsFromSource$toDocType(
					$author$project$Internal$Compiler$denode(two)));
	}
};
var $author$project$DocsFromSource$portToValue = function (signature) {
	return {
		aj: '',
		I: $author$project$Internal$Compiler$denode(signature.I),
		aU: $author$project$DocsFromSource$toDocType(
			$author$project$Internal$Compiler$denode(signature.aV))
	};
};
var $author$project$DocsFromSource$toDocAlias = function (typeAlias) {
	return {
		aX: A2($elm$core$List$map, $author$project$Internal$Compiler$denode, typeAlias.a9),
		aj: function () {
			var _v0 = typeAlias.aw;
			if (_v0.$ === 1) {
				return '';
			} else {
				var str = _v0.a;
				return $author$project$Internal$Compiler$denode(str);
			}
		}(),
		I: $author$project$Internal$Compiler$denode(typeAlias.I),
		aU: $author$project$DocsFromSource$toDocType(
			$author$project$Internal$Compiler$denode(typeAlias.aV))
	};
};
var $author$project$DocsFromSource$toDocUnion = function (type_) {
	return {
		aX: A2($elm$core$List$map, $author$project$Internal$Compiler$denode, type_.a9),
		aj: function () {
			var _v0 = type_.aw;
			if (_v0.$ === 1) {
				return '';
			} else {
				var doc = _v0.a;
				return $author$project$Internal$Compiler$denode(doc);
			}
		}(),
		I: $author$project$Internal$Compiler$denode(type_.I),
		dh: A2(
			$elm$core$List$map,
			function (_const) {
				var _v1 = $author$project$Internal$Compiler$denode(_const);
				var node = _v1;
				return _Utils_Tuple2(
					$author$project$Internal$Compiler$denode(node.I),
					A2(
						$elm$core$List$map,
						A2($elm$core$Basics$composeR, $author$project$Internal$Compiler$denode, $author$project$DocsFromSource$toDocType),
						node.bG));
			},
			type_.bU)
	};
};
var $author$project$DocsFromSource$toDocValue = function (fn) {
	var _v0 = fn.db;
	if (_v0.$ === 1) {
		return $elm$core$Maybe$Nothing;
	} else {
		var signature = _v0.a;
		return $elm$core$Maybe$Just(
			{
				aj: function () {
					var _v1 = fn.aw;
					if (_v1.$ === 1) {
						return '';
					} else {
						var doc = _v1.a;
						return $author$project$Internal$Compiler$denode(doc);
					}
				}(),
				I: function () {
					var _v2 = $author$project$Internal$Compiler$denode(fn.bX);
					var implementation = _v2;
					return $author$project$Internal$Compiler$denode(implementation.I);
				}(),
				aU: $author$project$DocsFromSource$toDocType(
					$author$project$Internal$Compiler$denode(
						$author$project$Internal$Compiler$denode(signature).aV))
			});
	}
};
var $author$project$DocsFromSource$gather = F2(
	function (node, found) {
		var _v0 = $author$project$Internal$Compiler$denode(node);
		switch (_v0.$) {
			case 0:
				var fn = _v0.a;
				var _v1 = $author$project$DocsFromSource$toDocValue(fn);
				if (_v1.$ === 1) {
					return found;
				} else {
					var val = _v1.a;
					return _Utils_update(
						found,
						{
							Z: A2($elm$core$List$cons, val, found.Z)
						});
				}
			case 1:
				var alias = _v0.a;
				return _Utils_update(
					found,
					{
						ah: A2(
							$elm$core$List$cons,
							$author$project$DocsFromSource$toDocAlias(alias),
							found.ah)
					});
			case 2:
				var type_ = _v0.a;
				return _Utils_update(
					found,
					{
						aq: A2(
							$elm$core$List$cons,
							$author$project$DocsFromSource$toDocUnion(type_),
							found.aq)
					});
			case 3:
				var portSignature = _v0.a;
				return _Utils_update(
					found,
					{
						Z: A2(
							$elm$core$List$cons,
							$author$project$DocsFromSource$portToValue(portSignature),
							found.Z)
					});
			case 4:
				var inf = _v0.a;
				return found;
			default:
				return found;
		}
	});
var $author$project$DocsFromSource$toDocs = function (file) {
	var gathered = A3(
		$elm$core$List$foldl,
		$author$project$DocsFromSource$gather,
		{ah: _List_Nil, aq: _List_Nil, Z: _List_Nil},
		file.b_);
	return {
		ah: gathered.ah,
		bI: _List_Nil,
		aj: '',
		I: function () {
			var _v0 = $author$project$Internal$Compiler$denode(file.cO);
			switch (_v0.$) {
				case 0:
					var mod = _v0.a;
					return A2(
						$elm$core$String$join,
						'.',
						$author$project$Internal$Compiler$denode(mod.ay));
				case 1:
					var mod = _v0.a;
					return A2(
						$elm$core$String$join,
						'.',
						$author$project$Internal$Compiler$denode(mod.ay));
				default:
					var mod = _v0.a;
					return A2(
						$elm$core$String$join,
						'.',
						$author$project$Internal$Compiler$denode(mod.ay));
			}
		}(),
		aq: gathered.aq,
		Z: gathered.Z
	};
};
var $author$project$DocsFromSource$fromSource = function (source) {
	var _v0 = $stil4m$elm_syntax$Elm$Parser$parse(source);
	if (_v0.$ === 1) {
		var deadends = _v0.a;
		return $elm$core$Result$Err('Unable to parse');
	} else {
		var raw = _v0.a;
		return $elm$core$Result$Ok(
			$author$project$DocsFromSource$toDocs(
				A2($stil4m$elm_syntax$Elm$Processing$process, $stil4m$elm_syntax$Elm$Processing$init, raw)));
	}
};
var $author$project$Generate$parseSources = F2(
	function (srcs, parsed) {
		parseSources:
		while (true) {
			if (!srcs.b) {
				return $elm$core$Result$Ok(parsed);
			} else {
				var top = srcs.a;
				var remain = srcs.b;
				var _v1 = $author$project$DocsFromSource$fromSource(top);
				if (_v1.$ === 1) {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				} else {
					var topParsed = _v1.a;
					var $temp$srcs = remain,
						$temp$parsed = A2($elm$core$List$cons, topParsed, parsed);
					srcs = $temp$srcs;
					parsed = $temp$parsed;
					continue parseSources;
				}
			}
		}
	});
var $elm$json$Json$Decode$value = _Json_decodeValue;
var $elm$core$Platform$worker = _Platform_worker;
var $author$project$Generate$main = $elm$core$Platform$worker(
	{
		cu: function (json) {
			var _v0 = A2($elm$json$Json$Decode$decodeValue, $author$project$Generate$flagsDecoder, json);
			if (_v0.$ === 1) {
				var err = _v0.a;
				return _Utils_Tuple2(
					0,
					$author$project$Elm$Gen$error(
						{
							b$: $elm$json$Json$Decode$errorToString(err),
							di: 'Invalid docs'
						}));
			} else {
				if (!_v0.a.$) {
					var docs = _v0.a.a;
					return _Utils_Tuple2(
						0,
						$author$project$Elm$Gen$files(
							A2($elm$core$List$map, $author$project$Generate$moduleToFile, docs)));
				} else {
					var srcs = _v0.a.a;
					var _v1 = A2($author$project$Generate$parseSources, srcs, _List_Nil);
					if (!_v1.$) {
						var docs = _v1.a;
						return _Utils_Tuple2(
							0,
							$author$project$Elm$Gen$files(
								A2($elm$core$List$map, $author$project$Generate$moduleToFile, docs)));
					} else {
						var err = _v1.a;
						return _Utils_Tuple2(
							0,
							$author$project$Elm$Gen$error(
								{b$: err, di: 'Error generating docs'}));
					}
				}
			}
		},
		dg: function (_v2) {
			return $elm$core$Platform$Sub$none;
		},
		$7: F2(
			function (msg, model) {
				return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
			})
	});
_Platform_export({'Generate':{'init':$author$project$Generate$main($elm$json$Json$Decode$value)(0)}});}(this));