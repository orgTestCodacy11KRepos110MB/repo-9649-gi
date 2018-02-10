
-- apply fun to each element of the array arr,
-- then concatenate them together with splice in
-- between each one. It arr is empty then we
-- return the empty string. arr can start at
-- [0] or [1].
function __mapAndJoinStrings(splice, arr, fun)
   local newarr = {}
   -- handle a zero argument, if present.
   local bump = 0
   local zval = arr[0]
   if zval ~= nil then
      bump = 1
      newarr[1] = fun(zval)
   end
   for i,v in ipairs(arr) do
      newarr[i+bump] = fun(v)
   end
   return table.concat(newarr, splice)
end

__global ={};
__module ={};

if (__global == nil  or  __global.Array == nil) then
  throw new Error("no global object found");
end
if (typeof module ~= "nil") then
  __module = module;
end

var __packages = {}, __idCounter = 0;
var __keys = function(m)  return m ? Object.keys(m) : []; end;
var __flushConsole = function() end;
var __throwRuntimeError; /* set by package "runtime" */
var __throwNilPointerError = function()  __throwRuntimeError("invalid memory address or nil pointer dereference"); end;
var __call = function(fn, rcvr, args)  return fn.apply(rcvr, args); end;
var __makeFunc = function(fn)  return function()  return __externalize(fn(this, new (__sliceType(__jsObjectPtr))(__global.Array.prototype.slice.call(arguments, []))), __emptyInterface); end; end;
var __unused = function(v) end;

var __mapArray = function(array, f) 
  var newArray = new array.constructor(array.length);
  for (var i = 0; i < array.length; i++) {
    newArray[i] = f(array[i]);
  end
  return newArray;
end;

var __methodVal = function(recv, name) 
  var vals = recv.__methodVals  or  {};
  recv.__methodVals = vals; /* noop for primitives */
  var f = vals[name];
  if (f ~= nil) then
    return f;
  end
  var method = recv[name];
  f = function() 
    __stackDepthOffset--;
    try {
      return method.apply(recv, arguments);
    } finally {
      __stackDepthOffset++;
    end
  end;
  vals[name] = f;
  return f;
end;

var __methodExpr = function(typ, name) 
  var method = typ.prototype[name];
  if (method.__expr == nil) then
    method.__expr = function() 
      __stackDepthOffset--;
      try {
        if (typ.wrapped) then
          arguments[0] = new typ(arguments[0]);
        end
        return Function.call.apply(method, arguments);
      } finally {
        __stackDepthOffset++;
      end
    end;
  end
  return method.__expr;
end;

var __ifaceMethodExprs = {};
var __ifaceMethodExpr = function(name) 
  var expr = __ifaceMethodExprs["_" + name];
  if (expr == nil) then
    expr = __ifaceMethodExprs["_" + name] = function()
      __stackDepthOffset--;
      try {
        return Function.call.apply(arguments[0][name], arguments);
      } finally {
        __stackDepthOffset++;
      end
    end;
  end
  return expr;
end;

var __subslice = function(x)
  if (low < 0  or  high < low  or  max < high  or  high > slice.__capacity  or  max > slice.__capacity) then
    __throwRuntimeError("slice bounds out of range");
  end
  var s = new slice.constructor(slice.__array);
  s.__offset = slice.__offset + low;
  s.__length = slice.__length - low;
  s.__capacity = slice.__capacity - low;
  if (high ~= nil) then
    s.__length = high - low;
  end
  if (max ~= nil) then
    s.__capacity = max - low;
  end
  return s;
end;

var __substring = function(h)
  if (low < 0  or  high < low  or  high > str.length) then
    __throwRuntimeError("slice bounds out of range");
  end
  return str.substring(low, high);
end;

var __sliceToArray = function(e)
  if (slice.__array.constructor ~= Array) then
    return slice.__array.subarray(slice.__offset, slice.__offset + slice.__length);
  end
  return slice.__array.slice(slice.__offset, slice.__offset + slice.__length);
end;

var __decodeRune = function(s)
  var c0 = str.charCodeAt(pos);

  if (c0 < 0x80) then
    return [c0, 1];
  end

  if (c0 ~= c0  or  c0 < 0xC0) then
    return [0xFFFD, 1];
  end

  var c1 = str.charCodeAt(pos + 1);
  if (c1 ~= c1  or  c1 < 0x80  or  0xC0 <= c1) then
    return [0xFFFD, 1];
  end

  if (c0 < 0xE0) then
    var r = (c0 & 0x1F) << 6 | (c1 & 0x3F);
    if (r <= 0x7F) then
      return [0xFFFD, 1];
    end
    return [r, 2];
  end

  var c2 = str.charCodeAt(pos + 2);
  if (c2 ~= c2  or  c2 < 0x80  or  0xC0 <= c2) then
    return [0xFFFD, 1];
  end

  if (c0 < 0xF0) then
    var r = (c0 & 0x0F) << 12 | (c1 & 0x3F) << 6 | (c2 & 0x3F);
    if (r <= 0x7FF) then
      return [0xFFFD, 1];
    end
    if (0xD800 <= r  and  r <= 0xDFFF) then
      return [0xFFFD, 1];
    end
    return [r, 3];
  end

  var c3 = str.charCodeAt(pos + 3);
  if (c3 ~= c3  or  c3 < 0x80  or  0xC0 <= c3) then
    return [0xFFFD, 1];
  end

  if (c0 < 0xF8) then
    var r = (c0 & 0x07) << 18 | (c1 & 0x3F) << 12 | (c2 & 0x3F) << 6 | (c3 & 0x3F);
    if (r <= 0xFFFF  or  0x10FFFF < r) then
      return [0xFFFD, 1];
    end
    return [r, 4];
  end

  return [0xFFFD, 1];
end;

var __encodeRune = function(r)
  if (r < 0  or  r > 0x10FFFF  or  (0xD800 <= r  and  r <= 0xDFFF)) then
    r = 0xFFFD;
  end
  if (r <= 0x7F) then
    return String.fromCharCode(r);
  end
  if (r <= 0x7FF) then
    return String.fromCharCode(0xC0 | r >> 6, 0x80 | (r & 0x3F));
  end
  if (r <= 0xFFFF) then
    return String.fromCharCode(0xE0 | r >> 12, 0x80 | (r >> 6 & 0x3F), 0x80 | (r & 0x3F));
  end
  return String.fromCharCode(0xF0 | r >> 18, 0x80 | (r >> 12 & 0x3F), 0x80 | (r >> 6 & 0x3F), 0x80 | (r & 0x3F));
end;

var __stringToBytes = function(r)
  var array = new Uint8Array(str.length);
  for (var i = 0; i < str.length; i++) {
    array[i] = str.charCodeAt(i);
  end
  return array;
end;

var __bytesToString = function(e)
  if (slice.__length == 0) then
    return "";
  end
  var str = "";
  for (var i = 0; i < slice.__length; i += 10000) {
    str += String.fromCharCode.apply(nil, slice.__array.subarray(slice.__offset + i, slice.__offset + Math.min(slice.__length, i + 10000)));
  end
  return str;
end;

var __stringToRunes = function(r)
  var array = new Int32Array(str.length);
  var rune, j = 0;
  for (var i = 0; i < str.length; i += rune[1], j++) {
    rune = __decodeRune(str, i);
    array[j] = rune[0];
  end
  return array.subarray(0, j);
end;

var __runesToString = function(e)
  if (slice.__length == 0) then
    return "";
  end
  var str = "";
  for (var i = 0; i < slice.__length; i++) {
    str += __encodeRune(slice.__array[slice.__offset + i]);
  end
  return str;
end;

var __copyString = function(c)
  var n = Math.min(src.length, dst.__length);
  for (var i = 0; i < n; i++) {
    dst.__array[dst.__offset + i] = src.charCodeAt(i);
  end
  return n;
end;

var __copySlice = function(c)
  var n = Math.min(src.__length, dst.__length);
  __copyArray(dst.__array, src.__array, dst.__offset, src.__offset, n, dst.constructor.elem);
  return n;
end;

var __copyArray = function(m)
  if (n == 0  or  (dst == src  and  dstOffset == srcOffset)) then
    return;
  end

  if (src.subarray) then
    dst.set(src.subarray(srcOffset, srcOffset + n), dstOffset);
    return;
  end

  switch (elem.kind) {
  case __kindArray:
  case __kindStruct:
    if (dst == src  and  dstOffset > srcOffset) then
      for (var i = n - 1; i >= 0; i--) {
        elem.copy(dst[dstOffset + i], src[srcOffset + i]);
      end
      return;
    end
    for (var i = 0; i < n; i++) {
      elem.copy(dst[dstOffset + i], src[srcOffset + i]);
    end
    return;
  end

  if (dst == src  and  dstOffset > srcOffset) then
    for (var i = n - 1; i >= 0; i--) {
      dst[dstOffset + i] = src[srcOffset + i];
    end
    return;
  end
  for (var i = 0; i < n; i++) {
    dst[dstOffset + i] = src[srcOffset + i];
  end
end;

var __clone = function(e)
  var clone = type.zero();
  type.copy(clone, src);
  return clone;
end;

var __pointerOfStructConversion = function(e)
  if(obj.__proxies == nil) then
    obj.__proxies = {};
    obj.__proxies[obj.constructor.string] = obj;
  end
  var proxy = obj.__proxies[type.string];
  if (proxy == nil) then
    var properties = {};
    for (var i = 0; i < type.elem.fields.length; i++) {
      (function(p)
        properties[fieldProp] = {
          get: function() return obj[fieldProp]; end,
          set: function(e) obj[fieldProp] = value; end
        end;
      end)(type.elem.fields[i].prop);
    end
    proxy = Object.create(type.prototype, properties);
    proxy.__val = proxy;
    obj.__proxies[type.string] = proxy;
    proxy.__proxies = obj.__proxies;
  end
  return proxy;
end;

var __append = function(e)
  return __internalAppend(slice, arguments, 1, arguments.length - 1);
end;

var __appendSlice = function(d)
  if (toAppend.constructor == String) then
    var bytes = __stringToBytes(toAppend);
    return __internalAppend(slice, bytes, 0, bytes.length);
  end
  return __internalAppend(slice, toAppend.__array, toAppend.__offset, toAppend.__length);
end;

var __internalAppend = function(h)
  if (length == 0) then
    return slice;
  end

  var newArray = slice.__array;
  var newOffset = slice.__offset;
  var newLength = slice.__length + length;
  var newCapacity = slice.__capacity;

  if (newLength > newCapacity) then
    newOffset = 0;
    newCapacity = Math.max(newLength, slice.__capacity < 1024 ? slice.__capacity * 2 : Math.floor(slice.__capacity * 5 / 4));

    if (slice.__array.constructor == Array) then
      newArray = slice.__array.slice(slice.__offset, slice.__offset + slice.__length);
      newArray.length = newCapacity;
      var zero = slice.constructor.elem.zero;
      for (var i = slice.__length; i < newCapacity; i++) {
        newArray[i] = zero();
      end
    end else {
      newArray = new slice.__array.constructor(newCapacity);
      newArray.set(slice.__array.subarray(slice.__offset, slice.__offset + slice.__length));
    end
  end

  __copyArray(newArray, array, newOffset + slice.__length, offset, length, slice.constructor.elem);

  var newSlice = new slice.constructor(newArray);
  newSlice.__offset = newOffset;
  newSlice.__length = newLength;
  newSlice.__capacity = newCapacity;
  return newSlice;
end;

var __equal = function(e)
  if (type == __jsObjectPtr) then
    return a == b;
  end
  switch (type.kind) {
  case __kindComplex64:
  case __kindComplex128:
    return a.__real == b.__real  and  a.__imag == b.__imag;
  case __kindInt64:
  case __kindUint64:
    return a.__high == b.__high  and  a.__low == b.__low;
  case __kindArray:
    if (a.length ~= b.length) {
      return false;
    end
    for (var i = 0; i < a.length; i++) {
      if ( not __equal(a[i], b[i], type.elem)) then
        return false;
      end
    end
    return true;
  case __kindStruct:
    for (var i = 0; i < type.fields.length; i++) {
      var f = type.fields[i];
      if ( not __equal(a[f.prop], b[f.prop], f.typ)) then
        return false;
      end
    end
    return true;
  case __kindInterface:
    return __interfaceIsEqual(a, b);
  default:
    return a == b;
  end
end;

var __interfaceIsEqual = function(b)
  if (a == __ifaceNil  or  b == __ifaceNil) then
    return a == b;
  end
  if (a.constructor ~= b.constructor) then
    return false;
  end
  if (a.constructor == __jsObjectPtr) then
    return a.object == b.object;
  end
  if ( not a.constructor.comparable) then
    __throwRuntimeError("comparing uncomparable type " + a.constructor.string);
  end
  return __equal(a.__val, b.__val, a.constructor);
end;

var __min = Math.min;
var __mod = function(y) return x % y; end;
var __parseInt = parseInt;
var __parseFloat = function(f)
  if (f ~= nil  and  f ~= null  and  f.constructor == Number) then
    return f;
  end
  return parseFloat(f);
end;

var __froundBuf = new Float32Array(1);
var __fround = Math.fround  or  function(f)
  __froundBuf[0] = f;
  return __froundBuf[0];
end;

var __imul = Math.imul  or  function(b)
  var ah = (a >>> 16) & 0xffff;
  var al = a & 0xffff;
  var bh = (b >>> 16) & 0xffff;
  var bl = b & 0xffff;
  return ((al * bl) + (((ah * bl + al * bh) << 16) >>> 0) >> 0);
end;

var __floatKey = function(f)
  if (f ~= f) then
    __idCounter++;
    return "NaN__" + __idCounter;
  end
  return String(f);
end;

var __flatten64 = function(x)
  return x.__high * 4294967296 + x.__low;
end;

var __shiftLeft64 = function(y)
  if (y == 0) then
    return x;
  end
  if (y < 32) then
    return new x.constructor(x.__high << y | x.__low >>> (32 - y), (x.__low << y) >>> 0);
  end
  if (y < 64) then
    return new x.constructor(x.__low << (y - 32), 0);
  end
  return new x.constructor(0, 0);
end;

var __shiftRightInt64 = function(y)
  if (y == 0) then
    return x;
  end
  if (y < 32) then
    return new x.constructor(x.__high >> y, (x.__low >>> y | x.__high << (32 - y)) >>> 0);
  end
  if (y < 64) then
    return new x.constructor(x.__high >> 31, (x.__high >> (y - 32)) >>> 0);
  end
  if (x.__high < 0) then
    return new x.constructor(-1, 4294967295);
  end
  return new x.constructor(0, 0);
end;

var __shiftRightUint64 = function(y)
  if (y == 0) then
    return x;
  end
  if (y < 32) then
    return new x.constructor(x.__high >>> y, (x.__low >>> y | x.__high << (32 - y)) >>> 0);
  end
  if (y < 64) then
    return new x.constructor(0, x.__high >>> (y - 32));
  end
  return new x.constructor(0, 0);
end;

var __mul64 = function(y)
  var high = 0, low = 0;
  if ((y.__low & 1) ~= 0) then
    high = x.__high;
    low = x.__low;
  end
  for (var i = 1; i < 32; i++) {
    if ((y.__low & 1<<i) ~= 0) then
      high += x.__high << i | x.__low >>> (32 - i);
      low += (x.__low << i) >>> 0;
    end
  end
  for (var i = 0; i < 32; i++) {
    if ((y.__high & 1<<i) ~= 0) then
      high += x.__low << i;
    end
  end
  return new x.constructor(high, low);
end;

var __div64 = function(r)
  if (y.__high == 0  and  y.__low == 0) then
    __throwRuntimeError("integer divide by zero");
  end

  var s = 1;
  var rs = 1;

  var xHigh = x.__high;
  var xLow = x.__low;
  if (xHigh < 0) then
    s = -1;
    rs = -1;
    xHigh = -xHigh;
    if (xLow ~= 0) then
      xHigh--;
      xLow = 4294967296 - xLow;
    end
  end

  var yHigh = y.__high;
  var yLow = y.__low;
  if (y.__high < 0) then
    s *= -1;
    yHigh = -yHigh;
    if (yLow ~= 0) then
      yHigh--;
      yLow = 4294967296 - yLow;
    end
  end

  var high = 0, low = 0, n = 0;
  while (yHigh < 2147483648  and  ((xHigh > yHigh)  or  (xHigh == yHigh  and  xLow > yLow))) {
    yHigh = (yHigh << 1 | yLow >>> 31) >>> 0;
    yLow = (yLow << 1) >>> 0;
    n++;
  end
  for (var i = 0; i <= n; i++) {
    high = high << 1 | low >>> 31;
    low = (low << 1) >>> 0;
    if ((xHigh > yHigh)  or  (xHigh == yHigh  and  xLow >= yLow)) then
      xHigh = xHigh - yHigh;
      xLow = xLow - yLow;
      if (xLow < 0) then
        xHigh--;
        xLow += 4294967296;
      end
      low++;
      if (low == 4294967296) then
        high++;
        low = 0;
      end
    end
    yLow = (yLow >>> 1 | yHigh << (32 - 1)) >>> 0;
    yHigh = yHigh >>> 1;
  end

  if (returnRemainder) then
    return new x.constructor(xHigh * rs, xLow * rs);
  end
  return new x.constructor(high * s, low * s);
end;

var __divComplex = function(d)
  var ninf = n.__real == Infinity  or  n.__real == -Infinity  or  n.__imag == Infinity  or  n.__imag == -Infinity;
  var dinf = d.__real == Infinity  or  d.__real == -Infinity  or  d.__imag == Infinity  or  d.__imag == -Infinity;
  var nnan =  not ninf  and  (n.__real ~= n.__real  or  n.__imag ~= n.__imag);
  var dnan =  not dinf  and  (d.__real ~= d.__real  or  d.__imag ~= d.__imag);
  if(nnan  or  dnan) then
    return new n.constructor(NaN, NaN);
  end
  if (ninf  and   not dinf) then
    return new n.constructor(Infinity, Infinity);
  end
  if ( not ninf  and  dinf) then
    return new n.constructor(0, 0);
  end
  if (d.__real == 0  and  d.__imag == 0) then
    if (n.__real == 0  and  n.__imag == 0) then
      return new n.constructor(NaN, NaN);
    end
    return new n.constructor(Infinity, Infinity);
  end
  var a = Math.abs(d.__real);
  var b = Math.abs(d.__imag);
  if (a <= b) then
    var ratio = d.__real / d.__imag;
    var denom = d.__real * ratio + d.__imag;
    return new n.constructor((n.__real * ratio + n.__imag) / denom, (n.__imag * ratio - n.__real) / denom);
  end
  var ratio = d.__imag / d.__real;
  var denom = d.__imag * ratio + d.__real;
  return new n.constructor((n.__imag * ratio + n.__real) / denom, (n.__imag - n.__real * ratio) / denom);
end;

var __kindBool = 1;
var __kindInt = 2;
var __kindInt8 = 3;
var __kindInt16 = 4;
var __kindInt32 = 5;
var __kindInt64 = 6;
var __kindUint = 7;
var __kindUint8 = 8;
var __kindUint16 = 9;
var __kindUint32 = 10;
var __kindUint64 = 11;
var __kindUintptr = 12;
var __kindFloat32 = 13;
var __kindFloat64 = 14;
var __kindComplex64 = 15;
var __kindComplex128 = 16;
var __kindArray = 17;
var __kindChan = 18;
var __kindFunc = 19;
var __kindInterface = 20;
var __kindMap = 21;
var __kindPtr = 22;
var __kindSlice = 23;
var __kindString = 24;
var __kindStruct = 25;
var __kindUnsafePointer = 26;

var __methodSynthesizers = [];
var __addMethodSynthesizer = function(f)
  if (__methodSynthesizers == null) then
    f();
    return;
  end
  __methodSynthesizers.push(f);
end;
var __synthesizeMethods = function()
  __methodSynthesizers.forEach(function(f) f(); end);
  __methodSynthesizers = null;
end;

var __ifaceKeyFor = function(x)
  if (x == __ifaceNil) then
    return 'nil';
  end
  var c = x.constructor;
  return c.string + '__' + c.keyFor(x.__val);
end;

var __identity = function(x) return x; end;

var __typeIDCounter = 0;

var __idKey = function(x)
  if (x.__id == nil) then
    __idCounter++;
    x.__id = __idCounter;
  end
  return String(x.__id);
end;

var __newType = function(r)
  var typ;
  switch(kind) {
  case __kindBool:
  case __kindInt:
  case __kindInt8:
  case __kindInt16:
  case __kindInt32:
  case __kindUint:
  case __kindUint8:
  case __kindUint16:
  case __kindUint32:
  case __kindUintptr:
  case __kindUnsafePointer:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.keyFor = __identity;
    break;

  case __kindString:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.keyFor = function(x) return "_" + x; end;
    break;

  case __kindFloat32:
  case __kindFloat64:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.keyFor = function(x) return __floatKey(x); end;
    break;

  case __kindInt64:
    typ = function(w)
      this.__high = (high + Math.floor(Math.ceil(low) / 4294967296)) >> 0;
      this.__low = low >>> 0;
      this.__val = this;
    end;
    typ.keyFor = function(x) return x.__high + "_" + x.__low; end;
    break;

  case __kindUint64:
    typ = function(w)
      this.__high = (high + Math.floor(Math.ceil(low) / 4294967296)) >>> 0;
      this.__low = low >>> 0;
      this.__val = this;
    end;
    typ.keyFor = function(x) return x.__high + "_" + x.__low; end;
    break;

  case __kindComplex64:
    typ = function(g)
      this.__real = __fround(real);
      this.__imag = __fround(imag);
      this.__val = this;
    end;
    typ.keyFor = function(x) return x.__real + "_" + x.__imag; end;
    break;

  case __kindComplex128:
    typ = function(g)
      this.__real = real;
      this.__imag = imag;
      this.__val = this;
    end;
    typ.keyFor = function(x) return x.__real + "_" + x.__imag; end;
    break;

  case __kindArray:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.ptr = __newType(4, __kindPtr, "*" + string, false, "", false, function(y)
      this.__get = function() return array; end;
      this.__set = function(v) typ.copy(this, v); end;
      this.__val = array;
    end);
    typ.init = function(n)
      typ.elem = elem;
      typ.len = len;
      typ.comparable = elem.comparable;
      typ.keyFor = function(x)
        return Array.prototype.join.call(__mapArray(x, function(e)
          return String(elem.keyFor(e)).replace(/\\/g, "\\\\").replace(/\__/g, "\\__");
        end), "_");
      end;
      typ.copy = function(c)
        __copyArray(dst, src, 0, 0, src.length, elem);
      end;
      typ.ptr.init(typ);
      Object.defineProperty(typ.ptr.nil, "nilCheck", { get: __throwNilPointerError end);
    end;
    break;

  case __kindChan:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.keyFor = __idKey;
    typ.init = function(y)
      typ.elem = elem;
      typ.sendOnly = sendOnly;
      typ.recvOnly = recvOnly;
    end;
    break;

  case __kindFunc:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.init = function(c)
      typ.params = params;
      typ.results = results;
      typ.variadic = variadic;
      typ.comparable = false;
    end;
    break;

  case __kindInterface:
     typ = { implementedBy= {}, missingMethodFor= {} };
    typ.keyFor = __ifaceKeyFor;
    typ.init = function(s)
      typ.methods = methods;
      methods.forEach(function(m)
        __ifaceNil[m.prop] = __throwNilPointerError;
      end);
    end;
    break;

  case __kindMap:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.init = function(m)
      typ.key = key;
      typ.elem = elem;
      typ.comparable = false;
    end;
    break;

  case __kindPtr:
    typ = constructor  or  function(t)
      this.__get = getter;
      this.__set = setter;
      this.__target = target;
      this.__val = this;
    end;
    typ.keyFor = __idKey;
    typ.init = function(m)
      typ.elem = elem;
      typ.wrapped = (elem.kind == __kindArray);
      typ.nil = new typ(__throwNilPointerError, __throwNilPointerError);
    end;
    break;

  case __kindSlice:
    typ = function(y)
      if (array.constructor ~= typ.nativeArray) then
        array = new typ.nativeArray(array);
      end
      this.__array = array;
      this.__offset = 0;
      this.__length = array.length;
      this.__capacity = array.length;
      this.__val = this;
    end;
    typ.init = function(m)
      typ.elem = elem;
      typ.comparable = false;
      typ.nativeArray = __nativeArray(elem.kind);
      typ.nil = new typ([]);
    end;
    break;

  case __kindStruct:
    typ = function(v) this.__val = v; end;
    typ.wrapped = true;
    typ.ptr = __newType(4, __kindPtr, "*" + string, false, pkg, exported, constructor);
    typ.ptr.elem = typ;
    typ.ptr.prototype.__get = function() return this; end;
    typ.ptr.prototype.__set = function(v) typ.copy(this, v); end;
    typ.init = function(s)
      typ.pkgPath = pkgPath;
      typ.fields = fields;
      fields.forEach(function(f)
        if ( not f.typ.comparable) then
          typ.comparable = false;
        end
      end);
      typ.keyFor = function(x)
        var val = x.__val;
        return __mapArray(fields, function(f)
          return String(f.typ.keyFor(val[f.prop])).replace(/\\/g, "\\\\").replace(/\__/g, "\\__");
        end).join("_");
      end;
      typ.copy = function(c)
        for (var i = 0; i < fields.length; i++) {
          var f = fields[i];
          switch (f.typ.kind) {
          case __kindArray:
          case __kindStruct:
            f.typ.copy(dst[f.prop], src[f.prop]);
            continue;
          default:
            dst[f.prop] = src[f.prop];
            continue;
          end
        end
      end;
      /* nil value */
      var properties = {};
      fields.forEach(function(f)
        properties[f.prop] = { get: __throwNilPointerError, set: __throwNilPointerError end;
      end);
      typ.ptr.nil = Object.create(constructor.prototype, properties);
      typ.ptr.nil.__val = typ.ptr.nil;
      /* methods for embedded fields */
      __addMethodSynthesizer(function()
        var synthesizeMethod = function(f)
          if (target.prototype[m.prop] ~= nil) then return; end
          target.prototype[m.prop] = function()
            var v = this.__val[f.prop];
            if (f.typ == __jsObjectPtr) then
              v = new __jsObjectPtr(v);
            end
            if (v.__val == nil) then
              v = new f.typ(v);
            end
            return v[m.prop].apply(v, arguments);
          end;
        end;
        fields.forEach(function(f)
          if (f.anonymous) then
            __methodSet(f.typ).forEach(function(m)
              synthesizeMethod(typ, m, f);
              synthesizeMethod(typ.ptr, m, f);
            end);
            __methodSet(__ptrType(f.typ)).forEach(function(m)
              synthesizeMethod(typ.ptr, m, f);
            end);
          end
        end);
      end);
    end;
    break;

  default:
    __panic(new __String("invalid kind: " + kind));
  end

  switch (kind) {
  case __kindBool:
  case __kindMap:
    typ.zero = function() return false; end;
    break;

  case __kindInt:
  case __kindInt8:
  case __kindInt16:
  case __kindInt32:
  case __kindUint:
  case __kindUint8 :
  case __kindUint16:
  case __kindUint32:
  case __kindUintptr:
  case __kindUnsafePointer:
  case __kindFloat32:
  case __kindFloat64:
    typ.zero = function() return 0; end;
    break;

  case __kindString:
    typ.zero = function() return ""; end;
    break;

  case __kindInt64:
  case __kindUint64:
  case __kindComplex64:
  case __kindComplex128:
    var zero = new typ(0, 0);
    typ.zero = function() return zero; end;
    break;

  case __kindPtr:
  case __kindSlice:
    typ.zero = function() return typ.nil; end;
    break;

  case __kindChan:
    typ.zero = function() return __chanNil; end;
    break;

  case __kindFunc:
    typ.zero = function() return __throwNilPointerError; end;
    break;

  case __kindInterface:
    typ.zero = function() return __ifaceNil; end;
    break;

  case __kindArray:
    typ.zero = function()
      var arrayClass = __nativeArray(typ.elem.kind);
      if (arrayClass ~= Array) then
        return new arrayClass(typ.len);
      end
      var array = new Array(typ.len);
      for (var i = 0; i < typ.len; i++) {
        array[i] = typ.elem.zero();
      end
      return array;
    end;
    break;

  case __kindStruct:
    typ.zero = function() return new typ.ptr(); end;
    break;

  default:
    __panic(new __String("invalid kind: " + kind));
  end

  typ.id = __typeIDCounter;
  __typeIDCounter++;
  typ.size = size;
  typ.kind = kind;
  typ.string = string;
  typ.named = named;
  typ.pkg = pkg;
  typ.exported = exported;
  typ.methods = [];
  typ.methodSetCache = null;
  typ.comparable = true;
  return typ;
end;

var __methodSet = function(p)
  if (typ.methodSetCache ~= null) then
    return typ.methodSetCache;
  end
  var base = {};

  var isPtr = (typ.kind == __kindPtr);
  if (isPtr  and  typ.elem.kind == __kindInterface) then
    typ.methodSetCache = [];
    return [];
  end

  var current = [{typ: isPtr ? typ.elem : typ, indirect: isPtrend];

  var seen = {};

  while (current.length > 0) {
    var next = [];
    var mset = [];

    current.forEach(function(e)
      if (seen[e.typ.string]) then
        return;
      end
      seen[e.typ.string] = true;

      if (e.typ.named) then
        mset = mset.concat(e.typ.methods);
        if (e.indirect) then
          mset = mset.concat(__ptrType(e.typ).methods);
        end
      end

      switch (e.typ.kind) {
      case __kindStruct:
        e.typ.fields.forEach(function(f)
          if (f.anonymous) then
            var fTyp = f.typ;
            var fIsPtr = (fTyp.kind == __kindPtr);
            next.push({typ: fIsPtr ? fTyp.elem : fTyp, indirect: e.indirect  or  fIsPtrend);
          end
        end);
        break;

      case __kindInterface:
        mset = mset.concat(e.typ.methods);
        break;
      end
    end);

    mset.forEach(function(m)
      if (base[m.name] == nil) then
        base[m.name] = m;
      end
    end);

    current = next;
  end

  typ.methodSetCache = [];
  Object.keys(base).sort().forEach(function(e)
    typ.methodSetCache.push(base[name]);
  end);
  return typ.methodSetCache;
end;

var __Bool          = __newType( 1, __kindBool,          "bool",           true, "", false, null);
var __Int           = __newType( 4, __kindInt,           "int",            true, "", false, null);
var __Int8          = __newType( 1, __kindInt8,          "int8",           true, "", false, null);
var __Int16         = __newType( 2, __kindInt16,         "int16",          true, "", false, null);
var __Int32         = __newType( 4, __kindInt32,         "int32",          true, "", false, null);
var __Int64         = __newType( 8, __kindInt64,         "int64",          true, "", false, null);
var __Uint          = __newType( 4, __kindUint,          "uint",           true, "", false, null);
var __Uint8         = __newType( 1, __kindUint8,         "uint8",          true, "", false, null);
var __Uint16        = __newType( 2, __kindUint16,        "uint16",         true, "", false, null);
var __Uint32        = __newType( 4, __kindUint32,        "uint32",         true, "", false, null);
var __Uint64        = __newType( 8, __kindUint64,        "uint64",         true, "", false, null);
var __Uintptr       = __newType( 4, __kindUintptr,       "uintptr",        true, "", false, null);
var __Float32       = __newType( 4, __kindFloat32,       "float32",        true, "", false, null);
var __Float64       = __newType( 8, __kindFloat64,       "float64",        true, "", false, null);
var __Complex64     = __newType( 8, __kindComplex64,     "complex64",      true, "", false, null);
var __Complex128    = __newType(16, __kindComplex128,    "complex128",     true, "", false, null);
var __String        = __newType( 8, __kindString,        "string",         true, "", false, null);
var __UnsafePointer = __newType( 4, __kindUnsafePointer, "unsafe.Pointer", true, "", false, null);

var __nativeArray = function(d)
  switch (elemKind) {
  case __kindInt:
    return Int32Array;
  case __kindInt8:
    return Int8Array;
  case __kindInt16:
    return Int16Array;
  case __kindInt32:
    return Int32Array;
  case __kindUint:
    return Uint32Array;
  case __kindUint8:
    return Uint8Array;
  case __kindUint16:
    return Uint16Array;
  case __kindUint32:
    return Uint32Array;
  case __kindUintptr:
    return Uint32Array;
  case __kindFloat32:
    return Float32Array;
  case __kindFloat64:
    return Float64Array;
  default:
    return Array;
  end
end;
var __toNativeArray = function(y)
  var nativeArray = __nativeArray(elemKind);
  if (nativeArray == Array) {
    return array;
  end
  return new nativeArray(array);
end;
var __arrayTypes = {};
var __arrayType = function(n)
  var typeKey = elem.id + "_" + len;
  var typ = __arrayTypes[typeKey];
  if (typ == nil) then
    typ = __newType(12, __kindArray, "[" + len + "]" + elem.string, false, "", false, null);
    __arrayTypes[typeKey] = typ;
    typ.init(elem, len);
  end
  return typ;
end;

var __chanType = function(y)
  var string = (recvOnly ? "<-" : "") + "chan" + (sendOnly ? "<- " : " ") + elem.string;
  var field = sendOnly ? "SendChan" : (recvOnly ? "RecvChan" : "Chan");
  var typ = elem[field];
  if (typ == nil) then
    typ = __newType(4, __kindChan, string, false, "", false, null);
    elem[field] = typ;
    typ.init(elem, sendOnly, recvOnly);
  end
  return typ;
end;
var __Chan = function(y)
  if (capacity < 0  or  capacity > 2147483647) then
    __throwRuntimeError("makechan: size out of range");
  end
  this.__elem = elem;
  this.__capacity = capacity;
  this.__buffer = [];
  this.__sendQueue = [];
  this.__recvQueue = [];
  this.__closed = false;
end;
var __chanNil = new __Chan(null, 0);
__chanNil.__sendQueue = __chanNil.__recvQueue = { length= 0, push= function()end, shift= function() return nil; end, indexOf= function() return -1; end; };

var __funcTypes = {};
var __funcType = function(c)
  var typeKey = __mapArray(params, function(p) return p.id; end).join(",") + "_" + __mapArray(results, function(r) return r.id; end).join(",") + "_" + variadic;
  var typ = __funcTypes[typeKey];
  if (typ == nil) then
    var paramTypes = __mapArray(params, function(p) return p.string; end);
    if (variadic) then
      paramTypes[paramTypes.length - 1] = "..." + paramTypes[paramTypes.length - 1].substr(2);
    end
    var string = "func(" + paramTypes.join(", ") + ")";
    if (results.length == 1) then
      string += " " + results[0].string;
    end else if (results.length > 1) then
      string += " (" + __mapArray(results, function(r) return r.string; end).join(", ") + ")";
    end
    typ = __newType(4, __kindFunc, string, false, "", false, null);
    __funcTypes[typeKey] = typ;
    typ.init(params, results, variadic);
  end
  return typ;
end;

var __interfaceTypes = {};
var __interfaceType = function(s)
  var typeKey = __mapArray(methods, function(m) return m.pkg + "," + m.name + "," + m.typ.id; end).join("_");
  var typ = __interfaceTypes[typeKey];
  if (typ == nil) then
    var string = "interface {}";
    if (methods.length ~= 0) then
      string = "interface { " + __mapArray(methods, function(m)
        return (m.pkg ~= "" ? m.pkg + "." : "") + m.name + m.typ.string.substr(4);
      end).join("; ") + " end";
    end
    typ = __newType(8, __kindInterface, string, false, "", false, null);
    __interfaceTypes[typeKey] = typ;
    typ.init(methods);
  end
  return typ;
end;
var __emptyInterface = __interfaceType([]);
var __ifaceNil = {};
var __error = __newType(8, __kindInterface, "error", true, "", false, null);
__error.init([{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end]);

var __mapTypes = {};
var __mapType = function(m)
  var typeKey = key.id + "_" + elem.id;
  var typ = __mapTypes[typeKey];
  if (typ == nil) then
    typ = __newType(4, __kindMap, "map[" + key.string + "]" + elem.string, false, "", false, null);
    __mapTypes[typeKey] = typ;
    typ.init(key, elem);
  end
  return typ;
end;
var __makeMap = function(s)
  var m = {};
  for (var i = 0; i < entries.length; i++) {
    var e = entries[i];
    m[keyForFunc(e.k)] = e;
  end
  return m;
end;

var __ptrType = function(m)
  var typ = elem.ptr;
  if (typ == nil) then
    typ = __newType(4, __kindPtr, "*" + elem.string, false, "", elem.exported, null);
    elem.ptr = typ;
    typ.init(elem);
  end
  return typ;
end;

var __newDataPointer = function(r)
  if (constructor.elem.kind == __kindStruct) then
    return data;
  end
  return new constructor(function() return data; end, function(v) data = v; end);
end;

var __indexPtr = function(r)
  array.__ptr = array.__ptr  or  {};
  return array.__ptr[index]  or  (array.__ptr[index] = new constructor(function() return array[index]; end, function(v) array[index] = v; end));
end;

var __sliceType = function(m)
  var typ = elem.slice;
  if (typ == nil) then
    typ = __newType(12, __kindSlice, "[]" + elem.string, false, "", false, null);
    elem.slice = typ;
    typ.init(elem);
  end
  return typ;
end;
var __makeSlice = function(y)
  capacity = capacity  or  length;
  if (length < 0  or  length > 2147483647) then
    __throwRuntimeError("makeslice: len out of range");
  end
  if (capacity < 0  or  capacity < length  or  capacity > 2147483647) then
    __throwRuntimeError("makeslice: cap out of range");
  end
  var array = new typ.nativeArray(capacity);
  if (typ.nativeArray == Array) then
    for (var i = 0; i < capacity; i++) {
      array[i] = typ.elem.zero();
    end
  end
  var slice = new typ(array);
  slice.__length = length;
  return slice;
end;

var __structTypes = {};
var __structType = function(s)
  var typeKey = __mapArray(fields, function(f) return f.name + "," + f.typ.id + "," + f.tag; end).join("_");
  var typ = __structTypes[typeKey];
  if (typ == nil) then
    var string = "struct { " + __mapArray(fields, function(f)
      return f.name + " " + f.typ.string + (f.tag ~= "" ? (" \"" + f.tag.replace(/\\/g, "\\\\").replace(/"/g, "\\\"") + "\"") : "");
    end).join("; ") + " end";
    if (fields.length == 0) then
      string = "struct {}";
    end
    typ = __newType(0, __kindStruct, string, false, "", false, function()
      this.__val = this;
      for (var i = 0; i < fields.length; i++) {
        var f = fields[i];
        var arg = arguments[i];
        this[f.prop] = arg ~= nil ? arg : f.typ.zero();
      end
    end);
    __structTypes[typeKey] = typ;
    typ.init(pkgPath, fields);
  end
  return typ;
end;

var __assertType = function(e)
  var isInterface = (type.kind == __kindInterface), ok, missingMethod = "";
  if (value == __ifaceNil) then
    ok = false;
  end else if ( not isInterface) then
    ok = value.constructor == type;
  end else {
    var valueTypeString = value.constructor.string;
    ok = type.implementedBy[valueTypeString];
    if (ok == nil) then
      ok = true;
      var valueMethodSet = __methodSet(value.constructor);
      var interfaceMethods = type.methods;
      for (var i = 0; i < interfaceMethods.length; i++) {
        var tm = interfaceMethods[i];
        var found = false;
        for (var j = 0; j < valueMethodSet.length; j++) {
          var vm = valueMethodSet[j];
          if (vm.name == tm.name  and  vm.pkg == tm.pkg  and  vm.typ == tm.typ) then
            found = true;
            break;
          end
        end
        if ( not found) then
          ok = false;
          type.missingMethodFor[valueTypeString] = tm.name;
          break;
        end
      end
      type.implementedBy[valueTypeString] = ok;
    end
    if ( not ok) then
      missingMethod = type.missingMethodFor[valueTypeString];
    end
  end

  if ( not ok) then
    if (returnTuple) then
      return [type.zero(), false];
    end
    __panic(new __packages["runtime"].TypeAssertionError.ptr("", (value == __ifaceNil ? "" : value.constructor.string), type.string, missingMethod));
  end

  if ( not isInterface) then
    value = value.__val;
  end
  if (type == __jsObjectPtr) then
    value = value.object;
  end
  return returnTuple ? [value, true] : value;
end;

var __stackDepthOffset = 0;
var __getStackDepth = function()
  var err = new Error();
  if (err.stack == nil) then
    return nil;
  end
  return __stackDepthOffset + err.stack.split("\n").length;
end;

var __panicStackDepth = null, __panicValue;
var __callDeferred = function(c)
  if ( not fromPanic  and  deferred ~= null  and  deferred.index >= __curGoroutine.deferStack.length) then
    throw jsErr;
  end
  if (jsErr ~= null) then
    var newErr = null;
    try {
      __curGoroutine.deferStack.push(deferred);
      __panic(new __jsErrorPtr(jsErr));
    end catch (err) {
      newErr = err;
    end
    __curGoroutine.deferStack.pop();
    __callDeferred(deferred, newErr);
    return;
  end
  if (__curGoroutine.asleep) then
    return;
  end

  __stackDepthOffset--;
  var outerPanicStackDepth = __panicStackDepth;
  var outerPanicValue = __panicValue;

  var localPanicValue = __curGoroutine.panicStack.pop();
  if (localPanicValue ~= nil) then
    __panicStackDepth = __getStackDepth();
    __panicValue = localPanicValue;
  end

  try {
    while (true) {
      if (deferred == null) then
        deferred = __curGoroutine.deferStack[__curGoroutine.deferStack.length - 1];
        if (deferred == nil) then
          /* The panic reached the top of the stack. Clear it and throw it as a JavaScript error. */
          __panicStackDepth = null;
          if (localPanicValue.Object instanceof Error) then
            throw localPanicValue.Object;
          end
          var msg;
          if (localPanicValue.constructor == __String) then
            msg = localPanicValue.__val;
          end else if (localPanicValue.Error ~= nil) then
            msg = localPanicValue.Error();
          end else if (localPanicValue.String ~= nil) then
            msg = localPanicValue.String();
          end else then
            msg = localPanicValue;
          end
          throw new Error(msg);
        end
      end
      var call = deferred.pop();
      if (call == nil) then
        __curGoroutine.deferStack.pop();
        if (localPanicValue ~= nil) then
          deferred = null;
          continue;
        end
        return;
      end
      var r = call[0].apply(call[2], call[1]);
      if (r  and  r.__blk ~= nil) then
        deferred.push([r.__blk, [], r]);
        if (fromPanic) then
          throw null;
        end
        return;
      end

      if (localPanicValue ~= nil  and  __panicStackDepth == null) then
        throw null; /* error was recovered */
      end
    end
  end finally {
    if (localPanicValue ~= nil) {
      if (__panicStackDepth ~= null) {
        __curGoroutine.panicStack.push(localPanicValue);
      end
      __panicStackDepth = outerPanicStackDepth;
      __panicValue = outerPanicValue;
    end
    __stackDepthOffset++;
  end
end;

var __panic = function(e)
  __curGoroutine.panicStack.push(value);
  __callDeferred(null, null, true);
end;
var __recover = function()
  if (__panicStackDepth == null  or  (__panicStackDepth ~= nil  and  __panicStackDepth ~= __getStackDepth() - 2)) then
    return __ifaceNil;
  end
  __panicStackDepth = null;
  return __panicValue;
end;
var __throw = function(r) throw err; end;

var __noGoroutine = { asleep: false, exit: false, deferStack: [], panicStack: [] end;
var __curGoroutine = __noGoroutine, __totalGoroutines = 0, __awakeGoroutines = 0, __checkForDeadlock = true;
var __mainFinished = false;
var __go = function(s)
  __totalGoroutines++;
  __awakeGoroutines++;
  var __goroutine = function()
    try {
      __curGoroutine = __goroutine;
      var r = fun.apply(nil, args);
      if (r  and  r.__blk ~= nil) then
        fun = function() return r.__blk(); end;
        args = [];
        return;
      end
      __goroutine.exit = true;
    end catch (err) {
      if ( not __goroutine.exit) then
        throw err;
      end
    end finally {
      __curGoroutine = __noGoroutine;
      if (__goroutine.exit) { /* also set by runtime.Goexit() */
        __totalGoroutines--;
        __goroutine.asleep = true;
      end
      if (__goroutine.asleep) {
        __awakeGoroutines--;
        if ( not __mainFinished  and  __awakeGoroutines == 0  and  __checkForDeadlock) then
          console.error("fatal error: all goroutines are asleep - deadlock not ");
          if (__global.process ~= nil) then
            __global.process.exit(2);
          end
        end
      end
    end
  end;
  __goroutine.asleep = false;
  __goroutine.exit = false;
  __goroutine.deferStack = [];
  __goroutine.panicStack = [];
  __schedule(__goroutine);
end;

var __scheduled = [];
var __runScheduled = function()
  try {
    var r;
    while ((r = __scheduled.shift()) ~= nil) {
      r();
    end
  end finally {
    if (__scheduled.length > 0) then
      setTimeout(__runScheduled, 0);
    end
  end
end;

var __schedule = function(e)
  if (goroutine.asleep) then
    goroutine.asleep = false;
    __awakeGoroutines++;
  end
  __scheduled.push(goroutine);
  if (__curGoroutine == __noGoroutine) then
    __runScheduled();
  end
end;

var __setTimeout = function(t)
  __awakeGoroutines++;
  return setTimeout(function()
    __awakeGoroutines--;
    f();
  end, t);
end;

var __block = function()
  if (__curGoroutine == __noGoroutine) then
    __throwRuntimeError("cannot block in JavaScript callback, fix by wrapping code in goroutine");
  end
  __curGoroutine.asleep = true;
end;

var __send = function(e)
  if (chan.__closed) then
    __throwRuntimeError("send on closed channel");
  end
  var queuedRecv = chan.__recvQueue.shift();
  if (queuedRecv ~= nil) then
    queuedRecv([value, true]);
    return;
  end
  if (chan.__buffer.length < chan.__capacity) then
    chan.__buffer.push(value);
    return;
  end

  var thisGoroutine = __curGoroutine;
  var closedDuringSend;
  chan.__sendQueue.push(function(d)
    closedDuringSend = closed;
    __schedule(thisGoroutine);
    return value;
  end);
  __block();
  return {
    __blk: function()
      if (closedDuringSend) then
        __throwRuntimeError("send on closed channel");
      end
    end
  end;
end;
var __recv = function(n)
  var queuedSend = chan.__sendQueue.shift();
  if (queuedSend ~= nil) then
    chan.__buffer.push(queuedSend(false));
  end
  var bufferedValue = chan.__buffer.shift();
  if (bufferedValue ~= nil) then
    return [bufferedValue, true];
  end
  if (chan.__closed) then
    return [chan.__elem.zero(), false];
  end

  var thisGoroutine = __curGoroutine;
  var f = { __blk: function() return this.value; end end;
  var queueEntry = function(v)
    f.value = v;
    __schedule(thisGoroutine);
  end;
  chan.__recvQueue.push(queueEntry);
  __block();
  return f;
end;
var __close = function(n)
  if (chan.__closed) then
    __throwRuntimeError("close of closed channel");
  end
  chan.__closed = true;
  while (true) {
    var queuedSend = chan.__sendQueue.shift();
    if (queuedSend == nil) then
      break;
    end
    queuedSend(true); /* will panic */
  end
  while (true) {
    var queuedRecv = chan.__recvQueue.shift();
    if (queuedRecv == nil) then
      break;
    end
    queuedRecv([chan.__elem.zero(), false]);
  end
end;
var __select = function(s)
  var ready = [];
  var selection = -1;
  for (var i = 0; i < comms.length; i++) {
    var comm = comms[i];
    var chan = comm[0];
    switch (comm.length) {
    case 0: /* default */
      selection = i;
      break;
    case 1: /* recv */
      if (chan.__sendQueue.length ~= 0  or  chan.__buffer.length ~= 0  or  chan.__closed) {
        ready.push(i);
      end
      break;
    case 2: /* send */
      if (chan.__closed) {
        __throwRuntimeError("send on closed channel");
      end
      if (chan.__recvQueue.length ~= 0  or  chan.__buffer.length < chan.__capacity) {
        ready.push(i);
      end
      break;
    end
  end

  if (ready.length ~= 0) then
    selection = ready[Math.floor(Math.random() * ready.length)];
  end
  if (selection ~= -1) then
    var comm = comms[selection];
    switch (comm.length) {
    case 0: /* default */
      return [selection];
    case 1: /* recv */
      return [selection, __recv(comm[0])];
    case 2: /* send */
      __send(comm[0], comm[1]);
      return [selection];
    end
  end

  var entries = [];
  var thisGoroutine = __curGoroutine;
  var f = { __blk: function() return this.selection; end end;
  var removeFromQueues = function()
    for (var i = 0; i < entries.length; i++) {
      var entry = entries[i];
      var queue = entry[0];
      var index = queue.indexOf(entry[1]);
      if (index ~= -1) then
        queue.splice(index, 1);
      end
    end
  end;
  for (var i = 0; i < comms.length; i++) {
    (function(i)
      var comm = comms[i];
      switch (comm.length) {
      case 1: /* recv */
        var queueEntry = function(e)
          f.selection = [i, value];
          removeFromQueues();
          __schedule(thisGoroutine);
        end;
        entries.push([comm[0].__recvQueue, queueEntry]);
        comm[0].__recvQueue.push(queueEntry);
        break;
      case 2: /* send */
        var queueEntry = function()
          if (comm[0].__closed) {
            __throwRuntimeError("send on closed channel");
          end
          f.selection = [i];
          removeFromQueues();
          __schedule(thisGoroutine);
          return comm[1];
        end;
        entries.push([comm[0].__sendQueue, queueEntry]);
        comm[0].__sendQueue.push(queueEntry);
        break;
      end
    end)(i);
  end
  __block();
  return f;
end;

var __jsObjectPtr, __jsErrorPtr;

var __needsExternalization = function(t)
  switch (t.kind) {
    case __kindBool:
    case __kindInt:
    case __kindInt8:
    case __kindInt16:
    case __kindInt32:
    case __kindUint:
    case __kindUint8:
    case __kindUint16:
    case __kindUint32:
    case __kindUintptr:
    case __kindFloat32:
    case __kindFloat64:
      return false;
    default:
      return t ~= __jsObjectPtr;
  end
end;

var __externalize = function(t)
  if (t == __jsObjectPtr) then
    return v;
  end
  switch (t.kind) {
  case __kindBool:
  case __kindInt:
  case __kindInt8:
  case __kindInt16:
  case __kindInt32:
  case __kindUint:
  case __kindUint8:
  case __kindUint16:
  case __kindUint32:
  case __kindUintptr:
  case __kindFloat32:
  case __kindFloat64:
    return v;
  case __kindInt64:
  case __kindUint64:
    return __flatten64(v);
  case __kindArray:
    if (__needsExternalization(t.elem)) then
      return __mapArray(v, function(e) return __externalize(e, t.elem); end);
    end
    return v;
  case __kindFunc:
    return __externalizeFunction(v, t, false);
  case __kindInterface:
    if (v == __ifaceNil) then
      return null;
    end
    if (v.constructor == __jsObjectPtr) then
      return v.__val.object;
    end
    return __externalize(v.__val, v.constructor);
  case __kindMap:
    var m = {};
    var keys = __keys(v);
    for (var i = 0; i < keys.length; i++) {
      var entry = v[keys[i]];
      m[__externalize(entry.k, t.key)] = __externalize(entry.v, t.elem);
    end
    return m;
  case __kindPtr:
    if (v == t.nil) then
      return null;
    end
    return __externalize(v.__get(), t.elem);
  case __kindSlice:
    if (__needsExternalization(t.elem)) then
      return __mapArray(__sliceToArray(v), function(e) return __externalize(e, t.elem); end);
    end
    return __sliceToArray(v);
  case __kindString:
    if (__isASCII(v)) then
      return v;
    end
    var s = "", r;
    for (var i = 0; i < v.length; i += r[1]) {
      r = __decodeRune(v, i);
      var c = r[0];
      if (c > 0xFFFF) then
        var h = Math.floor((c - 0x10000) / 0x400) + 0xD800;
        var l = (c - 0x10000) % 0x400 + 0xDC00;
        s += String.fromCharCode(h, l);
        continue;
      end
      s += String.fromCharCode(c);
    end
    return s;
  case __kindStruct:
    var timePkg = __packages["time"];
    if (timePkg ~= nil  and  v.constructor == timePkg.Time.ptr) then
      var milli = __div64(v.UnixNano(), new __Int64(0, 1000000));
      return new Date(__flatten64(milli));
    end

    var noJsObject = {};
    var searchJsObject = function(t)
      if (t == __jsObjectPtr) then
        return v;
      end
      switch (t.kind) {
      case __kindPtr:
        if (v == t.nil) then
          return noJsObject;
        end
        return searchJsObject(v.__get(), t.elem);
      case __kindStruct:
        var f = t.fields[0];
        return searchJsObject(v[f.prop], f.typ);
      case __kindInterface:
        return searchJsObject(v.__val, v.constructor);
      default:
        return noJsObject;
      end
    end;
    var o = searchJsObject(v, t);
    if (o ~= noJsObject) then
      return o;
    end

    o = {};
    for (var i = 0; i < t.fields.length; i++) {
      var f = t.fields[i];
      if ( not f.exported) then
        continue;
      end
      o[f.name] = __externalize(v[f.prop], f.typ);
    end
    return o;
  end
  __throwRuntimeError("cannot externalize " + t.string);
end;

var __externalizeFunction = function(s)
  if (v == __throwNilPointerError) then
    return null;
  end
  if (v.__externalizeWrapper == nil) then
    __checkForDeadlock = false;
    v.__externalizeWrapper = function()
      var args = [];
      for (var i = 0; i < t.params.length; i++) {
        if (t.variadic  and  i == t.params.length - 1) then
          var vt = t.params[i].elem, varargs = [];
          for (var j = i; j < arguments.length; j++) {
            varargs.push(__internalize(arguments[j], vt));
          end
          args.push(new (t.params[i])(varargs));
          break;
        end
        args.push(__internalize(arguments[i], t.params[i]));
      end
      var result = v.apply(passThis ? this : nil, args);
      switch (t.results.length) {
      case 0:
        return;
      case 1:
        return __externalize(result, t.results[0]);
      default:
        for (var i = 0; i < t.results.length; i++) {
          result[i] = __externalize(result[i], t.results[i]);
        end
        return result;
      end
    end;
  end
  return v.__externalizeWrapper;
end;

var __internalize = function(v)
  if (t == __jsObjectPtr) then
    return v;
  end
  if (t == __jsObjectPtr.elem) then
    __throwRuntimeError("cannot internalize js.Object, use *js.Object instead");
  end
  if (v  and  v.__internal_object__ ~= nil) then
    return __assertType(v.__internal_object__, t, false);
  end
  var timePkg = __packages["time"];
  if (timePkg ~= nil  and  t == timePkg.Time) then
    if ( not (v ~= null  and  v ~= nil  and  v.constructor == Date)) then
      __throwRuntimeError("cannot internalize time.Time from " + typeof v + ", must be Date");
    end
    return timePkg.Unix(new __Int64(0, 0), new __Int64(0, v.getTime() * 1000000));
  end
  switch (t.kind) {
  case __kindBool:
    return  not  not v;
  case __kindInt:
    return parseInt(v);
  case __kindInt8:
    return parseInt(v) << 24 >> 24;
  case __kindInt16:
    return parseInt(v) << 16 >> 16;
  case __kindInt32:
    return parseInt(v) >> 0;
  case __kindUint:
    return parseInt(v);
  case __kindUint8:
    return parseInt(v) << 24 >>> 24;
  case __kindUint16:
    return parseInt(v) << 16 >>> 16;
  case __kindUint32:
  case __kindUintptr:
    return parseInt(v) >>> 0;
  case __kindInt64:
  case __kindUint64:
    return new t(0, v);
  case __kindFloat32:
  case __kindFloat64:
    return parseFloat(v);
  case __kindArray:
    if (v.length ~= t.len) then
      __throwRuntimeError("got array with wrong size from JavaScript native");
    end
    return __mapArray(v, function(e) return __internalize(e, t.elem); end);
  case __kindFunc:
    return function()
      var args = [];
      for (var i = 0; i < t.params.length; i++) {
        if (t.variadic  and  i == t.params.length - 1) then
          var vt = t.params[i].elem, varargs = arguments[i];
          for (var j = 0; j < varargs.__length; j++) {
            args.push(__externalize(varargs.__array[varargs.__offset + j], vt));
          end
          break;
        end
        args.push(__externalize(arguments[i], t.params[i]));
      end
      var result = v.apply(recv, args);
      switch (t.results.length) {
      case 0:
        return;
      case 1:
        return __internalize(result, t.results[0]);
      default:
        for (var i = 0; i < t.results.length; i++) {
          result[i] = __internalize(result[i], t.results[i]);
        end
        return result;
      end
    end;
  case __kindInterface:
    if (t.methods.length ~= 0) then
      __throwRuntimeError("cannot internalize " + t.string);
    end
    if (v == null) then
      return __ifaceNil;
    end
    if (v == nil) then
      return new __jsObjectPtr(nil);
    end
    switch (v.constructor) {
    case Int8Array:
      return new (__sliceType(__Int8))(v);
    case Int16Array:
      return new (__sliceType(__Int16))(v);
    case Int32Array:
      return new (__sliceType(__Int))(v);
    case Uint8Array:
      return new (__sliceType(__Uint8))(v);
    case Uint16Array:
      return new (__sliceType(__Uint16))(v);
    case Uint32Array:
      return new (__sliceType(__Uint))(v);
    case Float32Array:
      return new (__sliceType(__Float32))(v);
    case Float64Array:
      return new (__sliceType(__Float64))(v);
    case Array:
      return __internalize(v, __sliceType(__emptyInterface));
    case Boolean:
      return new __Bool( not  not v);
    case Date:
      if (timePkg == nil) then
        /* time package is not present, internalize as &js.Object{Dateend so it can be externalized into original Date. */
        return new __jsObjectPtr(v);
      end
      return new timePkg.Time(__internalize(v, timePkg.Time));
    case Function:
      var funcType = __funcType([__sliceType(__emptyInterface)], [__jsObjectPtr], true);
      return new funcType(__internalize(v, funcType));
    case Number:
      return new __Float64(parseFloat(v));
    case String:
      return new __String(__internalize(v, __String));
    default:
      if (__global.Node  and  v instanceof __global.Node) then
        return new __jsObjectPtr(v);
      end
      var mapType = __mapType(__String, __emptyInterface);
      return new mapType(__internalize(v, mapType));
    end
  case __kindMap:
    var m = {};
    var keys = __keys(v);
    for (var i = 0; i < keys.length; i++) {
      var k = __internalize(keys[i], t.key);
      m[t.key.keyFor(k)] = { k: k, v: __internalize(v[keys[i]], t.elem) end;
    end
    return m;
  case __kindPtr:
    if (t.elem.kind == __kindStruct) then
      return __internalize(v, t.elem);
    end
  case __kindSlice:
    return new t(__mapArray(v, function(e) return __internalize(e, t.elem); end));
  case __kindString:
    v = String(v);
    if (__isASCII(v)) then
      return v;
    end
    var s = "";
    var i = 0;
    while (i < v.length) {
      var h = v.charCodeAt(i);
      if (0xD800 <= h  and  h <= 0xDBFF) then
        var l = v.charCodeAt(i + 1);
        var c = (h - 0xD800) * 0x400 + l - 0xDC00 + 0x10000;
        s += __encodeRune(c);
        i += 2;
        continue;
      end
      s += __encodeRune(h);
      i++;
    end
    return s;
  case __kindStruct:
    var noJsObject = {};
    var searchJsObject = function(t)
      if (t == __jsObjectPtr) then
        return v;
      end
      if (t == __jsObjectPtr.elem) then
        __throwRuntimeError("cannot internalize js.Object, use *js.Object instead");
      end
      switch (t.kind) {
      case __kindPtr:
        return searchJsObject(t.elem);
      case __kindStruct:
        var f = t.fields[0];
        var o = searchJsObject(f.typ);
        if (o ~= noJsObject) {
          var n = new t.ptr();
          n[f.prop] = o;
          return n;
        end
        return noJsObject;
      default:
        return noJsObject;
      end
    end;
    var o = searchJsObject(t);
    if (o ~= noJsObject) {
      return o;
    end
  end
  __throwRuntimeError("cannot internalize " + t.string);
end;

/* __isASCII reports whether string s contains only ASCII characters. */
var __isASCII = function(s)
  for (var i = 0; i < s.length; i++) {
    if (s.charCodeAt(i) >= 128) then
      return false;
    end
  end
  return true;
end;

__packages["github.com/gopherjs/gopherjs/js"] = (function()
	var __pkg = {}, __init, Object, Error, sliceType, ptrType, ptrType__1, MakeFunc, init;
	Object = __pkg.Object = __newType(0, __kindStruct, "js.Object", true, "github.com/gopherjs/gopherjs/js", true, function(_)
		this.__val = this;
		if (arguments.length == 0) then
			this.object = null;
			return;
		end
		this.object = object_;
	end);
	Error = __pkg.Error = __newType(0, __kindStruct, "js.Error", true, "github.com/gopherjs/gopherjs/js", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Object = null;
			return;
		end
		this.Object = Object_;
	end);
	sliceType = __sliceType(__emptyInterface);
	ptrType = __ptrType(Object);
	ptrType__1 = __ptrType(Error);
	Object.ptr.prototype.Get = function(y)
		var key, o;
		o = this;
		return o.object[__externalize(key, __String)];
	end;
	Object.prototype.Get = function(y) return this.__val.Get(key); end;
	Object.ptr.prototype.Set = function(e)
		var key, o, value;
		o = this;
		o.object[__externalize(key, __String)] = __externalize(value, __emptyInterface);
	end;
	Object.prototype.Set = function(e) return this.__val.Set(key, value); end;
	Object.ptr.prototype.Delete = function(y)
		var key, o;
		o = this;
		delete o.object[__externalize(key, __String)];
	end;
	Object.prototype.Delete = function(y) return this.__val.Delete(key); end;
	Object.ptr.prototype.Length = function()
		var o;
		o = this;
		return __parseInt(o.object.length);
	end;
	Object.prototype.Length = function() return this.__val.Length(); end;
	Object.ptr.prototype.Index = function(i)
		var i, o;
		o = this;
		return o.object[i];
	end;
	Object.prototype.Index = function(i) return this.__val.Index(i); end;
	Object.ptr.prototype.SetIndex = function(e)
		var i, o, value;
		o = this;
		o.object[i] = __externalize(value, __emptyInterface);
	end;
	Object.prototype.SetIndex = function(e) return this.__val.SetIndex(i, value); end;
	Object.ptr.prototype.Call = function(s)
		var args, name, o, obj;
		o = this;
		return (obj = o.object, obj[__externalize(name, __String)].apply(obj, __externalize(args, sliceType)));
	end;
	Object.prototype.Call = function(s) return this.__val.Call(name, args); end;
	Object.ptr.prototype.Invoke = function(s)
		var args, o;
		o = this;
		return o.object.apply(nil, __externalize(args, sliceType));
	end;
	Object.prototype.Invoke = function(s) return this.__val.Invoke(args); end;
	Object.ptr.prototype.New = function(s)
		var args, o;
		o = this;
		return new (__global.Function.prototype.bind.apply(o.object, [nil].concat(__externalize(args, sliceType))));
	end;
	Object.prototype.New = function(s) return this.__val.New(args); end;
	Object.ptr.prototype.Bool = function()
		var o;
		o = this;
		return  not  not (o.object);
	end;
	Object.prototype.Bool = function() return this.__val.Bool(); end;
	Object.ptr.prototype.String = function()
		var o;
		o = this;
		return __internalize(o.object, __String);
	end;
	Object.prototype.String = function() return this.__val.String(); end;
	Object.ptr.prototype.Int = function()
		var o;
		o = this;
		return __parseInt(o.object) >> 0;
	end;
	Object.prototype.Int = function() return this.__val.Int(); end;
	Object.ptr.prototype.Int64 = function()
		var o;
		o = this;
		return __internalize(o.object, __Int64);
	end;
	Object.prototype.Int64 = function() return this.__val.Int64(); end;
	Object.ptr.prototype.Uint64 = function()
		var o;
		o = this;
		return __internalize(o.object, __Uint64);
	end;
	Object.prototype.Uint64 = function() return this.__val.Uint64(); end;
	Object.ptr.prototype.Float = function()
		var o;
		o = this;
		return __parseFloat(o.object);
	end;
	Object.prototype.Float = function() return this.__val.Float(); end;
	Object.ptr.prototype.Interface = function()
		var o;
		o = this;
		return __internalize(o.object, __emptyInterface);
	end;
	Object.prototype.Interface = function() return this.__val.Interface(); end;
	Object.ptr.prototype.Unsafe = function()
		var o;
		o = this;
		return o.object;
	end;
	Object.prototype.Unsafe = function() return this.__val.Unsafe(); end;
	Error.ptr.prototype.Error = function()
		var err;
		err = this;
		return "JavaScript error: " + __internalize(err.Object.message, __String);
	end;
	Error.prototype.Error = function() return this.__val.Error(); end;
	Error.ptr.prototype.Stack = function()
		var err;
		err = this;
		return __internalize(err.Object.stack, __String);
	end;
	Error.prototype.Stack = function() return this.__val.Stack(); end;
	MakeFunc = function(n)
		var fn;
		return __makeFunc(fn);
	end;
	__pkg.MakeFunc = MakeFunc;
	init = function()
		var e;
		e = new Error.ptr(null);
		__unused(e);
	end;
	ptrType.methods = [{prop: "Get", name: "Get", pkg: "", typ: __funcType([__String], [ptrType], false)end, {prop: "Set", name: "Set", pkg: "", typ: __funcType([__String, __emptyInterface], [], false)end, {prop: "Delete", name: "Delete", pkg: "", typ: __funcType([__String], [], false)end, {prop: "Length", name: "Length", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Index", name: "Index", pkg: "", typ: __funcType([__Int], [ptrType], false)end, {prop: "SetIndex", name: "SetIndex", pkg: "", typ: __funcType([__Int, __emptyInterface], [], false)end, {prop: "Call", name: "Call", pkg: "", typ: __funcType([__String, sliceType], [ptrType], true)end, {prop: "Invoke", name: "Invoke", pkg: "", typ: __funcType([sliceType], [ptrType], true)end, {prop: "New", name: "New", pkg: "", typ: __funcType([sliceType], [ptrType], true)end, {prop: "Bool", name: "Bool", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Int", name: "Int", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Int64", name: "Int64", pkg: "", typ: __funcType([], [__Int64], false)end, {prop: "Uint64", name: "Uint64", pkg: "", typ: __funcType([], [__Uint64], false)end, {prop: "Float", name: "Float", pkg: "", typ: __funcType([], [__Float64], false)end, {prop: "Interface", name: "Interface", pkg: "", typ: __funcType([], [__emptyInterface], false)end, {prop: "Unsafe", name: "Unsafe", pkg: "", typ: __funcType([], [__Uintptr], false)end];
	ptrType__1.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Stack", name: "Stack", pkg: "", typ: __funcType([], [__String], false)end];
	Object.init("github.com/gopherjs/gopherjs/js", [{prop: "object", name: "object", anonymous: false, exported: false, typ: ptrType, tag: ""end]);
	Error.init("", [{prop: "Object", name: "Object", anonymous: true, exported: true, typ: ptrType, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		init();
		/* */ end return; end if (__f == nil) then __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["runtime/internal/sys"] = (function()
	var __pkg = {}, __init;
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		/* */ end return; end if (__f == nil) then __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["runtime"] = (function()
	var __pkg = {}, __init, js, sys, TypeAssertionError, errorString, ptrType__4, init, Goexit, SetFinalizer, KeepAlive, throw__1;
	js = __packages["github.com/gopherjs/gopherjs/js"];
	sys = __packages["runtime/internal/sys"];
	TypeAssertionError = __pkg.TypeAssertionError = __newType(0, __kindStruct, "runtime.TypeAssertionError", true, "runtime", true, function(_)
		this.__val = this;
		if (arguments.length == 0) then
			this.interfaceString = "";
			this.concreteString = "";
			this.assertedString = "";
			this.missingMethod = "";
			return;
		end
		this.interfaceString = interfaceString_;
		this.concreteString = concreteString_;
		this.assertedString = assertedString_;
		this.missingMethod = missingMethod_;
	end);
	errorString = __pkg.errorString = __newType(8, __kindString, "runtime.errorString", true, "runtime", false, null);
	ptrType__4 = __ptrType(TypeAssertionError);
	init = function()
		var e, jsPkg;
		jsPkg = __packages[__externalize("github.com/gopherjs/gopherjs/js", __String)];
		__jsObjectPtr = jsPkg.Object.ptr;
		__jsErrorPtr = jsPkg.Error.ptr;
		__throwRuntimeError = throw__1;
		e = __ifaceNil;
		e = new TypeAssertionError.ptr("", "", "", "");
		__unused(e);
	end;
	Goexit = function()
		__curGoroutine.exit = __externalize(true, __Bool);
		__throw(null);
	end;
	__pkg.Goexit = Goexit;
	SetFinalizer = function(f)
		var f, x;
	end;
	__pkg.SetFinalizer = SetFinalizer;
	KeepAlive = function(m)
		var param;
	end;
	__pkg.KeepAlive = KeepAlive;
	throw__1 = function(s)
		var s;
		__panic(new errorString((s)));
	end;
	TypeAssertionError.ptr.prototype.RuntimeError = function()
	end;
	TypeAssertionError.prototype.RuntimeError = function() return this.__val.RuntimeError(); end;
	TypeAssertionError.ptr.prototype.Error = function()
		var e, inter;
		e = this;
		inter = e.interfaceString;
		if (inter == "") then
			inter = "interface";
		end
		if (e.concreteString == "") then
			return "interface conversion: " + inter + " is nil, not " + e.assertedString;
		end
		if (e.missingMethod == "") then
			return "interface conversion: " + inter + " is " + e.concreteString + ", not " + e.assertedString;
		end
		return "interface conversion: " + e.concreteString + " is not " + e.assertedString + ": missing method " + e.missingMethod;
	end;
	TypeAssertionError.prototype.Error = function() return this.__val.Error(); end;
	errorString.prototype.RuntimeError = function()
		var e;
		e = this.__val;
	end;
	__ptrType(errorString).prototype.RuntimeError = function() return new errorString(this.__get()).RuntimeError(); end;
	errorString.prototype.Error = function()
		var e;
		e = this.__val;
		return "runtime error: " + (e);
	end;
	__ptrType(errorString).prototype.Error = function() return new errorString(this.__get()).Error(); end;
	ptrType__4.methods = [{prop: "RuntimeError", name: "RuntimeError", pkg: "", typ: __funcType([], [], false)end, {prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	errorString.methods = [{prop: "RuntimeError", name: "RuntimeError", pkg: "", typ: __funcType([], [], false)end, {prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	TypeAssertionError.init("runtime", [{prop: "interfaceString", name: "interfaceString", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "concreteString", name: "concreteString", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "assertedString", name: "assertedString", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "missingMethod", name: "missingMethod", anonymous: false, exported: false, typ: __String, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = js.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if (__r  and  __r.__blk ~= nil) then break s; end
		__r = sys.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if (__r  and  __r.__blk ~= nil) then break s; end
		init();
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["errors"] = (function()
	var __pkg = {}, __init, errorString, ptrType, New;
	errorString = __pkg.errorString = __newType(0, __kindStruct, "errors.errorString", true, "errors", false, function(_)
		this.__val = this;
		if (arguments.length == 0) then
			this.s = "";
			return;
		end
		this.s = s_;
	end);
	ptrType = __ptrType(errorString);
	New = function(t)
		var text;
		return new errorString.ptr(text);
	end;
	__pkg.New = New;
	errorString.ptr.prototype.Error = function()
		var e;
		e = this;
		return e.s;
	end;
	errorString.prototype.Error = function() return this.__val.Error(); end;
	ptrType.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	errorString.init("errors", [{prop: "s", name: "s", anonymous: false, exported: false, typ: __String, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["internal/race"] = (function()
	var __pkg = {}, __init, Acquire, Release, ReleaseMerge, ReadRange, WriteRange;
	Acquire = function(r)
		var addr;
	end;
	__pkg.Acquire = Acquire;
	Release = function(r)
		var addr;
	end;
	__pkg.Release = Release;
	ReleaseMerge = function(r)
		var addr;
	end;
	__pkg.ReleaseMerge = ReleaseMerge;
	ReadRange = function(n)
		var addr, len;
	end;
	__pkg.ReadRange = ReadRange;
	WriteRange = function(n)
		var addr, len;
	end;
	__pkg.WriteRange = WriteRange;
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		/* */ end return; end if (__f == nil) then __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["sync/atomic"] = (function()
	var __pkg = {}, __init, js, Value, noCopy, ptrType, ptrType__1, CompareAndSwapInt32, CompareAndSwapUint64, CompareAndSwapPointer, AddInt32, LoadUint64, LoadPointer, StorePointer;
	js = __packages["github.com/gopherjs/gopherjs/js"];
	Value = __pkg.Value = __newType(0, __kindStruct, "atomic.Value", true, "sync/atomic", true, function(_)
		this.__val = this;
		if (arguments.length == 0) then
			this.noCopy = new noCopy.ptr();
			this.v = __ifaceNil;
			return;
		end
		this.noCopy = noCopy_;
		this.v = v_;
	end);
	noCopy = __pkg.noCopy = __newType(0, __kindStruct, "atomic.noCopy", true, "sync/atomic", false, function()
		this.__val = this;
		if (arguments.length == 0) then
			return;
		end
	end);
	ptrType = __ptrType(Value);
	ptrType__1 = __ptrType(noCopy);
	CompareAndSwapInt32 = function(1)
		var addr, new__1, old;
		if (addr.__get() == old) then
			addr.__set(new__1);
			return true;
		end
		return false;
	end;
	__pkg.CompareAndSwapInt32 = CompareAndSwapInt32;
	CompareAndSwapUint64 = function(1)
		var addr, new__1, old, x;
		if ((x = addr.__get(), (x.__high == old.__high  and  x.__low == old.__low))) then
			addr.__set(new__1);
			return true;
		end
		return false;
	end;
	__pkg.CompareAndSwapUint64 = CompareAndSwapUint64;
	CompareAndSwapPointer = function(1)
		var addr, new__1, old;
		if (addr.__get() == old) then
			addr.__set(new__1);
			return true;
		end
		return false;
	end;
	__pkg.CompareAndSwapPointer = CompareAndSwapPointer;
	AddInt32 = function(a)
		var addr, delta, new__1;
		new__1 = addr.__get() + delta >> 0;
		addr.__set(new__1);
		return new__1;
	end;
	__pkg.AddInt32 = AddInt32;
	LoadUint64 = function(r)
		var addr;
		return addr.__get();
	end;
	__pkg.LoadUint64 = LoadUint64;
	LoadPointer = function(r)
		var addr;
		return addr.__get();
	end;
	__pkg.LoadPointer = LoadPointer;
	StorePointer = function(l)
		var addr, val;
		addr.__set(val);
	end;
	__pkg.StorePointer = StorePointer;
	Value.ptr.prototype.Load = function()
		var v, x;
		x = __ifaceNil;
		v = this;
		x = v.v;
		return x;
	end;
	Value.prototype.Load = function() return this.__val.Load(); end;
	Value.ptr.prototype.Store = function(x)
		var v, x;
		v = this;
		if (__interfaceIsEqual(x, __ifaceNil)) then
			__panic(new __String("sync/atomic: store of nil value into Value"));
		end
		if ( not (__interfaceIsEqual(v.v, __ifaceNil))  and   not (x.constructor == v.v.constructor)) then
			__panic(new __String("sync/atomic: store of inconsistently typed value into Value"));
		end
		v.v = x;
	end;
	Value.prototype.Store = function(x) return this.__val.Store(x); end;
	noCopy.ptr.prototype.Lock = function()
	end;
	noCopy.prototype.Lock = function() return this.__val.Lock(); end;
	ptrType.methods = [{prop: "Load", name: "Load", pkg: "", typ: __funcType([], [__emptyInterface], false)end, {prop: "Store", name: "Store", pkg: "", typ: __funcType([__emptyInterface], [], false)end];
	ptrType__1.methods = [{prop: "Lock", name: "Lock", pkg: "", typ: __funcType([], [], false)end];
	Value.init("sync/atomic", [{prop: "noCopy", name: "noCopy", anonymous: false, exported: false, typ: noCopy, tag: ""end, {prop: "v", name: "v", anonymous: false, exported: false, typ: __emptyInterface, tag: ""end]);
	noCopy.init("", []);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = js.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["sync"] = (function()
	var __pkg = {}, __init, js, race, runtime, atomic, Pool, Map, readOnly, entry, Mutex, poolLocalInternal, poolLocal, notifyList, ptrType, sliceType, ptrType__1, chanType, sliceType__1, ptrType__3, ptrType__4, ptrType__5, ptrType__6, ptrType__7, sliceType__4, funcType, funcType__1, ptrType__15, mapType, ptrType__16, arrayType__2, semWaiters, expunged, allPools, runtime_registerPoolCleanup, runtime_Semacquire, runtime_SemacquireMutex, runtime_Semrelease, runtime_notifyListCheck, runtime_canSpin, runtime_nanotime, newEntry, poolCleanup, init, indexLocal, init__1, runtime_doSpin;
	js = __packages["github.com/gopherjs/gopherjs/js"];
	race = __packages["internal/race"];
	runtime = __packages["runtime"];
	atomic = __packages["sync/atomic"];
	Pool = __pkg.Pool = __newType(0, __kindStruct, "sync.Pool", true, "sync", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.local = 0;
			this.localSize = 0;
			this.store = sliceType__4.nil;
			this.New = __throwNilPointerError;
			return;
		end
		this.local = local_;
		this.localSize = localSize_;
		this.store = store_;
		this.New = New_;
	end);
	Map = __pkg.Map = __newType(0, __kindStruct, "sync.Map", true, "sync", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.mu = new Mutex.ptr(0, 0);
			this.read = new atomic.Value.ptr(new atomic.noCopy.ptr(), __ifaceNil);
			this.dirty = false;
			this.misses = 0;
			return;
		end
		this.mu = mu_;
		this.read = read_;
		this.dirty = dirty_;
		this.misses = misses_;
	end);
	readOnly = __pkg.readOnly = __newType(0, __kindStruct, "sync.readOnly", true, "sync", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.m = false;
			this.amended = false;
			return;
		end
		this.m = m_;
		this.amended = amended_;
	end);
	entry = __pkg.entry = __newType(0, __kindStruct, "sync.entry", true, "sync", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.p = 0;
			return;
		end
		this.p = p_;
	end);
	Mutex = __pkg.Mutex = __newType(0, __kindStruct, "sync.Mutex", true, "sync", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.state = 0;
			this.sema = 0;
			return;
		end
		this.state = state_;
		this.sema = sema_;
	end);
	poolLocalInternal = __pkg.poolLocalInternal = __newType(0, __kindStruct, "sync.poolLocalInternal", true, "sync", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.private__0 = __ifaceNil;
			this.shared = sliceType__4.nil;
			this.Mutex = new Mutex.ptr(0, 0);
			return;
		end
		this.private__0 = private__0_;
		this.shared = shared_;
		this.Mutex = Mutex_;
	end);
	poolLocal = __pkg.poolLocal = __newType(0, __kindStruct, "sync.poolLocal", true, "sync", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.poolLocalInternal = new poolLocalInternal.ptr(__ifaceNil, sliceType__4.nil, new Mutex.ptr(0, 0));
			this.pad = arrayType__2.zero();
			return;
		end
		this.poolLocalInternal = poolLocalInternal_;
		this.pad = pad_;
	end);
	notifyList = __pkg.notifyList = __newType(0, __kindStruct, "sync.notifyList", true, "sync", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.wait = 0;
			this.notify = 0;
			this.lock = 0;
			this.head = 0;
			this.tail = 0;
			return;
		end
		this.wait = wait_;
		this.notify = notify_;
		this.lock = lock_;
		this.head = head_;
		this.tail = tail_;
	end);
	ptrType = __ptrType(Pool);
	sliceType = __sliceType(ptrType);
	ptrType__1 = __ptrType(__Uint32);
	chanType = __chanType(__Bool, false, false);
	sliceType__1 = __sliceType(chanType);
	ptrType__3 = __ptrType(__emptyInterface);
	ptrType__4 = __ptrType(entry);
	ptrType__5 = __ptrType(__UnsafePointer);
	ptrType__6 = __ptrType(__Int32);
	ptrType__7 = __ptrType(poolLocal);
	sliceType__4 = __sliceType(__emptyInterface);
	funcType = __funcType([], [__emptyInterface], false);
	funcType__1 = __funcType([__emptyInterface, __emptyInterface], [__Bool], false);
	ptrType__15 = __ptrType(Map);
	mapType = __mapType(__emptyInterface, ptrType__4);
	ptrType__16 = __ptrType(Mutex);
	arrayType__2 = __arrayType(__Uint8, 100);
	Pool.ptr.prototype.Get = function()
		var _r, p, x, x__1, x__2, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; p = __f.p; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		/* */ if (p.store.__length == 0) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (p.store.__length == 0) { */ case 1:
			/* */ if ( not (p.New == __throwNilPointerError)) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if ( not (p.New == __throwNilPointerError)) { */ case 3:
				_r = p.New(); /* */ __s = 5; case 5: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__s = -1; return _r;
			/* end */ case 4:
			__s = -1; return __ifaceNil;
		/* end */ case 2:
		x__2 = (x = p.store, x__1 = p.store.__length - 1 >> 0, ((x__1 < 0  or  x__1 >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + x__1]));
		p.store = __subslice(p.store, 0, (p.store.__length - 1 >> 0));
		__s = -1; return x__2;
		/* */ end return; end if __f == nil then  __f = { __blk: Pool.ptr.prototype.Get end; end __f._r = _r; __f.p = p; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Pool.prototype.Get = function() return this.__val.Get(); end;
	Pool.ptr.prototype.Put = function(x)
		var p, x;
		p = this;
		if (__interfaceIsEqual(x, __ifaceNil)) {
			return;
		end
		p.store = __append(p.store, x);
	end;
	Pool.prototype.Put = function(x) return this.__val.Put(x); end;
	runtime_registerPoolCleanup = function(p)
		var cleanup;
	end;
	runtime_Semacquire = function(s)
		var _entry, _key, _r, ch, s, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _key = __f._key; _r = __f._r; ch = __f.ch; s = __f.s; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		/* */ if (s.__get() == 0) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (s.__get() == 0) { */ case 1:
			ch = new __Chan(__Bool, 0);
			_key = s; (semWaiters  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__1.keyFor(_key)] = { k: _key, v: __append((_entry = semWaiters[ptrType__1.keyFor(s)], _entry ~= nil ? _entry.v : sliceType__1.nil), ch) end;
			_r = __recv(ch); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_r[0];
		/* end */ case 2:
		s.__set(s.__get() - (1) >>> 0);
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: runtime_Semacquire end; end __f._entry = _entry; __f._key = _key; __f._r = _r; __f.ch = ch; __f.s = s; __f.__s = __s; __f.__r = __r; return __f;
	end;
	runtime_SemacquireMutex = function(o)
		var lifo, s, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; lifo = __f.lifo; s = __f.s; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = runtime_Semacquire(s); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: runtime_SemacquireMutex end; end __f.lifo = lifo; __f.s = s; __f.__s = __s; __f.__r = __r; return __f;
	end;
	runtime_Semrelease = function(f)
		var _entry, _key, ch, handoff, s, w, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _key = __f._key; ch = __f.ch; handoff = __f.handoff; s = __f.s; w = __f.w; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		s.__set(s.__get() + (1) >>> 0);
		w = (_entry = semWaiters[ptrType__1.keyFor(s)], _entry ~= nil ? _entry.v : sliceType__1.nil);
		if (w.__length == 0) {
			__s = -1; return;
		end
		ch = (0 >= w.__length ? (__throwRuntimeError("index out of range"), nil) : w.__array[w.__offset + 0]);
		w = __subslice(w, 1);
		_key = s; (semWaiters  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__1.keyFor(_key)] = { k: _key, v: w end;
		if (w.__length == 0) {
			delete semWaiters[ptrType__1.keyFor(s)];
		end
		__r = __send(ch, true); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: runtime_Semrelease end; end __f._entry = _entry; __f._key = _key; __f.ch = ch; __f.handoff = handoff; __f.s = s; __f.w = w; __f.__s = __s; __f.__r = __r; return __f;
	end;
	runtime_notifyListCheck = function(e)
		var size;
	end;
	runtime_canSpin = function(i)
		var i;
		return false;
	end;
	runtime_nanotime = function()
		return __mul64(__internalize(new (__global.Date)().getTime(), __Int64), new __Int64(0, 1000000));
	end;
	newEntry = function(i)
		var i, i__24ptr;
		return new entry.ptr(((i__24ptr  or  (i__24ptr = new ptrType__3(function() return i; end, function(v) i = __v; end)))));
	end;
	Map.ptr.prototype.Load = function(y)
		var _entry, _entry__1, _entry__2, _tmp, _tmp__1, _tuple, _tuple__1, _tuple__2, _tuple__3, _tuple__4, _tuple__5, e, key, m, ok, read, value, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _entry__1 = __f._entry__1; _entry__2 = __f._entry__2; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; _tuple__3 = __f._tuple__3; _tuple__4 = __f._tuple__4; _tuple__5 = __f._tuple__5; e = __f.e; key = __f.key; m = __f.m; ok = __f.ok; read = __f.read; value = __f.value; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		value = __ifaceNil;
		ok = false;
		m = this;
		_tuple = __assertType(m.read.Load(), readOnly, true);
		read = __clone(_tuple[0], readOnly);
		_tuple__1 = (_entry = read.m[__emptyInterface.keyFor(key)], _entry ~= nil ? [_entry.v, true] : [ptrType__4.nil, false]);
		e = _tuple__1[0];
		ok = _tuple__1[1];
		/* */ if ( not ok  and  read.amended) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ok  and  read.amended) { */ case 1:
			__r = m.mu.Lock(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			_tuple__2 = __assertType(m.read.Load(), readOnly, true);
			readOnly.copy(read, _tuple__2[0]);
			_tuple__3 = (_entry__1 = read.m[__emptyInterface.keyFor(key)], _entry__1 ~= nil ? [_entry__1.v, true] : [ptrType__4.nil, false]);
			e = _tuple__3[0];
			ok = _tuple__3[1];
			if ( not ok  and  read.amended) {
				_tuple__4 = (_entry__2 = m.dirty[__emptyInterface.keyFor(key)], _entry__2 ~= nil ? [_entry__2.v, true] : [ptrType__4.nil, false]);
				e = _tuple__4[0];
				ok = _tuple__4[1];
				m.missLocked();
			end
			__r = m.mu.Unlock(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* end */ case 2:
		if ( not ok) {
			_tmp = __ifaceNil;
			_tmp__1 = false;
			value = _tmp;
			ok = _tmp__1;
			__s = -1; return [value, ok];
		end
		_tuple__5 = e.load();
		value = _tuple__5[0];
		ok = _tuple__5[1];
		__s = -1; return [value, ok];
		/* */ end return; end if __f == nil then  __f = { __blk: Map.ptr.prototype.Load end; end __f._entry = _entry; __f._entry__1 = _entry__1; __f._entry__2 = _entry__2; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f._tuple__3 = _tuple__3; __f._tuple__4 = _tuple__4; __f._tuple__5 = _tuple__5; __f.e = e; __f.key = key; __f.m = m; __f.ok = ok; __f.read = read; __f.value = value; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Map.prototype.Load = function(y) return this.__val.Load(key); end;
	entry.ptr.prototype.load = function()
		var _tmp, _tmp__1, _tmp__2, _tmp__3, e, ok, p, value;
		value = __ifaceNil;
		ok = false;
		e = this;
		p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
		if (p == 0  or  p == expunged) {
			_tmp = __ifaceNil;
			_tmp__1 = false;
			value = _tmp;
			ok = _tmp__1;
			return [value, ok];
		end
		_tmp__2 = (p).__get();
		_tmp__3 = true;
		value = _tmp__2;
		ok = _tmp__3;
		return [value, ok];
	end;
	entry.prototype.load = function() return this.__val.load(); end;
	Map.ptr.prototype.Store = function(e)
		var _entry, _entry__1, _entry__2, _key, _key__1, _tuple, _tuple__1, _tuple__2, _tuple__3, _tuple__4, e, e__1, e__2, key, m, ok, ok__1, ok__2, read, value, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _entry__1 = __f._entry__1; _entry__2 = __f._entry__2; _key = __f._key; _key__1 = __f._key__1; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; _tuple__3 = __f._tuple__3; _tuple__4 = __f._tuple__4; e = __f.e; e__1 = __f.e__1; e__2 = __f.e__2; key = __f.key; m = __f.m; ok = __f.ok; ok__1 = __f.ok__1; ok__2 = __f.ok__2; read = __f.read; value = __f.value; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		value = [value];
		m = this;
		_tuple = __assertType(m.read.Load(), readOnly, true);
		read = __clone(_tuple[0], readOnly);
		_tuple__1 = (_entry = read.m[__emptyInterface.keyFor(key)], _entry ~= nil ? [_entry.v, true] : [ptrType__4.nil, false]);
		e = _tuple__1[0];
		ok = _tuple__1[1];
		if (ok  and  e.tryStore((value.__ptr  or  (value.__ptr = new ptrType__3(function() return this.__target[0]; end, function(v) this.__target[0] = __v; end, value))))) {
			__s = -1; return;
		end
		__r = m.mu.Lock(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		_tuple__2 = __assertType(m.read.Load(), readOnly, true);
		readOnly.copy(read, _tuple__2[0]);
		_tuple__3 = (_entry__1 = read.m[__emptyInterface.keyFor(key)], _entry__1 ~= nil ? [_entry__1.v, true] : [ptrType__4.nil, false]);
		e__1 = _tuple__3[0];
		ok__1 = _tuple__3[1];
		if (ok__1) {
			if (e__1.unexpungeLocked()) {
				_key = key; (m.dirty  or  __throwRuntimeError("assignment to entry in nil map"))[__emptyInterface.keyFor(_key)] = { k: _key, v: e__1 end;
			end
			e__1.storeLocked((value.__ptr  or  (value.__ptr = new ptrType__3(function() return this.__target[0]; end, function(v) this.__target[0] = __v; end, value))));
		end else {
			_tuple__4 = (_entry__2 = m.dirty[__emptyInterface.keyFor(key)], _entry__2 ~= nil ? [_entry__2.v, true] : [ptrType__4.nil, false]);
			e__2 = _tuple__4[0];
			ok__2 = _tuple__4[1];
			if (ok__2) {
				e__2.storeLocked((value.__ptr  or  (value.__ptr = new ptrType__3(function() return this.__target[0]; end, function(v) this.__target[0] = __v; end, value))));
			end else {
				if ( not read.amended) {
					m.dirtyLocked();
					m.read.Store((x = new readOnly.ptr(read.m, true), new x.constructor.elem(x)));
				end
				_key__1 = key; (m.dirty  or  __throwRuntimeError("assignment to entry in nil map"))[__emptyInterface.keyFor(_key__1)] = { k: _key__1, v: newEntry(value[0]) end;
			end
		end
		__r = m.mu.Unlock(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Map.ptr.prototype.Store end; end __f._entry = _entry; __f._entry__1 = _entry__1; __f._entry__2 = _entry__2; __f._key = _key; __f._key__1 = _key__1; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f._tuple__3 = _tuple__3; __f._tuple__4 = _tuple__4; __f.e = e; __f.e__1 = e__1; __f.e__2 = e__2; __f.key = key; __f.m = m; __f.ok = ok; __f.ok__1 = ok__1; __f.ok__2 = ok__2; __f.read = read; __f.value = value; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Map.prototype.Store = function(e) return this.__val.Store(key, value); end;
	entry.ptr.prototype.tryStore = function(i)
		var e, i, p;
		e = this;
		p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
		if (p == expunged) {
			return false;
		end
		while (true) {
			if (atomic.CompareAndSwapPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))), p, (i))) {
				return true;
			end
			p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
			if (p == expunged) {
				return false;
			end
		end
	end;
	entry.prototype.tryStore = function(i) return this.__val.tryStore(i); end;
	entry.ptr.prototype.unexpungeLocked = function()
		var e, wasExpunged;
		wasExpunged = false;
		e = this;
		wasExpunged = atomic.CompareAndSwapPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))), expunged, 0);
		return wasExpunged;
	end;
	entry.prototype.unexpungeLocked = function() return this.__val.unexpungeLocked(); end;
	entry.ptr.prototype.storeLocked = function(i)
		var e, i;
		e = this;
		atomic.StorePointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))), (i));
	end;
	entry.prototype.storeLocked = function(i) return this.__val.storeLocked(i); end;
	Map.ptr.prototype.LoadOrStore = function(e)
		var _entry, _entry__1, _entry__2, _key, _key__1, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tuple, _tuple__1, _tuple__2, _tuple__3, _tuple__4, _tuple__5, _tuple__6, _tuple__7, actual, actual__1, e, e__1, e__2, key, loaded, loaded__1, m, ok, ok__1, ok__2, ok__3, read, value, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _entry__1 = __f._entry__1; _entry__2 = __f._entry__2; _key = __f._key; _key__1 = __f._key__1; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tmp__4 = __f._tmp__4; _tmp__5 = __f._tmp__5; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; _tuple__3 = __f._tuple__3; _tuple__4 = __f._tuple__4; _tuple__5 = __f._tuple__5; _tuple__6 = __f._tuple__6; _tuple__7 = __f._tuple__7; actual = __f.actual; actual__1 = __f.actual__1; e = __f.e; e__1 = __f.e__1; e__2 = __f.e__2; key = __f.key; loaded = __f.loaded; loaded__1 = __f.loaded__1; m = __f.m; ok = __f.ok; ok__1 = __f.ok__1; ok__2 = __f.ok__2; ok__3 = __f.ok__3; read = __f.read; value = __f.value; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		actual = __ifaceNil;
		loaded = false;
		m = this;
		_tuple = __assertType(m.read.Load(), readOnly, true);
		read = __clone(_tuple[0], readOnly);
		_tuple__1 = (_entry = read.m[__emptyInterface.keyFor(key)], _entry ~= nil ? [_entry.v, true] : [ptrType__4.nil, false]);
		e = _tuple__1[0];
		ok = _tuple__1[1];
		if (ok) {
			_tuple__2 = e.tryLoadOrStore(value);
			actual__1 = _tuple__2[0];
			loaded__1 = _tuple__2[1];
			ok__1 = _tuple__2[2];
			if (ok__1) {
				_tmp = actual__1;
				_tmp__1 = loaded__1;
				actual = _tmp;
				loaded = _tmp__1;
				__s = -1; return [actual, loaded];
			end
		end
		__r = m.mu.Lock(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		_tuple__3 = __assertType(m.read.Load(), readOnly, true);
		readOnly.copy(read, _tuple__3[0]);
		_tuple__4 = (_entry__1 = read.m[__emptyInterface.keyFor(key)], _entry__1 ~= nil ? [_entry__1.v, true] : [ptrType__4.nil, false]);
		e__1 = _tuple__4[0];
		ok__2 = _tuple__4[1];
		if (ok__2) {
			if (e__1.unexpungeLocked()) {
				_key = key; (m.dirty  or  __throwRuntimeError("assignment to entry in nil map"))[__emptyInterface.keyFor(_key)] = { k: _key, v: e__1 end;
			end
			_tuple__5 = e__1.tryLoadOrStore(value);
			actual = _tuple__5[0];
			loaded = _tuple__5[1];
		end else {
			_tuple__6 = (_entry__2 = m.dirty[__emptyInterface.keyFor(key)], _entry__2 ~= nil ? [_entry__2.v, true] : [ptrType__4.nil, false]);
			e__2 = _tuple__6[0];
			ok__3 = _tuple__6[1];
			if (ok__3) {
				_tuple__7 = e__2.tryLoadOrStore(value);
				actual = _tuple__7[0];
				loaded = _tuple__7[1];
				m.missLocked();
			end else {
				if ( not read.amended) {
					m.dirtyLocked();
					m.read.Store((x = new readOnly.ptr(read.m, true), new x.constructor.elem(x)));
				end
				_key__1 = key; (m.dirty  or  __throwRuntimeError("assignment to entry in nil map"))[__emptyInterface.keyFor(_key__1)] = { k: _key__1, v: newEntry(value) end;
				_tmp__2 = value;
				_tmp__3 = false;
				actual = _tmp__2;
				loaded = _tmp__3;
			end
		end
		__r = m.mu.Unlock(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		_tmp__4 = actual;
		_tmp__5 = loaded;
		actual = _tmp__4;
		loaded = _tmp__5;
		__s = -1; return [actual, loaded];
		/* */ end return; end if __f == nil then  __f = { __blk: Map.ptr.prototype.LoadOrStore end; end __f._entry = _entry; __f._entry__1 = _entry__1; __f._entry__2 = _entry__2; __f._key = _key; __f._key__1 = _key__1; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tmp__4 = _tmp__4; __f._tmp__5 = _tmp__5; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f._tuple__3 = _tuple__3; __f._tuple__4 = _tuple__4; __f._tuple__5 = _tuple__5; __f._tuple__6 = _tuple__6; __f._tuple__7 = _tuple__7; __f.actual = actual; __f.actual__1 = actual__1; __f.e = e; __f.e__1 = e__1; __f.e__2 = e__2; __f.key = key; __f.loaded = loaded; __f.loaded__1 = loaded__1; __f.m = m; __f.ok = ok; __f.ok__1 = ok__1; __f.ok__2 = ok__2; __f.ok__3 = ok__3; __f.read = read; __f.value = value; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Map.prototype.LoadOrStore = function(e) return this.__val.LoadOrStore(key, value); end;
	entry.ptr.prototype.tryLoadOrStore = function(i)
		var _tmp, _tmp__1, _tmp__10, _tmp__11, _tmp__12, _tmp__13, _tmp__14, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tmp__8, _tmp__9, actual, e, i, ic, ic__24ptr, loaded, ok, p;
		actual = __ifaceNil;
		loaded = false;
		ok = false;
		e = this;
		p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
		if (p == expunged) {
			_tmp = __ifaceNil;
			_tmp__1 = false;
			_tmp__2 = false;
			actual = _tmp;
			loaded = _tmp__1;
			ok = _tmp__2;
			return [actual, loaded, ok];
		end
		if ( not (p == 0)) {
			_tmp__3 = (p).__get();
			_tmp__4 = true;
			_tmp__5 = true;
			actual = _tmp__3;
			loaded = _tmp__4;
			ok = _tmp__5;
			return [actual, loaded, ok];
		end
		ic = i;
		while (true) {
			if (atomic.CompareAndSwapPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))), 0, ((ic__24ptr  or  (ic__24ptr = new ptrType__3(function() return ic; end, function(v) ic = __v; end)))))) {
				_tmp__6 = i;
				_tmp__7 = false;
				_tmp__8 = true;
				actual = _tmp__6;
				loaded = _tmp__7;
				ok = _tmp__8;
				return [actual, loaded, ok];
			end
			p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
			if (p == expunged) {
				_tmp__9 = __ifaceNil;
				_tmp__10 = false;
				_tmp__11 = false;
				actual = _tmp__9;
				loaded = _tmp__10;
				ok = _tmp__11;
				return [actual, loaded, ok];
			end
			if ( not (p == 0)) {
				_tmp__12 = (p).__get();
				_tmp__13 = true;
				_tmp__14 = true;
				actual = _tmp__12;
				loaded = _tmp__13;
				ok = _tmp__14;
				return [actual, loaded, ok];
			end
		end
	end;
	entry.prototype.tryLoadOrStore = function(i) return this.__val.tryLoadOrStore(i); end;
	Map.ptr.prototype.Delete = function(y)
		var _entry, _entry__1, _tuple, _tuple__1, _tuple__2, _tuple__3, e, key, m, ok, read, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _entry__1 = __f._entry__1; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; _tuple__3 = __f._tuple__3; e = __f.e; key = __f.key; m = __f.m; ok = __f.ok; read = __f.read; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		m = this;
		_tuple = __assertType(m.read.Load(), readOnly, true);
		read = __clone(_tuple[0], readOnly);
		_tuple__1 = (_entry = read.m[__emptyInterface.keyFor(key)], _entry ~= nil ? [_entry.v, true] : [ptrType__4.nil, false]);
		e = _tuple__1[0];
		ok = _tuple__1[1];
		/* */ if ( not ok  and  read.amended) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ok  and  read.amended) { */ case 1:
			__r = m.mu.Lock(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			_tuple__2 = __assertType(m.read.Load(), readOnly, true);
			readOnly.copy(read, _tuple__2[0]);
			_tuple__3 = (_entry__1 = read.m[__emptyInterface.keyFor(key)], _entry__1 ~= nil ? [_entry__1.v, true] : [ptrType__4.nil, false]);
			e = _tuple__3[0];
			ok = _tuple__3[1];
			if ( not ok  and  read.amended) {
				delete m.dirty[__emptyInterface.keyFor(key)];
			end
			__r = m.mu.Unlock(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* end */ case 2:
		if (ok) {
			e.delete__();
		end
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Map.ptr.prototype.Delete end; end __f._entry = _entry; __f._entry__1 = _entry__1; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f._tuple__3 = _tuple__3; __f.e = e; __f.key = key; __f.m = m; __f.ok = ok; __f.read = read; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Map.prototype.Delete = function(y) return this.__val.Delete(key); end;
	entry.ptr.prototype.delete__ = function()
		var e, hadValue, p;
		hadValue = false;
		e = this;
		while (true) {
			p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
			if (p == 0  or  p == expunged) {
				hadValue = false;
				return hadValue;
			end
			if (atomic.CompareAndSwapPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))), p, 0)) {
				hadValue = true;
				return hadValue;
			end
		end
	end;
	entry.prototype.delete__ = function() return this.__val.delete__(); end;
	Map.ptr.prototype.Range = function(f)
		var _entry, _i, _keys, _r, _ref, _tuple, _tuple__1, _tuple__2, e, f, k, m, ok, read, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _i = __f._i; _keys = __f._keys; _r = __f._r; _ref = __f._ref; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; e = __f.e; f = __f.f; k = __f.k; m = __f.m; ok = __f.ok; read = __f.read; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		m = this;
		_tuple = __assertType(m.read.Load(), readOnly, true);
		read = __clone(_tuple[0], readOnly);
		/* */ if (read.amended) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (read.amended) { */ case 1:
			__r = m.mu.Lock(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			_tuple__1 = __assertType(m.read.Load(), readOnly, true);
			readOnly.copy(read, _tuple__1[0]);
			if (read.amended) {
				readOnly.copy(read, new readOnly.ptr(m.dirty, false));
				m.read.Store(new read.constructor.elem(read));
				m.dirty = false;
				m.misses = 0;
			end
			__r = m.mu.Unlock(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* end */ case 2:
		_ref = read.m;
		_i = 0;
		_keys = __keys(_ref);
		/* while (true) { */ case 5:
			/* if ( not (_i < _keys.length)) { break; end */ if( not (_i < _keys.length)) { __s = 6; continue; end
			_entry = _ref[_keys[_i]];
			if (_entry == nil) {
				_i++;
				/* continue; */ __s = 5; continue;
			end
			k = _entry.k;
			e = _entry.v;
			_tuple__2 = e.load();
			v = _tuple__2[0];
			ok = _tuple__2[1];
			/* */ if ( not ok) { __s = 7; continue; end
			/* */ __s = 8; continue;
			/* if ( not ok) { */ case 7:
				_i++;
				/* continue; */ __s = 5; continue;
			/* end */ case 8:
			_r = f(k, v); /* */ __s = 11; case 11: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			/* */ if ( not _r) { __s = 9; continue; end
			/* */ __s = 10; continue;
			/* if ( not _r) { */ case 9:
				/* break; */ __s = 6; continue;
			/* end */ case 10:
			_i++;
		/* end */ __s = 5; continue; case 6:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Map.ptr.prototype.Range end; end __f._entry = _entry; __f._i = _i; __f._keys = _keys; __f._r = _r; __f._ref = _ref; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f.e = e; __f.f = f; __f.k = k; __f.m = m; __f.ok = ok; __f.read = read; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Map.prototype.Range = function(f) return this.__val.Range(f); end;
	Map.ptr.prototype.missLocked = function()
		var m, x;
		m = this;
		m.misses = m.misses + (1) >> 0;
		if (m.misses < __keys(m.dirty).length) {
			return;
		end
		m.read.Store((x = new readOnly.ptr(m.dirty, false), new x.constructor.elem(x)));
		m.dirty = false;
		m.misses = 0;
	end;
	Map.prototype.missLocked = function() return this.__val.missLocked(); end;
	Map.ptr.prototype.dirtyLocked = function()
		var _entry, _i, _key, _keys, _ref, _tuple, e, k, m, read, x;
		m = this;
		if ( not (m.dirty == false)) {
			return;
		end
		_tuple = __assertType(m.read.Load(), readOnly, true);
		read = __clone(_tuple[0], readOnly);
		m.dirty = (x = __keys(read.m).length, ((x < 0  or  x > 2147483647) ? __throwRuntimeError("makemap: size out of range") : {}));
		_ref = read.m;
		_i = 0;
		_keys = __keys(_ref);
		while (true) {
			if ( not (_i < _keys.length)) { break; end
			_entry = _ref[_keys[_i]];
			if (_entry == nil) {
				_i++;
				continue;
			end
			k = _entry.k;
			e = _entry.v;
			if ( not e.tryExpungeLocked()) {
				_key = k; (m.dirty  or  __throwRuntimeError("assignment to entry in nil map"))[__emptyInterface.keyFor(_key)] = { k: _key, v: e end;
			end
			_i++;
		end
	end;
	Map.prototype.dirtyLocked = function() return this.__val.dirtyLocked(); end;
	entry.ptr.prototype.tryExpungeLocked = function()
		var e, isExpunged, p;
		isExpunged = false;
		e = this;
		p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
		while (true) {
			if ( not (p == 0)) { break; end
			if (atomic.CompareAndSwapPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))), 0, expunged)) {
				isExpunged = true;
				return isExpunged;
			end
			p = atomic.LoadPointer((e.__ptr_p  or  (e.__ptr_p = new ptrType__5(function() return this.__target.p; end, function(v) this.__target.p = __v; end, e))));
		end
		isExpunged = p == expunged;
		return isExpunged;
	end;
	entry.prototype.tryExpungeLocked = function() return this.__val.tryExpungeLocked(); end;
	Mutex.ptr.prototype.Lock = function()
		var awoke, delta, iter, m, new__1, old, queueLifo, starving, waitStartTime, x, x__1, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; awoke = __f.awoke; delta = __f.delta; iter = __f.iter; m = __f.m; new__1 = __f.new__1; old = __f.old; queueLifo = __f.queueLifo; starving = __f.starving; waitStartTime = __f.waitStartTime; x = __f.x; x__1 = __f.x__1; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		m = this;
		if (atomic.CompareAndSwapInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), 0, 1)) {
			if (false) {
				race.Acquire((m));
			end
			__s = -1; return;
		end
		waitStartTime = new __Int64(0, 0);
		starving = false;
		awoke = false;
		iter = 0;
		old = m.state;
		/* while (true) { */ case 1:
			/* */ if (((old & 5) == 1)  and  runtime_canSpin(iter)) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if (((old & 5) == 1)  and  runtime_canSpin(iter)) { */ case 3:
				if ( not awoke  and  ((old & 2) == 0)  and   not (((old >> 3 >> 0) == 0))  and  atomic.CompareAndSwapInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), old, old | 2)) {
					awoke = true;
				end
				runtime_doSpin();
				iter = iter + (1) >> 0;
				old = m.state;
				/* continue; */ __s = 1; continue;
			/* end */ case 4:
			new__1 = old;
			if ((old & 4) == 0) {
				new__1 = new__1 | (1);
			end
			if ( not (((old & 5) == 0))) {
				new__1 = new__1 + (8) >> 0;
			end
			if (starving  and   not (((old & 1) == 0))) {
				new__1 = new__1 | (4);
			end
			if (awoke) {
				if ((new__1 & 2) == 0) {
					__panic(new __String("sync: inconsistent mutex state"));
				end
				new__1 = (new__1 & ~(2)) >> 0;
			end
			/* */ if (atomic.CompareAndSwapInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), old, new__1)) { __s = 5; continue; end
			/* */ __s = 6; continue;
			/* if (atomic.CompareAndSwapInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), old, new__1)) { */ case 5:
				if ((old & 5) == 0) {
					/* break; */ __s = 2; continue;
				end
				queueLifo =  not ((waitStartTime.__high == 0  and  waitStartTime.__low == 0));
				if ((waitStartTime.__high == 0  and  waitStartTime.__low == 0)) {
					waitStartTime = runtime_nanotime();
				end
				__r = runtime_SemacquireMutex((m.__ptr_sema  or  (m.__ptr_sema = new ptrType__1(function() return this.__target.sema; end, function(v) this.__target.sema = __v; end, m))), queueLifo); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				starving = starving  or  (x = (x__1 = runtime_nanotime(), new __Int64(x__1.__high - waitStartTime.__high, x__1.__low - waitStartTime.__low)), (x.__high > 0  or  (x.__high == 0  and  x.__low > 1000000)));
				old = m.state;
				if ( not (((old & 4) == 0))) {
					if ( not (((old & 3) == 0))  or  ((old >> 3 >> 0) == 0)) {
						__panic(new __String("sync: inconsistent mutex state"));
					end
					delta = -7;
					if ( not starving  or  ((old >> 3 >> 0) == 1)) {
						delta = delta - (4) >> 0;
					end
					atomic.AddInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), delta);
					/* break; */ __s = 2; continue;
				end
				awoke = true;
				iter = 0;
				__s = 7; continue;
			/* end else { */ case 6:
				old = m.state;
			/* end */ case 7:
		/* end */ __s = 1; continue; case 2:
		if (false) {
			race.Acquire((m));
		end
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Mutex.ptr.prototype.Lock end; end __f.awoke = awoke; __f.delta = delta; __f.iter = iter; __f.m = m; __f.new__1 = new__1; __f.old = old; __f.queueLifo = queueLifo; __f.starving = starving; __f.waitStartTime = waitStartTime; __f.x = x; __f.x__1 = x__1; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Mutex.prototype.Lock = function() return this.__val.Lock(); end;
	Mutex.ptr.prototype.Unlock = function()
		var m, new__1, old, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; m = __f.m; new__1 = __f.new__1; old = __f.old; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		m = this;
		if (false) {
			__unused(m.state);
			race.Release((m));
		end
		new__1 = atomic.AddInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), -1);
		if ((((new__1 + 1 >> 0)) & 1) == 0) {
			__panic(new __String("sync: unlock of unlocked mutex"));
		end
		/* */ if ((new__1 & 4) == 0) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ((new__1 & 4) == 0) { */ case 1:
			old = new__1;
			/* while (true) { */ case 4:
				if (((old >> 3 >> 0) == 0)  or   not (((old & 7) == 0))) {
					__s = -1; return;
				end
				new__1 = ((old - 8 >> 0)) | 2;
				/* */ if (atomic.CompareAndSwapInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), old, new__1)) { __s = 6; continue; end
				/* */ __s = 7; continue;
				/* if (atomic.CompareAndSwapInt32((m.__ptr_state  or  (m.__ptr_state = new ptrType__6(function() return this.__target.state; end, function(v) this.__target.state = __v; end, m))), old, new__1)) { */ case 6:
					__r = runtime_Semrelease((m.__ptr_sema  or  (m.__ptr_sema = new ptrType__1(function() return this.__target.sema; end, function(v) this.__target.sema = __v; end, m))), false); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					__s = -1; return;
				/* end */ case 7:
				old = m.state;
			/* end */ __s = 4; continue; case 5:
			__s = 3; continue;
		/* end else { */ case 2:
			__r = runtime_Semrelease((m.__ptr_sema  or  (m.__ptr_sema = new ptrType__1(function() return this.__target.sema; end, function(v) this.__target.sema = __v; end, m))), true); /* */ __s = 9; case 9: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* end */ case 3:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Mutex.ptr.prototype.Unlock end; end __f.m = m; __f.new__1 = new__1; __f.old = old; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Mutex.prototype.Unlock = function() return this.__val.Unlock(); end;
	poolCleanup = function()
		var _i, _i__1, _ref, _ref__1, i, i__1, j, l, p, x;
		_ref = allPools;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			p = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			((i < 0  or  i >= allPools.__length) ? (__throwRuntimeError("index out of range"), nil) : allPools.__array[allPools.__offset + i] = ptrType.nil);
			i__1 = 0;
			while (true) {
				if ( not (i__1 < ((p.localSize >> 0)))) { break; end
				l = indexLocal(p.local, i__1);
				l.poolLocalInternal.private__0 = __ifaceNil;
				_ref__1 = l.poolLocalInternal.shared;
				_i__1 = 0;
				while (true) {
					if ( not (_i__1 < _ref__1.__length)) { break; end
					j = _i__1;
					(x = l.poolLocalInternal.shared, ((j < 0  or  j >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + j] = __ifaceNil));
					_i__1++;
				end
				l.poolLocalInternal.shared = sliceType__4.nil;
				i__1 = i__1 + (1) >> 0;
			end
			p.local = 0;
			p.localSize = 0;
			_i++;
		end
		allPools = new sliceType([]);
	end;
	init = function()
		runtime_registerPoolCleanup(poolCleanup);
	end;
	indexLocal = function(i)
		var i, l, lp;
		lp = (((l) + (__imul(((i >>> 0)), 128) >>> 0) >>> 0));
		return (__pointerOfStructConversion(lp, ptrType__7));
	end;
	init__1 = function()
		var n;
		n = new notifyList.ptr(0, 0, 0, 0, 0);
		runtime_notifyListCheck(20);
	end;
	runtime_doSpin = function()
		__throwRuntimeError("native function not implemented: sync.runtime_doSpin");
	end;
	ptrType.methods = [{prop: "Get", name: "Get", pkg: "", typ: __funcType([], [__emptyInterface], false)end, {prop: "Put", name: "Put", pkg: "", typ: __funcType([__emptyInterface], [], false)end, {prop: "getSlow", name: "getSlow", pkg: "sync", typ: __funcType([], [__emptyInterface], false)end, {prop: "pin", name: "pin", pkg: "sync", typ: __funcType([], [ptrType__7], false)end, {prop: "pinSlow", name: "pinSlow", pkg: "sync", typ: __funcType([], [ptrType__7], false)end];
	ptrType__15.methods = [{prop: "Load", name: "Load", pkg: "", typ: __funcType([__emptyInterface], [__emptyInterface, __Bool], false)end, {prop: "Store", name: "Store", pkg: "", typ: __funcType([__emptyInterface, __emptyInterface], [], false)end, {prop: "LoadOrStore", name: "LoadOrStore", pkg: "", typ: __funcType([__emptyInterface, __emptyInterface], [__emptyInterface, __Bool], false)end, {prop: "Delete", name: "Delete", pkg: "", typ: __funcType([__emptyInterface], [], false)end, {prop: "Range", name: "Range", pkg: "", typ: __funcType([funcType__1], [], false)end, {prop: "missLocked", name: "missLocked", pkg: "sync", typ: __funcType([], [], false)end, {prop: "dirtyLocked", name: "dirtyLocked", pkg: "sync", typ: __funcType([], [], false)end];
	ptrType__4.methods = [{prop: "load", name: "load", pkg: "sync", typ: __funcType([], [__emptyInterface, __Bool], false)end, {prop: "tryStore", name: "tryStore", pkg: "sync", typ: __funcType([ptrType__3], [__Bool], false)end, {prop: "unexpungeLocked", name: "unexpungeLocked", pkg: "sync", typ: __funcType([], [__Bool], false)end, {prop: "storeLocked", name: "storeLocked", pkg: "sync", typ: __funcType([ptrType__3], [], false)end, {prop: "tryLoadOrStore", name: "tryLoadOrStore", pkg: "sync", typ: __funcType([__emptyInterface], [__emptyInterface, __Bool, __Bool], false)end, {prop: "delete__", name: "delete", pkg: "sync", typ: __funcType([], [__Bool], false)end, {prop: "tryExpungeLocked", name: "tryExpungeLocked", pkg: "sync", typ: __funcType([], [__Bool], false)end];
	ptrType__16.methods = [{prop: "Lock", name: "Lock", pkg: "", typ: __funcType([], [], false)end, {prop: "Unlock", name: "Unlock", pkg: "", typ: __funcType([], [], false)end];
	Pool.init("sync", [{prop: "local", name: "local", anonymous: false, exported: false, typ: __UnsafePointer, tag: ""end, {prop: "localSize", name: "localSize", anonymous: false, exported: false, typ: __Uintptr, tag: ""end, {prop: "store", name: "store", anonymous: false, exported: false, typ: sliceType__4, tag: ""end, {prop: "New", name: "New", anonymous: false, exported: true, typ: funcType, tag: ""end]);
	Map.init("sync", [{prop: "mu", name: "mu", anonymous: false, exported: false, typ: Mutex, tag: ""end, {prop: "read", name: "read", anonymous: false, exported: false, typ: atomic.Value, tag: ""end, {prop: "dirty", name: "dirty", anonymous: false, exported: false, typ: mapType, tag: ""end, {prop: "misses", name: "misses", anonymous: false, exported: false, typ: __Int, tag: ""end]);
	readOnly.init("sync", [{prop: "m", name: "m", anonymous: false, exported: false, typ: mapType, tag: ""end, {prop: "amended", name: "amended", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	entry.init("sync", [{prop: "p", name: "p", anonymous: false, exported: false, typ: __UnsafePointer, tag: ""end]);
	Mutex.init("sync", [{prop: "state", name: "state", anonymous: false, exported: false, typ: __Int32, tag: ""end, {prop: "sema", name: "sema", anonymous: false, exported: false, typ: __Uint32, tag: ""end]);
	poolLocalInternal.init("sync", [{prop: "private__0", name: "private", anonymous: false, exported: false, typ: __emptyInterface, tag: ""end, {prop: "shared", name: "shared", anonymous: false, exported: false, typ: sliceType__4, tag: ""end, {prop: "Mutex", name: "Mutex", anonymous: true, exported: true, typ: Mutex, tag: ""end]);
	poolLocal.init("sync", [{prop: "poolLocalInternal", name: "poolLocalInternal", anonymous: true, exported: false, typ: poolLocalInternal, tag: ""end, {prop: "pad", name: "pad", anonymous: false, exported: false, typ: arrayType__2, tag: ""end]);
	notifyList.init("sync", [{prop: "wait", name: "wait", anonymous: false, exported: false, typ: __Uint32, tag: ""end, {prop: "notify", name: "notify", anonymous: false, exported: false, typ: __Uint32, tag: ""end, {prop: "lock", name: "lock", anonymous: false, exported: false, typ: __Uintptr, tag: ""end, {prop: "head", name: "head", anonymous: false, exported: false, typ: __UnsafePointer, tag: ""end, {prop: "tail", name: "tail", anonymous: false, exported: false, typ: __UnsafePointer, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = js.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = race.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = runtime.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = atomic.__init(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		allPools = sliceType.nil;
		semWaiters = {};
		expunged = (new Uint8Array(8));
		init();
		init__1();
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["io"] = (function()
	var __pkg = {}, __init, errors, sync, RuneScanner, errWhence, errOffset;
	errors = __packages["errors"];
	sync = __packages["sync"];
	RuneScanner = __pkg.RuneScanner = __newType(8, __kindInterface, "io.RuneScanner", true, "io", true, null);
	RuneScanner.init([{prop: "ReadRune", name: "ReadRune", pkg: "", typ: __funcType([], [__Int32, __Int, __error], false)end, {prop: "UnreadRune", name: "UnreadRune", pkg: "", typ: __funcType([], [__error], false)end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = sync.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__pkg.ErrShortWrite = errors.New("short write");
		__pkg.ErrShortBuffer = errors.New("short buffer");
		__pkg.EOF = errors.New("EOF");
		__pkg.ErrUnexpectedEOF = errors.New("unexpected EOF");
		__pkg.ErrNoProgress = errors.New("multiple Read calls return no data or error");
		errWhence = errors.New("Seek: invalid whence");
		errOffset = errors.New("Seek: invalid offset");
		__pkg.ErrClosedPipe = errors.New("io: read/write on closed pipe");
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["math"] = (function()
	var __pkg = {}, __init, js, arrayType, arrayType__1, arrayType__2, structType, math, buf, init, Float32bits, Float64bits;
	js = __packages["github.com/gopherjs/gopherjs/js"];
	arrayType = __arrayType(__Uint32, 2);
	arrayType__1 = __arrayType(__Float32, 2);
	arrayType__2 = __arrayType(__Float64, 1);
	structType = __structType("math", [{prop: "uint32array", name: "uint32array", anonymous: false, exported: false, typ: arrayType, tag: ""end, {prop: "float32array", name: "float32array", anonymous: false, exported: false, typ: arrayType__1, tag: ""end, {prop: "float64array", name: "float64array", anonymous: false, exported: false, typ: arrayType__2, tag: ""end]);
	init = function()
		var ab;
		ab = new (__global.ArrayBuffer)(8);
		buf.uint32array = new (__global.Uint32Array)(ab);
		buf.float32array = new (__global.Float32Array)(ab);
		buf.float64array = new (__global.Float64Array)(ab);
	end;
	Float32bits = function(f)
		var f;
		buf.float32array[0] = f;
		return buf.uint32array[0];
	end;
	__pkg.Float32bits = Float32bits;
	Float64bits = function(f)
		var f, x, x__1;
		buf.float64array[0] = f;
		return (x = __shiftLeft64((new __Uint64(0, buf.uint32array[1])), 32), x__1 = (new __Uint64(0, buf.uint32array[0])), new __Uint64(x.__high + x__1.__high, x.__low + x__1.__low));
	end;
	__pkg.Float64bits = Float64bits;
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = js.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		buf = new structType.ptr(arrayType.zero(), arrayType__1.zero(), arrayType__2.zero());
		math = __global.Math;
		init();
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["syscall"] = (function()
	var __pkg = {}, __init, errors, js, race, runtime, sync, SockaddrDatalink, mmapper, Errno, Sockaddr, SockaddrInet4, SockaddrInet6, SockaddrUnix, Timespec, Stat_t, RawSockaddrInet4, RawSockaddrInet6, RawSockaddrUnix, RawSockaddrDatalink, RawSockaddr, RawSockaddrAny, _Socklen, Linger, Iovec, IPMreq, IPv6Mreq, Msghdr, sliceType, sliceType__1, ptrType__2, arrayType, arrayType__1, ptrType__11, arrayType__3, arrayType__4, arrayType__5, arrayType__6, arrayType__10, ptrType__16, arrayType__11, ptrType__17, ptrType__18, structType, ptrType__20, ptrType__21, ptrType__27, mapType, funcType__2, funcType__3, ptrType__28, ptrType__29, ptrType__30, ptrType__31, arrayType__15, ptrType__32, warningPrinted, lineBuffer, syscallModule, alreadyTriedToLoad, minusOne, envs, freebsdConfArch, minRoutingSockaddrLen, mapper, errEAGAIN, errEINVAL, errENOENT, ioSync, ioSync__24ptr, errors__1, init, printWarning, printToConsole, indexByte, runtime_envs, syscall, Syscall, Syscall6, BytePtrFromString, readInt, readIntBE, readIntLE, ParseDirent, CloseOnExec, SetNonblock, msanRead, msanWrite, rsaAlignOf, itoa, uitoa, ReadDirent, anyToSockaddr, Accept, Recvmsg, SendmsgN, direntIno, direntReclen, direntNamlen, errnoErr, Read, Write, Recvfrom, Sendto, SetsockoptByte, SetsockoptInt, SetsockoptInet4Addr, SetsockoptIPMreq, SetsockoptIPv6Mreq, SetsockoptLinger, accept, setsockopt, Shutdown, recvfrom, sendto, recvmsg, sendmsg, fcntl, Close, Fchdir, Fchmod, Fchown, Fstat, Fsync, Ftruncate, Getdirentries, Lstat, Pread, Pwrite, read, Seek, write, mmap, munmap;
	errors = __packages["errors"];
	js = __packages["github.com/gopherjs/gopherjs/js"];
	race = __packages["internal/race"];
	runtime = __packages["runtime"];
	sync = __packages["sync"];
	SockaddrDatalink = __pkg.SockaddrDatalink = __newType(0, __kindStruct, "syscall.SockaddrDatalink", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Len = 0;
			this.Family = 0;
			this.Index = 0;
			this.Type = 0;
			this.Nlen = 0;
			this.Alen = 0;
			this.Slen = 0;
			this.Data = arrayType__3.zero();
			this.raw = new RawSockaddrDatalink.ptr(0, 0, 0, 0, 0, 0, 0, arrayType__3.zero());
			return;
		end
		this.Len = Len_;
		this.Family = Family_;
		this.Index = Index_;
		this.Type = Type_;
		this.Nlen = Nlen_;
		this.Alen = Alen_;
		this.Slen = Slen_;
		this.Data = Data_;
		this.raw = raw_;
	end);
	mmapper = __pkg.mmapper = __newType(0, __kindStruct, "syscall.mmapper", true, "syscall", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Mutex = new sync.Mutex.ptr(0, 0);
			this.active = false;
			this.mmap = __throwNilPointerError;
			this.munmap = __throwNilPointerError;
			return;
		end
		this.Mutex = Mutex_;
		this.active = active_;
		this.mmap = mmap_;
		this.munmap = munmap_;
	end);
	Errno = __pkg.Errno = __newType(4, __kindUintptr, "syscall.Errno", true, "syscall", true, null);
	Sockaddr = __pkg.Sockaddr = __newType(8, __kindInterface, "syscall.Sockaddr", true, "syscall", true, null);
	SockaddrInet4 = __pkg.SockaddrInet4 = __newType(0, __kindStruct, "syscall.SockaddrInet4", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Port = 0;
			this.Addr = arrayType__1.zero();
			this.raw = new RawSockaddrInet4.ptr(0, 0, 0, arrayType__1.zero(), arrayType__6.zero());
			return;
		end
		this.Port = Port_;
		this.Addr = Addr_;
		this.raw = raw_;
	end);
	SockaddrInet6 = __pkg.SockaddrInet6 = __newType(0, __kindStruct, "syscall.SockaddrInet6", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Port = 0;
			this.ZoneId = 0;
			this.Addr = arrayType.zero();
			this.raw = new RawSockaddrInet6.ptr(0, 0, 0, 0, arrayType.zero(), 0);
			return;
		end
		this.Port = Port_;
		this.ZoneId = ZoneId_;
		this.Addr = Addr_;
		this.raw = raw_;
	end);
	SockaddrUnix = __pkg.SockaddrUnix = __newType(0, __kindStruct, "syscall.SockaddrUnix", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Name = "";
			this.raw = new RawSockaddrUnix.ptr(0, 0, arrayType__11.zero());
			return;
		end
		this.Name = Name_;
		this.raw = raw_;
	end);
	Timespec = __pkg.Timespec = __newType(0, __kindStruct, "syscall.Timespec", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Sec = new __Int64(0, 0);
			this.Nsec = new __Int64(0, 0);
			return;
		end
		this.Sec = Sec_;
		this.Nsec = Nsec_;
	end);
	Stat_t = __pkg.Stat_t = __newType(0, __kindStruct, "syscall.Stat_t", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Dev = 0;
			this.Mode = 0;
			this.Nlink = 0;
			this.Ino = new __Uint64(0, 0);
			this.Uid = 0;
			this.Gid = 0;
			this.Rdev = 0;
			this.Pad_cgo_0 = arrayType__1.zero();
			this.Atimespec = new Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0));
			this.Mtimespec = new Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0));
			this.Ctimespec = new Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0));
			this.Birthtimespec = new Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0));
			this.Size = new __Int64(0, 0);
			this.Blocks = new __Int64(0, 0);
			this.Blksize = 0;
			this.Flags = 0;
			this.Gen = 0;
			this.Lspare = 0;
			this.Qspare = arrayType__15.zero();
			return;
		end
		this.Dev = Dev_;
		this.Mode = Mode_;
		this.Nlink = Nlink_;
		this.Ino = Ino_;
		this.Uid = Uid_;
		this.Gid = Gid_;
		this.Rdev = Rdev_;
		this.Pad_cgo_0 = Pad_cgo_0_;
		this.Atimespec = Atimespec_;
		this.Mtimespec = Mtimespec_;
		this.Ctimespec = Ctimespec_;
		this.Birthtimespec = Birthtimespec_;
		this.Size = Size_;
		this.Blocks = Blocks_;
		this.Blksize = Blksize_;
		this.Flags = Flags_;
		this.Gen = Gen_;
		this.Lspare = Lspare_;
		this.Qspare = Qspare_;
	end);
	RawSockaddrInet4 = __pkg.RawSockaddrInet4 = __newType(0, __kindStruct, "syscall.RawSockaddrInet4", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Len = 0;
			this.Family = 0;
			this.Port = 0;
			this.Addr = arrayType__1.zero();
			this.Zero = arrayType__6.zero();
			return;
		end
		this.Len = Len_;
		this.Family = Family_;
		this.Port = Port_;
		this.Addr = Addr_;
		this.Zero = Zero_;
	end);
	RawSockaddrInet6 = __pkg.RawSockaddrInet6 = __newType(0, __kindStruct, "syscall.RawSockaddrInet6", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Len = 0;
			this.Family = 0;
			this.Port = 0;
			this.Flowinfo = 0;
			this.Addr = arrayType.zero();
			this.Scope_id = 0;
			return;
		end
		this.Len = Len_;
		this.Family = Family_;
		this.Port = Port_;
		this.Flowinfo = Flowinfo_;
		this.Addr = Addr_;
		this.Scope_id = Scope_id_;
	end);
	RawSockaddrUnix = __pkg.RawSockaddrUnix = __newType(0, __kindStruct, "syscall.RawSockaddrUnix", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Len = 0;
			this.Family = 0;
			this.Path = arrayType__11.zero();
			return;
		end
		this.Len = Len_;
		this.Family = Family_;
		this.Path = Path_;
	end);
	RawSockaddrDatalink = __pkg.RawSockaddrDatalink = __newType(0, __kindStruct, "syscall.RawSockaddrDatalink", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Len = 0;
			this.Family = 0;
			this.Index = 0;
			this.Type = 0;
			this.Nlen = 0;
			this.Alen = 0;
			this.Slen = 0;
			this.Data = arrayType__3.zero();
			return;
		end
		this.Len = Len_;
		this.Family = Family_;
		this.Index = Index_;
		this.Type = Type_;
		this.Nlen = Nlen_;
		this.Alen = Alen_;
		this.Slen = Slen_;
		this.Data = Data_;
	end);
	RawSockaddr = __pkg.RawSockaddr = __newType(0, __kindStruct, "syscall.RawSockaddr", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Len = 0;
			this.Family = 0;
			this.Data = arrayType__4.zero();
			return;
		end
		this.Len = Len_;
		this.Family = Family_;
		this.Data = Data_;
	end);
	RawSockaddrAny = __pkg.RawSockaddrAny = __newType(0, __kindStruct, "syscall.RawSockaddrAny", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Addr = new RawSockaddr.ptr(0, 0, arrayType__4.zero());
			this.Pad = arrayType__5.zero();
			return;
		end
		this.Addr = Addr_;
		this.Pad = Pad_;
	end);
	_Socklen = __pkg._Socklen = __newType(4, __kindUint32, "syscall._Socklen", true, "syscall", false, null);
	Linger = __pkg.Linger = __newType(0, __kindStruct, "syscall.Linger", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Onoff = 0;
			this.Linger = 0;
			return;
		end
		this.Onoff = Onoff_;
		this.Linger = Linger_;
	end);
	Iovec = __pkg.Iovec = __newType(0, __kindStruct, "syscall.Iovec", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Base = ptrType__2.nil;
			this.Len = new __Uint64(0, 0);
			return;
		end
		this.Base = Base_;
		this.Len = Len_;
	end);
	IPMreq = __pkg.IPMreq = __newType(0, __kindStruct, "syscall.IPMreq", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Multiaddr = arrayType__1.zero();
			this.Interface = arrayType__1.zero();
			return;
		end
		this.Multiaddr = Multiaddr_;
		this.Interface = Interface_;
	end);
	IPv6Mreq = __pkg.IPv6Mreq = __newType(0, __kindStruct, "syscall.IPv6Mreq", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Multiaddr = arrayType.zero();
			this.Interface = 0;
			return;
		end
		this.Multiaddr = Multiaddr_;
		this.Interface = Interface_;
	end);
	Msghdr = __pkg.Msghdr = __newType(0, __kindStruct, "syscall.Msghdr", true, "syscall", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Name = ptrType__2.nil;
			this.Namelen = 0;
			this.Pad_cgo_0 = arrayType__1.zero();
			this.Iov = ptrType__18.nil;
			this.Iovlen = 0;
			this.Pad_cgo_1 = arrayType__1.zero();
			this.Control = ptrType__2.nil;
			this.Controllen = 0;
			this.Flags = 0;
			return;
		end
		this.Name = Name_;
		this.Namelen = Namelen_;
		this.Pad_cgo_0 = Pad_cgo_0_;
		this.Iov = Iov_;
		this.Iovlen = Iovlen_;
		this.Pad_cgo_1 = Pad_cgo_1_;
		this.Control = Control_;
		this.Controllen = Controllen_;
		this.Flags = Flags_;
	end);
	sliceType = __sliceType(__Uint8);
	sliceType__1 = __sliceType(__String);
	ptrType__2 = __ptrType(__Uint8);
	arrayType = __arrayType(__Uint8, 16);
	arrayType__1 = __arrayType(__Uint8, 4);
	ptrType__11 = __ptrType(SockaddrDatalink);
	arrayType__3 = __arrayType(__Int8, 12);
	arrayType__4 = __arrayType(__Int8, 14);
	arrayType__5 = __arrayType(__Int8, 92);
	arrayType__6 = __arrayType(__Int8, 8);
	arrayType__10 = __arrayType(__Uint8, 32);
	ptrType__16 = __ptrType(__Uint16);
	arrayType__11 = __arrayType(__Int8, 104);
	ptrType__17 = __ptrType(_Socklen);
	ptrType__18 = __ptrType(Iovec);
	structType = __structType("syscall", [{prop: "addr", name: "addr", anonymous: false, exported: false, typ: __Uintptr, tag: ""end, {prop: "len", name: "len", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "cap", name: "cap", anonymous: false, exported: false, typ: __Int, tag: ""end]);
	ptrType__20 = __ptrType(__Int64);
	ptrType__21 = __ptrType(__Int32);
	ptrType__27 = __ptrType(mmapper);
	mapType = __mapType(ptrType__2, sliceType);
	funcType__2 = __funcType([__Uintptr, __Uintptr, __Int, __Int, __Int, __Int64], [__Uintptr, __error], false);
	funcType__3 = __funcType([__Uintptr, __Uintptr], [__error], false);
	ptrType__28 = __ptrType(SockaddrInet4);
	ptrType__29 = __ptrType(SockaddrInet6);
	ptrType__30 = __ptrType(SockaddrUnix);
	ptrType__31 = __ptrType(Timespec);
	arrayType__15 = __arrayType(__Int64, 2);
	ptrType__32 = __ptrType(Msghdr);
	init = function()
		__flushConsole = (function()
			if ( not ((lineBuffer.__length == 0))) {
				__global.console.log(__externalize((__bytesToString(lineBuffer)), __String));
				lineBuffer = sliceType.nil;
			end
		end);
	end;
	printWarning = function()
		if ( not warningPrinted) {
			__global.console.error(__externalize("warning: system calls not available, see https://github.com/gopherjs/gopherjs/blob/master/doc/syscalls.md", __String));
		end
		warningPrinted = true;
	end;
	printToConsole = function(b)
		var b, goPrintToConsole, i;
		goPrintToConsole = __global.goPrintToConsole;
		if ( not (goPrintToConsole == nil)) {
			goPrintToConsole(b);
			return;
		end
		lineBuffer = __appendSlice(lineBuffer, b);
		while (true) {
			i = indexByte(lineBuffer, 10);
			if (i == -1) {
				break;
			end
			__global.console.log(__externalize((__bytesToString(__subslice(lineBuffer, 0, i))), __String));
			lineBuffer = __subslice(lineBuffer, (i + 1 >> 0));
		end
	end;
	indexByte = function(c)
		var _i, _ref, b, c, i, s;
		_ref = s;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			b = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			if (b == c) {
				return i;
			end
			_i++;
		end
		return -1;
	end;
	runtime_envs = function()
		var envkeys, envs__1, i, jsEnv, key, process;
		process = __global.process;
		if (process == nil) {
			return sliceType__1.nil;
		end
		jsEnv = process.env;
		envkeys = __global.Object.keys(jsEnv);
		envs__1 = __makeSlice(sliceType__1, __parseInt(envkeys.length));
		i = 0;
		while (true) {
			if ( not (i < __parseInt(envkeys.length))) { break; end
			key = __internalize(envkeys[i], __String);
			((i < 0  or  i >= envs__1.__length) ? (__throwRuntimeError("index out of range"), nil) : envs__1.__array[envs__1.__offset + i] = key + "=" + __internalize(jsEnv[__externalize(key, __String)], __String));
			i = i + (1) >> 0;
		end
		return envs__1;
	end;
	syscall = function(e)
		var name, require, __deferred;
		/* */ var __err = null; try { __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		__deferred.push([(function()
			__recover();
		end), []]);
		if (syscallModule == null) {
			if (alreadyTriedToLoad) {
				return null;
			end
			alreadyTriedToLoad = true;
			require = __global.require;
			if (require == nil) {
				__panic(new __String(""));
			end
			syscallModule = require(__externalize("syscall", __String));
		end
		return syscallModule[__externalize(name, __String)];
		/* */ end catch(err) { __err = err; return null; end finally { __callDeferred(__deferred, __err); end
	end;
	Syscall = function(3)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tmp__8, a1, a2, a3, array, err, f, r, r1, r2, slice, trap;
		r1 = 0;
		r2 = 0;
		err = 0;
		f = syscall("Syscall");
		if ( not (f == null)) {
			r = f(trap, a1, a2, a3);
			_tmp = (((__parseInt(r[0]) >> 0) >>> 0));
			_tmp__1 = (((__parseInt(r[1]) >> 0) >>> 0));
			_tmp__2 = (((__parseInt(r[2]) >> 0) >>> 0));
			r1 = _tmp;
			r2 = _tmp__1;
			err = _tmp__2;
			return [r1, r2, err];
		end
		if ((trap == 4)  and  ((a1 == 1)  or  (a1 == 2))) {
			array = a2;
			slice = __makeSlice(sliceType, __parseInt(array.length));
			slice.__array = array;
			printToConsole(slice);
			_tmp__3 = ((__parseInt(array.length) >>> 0));
			_tmp__4 = 0;
			_tmp__5 = 0;
			r1 = _tmp__3;
			r2 = _tmp__4;
			err = _tmp__5;
			return [r1, r2, err];
		end
		if (trap == 1) {
			runtime.Goexit();
		end
		printWarning();
		_tmp__6 = ((minusOne >>> 0));
		_tmp__7 = 0;
		_tmp__8 = 13;
		r1 = _tmp__6;
		r2 = _tmp__7;
		err = _tmp__8;
		return [r1, r2, err];
	end;
	__pkg.Syscall = Syscall;
	Syscall6 = function(6)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, a1, a2, a3, a4, a5, a6, err, f, r, r1, r2, trap;
		r1 = 0;
		r2 = 0;
		err = 0;
		f = syscall("Syscall6");
		if ( not (f == null)) {
			r = f(trap, a1, a2, a3, a4, a5, a6);
			_tmp = (((__parseInt(r[0]) >> 0) >>> 0));
			_tmp__1 = (((__parseInt(r[1]) >> 0) >>> 0));
			_tmp__2 = (((__parseInt(r[2]) >> 0) >>> 0));
			r1 = _tmp;
			r2 = _tmp__1;
			err = _tmp__2;
			return [r1, r2, err];
		end
		if ( not ((trap == 202))) {
			printWarning();
		end
		_tmp__3 = ((minusOne >>> 0));
		_tmp__4 = 0;
		_tmp__5 = 13;
		r1 = _tmp__3;
		r2 = _tmp__4;
		err = _tmp__5;
		return [r1, r2, err];
	end;
	__pkg.Syscall6 = Syscall6;
	BytePtrFromString = function(s)
		var _i, _ref, array, b, i, s;
		array = new (__global.Uint8Array)(s.length + 1 >> 0);
		_ref = (new sliceType(__stringToBytes(s)));
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			b = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			if (b == 0) {
				return [ptrType__2.nil, new Errno(22)];
			end
			array[i] = b;
			_i++;
		end
		array[s.length] = 0;
		return [((array)), __ifaceNil];
	end;
	__pkg.BytePtrFromString = BytePtrFromString;
	readInt = function(e)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, b, off, ok, size, u;
		u = new __Uint64(0, 0);
		ok = false;
		if (b.__length < (((off + size >>> 0) >> 0))) {
			_tmp = new __Uint64(0, 0);
			_tmp__1 = false;
			u = _tmp;
			ok = _tmp__1;
			return [u, ok];
		end
		if (false) {
			_tmp__2 = readIntBE(__subslice(b, off), size);
			_tmp__3 = true;
			u = _tmp__2;
			ok = _tmp__3;
			return [u, ok];
		end
		_tmp__4 = readIntLE(__subslice(b, off), size);
		_tmp__5 = true;
		u = _tmp__4;
		ok = _tmp__5;
		return [u, ok];
	end;
	readIntBE = function(e)
		var _1, b, size, x, x__1, x__10, x__11, x__12, x__13, x__14, x__15, x__16, x__17, x__18, x__19, x__2, x__20, x__21, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		_1 = size;
		if (_1 == (1)) {
			return (new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0])));
		end else if (_1 == (2)) {
			__unused((1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]));
			return (x = (new __Uint64(0, (1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]))), x__1 = __shiftLeft64((new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0]))), 8), new __Uint64(x.__high | x__1.__high, (x.__low | x__1.__low) >>> 0));
		end else if (_1 == (4)) {
			__unused((3 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 3]));
			return (x__2 = (x__3 = (x__4 = (new __Uint64(0, (3 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 3]))), x__5 = __shiftLeft64((new __Uint64(0, (2 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 2]))), 8), new __Uint64(x__4.__high | x__5.__high, (x__4.__low | x__5.__low) >>> 0)), x__6 = __shiftLeft64((new __Uint64(0, (1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]))), 16), new __Uint64(x__3.__high | x__6.__high, (x__3.__low | x__6.__low) >>> 0)), x__7 = __shiftLeft64((new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0]))), 24), new __Uint64(x__2.__high | x__7.__high, (x__2.__low | x__7.__low) >>> 0));
		end else if (_1 == (8)) {
			__unused((7 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 7]));
			return (x__8 = (x__9 = (x__10 = (x__11 = (x__12 = (x__13 = (x__14 = (new __Uint64(0, (7 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 7]))), x__15 = __shiftLeft64((new __Uint64(0, (6 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 6]))), 8), new __Uint64(x__14.__high | x__15.__high, (x__14.__low | x__15.__low) >>> 0)), x__16 = __shiftLeft64((new __Uint64(0, (5 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 5]))), 16), new __Uint64(x__13.__high | x__16.__high, (x__13.__low | x__16.__low) >>> 0)), x__17 = __shiftLeft64((new __Uint64(0, (4 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 4]))), 24), new __Uint64(x__12.__high | x__17.__high, (x__12.__low | x__17.__low) >>> 0)), x__18 = __shiftLeft64((new __Uint64(0, (3 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 3]))), 32), new __Uint64(x__11.__high | x__18.__high, (x__11.__low | x__18.__low) >>> 0)), x__19 = __shiftLeft64((new __Uint64(0, (2 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 2]))), 40), new __Uint64(x__10.__high | x__19.__high, (x__10.__low | x__19.__low) >>> 0)), x__20 = __shiftLeft64((new __Uint64(0, (1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]))), 48), new __Uint64(x__9.__high | x__20.__high, (x__9.__low | x__20.__low) >>> 0)), x__21 = __shiftLeft64((new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0]))), 56), new __Uint64(x__8.__high | x__21.__high, (x__8.__low | x__21.__low) >>> 0));
		end else {
			__panic(new __String("syscall: readInt with unsupported size"));
		end
	end;
	readIntLE = function(e)
		var _1, b, size, x, x__1, x__10, x__11, x__12, x__13, x__14, x__15, x__16, x__17, x__18, x__19, x__2, x__20, x__21, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		_1 = size;
		if (_1 == (1)) {
			return (new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0])));
		end else if (_1 == (2)) {
			__unused((1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]));
			return (x = (new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0]))), x__1 = __shiftLeft64((new __Uint64(0, (1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]))), 8), new __Uint64(x.__high | x__1.__high, (x.__low | x__1.__low) >>> 0));
		end else if (_1 == (4)) {
			__unused((3 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 3]));
			return (x__2 = (x__3 = (x__4 = (new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0]))), x__5 = __shiftLeft64((new __Uint64(0, (1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]))), 8), new __Uint64(x__4.__high | x__5.__high, (x__4.__low | x__5.__low) >>> 0)), x__6 = __shiftLeft64((new __Uint64(0, (2 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 2]))), 16), new __Uint64(x__3.__high | x__6.__high, (x__3.__low | x__6.__low) >>> 0)), x__7 = __shiftLeft64((new __Uint64(0, (3 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 3]))), 24), new __Uint64(x__2.__high | x__7.__high, (x__2.__low | x__7.__low) >>> 0));
		end else if (_1 == (8)) {
			__unused((7 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 7]));
			return (x__8 = (x__9 = (x__10 = (x__11 = (x__12 = (x__13 = (x__14 = (new __Uint64(0, (0 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 0]))), x__15 = __shiftLeft64((new __Uint64(0, (1 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 1]))), 8), new __Uint64(x__14.__high | x__15.__high, (x__14.__low | x__15.__low) >>> 0)), x__16 = __shiftLeft64((new __Uint64(0, (2 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 2]))), 16), new __Uint64(x__13.__high | x__16.__high, (x__13.__low | x__16.__low) >>> 0)), x__17 = __shiftLeft64((new __Uint64(0, (3 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 3]))), 24), new __Uint64(x__12.__high | x__17.__high, (x__12.__low | x__17.__low) >>> 0)), x__18 = __shiftLeft64((new __Uint64(0, (4 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 4]))), 32), new __Uint64(x__11.__high | x__18.__high, (x__11.__low | x__18.__low) >>> 0)), x__19 = __shiftLeft64((new __Uint64(0, (5 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 5]))), 40), new __Uint64(x__10.__high | x__19.__high, (x__10.__low | x__19.__low) >>> 0)), x__20 = __shiftLeft64((new __Uint64(0, (6 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 6]))), 48), new __Uint64(x__9.__high | x__20.__high, (x__9.__low | x__20.__low) >>> 0)), x__21 = __shiftLeft64((new __Uint64(0, (7 >= b.__length ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + 7]))), 56), new __Uint64(x__8.__high | x__21.__high, (x__8.__low | x__21.__low) >>> 0));
		end else {
			__panic(new __String("syscall: readInt with unsupported size"));
		end
	end;
	ParseDirent = function(s)
		var _i, _ref, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tuple, _tuple__1, _tuple__2, buf, c, consumed, count, i, ino, max, name, names, namlen, newnames, ok, origlen, rec, reclen, x, x__1, x__2;
		consumed = 0;
		count = 0;
		newnames = sliceType__1.nil;
		origlen = buf.__length;
		count = 0;
		while (true) {
			if ( not ( not ((max == 0))  and  buf.__length > 0)) { break; end
			_tuple = direntReclen(buf);
			reclen = _tuple[0];
			ok = _tuple[1];
			if ( not ok  or  (x = (new __Uint64(0, buf.__length)), (reclen.__high > x.__high  or  (reclen.__high == x.__high  and  reclen.__low > x.__low)))) {
				_tmp = origlen;
				_tmp__1 = count;
				_tmp__2 = names;
				consumed = _tmp;
				count = _tmp__1;
				newnames = _tmp__2;
				return [consumed, count, newnames];
			end
			rec = __subslice(buf, 0, __flatten64(reclen));
			buf = __subslice(buf, __flatten64(reclen));
			_tuple__1 = direntIno(rec);
			ino = _tuple__1[0];
			ok = _tuple__1[1];
			if ( not ok) {
				break;
			end
			if ((ino.__high == 0  and  ino.__low == 0)) {
				continue;
			end
			_tuple__2 = direntNamlen(rec);
			namlen = _tuple__2[0];
			ok = _tuple__2[1];
			if ( not ok  or  (x__1 = new __Uint64(0 + namlen.__high, 21 + namlen.__low), x__2 = (new __Uint64(0, rec.__length)), (x__1.__high > x__2.__high  or  (x__1.__high == x__2.__high  and  x__1.__low > x__2.__low)))) {
				break;
			end
			name = __subslice(rec, 21, __flatten64(new __Uint64(0 + namlen.__high, 21 + namlen.__low)));
			_ref = name;
			_i = 0;
			while (true) {
				if ( not (_i < _ref.__length)) { break; end
				i = _i;
				c = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
				if (c == 0) {
					name = __subslice(name, 0, i);
					break;
				end
				_i++;
			end
			if ((__bytesToString(name)) == "."  or  (__bytesToString(name)) == "..") {
				continue;
			end
			max = max - (1) >> 0;
			count = count + (1) >> 0;
			names = __append(names, (__bytesToString(name)));
		end
		_tmp__3 = origlen - buf.__length >> 0;
		_tmp__4 = count;
		_tmp__5 = names;
		consumed = _tmp__3;
		count = _tmp__4;
		newnames = _tmp__5;
		return [consumed, count, newnames];
	end;
	__pkg.ParseDirent = ParseDirent;
	CloseOnExec = function(d)
		var fd;
		fcntl(fd, 2, 1);
	end;
	__pkg.CloseOnExec = CloseOnExec;
	SetNonblock = function(g)
		var _tuple, _tuple__1, err, fd, flag, nonblocking;
		err = __ifaceNil;
		_tuple = fcntl(fd, 3, 0);
		flag = _tuple[0];
		err = _tuple[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			err = err;
			return err;
		end
		if (nonblocking) {
			flag = flag | (4);
		end else {
			flag = (flag & ~(4)) >> 0;
		end
		_tuple__1 = fcntl(fd, 4, flag);
		err = _tuple__1[1];
		err = err;
		return err;
	end;
	__pkg.SetNonblock = SetNonblock;
	msanRead = function(n)
		var addr, len;
	end;
	msanWrite = function(n)
		var addr, len;
	end;
	rsaAlignOf = function(n)
		var salen, salign;
		salign = 8;
		if (true) {
			salign = 4;
		end else if (false) {
			salign = 8;
		end else if (false) {
			if (freebsdConfArch == "amd64") {
				salign = 8;
			end
		end
		if (salen == 0) {
			return salign;
		end
		return (((salen + salign >> 0) - 1 >> 0)) & (~((salign - 1 >> 0)) >> 0);
	end;
	itoa = function(l)
		var val;
		if (val < 0) {
			return "-" + uitoa(((-val >>> 0)));
		end
		return uitoa(((val >>> 0)));
	end;
	uitoa = function(l)
		var _q, _r, buf, i, val;
		buf = arrayType__10.zero();
		i = 31;
		while (true) {
			if ( not (val >= 10)) { break; end
			((i < 0  or  i >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[i] = ((((_r = val % 10, _r == _r ? _r : __throwRuntimeError("integer divide by zero")) + 48 >>> 0) << 24 >>> 24)));
			i = i - (1) >> 0;
			val = (_q = val / (10), (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >>> 0 : __throwRuntimeError("integer divide by zero"));
		end
		((i < 0  or  i >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[i] = (((val + 48 >>> 0) << 24 >>> 24)));
		return (__bytesToString(__subslice(new sliceType(buf), i)));
	end;
	Timespec.ptr.prototype.Unix = function()
		var _tmp, _tmp__1, nsec, sec, ts;
		sec = new __Int64(0, 0);
		nsec = new __Int64(0, 0);
		ts = this;
		_tmp = (ts.Sec);
		_tmp__1 = (ts.Nsec);
		sec = _tmp;
		nsec = _tmp__1;
		return [sec, nsec];
	end;
	Timespec.prototype.Unix = function() return this.__val.Unix(); end;
	Timespec.ptr.prototype.Nano = function()
		var ts, x, x__1;
		ts = this;
		return (x = __mul64((ts.Sec), new __Int64(0, 1000000000)), x__1 = (ts.Nsec), new __Int64(x.__high + x__1.__high, x.__low + x__1.__low));
	end;
	Timespec.prototype.Nano = function() return this.__val.Nano(); end;
	ReadDirent = function(f)
		var _tuple, base, buf, err, fd, n;
		n = 0;
		err = __ifaceNil;
		base = ((new Uint8Array(8)));
		_tuple = Getdirentries(fd, buf, base);
		n = _tuple[0];
		err = _tuple[1];
		return [n, err];
	end;
	__pkg.ReadDirent = ReadDirent;
	SockaddrInet4.ptr.prototype.sockaddr = function()
		var _array, _struct, _view, i, p, sa, x, x__1, x__2;
		sa = this;
		if (sa.Port < 0  or  sa.Port > 65535) {
			return [0, 0, new Errno(22)];
		end
		sa.raw.Len = 16;
		sa.raw.Family = 2;
		p = (((x = sa.raw, (x.__ptr_Port  or  (x.__ptr_Port = new ptrType__16(function() return this.__target.Port; end, function(v) this.__target.Port = __v; end, x))))));
		p.nilCheck, p[0] = (((sa.Port >> 8 >> 0) << 24 >>> 24));
		p.nilCheck, p[1] = ((sa.Port << 24 >>> 24));
		i = 0;
		while (true) {
			if ( not (i < 4)) { break; end
			(x__2 = sa.raw.Addr, ((i < 0  or  i >= x__2.length) ? (__throwRuntimeError("index out of range"), nil) : x__2[i] = (x__1 = sa.Addr, ((i < 0  or  i >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[i]))));
			i = i + (1) >> 0;
		end
		_array = new Uint8Array(16);
		return [(_array), ((sa.raw.Len >>> 0)), __ifaceNil];
	end;
	SockaddrInet4.prototype.sockaddr = function() return this.__val.sockaddr(); end;
	SockaddrInet6.ptr.prototype.sockaddr = function()
		var _array, _struct, _view, i, p, sa, x, x__1, x__2;
		sa = this;
		if (sa.Port < 0  or  sa.Port > 65535) {
			return [0, 0, new Errno(22)];
		end
		sa.raw.Len = 28;
		sa.raw.Family = 30;
		p = (((x = sa.raw, (x.__ptr_Port  or  (x.__ptr_Port = new ptrType__16(function() return this.__target.Port; end, function(v) this.__target.Port = __v; end, x))))));
		p.nilCheck, p[0] = (((sa.Port >> 8 >> 0) << 24 >>> 24));
		p.nilCheck, p[1] = ((sa.Port << 24 >>> 24));
		sa.raw.Scope_id = sa.ZoneId;
		i = 0;
		while (true) {
			if ( not (i < 16)) { break; end
			(x__2 = sa.raw.Addr, ((i < 0  or  i >= x__2.length) ? (__throwRuntimeError("index out of range"), nil) : x__2[i] = (x__1 = sa.Addr, ((i < 0  or  i >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[i]))));
			i = i + (1) >> 0;
		end
		_array = new Uint8Array(28);
		return [(_array), ((sa.raw.Len >>> 0)), __ifaceNil];
	end;
	SockaddrInet6.prototype.sockaddr = function() return this.__val.sockaddr(); end;
	SockaddrUnix.ptr.prototype.sockaddr = function()
		var _array, _struct, _view, i, n, name, sa, x;
		sa = this;
		name = sa.Name;
		n = name.length;
		if (n >= 104  or  (n == 0)) {
			return [0, 0, new Errno(22)];
		end
		sa.raw.Len = (((3 + n >> 0) << 24 >>> 24));
		sa.raw.Family = 1;
		i = 0;
		while (true) {
			if ( not (i < n)) { break; end
			(x = sa.raw.Path, ((i < 0  or  i >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[i] = ((name.charCodeAt(i) << 24 >> 24))));
			i = i + (1) >> 0;
		end
		_array = new Uint8Array(106);
		return [(_array), ((sa.raw.Len >>> 0)), __ifaceNil];
	end;
	SockaddrUnix.prototype.sockaddr = function() return this.__val.sockaddr(); end;
	SockaddrDatalink.ptr.prototype.sockaddr = function()
		var _array, _struct, _view, i, sa, x, x__1;
		sa = this;
		if (sa.Index == 0) {
			return [0, 0, new Errno(22)];
		end
		sa.raw.Len = sa.Len;
		sa.raw.Family = 18;
		sa.raw.Index = sa.Index;
		sa.raw.Type = sa.Type;
		sa.raw.Nlen = sa.Nlen;
		sa.raw.Alen = sa.Alen;
		sa.raw.Slen = sa.Slen;
		i = 0;
		while (true) {
			if ( not (i < 12)) { break; end
			(x__1 = sa.raw.Data, ((i < 0  or  i >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[i] = (x = sa.Data, ((i < 0  or  i >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[i]))));
			i = i + (1) >> 0;
		end
		_array = new Uint8Array(20);
		return [(_array), 20, __ifaceNil];
	end;
	SockaddrDatalink.prototype.sockaddr = function() return this.__val.sockaddr(); end;
	anyToSockaddr = function(a)
		var _1, _array, _array__1, _array__2, _array__3, _array__4, _array__5, _array__6, _array__7, _struct, _struct__1, _struct__2, _struct__3, _struct__4, _struct__5, _struct__6, _struct__7, _view, _view__1, _view__2, _view__3, _view__4, _view__5, _view__6, _view__7, bytes, i, i__1, i__2, i__3, n, p, p__1, pp, pp__1, pp__2, pp__3, rsa, sa, sa__1, sa__2, sa__3, x, x__1, x__2, x__3, x__4, x__5, x__6;
		_1 = rsa.Addr.Family;
		if (_1 == (18)) {
			_array__1 = new Uint8Array(108);
			pp = ((_array = (_array__1), _struct = new RawSockaddrDatalink.ptr(0, 0, 0, 0, 0, 0, 0, arrayType__3.zero()), _view = new DataView(_array.buffer, _array.byteOffset), _struct.Len = _view.getUint8(0, true), _struct.Family = _view.getUint8(1, true), _struct.Index = _view.getUint16(2, true), _struct.Type = _view.getUint8(4, true), _struct.Nlen = _view.getUint8(5, true), _struct.Alen = _view.getUint8(6, true), _struct.Slen = _view.getUint8(7, true), _struct.Data = new (__nativeArray(__kindInt8))(_array.buffer, __min(_array.byteOffset + 8, _array.buffer.byteLength)), _struct));
			_struct__1 = rsa, _view__1 = new DataView(_array__1.buffer, _array__1.byteOffset), _struct__1.Addr.Len = _view__1.getUint8(0, true), _struct__1.Addr.Family = _view__1.getUint8(1, true), _struct__1.Addr.Data = new (__nativeArray(__kindInt8))(_array__1.buffer, __min(_array__1.byteOffset + 2, _array__1.buffer.byteLength)), _struct__1.Pad = new (__nativeArray(__kindInt8))(_array__1.buffer, __min(_array__1.byteOffset + 16, _array__1.buffer.byteLength));
			sa = new SockaddrDatalink.ptr(0, 0, 0, 0, 0, 0, 0, arrayType__3.zero(), new RawSockaddrDatalink.ptr(0, 0, 0, 0, 0, 0, 0, arrayType__3.zero()));
			sa.Len = pp.Len;
			sa.Family = pp.Family;
			sa.Index = pp.Index;
			sa.Type = pp.Type;
			sa.Nlen = pp.Nlen;
			sa.Alen = pp.Alen;
			sa.Slen = pp.Slen;
			i = 0;
			while (true) {
				if ( not (i < 12)) { break; end
				(x__1 = sa.Data, ((i < 0  or  i >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[i] = (x = pp.Data, ((i < 0  or  i >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[i]))));
				i = i + (1) >> 0;
			end
			return [sa, __ifaceNil];
		end else if (_1 == (1)) {
			_array__3 = new Uint8Array(108);
			pp__1 = ((_array__2 = (_array__3), _struct__2 = new RawSockaddrUnix.ptr(0, 0, arrayType__11.zero()), _view__2 = new DataView(_array__2.buffer, _array__2.byteOffset), _struct__2.Len = _view__2.getUint8(0, true), _struct__2.Family = _view__2.getUint8(1, true), _struct__2.Path = new (__nativeArray(__kindInt8))(_array__2.buffer, __min(_array__2.byteOffset + 2, _array__2.buffer.byteLength)), _struct__2));
			_struct__3 = rsa, _view__3 = new DataView(_array__3.buffer, _array__3.byteOffset), _struct__3.Addr.Len = _view__3.getUint8(0, true), _struct__3.Addr.Family = _view__3.getUint8(1, true), _struct__3.Addr.Data = new (__nativeArray(__kindInt8))(_array__3.buffer, __min(_array__3.byteOffset + 2, _array__3.buffer.byteLength)), _struct__3.Pad = new (__nativeArray(__kindInt8))(_array__3.buffer, __min(_array__3.byteOffset + 16, _array__3.buffer.byteLength));
			if (pp__1.Len < 2  or  pp__1.Len > 106) {
				return [__ifaceNil, new Errno(22)];
			end
			sa__1 = new SockaddrUnix.ptr("", new RawSockaddrUnix.ptr(0, 0, arrayType__11.zero()));
			n = ((pp__1.Len >> 0)) - 2 >> 0;
			i__1 = 0;
			while (true) {
				if ( not (i__1 < n)) { break; end
				if ((x__2 = pp__1.Path, ((i__1 < 0  or  i__1 >= x__2.length) ? (__throwRuntimeError("index out of range"), nil) : x__2[i__1])) == 0) {
					n = i__1;
					break;
				end
				i__1 = i__1 + (1) >> 0;
			end
			bytes = __subslice(new sliceType(((__sliceToArray(new sliceType(pp__1.Path))))), 0, n);
			sa__1.Name = (__bytesToString(bytes));
			return [sa__1, __ifaceNil];
		end else if (_1 == (2)) {
			_array__5 = new Uint8Array(108);
			pp__2 = ((_array__4 = (_array__5), _struct__4 = new RawSockaddrInet4.ptr(0, 0, 0, arrayType__1.zero(), arrayType__6.zero()), _view__4 = new DataView(_array__4.buffer, _array__4.byteOffset), _struct__4.Len = _view__4.getUint8(0, true), _struct__4.Family = _view__4.getUint8(1, true), _struct__4.Port = _view__4.getUint16(2, true), _struct__4.Addr = new (__nativeArray(__kindUint8))(_array__4.buffer, __min(_array__4.byteOffset + 4, _array__4.buffer.byteLength)), _struct__4.Zero = new (__nativeArray(__kindInt8))(_array__4.buffer, __min(_array__4.byteOffset + 8, _array__4.buffer.byteLength)), _struct__4));
			_struct__5 = rsa, _view__5 = new DataView(_array__5.buffer, _array__5.byteOffset), _struct__5.Addr.Len = _view__5.getUint8(0, true), _struct__5.Addr.Family = _view__5.getUint8(1, true), _struct__5.Addr.Data = new (__nativeArray(__kindInt8))(_array__5.buffer, __min(_array__5.byteOffset + 2, _array__5.buffer.byteLength)), _struct__5.Pad = new (__nativeArray(__kindInt8))(_array__5.buffer, __min(_array__5.byteOffset + 16, _array__5.buffer.byteLength));
			sa__2 = new SockaddrInet4.ptr(0, arrayType__1.zero(), new RawSockaddrInet4.ptr(0, 0, 0, arrayType__1.zero(), arrayType__6.zero()));
			p = (((pp__2.__ptr_Port  or  (pp__2.__ptr_Port = new ptrType__16(function() return this.__target.Port; end, function(v) this.__target.Port = __v; end, pp__2)))));
			sa__2.Port = ((((p.nilCheck, p[0]) >> 0)) << 8 >> 0) + (((p.nilCheck, p[1]) >> 0)) >> 0;
			i__2 = 0;
			while (true) {
				if ( not (i__2 < 4)) { break; end
				(x__4 = sa__2.Addr, ((i__2 < 0  or  i__2 >= x__4.length) ? (__throwRuntimeError("index out of range"), nil) : x__4[i__2] = (x__3 = pp__2.Addr, ((i__2 < 0  or  i__2 >= x__3.length) ? (__throwRuntimeError("index out of range"), nil) : x__3[i__2]))));
				i__2 = i__2 + (1) >> 0;
			end
			return [sa__2, __ifaceNil];
		end else if (_1 == (30)) {
			_array__7 = new Uint8Array(108);
			pp__3 = ((_array__6 = (_array__7), _struct__6 = new RawSockaddrInet6.ptr(0, 0, 0, 0, arrayType.zero(), 0), _view__6 = new DataView(_array__6.buffer, _array__6.byteOffset), _struct__6.Len = _view__6.getUint8(0, true), _struct__6.Family = _view__6.getUint8(1, true), _struct__6.Port = _view__6.getUint16(2, true), _struct__6.Flowinfo = _view__6.getUint32(4, true), _struct__6.Addr = new (__nativeArray(__kindUint8))(_array__6.buffer, __min(_array__6.byteOffset + 8, _array__6.buffer.byteLength)), _struct__6.Scope_id = _view__6.getUint32(24, true), _struct__6));
			_struct__7 = rsa, _view__7 = new DataView(_array__7.buffer, _array__7.byteOffset), _struct__7.Addr.Len = _view__7.getUint8(0, true), _struct__7.Addr.Family = _view__7.getUint8(1, true), _struct__7.Addr.Data = new (__nativeArray(__kindInt8))(_array__7.buffer, __min(_array__7.byteOffset + 2, _array__7.buffer.byteLength)), _struct__7.Pad = new (__nativeArray(__kindInt8))(_array__7.buffer, __min(_array__7.byteOffset + 16, _array__7.buffer.byteLength));
			sa__3 = new SockaddrInet6.ptr(0, 0, arrayType.zero(), new RawSockaddrInet6.ptr(0, 0, 0, 0, arrayType.zero(), 0));
			p__1 = (((pp__3.__ptr_Port  or  (pp__3.__ptr_Port = new ptrType__16(function() return this.__target.Port; end, function(v) this.__target.Port = __v; end, pp__3)))));
			sa__3.Port = ((((p__1.nilCheck, p__1[0]) >> 0)) << 8 >> 0) + (((p__1.nilCheck, p__1[1]) >> 0)) >> 0;
			sa__3.ZoneId = pp__3.Scope_id;
			i__3 = 0;
			while (true) {
				if ( not (i__3 < 16)) { break; end
				(x__6 = sa__3.Addr, ((i__3 < 0  or  i__3 >= x__6.length) ? (__throwRuntimeError("index out of range"), nil) : x__6[i__3] = (x__5 = pp__3.Addr, ((i__3 < 0  or  i__3 >= x__5.length) ? (__throwRuntimeError("index out of range"), nil) : x__5[i__3]))));
				i__3 = i__3 + (1) >> 0;
			end
			return [sa__3, __ifaceNil];
		end
		return [__ifaceNil, new Errno(47)];
	end;
	Accept = function(d)
		var _tmp, _tmp__1, _tmp__2, _tuple, _tuple__1, err, fd, len, len__24ptr, nfd, rsa, sa;
		nfd = 0;
		sa = __ifaceNil;
		err = __ifaceNil;
		rsa = new RawSockaddrAny.ptr(new RawSockaddr.ptr(0, 0, arrayType__4.zero()), arrayType__5.zero());
		len = 108;
		_tuple = accept(fd, rsa, (len__24ptr  or  (len__24ptr = new ptrType__17(function() return len; end, function(v) len = __v; end))));
		nfd = _tuple[0];
		err = _tuple[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			return [nfd, sa, err];
		end
		if (true  and  (len == 0)) {
			Close(nfd);
			_tmp = 0;
			_tmp__1 = __ifaceNil;
			_tmp__2 = new Errno(53);
			nfd = _tmp;
			sa = _tmp__1;
			err = _tmp__2;
			return [nfd, sa, err];
		end
		_tuple__1 = anyToSockaddr(rsa);
		sa = _tuple__1[0];
		err = _tuple__1[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			Close(nfd);
			nfd = 0;
		end
		return [nfd, sa, err];
	end;
	__pkg.Accept = Accept;
	Recvmsg = function(s)
		var _array, _struct, _tuple, _tuple__1, _view, dummy, dummy__24ptr, err, fd, flags, from, iov, msg, n, oob, oobn, p, recvflags, rsa;
		n = 0;
		oobn = 0;
		recvflags = 0;
		from = __ifaceNil;
		err = __ifaceNil;
		msg = new Msghdr.ptr(ptrType__2.nil, 0, arrayType__1.zero(), ptrType__18.nil, 0, arrayType__1.zero(), ptrType__2.nil, 0, 0);
		rsa = new RawSockaddrAny.ptr(new RawSockaddr.ptr(0, 0, arrayType__4.zero()), arrayType__5.zero());
		_array = new Uint8Array(108);
		msg.Name = ((_array));
		_struct = rsa, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Addr.Len = _view.getUint8(0, true), _struct.Addr.Family = _view.getUint8(1, true), _struct.Addr.Data = new (__nativeArray(__kindInt8))(_array.buffer, __min(_array.byteOffset + 2, _array.buffer.byteLength)), _struct.Pad = new (__nativeArray(__kindInt8))(_array.buffer, __min(_array.byteOffset + 16, _array.buffer.byteLength));
		msg.Namelen = 108;
		iov = new Iovec.ptr(ptrType__2.nil, new __Uint64(0, 0));
		if (p.__length > 0) {
			iov.Base = ((__sliceToArray(p)));
			iov.SetLen(p.__length);
		end
		dummy = 0;
		if (oob.__length > 0) {
			if (p.__length == 0) {
				iov.Base = (dummy__24ptr  or  (dummy__24ptr = new ptrType__2(function() return dummy; end, function(v) dummy = __v; end)));
				iov.SetLen(1);
			end
			msg.Control = ((__sliceToArray(oob)));
			msg.SetControllen(oob.__length);
		end
		msg.Iov = iov;
		msg.Iovlen = 1;
		_tuple = recvmsg(fd, msg, flags);
		n = _tuple[0];
		err = _tuple[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			return [n, oobn, recvflags, from, err];
		end
		oobn = ((msg.Controllen >> 0));
		recvflags = ((msg.Flags >> 0));
		if ( not ((rsa.Addr.Family == 0))) {
			_tuple__1 = anyToSockaddr(rsa);
			from = _tuple__1[0];
			err = _tuple__1[1];
		end
		return [n, oobn, recvflags, from, err];
	end;
	__pkg.Recvmsg = Recvmsg;
	SendmsgN = function(s)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tuple, _tuple__1, dummy, err, fd, flags, iov, msg, n, oob, p, ptr, salen, to, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tmp__4 = __f._tmp__4; _tmp__5 = __f._tmp__5; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; dummy = __f.dummy; err = __f.err; fd = __f.fd; flags = __f.flags; iov = __f.iov; msg = __f.msg; n = __f.n; oob = __f.oob; p = __f.p; ptr = __f.ptr; salen = __f.salen; to = __f.to; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		dummy = [dummy];
		iov = [iov];
		msg = [msg];
		n = 0;
		err = __ifaceNil;
		ptr = 0;
		salen = 0;
		/* */ if ( not (__interfaceIsEqual(to, __ifaceNil))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not (__interfaceIsEqual(to, __ifaceNil))) { */ case 1:
			_r = to.sockaddr(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_tuple = _r;
			ptr = _tuple[0];
			salen = _tuple[1];
			err = _tuple[2];
			if ( not (__interfaceIsEqual(err, __ifaceNil))) {
				_tmp = 0;
				_tmp__1 = err;
				n = _tmp;
				err = _tmp__1;
				__s = -1; return [n, err];
			end
		/* end */ case 2:
		msg[0] = new Msghdr.ptr(ptrType__2.nil, 0, arrayType__1.zero(), ptrType__18.nil, 0, arrayType__1.zero(), ptrType__2.nil, 0, 0);
		msg[0].Name = ((ptr));
		msg[0].Namelen = ((salen >>> 0));
		iov[0] = new Iovec.ptr(ptrType__2.nil, new __Uint64(0, 0));
		if (p.__length > 0) {
			iov[0].Base = ((__sliceToArray(p)));
			iov[0].SetLen(p.__length);
		end
		dummy[0] = 0;
		if (oob.__length > 0) {
			if (p.__length == 0) {
				iov[0].Base = (dummy.__ptr  or  (dummy.__ptr = new ptrType__2(function() return this.__target[0]; end, function(v) this.__target[0] = __v; end, dummy)));
				iov[0].SetLen(1);
			end
			msg[0].Control = ((__sliceToArray(oob)));
			msg[0].SetControllen(oob.__length);
		end
		msg[0].Iov = iov[0];
		msg[0].Iovlen = 1;
		_tuple__1 = sendmsg(fd, msg[0], flags);
		n = _tuple__1[0];
		err = _tuple__1[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			_tmp__2 = 0;
			_tmp__3 = err;
			n = _tmp__2;
			err = _tmp__3;
			__s = -1; return [n, err];
		end
		if (oob.__length > 0  and  (p.__length == 0)) {
			n = 0;
		end
		_tmp__4 = n;
		_tmp__5 = __ifaceNil;
		n = _tmp__4;
		err = _tmp__5;
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: SendmsgN end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tmp__4 = _tmp__4; __f._tmp__5 = _tmp__5; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f.dummy = dummy; __f.err = err; __f.fd = fd; __f.flags = flags; __f.iov = iov; __f.msg = msg; __f.n = n; __f.oob = oob; __f.p = p; __f.ptr = ptr; __f.salen = salen; __f.to = to; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.SendmsgN = SendmsgN;
	direntIno = function(f)
		var buf;
		return readInt(buf, 0, 8);
	end;
	direntReclen = function(f)
		var buf;
		return readInt(buf, 16, 2);
	end;
	direntNamlen = function(f)
		var buf;
		return readInt(buf, 18, 2);
	end;
	Iovec.ptr.prototype.SetLen = function(h)
		var iov, length;
		iov = this;
		iov.Len = (new __Uint64(0, length));
	end;
	Iovec.prototype.SetLen = function(h) return this.__val.SetLen(length); end;
	Msghdr.ptr.prototype.SetControllen = function(h)
		var length, msghdr;
		msghdr = this;
		msghdr.Controllen = ((length >>> 0));
	end;
	Msghdr.prototype.SetControllen = function(h) return this.__val.SetControllen(length); end;
	mmapper.ptr.prototype.Mmap = function(s)
		var _key, _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tuple, addr, b, data, err, errno, fd, flags, length, m, offset, p, prot, sl, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _key = __f._key; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tmp__4 = __f._tmp__4; _tmp__5 = __f._tmp__5; _tuple = __f._tuple; addr = __f.addr; b = __f.b; data = __f.data; err = __f.err; errno = __f.errno; fd = __f.fd; flags = __f.flags; length = __f.length; m = __f.m; offset = __f.offset; p = __f.p; prot = __f.prot; sl = __f.sl; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		sl = [sl];
		data = sliceType.nil;
		err = __ifaceNil;
		m = this;
		if (length <= 0) {
			_tmp = sliceType.nil;
			_tmp__1 = new Errno(22);
			data = _tmp;
			err = _tmp__1;
			__s = -1; return [data, err];
		end
		_r = m.mmap(0, ((length >>> 0)), prot, flags, fd, offset); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		addr = _tuple[0];
		errno = _tuple[1];
		if ( not (__interfaceIsEqual(errno, __ifaceNil))) {
			_tmp__2 = sliceType.nil;
			_tmp__3 = errno;
			data = _tmp__2;
			err = _tmp__3;
			__s = -1; return [data, err];
		end
		sl[0] = new structType.ptr(addr, length, length);
		b = sl[0];
		p = __indexPtr(b.__array, b.__offset + (b.__capacity - 1 >> 0), ptrType__2);
		__r = m.Mutex.Lock(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__deferred.push([__methodVal(m.Mutex, "Unlock"), []]);
		_key = p; (m.active  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__2.keyFor(_key)] = { k: _key, v: b end;
		_tmp__4 = b;
		_tmp__5 = __ifaceNil;
		data = _tmp__4;
		err = _tmp__5;
		__s = -1; return [data, err];
		/* */ end return; end end catch(err) { __err = err; __s = -1; end finally { __callDeferred(__deferred, __err); if ( not __curGoroutine.asleep) then return  [data, err]; end if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: mmapper.ptr.prototype.Mmap end; end __f._key = _key; __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tmp__4 = _tmp__4; __f._tmp__5 = _tmp__5; __f._tuple = _tuple; __f.addr = addr; __f.b = b; __f.data = data; __f.err = err; __f.errno = errno; __f.fd = fd; __f.flags = flags; __f.length = length; __f.m = m; __f.offset = offset; __f.p = p; __f.prot = prot; __f.sl = sl; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	mmapper.prototype.Mmap = function(s) return this.__val.Mmap(fd, offset, length, prot, flags); end;
	mmapper.ptr.prototype.Munmap = function(a)
		var _entry, _r, b, data, err, errno, m, p, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _r = __f._r; b = __f.b; data = __f.data; err = __f.err; errno = __f.errno; m = __f.m; p = __f.p; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		err = __ifaceNil;
		m = this;
		if ((data.__length == 0)  or   not ((data.__length == data.__capacity))) {
			err = new Errno(22);
			__s = -1; return err;
		end
		p = __indexPtr(data.__array, data.__offset + (data.__capacity - 1 >> 0), ptrType__2);
		__r = m.Mutex.Lock(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__deferred.push([__methodVal(m.Mutex, "Unlock"), []]);
		b = (_entry = m.active[ptrType__2.keyFor(p)], _entry ~= nil ? _entry.v : sliceType.nil);
		if (b == sliceType.nil  or   not (__indexPtr(b.__array, b.__offset + 0, ptrType__2) == __indexPtr(data.__array, data.__offset + 0, ptrType__2))) {
			err = new Errno(22);
			__s = -1; return err;
		end
		_r = m.munmap(((__sliceToArray(b))), ((b.__length >>> 0))); /* */ __s = 2; case 2: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		errno = _r;
		if ( not (__interfaceIsEqual(errno, __ifaceNil))) {
			err = errno;
			__s = -1; return err;
		end
		delete m.active[ptrType__2.keyFor(p)];
		err = __ifaceNil;
		__s = -1; return err;
		/* */ end return; end end catch(err) { __err = err; __s = -1; end finally { __callDeferred(__deferred, __err); if ( not __curGoroutine.asleep) then return  err; end if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: mmapper.ptr.prototype.Munmap end; end __f._entry = _entry; __f._r = _r; __f.b = b; __f.data = data; __f.err = err; __f.errno = errno; __f.m = m; __f.p = p; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	mmapper.prototype.Munmap = function(a) return this.__val.Munmap(data); end;
	Errno.prototype.Error = function()
		var e, s;
		e = this.__val;
		if (0 <= ((e >> 0))  and  ((e >> 0)) < 106) {
			s = ((e < 0  or  e >= errors__1.length) ? (__throwRuntimeError("index out of range"), nil) : errors__1[e]);
			if ( not (s == "")) {
				return s;
			end
		end
		return "errno " + itoa(((e >> 0)));
	end;
	__ptrType(Errno).prototype.Error = function() return new Errno(this.__get()).Error(); end;
	Errno.prototype.Temporary = function()
		var e;
		e = this.__val;
		return (e == 4)  or  (e == 24)  or  (e == 54)  or  (e == 53)  or  new Errno(e).Timeout();
	end;
	__ptrType(Errno).prototype.Temporary = function() return new Errno(this.__get()).Temporary(); end;
	Errno.prototype.Timeout = function()
		var e;
		e = this.__val;
		return (e == 35)  or  (e == 35)  or  (e == 60);
	end;
	__ptrType(Errno).prototype.Timeout = function() return new Errno(this.__get()).Timeout(); end;
	errnoErr = function(e)
		var _1, e;
		_1 = e;
		if (_1 == (0)) {
			return __ifaceNil;
		end else if (_1 == (35)) {
			return errEAGAIN;
		end else if (_1 == (22)) {
			return errEINVAL;
		end else if (_1 == (2)) {
			return errENOENT;
		end
		return new Errno(e);
	end;
	Read = function(p)
		var _tuple, err, fd, n, p;
		n = 0;
		err = __ifaceNil;
		_tuple = read(fd, p);
		n = _tuple[0];
		err = _tuple[1];
		if (false) {
			if (n > 0) {
				race.WriteRange((__sliceToArray(p)), n);
			end
			if (__interfaceIsEqual(err, __ifaceNil)) {
				race.Acquire(((ioSync__24ptr  or  (ioSync__24ptr = new ptrType__20(function() return ioSync; end, function(v) ioSync = __v; end)))));
			end
		end
		if (false  and  n > 0) {
			msanWrite((__sliceToArray(p)), n);
		end
		return [n, err];
	end;
	__pkg.Read = Read;
	Write = function(p)
		var _tuple, err, fd, n, p;
		n = 0;
		err = __ifaceNil;
		if (false) {
			race.ReleaseMerge(((ioSync__24ptr  or  (ioSync__24ptr = new ptrType__20(function() return ioSync; end, function(v) ioSync = __v; end)))));
		end
		_tuple = write(fd, p);
		n = _tuple[0];
		err = _tuple[1];
		if (false  and  n > 0) {
			race.ReadRange((__sliceToArray(p)), n);
		end
		if (false  and  n > 0) {
			msanRead((__sliceToArray(p)), n);
		end
		return [n, err];
	end;
	__pkg.Write = Write;
	Recvfrom = function(s)
		var _tuple, _tuple__1, err, fd, flags, from, len, len__24ptr, n, p, rsa;
		n = 0;
		from = __ifaceNil;
		err = __ifaceNil;
		rsa = new RawSockaddrAny.ptr(new RawSockaddr.ptr(0, 0, arrayType__4.zero()), arrayType__5.zero());
		len = 108;
		_tuple = recvfrom(fd, p, flags, rsa, (len__24ptr  or  (len__24ptr = new ptrType__17(function() return len; end, function(v) len = __v; end))));
		n = _tuple[0];
		err = _tuple[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			return [n, from, err];
		end
		if ( not ((rsa.Addr.Family == 0))) {
			_tuple__1 = anyToSockaddr(rsa);
			from = _tuple__1[0];
			err = _tuple__1[1];
		end
		return [n, from, err];
	end;
	__pkg.Recvfrom = Recvfrom;
	Sendto = function(o)
		var _r, _tuple, err, fd, flags, n, p, ptr, to, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; err = __f.err; fd = __f.fd; flags = __f.flags; n = __f.n; p = __f.p; ptr = __f.ptr; to = __f.to; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		err = __ifaceNil;
		_r = to.sockaddr(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		ptr = _tuple[0];
		n = _tuple[1];
		err = _tuple[2];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			err = err;
			__s = -1; return err;
		end
		err = sendto(fd, p, flags, ptr, n);
		__s = -1; return err;
		/* */ end return; end if __f == nil then  __f = { __blk: Sendto end; end __f._r = _r; __f._tuple = _tuple; __f.err = err; __f.fd = fd; __f.flags = flags; __f.n = n; __f.p = p; __f.ptr = ptr; __f.to = to; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.Sendto = Sendto;
	SetsockoptByte = function(e)
		var err, fd, level, opt, value, value__24ptr;
		err = __ifaceNil;
		err = setsockopt(fd, level, opt, ((value__24ptr  or  (value__24ptr = new ptrType__2(function() return value; end, function(v) value = __v; end)))), 1);
		return err;
	end;
	__pkg.SetsockoptByte = SetsockoptByte;
	SetsockoptInt = function(e)
		var err, fd, level, n, n__24ptr, opt, value;
		err = __ifaceNil;
		n = ((value >> 0));
		err = setsockopt(fd, level, opt, ((n__24ptr  or  (n__24ptr = new ptrType__21(function() return n; end, function(v) n = __v; end)))), 4);
		return err;
	end;
	__pkg.SetsockoptInt = SetsockoptInt;
	SetsockoptInet4Addr = function(e)
		var err, fd, level, opt, value;
		err = __ifaceNil;
		err = setsockopt(fd, level, opt, (__sliceToArray(new sliceType(value))), 4);
		return err;
	end;
	__pkg.SetsockoptInet4Addr = SetsockoptInet4Addr;
	SetsockoptIPMreq = function(q)
		var _array, _struct, _view, err, fd, level, mreq, opt;
		err = __ifaceNil;
		_array = new Uint8Array(8);
		err = setsockopt(fd, level, opt, (_array), 8);
		_struct = mreq, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Multiaddr = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 0, _array.buffer.byteLength)), _struct.Interface = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 4, _array.buffer.byteLength));
		return err;
	end;
	__pkg.SetsockoptIPMreq = SetsockoptIPMreq;
	SetsockoptIPv6Mreq = function(q)
		var _array, _struct, _view, err, fd, level, mreq, opt;
		err = __ifaceNil;
		_array = new Uint8Array(20);
		err = setsockopt(fd, level, opt, (_array), 20);
		_struct = mreq, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Multiaddr = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 0, _array.buffer.byteLength)), _struct.Interface = _view.getUint32(16, true);
		return err;
	end;
	__pkg.SetsockoptIPv6Mreq = SetsockoptIPv6Mreq;
	SetsockoptLinger = function(l)
		var _array, _struct, _view, err, fd, l, level, opt;
		err = __ifaceNil;
		_array = new Uint8Array(8);
		err = setsockopt(fd, level, opt, (_array), 8);
		_struct = l, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Onoff = _view.getInt32(0, true), _struct.Linger = _view.getInt32(4, true);
		return err;
	end;
	__pkg.SetsockoptLinger = SetsockoptLinger;
	accept = function(n)
		var _array, _struct, _tuple, _view, addrlen, e1, err, fd, r0, rsa, s;
		fd = 0;
		err = __ifaceNil;
		_array = new Uint8Array(108);
		_tuple = Syscall(30, ((s >>> 0)), ((_array)), ((addrlen)));
		_struct = rsa, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Addr.Len = _view.getUint8(0, true), _struct.Addr.Family = _view.getUint8(1, true), _struct.Addr.Data = new (__nativeArray(__kindInt8))(_array.buffer, __min(_array.byteOffset + 2, _array.buffer.byteLength)), _struct.Pad = new (__nativeArray(__kindInt8))(_array.buffer, __min(_array.byteOffset + 16, _array.buffer.byteLength));
		r0 = _tuple[0];
		e1 = _tuple[2];
		fd = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [fd, err];
	end;
	setsockopt = function(n)
		var _tuple, e1, err, level, name, s, val, vallen;
		err = __ifaceNil;
		_tuple = Syscall6(105, ((s >>> 0)), ((level >>> 0)), ((name >>> 0)), (val), (vallen), 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	Shutdown = function(w)
		var _tuple, e1, err, how, s;
		err = __ifaceNil;
		_tuple = Syscall(134, ((s >>> 0)), ((how >>> 0)), 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Shutdown = Shutdown;
	recvfrom = function(n)
		var _array, _p0, _struct, _tuple, _view, e1, err, fd, flags, from, fromlen, n, p, r0;
		n = 0;
		err = __ifaceNil;
		_p0 = 0;
		if (p.__length > 0) {
			_p0 = (__sliceToArray(p));
		end else {
			_p0 = (new Uint8Array(0));
		end
		_array = new Uint8Array(108);
		_tuple = Syscall6(29, ((fd >>> 0)), (_p0), ((p.__length >>> 0)), ((flags >>> 0)), ((_array)), ((fromlen)));
		_struct = from, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Addr.Len = _view.getUint8(0, true), _struct.Addr.Family = _view.getUint8(1, true), _struct.Addr.Data = new (__nativeArray(__kindInt8))(_array.buffer, __min(_array.byteOffset + 2, _array.buffer.byteLength)), _struct.Pad = new (__nativeArray(__kindInt8))(_array.buffer, __min(_array.byteOffset + 16, _array.buffer.byteLength));
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	sendto = function(n)
		var _p0, _tuple, addrlen, buf, e1, err, flags, s, to;
		err = __ifaceNil;
		_p0 = 0;
		if (buf.__length > 0) {
			_p0 = (__sliceToArray(buf));
		end else {
			_p0 = (new Uint8Array(0));
		end
		_tuple = Syscall6(133, ((s >>> 0)), (_p0), ((buf.__length >>> 0)), ((flags >>> 0)), (to), ((addrlen >>> 0)));
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	recvmsg = function(s)
		var _array, _struct, _tuple, _view, e1, err, flags, msg, n, r0, s;
		n = 0;
		err = __ifaceNil;
		_array = new Uint8Array(36);
		_tuple = Syscall(27, ((s >>> 0)), ((_array)), ((flags >>> 0)));
		_struct = msg, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Namelen = _view.getUint32(4, true), _struct.Pad_cgo_0 = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 8, _array.buffer.byteLength)), _struct.Iovlen = _view.getInt32(16, true), _struct.Pad_cgo_1 = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 20, _array.buffer.byteLength)), _struct.Controllen = _view.getUint32(28, true), _struct.Flags = _view.getInt32(32, true);
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	sendmsg = function(s)
		var _array, _struct, _tuple, _view, e1, err, flags, msg, n, r0, s;
		n = 0;
		err = __ifaceNil;
		_array = new Uint8Array(36);
		_tuple = Syscall(28, ((s >>> 0)), ((_array)), ((flags >>> 0)));
		_struct = msg, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Namelen = _view.getUint32(4, true), _struct.Pad_cgo_0 = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 8, _array.buffer.byteLength)), _struct.Iovlen = _view.getInt32(16, true), _struct.Pad_cgo_1 = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 20, _array.buffer.byteLength)), _struct.Controllen = _view.getUint32(28, true), _struct.Flags = _view.getInt32(32, true);
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	fcntl = function(g)
		var _tuple, arg, cmd, e1, err, fd, r0, val;
		val = 0;
		err = __ifaceNil;
		_tuple = Syscall(92, ((fd >>> 0)), ((cmd >>> 0)), ((arg >>> 0)));
		r0 = _tuple[0];
		e1 = _tuple[2];
		val = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [val, err];
	end;
	Close = function(d)
		var _tuple, e1, err, fd;
		err = __ifaceNil;
		_tuple = Syscall(6, ((fd >>> 0)), 0, 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Close = Close;
	Fchdir = function(d)
		var _tuple, e1, err, fd;
		err = __ifaceNil;
		_tuple = Syscall(13, ((fd >>> 0)), 0, 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Fchdir = Fchdir;
	Fchmod = function(e)
		var _tuple, e1, err, fd, mode;
		err = __ifaceNil;
		_tuple = Syscall(124, ((fd >>> 0)), ((mode >>> 0)), 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Fchmod = Fchmod;
	Fchown = function(d)
		var _tuple, e1, err, fd, gid, uid;
		err = __ifaceNil;
		_tuple = Syscall(123, ((fd >>> 0)), ((uid >>> 0)), ((gid >>> 0)));
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Fchown = Fchown;
	Fstat = function(t)
		var _array, _struct, _tuple, _view, e1, err, fd, stat;
		err = __ifaceNil;
		_array = new Uint8Array(144);
		_tuple = Syscall(339, ((fd >>> 0)), ((_array)), 0);
		_struct = stat, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Dev = _view.getInt32(0, true), _struct.Mode = _view.getUint16(4, true), _struct.Nlink = _view.getUint16(6, true), _struct.Ino = new __Uint64(_view.getUint32(12, true), _view.getUint32(8, true)), _struct.Uid = _view.getUint32(16, true), _struct.Gid = _view.getUint32(20, true), _struct.Rdev = _view.getInt32(24, true), _struct.Pad_cgo_0 = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 28, _array.buffer.byteLength)), _struct.Atimespec.Sec = new __Int64(_view.getUint32(36, true), _view.getUint32(32, true)), _struct.Atimespec.Nsec = new __Int64(_view.getUint32(44, true), _view.getUint32(40, true)), _struct.Mtimespec.Sec = new __Int64(_view.getUint32(52, true), _view.getUint32(48, true)), _struct.Mtimespec.Nsec = new __Int64(_view.getUint32(60, true), _view.getUint32(56, true)), _struct.Ctimespec.Sec = new __Int64(_view.getUint32(68, true), _view.getUint32(64, true)), _struct.Ctimespec.Nsec = new __Int64(_view.getUint32(76, true), _view.getUint32(72, true)), _struct.Birthtimespec.Sec = new __Int64(_view.getUint32(84, true), _view.getUint32(80, true)), _struct.Birthtimespec.Nsec = new __Int64(_view.getUint32(92, true), _view.getUint32(88, true)), _struct.Size = new __Int64(_view.getUint32(100, true), _view.getUint32(96, true)), _struct.Blocks = new __Int64(_view.getUint32(108, true), _view.getUint32(104, true)), _struct.Blksize = _view.getInt32(112, true), _struct.Flags = _view.getUint32(116, true), _struct.Gen = _view.getUint32(120, true), _struct.Lspare = _view.getInt32(124, true), _struct.Qspare = new (__nativeArray(__kindInt64))(_array.buffer, __min(_array.byteOffset + 128, _array.buffer.byteLength));
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Fstat = Fstat;
	Fsync = function(d)
		var _tuple, e1, err, fd;
		err = __ifaceNil;
		_tuple = Syscall(95, ((fd >>> 0)), 0, 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Fsync = Fsync;
	Ftruncate = function(h)
		var _tuple, e1, err, fd, length;
		err = __ifaceNil;
		_tuple = Syscall(201, ((fd >>> 0)), ((length.__low >>> 0)), 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Ftruncate = Ftruncate;
	Getdirentries = function(p)
		var _p0, _tuple, basep, buf, e1, err, fd, n, r0;
		n = 0;
		err = __ifaceNil;
		_p0 = 0;
		if (buf.__length > 0) {
			_p0 = (__sliceToArray(buf));
		end else {
			_p0 = (new Uint8Array(0));
		end
		_tuple = Syscall6(344, ((fd >>> 0)), (_p0), ((buf.__length >>> 0)), ((basep)), 0, 0);
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	__pkg.Getdirentries = Getdirentries;
	Lstat = function(t)
		var _array, _p0, _struct, _tuple, _tuple__1, _view, e1, err, path, stat;
		err = __ifaceNil;
		_p0 = ptrType__2.nil;
		_tuple = BytePtrFromString(path);
		_p0 = _tuple[0];
		err = _tuple[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			return err;
		end
		_array = new Uint8Array(144);
		_tuple__1 = Syscall(340, ((_p0)), ((_array)), 0);
		_struct = stat, _view = new DataView(_array.buffer, _array.byteOffset), _struct.Dev = _view.getInt32(0, true), _struct.Mode = _view.getUint16(4, true), _struct.Nlink = _view.getUint16(6, true), _struct.Ino = new __Uint64(_view.getUint32(12, true), _view.getUint32(8, true)), _struct.Uid = _view.getUint32(16, true), _struct.Gid = _view.getUint32(20, true), _struct.Rdev = _view.getInt32(24, true), _struct.Pad_cgo_0 = new (__nativeArray(__kindUint8))(_array.buffer, __min(_array.byteOffset + 28, _array.buffer.byteLength)), _struct.Atimespec.Sec = new __Int64(_view.getUint32(36, true), _view.getUint32(32, true)), _struct.Atimespec.Nsec = new __Int64(_view.getUint32(44, true), _view.getUint32(40, true)), _struct.Mtimespec.Sec = new __Int64(_view.getUint32(52, true), _view.getUint32(48, true)), _struct.Mtimespec.Nsec = new __Int64(_view.getUint32(60, true), _view.getUint32(56, true)), _struct.Ctimespec.Sec = new __Int64(_view.getUint32(68, true), _view.getUint32(64, true)), _struct.Ctimespec.Nsec = new __Int64(_view.getUint32(76, true), _view.getUint32(72, true)), _struct.Birthtimespec.Sec = new __Int64(_view.getUint32(84, true), _view.getUint32(80, true)), _struct.Birthtimespec.Nsec = new __Int64(_view.getUint32(92, true), _view.getUint32(88, true)), _struct.Size = new __Int64(_view.getUint32(100, true), _view.getUint32(96, true)), _struct.Blocks = new __Int64(_view.getUint32(108, true), _view.getUint32(104, true)), _struct.Blksize = _view.getInt32(112, true), _struct.Flags = _view.getUint32(116, true), _struct.Gen = _view.getUint32(120, true), _struct.Lspare = _view.getInt32(124, true), _struct.Qspare = new (__nativeArray(__kindInt64))(_array.buffer, __min(_array.byteOffset + 128, _array.buffer.byteLength));
		e1 = _tuple__1[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	__pkg.Lstat = Lstat;
	Pread = function(t)
		var _p0, _tuple, e1, err, fd, n, offset, p, r0;
		n = 0;
		err = __ifaceNil;
		_p0 = 0;
		if (p.__length > 0) {
			_p0 = (__sliceToArray(p));
		end else {
			_p0 = (new Uint8Array(0));
		end
		_tuple = Syscall6(153, ((fd >>> 0)), (_p0), ((p.__length >>> 0)), ((offset.__low >>> 0)), 0, 0);
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	__pkg.Pread = Pread;
	Pwrite = function(t)
		var _p0, _tuple, e1, err, fd, n, offset, p, r0;
		n = 0;
		err = __ifaceNil;
		_p0 = 0;
		if (p.__length > 0) {
			_p0 = (__sliceToArray(p));
		end else {
			_p0 = (new Uint8Array(0));
		end
		_tuple = Syscall6(154, ((fd >>> 0)), (_p0), ((p.__length >>> 0)), ((offset.__low >>> 0)), 0, 0);
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	__pkg.Pwrite = Pwrite;
	read = function(p)
		var _p0, _tuple, e1, err, fd, n, p, r0;
		n = 0;
		err = __ifaceNil;
		_p0 = 0;
		if (p.__length > 0) {
			_p0 = (__sliceToArray(p));
		end else {
			_p0 = (new Uint8Array(0));
		end
		_tuple = Syscall(3, ((fd >>> 0)), (_p0), ((p.__length >>> 0)));
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	Seek = function(e)
		var _tuple, e1, err, fd, newoffset, offset, r0, whence;
		newoffset = new __Int64(0, 0);
		err = __ifaceNil;
		_tuple = Syscall(199, ((fd >>> 0)), ((offset.__low >>> 0)), ((whence >>> 0)));
		r0 = _tuple[0];
		e1 = _tuple[2];
		newoffset = (new __Int64(0, r0.constructor == Number ? r0 : 1));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [newoffset, err];
	end;
	__pkg.Seek = Seek;
	write = function(p)
		var _p0, _tuple, e1, err, fd, n, p, r0;
		n = 0;
		err = __ifaceNil;
		_p0 = 0;
		if (p.__length > 0) {
			_p0 = (__sliceToArray(p));
		end else {
			_p0 = (new Uint8Array(0));
		end
		_tuple = Syscall(4, ((fd >>> 0)), (_p0), ((p.__length >>> 0)));
		r0 = _tuple[0];
		e1 = _tuple[2];
		n = ((r0 >> 0));
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [n, err];
	end;
	mmap = function(s)
		var _tuple, addr, e1, err, fd, flag, length, pos, prot, r0, ret;
		ret = 0;
		err = __ifaceNil;
		_tuple = Syscall6(197, (addr), (length), ((prot >>> 0)), ((flag >>> 0)), ((fd >>> 0)), ((pos.__low >>> 0)));
		r0 = _tuple[0];
		e1 = _tuple[2];
		ret = (r0);
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return [ret, err];
	end;
	munmap = function(h)
		var _tuple, addr, e1, err, length;
		err = __ifaceNil;
		_tuple = Syscall(73, (addr), (length), 0);
		e1 = _tuple[2];
		if ( not ((e1 == 0))) {
			err = errnoErr(e1);
		end
		return err;
	end;
	ptrType__11.methods = [{prop: "sockaddr", name: "sockaddr", pkg: "syscall", typ: __funcType([], [__UnsafePointer, _Socklen, __error], false)end];
	ptrType__27.methods = [{prop: "Mmap", name: "Mmap", pkg: "", typ: __funcType([__Int, __Int64, __Int, __Int, __Int], [sliceType, __error], false)end, {prop: "Munmap", name: "Munmap", pkg: "", typ: __funcType([sliceType], [__error], false)end];
	Errno.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Temporary", name: "Temporary", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Timeout", name: "Timeout", pkg: "", typ: __funcType([], [__Bool], false)end];
	ptrType__28.methods = [{prop: "sockaddr", name: "sockaddr", pkg: "syscall", typ: __funcType([], [__UnsafePointer, _Socklen, __error], false)end];
	ptrType__29.methods = [{prop: "sockaddr", name: "sockaddr", pkg: "syscall", typ: __funcType([], [__UnsafePointer, _Socklen, __error], false)end];
	ptrType__30.methods = [{prop: "sockaddr", name: "sockaddr", pkg: "syscall", typ: __funcType([], [__UnsafePointer, _Socklen, __error], false)end];
	ptrType__31.methods = [{prop: "Unix", name: "Unix", pkg: "", typ: __funcType([], [__Int64, __Int64], false)end, {prop: "Nano", name: "Nano", pkg: "", typ: __funcType([], [__Int64], false)end];
	ptrType__18.methods = [{prop: "SetLen", name: "SetLen", pkg: "", typ: __funcType([__Int], [], false)end];
	ptrType__32.methods = [{prop: "SetControllen", name: "SetControllen", pkg: "", typ: __funcType([__Int], [], false)end];
	SockaddrDatalink.init("syscall", [{prop: "Len", name: "Len", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Family", name: "Family", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Index", name: "Index", anonymous: false, exported: true, typ: __Uint16, tag: ""end, {prop: "Type", name: "Type", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Nlen", name: "Nlen", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Alen", name: "Alen", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Slen", name: "Slen", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Data", name: "Data", anonymous: false, exported: true, typ: arrayType__3, tag: ""end, {prop: "raw", name: "raw", anonymous: false, exported: false, typ: RawSockaddrDatalink, tag: ""end]);
	mmapper.init("syscall", [{prop: "Mutex", name: "Mutex", anonymous: true, exported: true, typ: sync.Mutex, tag: ""end, {prop: "active", name: "active", anonymous: false, exported: false, typ: mapType, tag: ""end, {prop: "mmap", name: "mmap", anonymous: false, exported: false, typ: funcType__2, tag: ""end, {prop: "munmap", name: "munmap", anonymous: false, exported: false, typ: funcType__3, tag: ""end]);
	Sockaddr.init([{prop: "sockaddr", name: "sockaddr", pkg: "syscall", typ: __funcType([], [__UnsafePointer, _Socklen, __error], false)end]);
	SockaddrInet4.init("syscall", [{prop: "Port", name: "Port", anonymous: false, exported: true, typ: __Int, tag: ""end, {prop: "Addr", name: "Addr", anonymous: false, exported: true, typ: arrayType__1, tag: ""end, {prop: "raw", name: "raw", anonymous: false, exported: false, typ: RawSockaddrInet4, tag: ""end]);
	SockaddrInet6.init("syscall", [{prop: "Port", name: "Port", anonymous: false, exported: true, typ: __Int, tag: ""end, {prop: "ZoneId", name: "ZoneId", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Addr", name: "Addr", anonymous: false, exported: true, typ: arrayType, tag: ""end, {prop: "raw", name: "raw", anonymous: false, exported: false, typ: RawSockaddrInet6, tag: ""end]);
	SockaddrUnix.init("syscall", [{prop: "Name", name: "Name", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "raw", name: "raw", anonymous: false, exported: false, typ: RawSockaddrUnix, tag: ""end]);
	Timespec.init("", [{prop: "Sec", name: "Sec", anonymous: false, exported: true, typ: __Int64, tag: ""end, {prop: "Nsec", name: "Nsec", anonymous: false, exported: true, typ: __Int64, tag: ""end]);
	Stat_t.init("", [{prop: "Dev", name: "Dev", anonymous: false, exported: true, typ: __Int32, tag: ""end, {prop: "Mode", name: "Mode", anonymous: false, exported: true, typ: __Uint16, tag: ""end, {prop: "Nlink", name: "Nlink", anonymous: false, exported: true, typ: __Uint16, tag: ""end, {prop: "Ino", name: "Ino", anonymous: false, exported: true, typ: __Uint64, tag: ""end, {prop: "Uid", name: "Uid", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Gid", name: "Gid", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Rdev", name: "Rdev", anonymous: false, exported: true, typ: __Int32, tag: ""end, {prop: "Pad_cgo_0", name: "Pad_cgo_0", anonymous: false, exported: true, typ: arrayType__1, tag: ""end, {prop: "Atimespec", name: "Atimespec", anonymous: false, exported: true, typ: Timespec, tag: ""end, {prop: "Mtimespec", name: "Mtimespec", anonymous: false, exported: true, typ: Timespec, tag: ""end, {prop: "Ctimespec", name: "Ctimespec", anonymous: false, exported: true, typ: Timespec, tag: ""end, {prop: "Birthtimespec", name: "Birthtimespec", anonymous: false, exported: true, typ: Timespec, tag: ""end, {prop: "Size", name: "Size", anonymous: false, exported: true, typ: __Int64, tag: ""end, {prop: "Blocks", name: "Blocks", anonymous: false, exported: true, typ: __Int64, tag: ""end, {prop: "Blksize", name: "Blksize", anonymous: false, exported: true, typ: __Int32, tag: ""end, {prop: "Flags", name: "Flags", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Gen", name: "Gen", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Lspare", name: "Lspare", anonymous: false, exported: true, typ: __Int32, tag: ""end, {prop: "Qspare", name: "Qspare", anonymous: false, exported: true, typ: arrayType__15, tag: ""end]);
	RawSockaddrInet4.init("", [{prop: "Len", name: "Len", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Family", name: "Family", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Port", name: "Port", anonymous: false, exported: true, typ: __Uint16, tag: ""end, {prop: "Addr", name: "Addr", anonymous: false, exported: true, typ: arrayType__1, tag: ""end, {prop: "Zero", name: "Zero", anonymous: false, exported: true, typ: arrayType__6, tag: ""end]);
	RawSockaddrInet6.init("", [{prop: "Len", name: "Len", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Family", name: "Family", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Port", name: "Port", anonymous: false, exported: true, typ: __Uint16, tag: ""end, {prop: "Flowinfo", name: "Flowinfo", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Addr", name: "Addr", anonymous: false, exported: true, typ: arrayType, tag: ""end, {prop: "Scope_id", name: "Scope_id", anonymous: false, exported: true, typ: __Uint32, tag: ""end]);
	RawSockaddrUnix.init("", [{prop: "Len", name: "Len", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Family", name: "Family", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Path", name: "Path", anonymous: false, exported: true, typ: arrayType__11, tag: ""end]);
	RawSockaddrDatalink.init("", [{prop: "Len", name: "Len", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Family", name: "Family", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Index", name: "Index", anonymous: false, exported: true, typ: __Uint16, tag: ""end, {prop: "Type", name: "Type", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Nlen", name: "Nlen", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Alen", name: "Alen", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Slen", name: "Slen", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Data", name: "Data", anonymous: false, exported: true, typ: arrayType__3, tag: ""end]);
	RawSockaddr.init("", [{prop: "Len", name: "Len", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Family", name: "Family", anonymous: false, exported: true, typ: __Uint8, tag: ""end, {prop: "Data", name: "Data", anonymous: false, exported: true, typ: arrayType__4, tag: ""end]);
	RawSockaddrAny.init("", [{prop: "Addr", name: "Addr", anonymous: false, exported: true, typ: RawSockaddr, tag: ""end, {prop: "Pad", name: "Pad", anonymous: false, exported: true, typ: arrayType__5, tag: ""end]);
	Linger.init("", [{prop: "Onoff", name: "Onoff", anonymous: false, exported: true, typ: __Int32, tag: ""end, {prop: "Linger", name: "Linger", anonymous: false, exported: true, typ: __Int32, tag: ""end]);
	Iovec.init("", [{prop: "Base", name: "Base", anonymous: false, exported: true, typ: ptrType__2, tag: ""end, {prop: "Len", name: "Len", anonymous: false, exported: true, typ: __Uint64, tag: ""end]);
	IPMreq.init("", [{prop: "Multiaddr", name: "Multiaddr", anonymous: false, exported: true, typ: arrayType__1, tag: ""end, {prop: "Interface", name: "Interface", anonymous: false, exported: true, typ: arrayType__1, tag: ""end]);
	IPv6Mreq.init("", [{prop: "Multiaddr", name: "Multiaddr", anonymous: false, exported: true, typ: arrayType, tag: ""end, {prop: "Interface", name: "Interface", anonymous: false, exported: true, typ: __Uint32, tag: ""end]);
	Msghdr.init("", [{prop: "Name", name: "Name", anonymous: false, exported: true, typ: ptrType__2, tag: ""end, {prop: "Namelen", name: "Namelen", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Pad_cgo_0", name: "Pad_cgo_0", anonymous: false, exported: true, typ: arrayType__1, tag: ""end, {prop: "Iov", name: "Iov", anonymous: false, exported: true, typ: ptrType__18, tag: ""end, {prop: "Iovlen", name: "Iovlen", anonymous: false, exported: true, typ: __Int32, tag: ""end, {prop: "Pad_cgo_1", name: "Pad_cgo_1", anonymous: false, exported: true, typ: arrayType__1, tag: ""end, {prop: "Control", name: "Control", anonymous: false, exported: true, typ: ptrType__2, tag: ""end, {prop: "Controllen", name: "Controllen", anonymous: false, exported: true, typ: __Uint32, tag: ""end, {prop: "Flags", name: "Flags", anonymous: false, exported: true, typ: __Int32, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = js.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = race.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = runtime.__init(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = sync.__init(); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		lineBuffer = sliceType.nil;
		syscallModule = null;
		freebsdConfArch = "";
		ioSync = new __Int64(0, 0);
		warningPrinted = false;
		alreadyTriedToLoad = false;
		minusOne = -1;
		envs = runtime_envs();
		__pkg.Stdin = 0;
		__pkg.Stdout = 1;
		__pkg.Stderr = 2;
		errEAGAIN = new Errno(35);
		errEINVAL = new Errno(22);
		errENOENT = new Errno(2);
		errors__1 = __toNativeArray(__kindString, ["", "operation not permitted", "no such file or directory", "no such process", "interrupted system call", "input/output error", "device not configured", "argument list too long", "exec format error", "bad file descriptor", "no child processes", "resource deadlock avoided", "cannot allocate memory", "permission denied", "bad address", "block device required", "resource busy", "file exists", "cross-device link", "operation not supported by device", "not a directory", "is a directory", "invalid argument", "too many open files in system", "too many open files", "inappropriate ioctl for device", "text file busy", "file too large", "no space left on device", "illegal seek", "read-only file system", "too many links", "broken pipe", "numerical argument out of domain", "result too large", "resource temporarily unavailable", "operation now in progress", "operation already in progress", "socket operation on non-socket", "destination address required", "message too long", "protocol wrong type for socket", "protocol not available", "protocol not supported", "socket type not supported", "operation not supported", "protocol family not supported", "address family not supported by protocol family", "address already in use", "can't assign requested address", "network is down", "network is unreachable", "network dropped connection on reset", "software caused connection abort", "connection reset by peer", "no buffer space available", "socket is already connected", "socket is not connected", "can't send after socket shutdown", "too many references: can't splice", "operation timed out", "connection refused", "too many levels of symbolic links", "file name too long", "host is down", "no route to host", "directory not empty", "too many processes", "too many users", "disc quota exceeded", "stale NFS file handle", "too many levels of remote in path", "RPC struct is bad", "RPC version wrong", "RPC prog. not avail", "program version wrong", "bad procedure for program", "no locks available", "function not implemented", "inappropriate file type or format", "authentication error", "need authenticator", "device power is off", "device error", "value too large to be stored in data type", "bad executable (or shared library)", "bad CPU type in executable", "shared library version mismatch", "malformed Mach-o file", "operation canceled", "identifier removed", "no message of desired type", "illegal byte sequence", "attribute not found", "bad message", "EMULTIHOP (Reserved)", "no message available on STREAM", "ENOLINK (Reserved)", "no STREAM resources", "not a STREAM", "protocol error", "STREAM ioctl timeout", "operation not supported on socket", "policy not found", "state not recoverable", "previous owner died"]);
		mapper = new mmapper.ptr(new sync.Mutex.ptr(0, 0), {}, mmap, munmap);
		minRoutingSockaddrLen = rsaAlignOf(0);
		init();
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["github.com/gopherjs/gopherjs/nosync"] = (function()
	var __pkg = {}, __init, Once, funcType__1, ptrType__4;
	Once = __pkg.Once = __newType(0, __kindStruct, "nosync.Once", true, "github.com/gopherjs/gopherjs/nosync", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.doing = false;
			this.done = false;
			return;
		end
		this.doing = doing_;
		this.done = done_;
	end);
	funcType__1 = __funcType([], [], false);
	ptrType__4 = __ptrType(Once);
	Once.ptr.prototype.Do = function(f)
		var f, o, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; f = __f.f; o = __f.o; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		o = [o];
		o[0] = this;
		if (o[0].done) {
			__s = -1; return;
		end
		if (o[0].doing) {
			__panic(new __String("nosync: Do called within f"));
		end
		o[0].doing = true;
		__deferred.push([(function(o) return function()
			o[0].doing = false;
			o[0].done = true;
		end; end)(o), []]);
		__r = f(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__s = -1; return;
		/* */ end return; end end catch(err) { __err = err; __s = -1; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: Once.ptr.prototype.Do end; end __f.f = f; __f.o = o; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	Once.prototype.Do = function(f) return this.__val.Do(f); end;
	ptrType__4.methods = [{prop: "Do", name: "Do", pkg: "", typ: __funcType([funcType__1], [], false)end];
	Once.init("github.com/gopherjs/gopherjs/nosync", [{prop: "doing", name: "doing", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "done", name: "done", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["time"] = (function()
	var __pkg = {}, __init, errors, js, nosync, runtime, syscall, ParseError, Time, Month, Weekday, Duration, Location, zone, zoneTrans, sliceType, sliceType__1, ptrType, sliceType__2, arrayType, sliceType__3, arrayType__1, arrayType__2, ptrType__2, arrayType__4, ptrType__4, ptrType__7, std0x, longDayNames, shortDayNames, shortMonthNames, longMonthNames, atoiError, errBad, errLeadingInt, months, days, daysBefore, utcLoc, utcLoc__24ptr, localLoc, localLoc__24ptr, localOnce, errLocation, badData, init, initLocal, indexByte, startsWithLowerCase, nextStdChunk, match, lookup, appendInt, atoi, formatNano, quote, isDigit, getnum, cutspace, skip, Parse, parse, parseTimeZone, parseGMT, parseNanoseconds, leadingInt, absWeekday, absClock, fmtFrac, fmtInt, lessThanHalf, absDate, daysIn, unixTime, Unix, isLeap, norm, Date, div, FixedZone;
	errors = __packages["errors"];
	js = __packages["github.com/gopherjs/gopherjs/js"];
	nosync = __packages["github.com/gopherjs/gopherjs/nosync"];
	runtime = __packages["runtime"];
	syscall = __packages["syscall"];
	ParseError = __pkg.ParseError = __newType(0, __kindStruct, "time.ParseError", true, "time", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Layout = "";
			this.Value = "";
			this.LayoutElem = "";
			this.ValueElem = "";
			this.Message = "";
			return;
		end
		this.Layout = Layout_;
		this.Value = Value_;
		this.LayoutElem = LayoutElem_;
		this.ValueElem = ValueElem_;
		this.Message = Message_;
	end);
	Time = __pkg.Time = __newType(0, __kindStruct, "time.Time", true, "time", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.wall = new __Uint64(0, 0);
			this.ext = new __Int64(0, 0);
			this.loc = ptrType__2.nil;
			return;
		end
		this.wall = wall_;
		this.ext = ext_;
		this.loc = loc_;
	end);
	Month = __pkg.Month = __newType(4, __kindInt, "time.Month", true, "time", true, null);
	Weekday = __pkg.Weekday = __newType(4, __kindInt, "time.Weekday", true, "time", true, null);
	Duration = __pkg.Duration = __newType(8, __kindInt64, "time.Duration", true, "time", true, null);
	Location = __pkg.Location = __newType(0, __kindStruct, "time.Location", true, "time", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.name = "";
			this.zone = sliceType.nil;
			this.tx = sliceType__1.nil;
			this.cacheStart = new __Int64(0, 0);
			this.cacheEnd = new __Int64(0, 0);
			this.cacheZone = ptrType.nil;
			return;
		end
		this.name = name_;
		this.zone = zone_;
		this.tx = tx_;
		this.cacheStart = cacheStart_;
		this.cacheEnd = cacheEnd_;
		this.cacheZone = cacheZone_;
	end);
	zone = __pkg.zone = __newType(0, __kindStruct, "time.zone", true, "time", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.name = "";
			this.offset = 0;
			this.isDST = false;
			return;
		end
		this.name = name_;
		this.offset = offset_;
		this.isDST = isDST_;
	end);
	zoneTrans = __pkg.zoneTrans = __newType(0, __kindStruct, "time.zoneTrans", true, "time", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.when = new __Int64(0, 0);
			this.index = 0;
			this.isstd = false;
			this.isutc = false;
			return;
		end
		this.when = when_;
		this.index = index_;
		this.isstd = isstd_;
		this.isutc = isutc_;
	end);
	sliceType = __sliceType(zone);
	sliceType__1 = __sliceType(zoneTrans);
	ptrType = __ptrType(zone);
	sliceType__2 = __sliceType(__String);
	arrayType = __arrayType(__Uint8, 20);
	sliceType__3 = __sliceType(__Uint8);
	arrayType__1 = __arrayType(__Uint8, 9);
	arrayType__2 = __arrayType(__Uint8, 64);
	ptrType__2 = __ptrType(Location);
	arrayType__4 = __arrayType(__Uint8, 32);
	ptrType__4 = __ptrType(ParseError);
	ptrType__7 = __ptrType(Time);
	init = function()
		__unused(Unix(new __Int64(0, 0), new __Int64(0, 0)));
	end;
	initLocal = function()
		var d, i, j, s;
		d = new (__global.Date)();
		s = __internalize(d, __String);
		i = indexByte(s, 40);
		j = indexByte(s, 41);
		if ((i == -1)  or  (j == -1)) {
			localLoc.name = "UTC";
			return;
		end
		localLoc.name = __substring(s, (i + 1 >> 0), j);
		localLoc.zone = new sliceType([new zone.ptr(localLoc.name, __imul((__parseInt(d.getTimezoneOffset()) >> 0), -60), false)]);
	end;
	indexByte = function(c)
		var c, s;
		return __parseInt(s.indexOf(__global.String.fromCharCode(c))) >> 0;
	end;
	startsWithLowerCase = function(r)
		var c, str;
		if (str.length == 0) {
			return false;
		end
		c = str.charCodeAt(0);
		return 97 <= c  and  c <= 122;
	end;
	nextStdChunk = function(t)
		var _1, _tmp, _tmp__1, _tmp__10, _tmp__11, _tmp__12, _tmp__13, _tmp__14, _tmp__15, _tmp__16, _tmp__17, _tmp__18, _tmp__19, _tmp__2, _tmp__20, _tmp__21, _tmp__22, _tmp__23, _tmp__24, _tmp__25, _tmp__26, _tmp__27, _tmp__28, _tmp__29, _tmp__3, _tmp__30, _tmp__31, _tmp__32, _tmp__33, _tmp__34, _tmp__35, _tmp__36, _tmp__37, _tmp__38, _tmp__39, _tmp__4, _tmp__40, _tmp__41, _tmp__42, _tmp__43, _tmp__44, _tmp__45, _tmp__46, _tmp__47, _tmp__48, _tmp__49, _tmp__5, _tmp__50, _tmp__51, _tmp__52, _tmp__53, _tmp__54, _tmp__55, _tmp__56, _tmp__57, _tmp__58, _tmp__59, _tmp__6, _tmp__60, _tmp__61, _tmp__62, _tmp__63, _tmp__64, _tmp__65, _tmp__66, _tmp__67, _tmp__68, _tmp__69, _tmp__7, _tmp__70, _tmp__71, _tmp__72, _tmp__73, _tmp__74, _tmp__75, _tmp__76, _tmp__77, _tmp__78, _tmp__79, _tmp__8, _tmp__80, _tmp__81, _tmp__82, _tmp__83, _tmp__84, _tmp__85, _tmp__86, _tmp__9, c, ch, i, j, layout, prefix, std, std__1, suffix, x;
		prefix = "";
		std = 0;
		suffix = "";
		i = 0;
		while (true) {
			if ( not (i < layout.length)) { break; end
			c = ((layout.charCodeAt(i) >> 0));
			_1 = c;
			if (_1 == (74)) {
				if (layout.length >= (i + 3 >> 0)  and  __substring(layout, i, (i + 3 >> 0)) == "Jan") {
					if (layout.length >= (i + 7 >> 0)  and  __substring(layout, i, (i + 7 >> 0)) == "January") {
						_tmp = __substring(layout, 0, i);
						_tmp__1 = 257;
						_tmp__2 = __substring(layout, (i + 7 >> 0));
						prefix = _tmp;
						std = _tmp__1;
						suffix = _tmp__2;
						return [prefix, std, suffix];
					end
					if ( not startsWithLowerCase(__substring(layout, (i + 3 >> 0)))) {
						_tmp__3 = __substring(layout, 0, i);
						_tmp__4 = 258;
						_tmp__5 = __substring(layout, (i + 3 >> 0));
						prefix = _tmp__3;
						std = _tmp__4;
						suffix = _tmp__5;
						return [prefix, std, suffix];
					end
				end
			end else if (_1 == (77)) {
				if (layout.length >= (i + 3 >> 0)) {
					if (__substring(layout, i, (i + 3 >> 0)) == "Mon") {
						if (layout.length >= (i + 6 >> 0)  and  __substring(layout, i, (i + 6 >> 0)) == "Monday") {
							_tmp__6 = __substring(layout, 0, i);
							_tmp__7 = 261;
							_tmp__8 = __substring(layout, (i + 6 >> 0));
							prefix = _tmp__6;
							std = _tmp__7;
							suffix = _tmp__8;
							return [prefix, std, suffix];
						end
						if ( not startsWithLowerCase(__substring(layout, (i + 3 >> 0)))) {
							_tmp__9 = __substring(layout, 0, i);
							_tmp__10 = 262;
							_tmp__11 = __substring(layout, (i + 3 >> 0));
							prefix = _tmp__9;
							std = _tmp__10;
							suffix = _tmp__11;
							return [prefix, std, suffix];
						end
					end
					if (__substring(layout, i, (i + 3 >> 0)) == "MST") {
						_tmp__12 = __substring(layout, 0, i);
						_tmp__13 = 21;
						_tmp__14 = __substring(layout, (i + 3 >> 0));
						prefix = _tmp__12;
						std = _tmp__13;
						suffix = _tmp__14;
						return [prefix, std, suffix];
					end
				end
			end else if (_1 == (48)) {
				if (layout.length >= (i + 2 >> 0)  and  49 <= layout.charCodeAt((i + 1 >> 0))  and  layout.charCodeAt((i + 1 >> 0)) <= 54) {
					_tmp__15 = __substring(layout, 0, i);
					_tmp__16 = (x = layout.charCodeAt((i + 1 >> 0)) - 49 << 24 >>> 24, ((x < 0  or  x >= std0x.length) ? (__throwRuntimeError("index out of range"), nil) : std0x[x]));
					_tmp__17 = __substring(layout, (i + 2 >> 0));
					prefix = _tmp__15;
					std = _tmp__16;
					suffix = _tmp__17;
					return [prefix, std, suffix];
				end
			end else if (_1 == (49)) {
				if (layout.length >= (i + 2 >> 0)  and  (layout.charCodeAt((i + 1 >> 0)) == 53)) {
					_tmp__18 = __substring(layout, 0, i);
					_tmp__19 = 522;
					_tmp__20 = __substring(layout, (i + 2 >> 0));
					prefix = _tmp__18;
					std = _tmp__19;
					suffix = _tmp__20;
					return [prefix, std, suffix];
				end
				_tmp__21 = __substring(layout, 0, i);
				_tmp__22 = 259;
				_tmp__23 = __substring(layout, (i + 1 >> 0));
				prefix = _tmp__21;
				std = _tmp__22;
				suffix = _tmp__23;
				return [prefix, std, suffix];
			end else if (_1 == (50)) {
				if (layout.length >= (i + 4 >> 0)  and  __substring(layout, i, (i + 4 >> 0)) == "2006") {
					_tmp__24 = __substring(layout, 0, i);
					_tmp__25 = 273;
					_tmp__26 = __substring(layout, (i + 4 >> 0));
					prefix = _tmp__24;
					std = _tmp__25;
					suffix = _tmp__26;
					return [prefix, std, suffix];
				end
				_tmp__27 = __substring(layout, 0, i);
				_tmp__28 = 263;
				_tmp__29 = __substring(layout, (i + 1 >> 0));
				prefix = _tmp__27;
				std = _tmp__28;
				suffix = _tmp__29;
				return [prefix, std, suffix];
			end else if (_1 == (95)) {
				if (layout.length >= (i + 2 >> 0)  and  (layout.charCodeAt((i + 1 >> 0)) == 50)) {
					if (layout.length >= (i + 5 >> 0)  and  __substring(layout, (i + 1 >> 0), (i + 5 >> 0)) == "2006") {
						_tmp__30 = __substring(layout, 0, (i + 1 >> 0));
						_tmp__31 = 273;
						_tmp__32 = __substring(layout, (i + 5 >> 0));
						prefix = _tmp__30;
						std = _tmp__31;
						suffix = _tmp__32;
						return [prefix, std, suffix];
					end
					_tmp__33 = __substring(layout, 0, i);
					_tmp__34 = 264;
					_tmp__35 = __substring(layout, (i + 2 >> 0));
					prefix = _tmp__33;
					std = _tmp__34;
					suffix = _tmp__35;
					return [prefix, std, suffix];
				end
			end else if (_1 == (51)) {
				_tmp__36 = __substring(layout, 0, i);
				_tmp__37 = 523;
				_tmp__38 = __substring(layout, (i + 1 >> 0));
				prefix = _tmp__36;
				std = _tmp__37;
				suffix = _tmp__38;
				return [prefix, std, suffix];
			end else if (_1 == (52)) {
				_tmp__39 = __substring(layout, 0, i);
				_tmp__40 = 525;
				_tmp__41 = __substring(layout, (i + 1 >> 0));
				prefix = _tmp__39;
				std = _tmp__40;
				suffix = _tmp__41;
				return [prefix, std, suffix];
			end else if (_1 == (53)) {
				_tmp__42 = __substring(layout, 0, i);
				_tmp__43 = 527;
				_tmp__44 = __substring(layout, (i + 1 >> 0));
				prefix = _tmp__42;
				std = _tmp__43;
				suffix = _tmp__44;
				return [prefix, std, suffix];
			end else if (_1 == (80)) {
				if (layout.length >= (i + 2 >> 0)  and  (layout.charCodeAt((i + 1 >> 0)) == 77)) {
					_tmp__45 = __substring(layout, 0, i);
					_tmp__46 = 531;
					_tmp__47 = __substring(layout, (i + 2 >> 0));
					prefix = _tmp__45;
					std = _tmp__46;
					suffix = _tmp__47;
					return [prefix, std, suffix];
				end
			end else if (_1 == (112)) {
				if (layout.length >= (i + 2 >> 0)  and  (layout.charCodeAt((i + 1 >> 0)) == 109)) {
					_tmp__48 = __substring(layout, 0, i);
					_tmp__49 = 532;
					_tmp__50 = __substring(layout, (i + 2 >> 0));
					prefix = _tmp__48;
					std = _tmp__49;
					suffix = _tmp__50;
					return [prefix, std, suffix];
				end
			end else if (_1 == (45)) {
				if (layout.length >= (i + 7 >> 0)  and  __substring(layout, i, (i + 7 >> 0)) == "-070000") {
					_tmp__51 = __substring(layout, 0, i);
					_tmp__52 = 28;
					_tmp__53 = __substring(layout, (i + 7 >> 0));
					prefix = _tmp__51;
					std = _tmp__52;
					suffix = _tmp__53;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 9 >> 0)  and  __substring(layout, i, (i + 9 >> 0)) == "-07:00:00") {
					_tmp__54 = __substring(layout, 0, i);
					_tmp__55 = 31;
					_tmp__56 = __substring(layout, (i + 9 >> 0));
					prefix = _tmp__54;
					std = _tmp__55;
					suffix = _tmp__56;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 5 >> 0)  and  __substring(layout, i, (i + 5 >> 0)) == "-0700") {
					_tmp__57 = __substring(layout, 0, i);
					_tmp__58 = 27;
					_tmp__59 = __substring(layout, (i + 5 >> 0));
					prefix = _tmp__57;
					std = _tmp__58;
					suffix = _tmp__59;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 6 >> 0)  and  __substring(layout, i, (i + 6 >> 0)) == "-07:00") {
					_tmp__60 = __substring(layout, 0, i);
					_tmp__61 = 30;
					_tmp__62 = __substring(layout, (i + 6 >> 0));
					prefix = _tmp__60;
					std = _tmp__61;
					suffix = _tmp__62;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 3 >> 0)  and  __substring(layout, i, (i + 3 >> 0)) == "-07") {
					_tmp__63 = __substring(layout, 0, i);
					_tmp__64 = 29;
					_tmp__65 = __substring(layout, (i + 3 >> 0));
					prefix = _tmp__63;
					std = _tmp__64;
					suffix = _tmp__65;
					return [prefix, std, suffix];
				end
			end else if (_1 == (90)) {
				if (layout.length >= (i + 7 >> 0)  and  __substring(layout, i, (i + 7 >> 0)) == "Z070000") {
					_tmp__66 = __substring(layout, 0, i);
					_tmp__67 = 23;
					_tmp__68 = __substring(layout, (i + 7 >> 0));
					prefix = _tmp__66;
					std = _tmp__67;
					suffix = _tmp__68;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 9 >> 0)  and  __substring(layout, i, (i + 9 >> 0)) == "Z07:00:00") {
					_tmp__69 = __substring(layout, 0, i);
					_tmp__70 = 26;
					_tmp__71 = __substring(layout, (i + 9 >> 0));
					prefix = _tmp__69;
					std = _tmp__70;
					suffix = _tmp__71;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 5 >> 0)  and  __substring(layout, i, (i + 5 >> 0)) == "Z0700") {
					_tmp__72 = __substring(layout, 0, i);
					_tmp__73 = 22;
					_tmp__74 = __substring(layout, (i + 5 >> 0));
					prefix = _tmp__72;
					std = _tmp__73;
					suffix = _tmp__74;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 6 >> 0)  and  __substring(layout, i, (i + 6 >> 0)) == "Z07:00") {
					_tmp__75 = __substring(layout, 0, i);
					_tmp__76 = 25;
					_tmp__77 = __substring(layout, (i + 6 >> 0));
					prefix = _tmp__75;
					std = _tmp__76;
					suffix = _tmp__77;
					return [prefix, std, suffix];
				end
				if (layout.length >= (i + 3 >> 0)  and  __substring(layout, i, (i + 3 >> 0)) == "Z07") {
					_tmp__78 = __substring(layout, 0, i);
					_tmp__79 = 24;
					_tmp__80 = __substring(layout, (i + 3 >> 0));
					prefix = _tmp__78;
					std = _tmp__79;
					suffix = _tmp__80;
					return [prefix, std, suffix];
				end
			end else if (_1 == (46)) {
				if ((i + 1 >> 0) < layout.length  and  ((layout.charCodeAt((i + 1 >> 0)) == 48)  or  (layout.charCodeAt((i + 1 >> 0)) == 57))) {
					ch = layout.charCodeAt((i + 1 >> 0));
					j = i + 1 >> 0;
					while (true) {
						if ( not (j < layout.length  and  (layout.charCodeAt(j) == ch))) { break; end
						j = j + (1) >> 0;
					end
					if ( not isDigit(layout, j)) {
						std__1 = 32;
						if (layout.charCodeAt((i + 1 >> 0)) == 57) {
							std__1 = 33;
						end
						std__1 = std__1 | ((((j - ((i + 1 >> 0)) >> 0)) << 16 >> 0));
						_tmp__81 = __substring(layout, 0, i);
						_tmp__82 = std__1;
						_tmp__83 = __substring(layout, j);
						prefix = _tmp__81;
						std = _tmp__82;
						suffix = _tmp__83;
						return [prefix, std, suffix];
					end
				end
			end
			i = i + (1) >> 0;
		end
		_tmp__84 = layout;
		_tmp__85 = 0;
		_tmp__86 = "";
		prefix = _tmp__84;
		std = _tmp__85;
		suffix = _tmp__86;
		return [prefix, std, suffix];
	end;
	match = function(2)
		var c1, c2, i, s1, s2;
		i = 0;
		while (true) {
			if ( not (i < s1.length)) { break; end
			c1 = s1.charCodeAt(i);
			c2 = s2.charCodeAt(i);
			if ( not ((c1 == c2))) {
				c1 = (c1 | (32)) >>> 0;
				c2 = (c2 | (32)) >>> 0;
				if ( not ((c1 == c2))  or  c1 < 97  or  c1 > 122) {
					return false;
				end
			end
			i = i + (1) >> 0;
		end
		return true;
	end;
	lookup = function(l)
		var _i, _ref, i, tab, v, val;
		_ref = tab;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			v = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			if (val.length >= v.length  and  match(__substring(val, 0, v.length), v)) {
				return [i, __substring(val, v.length), __ifaceNil];
			end
			_i++;
		end
		return [-1, val, errBad];
	end;
	appendInt = function(h)
		var _q, b, buf, i, q, u, w, width, x;
		u = ((x >>> 0));
		if (x < 0) {
			b = __append(b, 45);
			u = ((-x >>> 0));
		end
		buf = arrayType.zero();
		i = 20;
		while (true) {
			if ( not (u >= 10)) { break; end
			i = i - (1) >> 0;
			q = (_q = u / 10, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >>> 0 : __throwRuntimeError("integer divide by zero"));
			((i < 0  or  i >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[i] = ((((48 + u >>> 0) - (q * 10 >>> 0) >>> 0) << 24 >>> 24)));
			u = q;
		end
		i = i - (1) >> 0;
		((i < 0  or  i >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[i] = (((48 + u >>> 0) << 24 >>> 24)));
		w = 20 - i >> 0;
		while (true) {
			if ( not (w < width)) { break; end
			b = __append(b, 48);
			w = w + (1) >> 0;
		end
		return __appendSlice(b, __subslice(new sliceType__3(buf), i));
	end;
	atoi = function(s)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tuple, err, neg, q, rem, s, x;
		x = 0;
		err = __ifaceNil;
		neg = false;
		if ( not (s == "")  and  ((s.charCodeAt(0) == 45)  or  (s.charCodeAt(0) == 43))) {
			neg = s.charCodeAt(0) == 45;
			s = __substring(s, 1);
		end
		_tuple = leadingInt(s);
		q = _tuple[0];
		rem = _tuple[1];
		err = _tuple[2];
		x = (((q.__low + ((q.__high >> 31) * 4294967296)) >> 0));
		if ( not (__interfaceIsEqual(err, __ifaceNil))  or   not (rem == "")) {
			_tmp = 0;
			_tmp__1 = atoiError;
			x = _tmp;
			err = _tmp__1;
			return [x, err];
		end
		if (neg) {
			x = -x;
		end
		_tmp__2 = x;
		_tmp__3 = __ifaceNil;
		x = _tmp__2;
		err = _tmp__3;
		return [x, err];
	end;
	formatNano = function(m)
		var _q, _r, b, buf, n, nanosec, start, trim, u, x;
		u = nanosec;
		buf = arrayType__1.zero();
		start = 9;
		while (true) {
			if ( not (start > 0)) { break; end
			start = start - (1) >> 0;
			((start < 0  or  start >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[start] = ((((_r = u % 10, _r == _r ? _r : __throwRuntimeError("integer divide by zero")) + 48 >>> 0) << 24 >>> 24)));
			u = (_q = u / (10), (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >>> 0 : __throwRuntimeError("integer divide by zero"));
		end
		if (n > 9) {
			n = 9;
		end
		if (trim) {
			while (true) {
				if ( not (n > 0  and  ((x = n - 1 >> 0, ((x < 0  or  x >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[x])) == 48))) { break; end
				n = n - (1) >> 0;
			end
			if (n == 0) {
				return b;
			end
		end
		b = __append(b, 46);
		return __appendSlice(b, __subslice(new sliceType__3(buf), 0, n));
	end;
	Time.ptr.prototype.String = function()
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, buf, m0, m1, m2, s, sign, t, wid, x, x__1, x__2, x__3, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; buf = __f.buf; m0 = __f.m0; m1 = __f.m1; m2 = __f.m2; s = __f.s; sign = __f.sign; t = __f.t; wid = __f.wid; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; x__3 = __f.x__3; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).Format("2006-01-02 15:04:05.999999999 -0700 MST"); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		s = _r;
		if ( not ((x = (x__1 = t.wall, new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			m2 = ((x__2 = t.ext, new __Uint64(x__2.__high, x__2.__low)));
			sign = 43;
			if ((x__3 = t.ext, (x__3.__high < 0  or  (x__3.__high == 0  and  x__3.__low < 0)))) {
				sign = 45;
				m2 = new __Uint64(-m2.__high, -m2.__low);
			end
			_tmp = __div64(m2, new __Uint64(0, 1000000000), false);
			_tmp__1 = __div64(m2, new __Uint64(0, 1000000000), true);
			m1 = _tmp;
			m2 = _tmp__1;
			_tmp__2 = __div64(m1, new __Uint64(0, 1000000000), false);
			_tmp__3 = __div64(m1, new __Uint64(0, 1000000000), true);
			m0 = _tmp__2;
			m1 = _tmp__3;
			buf = sliceType__3.nil;
			buf = __appendSlice(buf, " m=");
			buf = __append(buf, sign);
			wid = 0;
			if ( not ((m0.__high == 0  and  m0.__low == 0))) {
				buf = appendInt(buf, ((m0.__low >> 0)), 0);
				wid = 9;
			end
			buf = appendInt(buf, ((m1.__low >> 0)), wid);
			buf = __append(buf, 46);
			buf = appendInt(buf, ((m2.__low >> 0)), 9);
			s = s + ((__bytesToString(buf)));
		end
		__s = -1; return s;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.String end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f.buf = buf; __f.m0 = m0; __f.m1 = m1; __f.m2 = m2; __f.s = s; __f.sign = sign; __f.t = t; __f.wid = wid; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.x__3 = x__3; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.String = function() return this.__val.String(); end;
	Time.ptr.prototype.Format = function(t)
		var _r, b, buf, layout, max, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; b = __f.b; buf = __f.buf; layout = __f.layout; max = __f.max; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		b = sliceType__3.nil;
		max = layout.length + 10 >> 0;
		if (max < 64) {
			buf = arrayType__2.zero();
			b = __subslice(new sliceType__3(buf), 0, 0);
		end else {
			b = __makeSlice(sliceType__3, 0, max);
		end
		_r = __clone(t, Time).AppendFormat(b, layout); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		b = _r;
		__s = -1; return (__bytesToString(b));
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Format end; end __f._r = _r; __f.b = b; __f.buf = buf; __f.layout = layout; __f.max = max; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Format = function(t) return this.__val.Format(layout); end;
	Time.ptr.prototype.AppendFormat = function(t)
		var _1, _q, _q__1, _q__2, _q__3, _r, _r__1, _r__2, _r__3, _r__4, _r__5, _r__6, _tuple, _tuple__1, _tuple__2, _tuple__3, abs, absoffset, b, day, hour, hr, hr__1, layout, m, min, month, name, offset, prefix, s, sec, std, suffix, t, y, year, zone__1, zone__2, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _q = __f._q; _q__1 = __f._q__1; _q__2 = __f._q__2; _q__3 = __f._q__3; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _r__6 = __f._r__6; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; _tuple__3 = __f._tuple__3; abs = __f.abs; absoffset = __f.absoffset; b = __f.b; day = __f.day; hour = __f.hour; hr = __f.hr; hr__1 = __f.hr__1; layout = __f.layout; m = __f.m; min = __f.min; month = __f.month; name = __f.name; offset = __f.offset; prefix = __f.prefix; s = __f.s; sec = __f.sec; std = __f.std; suffix = __f.suffix; t = __f.t; y = __f.y; year = __f.year; zone__1 = __f.zone__1; zone__2 = __f.zone__2; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).locabs(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		name = _tuple[0];
		offset = _tuple[1];
		abs = _tuple[2];
		year = -1;
		month = 0;
		day = 0;
		hour = -1;
		min = 0;
		sec = 0;
		while (true) {
			if ( not ( not (layout == ""))) { break; end
			_tuple__1 = nextStdChunk(layout);
			prefix = _tuple__1[0];
			std = _tuple__1[1];
			suffix = _tuple__1[2];
			if ( not (prefix == "")) {
				b = __appendSlice(b, prefix);
			end
			if (std == 0) {
				break;
			end
			layout = suffix;
			if (year < 0  and   not (((std & 256) == 0))) {
				_tuple__2 = absDate(abs, true);
				year = _tuple__2[0];
				month = _tuple__2[1];
				day = _tuple__2[2];
			end
			if (hour < 0  and   not (((std & 512) == 0))) {
				_tuple__3 = absClock(abs);
				hour = _tuple__3[0];
				min = _tuple__3[1];
				sec = _tuple__3[2];
			end
			switch (0) { default:
				_1 = std & 65535;
				if (_1 == (274)) {
					y = year;
					if (y < 0) {
						y = -y;
					end
					b = appendInt(b, (_r__1 = y % 100, _r__1 == _r__1 ? _r__1 : __throwRuntimeError("integer divide by zero")), 2);
				end else if (_1 == (273)) {
					b = appendInt(b, year, 4);
				end else if (_1 == (258)) {
					b = __appendSlice(b, __substring(new Month(month).String(), 0, 3));
				end else if (_1 == (257)) {
					m = new Month(month).String();
					b = __appendSlice(b, m);
				end else if (_1 == (259)) {
					b = appendInt(b, ((month >> 0)), 0);
				end else if (_1 == (260)) {
					b = appendInt(b, ((month >> 0)), 2);
				end else if (_1 == (262)) {
					b = __appendSlice(b, __substring(new Weekday(absWeekday(abs)).String(), 0, 3));
				end else if (_1 == (261)) {
					s = new Weekday(absWeekday(abs)).String();
					b = __appendSlice(b, s);
				end else if (_1 == (263)) {
					b = appendInt(b, day, 0);
				end else if (_1 == (264)) {
					if (day < 10) {
						b = __append(b, 32);
					end
					b = appendInt(b, day, 0);
				end else if (_1 == (265)) {
					b = appendInt(b, day, 2);
				end else if (_1 == (522)) {
					b = appendInt(b, hour, 2);
				end else if (_1 == (523)) {
					hr = (_r__2 = hour % 12, _r__2 == _r__2 ? _r__2 : __throwRuntimeError("integer divide by zero"));
					if (hr == 0) {
						hr = 12;
					end
					b = appendInt(b, hr, 0);
				end else if (_1 == (524)) {
					hr__1 = (_r__3 = hour % 12, _r__3 == _r__3 ? _r__3 : __throwRuntimeError("integer divide by zero"));
					if (hr__1 == 0) {
						hr__1 = 12;
					end
					b = appendInt(b, hr__1, 2);
				end else if (_1 == (525)) {
					b = appendInt(b, min, 0);
				end else if (_1 == (526)) {
					b = appendInt(b, min, 2);
				end else if (_1 == (527)) {
					b = appendInt(b, sec, 0);
				end else if (_1 == (528)) {
					b = appendInt(b, sec, 2);
				end else if (_1 == (531)) {
					if (hour >= 12) {
						b = __appendSlice(b, "PM");
					end else {
						b = __appendSlice(b, "AM");
					end
				end else if (_1 == (532)) {
					if (hour >= 12) {
						b = __appendSlice(b, "pm");
					end else {
						b = __appendSlice(b, "am");
					end
				end else if ((_1 == (22))  or  (_1 == (25))  or  (_1 == (23))  or  (_1 == (24))  or  (_1 == (26))  or  (_1 == (27))  or  (_1 == (30))  or  (_1 == (28))  or  (_1 == (29))  or  (_1 == (31))) {
					if ((offset == 0)  and  ((std == 22)  or  (std == 25)  or  (std == 23)  or  (std == 24)  or  (std == 26))) {
						b = __append(b, 90);
						break;
					end
					zone__1 = (_q = offset / 60, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
					absoffset = offset;
					if (zone__1 < 0) {
						b = __append(b, 45);
						zone__1 = -zone__1;
						absoffset = -absoffset;
					end else {
						b = __append(b, 43);
					end
					b = appendInt(b, (_q__1 = zone__1 / 60, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >> 0 : __throwRuntimeError("integer divide by zero")), 2);
					if ((std == 25)  or  (std == 30)  or  (std == 26)  or  (std == 31)) {
						b = __append(b, 58);
					end
					if ( not ((std == 29))  and   not ((std == 24))) {
						b = appendInt(b, (_r__4 = zone__1 % 60, _r__4 == _r__4 ? _r__4 : __throwRuntimeError("integer divide by zero")), 2);
					end
					if ((std == 23)  or  (std == 28)  or  (std == 31)  or  (std == 26)) {
						if ((std == 31)  or  (std == 26)) {
							b = __append(b, 58);
						end
						b = appendInt(b, (_r__5 = absoffset % 60, _r__5 == _r__5 ? _r__5 : __throwRuntimeError("integer divide by zero")), 2);
					end
				end else if (_1 == (21)) {
					if ( not (name == "")) {
						b = __appendSlice(b, name);
						break;
					end
					zone__2 = (_q__2 = offset / 60, (_q__2 == _q__2  and  _q__2 ~= 1/0  and  _q__2 ~= -1/0) ? _q__2 >> 0 : __throwRuntimeError("integer divide by zero"));
					if (zone__2 < 0) {
						b = __append(b, 45);
						zone__2 = -zone__2;
					end else {
						b = __append(b, 43);
					end
					b = appendInt(b, (_q__3 = zone__2 / 60, (_q__3 == _q__3  and  _q__3 ~= 1/0  and  _q__3 ~= -1/0) ? _q__3 >> 0 : __throwRuntimeError("integer divide by zero")), 2);
					b = appendInt(b, (_r__6 = zone__2 % 60, _r__6 == _r__6 ? _r__6 : __throwRuntimeError("integer divide by zero")), 2);
				end else if ((_1 == (32))  or  (_1 == (33))) {
					b = formatNano(b, ((__clone(t, Time).Nanosecond() >>> 0)), std >> 16 >> 0, (std & 65535) == 33);
				end
			end
		end
		__s = -1; return b;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.AppendFormat end; end __f._1 = _1; __f._q = _q; __f._q__1 = _q__1; __f._q__2 = _q__2; __f._q__3 = _q__3; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._r__6 = _r__6; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f._tuple__3 = _tuple__3; __f.abs = abs; __f.absoffset = absoffset; __f.b = b; __f.day = day; __f.hour = hour; __f.hr = hr; __f.hr__1 = hr__1; __f.layout = layout; __f.m = m; __f.min = min; __f.month = month; __f.name = name; __f.offset = offset; __f.prefix = prefix; __f.s = s; __f.sec = sec; __f.std = std; __f.suffix = suffix; __f.t = t; __f.y = y; __f.year = year; __f.zone__1 = zone__1; __f.zone__2 = zone__2; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.AppendFormat = function(t) return this.__val.AppendFormat(b, layout); end;
	quote = function(s)
		var s;
		return "\"" + s + "\"";
	end;
	ParseError.ptr.prototype.Error = function()
		var e;
		e = this;
		if (e.Message == "") {
			return "parsing time " + quote(e.Value) + " as " + quote(e.Layout) + ": cannot parse " + quote(e.ValueElem) + " as " + quote(e.LayoutElem);
		end
		return "parsing time " + quote(e.Value) + e.Message;
	end;
	ParseError.prototype.Error = function() return this.__val.Error(); end;
	isDigit = function(i)
		var c, i, s;
		if (s.length <= i) {
			return false;
		end
		c = s.charCodeAt(i);
		return 48 <= c  and  c <= 57;
	end;
	getnum = function(d)
		var fixed, s;
		if ( not isDigit(s, 0)) {
			return [0, s, errBad];
		end
		if ( not isDigit(s, 1)) {
			if (fixed) {
				return [0, s, errBad];
			end
			return [(((s.charCodeAt(0) - 48 << 24 >>> 24) >> 0)), __substring(s, 1), __ifaceNil];
		end
		return [(__imul((((s.charCodeAt(0) - 48 << 24 >>> 24) >> 0)), 10)) + (((s.charCodeAt(1) - 48 << 24 >>> 24) >> 0)) >> 0, __substring(s, 2), __ifaceNil];
	end;
	cutspace = function(s)
		var s;
		while (true) {
			if ( not (s.length > 0  and  (s.charCodeAt(0) == 32))) { break; end
			s = __substring(s, 1);
		end
		return s;
	end;
	skip = function(x)
		var prefix, value;
		while (true) {
			if ( not (prefix.length > 0)) { break; end
			if (prefix.charCodeAt(0) == 32) {
				if (value.length > 0  and   not ((value.charCodeAt(0) == 32))) {
					return [value, errBad];
				end
				prefix = cutspace(prefix);
				value = cutspace(value);
				continue;
			end
			if ((value.length == 0)  or   not ((value.charCodeAt(0) == prefix.charCodeAt(0)))) {
				return [value, errBad];
			end
			prefix = __substring(prefix, 1);
			value = __substring(value, 1);
		end
		return [value, __ifaceNil];
	end;
	Parse = function(e)
		var _r, layout, value, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; layout = __f.layout; value = __f.value; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = parse(layout, value, __pkg.UTC, __pkg.Local); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Parse end; end __f._r = _r; __f.layout = layout; __f.value = value; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.Parse = Parse;
	parse = function(l)
		var _1, _2, _3, _4, _r, _r__1, _r__2, _r__3, _r__4, _r__5, _tmp, _tmp__1, _tmp__10, _tmp__11, _tmp__12, _tmp__13, _tmp__14, _tmp__15, _tmp__16, _tmp__17, _tmp__18, _tmp__19, _tmp__2, _tmp__20, _tmp__21, _tmp__22, _tmp__23, _tmp__24, _tmp__25, _tmp__26, _tmp__27, _tmp__28, _tmp__29, _tmp__3, _tmp__30, _tmp__31, _tmp__32, _tmp__33, _tmp__34, _tmp__35, _tmp__36, _tmp__37, _tmp__38, _tmp__39, _tmp__4, _tmp__40, _tmp__41, _tmp__42, _tmp__43, _tmp__5, _tmp__6, _tmp__7, _tmp__8, _tmp__9, _tuple, _tuple__1, _tuple__10, _tuple__11, _tuple__12, _tuple__13, _tuple__14, _tuple__15, _tuple__16, _tuple__17, _tuple__18, _tuple__19, _tuple__2, _tuple__20, _tuple__21, _tuple__22, _tuple__23, _tuple__24, _tuple__3, _tuple__4, _tuple__5, _tuple__6, _tuple__7, _tuple__8, _tuple__9, alayout, amSet, avalue, day, defaultLocation, err, hour, hour__1, hr, i, layout, local, min, min__1, mm, month, n, n__1, name, ndigit, nsec, offset, offset__1, ok, ok__1, p, pmSet, prefix, rangeErrString, sec, seconds, sign, ss, std, stdstr, suffix, t, t__1, value, x, x__1, year, z, zoneName, zoneOffset, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _2 = __f._2; _3 = __f._3; _4 = __f._4; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__10 = __f._tmp__10; _tmp__11 = __f._tmp__11; _tmp__12 = __f._tmp__12; _tmp__13 = __f._tmp__13; _tmp__14 = __f._tmp__14; _tmp__15 = __f._tmp__15; _tmp__16 = __f._tmp__16; _tmp__17 = __f._tmp__17; _tmp__18 = __f._tmp__18; _tmp__19 = __f._tmp__19; _tmp__2 = __f._tmp__2; _tmp__20 = __f._tmp__20; _tmp__21 = __f._tmp__21; _tmp__22 = __f._tmp__22; _tmp__23 = __f._tmp__23; _tmp__24 = __f._tmp__24; _tmp__25 = __f._tmp__25; _tmp__26 = __f._tmp__26; _tmp__27 = __f._tmp__27; _tmp__28 = __f._tmp__28; _tmp__29 = __f._tmp__29; _tmp__3 = __f._tmp__3; _tmp__30 = __f._tmp__30; _tmp__31 = __f._tmp__31; _tmp__32 = __f._tmp__32; _tmp__33 = __f._tmp__33; _tmp__34 = __f._tmp__34; _tmp__35 = __f._tmp__35; _tmp__36 = __f._tmp__36; _tmp__37 = __f._tmp__37; _tmp__38 = __f._tmp__38; _tmp__39 = __f._tmp__39; _tmp__4 = __f._tmp__4; _tmp__40 = __f._tmp__40; _tmp__41 = __f._tmp__41; _tmp__42 = __f._tmp__42; _tmp__43 = __f._tmp__43; _tmp__5 = __f._tmp__5; _tmp__6 = __f._tmp__6; _tmp__7 = __f._tmp__7; _tmp__8 = __f._tmp__8; _tmp__9 = __f._tmp__9; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__10 = __f._tuple__10; _tuple__11 = __f._tuple__11; _tuple__12 = __f._tuple__12; _tuple__13 = __f._tuple__13; _tuple__14 = __f._tuple__14; _tuple__15 = __f._tuple__15; _tuple__16 = __f._tuple__16; _tuple__17 = __f._tuple__17; _tuple__18 = __f._tuple__18; _tuple__19 = __f._tuple__19; _tuple__2 = __f._tuple__2; _tuple__20 = __f._tuple__20; _tuple__21 = __f._tuple__21; _tuple__22 = __f._tuple__22; _tuple__23 = __f._tuple__23; _tuple__24 = __f._tuple__24; _tuple__3 = __f._tuple__3; _tuple__4 = __f._tuple__4; _tuple__5 = __f._tuple__5; _tuple__6 = __f._tuple__6; _tuple__7 = __f._tuple__7; _tuple__8 = __f._tuple__8; _tuple__9 = __f._tuple__9; alayout = __f.alayout; amSet = __f.amSet; avalue = __f.avalue; day = __f.day; defaultLocation = __f.defaultLocation; err = __f.err; hour = __f.hour; hour__1 = __f.hour__1; hr = __f.hr; i = __f.i; layout = __f.layout; local = __f.local; min = __f.min; min__1 = __f.min__1; mm = __f.mm; month = __f.month; n = __f.n; n__1 = __f.n__1; name = __f.name; ndigit = __f.ndigit; nsec = __f.nsec; offset = __f.offset; offset__1 = __f.offset__1; ok = __f.ok; ok__1 = __f.ok__1; p = __f.p; pmSet = __f.pmSet; prefix = __f.prefix; rangeErrString = __f.rangeErrString; sec = __f.sec; seconds = __f.seconds; sign = __f.sign; ss = __f.ss; std = __f.std; stdstr = __f.stdstr; suffix = __f.suffix; t = __f.t; t__1 = __f.t__1; value = __f.value; x = __f.x; x__1 = __f.x__1; year = __f.year; z = __f.z; zoneName = __f.zoneName; zoneOffset = __f.zoneOffset; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_tmp = layout;
		_tmp__1 = value;
		alayout = _tmp;
		avalue = _tmp__1;
		rangeErrString = "";
		amSet = false;
		pmSet = false;
		year = 0;
		month = 1;
		day = 1;
		hour = 0;
		min = 0;
		sec = 0;
		nsec = 0;
		z = ptrType__2.nil;
		zoneOffset = -1;
		zoneName = "";
		while (true) {
			err = __ifaceNil;
			_tuple = nextStdChunk(layout);
			prefix = _tuple[0];
			std = _tuple[1];
			suffix = _tuple[2];
			stdstr = __substring(layout, prefix.length, (layout.length - suffix.length >> 0));
			_tuple__1 = skip(value, prefix);
			value = _tuple__1[0];
			err = _tuple__1[1];
			if ( not (__interfaceIsEqual(err, __ifaceNil))) {
				__s = -1; return [new Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__2.nil), new ParseError.ptr(alayout, avalue, prefix, value, "")];
			end
			if (std == 0) {
				if ( not ((value.length == 0))) {
					__s = -1; return [new Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__2.nil), new ParseError.ptr(alayout, avalue, "", value, ": extra text: " + value)];
				end
				break;
			end
			layout = suffix;
			p = "";
			switch (0) { default:
				_1 = std & 65535;
				if (_1 == (274)) {
					if (value.length < 2) {
						err = errBad;
						break;
					end
					_tmp__2 = __substring(value, 0, 2);
					_tmp__3 = __substring(value, 2);
					p = _tmp__2;
					value = _tmp__3;
					_tuple__2 = atoi(p);
					year = _tuple__2[0];
					err = _tuple__2[1];
					if (year >= 69) {
						year = year + (1900) >> 0;
					end else {
						year = year + (2000) >> 0;
					end
				end else if (_1 == (273)) {
					if (value.length < 4  or   not isDigit(value, 0)) {
						err = errBad;
						break;
					end
					_tmp__4 = __substring(value, 0, 4);
					_tmp__5 = __substring(value, 4);
					p = _tmp__4;
					value = _tmp__5;
					_tuple__3 = atoi(p);
					year = _tuple__3[0];
					err = _tuple__3[1];
				end else if (_1 == (258)) {
					_tuple__4 = lookup(shortMonthNames, value);
					month = _tuple__4[0];
					value = _tuple__4[1];
					err = _tuple__4[2];
				end else if (_1 == (257)) {
					_tuple__5 = lookup(longMonthNames, value);
					month = _tuple__5[0];
					value = _tuple__5[1];
					err = _tuple__5[2];
				end else if ((_1 == (259))  or  (_1 == (260))) {
					_tuple__6 = getnum(value, std == 260);
					month = _tuple__6[0];
					value = _tuple__6[1];
					err = _tuple__6[2];
					if (month <= 0  or  12 < month) {
						rangeErrString = "month";
					end
				end else if (_1 == (262)) {
					_tuple__7 = lookup(shortDayNames, value);
					value = _tuple__7[1];
					err = _tuple__7[2];
				end else if (_1 == (261)) {
					_tuple__8 = lookup(longDayNames, value);
					value = _tuple__8[1];
					err = _tuple__8[2];
				end else if ((_1 == (263))  or  (_1 == (264))  or  (_1 == (265))) {
					if ((std == 264)  and  value.length > 0  and  (value.charCodeAt(0) == 32)) {
						value = __substring(value, 1);
					end
					_tuple__9 = getnum(value, std == 265);
					day = _tuple__9[0];
					value = _tuple__9[1];
					err = _tuple__9[2];
					if (day < 0) {
						rangeErrString = "day";
					end
				end else if (_1 == (522)) {
					_tuple__10 = getnum(value, false);
					hour = _tuple__10[0];
					value = _tuple__10[1];
					err = _tuple__10[2];
					if (hour < 0  or  24 <= hour) {
						rangeErrString = "hour";
					end
				end else if ((_1 == (523))  or  (_1 == (524))) {
					_tuple__11 = getnum(value, std == 524);
					hour = _tuple__11[0];
					value = _tuple__11[1];
					err = _tuple__11[2];
					if (hour < 0  or  12 < hour) {
						rangeErrString = "hour";
					end
				end else if ((_1 == (525))  or  (_1 == (526))) {
					_tuple__12 = getnum(value, std == 526);
					min = _tuple__12[0];
					value = _tuple__12[1];
					err = _tuple__12[2];
					if (min < 0  or  60 <= min) {
						rangeErrString = "minute";
					end
				end else if ((_1 == (527))  or  (_1 == (528))) {
					_tuple__13 = getnum(value, std == 528);
					sec = _tuple__13[0];
					value = _tuple__13[1];
					err = _tuple__13[2];
					if (sec < 0  or  60 <= sec) {
						rangeErrString = "second";
						break;
					end
					if (value.length >= 2  and  (value.charCodeAt(0) == 46)  and  isDigit(value, 1)) {
						_tuple__14 = nextStdChunk(layout);
						std = _tuple__14[1];
						std = std & (65535);
						if ((std == 32)  or  (std == 33)) {
							break;
						end
						n = 2;
						while (true) {
							if ( not (n < value.length  and  isDigit(value, n))) { break; end
							n = n + (1) >> 0;
						end
						_tuple__15 = parseNanoseconds(value, n);
						nsec = _tuple__15[0];
						rangeErrString = _tuple__15[1];
						err = _tuple__15[2];
						value = __substring(value, n);
					end
				end else if (_1 == (531)) {
					if (value.length < 2) {
						err = errBad;
						break;
					end
					_tmp__6 = __substring(value, 0, 2);
					_tmp__7 = __substring(value, 2);
					p = _tmp__6;
					value = _tmp__7;
					_2 = p;
					if (_2 == ("PM")) {
						pmSet = true;
					end else if (_2 == ("AM")) {
						amSet = true;
					end else {
						err = errBad;
					end
				end else if (_1 == (532)) {
					if (value.length < 2) {
						err = errBad;
						break;
					end
					_tmp__8 = __substring(value, 0, 2);
					_tmp__9 = __substring(value, 2);
					p = _tmp__8;
					value = _tmp__9;
					_3 = p;
					if (_3 == ("pm")) {
						pmSet = true;
					end else if (_3 == ("am")) {
						amSet = true;
					end else {
						err = errBad;
					end
				end else if ((_1 == (22))  or  (_1 == (25))  or  (_1 == (23))  or  (_1 == (24))  or  (_1 == (26))  or  (_1 == (27))  or  (_1 == (29))  or  (_1 == (30))  or  (_1 == (28))  or  (_1 == (31))) {
					if (((std == 22)  or  (std == 24)  or  (std == 25))  and  value.length >= 1  and  (value.charCodeAt(0) == 90)) {
						value = __substring(value, 1);
						z = __pkg.UTC;
						break;
					end
					_tmp__10 = "";
					_tmp__11 = "";
					_tmp__12 = "";
					_tmp__13 = "";
					sign = _tmp__10;
					hour__1 = _tmp__11;
					min__1 = _tmp__12;
					seconds = _tmp__13;
					if ((std == 25)  or  (std == 30)) {
						if (value.length < 6) {
							err = errBad;
							break;
						end
						if ( not ((value.charCodeAt(3) == 58))) {
							err = errBad;
							break;
						end
						_tmp__14 = __substring(value, 0, 1);
						_tmp__15 = __substring(value, 1, 3);
						_tmp__16 = __substring(value, 4, 6);
						_tmp__17 = "00";
						_tmp__18 = __substring(value, 6);
						sign = _tmp__14;
						hour__1 = _tmp__15;
						min__1 = _tmp__16;
						seconds = _tmp__17;
						value = _tmp__18;
					end else if ((std == 29)  or  (std == 24)) {
						if (value.length < 3) {
							err = errBad;
							break;
						end
						_tmp__19 = __substring(value, 0, 1);
						_tmp__20 = __substring(value, 1, 3);
						_tmp__21 = "00";
						_tmp__22 = "00";
						_tmp__23 = __substring(value, 3);
						sign = _tmp__19;
						hour__1 = _tmp__20;
						min__1 = _tmp__21;
						seconds = _tmp__22;
						value = _tmp__23;
					end else if ((std == 26)  or  (std == 31)) {
						if (value.length < 9) {
							err = errBad;
							break;
						end
						if ( not ((value.charCodeAt(3) == 58))  or   not ((value.charCodeAt(6) == 58))) {
							err = errBad;
							break;
						end
						_tmp__24 = __substring(value, 0, 1);
						_tmp__25 = __substring(value, 1, 3);
						_tmp__26 = __substring(value, 4, 6);
						_tmp__27 = __substring(value, 7, 9);
						_tmp__28 = __substring(value, 9);
						sign = _tmp__24;
						hour__1 = _tmp__25;
						min__1 = _tmp__26;
						seconds = _tmp__27;
						value = _tmp__28;
					end else if ((std == 23)  or  (std == 28)) {
						if (value.length < 7) {
							err = errBad;
							break;
						end
						_tmp__29 = __substring(value, 0, 1);
						_tmp__30 = __substring(value, 1, 3);
						_tmp__31 = __substring(value, 3, 5);
						_tmp__32 = __substring(value, 5, 7);
						_tmp__33 = __substring(value, 7);
						sign = _tmp__29;
						hour__1 = _tmp__30;
						min__1 = _tmp__31;
						seconds = _tmp__32;
						value = _tmp__33;
					end else {
						if (value.length < 5) {
							err = errBad;
							break;
						end
						_tmp__34 = __substring(value, 0, 1);
						_tmp__35 = __substring(value, 1, 3);
						_tmp__36 = __substring(value, 3, 5);
						_tmp__37 = "00";
						_tmp__38 = __substring(value, 5);
						sign = _tmp__34;
						hour__1 = _tmp__35;
						min__1 = _tmp__36;
						seconds = _tmp__37;
						value = _tmp__38;
					end
					_tmp__39 = 0;
					_tmp__40 = 0;
					_tmp__41 = 0;
					hr = _tmp__39;
					mm = _tmp__40;
					ss = _tmp__41;
					_tuple__16 = atoi(hour__1);
					hr = _tuple__16[0];
					err = _tuple__16[1];
					if (__interfaceIsEqual(err, __ifaceNil)) {
						_tuple__17 = atoi(min__1);
						mm = _tuple__17[0];
						err = _tuple__17[1];
					end
					if (__interfaceIsEqual(err, __ifaceNil)) {
						_tuple__18 = atoi(seconds);
						ss = _tuple__18[0];
						err = _tuple__18[1];
					end
					zoneOffset = (__imul((((__imul(hr, 60)) + mm >> 0)), 60)) + ss >> 0;
					_4 = sign.charCodeAt(0);
					if (_4 == (43)) {
					end else if (_4 == (45)) {
						zoneOffset = -zoneOffset;
					end else {
						err = errBad;
					end
				end else if (_1 == (21)) {
					if (value.length >= 3  and  __substring(value, 0, 3) == "UTC") {
						z = __pkg.UTC;
						value = __substring(value, 3);
						break;
					end
					_tuple__19 = parseTimeZone(value);
					n__1 = _tuple__19[0];
					ok = _tuple__19[1];
					if ( not ok) {
						err = errBad;
						break;
					end
					_tmp__42 = __substring(value, 0, n__1);
					_tmp__43 = __substring(value, n__1);
					zoneName = _tmp__42;
					value = _tmp__43;
				end else if (_1 == (32)) {
					ndigit = 1 + ((std >> 16 >> 0)) >> 0;
					if (value.length < ndigit) {
						err = errBad;
						break;
					end
					_tuple__20 = parseNanoseconds(value, ndigit);
					nsec = _tuple__20[0];
					rangeErrString = _tuple__20[1];
					err = _tuple__20[2];
					value = __substring(value, ndigit);
				end else if (_1 == (33)) {
					if (value.length < 2  or   not ((value.charCodeAt(0) == 46))  or  value.charCodeAt(1) < 48  or  57 < value.charCodeAt(1)) {
						break;
					end
					i = 0;
					while (true) {
						if ( not (i < 9  and  (i + 1 >> 0) < value.length  and  48 <= value.charCodeAt((i + 1 >> 0))  and  value.charCodeAt((i + 1 >> 0)) <= 57)) { break; end
						i = i + (1) >> 0;
					end
					_tuple__21 = parseNanoseconds(value, 1 + i >> 0);
					nsec = _tuple__21[0];
					rangeErrString = _tuple__21[1];
					err = _tuple__21[2];
					value = __substring(value, (1 + i >> 0));
				end
			end
			if ( not (rangeErrString == "")) {
				__s = -1; return [new Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__2.nil), new ParseError.ptr(alayout, avalue, stdstr, value, ": " + rangeErrString + " out of range")];
			end
			if ( not (__interfaceIsEqual(err, __ifaceNil))) {
				__s = -1; return [new Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__2.nil), new ParseError.ptr(alayout, avalue, stdstr, value, "")];
			end
		end
		if (pmSet  and  hour < 12) {
			hour = hour + (12) >> 0;
		end else if (amSet  and  (hour == 12)) {
			hour = 0;
		end
		if (day < 1  or  day > daysIn(((month >> 0)), year)) {
			__s = -1; return [new Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__2.nil), new ParseError.ptr(alayout, avalue, "", value, ": day out of range")];
		end
		/* */ if ( not (z == ptrType__2.nil)) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not (z == ptrType__2.nil)) { */ case 1:
			_r = Date(year, ((month >> 0)), day, hour, min, sec, nsec, z); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			__s = -1; return [_r, __ifaceNil];
		/* end */ case 2:
		/* */ if ( not ((zoneOffset == -1))) { __s = 4; continue; end
		/* */ __s = 5; continue;
		/* if ( not ((zoneOffset == -1))) { */ case 4:
			_r__1 = Date(year, ((month >> 0)), day, hour, min, sec, nsec, __pkg.UTC); /* */ __s = 6; case 6: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			t = __clone(_r__1, Time);
			t.addSec((x = (new __Int64(0, zoneOffset)), new __Int64(-x.__high, -x.__low)));
			_r__2 = local.lookup(t.unixSec()); /* */ __s = 7; case 7: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
			_tuple__22 = _r__2;
			name = _tuple__22[0];
			offset = _tuple__22[1];
			if ((offset == zoneOffset)  and  (zoneName == ""  or  name == zoneName)) {
				t.setLoc(local);
				__s = -1; return [t, __ifaceNil];
			end
			t.setLoc(FixedZone(zoneName, zoneOffset));
			__s = -1; return [t, __ifaceNil];
		/* end */ case 5:
		/* */ if ( not (zoneName == "")) { __s = 8; continue; end
		/* */ __s = 9; continue;
		/* if ( not (zoneName == "")) { */ case 8:
			_r__3 = Date(year, ((month >> 0)), day, hour, min, sec, nsec, __pkg.UTC); /* */ __s = 10; case 10: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
			t__1 = __clone(_r__3, Time);
			_r__4 = local.lookupName(zoneName, t__1.unixSec()); /* */ __s = 11; case 11: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
			_tuple__23 = _r__4;
			offset__1 = _tuple__23[0];
			ok__1 = _tuple__23[2];
			if (ok__1) {
				t__1.addSec((x__1 = (new __Int64(0, offset__1)), new __Int64(-x__1.__high, -x__1.__low)));
				t__1.setLoc(local);
				__s = -1; return [t__1, __ifaceNil];
			end
			if (zoneName.length > 3  and  __substring(zoneName, 0, 3) == "GMT") {
				_tuple__24 = atoi(__substring(zoneName, 3));
				offset__1 = _tuple__24[0];
				offset__1 = __imul(offset__1, (3600));
			end
			t__1.setLoc(FixedZone(zoneName, offset__1));
			__s = -1; return [t__1, __ifaceNil];
		/* end */ case 9:
		_r__5 = Date(year, ((month >> 0)), day, hour, min, sec, nsec, defaultLocation); /* */ __s = 12; case 12: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
		__s = -1; return [_r__5, __ifaceNil];
		/* */ end return; end if __f == nil then  __f = { __blk: parse end; end __f._1 = _1; __f._2 = _2; __f._3 = _3; __f._4 = _4; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__10 = _tmp__10; __f._tmp__11 = _tmp__11; __f._tmp__12 = _tmp__12; __f._tmp__13 = _tmp__13; __f._tmp__14 = _tmp__14; __f._tmp__15 = _tmp__15; __f._tmp__16 = _tmp__16; __f._tmp__17 = _tmp__17; __f._tmp__18 = _tmp__18; __f._tmp__19 = _tmp__19; __f._tmp__2 = _tmp__2; __f._tmp__20 = _tmp__20; __f._tmp__21 = _tmp__21; __f._tmp__22 = _tmp__22; __f._tmp__23 = _tmp__23; __f._tmp__24 = _tmp__24; __f._tmp__25 = _tmp__25; __f._tmp__26 = _tmp__26; __f._tmp__27 = _tmp__27; __f._tmp__28 = _tmp__28; __f._tmp__29 = _tmp__29; __f._tmp__3 = _tmp__3; __f._tmp__30 = _tmp__30; __f._tmp__31 = _tmp__31; __f._tmp__32 = _tmp__32; __f._tmp__33 = _tmp__33; __f._tmp__34 = _tmp__34; __f._tmp__35 = _tmp__35; __f._tmp__36 = _tmp__36; __f._tmp__37 = _tmp__37; __f._tmp__38 = _tmp__38; __f._tmp__39 = _tmp__39; __f._tmp__4 = _tmp__4; __f._tmp__40 = _tmp__40; __f._tmp__41 = _tmp__41; __f._tmp__42 = _tmp__42; __f._tmp__43 = _tmp__43; __f._tmp__5 = _tmp__5; __f._tmp__6 = _tmp__6; __f._tmp__7 = _tmp__7; __f._tmp__8 = _tmp__8; __f._tmp__9 = _tmp__9; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__10 = _tuple__10; __f._tuple__11 = _tuple__11; __f._tuple__12 = _tuple__12; __f._tuple__13 = _tuple__13; __f._tuple__14 = _tuple__14; __f._tuple__15 = _tuple__15; __f._tuple__16 = _tuple__16; __f._tuple__17 = _tuple__17; __f._tuple__18 = _tuple__18; __f._tuple__19 = _tuple__19; __f._tuple__2 = _tuple__2; __f._tuple__20 = _tuple__20; __f._tuple__21 = _tuple__21; __f._tuple__22 = _tuple__22; __f._tuple__23 = _tuple__23; __f._tuple__24 = _tuple__24; __f._tuple__3 = _tuple__3; __f._tuple__4 = _tuple__4; __f._tuple__5 = _tuple__5; __f._tuple__6 = _tuple__6; __f._tuple__7 = _tuple__7; __f._tuple__8 = _tuple__8; __f._tuple__9 = _tuple__9; __f.alayout = alayout; __f.amSet = amSet; __f.avalue = avalue; __f.day = day; __f.defaultLocation = defaultLocation; __f.err = err; __f.hour = hour; __f.hour__1 = hour__1; __f.hr = hr; __f.i = i; __f.layout = layout; __f.local = local; __f.min = min; __f.min__1 = min__1; __f.mm = mm; __f.month = month; __f.n = n; __f.n__1 = n__1; __f.name = name; __f.ndigit = ndigit; __f.nsec = nsec; __f.offset = offset; __f.offset__1 = offset__1; __f.ok = ok; __f.ok__1 = ok__1; __f.p = p; __f.pmSet = pmSet; __f.prefix = prefix; __f.rangeErrString = rangeErrString; __f.sec = sec; __f.seconds = seconds; __f.sign = sign; __f.ss = ss; __f.std = std; __f.stdstr = stdstr; __f.suffix = suffix; __f.t = t; __f.t__1 = t__1; __f.value = value; __f.x = x; __f.x__1 = x__1; __f.year = year; __f.z = z; __f.zoneName = zoneName; __f.zoneOffset = zoneOffset; __f.__s = __s; __f.__r = __r; return __f;
	end;
	parseTimeZone = function(e)
		var _1, _tmp, _tmp__1, _tmp__10, _tmp__11, _tmp__12, _tmp__13, _tmp__14, _tmp__15, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tmp__8, _tmp__9, c, length, nUpper, ok, value;
		length = 0;
		ok = false;
		if (value.length < 3) {
			_tmp = 0;
			_tmp__1 = false;
			length = _tmp;
			ok = _tmp__1;
			return [length, ok];
		end
		if (value.length >= 4  and  (__substring(value, 0, 4) == "ChST"  or  __substring(value, 0, 4) == "MeST")) {
			_tmp__2 = 4;
			_tmp__3 = true;
			length = _tmp__2;
			ok = _tmp__3;
			return [length, ok];
		end
		if (__substring(value, 0, 3) == "GMT") {
			length = parseGMT(value);
			_tmp__4 = length;
			_tmp__5 = true;
			length = _tmp__4;
			ok = _tmp__5;
			return [length, ok];
		end
		nUpper = 0;
		nUpper = 0;
		while (true) {
			if ( not (nUpper < 6)) { break; end
			if (nUpper >= value.length) {
				break;
			end
			c = value.charCodeAt(nUpper);
			if (c < 65  or  90 < c) {
				break;
			end
			nUpper = nUpper + (1) >> 0;
		end
		_1 = nUpper;
		if ((_1 == (0))  or  (_1 == (1))  or  (_1 == (2))  or  (_1 == (6))) {
			_tmp__6 = 0;
			_tmp__7 = false;
			length = _tmp__6;
			ok = _tmp__7;
			return [length, ok];
		end else if (_1 == (5)) {
			if (value.charCodeAt(4) == 84) {
				_tmp__8 = 5;
				_tmp__9 = true;
				length = _tmp__8;
				ok = _tmp__9;
				return [length, ok];
			end
		end else if (_1 == (4)) {
			if ((value.charCodeAt(3) == 84)  or  __substring(value, 0, 4) == "WITA") {
				_tmp__10 = 4;
				_tmp__11 = true;
				length = _tmp__10;
				ok = _tmp__11;
				return [length, ok];
			end
		end else if (_1 == (3)) {
			_tmp__12 = 3;
			_tmp__13 = true;
			length = _tmp__12;
			ok = _tmp__13;
			return [length, ok];
		end
		_tmp__14 = 0;
		_tmp__15 = false;
		length = _tmp__14;
		ok = _tmp__15;
		return [length, ok];
	end;
	parseGMT = function(e)
		var _tuple, err, rem, sign, value, x;
		value = __substring(value, 3);
		if (value.length == 0) {
			return 3;
		end
		sign = value.charCodeAt(0);
		if ( not ((sign == 45))  and   not ((sign == 43))) {
			return 3;
		end
		_tuple = leadingInt(__substring(value, 1));
		x = _tuple[0];
		rem = _tuple[1];
		err = _tuple[2];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			return 3;
		end
		if (sign == 45) {
			x = new __Int64(-x.__high, -x.__low);
		end
		if ((x.__high == 0  and  x.__low == 0)  or  (x.__high < -1  or  (x.__high == -1  and  x.__low < 4294967282))  or  (0 < x.__high  or  (0 == x.__high  and  12 < x.__low))) {
			return 3;
		end
		return (3 + value.length >> 0) - rem.length >> 0;
	end;
	parseNanoseconds = function(s)
		var _tuple, err, i, nbytes, ns, rangeErrString, scaleDigits, value;
		ns = 0;
		rangeErrString = "";
		err = __ifaceNil;
		if ( not ((value.charCodeAt(0) == 46))) {
			err = errBad;
			return [ns, rangeErrString, err];
		end
		_tuple = atoi(__substring(value, 1, nbytes));
		ns = _tuple[0];
		err = _tuple[1];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			return [ns, rangeErrString, err];
		end
		if (ns < 0  or  1000000000 <= ns) {
			rangeErrString = "fractional second";
			return [ns, rangeErrString, err];
		end
		scaleDigits = 10 - nbytes >> 0;
		i = 0;
		while (true) {
			if ( not (i < scaleDigits)) { break; end
			ns = __imul(ns, (10));
			i = i + (1) >> 0;
		end
		return [ns, rangeErrString, err];
	end;
	leadingInt = function(s)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tmp__8, c, err, i, rem, s, x, x__1, x__2, x__3;
		x = new __Int64(0, 0);
		rem = "";
		err = __ifaceNil;
		i = 0;
		while (true) {
			if ( not (i < s.length)) { break; end
			c = s.charCodeAt(i);
			if (c < 48  or  c > 57) {
				break;
			end
			if ((x.__high > 214748364  or  (x.__high == 214748364  and  x.__low > 3435973836))) {
				_tmp = new __Int64(0, 0);
				_tmp__1 = "";
				_tmp__2 = errLeadingInt;
				x = _tmp;
				rem = _tmp__1;
				err = _tmp__2;
				return [x, rem, err];
			end
			x = (x__1 = (x__2 = __mul64(x, new __Int64(0, 10)), x__3 = (new __Int64(0, c)), new __Int64(x__2.__high + x__3.__high, x__2.__low + x__3.__low)), new __Int64(x__1.__high - 0, x__1.__low - 48));
			if ((x.__high < 0  or  (x.__high == 0  and  x.__low < 0))) {
				_tmp__3 = new __Int64(0, 0);
				_tmp__4 = "";
				_tmp__5 = errLeadingInt;
				x = _tmp__3;
				rem = _tmp__4;
				err = _tmp__5;
				return [x, rem, err];
			end
			i = i + (1) >> 0;
		end
		_tmp__6 = x;
		_tmp__7 = __substring(s, i);
		_tmp__8 = __ifaceNil;
		x = _tmp__6;
		rem = _tmp__7;
		err = _tmp__8;
		return [x, rem, err];
	end;
	Time.ptr.prototype.nsec = function()
		var t, x;
		t = this;
		return (((x = t.wall, new __Uint64(x.__high & 0, (x.__low & 1073741823) >>> 0)).__low >> 0));
	end;
	Time.prototype.nsec = function() return this.__val.nsec(); end;
	Time.ptr.prototype.sec = function()
		var t, x, x__1, x__2, x__3;
		t = this;
		if ( not ((x = (x__1 = t.wall, new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			return (x__2 = ((x__3 = __shiftRightUint64(__shiftLeft64(t.wall, 1), 31), new __Int64(x__3.__high, x__3.__low))), new __Int64(13 + x__2.__high, 3618733952 + x__2.__low));
		end
		return (t.ext);
	end;
	Time.prototype.sec = function() return this.__val.sec(); end;
	Time.ptr.prototype.unixSec = function()
		var t, x;
		t = this;
		return (x = t.sec(), new __Int64(x.__high + -15, x.__low + 2288912640));
	end;
	Time.prototype.unixSec = function() return this.__val.unixSec(); end;
	Time.ptr.prototype.addSec = function(d)
		var d, dsec, sec, t, x, x__1, x__2, x__3, x__4, x__5, x__6, x__7, x__8;
		t = this;
		if ( not ((x = (x__1 = t.wall, new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			sec = ((x__2 = __shiftRightUint64(__shiftLeft64(t.wall, 1), 31), new __Int64(x__2.__high, x__2.__low)));
			dsec = new __Int64(sec.__high + d.__high, sec.__low + d.__low);
			if ((0 < dsec.__high  or  (0 == dsec.__high  and  0 <= dsec.__low))  and  (dsec.__high < 1  or  (dsec.__high == 1  and  dsec.__low <= 4294967295))) {
				t.wall = (x__3 = (x__4 = (x__5 = t.wall, new __Uint64(x__5.__high & 0, (x__5.__low & 1073741823) >>> 0)), x__6 = __shiftLeft64((new __Uint64(dsec.__high, dsec.__low)), 30), new __Uint64(x__4.__high | x__6.__high, (x__4.__low | x__6.__low) >>> 0)), new __Uint64(x__3.__high | 2147483648, (x__3.__low | 0) >>> 0));
				return;
			end
			t.stripMono();
		end
		t.ext = (x__7 = t.ext, x__8 = d, new __Int64(x__7.__high + x__8.__high, x__7.__low + x__8.__low));
	end;
	Time.prototype.addSec = function(d) return this.__val.addSec(d); end;
	Time.ptr.prototype.setLoc = function(c)
		var loc, t;
		t = this;
		if (loc == utcLoc) {
			loc = ptrType__2.nil;
		end
		t.stripMono();
		t.loc = loc;
	end;
	Time.prototype.setLoc = function(c) return this.__val.setLoc(loc); end;
	Time.ptr.prototype.stripMono = function()
		var t, x, x__1, x__2, x__3;
		t = this;
		if ( not ((x = (x__1 = t.wall, new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			t.ext = t.sec();
			t.wall = (x__2 = t.wall, x__3 = new __Uint64(0, 1073741823), new __Uint64(x__2.__high & x__3.__high, (x__2.__low & x__3.__low) >>> 0));
		end
	end;
	Time.prototype.stripMono = function() return this.__val.stripMono(); end;
	Time.ptr.prototype.After = function(u)
		var t, ts, u, us, x, x__1, x__2, x__3, x__4, x__5;
		t = this;
		if ( not ((x = (x__1 = (x__2 = t.wall, x__3 = u.wall, new __Uint64(x__2.__high & x__3.__high, (x__2.__low & x__3.__low) >>> 0)), new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			return (x__4 = t.ext, x__5 = u.ext, (x__4.__high > x__5.__high  or  (x__4.__high == x__5.__high  and  x__4.__low > x__5.__low)));
		end
		ts = t.sec();
		us = u.sec();
		return (ts.__high > us.__high  or  (ts.__high == us.__high  and  ts.__low > us.__low))  or  (ts.__high == us.__high  and  ts.__low == us.__low)  and  t.nsec() > u.nsec();
	end;
	Time.prototype.After = function(u) return this.__val.After(u); end;
	Time.ptr.prototype.Before = function(u)
		var t, u, x, x__1, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		t = this;
		if ( not ((x = (x__1 = (x__2 = t.wall, x__3 = u.wall, new __Uint64(x__2.__high & x__3.__high, (x__2.__low & x__3.__low) >>> 0)), new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			return (x__4 = t.ext, x__5 = u.ext, (x__4.__high < x__5.__high  or  (x__4.__high == x__5.__high  and  x__4.__low < x__5.__low)));
		end
		return (x__6 = t.sec(), x__7 = u.sec(), (x__6.__high < x__7.__high  or  (x__6.__high == x__7.__high  and  x__6.__low < x__7.__low)))  or  (x__8 = t.sec(), x__9 = u.sec(), (x__8.__high == x__9.__high  and  x__8.__low == x__9.__low))  and  t.nsec() < u.nsec();
	end;
	Time.prototype.Before = function(u) return this.__val.Before(u); end;
	Time.ptr.prototype.Equal = function(u)
		var t, u, x, x__1, x__2, x__3, x__4, x__5, x__6, x__7;
		t = this;
		if ( not ((x = (x__1 = (x__2 = t.wall, x__3 = u.wall, new __Uint64(x__2.__high & x__3.__high, (x__2.__low & x__3.__low) >>> 0)), new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			return (x__4 = t.ext, x__5 = u.ext, (x__4.__high == x__5.__high  and  x__4.__low == x__5.__low));
		end
		return (x__6 = t.sec(), x__7 = u.sec(), (x__6.__high == x__7.__high  and  x__6.__low == x__7.__low))  and  (t.nsec() == u.nsec());
	end;
	Time.prototype.Equal = function(u) return this.__val.Equal(u); end;
	Month.prototype.String = function()
		var buf, m, n, x;
		m = this.__val;
		if (1 <= m  and  m <= 12) {
			return (x = m - 1 >> 0, ((x < 0  or  x >= months.length) ? (__throwRuntimeError("index out of range"), nil) : months[x]));
		end
		buf = __makeSlice(sliceType__3, 20);
		n = fmtInt(buf, (new __Uint64(0, m)));
		return "% not Month(" + (__bytesToString(__subslice(buf, n))) + ")";
	end;
	__ptrType(Month).prototype.String = function() return new Month(this.__get()).String(); end;
	Weekday.prototype.String = function()
		var d;
		d = this.__val;
		return ((d < 0  or  d >= days.length) ? (__throwRuntimeError("index out of range"), nil) : days[d]);
	end;
	__ptrType(Weekday).prototype.String = function() return new Weekday(this.__get()).String(); end;
	Time.ptr.prototype.IsZero = function()
		var t, x;
		t = this;
		return (x = t.sec(), (x.__high == 0  and  x.__low == 0))  and  (t.nsec() == 0);
	end;
	Time.prototype.IsZero = function() return this.__val.IsZero(); end;
	Time.ptr.prototype.abs = function()
		var _r, _r__1, _tuple, l, offset, sec, t, x, x__1, x__2, x__3, x__4, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; l = __f.l; offset = __f.offset; sec = __f.sec; t = __f.t; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; x__3 = __f.x__3; x__4 = __f.x__4; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		l = t.loc;
		/* */ if (l == ptrType__2.nil  or  l == localLoc) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (l == ptrType__2.nil  or  l == localLoc) { */ case 1:
			_r = l.get(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			l = _r;
		/* end */ case 2:
		sec = t.unixSec();
		/* */ if ( not (l == utcLoc)) { __s = 4; continue; end
		/* */ __s = 5; continue;
		/* if ( not (l == utcLoc)) { */ case 4:
			/* */ if ( not (l.cacheZone == ptrType.nil)  and  (x = l.cacheStart, (x.__high < sec.__high  or  (x.__high == sec.__high  and  x.__low <= sec.__low)))  and  (x__1 = l.cacheEnd, (sec.__high < x__1.__high  or  (sec.__high == x__1.__high  and  sec.__low < x__1.__low)))) { __s = 6; continue; end
			/* */ __s = 7; continue;
			/* if ( not (l.cacheZone == ptrType.nil)  and  (x = l.cacheStart, (x.__high < sec.__high  or  (x.__high == sec.__high  and  x.__low <= sec.__low)))  and  (x__1 = l.cacheEnd, (sec.__high < x__1.__high  or  (sec.__high == x__1.__high  and  sec.__low < x__1.__low)))) { */ case 6:
				sec = (x__2 = (new __Int64(0, l.cacheZone.offset)), new __Int64(sec.__high + x__2.__high, sec.__low + x__2.__low));
				__s = 8; continue;
			/* end else { */ case 7:
				_r__1 = l.lookup(sec); /* */ __s = 9; case 9: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				_tuple = _r__1;
				offset = _tuple[1];
				sec = (x__3 = (new __Int64(0, offset)), new __Int64(sec.__high + x__3.__high, sec.__low + x__3.__low));
			/* end */ case 8:
		/* end */ case 5:
		__s = -1; return ((x__4 = new __Int64(sec.__high + 2147483646, sec.__low + 450480384), new __Uint64(x__4.__high, x__4.__low)));
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.abs end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.l = l; __f.offset = offset; __f.sec = sec; __f.t = t; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.x__3 = x__3; __f.x__4 = x__4; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.abs = function() return this.__val.abs(); end;
	Time.ptr.prototype.locabs = function()
		var _r, _r__1, _tuple, abs, l, name, offset, sec, t, x, x__1, x__2, x__3, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; abs = __f.abs; l = __f.l; name = __f.name; offset = __f.offset; sec = __f.sec; t = __f.t; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; x__3 = __f.x__3; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		name = "";
		offset = 0;
		abs = new __Uint64(0, 0);
		t = this;
		l = t.loc;
		/* */ if (l == ptrType__2.nil  or  l == localLoc) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (l == ptrType__2.nil  or  l == localLoc) { */ case 1:
			_r = l.get(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			l = _r;
		/* end */ case 2:
		sec = t.unixSec();
		/* */ if ( not (l == utcLoc)) { __s = 4; continue; end
		/* */ __s = 5; continue;
		/* if ( not (l == utcLoc)) { */ case 4:
			/* */ if ( not (l.cacheZone == ptrType.nil)  and  (x = l.cacheStart, (x.__high < sec.__high  or  (x.__high == sec.__high  and  x.__low <= sec.__low)))  and  (x__1 = l.cacheEnd, (sec.__high < x__1.__high  or  (sec.__high == x__1.__high  and  sec.__low < x__1.__low)))) { __s = 7; continue; end
			/* */ __s = 8; continue;
			/* if ( not (l.cacheZone == ptrType.nil)  and  (x = l.cacheStart, (x.__high < sec.__high  or  (x.__high == sec.__high  and  x.__low <= sec.__low)))  and  (x__1 = l.cacheEnd, (sec.__high < x__1.__high  or  (sec.__high == x__1.__high  and  sec.__low < x__1.__low)))) { */ case 7:
				name = l.cacheZone.name;
				offset = l.cacheZone.offset;
				__s = 9; continue;
			/* end else { */ case 8:
				_r__1 = l.lookup(sec); /* */ __s = 10; case 10: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				_tuple = _r__1;
				name = _tuple[0];
				offset = _tuple[1];
			/* end */ case 9:
			sec = (x__2 = (new __Int64(0, offset)), new __Int64(sec.__high + x__2.__high, sec.__low + x__2.__low));
			__s = 6; continue;
		/* end else { */ case 5:
			name = "UTC";
		/* end */ case 6:
		abs = ((x__3 = new __Int64(sec.__high + 2147483646, sec.__low + 450480384), new __Uint64(x__3.__high, x__3.__low)));
		__s = -1; return [name, offset, abs];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.locabs end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.abs = abs; __f.l = l; __f.name = name; __f.offset = offset; __f.sec = sec; __f.t = t; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.x__3 = x__3; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.locabs = function() return this.__val.locabs(); end;
	Time.ptr.prototype.Date = function()
		var _r, _tuple, day, month, t, year, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; day = __f.day; month = __f.month; t = __f.t; year = __f.year; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		year = 0;
		month = 0;
		day = 0;
		t = this;
		_r = __clone(t, Time).date(true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		year = _tuple[0];
		month = _tuple[1];
		day = _tuple[2];
		__s = -1; return [year, month, day];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Date end; end __f._r = _r; __f._tuple = _tuple; __f.day = day; __f.month = month; __f.t = t; __f.year = year; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Date = function() return this.__val.Date(); end;
	Time.ptr.prototype.Year = function()
		var _r, _tuple, t, year, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; t = __f.t; year = __f.year; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).date(false); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		year = _tuple[0];
		__s = -1; return year;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Year end; end __f._r = _r; __f._tuple = _tuple; __f.t = t; __f.year = year; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Year = function() return this.__val.Year(); end;
	Time.ptr.prototype.Month = function()
		var _r, _tuple, month, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; month = __f.month; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).date(true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		month = _tuple[1];
		__s = -1; return month;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Month end; end __f._r = _r; __f._tuple = _tuple; __f.month = month; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Month = function() return this.__val.Month(); end;
	Time.ptr.prototype.Day = function()
		var _r, _tuple, day, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; day = __f.day; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).date(true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		day = _tuple[2];
		__s = -1; return day;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Day end; end __f._r = _r; __f._tuple = _tuple; __f.day = day; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Day = function() return this.__val.Day(); end;
	Time.ptr.prototype.Weekday = function()
		var _r, _r__1, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).abs(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = absWeekday(_r); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Weekday end; end __f._r = _r; __f._r__1 = _r__1; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Weekday = function() return this.__val.Weekday(); end;
	absWeekday = function(s)
		var _q, abs, sec;
		sec = __div64((new __Uint64(abs.__high + 0, abs.__low + 86400)), new __Uint64(0, 604800), true);
		return (((_q = ((sec.__low >> 0)) / 86400, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) >> 0));
	end;
	Time.ptr.prototype.ISOWeek = function()
		var _q, _r, _r__1, _r__2, _r__3, _r__4, _tuple, day, dec31wday, jan1wday, month, t, wday, week, yday, year, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _q = __f._q; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _tuple = __f._tuple; day = __f.day; dec31wday = __f.dec31wday; jan1wday = __f.jan1wday; month = __f.month; t = __f.t; wday = __f.wday; week = __f.week; yday = __f.yday; year = __f.year; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		year = 0;
		week = 0;
		t = this;
		_r = __clone(t, Time).date(true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		year = _tuple[0];
		month = _tuple[1];
		day = _tuple[2];
		yday = _tuple[3];
		_r__2 = __clone(t, Time).Weekday(); /* */ __s = 2; case 2: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		wday = (_r__1 = (((_r__2 + 6 >> 0) >> 0)) % 7, _r__1 == _r__1 ? _r__1 : __throwRuntimeError("integer divide by zero"));
		week = (_q = (((yday - wday >> 0) + 7 >> 0)) / 7, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
		jan1wday = (_r__3 = (((wday - yday >> 0) + 371 >> 0)) % 7, _r__3 == _r__3 ? _r__3 : __throwRuntimeError("integer divide by zero"));
		if (1 <= jan1wday  and  jan1wday <= 3) {
			week = week + (1) >> 0;
		end
		if (week == 0) {
			year = year - (1) >> 0;
			week = 52;
			if ((jan1wday == 4)  or  ((jan1wday == 5)  and  isLeap(year))) {
				week = week + (1) >> 0;
			end
		end
		if ((month == 12)  and  day >= 29  and  wday < 3) {
			dec31wday = (_r__4 = (((wday + 31 >> 0) - day >> 0)) % 7, _r__4 == _r__4 ? _r__4 : __throwRuntimeError("integer divide by zero"));
			if (0 <= dec31wday  and  dec31wday <= 2) {
				year = year + (1) >> 0;
				week = 1;
			end
		end
		__s = -1; return [year, week];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.ISOWeek end; end __f._q = _q; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._tuple = _tuple; __f.day = day; __f.dec31wday = dec31wday; __f.jan1wday = jan1wday; __f.month = month; __f.t = t; __f.wday = wday; __f.week = week; __f.yday = yday; __f.year = year; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.ISOWeek = function() return this.__val.ISOWeek(); end;
	Time.ptr.prototype.Clock = function()
		var _r, _r__1, _tuple, hour, min, sec, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; hour = __f.hour; min = __f.min; sec = __f.sec; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		hour = 0;
		min = 0;
		sec = 0;
		t = this;
		_r = __clone(t, Time).abs(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = absClock(_r); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_tuple = _r__1;
		hour = _tuple[0];
		min = _tuple[1];
		sec = _tuple[2];
		__s = -1; return [hour, min, sec];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Clock end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.hour = hour; __f.min = min; __f.sec = sec; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Clock = function() return this.__val.Clock(); end;
	absClock = function(s)
		var _q, _q__1, abs, hour, min, sec;
		hour = 0;
		min = 0;
		sec = 0;
		sec = ((__div64(abs, new __Uint64(0, 86400), true).__low >> 0));
		hour = (_q = sec / 3600, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
		sec = sec - ((__imul(hour, 3600))) >> 0;
		min = (_q__1 = sec / 60, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >> 0 : __throwRuntimeError("integer divide by zero"));
		sec = sec - ((__imul(min, 60))) >> 0;
		return [hour, min, sec];
	end;
	Time.ptr.prototype.Hour = function()
		var _q, _r, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _q = __f._q; _r = __f._r; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).abs(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return (_q = ((__div64(_r, new __Uint64(0, 86400), true).__low >> 0)) / 3600, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Hour end; end __f._q = _q; __f._r = _r; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Hour = function() return this.__val.Hour(); end;
	Time.ptr.prototype.Minute = function()
		var _q, _r, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _q = __f._q; _r = __f._r; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).abs(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return (_q = ((__div64(_r, new __Uint64(0, 3600), true).__low >> 0)) / 60, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Minute end; end __f._q = _q; __f._r = _r; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Minute = function() return this.__val.Minute(); end;
	Time.ptr.prototype.Second = function()
		var _r, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).abs(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return ((__div64(_r, new __Uint64(0, 60), true).__low >> 0));
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Second end; end __f._r = _r; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Second = function() return this.__val.Second(); end;
	Time.ptr.prototype.Nanosecond = function()
		var t;
		t = this;
		return ((t.nsec() >> 0));
	end;
	Time.prototype.Nanosecond = function() return this.__val.Nanosecond(); end;
	Time.ptr.prototype.YearDay = function()
		var _r, _tuple, t, yday, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; t = __f.t; yday = __f.yday; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).date(false); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		yday = _tuple[3];
		__s = -1; return yday + 1 >> 0;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.YearDay end; end __f._r = _r; __f._tuple = _tuple; __f.t = t; __f.yday = yday; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.YearDay = function() return this.__val.YearDay(); end;
	Duration.prototype.String = function()
		var _tuple, _tuple__1, buf, d, neg, prec, u, w;
		d = this;
		buf = arrayType__4.zero();
		w = 32;
		u = (new __Uint64(d.__high, d.__low));
		neg = (d.__high < 0  or  (d.__high == 0  and  d.__low < 0));
		if (neg) {
			u = new __Uint64(-u.__high, -u.__low);
		end
		if ((u.__high < 0  or  (u.__high == 0  and  u.__low < 1000000000))) {
			prec = 0;
			w = w - (1) >> 0;
			((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 115);
			w = w - (1) >> 0;
			if ((u.__high == 0  and  u.__low == 0)) {
				return "0s";
			end else if ((u.__high < 0  or  (u.__high == 0  and  u.__low < 1000))) {
				prec = 0;
				((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 110);
			end else if ((u.__high < 0  or  (u.__high == 0  and  u.__low < 1000000))) {
				prec = 3;
				w = w - (1) >> 0;
				__copyString(__subslice(new sliceType__3(buf), w), "\xC2\xB5");
			end else {
				prec = 6;
				((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 109);
			end
			_tuple = fmtFrac(__subslice(new sliceType__3(buf), 0, w), u, prec);
			w = _tuple[0];
			u = _tuple[1];
			w = fmtInt(__subslice(new sliceType__3(buf), 0, w), u);
		end else {
			w = w - (1) >> 0;
			((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 115);
			_tuple__1 = fmtFrac(__subslice(new sliceType__3(buf), 0, w), u, 9);
			w = _tuple__1[0];
			u = _tuple__1[1];
			w = fmtInt(__subslice(new sliceType__3(buf), 0, w), __div64(u, new __Uint64(0, 60), true));
			u = __div64(u, (new __Uint64(0, 60)), false);
			if ((u.__high > 0  or  (u.__high == 0  and  u.__low > 0))) {
				w = w - (1) >> 0;
				((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 109);
				w = fmtInt(__subslice(new sliceType__3(buf), 0, w), __div64(u, new __Uint64(0, 60), true));
				u = __div64(u, (new __Uint64(0, 60)), false);
				if ((u.__high > 0  or  (u.__high == 0  and  u.__low > 0))) {
					w = w - (1) >> 0;
					((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 104);
					w = fmtInt(__subslice(new sliceType__3(buf), 0, w), u);
				end
			end
		end
		if (neg) {
			w = w - (1) >> 0;
			((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 45);
		end
		return (__bytesToString(__subslice(new sliceType__3(buf), w)));
	end;
	__ptrType(Duration).prototype.String = function() return this.__get().String(); end;
	fmtFrac = function(c)
		var _tmp, _tmp__1, buf, digit, i, nv, nw, prec, print, v, w;
		nw = 0;
		nv = new __Uint64(0, 0);
		w = buf.__length;
		print = false;
		i = 0;
		while (true) {
			if ( not (i < prec)) { break; end
			digit = __div64(v, new __Uint64(0, 10), true);
			print = print  or   not ((digit.__high == 0  and  digit.__low == 0));
			if (print) {
				w = w - (1) >> 0;
				((w < 0  or  w >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + w] = (((digit.__low << 24 >>> 24)) + 48 << 24 >>> 24));
			end
			v = __div64(v, (new __Uint64(0, 10)), false);
			i = i + (1) >> 0;
		end
		if (print) {
			w = w - (1) >> 0;
			((w < 0  or  w >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + w] = 46);
		end
		_tmp = w;
		_tmp__1 = v;
		nw = _tmp;
		nv = _tmp__1;
		return [nw, nv];
	end;
	fmtInt = function(v)
		var buf, v, w;
		w = buf.__length;
		if ((v.__high == 0  and  v.__low == 0)) {
			w = w - (1) >> 0;
			((w < 0  or  w >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + w] = 48);
		end else {
			while (true) {
				if ( not ((v.__high > 0  or  (v.__high == 0  and  v.__low > 0)))) { break; end
				w = w - (1) >> 0;
				((w < 0  or  w >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + w] = (((__div64(v, new __Uint64(0, 10), true).__low << 24 >>> 24)) + 48 << 24 >>> 24));
				v = __div64(v, (new __Uint64(0, 10)), false);
			end
		end
		return w;
	end;
	Duration.prototype.Nanoseconds = function()
		var d;
		d = this;
		return (new __Int64(d.__high, d.__low));
	end;
	__ptrType(Duration).prototype.Nanoseconds = function() return this.__get().Nanoseconds(); end;
	Duration.prototype.Seconds = function()
		var d, nsec, sec;
		d = this;
		sec = __div64(d, new Duration(0, 1000000000), false);
		nsec = __div64(d, new Duration(0, 1000000000), true);
		return (__flatten64(sec)) + (__flatten64(nsec)) / 1e+09;
	end;
	__ptrType(Duration).prototype.Seconds = function() return this.__get().Seconds(); end;
	Duration.prototype.Minutes = function()
		var d, min, nsec;
		d = this;
		min = __div64(d, new Duration(13, 4165425152), false);
		nsec = __div64(d, new Duration(13, 4165425152), true);
		return (__flatten64(min)) + (__flatten64(nsec)) / 6e+10;
	end;
	__ptrType(Duration).prototype.Minutes = function() return this.__get().Minutes(); end;
	Duration.prototype.Hours = function()
		var d, hour, nsec;
		d = this;
		hour = __div64(d, new Duration(838, 817405952), false);
		nsec = __div64(d, new Duration(838, 817405952), true);
		return (__flatten64(hour)) + (__flatten64(nsec)) / 3.6e+12;
	end;
	__ptrType(Duration).prototype.Hours = function() return this.__get().Hours(); end;
	Duration.prototype.Truncate = function(m)
		var d, m, x;
		d = this;
		if ((m.__high < 0  or  (m.__high == 0  and  m.__low <= 0))) {
			return d;
		end
		return (x = __div64(d, m, true), new Duration(d.__high - x.__high, d.__low - x.__low));
	end;
	__ptrType(Duration).prototype.Truncate = function(m) return this.__get().Truncate(m); end;
	lessThanHalf = function(y)
		var x, x__1, x__2, x__3, x__4, y;
		return (x__1 = (x__2 = (new __Uint64(x.__high, x.__low)), x__3 = (new __Uint64(x.__high, x.__low)), new __Uint64(x__2.__high + x__3.__high, x__2.__low + x__3.__low)), x__4 = (new __Uint64(y.__high, y.__low)), (x__1.__high < x__4.__high  or  (x__1.__high == x__4.__high  and  x__1.__low < x__4.__low)));
	end;
	Duration.prototype.Round = function(m)
		var d, d1, d1__1, m, r, x, x__1;
		d = this;
		if ((m.__high < 0  or  (m.__high == 0  and  m.__low <= 0))) {
			return d;
		end
		r = __div64(d, m, true);
		if ((d.__high < 0  or  (d.__high == 0  and  d.__low < 0))) {
			r = new Duration(-r.__high, -r.__low);
			if (lessThanHalf(r, m)) {
				return new Duration(d.__high + r.__high, d.__low + r.__low);
			end
			d1 = (x = new Duration(d.__high - m.__high, d.__low - m.__low), new Duration(x.__high + r.__high, x.__low + r.__low));
			if ((d1.__high < d.__high  or  (d1.__high == d.__high  and  d1.__low < d.__low))) {
				return d1;
			end
			return new Duration(-2147483648, 0);
		end
		if (lessThanHalf(r, m)) {
			return new Duration(d.__high - r.__high, d.__low - r.__low);
		end
		d1__1 = (x__1 = new Duration(d.__high + m.__high, d.__low + m.__low), new Duration(x__1.__high - r.__high, x__1.__low - r.__low));
		if ((d1__1.__high > d.__high  or  (d1__1.__high == d.__high  and  d1__1.__low > d.__low))) {
			return d1__1;
		end
		return new Duration(2147483647, 4294967295);
	end;
	__ptrType(Duration).prototype.Round = function(m) return this.__get().Round(m); end;
	Time.ptr.prototype.Add = function(d)
		var d, dsec, nsec, t, te, x, x__1, x__10, x__11, x__12, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		t = this;
		dsec = ((x = __div64(d, new Duration(0, 1000000000), false), new __Int64(x.__high, x.__low)));
		nsec = t.nsec() + (((x__1 = __div64(d, new Duration(0, 1000000000), true), x__1.__low + ((x__1.__high >> 31) * 4294967296)) >> 0)) >> 0;
		if (nsec >= 1000000000) {
			dsec = (x__2 = new __Int64(0, 1), new __Int64(dsec.__high + x__2.__high, dsec.__low + x__2.__low));
			nsec = nsec - (1000000000) >> 0;
		end else if (nsec < 0) {
			dsec = (x__3 = new __Int64(0, 1), new __Int64(dsec.__high - x__3.__high, dsec.__low - x__3.__low));
			nsec = nsec + (1000000000) >> 0;
		end
		t.wall = (x__4 = (x__5 = t.wall, new __Uint64(x__5.__high & ~0, (x__5.__low & ~1073741823) >>> 0)), x__6 = (new __Uint64(0, nsec)), new __Uint64(x__4.__high | x__6.__high, (x__4.__low | x__6.__low) >>> 0));
		t.addSec(dsec);
		if ( not ((x__7 = (x__8 = t.wall, new __Uint64(x__8.__high & 2147483648, (x__8.__low & 0) >>> 0)), (x__7.__high == 0  and  x__7.__low == 0)))) {
			te = (x__9 = t.ext, x__10 = (new __Int64(d.__high, d.__low)), new __Int64(x__9.__high + x__10.__high, x__9.__low + x__10.__low));
			if ((d.__high < 0  or  (d.__high == 0  and  d.__low < 0))  and  (x__11 = (t.ext), (te.__high > x__11.__high  or  (te.__high == x__11.__high  and  te.__low > x__11.__low)))  or  (d.__high > 0  or  (d.__high == 0  and  d.__low > 0))  and  (x__12 = (t.ext), (te.__high < x__12.__high  or  (te.__high == x__12.__high  and  te.__low < x__12.__low)))) {
				t.stripMono();
			end else {
				t.ext = te;
			end
		end
		return t;
	end;
	Time.prototype.Add = function(d) return this.__val.Add(d); end;
	Time.ptr.prototype.Sub = function(u)
		var d, d__1, t, te, u, ue, x, x__1, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		t = this;
		if ( not ((x = (x__1 = (x__2 = t.wall, x__3 = u.wall, new __Uint64(x__2.__high & x__3.__high, (x__2.__low & x__3.__low) >>> 0)), new __Uint64(x__1.__high & 2147483648, (x__1.__low & 0) >>> 0)), (x.__high == 0  and  x.__low == 0)))) {
			te = (t.ext);
			ue = (u.ext);
			d = ((x__4 = new __Int64(te.__high - ue.__high, te.__low - ue.__low), new Duration(x__4.__high, x__4.__low)));
			if ((d.__high < 0  or  (d.__high == 0  and  d.__low < 0))  and  (te.__high > ue.__high  or  (te.__high == ue.__high  and  te.__low > ue.__low))) {
				return new Duration(2147483647, 4294967295);
			end
			if ((d.__high > 0  or  (d.__high == 0  and  d.__low > 0))  and  (te.__high < ue.__high  or  (te.__high == ue.__high  and  te.__low < ue.__low))) {
				return new Duration(-2147483648, 0);
			end
			return d;
		end
		d__1 = (x__5 = __mul64(((x__6 = (x__7 = t.sec(), x__8 = u.sec(), new __Int64(x__7.__high - x__8.__high, x__7.__low - x__8.__low)), new Duration(x__6.__high, x__6.__low))), new Duration(0, 1000000000)), x__9 = (new Duration(0, (t.nsec() - u.nsec() >> 0))), new Duration(x__5.__high + x__9.__high, x__5.__low + x__9.__low));
		if (__clone(__clone(u, Time).Add(d__1), Time).Equal(__clone(t, Time))) {
			return d__1;
		end else if (__clone(t, Time).Before(__clone(u, Time))) {
			return new Duration(-2147483648, 0);
		end else {
			return new Duration(2147483647, 4294967295);
		end
	end;
	Time.prototype.Sub = function(u) return this.__val.Sub(u); end;
	Time.ptr.prototype.AddDate = function(1)
		var _r, _r__1, _r__2, _tuple, _tuple__1, day, days__1, hour, min, month, months__1, sec, t, year, years, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; day = __f.day; days__1 = __f.days__1; hour = __f.hour; min = __f.min; month = __f.month; months__1 = __f.months__1; sec = __f.sec; t = __f.t; year = __f.year; years = __f.years; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).Date(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		year = _tuple[0];
		month = _tuple[1];
		day = _tuple[2];
		_r__1 = __clone(t, Time).Clock(); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_tuple__1 = _r__1;
		hour = _tuple__1[0];
		min = _tuple__1[1];
		sec = _tuple__1[2];
		_r__2 = Date(year + years >> 0, month + ((months__1 >> 0)) >> 0, day + days__1 >> 0, hour, min, sec, ((t.nsec() >> 0)), __clone(t, Time).Location()); /* */ __s = 3; case 3: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		__s = -1; return _r__2;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.AddDate end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f.day = day; __f.days__1 = days__1; __f.hour = hour; __f.min = min; __f.month = month; __f.months__1 = months__1; __f.sec = sec; __f.t = t; __f.year = year; __f.years = years; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.AddDate = function(1) return this.__val.AddDate(years, months__1, days__1); end;
	Time.ptr.prototype.date = function(l)
		var _r, _r__1, _tuple, day, full, month, t, yday, year, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; day = __f.day; full = __f.full; month = __f.month; t = __f.t; yday = __f.yday; year = __f.year; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		year = 0;
		month = 0;
		day = 0;
		yday = 0;
		t = this;
		_r = __clone(t, Time).abs(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = absDate(_r, full); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_tuple = _r__1;
		year = _tuple[0];
		month = _tuple[1];
		day = _tuple[2];
		yday = _tuple[3];
		__s = -1; return [year, month, day, yday];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.date end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.day = day; __f.full = full; __f.month = month; __f.t = t; __f.yday = yday; __f.year = year; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.date = function(l) return this.__val.date(full); end;
	absDate = function(l)
		var _q, abs, begin, d, day, end, full, month, n, x, x__1, x__10, x__11, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9, y, yday, year;
		year = 0;
		month = 0;
		day = 0;
		yday = 0;
		d = __div64(abs, new __Uint64(0, 86400), false);
		n = __div64(d, new __Uint64(0, 146097), false);
		y = __mul64(new __Uint64(0, 400), n);
		d = (x = __mul64(new __Uint64(0, 146097), n), new __Uint64(d.__high - x.__high, d.__low - x.__low));
		n = __div64(d, new __Uint64(0, 36524), false);
		n = (x__1 = __shiftRightUint64(n, 2), new __Uint64(n.__high - x__1.__high, n.__low - x__1.__low));
		y = (x__2 = __mul64(new __Uint64(0, 100), n), new __Uint64(y.__high + x__2.__high, y.__low + x__2.__low));
		d = (x__3 = __mul64(new __Uint64(0, 36524), n), new __Uint64(d.__high - x__3.__high, d.__low - x__3.__low));
		n = __div64(d, new __Uint64(0, 1461), false);
		y = (x__4 = __mul64(new __Uint64(0, 4), n), new __Uint64(y.__high + x__4.__high, y.__low + x__4.__low));
		d = (x__5 = __mul64(new __Uint64(0, 1461), n), new __Uint64(d.__high - x__5.__high, d.__low - x__5.__low));
		n = __div64(d, new __Uint64(0, 365), false);
		n = (x__6 = __shiftRightUint64(n, 2), new __Uint64(n.__high - x__6.__high, n.__low - x__6.__low));
		y = (x__7 = n, new __Uint64(y.__high + x__7.__high, y.__low + x__7.__low));
		d = (x__8 = __mul64(new __Uint64(0, 365), n), new __Uint64(d.__high - x__8.__high, d.__low - x__8.__low));
		year = (((x__9 = (x__10 = (new __Int64(y.__high, y.__low)), new __Int64(x__10.__high + -69, x__10.__low + 4075721025)), x__9.__low + ((x__9.__high >> 31) * 4294967296)) >> 0));
		yday = ((d.__low >> 0));
		if ( not full) {
			return [year, month, day, yday];
		end
		day = yday;
		if (isLeap(year)) {
			if (day > 59) {
				day = day - (1) >> 0;
			end else if ((day == 59)) {
				month = 2;
				day = 29;
				return [year, month, day, yday];
			end
		end
		month = (((_q = day / 31, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) >> 0));
		end = (((x__11 = month + 1 >> 0, ((x__11 < 0  or  x__11 >= daysBefore.length) ? (__throwRuntimeError("index out of range"), nil) : daysBefore[x__11])) >> 0));
		begin = 0;
		if (day >= end) {
			month = month + (1) >> 0;
			begin = end;
		end else {
			begin = ((((month < 0  or  month >= daysBefore.length) ? (__throwRuntimeError("index out of range"), nil) : daysBefore[month]) >> 0));
		end
		month = month + (1) >> 0;
		day = (day - begin >> 0) + 1 >> 0;
		return [year, month, day, yday];
	end;
	daysIn = function(r)
		var m, x, year;
		if ((m == 2)  and  isLeap(year)) {
			return 29;
		end
		return (((((m < 0  or  m >= daysBefore.length) ? (__throwRuntimeError("index out of range"), nil) : daysBefore[m]) - (x = m - 1 >> 0, ((x < 0  or  x >= daysBefore.length) ? (__throwRuntimeError("index out of range"), nil) : daysBefore[x])) >> 0) >> 0));
	end;
	unixTime = function(c)
		var nsec, sec;
		return new Time.ptr((new __Uint64(0, nsec)), new __Int64(sec.__high + 14, sec.__low + 2006054656), __pkg.Local);
	end;
	Time.ptr.prototype.UTC = function()
		var t;
		t = this;
		t.setLoc(utcLoc);
		return t;
	end;
	Time.prototype.UTC = function() return this.__val.UTC(); end;
	Time.ptr.prototype.Local = function()
		var t;
		t = this;
		t.setLoc(__pkg.Local);
		return t;
	end;
	Time.prototype.Local = function() return this.__val.Local(); end;
	Time.ptr.prototype.In = function(c)
		var loc, t;
		t = this;
		if (loc == ptrType__2.nil) {
			__panic(new __String("time: missing Location in call to Time.In"));
		end
		t.setLoc(loc);
		return t;
	end;
	Time.prototype.In = function(c) return this.__val.In(loc); end;
	Time.ptr.prototype.Location = function()
		var l, t;
		t = this;
		l = t.loc;
		if (l == ptrType__2.nil) {
			l = __pkg.UTC;
		end
		return l;
	end;
	Time.prototype.Location = function() return this.__val.Location(); end;
	Time.ptr.prototype.Zone = function()
		var _r, _tuple, name, offset, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; name = __f.name; offset = __f.offset; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		name = "";
		offset = 0;
		t = this;
		_r = t.loc.lookup(t.unixSec()); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		name = _tuple[0];
		offset = _tuple[1];
		__s = -1; return [name, offset];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.Zone end; end __f._r = _r; __f._tuple = _tuple; __f.name = name; __f.offset = offset; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.Zone = function() return this.__val.Zone(); end;
	Time.ptr.prototype.Unix = function()
		var t;
		t = this;
		return t.unixSec();
	end;
	Time.prototype.Unix = function() return this.__val.Unix(); end;
	Time.ptr.prototype.UnixNano = function()
		var t, x, x__1;
		t = this;
		return (x = __mul64((t.unixSec()), new __Int64(0, 1000000000)), x__1 = (new __Int64(0, t.nsec())), new __Int64(x.__high + x__1.__high, x.__low + x__1.__low));
	end;
	Time.prototype.UnixNano = function() return this.__val.UnixNano(); end;
	Time.ptr.prototype.MarshalBinary = function()
		var _q, _r, _r__1, _tuple, enc, nsec, offset, offsetMin, sec, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _q = __f._q; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; enc = __f.enc; nsec = __f.nsec; offset = __f.offset; offsetMin = __f.offsetMin; sec = __f.sec; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		offsetMin = 0;
		/* */ if (__clone(t, Time).Location() == __pkg.UTC) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (__clone(t, Time).Location() == __pkg.UTC) { */ case 1:
			offsetMin = -1;
			__s = 3; continue;
		/* end else { */ case 2:
			_r = __clone(t, Time).Zone(); /* */ __s = 4; case 4: if(__c) then  __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_tuple = _r;
			offset = _tuple[1];
			if ( not (((_r__1 = offset % 60, _r__1 == _r__1 ? _r__1 : __throwRuntimeError("integer divide by zero")) == 0))) {
				__s = -1; return [sliceType__3.nil, errors.New("Time.MarshalBinary: zone offset has fractional minute")];
			end
			offset = (_q = offset / (60), (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
			if (offset < -32768  or  (offset == -1)  or  offset > 32767) {
				__s = -1; return [sliceType__3.nil, errors.New("Time.MarshalBinary: unexpected zone offset")];
			end
			offsetMin = ((offset << 16 >> 16));
		/* end */ case 3:
		sec = t.sec();
		nsec = t.nsec();
		enc = new sliceType__3([1, ((__shiftRightInt64(sec, 56).__low << 24 >>> 24)), ((__shiftRightInt64(sec, 48).__low << 24 >>> 24)), ((__shiftRightInt64(sec, 40).__low << 24 >>> 24)), ((__shiftRightInt64(sec, 32).__low << 24 >>> 24)), ((__shiftRightInt64(sec, 24).__low << 24 >>> 24)), ((__shiftRightInt64(sec, 16).__low << 24 >>> 24)), ((__shiftRightInt64(sec, 8).__low << 24 >>> 24)), ((sec.__low << 24 >>> 24)), (((nsec >> 24 >> 0) << 24 >>> 24)), (((nsec >> 16 >> 0) << 24 >>> 24)), (((nsec >> 8 >> 0) << 24 >>> 24)), ((nsec << 24 >>> 24)), (((offsetMin >> 8 << 16 >> 16) << 24 >>> 24)), ((offsetMin << 24 >>> 24))]);
		__s = -1; return [enc, __ifaceNil];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.MarshalBinary end; end __f._q = _q; __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.enc = enc; __f.nsec = nsec; __f.offset = offset; __f.offsetMin = offsetMin; __f.sec = sec; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.MarshalBinary = function() return this.__val.MarshalBinary(); end;
	Time.ptr.prototype.UnmarshalBinary = function(1)
		var _r, _tuple, buf, data__1, localoff, nsec, offset, sec, t, x, x__1, x__10, x__11, x__12, x__13, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; buf = __f.buf; data__1 = __f.data__1; localoff = __f.localoff; nsec = __f.nsec; offset = __f.offset; sec = __f.sec; t = __f.t; x = __f.x; x__1 = __f.x__1; x__10 = __f.x__10; x__11 = __f.x__11; x__12 = __f.x__12; x__13 = __f.x__13; x__2 = __f.x__2; x__3 = __f.x__3; x__4 = __f.x__4; x__5 = __f.x__5; x__6 = __f.x__6; x__7 = __f.x__7; x__8 = __f.x__8; x__9 = __f.x__9; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		buf = data__1;
		if (buf.__length == 0) {
			__s = -1; return errors.New("Time.UnmarshalBinary: no data");
		end
		if ( not (((0 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 0]) == 1))) {
			__s = -1; return errors.New("Time.UnmarshalBinary: unsupported version");
		end
		if ( not ((buf.__length == 15))) {
			__s = -1; return errors.New("Time.UnmarshalBinary: invalid length");
		end
		buf = __subslice(buf, 1);
		sec = (x = (x__1 = (x__2 = (x__3 = (x__4 = (x__5 = (x__6 = (new __Int64(0, (7 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 7]))), x__7 = __shiftLeft64((new __Int64(0, (6 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 6]))), 8), new __Int64(x__6.__high | x__7.__high, (x__6.__low | x__7.__low) >>> 0)), x__8 = __shiftLeft64((new __Int64(0, (5 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 5]))), 16), new __Int64(x__5.__high | x__8.__high, (x__5.__low | x__8.__low) >>> 0)), x__9 = __shiftLeft64((new __Int64(0, (4 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 4]))), 24), new __Int64(x__4.__high | x__9.__high, (x__4.__low | x__9.__low) >>> 0)), x__10 = __shiftLeft64((new __Int64(0, (3 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 3]))), 32), new __Int64(x__3.__high | x__10.__high, (x__3.__low | x__10.__low) >>> 0)), x__11 = __shiftLeft64((new __Int64(0, (2 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 2]))), 40), new __Int64(x__2.__high | x__11.__high, (x__2.__low | x__11.__low) >>> 0)), x__12 = __shiftLeft64((new __Int64(0, (1 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 1]))), 48), new __Int64(x__1.__high | x__12.__high, (x__1.__low | x__12.__low) >>> 0)), x__13 = __shiftLeft64((new __Int64(0, (0 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 0]))), 56), new __Int64(x.__high | x__13.__high, (x.__low | x__13.__low) >>> 0));
		buf = __subslice(buf, 8);
		nsec = (((((3 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 3]) >> 0)) | ((((2 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 2]) >> 0)) << 8 >> 0)) | ((((1 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 1]) >> 0)) << 16 >> 0)) | ((((0 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 0]) >> 0)) << 24 >> 0);
		buf = __subslice(buf, 4);
		offset = __imul(((((((1 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 1]) << 16 >> 16)) | ((((0 >= buf.__length ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + 0]) << 16 >> 16)) << 8 << 16 >> 16)) >> 0)), 60);
		Time.copy(t, new Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__2.nil));
		t.wall = (new __Uint64(0, nsec));
		t.ext = sec;
		/* */ if (offset == -60) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (offset == -60) { */ case 1:
			t.setLoc(utcLoc);
			__s = 3; continue;
		/* end else { */ case 2:
			_r = __pkg.Local.lookup(t.unixSec()); /* */ __s = 4; case 4: if(__c) then  __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_tuple = _r;
			localoff = _tuple[1];
			if (offset == localoff) {
				t.setLoc(__pkg.Local);
			end else {
				t.setLoc(FixedZone("", offset));
			end
		/* end */ case 3:
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.UnmarshalBinary end; end __f._r = _r; __f._tuple = _tuple; __f.buf = buf; __f.data__1 = data__1; __f.localoff = localoff; __f.nsec = nsec; __f.offset = offset; __f.sec = sec; __f.t = t; __f.x = x; __f.x__1 = x__1; __f.x__10 = x__10; __f.x__11 = x__11; __f.x__12 = x__12; __f.x__13 = x__13; __f.x__2 = x__2; __f.x__3 = x__3; __f.x__4 = x__4; __f.x__5 = x__5; __f.x__6 = x__6; __f.x__7 = x__7; __f.x__8 = x__8; __f.x__9 = x__9; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.UnmarshalBinary = function(1) return this.__val.UnmarshalBinary(data__1); end;
	Time.ptr.prototype.GobEncode = function()
		var _r, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).MarshalBinary(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.GobEncode end; end __f._r = _r; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.GobEncode = function() return this.__val.GobEncode(); end;
	Time.ptr.prototype.GobDecode = function(1)
		var _r, data__1, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; data__1 = __f.data__1; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = t.UnmarshalBinary(data__1); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.GobDecode end; end __f._r = _r; __f.data__1 = data__1; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.GobDecode = function(1) return this.__val.GobDecode(data__1); end;
	Time.ptr.prototype.MarshalJSON = function()
		var _r, _r__1, b, t, y, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; b = __f.b; t = __f.t; y = __f.y; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).Year(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		y = _r;
		if (y < 0  or  y >= 10000) {
			__s = -1; return [sliceType__3.nil, errors.New("Time.MarshalJSON: year outside of range [0,9999]")];
		end
		b = __makeSlice(sliceType__3, 0, 37);
		b = __append(b, 34);
		_r__1 = __clone(t, Time).AppendFormat(b, "2006-01-02T15:04:05.999999999Z07:00"); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		b = _r__1;
		b = __append(b, 34);
		__s = -1; return [b, __ifaceNil];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.MarshalJSON end; end __f._r = _r; __f._r__1 = _r__1; __f.b = b; __f.t = t; __f.y = y; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.MarshalJSON = function() return this.__val.MarshalJSON(); end;
	Time.ptr.prototype.UnmarshalJSON = function(1)
		var _r, _tuple, data__1, err, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; data__1 = __f.data__1; err = __f.err; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if ((__bytesToString(data__1)) == "null") {
			__s = -1; return __ifaceNil;
		end
		err = __ifaceNil;
		_r = Parse("\"2006-01-02T15:04:05Z07:00\"", (__bytesToString(data__1))); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		Time.copy(t, _tuple[0]);
		err = _tuple[1];
		__s = -1; return err;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.UnmarshalJSON end; end __f._r = _r; __f._tuple = _tuple; __f.data__1 = data__1; __f.err = err; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.UnmarshalJSON = function(1) return this.__val.UnmarshalJSON(data__1); end;
	Time.ptr.prototype.MarshalText = function()
		var _r, _r__1, b, t, y, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; b = __f.b; t = __f.t; y = __f.y; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = __clone(t, Time).Year(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		y = _r;
		if (y < 0  or  y >= 10000) {
			__s = -1; return [sliceType__3.nil, errors.New("Time.MarshalText: year outside of range [0,9999]")];
		end
		b = __makeSlice(sliceType__3, 0, 35);
		_r__1 = __clone(t, Time).AppendFormat(b, "2006-01-02T15:04:05.999999999Z07:00"); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return [_r__1, __ifaceNil];
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.MarshalText end; end __f._r = _r; __f._r__1 = _r__1; __f.b = b; __f.t = t; __f.y = y; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.MarshalText = function() return this.__val.MarshalText(); end;
	Time.ptr.prototype.UnmarshalText = function(1)
		var _r, _tuple, data__1, err, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; data__1 = __f.data__1; err = __f.err; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		err = __ifaceNil;
		_r = Parse("2006-01-02T15:04:05Z07:00", (__bytesToString(data__1))); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		Time.copy(t, _tuple[0]);
		err = _tuple[1];
		__s = -1; return err;
		/* */ end return; end if __f == nil then  __f = { __blk: Time.ptr.prototype.UnmarshalText end; end __f._r = _r; __f._tuple = _tuple; __f.data__1 = data__1; __f.err = err; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Time.prototype.UnmarshalText = function(1) return this.__val.UnmarshalText(data__1); end;
	Unix = function(c)
		var n, nsec, sec, x, x__1, x__2, x__3;
		if ((nsec.__high < 0  or  (nsec.__high == 0  and  nsec.__low < 0))  or  (nsec.__high > 0  or  (nsec.__high == 0  and  nsec.__low >= 1000000000))) {
			n = __div64(nsec, new __Int64(0, 1000000000), false);
			sec = (x = n, new __Int64(sec.__high + x.__high, sec.__low + x.__low));
			nsec = (x__1 = __mul64(n, new __Int64(0, 1000000000)), new __Int64(nsec.__high - x__1.__high, nsec.__low - x__1.__low));
			if ((nsec.__high < 0  or  (nsec.__high == 0  and  nsec.__low < 0))) {
				nsec = (x__2 = new __Int64(0, 1000000000), new __Int64(nsec.__high + x__2.__high, nsec.__low + x__2.__low));
				sec = (x__3 = new __Int64(0, 1), new __Int64(sec.__high - x__3.__high, sec.__low - x__3.__low));
			end
		end
		return unixTime(sec, (((nsec.__low + ((nsec.__high >> 31) * 4294967296)) >> 0)));
	end;
	__pkg.Unix = Unix;
	isLeap = function(r)
		var _r, _r__1, _r__2, year;
		return ((_r = year % 4, _r == _r ? _r : __throwRuntimeError("integer divide by zero")) == 0)  and  ( not (((_r__1 = year % 100, _r__1 == _r__1 ? _r__1 : __throwRuntimeError("integer divide by zero")) == 0))  or  ((_r__2 = year % 400, _r__2 == _r__2 ? _r__2 : __throwRuntimeError("integer divide by zero")) == 0));
	end;
	norm = function(e)
		var _q, _q__1, _tmp, _tmp__1, base, hi, lo, n, n__1, nhi, nlo;
		nhi = 0;
		nlo = 0;
		if (lo < 0) {
			n = (_q = ((-lo - 1 >> 0)) / base, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) + 1 >> 0;
			hi = hi - (n) >> 0;
			lo = lo + ((__imul(n, base))) >> 0;
		end
		if (lo >= base) {
			n__1 = (_q__1 = lo / base, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >> 0 : __throwRuntimeError("integer divide by zero"));
			hi = hi + (n__1) >> 0;
			lo = lo - ((__imul(n__1, base))) >> 0;
		end
		_tmp = hi;
		_tmp__1 = lo;
		nhi = _tmp;
		nlo = _tmp__1;
		return [nhi, nlo];
	end;
	Date = function(c)
		var _r, _r__1, _r__2, _tuple, _tuple__1, _tuple__2, _tuple__3, _tuple__4, _tuple__5, _tuple__6, _tuple__7, abs, d, day, end, hour, loc, m, min, month, n, nsec, offset, sec, start, t, unix, utc, x, x__1, x__10, x__11, x__12, x__13, x__14, x__15, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9, y, year, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; _tuple__3 = __f._tuple__3; _tuple__4 = __f._tuple__4; _tuple__5 = __f._tuple__5; _tuple__6 = __f._tuple__6; _tuple__7 = __f._tuple__7; abs = __f.abs; d = __f.d; day = __f.day; end = __f.end; hour = __f.hour; loc = __f.loc; m = __f.m; min = __f.min; month = __f.month; n = __f.n; nsec = __f.nsec; offset = __f.offset; sec = __f.sec; start = __f.start; t = __f.t; unix = __f.unix; utc = __f.utc; x = __f.x; x__1 = __f.x__1; x__10 = __f.x__10; x__11 = __f.x__11; x__12 = __f.x__12; x__13 = __f.x__13; x__14 = __f.x__14; x__15 = __f.x__15; x__2 = __f.x__2; x__3 = __f.x__3; x__4 = __f.x__4; x__5 = __f.x__5; x__6 = __f.x__6; x__7 = __f.x__7; x__8 = __f.x__8; x__9 = __f.x__9; y = __f.y; year = __f.year; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if (loc == ptrType__2.nil) {
			__panic(new __String("time: missing Location in call to Date"));
		end
		m = ((month >> 0)) - 1 >> 0;
		_tuple = norm(year, m, 12);
		year = _tuple[0];
		m = _tuple[1];
		month = ((m >> 0)) + 1 >> 0;
		_tuple__1 = norm(sec, nsec, 1000000000);
		sec = _tuple__1[0];
		nsec = _tuple__1[1];
		_tuple__2 = norm(min, sec, 60);
		min = _tuple__2[0];
		sec = _tuple__2[1];
		_tuple__3 = norm(hour, min, 60);
		hour = _tuple__3[0];
		min = _tuple__3[1];
		_tuple__4 = norm(day, hour, 24);
		day = _tuple__4[0];
		hour = _tuple__4[1];
		y = ((x = (x__1 = (new __Int64(0, year)), new __Int64(x__1.__high - -69, x__1.__low - 4075721025)), new __Uint64(x.__high, x.__low)));
		n = __div64(y, new __Uint64(0, 400), false);
		y = (x__2 = __mul64(new __Uint64(0, 400), n), new __Uint64(y.__high - x__2.__high, y.__low - x__2.__low));
		d = __mul64(new __Uint64(0, 146097), n);
		n = __div64(y, new __Uint64(0, 100), false);
		y = (x__3 = __mul64(new __Uint64(0, 100), n), new __Uint64(y.__high - x__3.__high, y.__low - x__3.__low));
		d = (x__4 = __mul64(new __Uint64(0, 36524), n), new __Uint64(d.__high + x__4.__high, d.__low + x__4.__low));
		n = __div64(y, new __Uint64(0, 4), false);
		y = (x__5 = __mul64(new __Uint64(0, 4), n), new __Uint64(y.__high - x__5.__high, y.__low - x__5.__low));
		d = (x__6 = __mul64(new __Uint64(0, 1461), n), new __Uint64(d.__high + x__6.__high, d.__low + x__6.__low));
		n = y;
		d = (x__7 = __mul64(new __Uint64(0, 365), n), new __Uint64(d.__high + x__7.__high, d.__low + x__7.__low));
		d = (x__8 = (new __Uint64(0, (x__9 = month - 1 >> 0, ((x__9 < 0  or  x__9 >= daysBefore.length) ? (__throwRuntimeError("index out of range"), nil) : daysBefore[x__9])))), new __Uint64(d.__high + x__8.__high, d.__low + x__8.__low));
		if (isLeap(year)  and  month >= 3) {
			d = (x__10 = new __Uint64(0, 1), new __Uint64(d.__high + x__10.__high, d.__low + x__10.__low));
		end
		d = (x__11 = (new __Uint64(0, (day - 1 >> 0))), new __Uint64(d.__high + x__11.__high, d.__low + x__11.__low));
		abs = __mul64(d, new __Uint64(0, 86400));
		abs = (x__12 = (new __Uint64(0, (((__imul(hour, 3600)) + (__imul(min, 60)) >> 0) + sec >> 0))), new __Uint64(abs.__high + x__12.__high, abs.__low + x__12.__low));
		unix = (x__13 = (new __Int64(abs.__high, abs.__low)), new __Int64(x__13.__high + -2147483647, x__13.__low + 3844486912));
		_r = loc.lookup(unix); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple__5 = _r;
		offset = _tuple__5[1];
		start = _tuple__5[3];
		end = _tuple__5[4];
		/* */ if ( not ((offset == 0))) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if ( not ((offset == 0))) { */ case 2:
				utc = (x__14 = (new __Int64(0, offset)), new __Int64(unix.__high - x__14.__high, unix.__low - x__14.__low));
				/* */ if ((utc.__high < start.__high  or  (utc.__high == start.__high  and  utc.__low < start.__low))) { __s = 5; continue; end
				/* */ if ((utc.__high > end.__high  or  (utc.__high == end.__high  and  utc.__low >= end.__low))) { __s = 6; continue; end
				/* */ __s = 7; continue;
				/* if ((utc.__high < start.__high  or  (utc.__high == start.__high  and  utc.__low < start.__low))) { */ case 5:
					_r__1 = loc.lookup(new __Int64(start.__high - 0, start.__low - 1)); /* */ __s = 8; case 8: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
					_tuple__6 = _r__1;
					offset = _tuple__6[1];
					__s = 7; continue;
				/* end else if ((utc.__high > end.__high  or  (utc.__high == end.__high  and  utc.__low >= end.__low))) { */ case 6:
					_r__2 = loc.lookup(end); /* */ __s = 9; case 9: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
					_tuple__7 = _r__2;
					offset = _tuple__7[1];
				/* end */ case 7:
			case 4:
			unix = (x__15 = (new __Int64(0, offset)), new __Int64(unix.__high - x__15.__high, unix.__low - x__15.__low));
		/* end */ case 3:
		t = __clone(unixTime(unix, ((nsec >> 0))), Time);
		t.setLoc(loc);
		__s = -1; return t;
		/* */ end return; end if __f == nil then  __f = { __blk: Date end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f._tuple__3 = _tuple__3; __f._tuple__4 = _tuple__4; __f._tuple__5 = _tuple__5; __f._tuple__6 = _tuple__6; __f._tuple__7 = _tuple__7; __f.abs = abs; __f.d = d; __f.day = day; __f.end = end; __f.hour = hour; __f.loc = loc; __f.m = m; __f.min = min; __f.month = month; __f.n = n; __f.nsec = nsec; __f.offset = offset; __f.sec = sec; __f.start = start; __f.t = t; __f.unix = unix; __f.utc = utc; __f.x = x; __f.x__1 = x__1; __f.x__10 = x__10; __f.x__11 = x__11; __f.x__12 = x__12; __f.x__13 = x__13; __f.x__14 = x__14; __f.x__15 = x__15; __f.x__2 = x__2; __f.x__3 = x__3; __f.x__4 = x__4; __f.x__5 = x__5; __f.x__6 = x__6; __f.x__7 = x__7; __f.x__8 = x__8; __f.x__9 = x__9; __f.y = y; __f.year = year; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.Date = Date;
	Time.ptr.prototype.Truncate = function(d)
		var _tuple, d, r, t;
		t = this;
		t.stripMono();
		if ((d.__high < 0  or  (d.__high == 0  and  d.__low <= 0))) {
			return t;
		end
		_tuple = div(__clone(t, Time), d);
		r = _tuple[1];
		return __clone(t, Time).Add(new Duration(-r.__high, -r.__low));
	end;
	Time.prototype.Truncate = function(d) return this.__val.Truncate(d); end;
	Time.ptr.prototype.Round = function(d)
		var _tuple, d, r, t;
		t = this;
		t.stripMono();
		if ((d.__high < 0  or  (d.__high == 0  and  d.__low <= 0))) {
			return t;
		end
		_tuple = div(__clone(t, Time), d);
		r = _tuple[1];
		if (lessThanHalf(r, d)) {
			return __clone(t, Time).Add(new Duration(-r.__high, -r.__low));
		end
		return __clone(t, Time).Add(new Duration(d.__high - r.__high, d.__low - r.__low));
	end;
	Time.prototype.Round = function(d) return this.__val.Round(d); end;
	div = function(d)
		var _q, _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, d, d0, d1, d1__1, neg, nsec, qmod2, r, sec, sec__1, t, tmp, u0, u0x, u1, x, x__1, x__10, x__11, x__12, x__13, x__14, x__15, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		qmod2 = 0;
		r = new Duration(0, 0);
		neg = false;
		nsec = t.nsec();
		sec = t.sec();
		if ((sec.__high < 0  or  (sec.__high == 0  and  sec.__low < 0))) {
			neg = true;
			sec = new __Int64(-sec.__high, -sec.__low);
			nsec = -nsec;
			if (nsec < 0) {
				nsec = nsec + (1000000000) >> 0;
				sec = (x = new __Int64(0, 1), new __Int64(sec.__high - x.__high, sec.__low - x.__low));
			end
		end
		if ((d.__high < 0  or  (d.__high == 0  and  d.__low < 1000000000))  and  (x__1 = __div64(new Duration(0, 1000000000), (new Duration(d.__high + d.__high, d.__low + d.__low)), true), (x__1.__high == 0  and  x__1.__low == 0))) {
			qmod2 = (((_q = nsec / (((d.__low + ((d.__high >> 31) * 4294967296)) >> 0)), (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) >> 0)) & 1;
			r = (new Duration(0, (_r = nsec % (((d.__low + ((d.__high >> 31) * 4294967296)) >> 0)), _r == _r ? _r : __throwRuntimeError("integer divide by zero"))));
		end else if ((x__2 = __div64(d, new Duration(0, 1000000000), true), (x__2.__high == 0  and  x__2.__low == 0))) {
			d1 = ((x__3 = __div64(d, new Duration(0, 1000000000), false), new __Int64(x__3.__high, x__3.__low)));
			qmod2 = (((x__4 = __div64(sec, d1, false), x__4.__low + ((x__4.__high >> 31) * 4294967296)) >> 0)) & 1;
			r = (x__5 = __mul64(((x__6 = __div64(sec, d1, true), new Duration(x__6.__high, x__6.__low))), new Duration(0, 1000000000)), x__7 = (new Duration(0, nsec)), new Duration(x__5.__high + x__7.__high, x__5.__low + x__7.__low));
		end else {
			sec__1 = (new __Uint64(sec.__high, sec.__low));
			tmp = __mul64((__shiftRightUint64(sec__1, 32)), new __Uint64(0, 1000000000));
			u1 = __shiftRightUint64(tmp, 32);
			u0 = __shiftLeft64(tmp, 32);
			tmp = __mul64((new __Uint64(sec__1.__high & 0, (sec__1.__low & 4294967295) >>> 0)), new __Uint64(0, 1000000000));
			_tmp = u0;
			_tmp__1 = new __Uint64(u0.__high + tmp.__high, u0.__low + tmp.__low);
			u0x = _tmp;
			u0 = _tmp__1;
			if ((u0.__high < u0x.__high  or  (u0.__high == u0x.__high  and  u0.__low < u0x.__low))) {
				u1 = (x__8 = new __Uint64(0, 1), new __Uint64(u1.__high + x__8.__high, u1.__low + x__8.__low));
			end
			_tmp__2 = u0;
			_tmp__3 = (x__9 = (new __Uint64(0, nsec)), new __Uint64(u0.__high + x__9.__high, u0.__low + x__9.__low));
			u0x = _tmp__2;
			u0 = _tmp__3;
			if ((u0.__high < u0x.__high  or  (u0.__high == u0x.__high  and  u0.__low < u0x.__low))) {
				u1 = (x__10 = new __Uint64(0, 1), new __Uint64(u1.__high + x__10.__high, u1.__low + x__10.__low));
			end
			d1__1 = (new __Uint64(d.__high, d.__low));
			while (true) {
				if ( not ( not ((x__11 = __shiftRightUint64(d1__1, 63), (x__11.__high == 0  and  x__11.__low == 1))))) { break; end
				d1__1 = __shiftLeft64(d1__1, (1));
			end
			d0 = new __Uint64(0, 0);
			while (true) {
				qmod2 = 0;
				if ((u1.__high > d1__1.__high  or  (u1.__high == d1__1.__high  and  u1.__low > d1__1.__low))  or  (u1.__high == d1__1.__high  and  u1.__low == d1__1.__low)  and  (u0.__high > d0.__high  or  (u0.__high == d0.__high  and  u0.__low >= d0.__low))) {
					qmod2 = 1;
					_tmp__4 = u0;
					_tmp__5 = new __Uint64(u0.__high - d0.__high, u0.__low - d0.__low);
					u0x = _tmp__4;
					u0 = _tmp__5;
					if ((u0.__high > u0x.__high  or  (u0.__high == u0x.__high  and  u0.__low > u0x.__low))) {
						u1 = (x__12 = new __Uint64(0, 1), new __Uint64(u1.__high - x__12.__high, u1.__low - x__12.__low));
					end
					u1 = (x__13 = d1__1, new __Uint64(u1.__high - x__13.__high, u1.__low - x__13.__low));
				end
				if ((d1__1.__high == 0  and  d1__1.__low == 0)  and  (x__14 = (new __Uint64(d.__high, d.__low)), (d0.__high == x__14.__high  and  d0.__low == x__14.__low))) {
					break;
				end
				d0 = __shiftRightUint64(d0, (1));
				d0 = (x__15 = __shiftLeft64((new __Uint64(d1__1.__high & 0, (d1__1.__low & 1) >>> 0)), 63), new __Uint64(d0.__high | x__15.__high, (d0.__low | x__15.__low) >>> 0));
				d1__1 = __shiftRightUint64(d1__1, (1));
			end
			r = (new Duration(u0.__high, u0.__low));
		end
		if (neg  and   not ((r.__high == 0  and  r.__low == 0))) {
			qmod2 = (qmod2 ^ (1)) >> 0;
			r = new Duration(d.__high - r.__high, d.__low - r.__low);
		end
		return [qmod2, r];
	end;
	Location.ptr.prototype.get = function()
		var l, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; l = __f.l; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		l = this;
		if (l == ptrType__2.nil) {
			__s = -1; return utcLoc;
		end
		/* */ if (l == localLoc) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (l == localLoc) { */ case 1:
			__r = localOnce.Do(initLocal); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* end */ case 2:
		__s = -1; return l;
		/* */ end return; end if __f == nil then  __f = { __blk: Location.ptr.prototype.get end; end __f.l = l; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Location.prototype.get = function() return this.__val.get(); end;
	Location.ptr.prototype.String = function()
		var _r, l, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; l = __f.l; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		l = this;
		_r = l.get(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r.name;
		/* */ end return; end if __f == nil then  __f = { __blk: Location.ptr.prototype.String end; end __f._r = _r; __f.l = l; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Location.prototype.String = function() return this.__val.String(); end;
	FixedZone = function(t)
		var l, name, offset, x;
		l = new Location.ptr(name, new sliceType([new zone.ptr(name, offset, false)]), new sliceType__1([new zoneTrans.ptr(new __Int64(-2147483648, 0), 0, false, false)]), new __Int64(-2147483648, 0), new __Int64(2147483647, 4294967295), ptrType.nil);
		l.cacheZone = (x = l.zone, (0 >= x.__length ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + 0]));
		return l;
	end;
	__pkg.FixedZone = FixedZone;
	Location.ptr.prototype.lookup = function(c)
		var _q, _r, end, hi, isDST, l, lim, lo, m, name, offset, sec, start, tx, x, x__1, x__2, x__3, x__4, x__5, x__6, x__7, x__8, zone__1, zone__2, zone__3, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _q = __f._q; _r = __f._r; end = __f.end; hi = __f.hi; isDST = __f.isDST; l = __f.l; lim = __f.lim; lo = __f.lo; m = __f.m; name = __f.name; offset = __f.offset; sec = __f.sec; start = __f.start; tx = __f.tx; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; x__3 = __f.x__3; x__4 = __f.x__4; x__5 = __f.x__5; x__6 = __f.x__6; x__7 = __f.x__7; x__8 = __f.x__8; zone__1 = __f.zone__1; zone__2 = __f.zone__2; zone__3 = __f.zone__3; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		name = "";
		offset = 0;
		isDST = false;
		start = new __Int64(0, 0);
		end = new __Int64(0, 0);
		l = this;
		_r = l.get(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		l = _r;
		if (l.zone.__length == 0) {
			name = "UTC";
			offset = 0;
			isDST = false;
			start = new __Int64(-2147483648, 0);
			end = new __Int64(2147483647, 4294967295);
			__s = -1; return [name, offset, isDST, start, end];
		end
		zone__1 = l.cacheZone;
		if ( not (zone__1 == ptrType.nil)  and  (x = l.cacheStart, (x.__high < sec.__high  or  (x.__high == sec.__high  and  x.__low <= sec.__low)))  and  (x__1 = l.cacheEnd, (sec.__high < x__1.__high  or  (sec.__high == x__1.__high  and  sec.__low < x__1.__low)))) {
			name = zone__1.name;
			offset = zone__1.offset;
			isDST = zone__1.isDST;
			start = l.cacheStart;
			end = l.cacheEnd;
			__s = -1; return [name, offset, isDST, start, end];
		end
		if ((l.tx.__length == 0)  or  (x__2 = (x__3 = l.tx, (0 >= x__3.__length ? (__throwRuntimeError("index out of range"), nil) : x__3.__array[x__3.__offset + 0])).when, (sec.__high < x__2.__high  or  (sec.__high == x__2.__high  and  sec.__low < x__2.__low)))) {
			zone__2 = (x__4 = l.zone, x__5 = l.lookupFirstZone(), ((x__5 < 0  or  x__5 >= x__4.__length) ? (__throwRuntimeError("index out of range"), nil) : x__4.__array[x__4.__offset + x__5]));
			name = zone__2.name;
			offset = zone__2.offset;
			isDST = zone__2.isDST;
			start = new __Int64(-2147483648, 0);
			if (l.tx.__length > 0) {
				end = (x__6 = l.tx, (0 >= x__6.__length ? (__throwRuntimeError("index out of range"), nil) : x__6.__array[x__6.__offset + 0])).when;
			end else {
				end = new __Int64(2147483647, 4294967295);
			end
			__s = -1; return [name, offset, isDST, start, end];
		end
		tx = l.tx;
		end = new __Int64(2147483647, 4294967295);
		lo = 0;
		hi = tx.__length;
		while (true) {
			if ( not ((hi - lo >> 0) > 1)) { break; end
			m = lo + (_q = ((hi - lo >> 0)) / 2, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) >> 0;
			lim = ((m < 0  or  m >= tx.__length) ? (__throwRuntimeError("index out of range"), nil) : tx.__array[tx.__offset + m]).when;
			if ((sec.__high < lim.__high  or  (sec.__high == lim.__high  and  sec.__low < lim.__low))) {
				end = lim;
				hi = m;
			end else {
				lo = m;
			end
		end
		zone__3 = (x__7 = l.zone, x__8 = ((lo < 0  or  lo >= tx.__length) ? (__throwRuntimeError("index out of range"), nil) : tx.__array[tx.__offset + lo]).index, ((x__8 < 0  or  x__8 >= x__7.__length) ? (__throwRuntimeError("index out of range"), nil) : x__7.__array[x__7.__offset + x__8]));
		name = zone__3.name;
		offset = zone__3.offset;
		isDST = zone__3.isDST;
		start = ((lo < 0  or  lo >= tx.__length) ? (__throwRuntimeError("index out of range"), nil) : tx.__array[tx.__offset + lo]).when;
		__s = -1; return [name, offset, isDST, start, end];
		/* */ end return; end if __f == nil then  __f = { __blk: Location.ptr.prototype.lookup end; end __f._q = _q; __f._r = _r; __f.end = end; __f.hi = hi; __f.isDST = isDST; __f.l = l; __f.lim = lim; __f.lo = lo; __f.m = m; __f.name = name; __f.offset = offset; __f.sec = sec; __f.start = start; __f.tx = tx; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.x__3 = x__3; __f.x__4 = x__4; __f.x__5 = x__5; __f.x__6 = x__6; __f.x__7 = x__7; __f.x__8 = x__8; __f.zone__1 = zone__1; __f.zone__2 = zone__2; __f.zone__3 = zone__3; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Location.prototype.lookup = function(c) return this.__val.lookup(sec); end;
	Location.ptr.prototype.lookupFirstZone = function()
		var _i, _ref, l, x, x__1, x__2, x__3, x__4, x__5, zi, zi__1;
		l = this;
		if ( not l.firstZoneUsed()) {
			return 0;
		end
		if (l.tx.__length > 0  and  (x = l.zone, x__1 = (x__2 = l.tx, (0 >= x__2.__length ? (__throwRuntimeError("index out of range"), nil) : x__2.__array[x__2.__offset + 0])).index, ((x__1 < 0  or  x__1 >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + x__1])).isDST) {
			zi = (((x__3 = l.tx, (0 >= x__3.__length ? (__throwRuntimeError("index out of range"), nil) : x__3.__array[x__3.__offset + 0])).index >> 0)) - 1 >> 0;
			while (true) {
				if ( not (zi >= 0)) { break; end
				if ( not (x__4 = l.zone, ((zi < 0  or  zi >= x__4.__length) ? (__throwRuntimeError("index out of range"), nil) : x__4.__array[x__4.__offset + zi])).isDST) {
					return zi;
				end
				zi = zi - (1) >> 0;
			end
		end
		_ref = l.zone;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			zi__1 = _i;
			if ( not (x__5 = l.zone, ((zi__1 < 0  or  zi__1 >= x__5.__length) ? (__throwRuntimeError("index out of range"), nil) : x__5.__array[x__5.__offset + zi__1])).isDST) {
				return zi__1;
			end
			_i++;
		end
		return 0;
	end;
	Location.prototype.lookupFirstZone = function() return this.__val.lookupFirstZone(); end;
	Location.ptr.prototype.firstZoneUsed = function()
		var _i, _ref, l, tx;
		l = this;
		_ref = l.tx;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			tx = __clone(((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]), zoneTrans);
			if (tx.index == 0) {
				return true;
			end
			_i++;
		end
		return false;
	end;
	Location.prototype.firstZoneUsed = function() return this.__val.firstZoneUsed(); end;
	Location.ptr.prototype.lookupName = function(x)
		var _i, _i__1, _r, _r__1, _ref, _ref__1, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tuple, i, i__1, isDST, isDST__1, l, nam, name, offset, offset__1, ok, unix, x, x__1, x__2, zone__1, zone__2, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _i__1 = __f._i__1; _r = __f._r; _r__1 = __f._r__1; _ref = __f._ref; _ref__1 = __f._ref__1; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tmp__4 = __f._tmp__4; _tmp__5 = __f._tmp__5; _tuple = __f._tuple; i = __f.i; i__1 = __f.i__1; isDST = __f.isDST; isDST__1 = __f.isDST__1; l = __f.l; nam = __f.nam; name = __f.name; offset = __f.offset; offset__1 = __f.offset__1; ok = __f.ok; unix = __f.unix; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; zone__1 = __f.zone__1; zone__2 = __f.zone__2; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		offset = 0;
		isDST = false;
		ok = false;
		l = this;
		_r = l.get(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		l = _r;
		_ref = l.zone;
		_i = 0;
		/* while (true) { */ case 2:
			/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 3; continue; end
			i = _i;
			zone__1 = (x = l.zone, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
			/* */ if (zone__1.name == name) { __s = 4; continue; end
			/* */ __s = 5; continue;
			/* if (zone__1.name == name) { */ case 4:
				_r__1 = l.lookup((x__1 = (new __Int64(0, zone__1.offset)), new __Int64(unix.__high - x__1.__high, unix.__low - x__1.__low))); /* */ __s = 6; case 6: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				_tuple = _r__1;
				nam = _tuple[0];
				offset__1 = _tuple[1];
				isDST__1 = _tuple[2];
				if (nam == zone__1.name) {
					_tmp = offset__1;
					_tmp__1 = isDST__1;
					_tmp__2 = true;
					offset = _tmp;
					isDST = _tmp__1;
					ok = _tmp__2;
					__s = -1; return [offset, isDST, ok];
				end
			/* end */ case 5:
			_i++;
		/* end */ __s = 2; continue; case 3:
		_ref__1 = l.zone;
		_i__1 = 0;
		while (true) {
			if ( not (_i__1 < _ref__1.__length)) { break; end
			i__1 = _i__1;
			zone__2 = (x__2 = l.zone, ((i__1 < 0  or  i__1 >= x__2.__length) ? (__throwRuntimeError("index out of range"), nil) : x__2.__array[x__2.__offset + i__1]));
			if (zone__2.name == name) {
				_tmp__3 = zone__2.offset;
				_tmp__4 = zone__2.isDST;
				_tmp__5 = true;
				offset = _tmp__3;
				isDST = _tmp__4;
				ok = _tmp__5;
				__s = -1; return [offset, isDST, ok];
			end
			_i__1++;
		end
		__s = -1; return [offset, isDST, ok];
		/* */ end return; end if __f == nil then  __f = { __blk: Location.ptr.prototype.lookupName end; end __f._i = _i; __f._i__1 = _i__1; __f._r = _r; __f._r__1 = _r__1; __f._ref = _ref; __f._ref__1 = _ref__1; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tmp__4 = _tmp__4; __f._tmp__5 = _tmp__5; __f._tuple = _tuple; __f.i = i; __f.i__1 = i__1; __f.isDST = isDST; __f.isDST__1 = isDST__1; __f.l = l; __f.nam = nam; __f.name = name; __f.offset = offset; __f.offset__1 = offset__1; __f.ok = ok; __f.unix = unix; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.zone__1 = zone__1; __f.zone__2 = zone__2; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Location.prototype.lookupName = function(x) return this.__val.lookupName(name, unix); end;
	ptrType__4.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	Time.methods = [{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Format", name: "Format", pkg: "", typ: __funcType([__String], [__String], false)end, {prop: "AppendFormat", name: "AppendFormat", pkg: "", typ: __funcType([sliceType__3, __String], [sliceType__3], false)end, {prop: "After", name: "After", pkg: "", typ: __funcType([Time], [__Bool], false)end, {prop: "Before", name: "Before", pkg: "", typ: __funcType([Time], [__Bool], false)end, {prop: "Equal", name: "Equal", pkg: "", typ: __funcType([Time], [__Bool], false)end, {prop: "IsZero", name: "IsZero", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "abs", name: "abs", pkg: "time", typ: __funcType([], [__Uint64], false)end, {prop: "locabs", name: "locabs", pkg: "time", typ: __funcType([], [__String, __Int, __Uint64], false)end, {prop: "Date", name: "Date", pkg: "", typ: __funcType([], [__Int, Month, __Int], false)end, {prop: "Year", name: "Year", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Month", name: "Month", pkg: "", typ: __funcType([], [Month], false)end, {prop: "Day", name: "Day", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Weekday", name: "Weekday", pkg: "", typ: __funcType([], [Weekday], false)end, {prop: "ISOWeek", name: "ISOWeek", pkg: "", typ: __funcType([], [__Int, __Int], false)end, {prop: "Clock", name: "Clock", pkg: "", typ: __funcType([], [__Int, __Int, __Int], false)end, {prop: "Hour", name: "Hour", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Minute", name: "Minute", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Second", name: "Second", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Nanosecond", name: "Nanosecond", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "YearDay", name: "YearDay", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Add", name: "Add", pkg: "", typ: __funcType([Duration], [Time], false)end, {prop: "Sub", name: "Sub", pkg: "", typ: __funcType([Time], [Duration], false)end, {prop: "AddDate", name: "AddDate", pkg: "", typ: __funcType([__Int, __Int, __Int], [Time], false)end, {prop: "date", name: "date", pkg: "time", typ: __funcType([__Bool], [__Int, Month, __Int, __Int], false)end, {prop: "UTC", name: "UTC", pkg: "", typ: __funcType([], [Time], false)end, {prop: "Local", name: "Local", pkg: "", typ: __funcType([], [Time], false)end, {prop: "In", name: "In", pkg: "", typ: __funcType([ptrType__2], [Time], false)end, {prop: "Location", name: "Location", pkg: "", typ: __funcType([], [ptrType__2], false)end, {prop: "Zone", name: "Zone", pkg: "", typ: __funcType([], [__String, __Int], false)end, {prop: "Unix", name: "Unix", pkg: "", typ: __funcType([], [__Int64], false)end, {prop: "UnixNano", name: "UnixNano", pkg: "", typ: __funcType([], [__Int64], false)end, {prop: "MarshalBinary", name: "MarshalBinary", pkg: "", typ: __funcType([], [sliceType__3, __error], false)end, {prop: "GobEncode", name: "GobEncode", pkg: "", typ: __funcType([], [sliceType__3, __error], false)end, {prop: "MarshalJSON", name: "MarshalJSON", pkg: "", typ: __funcType([], [sliceType__3, __error], false)end, {prop: "MarshalText", name: "MarshalText", pkg: "", typ: __funcType([], [sliceType__3, __error], false)end, {prop: "Truncate", name: "Truncate", pkg: "", typ: __funcType([Duration], [Time], false)end, {prop: "Round", name: "Round", pkg: "", typ: __funcType([Duration], [Time], false)end];
	ptrType__7.methods = [{prop: "nsec", name: "nsec", pkg: "time", typ: __funcType([], [__Int32], false)end, {prop: "sec", name: "sec", pkg: "time", typ: __funcType([], [__Int64], false)end, {prop: "unixSec", name: "unixSec", pkg: "time", typ: __funcType([], [__Int64], false)end, {prop: "addSec", name: "addSec", pkg: "time", typ: __funcType([__Int64], [], false)end, {prop: "setLoc", name: "setLoc", pkg: "time", typ: __funcType([ptrType__2], [], false)end, {prop: "stripMono", name: "stripMono", pkg: "time", typ: __funcType([], [], false)end, {prop: "setMono", name: "setMono", pkg: "time", typ: __funcType([__Int64], [], false)end, {prop: "mono", name: "mono", pkg: "time", typ: __funcType([], [__Int64], false)end, {prop: "UnmarshalBinary", name: "UnmarshalBinary", pkg: "", typ: __funcType([sliceType__3], [__error], false)end, {prop: "GobDecode", name: "GobDecode", pkg: "", typ: __funcType([sliceType__3], [__error], false)end, {prop: "UnmarshalJSON", name: "UnmarshalJSON", pkg: "", typ: __funcType([sliceType__3], [__error], false)end, {prop: "UnmarshalText", name: "UnmarshalText", pkg: "", typ: __funcType([sliceType__3], [__error], false)end];
	Month.methods = [{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end];
	Weekday.methods = [{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end];
	Duration.methods = [{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Nanoseconds", name: "Nanoseconds", pkg: "", typ: __funcType([], [__Int64], false)end, {prop: "Seconds", name: "Seconds", pkg: "", typ: __funcType([], [__Float64], false)end, {prop: "Minutes", name: "Minutes", pkg: "", typ: __funcType([], [__Float64], false)end, {prop: "Hours", name: "Hours", pkg: "", typ: __funcType([], [__Float64], false)end, {prop: "Truncate", name: "Truncate", pkg: "", typ: __funcType([Duration], [Duration], false)end, {prop: "Round", name: "Round", pkg: "", typ: __funcType([Duration], [Duration], false)end];
	ptrType__2.methods = [{prop: "get", name: "get", pkg: "time", typ: __funcType([], [ptrType__2], false)end, {prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "lookup", name: "lookup", pkg: "time", typ: __funcType([__Int64], [__String, __Int, __Bool, __Int64, __Int64], false)end, {prop: "lookupFirstZone", name: "lookupFirstZone", pkg: "time", typ: __funcType([], [__Int], false)end, {prop: "firstZoneUsed", name: "firstZoneUsed", pkg: "time", typ: __funcType([], [__Bool], false)end, {prop: "lookupName", name: "lookupName", pkg: "time", typ: __funcType([__String, __Int64], [__Int, __Bool, __Bool], false)end];
	ParseError.init("", [{prop: "Layout", name: "Layout", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Value", name: "Value", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "LayoutElem", name: "LayoutElem", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "ValueElem", name: "ValueElem", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Message", name: "Message", anonymous: false, exported: true, typ: __String, tag: ""end]);
	Time.init("time", [{prop: "wall", name: "wall", anonymous: false, exported: false, typ: __Uint64, tag: ""end, {prop: "ext", name: "ext", anonymous: false, exported: false, typ: __Int64, tag: ""end, {prop: "loc", name: "loc", anonymous: false, exported: false, typ: ptrType__2, tag: ""end]);
	Location.init("time", [{prop: "name", name: "name", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "zone", name: "zone", anonymous: false, exported: false, typ: sliceType, tag: ""end, {prop: "tx", name: "tx", anonymous: false, exported: false, typ: sliceType__1, tag: ""end, {prop: "cacheStart", name: "cacheStart", anonymous: false, exported: false, typ: __Int64, tag: ""end, {prop: "cacheEnd", name: "cacheEnd", anonymous: false, exported: false, typ: __Int64, tag: ""end, {prop: "cacheZone", name: "cacheZone", anonymous: false, exported: false, typ: ptrType, tag: ""end]);
	zone.init("time", [{prop: "name", name: "name", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "offset", name: "offset", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "isDST", name: "isDST", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	zoneTrans.init("time", [{prop: "when", name: "when", anonymous: false, exported: false, typ: __Int64, tag: ""end, {prop: "index", name: "index", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "isstd", name: "isstd", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "isutc", name: "isutc", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = js.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = nosync.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = runtime.__init(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = syscall.__init(); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		localLoc = new Location.ptr("", sliceType.nil, sliceType__1.nil, new __Int64(0, 0), new __Int64(0, 0), ptrType.nil);
		localOnce = new nosync.Once.ptr(false, false);
		std0x = __toNativeArray(__kindInt, [260, 265, 524, 526, 528, 274]);
		longDayNames = new sliceType__2(["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]);
		shortDayNames = new sliceType__2(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]);
		shortMonthNames = new sliceType__2(["---", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]);
		longMonthNames = new sliceType__2(["---", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]);
		atoiError = errors.New("time: invalid number");
		errBad = errors.New("bad value for field");
		errLeadingInt = errors.New("time: bad [0-9]*");
		months = __toNativeArray(__kindString, ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]);
		days = __toNativeArray(__kindString, ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]);
		daysBefore = __toNativeArray(__kindInt32, [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365]);
		utcLoc = new Location.ptr("UTC", sliceType.nil, sliceType__1.nil, new __Int64(0, 0), new __Int64(0, 0), ptrType.nil);
		__pkg.UTC = utcLoc;
		__pkg.Local = localLoc;
		errLocation = errors.New("time: invalid location name");
		badData = errors.New("malformed time zone information");
		init();
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["internal/poll"] = (function()
	var __pkg = {}, __init, errors, io, atomic, syscall, time, pollDesc, TimeoutError, fdMutex, FD, ptrType, ptrType__1, arrayType, sliceType, ptrType__2, ptrType__3, ptrType__4, ptrType__5, ptrType__6, ptrType__7, sliceType__1, ptrType__8, funcType, funcType__1, ptrType__9, ptrType__10, ptrType__11, sliceType__2, ptrType__12, errClosing, consume, runtime_Semacquire, runtime_Semrelease, accept;
	errors = __packages["errors"];
	io = __packages["io"];
	atomic = __packages["sync/atomic"];
	syscall = __packages["syscall"];
	time = __packages["time"];
	pollDesc = __pkg.pollDesc = __newType(0, __kindStruct, "poll.pollDesc", true, "internal/poll", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.closing = false;
			return;
		end
		this.closing = closing_;
	end);
	TimeoutError = __pkg.TimeoutError = __newType(0, __kindStruct, "poll.TimeoutError", true, "internal/poll", true, function()
		this.__val = this;
		if (arguments.length == 0) {
			return;
		end
	end);
	fdMutex = __pkg.fdMutex = __newType(0, __kindStruct, "poll.fdMutex", true, "internal/poll", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.state = new __Uint64(0, 0);
			this.rsema = 0;
			this.wsema = 0;
			return;
		end
		this.state = state_;
		this.rsema = rsema_;
		this.wsema = wsema_;
	end);
	FD = __pkg.FD = __newType(0, __kindStruct, "poll.FD", true, "internal/poll", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.fdmu = new fdMutex.ptr(new __Uint64(0, 0), 0, 0);
			this.Sysfd = 0;
			this.pd = new pollDesc.ptr(false);
			this.iovecs = ptrType__2.nil;
			this.IsStream = false;
			this.ZeroReadIsEOF = false;
			this.isFile = false;
			return;
		end
		this.fdmu = fdmu_;
		this.Sysfd = Sysfd_;
		this.pd = pd_;
		this.iovecs = iovecs_;
		this.IsStream = IsStream_;
		this.ZeroReadIsEOF = ZeroReadIsEOF_;
		this.isFile = isFile_;
	end);
	ptrType = __ptrType(__Uint64);
	ptrType__1 = __ptrType(__Uint32);
	arrayType = __arrayType(__Uint8, 4);
	sliceType = __sliceType(syscall.Iovec);
	ptrType__2 = __ptrType(sliceType);
	ptrType__3 = __ptrType(__Uint8);
	ptrType__4 = __ptrType(FD);
	ptrType__5 = __ptrType(pollDesc);
	ptrType__6 = __ptrType(TimeoutError);
	ptrType__7 = __ptrType(fdMutex);
	sliceType__1 = __sliceType(__Uint8);
	ptrType__8 = __ptrType(syscall.Stat_t);
	funcType = __funcType([__Uintptr], [], false);
	funcType__1 = __funcType([__Uintptr], [__Bool], false);
	ptrType__9 = __ptrType(syscall.Linger);
	ptrType__10 = __ptrType(syscall.IPMreq);
	ptrType__11 = __ptrType(syscall.IPv6Mreq);
	sliceType__2 = __sliceType(sliceType__1);
	ptrType__12 = __ptrType(sliceType__2);
	pollDesc.ptr.prototype.init = function(d)
		var fd, pd;
		pd = this;
		return __ifaceNil;
	end;
	pollDesc.prototype.init = function(d) return this.__val.init(fd); end;
	pollDesc.ptr.prototype.close = function()
		var pd;
		pd = this;
	end;
	pollDesc.prototype.close = function() return this.__val.close(); end;
	pollDesc.ptr.prototype.evict = function()
		var pd;
		pd = this;
		pd.closing = true;
	end;
	pollDesc.prototype.evict = function() return this.__val.evict(); end;
	pollDesc.ptr.prototype.prepare = function(e)
		var isFile, mode, pd;
		pd = this;
		if (pd.closing) {
			return errClosing(isFile);
		end
		return __ifaceNil;
	end;
	pollDesc.prototype.prepare = function(e) return this.__val.prepare(mode, isFile); end;
	pollDesc.ptr.prototype.prepareRead = function(e)
		var isFile, pd;
		pd = this;
		return pd.prepare(114, isFile);
	end;
	pollDesc.prototype.prepareRead = function(e) return this.__val.prepareRead(isFile); end;
	pollDesc.ptr.prototype.prepareWrite = function(e)
		var isFile, pd;
		pd = this;
		return pd.prepare(119, isFile);
	end;
	pollDesc.prototype.prepareWrite = function(e) return this.__val.prepareWrite(isFile); end;
	pollDesc.ptr.prototype.wait = function(e)
		var isFile, mode, pd;
		pd = this;
		if (pd.closing) {
			return errClosing(isFile);
		end
		return __pkg.ErrTimeout;
	end;
	pollDesc.prototype.wait = function(e) return this.__val.wait(mode, isFile); end;
	pollDesc.ptr.prototype.waitRead = function(e)
		var isFile, pd;
		pd = this;
		return pd.wait(114, isFile);
	end;
	pollDesc.prototype.waitRead = function(e) return this.__val.waitRead(isFile); end;
	pollDesc.ptr.prototype.waitWrite = function(e)
		var isFile, pd;
		pd = this;
		return pd.wait(119, isFile);
	end;
	pollDesc.prototype.waitWrite = function(e) return this.__val.waitWrite(isFile); end;
	pollDesc.ptr.prototype.pollable = function()
		return true;
	end;
	pollDesc.prototype.pollable = function() return this.__val.pollable(); end;
	FD.ptr.prototype.SetDeadline = function(t)
		var t;
		return __ifaceNil;
	end;
	FD.prototype.SetDeadline = function(t) return this.__val.SetDeadline(t); end;
	FD.ptr.prototype.SetReadDeadline = function(t)
		var t;
		return __ifaceNil;
	end;
	FD.prototype.SetReadDeadline = function(t) return this.__val.SetReadDeadline(t); end;
	FD.ptr.prototype.SetWriteDeadline = function(t)
		var t;
		return __ifaceNil;
	end;
	FD.prototype.SetWriteDeadline = function(t) return this.__val.SetWriteDeadline(t); end;
	errClosing = function(e)
		var isFile;
		if (isFile) {
			return __pkg.ErrFileClosing;
		end
		return __pkg.ErrNetClosing;
	end;
	TimeoutError.ptr.prototype.Error = function()
		var e;
		e = this;
		return "i/o timeout";
	end;
	TimeoutError.prototype.Error = function() return this.__val.Error(); end;
	TimeoutError.ptr.prototype.Timeout = function()
		var e;
		e = this;
		return true;
	end;
	TimeoutError.prototype.Timeout = function() return this.__val.Timeout(); end;
	TimeoutError.ptr.prototype.Temporary = function()
		var e;
		e = this;
		return true;
	end;
	TimeoutError.prototype.Temporary = function() return this.__val.Temporary(); end;
	consume = function(n)
		var ln0, n, v, x, x__1, x__2, x__3;
		while (true) {
			if ( not (v.__get().__length > 0)) { break; end
			ln0 = (new __Int64(0, (x = v.__get(), (0 >= x.__length ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + 0])).__length));
			if ((ln0.__high > n.__high  or  (ln0.__high == n.__high  and  ln0.__low > n.__low))) {
				(x__2 = v.__get(), (0 >= x__2.__length ? (__throwRuntimeError("index out of range"), nil) : x__2.__array[x__2.__offset + 0] = __subslice((x__1 = v.__get(), (0 >= x__1.__length ? (__throwRuntimeError("index out of range"), nil) : x__1.__array[x__1.__offset + 0])), __flatten64(n))));
				return;
			end
			n = (x__3 = ln0, new __Int64(n.__high - x__3.__high, n.__low - x__3.__low));
			v.__set(__subslice((v.__get()), 1));
		end
	end;
	fdMutex.ptr.prototype.incref = function()
		var mu, new__1, old, x, x__1;
		mu = this;
		while (true) {
			old = atomic.LoadUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))));
			if ( not ((x = new __Uint64(old.__high & 0, (old.__low & 1) >>> 0), (x.__high == 0  and  x.__low == 0)))) {
				return false;
			end
			new__1 = new __Uint64(old.__high + 0, old.__low + 8);
			if ((x__1 = new __Uint64(new__1.__high & 0, (new__1.__low & 8388600) >>> 0), (x__1.__high == 0  and  x__1.__low == 0))) {
				__panic(new __String("inconsistent poll.fdMutex"));
			end
			if (atomic.CompareAndSwapUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))), old, new__1)) {
				return true;
			end
		end
	end;
	fdMutex.prototype.incref = function() return this.__val.incref(); end;
	fdMutex.ptr.prototype.increfAndClose = function()
		var mu, new__1, old, x, x__1, x__2, x__3, x__4, x__5, x__6, x__7;
		mu = this;
		while (true) {
			old = atomic.LoadUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))));
			if ( not ((x = new __Uint64(old.__high & 0, (old.__low & 1) >>> 0), (x.__high == 0  and  x.__low == 0)))) {
				return false;
			end
			new__1 = (x__1 = new __Uint64(old.__high | 0, (old.__low | 1) >>> 0), new __Uint64(x__1.__high + 0, x__1.__low + 8));
			if ((x__2 = new __Uint64(new__1.__high & 0, (new__1.__low & 8388600) >>> 0), (x__2.__high == 0  and  x__2.__low == 0))) {
				__panic(new __String("inconsistent poll.fdMutex"));
			end
			new__1 = (x__3 = new __Uint64(2147483647, 4286578688), new __Uint64(new__1.__high & ~x__3.__high, (new__1.__low & ~x__3.__low) >>> 0));
			if (atomic.CompareAndSwapUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))), old, new__1)) {
				while (true) {
					if ( not ( not ((x__4 = new __Uint64(old.__high & 2047, (old.__low & 4286578688) >>> 0), (x__4.__high == 0  and  x__4.__low == 0))))) { break; end
					old = (x__5 = new __Uint64(0, 8388608), new __Uint64(old.__high - x__5.__high, old.__low - x__5.__low));
					runtime_Semrelease((mu.__ptr_rsema  or  (mu.__ptr_rsema = new ptrType__1(function() return this.__target.rsema; end, function(v) this.__target.rsema = __v; end, mu))));
				end
				while (true) {
					if ( not ( not ((x__6 = new __Uint64(old.__high & 2147481600, (old.__low & 0) >>> 0), (x__6.__high == 0  and  x__6.__low == 0))))) { break; end
					old = (x__7 = new __Uint64(2048, 0), new __Uint64(old.__high - x__7.__high, old.__low - x__7.__low));
					runtime_Semrelease((mu.__ptr_wsema  or  (mu.__ptr_wsema = new ptrType__1(function() return this.__target.wsema; end, function(v) this.__target.wsema = __v; end, mu))));
				end
				return true;
			end
		end
	end;
	fdMutex.prototype.increfAndClose = function() return this.__val.increfAndClose(); end;
	fdMutex.ptr.prototype.decref = function()
		var mu, new__1, old, x, x__1;
		mu = this;
		while (true) {
			old = atomic.LoadUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))));
			if ((x = new __Uint64(old.__high & 0, (old.__low & 8388600) >>> 0), (x.__high == 0  and  x.__low == 0))) {
				__panic(new __String("inconsistent poll.fdMutex"));
			end
			new__1 = new __Uint64(old.__high - 0, old.__low - 8);
			if (atomic.CompareAndSwapUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))), old, new__1)) {
				return (x__1 = new __Uint64(new__1.__high & 0, (new__1.__low & 8388601) >>> 0), (x__1.__high == 0  and  x__1.__low == 1));
			end
		end
	end;
	fdMutex.prototype.decref = function() return this.__val.decref(); end;
	fdMutex.ptr.prototype.rwlock = function(d)
		var _tmp, _tmp__1, _tmp__2, mu, mutexBit, mutexMask, mutexSema, mutexWait, new__1, old, read, x, x__1, x__2, x__3, x__4, x__5;
		mu = this;
		_tmp = new __Uint64(0, 0);
		_tmp__1 = new __Uint64(0, 0);
		_tmp__2 = new __Uint64(0, 0);
		mutexBit = _tmp;
		mutexWait = _tmp__1;
		mutexMask = _tmp__2;
		mutexSema = ptrType__1.nil;
		if (read) {
			mutexBit = new __Uint64(0, 2);
			mutexWait = new __Uint64(0, 8388608);
			mutexMask = new __Uint64(2047, 4286578688);
			mutexSema = (mu.__ptr_rsema  or  (mu.__ptr_rsema = new ptrType__1(function() return this.__target.rsema; end, function(v) this.__target.rsema = __v; end, mu)));
		end else {
			mutexBit = new __Uint64(0, 4);
			mutexWait = new __Uint64(2048, 0);
			mutexMask = new __Uint64(2147481600, 0);
			mutexSema = (mu.__ptr_wsema  or  (mu.__ptr_wsema = new ptrType__1(function() return this.__target.wsema; end, function(v) this.__target.wsema = __v; end, mu)));
		end
		while (true) {
			old = atomic.LoadUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))));
			if ( not ((x = new __Uint64(old.__high & 0, (old.__low & 1) >>> 0), (x.__high == 0  and  x.__low == 0)))) {
				return false;
			end
			new__1 = new __Uint64(0, 0);
			if ((x__1 = new __Uint64(old.__high & mutexBit.__high, (old.__low & mutexBit.__low) >>> 0), (x__1.__high == 0  and  x__1.__low == 0))) {
				new__1 = (x__2 = new __Uint64(old.__high | mutexBit.__high, (old.__low | mutexBit.__low) >>> 0), new __Uint64(x__2.__high + 0, x__2.__low + 8));
				if ((x__3 = new __Uint64(new__1.__high & 0, (new__1.__low & 8388600) >>> 0), (x__3.__high == 0  and  x__3.__low == 0))) {
					__panic(new __String("inconsistent poll.fdMutex"));
				end
			end else {
				new__1 = new __Uint64(old.__high + mutexWait.__high, old.__low + mutexWait.__low);
				if ((x__4 = new __Uint64(new__1.__high & mutexMask.__high, (new__1.__low & mutexMask.__low) >>> 0), (x__4.__high == 0  and  x__4.__low == 0))) {
					__panic(new __String("inconsistent poll.fdMutex"));
				end
			end
			if (atomic.CompareAndSwapUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))), old, new__1)) {
				if ((x__5 = new __Uint64(old.__high & mutexBit.__high, (old.__low & mutexBit.__low) >>> 0), (x__5.__high == 0  and  x__5.__low == 0))) {
					return true;
				end
				runtime_Semacquire(mutexSema);
			end
		end
	end;
	fdMutex.prototype.rwlock = function(d) return this.__val.rwlock(read); end;
	fdMutex.ptr.prototype.rwunlock = function(d)
		var _tmp, _tmp__1, _tmp__2, mu, mutexBit, mutexMask, mutexSema, mutexWait, new__1, old, read, x, x__1, x__2, x__3, x__4, x__5, x__6;
		mu = this;
		_tmp = new __Uint64(0, 0);
		_tmp__1 = new __Uint64(0, 0);
		_tmp__2 = new __Uint64(0, 0);
		mutexBit = _tmp;
		mutexWait = _tmp__1;
		mutexMask = _tmp__2;
		mutexSema = ptrType__1.nil;
		if (read) {
			mutexBit = new __Uint64(0, 2);
			mutexWait = new __Uint64(0, 8388608);
			mutexMask = new __Uint64(2047, 4286578688);
			mutexSema = (mu.__ptr_rsema  or  (mu.__ptr_rsema = new ptrType__1(function() return this.__target.rsema; end, function(v) this.__target.rsema = __v; end, mu)));
		end else {
			mutexBit = new __Uint64(0, 4);
			mutexWait = new __Uint64(2048, 0);
			mutexMask = new __Uint64(2147481600, 0);
			mutexSema = (mu.__ptr_wsema  or  (mu.__ptr_wsema = new ptrType__1(function() return this.__target.wsema; end, function(v) this.__target.wsema = __v; end, mu)));
		end
		while (true) {
			old = atomic.LoadUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))));
			if ((x = new __Uint64(old.__high & mutexBit.__high, (old.__low & mutexBit.__low) >>> 0), (x.__high == 0  and  x.__low == 0))  or  (x__1 = new __Uint64(old.__high & 0, (old.__low & 8388600) >>> 0), (x__1.__high == 0  and  x__1.__low == 0))) {
				__panic(new __String("inconsistent poll.fdMutex"));
			end
			new__1 = (x__2 = new __Uint64(old.__high & ~mutexBit.__high, (old.__low & ~mutexBit.__low) >>> 0), new __Uint64(x__2.__high - 0, x__2.__low - 8));
			if ( not ((x__3 = new __Uint64(old.__high & mutexMask.__high, (old.__low & mutexMask.__low) >>> 0), (x__3.__high == 0  and  x__3.__low == 0)))) {
				new__1 = (x__4 = mutexWait, new __Uint64(new__1.__high - x__4.__high, new__1.__low - x__4.__low));
			end
			if (atomic.CompareAndSwapUint64((mu.__ptr_state  or  (mu.__ptr_state = new ptrType(function() return this.__target.state; end, function(v) this.__target.state = __v; end, mu))), old, new__1)) {
				if ( not ((x__5 = new __Uint64(old.__high & mutexMask.__high, (old.__low & mutexMask.__low) >>> 0), (x__5.__high == 0  and  x__5.__low == 0)))) {
					runtime_Semrelease(mutexSema);
				end
				return (x__6 = new __Uint64(new__1.__high & 0, (new__1.__low & 8388601) >>> 0), (x__6.__high == 0  and  x__6.__low == 1));
			end
		end
	end;
	fdMutex.prototype.rwunlock = function(d) return this.__val.rwunlock(read); end;
	runtime_Semacquire = function()
		__throwRuntimeError("native function not implemented: internal/poll.runtime_Semacquire");
	end;
	runtime_Semrelease = function()
		__throwRuntimeError("native function not implemented: internal/poll.runtime_Semrelease");
	end;
	FD.ptr.prototype.incref = function()
		var fd;
		fd = this;
		if ( not fd.fdmu.incref()) {
			return errClosing(fd.isFile);
		end
		return __ifaceNil;
	end;
	FD.prototype.incref = function() return this.__val.incref(); end;
	FD.ptr.prototype.decref = function()
		var _r, fd, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; fd = __f.fd; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fd = this;
		/* */ if (fd.fdmu.decref()) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (fd.fdmu.decref()) { */ case 1:
			_r = fd.destroy(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			__s = -1; return _r;
		/* end */ case 2:
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: FD.ptr.prototype.decref end; end __f._r = _r; __f.fd = fd; __f.__s = __s; __f.__r = __r; return __f;
	end;
	FD.prototype.decref = function() return this.__val.decref(); end;
	FD.ptr.prototype.readLock = function()
		var fd;
		fd = this;
		if ( not fd.fdmu.rwlock(true)) {
			return errClosing(fd.isFile);
		end
		return __ifaceNil;
	end;
	FD.prototype.readLock = function() return this.__val.readLock(); end;
	FD.ptr.prototype.readUnlock = function()
		var _r, fd, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; fd = __f.fd; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fd = this;
		/* */ if (fd.fdmu.rwunlock(true)) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (fd.fdmu.rwunlock(true)) { */ case 1:
			_r = fd.destroy(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_r;
		/* end */ case 2:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: FD.ptr.prototype.readUnlock end; end __f._r = _r; __f.fd = fd; __f.__s = __s; __f.__r = __r; return __f;
	end;
	FD.prototype.readUnlock = function() return this.__val.readUnlock(); end;
	FD.ptr.prototype.writeLock = function()
		var fd;
		fd = this;
		if ( not fd.fdmu.rwlock(false)) {
			return errClosing(fd.isFile);
		end
		return __ifaceNil;
	end;
	FD.prototype.writeLock = function() return this.__val.writeLock(); end;
	FD.ptr.prototype.writeUnlock = function()
		var _r, fd, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; fd = __f.fd; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fd = this;
		/* */ if (fd.fdmu.rwunlock(false)) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (fd.fdmu.rwunlock(false)) { */ case 1:
			_r = fd.destroy(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_r;
		/* end */ case 2:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: FD.ptr.prototype.writeUnlock end; end __f._r = _r; __f.fd = fd; __f.__s = __s; __f.__r = __r; return __f;
	end;
	FD.prototype.writeUnlock = function() return this.__val.writeUnlock(); end;
	FD.ptr.prototype.eofError = function(r)
		var err, fd, n;
		fd = this;
		if ((n == 0)  and  __interfaceIsEqual(err, __ifaceNil)  and  fd.ZeroReadIsEOF) {
			return io.EOF;
		end
		return err;
	end;
	FD.prototype.eofError = function(r) return this.__val.eofError(n, err); end;
	FD.ptr.prototype.Fchmod = function(e)
		var err, fd, mode, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; mode = __f.mode; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Fchmod(fd.Sysfd, mode);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Fchmod end; end __f.err = err; __f.fd = fd; __f.mode = mode; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Fchmod = function(e) return this.__val.Fchmod(mode); end;
	FD.ptr.prototype.Fchown = function(d)
		var err, fd, gid, uid, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; gid = __f.gid; uid = __f.uid; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Fchown(fd.Sysfd, uid, gid);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Fchown end; end __f.err = err; __f.fd = fd; __f.gid = gid; __f.uid = uid; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Fchown = function(d) return this.__val.Fchown(uid, gid); end;
	FD.ptr.prototype.Ftruncate = function(e)
		var err, fd, size, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; size = __f.size; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Ftruncate(fd.Sysfd, size);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Ftruncate end; end __f.err = err; __f.fd = fd; __f.size = size; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Ftruncate = function(e) return this.__val.Ftruncate(size); end;
	FD.ptr.prototype.Fsync = function()
		var err, fd, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Fsync(fd.Sysfd);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Fsync end; end __f.err = err; __f.fd = fd; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Fsync = function() return this.__val.Fsync(); end;
	FD.ptr.prototype.Init = function(e)
		var fd, net, pollable;
		fd = this;
		if (net == "file") {
			fd.isFile = true;
		end
		if ( not pollable) {
			return __ifaceNil;
		end
		return fd.pd.init(fd);
	end;
	FD.prototype.Init = function(e) return this.__val.Init(net, pollable); end;
	FD.ptr.prototype.destroy = function()
		var _r, err, fd, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; err = __f.err; fd = __f.fd; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fd = this;
		fd.pd.close();
		_r = __pkg.CloseFunc(fd.Sysfd); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		err = _r;
		fd.Sysfd = -1;
		__s = -1; return err;
		/* */ end return; end if __f == nil then  __f = { __blk: FD.ptr.prototype.destroy end; end __f._r = _r; __f.err = err; __f.fd = fd; __f.__s = __s; __f.__r = __r; return __f;
	end;
	FD.prototype.destroy = function() return this.__val.destroy(); end;
	FD.ptr.prototype.Close = function()
		var _r, fd, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; fd = __f.fd; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fd = this;
		if ( not fd.fdmu.increfAndClose()) {
			__s = -1; return errClosing(fd.isFile);
		end
		fd.pd.evict();
		_r = fd.decref(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: FD.ptr.prototype.Close end; end __f._r = _r; __f.fd = fd; __f.__s = __s; __f.__r = __r; return __f;
	end;
	FD.prototype.Close = function() return this.__val.Close(); end;
	FD.ptr.prototype.Shutdown = function(w)
		var err, fd, how, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; how = __f.how; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Shutdown(fd.Sysfd, how);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Shutdown end; end __f.err = err; __f.fd = fd; __f.how = how; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Shutdown = function(w) return this.__val.Shutdown(how); end;
	FD.ptr.prototype.Read = function(p)
		var _tuple, err, err__1, err__2, fd, n, p, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; fd = __f.fd; n = __f.n; p = __f.p; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.readLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, err];
		end
		__deferred.push([__methodVal(fd, "readUnlock"), []]);
		if (p.__length == 0) {
			__s = -1; return [0, __ifaceNil];
		end
		err__1 = fd.pd.prepareRead(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [0, err__1];
		end
		if (fd.IsStream  and  p.__length > 1073741824) {
			p = __subslice(p, 0, 1073741824);
		end
		while (true) {
			_tuple = syscall.Read(fd.Sysfd, p);
			n = _tuple[0];
			err__2 = _tuple[1];
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				n = 0;
				if (__interfaceIsEqual(err__2, new syscall.Errno(35))  and  fd.pd.pollable()) {
					err__2 = fd.pd.waitRead(fd.isFile);
					if (__interfaceIsEqual(err__2, __ifaceNil)) {
						continue;
					end
				end
			end
			err__2 = fd.eofError(n, err__2);
			__s = -1; return [n, err__2];
		end
		__s = -1; return [0, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Read end; end __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.fd = fd; __f.n = n; __f.p = p; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Read = function(p) return this.__val.Read(p); end;
	FD.ptr.prototype.Pread = function(f)
		var _r, _tuple, err, err__1, fd, n, off, p, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; fd = __f.fd; n = __f.n; off = __f.off; p = __f.p; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, err];
		end
		if (fd.IsStream  and  p.__length > 1073741824) {
			p = __subslice(p, 0, 1073741824);
		end
		_tuple = syscall.Pread(fd.Sysfd, p, off);
		n = _tuple[0];
		err__1 = _tuple[1];
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			n = 0;
		end
		_r = fd.decref(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r;
		err__1 = fd.eofError(n, err__1);
		__s = -1; return [n, err__1];
		/* */ end return; end if __f == nil then  __f = { __blk: FD.ptr.prototype.Pread end; end __f._r = _r; __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.fd = fd; __f.n = n; __f.off = off; __f.p = p; __f.__s = __s; __f.__r = __r; return __f;
	end;
	FD.prototype.Pread = function(f) return this.__val.Pread(p, off); end;
	FD.ptr.prototype.ReadFrom = function(p)
		var _tuple, err, err__1, err__2, fd, n, p, sa, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; fd = __f.fd; n = __f.n; p = __f.p; sa = __f.sa; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.readLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, __ifaceNil, err];
		end
		__deferred.push([__methodVal(fd, "readUnlock"), []]);
		err__1 = fd.pd.prepareRead(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [0, __ifaceNil, err__1];
		end
		while (true) {
			_tuple = syscall.Recvfrom(fd.Sysfd, p, 0);
			n = _tuple[0];
			sa = _tuple[1];
			err__2 = _tuple[2];
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				n = 0;
				if (__interfaceIsEqual(err__2, new syscall.Errno(35))  and  fd.pd.pollable()) {
					err__2 = fd.pd.waitRead(fd.isFile);
					if (__interfaceIsEqual(err__2, __ifaceNil)) {
						continue;
					end
				end
			end
			err__2 = fd.eofError(n, err__2);
			__s = -1; return [n, sa, err__2];
		end
		__s = -1; return [0, __ifaceNil, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, __ifaceNil, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.ReadFrom end; end __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.fd = fd; __f.n = n; __f.p = p; __f.sa = sa; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.ReadFrom = function(p) return this.__val.ReadFrom(p); end;
	FD.ptr.prototype.ReadMsg = function(b)
		var _tuple, err, err__1, err__2, fd, flags, n, oob, oobn, p, sa, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; fd = __f.fd; flags = __f.flags; n = __f.n; oob = __f.oob; oobn = __f.oobn; p = __f.p; sa = __f.sa; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.readLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, 0, 0, __ifaceNil, err];
		end
		__deferred.push([__methodVal(fd, "readUnlock"), []]);
		err__1 = fd.pd.prepareRead(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [0, 0, 0, __ifaceNil, err__1];
		end
		while (true) {
			_tuple = syscall.Recvmsg(fd.Sysfd, p, oob, 0);
			n = _tuple[0];
			oobn = _tuple[1];
			flags = _tuple[2];
			sa = _tuple[3];
			err__2 = _tuple[4];
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				if (__interfaceIsEqual(err__2, new syscall.Errno(35))  and  fd.pd.pollable()) {
					err__2 = fd.pd.waitRead(fd.isFile);
					if (__interfaceIsEqual(err__2, __ifaceNil)) {
						continue;
					end
				end
			end
			err__2 = fd.eofError(n, err__2);
			__s = -1; return [n, oobn, flags, sa, err__2];
		end
		__s = -1; return [0, 0, 0, __ifaceNil, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, 0, 0, __ifaceNil, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.ReadMsg end; end __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.fd = fd; __f.flags = flags; __f.n = n; __f.oob = oob; __f.oobn = oobn; __f.p = p; __f.sa = sa; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.ReadMsg = function(b) return this.__val.ReadMsg(p, oob); end;
	FD.ptr.prototype.Write = function(p)
		var _tuple, err, err__1, err__2, fd, max, n, nn, p, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; fd = __f.fd; max = __f.max; n = __f.n; nn = __f.nn; p = __f.p; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.writeLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, err];
		end
		__deferred.push([__methodVal(fd, "writeUnlock"), []]);
		err__1 = fd.pd.prepareWrite(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [0, err__1];
		end
		nn = 0;
		while (true) {
			max = p.__length;
			if (fd.IsStream  and  (max - nn >> 0) > 1073741824) {
				max = nn + 1073741824 >> 0;
			end
			_tuple = syscall.Write(fd.Sysfd, __subslice(p, nn, max));
			n = _tuple[0];
			err__2 = _tuple[1];
			if (n > 0) {
				nn = nn + (n) >> 0;
			end
			if (nn == p.__length) {
				__s = -1; return [nn, err__2];
			end
			if (__interfaceIsEqual(err__2, new syscall.Errno(35))  and  fd.pd.pollable()) {
				err__2 = fd.pd.waitWrite(fd.isFile);
				if (__interfaceIsEqual(err__2, __ifaceNil)) {
					continue;
				end
			end
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				__s = -1; return [nn, err__2];
			end
			if (n == 0) {
				__s = -1; return [nn, io.ErrUnexpectedEOF];
			end
		end
		__s = -1; return [0, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Write end; end __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.fd = fd; __f.max = max; __f.n = n; __f.nn = nn; __f.p = p; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Write = function(p) return this.__val.Write(p); end;
	FD.ptr.prototype.Pwrite = function(f)
		var _tuple, err, err__1, fd, max, n, nn, off, p, x, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; fd = __f.fd; max = __f.max; n = __f.n; nn = __f.nn; off = __f.off; p = __f.p; x = __f.x; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, err];
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		nn = 0;
		while (true) {
			max = p.__length;
			if (fd.IsStream  and  (max - nn >> 0) > 1073741824) {
				max = nn + 1073741824 >> 0;
			end
			_tuple = syscall.Pwrite(fd.Sysfd, __subslice(p, nn, max), (x = (new __Int64(0, nn)), new __Int64(off.__high + x.__high, off.__low + x.__low)));
			n = _tuple[0];
			err__1 = _tuple[1];
			if (n > 0) {
				nn = nn + (n) >> 0;
			end
			if (nn == p.__length) {
				__s = -1; return [nn, err__1];
			end
			if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
				__s = -1; return [nn, err__1];
			end
			if (n == 0) {
				__s = -1; return [nn, io.ErrUnexpectedEOF];
			end
		end
		__s = -1; return [0, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Pwrite end; end __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.fd = fd; __f.max = max; __f.n = n; __f.nn = nn; __f.off = off; __f.p = p; __f.x = x; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Pwrite = function(f) return this.__val.Pwrite(p, off); end;
	FD.ptr.prototype.WriteTo = function(a)
		var _r, err, err__1, err__2, fd, p, sa, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; fd = __f.fd; p = __f.p; sa = __f.sa; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.writeLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, err];
		end
		__deferred.push([__methodVal(fd, "writeUnlock"), []]);
		err__1 = fd.pd.prepareWrite(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [0, err__1];
		end
		/* while (true) { */ case 1:
			_r = syscall.Sendto(fd.Sysfd, p, 0, sa); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			err__2 = _r;
			if (__interfaceIsEqual(err__2, new syscall.Errno(35))  and  fd.pd.pollable()) {
				err__2 = fd.pd.waitWrite(fd.isFile);
				if (__interfaceIsEqual(err__2, __ifaceNil)) {
					/* continue; */ __s = 1; continue;
				end
			end
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				__s = -1; return [0, err__2];
			end
			__s = -1; return [p.__length, __ifaceNil];
		/* end */ __s = 1; continue; case 2:
		__s = -1; return [0, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.WriteTo end; end __f._r = _r; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.fd = fd; __f.p = p; __f.sa = sa; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.WriteTo = function(a) return this.__val.WriteTo(p, sa); end;
	FD.ptr.prototype.WriteMsg = function(a)
		var _r, _tuple, err, err__1, err__2, fd, n, oob, p, sa, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; fd = __f.fd; n = __f.n; oob = __f.oob; p = __f.p; sa = __f.sa; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.writeLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, 0, err];
		end
		__deferred.push([__methodVal(fd, "writeUnlock"), []]);
		err__1 = fd.pd.prepareWrite(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [0, 0, err__1];
		end
		/* while (true) { */ case 1:
			_r = syscall.SendmsgN(fd.Sysfd, p, oob, sa, 0); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_tuple = _r;
			n = _tuple[0];
			err__2 = _tuple[1];
			if (__interfaceIsEqual(err__2, new syscall.Errno(35))  and  fd.pd.pollable()) {
				err__2 = fd.pd.waitWrite(fd.isFile);
				if (__interfaceIsEqual(err__2, __ifaceNil)) {
					/* continue; */ __s = 1; continue;
				end
			end
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				__s = -1; return [n, 0, err__2];
			end
			__s = -1; return [n, oob.__length, err__2];
		/* end */ __s = 1; continue; case 2:
		__s = -1; return [0, 0, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, 0, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.WriteMsg end; end __f._r = _r; __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.fd = fd; __f.n = n; __f.oob = oob; __f.p = p; __f.sa = sa; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.WriteMsg = function(a) return this.__val.WriteMsg(p, oob, sa); end;
	FD.ptr.prototype.Accept = function()
		var _1, _r, _tuple, err, err__1, err__2, errcall, fd, rsa, s, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; _tuple = __f._tuple; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; errcall = __f.errcall; fd = __f.fd; rsa = __f.rsa; s = __f.s; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.readLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [-1, __ifaceNil, "", err];
		end
		__deferred.push([__methodVal(fd, "readUnlock"), []]);
		err__1 = fd.pd.prepareRead(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [-1, __ifaceNil, "", err__1];
		end
		/* while (true) { */ case 1:
			_r = accept(fd.Sysfd); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_tuple = _r;
			s = _tuple[0];
			rsa = _tuple[1];
			errcall = _tuple[2];
			err__2 = _tuple[3];
			if (__interfaceIsEqual(err__2, __ifaceNil)) {
				__s = -1; return [s, rsa, "", err__2];
			end
			_1 = err__2;
			if (__interfaceIsEqual(_1, new syscall.Errno((35)))) {
				if (fd.pd.pollable()) {
					err__2 = fd.pd.waitRead(fd.isFile);
					if (__interfaceIsEqual(err__2, __ifaceNil)) {
						/* continue; */ __s = 1; continue;
					end
				end
			end else if (__interfaceIsEqual(_1, new syscall.Errno((53)))) {
				/* continue; */ __s = 1; continue;
			end
			__s = -1; return [-1, __ifaceNil, errcall, err__2];
		/* end */ __s = 1; continue; case 2:
		__s = -1; return [0, __ifaceNil, "", __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, __ifaceNil, "", __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Accept end; end __f._1 = _1; __f._r = _r; __f._tuple = _tuple; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.errcall = errcall; __f.fd = fd; __f.rsa = rsa; __f.s = s; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Accept = function() return this.__val.Accept(); end;
	FD.ptr.prototype.Seek = function(e)
		var err, fd, offset, whence, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; offset = __f.offset; whence = __f.whence; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [new __Int64(0, 0), err];
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Seek(fd.Sysfd, offset, whence);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [new __Int64(0, 0), __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Seek end; end __f.err = err; __f.fd = fd; __f.offset = offset; __f.whence = whence; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Seek = function(e) return this.__val.Seek(offset, whence); end;
	FD.ptr.prototype.ReadDirent = function(f)
		var _tuple, buf, err, err__1, fd, n, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _tuple = __f._tuple; buf = __f.buf; err = __f.err; err__1 = __f.err__1; fd = __f.fd; n = __f.n; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [0, err];
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		while (true) {
			_tuple = syscall.ReadDirent(fd.Sysfd, buf);
			n = _tuple[0];
			err__1 = _tuple[1];
			if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
				n = 0;
				if (__interfaceIsEqual(err__1, new syscall.Errno(35))  and  fd.pd.pollable()) {
					err__1 = fd.pd.waitRead(fd.isFile);
					if (__interfaceIsEqual(err__1, __ifaceNil)) {
						continue;
					end
				end
			end
			__s = -1; return [n, err__1];
		end
		__s = -1; return [0, __ifaceNil];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [0, __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.ReadDirent end; end __f._tuple = _tuple; __f.buf = buf; __f.err = err; __f.err__1 = err__1; __f.fd = fd; __f.n = n; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.ReadDirent = function(f) return this.__val.ReadDirent(buf); end;
	FD.ptr.prototype.Fchdir = function()
		var err, fd, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Fchdir(fd.Sysfd);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Fchdir end; end __f.err = err; __f.fd = fd; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Fchdir = function() return this.__val.Fchdir(); end;
	FD.ptr.prototype.Fstat = function(s)
		var err, fd, s, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; s = __f.s; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.Fstat(fd.Sysfd, s);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Fstat end; end __f.err = err; __f.fd = fd; __f.s = s; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Fstat = function(s) return this.__val.Fstat(s); end;
	FD.ptr.prototype.WaitWrite = function()
		var fd;
		fd = this;
		return fd.pd.waitWrite(fd.isFile);
	end;
	FD.prototype.WaitWrite = function() return this.__val.WaitWrite(); end;
	FD.ptr.prototype.RawControl = function(f)
		var err, f, fd, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; f = __f.f; fd = __f.fd; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__r = f(((fd.Sysfd >>> 0))); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__s = -1; return __ifaceNil;
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.RawControl end; end __f.err = err; __f.f = f; __f.fd = fd; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.RawControl = function(f) return this.__val.RawControl(f); end;
	FD.ptr.prototype.RawRead = function(f)
		var _r, err, err__1, err__2, f, fd, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; f = __f.f; fd = __f.fd; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.readLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "readUnlock"), []]);
		err__1 = fd.pd.prepareRead(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return err__1;
		end
		/* while (true) { */ case 1:
			_r = f(((fd.Sysfd >>> 0))); /* */ __s = 5; case 5: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			/* */ if (_r) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if (_r) { */ case 3:
				__s = -1; return __ifaceNil;
			/* end */ case 4:
			err__2 = fd.pd.waitRead(fd.isFile);
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				__s = -1; return err__2;
			end
		/* end */ __s = 1; continue; case 2:
		__s = -1; return __ifaceNil;
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.RawRead end; end __f._r = _r; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.f = f; __f.fd = fd; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.RawRead = function(f) return this.__val.RawRead(f); end;
	FD.ptr.prototype.RawWrite = function(f)
		var _r, err, err__1, err__2, f, fd, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; f = __f.f; fd = __f.fd; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.writeLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "writeUnlock"), []]);
		err__1 = fd.pd.prepareWrite(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return err__1;
		end
		/* while (true) { */ case 1:
			_r = f(((fd.Sysfd >>> 0))); /* */ __s = 5; case 5: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			/* */ if (_r) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if (_r) { */ case 3:
				__s = -1; return __ifaceNil;
			/* end */ case 4:
			err__2 = fd.pd.waitWrite(fd.isFile);
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				__s = -1; return err__2;
			end
		/* end */ __s = 1; continue; case 2:
		__s = -1; return __ifaceNil;
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.RawWrite end; end __f._r = _r; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.f = f; __f.fd = fd; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.RawWrite = function(f) return this.__val.RawWrite(f); end;
	FD.ptr.prototype.SetsockoptInt = function(g)
		var arg, err, fd, level, name, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; arg = __f.arg; err = __f.err; fd = __f.fd; level = __f.level; name = __f.name; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.SetsockoptInt(fd.Sysfd, level, name, arg);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.SetsockoptInt end; end __f.arg = arg; __f.err = err; __f.fd = fd; __f.level = level; __f.name = name; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.SetsockoptInt = function(g) return this.__val.SetsockoptInt(level, name, arg); end;
	FD.ptr.prototype.SetsockoptInet4Addr = function(g)
		var arg, err, fd, level, name, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; arg = __f.arg; err = __f.err; fd = __f.fd; level = __f.level; name = __f.name; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.SetsockoptInet4Addr(fd.Sysfd, level, name, __clone(arg, arrayType));
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.SetsockoptInet4Addr end; end __f.arg = arg; __f.err = err; __f.fd = fd; __f.level = level; __f.name = name; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.SetsockoptInet4Addr = function(g) return this.__val.SetsockoptInet4Addr(level, name, arg); end;
	FD.ptr.prototype.SetsockoptLinger = function(l)
		var err, fd, l, level, name, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; l = __f.l; level = __f.level; name = __f.name; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.SetsockoptLinger(fd.Sysfd, level, name, l);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.SetsockoptLinger end; end __f.err = err; __f.fd = fd; __f.l = l; __f.level = level; __f.name = name; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.SetsockoptLinger = function(l) return this.__val.SetsockoptLinger(level, name, l); end;
	FD.ptr.prototype.SetsockoptByte = function(g)
		var arg, err, fd, level, name, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; arg = __f.arg; err = __f.err; fd = __f.fd; level = __f.level; name = __f.name; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.SetsockoptByte(fd.Sysfd, level, name, arg);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.SetsockoptByte end; end __f.arg = arg; __f.err = err; __f.fd = fd; __f.level = level; __f.name = name; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.SetsockoptByte = function(g) return this.__val.SetsockoptByte(level, name, arg); end;
	FD.ptr.prototype.SetsockoptIPMreq = function(q)
		var err, fd, level, mreq, name, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; level = __f.level; mreq = __f.mreq; name = __f.name; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.SetsockoptIPMreq(fd.Sysfd, level, name, mreq);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.SetsockoptIPMreq end; end __f.err = err; __f.fd = fd; __f.level = level; __f.mreq = mreq; __f.name = name; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.SetsockoptIPMreq = function(q) return this.__val.SetsockoptIPMreq(level, name, mreq); end;
	FD.ptr.prototype.SetsockoptIPv6Mreq = function(q)
		var err, fd, level, mreq, name, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; err = __f.err; fd = __f.fd; level = __f.level; mreq = __f.mreq; name = __f.name; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		fd = this;
		err = fd.incref();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		__deferred.push([__methodVal(fd, "decref"), []]);
		__s = -1; return syscall.SetsockoptIPv6Mreq(fd.Sysfd, level, name, mreq);
		/* */ end return; end end catch(err) { __err = err; __s = -1; return __ifaceNil; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.SetsockoptIPv6Mreq end; end __f.err = err; __f.fd = fd; __f.level = level; __f.mreq = mreq; __f.name = name; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.SetsockoptIPv6Mreq = function(q) return this.__val.SetsockoptIPv6Mreq(level, name, mreq); end;
	accept = function(s)
		var _r, _r__1, _tuple, err, ns, s, sa, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; err = __f.err; ns = __f.ns; s = __f.s; sa = __f.sa; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = __pkg.AcceptFunc(s); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		ns = _tuple[0];
		sa = _tuple[1];
		err = _tuple[2];
		if (__interfaceIsEqual(err, __ifaceNil)) {
			syscall.CloseOnExec(ns);
		end
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [-1, __ifaceNil, "accept", err];
		end
		err = syscall.SetNonblock(ns, true);
		/* */ if ( not (__interfaceIsEqual(err, __ifaceNil))) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if ( not (__interfaceIsEqual(err, __ifaceNil))) { */ case 2:
			_r__1 = __pkg.CloseFunc(ns); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			_r__1;
			__s = -1; return [-1, __ifaceNil, "setnonblock", err];
		/* end */ case 3:
		__s = -1; return [ns, sa, "", __ifaceNil];
		/* */ end return; end if __f == nil then  __f = { __blk: accept end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.err = err; __f.ns = ns; __f.s = s; __f.sa = sa; __f.__s = __s; __f.__r = __r; return __f;
	end;
	FD.ptr.prototype.Writev = function(v)
		var _i, _ref, _tuple, chunk, e0, err, err__1, err__2, fd, iovecs, maxVec, n, v, wrote, x, x__1, x__2, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _ref = __f._ref; _tuple = __f._tuple; chunk = __f.chunk; e0 = __f.e0; err = __f.err; err__1 = __f.err__1; err__2 = __f.err__2; fd = __f.fd; iovecs = __f.iovecs; maxVec = __f.maxVec; n = __f.n; v = __f.v; wrote = __f.wrote; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		iovecs = [iovecs];
		fd = this;
		err = fd.writeLock();
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [new __Int64(0, 0), err];
		end
		__deferred.push([__methodVal(fd, "writeUnlock"), []]);
		err__1 = fd.pd.prepareWrite(fd.isFile);
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			__s = -1; return [new __Int64(0, 0), err__1];
		end
		iovecs[0] = sliceType.nil;
		if ( not (fd.iovecs == ptrType__2.nil)) {
			iovecs[0] = fd.iovecs.__get();
		end
		maxVec = 1024;
		n = new __Int64(0, 0);
		err__2 = __ifaceNil;
		/* while (true) { */ case 1:
			/* if ( not (v.__get().__length > 0)) { break; end */ if( not (v.__get().__length > 0)) { __s = 2; continue; end
			iovecs[0] = __subslice(iovecs[0], 0, 0);
			_ref = v.__get();
			_i = 0;
			/* while (true) { */ case 3:
				/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 4; continue; end
				chunk = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
				if (chunk.__length == 0) {
					_i++;
					/* continue; */ __s = 3; continue;
				end
				iovecs[0] = __append(iovecs[0], new syscall.Iovec.ptr(__indexPtr(chunk.__array, chunk.__offset + 0, ptrType__3), new __Uint64(0, 0)));
				if (fd.IsStream  and  chunk.__length > 1073741824) {
					(x = iovecs[0].__length - 1 >> 0, ((x < 0  or  x >= iovecs[0].__length) ? (__throwRuntimeError("index out of range"), nil) : iovecs[0].__array[iovecs[0].__offset + x])).SetLen(1073741824);
					/* break; */ __s = 4; continue;
				end
				(x__1 = iovecs[0].__length - 1 >> 0, ((x__1 < 0  or  x__1 >= iovecs[0].__length) ? (__throwRuntimeError("index out of range"), nil) : iovecs[0].__array[iovecs[0].__offset + x__1])).SetLen(chunk.__length);
				if (iovecs[0].__length == maxVec) {
					/* break; */ __s = 4; continue;
				end
				_i++;
			/* end */ __s = 3; continue; case 4:
			if (iovecs[0].__length == 0) {
				/* break; */ __s = 2; continue;
			end
			fd.iovecs = (iovecs.__ptr  or  (iovecs.__ptr = new ptrType__2(function() return this.__target[0]; end, function(v) this.__target[0] = __v; end, iovecs)));
			_tuple = syscall.Syscall(121, ((fd.Sysfd >>> 0)), ((__sliceToArray(iovecs[0]))), ((iovecs[0].__length >>> 0)));
			wrote = _tuple[0];
			e0 = _tuple[2];
			if (wrote == 4294967295) {
				wrote = 0;
			end
			__r = __pkg.TestHookDidWritev(((wrote >> 0))); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			n = (x__2 = (new __Int64(0, wrote.constructor == Number ? wrote : 1)), new __Int64(n.__high + x__2.__high, n.__low + x__2.__low));
			consume(v, (new __Int64(0, wrote.constructor == Number ? wrote : 1)));
			if (e0 == 35) {
				err__2 = fd.pd.waitWrite(fd.isFile);
				if (__interfaceIsEqual(err__2, __ifaceNil)) {
					/* continue; */ __s = 1; continue;
				end
			end else if ( not ((e0 == 0))) {
				err__2 = new syscall.Errno((e0));
			end
			if ( not (__interfaceIsEqual(err__2, __ifaceNil))) {
				/* break; */ __s = 2; continue;
			end
			if ((n.__high == 0  and  n.__low == 0)) {
				err__2 = io.ErrUnexpectedEOF;
				/* break; */ __s = 2; continue;
			end
		/* end */ __s = 1; continue; case 2:
		__s = -1; return [n, err__2];
		/* */ end return; end end catch(err) { __err = err; __s = -1; return [new __Int64(0, 0), __ifaceNil]; end finally { __callDeferred(__deferred, __err); if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: FD.ptr.prototype.Writev end; end __f._i = _i; __f._ref = _ref; __f._tuple = _tuple; __f.chunk = chunk; __f.e0 = e0; __f.err = err; __f.err__1 = err__1; __f.err__2 = err__2; __f.fd = fd; __f.iovecs = iovecs; __f.maxVec = maxVec; __f.n = n; __f.v = v; __f.wrote = wrote; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	FD.prototype.Writev = function(v) return this.__val.Writev(v); end;
	ptrType__5.methods = [{prop: "init", name: "init", pkg: "internal/poll", typ: __funcType([ptrType__4], [__error], false)end, {prop: "close", name: "close", pkg: "internal/poll", typ: __funcType([], [], false)end, {prop: "evict", name: "evict", pkg: "internal/poll", typ: __funcType([], [], false)end, {prop: "prepare", name: "prepare", pkg: "internal/poll", typ: __funcType([__Int, __Bool], [__error], false)end, {prop: "prepareRead", name: "prepareRead", pkg: "internal/poll", typ: __funcType([__Bool], [__error], false)end, {prop: "prepareWrite", name: "prepareWrite", pkg: "internal/poll", typ: __funcType([__Bool], [__error], false)end, {prop: "wait", name: "wait", pkg: "internal/poll", typ: __funcType([__Int, __Bool], [__error], false)end, {prop: "waitRead", name: "waitRead", pkg: "internal/poll", typ: __funcType([__Bool], [__error], false)end, {prop: "waitWrite", name: "waitWrite", pkg: "internal/poll", typ: __funcType([__Bool], [__error], false)end, {prop: "waitCanceled", name: "waitCanceled", pkg: "internal/poll", typ: __funcType([__Int], [], false)end, {prop: "pollable", name: "pollable", pkg: "internal/poll", typ: __funcType([], [__Bool], false)end];
	ptrType__6.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Timeout", name: "Timeout", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Temporary", name: "Temporary", pkg: "", typ: __funcType([], [__Bool], false)end];
	ptrType__7.methods = [{prop: "incref", name: "incref", pkg: "internal/poll", typ: __funcType([], [__Bool], false)end, {prop: "increfAndClose", name: "increfAndClose", pkg: "internal/poll", typ: __funcType([], [__Bool], false)end, {prop: "decref", name: "decref", pkg: "internal/poll", typ: __funcType([], [__Bool], false)end, {prop: "rwlock", name: "rwlock", pkg: "internal/poll", typ: __funcType([__Bool], [__Bool], false)end, {prop: "rwunlock", name: "rwunlock", pkg: "internal/poll", typ: __funcType([__Bool], [__Bool], false)end];
	ptrType__4.methods = [{prop: "SetDeadline", name: "SetDeadline", pkg: "", typ: __funcType([time.Time], [__error], false)end, {prop: "SetReadDeadline", name: "SetReadDeadline", pkg: "", typ: __funcType([time.Time], [__error], false)end, {prop: "SetWriteDeadline", name: "SetWriteDeadline", pkg: "", typ: __funcType([time.Time], [__error], false)end, {prop: "incref", name: "incref", pkg: "internal/poll", typ: __funcType([], [__error], false)end, {prop: "decref", name: "decref", pkg: "internal/poll", typ: __funcType([], [__error], false)end, {prop: "readLock", name: "readLock", pkg: "internal/poll", typ: __funcType([], [__error], false)end, {prop: "readUnlock", name: "readUnlock", pkg: "internal/poll", typ: __funcType([], [], false)end, {prop: "writeLock", name: "writeLock", pkg: "internal/poll", typ: __funcType([], [__error], false)end, {prop: "writeUnlock", name: "writeUnlock", pkg: "internal/poll", typ: __funcType([], [], false)end, {prop: "eofError", name: "eofError", pkg: "internal/poll", typ: __funcType([__Int, __error], [__error], false)end, {prop: "Fchmod", name: "Fchmod", pkg: "", typ: __funcType([__Uint32], [__error], false)end, {prop: "Fchown", name: "Fchown", pkg: "", typ: __funcType([__Int, __Int], [__error], false)end, {prop: "Ftruncate", name: "Ftruncate", pkg: "", typ: __funcType([__Int64], [__error], false)end, {prop: "Fsync", name: "Fsync", pkg: "", typ: __funcType([], [__error], false)end, {prop: "Init", name: "Init", pkg: "", typ: __funcType([__String, __Bool], [__error], false)end, {prop: "destroy", name: "destroy", pkg: "internal/poll", typ: __funcType([], [__error], false)end, {prop: "Close", name: "Close", pkg: "", typ: __funcType([], [__error], false)end, {prop: "Shutdown", name: "Shutdown", pkg: "", typ: __funcType([__Int], [__error], false)end, {prop: "Read", name: "Read", pkg: "", typ: __funcType([sliceType__1], [__Int, __error], false)end, {prop: "Pread", name: "Pread", pkg: "", typ: __funcType([sliceType__1, __Int64], [__Int, __error], false)end, {prop: "ReadFrom", name: "ReadFrom", pkg: "", typ: __funcType([sliceType__1], [__Int, syscall.Sockaddr, __error], false)end, {prop: "ReadMsg", name: "ReadMsg", pkg: "", typ: __funcType([sliceType__1, sliceType__1], [__Int, __Int, __Int, syscall.Sockaddr, __error], false)end, {prop: "Write", name: "Write", pkg: "", typ: __funcType([sliceType__1], [__Int, __error], false)end, {prop: "Pwrite", name: "Pwrite", pkg: "", typ: __funcType([sliceType__1, __Int64], [__Int, __error], false)end, {prop: "WriteTo", name: "WriteTo", pkg: "", typ: __funcType([sliceType__1, syscall.Sockaddr], [__Int, __error], false)end, {prop: "WriteMsg", name: "WriteMsg", pkg: "", typ: __funcType([sliceType__1, sliceType__1, syscall.Sockaddr], [__Int, __Int, __error], false)end, {prop: "Accept", name: "Accept", pkg: "", typ: __funcType([], [__Int, syscall.Sockaddr, __String, __error], false)end, {prop: "Seek", name: "Seek", pkg: "", typ: __funcType([__Int64, __Int], [__Int64, __error], false)end, {prop: "ReadDirent", name: "ReadDirent", pkg: "", typ: __funcType([sliceType__1], [__Int, __error], false)end, {prop: "Fchdir", name: "Fchdir", pkg: "", typ: __funcType([], [__error], false)end, {prop: "Fstat", name: "Fstat", pkg: "", typ: __funcType([ptrType__8], [__error], false)end, {prop: "WaitWrite", name: "WaitWrite", pkg: "", typ: __funcType([], [__error], false)end, {prop: "RawControl", name: "RawControl", pkg: "", typ: __funcType([funcType], [__error], false)end, {prop: "RawRead", name: "RawRead", pkg: "", typ: __funcType([funcType__1], [__error], false)end, {prop: "RawWrite", name: "RawWrite", pkg: "", typ: __funcType([funcType__1], [__error], false)end, {prop: "SetsockoptInt", name: "SetsockoptInt", pkg: "", typ: __funcType([__Int, __Int, __Int], [__error], false)end, {prop: "SetsockoptInet4Addr", name: "SetsockoptInet4Addr", pkg: "", typ: __funcType([__Int, __Int, arrayType], [__error], false)end, {prop: "SetsockoptLinger", name: "SetsockoptLinger", pkg: "", typ: __funcType([__Int, __Int, ptrType__9], [__error], false)end, {prop: "SetsockoptByte", name: "SetsockoptByte", pkg: "", typ: __funcType([__Int, __Int, __Uint8], [__error], false)end, {prop: "SetsockoptIPMreq", name: "SetsockoptIPMreq", pkg: "", typ: __funcType([__Int, __Int, ptrType__10], [__error], false)end, {prop: "SetsockoptIPv6Mreq", name: "SetsockoptIPv6Mreq", pkg: "", typ: __funcType([__Int, __Int, ptrType__11], [__error], false)end, {prop: "Writev", name: "Writev", pkg: "", typ: __funcType([ptrType__12], [__Int64, __error], false)end];
	pollDesc.init("internal/poll", [{prop: "closing", name: "closing", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	TimeoutError.init("", []);
	fdMutex.init("internal/poll", [{prop: "state", name: "state", anonymous: false, exported: false, typ: __Uint64, tag: ""end, {prop: "rsema", name: "rsema", anonymous: false, exported: false, typ: __Uint32, tag: ""end, {prop: "wsema", name: "wsema", anonymous: false, exported: false, typ: __Uint32, tag: ""end]);
	FD.init("internal/poll", [{prop: "fdmu", name: "fdmu", anonymous: false, exported: false, typ: fdMutex, tag: ""end, {prop: "Sysfd", name: "Sysfd", anonymous: false, exported: true, typ: __Int, tag: ""end, {prop: "pd", name: "pd", anonymous: false, exported: false, typ: pollDesc, tag: ""end, {prop: "iovecs", name: "iovecs", anonymous: false, exported: false, typ: ptrType__2, tag: ""end, {prop: "IsStream", name: "IsStream", anonymous: false, exported: true, typ: __Bool, tag: ""end, {prop: "ZeroReadIsEOF", name: "ZeroReadIsEOF", anonymous: false, exported: true, typ: __Bool, tag: ""end, {prop: "isFile", name: "isFile", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = io.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = atomic.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = syscall.__init(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = time.__init(); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__pkg.ErrNetClosing = errors.New("use of closed network connection");
		__pkg.ErrFileClosing = errors.New("use of closed file");
		__pkg.ErrTimeout = new TimeoutError.ptr();
		__pkg.TestHookDidWritev = (function(e)
			var wrote;
		end);
		__pkg.CloseFunc = syscall.Close;
		__pkg.AcceptFunc = syscall.Accept;
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["os"] = (function()
	var __pkg = {}, __init, errors, js, poll, io, runtime, sync, atomic, syscall, time, PathError, SyscallError, LinkError, file, dirInfo, File, FileInfo, FileMode, fileStat, sliceType, ptrType, sliceType__1, ptrType__1, sliceType__2, ptrType__2, ptrType__3, ptrType__4, arrayType, sliceType__5, ptrType__12, ptrType__13, funcType__1, ptrType__15, arrayType__3, arrayType__5, ptrType__16, errFinished, lstat, useSyscallwd, runtime_args, init, NewSyscallError, IsNotExist, underlyingError, wrapSyscallError, isNotExist, sigpipe, syscallMode, NewFile, newFile, epipecheck, init__1, useSyscallwdDarwin, basename, init__2, fillFileStatFromSys, timespecToTime, Lstat;
	errors = __packages["errors"];
	js = __packages["github.com/gopherjs/gopherjs/js"];
	poll = __packages["internal/poll"];
	io = __packages["io"];
	runtime = __packages["runtime"];
	sync = __packages["sync"];
	atomic = __packages["sync/atomic"];
	syscall = __packages["syscall"];
	time = __packages["time"];
	PathError = __pkg.PathError = __newType(0, __kindStruct, "os.PathError", true, "os", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Op = "";
			this.Path = "";
			this.Err = __ifaceNil;
			return;
		end
		this.Op = Op_;
		this.Path = Path_;
		this.Err = Err_;
	end);
	SyscallError = __pkg.SyscallError = __newType(0, __kindStruct, "os.SyscallError", true, "os", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Syscall = "";
			this.Err = __ifaceNil;
			return;
		end
		this.Syscall = Syscall_;
		this.Err = Err_;
	end);
	LinkError = __pkg.LinkError = __newType(0, __kindStruct, "os.LinkError", true, "os", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Op = "";
			this.Old = "";
			this.New = "";
			this.Err = __ifaceNil;
			return;
		end
		this.Op = Op_;
		this.Old = Old_;
		this.New = New_;
		this.Err = Err_;
	end);
	file = __pkg.file = __newType(0, __kindStruct, "os.file", true, "os", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.pfd = new poll.FD.ptr(new poll.fdMutex.ptr(new __Uint64(0, 0), 0, 0), 0, new poll.pollDesc.ptr(false), ptrType__12.nil, false, false, false);
			this.name = "";
			this.dirinfo = ptrType__1.nil;
			this.nonblock = false;
			return;
		end
		this.pfd = pfd_;
		this.name = name_;
		this.dirinfo = dirinfo_;
		this.nonblock = nonblock_;
	end);
	dirInfo = __pkg.dirInfo = __newType(0, __kindStruct, "os.dirInfo", true, "os", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.buf = sliceType__2.nil;
			this.nbuf = 0;
			this.bufp = 0;
			return;
		end
		this.buf = buf_;
		this.nbuf = nbuf_;
		this.bufp = bufp_;
	end);
	File = __pkg.File = __newType(0, __kindStruct, "os.File", true, "os", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.file = ptrType__13.nil;
			return;
		end
		this.file = file_;
	end);
	FileInfo = __pkg.FileInfo = __newType(8, __kindInterface, "os.FileInfo", true, "os", true, null);
	FileMode = __pkg.FileMode = __newType(4, __kindUint32, "os.FileMode", true, "os", true, null);
	fileStat = __pkg.fileStat = __newType(0, __kindStruct, "os.fileStat", true, "os", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.name = "";
			this.size = new __Int64(0, 0);
			this.mode = 0;
			this.modTime = new time.Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__15.nil);
			this.sys = new syscall.Stat_t.ptr(0, 0, 0, new __Uint64(0, 0), 0, 0, 0, arrayType.zero(), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new __Int64(0, 0), new __Int64(0, 0), 0, 0, 0, 0, arrayType__3.zero());
			return;
		end
		this.name = name_;
		this.size = size_;
		this.mode = mode_;
		this.modTime = modTime_;
		this.sys = sys_;
	end);
	sliceType = __sliceType(__String);
	ptrType = __ptrType(File);
	sliceType__1 = __sliceType(FileInfo);
	ptrType__1 = __ptrType(dirInfo);
	sliceType__2 = __sliceType(__Uint8);
	ptrType__2 = __ptrType(PathError);
	ptrType__3 = __ptrType(LinkError);
	ptrType__4 = __ptrType(SyscallError);
	arrayType = __arrayType(__Uint8, 4);
	sliceType__5 = __sliceType(syscall.Iovec);
	ptrType__12 = __ptrType(sliceType__5);
	ptrType__13 = __ptrType(file);
	funcType__1 = __funcType([ptrType__13], [__error], false);
	ptrType__15 = __ptrType(time.Location);
	arrayType__3 = __arrayType(__Int64, 2);
	arrayType__5 = __arrayType(__Uint8, 32);
	ptrType__16 = __ptrType(fileStat);
	runtime_args = function()
		return __pkg.Args;
	end;
	init = function()
		var argv, i, process;
		process = __global.process;
		if ( not (process == nil)) {
			argv = process.argv;
			__pkg.Args = __makeSlice(sliceType, (__parseInt(argv.length) - 1 >> 0));
			i = 0;
			while (true) {
				if ( not (i < (__parseInt(argv.length) - 1 >> 0))) { break; end
				((i < 0  or  i >= __pkg.Args.__length) ? (__throwRuntimeError("index out of range"), nil) : __pkg.Args.__array[__pkg.Args.__offset + i] = __internalize(argv[(i + 1 >> 0)], __String));
				i = i + (1) >> 0;
			end
		end
		if (__pkg.Args.__length == 0) {
			__pkg.Args = new sliceType(["?"]);
		end
	end;
	File.ptr.prototype.Readdir = function(n)
		var _r, f, n, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; f = __f.f; n = __f.n; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		if (f == ptrType.nil) {
			__s = -1; return [sliceType__1.nil, __pkg.ErrInvalid];
		end
		_r = f.readdir(n); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Readdir end; end __f._r = _r; __f.f = f; __f.n = n; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Readdir = function(n) return this.__val.Readdir(n); end;
	File.ptr.prototype.Readdirnames = function(n)
		var _r, _tmp, _tmp__1, _tuple, err, f, n, names, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; err = __f.err; f = __f.f; n = __f.n; names = __f.names; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		names = sliceType.nil;
		err = __ifaceNil;
		f = this;
		if (f == ptrType.nil) {
			_tmp = sliceType.nil;
			_tmp__1 = __pkg.ErrInvalid;
			names = _tmp;
			err = _tmp__1;
			__s = -1; return [names, err];
		end
		_r = f.readdirnames(n); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		names = _tuple[0];
		err = _tuple[1];
		__s = -1; return [names, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Readdirnames end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.err = err; __f.f = f; __f.n = n; __f.names = names; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Readdirnames = function(n) return this.__val.Readdirnames(n); end;
	File.ptr.prototype.readdir = function(n)
		var _i, _r, _r__1, _ref, _tmp, _tmp__1, _tmp__2, _tmp__3, _tuple, _tuple__1, dirname, err, f, fi, filename, fip, lerr, n, names, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _r = __f._r; _r__1 = __f._r__1; _ref = __f._ref; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; dirname = __f.dirname; err = __f.err; f = __f.f; fi = __f.fi; filename = __f.filename; fip = __f.fip; lerr = __f.lerr; n = __f.n; names = __f.names; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fi = sliceType__1.nil;
		err = __ifaceNil;
		f = this;
		dirname = f.file.name;
		if (dirname == "") {
			dirname = ".";
		end
		_r = f.Readdirnames(n); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		names = _tuple[0];
		err = _tuple[1];
		fi = __makeSlice(sliceType__1, 0, names.__length);
		_ref = names;
		_i = 0;
		/* while (true) { */ case 2:
			/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 3; continue; end
			filename = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			_r__1 = lstat(dirname + "/" + filename); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			_tuple__1 = _r__1;
			fip = _tuple__1[0];
			lerr = _tuple__1[1];
			if (IsNotExist(lerr)) {
				_i++;
				/* continue; */ __s = 2; continue;
			end
			if ( not (__interfaceIsEqual(lerr, __ifaceNil))) {
				_tmp = fi;
				_tmp__1 = lerr;
				fi = _tmp;
				err = _tmp__1;
				__s = -1; return [fi, err];
			end
			fi = __append(fi, fip);
			_i++;
		/* end */ __s = 2; continue; case 3:
		if ((fi.__length == 0)  and  __interfaceIsEqual(err, __ifaceNil)  and  n > 0) {
			err = io.EOF;
		end
		_tmp__2 = fi;
		_tmp__3 = err;
		fi = _tmp__2;
		err = _tmp__3;
		__s = -1; return [fi, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.readdir end; end __f._i = _i; __f._r = _r; __f._r__1 = _r__1; __f._ref = _ref; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f.dirname = dirname; __f.err = err; __f.f = f; __f.fi = fi; __f.filename = filename; __f.fip = fip; __f.lerr = lerr; __f.n = n; __f.names = names; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.readdir = function(n) return this.__val.readdir(n); end;
	File.ptr.prototype.readdirnames = function(n)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tuple, _tuple__1, d, err, errno, f, n, names, nb, nc, size, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tmp__4 = __f._tmp__4; _tmp__5 = __f._tmp__5; _tmp__6 = __f._tmp__6; _tmp__7 = __f._tmp__7; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; d = __f.d; err = __f.err; errno = __f.errno; f = __f.f; n = __f.n; names = __f.names; nb = __f.nb; nc = __f.nc; size = __f.size; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		names = sliceType.nil;
		err = __ifaceNil;
		f = this;
		if (f.file.dirinfo == ptrType__1.nil) {
			f.file.dirinfo = new dirInfo.ptr(sliceType__2.nil, 0, 0);
			f.file.dirinfo.buf = __makeSlice(sliceType__2, 4096);
		end
		d = f.file.dirinfo;
		size = n;
		if (size <= 0) {
			size = 100;
			n = -1;
		end
		names = __makeSlice(sliceType, 0, size);
		/* while (true) { */ case 1:
			/* if ( not ( not ((n == 0)))) { break; end */ if( not ( not ((n == 0)))) { __s = 2; continue; end
			/* */ if (d.bufp >= d.nbuf) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if (d.bufp >= d.nbuf) { */ case 3:
				d.bufp = 0;
				errno = __ifaceNil;
				_r = f.file.pfd.ReadDirent(d.buf); /* */ __s = 5; case 5: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				_tuple = _r;
				d.nbuf = _tuple[0];
				errno = _tuple[1];
				runtime.KeepAlive(f);
				if ( not (__interfaceIsEqual(errno, __ifaceNil))) {
					_tmp = names;
					_tmp__1 = wrapSyscallError("readdirent", errno);
					names = _tmp;
					err = _tmp__1;
					__s = -1; return [names, err];
				end
				if (d.nbuf <= 0) {
					/* break; */ __s = 2; continue;
				end
			/* end */ case 4:
			_tmp__2 = 0;
			_tmp__3 = 0;
			nb = _tmp__2;
			nc = _tmp__3;
			_tuple__1 = syscall.ParseDirent(__subslice(d.buf, d.bufp, d.nbuf), n, names);
			nb = _tuple__1[0];
			nc = _tuple__1[1];
			names = _tuple__1[2];
			d.bufp = d.bufp + (nb) >> 0;
			n = n - (nc) >> 0;
		/* end */ __s = 1; continue; case 2:
		if (n >= 0  and  (names.__length == 0)) {
			_tmp__4 = names;
			_tmp__5 = io.EOF;
			names = _tmp__4;
			err = _tmp__5;
			__s = -1; return [names, err];
		end
		_tmp__6 = names;
		_tmp__7 = __ifaceNil;
		names = _tmp__6;
		err = _tmp__7;
		__s = -1; return [names, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.readdirnames end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tmp__4 = _tmp__4; __f._tmp__5 = _tmp__5; __f._tmp__6 = _tmp__6; __f._tmp__7 = _tmp__7; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f.d = d; __f.err = err; __f.errno = errno; __f.f = f; __f.n = n; __f.names = names; __f.nb = nb; __f.nc = nc; __f.size = size; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.readdirnames = function(n) return this.__val.readdirnames(n); end;
	PathError.ptr.prototype.Error = function()
		var _r, e, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		e = this;
		_r = e.Err.Error(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return e.Op + " " + e.Path + ": " + _r;
		/* */ end return; end if __f == nil then  __f = { __blk: PathError.ptr.prototype.Error end; end __f._r = _r; __f.e = e; __f.__s = __s; __f.__r = __r; return __f;
	end;
	PathError.prototype.Error = function() return this.__val.Error(); end;
	SyscallError.ptr.prototype.Error = function()
		var _r, e, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		e = this;
		_r = e.Err.Error(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return e.Syscall + ": " + _r;
		/* */ end return; end if __f == nil then  __f = { __blk: SyscallError.ptr.prototype.Error end; end __f._r = _r; __f.e = e; __f.__s = __s; __f.__r = __r; return __f;
	end;
	SyscallError.prototype.Error = function() return this.__val.Error(); end;
	NewSyscallError = function(r)
		var err, syscall__1;
		if (__interfaceIsEqual(err, __ifaceNil)) {
			return __ifaceNil;
		end
		return new SyscallError.ptr(syscall__1, err);
	end;
	__pkg.NewSyscallError = NewSyscallError;
	IsNotExist = function(r)
		var err;
		return isNotExist(err);
	end;
	__pkg.IsNotExist = IsNotExist;
	underlyingError = function(r)
		var _ref, err, err__1, err__2, err__3;
		_ref = err;
		if (__assertType(_ref, ptrType__2, true)[1]) {
			err__1 = _ref.__val;
			return err__1.Err;
		end else if (__assertType(_ref, ptrType__3, true)[1]) {
			err__2 = _ref.__val;
			return err__2.Err;
		end else if (__assertType(_ref, ptrType__4, true)[1]) {
			err__3 = _ref.__val;
			return err__3.Err;
		end
		return err;
	end;
	wrapSyscallError = function(r)
		var _tuple, err, name, ok;
		_tuple = __assertType(err, syscall.Errno, true);
		ok = _tuple[1];
		if (ok) {
			err = NewSyscallError(name, err);
		end
		return err;
	end;
	isNotExist = function(r)
		var err;
		err = underlyingError(err);
		return __interfaceIsEqual(err, new syscall.Errno(2))  or  __interfaceIsEqual(err, __pkg.ErrNotExist);
	end;
	File.ptr.prototype.Name = function()
		var f;
		f = this;
		return f.file.name;
	end;
	File.prototype.Name = function() return this.__val.Name(); end;
	LinkError.ptr.prototype.Error = function()
		var _r, e, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		e = this;
		_r = e.Err.Error(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return e.Op + " " + e.Old + " " + e.New + ": " + _r;
		/* */ end return; end if __f == nil then  __f = { __blk: LinkError.ptr.prototype.Error end; end __f._r = _r; __f.e = e; __f.__s = __s; __f.__r = __r; return __f;
	end;
	LinkError.prototype.Error = function() return this.__val.Error(); end;
	File.ptr.prototype.Read = function(b)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tuple, b, e, err, err__1, f, n, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tuple = __f._tuple; b = __f.b; e = __f.e; err = __f.err; err__1 = __f.err__1; f = __f.f; n = __f.n; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		err__1 = f.checkValid("read");
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			_tmp = 0;
			_tmp__1 = err__1;
			n = _tmp;
			err = _tmp__1;
			__s = -1; return [n, err];
		end
		_r = f.read(b); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		e = _tuple[1];
		_tmp__2 = n;
		_tmp__3 = f.wrapErr("read", e);
		n = _tmp__2;
		err = _tmp__3;
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Read end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tuple = _tuple; __f.b = b; __f.e = e; __f.err = err; __f.err__1 = err__1; __f.f = f; __f.n = n; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Read = function(b) return this.__val.Read(b); end;
	File.ptr.prototype.ReadAt = function(f)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tuple, b, e, err, err__1, f, m, n, off, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tuple = __f._tuple; b = __f.b; e = __f.e; err = __f.err; err__1 = __f.err__1; f = __f.f; m = __f.m; n = __f.n; off = __f.off; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		err__1 = f.checkValid("read");
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			_tmp = 0;
			_tmp__1 = err__1;
			n = _tmp;
			err = _tmp__1;
			__s = -1; return [n, err];
		end
		if ((off.__high < 0  or  (off.__high == 0  and  off.__low < 0))) {
			_tmp__2 = 0;
			_tmp__3 = new PathError.ptr("readat", f.file.name, errors.New("negative offset"));
			n = _tmp__2;
			err = _tmp__3;
			__s = -1; return [n, err];
		end
		/* while (true) { */ case 1:
			/* if ( not (b.__length > 0)) { break; end */ if( not (b.__length > 0)) { __s = 2; continue; end
			_r = f.pread(b, off); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_tuple = _r;
			m = _tuple[0];
			e = _tuple[1];
			if ( not (__interfaceIsEqual(e, __ifaceNil))) {
				err = f.wrapErr("read", e);
				/* break; */ __s = 2; continue;
			end
			n = n + (m) >> 0;
			b = __subslice(b, m);
			off = (x = (new __Int64(0, m)), new __Int64(off.__high + x.__high, off.__low + x.__low));
		/* end */ __s = 1; continue; case 2:
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.ReadAt end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tuple = _tuple; __f.b = b; __f.e = e; __f.err = err; __f.err__1 = err__1; __f.f = f; __f.m = m; __f.n = n; __f.off = off; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.ReadAt = function(f) return this.__val.ReadAt(b, off); end;
	File.ptr.prototype.Write = function(b)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tuple, b, e, err, err__1, f, n, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tuple = __f._tuple; b = __f.b; e = __f.e; err = __f.err; err__1 = __f.err__1; f = __f.f; n = __f.n; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		err__1 = f.checkValid("write");
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			_tmp = 0;
			_tmp__1 = err__1;
			n = _tmp;
			err = _tmp__1;
			__s = -1; return [n, err];
		end
		_r = f.write(b); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		e = _tuple[1];
		if (n < 0) {
			n = 0;
		end
		if ( not ((n == b.__length))) {
			err = io.ErrShortWrite;
		end
		epipecheck(f, e);
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			err = f.wrapErr("write", e);
		end
		_tmp__2 = n;
		_tmp__3 = err;
		n = _tmp__2;
		err = _tmp__3;
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Write end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tuple = _tuple; __f.b = b; __f.e = e; __f.err = err; __f.err__1 = err__1; __f.f = f; __f.n = n; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Write = function(b) return this.__val.Write(b); end;
	File.ptr.prototype.WriteAt = function(f)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tuple, b, e, err, err__1, f, m, n, off, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tuple = __f._tuple; b = __f.b; e = __f.e; err = __f.err; err__1 = __f.err__1; f = __f.f; m = __f.m; n = __f.n; off = __f.off; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		err__1 = f.checkValid("write");
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			_tmp = 0;
			_tmp__1 = err__1;
			n = _tmp;
			err = _tmp__1;
			__s = -1; return [n, err];
		end
		if ((off.__high < 0  or  (off.__high == 0  and  off.__low < 0))) {
			_tmp__2 = 0;
			_tmp__3 = new PathError.ptr("writeat", f.file.name, errors.New("negative offset"));
			n = _tmp__2;
			err = _tmp__3;
			__s = -1; return [n, err];
		end
		/* while (true) { */ case 1:
			/* if ( not (b.__length > 0)) { break; end */ if( not (b.__length > 0)) { __s = 2; continue; end
			_r = f.pwrite(b, off); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			_tuple = _r;
			m = _tuple[0];
			e = _tuple[1];
			if ( not (__interfaceIsEqual(e, __ifaceNil))) {
				err = f.wrapErr("write", e);
				/* break; */ __s = 2; continue;
			end
			n = n + (m) >> 0;
			b = __subslice(b, m);
			off = (x = (new __Int64(0, m)), new __Int64(off.__high + x.__high, off.__low + x.__low));
		/* end */ __s = 1; continue; case 2:
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.WriteAt end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tuple = _tuple; __f.b = b; __f.e = e; __f.err = err; __f.err__1 = err__1; __f.f = f; __f.m = m; __f.n = n; __f.off = off; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.WriteAt = function(f) return this.__val.WriteAt(b, off); end;
	File.ptr.prototype.Seek = function(e)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tuple, e, err, err__1, f, offset, r, ret, whence, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tmp__4 = __f._tmp__4; _tmp__5 = __f._tmp__5; _tuple = __f._tuple; e = __f.e; err = __f.err; err__1 = __f.err__1; f = __f.f; offset = __f.offset; r = __f.r; ret = __f.ret; whence = __f.whence; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		ret = new __Int64(0, 0);
		err = __ifaceNil;
		f = this;
		err__1 = f.checkValid("seek");
		if ( not (__interfaceIsEqual(err__1, __ifaceNil))) {
			_tmp = new __Int64(0, 0);
			_tmp__1 = err__1;
			ret = _tmp;
			err = _tmp__1;
			__s = -1; return [ret, err];
		end
		_r = f.seek(offset, whence); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		r = _tuple[0];
		e = _tuple[1];
		if (__interfaceIsEqual(e, __ifaceNil)  and   not (f.file.dirinfo == ptrType__1.nil)  and   not ((r.__high == 0  and  r.__low == 0))) {
			e = new syscall.Errno(21);
		end
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			_tmp__2 = new __Int64(0, 0);
			_tmp__3 = f.wrapErr("seek", e);
			ret = _tmp__2;
			err = _tmp__3;
			__s = -1; return [ret, err];
		end
		_tmp__4 = r;
		_tmp__5 = __ifaceNil;
		ret = _tmp__4;
		err = _tmp__5;
		__s = -1; return [ret, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Seek end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tmp__4 = _tmp__4; __f._tmp__5 = _tmp__5; __f._tuple = _tuple; __f.e = e; __f.err = err; __f.err__1 = err__1; __f.f = f; __f.offset = offset; __f.r = r; __f.ret = ret; __f.whence = whence; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Seek = function(e) return this.__val.Seek(offset, whence); end;
	File.ptr.prototype.WriteString = function(s)
		var _r, _tuple, err, f, n, s, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; err = __f.err; f = __f.f; n = __f.n; s = __f.s; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		_r = f.Write((new sliceType__2(__stringToBytes(s)))); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		err = _tuple[1];
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.WriteString end; end __f._r = _r; __f._tuple = _tuple; __f.err = err; __f.f = f; __f.n = n; __f.s = s; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.WriteString = function(s) return this.__val.WriteString(s); end;
	File.ptr.prototype.wrapErr = function(r)
		var err, f, op;
		f = this;
		if (__interfaceIsEqual(err, __ifaceNil)  or  __interfaceIsEqual(err, io.EOF)) {
			return err;
		end
		if (__interfaceIsEqual(err, poll.ErrFileClosing)) {
			err = __pkg.ErrClosed;
		end
		return new PathError.ptr(op, f.file.name, err);
	end;
	File.prototype.wrapErr = function(r) return this.__val.wrapErr(op, err); end;
	File.ptr.prototype.Chmod = function(e)
		var _r, f, mode, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; f = __f.f; mode = __f.mode; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		_r = f.chmod(mode); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Chmod end; end __f._r = _r; __f.f = f; __f.mode = mode; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Chmod = function(e) return this.__val.Chmod(mode); end;
	sigpipe = function()
		__throwRuntimeError("native function not implemented: os.sigpipe");
	end;
	syscallMode = function(i)
		var i, o;
		o = 0;
		o = (o | (((new FileMode(i).Perm() >>> 0)))) >>> 0;
		if ( not ((((i & 8388608) >>> 0) == 0))) {
			o = (o | (2048)) >>> 0;
		end
		if ( not ((((i & 4194304) >>> 0) == 0))) {
			o = (o | (1024)) >>> 0;
		end
		if ( not ((((i & 1048576) >>> 0) == 0))) {
			o = (o | (512)) >>> 0;
		end
		return o;
	end;
	File.ptr.prototype.chmod = function(e)
		var _r, e, err, f, mode, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; err = __f.err; f = __f.f; mode = __f.mode; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		err = f.checkValid("chmod");
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		_r = f.file.pfd.Fchmod(syscallMode(mode)); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		e = _r;
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			__s = -1; return f.wrapErr("chmod", e);
		end
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.chmod end; end __f._r = _r; __f.e = e; __f.err = err; __f.f = f; __f.mode = mode; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.chmod = function(e) return this.__val.chmod(mode); end;
	File.ptr.prototype.Chown = function(d)
		var _r, e, err, f, gid, uid, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; err = __f.err; f = __f.f; gid = __f.gid; uid = __f.uid; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		err = f.checkValid("chown");
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		_r = f.file.pfd.Fchown(uid, gid); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		e = _r;
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			__s = -1; return f.wrapErr("chown", e);
		end
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Chown end; end __f._r = _r; __f.e = e; __f.err = err; __f.f = f; __f.gid = gid; __f.uid = uid; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Chown = function(d) return this.__val.Chown(uid, gid); end;
	File.ptr.prototype.Truncate = function(e)
		var _r, e, err, f, size, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; err = __f.err; f = __f.f; size = __f.size; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		err = f.checkValid("truncate");
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		_r = f.file.pfd.Ftruncate(size); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		e = _r;
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			__s = -1; return f.wrapErr("truncate", e);
		end
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Truncate end; end __f._r = _r; __f.e = e; __f.err = err; __f.f = f; __f.size = size; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Truncate = function(e) return this.__val.Truncate(size); end;
	File.ptr.prototype.Sync = function()
		var _r, e, err, f, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; err = __f.err; f = __f.f; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		err = f.checkValid("sync");
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		_r = f.file.pfd.Fsync(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		e = _r;
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			__s = -1; return f.wrapErr("sync", e);
		end
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Sync end; end __f._r = _r; __f.e = e; __f.err = err; __f.f = f; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Sync = function() return this.__val.Sync(); end;
	File.ptr.prototype.Chdir = function()
		var _r, e, err, f, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; err = __f.err; f = __f.f; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		err = f.checkValid("chdir");
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return err;
		end
		_r = f.file.pfd.Fchdir(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		e = _r;
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			__s = -1; return f.wrapErr("chdir", e);
		end
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Chdir end; end __f._r = _r; __f.e = e; __f.err = err; __f.f = f; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Chdir = function() return this.__val.Chdir(); end;
	File.ptr.prototype.checkValid = function(p)
		var f, op;
		f = this;
		if (f == ptrType.nil) {
			return __pkg.ErrInvalid;
		end
		return __ifaceNil;
	end;
	File.prototype.checkValid = function(p) return this.__val.checkValid(op); end;
	File.ptr.prototype.Fd = function()
		var f;
		f = this;
		if (f == ptrType.nil) {
			return 4294967295;
		end
		if (f.file.nonblock) {
			syscall.SetNonblock(f.file.pfd.Sysfd, false);
		end
		return ((f.file.pfd.Sysfd >>> 0));
	end;
	File.prototype.Fd = function() return this.__val.Fd(); end;
	NewFile = function(e)
		var fd, name;
		return newFile(fd, name, false);
	end;
	__pkg.NewFile = NewFile;
	newFile = function(e)
		var err, err__1, f, fd, fdi, name, pollable;
		fdi = ((fd >> 0));
		if (fdi < 0) {
			return ptrType.nil;
		end
		f = new File.ptr(new file.ptr(new poll.FD.ptr(new poll.fdMutex.ptr(new __Uint64(0, 0), 0, 0), fdi, new poll.pollDesc.ptr(false), ptrType__12.nil, true, true, false), name, ptrType__1.nil, false));
		if (false) {
			pollable = false;
		end
		err = f.file.pfd.Init("file", pollable);
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
		end else if (pollable) {
			err__1 = syscall.SetNonblock(fdi, true);
			if (__interfaceIsEqual(err__1, __ifaceNil)) {
				f.file.nonblock = true;
			end
		end
		runtime.SetFinalizer(f.file, new funcType__1(__methodExpr(ptrType__13, "close")));
		return f;
	end;
	epipecheck = function(e)
		var e, file__1;
		if (__interfaceIsEqual(e, new syscall.Errno(32))  and  ((file__1.file.pfd.Sysfd == 1)  or  (file__1.file.pfd.Sysfd == 2))) {
			sigpipe();
		end
	end;
	File.ptr.prototype.Close = function()
		var _r, f, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; f = __f.f; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = this;
		if (f == ptrType.nil) {
			__s = -1; return __pkg.ErrInvalid;
		end
		_r = f.file.close(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Close end; end __f._r = _r; __f.f = f; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Close = function() return this.__val.Close(); end;
	file.ptr.prototype.close = function()
		var _r, e, err, file__1, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; e = __f.e; err = __f.err; file__1 = __f.file__1; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		file__1 = this;
		if (file__1 == ptrType__13.nil) {
			__s = -1; return new syscall.Errno(22);
		end
		err = __ifaceNil;
		_r = file__1.pfd.Close(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		e = _r;
		if ( not (__interfaceIsEqual(e, __ifaceNil))) {
			if (__interfaceIsEqual(e, poll.ErrFileClosing)) {
				e = __pkg.ErrClosed;
			end
			err = new PathError.ptr("close", file__1.name, e);
		end
		runtime.SetFinalizer(file__1, __ifaceNil);
		__s = -1; return err;
		/* */ end return; end if __f == nil then  __f = { __blk: file.ptr.prototype.close end; end __f._r = _r; __f.e = e; __f.err = err; __f.file__1 = file__1; __f.__s = __s; __f.__r = __r; return __f;
	end;
	file.prototype.close = function() return this.__val.close(); end;
	File.ptr.prototype.read = function(b)
		var _r, _tmp, _tmp__1, _tuple, b, err, f, n, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; b = __f.b; err = __f.err; f = __f.f; n = __f.n; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		_r = f.file.pfd.Read(b); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		err = _tuple[1];
		runtime.KeepAlive(f);
		_tmp = n;
		_tmp__1 = err;
		n = _tmp;
		err = _tmp__1;
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.read end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.b = b; __f.err = err; __f.f = f; __f.n = n; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.read = function(b) return this.__val.read(b); end;
	File.ptr.prototype.pread = function(f)
		var _r, _tmp, _tmp__1, _tuple, b, err, f, n, off, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; b = __f.b; err = __f.err; f = __f.f; n = __f.n; off = __f.off; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		_r = f.file.pfd.Pread(b, off); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		err = _tuple[1];
		runtime.KeepAlive(f);
		_tmp = n;
		_tmp__1 = err;
		n = _tmp;
		err = _tmp__1;
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.pread end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.b = b; __f.err = err; __f.f = f; __f.n = n; __f.off = off; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.pread = function(f) return this.__val.pread(b, off); end;
	File.ptr.prototype.write = function(b)
		var _r, _tmp, _tmp__1, _tuple, b, err, f, n, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; b = __f.b; err = __f.err; f = __f.f; n = __f.n; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		_r = f.file.pfd.Write(b); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		err = _tuple[1];
		runtime.KeepAlive(f);
		_tmp = n;
		_tmp__1 = err;
		n = _tmp;
		err = _tmp__1;
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.write end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.b = b; __f.err = err; __f.f = f; __f.n = n; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.write = function(b) return this.__val.write(b); end;
	File.ptr.prototype.pwrite = function(f)
		var _r, _tmp, _tmp__1, _tuple, b, err, f, n, off, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; b = __f.b; err = __f.err; f = __f.f; n = __f.n; off = __f.off; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		f = this;
		_r = f.file.pfd.Pwrite(b, off); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		err = _tuple[1];
		runtime.KeepAlive(f);
		_tmp = n;
		_tmp__1 = err;
		n = _tmp;
		err = _tmp__1;
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.pwrite end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.b = b; __f.err = err; __f.f = f; __f.n = n; __f.off = off; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.pwrite = function(f) return this.__val.pwrite(b, off); end;
	File.ptr.prototype.seek = function(e)
		var _r, _tmp, _tmp__1, _tuple, err, f, offset, ret, whence, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; err = __f.err; f = __f.f; offset = __f.offset; ret = __f.ret; whence = __f.whence; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		ret = new __Int64(0, 0);
		err = __ifaceNil;
		f = this;
		_r = f.file.pfd.Seek(offset, whence); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		ret = _tuple[0];
		err = _tuple[1];
		runtime.KeepAlive(f);
		_tmp = ret;
		_tmp__1 = err;
		ret = _tmp;
		err = _tmp__1;
		__s = -1; return [ret, err];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.seek end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.err = err; __f.f = f; __f.offset = offset; __f.ret = ret; __f.whence = whence; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.seek = function(e) return this.__val.seek(offset, whence); end;
	init__1 = function()
		useSyscallwd = useSyscallwdDarwin;
	end;
	useSyscallwdDarwin = function(r)
		var err;
		return  not (__interfaceIsEqual(err, new syscall.Errno(45)));
	end;
	basename = function(e)
		var i, name;
		i = name.length - 1 >> 0;
		while (true) {
			if ( not (i > 0  and  (name.charCodeAt(i) == 47))) { break; end
			name = __substring(name, 0, i);
			i = i - (1) >> 0;
		end
		i = i - (1) >> 0;
		while (true) {
			if ( not (i >= 0)) { break; end
			if (name.charCodeAt(i) == 47) {
				name = __substring(name, (i + 1 >> 0));
				break;
			end
			i = i - (1) >> 0;
		end
		return name;
	end;
	init__2 = function()
		if (false) {
			return;
		end
		__pkg.Args = runtime_args();
	end;
	fillFileStatFromSys = function(e)
		var _1, fs, name;
		fs.name = basename(name);
		fs.size = fs.sys.Size;
		time.Time.copy(fs.modTime, timespecToTime(__clone(fs.sys.Mtimespec, syscall.Timespec)));
		fs.mode = ((((fs.sys.Mode & 511) >>> 0) >>> 0));
		_1 = (fs.sys.Mode & 61440) >>> 0;
		if ((_1 == (24576))  or  (_1 == (57344))) {
			fs.mode = (fs.mode | (67108864)) >>> 0;
		end else if (_1 == (8192)) {
			fs.mode = (fs.mode | (69206016)) >>> 0;
		end else if (_1 == (16384)) {
			fs.mode = (fs.mode | (2147483648)) >>> 0;
		end else if (_1 == (4096)) {
			fs.mode = (fs.mode | (33554432)) >>> 0;
		end else if (_1 == (40960)) {
			fs.mode = (fs.mode | (134217728)) >>> 0;
		end else if (_1 == (32768)) {
		end else if (_1 == (49152)) {
			fs.mode = (fs.mode | (16777216)) >>> 0;
		end
		if ( not ((((fs.sys.Mode & 1024) >>> 0) == 0))) {
			fs.mode = (fs.mode | (4194304)) >>> 0;
		end
		if ( not ((((fs.sys.Mode & 2048) >>> 0) == 0))) {
			fs.mode = (fs.mode | (8388608)) >>> 0;
		end
		if ( not ((((fs.sys.Mode & 512) >>> 0) == 0))) {
			fs.mode = (fs.mode | (1048576)) >>> 0;
		end
	end;
	timespecToTime = function(s)
		var ts;
		return time.Unix((ts.Sec), (ts.Nsec));
	end;
	File.ptr.prototype.Stat = function()
		var _r, err, f, fs, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; err = __f.err; f = __f.f; fs = __f.fs; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fs = [fs];
		f = this;
		if (f == ptrType.nil) {
			__s = -1; return [__ifaceNil, __pkg.ErrInvalid];
		end
		fs[0] = new fileStat.ptr("", new __Int64(0, 0), 0, new time.Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__15.nil), new syscall.Stat_t.ptr(0, 0, 0, new __Uint64(0, 0), 0, 0, 0, arrayType.zero(), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new __Int64(0, 0), new __Int64(0, 0), 0, 0, 0, 0, arrayType__3.zero()));
		_r = f.file.pfd.Fstat(fs[0].sys); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		err = _r;
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			__s = -1; return [__ifaceNil, new PathError.ptr("stat", f.file.name, err)];
		end
		fillFileStatFromSys(fs[0], f.file.name);
		__s = -1; return [fs[0], __ifaceNil];
		/* */ end return; end if __f == nil then  __f = { __blk: File.ptr.prototype.Stat end; end __f._r = _r; __f.err = err; __f.f = f; __f.fs = fs; __f.__s = __s; __f.__r = __r; return __f;
	end;
	File.prototype.Stat = function() return this.__val.Stat(); end;
	Lstat = function(e)
		var err, fs, name;
		fs = new fileStat.ptr("", new __Int64(0, 0), 0, new time.Time.ptr(new __Uint64(0, 0), new __Int64(0, 0), ptrType__15.nil), new syscall.Stat_t.ptr(0, 0, 0, new __Uint64(0, 0), 0, 0, 0, arrayType.zero(), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new syscall.Timespec.ptr(new __Int64(0, 0), new __Int64(0, 0)), new __Int64(0, 0), new __Int64(0, 0), 0, 0, 0, 0, arrayType__3.zero()));
		err = syscall.Lstat(name, fs.sys);
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			return [__ifaceNil, new PathError.ptr("lstat", name, err)];
		end
		fillFileStatFromSys(fs, name);
		return [fs, __ifaceNil];
	end;
	__pkg.Lstat = Lstat;
	FileMode.prototype.String = function()
		var _i, _i__1, _ref, _ref__1, _rune, _rune__1, buf, c, c__1, i, i__1, m, w, y, y__1;
		m = this.__val;
		buf = arrayType__5.zero();
		w = 0;
		_ref = "dalTLDpSugct";
		_i = 0;
		while (true) {
			if not (_i < #_ref) then break; end
			_rune = __decodeRune(_ref, _i);
			i = _i;
			c = _rune[0];
			if ( not ((((m & (((y = (((31 - i >> 0) >>> 0)), y < 32 ? (1 << y) : 0) >>> 0))) >>> 0) == 0))) {
				((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = ((c << 24 >>> 24)));
				w = w + (1) >> 0;
			end
			_i += _rune[1];
		end
		if (w == 0) {
			((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 45);
			w = w + (1) >> 0;
		end
		_ref__1 = "rwxrwxrwx";
		_i__1 = 0;
		while (true) {
			if ( not (_i__1 < _ref__1.length)) { break; end
			_rune__1 = __decodeRune(_ref__1, _i__1);
			i__1 = _i__1;
			c__1 = _rune__1[0];
			if ( not ((((m & (((y__1 = (((8 - i__1 >> 0) >>> 0)), y__1 < 32 ? (1 << y__1) : 0) >>> 0))) >>> 0) == 0))) {
				((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = ((c__1 << 24 >>> 24)));
			end else {
				((w < 0  or  w >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[w] = 45);
			end
			w = w + (1) >> 0;
			_i__1 += _rune__1[1];
		end
		return (__bytesToString(__subslice(new sliceType__2(buf), 0, w)));
	end;
	__ptrType(FileMode).prototype.String = function() return new FileMode(this.__get()).String(); end;
	FileMode.prototype.IsDir = function()
		var m;
		m = this.__val;
		return  not ((((m & 2147483648) >>> 0) == 0));
	end;
	__ptrType(FileMode).prototype.IsDir = function() return new FileMode(this.__get()).IsDir(); end;
	FileMode.prototype.IsRegular = function()
		var m;
		m = this.__val;
		return ((m & 2399141888) >>> 0) == 0;
	end;
	__ptrType(FileMode).prototype.IsRegular = function() return new FileMode(this.__get()).IsRegular(); end;
	FileMode.prototype.Perm = function()
		var m;
		m = this.__val;
		return (m & 511) >>> 0;
	end;
	__ptrType(FileMode).prototype.Perm = function() return new FileMode(this.__get()).Perm(); end;
	fileStat.ptr.prototype.Name = function()
		var fs;
		fs = this;
		return fs.name;
	end;
	fileStat.prototype.Name = function() return this.__val.Name(); end;
	fileStat.ptr.prototype.IsDir = function()
		var fs;
		fs = this;
		return new FileMode(fs.Mode()).IsDir();
	end;
	fileStat.prototype.IsDir = function() return this.__val.IsDir(); end;
	fileStat.ptr.prototype.Size = function()
		var fs;
		fs = this;
		return fs.size;
	end;
	fileStat.prototype.Size = function() return this.__val.Size(); end;
	fileStat.ptr.prototype.Mode = function()
		var fs;
		fs = this;
		return fs.mode;
	end;
	fileStat.prototype.Mode = function() return this.__val.Mode(); end;
	fileStat.ptr.prototype.ModTime = function()
		var fs;
		fs = this;
		return fs.modTime;
	end;
	fileStat.prototype.ModTime = function() return this.__val.ModTime(); end;
	fileStat.ptr.prototype.Sys = function()
		var fs;
		fs = this;
		return fs.sys;
	end;
	fileStat.prototype.Sys = function() return this.__val.Sys(); end;
	ptrType__2.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	ptrType__4.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	ptrType__3.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	ptrType__13.methods = [{prop: "close", name: "close", pkg: "os", typ: __funcType([], [__error], false)end];
	ptrType.methods = [{prop: "Readdir", name: "Readdir", pkg: "", typ: __funcType([__Int], [sliceType__1, __error], false)end, {prop: "Readdirnames", name: "Readdirnames", pkg: "", typ: __funcType([__Int], [sliceType, __error], false)end, {prop: "readdir", name: "readdir", pkg: "os", typ: __funcType([__Int], [sliceType__1, __error], false)end, {prop: "readdirnames", name: "readdirnames", pkg: "os", typ: __funcType([__Int], [sliceType, __error], false)end, {prop: "Name", name: "Name", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Read", name: "Read", pkg: "", typ: __funcType([sliceType__2], [__Int, __error], false)end, {prop: "ReadAt", name: "ReadAt", pkg: "", typ: __funcType([sliceType__2, __Int64], [__Int, __error], false)end, {prop: "Write", name: "Write", pkg: "", typ: __funcType([sliceType__2], [__Int, __error], false)end, {prop: "WriteAt", name: "WriteAt", pkg: "", typ: __funcType([sliceType__2, __Int64], [__Int, __error], false)end, {prop: "Seek", name: "Seek", pkg: "", typ: __funcType([__Int64, __Int], [__Int64, __error], false)end, {prop: "WriteString", name: "WriteString", pkg: "", typ: __funcType([__String], [__Int, __error], false)end, {prop: "wrapErr", name: "wrapErr", pkg: "os", typ: __funcType([__String, __error], [__error], false)end, {prop: "Chmod", name: "Chmod", pkg: "", typ: __funcType([FileMode], [__error], false)end, {prop: "chmod", name: "chmod", pkg: "os", typ: __funcType([FileMode], [__error], false)end, {prop: "Chown", name: "Chown", pkg: "", typ: __funcType([__Int, __Int], [__error], false)end, {prop: "Truncate", name: "Truncate", pkg: "", typ: __funcType([__Int64], [__error], false)end, {prop: "Sync", name: "Sync", pkg: "", typ: __funcType([], [__error], false)end, {prop: "Chdir", name: "Chdir", pkg: "", typ: __funcType([], [__error], false)end, {prop: "checkValid", name: "checkValid", pkg: "os", typ: __funcType([__String], [__error], false)end, {prop: "Fd", name: "Fd", pkg: "", typ: __funcType([], [__Uintptr], false)end, {prop: "Close", name: "Close", pkg: "", typ: __funcType([], [__error], false)end, {prop: "read", name: "read", pkg: "os", typ: __funcType([sliceType__2], [__Int, __error], false)end, {prop: "pread", name: "pread", pkg: "os", typ: __funcType([sliceType__2, __Int64], [__Int, __error], false)end, {prop: "write", name: "write", pkg: "os", typ: __funcType([sliceType__2], [__Int, __error], false)end, {prop: "pwrite", name: "pwrite", pkg: "os", typ: __funcType([sliceType__2, __Int64], [__Int, __error], false)end, {prop: "seek", name: "seek", pkg: "os", typ: __funcType([__Int64, __Int], [__Int64, __error], false)end, {prop: "Stat", name: "Stat", pkg: "", typ: __funcType([], [FileInfo, __error], false)end];
	FileMode.methods = [{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "IsDir", name: "IsDir", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "IsRegular", name: "IsRegular", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Perm", name: "Perm", pkg: "", typ: __funcType([], [FileMode], false)end];
	ptrType__16.methods = [{prop: "Name", name: "Name", pkg: "", typ: __funcType([], [__String], false)end, {prop: "IsDir", name: "IsDir", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Size", name: "Size", pkg: "", typ: __funcType([], [__Int64], false)end, {prop: "Mode", name: "Mode", pkg: "", typ: __funcType([], [FileMode], false)end, {prop: "ModTime", name: "ModTime", pkg: "", typ: __funcType([], [time.Time], false)end, {prop: "Sys", name: "Sys", pkg: "", typ: __funcType([], [__emptyInterface], false)end];
	PathError.init("", [{prop: "Op", name: "Op", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Path", name: "Path", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Err", name: "Err", anonymous: false, exported: true, typ: __error, tag: ""end]);
	SyscallError.init("", [{prop: "Syscall", name: "Syscall", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Err", name: "Err", anonymous: false, exported: true, typ: __error, tag: ""end]);
	LinkError.init("", [{prop: "Op", name: "Op", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Old", name: "Old", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "New", name: "New", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Err", name: "Err", anonymous: false, exported: true, typ: __error, tag: ""end]);
	file.init("os", [{prop: "pfd", name: "pfd", anonymous: false, exported: false, typ: poll.FD, tag: ""end, {prop: "name", name: "name", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "dirinfo", name: "dirinfo", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "nonblock", name: "nonblock", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	dirInfo.init("os", [{prop: "buf", name: "buf", anonymous: false, exported: false, typ: sliceType__2, tag: ""end, {prop: "nbuf", name: "nbuf", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "bufp", name: "bufp", anonymous: false, exported: false, typ: __Int, tag: ""end]);
	File.init("os", [{prop: "file", name: "file", anonymous: true, exported: false, typ: ptrType__13, tag: ""end]);
	FileInfo.init([{prop: "IsDir", name: "IsDir", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "ModTime", name: "ModTime", pkg: "", typ: __funcType([], [time.Time], false)end, {prop: "Mode", name: "Mode", pkg: "", typ: __funcType([], [FileMode], false)end, {prop: "Name", name: "Name", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Size", name: "Size", pkg: "", typ: __funcType([], [__Int64], false)end, {prop: "Sys", name: "Sys", pkg: "", typ: __funcType([], [__emptyInterface], false)end]);
	fileStat.init("os", [{prop: "name", name: "name", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "size", name: "size", anonymous: false, exported: false, typ: __Int64, tag: ""end, {prop: "mode", name: "mode", anonymous: false, exported: false, typ: FileMode, tag: ""end, {prop: "modTime", name: "modTime", anonymous: false, exported: false, typ: time.Time, tag: ""end, {prop: "sys", name: "sys", anonymous: false, exported: false, typ: syscall.Stat_t, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = js.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = poll.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = io.__init(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = runtime.__init(); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = sync.__init(); /* */ __s = 6; case 6: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = atomic.__init(); /* */ __s = 7; case 7: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = syscall.__init(); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = time.__init(); /* */ __s = 9; case 9: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__pkg.Args = sliceType.nil;
		__pkg.ErrInvalid = errors.New("invalid argument");
		__pkg.ErrPermission = errors.New("permission denied");
		__pkg.ErrExist = errors.New("file already exists");
		__pkg.ErrNotExist = errors.New("file does not exist");
		__pkg.ErrClosed = errors.New("file already closed");
		errFinished = errors.New("os: process already finished");
		__pkg.Stdin = NewFile(((syscall.Stdin >>> 0)), "/dev/stdin");
		__pkg.Stdout = NewFile(((syscall.Stdout >>> 0)), "/dev/stdout");
		__pkg.Stderr = NewFile(((syscall.Stderr >>> 0)), "/dev/stderr");
		useSyscallwd = (function(m)
			var param;
			return true;
		end);
		lstat = Lstat;
		init();
		init__1();
		init__2();
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["unicode/utf8"] = (function()
	var __pkg = {}, __init, acceptRange, first, acceptRanges, DecodeRuneInString, RuneLen, EncodeRune, RuneCount, RuneCountInString, ValidRune;
	acceptRange = __pkg.acceptRange = __newType(0, __kindStruct, "utf8.acceptRange", true, "unicode/utf8", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.lo = 0;
			this.hi = 0;
			return;
		end
		this.lo = lo_;
		this.hi = hi_;
	end);
	DecodeRuneInString = function(s)
		var _tmp, _tmp__1, _tmp__10, _tmp__11, _tmp__12, _tmp__13, _tmp__14, _tmp__15, _tmp__16, _tmp__17, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tmp__8, _tmp__9, accept, mask, n, r, s, s0, s1, s2, s3, size, sz, x, x__1;
		r = 0;
		size = 0;
		n = s.length;
		if (n < 1) {
			_tmp = 65533;
			_tmp__1 = 0;
			r = _tmp;
			size = _tmp__1;
			return [r, size];
		end
		s0 = s.charCodeAt(0);
		x = ((s0 < 0  or  s0 >= first.length) ? (__throwRuntimeError("index out of range"), nil) : first[s0]);
		if (x >= 240) {
			mask = (((x >> 0)) << 31 >> 0) >> 31 >> 0;
			_tmp__2 = ((((s.charCodeAt(0) >> 0)) & ~mask) >> 0) | (65533 & mask);
			_tmp__3 = 1;
			r = _tmp__2;
			size = _tmp__3;
			return [r, size];
		end
		sz = (x & 7) >>> 0;
		accept = __clone((x__1 = x >>> 4 << 24 >>> 24, ((x__1 < 0  or  x__1 >= acceptRanges.length) ? (__throwRuntimeError("index out of range"), nil) : acceptRanges[x__1])), acceptRange);
		if (n < ((sz >> 0))) {
			_tmp__4 = 65533;
			_tmp__5 = 1;
			r = _tmp__4;
			size = _tmp__5;
			return [r, size];
		end
		s1 = s.charCodeAt(1);
		if (s1 < accept.lo  or  accept.hi < s1) {
			_tmp__6 = 65533;
			_tmp__7 = 1;
			r = _tmp__6;
			size = _tmp__7;
			return [r, size];
		end
		if (sz == 2) {
			_tmp__8 = (((((s0 & 31) >>> 0) >> 0)) << 6 >> 0) | ((((s1 & 63) >>> 0) >> 0));
			_tmp__9 = 2;
			r = _tmp__8;
			size = _tmp__9;
			return [r, size];
		end
		s2 = s.charCodeAt(2);
		if (s2 < 128  or  191 < s2) {
			_tmp__10 = 65533;
			_tmp__11 = 1;
			r = _tmp__10;
			size = _tmp__11;
			return [r, size];
		end
		if (sz == 3) {
			_tmp__12 = ((((((s0 & 15) >>> 0) >> 0)) << 12 >> 0) | (((((s1 & 63) >>> 0) >> 0)) << 6 >> 0)) | ((((s2 & 63) >>> 0) >> 0));
			_tmp__13 = 3;
			r = _tmp__12;
			size = _tmp__13;
			return [r, size];
		end
		s3 = s.charCodeAt(3);
		if (s3 < 128  or  191 < s3) {
			_tmp__14 = 65533;
			_tmp__15 = 1;
			r = _tmp__14;
			size = _tmp__15;
			return [r, size];
		end
		_tmp__16 = (((((((s0 & 7) >>> 0) >> 0)) << 18 >> 0) | (((((s1 & 63) >>> 0) >> 0)) << 12 >> 0)) | (((((s2 & 63) >>> 0) >> 0)) << 6 >> 0)) | ((((s3 & 63) >>> 0) >> 0));
		_tmp__17 = 4;
		r = _tmp__16;
		size = _tmp__17;
		return [r, size];
	end;
	__pkg.DecodeRuneInString = DecodeRuneInString;
	RuneLen = function(r)
		var r;
		if (r < 0) {
			return -1;
		end else if (r <= 127) {
			return 1;
		end else if (r <= 2047) {
			return 2;
		end else if (55296 <= r  and  r <= 57343) {
			return -1;
		end else if (r <= 65535) {
			return 3;
		end else if (r <= 1114111) {
			return 4;
		end
		return -1;
	end;
	__pkg.RuneLen = RuneLen;
	EncodeRune = function(r)
		var i, p, r;
		i = ((r >>> 0));
		if (i <= 127) {
			(0 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 0] = ((r << 24 >>> 24)));
			return 1;
		end else if (i <= 2047) {
			__unused((1 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 1]));
			(0 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 0] = ((192 | (((r >> 6 >> 0) << 24 >>> 24))) >>> 0));
			(1 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 1] = ((128 | ((((r << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			return 2;
		end else if ((i > 1114111)  or  (55296 <= i  and  i <= 57343)) {
			r = 65533;
			__unused((2 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 2]));
			(0 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 0] = ((224 | (((r >> 12 >> 0) << 24 >>> 24))) >>> 0));
			(1 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 1] = ((128 | (((((r >> 6 >> 0) << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			(2 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 2] = ((128 | ((((r << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			return 3;
		end else if (i <= 65535) {
			__unused((2 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 2]));
			(0 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 0] = ((224 | (((r >> 12 >> 0) << 24 >>> 24))) >>> 0));
			(1 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 1] = ((128 | (((((r >> 6 >> 0) << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			(2 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 2] = ((128 | ((((r << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			return 3;
		end else {
			__unused((3 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 3]));
			(0 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 0] = ((240 | (((r >> 18 >> 0) << 24 >>> 24))) >>> 0));
			(1 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 1] = ((128 | (((((r >> 12 >> 0) << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			(2 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 2] = ((128 | (((((r >> 6 >> 0) << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			(3 >= p.__length ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + 3] = ((128 | ((((r << 24 >>> 24)) & 63) >>> 0)) >>> 0));
			return 4;
		end
	end;
	__pkg.EncodeRune = EncodeRune;
	RuneCount = function(p)
		var accept, c, c__1, c__2, c__3, i, n, np, p, size, x, x__1, x__2, x__3, x__4;
		np = p.__length;
		n = 0;
		i = 0;
		while (true) {
			if ( not (i < np)) { break; end
			n = n + (1) >> 0;
			c = ((i < 0  or  i >= p.__length) ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + i]);
			if (c < 128) {
				i = i + (1) >> 0;
				continue;
			end
			x = ((c < 0  or  c >= first.length) ? (__throwRuntimeError("index out of range"), nil) : first[c]);
			if (x == 241) {
				i = i + (1) >> 0;
				continue;
			end
			size = ((((x & 7) >>> 0) >> 0));
			if ((i + size >> 0) > np) {
				i = i + (1) >> 0;
				continue;
			end
			accept = __clone((x__1 = x >>> 4 << 24 >>> 24, ((x__1 < 0  or  x__1 >= acceptRanges.length) ? (__throwRuntimeError("index out of range"), nil) : acceptRanges[x__1])), acceptRange);
			c__1 = (x__2 = i + 1 >> 0, ((x__2 < 0  or  x__2 >= p.__length) ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + x__2]));
			if (c__1 < accept.lo  or  accept.hi < c__1) {
				size = 1;
			end else if (size == 2) {
			end else {
				c__2 = (x__3 = i + 2 >> 0, ((x__3 < 0  or  x__3 >= p.__length) ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + x__3]));
				if (c__2 < 128  or  191 < c__2) {
					size = 1;
				end else if (size == 3) {
				end else {
					c__3 = (x__4 = i + 3 >> 0, ((x__4 < 0  or  x__4 >= p.__length) ? (__throwRuntimeError("index out of range"), nil) : p.__array[p.__offset + x__4]));
					if (c__3 < 128  or  191 < c__3) {
						size = 1;
					end
				end
			end
			i = i + (size) >> 0;
		end
		return n;
	end;
	__pkg.RuneCount = RuneCount;
	RuneCountInString = function(s)
		var accept, c, c__1, c__2, c__3, i, n, ns, s, size, x, x__1;
		n = 0;
		ns = s.length;
		i = 0;
		while (true) {
			if ( not (i < ns)) { break; end
			c = s.charCodeAt(i);
			if (c < 128) {
				i = i + (1) >> 0;
				n = n + (1) >> 0;
				continue;
			end
			x = ((c < 0  or  c >= first.length) ? (__throwRuntimeError("index out of range"), nil) : first[c]);
			if (x == 241) {
				i = i + (1) >> 0;
				n = n + (1) >> 0;
				continue;
			end
			size = ((((x & 7) >>> 0) >> 0));
			if ((i + size >> 0) > ns) {
				i = i + (1) >> 0;
				n = n + (1) >> 0;
				continue;
			end
			accept = __clone((x__1 = x >>> 4 << 24 >>> 24, ((x__1 < 0  or  x__1 >= acceptRanges.length) ? (__throwRuntimeError("index out of range"), nil) : acceptRanges[x__1])), acceptRange);
			c__1 = s.charCodeAt((i + 1 >> 0));
			if (c__1 < accept.lo  or  accept.hi < c__1) {
				size = 1;
			end else if (size == 2) {
			end else {
				c__2 = s.charCodeAt((i + 2 >> 0));
				if (c__2 < 128  or  191 < c__2) {
					size = 1;
				end else if (size == 3) {
				end else {
					c__3 = s.charCodeAt((i + 3 >> 0));
					if (c__3 < 128  or  191 < c__3) {
						size = 1;
					end
				end
			end
			i = i + (size) >> 0;
			n = n + (1) >> 0;
		end
		n = n;
		return n;
	end;
	__pkg.RuneCountInString = RuneCountInString;
	ValidRune = function(r)
		var r;
		if (0 <= r  and  r < 55296) {
			return true;
		end else if (57343 < r  and  r <= 1114111) {
			return true;
		end
		return false;
	end;
	__pkg.ValidRune = ValidRune;
	acceptRange.init("unicode/utf8", [{prop: "lo", name: "lo", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "hi", name: "hi", anonymous: false, exported: false, typ: __Uint8, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		first = __toNativeArray(__kindUint8, [240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 19, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 35, 3, 3, 52, 4, 4, 4, 68, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241]);
		acceptRanges = __toNativeArray(__kindStruct, [new acceptRange.ptr(128, 191), new acceptRange.ptr(160, 191), new acceptRange.ptr(128, 159), new acceptRange.ptr(144, 191), new acceptRange.ptr(128, 143)]);
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["strconv"] = (function()
	var __pkg = {}, __init, errors, math, utf8, decimal, leftCheat, extFloat, floatInfo, decimalSlice, sliceType__3, sliceType__4, sliceType__5, arrayType, sliceType__6, arrayType__1, arrayType__2, ptrType__1, arrayType__3, arrayType__4, ptrType__2, ptrType__3, ptrType__4, optimize, leftcheats, smallPowersOfTen, powersOfTen, uint64pow10, float32info, float32info__24ptr, float64info, float64info__24ptr, isPrint16, isNotPrint16, isPrint32, isNotPrint32, isGraphic, shifts, digitZero, trim, rightShift, prefixIsLessThan, leftShift, shouldRoundUp, frexp10Many, adjustLastDigitFixed, adjustLastDigit, AppendFloat, genericFtoa, bigFtoa, formatDigits, roundShortest, fmtE, fmtF, fmtB, min, max, FormatInt, Itoa, small, formatBits, appendQuotedWith, appendQuotedRuneWith, appendEscapedRune, AppendQuote, AppendQuoteToASCII, AppendQuoteRune, AppendQuoteRuneToASCII, CanBackquote, unhex, UnquoteChar, Unquote, contains, bsearch16, bsearch32, IsPrint, isInGraphicList;
	errors = __packages["errors"];
	math = __packages["math"];
	utf8 = __packages["unicode/utf8"];
	decimal = __pkg.decimal = __newType(0, __kindStruct, "strconv.decimal", true, "strconv", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.d = arrayType.zero();
			this.nd = 0;
			this.dp = 0;
			this.neg = false;
			this.trunc = false;
			return;
		end
		this.d = d_;
		this.nd = nd_;
		this.dp = dp_;
		this.neg = neg_;
		this.trunc = trunc_;
	end);
	leftCheat = __pkg.leftCheat = __newType(0, __kindStruct, "strconv.leftCheat", true, "strconv", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.delta = 0;
			this.cutoff = "";
			return;
		end
		this.delta = delta_;
		this.cutoff = cutoff_;
	end);
	extFloat = __pkg.extFloat = __newType(0, __kindStruct, "strconv.extFloat", true, "strconv", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.mant = new __Uint64(0, 0);
			this.exp = 0;
			this.neg = false;
			return;
		end
		this.mant = mant_;
		this.exp = exp_;
		this.neg = neg_;
	end);
	floatInfo = __pkg.floatInfo = __newType(0, __kindStruct, "strconv.floatInfo", true, "strconv", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.mantbits = 0;
			this.expbits = 0;
			this.bias = 0;
			return;
		end
		this.mantbits = mantbits_;
		this.expbits = expbits_;
		this.bias = bias_;
	end);
	decimalSlice = __pkg.decimalSlice = __newType(0, __kindStruct, "strconv.decimalSlice", true, "strconv", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.d = sliceType__6.nil;
			this.nd = 0;
			this.dp = 0;
			this.neg = false;
			return;
		end
		this.d = d_;
		this.nd = nd_;
		this.dp = dp_;
		this.neg = neg_;
	end);
	sliceType__3 = __sliceType(leftCheat);
	sliceType__4 = __sliceType(__Uint16);
	sliceType__5 = __sliceType(__Uint32);
	arrayType = __arrayType(__Uint8, 800);
	sliceType__6 = __sliceType(__Uint8);
	arrayType__1 = __arrayType(__Uint8, 24);
	arrayType__2 = __arrayType(__Uint8, 32);
	ptrType__1 = __ptrType(floatInfo);
	arrayType__3 = __arrayType(__Uint8, 65);
	arrayType__4 = __arrayType(__Uint8, 4);
	ptrType__2 = __ptrType(decimal);
	ptrType__3 = __ptrType(decimalSlice);
	ptrType__4 = __ptrType(extFloat);
	decimal.ptr.prototype.String = function()
		var a, buf, n, w;
		a = this;
		n = 10 + a.nd >> 0;
		if (a.dp > 0) {
			n = n + (a.dp) >> 0;
		end
		if (a.dp < 0) {
			n = n + (-a.dp) >> 0;
		end
		buf = __makeSlice(sliceType__6, n);
		w = 0;
		if ((a.nd == 0)) {
			return "0";
		end else if (a.dp <= 0) {
			((w < 0  or  w >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + w] = 48);
			w = w + (1) >> 0;
			((w < 0  or  w >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + w] = 46);
			w = w + (1) >> 0;
			w = w + (digitZero(__subslice(buf, w, (w + -a.dp >> 0)))) >> 0;
			w = w + (__copySlice(__subslice(buf, w), __subslice(new sliceType__6(a.d), 0, a.nd))) >> 0;
		end else if (a.dp < a.nd) {
			w = w + (__copySlice(__subslice(buf, w), __subslice(new sliceType__6(a.d), 0, a.dp))) >> 0;
			((w < 0  or  w >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + w] = 46);
			w = w + (1) >> 0;
			w = w + (__copySlice(__subslice(buf, w), __subslice(new sliceType__6(a.d), a.dp, a.nd))) >> 0;
		end else {
			w = w + (__copySlice(__subslice(buf, w), __subslice(new sliceType__6(a.d), 0, a.nd))) >> 0;
			w = w + (digitZero(__subslice(buf, w, ((w + a.dp >> 0) - a.nd >> 0)))) >> 0;
		end
		return (__bytesToString(__subslice(buf, 0, w)));
	end;
	decimal.prototype.String = function() return this.__val.String(); end;
	digitZero = function(t)
		var _i, _ref, dst, i;
		_ref = dst;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			((i < 0  or  i >= dst.__length) ? (__throwRuntimeError("index out of range"), nil) : dst.__array[dst.__offset + i] = 48);
			_i++;
		end
		return dst.__length;
	end;
	trim = function(a)
		var a, x, x__1;
		while (true) {
			if ( not (a.nd > 0  and  ((x = a.d, x__1 = a.nd - 1 >> 0, ((x__1 < 0  or  x__1 >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[x__1])) == 48))) { break; end
			a.nd = a.nd - (1) >> 0;
		end
		if (a.nd == 0) {
			a.dp = 0;
		end
	end;
	decimal.ptr.prototype.Assign = function(v)
		var a, buf, n, v, v1, x, x__1, x__2;
		a = this;
		buf = arrayType__1.zero();
		n = 0;
		while (true) {
			if ( not ((v.__high > 0  or  (v.__high == 0  and  v.__low > 0)))) { break; end
			v1 = __div64(v, new __Uint64(0, 10), false);
			v = (x = __mul64(new __Uint64(0, 10), v1), new __Uint64(v.__high - x.__high, v.__low - x.__low));
			((n < 0  or  n >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[n] = ((new __Uint64(v.__high + 0, v.__low + 48).__low << 24 >>> 24)));
			n = n + (1) >> 0;
			v = v1;
		end
		a.nd = 0;
		n = n - (1) >> 0;
		while (true) {
			if ( not (n >= 0)) { break; end
			(x__1 = a.d, x__2 = a.nd, ((x__2 < 0  or  x__2 >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[x__2] = ((n < 0  or  n >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[n])));
			a.nd = a.nd + (1) >> 0;
			n = n - (1) >> 0;
		end
		a.dp = a.nd;
		trim(a);
	end;
	decimal.prototype.Assign = function(v) return this.__val.Assign(v); end;
	rightShift = function(k)
		var a, c, c__1, dig, dig__1, k, mask, n, r, w, x, x__1, x__2, x__3, y, y__1, y__2, y__3, y__4;
		r = 0;
		w = 0;
		n = 0;
		while (true) {
			if ( not (((y = k, y < 32 ? (n >>> y) : 0) >>> 0) == 0)) { break; end
			if (r >= a.nd) {
				if (n == 0) {
					a.nd = 0;
					return;
				end
				while (true) {
					if ( not (((y__1 = k, y__1 < 32 ? (n >>> y__1) : 0) >>> 0) == 0)) { break; end
					n = n * 10 >>> 0;
					r = r + (1) >> 0;
				end
				break;
			end
			c = (((x = a.d, ((r < 0  or  r >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[r])) >>> 0));
			n = ((n * 10 >>> 0) + c >>> 0) - 48 >>> 0;
			r = r + (1) >> 0;
		end
		a.dp = a.dp - ((r - 1 >> 0)) >> 0;
		mask = (((y__2 = k, y__2 < 32 ? (1 << y__2) : 0) >>> 0)) - 1 >>> 0;
		while (true) {
			if ( not (r < a.nd)) { break; end
			c__1 = (((x__1 = a.d, ((r < 0  or  r >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[r])) >>> 0));
			dig = (y__3 = k, y__3 < 32 ? (n >>> y__3) : 0) >>> 0;
			n = (n & (mask)) >>> 0;
			(x__2 = a.d, ((w < 0  or  w >= x__2.length) ? (__throwRuntimeError("index out of range"), nil) : x__2[w] = (((dig + 48 >>> 0) << 24 >>> 24))));
			w = w + (1) >> 0;
			n = ((n * 10 >>> 0) + c__1 >>> 0) - 48 >>> 0;
			r = r + (1) >> 0;
		end
		while (true) {
			if ( not (n > 0)) { break; end
			dig__1 = (y__4 = k, y__4 < 32 ? (n >>> y__4) : 0) >>> 0;
			n = (n & (mask)) >>> 0;
			if (w < 800) {
				(x__3 = a.d, ((w < 0  or  w >= x__3.length) ? (__throwRuntimeError("index out of range"), nil) : x__3[w] = (((dig__1 + 48 >>> 0) << 24 >>> 24))));
				w = w + (1) >> 0;
			end else if (dig__1 > 0) {
				a.trunc = true;
			end
			n = n * 10 >>> 0;
		end
		a.nd = w;
		trim(a);
	end;
	prefixIsLessThan = function(s)
		var b, i, s;
		i = 0;
		while (true) {
			if ( not (i < s.length)) { break; end
			if (i >= b.__length) {
				return true;
			end
			if ( not ((((i < 0  or  i >= b.__length) ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + i]) == s.charCodeAt(i)))) {
				return ((i < 0  or  i >= b.__length) ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + i]) < s.charCodeAt(i);
			end
			i = i + (1) >> 0;
		end
		return false;
	end;
	leftShift = function(k)
		var _q, _q__1, a, delta, k, n, quo, quo__1, r, rem, rem__1, w, x, x__1, x__2, y;
		delta = ((k < 0  or  k >= leftcheats.__length) ? (__throwRuntimeError("index out of range"), nil) : leftcheats.__array[leftcheats.__offset + k]).delta;
		if (prefixIsLessThan(__subslice(new sliceType__6(a.d), 0, a.nd), ((k < 0  or  k >= leftcheats.__length) ? (__throwRuntimeError("index out of range"), nil) : leftcheats.__array[leftcheats.__offset + k]).cutoff)) {
			delta = delta - (1) >> 0;
		end
		r = a.nd;
		w = a.nd + delta >> 0;
		n = 0;
		r = r - (1) >> 0;
		while (true) {
			if ( not (r >= 0)) { break; end
			n = n + (((y = k, y < 32 ? ((((((x = a.d, ((r < 0  or  r >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[r])) >>> 0)) - 48 >>> 0)) << y) : 0) >>> 0)) >>> 0;
			quo = (_q = n / 10, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >>> 0 : __throwRuntimeError("integer divide by zero"));
			rem = n - (10 * quo >>> 0) >>> 0;
			w = w - (1) >> 0;
			if (w < 800) {
				(x__1 = a.d, ((w < 0  or  w >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[w] = (((rem + 48 >>> 0) << 24 >>> 24))));
			end else if ( not ((rem == 0))) {
				a.trunc = true;
			end
			n = quo;
			r = r - (1) >> 0;
		end
		while (true) {
			if ( not (n > 0)) { break; end
			quo__1 = (_q__1 = n / 10, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >>> 0 : __throwRuntimeError("integer divide by zero"));
			rem__1 = n - (10 * quo__1 >>> 0) >>> 0;
			w = w - (1) >> 0;
			if (w < 800) {
				(x__2 = a.d, ((w < 0  or  w >= x__2.length) ? (__throwRuntimeError("index out of range"), nil) : x__2[w] = (((rem__1 + 48 >>> 0) << 24 >>> 24))));
			end else if ( not ((rem__1 == 0))) {
				a.trunc = true;
			end
			n = quo__1;
		end
		a.nd = a.nd + (delta) >> 0;
		if (a.nd >= 800) {
			a.nd = 800;
		end
		a.dp = a.dp + (delta) >> 0;
		trim(a);
	end;
	decimal.ptr.prototype.Shift = function(k)
		var a, k;
		a = this;
		if ((a.nd == 0)) {
		end else if (k > 0) {
			while (true) {
				if ( not (k > 28)) { break; end
				leftShift(a, 28);
				k = k - (28) >> 0;
			end
			leftShift(a, ((k >>> 0)));
		end else if (k < 0) {
			while (true) {
				if ( not (k < -28)) { break; end
				rightShift(a, 28);
				k = k + (28) >> 0;
			end
			rightShift(a, ((-k >>> 0)));
		end
	end;
	decimal.prototype.Shift = function(k) return this.__val.Shift(k); end;
	shouldRoundUp = function(d)
		var _r, a, nd, x, x__1, x__2, x__3;
		if (nd < 0  or  nd >= a.nd) {
			return false;
		end
		if (((x = a.d, ((nd < 0  or  nd >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[nd])) == 53)  and  ((nd + 1 >> 0) == a.nd)) {
			if (a.trunc) {
				return true;
			end
			return nd > 0  and   not (((_r = (((x__1 = a.d, x__2 = nd - 1 >> 0, ((x__2 < 0  or  x__2 >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[x__2])) - 48 << 24 >>> 24)) % 2, _r == _r ? _r : __throwRuntimeError("integer divide by zero")) == 0));
		end
		return (x__3 = a.d, ((nd < 0  or  nd >= x__3.length) ? (__throwRuntimeError("index out of range"), nil) : x__3[nd])) >= 53;
	end;
	decimal.ptr.prototype.Round = function(d)
		var a, nd;
		a = this;
		if (nd < 0  or  nd >= a.nd) {
			return;
		end
		if (shouldRoundUp(a, nd)) {
			a.RoundUp(nd);
		end else {
			a.RoundDown(nd);
		end
	end;
	decimal.prototype.Round = function(d) return this.__val.Round(nd); end;
	decimal.ptr.prototype.RoundDown = function(d)
		var a, nd;
		a = this;
		if (nd < 0  or  nd >= a.nd) {
			return;
		end
		a.nd = nd;
		trim(a);
	end;
	decimal.prototype.RoundDown = function(d) return this.__val.RoundDown(nd); end;
	decimal.ptr.prototype.RoundUp = function(d)
		var a, c, i, nd, x, x__1, x__2;
		a = this;
		if (nd < 0  or  nd >= a.nd) {
			return;
		end
		i = nd - 1 >> 0;
		while (true) {
			if ( not (i >= 0)) { break; end
			c = (x = a.d, ((i < 0  or  i >= x.length) ? (__throwRuntimeError("index out of range"), nil) : x[i]));
			if (c < 57) {
				(x__2 = a.d, ((i < 0  or  i >= x__2.length) ? (__throwRuntimeError("index out of range"), nil) : x__2[i] = ((x__1 = a.d, ((i < 0  or  i >= x__1.length) ? (__throwRuntimeError("index out of range"), nil) : x__1[i])) + (1) << 24 >>> 24)));
				a.nd = i + 1 >> 0;
				return;
			end
			i = i - (1) >> 0;
		end
		a.d[0] = 49;
		a.nd = 1;
		a.dp = a.dp + (1) >> 0;
	end;
	decimal.prototype.RoundUp = function(d) return this.__val.RoundUp(nd); end;
	decimal.ptr.prototype.RoundedInteger = function()
		var a, i, n, x, x__1, x__2, x__3;
		a = this;
		if (a.dp > 20) {
			return new __Uint64(4294967295, 4294967295);
		end
		i = 0;
		n = new __Uint64(0, 0);
		i = 0;
		while (true) {
			if ( not (i < a.dp  and  i < a.nd)) { break; end
			n = (x = __mul64(n, new __Uint64(0, 10)), x__1 = (new __Uint64(0, ((x__2 = a.d, ((i < 0  or  i >= x__2.length) ? (__throwRuntimeError("index out of range"), nil) : x__2[i])) - 48 << 24 >>> 24))), new __Uint64(x.__high + x__1.__high, x.__low + x__1.__low));
			i = i + (1) >> 0;
		end
		while (true) {
			if ( not (i < a.dp)) { break; end
			n = __mul64(n, (new __Uint64(0, 10)));
			i = i + (1) >> 0;
		end
		if (shouldRoundUp(a, a.dp)) {
			n = (x__3 = new __Uint64(0, 1), new __Uint64(n.__high + x__3.__high, n.__low + x__3.__low));
		end
		return n;
	end;
	decimal.prototype.RoundedInteger = function() return this.__val.RoundedInteger(); end;
	extFloat.ptr.prototype.AssignComputeBounds = function(t)
		var _tmp, _tmp__1, exp, expBiased, f, flt, lower, mant, neg, upper, x, x__1, x__2, x__3, x__4;
		lower = new extFloat.ptr(new __Uint64(0, 0), 0, false);
		upper = new extFloat.ptr(new __Uint64(0, 0), 0, false);
		f = this;
		f.mant = mant;
		f.exp = exp - ((flt.mantbits >> 0)) >> 0;
		f.neg = neg;
		if (f.exp <= 0  and  (x = __shiftLeft64((__shiftRightUint64(mant, ((-f.exp >>> 0)))), ((-f.exp >>> 0))), (mant.__high == x.__high  and  mant.__low == x.__low))) {
			f.mant = __shiftRightUint64(f.mant, (((-f.exp >>> 0))));
			f.exp = 0;
			_tmp = __clone(f, extFloat);
			_tmp__1 = __clone(f, extFloat);
			extFloat.copy(lower, _tmp);
			extFloat.copy(upper, _tmp__1);
			return [lower, upper];
		end
		expBiased = exp - flt.bias >> 0;
		extFloat.copy(upper, new extFloat.ptr((x__1 = __mul64(new __Uint64(0, 2), f.mant), new __Uint64(x__1.__high + 0, x__1.__low + 1)), f.exp - 1 >> 0, f.neg));
		if ( not ((x__2 = __shiftLeft64(new __Uint64(0, 1), flt.mantbits), (mant.__high == x__2.__high  and  mant.__low == x__2.__low)))  or  (expBiased == 1)) {
			extFloat.copy(lower, new extFloat.ptr((x__3 = __mul64(new __Uint64(0, 2), f.mant), new __Uint64(x__3.__high - 0, x__3.__low - 1)), f.exp - 1 >> 0, f.neg));
		end else {
			extFloat.copy(lower, new extFloat.ptr((x__4 = __mul64(new __Uint64(0, 4), f.mant), new __Uint64(x__4.__high - 0, x__4.__low - 1)), f.exp - 2 >> 0, f.neg));
		end
		return [lower, upper];
	end;
	extFloat.prototype.AssignComputeBounds = function(t) return this.__val.AssignComputeBounds(mant, exp, neg, flt); end;
	extFloat.ptr.prototype.Normalize = function()
		var _tmp, _tmp__1, _tmp__2, _tmp__3, exp, f, mant, shift, x, x__1, x__2, x__3, x__4, x__5;
		shift = 0;
		f = this;
		_tmp = f.mant;
		_tmp__1 = f.exp;
		mant = _tmp;
		exp = _tmp__1;
		if ((mant.__high == 0  and  mant.__low == 0)) {
			shift = 0;
			return shift;
		end
		if ((x = __shiftRightUint64(mant, 32), (x.__high == 0  and  x.__low == 0))) {
			mant = __shiftLeft64(mant, (32));
			exp = exp - (32) >> 0;
		end
		if ((x__1 = __shiftRightUint64(mant, 48), (x__1.__high == 0  and  x__1.__low == 0))) {
			mant = __shiftLeft64(mant, (16));
			exp = exp - (16) >> 0;
		end
		if ((x__2 = __shiftRightUint64(mant, 56), (x__2.__high == 0  and  x__2.__low == 0))) {
			mant = __shiftLeft64(mant, (8));
			exp = exp - (8) >> 0;
		end
		if ((x__3 = __shiftRightUint64(mant, 60), (x__3.__high == 0  and  x__3.__low == 0))) {
			mant = __shiftLeft64(mant, (4));
			exp = exp - (4) >> 0;
		end
		if ((x__4 = __shiftRightUint64(mant, 62), (x__4.__high == 0  and  x__4.__low == 0))) {
			mant = __shiftLeft64(mant, (2));
			exp = exp - (2) >> 0;
		end
		if ((x__5 = __shiftRightUint64(mant, 63), (x__5.__high == 0  and  x__5.__low == 0))) {
			mant = __shiftLeft64(mant, (1));
			exp = exp - (1) >> 0;
		end
		shift = (((f.exp - exp >> 0) >>> 0));
		_tmp__2 = mant;
		_tmp__3 = exp;
		f.mant = _tmp__2;
		f.exp = _tmp__3;
		return shift;
	end;
	extFloat.prototype.Normalize = function() return this.__val.Normalize(); end;
	extFloat.ptr.prototype.Multiply = function(g)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, cross1, cross2, f, fhi, flo, g, ghi, glo, rem, x, x__1, x__10, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		f = this;
		_tmp = __shiftRightUint64(f.mant, 32);
		_tmp__1 = (new __Uint64(0, ((f.mant.__low >>> 0))));
		fhi = _tmp;
		flo = _tmp__1;
		_tmp__2 = __shiftRightUint64(g.mant, 32);
		_tmp__3 = (new __Uint64(0, ((g.mant.__low >>> 0))));
		ghi = _tmp__2;
		glo = _tmp__3;
		cross1 = __mul64(fhi, glo);
		cross2 = __mul64(flo, ghi);
		f.mant = (x = (x__1 = __mul64(fhi, ghi), x__2 = __shiftRightUint64(cross1, 32), new __Uint64(x__1.__high + x__2.__high, x__1.__low + x__2.__low)), x__3 = __shiftRightUint64(cross2, 32), new __Uint64(x.__high + x__3.__high, x.__low + x__3.__low));
		rem = (x__4 = (x__5 = (new __Uint64(0, ((cross1.__low >>> 0)))), x__6 = (new __Uint64(0, ((cross2.__low >>> 0)))), new __Uint64(x__5.__high + x__6.__high, x__5.__low + x__6.__low)), x__7 = __shiftRightUint64((__mul64(flo, glo)), 32), new __Uint64(x__4.__high + x__7.__high, x__4.__low + x__7.__low));
		rem = (x__8 = new __Uint64(0, 2147483648), new __Uint64(rem.__high + x__8.__high, rem.__low + x__8.__low));
		f.mant = (x__9 = f.mant, x__10 = (__shiftRightUint64(rem, 32)), new __Uint64(x__9.__high + x__10.__high, x__9.__low + x__10.__low));
		f.exp = (f.exp + g.exp >> 0) + 64 >> 0;
	end;
	extFloat.prototype.Multiply = function(g) return this.__val.Multiply(g); end;
	extFloat.ptr.prototype.AssignDecimal = function(t)
		var _q, _r, adjExp, denormalExp, errors__1, exp10, extrabits, f, flt, halfway, i, mant_extra, mantissa, neg, ok, shift, trunc, x, x__1, x__10, x__11, x__12, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9, y;
		ok = false;
		f = this;
		errors__1 = 0;
		if (trunc) {
			errors__1 = errors__1 + (4) >> 0;
		end
		f.mant = mantissa;
		f.exp = 0;
		f.neg = neg;
		i = (_q = ((exp10 - -348 >> 0)) / 8, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
		if (exp10 < -348  or  i >= 87) {
			ok = false;
			return ok;
		end
		adjExp = (_r = ((exp10 - -348 >> 0)) % 8, _r == _r ? _r : __throwRuntimeError("integer divide by zero"));
		if (adjExp < 19  and  (x = (x__1 = 19 - adjExp >> 0, ((x__1 < 0  or  x__1 >= uint64pow10.length) ? (__throwRuntimeError("index out of range"), nil) : uint64pow10[x__1])), (mantissa.__high < x.__high  or  (mantissa.__high == x.__high  and  mantissa.__low < x.__low)))) {
			f.mant = __mul64(f.mant, (((adjExp < 0  or  adjExp >= uint64pow10.length) ? (__throwRuntimeError("index out of range"), nil) : uint64pow10[adjExp])));
			f.Normalize();
		end else {
			f.Normalize();
			f.Multiply(__clone(((adjExp < 0  or  adjExp >= smallPowersOfTen.length) ? (__throwRuntimeError("index out of range"), nil) : smallPowersOfTen[adjExp]), extFloat));
			errors__1 = errors__1 + (4) >> 0;
		end
		f.Multiply(__clone(((i < 0  or  i >= powersOfTen.length) ? (__throwRuntimeError("index out of range"), nil) : powersOfTen[i]), extFloat));
		if (errors__1 > 0) {
			errors__1 = errors__1 + (1) >> 0;
		end
		errors__1 = errors__1 + (4) >> 0;
		shift = f.Normalize();
		errors__1 = (y = (shift), y < 32 ? (errors__1 << y) : 0) >> 0;
		denormalExp = flt.bias - 63 >> 0;
		extrabits = 0;
		if (f.exp <= denormalExp) {
			extrabits = ((63 - flt.mantbits >>> 0) + 1 >>> 0) + (((denormalExp - f.exp >> 0) >>> 0)) >>> 0;
		end else {
			extrabits = 63 - flt.mantbits >>> 0;
		end
		halfway = __shiftLeft64(new __Uint64(0, 1), ((extrabits - 1 >>> 0)));
		mant_extra = (x__2 = f.mant, x__3 = (x__4 = __shiftLeft64(new __Uint64(0, 1), extrabits), new __Uint64(x__4.__high - 0, x__4.__low - 1)), new __Uint64(x__2.__high & x__3.__high, (x__2.__low & x__3.__low) >>> 0));
		if ((x__5 = (x__6 = (new __Int64(halfway.__high, halfway.__low)), x__7 = (new __Int64(0, errors__1)), new __Int64(x__6.__high - x__7.__high, x__6.__low - x__7.__low)), x__8 = (new __Int64(mant_extra.__high, mant_extra.__low)), (x__5.__high < x__8.__high  or  (x__5.__high == x__8.__high  and  x__5.__low < x__8.__low)))  and  (x__9 = (new __Int64(mant_extra.__high, mant_extra.__low)), x__10 = (x__11 = (new __Int64(halfway.__high, halfway.__low)), x__12 = (new __Int64(0, errors__1)), new __Int64(x__11.__high + x__12.__high, x__11.__low + x__12.__low)), (x__9.__high < x__10.__high  or  (x__9.__high == x__10.__high  and  x__9.__low < x__10.__low)))) {
			ok = false;
			return ok;
		end
		ok = true;
		return ok;
	end;
	extFloat.prototype.AssignDecimal = function(t) return this.__val.AssignDecimal(mantissa, exp10, neg, trunc, flt); end;
	extFloat.ptr.prototype.frexp10 = function()
		var _q, _q__1, _tmp, _tmp__1, approxExp10, exp, exp10, f, i, index;
		exp10 = 0;
		index = 0;
		f = this;
		approxExp10 = (_q = (__imul(((-46 - f.exp >> 0)), 28)) / 93, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero"));
		i = (_q__1 = ((approxExp10 - -348 >> 0)) / 8, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >> 0 : __throwRuntimeError("integer divide by zero"));
		Loop:
		while (true) {
			exp = (f.exp + ((i < 0  or  i >= powersOfTen.length) ? (__throwRuntimeError("index out of range"), nil) : powersOfTen[i]).exp >> 0) + 64 >> 0;
			if (exp < -60) {
				i = i + (1) >> 0;
			end else if (exp > -32) {
				i = i - (1) >> 0;
			end else {
				break Loop;
			end
		end
		f.Multiply(__clone(((i < 0  or  i >= powersOfTen.length) ? (__throwRuntimeError("index out of range"), nil) : powersOfTen[i]), extFloat));
		_tmp = -((-348 + (__imul(i, 8)) >> 0));
		_tmp__1 = i;
		exp10 = _tmp;
		index = _tmp__1;
		return [exp10, index];
	end;
	extFloat.prototype.frexp10 = function() return this.__val.frexp10(); end;
	frexp10Many = function(c)
		var _tuple, a, b, c, exp10, i;
		exp10 = 0;
		_tuple = c.frexp10();
		exp10 = _tuple[0];
		i = _tuple[1];
		a.Multiply(__clone(((i < 0  or  i >= powersOfTen.length) ? (__throwRuntimeError("index out of range"), nil) : powersOfTen[i]), extFloat));
		b.Multiply(__clone(((i < 0  or  i >= powersOfTen.length) ? (__throwRuntimeError("index out of range"), nil) : powersOfTen[i]), extFloat));
		return exp10;
	end;
	extFloat.ptr.prototype.FixedDecimal = function(n)
		var __CE__B5, _q, _q__1, _tmp, _tmp__1, _tuple, buf, d, digit, exp10, f, fraction, i, i__1, i__2, integer, integerDigits, n, nd, needed, ok, pos, pow, pow10, rest, shift, v, v1, x, x__1, x__10, x__11, x__12, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		f = this;
		if ((x = f.mant, (x.__high == 0  and  x.__low == 0))) {
			d.nd = 0;
			d.dp = 0;
			d.neg = f.neg;
			return true;
		end
		if (n == 0) {
			__panic(new __String("strconv: internal error: extFloat.FixedDecimal called with n == 0"));
		end
		f.Normalize();
		_tuple = f.frexp10();
		exp10 = _tuple[0];
		shift = ((-f.exp >>> 0));
		integer = ((__shiftRightUint64(f.mant, shift).__low >>> 0));
		fraction = (x__1 = f.mant, x__2 = __shiftLeft64((new __Uint64(0, integer)), shift), new __Uint64(x__1.__high - x__2.__high, x__1.__low - x__2.__low));
		__CE__B5 = new __Uint64(0, 1);
		needed = n;
		integerDigits = 0;
		pow10 = new __Uint64(0, 1);
		_tmp = 0;
		_tmp__1 = new __Uint64(0, 1);
		i = _tmp;
		pow = _tmp__1;
		while (true) {
			if ( not (i < 20)) { break; end
			if ((x__3 = (new __Uint64(0, integer)), (pow.__high > x__3.__high  or  (pow.__high == x__3.__high  and  pow.__low > x__3.__low)))) {
				integerDigits = i;
				break;
			end
			pow = __mul64(pow, (new __Uint64(0, 10)));
			i = i + (1) >> 0;
		end
		rest = integer;
		if (integerDigits > needed) {
			pow10 = (x__4 = integerDigits - needed >> 0, ((x__4 < 0  or  x__4 >= uint64pow10.length) ? (__throwRuntimeError("index out of range"), nil) : uint64pow10[x__4]));
			integer = (_q = integer / (((pow10.__low >>> 0))), (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >>> 0 : __throwRuntimeError("integer divide by zero"));
			rest = rest - ((__imul(integer, ((pow10.__low >>> 0))) >>> 0)) >>> 0;
		end else {
			rest = 0;
		end
		buf = arrayType__2.zero();
		pos = 32;
		v = integer;
		while (true) {
			if ( not (v > 0)) { break; end
			v1 = (_q__1 = v / 10, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >>> 0 : __throwRuntimeError("integer divide by zero"));
			v = v - ((__imul(10, v1) >>> 0)) >>> 0;
			pos = pos - (1) >> 0;
			((pos < 0  or  pos >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[pos] = (((v + 48 >>> 0) << 24 >>> 24)));
			v = v1;
		end
		i__1 = pos;
		while (true) {
			if ( not (i__1 < 32)) { break; end
			(x__5 = d.d, x__6 = i__1 - pos >> 0, ((x__6 < 0  or  x__6 >= x__5.__length) ? (__throwRuntimeError("index out of range"), nil) : x__5.__array[x__5.__offset + x__6] = ((i__1 < 0  or  i__1 >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[i__1])));
			i__1 = i__1 + (1) >> 0;
		end
		nd = 32 - pos >> 0;
		d.nd = nd;
		d.dp = integerDigits + exp10 >> 0;
		needed = needed - (nd) >> 0;
		if (needed > 0) {
			if ( not ((rest == 0))  or   not ((pow10.__high == 0  and  pow10.__low == 1))) {
				__panic(new __String("strconv: internal error, rest  not = 0 but needed > 0"));
			end
			while (true) {
				if ( not (needed > 0)) { break; end
				fraction = __mul64(fraction, (new __Uint64(0, 10)));
				__CE__B5 = __mul64(__CE__B5, (new __Uint64(0, 10)));
				if ((x__7 = __mul64(new __Uint64(0, 2), __CE__B5), x__8 = __shiftLeft64(new __Uint64(0, 1), shift), (x__7.__high > x__8.__high  or  (x__7.__high == x__8.__high  and  x__7.__low > x__8.__low)))) {
					return false;
				end
				digit = __shiftRightUint64(fraction, shift);
				(x__9 = d.d, ((nd < 0  or  nd >= x__9.__length) ? (__throwRuntimeError("index out of range"), nil) : x__9.__array[x__9.__offset + nd] = ((new __Uint64(digit.__high + 0, digit.__low + 48).__low << 24 >>> 24))));
				fraction = (x__10 = __shiftLeft64(digit, shift), new __Uint64(fraction.__high - x__10.__high, fraction.__low - x__10.__low));
				nd = nd + (1) >> 0;
				needed = needed - (1) >> 0;
			end
			d.nd = nd;
		end
		ok = adjustLastDigitFixed(d, (x__11 = __shiftLeft64((new __Uint64(0, rest)), shift), new __Uint64(x__11.__high | fraction.__high, (x__11.__low | fraction.__low) >>> 0)), pow10, shift, __CE__B5);
		if ( not ok) {
			return false;
		end
		i__2 = d.nd - 1 >> 0;
		while (true) {
			if ( not (i__2 >= 0)) { break; end
			if ( not (((x__12 = d.d, ((i__2 < 0  or  i__2 >= x__12.__length) ? (__throwRuntimeError("index out of range"), nil) : x__12.__array[x__12.__offset + i__2])) == 48))) {
				d.nd = i__2 + 1 >> 0;
				break;
			end
			i__2 = i__2 - (1) >> 0;
		end
		return true;
	end;
	extFloat.prototype.FixedDecimal = function(n) return this.__val.FixedDecimal(d, n); end;
	adjustLastDigitFixed = function(5)
		var __CE__B5, d, den, i, num, shift, x, x__1, x__10, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		if ((x = __shiftLeft64(den, shift), (num.__high > x.__high  or  (num.__high == x.__high  and  num.__low > x.__low)))) {
			__panic(new __String("strconv: num > den<<shift in adjustLastDigitFixed"));
		end
		if ((x__1 = __mul64(new __Uint64(0, 2), __CE__B5), x__2 = __shiftLeft64(den, shift), (x__1.__high > x__2.__high  or  (x__1.__high == x__2.__high  and  x__1.__low > x__2.__low)))) {
			__panic(new __String("strconv: \xCE\xB5 > (den<<shift)/2"));
		end
		if ((x__3 = __mul64(new __Uint64(0, 2), (new __Uint64(num.__high + __CE__B5.__high, num.__low + __CE__B5.__low))), x__4 = __shiftLeft64(den, shift), (x__3.__high < x__4.__high  or  (x__3.__high == x__4.__high  and  x__3.__low < x__4.__low)))) {
			return true;
		end
		if ((x__5 = __mul64(new __Uint64(0, 2), (new __Uint64(num.__high - __CE__B5.__high, num.__low - __CE__B5.__low))), x__6 = __shiftLeft64(den, shift), (x__5.__high > x__6.__high  or  (x__5.__high == x__6.__high  and  x__5.__low > x__6.__low)))) {
			i = d.nd - 1 >> 0;
			while (true) {
				if ( not (i >= 0)) { break; end
				if ((x__7 = d.d, ((i < 0  or  i >= x__7.__length) ? (__throwRuntimeError("index out of range"), nil) : x__7.__array[x__7.__offset + i])) == 57) {
					d.nd = d.nd - (1) >> 0;
				end else {
					break;
				end
				i = i - (1) >> 0;
			end
			if (i < 0) {
				(x__8 = d.d, (0 >= x__8.__length ? (__throwRuntimeError("index out of range"), nil) : x__8.__array[x__8.__offset + 0] = 49));
				d.nd = 1;
				d.dp = d.dp + (1) >> 0;
			end else {
				(x__10 = d.d, ((i < 0  or  i >= x__10.__length) ? (__throwRuntimeError("index out of range"), nil) : x__10.__array[x__10.__offset + i] = ((x__9 = d.d, ((i < 0  or  i >= x__9.__length) ? (__throwRuntimeError("index out of range"), nil) : x__9.__array[x__9.__offset + i])) + (1) << 24 >>> 24)));
			end
			return true;
		end
		return false;
	end;
	extFloat.ptr.prototype.ShortestDecimal = function(r)
		var _q, _tmp, _tmp__1, _tmp__2, _tmp__3, allowance, buf, currentDiff, d, digit, digit__1, exp10, f, fraction, i, i__1, i__2, integer, integerDigits, lower, multiplier, n, nd, pow, pow__1, shift, targetDiff, upper, v, v1, x, x__1, x__10, x__11, x__12, x__13, x__14, x__15, x__16, x__17, x__18, x__19, x__2, x__20, x__21, x__22, x__23, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		f = this;
		if ((x = f.mant, (x.__high == 0  and  x.__low == 0))) {
			d.nd = 0;
			d.dp = 0;
			d.neg = f.neg;
			return true;
		end
		if ((f.exp == 0)  and  __equal(lower, f, extFloat)  and  __equal(lower, upper, extFloat)) {
			buf = arrayType__1.zero();
			n = 23;
			v = f.mant;
			while (true) {
				if ( not ((v.__high > 0  or  (v.__high == 0  and  v.__low > 0)))) { break; end
				v1 = __div64(v, new __Uint64(0, 10), false);
				v = (x__1 = __mul64(new __Uint64(0, 10), v1), new __Uint64(v.__high - x__1.__high, v.__low - x__1.__low));
				((n < 0  or  n >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[n] = ((new __Uint64(v.__high + 0, v.__low + 48).__low << 24 >>> 24)));
				n = n - (1) >> 0;
				v = v1;
			end
			nd = (24 - n >> 0) - 1 >> 0;
			i = 0;
			while (true) {
				if ( not (i < nd)) { break; end
				(x__3 = d.d, ((i < 0  or  i >= x__3.__length) ? (__throwRuntimeError("index out of range"), nil) : x__3.__array[x__3.__offset + i] = (x__2 = (n + 1 >> 0) + i >> 0, ((x__2 < 0  or  x__2 >= buf.length) ? (__throwRuntimeError("index out of range"), nil) : buf[x__2]))));
				i = i + (1) >> 0;
			end
			_tmp = nd;
			_tmp__1 = nd;
			d.nd = _tmp;
			d.dp = _tmp__1;
			while (true) {
				if ( not (d.nd > 0  and  ((x__4 = d.d, x__5 = d.nd - 1 >> 0, ((x__5 < 0  or  x__5 >= x__4.__length) ? (__throwRuntimeError("index out of range"), nil) : x__4.__array[x__4.__offset + x__5])) == 48))) { break; end
				d.nd = d.nd - (1) >> 0;
			end
			if (d.nd == 0) {
				d.dp = 0;
			end
			d.neg = f.neg;
			return true;
		end
		upper.Normalize();
		if (f.exp > upper.exp) {
			f.mant = __shiftLeft64(f.mant, ((((f.exp - upper.exp >> 0) >>> 0))));
			f.exp = upper.exp;
		end
		if (lower.exp > upper.exp) {
			lower.mant = __shiftLeft64(lower.mant, ((((lower.exp - upper.exp >> 0) >>> 0))));
			lower.exp = upper.exp;
		end
		exp10 = frexp10Many(lower, f, upper);
		upper.mant = (x__6 = upper.mant, x__7 = new __Uint64(0, 1), new __Uint64(x__6.__high + x__7.__high, x__6.__low + x__7.__low));
		lower.mant = (x__8 = lower.mant, x__9 = new __Uint64(0, 1), new __Uint64(x__8.__high - x__9.__high, x__8.__low - x__9.__low));
		shift = ((-upper.exp >>> 0));
		integer = ((__shiftRightUint64(upper.mant, shift).__low >>> 0));
		fraction = (x__10 = upper.mant, x__11 = __shiftLeft64((new __Uint64(0, integer)), shift), new __Uint64(x__10.__high - x__11.__high, x__10.__low - x__11.__low));
		allowance = (x__12 = upper.mant, x__13 = lower.mant, new __Uint64(x__12.__high - x__13.__high, x__12.__low - x__13.__low));
		targetDiff = (x__14 = upper.mant, x__15 = f.mant, new __Uint64(x__14.__high - x__15.__high, x__14.__low - x__15.__low));
		integerDigits = 0;
		_tmp__2 = 0;
		_tmp__3 = new __Uint64(0, 1);
		i__1 = _tmp__2;
		pow = _tmp__3;
		while (true) {
			if ( not (i__1 < 20)) { break; end
			if ((x__16 = (new __Uint64(0, integer)), (pow.__high > x__16.__high  or  (pow.__high == x__16.__high  and  pow.__low > x__16.__low)))) {
				integerDigits = i__1;
				break;
			end
			pow = __mul64(pow, (new __Uint64(0, 10)));
			i__1 = i__1 + (1) >> 0;
		end
		i__2 = 0;
		while (true) {
			if ( not (i__2 < integerDigits)) { break; end
			pow__1 = (x__17 = (integerDigits - i__2 >> 0) - 1 >> 0, ((x__17 < 0  or  x__17 >= uint64pow10.length) ? (__throwRuntimeError("index out of range"), nil) : uint64pow10[x__17]));
			digit = (_q = integer / ((pow__1.__low >>> 0)), (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >>> 0 : __throwRuntimeError("integer divide by zero"));
			(x__18 = d.d, ((i__2 < 0  or  i__2 >= x__18.__length) ? (__throwRuntimeError("index out of range"), nil) : x__18.__array[x__18.__offset + i__2] = (((digit + 48 >>> 0) << 24 >>> 24))));
			integer = integer - ((__imul(digit, ((pow__1.__low >>> 0))) >>> 0)) >>> 0;
			currentDiff = (x__19 = __shiftLeft64((new __Uint64(0, integer)), shift), new __Uint64(x__19.__high + fraction.__high, x__19.__low + fraction.__low));
			if ((currentDiff.__high < allowance.__high  or  (currentDiff.__high == allowance.__high  and  currentDiff.__low < allowance.__low))) {
				d.nd = i__2 + 1 >> 0;
				d.dp = integerDigits + exp10 >> 0;
				d.neg = f.neg;
				return adjustLastDigit(d, currentDiff, targetDiff, allowance, __shiftLeft64(pow__1, shift), new __Uint64(0, 2));
			end
			i__2 = i__2 + (1) >> 0;
		end
		d.nd = integerDigits;
		d.dp = d.nd + exp10 >> 0;
		d.neg = f.neg;
		digit__1 = 0;
		multiplier = new __Uint64(0, 1);
		while (true) {
			fraction = __mul64(fraction, (new __Uint64(0, 10)));
			multiplier = __mul64(multiplier, (new __Uint64(0, 10)));
			digit__1 = ((__shiftRightUint64(fraction, shift).__low >> 0));
			(x__20 = d.d, x__21 = d.nd, ((x__21 < 0  or  x__21 >= x__20.__length) ? (__throwRuntimeError("index out of range"), nil) : x__20.__array[x__20.__offset + x__21] = (((digit__1 + 48 >> 0) << 24 >>> 24))));
			d.nd = d.nd + (1) >> 0;
			fraction = (x__22 = __shiftLeft64((new __Uint64(0, digit__1)), shift), new __Uint64(fraction.__high - x__22.__high, fraction.__low - x__22.__low));
			if ((x__23 = __mul64(allowance, multiplier), (fraction.__high < x__23.__high  or  (fraction.__high == x__23.__high  and  fraction.__low < x__23.__low)))) {
				return adjustLastDigit(d, fraction, __mul64(targetDiff, multiplier), __mul64(allowance, multiplier), __shiftLeft64(new __Uint64(0, 1), shift), __mul64(multiplier, new __Uint64(0, 2)));
			end
		end
	end;
	extFloat.prototype.ShortestDecimal = function(r) return this.__val.ShortestDecimal(d, lower, upper); end;
	adjustLastDigit = function(y)
		var _index, currentDiff, d, maxDiff, targetDiff, ulpBinary, ulpDecimal, x, x__1, x__10, x__11, x__12, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9;
		if ((x = __mul64(new __Uint64(0, 2), ulpBinary), (ulpDecimal.__high < x.__high  or  (ulpDecimal.__high == x.__high  and  ulpDecimal.__low < x.__low)))) {
			return false;
		end
		while (true) {
			if ( not ((x__1 = (x__2 = (x__3 = __div64(ulpDecimal, new __Uint64(0, 2), false), new __Uint64(currentDiff.__high + x__3.__high, currentDiff.__low + x__3.__low)), new __Uint64(x__2.__high + ulpBinary.__high, x__2.__low + ulpBinary.__low)), (x__1.__high < targetDiff.__high  or  (x__1.__high == targetDiff.__high  and  x__1.__low < targetDiff.__low))))) { break; end
			_index = d.nd - 1 >> 0;
			(x__5 = d.d, ((_index < 0  or  _index >= x__5.__length) ? (__throwRuntimeError("index out of range"), nil) : x__5.__array[x__5.__offset + _index] = ((x__4 = d.d, ((_index < 0  or  _index >= x__4.__length) ? (__throwRuntimeError("index out of range"), nil) : x__4.__array[x__4.__offset + _index])) - (1) << 24 >>> 24)));
			currentDiff = (x__6 = ulpDecimal, new __Uint64(currentDiff.__high + x__6.__high, currentDiff.__low + x__6.__low));
		end
		if ((x__7 = new __Uint64(currentDiff.__high + ulpDecimal.__high, currentDiff.__low + ulpDecimal.__low), x__8 = (x__9 = (x__10 = __div64(ulpDecimal, new __Uint64(0, 2), false), new __Uint64(targetDiff.__high + x__10.__high, targetDiff.__low + x__10.__low)), new __Uint64(x__9.__high + ulpBinary.__high, x__9.__low + ulpBinary.__low)), (x__7.__high < x__8.__high  or  (x__7.__high == x__8.__high  and  x__7.__low <= x__8.__low)))) {
			return false;
		end
		if ((currentDiff.__high < ulpBinary.__high  or  (currentDiff.__high == ulpBinary.__high  and  currentDiff.__low < ulpBinary.__low))  or  (x__11 = new __Uint64(maxDiff.__high - ulpBinary.__high, maxDiff.__low - ulpBinary.__low), (currentDiff.__high > x__11.__high  or  (currentDiff.__high == x__11.__high  and  currentDiff.__low > x__11.__low)))) {
			return false;
		end
		if ((d.nd == 1)  and  ((x__12 = d.d, (0 >= x__12.__length ? (__throwRuntimeError("index out of range"), nil) : x__12.__array[x__12.__offset + 0])) == 48)) {
			d.nd = 0;
			d.dp = 0;
		end
		return true;
	end;
	AppendFloat = function(e)
		var bitSize, dst, f, fmt, prec;
		return genericFtoa(dst, f, fmt, prec, bitSize);
	end;
	__pkg.AppendFloat = AppendFloat;
	genericFtoa = function(e)
		var _1, _2, _3, _4, _tuple, bitSize, bits, buf, buf__1, digits, digs, dst, exp, f, f__1, flt, fmt, lower, mant, neg, ok, prec, s, shortest, upper, val, x, x__1, x__2, x__3, y, y__1;
		bits = new __Uint64(0, 0);
		flt = ptrType__1.nil;
		_1 = bitSize;
		if (_1 == (32)) {
			bits = (new __Uint64(0, math.Float32bits((__fround(val)))));
			flt = float32info;
		end else if (_1 == (64)) {
			bits = math.Float64bits(val);
			flt = float64info;
		end else {
			__panic(new __String("strconv: illegal AppendFloat/FormatFloat bitSize"));
		end
		neg =  not ((x = __shiftRightUint64(bits, ((flt.expbits + flt.mantbits >>> 0))), (x.__high == 0  and  x.__low == 0)));
		exp = ((__shiftRightUint64(bits, flt.mantbits).__low >> 0)) & ((((y = flt.expbits, y < 32 ? (1 << y) : 0) >> 0) - 1 >> 0));
		mant = (x__1 = (x__2 = __shiftLeft64(new __Uint64(0, 1), flt.mantbits), new __Uint64(x__2.__high - 0, x__2.__low - 1)), new __Uint64(bits.__high & x__1.__high, (bits.__low & x__1.__low) >>> 0));
		_2 = exp;
		if (_2 == ((((y__1 = flt.expbits, y__1 < 32 ? (1 << y__1) : 0) >> 0) - 1 >> 0))) {
			s = "";
			if ( not ((mant.__high == 0  and  mant.__low == 0))) {
				s = "NaN";
			end else if (neg) {
				s = "-Inf";
			end else {
				s = "+Inf";
			end
			return __appendSlice(dst, s);
		end else if (_2 == (0)) {
			exp = exp + (1) >> 0;
		end else {
			mant = (x__3 = __shiftLeft64(new __Uint64(0, 1), flt.mantbits), new __Uint64(mant.__high | x__3.__high, (mant.__low | x__3.__low) >>> 0));
		end
		exp = exp + (flt.bias) >> 0;
		if (fmt == 98) {
			return fmtB(dst, neg, mant, exp, flt);
		end
		if ( not optimize) {
			return bigFtoa(dst, prec, fmt, neg, mant, exp, flt);
		end
		digs = new decimalSlice.ptr(sliceType__6.nil, 0, 0, false);
		ok = false;
		shortest = prec < 0;
		if (shortest) {
			f = new extFloat.ptr(new __Uint64(0, 0), 0, false);
			_tuple = f.AssignComputeBounds(mant, exp, neg, flt);
			lower = __clone(_tuple[0], extFloat);
			upper = __clone(_tuple[1], extFloat);
			buf = arrayType__2.zero();
			digs.d = new sliceType__6(buf);
			ok = f.ShortestDecimal(digs, lower, upper);
			if ( not ok) {
				return bigFtoa(dst, prec, fmt, neg, mant, exp, flt);
			end
			_3 = fmt;
			if ((_3 == (101))  or  (_3 == (69))) {
				prec = max(digs.nd - 1 >> 0, 0);
			end else if (_3 == (102)) {
				prec = max(digs.nd - digs.dp >> 0, 0);
			end else if ((_3 == (103))  or  (_3 == (71))) {
				prec = digs.nd;
			end
		end else if ( not ((fmt == 102))) {
			digits = prec;
			_4 = fmt;
			if ((_4 == (101))  or  (_4 == (69))) {
				digits = digits + (1) >> 0;
			end else if ((_4 == (103))  or  (_4 == (71))) {
				if (prec == 0) {
					prec = 1;
				end
				digits = prec;
			end
			if (digits <= 15) {
				buf__1 = arrayType__1.zero();
				digs.d = new sliceType__6(buf__1);
				f__1 = new extFloat.ptr(mant, exp - ((flt.mantbits >> 0)) >> 0, neg);
				ok = f__1.FixedDecimal(digs, digits);
			end
		end
		if ( not ok) {
			return bigFtoa(dst, prec, fmt, neg, mant, exp, flt);
		end
		return formatDigits(dst, shortest, neg, __clone(digs, decimalSlice), prec, fmt);
	end;
	bigFtoa = function(t)
		var _1, _2, d, digs, dst, exp, flt, fmt, mant, neg, prec, shortest;
		d = new decimal.ptr(arrayType.zero(), 0, 0, false, false);
		d.Assign(mant);
		d.Shift(exp - ((flt.mantbits >> 0)) >> 0);
		digs = new decimalSlice.ptr(sliceType__6.nil, 0, 0, false);
		shortest = prec < 0;
		if (shortest) {
			roundShortest(d, mant, exp, flt);
			decimalSlice.copy(digs, new decimalSlice.ptr(new sliceType__6(d.d), d.nd, d.dp, false));
			_1 = fmt;
			if ((_1 == (101))  or  (_1 == (69))) {
				prec = digs.nd - 1 >> 0;
			end else if (_1 == (102)) {
				prec = max(digs.nd - digs.dp >> 0, 0);
			end else if ((_1 == (103))  or  (_1 == (71))) {
				prec = digs.nd;
			end
		end else {
			_2 = fmt;
			if ((_2 == (101))  or  (_2 == (69))) {
				d.Round(prec + 1 >> 0);
			end else if (_2 == (102)) {
				d.Round(d.dp + prec >> 0);
			end else if ((_2 == (103))  or  (_2 == (71))) {
				if (prec == 0) {
					prec = 1;
				end
				d.Round(prec);
			end
			decimalSlice.copy(digs, new decimalSlice.ptr(new sliceType__6(d.d), d.nd, d.dp, false));
		end
		return formatDigits(dst, shortest, neg, __clone(digs, decimalSlice), prec, fmt);
	end;
	formatDigits = function(t)
		var _1, digs, dst, eprec, exp, fmt, neg, prec, shortest;
		_1 = fmt;
		if ((_1 == (101))  or  (_1 == (69))) {
			return fmtE(dst, neg, __clone(digs, decimalSlice), prec, fmt);
		end else if (_1 == (102)) {
			return fmtF(dst, neg, __clone(digs, decimalSlice), prec);
		end else if ((_1 == (103))  or  (_1 == (71))) {
			eprec = prec;
			if (eprec > digs.nd  and  digs.nd >= digs.dp) {
				eprec = digs.nd;
			end
			if (shortest) {
				eprec = 6;
			end
			exp = digs.dp - 1 >> 0;
			if (exp < -4  or  exp >= eprec) {
				if (prec > digs.nd) {
					prec = digs.nd;
				end
				return fmtE(dst, neg, __clone(digs, decimalSlice), prec - 1 >> 0, (fmt + 101 << 24 >>> 24) - 103 << 24 >>> 24);
			end
			if (prec > digs.dp) {
				prec = digs.nd;
			end
			return fmtF(dst, neg, __clone(digs, decimalSlice), max(prec - digs.dp >> 0, 0));
		end
		return __append(dst, 37, fmt);
	end;
	roundShortest = function(t)
		var d, exp, explo, flt, i, inclusive, l, lower, m, mant, mantlo, minexp, okdown, okup, u, upper, x, x__1, x__2, x__3, x__4, x__5, x__6, x__7;
		if ((mant.__high == 0  and  mant.__low == 0)) {
			d.nd = 0;
			return;
		end
		minexp = flt.bias + 1 >> 0;
		if (exp > minexp  and  (__imul(332, ((d.dp - d.nd >> 0)))) >= (__imul(100, ((exp - ((flt.mantbits >> 0)) >> 0))))) {
			return;
		end
		upper = new decimal.ptr(arrayType.zero(), 0, 0, false, false);
		upper.Assign((x = __mul64(mant, new __Uint64(0, 2)), new __Uint64(x.__high + 0, x.__low + 1)));
		upper.Shift((exp - ((flt.mantbits >> 0)) >> 0) - 1 >> 0);
		mantlo = new __Uint64(0, 0);
		explo = 0;
		if ((x__1 = __shiftLeft64(new __Uint64(0, 1), flt.mantbits), (mant.__high > x__1.__high  or  (mant.__high == x__1.__high  and  mant.__low > x__1.__low)))  or  (exp == minexp)) {
			mantlo = new __Uint64(mant.__high - 0, mant.__low - 1);
			explo = exp;
		end else {
			mantlo = (x__2 = __mul64(mant, new __Uint64(0, 2)), new __Uint64(x__2.__high - 0, x__2.__low - 1));
			explo = exp - 1 >> 0;
		end
		lower = new decimal.ptr(arrayType.zero(), 0, 0, false, false);
		lower.Assign((x__3 = __mul64(mantlo, new __Uint64(0, 2)), new __Uint64(x__3.__high + 0, x__3.__low + 1)));
		lower.Shift((explo - ((flt.mantbits >> 0)) >> 0) - 1 >> 0);
		inclusive = (x__4 = __div64(mant, new __Uint64(0, 2), true), (x__4.__high == 0  and  x__4.__low == 0));
		i = 0;
		while (true) {
			if ( not (i < d.nd)) { break; end
			l = 48;
			if (i < lower.nd) {
				l = (x__5 = lower.d, ((i < 0  or  i >= x__5.length) ? (__throwRuntimeError("index out of range"), nil) : x__5[i]));
			end
			m = (x__6 = d.d, ((i < 0  or  i >= x__6.length) ? (__throwRuntimeError("index out of range"), nil) : x__6[i]));
			u = 48;
			if (i < upper.nd) {
				u = (x__7 = upper.d, ((i < 0  or  i >= x__7.length) ? (__throwRuntimeError("index out of range"), nil) : x__7[i]));
			end
			okdown =  not ((l == m))  or  inclusive  and  ((i + 1 >> 0) == lower.nd);
			okup =  not ((m == u))  and  (inclusive  or  (m + 1 << 24 >>> 24) < u  or  (i + 1 >> 0) < upper.nd);
			if (okdown  and  okup) {
				d.Round(i + 1 >> 0);
				return;
			end else if (okdown) {
				d.RoundDown(i + 1 >> 0);
				return;
			end else if (okup) {
				d.RoundUp(i + 1 >> 0);
				return;
			end
			i = i + (1) >> 0;
		end
	end;
	fmtE = function(t)
		var _q, _q__1, _q__2, _r, _r__1, _r__2, ch, d, dst, exp, fmt, i, m, neg, prec, x;
		if (neg) {
			dst = __append(dst, 45);
		end
		ch = 48;
		if ( not ((d.nd == 0))) {
			ch = (x = d.d, (0 >= x.__length ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + 0]));
		end
		dst = __append(dst, ch);
		if (prec > 0) {
			dst = __append(dst, 46);
			i = 1;
			m = min(d.nd, prec + 1 >> 0);
			if (i < m) {
				dst = __appendSlice(dst, __subslice(d.d, i, m));
				i = m;
			end
			while (true) {
				if ( not (i <= prec)) { break; end
				dst = __append(dst, 48);
				i = i + (1) >> 0;
			end
		end
		dst = __append(dst, fmt);
		exp = d.dp - 1 >> 0;
		if (d.nd == 0) {
			exp = 0;
		end
		if (exp < 0) {
			ch = 45;
			exp = -exp;
		end else {
			ch = 43;
		end
		dst = __append(dst, ch);
		if (exp < 10) {
			dst = __append(dst, 48, ((exp << 24 >>> 24)) + 48 << 24 >>> 24);
		end else if (exp < 100) {
			dst = __append(dst, (((_q = exp / 10, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) << 24 >>> 24)) + 48 << 24 >>> 24, (((_r = exp % 10, _r == _r ? _r : __throwRuntimeError("integer divide by zero")) << 24 >>> 24)) + 48 << 24 >>> 24);
		end else {
			dst = __append(dst, (((_q__1 = exp / 100, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >> 0 : __throwRuntimeError("integer divide by zero")) << 24 >>> 24)) + 48 << 24 >>> 24, (_r__1 = (((_q__2 = exp / 10, (_q__2 == _q__2  and  _q__2 ~= 1/0  and  _q__2 ~= -1/0) ? _q__2 >> 0 : __throwRuntimeError("integer divide by zero")) << 24 >>> 24)) % 10, _r__1 == _r__1 ? _r__1 : __throwRuntimeError("integer divide by zero")) + 48 << 24 >>> 24, (((_r__2 = exp % 10, _r__2 == _r__2 ? _r__2 : __throwRuntimeError("integer divide by zero")) << 24 >>> 24)) + 48 << 24 >>> 24);
		end
		return dst;
	end;
	fmtF = function(c)
		var ch, d, dst, i, j, m, neg, prec, x;
		if (neg) {
			dst = __append(dst, 45);
		end
		if (d.dp > 0) {
			m = min(d.nd, d.dp);
			dst = __appendSlice(dst, __subslice(d.d, 0, m));
			while (true) {
				if ( not (m < d.dp)) { break; end
				dst = __append(dst, 48);
				m = m + (1) >> 0;
			end
		end else {
			dst = __append(dst, 48);
		end
		if (prec > 0) {
			dst = __append(dst, 46);
			i = 0;
			while (true) {
				if ( not (i < prec)) { break; end
				ch = 48;
				j = d.dp + i >> 0;
				if (0 <= j  and  j < d.nd) {
					ch = (x = d.d, ((j < 0  or  j >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + j]));
				end
				dst = __append(dst, ch);
				i = i + (1) >> 0;
			end
		end
		return dst;
	end;
	fmtB = function(t)
		var _tuple, _tuple__1, dst, exp, flt, mant, neg;
		if (neg) {
			dst = __append(dst, 45);
		end
		_tuple = formatBits(dst, mant, 10, false, true);
		dst = _tuple[0];
		dst = __append(dst, 112);
		exp = exp - (((flt.mantbits >> 0))) >> 0;
		if (exp >= 0) {
			dst = __append(dst, 43);
		end
		_tuple__1 = formatBits(dst, (new __Uint64(0, exp)), 10, exp < 0, true);
		dst = _tuple__1[0];
		return dst;
	end;
	min = function(b)
		var a, b;
		if (a < b) {
			return a;
		end
		return b;
	end;
	max = function(b)
		var a, b;
		if (a > b) {
			return a;
		end
		return b;
	end;
	FormatInt = function(e)
		var _tuple, base, i, s;
		if (true  and  (0 < i.__high  or  (0 == i.__high  and  0 <= i.__low))  and  (i.__high < 0  or  (i.__high == 0  and  i.__low < 100))  and  (base == 10)) {
			return small((((i.__low + ((i.__high >> 31) * 4294967296)) >> 0)));
		end
		_tuple = formatBits(sliceType__6.nil, (new __Uint64(i.__high, i.__low)), base, (i.__high < 0  or  (i.__high == 0  and  i.__low < 0)), false);
		s = _tuple[1];
		return s;
	end;
	__pkg.FormatInt = FormatInt;
	Itoa = function(i)
		var i;
		return FormatInt((new __Int64(0, i)), 10);
	end;
	__pkg.Itoa = Itoa;
	small = function(i)
		var i, off;
		off = 0;
		if (i < 10) {
			off = 1;
		end
		return __substring("00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899", ((__imul(i, 2)) + off >> 0), ((__imul(i, 2)) + 2 >> 0));
	end;
	formatBits = function(_)
		var _q, _q__1, _r, _r__1, a, append_, b, b__1, base, d, dst, i, is, is__1, is__2, j, m, neg, q, q__1, s, s__1, u, us, us__1, x, x__1, x__2, x__3, x__4, x__5;
		d = sliceType__6.nil;
		s = "";
		if (base < 2  or  base > 36) {
			__panic(new __String("strconv: illegal AppendInt/FormatInt base"));
		end
		a = arrayType__3.zero();
		i = 65;
		if (neg) {
			u = new __Uint64(-u.__high, -u.__low);
		end
		if (base == 10) {
			if (true) {
				while (true) {
					if ( not ((u.__high > 0  or  (u.__high == 0  and  u.__low >= 1000000000)))) { break; end
					q = __div64(u, new __Uint64(0, 1000000000), false);
					us = (((x = __mul64(q, new __Uint64(0, 1000000000)), new __Uint64(u.__high - x.__high, u.__low - x.__low)).__low >>> 0));
					j = 4;
					while (true) {
						if ( not (j > 0)) { break; end
						is = (_r = us % 100, _r == _r ? _r : __throwRuntimeError("integer divide by zero")) * 2 >>> 0;
						us = (_q = us / (100), (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >>> 0 : __throwRuntimeError("integer divide by zero"));
						i = i - (2) >> 0;
						(x__1 = i + 1 >> 0, ((x__1 < 0  or  x__1 >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[x__1] = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899".charCodeAt((is + 1 >>> 0))));
						(x__2 = i + 0 >> 0, ((x__2 < 0  or  x__2 >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[x__2] = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899".charCodeAt((is + 0 >>> 0))));
						j = j - (1) >> 0;
					end
					i = i - (1) >> 0;
					((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899".charCodeAt(((us * 2 >>> 0) + 1 >>> 0)));
					u = q;
				end
			end
			us__1 = ((u.__low >>> 0));
			while (true) {
				if ( not (us__1 >= 100)) { break; end
				is__1 = (_r__1 = us__1 % 100, _r__1 == _r__1 ? _r__1 : __throwRuntimeError("integer divide by zero")) * 2 >>> 0;
				us__1 = (_q__1 = us__1 / (100), (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >>> 0 : __throwRuntimeError("integer divide by zero"));
				i = i - (2) >> 0;
				(x__3 = i + 1 >> 0, ((x__3 < 0  or  x__3 >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[x__3] = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899".charCodeAt((is__1 + 1 >>> 0))));
				(x__4 = i + 0 >> 0, ((x__4 < 0  or  x__4 >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[x__4] = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899".charCodeAt((is__1 + 0 >>> 0))));
			end
			is__2 = us__1 * 2 >>> 0;
			i = i - (1) >> 0;
			((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899".charCodeAt((is__2 + 1 >>> 0)));
			if (us__1 >= 10) {
				i = i - (1) >> 0;
				((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899".charCodeAt(is__2));
			end
		end else {
			s__1 = ((base < 0  or  base >= shifts.length) ? (__throwRuntimeError("index out of range"), nil) : shifts[base]);
			if (s__1 > 0) {
				b = (new __Uint64(0, base));
				m = ((base >>> 0)) - 1 >>> 0;
				while (true) {
					if ( not ((u.__high > b.__high  or  (u.__high == b.__high  and  u.__low >= b.__low)))) { break; end
					i = i - (1) >> 0;
					((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = "0123456789abcdefghijklmnopqrstuvwxyz".charCodeAt(((((u.__low >>> 0)) & m) >>> 0)));
					u = __shiftRightUint64(u, (s__1));
				end
				i = i - (1) >> 0;
				((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = "0123456789abcdefghijklmnopqrstuvwxyz".charCodeAt(((u.__low >>> 0))));
			end else {
				b__1 = (new __Uint64(0, base));
				while (true) {
					if ( not ((u.__high > b__1.__high  or  (u.__high == b__1.__high  and  u.__low >= b__1.__low)))) { break; end
					i = i - (1) >> 0;
					q__1 = __div64(u, b__1, false);
					((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = "0123456789abcdefghijklmnopqrstuvwxyz".charCodeAt((((x__5 = __mul64(q__1, b__1), new __Uint64(u.__high - x__5.__high, u.__low - x__5.__low)).__low >>> 0))));
					u = q__1;
				end
				i = i - (1) >> 0;
				((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = "0123456789abcdefghijklmnopqrstuvwxyz".charCodeAt(((u.__low >>> 0))));
			end
		end
		if (neg) {
			i = i - (1) >> 0;
			((i < 0  or  i >= a.length) ? (__throwRuntimeError("index out of range"), nil) : a[i] = 45);
		end
		if (append_) {
			d = __appendSlice(dst, __subslice(new sliceType__6(a), i));
			return [d, s];
		end
		s = (__bytesToString(__subslice(new sliceType__6(a), i)));
		return [d, s];
	end;
	appendQuotedWith = function(y)
		var ASCIIonly, _tuple, buf, graphicOnly, quote, r, s, width;
		buf = __append(buf, quote);
		width = 0;
		while (true) {
			if ( not (s.length > 0)) { break; end
			r = ((s.charCodeAt(0) >> 0));
			width = 1;
			if (r >= 128) {
				_tuple = utf8.DecodeRuneInString(s);
				r = _tuple[0];
				width = _tuple[1];
			end
			if ((width == 1)  and  (r == 65533)) {
				buf = __appendSlice(buf, "\\x");
				buf = __append(buf, "0123456789abcdef".charCodeAt((s.charCodeAt(0) >>> 4 << 24 >>> 24)));
				buf = __append(buf, "0123456789abcdef".charCodeAt(((s.charCodeAt(0) & 15) >>> 0)));
				s = __substring(s, width);
				continue;
			end
			buf = appendEscapedRune(buf, r, quote, ASCIIonly, graphicOnly);
			s = __substring(s, width);
		end
		buf = __append(buf, quote);
		return buf;
	end;
	appendQuotedRuneWith = function(y)
		var ASCIIonly, buf, graphicOnly, quote, r;
		buf = __append(buf, quote);
		if ( not utf8.ValidRune(r)) {
			r = 65533;
		end
		buf = appendEscapedRune(buf, r, quote, ASCIIonly, graphicOnly);
		buf = __append(buf, quote);
		return buf;
	end;
	appendEscapedRune = function(y)
		var ASCIIonly, _1, buf, graphicOnly, n, quote, r, runeTmp, s, s__1;
		runeTmp = arrayType__4.zero();
		if ((r == ((quote >> 0)))  or  (r == 92)) {
			buf = __append(buf, 92);
			buf = __append(buf, ((r << 24 >>> 24)));
			return buf;
		end
		if (ASCIIonly) {
			if (r < 128  and  IsPrint(r)) {
				buf = __append(buf, ((r << 24 >>> 24)));
				return buf;
			end
		end else if (IsPrint(r)  or  graphicOnly  and  isInGraphicList(r)) {
			n = utf8.EncodeRune(new sliceType__6(runeTmp), r);
			buf = __appendSlice(buf, __subslice(new sliceType__6(runeTmp), 0, n));
			return buf;
		end
		_1 = r;
		if (_1 == (7)) {
			buf = __appendSlice(buf, "\\a");
		end else if (_1 == (8)) {
			buf = __appendSlice(buf, "\\b");
		end else if (_1 == (12)) {
			buf = __appendSlice(buf, "\\f");
		end else if (_1 == (10)) {
			buf = __appendSlice(buf, "\\n");
		end else if (_1 == (13)) {
			buf = __appendSlice(buf, "\\r");
		end else if (_1 == (9)) {
			buf = __appendSlice(buf, "\\t");
		end else if (_1 == (11)) {
			buf = __appendSlice(buf, "\\v");
		end else {
			if (r < 32) {
				buf = __appendSlice(buf, "\\x");
				buf = __append(buf, "0123456789abcdef".charCodeAt((((r << 24 >>> 24)) >>> 4 << 24 >>> 24)));
				buf = __append(buf, "0123456789abcdef".charCodeAt(((((r << 24 >>> 24)) & 15) >>> 0)));
			end else if (r > 1114111) {
				r = 65533;
				buf = __appendSlice(buf, "\\u");
				s = 12;
				while (true) {
					if ( not (s >= 0)) { break; end
					buf = __append(buf, "0123456789abcdef".charCodeAt((((r >> __min(((s >>> 0)), 31)) >> 0) & 15)));
					s = s - (4) >> 0;
				end
			end else if (r < 65536) {
				buf = __appendSlice(buf, "\\u");
				s = 12;
				while (true) {
					if ( not (s >= 0)) { break; end
					buf = __append(buf, "0123456789abcdef".charCodeAt((((r >> __min(((s >>> 0)), 31)) >> 0) & 15)));
					s = s - (4) >> 0;
				end
			end else {
				buf = __appendSlice(buf, "\\U");
				s__1 = 28;
				while (true) {
					if ( not (s__1 >= 0)) { break; end
					buf = __append(buf, "0123456789abcdef".charCodeAt((((r >> __min(((s__1 >>> 0)), 31)) >> 0) & 15)));
					s__1 = s__1 - (4) >> 0;
				end
			end
		end
		return buf;
	end;
	AppendQuote = function(s)
		var dst, s;
		return appendQuotedWith(dst, s, 34, false, false);
	end;
	__pkg.AppendQuote = AppendQuote;
	AppendQuoteToASCII = function(s)
		var dst, s;
		return appendQuotedWith(dst, s, 34, true, false);
	end;
	__pkg.AppendQuoteToASCII = AppendQuoteToASCII;
	AppendQuoteRune = function(r)
		var dst, r;
		return appendQuotedRuneWith(dst, r, 39, false, false);
	end;
	__pkg.AppendQuoteRune = AppendQuoteRune;
	AppendQuoteRuneToASCII = function(r)
		var dst, r;
		return appendQuotedRuneWith(dst, r, 39, true, false);
	end;
	__pkg.AppendQuoteRuneToASCII = AppendQuoteRuneToASCII;
	CanBackquote = function(s)
		var _tuple, r, s, wid;
		while (true) {
			if ( not (s.length > 0)) { break; end
			_tuple = utf8.DecodeRuneInString(s);
			r = _tuple[0];
			wid = _tuple[1];
			s = __substring(s, wid);
			if (wid > 1) {
				if (r == 65279) {
					return false;
				end
				continue;
			end
			if (r == 65533) {
				return false;
			end
			if ((r < 32  and   not ((r == 9)))  or  (r == 96)  or  (r == 127)) {
				return false;
			end
		end
		return true;
	end;
	__pkg.CanBackquote = CanBackquote;
	unhex = function(b)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, b, c, ok, v;
		v = 0;
		ok = false;
		c = ((b >> 0));
		if (48 <= c  and  c <= 57) {
			_tmp = c - 48 >> 0;
			_tmp__1 = true;
			v = _tmp;
			ok = _tmp__1;
			return [v, ok];
		end else if (97 <= c  and  c <= 102) {
			_tmp__2 = (c - 97 >> 0) + 10 >> 0;
			_tmp__3 = true;
			v = _tmp__2;
			ok = _tmp__3;
			return [v, ok];
		end else if (65 <= c  and  c <= 70) {
			_tmp__4 = (c - 65 >> 0) + 10 >> 0;
			_tmp__5 = true;
			v = _tmp__4;
			ok = _tmp__5;
			return [v, ok];
		end
		return [v, ok];
	end;
	UnquoteChar = function(e)
		var _1, _2, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tuple, _tuple__1, c, c__1, err, j, j__1, multibyte, n, ok, quote, r, s, size, tail, v, v__1, value, x, x__1;
		value = 0;
		multibyte = false;
		tail = "";
		err = __ifaceNil;
		c = s.charCodeAt(0);
		if ((c == quote)  and  ((quote == 39)  or  (quote == 34))) {
			err = __pkg.ErrSyntax;
			return [value, multibyte, tail, err];
		end else if (c >= 128) {
			_tuple = utf8.DecodeRuneInString(s);
			r = _tuple[0];
			size = _tuple[1];
			_tmp = r;
			_tmp__1 = true;
			_tmp__2 = __substring(s, size);
			_tmp__3 = __ifaceNil;
			value = _tmp;
			multibyte = _tmp__1;
			tail = _tmp__2;
			err = _tmp__3;
			return [value, multibyte, tail, err];
		end else if ( not ((c == 92))) {
			_tmp__4 = ((s.charCodeAt(0) >> 0));
			_tmp__5 = false;
			_tmp__6 = __substring(s, 1);
			_tmp__7 = __ifaceNil;
			value = _tmp__4;
			multibyte = _tmp__5;
			tail = _tmp__6;
			err = _tmp__7;
			return [value, multibyte, tail, err];
		end
		if (s.length <= 1) {
			err = __pkg.ErrSyntax;
			return [value, multibyte, tail, err];
		end
		c__1 = s.charCodeAt(1);
		s = __substring(s, 2);
		switch (0) { default:
			_1 = c__1;
			if (_1 == (97)) {
				value = 7;
			end else if (_1 == (98)) {
				value = 8;
			end else if (_1 == (102)) {
				value = 12;
			end else if (_1 == (110)) {
				value = 10;
			end else if (_1 == (114)) {
				value = 13;
			end else if (_1 == (116)) {
				value = 9;
			end else if (_1 == (118)) {
				value = 11;
			end else if ((_1 == (120))  or  (_1 == (117))  or  (_1 == (85))) {
				n = 0;
				_2 = c__1;
				if (_2 == (120)) {
					n = 2;
				end else if (_2 == (117)) {
					n = 4;
				end else if (_2 == (85)) {
					n = 8;
				end
				v = 0;
				if (s.length < n) {
					err = __pkg.ErrSyntax;
					return [value, multibyte, tail, err];
				end
				j = 0;
				while (true) {
					if ( not (j < n)) { break; end
					_tuple__1 = unhex(s.charCodeAt(j));
					x = _tuple__1[0];
					ok = _tuple__1[1];
					if ( not ok) {
						err = __pkg.ErrSyntax;
						return [value, multibyte, tail, err];
					end
					v = (v << 4 >> 0) | x;
					j = j + (1) >> 0;
				end
				s = __substring(s, n);
				if (c__1 == 120) {
					value = v;
					break;
				end
				if (v > 1114111) {
					err = __pkg.ErrSyntax;
					return [value, multibyte, tail, err];
				end
				value = v;
				multibyte = true;
			end else if ((_1 == (48))  or  (_1 == (49))  or  (_1 == (50))  or  (_1 == (51))  or  (_1 == (52))  or  (_1 == (53))  or  (_1 == (54))  or  (_1 == (55))) {
				v__1 = ((c__1 >> 0)) - 48 >> 0;
				if (s.length < 2) {
					err = __pkg.ErrSyntax;
					return [value, multibyte, tail, err];
				end
				j__1 = 0;
				while (true) {
					if ( not (j__1 < 2)) { break; end
					x__1 = ((s.charCodeAt(j__1) >> 0)) - 48 >> 0;
					if (x__1 < 0  or  x__1 > 7) {
						err = __pkg.ErrSyntax;
						return [value, multibyte, tail, err];
					end
					v__1 = ((v__1 << 3 >> 0)) | x__1;
					j__1 = j__1 + (1) >> 0;
				end
				s = __substring(s, 2);
				if (v__1 > 255) {
					err = __pkg.ErrSyntax;
					return [value, multibyte, tail, err];
				end
				value = v__1;
			end else if (_1 == (92)) {
				value = 92;
			end else if ((_1 == (39))  or  (_1 == (34))) {
				if ( not ((c__1 == quote))) {
					err = __pkg.ErrSyntax;
					return [value, multibyte, tail, err];
				end
				value = ((c__1 >> 0));
			end else {
				err = __pkg.ErrSyntax;
				return [value, multibyte, tail, err];
			end
		end
		tail = s;
		return [value, multibyte, tail, err];
	end;
	__pkg.UnquoteChar = UnquoteChar;
	Unquote = function(s)
		var _1, _q, _tuple, _tuple__1, buf, buf__1, c, err, i, multibyte, n, n__1, quote, r, runeTmp, s, size, ss;
		n = s.length;
		if (n < 2) {
			return ["", __pkg.ErrSyntax];
		end
		quote = s.charCodeAt(0);
		if ( not ((quote == s.charCodeAt((n - 1 >> 0))))) {
			return ["", __pkg.ErrSyntax];
		end
		s = __substring(s, 1, (n - 1 >> 0));
		if (quote == 96) {
			if (contains(s, 96)) {
				return ["", __pkg.ErrSyntax];
			end
			if (contains(s, 13)) {
				buf = __makeSlice(sliceType__6, 0, (s.length - 1 >> 0));
				i = 0;
				while (true) {
					if ( not (i < s.length)) { break; end
					if ( not ((s.charCodeAt(i) == 13))) {
						buf = __append(buf, s.charCodeAt(i));
					end
					i = i + (1) >> 0;
				end
				return [(__bytesToString(buf)), __ifaceNil];
			end
			return [s, __ifaceNil];
		end
		if ( not ((quote == 34))  and   not ((quote == 39))) {
			return ["", __pkg.ErrSyntax];
		end
		if (contains(s, 10)) {
			return ["", __pkg.ErrSyntax];
		end
		if ( not contains(s, 92)  and   not contains(s, quote)) {
			_1 = quote;
			if (_1 == (34)) {
				return [s, __ifaceNil];
			end else if (_1 == (39)) {
				_tuple = utf8.DecodeRuneInString(s);
				r = _tuple[0];
				size = _tuple[1];
				if ((size == s.length)  and  ( not ((r == 65533))  or   not ((size == 1)))) {
					return [s, __ifaceNil];
				end
			end
		end
		runeTmp = arrayType__4.zero();
		buf__1 = __makeSlice(sliceType__6, 0, (_q = (__imul(3, s.length)) / 2, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")));
		while (true) {
			if ( not (s.length > 0)) { break; end
			_tuple__1 = UnquoteChar(s, quote);
			c = _tuple__1[0];
			multibyte = _tuple__1[1];
			ss = _tuple__1[2];
			err = _tuple__1[3];
			if ( not (__interfaceIsEqual(err, __ifaceNil))) {
				return ["", err];
			end
			s = ss;
			if (c < 128  or   not multibyte) {
				buf__1 = __append(buf__1, ((c << 24 >>> 24)));
			end else {
				n__1 = utf8.EncodeRune(new sliceType__6(runeTmp), c);
				buf__1 = __appendSlice(buf__1, __subslice(new sliceType__6(runeTmp), 0, n__1));
			end
			if ((quote == 39)  and   not ((s.length == 0))) {
				return ["", __pkg.ErrSyntax];
			end
		end
		return [(__bytesToString(buf__1)), __ifaceNil];
	end;
	__pkg.Unquote = Unquote;
	contains = function(c)
		var c, i, s;
		i = 0;
		while (true) {
			if ( not (i < s.length)) { break; end
			if (s.charCodeAt(i) == c) {
				return true;
			end
			i = i + (1) >> 0;
		end
		return false;
	end;
	bsearch16 = function(x)
		var _q, _tmp, _tmp__1, a, h, i, j, x;
		_tmp = 0;
		_tmp__1 = a.__length;
		i = _tmp;
		j = _tmp__1;
		while (true) {
			if ( not (i < j)) { break; end
			h = i + (_q = ((j - i >> 0)) / 2, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) >> 0;
			if (((h < 0  or  h >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + h]) < x) {
				i = h + 1 >> 0;
			end else {
				j = h;
			end
		end
		return i;
	end;
	bsearch32 = function(x)
		var _q, _tmp, _tmp__1, a, h, i, j, x;
		_tmp = 0;
		_tmp__1 = a.__length;
		i = _tmp;
		j = _tmp__1;
		while (true) {
			if ( not (i < j)) { break; end
			h = i + (_q = ((j - i >> 0)) / 2, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")) >> 0;
			if (((h < 0  or  h >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + h]) < x) {
				i = h + 1 >> 0;
			end else {
				j = h;
			end
		end
		return i;
	end;
	IsPrint = function(r)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, i, i__1, isNotPrint, isNotPrint__1, isPrint, isPrint__1, j, j__1, r, rr, rr__1, x, x__1, x__2, x__3;
		if (r <= 255) {
			if (32 <= r  and  r <= 126) {
				return true;
			end
			if (161 <= r  and  r <= 255) {
				return  not ((r == 173));
			end
			return false;
		end
		if (0 <= r  and  r < 65536) {
			_tmp = ((r << 16 >>> 16));
			_tmp__1 = isPrint16;
			_tmp__2 = isNotPrint16;
			rr = _tmp;
			isPrint = _tmp__1;
			isNotPrint = _tmp__2;
			i = bsearch16(isPrint, rr);
			if (i >= isPrint.__length  or  rr < (x = (i & ~1) >> 0, ((x < 0  or  x >= isPrint.__length) ? (__throwRuntimeError("index out of range"), nil) : isPrint.__array[isPrint.__offset + x]))  or  (x__1 = i | 1, ((x__1 < 0  or  x__1 >= isPrint.__length) ? (__throwRuntimeError("index out of range"), nil) : isPrint.__array[isPrint.__offset + x__1])) < rr) {
				return false;
			end
			j = bsearch16(isNotPrint, rr);
			return j >= isNotPrint.__length  or   not ((((j < 0  or  j >= isNotPrint.__length) ? (__throwRuntimeError("index out of range"), nil) : isNotPrint.__array[isNotPrint.__offset + j]) == rr));
		end
		_tmp__3 = ((r >>> 0));
		_tmp__4 = isPrint32;
		_tmp__5 = isNotPrint32;
		rr__1 = _tmp__3;
		isPrint__1 = _tmp__4;
		isNotPrint__1 = _tmp__5;
		i__1 = bsearch32(isPrint__1, rr__1);
		if (i__1 >= isPrint__1.__length  or  rr__1 < (x__2 = (i__1 & ~1) >> 0, ((x__2 < 0  or  x__2 >= isPrint__1.__length) ? (__throwRuntimeError("index out of range"), nil) : isPrint__1.__array[isPrint__1.__offset + x__2]))  or  (x__3 = i__1 | 1, ((x__3 < 0  or  x__3 >= isPrint__1.__length) ? (__throwRuntimeError("index out of range"), nil) : isPrint__1.__array[isPrint__1.__offset + x__3])) < rr__1) {
			return false;
		end
		if (r >= 131072) {
			return true;
		end
		r = r - (65536) >> 0;
		j__1 = bsearch16(isNotPrint__1, ((r << 16 >>> 16)));
		return j__1 >= isNotPrint__1.__length  or   not ((((j__1 < 0  or  j__1 >= isNotPrint__1.__length) ? (__throwRuntimeError("index out of range"), nil) : isNotPrint__1.__array[isNotPrint__1.__offset + j__1]) == ((r << 16 >>> 16))));
	end;
	__pkg.IsPrint = IsPrint;
	isInGraphicList = function(r)
		var i, r, rr;
		if (r > 65535) {
			return false;
		end
		rr = ((r << 16 >>> 16));
		i = bsearch16(isGraphic, rr);
		return i < isGraphic.__length  and  (rr == ((i < 0  or  i >= isGraphic.__length) ? (__throwRuntimeError("index out of range"), nil) : isGraphic.__array[isGraphic.__offset + i]));
	end;
	ptrType__2.methods = [{prop: "set", name: "set", pkg: "strconv", typ: __funcType([__String], [__Bool], false)end, {prop: "floatBits", name: "floatBits", pkg: "strconv", typ: __funcType([ptrType__1], [__Uint64, __Bool], false)end, {prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Assign", name: "Assign", pkg: "", typ: __funcType([__Uint64], [], false)end, {prop: "Shift", name: "Shift", pkg: "", typ: __funcType([__Int], [], false)end, {prop: "Round", name: "Round", pkg: "", typ: __funcType([__Int], [], false)end, {prop: "RoundDown", name: "RoundDown", pkg: "", typ: __funcType([__Int], [], false)end, {prop: "RoundUp", name: "RoundUp", pkg: "", typ: __funcType([__Int], [], false)end, {prop: "RoundedInteger", name: "RoundedInteger", pkg: "", typ: __funcType([], [__Uint64], false)end];
	ptrType__4.methods = [{prop: "floatBits", name: "floatBits", pkg: "strconv", typ: __funcType([ptrType__1], [__Uint64, __Bool], false)end, {prop: "AssignComputeBounds", name: "AssignComputeBounds", pkg: "", typ: __funcType([__Uint64, __Int, __Bool, ptrType__1], [extFloat, extFloat], false)end, {prop: "Normalize", name: "Normalize", pkg: "", typ: __funcType([], [__Uint], false)end, {prop: "Multiply", name: "Multiply", pkg: "", typ: __funcType([extFloat], [], false)end, {prop: "AssignDecimal", name: "AssignDecimal", pkg: "", typ: __funcType([__Uint64, __Int, __Bool, __Bool, ptrType__1], [__Bool], false)end, {prop: "frexp10", name: "frexp10", pkg: "strconv", typ: __funcType([], [__Int, __Int], false)end, {prop: "FixedDecimal", name: "FixedDecimal", pkg: "", typ: __funcType([ptrType__3, __Int], [__Bool], false)end, {prop: "ShortestDecimal", name: "ShortestDecimal", pkg: "", typ: __funcType([ptrType__3, ptrType__4, ptrType__4], [__Bool], false)end];
	decimal.init("strconv", [{prop: "d", name: "d", anonymous: false, exported: false, typ: arrayType, tag: ""end, {prop: "nd", name: "nd", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "dp", name: "dp", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "neg", name: "neg", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "trunc", name: "trunc", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	leftCheat.init("strconv", [{prop: "delta", name: "delta", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "cutoff", name: "cutoff", anonymous: false, exported: false, typ: __String, tag: ""end]);
	extFloat.init("strconv", [{prop: "mant", name: "mant", anonymous: false, exported: false, typ: __Uint64, tag: ""end, {prop: "exp", name: "exp", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "neg", name: "neg", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	floatInfo.init("strconv", [{prop: "mantbits", name: "mantbits", anonymous: false, exported: false, typ: __Uint, tag: ""end, {prop: "expbits", name: "expbits", anonymous: false, exported: false, typ: __Uint, tag: ""end, {prop: "bias", name: "bias", anonymous: false, exported: false, typ: __Int, tag: ""end]);
	decimalSlice.init("strconv", [{prop: "d", name: "d", anonymous: false, exported: false, typ: sliceType__6, tag: ""end, {prop: "nd", name: "nd", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "dp", name: "dp", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "neg", name: "neg", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = math.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = utf8.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		optimize = true;
		__pkg.ErrRange = errors.New("value out of range");
		__pkg.ErrSyntax = errors.New("invalid syntax");
		leftcheats = new sliceType__3([new leftCheat.ptr(0, ""), new leftCheat.ptr(1, "5"), new leftCheat.ptr(1, "25"), new leftCheat.ptr(1, "125"), new leftCheat.ptr(2, "625"), new leftCheat.ptr(2, "3125"), new leftCheat.ptr(2, "15625"), new leftCheat.ptr(3, "78125"), new leftCheat.ptr(3, "390625"), new leftCheat.ptr(3, "1953125"), new leftCheat.ptr(4, "9765625"), new leftCheat.ptr(4, "48828125"), new leftCheat.ptr(4, "244140625"), new leftCheat.ptr(4, "1220703125"), new leftCheat.ptr(5, "6103515625"), new leftCheat.ptr(5, "30517578125"), new leftCheat.ptr(5, "152587890625"), new leftCheat.ptr(6, "762939453125"), new leftCheat.ptr(6, "3814697265625"), new leftCheat.ptr(6, "19073486328125"), new leftCheat.ptr(7, "95367431640625"), new leftCheat.ptr(7, "476837158203125"), new leftCheat.ptr(7, "2384185791015625"), new leftCheat.ptr(7, "11920928955078125"), new leftCheat.ptr(8, "59604644775390625"), new leftCheat.ptr(8, "298023223876953125"), new leftCheat.ptr(8, "1490116119384765625"), new leftCheat.ptr(9, "7450580596923828125"), new leftCheat.ptr(9, "37252902984619140625"), new leftCheat.ptr(9, "186264514923095703125"), new leftCheat.ptr(10, "931322574615478515625"), new leftCheat.ptr(10, "4656612873077392578125"), new leftCheat.ptr(10, "23283064365386962890625"), new leftCheat.ptr(10, "116415321826934814453125"), new leftCheat.ptr(11, "582076609134674072265625"), new leftCheat.ptr(11, "2910383045673370361328125"), new leftCheat.ptr(11, "14551915228366851806640625"), new leftCheat.ptr(12, "72759576141834259033203125"), new leftCheat.ptr(12, "363797880709171295166015625"), new leftCheat.ptr(12, "1818989403545856475830078125"), new leftCheat.ptr(13, "9094947017729282379150390625"), new leftCheat.ptr(13, "45474735088646411895751953125"), new leftCheat.ptr(13, "227373675443232059478759765625"), new leftCheat.ptr(13, "1136868377216160297393798828125"), new leftCheat.ptr(14, "5684341886080801486968994140625"), new leftCheat.ptr(14, "28421709430404007434844970703125"), new leftCheat.ptr(14, "142108547152020037174224853515625"), new leftCheat.ptr(15, "710542735760100185871124267578125"), new leftCheat.ptr(15, "3552713678800500929355621337890625"), new leftCheat.ptr(15, "17763568394002504646778106689453125"), new leftCheat.ptr(16, "88817841970012523233890533447265625"), new leftCheat.ptr(16, "444089209850062616169452667236328125"), new leftCheat.ptr(16, "2220446049250313080847263336181640625"), new leftCheat.ptr(16, "11102230246251565404236316680908203125"), new leftCheat.ptr(17, "55511151231257827021181583404541015625"), new leftCheat.ptr(17, "277555756156289135105907917022705078125"), new leftCheat.ptr(17, "1387778780781445675529539585113525390625"), new leftCheat.ptr(18, "6938893903907228377647697925567626953125"), new leftCheat.ptr(18, "34694469519536141888238489627838134765625"), new leftCheat.ptr(18, "173472347597680709441192448139190673828125"), new leftCheat.ptr(19, "867361737988403547205962240695953369140625")]);
		smallPowersOfTen = __toNativeArray(__kindStruct, [new extFloat.ptr(new __Uint64(2147483648, 0), -63, false), new extFloat.ptr(new __Uint64(2684354560, 0), -60, false), new extFloat.ptr(new __Uint64(3355443200, 0), -57, false), new extFloat.ptr(new __Uint64(4194304000, 0), -54, false), new extFloat.ptr(new __Uint64(2621440000, 0), -50, false), new extFloat.ptr(new __Uint64(3276800000, 0), -47, false), new extFloat.ptr(new __Uint64(4096000000, 0), -44, false), new extFloat.ptr(new __Uint64(2560000000, 0), -40, false)]);
		powersOfTen = __toNativeArray(__kindStruct, [new extFloat.ptr(new __Uint64(4203730336, 136053384), -1220, false), new extFloat.ptr(new __Uint64(3132023167, 2722021238), -1193, false), new extFloat.ptr(new __Uint64(2333539104, 810921078), -1166, false), new extFloat.ptr(new __Uint64(3477244234, 1573795306), -1140, false), new extFloat.ptr(new __Uint64(2590748842, 1432697645), -1113, false), new extFloat.ptr(new __Uint64(3860516611, 1025131999), -1087, false), new extFloat.ptr(new __Uint64(2876309015, 3348809418), -1060, false), new extFloat.ptr(new __Uint64(4286034428, 3200048207), -1034, false), new extFloat.ptr(new __Uint64(3193344495, 1097586188), -1007, false), new extFloat.ptr(new __Uint64(2379227053, 2424306748), -980, false), new extFloat.ptr(new __Uint64(3545324584, 827693699), -954, false), new extFloat.ptr(new __Uint64(2641472655, 2913388981), -927, false), new extFloat.ptr(new __Uint64(3936100983, 602835915), -901, false), new extFloat.ptr(new __Uint64(2932623761, 1081627501), -874, false), new extFloat.ptr(new __Uint64(2184974969, 1572261463), -847, false), new extFloat.ptr(new __Uint64(3255866422, 1308317239), -821, false), new extFloat.ptr(new __Uint64(2425809519, 944281679), -794, false), new extFloat.ptr(new __Uint64(3614737867, 629291719), -768, false), new extFloat.ptr(new __Uint64(2693189581, 2545915892), -741, false), new extFloat.ptr(new __Uint64(4013165208, 388672741), -715, false), new extFloat.ptr(new __Uint64(2990041083, 708162190), -688, false), new extFloat.ptr(new __Uint64(2227754207, 3536207675), -661, false), new extFloat.ptr(new __Uint64(3319612455, 450088378), -635, false), new extFloat.ptr(new __Uint64(2473304014, 3139815830), -608, false), new extFloat.ptr(new __Uint64(3685510180, 2103616900), -582, false), new extFloat.ptr(new __Uint64(2745919064, 224385782), -555, false), new extFloat.ptr(new __Uint64(4091738259, 3737383206), -529, false), new extFloat.ptr(new __Uint64(3048582568, 2868871352), -502, false), new extFloat.ptr(new __Uint64(2271371013, 1820084875), -475, false), new extFloat.ptr(new __Uint64(3384606560, 885076051), -449, false), new extFloat.ptr(new __Uint64(2521728396, 2444895829), -422, false), new extFloat.ptr(new __Uint64(3757668132, 1881767613), -396, false), new extFloat.ptr(new __Uint64(2799680927, 3102062735), -369, false), new extFloat.ptr(new __Uint64(4171849679, 2289335700), -343, false), new extFloat.ptr(new __Uint64(3108270227, 2410191823), -316, false), new extFloat.ptr(new __Uint64(2315841784, 3205436779), -289, false), new extFloat.ptr(new __Uint64(3450873173, 1697722806), -263, false), new extFloat.ptr(new __Uint64(2571100870, 3497754540), -236, false), new extFloat.ptr(new __Uint64(3831238852, 707476230), -210, false), new extFloat.ptr(new __Uint64(2854495385, 1769181907), -183, false), new extFloat.ptr(new __Uint64(4253529586, 2197867022), -157, false), new extFloat.ptr(new __Uint64(3169126500, 2450594539), -130, false), new extFloat.ptr(new __Uint64(2361183241, 1867548876), -103, false), new extFloat.ptr(new __Uint64(3518437208, 3793315116), -77, false), new extFloat.ptr(new __Uint64(2621440000, 0), -50, false), new extFloat.ptr(new __Uint64(3906250000, 0), -24, false), new extFloat.ptr(new __Uint64(2910383045, 2892103680), 3, false), new extFloat.ptr(new __Uint64(2168404344, 4170451332), 30, false), new extFloat.ptr(new __Uint64(3231174267, 3372684723), 56, false), new extFloat.ptr(new __Uint64(2407412430, 2078956656), 83, false), new extFloat.ptr(new __Uint64(3587324068, 2884206696), 109, false), new extFloat.ptr(new __Uint64(2672764710, 395977285), 136, false), new extFloat.ptr(new __Uint64(3982729777, 3569679143), 162, false), new extFloat.ptr(new __Uint64(2967364920, 2361961896), 189, false), new extFloat.ptr(new __Uint64(2210859150, 447440347), 216, false), new extFloat.ptr(new __Uint64(3294436857, 1114709402), 242, false), new extFloat.ptr(new __Uint64(2454546732, 2786846552), 269, false), new extFloat.ptr(new __Uint64(3657559652, 443583978), 295, false), new extFloat.ptr(new __Uint64(2725094297, 2599384906), 322, false), new extFloat.ptr(new __Uint64(4060706939, 3028118405), 348, false), new extFloat.ptr(new __Uint64(3025462433, 2044532855), 375, false), new extFloat.ptr(new __Uint64(2254145170, 1536935362), 402, false), new extFloat.ptr(new __Uint64(3358938053, 3365297469), 428, false), new extFloat.ptr(new __Uint64(2502603868, 4204241075), 455, false), new extFloat.ptr(new __Uint64(3729170365, 2577424355), 481, false), new extFloat.ptr(new __Uint64(2778448436, 3677981733), 508, false), new extFloat.ptr(new __Uint64(4140210802, 2744688476), 534, false), new extFloat.ptr(new __Uint64(3084697427, 1424604878), 561, false), new extFloat.ptr(new __Uint64(2298278679, 4062331362), 588, false), new extFloat.ptr(new __Uint64(3424702107, 3546052773), 614, false), new extFloat.ptr(new __Uint64(2551601907, 2065781727), 641, false), new extFloat.ptr(new __Uint64(3802183132, 2535403578), 667, false), new extFloat.ptr(new __Uint64(2832847187, 1558426518), 694, false), new extFloat.ptr(new __Uint64(4221271257, 2762425404), 720, false), new extFloat.ptr(new __Uint64(3145092172, 2812560400), 747, false), new extFloat.ptr(new __Uint64(2343276271, 3057687578), 774, false), new extFloat.ptr(new __Uint64(3491753744, 2790753324), 800, false), new extFloat.ptr(new __Uint64(2601559269, 3918606633), 827, false), new extFloat.ptr(new __Uint64(3876625403, 2711358621), 853, false), new extFloat.ptr(new __Uint64(2888311001, 1648096297), 880, false), new extFloat.ptr(new __Uint64(2151959390, 2057817989), 907, false), new extFloat.ptr(new __Uint64(3206669376, 61660461), 933, false), new extFloat.ptr(new __Uint64(2389154863, 1581580175), 960, false), new extFloat.ptr(new __Uint64(3560118173, 2626467905), 986, false), new extFloat.ptr(new __Uint64(2652494738, 3034782633), 1013, false), new extFloat.ptr(new __Uint64(3952525166, 3135207385), 1039, false), new extFloat.ptr(new __Uint64(2944860731, 2616258155), 1066, false)]);
		uint64pow10 = __toNativeArray(__kindUint64, [new __Uint64(0, 1), new __Uint64(0, 10), new __Uint64(0, 100), new __Uint64(0, 1000), new __Uint64(0, 10000), new __Uint64(0, 100000), new __Uint64(0, 1000000), new __Uint64(0, 10000000), new __Uint64(0, 100000000), new __Uint64(0, 1000000000), new __Uint64(2, 1410065408), new __Uint64(23, 1215752192), new __Uint64(232, 3567587328), new __Uint64(2328, 1316134912), new __Uint64(23283, 276447232), new __Uint64(232830, 2764472320), new __Uint64(2328306, 1874919424), new __Uint64(23283064, 1569325056), new __Uint64(232830643, 2808348672), new __Uint64(2328306436, 2313682944)]);
		float32info = new floatInfo.ptr(23, 8, -127);
		float64info = new floatInfo.ptr(52, 11, -1023);
		isPrint16 = new sliceType__4([32, 126, 161, 887, 890, 895, 900, 1366, 1369, 1418, 1421, 1479, 1488, 1514, 1520, 1524, 1542, 1563, 1566, 1805, 1808, 1866, 1869, 1969, 1984, 2042, 2048, 2093, 2096, 2139, 2142, 2142, 2208, 2237, 2260, 2444, 2447, 2448, 2451, 2482, 2486, 2489, 2492, 2500, 2503, 2504, 2507, 2510, 2519, 2519, 2524, 2531, 2534, 2555, 2561, 2570, 2575, 2576, 2579, 2617, 2620, 2626, 2631, 2632, 2635, 2637, 2641, 2641, 2649, 2654, 2662, 2677, 2689, 2745, 2748, 2765, 2768, 2768, 2784, 2787, 2790, 2801, 2809, 2809, 2817, 2828, 2831, 2832, 2835, 2873, 2876, 2884, 2887, 2888, 2891, 2893, 2902, 2903, 2908, 2915, 2918, 2935, 2946, 2954, 2958, 2965, 2969, 2975, 2979, 2980, 2984, 2986, 2990, 3001, 3006, 3010, 3014, 3021, 3024, 3024, 3031, 3031, 3046, 3066, 3072, 3129, 3133, 3149, 3157, 3162, 3168, 3171, 3174, 3183, 3192, 3257, 3260, 3277, 3285, 3286, 3294, 3299, 3302, 3314, 3329, 3386, 3389, 3407, 3412, 3427, 3430, 3455, 3458, 3478, 3482, 3517, 3520, 3526, 3530, 3530, 3535, 3551, 3558, 3567, 3570, 3572, 3585, 3642, 3647, 3675, 3713, 3716, 3719, 3722, 3725, 3725, 3732, 3751, 3754, 3773, 3776, 3789, 3792, 3801, 3804, 3807, 3840, 3948, 3953, 4058, 4096, 4295, 4301, 4301, 4304, 4685, 4688, 4701, 4704, 4749, 4752, 4789, 4792, 4805, 4808, 4885, 4888, 4954, 4957, 4988, 4992, 5017, 5024, 5109, 5112, 5117, 5120, 5788, 5792, 5880, 5888, 5908, 5920, 5942, 5952, 5971, 5984, 6003, 6016, 6109, 6112, 6121, 6128, 6137, 6144, 6157, 6160, 6169, 6176, 6263, 6272, 6314, 6320, 6389, 6400, 6443, 6448, 6459, 6464, 6464, 6468, 6509, 6512, 6516, 6528, 6571, 6576, 6601, 6608, 6618, 6622, 6683, 6686, 6780, 6783, 6793, 6800, 6809, 6816, 6829, 6832, 6846, 6912, 6987, 6992, 7036, 7040, 7155, 7164, 7223, 7227, 7241, 7245, 7304, 7360, 7367, 7376, 7417, 7424, 7669, 7675, 7957, 7960, 7965, 7968, 8005, 8008, 8013, 8016, 8061, 8064, 8147, 8150, 8175, 8178, 8190, 8208, 8231, 8240, 8286, 8304, 8305, 8308, 8348, 8352, 8382, 8400, 8432, 8448, 8587, 8592, 9254, 9280, 9290, 9312, 11123, 11126, 11157, 11160, 11193, 11197, 11217, 11244, 11247, 11264, 11507, 11513, 11559, 11565, 11565, 11568, 11623, 11631, 11632, 11647, 11670, 11680, 11844, 11904, 12019, 12032, 12245, 12272, 12283, 12289, 12438, 12441, 12543, 12549, 12589, 12593, 12730, 12736, 12771, 12784, 19893, 19904, 40917, 40960, 42124, 42128, 42182, 42192, 42539, 42560, 42743, 42752, 42935, 42999, 43051, 43056, 43065, 43072, 43127, 43136, 43205, 43214, 43225, 43232, 43261, 43264, 43347, 43359, 43388, 43392, 43481, 43486, 43574, 43584, 43597, 43600, 43609, 43612, 43714, 43739, 43766, 43777, 43782, 43785, 43790, 43793, 43798, 43808, 43877, 43888, 44013, 44016, 44025, 44032, 55203, 55216, 55238, 55243, 55291, 63744, 64109, 64112, 64217, 64256, 64262, 64275, 64279, 64285, 64449, 64467, 64831, 64848, 64911, 64914, 64967, 65008, 65021, 65024, 65049, 65056, 65131, 65136, 65276, 65281, 65470, 65474, 65479, 65482, 65487, 65490, 65495, 65498, 65500, 65504, 65518, 65532, 65533]);
		isNotPrint16 = new sliceType__4([173, 907, 909, 930, 1328, 1376, 1416, 1424, 1757, 2111, 2229, 2274, 2436, 2473, 2481, 2526, 2564, 2601, 2609, 2612, 2615, 2621, 2653, 2692, 2702, 2706, 2729, 2737, 2740, 2758, 2762, 2820, 2857, 2865, 2868, 2910, 2948, 2961, 2971, 2973, 3017, 3076, 3085, 3089, 3113, 3141, 3145, 3159, 3204, 3213, 3217, 3241, 3252, 3269, 3273, 3295, 3312, 3332, 3341, 3345, 3397, 3401, 3460, 3506, 3516, 3541, 3543, 3715, 3721, 3736, 3744, 3748, 3750, 3756, 3770, 3781, 3783, 3912, 3992, 4029, 4045, 4294, 4681, 4695, 4697, 4745, 4785, 4799, 4801, 4823, 4881, 5760, 5901, 5997, 6001, 6431, 6751, 7415, 8024, 8026, 8028, 8030, 8117, 8133, 8156, 8181, 8335, 9215, 11209, 11311, 11359, 11558, 11687, 11695, 11703, 11711, 11719, 11727, 11735, 11743, 11930, 12352, 12687, 12831, 13055, 42927, 43470, 43519, 43815, 43823, 64311, 64317, 64319, 64322, 64325, 65107, 65127, 65141, 65511]);
		isPrint32 = new sliceType__5([65536, 65613, 65616, 65629, 65664, 65786, 65792, 65794, 65799, 65843, 65847, 65947, 65952, 65952, 66000, 66045, 66176, 66204, 66208, 66256, 66272, 66299, 66304, 66339, 66352, 66378, 66384, 66426, 66432, 66499, 66504, 66517, 66560, 66717, 66720, 66729, 66736, 66771, 66776, 66811, 66816, 66855, 66864, 66915, 66927, 66927, 67072, 67382, 67392, 67413, 67424, 67431, 67584, 67589, 67592, 67640, 67644, 67644, 67647, 67742, 67751, 67759, 67808, 67829, 67835, 67867, 67871, 67897, 67903, 67903, 67968, 68023, 68028, 68047, 68050, 68102, 68108, 68147, 68152, 68154, 68159, 68167, 68176, 68184, 68192, 68255, 68288, 68326, 68331, 68342, 68352, 68405, 68409, 68437, 68440, 68466, 68472, 68497, 68505, 68508, 68521, 68527, 68608, 68680, 68736, 68786, 68800, 68850, 68858, 68863, 69216, 69246, 69632, 69709, 69714, 69743, 69759, 69825, 69840, 69864, 69872, 69881, 69888, 69955, 69968, 70006, 70016, 70093, 70096, 70132, 70144, 70206, 70272, 70313, 70320, 70378, 70384, 70393, 70400, 70412, 70415, 70416, 70419, 70457, 70460, 70468, 70471, 70472, 70475, 70477, 70480, 70480, 70487, 70487, 70493, 70499, 70502, 70508, 70512, 70516, 70656, 70749, 70784, 70855, 70864, 70873, 71040, 71093, 71096, 71133, 71168, 71236, 71248, 71257, 71264, 71276, 71296, 71351, 71360, 71369, 71424, 71449, 71453, 71467, 71472, 71487, 71840, 71922, 71935, 71935, 72384, 72440, 72704, 72773, 72784, 72812, 72816, 72847, 72850, 72886, 73728, 74649, 74752, 74868, 74880, 75075, 77824, 78894, 82944, 83526, 92160, 92728, 92736, 92777, 92782, 92783, 92880, 92909, 92912, 92917, 92928, 92997, 93008, 93047, 93053, 93071, 93952, 94020, 94032, 94078, 94095, 94111, 94176, 94176, 94208, 100332, 100352, 101106, 110592, 110593, 113664, 113770, 113776, 113788, 113792, 113800, 113808, 113817, 113820, 113823, 118784, 119029, 119040, 119078, 119081, 119154, 119163, 119272, 119296, 119365, 119552, 119638, 119648, 119665, 119808, 119967, 119970, 119970, 119973, 119974, 119977, 120074, 120077, 120134, 120138, 120485, 120488, 120779, 120782, 121483, 121499, 121519, 122880, 122904, 122907, 122922, 124928, 125124, 125127, 125142, 125184, 125258, 125264, 125273, 125278, 125279, 126464, 126500, 126503, 126523, 126530, 126530, 126535, 126548, 126551, 126564, 126567, 126619, 126625, 126651, 126704, 126705, 126976, 127019, 127024, 127123, 127136, 127150, 127153, 127221, 127232, 127244, 127248, 127339, 127344, 127404, 127462, 127490, 127504, 127547, 127552, 127560, 127568, 127569, 127744, 128722, 128736, 128748, 128752, 128758, 128768, 128883, 128896, 128980, 129024, 129035, 129040, 129095, 129104, 129113, 129120, 129159, 129168, 129197, 129296, 129319, 129328, 129328, 129331, 129355, 129360, 129374, 129408, 129425, 129472, 129472, 131072, 173782, 173824, 177972, 177984, 178205, 178208, 183969, 194560, 195101, 917760, 917999]);
		isNotPrint32 = new sliceType__4([12, 39, 59, 62, 399, 926, 2057, 2102, 2134, 2291, 2564, 2580, 2584, 4285, 4405, 4576, 4626, 4743, 4745, 4750, 4766, 4868, 4905, 4913, 4916, 5210, 5212, 7177, 7223, 7336, 9327, 27231, 27482, 27490, 54357, 54429, 54445, 54458, 54460, 54468, 54534, 54549, 54557, 54586, 54591, 54597, 54609, 55968, 57351, 57378, 57381, 60932, 60960, 60963, 60968, 60979, 60984, 60986, 61000, 61002, 61004, 61008, 61011, 61016, 61018, 61020, 61022, 61024, 61027, 61035, 61043, 61048, 61053, 61055, 61066, 61092, 61098, 61632, 61648, 61743, 63775, 63807]);
		isGraphic = new sliceType__4([160, 5760, 8192, 8193, 8194, 8195, 8196, 8197, 8198, 8199, 8200, 8201, 8202, 8239, 8287, 12288]);
		shifts = __toNativeArray(__kindUint, [0, 0, 1, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0]);
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["unicode"] = (function()
	var __pkg = {}, __init;
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["reflect"] = (function()
	var __pkg = {}, __init, errors, js, math, runtime, strconv, sync, unicode, utf8, uncommonType, funcType, name, nameData, mapIter, Type, Kind, tflag, rtype, typeAlg, method, ChanDir, arrayType, chanType, imethod, interfaceType, mapType, ptrType, sliceType, structField, structType, Method, nameOff, typeOff, textOff, StructField, StructTag, fieldScan, Value, flag, ValueError, sliceType__1, ptrType__1, sliceType__2, sliceType__3, ptrType__2, funcType__1, sliceType__4, ptrType__3, ptrType__4, sliceType__5, sliceType__6, sliceType__7, ptrType__5, ptrType__6, structType__3, sliceType__8, sliceType__9, sliceType__10, sliceType__11, ptrType__7, ptrType__8, sliceType__13, sliceType__14, ptrType__9, sliceType__15, ptrType__15, sliceType__17, ptrType__16, funcType__3, funcType__4, funcType__5, ptrType__17, arrayType__12, ptrType__18, initialized, uncommonTypeMap, nameMap, nameOffList, typeOffList, callHelper, jsObjectPtr, selectHelper, kindNames, methodCache, uint8Type, init, jsType, reflectType, setKindType, newName, newNameOff, newTypeOff, internalStr, isWrapped, copyStruct, makeValue, MakeSlice, TypeOf, ValueOf, FuncOf, SliceOf, Zero, unsafe_New, makeInt, typedmemmove, keyFor, mapaccess, mapassign, mapdelete, mapiterinit, mapiterkey, mapiternext, maplen, cvtDirect, methodReceiver, valueInterface, ifaceE2I, methodName, makeMethodValue, wrapJsObject, unwrapJsObject, getJsTag, chanrecv, chansend, PtrTo, implements__1, directlyAssignable, haveIdenticalType, haveIdenticalUnderlyingType, toType, ifaceIndir, overflowFloat32, New, convertOp, makeFloat, makeComplex, makeString, makeBytes, makeRunes, cvtInt, cvtUint, cvtFloatInt, cvtFloatUint, cvtIntFloat, cvtUintFloat, cvtFloat, cvtComplex, cvtIntString, cvtUintString, cvtBytesString, cvtStringBytes, cvtRunesString, cvtStringRunes, cvtT2I, cvtI2I;
	errors = __packages["errors"];
	js = __packages["github.com/gopherjs/gopherjs/js"];
	math = __packages["math"];
	runtime = __packages["runtime"];
	strconv = __packages["strconv"];
	sync = __packages["sync"];
	unicode = __packages["unicode"];
	utf8 = __packages["unicode/utf8"];
	uncommonType = __pkg.uncommonType = __newType(0, __kindStruct, "reflect.uncommonType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.pkgPath = 0;
			this.mcount = 0;
			this.___2 = 0;
			this.moff = 0;
			this.___4 = 0;
			this._methods = sliceType__5.nil;
			return;
		end
		this.pkgPath = pkgPath_;
		this.mcount = mcount_;
		this.___2 = ___2_;
		this.moff = moff_;
		this.___4 = ___4_;
		this._methods = _methods_;
	end);
	funcType = __pkg.funcType = __newType(0, __kindStruct, "reflect.funcType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.inCount = 0;
			this.outCount = 0;
			this._in = sliceType__2.nil;
			this._out = sliceType__2.nil;
			return;
		end
		this.rtype = rtype_;
		this.inCount = inCount_;
		this.outCount = outCount_;
		this._in = _in_;
		this._out = _out_;
	end);
	name = __pkg.name = __newType(0, __kindStruct, "reflect.name", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.bytes = ptrType__4.nil;
			return;
		end
		this.bytes = bytes_;
	end);
	nameData = __pkg.nameData = __newType(0, __kindStruct, "reflect.nameData", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.name = "";
			this.tag = "";
			this.pkgPath = "";
			this.exported = false;
			return;
		end
		this.name = name_;
		this.tag = tag_;
		this.pkgPath = pkgPath_;
		this.exported = exported_;
	end);
	mapIter = __pkg.mapIter = __newType(0, __kindStruct, "reflect.mapIter", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.t = __ifaceNil;
			this.m = null;
			this.keys = null;
			this.i = 0;
			return;
		end
		this.t = t_;
		this.m = m_;
		this.keys = keys_;
		this.i = i_;
	end);
	Type = __pkg.Type = __newType(8, __kindInterface, "reflect.Type", true, "reflect", true, null);
	Kind = __pkg.Kind = __newType(4, __kindUint, "reflect.Kind", true, "reflect", true, null);
	tflag = __pkg.tflag = __newType(1, __kindUint8, "reflect.tflag", true, "reflect", false, null);
	rtype = __pkg.rtype = __newType(0, __kindStruct, "reflect.rtype", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.size = 0;
			this.ptrdata = 0;
			this.hash = 0;
			this.tflag = 0;
			this.align = 0;
			this.fieldAlign = 0;
			this.kind = 0;
			this.alg = ptrType__3.nil;
			this.gcdata = ptrType__4.nil;
			this.str = 0;
			this.ptrToThis = 0;
			return;
		end
		this.size = size_;
		this.ptrdata = ptrdata_;
		this.hash = hash_;
		this.tflag = tflag_;
		this.align = align_;
		this.fieldAlign = fieldAlign_;
		this.kind = kind_;
		this.alg = alg_;
		this.gcdata = gcdata_;
		this.str = str_;
		this.ptrToThis = ptrToThis_;
	end);
	typeAlg = __pkg.typeAlg = __newType(0, __kindStruct, "reflect.typeAlg", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.hash = __throwNilPointerError;
			this.equal = __throwNilPointerError;
			return;
		end
		this.hash = hash_;
		this.equal = equal_;
	end);
	method = __pkg.method = __newType(0, __kindStruct, "reflect.method", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.name = 0;
			this.mtyp = 0;
			this.ifn = 0;
			this.tfn = 0;
			return;
		end
		this.name = name_;
		this.mtyp = mtyp_;
		this.ifn = ifn_;
		this.tfn = tfn_;
	end);
	ChanDir = __pkg.ChanDir = __newType(4, __kindInt, "reflect.ChanDir", true, "reflect", true, null);
	arrayType = __pkg.arrayType = __newType(0, __kindStruct, "reflect.arrayType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.elem = ptrType__1.nil;
			this.slice = ptrType__1.nil;
			this.len = 0;
			return;
		end
		this.rtype = rtype_;
		this.elem = elem_;
		this.slice = slice_;
		this.len = len_;
	end);
	chanType = __pkg.chanType = __newType(0, __kindStruct, "reflect.chanType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.elem = ptrType__1.nil;
			this.dir = 0;
			return;
		end
		this.rtype = rtype_;
		this.elem = elem_;
		this.dir = dir_;
	end);
	imethod = __pkg.imethod = __newType(0, __kindStruct, "reflect.imethod", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.name = 0;
			this.typ = 0;
			return;
		end
		this.name = name_;
		this.typ = typ_;
	end);
	interfaceType = __pkg.interfaceType = __newType(0, __kindStruct, "reflect.interfaceType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.pkgPath = new name.ptr(ptrType__4.nil);
			this.methods = sliceType__6.nil;
			return;
		end
		this.rtype = rtype_;
		this.pkgPath = pkgPath_;
		this.methods = methods_;
	end);
	mapType = __pkg.mapType = __newType(0, __kindStruct, "reflect.mapType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.key = ptrType__1.nil;
			this.elem = ptrType__1.nil;
			this.bucket = ptrType__1.nil;
			this.hmap = ptrType__1.nil;
			this.keysize = 0;
			this.indirectkey = 0;
			this.valuesize = 0;
			this.indirectvalue = 0;
			this.bucketsize = 0;
			this.reflexivekey = false;
			this.needkeyupdate = false;
			return;
		end
		this.rtype = rtype_;
		this.key = key_;
		this.elem = elem_;
		this.bucket = bucket_;
		this.hmap = hmap_;
		this.keysize = keysize_;
		this.indirectkey = indirectkey_;
		this.valuesize = valuesize_;
		this.indirectvalue = indirectvalue_;
		this.bucketsize = bucketsize_;
		this.reflexivekey = reflexivekey_;
		this.needkeyupdate = needkeyupdate_;
	end);
	ptrType = __pkg.ptrType = __newType(0, __kindStruct, "reflect.ptrType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.elem = ptrType__1.nil;
			return;
		end
		this.rtype = rtype_;
		this.elem = elem_;
	end);
	sliceType = __pkg.sliceType = __newType(0, __kindStruct, "reflect.sliceType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.elem = ptrType__1.nil;
			return;
		end
		this.rtype = rtype_;
		this.elem = elem_;
	end);
	structField = __pkg.structField = __newType(0, __kindStruct, "reflect.structField", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.name = new name.ptr(ptrType__4.nil);
			this.typ = ptrType__1.nil;
			this.offsetAnon = 0;
			return;
		end
		this.name = name_;
		this.typ = typ_;
		this.offsetAnon = offsetAnon_;
	end);
	structType = __pkg.structType = __newType(0, __kindStruct, "reflect.structType", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rtype = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
			this.pkgPath = new name.ptr(ptrType__4.nil);
			this.fields = sliceType__7.nil;
			return;
		end
		this.rtype = rtype_;
		this.pkgPath = pkgPath_;
		this.fields = fields_;
	end);
	Method = __pkg.Method = __newType(0, __kindStruct, "reflect.Method", true, "reflect", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Name = "";
			this.PkgPath = "";
			this.Type = __ifaceNil;
			this.Func = new Value.ptr(ptrType__1.nil, 0, 0);
			this.Index = 0;
			return;
		end
		this.Name = Name_;
		this.PkgPath = PkgPath_;
		this.Type = Type_;
		this.Func = Func_;
		this.Index = Index_;
	end);
	nameOff = __pkg.nameOff = __newType(4, __kindInt32, "reflect.nameOff", true, "reflect", false, null);
	typeOff = __pkg.typeOff = __newType(4, __kindInt32, "reflect.typeOff", true, "reflect", false, null);
	textOff = __pkg.textOff = __newType(4, __kindInt32, "reflect.textOff", true, "reflect", false, null);
	StructField = __pkg.StructField = __newType(0, __kindStruct, "reflect.StructField", true, "reflect", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Name = "";
			this.PkgPath = "";
			this.Type = __ifaceNil;
			this.Tag = "";
			this.Offset = 0;
			this.Index = sliceType__13.nil;
			this.Anonymous = false;
			return;
		end
		this.Name = Name_;
		this.PkgPath = PkgPath_;
		this.Type = Type_;
		this.Tag = Tag_;
		this.Offset = Offset_;
		this.Index = Index_;
		this.Anonymous = Anonymous_;
	end);
	StructTag = __pkg.StructTag = __newType(8, __kindString, "reflect.StructTag", true, "reflect", true, null);
	fieldScan = __pkg.fieldScan = __newType(0, __kindStruct, "reflect.fieldScan", true, "reflect", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.typ = ptrType__9.nil;
			this.index = sliceType__13.nil;
			return;
		end
		this.typ = typ_;
		this.index = index_;
	end);
	Value = __pkg.Value = __newType(0, __kindStruct, "reflect.Value", true, "reflect", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.typ = ptrType__1.nil;
			this.ptr = 0;
			this.flag = 0;
			return;
		end
		this.typ = typ_;
		this.ptr = ptr_;
		this.flag = flag_;
	end);
	flag = __pkg.flag = __newType(4, __kindUintptr, "reflect.flag", true, "reflect", false, null);
	ValueError = __pkg.ValueError = __newType(0, __kindStruct, "reflect.ValueError", true, "reflect", true, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.Method = "";
			this.Kind = 0;
			return;
		end
		this.Method = Method_;
		this.Kind = Kind_;
	end);
	sliceType__1 = __sliceType(name);
	ptrType__1 = __ptrType(rtype);
	sliceType__2 = __sliceType(ptrType__1);
	sliceType__3 = __sliceType(__emptyInterface);
	ptrType__2 = __ptrType(js.Object);
	funcType__1 = __funcType([sliceType__3], [ptrType__2], true);
	sliceType__4 = __sliceType(__String);
	ptrType__3 = __ptrType(typeAlg);
	ptrType__4 = __ptrType(__Uint8);
	sliceType__5 = __sliceType(method);
	sliceType__6 = __sliceType(imethod);
	sliceType__7 = __sliceType(structField);
	ptrType__5 = __ptrType(uncommonType);
	ptrType__6 = __ptrType(nameData);
	structType__3 = __structType("reflect", [{prop: "str", name: "str", anonymous: false, exported: false, typ: __String, tag: ""end]);
	sliceType__8 = __sliceType(ptrType__2);
	sliceType__9 = __sliceType(Value);
	sliceType__10 = __sliceType(Type);
	sliceType__11 = __sliceType(sliceType__8);
	ptrType__7 = __ptrType(interfaceType);
	ptrType__8 = __ptrType(imethod);
	sliceType__13 = __sliceType(__Int);
	sliceType__14 = __sliceType(fieldScan);
	ptrType__9 = __ptrType(structType);
	sliceType__15 = __sliceType(__Uint8);
	ptrType__15 = __ptrType(__UnsafePointer);
	sliceType__17 = __sliceType(__Int32);
	ptrType__16 = __ptrType(funcType);
	funcType__3 = __funcType([__String], [__Bool], false);
	funcType__4 = __funcType([__UnsafePointer, __Uintptr], [__Uintptr], false);
	funcType__5 = __funcType([__UnsafePointer, __UnsafePointer], [__Bool], false);
	ptrType__17 = __ptrType(structField);
	arrayType__12 = __arrayType(__Uintptr, 2);
	ptrType__18 = __ptrType(ValueError);
	init = function()
		var used, x, x__1, x__10, x__11, x__12, x__2, x__3, x__4, x__5, x__6, x__7, x__8, x__9, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; used = __f.used; x = __f.x; x__1 = __f.x__1; x__10 = __f.x__10; x__11 = __f.x__11; x__12 = __f.x__12; x__2 = __f.x__2; x__3 = __f.x__3; x__4 = __f.x__4; x__5 = __f.x__5; x__6 = __f.x__6; x__7 = __f.x__7; x__8 = __f.x__8; x__9 = __f.x__9; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		used = (function(i)
			var i;
		end);
		__r = used((x = new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), new x.constructor.elem(x))); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__1 = new uncommonType.ptr(0, 0, 0, 0, 0, sliceType__5.nil), new x__1.constructor.elem(x__1))); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__2 = new method.ptr(0, 0, 0, 0), new x__2.constructor.elem(x__2))); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__3 = new arrayType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), ptrType__1.nil, ptrType__1.nil, 0), new x__3.constructor.elem(x__3))); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__4 = new chanType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), ptrType__1.nil, 0), new x__4.constructor.elem(x__4))); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__5 = new funcType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), 0, 0, sliceType__2.nil, sliceType__2.nil), new x__5.constructor.elem(x__5))); /* */ __s = 6; case 6: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__6 = new interfaceType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), new name.ptr(ptrType__4.nil), sliceType__6.nil), new x__6.constructor.elem(x__6))); /* */ __s = 7; case 7: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__7 = new mapType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), ptrType__1.nil, ptrType__1.nil, ptrType__1.nil, ptrType__1.nil, 0, 0, 0, 0, 0, false, false), new x__7.constructor.elem(x__7))); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__8 = new ptrType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), ptrType__1.nil), new x__8.constructor.elem(x__8))); /* */ __s = 9; case 9: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__9 = new sliceType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), ptrType__1.nil), new x__9.constructor.elem(x__9))); /* */ __s = 10; case 10: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__10 = new structType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), new name.ptr(ptrType__4.nil), sliceType__7.nil), new x__10.constructor.elem(x__10))); /* */ __s = 11; case 11: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__11 = new imethod.ptr(0, 0), new x__11.constructor.elem(x__11))); /* */ __s = 12; case 12: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = used((x__12 = new structField.ptr(new name.ptr(ptrType__4.nil), ptrType__1.nil, 0), new x__12.constructor.elem(x__12))); /* */ __s = 13; case 13: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		initialized = true;
		uint8Type = __assertType(TypeOf(new __Uint8(0)), ptrType__1);
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: init end; end __f.used = used; __f.x = x; __f.x__1 = x__1; __f.x__10 = x__10; __f.x__11 = x__11; __f.x__12 = x__12; __f.x__2 = x__2; __f.x__3 = x__3; __f.x__4 = x__4; __f.x__5 = x__5; __f.x__6 = x__6; __f.x__7 = x__7; __f.x__8 = x__8; __f.x__9 = x__9; __f.__s = __s; __f.__r = __r; return __f;
	end;
	jsType = function(p)
		var typ;
		return typ.jsType;
	end;
	reflectType = function(p)
		var _1, _i, _i__1, _i__2, _i__3, _i__4, _key, _ref, _ref__1, _ref__2, _ref__3, _ref__4, dir, f, fields, i, i__1, i__2, i__3, i__4, imethods, in__1, m, m__1, methodSet, methods, offsetAnon, out, outCount, params, reflectFields, reflectMethods, results, rt, typ, ut;
		if (typ.reflectType == nil) {
			rt = new rtype.ptr((((__parseInt(typ.size) >> 0) >>> 0)), 0, 0, 0, 0, 0, (((__parseInt(typ.kind) >> 0) << 24 >>> 24)), ptrType__3.nil, ptrType__4.nil, newNameOff(__clone(newName(internalStr(typ.string), "", "",  not  not (typ.exported)), name)), 0);
			rt.jsType = typ;
			typ.reflectType = rt;
			methodSet = __methodSet(typ);
			if ( not ((__parseInt(methodSet.length) == 0))  or   not  not (typ.named)) {
				rt.tflag = (rt.tflag | (1)) >>> 0;
				if ( not  not (typ.named)) {
					rt.tflag = (rt.tflag | (4)) >>> 0;
				end
				reflectMethods = __makeSlice(sliceType__5, __parseInt(methodSet.length));
				_ref = reflectMethods;
				_i = 0;
				while (true) {
					if ( not (_i < _ref.__length)) { break; end
					i = _i;
					m = methodSet[i];
					method.copy(((i < 0  or  i >= reflectMethods.__length) ? (__throwRuntimeError("index out of range"), nil) : reflectMethods.__array[reflectMethods.__offset + i]), new method.ptr(newNameOff(__clone(newName(internalStr(m.name), "", "", internalStr(m.pkg) == ""), name)), newTypeOff(reflectType(m.typ)), 0, 0));
					_i++;
				end
				ut = new uncommonType.ptr(newNameOff(__clone(newName(internalStr(typ.pkg), "", "", false), name)), ((__parseInt(methodSet.length) << 16 >>> 16)), 0, 0, 0, reflectMethods);
				_key = rt; (uncommonTypeMap  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__1.keyFor(_key)] = { k: _key, v: ut end;
				ut.jsType = typ;
			end
			_1 = rt.Kind();
			if (_1 == (17)) {
				setKindType(rt, new arrayType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), reflectType(typ.elem), ptrType__1.nil, (((__parseInt(typ.len) >> 0) >>> 0))));
			end else if (_1 == (18)) {
				dir = 3;
				if ( not  not (typ.sendOnly)) {
					dir = 2;
				end
				if ( not  not (typ.recvOnly)) {
					dir = 1;
				end
				setKindType(rt, new chanType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), reflectType(typ.elem), ((dir >>> 0))));
			end else if (_1 == (19)) {
				params = typ.params;
				in__1 = __makeSlice(sliceType__2, __parseInt(params.length));
				_ref__1 = in__1;
				_i__1 = 0;
				while (true) {
					if ( not (_i__1 < _ref__1.__length)) { break; end
					i__1 = _i__1;
					((i__1 < 0  or  i__1 >= in__1.__length) ? (__throwRuntimeError("index out of range"), nil) : in__1.__array[in__1.__offset + i__1] = reflectType(params[i__1]));
					_i__1++;
				end
				results = typ.results;
				out = __makeSlice(sliceType__2, __parseInt(results.length));
				_ref__2 = out;
				_i__2 = 0;
				while (true) {
					if ( not (_i__2 < _ref__2.__length)) { break; end
					i__2 = _i__2;
					((i__2 < 0  or  i__2 >= out.__length) ? (__throwRuntimeError("index out of range"), nil) : out.__array[out.__offset + i__2] = reflectType(results[i__2]));
					_i__2++;
				end
				outCount = ((__parseInt(results.length) << 16 >>> 16));
				if ( not  not (typ.variadic)) {
					outCount = (outCount | (32768)) >>> 0;
				end
				setKindType(rt, new funcType.ptr(__clone(rt, rtype), ((__parseInt(params.length) << 16 >>> 16)), outCount, in__1, out));
			end else if (_1 == (20)) {
				methods = typ.methods;
				imethods = __makeSlice(sliceType__6, __parseInt(methods.length));
				_ref__3 = imethods;
				_i__3 = 0;
				while (true) {
					if ( not (_i__3 < _ref__3.__length)) { break; end
					i__3 = _i__3;
					m__1 = methods[i__3];
					imethod.copy(((i__3 < 0  or  i__3 >= imethods.__length) ? (__throwRuntimeError("index out of range"), nil) : imethods.__array[imethods.__offset + i__3]), new imethod.ptr(newNameOff(__clone(newName(internalStr(m__1.name), "", "", internalStr(m__1.pkg) == ""), name)), newTypeOff(reflectType(m__1.typ))));
					_i__3++;
				end
				setKindType(rt, new interfaceType.ptr(__clone(rt, rtype), __clone(newName(internalStr(typ.pkg), "", "", false), name), imethods));
			end else if (_1 == (21)) {
				setKindType(rt, new mapType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), reflectType(typ.key), reflectType(typ.elem), ptrType__1.nil, ptrType__1.nil, 0, 0, 0, 0, 0, false, false));
			end else if (_1 == (22)) {
				setKindType(rt, new ptrType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), reflectType(typ.elem)));
			end else if (_1 == (23)) {
				setKindType(rt, new sliceType.ptr(new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0), reflectType(typ.elem)));
			end else if (_1 == (25)) {
				fields = typ.fields;
				reflectFields = __makeSlice(sliceType__7, __parseInt(fields.length));
				_ref__4 = reflectFields;
				_i__4 = 0;
				while (true) {
					if ( not (_i__4 < _ref__4.__length)) { break; end
					i__4 = _i__4;
					f = fields[i__4];
					offsetAnon = ((i__4 >>> 0)) << 1 >>> 0;
					if ( not  not (f.anonymous)) {
						offsetAnon = (offsetAnon | (1)) >>> 0;
					end
					structField.copy(((i__4 < 0  or  i__4 >= reflectFields.__length) ? (__throwRuntimeError("index out of range"), nil) : reflectFields.__array[reflectFields.__offset + i__4]), new structField.ptr(__clone(newName(internalStr(f.name), internalStr(f.tag), "",  not  not (f.exported)), name), reflectType(f.typ), offsetAnon));
					_i__4++;
				end
				setKindType(rt, new structType.ptr(__clone(rt, rtype), __clone(newName(internalStr(typ.pkgPath), "", "", false), name), reflectFields));
			end
		end
		return ((typ.reflectType));
	end;
	setKindType = function(e)
		var kindType, rt;
		rt.kindType = kindType;
		kindType.rtype = rt;
	end;
	uncommonType.ptr.prototype.methods = function()
		var t;
		t = this;
		return t._methods;
	end;
	uncommonType.prototype.methods = function() return this.__val.methods(); end;
	rtype.ptr.prototype.uncommon = function()
		var _entry, t;
		t = this;
		return (_entry = uncommonTypeMap[ptrType__1.keyFor(t)], _entry ~= nil ? _entry.v : ptrType__5.nil);
	end;
	rtype.prototype.uncommon = function() return this.__val.uncommon(); end;
	funcType.ptr.prototype.in__ = function()
		var t;
		t = this;
		return t._in;
	end;
	funcType.prototype.in__ = function() return this.__val.in__(); end;
	funcType.ptr.prototype.out = function()
		var t;
		t = this;
		return t._out;
	end;
	funcType.prototype.out = function() return this.__val.out(); end;
	name.ptr.prototype.name = function()
		var _entry, n, s;
		s = "";
		n = this;
		s = (_entry = nameMap[ptrType__4.keyFor(n.bytes)], _entry ~= nil ? _entry.v : ptrType__6.nil).name;
		return s;
	end;
	name.prototype.name = function() return this.__val.name(); end;
	name.ptr.prototype.tag = function()
		var _entry, n, s;
		s = "";
		n = this;
		s = (_entry = nameMap[ptrType__4.keyFor(n.bytes)], _entry ~= nil ? _entry.v : ptrType__6.nil).tag;
		return s;
	end;
	name.prototype.tag = function() return this.__val.tag(); end;
	name.ptr.prototype.pkgPath = function()
		var _entry, n;
		n = this;
		return (_entry = nameMap[ptrType__4.keyFor(n.bytes)], _entry ~= nil ? _entry.v : ptrType__6.nil).pkgPath;
	end;
	name.prototype.pkgPath = function() return this.__val.pkgPath(); end;
	name.ptr.prototype.isExported = function()
		var _entry, n;
		n = this;
		return (_entry = nameMap[ptrType__4.keyFor(n.bytes)], _entry ~= nil ? _entry.v : ptrType__6.nil).exported;
	end;
	name.prototype.isExported = function() return this.__val.isExported(); end;
	newName = function(d)
		var _key, b, exported, n, pkgPath, tag;
		b = __newDataPointer(0, ptrType__4);
		_key = b; (nameMap  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__4.keyFor(_key)] = { k: _key, v: new nameData.ptr(n, tag, pkgPath, exported) end;
		return new name.ptr(b);
	end;
	rtype.ptr.prototype.nameOff = function(f)
		var off, t, x;
		t = this;
		return (x = ((off >> 0)), ((x < 0  or  x >= nameOffList.__length) ? (__throwRuntimeError("index out of range"), nil) : nameOffList.__array[nameOffList.__offset + x]));
	end;
	rtype.prototype.nameOff = function(f) return this.__val.nameOff(off); end;
	newNameOff = function(n)
		var i, n;
		i = nameOffList.__length;
		nameOffList = __append(nameOffList, n);
		return ((i >> 0));
	end;
	rtype.ptr.prototype.typeOff = function(f)
		var off, t, x;
		t = this;
		return (x = ((off >> 0)), ((x < 0  or  x >= typeOffList.__length) ? (__throwRuntimeError("index out of range"), nil) : typeOffList.__array[typeOffList.__offset + x]));
	end;
	rtype.prototype.typeOff = function(f) return this.__val.typeOff(off); end;
	newTypeOff = function(t)
		var i, t;
		i = typeOffList.__length;
		typeOffList = __append(typeOffList, t);
		return ((i >> 0));
	end;
	internalStr = function(j)
		var c, strObj;
		c = new structType__3.ptr("");
		c.str = strObj;
		return c.str;
	end;
	isWrapped = function(p)
		var typ;
		return  not  not (jsType(typ).wrapped);
	end;
	copyStruct = function(p)
		var dst, fields, i, prop, src, typ;
		fields = jsType(typ).fields;
		i = 0;
		while (true) {
			if ( not (i < __parseInt(fields.length))) { break; end
			prop = __internalize(fields[i].prop, __String);
			dst[__externalize(prop, __String)] = src[__externalize(prop, __String)];
			i = i + (1) >> 0;
		end
	end;
	makeValue = function(l)
		var _r, _r__1, _r__2, _r__3, _r__4, _r__5, _v, _v__1, fl, rt, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _v = __f._v; _v__1 = __f._v__1; fl = __f.fl; rt = __f.rt; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = t.common(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		rt = _r;
		_r__1 = t.Kind(); /* */ __s = 6; case 6: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		if (_r__1 == 17) { _v__1 = true; __s = 5; continue s; end
		_r__2 = t.Kind(); /* */ __s = 7; case 7: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		_v__1 = _r__2 == 25; case 5:
		if (_v__1) { _v = true; __s = 4; continue s; end
		_r__3 = t.Kind(); /* */ __s = 8; case 8: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
		_v = _r__3 == 22; case 4:
		/* */ if (_v) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if (_v) { */ case 2:
			_r__4 = t.Kind(); /* */ __s = 9; case 9: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
			__s = -1; return new Value.ptr(rt, (v), (fl | ((_r__4 >>> 0))) >>> 0);
		/* end */ case 3:
		_r__5 = t.Kind(); /* */ __s = 10; case 10: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
		__s = -1; return new Value.ptr(rt, (__newDataPointer(v, jsType(rt.ptrTo()))), (((fl | ((_r__5 >>> 0))) >>> 0) | 128) >>> 0);
		/* */ end return; end if __f == nil then  __f = { __blk: makeValue end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._v = _v; __f._v__1 = _v__1; __f.fl = fl; __f.rt = rt; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	MakeSlice = function(p)
		var _r, _r__1, cap, len, typ, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; cap = __f.cap; len = __f.len; typ = __f.typ; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		typ = [typ];
		_r = typ[0].Kind(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		/* */ if ( not ((_r == 23))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((_r == 23))) { */ case 1:
			__panic(new __String("reflect.MakeSlice of non-slice type"));
		/* end */ case 2:
		if (len < 0) {
			__panic(new __String("reflect.MakeSlice: negative len"));
		end
		if (cap < 0) {
			__panic(new __String("reflect.MakeSlice: negative cap"));
		end
		if (len > cap) {
			__panic(new __String("reflect.MakeSlice: len > cap"));
		end
		_r__1 = makeValue(typ[0], __makeSlice(jsType(typ[0]), len, cap, (function(p) return function __b() {
			var _r__1, _r__2, __s, __r;
			/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r__1 = __f._r__1; _r__2 = __f._r__2; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
			_r__1 = typ[0].Elem(); /* */ __s = 1; case 1: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			_r__2 = jsType(_r__1); /* */ __s = 2; case 2: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
			__s = -1; return _r__2.zero();
			/* */ end return; end if __f == nil then  __f = { __blk: __b end; end __f._r__1 = _r__1; __f._r__2 = _r__2; __f.__s = __s; __f.__r = __r; return __f;
		end; end)(typ)), 0); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: MakeSlice end; end __f._r = _r; __f._r__1 = _r__1; __f.cap = cap; __f.len = len; __f.typ = typ; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.MakeSlice = MakeSlice;
	TypeOf = function(i)
		var i;
		if ( not initialized) {
			return new rtype.ptr(0, 0, 0, 0, 0, 0, 0, ptrType__3.nil, ptrType__4.nil, 0, 0);
		end
		if (__interfaceIsEqual(i, __ifaceNil)) {
			return __ifaceNil;
		end
		return reflectType(i.constructor);
	end;
	__pkg.TypeOf = TypeOf;
	ValueOf = function(i)
		var _r, i, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; i = __f.i; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if (__interfaceIsEqual(i, __ifaceNil)) {
			__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		end
		_r = makeValue(reflectType(i.constructor), i.__val, 0); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: ValueOf end; end __f._r = _r; __f.i = i; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.ValueOf = ValueOf;
	FuncOf = function(c)
		var _i, _i__1, _r, _ref, _ref__1, _v, _v__1, i, i__1, in__1, jsIn, jsOut, out, v, v__1, variadic, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _i__1 = __f._i__1; _r = __f._r; _ref = __f._ref; _ref__1 = __f._ref__1; _v = __f._v; _v__1 = __f._v__1; i = __f.i; i__1 = __f.i__1; in__1 = __f.in__1; jsIn = __f.jsIn; jsOut = __f.jsOut; out = __f.out; v = __f.v; v__1 = __f.v__1; variadic = __f.variadic; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if ( not (variadic)) { _v = false; __s = 3; continue s; end
		if (in__1.__length == 0) { _v__1 = true; __s = 4; continue s; end
		_r = (x = in__1.__length - 1 >> 0, ((x < 0  or  x >= in__1.__length) ? (__throwRuntimeError("index out of range"), nil) : in__1.__array[in__1.__offset + x])).Kind(); /* */ __s = 5; case 5: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_v__1 =  not ((_r == 23)); case 4:
		_v = _v__1; case 3:
		/* */ if (_v) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (_v) { */ case 1:
			__panic(new __String("reflect.FuncOf: last arg of variadic func must be slice"));
		/* end */ case 2:
		jsIn = __makeSlice(sliceType__8, in__1.__length);
		_ref = in__1;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			v = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			((i < 0  or  i >= jsIn.__length) ? (__throwRuntimeError("index out of range"), nil) : jsIn.__array[jsIn.__offset + i] = jsType(v));
			_i++;
		end
		jsOut = __makeSlice(sliceType__8, out.__length);
		_ref__1 = out;
		_i__1 = 0;
		while (true) {
			if ( not (_i__1 < _ref__1.__length)) { break; end
			i__1 = _i__1;
			v__1 = ((_i__1 < 0  or  _i__1 >= _ref__1.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref__1.__array[_ref__1.__offset + _i__1]);
			((i__1 < 0  or  i__1 >= jsOut.__length) ? (__throwRuntimeError("index out of range"), nil) : jsOut.__array[jsOut.__offset + i__1] = jsType(v__1));
			_i__1++;
		end
		__s = -1; return reflectType(__funcType(__externalize(jsIn, sliceType__8), __externalize(jsOut, sliceType__8), __externalize(variadic, __Bool)));
		/* */ end return; end if __f == nil then  __f = { __blk: FuncOf end; end __f._i = _i; __f._i__1 = _i__1; __f._r = _r; __f._ref = _ref; __f._ref__1 = _ref__1; __f._v = _v; __f._v__1 = _v__1; __f.i = i; __f.i__1 = i__1; __f.in__1 = in__1; __f.jsIn = jsIn; __f.jsOut = jsOut; __f.out = out; __f.v = v; __f.v__1 = v__1; __f.variadic = variadic; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.FuncOf = FuncOf;
	rtype.ptr.prototype.ptrTo = function()
		var t;
		t = this;
		return reflectType(__ptrType(jsType(t)));
	end;
	rtype.prototype.ptrTo = function() return this.__val.ptrTo(); end;
	SliceOf = function(t)
		var t;
		return reflectType(__sliceType(jsType(t)));
	end;
	__pkg.SliceOf = SliceOf;
	Zero = function(p)
		var _r, typ, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; typ = __f.typ; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeValue(typ, jsType(typ).zero(), 0); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Zero end; end __f._r = _r; __f.typ = typ; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.Zero = Zero;
	unsafe_New = function(p)
		var _1, typ;
		_1 = typ.Kind();
		if (_1 == (25)) {
			return (new (jsType(typ).ptr)());
		end else if (_1 == (17)) {
			return (jsType(typ).zero());
		end else {
			return (__newDataPointer(jsType(typ).zero(), jsType(typ.ptrTo())));
		end
	end;
	makeInt = function(t)
		var _1, _r, bits, f, ptr, t, typ, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; bits = __f.bits; f = __f.f; ptr = __f.ptr; t = __f.t; typ = __f.typ; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = t.common(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		typ = _r;
		ptr = unsafe_New(typ);
		_1 = typ.Kind();
		if (_1 == (3)) {
			(ptr).__set(((bits.__low << 24 >> 24)));
		end else if (_1 == (4)) {
			(ptr).__set(((bits.__low << 16 >> 16)));
		end else if ((_1 == (2))  or  (_1 == (5))) {
			(ptr).__set(((bits.__low >> 0)));
		end else if (_1 == (6)) {
			(ptr).__set((new __Int64(bits.__high, bits.__low)));
		end else if (_1 == (8)) {
			(ptr).__set(((bits.__low << 24 >>> 24)));
		end else if (_1 == (9)) {
			(ptr).__set(((bits.__low << 16 >>> 16)));
		end else if ((_1 == (7))  or  (_1 == (10))  or  (_1 == (12))) {
			(ptr).__set(((bits.__low >>> 0)));
		end else if (_1 == (11)) {
			(ptr).__set((bits));
		end
		__s = -1; return new Value.ptr(typ, ptr, (((f | 128) >>> 0) | ((typ.Kind() >>> 0))) >>> 0);
		/* */ end return; end if __f == nil then  __f = { __blk: makeInt end; end __f._1 = _1; __f._r = _r; __f.bits = bits; __f.f = f; __f.ptr = ptr; __f.t = t; __f.typ = typ; __f.__s = __s; __f.__r = __r; return __f;
	end;
	typedmemmove = function(c)
		var dst, src, t;
		dst.__set(src.__get());
	end;
	keyFor = function(y)
		var k, key, kv, t;
		kv = key;
		if ( not (kv.__get == nil)) {
			kv = kv.__get();
		end
		k = __internalize(jsType(t.Key()).keyFor(kv), __String);
		return [kv, k];
	end;
	mapaccess = function(y)
		var _tuple, entry, k, key, m, t;
		_tuple = keyFor(t, key);
		k = _tuple[1];
		entry = m[__externalize(k, __String)];
		if (entry == nil) {
			return 0;
		end
		return (__newDataPointer(entry.v, jsType(PtrTo(t.Elem()))));
	end;
	mapassign = function(l)
		var _r, _tuple, entry, et, jsVal, k, key, kv, m, newVal, t, val, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; entry = __f.entry; et = __f.et; jsVal = __f.jsVal; k = __f.k; key = __f.key; kv = __f.kv; m = __f.m; newVal = __f.newVal; t = __f.t; val = __f.val; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_tuple = keyFor(t, key);
		kv = _tuple[0];
		k = _tuple[1];
		jsVal = val.__get();
		et = t.Elem();
		_r = et.Kind(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		/* */ if (_r == 25) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (_r == 25) { */ case 1:
			newVal = jsType(et).zero();
			copyStruct(newVal, jsVal, et);
			jsVal = newVal;
		/* end */ case 2:
		entry = new (__global.Object)();
		entry.k = kv;
		entry.v = jsVal;
		m[__externalize(k, __String)] = entry;
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: mapassign end; end __f._r = _r; __f._tuple = _tuple; __f.entry = entry; __f.et = et; __f.jsVal = jsVal; __f.k = k; __f.key = key; __f.kv = kv; __f.m = m; __f.newVal = newVal; __f.t = t; __f.val = val; __f.__s = __s; __f.__r = __r; return __f;
	end;
	mapdelete = function(y)
		var _tuple, k, key, m, t;
		_tuple = keyFor(t, key);
		k = _tuple[1];
		delete m[__externalize(k, __String)];
	end;
	mapiterinit = function(m)
		var m, t;
		return ((new mapIter.ptr(t, m, __keys(m), 0)));
	end;
	mapiterkey = function(t)
		var _r, _r__1, _r__2, it, iter, k, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; it = __f.it; iter = __f.iter; k = __f.k; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		iter = ((it));
		k = iter.keys[iter.i];
		_r = iter.t.Key(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = PtrTo(_r); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_r__2 = jsType(_r__1); /* */ __s = 3; case 3: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		__s = -1; return (__newDataPointer(iter.m[__externalize(__internalize(k, __String), __String)].k, _r__2));
		/* */ end return; end if __f == nil then  __f = { __blk: mapiterkey end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f.it = it; __f.iter = iter; __f.k = k; __f.__s = __s; __f.__r = __r; return __f;
	end;
	mapiternext = function(t)
		var it, iter;
		iter = ((it));
		iter.i = iter.i + (1) >> 0;
	end;
	maplen = function(m)
		var m;
		return __parseInt(__keys(m).length);
	end;
	cvtDirect = function(p)
		var _1, _arg, _arg__1, _arg__2, _r, _r__1, _r__2, _r__3, _r__4, _r__5, _r__6, _r__7, k, slice, srcVal, typ, v, val, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _arg = __f._arg; _arg__1 = __f._arg__1; _arg__2 = __f._arg__2; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _r__6 = __f._r__6; _r__7 = __f._r__7; k = __f.k; slice = __f.slice; srcVal = __f.srcVal; typ = __f.typ; v = __f.v; val = __f.val; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		srcVal = __clone(v, Value).object();
		/* */ if (srcVal == jsType(v.typ).nil) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (srcVal == jsType(v.typ).nil) { */ case 1:
			_r = makeValue(typ, jsType(typ).nil, v.flag); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			__s = -1; return _r;
		/* end */ case 2:
		val = null;
			_r__1 = typ.Kind(); /* */ __s = 5; case 5: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			k = _r__1;
			_1 = k;
			/* */ if (_1 == (23)) { __s = 6; continue; end
			/* */ if (_1 == (22)) { __s = 7; continue; end
			/* */ if (_1 == (25)) { __s = 8; continue; end
			/* */ if ((_1 == (17))  or  (_1 == (1))  or  (_1 == (18))  or  (_1 == (19))  or  (_1 == (20))  or  (_1 == (21))  or  (_1 == (24))) { __s = 9; continue; end
			/* */ __s = 10; continue;
			/* if (_1 == (23)) { */ case 6:
				slice = new (jsType(typ))(srcVal.__array);
				slice.__offset = srcVal.__offset;
				slice.__length = srcVal.__length;
				slice.__capacity = srcVal.__capacity;
				val = __newDataPointer(slice, jsType(PtrTo(typ)));
				__s = 11; continue;
			/* end else if (_1 == (22)) { */ case 7:
				_r__2 = typ.Elem(); /* */ __s = 14; case 14: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				_r__3 = _r__2.Kind(); /* */ __s = 15; case 15: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
				/* */ if (_r__3 == 25) { __s = 12; continue; end
				/* */ __s = 13; continue;
				/* if (_r__3 == 25) { */ case 12:
					_r__4 = typ.Elem(); /* */ __s = 18; case 18: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
					/* */ if (__interfaceIsEqual(_r__4, v.typ.Elem())) { __s = 16; continue; end
					/* */ __s = 17; continue;
					/* if (__interfaceIsEqual(_r__4, v.typ.Elem())) { */ case 16:
						val = srcVal;
						/* break; */ __s = 4; continue;
					/* end */ case 17:
					val = new (jsType(typ))();
					_arg = val;
					_arg__1 = srcVal;
					_r__5 = typ.Elem(); /* */ __s = 19; case 19: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
					_arg__2 = _r__5;
					__r = copyStruct(_arg, _arg__1, _arg__2); /* */ __s = 20; case 20: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					/* break; */ __s = 4; continue;
				/* end */ case 13:
				val = new (jsType(typ))(srcVal.__get, srcVal.__set);
				__s = 11; continue;
			/* end else if (_1 == (25)) { */ case 8:
				val = new (jsType(typ).ptr)();
				copyStruct(val, srcVal, typ);
				__s = 11; continue;
			/* end else if ((_1 == (17))  or  (_1 == (1))  or  (_1 == (18))  or  (_1 == (19))  or  (_1 == (20))  or  (_1 == (21))  or  (_1 == (24))) { */ case 9:
				val = v.ptr;
				__s = 11; continue;
			/* end else { */ case 10:
				__panic(new ValueError.ptr("reflect.Convert", k));
			/* end */ case 11:
		case 4:
		_r__6 = typ.common(); /* */ __s = 21; case 21: if(__c) then __c = false; _r__6 = _r__6.__blk(); end if (_r__6  and  _r__6.__blk ~= nil) { break s; end
		_r__7 = typ.Kind(); /* */ __s = 22; case 22: if(__c) then __c = false; _r__7 = _r__7.__blk(); end if (_r__7  and  _r__7.__blk ~= nil) { break s; end
		__s = -1; return new Value.ptr(_r__6, (val), (((v.flag & 224) >>> 0) | ((_r__7 >>> 0))) >>> 0);
		/* */ end return; end if __f == nil then  __f = { __blk: cvtDirect end; end __f._1 = _1; __f._arg = _arg; __f._arg__1 = _arg__1; __f._arg__2 = _arg__2; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._r__6 = _r__6; __f._r__7 = _r__7; __f.k = k; __f.slice = slice; __f.srcVal = srcVal; __f.typ = typ; __f.v = v; __f.val = val; __f.__s = __s; __f.__r = __r; return __f;
	end;
	methodReceiver = function(i)
		var ___38, fn, i, m, m__1, op, prop, rcvr, t, tt, ut, v, x, x__1;
		___38 = ptrType__1.nil;
		t = ptrType__1.nil;
		fn = 0;
		prop = "";
		if (v.typ.Kind() == 20) {
			tt = (v.typ.kindType);
			if (i < 0  or  i >= tt.methods.__length) {
				__panic(new __String("reflect: internal error: invalid method index"));
			end
			m = (x = tt.methods, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
			if ( not __clone(tt.rtype.nameOff(m.name), name).isExported()) {
				__panic(new __String("reflect: " + op + " of unexported method"));
			end
			t = tt.rtype.typeOff(m.typ);
			prop = __clone(tt.rtype.nameOff(m.name), name).name();
		end else {
			ut = v.typ.uncommon();
			if (ut == ptrType__5.nil  or  ((i >>> 0)) >= ((ut.mcount >>> 0))) {
				__panic(new __String("reflect: internal error: invalid method index"));
			end
			m__1 = __clone((x__1 = ut.methods(), ((i < 0  or  i >= x__1.__length) ? (__throwRuntimeError("index out of range"), nil) : x__1.__array[x__1.__offset + i])), method);
			if ( not __clone(v.typ.nameOff(m__1.name), name).isExported()) {
				__panic(new __String("reflect: " + op + " of unexported method"));
			end
			t = v.typ.typeOff(m__1.mtyp);
			prop = __internalize(__methodSet(jsType(v.typ))[i].prop, __String);
		end
		rcvr = __clone(v, Value).object();
		if (isWrapped(v.typ)) {
			rcvr = new (jsType(v.typ))(rcvr);
		end
		fn = (rcvr[__externalize(prop, __String)]);
		return [___38, t, fn];
	end;
	valueInterface = function(e)
		var _r, safe, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; safe = __f.safe; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if (v.flag == 0) {
			__panic(new ValueError.ptr("reflect.Value.Interface", 0));
		end
		if (safe  and   not ((((v.flag & 96) >>> 0) == 0))) {
			__panic(new __String("reflect.Value.Interface: cannot return value obtained from unexported field or method"));
		end
		/* */ if ( not ((((v.flag & 512) >>> 0) == 0))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((((v.flag & 512) >>> 0) == 0))) { */ case 1:
			_r = makeMethodValue("Interface", __clone(v, Value)); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			v = _r;
		/* end */ case 2:
		if (isWrapped(v.typ)) {
			__s = -1; return ((new (jsType(v.typ))(__clone(v, Value).object())));
		end
		__s = -1; return ((__clone(v, Value).object()));
		/* */ end return; end if __f == nil then  __f = { __blk: valueInterface end; end __f._r = _r; __f.safe = safe; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ifaceE2I = function(t)
		var dst, src, t;
		dst.__set(src);
	end;
	methodName = function()
		return "?FIXME?";
	end;
	makeMethodValue = function(v)
		var _r, _tuple, fn, fv, op, rcvr, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; fn = __f.fn; fv = __f.fv; op = __f.op; rcvr = __f.rcvr; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		fn = [fn];
		rcvr = [rcvr];
		if (((v.flag & 512) >>> 0) == 0) {
			__panic(new __String("reflect: internal error: invalid use of makePartialFunc"));
		end
		_tuple = methodReceiver(op, __clone(v, Value), ((v.flag >> 0)) >> 10 >> 0);
		fn[0] = _tuple[2];
		rcvr[0] = __clone(v, Value).object();
		if (isWrapped(v.typ)) {
			rcvr[0] = new (jsType(v.typ))(rcvr[0]);
		end
		fv = js.MakeFunc((function(r) return function(1)
			var arguments__1, this__1;
			return new __jsObjectPtr(fn[0].apply(rcvr[0], __externalize(arguments__1, sliceType__8)));
		end; end)(fn, rcvr));
		_r = __clone(v, Value).Type().common(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return new Value.ptr(_r, (fv), (((v.flag & 96) >>> 0) | 19) >>> 0);
		/* */ end return; end if __f == nil then  __f = { __blk: makeMethodValue end; end __f._r = _r; __f._tuple = _tuple; __f.fn = fn; __f.fv = fv; __f.op = op; __f.rcvr = rcvr; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.ptr.prototype.pointers = function()
		var _1, t;
		t = this;
		_1 = t.Kind();
		if ((_1 == (22))  or  (_1 == (21))  or  (_1 == (18))  or  (_1 == (19))  or  (_1 == (25))  or  (_1 == (17))) {
			return true;
		end else {
			return false;
		end
	end;
	rtype.prototype.pointers = function() return this.__val.pointers(); end;
	rtype.ptr.prototype.Comparable = function()
		var _1, _r, _r__1, i, t, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; _r__1 = __f._r__1; i = __f.i; t = __f.t; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
			_1 = t.Kind();
			/* */ if ((_1 == (19))  or  (_1 == (23))  or  (_1 == (21))) { __s = 2; continue; end
			/* */ if (_1 == (17)) { __s = 3; continue; end
			/* */ if (_1 == (25)) { __s = 4; continue; end
			/* */ __s = 5; continue;
			/* if ((_1 == (19))  or  (_1 == (23))  or  (_1 == (21))) { */ case 2:
				__s = -1; return false;
			/* end else if (_1 == (17)) { */ case 3:
				_r = t.Elem().Comparable(); /* */ __s = 6; case 6: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__s = -1; return _r;
			/* end else if (_1 == (25)) { */ case 4:
				i = 0;
				/* while (true) { */ case 7:
					/* if ( not (i < t.NumField())) { break; end */ if( not (i < t.NumField())) { __s = 8; continue; end
					_r__1 = t.Field(i).Type.Comparable(); /* */ __s = 11; case 11: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
					/* */ if ( not _r__1) { __s = 9; continue; end
					/* */ __s = 10; continue;
					/* if ( not _r__1) { */ case 9:
						__s = -1; return false;
					/* end */ case 10:
					i = i + (1) >> 0;
				/* end */ __s = 7; continue; case 8:
			/* end */ case 5:
		case 1:
		__s = -1; return true;
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.Comparable end; end __f._1 = _1; __f._r = _r; __f._r__1 = _r__1; __f.i = i; __f.t = t; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.Comparable = function() return this.__val.Comparable(); end;
	rtype.ptr.prototype.Method = function(i)
		var _i, _i__1, _r, _r__1, _ref, _ref__1, arg, fl, fn, ft, i, in__1, m, methods, mt, mtyp, out, p, pname, prop, ret, t, tt, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _i__1 = __f._i__1; _r = __f._r; _r__1 = __f._r__1; _ref = __f._ref; _ref__1 = __f._ref__1; arg = __f.arg; fl = __f.fl; fn = __f.fn; ft = __f.ft; i = __f.i; in__1 = __f.in__1; m = __f.m; methods = __f.methods; mt = __f.mt; mtyp = __f.mtyp; out = __f.out; p = __f.p; pname = __f.pname; prop = __f.prop; ret = __f.ret; t = __f.t; tt = __f.tt; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		prop = [prop];
		m = new Method.ptr("", "", __ifaceNil, new Value.ptr(ptrType__1.nil, 0, 0), 0);
		t = this;
		if (t.Kind() == 20) {
			tt = (t.kindType);
			Method.copy(m, tt.Method(i));
			__s = -1; return m;
		end
		_r = t.exportedMethods(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		methods = _r;
		if (i < 0  or  i >= methods.__length) {
			__panic(new __String("reflect: Method index out of range"));
		end
		p = __clone(((i < 0  or  i >= methods.__length) ? (__throwRuntimeError("index out of range"), nil) : methods.__array[methods.__offset + i]), method);
		pname = __clone(t.nameOff(p.name), name);
		m.Name = __clone(pname, name).name();
		fl = 19;
		mtyp = t.typeOff(p.mtyp);
		ft = (mtyp.kindType);
		in__1 = __makeSlice(sliceType__10, 0, (1 + ft.in__().__length >> 0));
		in__1 = __append(in__1, t);
		_ref = ft.in__();
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			arg = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			in__1 = __append(in__1, arg);
			_i++;
		end
		out = __makeSlice(sliceType__10, 0, ft.out().__length);
		_ref__1 = ft.out();
		_i__1 = 0;
		while (true) {
			if ( not (_i__1 < _ref__1.__length)) { break; end
			ret = ((_i__1 < 0  or  _i__1 >= _ref__1.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref__1.__array[_ref__1.__offset + _i__1]);
			out = __append(out, ret);
			_i__1++;
		end
		_r__1 = FuncOf(in__1, out, ft.rtype.IsVariadic()); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		mt = _r__1;
		m.Type = mt;
		prop[0] = __internalize(__methodSet(t.jsType)[i].prop, __String);
		fn = js.MakeFunc((function(p) return function(1)
			var arguments__1, rcvr, this__1;
			rcvr = (0 >= arguments__1.__length ? (__throwRuntimeError("index out of range"), nil) : arguments__1.__array[arguments__1.__offset + 0]);
			return new __jsObjectPtr(rcvr[__externalize(prop[0], __String)].apply(rcvr, __externalize(__subslice(arguments__1, 1), sliceType__8)));
		end; end)(prop));
		m.Func = new Value.ptr(__assertType(mt, ptrType__1), (fn), fl);
		m.Index = i;
		Method.copy(m, m);
		__s = -1; return m;
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.Method end; end __f._i = _i; __f._i__1 = _i__1; __f._r = _r; __f._r__1 = _r__1; __f._ref = _ref; __f._ref__1 = _ref__1; __f.arg = arg; __f.fl = fl; __f.fn = fn; __f.ft = ft; __f.i = i; __f.in__1 = in__1; __f.m = m; __f.methods = methods; __f.mt = mt; __f.mtyp = mtyp; __f.out = out; __f.p = p; __f.pname = pname; __f.prop = prop; __f.ret = ret; __f.t = t; __f.tt = tt; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.Method = function(i) return this.__val.Method(i); end;
	Value.ptr.prototype.object = function()
		var _1, newVal, v, val;
		v = this;
		if ((v.typ.Kind() == 17)  or  (v.typ.Kind() == 25)) {
			return v.ptr;
		end
		if ( not ((((v.flag & 128) >>> 0) == 0))) {
			val = v.ptr.__get();
			if ( not (val == __ifaceNil)  and   not (val.constructor == jsType(v.typ))) {
				switch (0) { default:
					_1 = v.typ.Kind();
					if ((_1 == (11))  or  (_1 == (6))) {
						val = new (jsType(v.typ))(val.__high, val.__low);
					end else if ((_1 == (15))  or  (_1 == (16))) {
						val = new (jsType(v.typ))(val.__real, val.__imag);
					end else if (_1 == (23)) {
						if (val == val.constructor.nil) {
							val = jsType(v.typ).nil;
							break;
						end
						newVal = new (jsType(v.typ))(val.__array);
						newVal.__offset = val.__offset;
						newVal.__length = val.__length;
						newVal.__capacity = val.__capacity;
						val = newVal;
					end
				end
			end
			return val;
		end
		return v.ptr;
	end;
	Value.prototype.object = function() return this.__val.object(); end;
	Value.ptr.prototype.call = function(1)
		var _1, _arg, _arg__1, _arg__2, _arg__3, _i, _i__1, _i__2, _r, _r__1, _r__10, _r__11, _r__12, _r__13, _r__14, _r__15, _r__2, _r__3, _r__4, _r__5, _r__6, _r__7, _r__8, _r__9, _ref, _ref__1, _ref__2, _tmp, _tmp__1, _tuple, arg, argsArray, elem, fn, i, i__1, i__2, i__3, in__1, isSlice, m, n, nin, nout, op, origIn, rcvr, results, ret, slice, t, targ, v, x, x__1, x__2, xt, xt__1, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _arg = __f._arg; _arg__1 = __f._arg__1; _arg__2 = __f._arg__2; _arg__3 = __f._arg__3; _i = __f._i; _i__1 = __f._i__1; _i__2 = __f._i__2; _r = __f._r; _r__1 = __f._r__1; _r__10 = __f._r__10; _r__11 = __f._r__11; _r__12 = __f._r__12; _r__13 = __f._r__13; _r__14 = __f._r__14; _r__15 = __f._r__15; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _r__6 = __f._r__6; _r__7 = __f._r__7; _r__8 = __f._r__8; _r__9 = __f._r__9; _ref = __f._ref; _ref__1 = __f._ref__1; _ref__2 = __f._ref__2; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; arg = __f.arg; argsArray = __f.argsArray; elem = __f.elem; fn = __f.fn; i = __f.i; i__1 = __f.i__1; i__2 = __f.i__2; i__3 = __f.i__3; in__1 = __f.in__1; isSlice = __f.isSlice; m = __f.m; n = __f.n; nin = __f.nin; nout = __f.nout; op = __f.op; origIn = __f.origIn; rcvr = __f.rcvr; results = __f.results; ret = __f.ret; slice = __f.slice; t = __f.t; targ = __f.targ; v = __f.v; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; xt = __f.xt; xt__1 = __f.xt__1; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		t = ptrType__1.nil;
		fn = 0;
		rcvr = null;
		if ( not ((((v.flag & 512) >>> 0) == 0))) {
			_tuple = methodReceiver(op, __clone(v, Value), ((v.flag >> 0)) >> 10 >> 0);
			t = _tuple[1];
			fn = _tuple[2];
			rcvr = __clone(v, Value).object();
			if (isWrapped(v.typ)) {
				rcvr = new (jsType(v.typ))(rcvr);
			end
		end else {
			t = v.typ;
			fn = (__clone(v, Value).object());
			rcvr = nil;
		end
		if (fn == 0) {
			__panic(new __String("reflect.Value.Call: call of nil function"));
		end
		isSlice = op == "CallSlice";
		n = t.NumIn();
		if (isSlice) {
			if ( not t.IsVariadic()) {
				__panic(new __String("reflect: CallSlice of non-variadic function"));
			end
			if (in__1.__length < n) {
				__panic(new __String("reflect: CallSlice with too few input arguments"));
			end
			if (in__1.__length > n) {
				__panic(new __String("reflect: CallSlice with too many input arguments"));
			end
		end else {
			if (t.IsVariadic()) {
				n = n - (1) >> 0;
			end
			if (in__1.__length < n) {
				__panic(new __String("reflect: Call with too few input arguments"));
			end
			if ( not t.IsVariadic()  and  in__1.__length > n) {
				__panic(new __String("reflect: Call with too many input arguments"));
			end
		end
		_ref = in__1;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			x = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			if (__clone(x, Value).Kind() == 0) {
				__panic(new __String("reflect: " + op + " using zero Value argument"));
			end
			_i++;
		end
		i = 0;
		/* while (true) { */ case 1:
			/* if ( not (i < n)) { break; end */ if( not (i < n)) { __s = 2; continue; end
			_tmp = __clone(((i < 0  or  i >= in__1.__length) ? (__throwRuntimeError("index out of range"), nil) : in__1.__array[in__1.__offset + i]), Value).Type();
			_tmp__1 = t.In(i);
			xt = _tmp;
			targ = _tmp__1;
			_r = xt.AssignableTo(targ); /* */ __s = 5; case 5: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			/* */ if ( not _r) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if ( not _r) { */ case 3:
				_r__1 = xt.String(); /* */ __s = 6; case 6: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				_r__2 = targ.String(); /* */ __s = 7; case 7: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				__panic(new __String("reflect: " + op + " using " + _r__1 + " as type " + _r__2));
			/* end */ case 4:
			i = i + (1) >> 0;
		/* end */ __s = 1; continue; case 2:
		/* */ if ( not isSlice  and  t.IsVariadic()) { __s = 8; continue; end
		/* */ __s = 9; continue;
		/* if ( not isSlice  and  t.IsVariadic()) { */ case 8:
			m = in__1.__length - n >> 0;
			_r__3 = MakeSlice(t.In(n), m, m); /* */ __s = 10; case 10: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
			slice = _r__3;
			_r__4 = t.In(n).Elem(); /* */ __s = 11; case 11: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
			elem = _r__4;
			i__1 = 0;
			/* while (true) { */ case 12:
				/* if ( not (i__1 < m)) { break; end */ if( not (i__1 < m)) { __s = 13; continue; end
				x__2 = (x__1 = n + i__1 >> 0, ((x__1 < 0  or  x__1 >= in__1.__length) ? (__throwRuntimeError("index out of range"), nil) : in__1.__array[in__1.__offset + x__1]));
				xt__1 = __clone(x__2, Value).Type();
				_r__5 = xt__1.AssignableTo(elem); /* */ __s = 16; case 16: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
				/* */ if ( not _r__5) { __s = 14; continue; end
				/* */ __s = 15; continue;
				/* if ( not _r__5) { */ case 14:
					_r__6 = xt__1.String(); /* */ __s = 17; case 17: if(__c) then __c = false; _r__6 = _r__6.__blk(); end if (_r__6  and  _r__6.__blk ~= nil) { break s; end
					_r__7 = elem.String(); /* */ __s = 18; case 18: if(__c) then __c = false; _r__7 = _r__7.__blk(); end if (_r__7  and  _r__7.__blk ~= nil) { break s; end
					__panic(new __String("reflect: cannot use " + _r__6 + " as type " + _r__7 + " in " + op));
				/* end */ case 15:
				_r__8 = __clone(slice, Value).Index(i__1); /* */ __s = 19; case 19: if(__c) then __c = false; _r__8 = _r__8.__blk(); end if (_r__8  and  _r__8.__blk ~= nil) { break s; end
				__r = __clone(_r__8, Value).Set(__clone(x__2, Value)); /* */ __s = 20; case 20: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				i__1 = i__1 + (1) >> 0;
			/* end */ __s = 12; continue; case 13:
			origIn = in__1;
			in__1 = __makeSlice(sliceType__9, (n + 1 >> 0));
			__copySlice(__subslice(in__1, 0, n), origIn);
			((n < 0  or  n >= in__1.__length) ? (__throwRuntimeError("index out of range"), nil) : in__1.__array[in__1.__offset + n] = slice);
		/* end */ case 9:
		nin = in__1.__length;
		if ( not ((nin == t.NumIn()))) {
			__panic(new __String("reflect.Value.Call: wrong argument count"));
		end
		nout = t.NumOut();
		argsArray = new (__global.Array)(t.NumIn());
		_ref__1 = in__1;
		_i__1 = 0;
		/* while (true) { */ case 21:
			/* if ( not (_i__1 < _ref__1.__length)) { break; end */ if( not (_i__1 < _ref__1.__length)) { __s = 22; continue; end
			i__2 = _i__1;
			arg = ((_i__1 < 0  or  _i__1 >= _ref__1.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref__1.__array[_ref__1.__offset + _i__1]);
			_arg = t.In(i__2);
			_r__9 = t.In(i__2).common(); /* */ __s = 23; case 23: if(__c) then __c = false; _r__9 = _r__9.__blk(); end if (_r__9  and  _r__9.__blk ~= nil) { break s; end
			_arg__1 = _r__9;
			_arg__2 = 0;
			_r__10 = __clone(arg, Value).assignTo("reflect.Value.Call", _arg__1, _arg__2); /* */ __s = 24; case 24: if(__c) then __c = false; _r__10 = _r__10.__blk(); end if (_r__10  and  _r__10.__blk ~= nil) { break s; end
			_r__11 = __clone(_r__10, Value).object(); /* */ __s = 25; case 25: if(__c) then __c = false; _r__11 = _r__11.__blk(); end if (_r__11  and  _r__11.__blk ~= nil) { break s; end
			_arg__3 = _r__11;
			_r__12 = unwrapJsObject(_arg, _arg__3); /* */ __s = 26; case 26: if(__c) then __c = false; _r__12 = _r__12.__blk(); end if (_r__12  and  _r__12.__blk ~= nil) { break s; end
			argsArray[i__2] = _r__12;
			_i__1++;
		/* end */ __s = 21; continue; case 22:
		_r__13 = callHelper(new sliceType__3([new __jsObjectPtr(fn), new __jsObjectPtr(rcvr), new __jsObjectPtr(argsArray)])); /* */ __s = 27; case 27: if(__c) then __c = false; _r__13 = _r__13.__blk(); end if (_r__13  and  _r__13.__blk ~= nil) { break s; end
		results = _r__13;
			_1 = nout;
			/* */ if (_1 == (0)) { __s = 29; continue; end
			/* */ if (_1 == (1)) { __s = 30; continue; end
			/* */ __s = 31; continue;
			/* if (_1 == (0)) { */ case 29:
				__s = -1; return sliceType__9.nil;
			/* end else if (_1 == (1)) { */ case 30:
				_r__14 = makeValue(t.Out(0), wrapJsObject(t.Out(0), results), 0); /* */ __s = 33; case 33: if(__c) then __c = false; _r__14 = _r__14.__blk(); end if (_r__14  and  _r__14.__blk ~= nil) { break s; end
				__s = -1; return new sliceType__9([__clone(_r__14, Value)]);
			/* end else { */ case 31:
				ret = __makeSlice(sliceType__9, nout);
				_ref__2 = ret;
				_i__2 = 0;
				/* while (true) { */ case 34:
					/* if ( not (_i__2 < _ref__2.__length)) { break; end */ if( not (_i__2 < _ref__2.__length)) { __s = 35; continue; end
					i__3 = _i__2;
					_r__15 = makeValue(t.Out(i__3), wrapJsObject(t.Out(i__3), results[i__3]), 0); /* */ __s = 36; case 36: if(__c) then __c = false; _r__15 = _r__15.__blk(); end if (_r__15  and  _r__15.__blk ~= nil) { break s; end
					((i__3 < 0  or  i__3 >= ret.__length) ? (__throwRuntimeError("index out of range"), nil) : ret.__array[ret.__offset + i__3] = _r__15);
					_i__2++;
				/* end */ __s = 34; continue; case 35:
				__s = -1; return ret;
			/* end */ case 32:
		case 28:
		__s = -1; return sliceType__9.nil;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.call end; end __f._1 = _1; __f._arg = _arg; __f._arg__1 = _arg__1; __f._arg__2 = _arg__2; __f._arg__3 = _arg__3; __f._i = _i; __f._i__1 = _i__1; __f._i__2 = _i__2; __f._r = _r; __f._r__1 = _r__1; __f._r__10 = _r__10; __f._r__11 = _r__11; __f._r__12 = _r__12; __f._r__13 = _r__13; __f._r__14 = _r__14; __f._r__15 = _r__15; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._r__6 = _r__6; __f._r__7 = _r__7; __f._r__8 = _r__8; __f._r__9 = _r__9; __f._ref = _ref; __f._ref__1 = _ref__1; __f._ref__2 = _ref__2; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.arg = arg; __f.argsArray = argsArray; __f.elem = elem; __f.fn = fn; __f.i = i; __f.i__1 = i__1; __f.i__2 = i__2; __f.i__3 = i__3; __f.in__1 = in__1; __f.isSlice = isSlice; __f.m = m; __f.n = n; __f.nin = nin; __f.nout = nout; __f.op = op; __f.origIn = origIn; __f.rcvr = rcvr; __f.results = results; __f.ret = ret; __f.slice = slice; __f.t = t; __f.targ = targ; __f.v = v; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.xt = xt; __f.xt__1 = xt__1; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.call = function(1) return this.__val.call(op, in__1); end;
	Value.ptr.prototype.Cap = function()
		var _1, k, v;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (17)) {
			return v.typ.Len();
		end else if ((_1 == (18))  or  (_1 == (23))) {
			return __parseInt(__clone(v, Value).object().__capacity) >> 0;
		end
		__panic(new ValueError.ptr("reflect.Value.Cap", k));
	end;
	Value.prototype.Cap = function() return this.__val.Cap(); end;
	wrapJsObject = function(l)
		var typ, val;
		if (__interfaceIsEqual(typ, jsObjectPtr)) {
			return new (jsType(jsObjectPtr))(val);
		end
		return val;
	end;
	unwrapJsObject = function(l)
		var typ, val;
		if (__interfaceIsEqual(typ, jsObjectPtr)) {
			return val.object;
		end
		return val;
	end;
	Value.ptr.prototype.Elem = function()
		var _1, _r, fl, k, tt, typ, v, val, val__1, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; fl = __f.fl; k = __f.k; tt = __f.tt; typ = __f.typ; v = __f.v; val = __f.val; val__1 = __f.val__1; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
			k = new flag(v.flag).kind();
			_1 = k;
			/* */ if (_1 == (20)) { __s = 2; continue; end
			/* */ if (_1 == (22)) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if (_1 == (20)) { */ case 2:
				val = __clone(v, Value).object();
				if (val == __ifaceNil) {
					__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
				end
				typ = reflectType(val.constructor);
				_r = makeValue(typ, val.__val, (v.flag & 96) >>> 0); /* */ __s = 6; case 6: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__s = -1; return _r;
			/* end else if (_1 == (22)) { */ case 3:
				if (__clone(v, Value).IsNil()) {
					__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
				end
				val__1 = __clone(v, Value).object();
				tt = (v.typ.kindType);
				fl = (((((v.flag & 96) >>> 0) | 128) >>> 0) | 256) >>> 0;
				fl = (fl | (((tt.elem.Kind() >>> 0)))) >>> 0;
				__s = -1; return new Value.ptr(tt.elem, (wrapJsObject(tt.elem, val__1)), fl);
			/* end else { */ case 4:
				__panic(new ValueError.ptr("reflect.Value.Elem", k));
			/* end */ case 5:
		case 1:
		__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Elem end; end __f._1 = _1; __f._r = _r; __f.fl = fl; __f.k = k; __f.tt = tt; __f.typ = typ; __f.v = v; __f.val = val; __f.val__1 = val__1; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Elem = function() return this.__val.Elem(); end;
	Value.ptr.prototype.Field = function(i)
		var _r, _r__1, _r__2, field, fl, i, jsTag, o, prop, s, tag, tt, typ, v, x, x__1, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; field = __f.field; fl = __f.fl; i = __f.i; jsTag = __f.jsTag; o = __f.o; prop = __f.prop; s = __f.s; tag = __f.tag; tt = __f.tt; typ = __f.typ; v = __f.v; x = __f.x; x__1 = __f.x__1; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		jsTag = [jsTag];
		prop = [prop];
		s = [s];
		typ = [typ];
		v = this;
		if ( not ((new flag(v.flag).kind() == 25))) {
			__panic(new ValueError.ptr("reflect.Value.Field", new flag(v.flag).kind()));
		end
		tt = (v.typ.kindType);
		if (((i >>> 0)) >= ((tt.fields.__length >>> 0))) {
			__panic(new __String("reflect: Field index out of range"));
		end
		prop[0] = __internalize(jsType(v.typ).fields[i].prop, __String);
		field = (x = tt.fields, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
		typ[0] = field.typ;
		fl = (((v.flag & 416) >>> 0) | ((typ[0].Kind() >>> 0))) >>> 0;
		if ( not __clone(field.name, name).isExported()) {
			if (field.anon()) {
				fl = (fl | (64)) >>> 0;
			end else {
				fl = (fl | (32)) >>> 0;
			end
		end
		tag = __clone((x__1 = tt.fields, ((i < 0  or  i >= x__1.__length) ? (__throwRuntimeError("index out of range"), nil) : x__1.__array[x__1.__offset + i])).name, name).tag();
		/* */ if ( not (tag == "")  and   not ((i == 0))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not (tag == "")  and   not ((i == 0))) { */ case 1:
			jsTag[0] = getJsTag(tag);
			/* */ if ( not (jsTag[0] == "")) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if ( not (jsTag[0] == "")) { */ case 3:
				/* while (true) { */ case 5:
					o = [o];
					_r = __clone(v, Value).Field(0); /* */ __s = 7; case 7: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
					v = _r;
					/* */ if (v.typ == jsObjectPtr) { __s = 8; continue; end
					/* */ __s = 9; continue;
					/* if (v.typ == jsObjectPtr) { */ case 8:
						o[0] = __clone(v, Value).object().object;
						__s = -1; return new Value.ptr(typ[0], (new (jsType(PtrTo(typ[0])))((function(p) return function()
							return __internalize(o[0][__externalize(jsTag[0], __String)], jsType(typ[0]));
						end; end)(jsTag, o, prop, s, typ), (function(p) return function(2)
							var x__2;
							o[0][__externalize(jsTag[0], __String)] = __externalize(x__2, jsType(typ[0]));
						end; end)(jsTag, o, prop, s, typ))), fl);
					/* end */ case 9:
					/* */ if (v.typ.Kind() == 22) { __s = 10; continue; end
					/* */ __s = 11; continue;
					/* if (v.typ.Kind() == 22) { */ case 10:
						_r__1 = __clone(v, Value).Elem(); /* */ __s = 12; case 12: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
						v = _r__1;
					/* end */ case 11:
				/* end */ __s = 5; continue; case 6:
			/* end */ case 4:
		/* end */ case 2:
		s[0] = v.ptr;
		/* */ if ( not ((((fl & 128) >>> 0) == 0))  and   not ((typ[0].Kind() == 17))  and   not ((typ[0].Kind() == 25))) { __s = 13; continue; end
		/* */ __s = 14; continue;
		/* if ( not ((((fl & 128) >>> 0) == 0))  and   not ((typ[0].Kind() == 17))  and   not ((typ[0].Kind() == 25))) { */ case 13:
			__s = -1; return new Value.ptr(typ[0], (new (jsType(PtrTo(typ[0])))((function(p) return function()
				return wrapJsObject(typ[0], s[0][__externalize(prop[0], __String)]);
			end; end)(jsTag, prop, s, typ), (function(p) return function(2)
				var x__2;
				s[0][__externalize(prop[0], __String)] = unwrapJsObject(typ[0], x__2);
			end; end)(jsTag, prop, s, typ))), fl);
		/* end */ case 14:
		_r__2 = makeValue(typ[0], wrapJsObject(typ[0], s[0][__externalize(prop[0], __String)]), fl); /* */ __s = 15; case 15: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		__s = -1; return _r__2;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Field end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f.field = field; __f.fl = fl; __f.i = i; __f.jsTag = jsTag; __f.o = o; __f.prop = prop; __f.s = s; __f.tag = tag; __f.tt = tt; __f.typ = typ; __f.v = v; __f.x = x; __f.x__1 = x__1; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Field = function(i) return this.__val.Field(i); end;
	getJsTag = function(g)
		var _tuple, i, name__1, qvalue, tag, value;
		while (true) {
			if ( not ( not (tag == ""))) { break; end
			i = 0;
			while (true) {
				if ( not (i < tag.length  and  (tag.charCodeAt(i) == 32))) { break; end
				i = i + (1) >> 0;
			end
			tag = __substring(tag, i);
			if (tag == "") {
				break;
			end
			i = 0;
			while (true) {
				if ( not (i < tag.length  and   not ((tag.charCodeAt(i) == 32))  and   not ((tag.charCodeAt(i) == 58))  and   not ((tag.charCodeAt(i) == 34)))) { break; end
				i = i + (1) >> 0;
			end
			if ((i + 1 >> 0) >= tag.length  or   not ((tag.charCodeAt(i) == 58))  or   not ((tag.charCodeAt((i + 1 >> 0)) == 34))) {
				break;
			end
			name__1 = (__substring(tag, 0, i));
			tag = __substring(tag, (i + 1 >> 0));
			i = 1;
			while (true) {
				if ( not (i < tag.length  and   not ((tag.charCodeAt(i) == 34)))) { break; end
				if (tag.charCodeAt(i) == 92) {
					i = i + (1) >> 0;
				end
				i = i + (1) >> 0;
			end
			if (i >= tag.length) {
				break;
			end
			qvalue = (__substring(tag, 0, (i + 1 >> 0)));
			tag = __substring(tag, (i + 1 >> 0));
			if (name__1 == "js") {
				_tuple = strconv.Unquote(qvalue);
				value = _tuple[0];
				return value;
			end
		end
		return "";
	end;
	Value.ptr.prototype.Index = function(i)
		var _1, _r, _r__1, a, a__1, c, fl, fl__1, fl__2, i, k, s, str, tt, tt__1, typ, typ__1, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; _r__1 = __f._r__1; a = __f.a; a__1 = __f.a__1; c = __f.c; fl = __f.fl; fl__1 = __f.fl__1; fl__2 = __f.fl__2; i = __f.i; k = __f.k; s = __f.s; str = __f.str; tt = __f.tt; tt__1 = __f.tt__1; typ = __f.typ; typ__1 = __f.typ__1; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		a = [a];
		a__1 = [a__1];
		c = [c];
		i = [i];
		typ = [typ];
		typ__1 = [typ__1];
		v = this;
			k = new flag(v.flag).kind();
			_1 = k;
			/* */ if (_1 == (17)) { __s = 2; continue; end
			/* */ if (_1 == (23)) { __s = 3; continue; end
			/* */ if (_1 == (24)) { __s = 4; continue; end
			/* */ __s = 5; continue;
			/* if (_1 == (17)) { */ case 2:
				tt = (v.typ.kindType);
				if (i[0] < 0  or  i[0] > ((tt.len >> 0))) {
					__panic(new __String("reflect: array index out of range"));
				end
				typ[0] = tt.elem;
				fl = (v.flag & 480) >>> 0;
				fl = (fl | (((typ[0].Kind() >>> 0)))) >>> 0;
				a[0] = v.ptr;
				/* */ if ( not ((((fl & 128) >>> 0) == 0))  and   not ((typ[0].Kind() == 17))  and   not ((typ[0].Kind() == 25))) { __s = 7; continue; end
				/* */ __s = 8; continue;
				/* if ( not ((((fl & 128) >>> 0) == 0))  and   not ((typ[0].Kind() == 17))  and   not ((typ[0].Kind() == 25))) { */ case 7:
					__s = -1; return new Value.ptr(typ[0], (new (jsType(PtrTo(typ[0])))((function(1) return function()
						return wrapJsObject(typ[0], a[0][i[0]]);
					end; end)(a, a__1, c, i, typ, typ__1), (function(1) return function(x)
						var x;
						a[0][i[0]] = unwrapJsObject(typ[0], x);
					end; end)(a, a__1, c, i, typ, typ__1))), fl);
				/* end */ case 8:
				_r = makeValue(typ[0], wrapJsObject(typ[0], a[0][i[0]]), fl); /* */ __s = 9; case 9: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__s = -1; return _r;
			/* end else if (_1 == (23)) { */ case 3:
				s = __clone(v, Value).object();
				if (i[0] < 0  or  i[0] >= (__parseInt(s.__length) >> 0)) {
					__panic(new __String("reflect: slice index out of range"));
				end
				tt__1 = (v.typ.kindType);
				typ__1[0] = tt__1.elem;
				fl__1 = (384 | ((v.flag & 96) >>> 0)) >>> 0;
				fl__1 = (fl__1 | (((typ__1[0].Kind() >>> 0)))) >>> 0;
				i[0] = i[0] + ((__parseInt(s.__offset) >> 0)) >> 0;
				a__1[0] = s.__array;
				/* */ if ( not ((((fl__1 & 128) >>> 0) == 0))  and   not ((typ__1[0].Kind() == 17))  and   not ((typ__1[0].Kind() == 25))) { __s = 10; continue; end
				/* */ __s = 11; continue;
				/* if ( not ((((fl__1 & 128) >>> 0) == 0))  and   not ((typ__1[0].Kind() == 17))  and   not ((typ__1[0].Kind() == 25))) { */ case 10:
					__s = -1; return new Value.ptr(typ__1[0], (new (jsType(PtrTo(typ__1[0])))((function(1) return function()
						return wrapJsObject(typ__1[0], a__1[0][i[0]]);
					end; end)(a, a__1, c, i, typ, typ__1), (function(1) return function(x)
						var x;
						a__1[0][i[0]] = unwrapJsObject(typ__1[0], x);
					end; end)(a, a__1, c, i, typ, typ__1))), fl__1);
				/* end */ case 11:
				_r__1 = makeValue(typ__1[0], wrapJsObject(typ__1[0], a__1[0][i[0]]), fl__1); /* */ __s = 12; case 12: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				__s = -1; return _r__1;
			/* end else if (_1 == (24)) { */ case 4:
				str = (v.ptr).__get();
				if (i[0] < 0  or  i[0] >= str.length) {
					__panic(new __String("reflect: string index out of range"));
				end
				fl__2 = (((v.flag & 96) >>> 0) | 8) >>> 0;
				c[0] = str.charCodeAt(i[0]);
				__s = -1; return new Value.ptr(uint8Type, ((c.__ptr  or  (c.__ptr = new ptrType__4(function() return this.__target[0]; end, function(v) this.__target[0] = __v; end, c)))), (fl__2 | 128) >>> 0);
			/* end else { */ case 5:
				__panic(new ValueError.ptr("reflect.Value.Index", k));
			/* end */ case 6:
		case 1:
		__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Index end; end __f._1 = _1; __f._r = _r; __f._r__1 = _r__1; __f.a = a; __f.a__1 = a__1; __f.c = c; __f.fl = fl; __f.fl__1 = fl__1; __f.fl__2 = fl__2; __f.i = i; __f.k = k; __f.s = s; __f.str = str; __f.tt = tt; __f.tt__1 = tt__1; __f.typ = typ; __f.typ__1 = typ__1; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Index = function(i) return this.__val.Index(i); end;
	Value.ptr.prototype.InterfaceData = function()
		var v;
		v = this;
		__panic(errors.New("InterfaceData is not supported by GopherJS"));
	end;
	Value.prototype.InterfaceData = function() return this.__val.InterfaceData(); end;
	Value.ptr.prototype.IsNil = function()
		var _1, k, v;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if ((_1 == (22))  or  (_1 == (23))) {
			return __clone(v, Value).object() == jsType(v.typ).nil;
		end else if (_1 == (18)) {
			return __clone(v, Value).object() == __chanNil;
		end else if (_1 == (19)) {
			return __clone(v, Value).object() == __throwNilPointerError;
		end else if (_1 == (21)) {
			return __clone(v, Value).object() == false;
		end else if (_1 == (20)) {
			return __clone(v, Value).object() == __ifaceNil;
		end else {
			__panic(new ValueError.ptr("reflect.Value.IsNil", k));
		end
	end;
	Value.prototype.IsNil = function() return this.__val.IsNil(); end;
	Value.ptr.prototype.Len = function()
		var _1, k, v;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if ((_1 == (17))  or  (_1 == (24))) {
			return __parseInt(__clone(v, Value).object().length);
		end else if (_1 == (23)) {
			return __parseInt(__clone(v, Value).object().__length) >> 0;
		end else if (_1 == (18)) {
			return __parseInt(__clone(v, Value).object().__buffer.length) >> 0;
		end else if (_1 == (21)) {
			return __parseInt(__keys(__clone(v, Value).object()).length);
		end else {
			__panic(new ValueError.ptr("reflect.Value.Len", k));
		end
	end;
	Value.prototype.Len = function() return this.__val.Len(); end;
	Value.ptr.prototype.Pointer = function()
		var _1, k, v;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if ((_1 == (18))  or  (_1 == (21))  or  (_1 == (22))  or  (_1 == (26))) {
			if (__clone(v, Value).IsNil()) {
				return 0;
			end
			return __clone(v, Value).object();
		end else if (_1 == (19)) {
			if (__clone(v, Value).IsNil()) {
				return 0;
			end
			return 1;
		end else if (_1 == (23)) {
			if (__clone(v, Value).IsNil()) {
				return 0;
			end
			return __clone(v, Value).object().__array;
		end else {
			__panic(new ValueError.ptr("reflect.Value.Pointer", k));
		end
	end;
	Value.prototype.Pointer = function() return this.__val.Pointer(); end;
	Value.ptr.prototype.Set = function(x)
		var _1, _r, _r__1, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; _r__1 = __f._r__1; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(x.flag).mustBeExported();
		_r = __clone(x, Value).assignTo("reflect.Set", v.typ, 0); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		x = _r;
		/* */ if ( not ((((v.flag & 128) >>> 0) == 0))) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if ( not ((((v.flag & 128) >>> 0) == 0))) { */ case 2:
				_1 = v.typ.Kind();
				/* */ if (_1 == (17)) { __s = 5; continue; end
				/* */ if (_1 == (20)) { __s = 6; continue; end
				/* */ if (_1 == (25)) { __s = 7; continue; end
				/* */ __s = 8; continue;
				/* if (_1 == (17)) { */ case 5:
					jsType(v.typ).copy(v.ptr, x.ptr);
					__s = 9; continue;
				/* end else if (_1 == (20)) { */ case 6:
					_r__1 = valueInterface(__clone(x, Value), false); /* */ __s = 10; case 10: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
					v.ptr.__set(_r__1);
					__s = 9; continue;
				/* end else if (_1 == (25)) { */ case 7:
					copyStruct(v.ptr, x.ptr, v.typ);
					__s = 9; continue;
				/* end else { */ case 8:
					v.ptr.__set(__clone(x, Value).object());
				/* end */ case 9:
			case 4:
			__s = -1; return;
		/* end */ case 3:
		v.ptr = x.ptr;
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Set end; end __f._1 = _1; __f._r = _r; __f._r__1 = _r__1; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Set = function(x) return this.__val.Set(x); end;
	Value.ptr.prototype.SetBytes = function(x)
		var _r, _r__1, _v, slice, typedSlice, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _v = __f._v; slice = __f.slice; typedSlice = __f.typedSlice; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(v.flag).mustBe(23);
		_r = v.typ.Elem().Kind(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		/* */ if ( not ((_r == 8))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((_r == 8))) { */ case 1:
			__panic(new __String("reflect.Value.SetBytes of non-byte slice"));
		/* end */ case 2:
		slice = x;
		if ( not (v.typ.Name() == "")) { _v = true; __s = 6; continue s; end
		_r__1 = v.typ.Elem().Name(); /* */ __s = 7; case 7: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_v =  not (_r__1 == ""); case 6:
		/* */ if (_v) { __s = 4; continue; end
		/* */ __s = 5; continue;
		/* if (_v) { */ case 4:
			typedSlice = new (jsType(v.typ))(slice.__array);
			typedSlice.__offset = slice.__offset;
			typedSlice.__length = slice.__length;
			typedSlice.__capacity = slice.__capacity;
			slice = typedSlice;
		/* end */ case 5:
		v.ptr.__set(slice);
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.SetBytes end; end __f._r = _r; __f._r__1 = _r__1; __f._v = _v; __f.slice = slice; __f.typedSlice = typedSlice; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.SetBytes = function(x) return this.__val.SetBytes(x); end;
	Value.ptr.prototype.SetCap = function(n)
		var n, newSlice, s, v;
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(v.flag).mustBe(23);
		s = v.ptr.__get();
		if (n < (__parseInt(s.__length) >> 0)  or  n > (__parseInt(s.__capacity) >> 0)) {
			__panic(new __String("reflect: slice capacity out of range in SetCap"));
		end
		newSlice = new (jsType(v.typ))(s.__array);
		newSlice.__offset = s.__offset;
		newSlice.__length = s.__length;
		newSlice.__capacity = n;
		v.ptr.__set(newSlice);
	end;
	Value.prototype.SetCap = function(n) return this.__val.SetCap(n); end;
	Value.ptr.prototype.SetLen = function(n)
		var n, newSlice, s, v;
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(v.flag).mustBe(23);
		s = v.ptr.__get();
		if (n < 0  or  n > (__parseInt(s.__capacity) >> 0)) {
			__panic(new __String("reflect: slice length out of range in SetLen"));
		end
		newSlice = new (jsType(v.typ))(s.__array);
		newSlice.__offset = s.__offset;
		newSlice.__length = n;
		newSlice.__capacity = s.__capacity;
		v.ptr.__set(newSlice);
	end;
	Value.prototype.SetLen = function(n) return this.__val.SetLen(n); end;
	Value.ptr.prototype.Slice = function(j)
		var _1, _r, _r__1, cap, i, j, kind, s, str, tt, typ, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; _r__1 = __f._r__1; cap = __f.cap; i = __f.i; j = __f.j; kind = __f.kind; s = __f.s; str = __f.str; tt = __f.tt; typ = __f.typ; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		cap = 0;
		typ = __ifaceNil;
		s = null;
			kind = new flag(v.flag).kind();
			_1 = kind;
			/* */ if (_1 == (17)) { __s = 2; continue; end
			/* */ if (_1 == (23)) { __s = 3; continue; end
			/* */ if (_1 == (24)) { __s = 4; continue; end
			/* */ __s = 5; continue;
			/* if (_1 == (17)) { */ case 2:
				if (((v.flag & 256) >>> 0) == 0) {
					__panic(new __String("reflect.Value.Slice: slice of unaddressable array"));
				end
				tt = (v.typ.kindType);
				cap = ((tt.len >> 0));
				typ = SliceOf(tt.elem);
				s = new (jsType(typ))(__clone(v, Value).object());
				__s = 6; continue;
			/* end else if (_1 == (23)) { */ case 3:
				typ = v.typ;
				s = __clone(v, Value).object();
				cap = __parseInt(s.__capacity) >> 0;
				__s = 6; continue;
			/* end else if (_1 == (24)) { */ case 4:
				str = (v.ptr).__get();
				if (i < 0  or  j < i  or  j > str.length) {
					__panic(new __String("reflect.Value.Slice: string slice index out of bounds"));
				end
				_r = ValueOf(new __String(__substring(str, i, j))); /* */ __s = 7; case 7: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__s = -1; return _r;
			/* end else { */ case 5:
				__panic(new ValueError.ptr("reflect.Value.Slice", kind));
			/* end */ case 6:
		case 1:
		if (i < 0  or  j < i  or  j > cap) {
			__panic(new __String("reflect.Value.Slice: slice index out of bounds"));
		end
		_r__1 = makeValue(typ, __subslice(s, i, j), (v.flag & 96) >>> 0); /* */ __s = 8; case 8: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Slice end; end __f._1 = _1; __f._r = _r; __f._r__1 = _r__1; __f.cap = cap; __f.i = i; __f.j = j; __f.kind = kind; __f.s = s; __f.str = str; __f.tt = tt; __f.typ = typ; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Slice = function(j) return this.__val.Slice(i, j); end;
	Value.ptr.prototype.Slice3 = function(k)
		var _1, _r, cap, i, j, k, kind, s, tt, typ, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; cap = __f.cap; i = __f.i; j = __f.j; k = __f.k; kind = __f.kind; s = __f.s; tt = __f.tt; typ = __f.typ; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		cap = 0;
		typ = __ifaceNil;
		s = null;
		kind = new flag(v.flag).kind();
		_1 = kind;
		if (_1 == (17)) {
			if (((v.flag & 256) >>> 0) == 0) {
				__panic(new __String("reflect.Value.Slice: slice of unaddressable array"));
			end
			tt = (v.typ.kindType);
			cap = ((tt.len >> 0));
			typ = SliceOf(tt.elem);
			s = new (jsType(typ))(__clone(v, Value).object());
		end else if (_1 == (23)) {
			typ = v.typ;
			s = __clone(v, Value).object();
			cap = __parseInt(s.__capacity) >> 0;
		end else {
			__panic(new ValueError.ptr("reflect.Value.Slice3", kind));
		end
		if (i < 0  or  j < i  or  k < j  or  k > cap) {
			__panic(new __String("reflect.Value.Slice3: slice index out of bounds"));
		end
		_r = makeValue(typ, __subslice(s, i, j, k), (v.flag & 96) >>> 0); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Slice3 end; end __f._1 = _1; __f._r = _r; __f.cap = cap; __f.i = i; __f.j = j; __f.k = k; __f.kind = kind; __f.s = s; __f.tt = tt; __f.typ = typ; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Slice3 = function(k) return this.__val.Slice3(i, j, k); end;
	Value.ptr.prototype.Close = function()
		var v;
		v = this;
		new flag(v.flag).mustBe(18);
		new flag(v.flag).mustBeExported();
		__close(__clone(v, Value).object());
	end;
	Value.prototype.Close = function() return this.__val.Close(); end;
	chanrecv = function(l)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, ch, comms, nb, received, recvRes, selectRes, selected, val, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; ch = __f.ch; comms = __f.comms; nb = __f.nb; received = __f.received; recvRes = __f.recvRes; selectRes = __f.selectRes; selected = __f.selected; val = __f.val; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		selected = false;
		received = false;
		comms = new sliceType__11([new sliceType__8([ch])]);
		if (nb) {
			comms = __append(comms, new sliceType__8([]));
		end
		_r = selectHelper(new sliceType__3([comms])); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		selectRes = _r;
		if (nb  and  ((__parseInt(selectRes[0]) >> 0) == 1)) {
			_tmp = false;
			_tmp__1 = false;
			selected = _tmp;
			received = _tmp__1;
			__s = -1; return [selected, received];
		end
		recvRes = selectRes[1];
		val.__set(recvRes[0]);
		_tmp__2 = true;
		_tmp__3 =  not  not (recvRes[1]);
		selected = _tmp__2;
		received = _tmp__3;
		__s = -1; return [selected, received];
		/* */ end return; end if __f == nil then  __f = { __blk: chanrecv end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f.ch = ch; __f.comms = comms; __f.nb = nb; __f.received = received; __f.recvRes = recvRes; __f.selectRes = selectRes; __f.selected = selected; __f.val = val; __f.__s = __s; __f.__r = __r; return __f;
	end;
	chansend = function(b)
		var _r, ch, comms, nb, selectRes, val, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; ch = __f.ch; comms = __f.comms; nb = __f.nb; selectRes = __f.selectRes; val = __f.val; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		comms = new sliceType__11([new sliceType__8([ch, val.__get()])]);
		if (nb) {
			comms = __append(comms, new sliceType__8([]));
		end
		_r = selectHelper(new sliceType__3([comms])); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		selectRes = _r;
		if (nb  and  ((__parseInt(selectRes[0]) >> 0) == 1)) {
			__s = -1; return false;
		end
		__s = -1; return true;
		/* */ end return; end if __f == nil then  __f = { __blk: chansend end; end __f._r = _r; __f.ch = ch; __f.comms = comms; __f.nb = nb; __f.selectRes = selectRes; __f.val = val; __f.__s = __s; __f.__r = __r; return __f;
	end;
	structField.ptr.prototype.offset = function()
		var f;
		f = this;
		return f.offsetAnon >>> 1 >>> 0;
	end;
	structField.prototype.offset = function() return this.__val.offset(); end;
	structField.ptr.prototype.anon = function()
		var f;
		f = this;
		return  not ((((f.offsetAnon & 1) >>> 0) == 0));
	end;
	structField.prototype.anon = function() return this.__val.anon(); end;
	Kind.prototype.String = function()
		var k;
		k = this.__val;
		if (((k >> 0)) < kindNames.__length) {
			return ((k < 0  or  k >= kindNames.__length) ? (__throwRuntimeError("index out of range"), nil) : kindNames.__array[kindNames.__offset + k]);
		end
		return "kind" + strconv.Itoa(((k >> 0)));
	end;
	__ptrType(Kind).prototype.String = function() return new Kind(this.__get()).String(); end;
	rtype.ptr.prototype.String = function()
		var s, t;
		t = this;
		s = __clone(t.nameOff(t.str), name).name();
		if ( not ((((t.tflag & 2) >>> 0) == 0))) {
			return __substring(s, 1);
		end
		return s;
	end;
	rtype.prototype.String = function() return this.__val.String(); end;
	rtype.ptr.prototype.Size = function()
		var t;
		t = this;
		return t.size;
	end;
	rtype.prototype.Size = function() return this.__val.Size(); end;
	rtype.ptr.prototype.Bits = function()
		var k, t;
		t = this;
		if (t == ptrType__1.nil) {
			__panic(new __String("reflect: Bits of nil Type"));
		end
		k = t.Kind();
		if (k < 2  or  k > 16) {
			__panic(new __String("reflect: Bits of non-arithmetic Type " + t.String()));
		end
		return __imul(((t.size >> 0)), 8);
	end;
	rtype.prototype.Bits = function() return this.__val.Bits(); end;
	rtype.ptr.prototype.Align = function()
		var t;
		t = this;
		return ((t.align >> 0));
	end;
	rtype.prototype.Align = function() return this.__val.Align(); end;
	rtype.ptr.prototype.FieldAlign = function()
		var t;
		t = this;
		return ((t.fieldAlign >> 0));
	end;
	rtype.prototype.FieldAlign = function() return this.__val.FieldAlign(); end;
	rtype.ptr.prototype.Kind = function()
		var t;
		t = this;
		return ((((t.kind & 31) >>> 0) >>> 0));
	end;
	rtype.prototype.Kind = function() return this.__val.Kind(); end;
	rtype.ptr.prototype.common = function()
		var t;
		t = this;
		return t;
	end;
	rtype.prototype.common = function() return this.__val.common(); end;
	rtype.ptr.prototype.exportedMethods = function()
		var _i, _i__1, _r, _r__1, _ref, _ref__1, _tuple, _tuple__1, allExported, allm, found, m, m__1, methods, methodsi, name__1, name__2, t, ut, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _i__1 = __f._i__1; _r = __f._r; _r__1 = __f._r__1; _ref = __f._ref; _ref__1 = __f._ref__1; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; allExported = __f.allExported; allm = __f.allm; found = __f.found; m = __f.m; m__1 = __f.m__1; methods = __f.methods; methodsi = __f.methodsi; name__1 = __f.name__1; name__2 = __f.name__2; t = __f.t; ut = __f.ut; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		_r = methodCache.Load(t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		methodsi = _tuple[0];
		found = _tuple[1];
		if (found) {
			__s = -1; return __assertType(methodsi, sliceType__5);
		end
		ut = t.uncommon();
		if (ut == ptrType__5.nil) {
			__s = -1; return sliceType__5.nil;
		end
		allm = ut.methods();
		allExported = true;
		_ref = allm;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			m = __clone(((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]), method);
			name__1 = __clone(t.nameOff(m.name), name);
			if ( not __clone(name__1, name).isExported()) {
				allExported = false;
				break;
			end
			_i++;
		end
		methods = sliceType__5.nil;
		if (allExported) {
			methods = allm;
		end else {
			methods = __makeSlice(sliceType__5, 0, allm.__length);
			_ref__1 = allm;
			_i__1 = 0;
			while (true) {
				if ( not (_i__1 < _ref__1.__length)) { break; end
				m__1 = __clone(((_i__1 < 0  or  _i__1 >= _ref__1.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref__1.__array[_ref__1.__offset + _i__1]), method);
				name__2 = __clone(t.nameOff(m__1.name), name);
				if (__clone(name__2, name).isExported()) {
					methods = __append(methods, m__1);
				end
				_i__1++;
			end
			methods = __subslice(methods, 0, methods.__length, methods.__length);
		end
		_r__1 = methodCache.LoadOrStore(t, methods); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_tuple__1 = _r__1;
		methodsi = _tuple__1[0];
		__s = -1; return __assertType(methodsi, sliceType__5);
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.exportedMethods end; end __f._i = _i; __f._i__1 = _i__1; __f._r = _r; __f._r__1 = _r__1; __f._ref = _ref; __f._ref__1 = _ref__1; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f.allExported = allExported; __f.allm = allm; __f.found = found; __f.m = m; __f.m__1 = m__1; __f.methods = methods; __f.methodsi = methodsi; __f.name__1 = name__1; __f.name__2 = name__2; __f.t = t; __f.ut = ut; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.exportedMethods = function() return this.__val.exportedMethods(); end;
	rtype.ptr.prototype.NumMethod = function()
		var _r, t, tt, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; tt = __f.tt; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if (t.Kind() == 20) {
			tt = (t.kindType);
			__s = -1; return tt.NumMethod();
		end
		if (((t.tflag & 1) >>> 0) == 0) {
			__s = -1; return 0;
		end
		_r = t.exportedMethods(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r.__length;
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.NumMethod end; end __f._r = _r; __f.t = t; __f.tt = tt; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.NumMethod = function() return this.__val.NumMethod(); end;
	rtype.ptr.prototype.MethodByName = function(1)
		var _r, _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tuple, i, m, name__1, ok, p, pname, t, tt, ut, utmethods, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; _tmp__4 = __f._tmp__4; _tmp__5 = __f._tmp__5; _tuple = __f._tuple; i = __f.i; m = __f.m; name__1 = __f.name__1; ok = __f.ok; p = __f.p; pname = __f.pname; t = __f.t; tt = __f.tt; ut = __f.ut; utmethods = __f.utmethods; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		m = new Method.ptr("", "", __ifaceNil, new Value.ptr(ptrType__1.nil, 0, 0), 0);
		ok = false;
		t = this;
		if (t.Kind() == 20) {
			tt = (t.kindType);
			_tuple = tt.MethodByName(name__1);
			Method.copy(m, _tuple[0]);
			ok = _tuple[1];
			__s = -1; return [m, ok];
		end
		ut = t.uncommon();
		if (ut == ptrType__5.nil) {
			_tmp = new Method.ptr("", "", __ifaceNil, new Value.ptr(ptrType__1.nil, 0, 0), 0);
			_tmp__1 = false;
			Method.copy(m, _tmp);
			ok = _tmp__1;
			__s = -1; return [m, ok];
		end
		utmethods = ut.methods();
		i = 0;
		/* while (true) { */ case 1:
			/* if ( not (i < ((ut.mcount >> 0)))) { break; end */ if( not (i < ((ut.mcount >> 0)))) { __s = 2; continue; end
			p = __clone(((i < 0  or  i >= utmethods.__length) ? (__throwRuntimeError("index out of range"), nil) : utmethods.__array[utmethods.__offset + i]), method);
			pname = __clone(t.nameOff(p.name), name);
			/* */ if (__clone(pname, name).isExported()  and  __clone(pname, name).name() == name__1) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if (__clone(pname, name).isExported()  and  __clone(pname, name).name() == name__1) { */ case 3:
				_r = t.Method(i); /* */ __s = 5; case 5: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				_tmp__2 = __clone(_r, Method);
				_tmp__3 = true;
				Method.copy(m, _tmp__2);
				ok = _tmp__3;
				__s = -1; return [m, ok];
			/* end */ case 4:
			i = i + (1) >> 0;
		/* end */ __s = 1; continue; case 2:
		_tmp__4 = new Method.ptr("", "", __ifaceNil, new Value.ptr(ptrType__1.nil, 0, 0), 0);
		_tmp__5 = false;
		Method.copy(m, _tmp__4);
		ok = _tmp__5;
		__s = -1; return [m, ok];
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.MethodByName end; end __f._r = _r; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f._tmp__4 = _tmp__4; __f._tmp__5 = _tmp__5; __f._tuple = _tuple; __f.i = i; __f.m = m; __f.name__1 = name__1; __f.ok = ok; __f.p = p; __f.pname = pname; __f.t = t; __f.tt = tt; __f.ut = ut; __f.utmethods = utmethods; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.MethodByName = function(1) return this.__val.MethodByName(name__1); end;
	rtype.ptr.prototype.PkgPath = function()
		var t, ut;
		t = this;
		if (((t.tflag & 4) >>> 0) == 0) {
			return "";
		end
		ut = t.uncommon();
		if (ut == ptrType__5.nil) {
			return "";
		end
		return __clone(t.nameOff(ut.pkgPath), name).name();
	end;
	rtype.prototype.PkgPath = function() return this.__val.PkgPath(); end;
	rtype.ptr.prototype.Name = function()
		var i, s, t;
		t = this;
		if (((t.tflag & 4) >>> 0) == 0) {
			return "";
		end
		s = t.String();
		i = s.length - 1 >> 0;
		while (true) {
			if ( not (i >= 0)) { break; end
			if (s.charCodeAt(i) == 46) {
				break;
			end
			i = i - (1) >> 0;
		end
		return __substring(s, (i + 1 >> 0));
	end;
	rtype.prototype.Name = function() return this.__val.Name(); end;
	rtype.ptr.prototype.ChanDir = function()
		var t, tt;
		t = this;
		if ( not ((t.Kind() == 18))) {
			__panic(new __String("reflect: ChanDir of non-chan type"));
		end
		tt = (t.kindType);
		return ((tt.dir >> 0));
	end;
	rtype.prototype.ChanDir = function() return this.__val.ChanDir(); end;
	rtype.ptr.prototype.IsVariadic = function()
		var t, tt;
		t = this;
		if ( not ((t.Kind() == 19))) {
			__panic(new __String("reflect: IsVariadic of non-func type"));
		end
		tt = (t.kindType);
		return  not ((((tt.outCount & 32768) >>> 0) == 0));
	end;
	rtype.prototype.IsVariadic = function() return this.__val.IsVariadic(); end;
	rtype.ptr.prototype.Elem = function()
		var _1, t, tt, tt__1, tt__2, tt__3, tt__4;
		t = this;
		_1 = t.Kind();
		if (_1 == (17)) {
			tt = (t.kindType);
			return toType(tt.elem);
		end else if (_1 == (18)) {
			tt__1 = (t.kindType);
			return toType(tt__1.elem);
		end else if (_1 == (21)) {
			tt__2 = (t.kindType);
			return toType(tt__2.elem);
		end else if (_1 == (22)) {
			tt__3 = (t.kindType);
			return toType(tt__3.elem);
		end else if (_1 == (23)) {
			tt__4 = (t.kindType);
			return toType(tt__4.elem);
		end
		__panic(new __String("reflect: Elem of invalid type"));
	end;
	rtype.prototype.Elem = function() return this.__val.Elem(); end;
	rtype.ptr.prototype.Field = function(i)
		var i, t, tt;
		t = this;
		if ( not ((t.Kind() == 25))) {
			__panic(new __String("reflect: Field of non-struct type"));
		end
		tt = (t.kindType);
		return tt.Field(i);
	end;
	rtype.prototype.Field = function(i) return this.__val.Field(i); end;
	rtype.ptr.prototype.FieldByIndex = function(x)
		var _r, index, t, tt, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; index = __f.index; t = __f.t; tt = __f.tt; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if ( not ((t.Kind() == 25))) {
			__panic(new __String("reflect: FieldByIndex of non-struct type"));
		end
		tt = (t.kindType);
		_r = tt.FieldByIndex(index); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.FieldByIndex end; end __f._r = _r; __f.index = index; __f.t = t; __f.tt = tt; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.FieldByIndex = function(x) return this.__val.FieldByIndex(index); end;
	rtype.ptr.prototype.FieldByName = function(1)
		var _r, name__1, t, tt, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; name__1 = __f.name__1; t = __f.t; tt = __f.tt; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if ( not ((t.Kind() == 25))) {
			__panic(new __String("reflect: FieldByName of non-struct type"));
		end
		tt = (t.kindType);
		_r = tt.FieldByName(name__1); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.FieldByName end; end __f._r = _r; __f.name__1 = name__1; __f.t = t; __f.tt = tt; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.FieldByName = function(1) return this.__val.FieldByName(name__1); end;
	rtype.ptr.prototype.FieldByNameFunc = function(h)
		var _r, match, t, tt, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; match = __f.match; t = __f.t; tt = __f.tt; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if ( not ((t.Kind() == 25))) {
			__panic(new __String("reflect: FieldByNameFunc of non-struct type"));
		end
		tt = (t.kindType);
		_r = tt.FieldByNameFunc(match); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.FieldByNameFunc end; end __f._r = _r; __f.match = match; __f.t = t; __f.tt = tt; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.FieldByNameFunc = function(h) return this.__val.FieldByNameFunc(match); end;
	rtype.ptr.prototype.In = function(i)
		var i, t, tt, x;
		t = this;
		if ( not ((t.Kind() == 19))) {
			__panic(new __String("reflect: In of non-func type"));
		end
		tt = (t.kindType);
		return toType((x = tt.in__(), ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i])));
	end;
	rtype.prototype.In = function(i) return this.__val.In(i); end;
	rtype.ptr.prototype.Key = function()
		var t, tt;
		t = this;
		if ( not ((t.Kind() == 21))) {
			__panic(new __String("reflect: Key of non-map type"));
		end
		tt = (t.kindType);
		return toType(tt.key);
	end;
	rtype.prototype.Key = function() return this.__val.Key(); end;
	rtype.ptr.prototype.Len = function()
		var t, tt;
		t = this;
		if ( not ((t.Kind() == 17))) {
			__panic(new __String("reflect: Len of non-array type"));
		end
		tt = (t.kindType);
		return ((tt.len >> 0));
	end;
	rtype.prototype.Len = function() return this.__val.Len(); end;
	rtype.ptr.prototype.NumField = function()
		var t, tt;
		t = this;
		if ( not ((t.Kind() == 25))) {
			__panic(new __String("reflect: NumField of non-struct type"));
		end
		tt = (t.kindType);
		return tt.fields.__length;
	end;
	rtype.prototype.NumField = function() return this.__val.NumField(); end;
	rtype.ptr.prototype.NumIn = function()
		var t, tt;
		t = this;
		if ( not ((t.Kind() == 19))) {
			__panic(new __String("reflect: NumIn of non-func type"));
		end
		tt = (t.kindType);
		return ((tt.inCount >> 0));
	end;
	rtype.prototype.NumIn = function() return this.__val.NumIn(); end;
	rtype.ptr.prototype.NumOut = function()
		var t, tt;
		t = this;
		if ( not ((t.Kind() == 19))) {
			__panic(new __String("reflect: NumOut of non-func type"));
		end
		tt = (t.kindType);
		return tt.out().__length;
	end;
	rtype.prototype.NumOut = function() return this.__val.NumOut(); end;
	rtype.ptr.prototype.Out = function(i)
		var i, t, tt, x;
		t = this;
		if ( not ((t.Kind() == 19))) {
			__panic(new __String("reflect: Out of non-func type"));
		end
		tt = (t.kindType);
		return toType((x = tt.out(), ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i])));
	end;
	rtype.prototype.Out = function(i) return this.__val.Out(i); end;
	ChanDir.prototype.String = function()
		var _1, d;
		d = this.__val;
		_1 = d;
		if (_1 == (2)) {
			return "chan<-";
		end else if (_1 == (1)) {
			return "<-chan";
		end else if (_1 == (3)) {
			return "chan";
		end
		return "ChanDir" + strconv.Itoa(((d >> 0)));
	end;
	__ptrType(ChanDir).prototype.String = function() return new ChanDir(this.__get()).String(); end;
	interfaceType.ptr.prototype.Method = function(i)
		var i, m, p, pname, t, x;
		m = new Method.ptr("", "", __ifaceNil, new Value.ptr(ptrType__1.nil, 0, 0), 0);
		t = this;
		if (i < 0  or  i >= t.methods.__length) {
			return m;
		end
		p = (x = t.methods, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
		pname = __clone(t.rtype.nameOff(p.name), name);
		m.Name = __clone(pname, name).name();
		if ( not __clone(pname, name).isExported()) {
			m.PkgPath = __clone(pname, name).pkgPath();
			if (m.PkgPath == "") {
				m.PkgPath = __clone(t.pkgPath, name).name();
			end
		end
		m.Type = toType(t.rtype.typeOff(p.typ));
		m.Index = i;
		return m;
	end;
	interfaceType.prototype.Method = function(i) return this.__val.Method(i); end;
	interfaceType.ptr.prototype.NumMethod = function()
		var t;
		t = this;
		return t.methods.__length;
	end;
	interfaceType.prototype.NumMethod = function() return this.__val.NumMethod(); end;
	interfaceType.ptr.prototype.MethodByName = function(1)
		var _i, _ref, _tmp, _tmp__1, i, m, name__1, ok, p, t, x;
		m = new Method.ptr("", "", __ifaceNil, new Value.ptr(ptrType__1.nil, 0, 0), 0);
		ok = false;
		t = this;
		if (t == ptrType__7.nil) {
			return [m, ok];
		end
		p = ptrType__8.nil;
		_ref = t.methods;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			p = (x = t.methods, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
			if (__clone(t.rtype.nameOff(p.name), name).name() == name__1) {
				_tmp = __clone(t.Method(i), Method);
				_tmp__1 = true;
				Method.copy(m, _tmp);
				ok = _tmp__1;
				return [m, ok];
			end
			_i++;
		end
		return [m, ok];
	end;
	interfaceType.prototype.MethodByName = function(1) return this.__val.MethodByName(name__1); end;
	StructTag.prototype.Get = function(y)
		var _tuple, key, tag, v;
		tag = this.__val;
		_tuple = new StructTag(tag).Lookup(key);
		v = _tuple[0];
		return v;
	end;
	__ptrType(StructTag).prototype.Get = function(y) return new StructTag(this.__get()).Get(key); end;
	StructTag.prototype.Lookup = function(y)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tuple, err, i, key, name__1, ok, qvalue, tag, value, value__1;
		value = "";
		ok = false;
		tag = this.__val;
		while (true) {
			if ( not ( not (tag == ""))) { break; end
			i = 0;
			while (true) {
				if ( not (i < tag.length  and  (tag.charCodeAt(i) == 32))) { break; end
				i = i + (1) >> 0;
			end
			tag = __substring(tag, i);
			if (tag == "") {
				break;
			end
			i = 0;
			while (true) {
				if ( not (i < tag.length  and  tag.charCodeAt(i) > 32  and   not ((tag.charCodeAt(i) == 58))  and   not ((tag.charCodeAt(i) == 34))  and   not ((tag.charCodeAt(i) == 127)))) { break; end
				i = i + (1) >> 0;
			end
			if ((i == 0)  or  (i + 1 >> 0) >= tag.length  or   not ((tag.charCodeAt(i) == 58))  or   not ((tag.charCodeAt((i + 1 >> 0)) == 34))) {
				break;
			end
			name__1 = (__substring(tag, 0, i));
			tag = __substring(tag, (i + 1 >> 0));
			i = 1;
			while (true) {
				if ( not (i < tag.length  and   not ((tag.charCodeAt(i) == 34)))) { break; end
				if (tag.charCodeAt(i) == 92) {
					i = i + (1) >> 0;
				end
				i = i + (1) >> 0;
			end
			if (i >= tag.length) {
				break;
			end
			qvalue = (__substring(tag, 0, (i + 1 >> 0)));
			tag = __substring(tag, (i + 1 >> 0));
			if (key == name__1) {
				_tuple = strconv.Unquote(qvalue);
				value__1 = _tuple[0];
				err = _tuple[1];
				if ( not (__interfaceIsEqual(err, __ifaceNil))) {
					break;
				end
				_tmp = value__1;
				_tmp__1 = true;
				value = _tmp;
				ok = _tmp__1;
				return [value, ok];
			end
		end
		_tmp__2 = "";
		_tmp__3 = false;
		value = _tmp__2;
		ok = _tmp__3;
		return [value, ok];
	end;
	__ptrType(StructTag).prototype.Lookup = function(y) return new StructTag(this.__get()).Lookup(key); end;
	structType.ptr.prototype.Field = function(i)
		var f, i, p, t, tag, x;
		f = new StructField.ptr("", "", __ifaceNil, "", 0, sliceType__13.nil, false);
		t = this;
		if (i < 0  or  i >= t.fields.__length) {
			__panic(new __String("reflect: Field index out of bounds"));
		end
		p = (x = t.fields, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
		f.Type = toType(p.typ);
		f.Name = __clone(p.name, name).name();
		f.Anonymous = p.anon();
		if ( not __clone(p.name, name).isExported()) {
			f.PkgPath = __clone(p.name, name).pkgPath();
			if (f.PkgPath == "") {
				f.PkgPath = __clone(t.pkgPath, name).name();
			end
		end
		tag = __clone(p.name, name).tag();
		if ( not (tag == "")) {
			f.Tag = (tag);
		end
		f.Offset = p.offset();
		f.Index = new sliceType__13([i]);
		return f;
	end;
	structType.prototype.Field = function(i) return this.__val.Field(i); end;
	structType.ptr.prototype.FieldByIndex = function(x)
		var _i, _r, _r__1, _r__2, _r__3, _r__4, _ref, _v, f, ft, i, index, t, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _ref = __f._ref; _v = __f._v; f = __f.f; ft = __f.ft; i = __f.i; index = __f.index; t = __f.t; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		f = new StructField.ptr("", "", __ifaceNil, "", 0, sliceType__13.nil, false);
		t = this;
		f.Type = toType(t.rtype);
		_ref = index;
		_i = 0;
		/* while (true) { */ case 1:
			/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 2; continue; end
			i = _i;
			x = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			/* */ if (i > 0) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if (i > 0) { */ case 3:
				ft = f.Type;
				_r = ft.Kind(); /* */ __s = 8; case 8: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				if ( not (_r == 22)) { _v = false; __s = 7; continue s; end
				_r__1 = ft.Elem(); /* */ __s = 9; case 9: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				_r__2 = _r__1.Kind(); /* */ __s = 10; case 10: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				_v = _r__2 == 25; case 7:
				/* */ if (_v) { __s = 5; continue; end
				/* */ __s = 6; continue;
				/* if (_v) { */ case 5:
					_r__3 = ft.Elem(); /* */ __s = 11; case 11: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
					ft = _r__3;
				/* end */ case 6:
				f.Type = ft;
			/* end */ case 4:
			_r__4 = f.Type.Field(x); /* */ __s = 12; case 12: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
			StructField.copy(f, _r__4);
			_i++;
		/* end */ __s = 1; continue; case 2:
		__s = -1; return f;
		/* */ end return; end if __f == nil then  __f = { __blk: structType.ptr.prototype.FieldByIndex end; end __f._i = _i; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._ref = _ref; __f._v = _v; __f.f = f; __f.ft = ft; __f.i = i; __f.index = index; __f.t = t; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	structType.prototype.FieldByIndex = function(x) return this.__val.FieldByIndex(index); end;
	structType.ptr.prototype.FieldByNameFunc = function(h)
		var _entry, _entry__1, _entry__2, _entry__3, _i, _i__1, _key, _key__1, _key__2, _key__3, _r, _r__1, _ref, _ref__1, _tmp, _tmp__1, _tmp__2, _tmp__3, count, current, f, fname, i, index, match, next, nextCount, ntyp, ok, result, scan, styp, t, t__1, visited, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _entry = __f._entry; _entry__1 = __f._entry__1; _entry__2 = __f._entry__2; _entry__3 = __f._entry__3; _i = __f._i; _i__1 = __f._i__1; _key = __f._key; _key__1 = __f._key__1; _key__2 = __f._key__2; _key__3 = __f._key__3; _r = __f._r; _r__1 = __f._r__1; _ref = __f._ref; _ref__1 = __f._ref__1; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tmp__2 = __f._tmp__2; _tmp__3 = __f._tmp__3; count = __f.count; current = __f.current; f = __f.f; fname = __f.fname; i = __f.i; index = __f.index; match = __f.match; next = __f.next; nextCount = __f.nextCount; ntyp = __f.ntyp; ok = __f.ok; result = __f.result; scan = __f.scan; styp = __f.styp; t = __f.t; t__1 = __f.t__1; visited = __f.visited; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		result = new StructField.ptr("", "", __ifaceNil, "", 0, sliceType__13.nil, false);
		ok = false;
		t = this;
		current = new sliceType__14([]);
		next = new sliceType__14([new fieldScan.ptr(t, sliceType__13.nil)]);
		nextCount = false;
		visited = __makeMap(ptrType__9.keyFor, []);
		/* while (true) { */ case 1:
			/* if ( not (next.__length > 0)) { break; end */ if( not (next.__length > 0)) { __s = 2; continue; end
			_tmp = next;
			_tmp__1 = __subslice(current, 0, 0);
			current = _tmp;
			next = _tmp__1;
			count = nextCount;
			nextCount = false;
			_ref = current;
			_i = 0;
			/* while (true) { */ case 3:
				/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 4; continue; end
				scan = __clone(((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]), fieldScan);
				t__1 = scan.typ;
				/* */ if ((_entry = visited[ptrType__9.keyFor(t__1)], _entry ~= nil ? _entry.v : false)) { __s = 5; continue; end
				/* */ __s = 6; continue;
				/* if ((_entry = visited[ptrType__9.keyFor(t__1)], _entry ~= nil ? _entry.v : false)) { */ case 5:
					_i++;
					/* continue; */ __s = 3; continue;
				/* end */ case 6:
				_key = t__1; (visited  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__9.keyFor(_key)] = { k: _key, v: true end;
				_ref__1 = t__1.fields;
				_i__1 = 0;
				/* while (true) { */ case 7:
					/* if ( not (_i__1 < _ref__1.__length)) { break; end */ if( not (_i__1 < _ref__1.__length)) { __s = 8; continue; end
					i = _i__1;
					f = (x = t__1.fields, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
					fname = __clone(f.name, name).name();
					ntyp = ptrType__1.nil;
					/* */ if (f.anon()) { __s = 9; continue; end
					/* */ __s = 10; continue;
					/* if (f.anon()) { */ case 9:
						ntyp = f.typ;
						/* */ if (ntyp.Kind() == 22) { __s = 11; continue; end
						/* */ __s = 12; continue;
						/* if (ntyp.Kind() == 22) { */ case 11:
							_r = ntyp.Elem().common(); /* */ __s = 13; case 13: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
							ntyp = _r;
						/* end */ case 12:
					/* end */ case 10:
					_r__1 = match(fname); /* */ __s = 16; case 16: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
					/* */ if (_r__1) { __s = 14; continue; end
					/* */ __s = 15; continue;
					/* if (_r__1) { */ case 14:
						if ((_entry__1 = count[ptrType__9.keyFor(t__1)], _entry__1 ~= nil ? _entry__1.v : 0) > 1  or  ok) {
							_tmp__2 = new StructField.ptr("", "", __ifaceNil, "", 0, sliceType__13.nil, false);
							_tmp__3 = false;
							StructField.copy(result, _tmp__2);
							ok = _tmp__3;
							__s = -1; return [result, ok];
						end
						StructField.copy(result, t__1.Field(i));
						result.Index = sliceType__13.nil;
						result.Index = __appendSlice(result.Index, scan.index);
						result.Index = __append(result.Index, i);
						ok = true;
						_i__1++;
						/* continue; */ __s = 7; continue;
					/* end */ case 15:
					if (ok  or  ntyp == ptrType__1.nil  or   not ((ntyp.Kind() == 25))) {
						_i__1++;
						/* continue; */ __s = 7; continue;
					end
					styp = (ntyp.kindType);
					if ((_entry__2 = nextCount[ptrType__9.keyFor(styp)], _entry__2 ~= nil ? _entry__2.v : 0) > 0) {
						_key__1 = styp; (nextCount  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__9.keyFor(_key__1)] = { k: _key__1, v: 2 end;
						_i__1++;
						/* continue; */ __s = 7; continue;
					end
					if (nextCount == false) {
						nextCount = __makeMap(ptrType__9.keyFor, []);
					end
					_key__2 = styp; (nextCount  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__9.keyFor(_key__2)] = { k: _key__2, v: 1 end;
					if ((_entry__3 = count[ptrType__9.keyFor(t__1)], _entry__3 ~= nil ? _entry__3.v : 0) > 1) {
						_key__3 = styp; (nextCount  or  __throwRuntimeError("assignment to entry in nil map"))[ptrType__9.keyFor(_key__3)] = { k: _key__3, v: 2 end;
					end
					index = sliceType__13.nil;
					index = __appendSlice(index, scan.index);
					index = __append(index, i);
					next = __append(next, new fieldScan.ptr(styp, index));
					_i__1++;
				/* end */ __s = 7; continue; case 8:
				_i++;
			/* end */ __s = 3; continue; case 4:
			if (ok) {
				/* break; */ __s = 2; continue;
			end
		/* end */ __s = 1; continue; case 2:
		__s = -1; return [result, ok];
		/* */ end return; end if __f == nil then  __f = { __blk: structType.ptr.prototype.FieldByNameFunc end; end __f._entry = _entry; __f._entry__1 = _entry__1; __f._entry__2 = _entry__2; __f._entry__3 = _entry__3; __f._i = _i; __f._i__1 = _i__1; __f._key = _key; __f._key__1 = _key__1; __f._key__2 = _key__2; __f._key__3 = _key__3; __f._r = _r; __f._r__1 = _r__1; __f._ref = _ref; __f._ref__1 = _ref__1; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tmp__2 = _tmp__2; __f._tmp__3 = _tmp__3; __f.count = count; __f.current = current; __f.f = f; __f.fname = fname; __f.i = i; __f.index = index; __f.match = match; __f.next = next; __f.nextCount = nextCount; __f.ntyp = ntyp; __f.ok = ok; __f.result = result; __f.scan = scan; __f.styp = styp; __f.t = t; __f.t__1 = t__1; __f.visited = visited; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	structType.prototype.FieldByNameFunc = function(h) return this.__val.FieldByNameFunc(match); end;
	structType.ptr.prototype.FieldByName = function(1)
		var _i, _r, _ref, _tmp, _tmp__1, _tuple, f, hasAnon, i, name__1, present, t, tf, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _r = __f._r; _ref = __f._ref; _tmp = __f._tmp; _tmp__1 = __f._tmp__1; _tuple = __f._tuple; f = __f.f; hasAnon = __f.hasAnon; i = __f.i; name__1 = __f.name__1; present = __f.present; t = __f.t; tf = __f.tf; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		name__1 = [name__1];
		f = new StructField.ptr("", "", __ifaceNil, "", 0, sliceType__13.nil, false);
		present = false;
		t = this;
		hasAnon = false;
		if ( not (name__1[0] == "")) {
			_ref = t.fields;
			_i = 0;
			while (true) {
				if ( not (_i < _ref.__length)) { break; end
				i = _i;
				tf = (x = t.fields, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
				if (__clone(tf.name, name).name() == name__1[0]) {
					_tmp = __clone(t.Field(i), StructField);
					_tmp__1 = true;
					StructField.copy(f, _tmp);
					present = _tmp__1;
					__s = -1; return [f, present];
				end
				if (tf.anon()) {
					hasAnon = true;
				end
				_i++;
			end
		end
		if ( not hasAnon) {
			__s = -1; return [f, present];
		end
		_r = t.FieldByNameFunc((function(1) return function(s)
			var s;
			return s == name__1[0];
		end; end)(name__1)); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		StructField.copy(f, _tuple[0]);
		present = _tuple[1];
		__s = -1; return [f, present];
		/* */ end return; end if __f == nil then  __f = { __blk: structType.ptr.prototype.FieldByName end; end __f._i = _i; __f._r = _r; __f._ref = _ref; __f._tmp = _tmp; __f._tmp__1 = _tmp__1; __f._tuple = _tuple; __f.f = f; __f.hasAnon = hasAnon; __f.i = i; __f.name__1 = name__1; __f.present = present; __f.t = t; __f.tf = tf; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	structType.prototype.FieldByName = function(1) return this.__val.FieldByName(name__1); end;
	PtrTo = function(t)
		var t;
		return __assertType(t, ptrType__1).ptrTo();
	end;
	__pkg.PtrTo = PtrTo;
	rtype.ptr.prototype.Implements = function(u)
		var _r, t, u, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; u = __f.u; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if (__interfaceIsEqual(u, __ifaceNil)) {
			__panic(new __String("reflect: nil type passed to Type.Implements"));
		end
		_r = u.Kind(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		/* */ if ( not ((_r == 20))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((_r == 20))) { */ case 1:
			__panic(new __String("reflect: non-interface type passed to Type.Implements"));
		/* end */ case 2:
		__s = -1; return implements__1(__assertType(u, ptrType__1), t);
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.Implements end; end __f._r = _r; __f.t = t; __f.u = u; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.Implements = function(u) return this.__val.Implements(u); end;
	rtype.ptr.prototype.AssignableTo = function(u)
		var _r, t, u, uu, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; u = __f.u; uu = __f.uu; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if (__interfaceIsEqual(u, __ifaceNil)) {
			__panic(new __String("reflect: nil type passed to Type.AssignableTo"));
		end
		uu = __assertType(u, ptrType__1);
		_r = directlyAssignable(uu, t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r  or  implements__1(uu, t);
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.AssignableTo end; end __f._r = _r; __f.t = t; __f.u = u; __f.uu = uu; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.AssignableTo = function(u) return this.__val.AssignableTo(u); end;
	rtype.ptr.prototype.ConvertibleTo = function(u)
		var _r, t, u, uu, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; u = __f.u; uu = __f.uu; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		t = this;
		if (__interfaceIsEqual(u, __ifaceNil)) {
			__panic(new __String("reflect: nil type passed to Type.ConvertibleTo"));
		end
		uu = __assertType(u, ptrType__1);
		_r = convertOp(uu, t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return  not (_r == __throwNilPointerError);
		/* */ end return; end if __f == nil then  __f = { __blk: rtype.ptr.prototype.ConvertibleTo end; end __f._r = _r; __f.t = t; __f.u = u; __f.uu = uu; __f.__s = __s; __f.__r = __r; return __f;
	end;
	rtype.prototype.ConvertibleTo = function(u) return this.__val.ConvertibleTo(u); end;
	implements__1 = function(V)
		var T, V, i, i__1, j, j__1, t, tm, tm__1, tmName, tmName__1, tmPkgPath, tmPkgPath__1, v, v__1, vm, vm__1, vmName, vmName__1, vmPkgPath, vmPkgPath__1, vmethods, x, x__1, x__2;
		if ( not ((T.Kind() == 20))) {
			return false;
		end
		t = (T.kindType);
		if (t.methods.__length == 0) {
			return true;
		end
		if (V.Kind() == 20) {
			v = (V.kindType);
			i = 0;
			j = 0;
			while (true) {
				if ( not (j < v.methods.__length)) { break; end
				tm = (x = t.methods, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
				tmName = __clone(t.rtype.nameOff(tm.name), name);
				vm = (x__1 = v.methods, ((j < 0  or  j >= x__1.__length) ? (__throwRuntimeError("index out of range"), nil) : x__1.__array[x__1.__offset + j]));
				vmName = __clone(V.nameOff(vm.name), name);
				if (__clone(vmName, name).name() == __clone(tmName, name).name()  and  V.typeOff(vm.typ) == t.rtype.typeOff(tm.typ)) {
					if ( not __clone(tmName, name).isExported()) {
						tmPkgPath = __clone(tmName, name).pkgPath();
						if (tmPkgPath == "") {
							tmPkgPath = __clone(t.pkgPath, name).name();
						end
						vmPkgPath = __clone(vmName, name).pkgPath();
						if (vmPkgPath == "") {
							vmPkgPath = __clone(v.pkgPath, name).name();
						end
						if ( not (tmPkgPath == vmPkgPath)) {
							j = j + (1) >> 0;
							continue;
						end
					end
					i = i + (1) >> 0;
					if (i >= t.methods.__length) {
						return true;
					end
				end
				j = j + (1) >> 0;
			end
			return false;
		end
		v__1 = V.uncommon();
		if (v__1 == ptrType__5.nil) {
			return false;
		end
		i__1 = 0;
		vmethods = v__1.methods();
		j__1 = 0;
		while (true) {
			if ( not (j__1 < ((v__1.mcount >> 0)))) { break; end
			tm__1 = (x__2 = t.methods, ((i__1 < 0  or  i__1 >= x__2.__length) ? (__throwRuntimeError("index out of range"), nil) : x__2.__array[x__2.__offset + i__1]));
			tmName__1 = __clone(t.rtype.nameOff(tm__1.name), name);
			vm__1 = __clone(((j__1 < 0  or  j__1 >= vmethods.__length) ? (__throwRuntimeError("index out of range"), nil) : vmethods.__array[vmethods.__offset + j__1]), method);
			vmName__1 = __clone(V.nameOff(vm__1.name), name);
			if (__clone(vmName__1, name).name() == __clone(tmName__1, name).name()  and  V.typeOff(vm__1.mtyp) == t.rtype.typeOff(tm__1.typ)) {
				if ( not __clone(tmName__1, name).isExported()) {
					tmPkgPath__1 = __clone(tmName__1, name).pkgPath();
					if (tmPkgPath__1 == "") {
						tmPkgPath__1 = __clone(t.pkgPath, name).name();
					end
					vmPkgPath__1 = __clone(vmName__1, name).pkgPath();
					if (vmPkgPath__1 == "") {
						vmPkgPath__1 = __clone(V.nameOff(v__1.pkgPath), name).name();
					end
					if ( not (tmPkgPath__1 == vmPkgPath__1)) {
						j__1 = j__1 + (1) >> 0;
						continue;
					end
				end
				i__1 = i__1 + (1) >> 0;
				if (i__1 >= t.methods.__length) {
					return true;
				end
			end
			j__1 = j__1 + (1) >> 0;
		end
		return false;
	end;
	directlyAssignable = function(V)
		var T, V, _r, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; T = __f.T; V = __f.V; _r = __f._r; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if (T == V) {
			__s = -1; return true;
		end
		if ( not (T.Name() == "")  and   not (V.Name() == "")  or   not ((T.Kind() == V.Kind()))) {
			__s = -1; return false;
		end
		_r = haveIdenticalUnderlyingType(T, V, true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: directlyAssignable end; end __f.T = T; __f.V = V; __f._r = _r; __f.__s = __s; __f.__r = __r; return __f;
	end;
	haveIdenticalType = function(s)
		var T, V, _arg, _arg__1, _r, _r__1, _r__2, _r__3, _r__4, _r__5, _r__6, _v, cmpTags, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; T = __f.T; V = __f.V; _arg = __f._arg; _arg__1 = __f._arg__1; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _r__6 = __f._r__6; _v = __f._v; cmpTags = __f.cmpTags; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if (cmpTags) {
			__s = -1; return __interfaceIsEqual(T, V);
		end
		_r = T.Name(); /* */ __s = 4; case 4: if(__c) then  __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = V.Name(); /* */ __s = 5; case 5: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		if ( not (_r == _r__1)) { _v = true; __s = 3; continue s; end
		_r__2 = T.Kind(); /* */ __s = 6; case 6: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		_r__3 = V.Kind(); /* */ __s = 7; case 7: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
		_v =  not ((_r__2 == _r__3)); case 3:
		/* */ if (_v) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (_v) { */ case 1:
			__s = -1; return false;
		/* end */ case 2:
		_r__4 = T.common(); /* */ __s = 8; case 8: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
		_arg = _r__4;
		_r__5 = V.common(); /* */ __s = 9; case 9: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
		_arg__1 = _r__5;
		_r__6 = haveIdenticalUnderlyingType(_arg, _arg__1, false); /* */ __s = 10; case 10: if(__c) then __c = false; _r__6 = _r__6.__blk(); end if (_r__6  and  _r__6.__blk ~= nil) { break s; end
		__s = -1; return _r__6;
		/* */ end return; end if __f == nil then  __f = { __blk: haveIdenticalType end; end __f.T = T; __f.V = V; __f._arg = _arg; __f._arg__1 = _arg__1; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._r__6 = _r__6; __f._v = _v; __f.cmpTags = cmpTags; __f.__s = __s; __f.__r = __r; return __f;
	end;
	haveIdenticalUnderlyingType = function(s)
		var T, V, _1, _i, _r, _r__1, _r__2, _r__3, _r__4, _r__5, _r__6, _r__7, _r__8, _ref, _v, _v__1, _v__2, _v__3, cmpTags, i, i__1, i__2, kind, t, t__1, t__2, tf, tp, v, v__1, v__2, vf, vp, x, x__1, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; T = __f.T; V = __f.V; _1 = __f._1; _i = __f._i; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _r__6 = __f._r__6; _r__7 = __f._r__7; _r__8 = __f._r__8; _ref = __f._ref; _v = __f._v; _v__1 = __f._v__1; _v__2 = __f._v__2; _v__3 = __f._v__3; cmpTags = __f.cmpTags; i = __f.i; i__1 = __f.i__1; i__2 = __f.i__2; kind = __f.kind; t = __f.t; t__1 = __f.t__1; t__2 = __f.t__2; tf = __f.tf; tp = __f.tp; v = __f.v; v__1 = __f.v__1; v__2 = __f.v__2; vf = __f.vf; vp = __f.vp; x = __f.x; x__1 = __f.x__1; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if (T == V) {
			__s = -1; return true;
		end
		kind = T.Kind();
		if ( not ((kind == V.Kind()))) {
			__s = -1; return false;
		end
		if (1 <= kind  and  kind <= 16  or  (kind == 24)  or  (kind == 26)) {
			__s = -1; return true;
		end
			_1 = kind;
			/* */ if (_1 == (17)) { __s = 2; continue; end
			/* */ if (_1 == (18)) { __s = 3; continue; end
			/* */ if (_1 == (19)) { __s = 4; continue; end
			/* */ if (_1 == (20)) { __s = 5; continue; end
			/* */ if (_1 == (21)) { __s = 6; continue; end
			/* */ if ((_1 == (22))  or  (_1 == (23))) { __s = 7; continue; end
			/* */ if (_1 == (25)) { __s = 8; continue; end
			/* */ __s = 9; continue;
			/* if (_1 == (17)) { */ case 2:
				if ( not (T.Len() == V.Len())) { _v = false; __s = 10; continue s; end
				_r = haveIdenticalType(T.Elem(), V.Elem(), cmpTags); /* */ __s = 11; case 11: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				_v = _r; case 10:
				__s = -1; return _v;
			/* end else if (_1 == (18)) { */ case 3:
				if ( not (V.ChanDir() == 3)) { _v__1 = false; __s = 14; continue s; end
				_r__1 = haveIdenticalType(T.Elem(), V.Elem(), cmpTags); /* */ __s = 15; case 15: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				_v__1 = _r__1; case 14:
				/* */ if (_v__1) { __s = 12; continue; end
				/* */ __s = 13; continue;
				/* if (_v__1) { */ case 12:
					__s = -1; return true;
				/* end */ case 13:
				if ( not (V.ChanDir() == T.ChanDir())) { _v__2 = false; __s = 16; continue s; end
				_r__2 = haveIdenticalType(T.Elem(), V.Elem(), cmpTags); /* */ __s = 17; case 17: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				_v__2 = _r__2; case 16:
				__s = -1; return _v__2;
			/* end else if (_1 == (19)) { */ case 4:
				t = (T.kindType);
				v = (V.kindType);
				if ( not ((t.outCount == v.outCount))  or   not ((t.inCount == v.inCount))) {
					__s = -1; return false;
				end
				i = 0;
				/* while (true) { */ case 18:
					/* if ( not (i < t.rtype.NumIn())) { break; end */ if( not (i < t.rtype.NumIn())) { __s = 19; continue; end
					_r__3 = haveIdenticalType(t.rtype.In(i), v.rtype.In(i), cmpTags); /* */ __s = 22; case 22: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
					/* */ if ( not _r__3) { __s = 20; continue; end
					/* */ __s = 21; continue;
					/* if ( not _r__3) { */ case 20:
						__s = -1; return false;
					/* end */ case 21:
					i = i + (1) >> 0;
				/* end */ __s = 18; continue; case 19:
				i__1 = 0;
				/* while (true) { */ case 23:
					/* if ( not (i__1 < t.rtype.NumOut())) { break; end */ if( not (i__1 < t.rtype.NumOut())) { __s = 24; continue; end
					_r__4 = haveIdenticalType(t.rtype.Out(i__1), v.rtype.Out(i__1), cmpTags); /* */ __s = 27; case 27: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
					/* */ if ( not _r__4) { __s = 25; continue; end
					/* */ __s = 26; continue;
					/* if ( not _r__4) { */ case 25:
						__s = -1; return false;
					/* end */ case 26:
					i__1 = i__1 + (1) >> 0;
				/* end */ __s = 23; continue; case 24:
				__s = -1; return true;
			/* end else if (_1 == (20)) { */ case 5:
				t__1 = (T.kindType);
				v__1 = (V.kindType);
				if ((t__1.methods.__length == 0)  and  (v__1.methods.__length == 0)) {
					__s = -1; return true;
				end
				__s = -1; return false;
			/* end else if (_1 == (21)) { */ case 6:
				_r__5 = haveIdenticalType(T.Key(), V.Key(), cmpTags); /* */ __s = 29; case 29: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
				if ( not (_r__5)) { _v__3 = false; __s = 28; continue s; end
				_r__6 = haveIdenticalType(T.Elem(), V.Elem(), cmpTags); /* */ __s = 30; case 30: if(__c) then __c = false; _r__6 = _r__6.__blk(); end if (_r__6  and  _r__6.__blk ~= nil) { break s; end
				_v__3 = _r__6; case 28:
				__s = -1; return _v__3;
			/* end else if ((_1 == (22))  or  (_1 == (23))) { */ case 7:
				_r__7 = haveIdenticalType(T.Elem(), V.Elem(), cmpTags); /* */ __s = 31; case 31: if(__c) then __c = false; _r__7 = _r__7.__blk(); end if (_r__7  and  _r__7.__blk ~= nil) { break s; end
				__s = -1; return _r__7;
			/* end else if (_1 == (25)) { */ case 8:
				t__2 = (T.kindType);
				v__2 = (V.kindType);
				if ( not ((t__2.fields.__length == v__2.fields.__length))) {
					__s = -1; return false;
				end
				_ref = t__2.fields;
				_i = 0;
				/* while (true) { */ case 32:
					/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 33; continue; end
					i__2 = _i;
					tf = (x = t__2.fields, ((i__2 < 0  or  i__2 >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i__2]));
					vf = (x__1 = v__2.fields, ((i__2 < 0  or  i__2 >= x__1.__length) ? (__throwRuntimeError("index out of range"), nil) : x__1.__array[x__1.__offset + i__2]));
					if ( not (__clone(tf.name, name).name() == __clone(vf.name, name).name())) {
						__s = -1; return false;
					end
					_r__8 = haveIdenticalType(tf.typ, vf.typ, cmpTags); /* */ __s = 36; case 36: if(__c) then __c = false; _r__8 = _r__8.__blk(); end if (_r__8  and  _r__8.__blk ~= nil) { break s; end
					/* */ if ( not _r__8) { __s = 34; continue; end
					/* */ __s = 35; continue;
					/* if ( not _r__8) { */ case 34:
						__s = -1; return false;
					/* end */ case 35:
					if (cmpTags  and   not (__clone(tf.name, name).tag() == __clone(vf.name, name).tag())) {
						__s = -1; return false;
					end
					if ( not ((tf.offsetAnon == vf.offsetAnon))) {
						__s = -1; return false;
					end
					if ( not __clone(tf.name, name).isExported()) {
						tp = __clone(tf.name, name).pkgPath();
						if (tp == "") {
							tp = __clone(t__2.pkgPath, name).name();
						end
						vp = __clone(vf.name, name).pkgPath();
						if (vp == "") {
							vp = __clone(v__2.pkgPath, name).name();
						end
						if ( not (tp == vp)) {
							__s = -1; return false;
						end
					end
					_i++;
				/* end */ __s = 32; continue; case 33:
				__s = -1; return true;
			/* end */ case 9:
		case 1:
		__s = -1; return false;
		/* */ end return; end if __f == nil then  __f = { __blk: haveIdenticalUnderlyingType end; end __f.T = T; __f.V = V; __f._1 = _1; __f._i = _i; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._r__6 = _r__6; __f._r__7 = _r__7; __f._r__8 = _r__8; __f._ref = _ref; __f._v = _v; __f._v__1 = _v__1; __f._v__2 = _v__2; __f._v__3 = _v__3; __f.cmpTags = cmpTags; __f.i = i; __f.i__1 = i__1; __f.i__2 = i__2; __f.kind = kind; __f.t = t; __f.t__1 = t__1; __f.t__2 = t__2; __f.tf = tf; __f.tp = tp; __f.v = v; __f.v__1 = v__1; __f.v__2 = v__2; __f.vf = vf; __f.vp = vp; __f.x = x; __f.x__1 = x__1; __f.__s = __s; __f.__r = __r; return __f;
	end;
	toType = function(t)
		var t;
		if (t == ptrType__1.nil) {
			return __ifaceNil;
		end
		return t;
	end;
	ifaceIndir = function(t)
		var t;
		return ((t.kind & 32) >>> 0) == 0;
	end;
	flag.prototype.kind = function()
		var f;
		f = this.__val;
		return ((((f & 31) >>> 0) >>> 0));
	end;
	__ptrType(flag).prototype.kind = function() return new flag(this.__get()).kind(); end;
	Value.ptr.prototype.pointer = function()
		var v;
		v = this;
		if ( not ((v.typ.size == 4))  or   not v.typ.pointers()) {
			__panic(new __String("can't call pointer on a non-pointer Value"));
		end
		if ( not ((((v.flag & 128) >>> 0) == 0))) {
			return (v.ptr).__get();
		end
		return v.ptr;
	end;
	Value.prototype.pointer = function() return this.__val.pointer(); end;
	ValueError.ptr.prototype.Error = function()
		var e;
		e = this;
		if (e.Kind == 0) {
			return "reflect: call of " + e.Method + " on zero Value";
		end
		return "reflect: call of " + e.Method + " on " + new Kind(e.Kind).String() + " Value";
	end;
	ValueError.prototype.Error = function() return this.__val.Error(); end;
	flag.prototype.mustBe = function(d)
		var expected, f;
		f = this.__val;
		if ( not ((new flag(f).kind() == expected))) {
			__panic(new ValueError.ptr(methodName(), new flag(f).kind()));
		end
	end;
	__ptrType(flag).prototype.mustBe = function(d) return new flag(this.__get()).mustBe(expected); end;
	flag.prototype.mustBeExported = function()
		var f;
		f = this.__val;
		if (f == 0) {
			__panic(new ValueError.ptr(methodName(), 0));
		end
		if ( not ((((f & 96) >>> 0) == 0))) {
			__panic(new __String("reflect: " + methodName() + " using value obtained using unexported field"));
		end
	end;
	__ptrType(flag).prototype.mustBeExported = function() return new flag(this.__get()).mustBeExported(); end;
	flag.prototype.mustBeAssignable = function()
		var f;
		f = this.__val;
		if (f == 0) {
			__panic(new ValueError.ptr(methodName(), 0));
		end
		if ( not ((((f & 96) >>> 0) == 0))) {
			__panic(new __String("reflect: " + methodName() + " using value obtained using unexported field"));
		end
		if (((f & 256) >>> 0) == 0) {
			__panic(new __String("reflect: " + methodName() + " using unaddressable value"));
		end
	end;
	__ptrType(flag).prototype.mustBeAssignable = function() return new flag(this.__get()).mustBeAssignable(); end;
	Value.ptr.prototype.Addr = function()
		var v;
		v = this;
		if (((v.flag & 256) >>> 0) == 0) {
			__panic(new __String("reflect.Value.Addr of unaddressable value"));
		end
		return new Value.ptr(v.typ.ptrTo(), v.ptr, ((((v.flag & 96) >>> 0)) | 22) >>> 0);
	end;
	Value.prototype.Addr = function() return this.__val.Addr(); end;
	Value.ptr.prototype.Bool = function()
		var v;
		v = this;
		new flag(v.flag).mustBe(1);
		return (v.ptr).__get();
	end;
	Value.prototype.Bool = function() return this.__val.Bool(); end;
	Value.ptr.prototype.Bytes = function()
		var _r, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(23);
		_r = v.typ.Elem().Kind(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		/* */ if ( not ((_r == 8))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((_r == 8))) { */ case 1:
			__panic(new __String("reflect.Value.Bytes of non-byte slice"));
		/* end */ case 2:
		__s = -1; return (v.ptr).__get();
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Bytes end; end __f._r = _r; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Bytes = function() return this.__val.Bytes(); end;
	Value.ptr.prototype.runes = function()
		var _r, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(23);
		_r = v.typ.Elem().Kind(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		/* */ if ( not ((_r == 5))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((_r == 5))) { */ case 1:
			__panic(new __String("reflect.Value.Bytes of non-rune slice"));
		/* end */ case 2:
		__s = -1; return (v.ptr).__get();
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.runes end; end __f._r = _r; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.runes = function() return this.__val.runes(); end;
	Value.ptr.prototype.CanAddr = function()
		var v;
		v = this;
		return  not ((((v.flag & 256) >>> 0) == 0));
	end;
	Value.prototype.CanAddr = function() return this.__val.CanAddr(); end;
	Value.ptr.prototype.CanSet = function()
		var v;
		v = this;
		return ((v.flag & 352) >>> 0) == 256;
	end;
	Value.prototype.CanSet = function() return this.__val.CanSet(); end;
	Value.ptr.prototype.Call = function(1)
		var _r, in__1, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; in__1 = __f.in__1; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(19);
		new flag(v.flag).mustBeExported();
		_r = __clone(v, Value).call("Call", in__1); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Call end; end __f._r = _r; __f.in__1 = in__1; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Call = function(1) return this.__val.Call(in__1); end;
	Value.ptr.prototype.CallSlice = function(1)
		var _r, in__1, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; in__1 = __f.in__1; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(19);
		new flag(v.flag).mustBeExported();
		_r = __clone(v, Value).call("CallSlice", in__1); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.CallSlice end; end __f._r = _r; __f.in__1 = in__1; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.CallSlice = function(1) return this.__val.CallSlice(in__1); end;
	Value.ptr.prototype.Complex = function()
		var _1, k, v, x;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (15)) {
			return ((x = (v.ptr).__get(), new __Complex128(x.__real, x.__imag)));
		end else if (_1 == (16)) {
			return (v.ptr).__get();
		end
		__panic(new ValueError.ptr("reflect.Value.Complex", new flag(v.flag).kind()));
	end;
	Value.prototype.Complex = function() return this.__val.Complex(); end;
	Value.ptr.prototype.FieldByIndex = function(x)
		var _i, _r, _r__1, _r__2, _r__3, _ref, _v, i, index, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _i = __f._i; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _ref = __f._ref; _v = __f._v; i = __f.i; index = __f.index; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		/* */ if (index.__length == 1) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (index.__length == 1) { */ case 1:
			_r = __clone(v, Value).Field((0 >= index.__length ? (__throwRuntimeError("index out of range"), nil) : index.__array[index.__offset + 0])); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			__s = -1; return _r;
		/* end */ case 2:
		new flag(v.flag).mustBe(25);
		_ref = index;
		_i = 0;
		/* while (true) { */ case 4:
			/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 5; continue; end
			i = _i;
			x = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
			/* */ if (i > 0) { __s = 6; continue; end
			/* */ __s = 7; continue;
			/* if (i > 0) { */ case 6:
				if ( not (__clone(v, Value).Kind() == 22)) { _v = false; __s = 10; continue s; end
				_r__1 = v.typ.Elem().Kind(); /* */ __s = 11; case 11: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				_v = _r__1 == 25; case 10:
				/* */ if (_v) { __s = 8; continue; end
				/* */ __s = 9; continue;
				/* if (_v) { */ case 8:
					if (__clone(v, Value).IsNil()) {
						__panic(new __String("reflect: indirection through nil pointer to embedded struct"));
					end
					_r__2 = __clone(v, Value).Elem(); /* */ __s = 12; case 12: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
					v = _r__2;
				/* end */ case 9:
			/* end */ case 7:
			_r__3 = __clone(v, Value).Field(x); /* */ __s = 13; case 13: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
			v = _r__3;
			_i++;
		/* end */ __s = 4; continue; case 5:
		__s = -1; return v;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.FieldByIndex end; end __f._i = _i; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._ref = _ref; __f._v = _v; __f.i = i; __f.index = index; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.FieldByIndex = function(x) return this.__val.FieldByIndex(index); end;
	Value.ptr.prototype.FieldByName = function(1)
		var _r, _r__1, _tuple, f, name__1, ok, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; f = __f.f; name__1 = __f.name__1; ok = __f.ok; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(25);
		_r = v.typ.FieldByName(name__1); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		f = __clone(_tuple[0], StructField);
		ok = _tuple[1];
		/* */ if (ok) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if (ok) { */ case 2:
			_r__1 = __clone(v, Value).FieldByIndex(f.Index); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			__s = -1; return _r__1;
		/* end */ case 3:
		__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.FieldByName end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.f = f; __f.name__1 = name__1; __f.ok = ok; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.FieldByName = function(1) return this.__val.FieldByName(name__1); end;
	Value.ptr.prototype.FieldByNameFunc = function(h)
		var _r, _r__1, _tuple, f, match, ok, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; f = __f.f; match = __f.match; ok = __f.ok; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		_r = v.typ.FieldByNameFunc(match); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		f = __clone(_tuple[0], StructField);
		ok = _tuple[1];
		/* */ if (ok) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if (ok) { */ case 2:
			_r__1 = __clone(v, Value).FieldByIndex(f.Index); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			__s = -1; return _r__1;
		/* end */ case 3:
		__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.FieldByNameFunc end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.f = f; __f.match = match; __f.ok = ok; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.FieldByNameFunc = function(h) return this.__val.FieldByNameFunc(match); end;
	Value.ptr.prototype.Float = function()
		var _1, k, v;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (13)) {
			return ((v.ptr).__get());
		end else if (_1 == (14)) {
			return (v.ptr).__get();
		end
		__panic(new ValueError.ptr("reflect.Value.Float", new flag(v.flag).kind()));
	end;
	Value.prototype.Float = function() return this.__val.Float(); end;
	Value.ptr.prototype.Int = function()
		var _1, k, p, v;
		v = this;
		k = new flag(v.flag).kind();
		p = v.ptr;
		_1 = k;
		if (_1 == (2)) {
			return (new __Int64(0, (p).__get()));
		end else if (_1 == (3)) {
			return (new __Int64(0, (p).__get()));
		end else if (_1 == (4)) {
			return (new __Int64(0, (p).__get()));
		end else if (_1 == (5)) {
			return (new __Int64(0, (p).__get()));
		end else if (_1 == (6)) {
			return (p).__get();
		end
		__panic(new ValueError.ptr("reflect.Value.Int", new flag(v.flag).kind()));
	end;
	Value.prototype.Int = function() return this.__val.Int(); end;
	Value.ptr.prototype.CanInterface = function()
		var v;
		v = this;
		if (v.flag == 0) {
			__panic(new ValueError.ptr("reflect.Value.CanInterface", 0));
		end
		return ((v.flag & 96) >>> 0) == 0;
	end;
	Value.prototype.CanInterface = function() return this.__val.CanInterface(); end;
	Value.ptr.prototype.Interface = function()
		var _r, i, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; i = __f.i; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		i = __ifaceNil;
		v = this;
		_r = valueInterface(__clone(v, Value), true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		i = _r;
		__s = -1; return i;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Interface end; end __f._r = _r; __f.i = i; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Interface = function() return this.__val.Interface(); end;
	Value.ptr.prototype.IsValid = function()
		var v;
		v = this;
		return  not ((v.flag == 0));
	end;
	Value.prototype.IsValid = function() return this.__val.IsValid(); end;
	Value.ptr.prototype.Kind = function()
		var v;
		v = this;
		return new flag(v.flag).kind();
	end;
	Value.prototype.Kind = function() return this.__val.Kind(); end;
	Value.ptr.prototype.MapIndex = function(y)
		var _r, c, e, fl, k, key, tt, typ, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; c = __f.c; e = __f.e; fl = __f.fl; k = __f.k; key = __f.key; tt = __f.tt; typ = __f.typ; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(21);
		tt = (v.typ.kindType);
		_r = __clone(key, Value).assignTo("reflect.Value.MapIndex", tt.key, 0); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		key = _r;
		k = 0;
		if ( not ((((key.flag & 128) >>> 0) == 0))) {
			k = key.ptr;
		end else {
			k = ((key.__ptr_ptr  or  (key.__ptr_ptr = new ptrType__15(function() return this.__target.ptr; end, function(v) this.__target.ptr = __v; end, key))));
		end
		e = mapaccess(v.typ, __clone(v, Value).pointer(), k);
		if (e == 0) {
			__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		end
		typ = tt.elem;
		fl = ((((v.flag | key.flag) >>> 0)) & 96) >>> 0;
		fl = (fl | (((typ.Kind() >>> 0)))) >>> 0;
		if (ifaceIndir(typ)) {
			c = unsafe_New(typ);
			typedmemmove(typ, c, e);
			__s = -1; return new Value.ptr(typ, c, (fl | 128) >>> 0);
		end else {
			__s = -1; return new Value.ptr(typ, (e).__get(), fl);
		end
		__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.MapIndex end; end __f._r = _r; __f.c = c; __f.e = e; __f.fl = fl; __f.k = k; __f.key = key; __f.tt = tt; __f.typ = typ; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.MapIndex = function(y) return this.__val.MapIndex(key); end;
	Value.ptr.prototype.MapKeys = function()
		var _r, a, c, fl, i, it, key, keyType, m, mlen, tt, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; a = __f.a; c = __f.c; fl = __f.fl; i = __f.i; it = __f.it; key = __f.key; keyType = __f.keyType; m = __f.m; mlen = __f.mlen; tt = __f.tt; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(21);
		tt = (v.typ.kindType);
		keyType = tt.key;
		fl = (((v.flag & 96) >>> 0) | ((keyType.Kind() >>> 0))) >>> 0;
		m = __clone(v, Value).pointer();
		mlen = 0;
		if ( not (m == 0)) {
			mlen = maplen(m);
		end
		it = mapiterinit(v.typ, m);
		a = __makeSlice(sliceType__9, mlen);
		i = 0;
		i = 0;
		/* while (true) { */ case 1:
			/* if ( not (i < a.__length)) { break; end */ if( not (i < a.__length)) { __s = 2; continue; end
			_r = mapiterkey(it); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			key = _r;
			if (key == 0) {
				/* break; */ __s = 2; continue;
			end
			if (ifaceIndir(keyType)) {
				c = unsafe_New(keyType);
				typedmemmove(keyType, c, key);
				((i < 0  or  i >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + i] = new Value.ptr(keyType, c, (fl | 128) >>> 0));
			end else {
				((i < 0  or  i >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + i] = new Value.ptr(keyType, (key).__get(), fl));
			end
			mapiternext(it);
			i = i + (1) >> 0;
		/* end */ __s = 1; continue; case 2:
		__s = -1; return __subslice(a, 0, i);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.MapKeys end; end __f._r = _r; __f.a = a; __f.c = c; __f.fl = fl; __f.i = i; __f.it = it; __f.key = key; __f.keyType = keyType; __f.m = m; __f.mlen = mlen; __f.tt = tt; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.MapKeys = function() return this.__val.MapKeys(); end;
	Value.ptr.prototype.Method = function(i)
		var _r, _v, fl, i, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _v = __f._v; fl = __f.fl; i = __f.i; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		if (v.typ == ptrType__1.nil) {
			__panic(new ValueError.ptr("reflect.Value.Method", 0));
		end
		if ( not ((((v.flag & 512) >>> 0) == 0))) { _v = true; __s = 3; continue s; end
		_r = v.typ.NumMethod(); /* */ __s = 4; case 4: if(__c) then  __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_v = ((i >>> 0)) >= ((_r >>> 0)); case 3:
		/* */ if (_v) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (_v) { */ case 1:
			__panic(new __String("reflect: Method index out of range"));
		/* end */ case 2:
		if ((v.typ.Kind() == 20)  and  __clone(v, Value).IsNil()) {
			__panic(new __String("reflect: Method on nil interface value"));
		end
		fl = (v.flag & 160) >>> 0;
		fl = (fl | (19)) >>> 0;
		fl = (fl | ((((((i >>> 0)) << 10 >>> 0) | 512) >>> 0))) >>> 0;
		__s = -1; return new Value.ptr(v.typ, v.ptr, fl);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Method end; end __f._r = _r; __f._v = _v; __f.fl = fl; __f.i = i; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Method = function(i) return this.__val.Method(i); end;
	Value.ptr.prototype.NumMethod = function()
		var _r, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		if (v.typ == ptrType__1.nil) {
			__panic(new ValueError.ptr("reflect.Value.NumMethod", 0));
		end
		if ( not ((((v.flag & 512) >>> 0) == 0))) {
			__s = -1; return 0;
		end
		_r = v.typ.NumMethod(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.NumMethod end; end __f._r = _r; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.NumMethod = function() return this.__val.NumMethod(); end;
	Value.ptr.prototype.MethodByName = function(1)
		var _r, _r__1, _tuple, m, name__1, ok, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; m = __f.m; name__1 = __f.name__1; ok = __f.ok; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		if (v.typ == ptrType__1.nil) {
			__panic(new ValueError.ptr("reflect.Value.MethodByName", 0));
		end
		if ( not ((((v.flag & 512) >>> 0) == 0))) {
			__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		end
		_r = v.typ.MethodByName(name__1); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		m = __clone(_tuple[0], Method);
		ok = _tuple[1];
		if ( not ok) {
			__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		end
		_r__1 = __clone(v, Value).Method(m.Index); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.MethodByName end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.m = m; __f.name__1 = name__1; __f.ok = ok; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.MethodByName = function(1) return this.__val.MethodByName(name__1); end;
	Value.ptr.prototype.NumField = function()
		var tt, v;
		v = this;
		new flag(v.flag).mustBe(25);
		tt = (v.typ.kindType);
		return tt.fields.__length;
	end;
	Value.prototype.NumField = function() return this.__val.NumField(); end;
	Value.ptr.prototype.OverflowComplex = function(x)
		var _1, k, v, x;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (15)) {
			return overflowFloat32(x.__real)  or  overflowFloat32(x.__imag);
		end else if (_1 == (16)) {
			return false;
		end
		__panic(new ValueError.ptr("reflect.Value.OverflowComplex", new flag(v.flag).kind()));
	end;
	Value.prototype.OverflowComplex = function(x) return this.__val.OverflowComplex(x); end;
	Value.ptr.prototype.OverflowFloat = function(x)
		var _1, k, v, x;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (13)) {
			return overflowFloat32(x);
		end else if (_1 == (14)) {
			return false;
		end
		__panic(new ValueError.ptr("reflect.Value.OverflowFloat", new flag(v.flag).kind()));
	end;
	Value.prototype.OverflowFloat = function(x) return this.__val.OverflowFloat(x); end;
	overflowFloat32 = function(x)
		var x;
		if (x < 0) {
			x = -x;
		end
		return 3.4028234663852886e+38 < x  and  x <= 1.7976931348623157e+308;
	end;
	Value.ptr.prototype.OverflowInt = function(x)
		var _1, bitSize, k, trunc, v, x;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if ((_1 == (2))  or  (_1 == (3))  or  (_1 == (4))  or  (_1 == (5))  or  (_1 == (6))) {
			bitSize = __imul(v.typ.size, 8) >>> 0;
			trunc = __shiftRightInt64((__shiftLeft64(x, ((64 - bitSize >>> 0)))), ((64 - bitSize >>> 0)));
			return  not ((x.__high == trunc.__high  and  x.__low == trunc.__low));
		end
		__panic(new ValueError.ptr("reflect.Value.OverflowInt", new flag(v.flag).kind()));
	end;
	Value.prototype.OverflowInt = function(x) return this.__val.OverflowInt(x); end;
	Value.ptr.prototype.OverflowUint = function(x)
		var _1, bitSize, k, trunc, v, x;
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if ((_1 == (7))  or  (_1 == (12))  or  (_1 == (8))  or  (_1 == (9))  or  (_1 == (10))  or  (_1 == (11))) {
			bitSize = __imul(v.typ.size, 8) >>> 0;
			trunc = __shiftRightUint64((__shiftLeft64(x, ((64 - bitSize >>> 0)))), ((64 - bitSize >>> 0)));
			return  not ((x.__high == trunc.__high  and  x.__low == trunc.__low));
		end
		__panic(new ValueError.ptr("reflect.Value.OverflowUint", new flag(v.flag).kind()));
	end;
	Value.prototype.OverflowUint = function(x) return this.__val.OverflowUint(x); end;
	Value.ptr.prototype.Recv = function()
		var _r, _tuple, ok, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; ok = __f.ok; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		x = new Value.ptr(ptrType__1.nil, 0, 0);
		ok = false;
		v = this;
		new flag(v.flag).mustBe(18);
		new flag(v.flag).mustBeExported();
		_r = __clone(v, Value).recv(false); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		x = _tuple[0];
		ok = _tuple[1];
		__s = -1; return [x, ok];
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Recv end; end __f._r = _r; __f._tuple = _tuple; __f.ok = ok; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Recv = function() return this.__val.Recv(); end;
	Value.ptr.prototype.recv = function(b)
		var _r, _tuple, nb, ok, p, selected, t, tt, v, val, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; nb = __f.nb; ok = __f.ok; p = __f.p; selected = __f.selected; t = __f.t; tt = __f.tt; v = __f.v; val = __f.val; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		val = new Value.ptr(ptrType__1.nil, 0, 0);
		ok = false;
		v = this;
		tt = (v.typ.kindType);
		if ((((tt.dir >> 0)) & 1) == 0) {
			__panic(new __String("reflect: recv on send-only channel"));
		end
		t = tt.elem;
		val = new Value.ptr(t, 0, ((t.Kind() >>> 0)));
		p = 0;
		if (ifaceIndir(t)) {
			p = unsafe_New(t);
			val.ptr = p;
			val.flag = (val.flag | (128)) >>> 0;
		end else {
			p = ((val.__ptr_ptr  or  (val.__ptr_ptr = new ptrType__15(function() return this.__target.ptr; end, function(v) this.__target.ptr = __v; end, val))));
		end
		_r = chanrecv(__clone(v, Value).pointer(), nb, p); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		selected = _tuple[0];
		ok = _tuple[1];
		if ( not selected) {
			val = new Value.ptr(ptrType__1.nil, 0, 0);
		end
		__s = -1; return [val, ok];
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.recv end; end __f._r = _r; __f._tuple = _tuple; __f.nb = nb; __f.ok = ok; __f.p = p; __f.selected = selected; __f.t = t; __f.tt = tt; __f.v = v; __f.val = val; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.recv = function(b) return this.__val.recv(nb); end;
	Value.ptr.prototype.Send = function(x)
		var _r, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(18);
		new flag(v.flag).mustBeExported();
		_r = __clone(v, Value).send(__clone(x, Value), false); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r;
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Send end; end __f._r = _r; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Send = function(x) return this.__val.Send(x); end;
	Value.ptr.prototype.send = function(b)
		var _r, _r__1, nb, p, selected, tt, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; nb = __f.nb; p = __f.p; selected = __f.selected; tt = __f.tt; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		selected = false;
		v = this;
		tt = (v.typ.kindType);
		if ((((tt.dir >> 0)) & 2) == 0) {
			__panic(new __String("reflect: send on recv-only channel"));
		end
		new flag(x.flag).mustBeExported();
		_r = __clone(x, Value).assignTo("reflect.Value.Send", tt.elem, 0); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		x = _r;
		p = 0;
		if ( not ((((x.flag & 128) >>> 0) == 0))) {
			p = x.ptr;
		end else {
			p = ((x.__ptr_ptr  or  (x.__ptr_ptr = new ptrType__15(function() return this.__target.ptr; end, function(v) this.__target.ptr = __v; end, x))));
		end
		_r__1 = chansend(__clone(v, Value).pointer(), p, nb); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		selected = _r__1;
		__s = -1; return selected;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.send end; end __f._r = _r; __f._r__1 = _r__1; __f.nb = nb; __f.p = p; __f.selected = selected; __f.tt = tt; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.send = function(b) return this.__val.send(x, nb); end;
	Value.ptr.prototype.SetBool = function(x)
		var v, x;
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(v.flag).mustBe(1);
		(v.ptr).__set(x);
	end;
	Value.prototype.SetBool = function(x) return this.__val.SetBool(x); end;
	Value.ptr.prototype.setRunes = function(x)
		var _r, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(v.flag).mustBe(23);
		_r = v.typ.Elem().Kind(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		/* */ if ( not ((_r == 5))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((_r == 5))) { */ case 1:
			__panic(new __String("reflect.Value.setRunes of non-rune slice"));
		/* end */ case 2:
		(v.ptr).__set(x);
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.setRunes end; end __f._r = _r; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.setRunes = function(x) return this.__val.setRunes(x); end;
	Value.ptr.prototype.SetComplex = function(x)
		var _1, k, v, x;
		v = this;
		new flag(v.flag).mustBeAssignable();
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (15)) {
			(v.ptr).__set((new __Complex64(x.__real, x.__imag)));
		end else if (_1 == (16)) {
			(v.ptr).__set(x);
		end else {
			__panic(new ValueError.ptr("reflect.Value.SetComplex", new flag(v.flag).kind()));
		end
	end;
	Value.prototype.SetComplex = function(x) return this.__val.SetComplex(x); end;
	Value.ptr.prototype.SetFloat = function(x)
		var _1, k, v, x;
		v = this;
		new flag(v.flag).mustBeAssignable();
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (13)) {
			(v.ptr).__set((__fround(x)));
		end else if (_1 == (14)) {
			(v.ptr).__set(x);
		end else {
			__panic(new ValueError.ptr("reflect.Value.SetFloat", new flag(v.flag).kind()));
		end
	end;
	Value.prototype.SetFloat = function(x) return this.__val.SetFloat(x); end;
	Value.ptr.prototype.SetInt = function(x)
		var _1, k, v, x;
		v = this;
		new flag(v.flag).mustBeAssignable();
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (2)) {
			(v.ptr).__set((((x.__low + ((x.__high >> 31) * 4294967296)) >> 0)));
		end else if (_1 == (3)) {
			(v.ptr).__set((((x.__low + ((x.__high >> 31) * 4294967296)) << 24 >> 24)));
		end else if (_1 == (4)) {
			(v.ptr).__set((((x.__low + ((x.__high >> 31) * 4294967296)) << 16 >> 16)));
		end else if (_1 == (5)) {
			(v.ptr).__set((((x.__low + ((x.__high >> 31) * 4294967296)) >> 0)));
		end else if (_1 == (6)) {
			(v.ptr).__set(x);
		end else {
			__panic(new ValueError.ptr("reflect.Value.SetInt", new flag(v.flag).kind()));
		end
	end;
	Value.prototype.SetInt = function(x) return this.__val.SetInt(x); end;
	Value.ptr.prototype.SetMapIndex = function(l)
		var _r, _r__1, e, k, key, tt, v, val, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; e = __f.e; k = __f.k; key = __f.key; tt = __f.tt; v = __f.v; val = __f.val; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(21);
		new flag(v.flag).mustBeExported();
		new flag(key.flag).mustBeExported();
		tt = (v.typ.kindType);
		_r = __clone(key, Value).assignTo("reflect.Value.SetMapIndex", tt.key, 0); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		key = _r;
		k = 0;
		if ( not ((((key.flag & 128) >>> 0) == 0))) {
			k = key.ptr;
		end else {
			k = ((key.__ptr_ptr  or  (key.__ptr_ptr = new ptrType__15(function() return this.__target.ptr; end, function(v) this.__target.ptr = __v; end, key))));
		end
		if (val.typ == ptrType__1.nil) {
			mapdelete(v.typ, __clone(v, Value).pointer(), k);
			__s = -1; return;
		end
		new flag(val.flag).mustBeExported();
		_r__1 = __clone(val, Value).assignTo("reflect.Value.SetMapIndex", tt.elem, 0); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		val = _r__1;
		e = 0;
		if ( not ((((val.flag & 128) >>> 0) == 0))) {
			e = val.ptr;
		end else {
			e = ((val.__ptr_ptr  or  (val.__ptr_ptr = new ptrType__15(function() return this.__target.ptr; end, function(v) this.__target.ptr = __v; end, val))));
		end
		__r = mapassign(v.typ, __clone(v, Value).pointer(), k, e); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.SetMapIndex end; end __f._r = _r; __f._r__1 = _r__1; __f.e = e; __f.k = k; __f.key = key; __f.tt = tt; __f.v = v; __f.val = val; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.SetMapIndex = function(l) return this.__val.SetMapIndex(key, val); end;
	Value.ptr.prototype.SetUint = function(x)
		var _1, k, v, x;
		v = this;
		new flag(v.flag).mustBeAssignable();
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (7)) {
			(v.ptr).__set(((x.__low >>> 0)));
		end else if (_1 == (8)) {
			(v.ptr).__set(((x.__low << 24 >>> 24)));
		end else if (_1 == (9)) {
			(v.ptr).__set(((x.__low << 16 >>> 16)));
		end else if (_1 == (10)) {
			(v.ptr).__set(((x.__low >>> 0)));
		end else if (_1 == (11)) {
			(v.ptr).__set(x);
		end else if (_1 == (12)) {
			(v.ptr).__set(((x.__low >>> 0)));
		end else {
			__panic(new ValueError.ptr("reflect.Value.SetUint", new flag(v.flag).kind()));
		end
	end;
	Value.prototype.SetUint = function(x) return this.__val.SetUint(x); end;
	Value.ptr.prototype.SetPointer = function(x)
		var v, x;
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(v.flag).mustBe(26);
		(v.ptr).__set(x);
	end;
	Value.prototype.SetPointer = function(x) return this.__val.SetPointer(x); end;
	Value.ptr.prototype.SetString = function(x)
		var v, x;
		v = this;
		new flag(v.flag).mustBeAssignable();
		new flag(v.flag).mustBe(24);
		(v.ptr).__set(x);
	end;
	Value.prototype.SetString = function(x) return this.__val.SetString(x); end;
	Value.ptr.prototype.String = function()
		var _1, _r, k, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; k = __f.k; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		k = new flag(v.flag).kind();
		_1 = k;
		if (_1 == (0)) {
			__s = -1; return "<invalid Value>";
		end else if (_1 == (24)) {
			__s = -1; return (v.ptr).__get();
		end
		_r = __clone(v, Value).Type().String(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return "<" + _r + " Value>";
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.String end; end __f._1 = _1; __f._r = _r; __f.k = k; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.String = function() return this.__val.String(); end;
	Value.ptr.prototype.TryRecv = function()
		var _r, _tuple, ok, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; ok = __f.ok; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		x = new Value.ptr(ptrType__1.nil, 0, 0);
		ok = false;
		v = this;
		new flag(v.flag).mustBe(18);
		new flag(v.flag).mustBeExported();
		_r = __clone(v, Value).recv(true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		x = _tuple[0];
		ok = _tuple[1];
		__s = -1; return [x, ok];
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.TryRecv end; end __f._r = _r; __f._tuple = _tuple; __f.ok = ok; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.TryRecv = function() return this.__val.TryRecv(); end;
	Value.ptr.prototype.TrySend = function(x)
		var _r, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		new flag(v.flag).mustBe(18);
		new flag(v.flag).mustBeExported();
		_r = __clone(v, Value).send(__clone(x, Value), true); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.TrySend end; end __f._r = _r; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.TrySend = function(x) return this.__val.TrySend(x); end;
	Value.ptr.prototype.Type = function()
		var f, i, m, m__1, tt, ut, v, x, x__1;
		v = this;
		f = v.flag;
		if (f == 0) {
			__panic(new ValueError.ptr("reflect.Value.Type", 0));
		end
		if (((f & 512) >>> 0) == 0) {
			return v.typ;
		end
		i = ((v.flag >> 0)) >> 10 >> 0;
		if (v.typ.Kind() == 20) {
			tt = (v.typ.kindType);
			if (((i >>> 0)) >= ((tt.methods.__length >>> 0))) {
				__panic(new __String("reflect: internal error: invalid method index"));
			end
			m = (x = tt.methods, ((i < 0  or  i >= x.__length) ? (__throwRuntimeError("index out of range"), nil) : x.__array[x.__offset + i]));
			return v.typ.typeOff(m.typ);
		end
		ut = v.typ.uncommon();
		if (ut == ptrType__5.nil  or  ((i >>> 0)) >= ((ut.mcount >>> 0))) {
			__panic(new __String("reflect: internal error: invalid method index"));
		end
		m__1 = __clone((x__1 = ut.methods(), ((i < 0  or  i >= x__1.__length) ? (__throwRuntimeError("index out of range"), nil) : x__1.__array[x__1.__offset + i])), method);
		return v.typ.typeOff(m__1.mtyp);
	end;
	Value.prototype.Type = function() return this.__val.Type(); end;
	Value.ptr.prototype.Uint = function()
		var _1, k, p, v, x;
		v = this;
		k = new flag(v.flag).kind();
		p = v.ptr;
		_1 = k;
		if (_1 == (7)) {
			return (new __Uint64(0, (p).__get()));
		end else if (_1 == (8)) {
			return (new __Uint64(0, (p).__get()));
		end else if (_1 == (9)) {
			return (new __Uint64(0, (p).__get()));
		end else if (_1 == (10)) {
			return (new __Uint64(0, (p).__get()));
		end else if (_1 == (11)) {
			return (p).__get();
		end else if (_1 == (12)) {
			return ((x = (p).__get(), new __Uint64(0, x.constructor == Number ? x : 1)));
		end
		__panic(new ValueError.ptr("reflect.Value.Uint", new flag(v.flag).kind()));
	end;
	Value.prototype.Uint = function() return this.__val.Uint(); end;
	Value.ptr.prototype.UnsafeAddr = function()
		var v;
		v = this;
		if (v.typ == ptrType__1.nil) {
			__panic(new ValueError.ptr("reflect.Value.UnsafeAddr", 0));
		end
		if (((v.flag & 256) >>> 0) == 0) {
			__panic(new __String("reflect.Value.UnsafeAddr of unaddressable value"));
		end
		return (v.ptr);
	end;
	Value.prototype.UnsafeAddr = function() return this.__val.UnsafeAddr(); end;
	New = function(p)
		var _r, _r__1, fl, ptr, typ, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; fl = __f.fl; ptr = __f.ptr; typ = __f.typ; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		if (__interfaceIsEqual(typ, __ifaceNil)) {
			__panic(new __String("reflect: New(nil)"));
		end
		ptr = unsafe_New(__assertType(typ, ptrType__1));
		fl = 22;
		_r = typ.common(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = _r.ptrTo(); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return new Value.ptr(_r__1, ptr, fl);
		/* */ end return; end if __f == nil then  __f = { __blk: New end; end __f._r = _r; __f._r__1 = _r__1; __f.fl = fl; __f.ptr = ptr; __f.typ = typ; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.New = New;
	Value.ptr.prototype.assignTo = function(t)
		var _r, _r__1, _r__2, _r__3, context, dst, fl, target, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; context = __f.context; dst = __f.dst; fl = __f.fl; target = __f.target; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		/* */ if ( not ((((v.flag & 512) >>> 0) == 0))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((((v.flag & 512) >>> 0) == 0))) { */ case 1:
			_r = makeMethodValue(context, __clone(v, Value)); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			v = _r;
		/* end */ case 2:
			_r__1 = directlyAssignable(dst, v.typ); /* */ __s = 8; case 8: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			/* */ if (_r__1) { __s = 5; continue; end
			/* */ if (implements__1(dst, v.typ)) { __s = 6; continue; end
			/* */ __s = 7; continue;
			/* if (_r__1) { */ case 5:
				fl = (v.flag & 480) >>> 0;
				fl = (fl | (((dst.Kind() >>> 0)))) >>> 0;
				__s = -1; return new Value.ptr(dst, v.ptr, fl);
			/* end else if (implements__1(dst, v.typ)) { */ case 6:
				if (target == 0) {
					target = unsafe_New(dst);
				end
				_r__2 = valueInterface(__clone(v, Value), false); /* */ __s = 9; case 9: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				x = _r__2;
				_r__3 = dst.NumMethod(); /* */ __s = 13; case 13: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
				/* */ if (_r__3 == 0) { __s = 10; continue; end
				/* */ __s = 11; continue;
				/* if (_r__3 == 0) { */ case 10:
					(target).__set(x);
					__s = 12; continue;
				/* end else { */ case 11:
					ifaceE2I(dst, x, target);
				/* end */ case 12:
				__s = -1; return new Value.ptr(dst, target, 148);
			/* end */ case 7:
		case 4:
		__panic(new __String(context + ": value of type " + v.typ.String() + " is not assignable to type " + dst.String()));
		__s = -1; return new Value.ptr(ptrType__1.nil, 0, 0);
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.assignTo end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f.context = context; __f.dst = dst; __f.fl = fl; __f.target = target; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.assignTo = function(t) return this.__val.assignTo(context, dst, target); end;
	Value.ptr.prototype.Convert = function(t)
		var _r, _r__1, _r__2, _r__3, _r__4, op, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; op = __f.op; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		v = this;
		/* */ if ( not ((((v.flag & 512) >>> 0) == 0))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not ((((v.flag & 512) >>> 0) == 0))) { */ case 1:
			_r = makeMethodValue("Convert", __clone(v, Value)); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			v = _r;
		/* end */ case 2:
		_r__1 = t.common(); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_r__2 = convertOp(_r__1, v.typ); /* */ __s = 5; case 5: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		op = _r__2;
		/* */ if (op == __throwNilPointerError) { __s = 6; continue; end
		/* */ __s = 7; continue;
		/* if (op == __throwNilPointerError) { */ case 6:
			_r__3 = t.String(); /* */ __s = 8; case 8: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
			__panic(new __String("reflect.Value.Convert: value of type " + v.typ.String() + " cannot be converted to type " + _r__3));
		/* end */ case 7:
		_r__4 = op(__clone(v, Value), t); /* */ __s = 9; case 9: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
		__s = -1; return _r__4;
		/* */ end return; end if __f == nil then  __f = { __blk: Value.ptr.prototype.Convert end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f.op = op; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	Value.prototype.Convert = function(t) return this.__val.Convert(t); end;
	convertOp = function(c)
		var _1, _2, _3, _4, _5, _6, _7, _arg, _arg__1, _r, _r__1, _r__2, _r__3, _r__4, _r__5, _r__6, _r__7, _v, _v__1, _v__2, dst, src, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _2 = __f._2; _3 = __f._3; _4 = __f._4; _5 = __f._5; _6 = __f._6; _7 = __f._7; _arg = __f._arg; _arg__1 = __f._arg__1; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _r__6 = __f._r__6; _r__7 = __f._r__7; _v = __f._v; _v__1 = __f._v__1; _v__2 = __f._v__2; dst = __f.dst; src = __f.src; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
			_1 = src.Kind();
			/* */ if ((_1 == (2))  or  (_1 == (3))  or  (_1 == (4))  or  (_1 == (5))  or  (_1 == (6))) { __s = 2; continue; end
			/* */ if ((_1 == (7))  or  (_1 == (8))  or  (_1 == (9))  or  (_1 == (10))  or  (_1 == (11))  or  (_1 == (12))) { __s = 3; continue; end
			/* */ if ((_1 == (13))  or  (_1 == (14))) { __s = 4; continue; end
			/* */ if ((_1 == (15))  or  (_1 == (16))) { __s = 5; continue; end
			/* */ if (_1 == (24)) { __s = 6; continue; end
			/* */ if (_1 == (23)) { __s = 7; continue; end
			/* */ __s = 8; continue;
			/* if ((_1 == (2))  or  (_1 == (3))  or  (_1 == (4))  or  (_1 == (5))  or  (_1 == (6))) { */ case 2:
				_2 = dst.Kind();
				if ((_2 == (2))  or  (_2 == (3))  or  (_2 == (4))  or  (_2 == (5))  or  (_2 == (6))  or  (_2 == (7))  or  (_2 == (8))  or  (_2 == (9))  or  (_2 == (10))  or  (_2 == (11))  or  (_2 == (12))) {
					__s = -1; return cvtInt;
				end else if ((_2 == (13))  or  (_2 == (14))) {
					__s = -1; return cvtIntFloat;
				end else if (_2 == (24)) {
					__s = -1; return cvtIntString;
				end
				__s = 8; continue;
			/* end else if ((_1 == (7))  or  (_1 == (8))  or  (_1 == (9))  or  (_1 == (10))  or  (_1 == (11))  or  (_1 == (12))) { */ case 3:
				_3 = dst.Kind();
				if ((_3 == (2))  or  (_3 == (3))  or  (_3 == (4))  or  (_3 == (5))  or  (_3 == (6))  or  (_3 == (7))  or  (_3 == (8))  or  (_3 == (9))  or  (_3 == (10))  or  (_3 == (11))  or  (_3 == (12))) {
					__s = -1; return cvtUint;
				end else if ((_3 == (13))  or  (_3 == (14))) {
					__s = -1; return cvtUintFloat;
				end else if (_3 == (24)) {
					__s = -1; return cvtUintString;
				end
				__s = 8; continue;
			/* end else if ((_1 == (13))  or  (_1 == (14))) { */ case 4:
				_4 = dst.Kind();
				if ((_4 == (2))  or  (_4 == (3))  or  (_4 == (4))  or  (_4 == (5))  or  (_4 == (6))) {
					__s = -1; return cvtFloatInt;
				end else if ((_4 == (7))  or  (_4 == (8))  or  (_4 == (9))  or  (_4 == (10))  or  (_4 == (11))  or  (_4 == (12))) {
					__s = -1; return cvtFloatUint;
				end else if ((_4 == (13))  or  (_4 == (14))) {
					__s = -1; return cvtFloat;
				end
				__s = 8; continue;
			/* end else if ((_1 == (15))  or  (_1 == (16))) { */ case 5:
				_5 = dst.Kind();
				if ((_5 == (15))  or  (_5 == (16))) {
					__s = -1; return cvtComplex;
				end
				__s = 8; continue;
			/* end else if (_1 == (24)) { */ case 6:
				if ( not (dst.Kind() == 23)) { _v = false; __s = 11; continue s; end
				_r = dst.Elem().PkgPath(); /* */ __s = 12; case 12: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				_v = _r == ""; case 11:
				/* */ if (_v) { __s = 9; continue; end
				/* */ __s = 10; continue;
				/* if (_v) { */ case 9:
						_r__1 = dst.Elem().Kind(); /* */ __s = 14; case 14: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
						_6 = _r__1;
						if (_6 == (8)) {
							__s = -1; return cvtStringBytes;
						end else if (_6 == (5)) {
							__s = -1; return cvtStringRunes;
						end
					case 13:
				/* end */ case 10:
				__s = 8; continue;
			/* end else if (_1 == (23)) { */ case 7:
				if ( not (dst.Kind() == 24)) { _v__1 = false; __s = 17; continue s; end
				_r__2 = src.Elem().PkgPath(); /* */ __s = 18; case 18: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				_v__1 = _r__2 == ""; case 17:
				/* */ if (_v__1) { __s = 15; continue; end
				/* */ __s = 16; continue;
				/* if (_v__1) { */ case 15:
						_r__3 = src.Elem().Kind(); /* */ __s = 20; case 20: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
						_7 = _r__3;
						if (_7 == (8)) {
							__s = -1; return cvtBytesString;
						end else if (_7 == (5)) {
							__s = -1; return cvtRunesString;
						end
					case 19:
				/* end */ case 16:
			/* end */ case 8:
		case 1:
		_r__4 = haveIdenticalUnderlyingType(dst, src, false); /* */ __s = 23; case 23: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
		/* */ if (_r__4) { __s = 21; continue; end
		/* */ __s = 22; continue;
		/* if (_r__4) { */ case 21:
			__s = -1; return cvtDirect;
		/* end */ case 22:
		if ( not ((dst.Kind() == 22)  and  dst.Name() == ""  and  (src.Kind() == 22)  and  src.Name() == "")) { _v__2 = false; __s = 26; continue s; end
		_r__5 = dst.Elem().common(); /* */ __s = 27; case 27: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
		_arg = _r__5;
		_r__6 = src.Elem().common(); /* */ __s = 28; case 28: if(__c) then __c = false; _r__6 = _r__6.__blk(); end if (_r__6  and  _r__6.__blk ~= nil) { break s; end
		_arg__1 = _r__6;
		_r__7 = haveIdenticalUnderlyingType(_arg, _arg__1, false); /* */ __s = 29; case 29: if(__c) then __c = false; _r__7 = _r__7.__blk(); end if (_r__7  and  _r__7.__blk ~= nil) { break s; end
		_v__2 = _r__7; case 26:
		/* */ if (_v__2) { __s = 24; continue; end
		/* */ __s = 25; continue;
		/* if (_v__2) { */ case 24:
			__s = -1; return cvtDirect;
		/* end */ case 25:
		if (implements__1(dst, src)) {
			if (src.Kind() == 20) {
				__s = -1; return cvtI2I;
			end
			__s = -1; return cvtT2I;
		end
		__s = -1; return __throwNilPointerError;
		/* */ end return; end if __f == nil then  __f = { __blk: convertOp end; end __f._1 = _1; __f._2 = _2; __f._3 = _3; __f._4 = _4; __f._5 = _5; __f._6 = _6; __f._7 = _7; __f._arg = _arg; __f._arg__1 = _arg__1; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._r__6 = _r__6; __f._r__7 = _r__7; __f._v = _v; __f._v__1 = _v__1; __f._v__2 = _v__2; __f.dst = dst; __f.src = src; __f.__s = __s; __f.__r = __r; return __f;
	end;
	makeFloat = function(t)
		var _1, _r, f, ptr, t, typ, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; f = __f.f; ptr = __f.ptr; t = __f.t; typ = __f.typ; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = t.common(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		typ = _r;
		ptr = unsafe_New(typ);
		_1 = typ.size;
		if (_1 == (4)) {
			(ptr).__set((__fround(v)));
		end else if (_1 == (8)) {
			(ptr).__set(v);
		end
		__s = -1; return new Value.ptr(typ, ptr, (((f | 128) >>> 0) | ((typ.Kind() >>> 0))) >>> 0);
		/* */ end return; end if __f == nil then  __f = { __blk: makeFloat end; end __f._1 = _1; __f._r = _r; __f.f = f; __f.ptr = ptr; __f.t = t; __f.typ = typ; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	makeComplex = function(t)
		var _1, _r, f, ptr, t, typ, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; f = __f.f; ptr = __f.ptr; t = __f.t; typ = __f.typ; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = t.common(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		typ = _r;
		ptr = unsafe_New(typ);
		_1 = typ.size;
		if (_1 == (8)) {
			(ptr).__set((new __Complex64(v.__real, v.__imag)));
		end else if (_1 == (16)) {
			(ptr).__set(v);
		end
		__s = -1; return new Value.ptr(typ, ptr, (((f | 128) >>> 0) | ((typ.Kind() >>> 0))) >>> 0);
		/* */ end return; end if __f == nil then  __f = { __blk: makeComplex end; end __f._1 = _1; __f._r = _r; __f.f = f; __f.ptr = ptr; __f.t = t; __f.typ = typ; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	makeString = function(t)
		var _r, _r__1, f, ret, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; f = __f.f; ret = __f.ret; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = New(t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = __clone(_r, Value).Elem(); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		ret = _r__1;
		__clone(ret, Value).SetString(v);
		ret.flag = (((ret.flag & ~256) >>> 0) | f) >>> 0;
		__s = -1; return ret;
		/* */ end return; end if __f == nil then  __f = { __blk: makeString end; end __f._r = _r; __f._r__1 = _r__1; __f.f = f; __f.ret = ret; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	makeBytes = function(t)
		var _r, _r__1, f, ret, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; f = __f.f; ret = __f.ret; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = New(t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = __clone(_r, Value).Elem(); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		ret = _r__1;
		__r = __clone(ret, Value).SetBytes(v); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		ret.flag = (((ret.flag & ~256) >>> 0) | f) >>> 0;
		__s = -1; return ret;
		/* */ end return; end if __f == nil then  __f = { __blk: makeBytes end; end __f._r = _r; __f._r__1 = _r__1; __f.f = f; __f.ret = ret; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	makeRunes = function(t)
		var _r, _r__1, f, ret, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; f = __f.f; ret = __f.ret; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = New(t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = __clone(_r, Value).Elem(); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		ret = _r__1;
		__r = __clone(ret, Value).setRunes(v); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		ret.flag = (((ret.flag & ~256) >>> 0) | f) >>> 0;
		__s = -1; return ret;
		/* */ end return; end if __f == nil then  __f = { __blk: makeRunes end; end __f._r = _r; __f._r__1 = _r__1; __f.f = f; __f.ret = ret; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtInt = function(t)
		var _r, t, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeInt((v.flag & 96) >>> 0, ((x = __clone(v, Value).Int(), new __Uint64(x.__high, x.__low))), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtInt end; end __f._r = _r; __f.t = t; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtUint = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeInt((v.flag & 96) >>> 0, __clone(v, Value).Uint(), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtUint end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtFloatInt = function(t)
		var _r, t, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeInt((v.flag & 96) >>> 0, ((x = (new __Int64(0, __clone(v, Value).Float())), new __Uint64(x.__high, x.__low))), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtFloatInt end; end __f._r = _r; __f.t = t; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtFloatUint = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeInt((v.flag & 96) >>> 0, (new __Uint64(0, __clone(v, Value).Float())), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtFloatUint end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtIntFloat = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeFloat((v.flag & 96) >>> 0, (__flatten64(__clone(v, Value).Int())), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtIntFloat end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtUintFloat = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeFloat((v.flag & 96) >>> 0, (__flatten64(__clone(v, Value).Uint())), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtUintFloat end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtFloat = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeFloat((v.flag & 96) >>> 0, __clone(v, Value).Float(), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtFloat end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtComplex = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeComplex((v.flag & 96) >>> 0, __clone(v, Value).Complex(), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtComplex end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtIntString = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeString((v.flag & 96) >>> 0, (__encodeRune(__clone(v, Value).Int().__low)), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtIntString end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtUintString = function(t)
		var _r, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = makeString((v.flag & 96) >>> 0, (__encodeRune(__clone(v, Value).Uint().__low)), t); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__s = -1; return _r;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtUintString end; end __f._r = _r; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtBytesString = function(t)
		var _arg, _arg__1, _arg__2, _r, _r__1, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _arg = __f._arg; _arg__1 = __f._arg__1; _arg__2 = __f._arg__2; _r = __f._r; _r__1 = __f._r__1; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_arg = (v.flag & 96) >>> 0;
		_r = __clone(v, Value).Bytes(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_arg__1 = (__bytesToString(_r));
		_arg__2 = t;
		_r__1 = makeString(_arg, _arg__1, _arg__2); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtBytesString end; end __f._arg = _arg; __f._arg__1 = _arg__1; __f._arg__2 = _arg__2; __f._r = _r; __f._r__1 = _r__1; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtStringBytes = function(t)
		var _arg, _arg__1, _arg__2, _r, _r__1, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _arg = __f._arg; _arg__1 = __f._arg__1; _arg__2 = __f._arg__2; _r = __f._r; _r__1 = __f._r__1; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_arg = (v.flag & 96) >>> 0;
		_r = __clone(v, Value).String(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_arg__1 = (new sliceType__15(__stringToBytes(_r)));
		_arg__2 = t;
		_r__1 = makeBytes(_arg, _arg__1, _arg__2); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtStringBytes end; end __f._arg = _arg; __f._arg__1 = _arg__1; __f._arg__2 = _arg__2; __f._r = _r; __f._r__1 = _r__1; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtRunesString = function(t)
		var _arg, _arg__1, _arg__2, _r, _r__1, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _arg = __f._arg; _arg__1 = __f._arg__1; _arg__2 = __f._arg__2; _r = __f._r; _r__1 = __f._r__1; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_arg = (v.flag & 96) >>> 0;
		_r = __clone(v, Value).runes(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_arg__1 = (__runesToString(_r));
		_arg__2 = t;
		_r__1 = makeString(_arg, _arg__1, _arg__2); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtRunesString end; end __f._arg = _arg; __f._arg__1 = _arg__1; __f._arg__2 = _arg__2; __f._r = _r; __f._r__1 = _r__1; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtStringRunes = function(t)
		var _arg, _arg__1, _arg__2, _r, _r__1, t, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _arg = __f._arg; _arg__1 = __f._arg__1; _arg__2 = __f._arg__2; _r = __f._r; _r__1 = __f._r__1; t = __f.t; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_arg = (v.flag & 96) >>> 0;
		_r = __clone(v, Value).String(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_arg__1 = (new sliceType__17(__stringToRunes(_r)));
		_arg__2 = t;
		_r__1 = makeRunes(_arg, _arg__1, _arg__2); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		__s = -1; return _r__1;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtStringRunes end; end __f._arg = _arg; __f._arg__1 = _arg__1; __f._arg__2 = _arg__2; __f._r = _r; __f._r__1 = _r__1; __f.t = t; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtT2I = function(p)
		var _r, _r__1, _r__2, _r__3, _r__4, target, typ, v, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; target = __f.target; typ = __f.typ; v = __f.v; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = typ.common(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r__1 = unsafe_New(_r); /* */ __s = 2; case 2: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		target = _r__1;
		_r__2 = valueInterface(__clone(v, Value), false); /* */ __s = 3; case 3: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		x = _r__2;
		_r__3 = typ.NumMethod(); /* */ __s = 7; case 7: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
		/* */ if (_r__3 == 0) { __s = 4; continue; end
		/* */ __s = 5; continue;
		/* if (_r__3 == 0) { */ case 4:
			(target).__set(x);
			__s = 6; continue;
		/* end else { */ case 5:
			ifaceE2I(__assertType(typ, ptrType__1), x, target);
		/* end */ case 6:
		_r__4 = typ.common(); /* */ __s = 8; case 8: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
		__s = -1; return new Value.ptr(_r__4, target, (((((v.flag & 96) >>> 0) | 128) >>> 0) | 20) >>> 0);
		/* */ end return; end if __f == nil then  __f = { __blk: cvtT2I end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f.target = target; __f.typ = typ; __f.v = v; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	cvtI2I = function(p)
		var _r, _r__1, _r__2, ret, typ, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; ret = __f.ret; typ = __f.typ; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		/* */ if (__clone(v, Value).IsNil()) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (__clone(v, Value).IsNil()) { */ case 1:
			_r = Zero(typ); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			ret = _r;
			ret.flag = (ret.flag | (((v.flag & 96) >>> 0))) >>> 0;
			__s = -1; return ret;
		/* end */ case 2:
		_r__1 = __clone(v, Value).Elem(); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_r__2 = cvtT2I(__clone(_r__1, Value), typ); /* */ __s = 5; case 5: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
		__s = -1; return _r__2;
		/* */ end return; end if __f == nil then  __f = { __blk: cvtI2I end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f.ret = ret; __f.typ = typ; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ptrType__5.methods = [{prop: "methods", name: "methods", pkg: "reflect", typ: __funcType([], [sliceType__5], false)end];
	ptrType__16.methods = [{prop: "in__", name: "in", pkg: "reflect", typ: __funcType([], [sliceType__2], false)end, {prop: "out", name: "out", pkg: "reflect", typ: __funcType([], [sliceType__2], false)end];
	name.methods = [{prop: "name", name: "name", pkg: "reflect", typ: __funcType([], [__String], false)end, {prop: "tag", name: "tag", pkg: "reflect", typ: __funcType([], [__String], false)end, {prop: "pkgPath", name: "pkgPath", pkg: "reflect", typ: __funcType([], [__String], false)end, {prop: "isExported", name: "isExported", pkg: "reflect", typ: __funcType([], [__Bool], false)end, {prop: "data", name: "data", pkg: "reflect", typ: __funcType([__Int], [ptrType__4], false)end, {prop: "nameLen", name: "nameLen", pkg: "reflect", typ: __funcType([], [__Int], false)end, {prop: "tagLen", name: "tagLen", pkg: "reflect", typ: __funcType([], [__Int], false)end];
	Kind.methods = [{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end];
	ptrType__1.methods = [{prop: "uncommon", name: "uncommon", pkg: "reflect", typ: __funcType([], [ptrType__5], false)end, {prop: "nameOff", name: "nameOff", pkg: "reflect", typ: __funcType([nameOff], [name], false)end, {prop: "typeOff", name: "typeOff", pkg: "reflect", typ: __funcType([typeOff], [ptrType__1], false)end, {prop: "ptrTo", name: "ptrTo", pkg: "reflect", typ: __funcType([], [ptrType__1], false)end, {prop: "pointers", name: "pointers", pkg: "reflect", typ: __funcType([], [__Bool], false)end, {prop: "Comparable", name: "Comparable", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Method", name: "Method", pkg: "", typ: __funcType([__Int], [Method], false)end, {prop: "textOff", name: "textOff", pkg: "reflect", typ: __funcType([textOff], [__UnsafePointer], false)end, {prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Size", name: "Size", pkg: "", typ: __funcType([], [__Uintptr], false)end, {prop: "Bits", name: "Bits", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Align", name: "Align", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "FieldAlign", name: "FieldAlign", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Kind", name: "Kind", pkg: "", typ: __funcType([], [Kind], false)end, {prop: "common", name: "common", pkg: "reflect", typ: __funcType([], [ptrType__1], false)end, {prop: "exportedMethods", name: "exportedMethods", pkg: "reflect", typ: __funcType([], [sliceType__5], false)end, {prop: "NumMethod", name: "NumMethod", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "MethodByName", name: "MethodByName", pkg: "", typ: __funcType([__String], [Method, __Bool], false)end, {prop: "PkgPath", name: "PkgPath", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Name", name: "Name", pkg: "", typ: __funcType([], [__String], false)end, {prop: "ChanDir", name: "ChanDir", pkg: "", typ: __funcType([], [ChanDir], false)end, {prop: "IsVariadic", name: "IsVariadic", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Elem", name: "Elem", pkg: "", typ: __funcType([], [Type], false)end, {prop: "Field", name: "Field", pkg: "", typ: __funcType([__Int], [StructField], false)end, {prop: "FieldByIndex", name: "FieldByIndex", pkg: "", typ: __funcType([sliceType__13], [StructField], false)end, {prop: "FieldByName", name: "FieldByName", pkg: "", typ: __funcType([__String], [StructField, __Bool], false)end, {prop: "FieldByNameFunc", name: "FieldByNameFunc", pkg: "", typ: __funcType([funcType__3], [StructField, __Bool], false)end, {prop: "In", name: "In", pkg: "", typ: __funcType([__Int], [Type], false)end, {prop: "Key", name: "Key", pkg: "", typ: __funcType([], [Type], false)end, {prop: "Len", name: "Len", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "NumField", name: "NumField", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "NumIn", name: "NumIn", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "NumOut", name: "NumOut", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Out", name: "Out", pkg: "", typ: __funcType([__Int], [Type], false)end, {prop: "Implements", name: "Implements", pkg: "", typ: __funcType([Type], [__Bool], false)end, {prop: "AssignableTo", name: "AssignableTo", pkg: "", typ: __funcType([Type], [__Bool], false)end, {prop: "ConvertibleTo", name: "ConvertibleTo", pkg: "", typ: __funcType([Type], [__Bool], false)end];
	ChanDir.methods = [{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end];
	ptrType__7.methods = [{prop: "Method", name: "Method", pkg: "", typ: __funcType([__Int], [Method], false)end, {prop: "NumMethod", name: "NumMethod", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "MethodByName", name: "MethodByName", pkg: "", typ: __funcType([__String], [Method, __Bool], false)end];
	ptrType__17.methods = [{prop: "offset", name: "offset", pkg: "reflect", typ: __funcType([], [__Uintptr], false)end, {prop: "anon", name: "anon", pkg: "reflect", typ: __funcType([], [__Bool], false)end];
	ptrType__9.methods = [{prop: "Field", name: "Field", pkg: "", typ: __funcType([__Int], [StructField], false)end, {prop: "FieldByIndex", name: "FieldByIndex", pkg: "", typ: __funcType([sliceType__13], [StructField], false)end, {prop: "FieldByNameFunc", name: "FieldByNameFunc", pkg: "", typ: __funcType([funcType__3], [StructField, __Bool], false)end, {prop: "FieldByName", name: "FieldByName", pkg: "", typ: __funcType([__String], [StructField, __Bool], false)end];
	StructTag.methods = [{prop: "Get", name: "Get", pkg: "", typ: __funcType([__String], [__String], false)end, {prop: "Lookup", name: "Lookup", pkg: "", typ: __funcType([__String], [__String, __Bool], false)end];
	Value.methods = [{prop: "object", name: "object", pkg: "reflect", typ: __funcType([], [ptrType__2], false)end, {prop: "call", name: "call", pkg: "reflect", typ: __funcType([__String, sliceType__9], [sliceType__9], false)end, {prop: "Cap", name: "Cap", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Elem", name: "Elem", pkg: "", typ: __funcType([], [Value], false)end, {prop: "Field", name: "Field", pkg: "", typ: __funcType([__Int], [Value], false)end, {prop: "Index", name: "Index", pkg: "", typ: __funcType([__Int], [Value], false)end, {prop: "InterfaceData", name: "InterfaceData", pkg: "", typ: __funcType([], [arrayType__12], false)end, {prop: "IsNil", name: "IsNil", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Len", name: "Len", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Pointer", name: "Pointer", pkg: "", typ: __funcType([], [__Uintptr], false)end, {prop: "Set", name: "Set", pkg: "", typ: __funcType([Value], [], false)end, {prop: "SetBytes", name: "SetBytes", pkg: "", typ: __funcType([sliceType__15], [], false)end, {prop: "SetCap", name: "SetCap", pkg: "", typ: __funcType([__Int], [], false)end, {prop: "SetLen", name: "SetLen", pkg: "", typ: __funcType([__Int], [], false)end, {prop: "Slice", name: "Slice", pkg: "", typ: __funcType([__Int, __Int], [Value], false)end, {prop: "Slice3", name: "Slice3", pkg: "", typ: __funcType([__Int, __Int, __Int], [Value], false)end, {prop: "Close", name: "Close", pkg: "", typ: __funcType([], [], false)end, {prop: "pointer", name: "pointer", pkg: "reflect", typ: __funcType([], [__UnsafePointer], false)end, {prop: "Addr", name: "Addr", pkg: "", typ: __funcType([], [Value], false)end, {prop: "Bool", name: "Bool", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Bytes", name: "Bytes", pkg: "", typ: __funcType([], [sliceType__15], false)end, {prop: "runes", name: "runes", pkg: "reflect", typ: __funcType([], [sliceType__17], false)end, {prop: "CanAddr", name: "CanAddr", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "CanSet", name: "CanSet", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Call", name: "Call", pkg: "", typ: __funcType([sliceType__9], [sliceType__9], false)end, {prop: "CallSlice", name: "CallSlice", pkg: "", typ: __funcType([sliceType__9], [sliceType__9], false)end, {prop: "Complex", name: "Complex", pkg: "", typ: __funcType([], [__Complex128], false)end, {prop: "FieldByIndex", name: "FieldByIndex", pkg: "", typ: __funcType([sliceType__13], [Value], false)end, {prop: "FieldByName", name: "FieldByName", pkg: "", typ: __funcType([__String], [Value], false)end, {prop: "FieldByNameFunc", name: "FieldByNameFunc", pkg: "", typ: __funcType([funcType__3], [Value], false)end, {prop: "Float", name: "Float", pkg: "", typ: __funcType([], [__Float64], false)end, {prop: "Int", name: "Int", pkg: "", typ: __funcType([], [__Int64], false)end, {prop: "CanInterface", name: "CanInterface", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Interface", name: "Interface", pkg: "", typ: __funcType([], [__emptyInterface], false)end, {prop: "IsValid", name: "IsValid", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Kind", name: "Kind", pkg: "", typ: __funcType([], [Kind], false)end, {prop: "MapIndex", name: "MapIndex", pkg: "", typ: __funcType([Value], [Value], false)end, {prop: "MapKeys", name: "MapKeys", pkg: "", typ: __funcType([], [sliceType__9], false)end, {prop: "Method", name: "Method", pkg: "", typ: __funcType([__Int], [Value], false)end, {prop: "NumMethod", name: "NumMethod", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "MethodByName", name: "MethodByName", pkg: "", typ: __funcType([__String], [Value], false)end, {prop: "NumField", name: "NumField", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "OverflowComplex", name: "OverflowComplex", pkg: "", typ: __funcType([__Complex128], [__Bool], false)end, {prop: "OverflowFloat", name: "OverflowFloat", pkg: "", typ: __funcType([__Float64], [__Bool], false)end, {prop: "OverflowInt", name: "OverflowInt", pkg: "", typ: __funcType([__Int64], [__Bool], false)end, {prop: "OverflowUint", name: "OverflowUint", pkg: "", typ: __funcType([__Uint64], [__Bool], false)end, {prop: "Recv", name: "Recv", pkg: "", typ: __funcType([], [Value, __Bool], false)end, {prop: "recv", name: "recv", pkg: "reflect", typ: __funcType([__Bool], [Value, __Bool], false)end, {prop: "Send", name: "Send", pkg: "", typ: __funcType([Value], [], false)end, {prop: "send", name: "send", pkg: "reflect", typ: __funcType([Value, __Bool], [__Bool], false)end, {prop: "SetBool", name: "SetBool", pkg: "", typ: __funcType([__Bool], [], false)end, {prop: "setRunes", name: "setRunes", pkg: "reflect", typ: __funcType([sliceType__17], [], false)end, {prop: "SetComplex", name: "SetComplex", pkg: "", typ: __funcType([__Complex128], [], false)end, {prop: "SetFloat", name: "SetFloat", pkg: "", typ: __funcType([__Float64], [], false)end, {prop: "SetInt", name: "SetInt", pkg: "", typ: __funcType([__Int64], [], false)end, {prop: "SetMapIndex", name: "SetMapIndex", pkg: "", typ: __funcType([Value, Value], [], false)end, {prop: "SetUint", name: "SetUint", pkg: "", typ: __funcType([__Uint64], [], false)end, {prop: "SetPointer", name: "SetPointer", pkg: "", typ: __funcType([__UnsafePointer], [], false)end, {prop: "SetString", name: "SetString", pkg: "", typ: __funcType([__String], [], false)end, {prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "TryRecv", name: "TryRecv", pkg: "", typ: __funcType([], [Value, __Bool], false)end, {prop: "TrySend", name: "TrySend", pkg: "", typ: __funcType([Value], [__Bool], false)end, {prop: "Type", name: "Type", pkg: "", typ: __funcType([], [Type], false)end, {prop: "Uint", name: "Uint", pkg: "", typ: __funcType([], [__Uint64], false)end, {prop: "UnsafeAddr", name: "UnsafeAddr", pkg: "", typ: __funcType([], [__Uintptr], false)end, {prop: "assignTo", name: "assignTo", pkg: "reflect", typ: __funcType([__String, ptrType__1, __UnsafePointer], [Value], false)end, {prop: "Convert", name: "Convert", pkg: "", typ: __funcType([Type], [Value], false)end];
	flag.methods = [{prop: "kind", name: "kind", pkg: "reflect", typ: __funcType([], [Kind], false)end, {prop: "mustBe", name: "mustBe", pkg: "reflect", typ: __funcType([Kind], [], false)end, {prop: "mustBeExported", name: "mustBeExported", pkg: "reflect", typ: __funcType([], [], false)end, {prop: "mustBeAssignable", name: "mustBeAssignable", pkg: "reflect", typ: __funcType([], [], false)end];
	ptrType__18.methods = [{prop: "Error", name: "Error", pkg: "", typ: __funcType([], [__String], false)end];
	uncommonType.init("reflect", [{prop: "pkgPath", name: "pkgPath", anonymous: false, exported: false, typ: nameOff, tag: ""end, {prop: "mcount", name: "mcount", anonymous: false, exported: false, typ: __Uint16, tag: ""end, {prop: "___2", name: "_", anonymous: false, exported: false, typ: __Uint16, tag: ""end, {prop: "moff", name: "moff", anonymous: false, exported: false, typ: __Uint32, tag: ""end, {prop: "___4", name: "_", anonymous: false, exported: false, typ: __Uint32, tag: ""end, {prop: "_methods", name: "_methods", anonymous: false, exported: false, typ: sliceType__5, tag: ""end]);
	funcType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"func\""end, {prop: "inCount", name: "inCount", anonymous: false, exported: false, typ: __Uint16, tag: ""end, {prop: "outCount", name: "outCount", anonymous: false, exported: false, typ: __Uint16, tag: ""end, {prop: "_in", name: "_in", anonymous: false, exported: false, typ: sliceType__2, tag: ""end, {prop: "_out", name: "_out", anonymous: false, exported: false, typ: sliceType__2, tag: ""end]);
	name.init("reflect", [{prop: "bytes", name: "bytes", anonymous: false, exported: false, typ: ptrType__4, tag: ""end]);
	nameData.init("reflect", [{prop: "name", name: "name", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "tag", name: "tag", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "pkgPath", name: "pkgPath", anonymous: false, exported: false, typ: __String, tag: ""end, {prop: "exported", name: "exported", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	mapIter.init("reflect", [{prop: "t", name: "t", anonymous: false, exported: false, typ: Type, tag: ""end, {prop: "m", name: "m", anonymous: false, exported: false, typ: ptrType__2, tag: ""end, {prop: "keys", name: "keys", anonymous: false, exported: false, typ: ptrType__2, tag: ""end, {prop: "i", name: "i", anonymous: false, exported: false, typ: __Int, tag: ""end]);
	Type.init([{prop: "Align", name: "Align", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "AssignableTo", name: "AssignableTo", pkg: "", typ: __funcType([Type], [__Bool], false)end, {prop: "Bits", name: "Bits", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "ChanDir", name: "ChanDir", pkg: "", typ: __funcType([], [ChanDir], false)end, {prop: "Comparable", name: "Comparable", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "ConvertibleTo", name: "ConvertibleTo", pkg: "", typ: __funcType([Type], [__Bool], false)end, {prop: "Elem", name: "Elem", pkg: "", typ: __funcType([], [Type], false)end, {prop: "Field", name: "Field", pkg: "", typ: __funcType([__Int], [StructField], false)end, {prop: "FieldAlign", name: "FieldAlign", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "FieldByIndex", name: "FieldByIndex", pkg: "", typ: __funcType([sliceType__13], [StructField], false)end, {prop: "FieldByName", name: "FieldByName", pkg: "", typ: __funcType([__String], [StructField, __Bool], false)end, {prop: "FieldByNameFunc", name: "FieldByNameFunc", pkg: "", typ: __funcType([funcType__3], [StructField, __Bool], false)end, {prop: "Implements", name: "Implements", pkg: "", typ: __funcType([Type], [__Bool], false)end, {prop: "In", name: "In", pkg: "", typ: __funcType([__Int], [Type], false)end, {prop: "IsVariadic", name: "IsVariadic", pkg: "", typ: __funcType([], [__Bool], false)end, {prop: "Key", name: "Key", pkg: "", typ: __funcType([], [Type], false)end, {prop: "Kind", name: "Kind", pkg: "", typ: __funcType([], [Kind], false)end, {prop: "Len", name: "Len", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Method", name: "Method", pkg: "", typ: __funcType([__Int], [Method], false)end, {prop: "MethodByName", name: "MethodByName", pkg: "", typ: __funcType([__String], [Method, __Bool], false)end, {prop: "Name", name: "Name", pkg: "", typ: __funcType([], [__String], false)end, {prop: "NumField", name: "NumField", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "NumIn", name: "NumIn", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "NumMethod", name: "NumMethod", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "NumOut", name: "NumOut", pkg: "", typ: __funcType([], [__Int], false)end, {prop: "Out", name: "Out", pkg: "", typ: __funcType([__Int], [Type], false)end, {prop: "PkgPath", name: "PkgPath", pkg: "", typ: __funcType([], [__String], false)end, {prop: "Size", name: "Size", pkg: "", typ: __funcType([], [__Uintptr], false)end, {prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end, {prop: "common", name: "common", pkg: "reflect", typ: __funcType([], [ptrType__1], false)end, {prop: "uncommon", name: "uncommon", pkg: "reflect", typ: __funcType([], [ptrType__5], false)end]);
	rtype.init("reflect", [{prop: "size", name: "size", anonymous: false, exported: false, typ: __Uintptr, tag: ""end, {prop: "ptrdata", name: "ptrdata", anonymous: false, exported: false, typ: __Uintptr, tag: ""end, {prop: "hash", name: "hash", anonymous: false, exported: false, typ: __Uint32, tag: ""end, {prop: "tflag", name: "tflag", anonymous: false, exported: false, typ: tflag, tag: ""end, {prop: "align", name: "align", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "fieldAlign", name: "fieldAlign", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "kind", name: "kind", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "alg", name: "alg", anonymous: false, exported: false, typ: ptrType__3, tag: ""end, {prop: "gcdata", name: "gcdata", anonymous: false, exported: false, typ: ptrType__4, tag: ""end, {prop: "str", name: "str", anonymous: false, exported: false, typ: nameOff, tag: ""end, {prop: "ptrToThis", name: "ptrToThis", anonymous: false, exported: false, typ: typeOff, tag: ""end]);
	typeAlg.init("reflect", [{prop: "hash", name: "hash", anonymous: false, exported: false, typ: funcType__4, tag: ""end, {prop: "equal", name: "equal", anonymous: false, exported: false, typ: funcType__5, tag: ""end]);
	method.init("reflect", [{prop: "name", name: "name", anonymous: false, exported: false, typ: nameOff, tag: ""end, {prop: "mtyp", name: "mtyp", anonymous: false, exported: false, typ: typeOff, tag: ""end, {prop: "ifn", name: "ifn", anonymous: false, exported: false, typ: textOff, tag: ""end, {prop: "tfn", name: "tfn", anonymous: false, exported: false, typ: textOff, tag: ""end]);
	arrayType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"array\""end, {prop: "elem", name: "elem", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "slice", name: "slice", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "len", name: "len", anonymous: false, exported: false, typ: __Uintptr, tag: ""end]);
	chanType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"chan\""end, {prop: "elem", name: "elem", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "dir", name: "dir", anonymous: false, exported: false, typ: __Uintptr, tag: ""end]);
	imethod.init("reflect", [{prop: "name", name: "name", anonymous: false, exported: false, typ: nameOff, tag: ""end, {prop: "typ", name: "typ", anonymous: false, exported: false, typ: typeOff, tag: ""end]);
	interfaceType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"interface\""end, {prop: "pkgPath", name: "pkgPath", anonymous: false, exported: false, typ: name, tag: ""end, {prop: "methods", name: "methods", anonymous: false, exported: false, typ: sliceType__6, tag: ""end]);
	mapType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"map\""end, {prop: "key", name: "key", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "elem", name: "elem", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "bucket", name: "bucket", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "hmap", name: "hmap", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "keysize", name: "keysize", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "indirectkey", name: "indirectkey", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "valuesize", name: "valuesize", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "indirectvalue", name: "indirectvalue", anonymous: false, exported: false, typ: __Uint8, tag: ""end, {prop: "bucketsize", name: "bucketsize", anonymous: false, exported: false, typ: __Uint16, tag: ""end, {prop: "reflexivekey", name: "reflexivekey", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "needkeyupdate", name: "needkeyupdate", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	ptrType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"ptr\""end, {prop: "elem", name: "elem", anonymous: false, exported: false, typ: ptrType__1, tag: ""end]);
	sliceType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"slice\""end, {prop: "elem", name: "elem", anonymous: false, exported: false, typ: ptrType__1, tag: ""end]);
	structField.init("reflect", [{prop: "name", name: "name", anonymous: false, exported: false, typ: name, tag: ""end, {prop: "typ", name: "typ", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "offsetAnon", name: "offsetAnon", anonymous: false, exported: false, typ: __Uintptr, tag: ""end]);
	structType.init("reflect", [{prop: "rtype", name: "rtype", anonymous: true, exported: false, typ: rtype, tag: "reflect:\"struct\""end, {prop: "pkgPath", name: "pkgPath", anonymous: false, exported: false, typ: name, tag: ""end, {prop: "fields", name: "fields", anonymous: false, exported: false, typ: sliceType__7, tag: ""end]);
	Method.init("", [{prop: "Name", name: "Name", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "PkgPath", name: "PkgPath", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Type", name: "Type", anonymous: false, exported: true, typ: Type, tag: ""end, {prop: "Func", name: "Func", anonymous: false, exported: true, typ: Value, tag: ""end, {prop: "Index", name: "Index", anonymous: false, exported: true, typ: __Int, tag: ""end]);
	StructField.init("", [{prop: "Name", name: "Name", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "PkgPath", name: "PkgPath", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Type", name: "Type", anonymous: false, exported: true, typ: Type, tag: ""end, {prop: "Tag", name: "Tag", anonymous: false, exported: true, typ: StructTag, tag: ""end, {prop: "Offset", name: "Offset", anonymous: false, exported: true, typ: __Uintptr, tag: ""end, {prop: "Index", name: "Index", anonymous: false, exported: true, typ: sliceType__13, tag: ""end, {prop: "Anonymous", name: "Anonymous", anonymous: false, exported: true, typ: __Bool, tag: ""end]);
	fieldScan.init("reflect", [{prop: "typ", name: "typ", anonymous: false, exported: false, typ: ptrType__9, tag: ""end, {prop: "index", name: "index", anonymous: false, exported: false, typ: sliceType__13, tag: ""end]);
	Value.init("reflect", [{prop: "typ", name: "typ", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "ptr", name: "ptr", anonymous: false, exported: false, typ: __UnsafePointer, tag: ""end, {prop: "flag", name: "flag", anonymous: true, exported: false, typ: flag, tag: ""end]);
	ValueError.init("", [{prop: "Method", name: "Method", anonymous: false, exported: true, typ: __String, tag: ""end, {prop: "Kind", name: "Kind", anonymous: false, exported: true, typ: Kind, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = js.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = math.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = runtime.__init(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = strconv.__init(); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = sync.__init(); /* */ __s = 6; case 6: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = unicode.__init(); /* */ __s = 7; case 7: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = utf8.__init(); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		nameOffList = sliceType__1.nil;
		typeOffList = sliceType__2.nil;
		methodCache = new sync.Map.ptr(new sync.Mutex.ptr(0, 0), new __packages["sync/atomic"].Value.ptr(new __packages["sync/atomic"].noCopy.ptr(), __ifaceNil), false, 0);
		initialized = false;
		uncommonTypeMap = {};
		nameMap = {};
		callHelper = __assertType(__internalize(__call, __emptyInterface), funcType__1);
		selectHelper = __assertType(__internalize(__select, __emptyInterface), funcType__1);
		jsObjectPtr = reflectType(__jsObjectPtr);
		kindNames = new sliceType__4(["invalid", "bool", "int", "int8", "int16", "int32", "int64", "uint", "uint8", "uint16", "uint32", "uint64", "uintptr", "float32", "float64", "complex64", "complex128", "array", "chan", "func", "interface", "map", "ptr", "slice", "string", "struct", "unsafe.Pointer"]);
		uint8Type = __assertType(TypeOf(new __Uint8(0)), ptrType__1);
		__r = init(); /* */ __s = 9; case 9: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["fmt"] = (function()
	var __pkg = {}, __init, errors, io, math, os, reflect, strconv, sync, utf8, fmtFlags, fmt, State, Formatter, Stringer, GoStringer, buffer, pp, scanError, ss, ssave, sliceType, ptrType, ptrType__1, arrayType, arrayType__1, sliceType__1, sliceType__2, arrayType__2, ptrType__2, ptrType__5, ptrType__25, funcType, ppFree, space, ssFree, complexError, boolError, newPrinter, Fprintf, Printf, getField, tooLarge, parsenum, intFromArg, parseArgNumber, isSpace, notSpace, indexRune;
	errors = __packages["errors"];
	io = __packages["io"];
	math = __packages["math"];
	os = __packages["os"];
	reflect = __packages["reflect"];
	strconv = __packages["strconv"];
	sync = __packages["sync"];
	utf8 = __packages["unicode/utf8"];
	fmtFlags = __pkg.fmtFlags = __newType(0, __kindStruct, "fmt.fmtFlags", true, "fmt", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.widPresent = false;
			this.precPresent = false;
			this.minus = false;
			this.plus = false;
			this.sharp = false;
			this.space = false;
			this.zero = false;
			this.plusV = false;
			this.sharpV = false;
			return;
		end
		this.widPresent = widPresent_;
		this.precPresent = precPresent_;
		this.minus = minus_;
		this.plus = plus_;
		this.sharp = sharp_;
		this.space = space_;
		this.zero = zero_;
		this.plusV = plusV_;
		this.sharpV = sharpV_;
	end);
	fmt = __pkg.fmt = __newType(0, __kindStruct, "fmt.fmt", true, "fmt", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.buf = ptrType__1.nil;
			this.fmtFlags = new fmtFlags.ptr(false, false, false, false, false, false, false, false, false);
			this.wid = 0;
			this.prec = 0;
			this.intbuf = arrayType.zero();
			return;
		end
		this.buf = buf_;
		this.fmtFlags = fmtFlags_;
		this.wid = wid_;
		this.prec = prec_;
		this.intbuf = intbuf_;
	end);
	State = __pkg.State = __newType(8, __kindInterface, "fmt.State", true, "fmt", true, null);
	Formatter = __pkg.Formatter = __newType(8, __kindInterface, "fmt.Formatter", true, "fmt", true, null);
	Stringer = __pkg.Stringer = __newType(8, __kindInterface, "fmt.Stringer", true, "fmt", true, null);
	GoStringer = __pkg.GoStringer = __newType(8, __kindInterface, "fmt.GoStringer", true, "fmt", true, null);
	buffer = __pkg.buffer = __newType(12, __kindSlice, "fmt.buffer", true, "fmt", false, null);
	pp = __pkg.pp = __newType(0, __kindStruct, "fmt.pp", true, "fmt", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.buf = buffer.nil;
			this.arg = __ifaceNil;
			this.value = new reflect.Value.ptr(ptrType.nil, 0, 0);
			this.fmt = new fmt.ptr(ptrType__1.nil, new fmtFlags.ptr(false, false, false, false, false, false, false, false, false), 0, 0, arrayType.zero());
			this.reordered = false;
			this.goodArgNum = false;
			this.panicking = false;
			this.erroring = false;
			return;
		end
		this.buf = buf_;
		this.arg = arg_;
		this.value = value_;
		this.fmt = fmt_;
		this.reordered = reordered_;
		this.goodArgNum = goodArgNum_;
		this.panicking = panicking_;
		this.erroring = erroring_;
	end);
	scanError = __pkg.scanError = __newType(0, __kindStruct, "fmt.scanError", true, "fmt", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.err = __ifaceNil;
			return;
		end
		this.err = err_;
	end);
	ss = __pkg.ss = __newType(0, __kindStruct, "fmt.ss", true, "fmt", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.rs = __ifaceNil;
			this.buf = buffer.nil;
			this.count = 0;
			this.atEOF = false;
			this.ssave = new ssave.ptr(false, false, false, 0, 0, 0);
			return;
		end
		this.rs = rs_;
		this.buf = buf_;
		this.count = count_;
		this.atEOF = atEOF_;
		this.ssave = ssave_;
	end);
	ssave = __pkg.ssave = __newType(0, __kindStruct, "fmt.ssave", true, "fmt", false, function(_)
		this.__val = this;
		if (arguments.length == 0) {
			this.validSave = false;
			this.nlIsEnd = false;
			this.nlIsSpace = false;
			this.argLimit = 0;
			this.limit = 0;
			this.maxWid = 0;
			return;
		end
		this.validSave = validSave_;
		this.nlIsEnd = nlIsEnd_;
		this.nlIsSpace = nlIsSpace_;
		this.argLimit = argLimit_;
		this.limit = limit_;
		this.maxWid = maxWid_;
	end);
	sliceType = __sliceType(__emptyInterface);
	ptrType = __ptrType(reflect.rtype);
	ptrType__1 = __ptrType(buffer);
	arrayType = __arrayType(__Uint8, 68);
	arrayType__1 = __arrayType(__Uint16, 2);
	sliceType__1 = __sliceType(arrayType__1);
	sliceType__2 = __sliceType(__Uint8);
	arrayType__2 = __arrayType(__Uint8, 5);
	ptrType__2 = __ptrType(pp);
	ptrType__5 = __ptrType(ss);
	ptrType__25 = __ptrType(fmt);
	funcType = __funcType([__Int32], [__Bool], false);
	fmt.ptr.prototype.clearflags = function()
		var f;
		f = this;
		fmtFlags.copy(f.fmtFlags, new fmtFlags.ptr(false, false, false, false, false, false, false, false, false));
	end;
	fmt.prototype.clearflags = function() return this.__val.clearflags(); end;
	fmt.ptr.prototype.init = function(f)
		var buf, f;
		f = this;
		f.buf = buf;
		f.clearflags();
	end;
	fmt.prototype.init = function(f) return this.__val.init(buf); end;
	fmt.ptr.prototype.writePadding = function(n)
		var _i, _ref, buf, f, i, n, newLen, oldLen, padByte, padding;
		f = this;
		if (n <= 0) {
			return;
		end
		buf = f.buf.__get();
		oldLen = buf.__length;
		newLen = oldLen + n >> 0;
		if (newLen > buf.__capacity) {
			buf = __makeSlice(buffer, ((__imul(buf.__capacity, 2)) + n >> 0));
			__copySlice(buf, f.buf.__get());
		end
		padByte = 32;
		if (f.fmtFlags.zero) {
			padByte = 48;
		end
		padding = __subslice(buf, oldLen, newLen);
		_ref = padding;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			i = _i;
			((i < 0  or  i >= padding.__length) ? (__throwRuntimeError("index out of range"), nil) : padding.__array[padding.__offset + i] = padByte);
			_i++;
		end
		f.buf.__set(__subslice(buf, 0, newLen));
	end;
	fmt.prototype.writePadding = function(n) return this.__val.writePadding(n); end;
	fmt.ptr.prototype.pad = function(b)
		var b, f, width;
		f = this;
		if ( not f.fmtFlags.widPresent  or  (f.wid == 0)) {
			f.buf.Write(b);
			return;
		end
		width = f.wid - utf8.RuneCount(b) >> 0;
		if ( not f.fmtFlags.minus) {
			f.writePadding(width);
			f.buf.Write(b);
		end else {
			f.buf.Write(b);
			f.writePadding(width);
		end
	end;
	fmt.prototype.pad = function(b) return this.__val.pad(b); end;
	fmt.ptr.prototype.padString = function(s)
		var f, s, width;
		f = this;
		if ( not f.fmtFlags.widPresent  or  (f.wid == 0)) {
			f.buf.WriteString(s);
			return;
		end
		width = f.wid - utf8.RuneCountInString(s) >> 0;
		if ( not f.fmtFlags.minus) {
			f.writePadding(width);
			f.buf.WriteString(s);
		end else {
			f.buf.WriteString(s);
			f.writePadding(width);
		end
	end;
	fmt.prototype.padString = function(s) return this.__val.padString(s); end;
	fmt.ptr.prototype.fmt_boolean = function(v)
		var f, v;
		f = this;
		if (v) {
			f.padString("true");
		end else {
			f.padString("false");
		end
	end;
	fmt.prototype.fmt_boolean = function(v) return this.__val.fmt_boolean(v); end;
	fmt.ptr.prototype.fmt_unicode = function(u)
		var buf, f, i, oldZero, prec, u, width;
		f = this;
		buf = __subslice(new sliceType__2(f.intbuf), 0);
		prec = 4;
		if (f.fmtFlags.precPresent  and  f.prec > 4) {
			prec = f.prec;
			width = (((2 + prec >> 0) + 2 >> 0) + 4 >> 0) + 1 >> 0;
			if (width > buf.__length) {
				buf = __makeSlice(sliceType__2, width);
			end
		end
		i = buf.__length;
		if (f.fmtFlags.sharp  and  (u.__high < 0  or  (u.__high == 0  and  u.__low <= 1114111))  and  strconv.IsPrint(((u.__low >> 0)))) {
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 39);
			i = i - (utf8.RuneLen(((u.__low >> 0)))) >> 0;
			utf8.EncodeRune(__subslice(buf, i), ((u.__low >> 0)));
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 39);
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 32);
		end
		while (true) {
			if ( not ((u.__high > 0  or  (u.__high == 0  and  u.__low >= 16)))) { break; end
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = "0123456789ABCDEFX".charCodeAt(__flatten64(new __Uint64(u.__high & 0, (u.__low & 15) >>> 0))));
			prec = prec - (1) >> 0;
			u = __shiftRightUint64(u, (4));
		end
		i = i - (1) >> 0;
		((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = "0123456789ABCDEFX".charCodeAt(__flatten64(u)));
		prec = prec - (1) >> 0;
		while (true) {
			if ( not (prec > 0)) { break; end
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 48);
			prec = prec - (1) >> 0;
		end
		i = i - (1) >> 0;
		((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 43);
		i = i - (1) >> 0;
		((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 85);
		oldZero = f.fmtFlags.zero;
		f.fmtFlags.zero = false;
		f.pad(__subslice(buf, i));
		f.fmtFlags.zero = oldZero;
	end;
	fmt.prototype.fmt_unicode = function(u) return this.__val.fmt_unicode(u); end;
	fmt.ptr.prototype.fmt_integer = function(s)
		var _1, _2, base, buf, digits, f, i, isSigned, negative, next, oldZero, oldZero__1, prec, u, width, x, x__1, x__2, x__3, x__4;
		f = this;
		negative = isSigned  and  (x = (new __Int64(u.__high, u.__low)), (x.__high < 0  or  (x.__high == 0  and  x.__low < 0)));
		if (negative) {
			u = new __Uint64(-u.__high, -u.__low);
		end
		buf = __subslice(new sliceType__2(f.intbuf), 0);
		if (f.fmtFlags.widPresent  or  f.fmtFlags.precPresent) {
			width = (3 + f.wid >> 0) + f.prec >> 0;
			if (width > buf.__length) {
				buf = __makeSlice(sliceType__2, width);
			end
		end
		prec = 0;
		if (f.fmtFlags.precPresent) {
			prec = f.prec;
			if ((prec == 0)  and  (u.__high == 0  and  u.__low == 0)) {
				oldZero = f.fmtFlags.zero;
				f.fmtFlags.zero = false;
				f.writePadding(f.wid);
				f.fmtFlags.zero = oldZero;
				return;
			end
		end else if (f.fmtFlags.zero  and  f.fmtFlags.widPresent) {
			prec = f.wid;
			if (negative  or  f.fmtFlags.plus  or  f.fmtFlags.space) {
				prec = prec - (1) >> 0;
			end
		end
		i = buf.__length;
		_1 = base;
		if (_1 == (10)) {
			while (true) {
				if ( not ((u.__high > 0  or  (u.__high == 0  and  u.__low >= 10)))) { break; end
				i = i - (1) >> 0;
				next = __div64(u, new __Uint64(0, 10), false);
				((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = (((x__1 = new __Uint64(0 + u.__high, 48 + u.__low), x__2 = __mul64(next, new __Uint64(0, 10)), new __Uint64(x__1.__high - x__2.__high, x__1.__low - x__2.__low)).__low << 24 >>> 24)));
				u = next;
			end
		end else if (_1 == (16)) {
			while (true) {
				if ( not ((u.__high > 0  or  (u.__high == 0  and  u.__low >= 16)))) { break; end
				i = i - (1) >> 0;
				((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = digits.charCodeAt(__flatten64(new __Uint64(u.__high & 0, (u.__low & 15) >>> 0))));
				u = __shiftRightUint64(u, (4));
			end
		end else if (_1 == (8)) {
			while (true) {
				if ( not ((u.__high > 0  or  (u.__high == 0  and  u.__low >= 8)))) { break; end
				i = i - (1) >> 0;
				((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = (((x__3 = new __Uint64(u.__high & 0, (u.__low & 7) >>> 0), new __Uint64(0 + x__3.__high, 48 + x__3.__low)).__low << 24 >>> 24)));
				u = __shiftRightUint64(u, (3));
			end
		end else if (_1 == (2)) {
			while (true) {
				if ( not ((u.__high > 0  or  (u.__high == 0  and  u.__low >= 2)))) { break; end
				i = i - (1) >> 0;
				((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = (((x__4 = new __Uint64(u.__high & 0, (u.__low & 1) >>> 0), new __Uint64(0 + x__4.__high, 48 + x__4.__low)).__low << 24 >>> 24)));
				u = __shiftRightUint64(u, (1));
			end
		end else {
			__panic(new __String("fmt: unknown base; can't happen"));
		end
		i = i - (1) >> 0;
		((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = digits.charCodeAt(__flatten64(u)));
		while (true) {
			if ( not (i > 0  and  prec > (buf.__length - i >> 0))) { break; end
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 48);
		end
		if (f.fmtFlags.sharp) {
			_2 = base;
			if (_2 == (8)) {
				if ( not ((((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i]) == 48))) {
					i = i - (1) >> 0;
					((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 48);
				end
			end else if (_2 == (16)) {
				i = i - (1) >> 0;
				((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = digits.charCodeAt(16));
				i = i - (1) >> 0;
				((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 48);
			end
		end
		if (negative) {
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 45);
		end else if (f.fmtFlags.plus) {
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 43);
		end else if (f.fmtFlags.space) {
			i = i - (1) >> 0;
			((i < 0  or  i >= buf.__length) ? (__throwRuntimeError("index out of range"), nil) : buf.__array[buf.__offset + i] = 32);
		end
		oldZero__1 = f.fmtFlags.zero;
		f.fmtFlags.zero = false;
		f.pad(__subslice(buf, i));
		f.fmtFlags.zero = oldZero__1;
	end;
	fmt.prototype.fmt_integer = function(s) return this.__val.fmt_integer(u, base, isSigned, digits); end;
	fmt.ptr.prototype.truncate = function(s)
		var _i, _ref, _rune, f, i, n, s;
		f = this;
		if (f.fmtFlags.precPresent) {
			n = f.prec;
			_ref = s;
			_i = 0;
			while (true) {
				if not (_i < #_ref) then break; end
				_rune = __decodeRune(_ref, _i);
				i = _i;
				n = n - (1) >> 0;
				if (n < 0) {
					return __substring(s, 0, i);
				end
				_i += _rune[1];
			end
		end
		return s;
	end;
	fmt.prototype.truncate = function(s) return this.__val.truncate(s); end;
	fmt.ptr.prototype.fmt_s = function(s)
		var f, s;
		f = this;
		s = f.truncate(s);
		f.padString(s);
	end;
	fmt.prototype.fmt_s = function(s) return this.__val.fmt_s(s); end;
	fmt.ptr.prototype.fmt_sbx = function(s)
		var b, buf, c, digits, f, i, length, s, width;
		f = this;
		length = b.__length;
		if (b == sliceType__2.nil) {
			length = s.length;
		end
		if (f.fmtFlags.precPresent  and  f.prec < length) {
			length = f.prec;
		end
		width = __imul(2, length);
		if (width > 0) {
			if (f.fmtFlags.space) {
				if (f.fmtFlags.sharp) {
					width = __imul(width, (2));
				end
				width = width + ((length - 1 >> 0)) >> 0;
			end else if (f.fmtFlags.sharp) {
				width = width + (2) >> 0;
			end
		end else {
			if (f.fmtFlags.widPresent) {
				f.writePadding(f.wid);
			end
			return;
		end
		if (f.fmtFlags.widPresent  and  f.wid > width  and   not f.fmtFlags.minus) {
			f.writePadding(f.wid - width >> 0);
		end
		buf = f.buf.__get();
		if (f.fmtFlags.sharp) {
			buf = __append(buf, 48, digits.charCodeAt(16));
		end
		c = 0;
		i = 0;
		while (true) {
			if ( not (i < length)) { break; end
			if (f.fmtFlags.space  and  i > 0) {
				buf = __append(buf, 32);
				if (f.fmtFlags.sharp) {
					buf = __append(buf, 48, digits.charCodeAt(16));
				end
			end
			if ( not (b == sliceType__2.nil)) {
				c = ((i < 0  or  i >= b.__length) ? (__throwRuntimeError("index out of range"), nil) : b.__array[b.__offset + i]);
			end else {
				c = s.charCodeAt(i);
			end
			buf = __append(buf, digits.charCodeAt((c >>> 4 << 24 >>> 24)), digits.charCodeAt(((c & 15) >>> 0)));
			i = i + (1) >> 0;
		end
		f.buf.__set(buf);
		if (f.fmtFlags.widPresent  and  f.wid > width  and  f.fmtFlags.minus) {
			f.writePadding(f.wid - width >> 0);
		end
	end;
	fmt.prototype.fmt_sbx = function(s) return this.__val.fmt_sbx(s, b, digits); end;
	fmt.ptr.prototype.fmt_sx = function(s)
		var digits, f, s;
		f = this;
		f.fmt_sbx(s, sliceType__2.nil, digits);
	end;
	fmt.prototype.fmt_sx = function(s) return this.__val.fmt_sx(s, digits); end;
	fmt.ptr.prototype.fmt_bx = function(s)
		var b, digits, f;
		f = this;
		f.fmt_sbx("", b, digits);
	end;
	fmt.prototype.fmt_bx = function(s) return this.__val.fmt_bx(b, digits); end;
	fmt.ptr.prototype.fmt_q = function(s)
		var buf, f, s;
		f = this;
		s = f.truncate(s);
		if (f.fmtFlags.sharp  and  strconv.CanBackquote(s)) {
			f.padString("`" + s + "`");
			return;
		end
		buf = __subslice(new sliceType__2(f.intbuf), 0, 0);
		if (f.fmtFlags.plus) {
			f.pad(strconv.AppendQuoteToASCII(buf, s));
		end else {
			f.pad(strconv.AppendQuote(buf, s));
		end
	end;
	fmt.prototype.fmt_q = function(s) return this.__val.fmt_q(s); end;
	fmt.ptr.prototype.fmt_c = function(c)
		var buf, c, f, r, w;
		f = this;
		r = ((c.__low >> 0));
		if ((c.__high > 0  or  (c.__high == 0  and  c.__low > 1114111))) {
			r = 65533;
		end
		buf = __subslice(new sliceType__2(f.intbuf), 0, 0);
		w = utf8.EncodeRune(__subslice(buf, 0, 4), r);
		f.pad(__subslice(buf, 0, w));
	end;
	fmt.prototype.fmt_c = function(c) return this.__val.fmt_c(c); end;
	fmt.ptr.prototype.fmt_qc = function(c)
		var buf, c, f, r;
		f = this;
		r = ((c.__low >> 0));
		if ((c.__high > 0  or  (c.__high == 0  and  c.__low > 1114111))) {
			r = 65533;
		end
		buf = __subslice(new sliceType__2(f.intbuf), 0, 0);
		if (f.fmtFlags.plus) {
			f.pad(strconv.AppendQuoteRuneToASCII(buf, r));
		end else {
			f.pad(strconv.AppendQuoteRune(buf, r));
		end
	end;
	fmt.prototype.fmt_qc = function(c) return this.__val.fmt_qc(c); end;
	fmt.ptr.prototype.fmt_float = function(c)
		var _1, _2, digits, f, hasDecimalPoint, i, num, oldZero, prec, size, tail, tailBuf, v, verb;
		f = this;
		if (f.fmtFlags.precPresent) {
			prec = f.prec;
		end
		num = strconv.AppendFloat(__subslice(new sliceType__2(f.intbuf), 0, 1), v, ((verb << 24 >>> 24)), prec, size);
		if (((1 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 1]) == 45)  or  ((1 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 1]) == 43)) {
			num = __subslice(num, 1);
		end else {
			(0 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 0] = 43);
		end
		if (f.fmtFlags.space  and  ((0 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 0]) == 43)  and   not f.fmtFlags.plus) {
			(0 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 0] = 32);
		end
		if (((1 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 1]) == 73)  or  ((1 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 1]) == 78)) {
			oldZero = f.fmtFlags.zero;
			f.fmtFlags.zero = false;
			if (((1 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 1]) == 78)  and   not f.fmtFlags.space  and   not f.fmtFlags.plus) {
				num = __subslice(num, 1);
			end
			f.pad(num);
			f.fmtFlags.zero = oldZero;
			return;
		end
		if (f.fmtFlags.sharp  and   not ((verb == 98))) {
			digits = 0;
			_1 = verb;
			if ((_1 == (118))  or  (_1 == (103))  or  (_1 == (71))) {
				digits = prec;
				if (digits == -1) {
					digits = 6;
				end
			end
			tailBuf = arrayType__2.zero();
			tail = __subslice(new sliceType__2(tailBuf), 0, 0);
			hasDecimalPoint = false;
			i = 1;
			while (true) {
				if ( not (i < num.__length)) { break; end
				_2 = ((i < 0  or  i >= num.__length) ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + i]);
				if (_2 == (46)) {
					hasDecimalPoint = true;
				end else if ((_2 == (101))  or  (_2 == (69))) {
					tail = __appendSlice(tail, __subslice(num, i));
					num = __subslice(num, 0, i);
				end else {
					digits = digits - (1) >> 0;
				end
				i = i + (1) >> 0;
			end
			if ( not hasDecimalPoint) {
				num = __append(num, 46);
			end
			while (true) {
				if ( not (digits > 0)) { break; end
				num = __append(num, 48);
				digits = digits - (1) >> 0;
			end
			num = __appendSlice(num, tail);
		end
		if (f.fmtFlags.plus  or   not (((0 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 0]) == 43))) {
			if (f.fmtFlags.zero  and  f.fmtFlags.widPresent  and  f.wid > num.__length) {
				f.buf.WriteByte((0 >= num.__length ? (__throwRuntimeError("index out of range"), nil) : num.__array[num.__offset + 0]));
				f.writePadding(f.wid - num.__length >> 0);
				f.buf.Write(__subslice(num, 1));
				return;
			end
			f.pad(num);
			return;
		end
		f.pad(__subslice(num, 1));
	end;
	fmt.prototype.fmt_float = function(c) return this.__val.fmt_float(v, size, verb, prec); end;
	__ptrType(buffer).prototype.Write = function(p)
		var b, p;
		b = this;
		b.__set(__appendSlice(b.__get(), p));
	end;
	__ptrType(buffer).prototype.WriteString = function(s)
		var b, s;
		b = this;
		b.__set(__appendSlice(b.__get(), s));
	end;
	__ptrType(buffer).prototype.WriteByte = function(c)
		var b, c;
		b = this;
		b.__set(__append(b.__get(), c));
	end;
	__ptrType(buffer).prototype.WriteRune = function(r)
		var b, bp, n, r, w, x;
		bp = this;
		if (r < 128) {
			bp.__set(__append(bp.__get(), ((r << 24 >>> 24))));
			return;
		end
		b = bp.__get();
		n = b.__length;
		while (true) {
			if ( not ((n + 4 >> 0) > b.__capacity)) { break; end
			b = __append(b, 0);
		end
		w = utf8.EncodeRune((x = __subslice(b, n, (n + 4 >> 0)), __subslice(new sliceType__2(x.__array), x.__offset, x.__offset + x.__length)), r);
		bp.__set(__subslice(b, 0, (n + w >> 0)));
	end;
	newPrinter = function()
		var _r, p, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; p = __f.p; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = ppFree.Get(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		p = __assertType(_r, ptrType__2);
		p.panicking = false;
		p.erroring = false;
		p.fmt.init((p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))));
		__s = -1; return p;
		/* */ end return; end if __f == nil then  __f = { __blk: newPrinter end; end __f._r = _r; __f.p = p; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.ptr.prototype.free = function()
		var p;
		p = this;
		p.buf = __subslice(p.buf, 0, 0);
		p.arg = __ifaceNil;
		p.value = new reflect.Value.ptr(ptrType.nil, 0, 0);
		ppFree.Put(p);
	end;
	pp.prototype.free = function() return this.__val.free(); end;
	pp.ptr.prototype.Width = function()
		var _tmp, _tmp__1, ok, p, wid;
		wid = 0;
		ok = false;
		p = this;
		_tmp = p.fmt.wid;
		_tmp__1 = p.fmt.fmtFlags.widPresent;
		wid = _tmp;
		ok = _tmp__1;
		return [wid, ok];
	end;
	pp.prototype.Width = function() return this.__val.Width(); end;
	pp.ptr.prototype.Precision = function()
		var _tmp, _tmp__1, ok, p, prec;
		prec = 0;
		ok = false;
		p = this;
		_tmp = p.fmt.prec;
		_tmp__1 = p.fmt.fmtFlags.precPresent;
		prec = _tmp;
		ok = _tmp__1;
		return [prec, ok];
	end;
	pp.prototype.Precision = function() return this.__val.Precision(); end;
	pp.ptr.prototype.Flag = function(b)
		var _1, b, p;
		p = this;
		_1 = b;
		if (_1 == (45)) {
			return p.fmt.fmtFlags.minus;
		end else if (_1 == (43)) {
			return p.fmt.fmtFlags.plus  or  p.fmt.fmtFlags.plusV;
		end else if (_1 == (35)) {
			return p.fmt.fmtFlags.sharp  or  p.fmt.fmtFlags.sharpV;
		end else if (_1 == (32)) {
			return p.fmt.fmtFlags.space;
		end else if (_1 == (48)) {
			return p.fmt.fmtFlags.zero;
		end
		return false;
	end;
	pp.prototype.Flag = function(b) return this.__val.Flag(b); end;
	pp.ptr.prototype.Write = function(b)
		var _tmp, _tmp__1, b, err, p, ret;
		ret = 0;
		err = __ifaceNil;
		p = this;
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).Write(b);
		_tmp = b.__length;
		_tmp__1 = __ifaceNil;
		ret = _tmp;
		err = _tmp__1;
		return [ret, err];
	end;
	pp.prototype.Write = function(b) return this.__val.Write(b); end;
	Fprintf = function(a)
		var _r, _r__1, _tuple, a, err, format, n, p, w, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _tuple = __f._tuple; a = __f.a; err = __f.err; format = __f.format; n = __f.n; p = __f.p; w = __f.w; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		_r = newPrinter(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		p = _r;
		__r = p.doPrintf(format, a); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		_r__1 = w.Write((x = p.buf, __subslice(new sliceType__2(x.__array), x.__offset, x.__offset + x.__length))); /* */ __s = 3; case 3: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
		_tuple = _r__1;
		n = _tuple[0];
		err = _tuple[1];
		p.free();
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: Fprintf end; end __f._r = _r; __f._r__1 = _r__1; __f._tuple = _tuple; __f.a = a; __f.err = err; __f.format = format; __f.n = n; __f.p = p; __f.w = w; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.Fprintf = Fprintf;
	Printf = function(a)
		var _r, _tuple, a, err, format, n, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; a = __f.a; err = __f.err; format = __f.format; n = __f.n; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		n = 0;
		err = __ifaceNil;
		_r = Fprintf(os.Stdout, format, a); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		n = _tuple[0];
		err = _tuple[1];
		__s = -1; return [n, err];
		/* */ end return; end if __f == nil then  __f = { __blk: Printf end; end __f._r = _r; __f._tuple = _tuple; __f.a = a; __f.err = err; __f.format = format; __f.n = n; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.Printf = Printf;
	getField = function(i)
		var _r, _r__1, i, v, val, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; i = __f.i; v = __f.v; val = __f.val; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		_r = __clone(v, reflect.Value).Field(i); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		val = _r;
		/* */ if ((__clone(val, reflect.Value).Kind() == 20)  and   not __clone(val, reflect.Value).IsNil()) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if ((__clone(val, reflect.Value).Kind() == 20)  and   not __clone(val, reflect.Value).IsNil()) { */ case 2:
			_r__1 = __clone(val, reflect.Value).Elem(); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			val = _r__1;
		/* end */ case 3:
		__s = -1; return val;
		/* */ end return; end if __f == nil then  __f = { __blk: getField end; end __f._r = _r; __f._r__1 = _r__1; __f.i = i; __f.v = v; __f.val = val; __f.__s = __s; __f.__r = __r; return __f;
	end;
	tooLarge = function(x)
		var x;
		return x > 1000000  or  x < -1000000;
	end;
	parsenum = function(d)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, end, isnum, newi, num, s, start;
		num = 0;
		isnum = false;
		newi = 0;
		if (start >= end) {
			_tmp = 0;
			_tmp__1 = false;
			_tmp__2 = end;
			num = _tmp;
			isnum = _tmp__1;
			newi = _tmp__2;
			return [num, isnum, newi];
		end
		newi = start;
		while (true) {
			if ( not (newi < end  and  48 <= s.charCodeAt(newi)  and  s.charCodeAt(newi) <= 57)) { break; end
			if (tooLarge(num)) {
				_tmp__3 = 0;
				_tmp__4 = false;
				_tmp__5 = end;
				num = _tmp__3;
				isnum = _tmp__4;
				newi = _tmp__5;
				return [num, isnum, newi];
			end
			num = (__imul(num, 10)) + (((s.charCodeAt(newi) - 48 << 24 >>> 24) >> 0)) >> 0;
			isnum = true;
			newi = newi + (1) >> 0;
		end
		return [num, isnum, newi];
	end;
	pp.ptr.prototype.unknownType = function(v)
		var _r, p, v, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; p = __f.p; v = __f.v; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		if ( not __clone(v, reflect.Value).IsValid()) {
			(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("<nil>");
			__s = -1; return;
		end
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(63);
		_r = __clone(v, reflect.Value).Type().String(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(63);
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.unknownType end; end __f._r = _r; __f.p = p; __f.v = v; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.unknownType = function(v) return this.__val.unknownType(v); end;
	pp.ptr.prototype.badVerb = function(b)
		var _r, _r__1, p, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; p = __f.p; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		p.erroring = true;
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not ");
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteRune(verb);
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(40);
			/* */ if ( not (__interfaceIsEqual(p.arg, __ifaceNil))) { __s = 2; continue; end
			/* */ if (__clone(p.value, reflect.Value).IsValid()) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if ( not (__interfaceIsEqual(p.arg, __ifaceNil))) { */ case 2:
				_r = reflect.TypeOf(p.arg).String(); /* */ __s = 6; case 6: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r); /* */ __s = 7; case 7: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(61);
				__r = p.printArg(p.arg, 118); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 5; continue;
			/* end else if (__clone(p.value, reflect.Value).IsValid()) { */ case 3:
				_r__1 = __clone(p.value, reflect.Value).Type().String(); /* */ __s = 9; case 9: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r__1); /* */ __s = 10; case 10: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(61);
				__r = p.printValue(__clone(p.value, reflect.Value), 118, 0); /* */ __s = 11; case 11: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 5; continue;
			/* end else { */ case 4:
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("<nil>");
			/* end */ case 5:
		case 1:
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(41);
		p.erroring = false;
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.badVerb end; end __f._r = _r; __f._r__1 = _r__1; __f.p = p; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.badVerb = function(b) return this.__val.badVerb(verb); end;
	pp.ptr.prototype.fmtBool = function(b)
		var _1, p, v, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; p = __f.p; v = __f.v; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
			_1 = verb;
			/* */ if ((_1 == (116))  or  (_1 == (118))) { __s = 2; continue; end
			/* */ __s = 3; continue;
			/* if ((_1 == (116))  or  (_1 == (118))) { */ case 2:
				p.fmt.fmt_boolean(v);
				__s = 4; continue;
			/* end else { */ case 3:
				__r = p.badVerb(verb); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 4:
		case 1:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.fmtBool end; end __f._1 = _1; __f.p = p; __f.v = v; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.fmtBool = function(b) return this.__val.fmtBool(v, verb); end;
	pp.ptr.prototype.fmt0x64 = function(x)
		var leading0x, p, sharp, v;
		p = this;
		sharp = p.fmt.fmtFlags.sharp;
		p.fmt.fmtFlags.sharp = leading0x;
		p.fmt.fmt_integer(v, 16, false, "0123456789abcdefx");
		p.fmt.fmtFlags.sharp = sharp;
	end;
	pp.prototype.fmt0x64 = function(x) return this.__val.fmt0x64(v, leading0x); end;
	pp.ptr.prototype.fmtInteger = function(b)
		var _1, isSigned, p, v, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; isSigned = __f.isSigned; p = __f.p; v = __f.v; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
			_1 = verb;
			/* */ if (_1 == (118)) { __s = 2; continue; end
			/* */ if (_1 == (100)) { __s = 3; continue; end
			/* */ if (_1 == (98)) { __s = 4; continue; end
			/* */ if (_1 == (111)) { __s = 5; continue; end
			/* */ if (_1 == (120)) { __s = 6; continue; end
			/* */ if (_1 == (88)) { __s = 7; continue; end
			/* */ if (_1 == (99)) { __s = 8; continue; end
			/* */ if (_1 == (113)) { __s = 9; continue; end
			/* */ if (_1 == (85)) { __s = 10; continue; end
			/* */ __s = 11; continue;
			/* if (_1 == (118)) { */ case 2:
				if (p.fmt.fmtFlags.sharpV  and   not isSigned) {
					p.fmt0x64(v, true);
				end else {
					p.fmt.fmt_integer(v, 10, isSigned, "0123456789abcdefx");
				end
				__s = 12; continue;
			/* end else if (_1 == (100)) { */ case 3:
				p.fmt.fmt_integer(v, 10, isSigned, "0123456789abcdefx");
				__s = 12; continue;
			/* end else if (_1 == (98)) { */ case 4:
				p.fmt.fmt_integer(v, 2, isSigned, "0123456789abcdefx");
				__s = 12; continue;
			/* end else if (_1 == (111)) { */ case 5:
				p.fmt.fmt_integer(v, 8, isSigned, "0123456789abcdefx");
				__s = 12; continue;
			/* end else if (_1 == (120)) { */ case 6:
				p.fmt.fmt_integer(v, 16, isSigned, "0123456789abcdefx");
				__s = 12; continue;
			/* end else if (_1 == (88)) { */ case 7:
				p.fmt.fmt_integer(v, 16, isSigned, "0123456789ABCDEFX");
				__s = 12; continue;
			/* end else if (_1 == (99)) { */ case 8:
				p.fmt.fmt_c(v);
				__s = 12; continue;
			/* end else if (_1 == (113)) { */ case 9:
				/* */ if ((v.__high < 0  or  (v.__high == 0  and  v.__low <= 1114111))) { __s = 13; continue; end
				/* */ __s = 14; continue;
				/* if ((v.__high < 0  or  (v.__high == 0  and  v.__low <= 1114111))) { */ case 13:
					p.fmt.fmt_qc(v);
					__s = 15; continue;
				/* end else { */ case 14:
					__r = p.badVerb(verb); /* */ __s = 16; case 16: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				/* end */ case 15:
				__s = 12; continue;
			/* end else if (_1 == (85)) { */ case 10:
				p.fmt.fmt_unicode(v);
				__s = 12; continue;
			/* end else { */ case 11:
				__r = p.badVerb(verb); /* */ __s = 17; case 17: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 12:
		case 1:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.fmtInteger end; end __f._1 = _1; __f.isSigned = isSigned; __f.p = p; __f.v = v; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.fmtInteger = function(b) return this.__val.fmtInteger(v, isSigned, verb); end;
	pp.ptr.prototype.fmtFloat = function(b)
		var _1, p, size, v, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; p = __f.p; size = __f.size; v = __f.v; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
			_1 = verb;
			/* */ if (_1 == (118)) { __s = 2; continue; end
			/* */ if ((_1 == (98))  or  (_1 == (103))  or  (_1 == (71))) { __s = 3; continue; end
			/* */ if ((_1 == (102))  or  (_1 == (101))  or  (_1 == (69))) { __s = 4; continue; end
			/* */ if (_1 == (70)) { __s = 5; continue; end
			/* */ __s = 6; continue;
			/* if (_1 == (118)) { */ case 2:
				p.fmt.fmt_float(v, size, 103, -1);
				__s = 7; continue;
			/* end else if ((_1 == (98))  or  (_1 == (103))  or  (_1 == (71))) { */ case 3:
				p.fmt.fmt_float(v, size, verb, -1);
				__s = 7; continue;
			/* end else if ((_1 == (102))  or  (_1 == (101))  or  (_1 == (69))) { */ case 4:
				p.fmt.fmt_float(v, size, verb, 6);
				__s = 7; continue;
			/* end else if (_1 == (70)) { */ case 5:
				p.fmt.fmt_float(v, size, 102, 6);
				__s = 7; continue;
			/* end else { */ case 6:
				__r = p.badVerb(verb); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 7:
		case 1:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.fmtFloat end; end __f._1 = _1; __f.p = p; __f.size = size; __f.v = v; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.fmtFloat = function(b) return this.__val.fmtFloat(v, size, verb); end;
	pp.ptr.prototype.fmtComplex = function(b)
		var _1, _q, _q__1, oldPlus, p, size, v, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _q = __f._q; _q__1 = __f._q__1; oldPlus = __f.oldPlus; p = __f.p; size = __f.size; v = __f.v; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
			_1 = verb;
			/* */ if ((_1 == (118))  or  (_1 == (98))  or  (_1 == (103))  or  (_1 == (71))  or  (_1 == (102))  or  (_1 == (70))  or  (_1 == (101))  or  (_1 == (69))) { __s = 2; continue; end
			/* */ __s = 3; continue;
			/* if ((_1 == (118))  or  (_1 == (98))  or  (_1 == (103))  or  (_1 == (71))  or  (_1 == (102))  or  (_1 == (70))  or  (_1 == (101))  or  (_1 == (69))) { */ case 2:
				oldPlus = p.fmt.fmtFlags.plus;
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(40);
				__r = p.fmtFloat(v.__real, (_q = size / 2, (_q == _q  and  _q ~= 1/0  and  _q ~= -1/0) ? _q >> 0 : __throwRuntimeError("integer divide by zero")), verb); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				p.fmt.fmtFlags.plus = true;
				__r = p.fmtFloat(v.__imag, (_q__1 = size / 2, (_q__1 == _q__1  and  _q__1 ~= 1/0  and  _q__1 ~= -1/0) ? _q__1 >> 0 : __throwRuntimeError("integer divide by zero")), verb); /* */ __s = 6; case 6: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("i)");
				p.fmt.fmtFlags.plus = oldPlus;
				__s = 4; continue;
			/* end else { */ case 3:
				__r = p.badVerb(verb); /* */ __s = 7; case 7: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 4:
		case 1:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.fmtComplex end; end __f._1 = _1; __f._q = _q; __f._q__1 = _q__1; __f.oldPlus = oldPlus; __f.p = p; __f.size = size; __f.v = v; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.fmtComplex = function(b) return this.__val.fmtComplex(v, size, verb); end;
	pp.ptr.prototype.fmtString = function(b)
		var _1, p, v, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; p = __f.p; v = __f.v; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
			_1 = verb;
			/* */ if (_1 == (118)) { __s = 2; continue; end
			/* */ if (_1 == (115)) { __s = 3; continue; end
			/* */ if (_1 == (120)) { __s = 4; continue; end
			/* */ if (_1 == (88)) { __s = 5; continue; end
			/* */ if (_1 == (113)) { __s = 6; continue; end
			/* */ __s = 7; continue;
			/* if (_1 == (118)) { */ case 2:
				if (p.fmt.fmtFlags.sharpV) {
					p.fmt.fmt_q(v);
				end else {
					p.fmt.fmt_s(v);
				end
				__s = 8; continue;
			/* end else if (_1 == (115)) { */ case 3:
				p.fmt.fmt_s(v);
				__s = 8; continue;
			/* end else if (_1 == (120)) { */ case 4:
				p.fmt.fmt_sx(v, "0123456789abcdefx");
				__s = 8; continue;
			/* end else if (_1 == (88)) { */ case 5:
				p.fmt.fmt_sx(v, "0123456789ABCDEFX");
				__s = 8; continue;
			/* end else if (_1 == (113)) { */ case 6:
				p.fmt.fmt_q(v);
				__s = 8; continue;
			/* end else { */ case 7:
				__r = p.badVerb(verb); /* */ __s = 9; case 9: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 8:
		case 1:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.fmtString end; end __f._1 = _1; __f.p = p; __f.v = v; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.fmtString = function(b) return this.__val.fmtString(v, verb); end;
	pp.ptr.prototype.fmtBytes = function(g)
		var _1, _i, _i__1, _r, _ref, _ref__1, c, c__1, i, i__1, p, typeString, v, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _i = __f._i; _i__1 = __f._i__1; _r = __f._r; _ref = __f._ref; _ref__1 = __f._ref__1; c = __f.c; c__1 = __f.c__1; i = __f.i; i__1 = __f.i__1; p = __f.p; typeString = __f.typeString; v = __f.v; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
			_1 = verb;
			/* */ if ((_1 == (118))  or  (_1 == (100))) { __s = 2; continue; end
			/* */ if (_1 == (115)) { __s = 3; continue; end
			/* */ if (_1 == (120)) { __s = 4; continue; end
			/* */ if (_1 == (88)) { __s = 5; continue; end
			/* */ if (_1 == (113)) { __s = 6; continue; end
			/* */ __s = 7; continue;
			/* if ((_1 == (118))  or  (_1 == (100))) { */ case 2:
				if (p.fmt.fmtFlags.sharpV) {
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(typeString);
					if (v == sliceType__2.nil) {
						(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("(nil)");
						__s = -1; return;
					end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(123);
					_ref = v;
					_i = 0;
					while (true) {
						if ( not (_i < _ref.__length)) { break; end
						i = _i;
						c = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
						if (i > 0) {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(", ");
						end
						p.fmt0x64((new __Uint64(0, c)), true);
						_i++;
					end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(125);
				end else {
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(91);
					_ref__1 = v;
					_i__1 = 0;
					while (true) {
						if ( not (_i__1 < _ref__1.__length)) { break; end
						i__1 = _i__1;
						c__1 = ((_i__1 < 0  or  _i__1 >= _ref__1.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref__1.__array[_ref__1.__offset + _i__1]);
						if (i__1 > 0) {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(32);
						end
						p.fmt.fmt_integer((new __Uint64(0, c__1)), 10, false, "0123456789abcdefx");
						_i__1++;
					end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(93);
				end
				__s = 8; continue;
			/* end else if (_1 == (115)) { */ case 3:
				p.fmt.fmt_s((__bytesToString(v)));
				__s = 8; continue;
			/* end else if (_1 == (120)) { */ case 4:
				p.fmt.fmt_bx(v, "0123456789abcdefx");
				__s = 8; continue;
			/* end else if (_1 == (88)) { */ case 5:
				p.fmt.fmt_bx(v, "0123456789ABCDEFX");
				__s = 8; continue;
			/* end else if (_1 == (113)) { */ case 6:
				p.fmt.fmt_q((__bytesToString(v)));
				__s = 8; continue;
			/* end else { */ case 7:
				_r = reflect.ValueOf(v); /* */ __s = 9; case 9: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__r = p.printValue(__clone(_r, reflect.Value), verb, 0); /* */ __s = 10; case 10: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 8:
		case 1:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.fmtBytes end; end __f._1 = _1; __f._i = _i; __f._i__1 = _i__1; __f._r = _r; __f._ref = _ref; __f._ref__1 = _ref__1; __f.c = c; __f.c__1 = c__1; __f.i = i; __f.i__1 = i__1; __f.p = p; __f.typeString = typeString; __f.v = v; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.fmtBytes = function(g) return this.__val.fmtBytes(v, verb, typeString); end;
	pp.ptr.prototype.fmtPointer = function(b)
		var _1, _2, _r, p, u, value, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _2 = __f._2; _r = __f._r; p = __f.p; u = __f.u; value = __f.value; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		u = 0;
			_1 = __clone(value, reflect.Value).Kind();
			/* */ if ((_1 == (18))  or  (_1 == (19))  or  (_1 == (21))  or  (_1 == (22))  or  (_1 == (23))  or  (_1 == (26))) { __s = 2; continue; end
			/* */ __s = 3; continue;
			/* if ((_1 == (18))  or  (_1 == (19))  or  (_1 == (21))  or  (_1 == (22))  or  (_1 == (23))  or  (_1 == (26))) { */ case 2:
				u = __clone(value, reflect.Value).Pointer();
				__s = 4; continue;
			/* end else { */ case 3:
				__r = p.badVerb(verb); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = -1; return;
			/* end */ case 4:
		case 1:
			_2 = verb;
			/* */ if (_2 == (118)) { __s = 7; continue; end
			/* */ if (_2 == (112)) { __s = 8; continue; end
			/* */ if ((_2 == (98))  or  (_2 == (111))  or  (_2 == (100))  or  (_2 == (120))  or  (_2 == (88))) { __s = 9; continue; end
			/* */ __s = 10; continue;
			/* if (_2 == (118)) { */ case 7:
				/* */ if (p.fmt.fmtFlags.sharpV) { __s = 12; continue; end
				/* */ __s = 13; continue;
				/* if (p.fmt.fmtFlags.sharpV) { */ case 12:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(40);
					_r = __clone(value, reflect.Value).Type().String(); /* */ __s = 15; case 15: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
					__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r); /* */ __s = 16; case 16: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(")(");
					if (u == 0) {
						(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("nil");
					end else {
						p.fmt0x64((new __Uint64(0, u.constructor == Number ? u : 1)), true);
					end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(41);
					__s = 14; continue;
				/* end else { */ case 13:
					if (u == 0) {
						p.fmt.padString("<nil>");
					end else {
						p.fmt0x64((new __Uint64(0, u.constructor == Number ? u : 1)),  not p.fmt.fmtFlags.sharp);
					end
				/* end */ case 14:
				__s = 11; continue;
			/* end else if (_2 == (112)) { */ case 8:
				p.fmt0x64((new __Uint64(0, u.constructor == Number ? u : 1)),  not p.fmt.fmtFlags.sharp);
				__s = 11; continue;
			/* end else if ((_2 == (98))  or  (_2 == (111))  or  (_2 == (100))  or  (_2 == (120))  or  (_2 == (88))) { */ case 9:
				__r = p.fmtInteger((new __Uint64(0, u.constructor == Number ? u : 1)), false, verb); /* */ __s = 17; case 17: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 11; continue;
			/* end else { */ case 10:
				__r = p.badVerb(verb); /* */ __s = 18; case 18: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 11:
		case 6:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.fmtPointer end; end __f._1 = _1; __f._2 = _2; __f._r = _r; __f.p = p; __f.u = u; __f.value = value; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.fmtPointer = function(b) return this.__val.fmtPointer(value, verb); end;
	pp.ptr.prototype.catchPanic = function(b)
		var _r, arg, err, oldFlags, p, v, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; arg = __f.arg; err = __f.err; oldFlags = __f.oldFlags; p = __f.p; v = __f.v; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		err = __recover();
		/* */ if ( not (__interfaceIsEqual(err, __ifaceNil))) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if ( not (__interfaceIsEqual(err, __ifaceNil))) { */ case 1:
			_r = reflect.ValueOf(arg); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			v = _r;
			if ((__clone(v, reflect.Value).Kind() == 22)  and  __clone(v, reflect.Value).IsNil()) {
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("<nil>");
				__s = -1; return;
			end
			if (p.panicking) {
				__panic(err);
			end
			oldFlags = __clone(p.fmt.fmtFlags, fmtFlags);
			p.fmt.clearflags();
			(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not ");
			(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteRune(verb);
			(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("(PANIC=");
			p.panicking = true;
			__r = p.printArg(err, 118); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			p.panicking = false;
			(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(41);
			fmtFlags.copy(p.fmt.fmtFlags, oldFlags);
		/* end */ case 2:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.catchPanic end; end __f._r = _r; __f.arg = arg; __f.err = err; __f.oldFlags = oldFlags; __f.p = p; __f.v = v; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.catchPanic = function(b) return this.__val.catchPanic(arg, verb); end;
	pp.ptr.prototype.handleMethods = function(b)
		var _1, _r, _r__1, _r__2, _ref, _tuple, _tuple__1, formatter, handled, ok, ok__1, p, stringer, v, v__1, verb, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _ref = __f._ref; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; formatter = __f.formatter; handled = __f.handled; ok = __f.ok; ok__1 = __f.ok__1; p = __f.p; stringer = __f.stringer; v = __f.v; v__1 = __f.v__1; verb = __f.verb; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		handled = false;
		p = this;
		if (p.erroring) {
			__s = -1; return handled;
		end
		_tuple = __assertType(p.arg, Formatter, true);
		formatter = _tuple[0];
		ok = _tuple[1];
		/* */ if (ok) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (ok) { */ case 1:
			handled = true;
			__deferred.push([__methodVal(p, "catchPanic"), [p.arg, verb]]);
			__r = formatter.Format(p, verb); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = -1; return handled;
		/* end */ case 2:
		/* */ if (p.fmt.fmtFlags.sharpV) { __s = 4; continue; end
		/* */ __s = 5; continue;
		/* if (p.fmt.fmtFlags.sharpV) { */ case 4:
			_tuple__1 = __assertType(p.arg, GoStringer, true);
			stringer = _tuple__1[0];
			ok__1 = _tuple__1[1];
			/* */ if (ok__1) { __s = 7; continue; end
			/* */ __s = 8; continue;
			/* if (ok__1) { */ case 7:
				handled = true;
				__deferred.push([__methodVal(p, "catchPanic"), [p.arg, verb]]);
				_r = stringer.GoString(); /* */ __s = 9; case 9: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__r = p.fmt.fmt_s(_r); /* */ __s = 10; case 10: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = -1; return handled;
			/* end */ case 8:
			__s = 6; continue;
		/* end else { */ case 5:
				_1 = verb;
				/* */ if ((_1 == (118))  or  (_1 == (115))  or  (_1 == (120))  or  (_1 == (88))  or  (_1 == (113))) { __s = 12; continue; end
				/* */ __s = 13; continue;
				/* if ((_1 == (118))  or  (_1 == (115))  or  (_1 == (120))  or  (_1 == (88))  or  (_1 == (113))) { */ case 12:
					_ref = p.arg;
					/* */ if (__assertType(_ref, __error, true)[1]) { __s = 14; continue; end
					/* */ if (__assertType(_ref, Stringer, true)[1]) { __s = 15; continue; end
					/* */ __s = 16; continue;
					/* if (__assertType(_ref, __error, true)[1]) { */ case 14:
						v = _ref;
						handled = true;
						__deferred.push([__methodVal(p, "catchPanic"), [p.arg, verb]]);
						_r__1 = v.Error(); /* */ __s = 17; case 17: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
						__r = p.fmtString(_r__1, verb); /* */ __s = 18; case 18: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
						__s = -1; return handled;
					/* end else if (__assertType(_ref, Stringer, true)[1]) { */ case 15:
						v__1 = _ref;
						handled = true;
						__deferred.push([__methodVal(p, "catchPanic"), [p.arg, verb]]);
						_r__2 = v__1.String(); /* */ __s = 19; case 19: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
						__r = p.fmtString(_r__2, verb); /* */ __s = 20; case 20: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
						__s = -1; return handled;
					/* end */ case 16:
				/* end */ case 13:
			case 11:
		/* end */ case 6:
		handled = false;
		__s = -1; return handled;
		/* */ end return; end end catch(err) { __err = err; __s = -1; end finally { __callDeferred(__deferred, __err); if ( not __curGoroutine.asleep) then return  handled; end if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: pp.ptr.prototype.handleMethods end; end __f._1 = _1; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._ref = _ref; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f.formatter = formatter; __f.handled = handled; __f.ok = ok; __f.ok__1 = ok__1; __f.p = p; __f.stringer = stringer; __f.v = v; __f.v__1 = v__1; __f.verb = verb; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	pp.prototype.handleMethods = function(b) return this.__val.handleMethods(verb); end;
	pp.ptr.prototype.printArg = function(b)
		var _1, _2, _r, _r__1, _r__2, _r__3, _r__4, _r__5, _ref, arg, f, f__1, f__10, f__11, f__12, f__13, f__14, f__15, f__16, f__17, f__18, f__19, f__2, f__3, f__4, f__5, f__6, f__7, f__8, f__9, p, verb, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _2 = __f._2; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _ref = __f._ref; arg = __f.arg; f = __f.f; f__1 = __f.f__1; f__10 = __f.f__10; f__11 = __f.f__11; f__12 = __f.f__12; f__13 = __f.f__13; f__14 = __f.f__14; f__15 = __f.f__15; f__16 = __f.f__16; f__17 = __f.f__17; f__18 = __f.f__18; f__19 = __f.f__19; f__2 = __f.f__2; f__3 = __f.f__3; f__4 = __f.f__4; f__5 = __f.f__5; f__6 = __f.f__6; f__7 = __f.f__7; f__8 = __f.f__8; f__9 = __f.f__9; p = __f.p; verb = __f.verb; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		p.arg = arg;
		p.value = new reflect.Value.ptr(ptrType.nil, 0, 0);
		/* */ if (__interfaceIsEqual(arg, __ifaceNil)) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (__interfaceIsEqual(arg, __ifaceNil)) { */ case 1:
				_1 = verb;
				/* */ if ((_1 == (84))  or  (_1 == (118))) { __s = 4; continue; end
				/* */ __s = 5; continue;
				/* if ((_1 == (84))  or  (_1 == (118))) { */ case 4:
					p.fmt.padString("<nil>");
					__s = 6; continue;
				/* end else { */ case 5:
					__r = p.badVerb(verb); /* */ __s = 7; case 7: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				/* end */ case 6:
			case 3:
			__s = -1; return;
		/* end */ case 2:
			_2 = verb;
			/* */ if (_2 == (84)) { __s = 9; continue; end
			/* */ if (_2 == (112)) { __s = 10; continue; end
			/* */ __s = 11; continue;
			/* if (_2 == (84)) { */ case 9:
				_r = reflect.TypeOf(arg).String(); /* */ __s = 12; case 12: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				__r = p.fmt.fmt_s(_r); /* */ __s = 13; case 13: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = -1; return;
			/* end else if (_2 == (112)) { */ case 10:
				_r__1 = reflect.ValueOf(arg); /* */ __s = 14; case 14: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
				__r = p.fmtPointer(__clone(_r__1, reflect.Value), 112); /* */ __s = 15; case 15: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = -1; return;
			/* end */ case 11:
		case 8:
		_ref = arg;
		/* */ if (__assertType(_ref, __Bool, true)[1]) { __s = 16; continue; end
		/* */ if (__assertType(_ref, __Float32, true)[1]) { __s = 17; continue; end
		/* */ if (__assertType(_ref, __Float64, true)[1]) { __s = 18; continue; end
		/* */ if (__assertType(_ref, __Complex64, true)[1]) { __s = 19; continue; end
		/* */ if (__assertType(_ref, __Complex128, true)[1]) { __s = 20; continue; end
		/* */ if (__assertType(_ref, __Int, true)[1]) { __s = 21; continue; end
		/* */ if (__assertType(_ref, __Int8, true)[1]) { __s = 22; continue; end
		/* */ if (__assertType(_ref, __Int16, true)[1]) { __s = 23; continue; end
		/* */ if (__assertType(_ref, __Int32, true)[1]) { __s = 24; continue; end
		/* */ if (__assertType(_ref, __Int64, true)[1]) { __s = 25; continue; end
		/* */ if (__assertType(_ref, __Uint, true)[1]) { __s = 26; continue; end
		/* */ if (__assertType(_ref, __Uint8, true)[1]) { __s = 27; continue; end
		/* */ if (__assertType(_ref, __Uint16, true)[1]) { __s = 28; continue; end
		/* */ if (__assertType(_ref, __Uint32, true)[1]) { __s = 29; continue; end
		/* */ if (__assertType(_ref, __Uint64, true)[1]) { __s = 30; continue; end
		/* */ if (__assertType(_ref, __Uintptr, true)[1]) { __s = 31; continue; end
		/* */ if (__assertType(_ref, __String, true)[1]) { __s = 32; continue; end
		/* */ if (__assertType(_ref, sliceType__2, true)[1]) { __s = 33; continue; end
		/* */ if (__assertType(_ref, reflect.Value, true)[1]) { __s = 34; continue; end
		/* */ __s = 35; continue;
		/* if (__assertType(_ref, __Bool, true)[1]) { */ case 16:
			f = _ref.__val;
			__r = p.fmtBool(f, verb); /* */ __s = 37; case 37: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Float32, true)[1]) { */ case 17:
			f__1 = _ref.__val;
			__r = p.fmtFloat((f__1), 32, verb); /* */ __s = 38; case 38: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Float64, true)[1]) { */ case 18:
			f__2 = _ref.__val;
			__r = p.fmtFloat(f__2, 64, verb); /* */ __s = 39; case 39: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Complex64, true)[1]) { */ case 19:
			f__3 = _ref.__val;
			__r = p.fmtComplex((new __Complex128(f__3.__real, f__3.__imag)), 64, verb); /* */ __s = 40; case 40: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Complex128, true)[1]) { */ case 20:
			f__4 = _ref.__val;
			__r = p.fmtComplex(f__4, 128, verb); /* */ __s = 41; case 41: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Int, true)[1]) { */ case 21:
			f__5 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__5)), true, verb); /* */ __s = 42; case 42: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Int8, true)[1]) { */ case 22:
			f__6 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__6)), true, verb); /* */ __s = 43; case 43: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Int16, true)[1]) { */ case 23:
			f__7 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__7)), true, verb); /* */ __s = 44; case 44: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Int32, true)[1]) { */ case 24:
			f__8 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__8)), true, verb); /* */ __s = 45; case 45: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Int64, true)[1]) { */ case 25:
			f__9 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(f__9.__high, f__9.__low)), true, verb); /* */ __s = 46; case 46: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Uint, true)[1]) { */ case 26:
			f__10 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__10)), false, verb); /* */ __s = 47; case 47: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Uint8, true)[1]) { */ case 27:
			f__11 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__11)), false, verb); /* */ __s = 48; case 48: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Uint16, true)[1]) { */ case 28:
			f__12 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__12)), false, verb); /* */ __s = 49; case 49: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Uint32, true)[1]) { */ case 29:
			f__13 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__13)), false, verb); /* */ __s = 50; case 50: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Uint64, true)[1]) { */ case 30:
			f__14 = _ref.__val;
			__r = p.fmtInteger(f__14, false, verb); /* */ __s = 51; case 51: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __Uintptr, true)[1]) { */ case 31:
			f__15 = _ref.__val;
			__r = p.fmtInteger((new __Uint64(0, f__15.constructor == Number ? f__15 : 1)), false, verb); /* */ __s = 52; case 52: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, __String, true)[1]) { */ case 32:
			f__16 = _ref.__val;
			__r = p.fmtString(f__16, verb); /* */ __s = 53; case 53: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, sliceType__2, true)[1]) { */ case 33:
			f__17 = _ref.__val;
			__r = p.fmtBytes(f__17, verb, "[]byte"); /* */ __s = 54; case 54: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else if (__assertType(_ref, reflect.Value, true)[1]) { */ case 34:
			f__18 = _ref.__val;
			/* */ if (__clone(f__18, reflect.Value).IsValid()  and  __clone(f__18, reflect.Value).CanInterface()) { __s = 55; continue; end
			/* */ __s = 56; continue;
			/* if (__clone(f__18, reflect.Value).IsValid()  and  __clone(f__18, reflect.Value).CanInterface()) { */ case 55:
				_r__2 = __clone(f__18, reflect.Value).Interface(); /* */ __s = 57; case 57: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				p.arg = _r__2;
				_r__3 = p.handleMethods(verb); /* */ __s = 60; case 60: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
				/* */ if (_r__3) { __s = 58; continue; end
				/* */ __s = 59; continue;
				/* if (_r__3) { */ case 58:
					__s = -1; return;
				/* end */ case 59:
			/* end */ case 56:
			__r = p.printValue(__clone(f__18, reflect.Value), verb, 0); /* */ __s = 61; case 61: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__s = 36; continue;
		/* end else { */ case 35:
			f__19 = _ref;
			_r__4 = p.handleMethods(verb); /* */ __s = 64; case 64: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
			/* */ if ( not _r__4) { __s = 62; continue; end
			/* */ __s = 63; continue;
			/* if ( not _r__4) { */ case 62:
				_r__5 = reflect.ValueOf(f__19); /* */ __s = 65; case 65: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
				__r = p.printValue(__clone(_r__5, reflect.Value), verb, 0); /* */ __s = 66; case 66: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 63:
		/* end */ case 36:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.printArg end; end __f._1 = _1; __f._2 = _2; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._ref = _ref; __f.arg = arg; __f.f = f; __f.f__1 = f__1; __f.f__10 = f__10; __f.f__11 = f__11; __f.f__12 = f__12; __f.f__13 = f__13; __f.f__14 = f__14; __f.f__15 = f__15; __f.f__16 = f__16; __f.f__17 = f__17; __f.f__18 = f__18; __f.f__19 = f__19; __f.f__2 = f__2; __f.f__3 = f__3; __f.f__4 = f__4; __f.f__5 = f__5; __f.f__6 = f__6; __f.f__7 = f__7; __f.f__8 = f__8; __f.f__9 = f__9; __f.p = p; __f.verb = verb; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.printArg = function(b) return this.__val.printArg(arg, verb); end;
	pp.ptr.prototype.printValue = function(h)
		var _1, _2, _3, _4, _arg, _arg__1, _arg__2, _i, _i__1, _r, _r__1, _r__10, _r__11, _r__12, _r__13, _r__14, _r__15, _r__16, _r__17, _r__18, _r__19, _r__2, _r__20, _r__21, _r__22, _r__3, _r__4, _r__5, _r__6, _r__7, _r__8, _r__9, _ref, _ref__1, a, bytes, depth, f, i, i__1, i__2, i__3, i__4, key, keys, name, p, t, value, value__1, verb, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _2 = __f._2; _3 = __f._3; _4 = __f._4; _arg = __f._arg; _arg__1 = __f._arg__1; _arg__2 = __f._arg__2; _i = __f._i; _i__1 = __f._i__1; _r = __f._r; _r__1 = __f._r__1; _r__10 = __f._r__10; _r__11 = __f._r__11; _r__12 = __f._r__12; _r__13 = __f._r__13; _r__14 = __f._r__14; _r__15 = __f._r__15; _r__16 = __f._r__16; _r__17 = __f._r__17; _r__18 = __f._r__18; _r__19 = __f._r__19; _r__2 = __f._r__2; _r__20 = __f._r__20; _r__21 = __f._r__21; _r__22 = __f._r__22; _r__3 = __f._r__3; _r__4 = __f._r__4; _r__5 = __f._r__5; _r__6 = __f._r__6; _r__7 = __f._r__7; _r__8 = __f._r__8; _r__9 = __f._r__9; _ref = __f._ref; _ref__1 = __f._ref__1; a = __f.a; bytes = __f.bytes; depth = __f.depth; f = __f.f; i = __f.i; i__1 = __f.i__1; i__2 = __f.i__2; i__3 = __f.i__3; i__4 = __f.i__4; key = __f.key; keys = __f.keys; name = __f.name; p = __f.p; t = __f.t; value = __f.value; value__1 = __f.value__1; verb = __f.verb; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		/* */ if (depth > 0  and  __clone(value, reflect.Value).IsValid()  and  __clone(value, reflect.Value).CanInterface()) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (depth > 0  and  __clone(value, reflect.Value).IsValid()  and  __clone(value, reflect.Value).CanInterface()) { */ case 1:
			_r = __clone(value, reflect.Value).Interface(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			p.arg = _r;
			_r__1 = p.handleMethods(verb); /* */ __s = 6; case 6: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			/* */ if (_r__1) { __s = 4; continue; end
			/* */ __s = 5; continue;
			/* if (_r__1) { */ case 4:
				__s = -1; return;
			/* end */ case 5:
		/* end */ case 2:
		p.arg = __ifaceNil;
		p.value = value;
			f = value;
			_1 = __clone(value, reflect.Value).Kind();
			/* */ if (_1 == (0)) { __s = 8; continue; end
			/* */ if (_1 == (1)) { __s = 9; continue; end
			/* */ if ((_1 == (2))  or  (_1 == (3))  or  (_1 == (4))  or  (_1 == (5))  or  (_1 == (6))) { __s = 10; continue; end
			/* */ if ((_1 == (7))  or  (_1 == (8))  or  (_1 == (9))  or  (_1 == (10))  or  (_1 == (11))  or  (_1 == (12))) { __s = 11; continue; end
			/* */ if (_1 == (13)) { __s = 12; continue; end
			/* */ if (_1 == (14)) { __s = 13; continue; end
			/* */ if (_1 == (15)) { __s = 14; continue; end
			/* */ if (_1 == (16)) { __s = 15; continue; end
			/* */ if (_1 == (24)) { __s = 16; continue; end
			/* */ if (_1 == (21)) { __s = 17; continue; end
			/* */ if (_1 == (25)) { __s = 18; continue; end
			/* */ if (_1 == (20)) { __s = 19; continue; end
			/* */ if ((_1 == (17))  or  (_1 == (23))) { __s = 20; continue; end
			/* */ if (_1 == (22)) { __s = 21; continue; end
			/* */ if ((_1 == (18))  or  (_1 == (19))  or  (_1 == (26))) { __s = 22; continue; end
			/* */ __s = 23; continue;
			/* if (_1 == (0)) { */ case 8:
				/* */ if (depth == 0) { __s = 25; continue; end
				/* */ __s = 26; continue;
				/* if (depth == 0) { */ case 25:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("<invalid reflect.Value>");
					__s = 27; continue;
				/* end else { */ case 26:
						_2 = verb;
						/* */ if (_2 == (118)) { __s = 29; continue; end
						/* */ __s = 30; continue;
						/* if (_2 == (118)) { */ case 29:
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("<nil>");
							__s = 31; continue;
						/* end else { */ case 30:
							__r = p.badVerb(verb); /* */ __s = 32; case 32: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
						/* end */ case 31:
					case 28:
				/* end */ case 27:
				__s = 24; continue;
			/* end else if (_1 == (1)) { */ case 9:
				__r = p.fmtBool(__clone(f, reflect.Value).Bool(), verb); /* */ __s = 33; case 33: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if ((_1 == (2))  or  (_1 == (3))  or  (_1 == (4))  or  (_1 == (5))  or  (_1 == (6))) { */ case 10:
				__r = p.fmtInteger(((x = __clone(f, reflect.Value).Int(), new __Uint64(x.__high, x.__low))), true, verb); /* */ __s = 34; case 34: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if ((_1 == (7))  or  (_1 == (8))  or  (_1 == (9))  or  (_1 == (10))  or  (_1 == (11))  or  (_1 == (12))) { */ case 11:
				__r = p.fmtInteger(__clone(f, reflect.Value).Uint(), false, verb); /* */ __s = 35; case 35: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if (_1 == (13)) { */ case 12:
				__r = p.fmtFloat(__clone(f, reflect.Value).Float(), 32, verb); /* */ __s = 36; case 36: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if (_1 == (14)) { */ case 13:
				__r = p.fmtFloat(__clone(f, reflect.Value).Float(), 64, verb); /* */ __s = 37; case 37: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if (_1 == (15)) { */ case 14:
				__r = p.fmtComplex(__clone(f, reflect.Value).Complex(), 64, verb); /* */ __s = 38; case 38: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if (_1 == (16)) { */ case 15:
				__r = p.fmtComplex(__clone(f, reflect.Value).Complex(), 128, verb); /* */ __s = 39; case 39: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if (_1 == (24)) { */ case 16:
				_r__2 = __clone(f, reflect.Value).String(); /* */ __s = 40; case 40: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				__r = p.fmtString(_r__2, verb); /* */ __s = 41; case 41: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if (_1 == (21)) { */ case 17:
				/* */ if (p.fmt.fmtFlags.sharpV) { __s = 42; continue; end
				/* */ __s = 43; continue;
				/* if (p.fmt.fmtFlags.sharpV) { */ case 42:
					_r__3 = __clone(f, reflect.Value).Type().String(); /* */ __s = 45; case 45: if(__c) then __c = false; _r__3 = _r__3.__blk(); end if (_r__3  and  _r__3.__blk ~= nil) { break s; end
					__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r__3); /* */ __s = 46; case 46: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					if (__clone(f, reflect.Value).IsNil()) {
						(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("(nil)");
						__s = -1; return;
					end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(123);
					__s = 44; continue;
				/* end else { */ case 43:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("map[");
				/* end */ case 44:
				_r__4 = __clone(f, reflect.Value).MapKeys(); /* */ __s = 47; case 47: if(__c) then __c = false; _r__4 = _r__4.__blk(); end if (_r__4  and  _r__4.__blk ~= nil) { break s; end
				keys = _r__4;
				_ref = keys;
				_i = 0;
				/* while (true) { */ case 48:
					/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 49; continue; end
					i = _i;
					key = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
					if (i > 0) {
						if (p.fmt.fmtFlags.sharpV) {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(", ");
						end else {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(32);
						end
					end
					__r = p.printValue(__clone(key, reflect.Value), verb, depth + 1 >> 0); /* */ __s = 50; case 50: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(58);
					_r__5 = __clone(f, reflect.Value).MapIndex(__clone(key, reflect.Value)); /* */ __s = 51; case 51: if(__c) then __c = false; _r__5 = _r__5.__blk(); end if (_r__5  and  _r__5.__blk ~= nil) { break s; end
					__r = p.printValue(__clone(_r__5, reflect.Value), verb, depth + 1 >> 0); /* */ __s = 52; case 52: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					_i++;
				/* end */ __s = 48; continue; case 49:
				if (p.fmt.fmtFlags.sharpV) {
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(125);
				end else {
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(93);
				end
				__s = 24; continue;
			/* end else if (_1 == (25)) { */ case 18:
				/* */ if (p.fmt.fmtFlags.sharpV) { __s = 53; continue; end
				/* */ __s = 54; continue;
				/* if (p.fmt.fmtFlags.sharpV) { */ case 53:
					_r__6 = __clone(f, reflect.Value).Type().String(); /* */ __s = 55; case 55: if(__c) then __c = false; _r__6 = _r__6.__blk(); end if (_r__6  and  _r__6.__blk ~= nil) { break s; end
					__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r__6); /* */ __s = 56; case 56: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				/* end */ case 54:
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(123);
				i__1 = 0;
				/* while (true) { */ case 57:
					/* if ( not (i__1 < __clone(f, reflect.Value).NumField())) { break; end */ if( not (i__1 < __clone(f, reflect.Value).NumField())) { __s = 58; continue; end
					if (i__1 > 0) {
						if (p.fmt.fmtFlags.sharpV) {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(", ");
						end else {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(32);
						end
					end
					/* */ if (p.fmt.fmtFlags.plusV  or  p.fmt.fmtFlags.sharpV) { __s = 59; continue; end
					/* */ __s = 60; continue;
					/* if (p.fmt.fmtFlags.plusV  or  p.fmt.fmtFlags.sharpV) { */ case 59:
						_r__7 = __clone(f, reflect.Value).Type().Field(i__1); /* */ __s = 61; case 61: if(__c) then __c = false; _r__7 = _r__7.__blk(); end if (_r__7  and  _r__7.__blk ~= nil) { break s; end
						name = _r__7.Name;
						if ( not (name == "")) {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(name);
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(58);
						end
					/* end */ case 60:
					_r__8 = getField(__clone(f, reflect.Value), i__1); /* */ __s = 62; case 62: if(__c) then __c = false; _r__8 = _r__8.__blk(); end if (_r__8  and  _r__8.__blk ~= nil) { break s; end
					__r = p.printValue(__clone(_r__8, reflect.Value), verb, depth + 1 >> 0); /* */ __s = 63; case 63: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					i__1 = i__1 + (1) >> 0;
				/* end */ __s = 57; continue; case 58:
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(125);
				__s = 24; continue;
			/* end else if (_1 == (20)) { */ case 19:
				_r__9 = __clone(f, reflect.Value).Elem(); /* */ __s = 64; case 64: if(__c) then __c = false; _r__9 = _r__9.__blk(); end if (_r__9  and  _r__9.__blk ~= nil) { break s; end
				value__1 = _r__9;
				/* */ if ( not __clone(value__1, reflect.Value).IsValid()) { __s = 65; continue; end
				/* */ __s = 66; continue;
				/* if ( not __clone(value__1, reflect.Value).IsValid()) { */ case 65:
					/* */ if (p.fmt.fmtFlags.sharpV) { __s = 68; continue; end
					/* */ __s = 69; continue;
					/* if (p.fmt.fmtFlags.sharpV) { */ case 68:
						_r__10 = __clone(f, reflect.Value).Type().String(); /* */ __s = 71; case 71: if(__c) then __c = false; _r__10 = _r__10.__blk(); end if (_r__10  and  _r__10.__blk ~= nil) { break s; end
						__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r__10); /* */ __s = 72; case 72: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
						(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("(nil)");
						__s = 70; continue;
					/* end else { */ case 69:
						(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("<nil>");
					/* end */ case 70:
					__s = 67; continue;
				/* end else { */ case 66:
					__r = p.printValue(__clone(value__1, reflect.Value), verb, depth + 1 >> 0); /* */ __s = 73; case 73: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				/* end */ case 67:
				__s = 24; continue;
			/* end else if ((_1 == (17))  or  (_1 == (23))) { */ case 20:
					_3 = verb;
					/* */ if ((_3 == (115))  or  (_3 == (113))  or  (_3 == (120))  or  (_3 == (88))) { __s = 75; continue; end
					/* */ __s = 76; continue;
					/* if ((_3 == (115))  or  (_3 == (113))  or  (_3 == (120))  or  (_3 == (88))) { */ case 75:
						t = __clone(f, reflect.Value).Type();
						_r__11 = t.Elem(); /* */ __s = 79; case 79: if(__c) then __c = false; _r__11 = _r__11.__blk(); end if (_r__11  and  _r__11.__blk ~= nil) { break s; end
						_r__12 = _r__11.Kind(); /* */ __s = 80; case 80: if(__c) then __c = false; _r__12 = _r__12.__blk(); end if (_r__12  and  _r__12.__blk ~= nil) { break s; end
						/* */ if (_r__12 == 8) { __s = 77; continue; end
						/* */ __s = 78; continue;
						/* if (_r__12 == 8) { */ case 77:
							bytes = sliceType__2.nil;
							/* */ if (__clone(f, reflect.Value).Kind() == 23) { __s = 81; continue; end
							/* */ if (__clone(f, reflect.Value).CanAddr()) { __s = 82; continue; end
							/* */ __s = 83; continue;
							/* if (__clone(f, reflect.Value).Kind() == 23) { */ case 81:
								_r__13 = __clone(f, reflect.Value).Bytes(); /* */ __s = 85; case 85: if(__c) then __c = false; _r__13 = _r__13.__blk(); end if (_r__13  and  _r__13.__blk ~= nil) { break s; end
								bytes = _r__13;
								__s = 84; continue;
							/* end else if (__clone(f, reflect.Value).CanAddr()) { */ case 82:
								_r__14 = __clone(f, reflect.Value).Slice(0, __clone(f, reflect.Value).Len()); /* */ __s = 86; case 86: if(__c) then __c = false; _r__14 = _r__14.__blk(); end if (_r__14  and  _r__14.__blk ~= nil) { break s; end
								_r__15 = __clone(_r__14, reflect.Value).Bytes(); /* */ __s = 87; case 87: if(__c) then __c = false; _r__15 = _r__15.__blk(); end if (_r__15  and  _r__15.__blk ~= nil) { break s; end
								bytes = _r__15;
								__s = 84; continue;
							/* end else { */ case 83:
								bytes = __makeSlice(sliceType__2, __clone(f, reflect.Value).Len());
								_ref__1 = bytes;
								_i__1 = 0;
								/* while (true) { */ case 88:
									/* if ( not (_i__1 < _ref__1.__length)) { break; end */ if( not (_i__1 < _ref__1.__length)) { __s = 89; continue; end
									i__2 = _i__1;
									_r__16 = __clone(f, reflect.Value).Index(i__2); /* */ __s = 90; case 90: if(__c) then __c = false; _r__16 = _r__16.__blk(); end if (_r__16  and  _r__16.__blk ~= nil) { break s; end
									_r__17 = __clone(_r__16, reflect.Value).Uint(); /* */ __s = 91; case 91: if(__c) then __c = false; _r__17 = _r__17.__blk(); end if (_r__17  and  _r__17.__blk ~= nil) { break s; end
									((i__2 < 0  or  i__2 >= bytes.__length) ? (__throwRuntimeError("index out of range"), nil) : bytes.__array[bytes.__offset + i__2] = ((_r__17.__low << 24 >>> 24)));
									_i__1++;
								/* end */ __s = 88; continue; case 89:
							/* end */ case 84:
							_arg = bytes;
							_arg__1 = verb;
							_r__18 = t.String(); /* */ __s = 92; case 92: if(__c) then __c = false; _r__18 = _r__18.__blk(); end if (_r__18  and  _r__18.__blk ~= nil) { break s; end
							_arg__2 = _r__18;
							__r = p.fmtBytes(_arg, _arg__1, _arg__2); /* */ __s = 93; case 93: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
							__s = -1; return;
						/* end */ case 78:
					/* end */ case 76:
				case 74:
				/* */ if (p.fmt.fmtFlags.sharpV) { __s = 94; continue; end
				/* */ __s = 95; continue;
				/* if (p.fmt.fmtFlags.sharpV) { */ case 94:
					_r__19 = __clone(f, reflect.Value).Type().String(); /* */ __s = 97; case 97: if(__c) then __c = false; _r__19 = _r__19.__blk(); end if (_r__19  and  _r__19.__blk ~= nil) { break s; end
					__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r__19); /* */ __s = 98; case 98: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					if ((__clone(f, reflect.Value).Kind() == 23)  and  __clone(f, reflect.Value).IsNil()) {
						(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("(nil)");
						__s = -1; return;
					end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(123);
					i__3 = 0;
					/* while (true) { */ case 99:
						/* if ( not (i__3 < __clone(f, reflect.Value).Len())) { break; end */ if( not (i__3 < __clone(f, reflect.Value).Len())) { __s = 100; continue; end
						if (i__3 > 0) {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(", ");
						end
						_r__20 = __clone(f, reflect.Value).Index(i__3); /* */ __s = 101; case 101: if(__c) then __c = false; _r__20 = _r__20.__blk(); end if (_r__20  and  _r__20.__blk ~= nil) { break s; end
						__r = p.printValue(__clone(_r__20, reflect.Value), verb, depth + 1 >> 0); /* */ __s = 102; case 102: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
						i__3 = i__3 + (1) >> 0;
					/* end */ __s = 99; continue; case 100:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(125);
					__s = 96; continue;
				/* end else { */ case 95:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(91);
					i__4 = 0;
					/* while (true) { */ case 103:
						/* if ( not (i__4 < __clone(f, reflect.Value).Len())) { break; end */ if( not (i__4 < __clone(f, reflect.Value).Len())) { __s = 104; continue; end
						if (i__4 > 0) {
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(32);
						end
						_r__21 = __clone(f, reflect.Value).Index(i__4); /* */ __s = 105; case 105: if(__c) then __c = false; _r__21 = _r__21.__blk(); end if (_r__21  and  _r__21.__blk ~= nil) { break s; end
						__r = p.printValue(__clone(_r__21, reflect.Value), verb, depth + 1 >> 0); /* */ __s = 106; case 106: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
						i__4 = i__4 + (1) >> 0;
					/* end */ __s = 103; continue; case 104:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(93);
				/* end */ case 96:
				__s = 24; continue;
			/* end else if (_1 == (22)) { */ case 21:
				/* */ if ((depth == 0)  and   not ((__clone(f, reflect.Value).Pointer() == 0))) { __s = 107; continue; end
				/* */ __s = 108; continue;
				/* if ((depth == 0)  and   not ((__clone(f, reflect.Value).Pointer() == 0))) { */ case 107:
						_r__22 = __clone(f, reflect.Value).Elem(); /* */ __s = 110; case 110: if(__c) then __c = false; _r__22 = _r__22.__blk(); end if (_r__22  and  _r__22.__blk ~= nil) { break s; end
						a = _r__22;
						_4 = __clone(a, reflect.Value).Kind();
						/* */ if ((_4 == (17))  or  (_4 == (23))  or  (_4 == (25))  or  (_4 == (21))) { __s = 111; continue; end
						/* */ __s = 112; continue;
						/* if ((_4 == (17))  or  (_4 == (23))  or  (_4 == (25))  or  (_4 == (21))) { */ case 111:
							(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(38);
							__r = p.printValue(__clone(a, reflect.Value), verb, depth + 1 >> 0); /* */ __s = 113; case 113: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
							__s = -1; return;
						/* end */ case 112:
					case 109:
				/* end */ case 108:
				__r = p.fmtPointer(__clone(f, reflect.Value), verb); /* */ __s = 114; case 114: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else if ((_1 == (18))  or  (_1 == (19))  or  (_1 == (26))) { */ case 22:
				__r = p.fmtPointer(__clone(f, reflect.Value), verb); /* */ __s = 115; case 115: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				__s = 24; continue;
			/* end else { */ case 23:
				__r = p.unknownType(__clone(f, reflect.Value)); /* */ __s = 116; case 116: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			/* end */ case 24:
		case 7:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.printValue end; end __f._1 = _1; __f._2 = _2; __f._3 = _3; __f._4 = _4; __f._arg = _arg; __f._arg__1 = _arg__1; __f._arg__2 = _arg__2; __f._i = _i; __f._i__1 = _i__1; __f._r = _r; __f._r__1 = _r__1; __f._r__10 = _r__10; __f._r__11 = _r__11; __f._r__12 = _r__12; __f._r__13 = _r__13; __f._r__14 = _r__14; __f._r__15 = _r__15; __f._r__16 = _r__16; __f._r__17 = _r__17; __f._r__18 = _r__18; __f._r__19 = _r__19; __f._r__2 = _r__2; __f._r__20 = _r__20; __f._r__21 = _r__21; __f._r__22 = _r__22; __f._r__3 = _r__3; __f._r__4 = _r__4; __f._r__5 = _r__5; __f._r__6 = _r__6; __f._r__7 = _r__7; __f._r__8 = _r__8; __f._r__9 = _r__9; __f._ref = _ref; __f._ref__1 = _ref__1; __f.a = a; __f.bytes = bytes; __f.depth = depth; __f.f = f; __f.i = i; __f.i__1 = i__1; __f.i__2 = i__2; __f.i__3 = i__3; __f.i__4 = i__4; __f.key = key; __f.keys = keys; __f.name = name; __f.p = p; __f.t = t; __f.value = value; __f.value__1 = value__1; __f.verb = verb; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.printValue = function(h) return this.__val.printValue(value, verb, depth); end;
	intFromArg = function(m)
		var _1, _r, _tuple, a, argNum, isInt, n, n__1, newArgNum, num, v, x, x__1, x__2, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _r = __f._r; _tuple = __f._tuple; a = __f.a; argNum = __f.argNum; isInt = __f.isInt; n = __f.n; n__1 = __f.n__1; newArgNum = __f.newArgNum; num = __f.num; v = __f.v; x = __f.x; x__1 = __f.x__1; x__2 = __f.x__2; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		num = 0;
		isInt = false;
		newArgNum = 0;
		newArgNum = argNum;
		/* */ if (argNum < a.__length) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (argNum < a.__length) { */ case 1:
			_tuple = __assertType(((argNum < 0  or  argNum >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + argNum]), __Int, true);
			num = _tuple[0];
			isInt = _tuple[1];
			/* */ if ( not isInt) { __s = 3; continue; end
			/* */ __s = 4; continue;
			/* if ( not isInt) { */ case 3:
					_r = reflect.ValueOf(((argNum < 0  or  argNum >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + argNum])); /* */ __s = 6; case 6: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
					v = _r;
					_1 = __clone(v, reflect.Value).Kind();
					if ((_1 == (2))  or  (_1 == (3))  or  (_1 == (4))  or  (_1 == (5))  or  (_1 == (6))) {
						n = __clone(v, reflect.Value).Int();
						if ((x = (new __Int64(0, (((n.__low + ((n.__high >> 31) * 4294967296)) >> 0)))), (x.__high == n.__high  and  x.__low == n.__low))) {
							num = (((n.__low + ((n.__high >> 31) * 4294967296)) >> 0));
							isInt = true;
						end
					end else if ((_1 == (7))  or  (_1 == (8))  or  (_1 == (9))  or  (_1 == (10))  or  (_1 == (11))  or  (_1 == (12))) {
						n__1 = __clone(v, reflect.Value).Uint();
						if ((x__1 = (new __Int64(n__1.__high, n__1.__low)), (x__1.__high > 0  or  (x__1.__high == 0  and  x__1.__low >= 0)))  and  (x__2 = (new __Uint64(0, ((n__1.__low >> 0)))), (x__2.__high == n__1.__high  and  x__2.__low == n__1.__low))) {
							num = ((n__1.__low >> 0));
							isInt = true;
						end
					end
				case 5:
			/* end */ case 4:
			newArgNum = argNum + 1 >> 0;
			if (tooLarge(num)) {
				num = 0;
				isInt = false;
			end
		/* end */ case 2:
		__s = -1; return [num, isInt, newArgNum];
		/* */ end return; end if __f == nil then  __f = { __blk: intFromArg end; end __f._1 = _1; __f._r = _r; __f._tuple = _tuple; __f.a = a; __f.argNum = argNum; __f.isInt = isInt; __f.n = n; __f.n__1 = n__1; __f.newArgNum = newArgNum; __f.num = num; __f.v = v; __f.x = x; __f.x__1 = x__1; __f.x__2 = x__2; __f.__s = __s; __f.__r = __r; return __f;
	end;
	parseArgNumber = function(t)
		var _tmp, _tmp__1, _tmp__10, _tmp__11, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tmp__8, _tmp__9, _tuple, format, i, index, newi, ok, ok__1, wid, width;
		index = 0;
		wid = 0;
		ok = false;
		if (format.length < 3) {
			_tmp = 0;
			_tmp__1 = 1;
			_tmp__2 = false;
			index = _tmp;
			wid = _tmp__1;
			ok = _tmp__2;
			return [index, wid, ok];
		end
		i = 1;
		while (true) {
			if ( not (i < format.length)) { break; end
			if (format.charCodeAt(i) == 93) {
				_tuple = parsenum(format, 1, i);
				width = _tuple[0];
				ok__1 = _tuple[1];
				newi = _tuple[2];
				if ( not ok__1  or   not ((newi == i))) {
					_tmp__3 = 0;
					_tmp__4 = i + 1 >> 0;
					_tmp__5 = false;
					index = _tmp__3;
					wid = _tmp__4;
					ok = _tmp__5;
					return [index, wid, ok];
				end
				_tmp__6 = width - 1 >> 0;
				_tmp__7 = i + 1 >> 0;
				_tmp__8 = true;
				index = _tmp__6;
				wid = _tmp__7;
				ok = _tmp__8;
				return [index, wid, ok];
			end
			i = i + (1) >> 0;
		end
		_tmp__9 = 0;
		_tmp__10 = 1;
		_tmp__11 = false;
		index = _tmp__9;
		wid = _tmp__10;
		ok = _tmp__11;
		return [index, wid, ok];
	end;
	pp.ptr.prototype.argNumber = function(s)
		var _tmp, _tmp__1, _tmp__2, _tmp__3, _tmp__4, _tmp__5, _tmp__6, _tmp__7, _tmp__8, _tuple, argNum, format, found, i, index, newArgNum, newi, numArgs, ok, p, wid;
		newArgNum = 0;
		newi = 0;
		found = false;
		p = this;
		if (format.length <= i  or   not ((format.charCodeAt(i) == 91))) {
			_tmp = argNum;
			_tmp__1 = i;
			_tmp__2 = false;
			newArgNum = _tmp;
			newi = _tmp__1;
			found = _tmp__2;
			return [newArgNum, newi, found];
		end
		p.reordered = true;
		_tuple = parseArgNumber(__substring(format, i));
		index = _tuple[0];
		wid = _tuple[1];
		ok = _tuple[2];
		if (ok  and  0 <= index  and  index < numArgs) {
			_tmp__3 = index;
			_tmp__4 = i + wid >> 0;
			_tmp__5 = true;
			newArgNum = _tmp__3;
			newi = _tmp__4;
			found = _tmp__5;
			return [newArgNum, newi, found];
		end
		p.goodArgNum = false;
		_tmp__6 = argNum;
		_tmp__7 = i + wid >> 0;
		_tmp__8 = ok;
		newArgNum = _tmp__6;
		newi = _tmp__7;
		found = _tmp__8;
		return [newArgNum, newi, found];
	end;
	pp.prototype.argNumber = function(s) return this.__val.argNumber(argNum, format, i, numArgs); end;
	pp.ptr.prototype.badArgNum = function(b)
		var p, verb;
		p = this;
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not ");
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteRune(verb);
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("(BADINDEX)");
	end;
	pp.prototype.badArgNum = function(b) return this.__val.badArgNum(verb); end;
	pp.ptr.prototype.missingArg = function(b)
		var p, verb;
		p = this;
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not ");
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteRune(verb);
		(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("(MISSING)");
	end;
	pp.prototype.missingArg = function(b) return this.__val.missingArg(verb); end;
	pp.ptr.prototype.doPrintf = function(a)
		var _1, _i, _r, _r__1, _r__2, _ref, _tuple, _tuple__1, _tuple__2, _tuple__3, _tuple__4, _tuple__5, _tuple__6, _tuple__7, a, afterIndex, arg, argNum, c, end, format, i, i__1, lasti, p, verb, w, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _1 = __f._1; _i = __f._i; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _ref = __f._ref; _tuple = __f._tuple; _tuple__1 = __f._tuple__1; _tuple__2 = __f._tuple__2; _tuple__3 = __f._tuple__3; _tuple__4 = __f._tuple__4; _tuple__5 = __f._tuple__5; _tuple__6 = __f._tuple__6; _tuple__7 = __f._tuple__7; a = __f.a; afterIndex = __f.afterIndex; arg = __f.arg; argNum = __f.argNum; c = __f.c; end = __f.end; format = __f.format; i = __f.i; i__1 = __f.i__1; lasti = __f.lasti; p = __f.p; verb = __f.verb; w = __f.w; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		p = this;
		end = format.length;
		argNum = 0;
		afterIndex = false;
		p.reordered = false;
		i = 0;
		/* while (true) { */ case 1:
			/* if ( not (i < end)) { break; end */ if( not (i < end)) { __s = 2; continue; end
			p.goodArgNum = true;
			lasti = i;
			while (true) {
				if ( not (i < end  and   not ((format.charCodeAt(i) == 37)))) { break; end
				i = i + (1) >> 0;
			end
			if (i > lasti) {
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(__substring(format, lasti, i));
			end
			if (i >= end) {
				/* break; */ __s = 2; continue;
			end
			i = i + (1) >> 0;
			p.fmt.clearflags();
			/* while (true) { */ case 3:
				/* if ( not (i < end)) { break; end */ if( not (i < end)) { __s = 4; continue; end
				c = format.charCodeAt(i);
					_1 = c;
					/* */ if (_1 == (35)) { __s = 6; continue; end
					/* */ if (_1 == (48)) { __s = 7; continue; end
					/* */ if (_1 == (43)) { __s = 8; continue; end
					/* */ if (_1 == (45)) { __s = 9; continue; end
					/* */ if (_1 == (32)) { __s = 10; continue; end
					/* */ __s = 11; continue;
					/* if (_1 == (35)) { */ case 6:
						p.fmt.fmtFlags.sharp = true;
						__s = 12; continue;
					/* end else if (_1 == (48)) { */ case 7:
						p.fmt.fmtFlags.zero =  not p.fmt.fmtFlags.minus;
						__s = 12; continue;
					/* end else if (_1 == (43)) { */ case 8:
						p.fmt.fmtFlags.plus = true;
						__s = 12; continue;
					/* end else if (_1 == (45)) { */ case 9:
						p.fmt.fmtFlags.minus = true;
						p.fmt.fmtFlags.zero = false;
						__s = 12; continue;
					/* end else if (_1 == (32)) { */ case 10:
						p.fmt.fmtFlags.space = true;
						__s = 12; continue;
					/* end else { */ case 11:
						/* */ if (97 <= c  and  c <= 122  and  argNum < a.__length) { __s = 13; continue; end
						/* */ __s = 14; continue;
						/* if (97 <= c  and  c <= 122  and  argNum < a.__length) { */ case 13:
							if (c == 118) {
								p.fmt.fmtFlags.sharpV = p.fmt.fmtFlags.sharp;
								p.fmt.fmtFlags.sharp = false;
								p.fmt.fmtFlags.plusV = p.fmt.fmtFlags.plus;
								p.fmt.fmtFlags.plus = false;
							end
							__r = p.printArg(((argNum < 0  or  argNum >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + argNum]), ((c >> 0))); /* */ __s = 15; case 15: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
							argNum = argNum + (1) >> 0;
							i = i + (1) >> 0;
							/* continue formatLoop; */ __s = 1; continue s;
						/* end */ case 14:
						/* break simpleFormat; */ __s = 4; continue s;
					/* end */ case 12:
				case 5:
				i = i + (1) >> 0;
			/* end */ __s = 3; continue; case 4:
			_tuple = p.argNumber(argNum, format, i, a.__length);
			argNum = _tuple[0];
			i = _tuple[1];
			afterIndex = _tuple[2];
			/* */ if (i < end  and  (format.charCodeAt(i) == 42)) { __s = 16; continue; end
			/* */ __s = 17; continue;
			/* if (i < end  and  (format.charCodeAt(i) == 42)) { */ case 16:
				i = i + (1) >> 0;
				_r = intFromArg(a, argNum); /* */ __s = 19; case 19: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
				_tuple__1 = _r;
				p.fmt.wid = _tuple__1[0];
				p.fmt.fmtFlags.widPresent = _tuple__1[1];
				argNum = _tuple__1[2];
				if ( not p.fmt.fmtFlags.widPresent) {
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not (BADWIDTH)");
				end
				if (p.fmt.wid < 0) {
					p.fmt.wid = -p.fmt.wid;
					p.fmt.fmtFlags.minus = true;
					p.fmt.fmtFlags.zero = false;
				end
				afterIndex = false;
				__s = 18; continue;
			/* end else { */ case 17:
				_tuple__2 = parsenum(format, i, end);
				p.fmt.wid = _tuple__2[0];
				p.fmt.fmtFlags.widPresent = _tuple__2[1];
				i = _tuple__2[2];
				if (afterIndex  and  p.fmt.fmtFlags.widPresent) {
					p.goodArgNum = false;
				end
			/* end */ case 18:
			/* */ if ((i + 1 >> 0) < end  and  (format.charCodeAt(i) == 46)) { __s = 20; continue; end
			/* */ __s = 21; continue;
			/* if ((i + 1 >> 0) < end  and  (format.charCodeAt(i) == 46)) { */ case 20:
				i = i + (1) >> 0;
				if (afterIndex) {
					p.goodArgNum = false;
				end
				_tuple__3 = p.argNumber(argNum, format, i, a.__length);
				argNum = _tuple__3[0];
				i = _tuple__3[1];
				afterIndex = _tuple__3[2];
				/* */ if (i < end  and  (format.charCodeAt(i) == 42)) { __s = 22; continue; end
				/* */ __s = 23; continue;
				/* if (i < end  and  (format.charCodeAt(i) == 42)) { */ case 22:
					i = i + (1) >> 0;
					_r__1 = intFromArg(a, argNum); /* */ __s = 25; case 25: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
					_tuple__4 = _r__1;
					p.fmt.prec = _tuple__4[0];
					p.fmt.fmtFlags.precPresent = _tuple__4[1];
					argNum = _tuple__4[2];
					if (p.fmt.prec < 0) {
						p.fmt.prec = 0;
						p.fmt.fmtFlags.precPresent = false;
					end
					if ( not p.fmt.fmtFlags.precPresent) {
						(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not (BADPREC)");
					end
					afterIndex = false;
					__s = 24; continue;
				/* end else { */ case 23:
					_tuple__5 = parsenum(format, i, end);
					p.fmt.prec = _tuple__5[0];
					p.fmt.fmtFlags.precPresent = _tuple__5[1];
					i = _tuple__5[2];
					if ( not p.fmt.fmtFlags.precPresent) {
						p.fmt.prec = 0;
						p.fmt.fmtFlags.precPresent = true;
					end
				/* end */ case 24:
			/* end */ case 21:
			if ( not afterIndex) {
				_tuple__6 = p.argNumber(argNum, format, i, a.__length);
				argNum = _tuple__6[0];
				i = _tuple__6[1];
				afterIndex = _tuple__6[2];
			end
			if (i >= end) {
				(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not (NOVERB)");
				/* break; */ __s = 2; continue;
			end
			_tuple__7 = utf8.DecodeRuneInString(__substring(format, i));
			verb = _tuple__7[0];
			w = _tuple__7[1];
			i = i + (w) >> 0;
				/* */ if ((verb == 37)) { __s = 27; continue; end
				/* */ if ( not p.goodArgNum) { __s = 28; continue; end
				/* */ if (argNum >= a.__length) { __s = 29; continue; end
				/* */ if ((verb == 118)) { __s = 30; continue; end
				/* */ __s = 31; continue;
				/* if ((verb == 37)) { */ case 27:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(37);
					__s = 32; continue;
				/* end else if ( not p.goodArgNum) { */ case 28:
					p.badArgNum(verb);
					__s = 32; continue;
				/* end else if (argNum >= a.__length) { */ case 29:
					p.missingArg(verb);
					__s = 32; continue;
				/* end else if ((verb == 118)) { */ case 30:
					p.fmt.fmtFlags.sharpV = p.fmt.fmtFlags.sharp;
					p.fmt.fmtFlags.sharp = false;
					p.fmt.fmtFlags.plusV = p.fmt.fmtFlags.plus;
					p.fmt.fmtFlags.plus = false;
					__r = p.printArg(((argNum < 0  or  argNum >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + argNum]), verb); /* */ __s = 33; case 33: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					argNum = argNum + (1) >> 0;
					__s = 32; continue;
				/* end else { */ case 31:
					__r = p.printArg(((argNum < 0  or  argNum >= a.__length) ? (__throwRuntimeError("index out of range"), nil) : a.__array[a.__offset + argNum]), verb); /* */ __s = 34; case 34: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					argNum = argNum + (1) >> 0;
				/* end */ case 32:
			case 26:
		/* end */ __s = 1; continue; case 2:
		/* */ if ( not p.reordered  and  argNum < a.__length) { __s = 35; continue; end
		/* */ __s = 36; continue;
		/* if ( not p.reordered  and  argNum < a.__length) { */ case 35:
			p.fmt.clearflags();
			(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("% not (EXTRA ");
			_ref = __subslice(a, argNum);
			_i = 0;
			/* while (true) { */ case 37:
				/* if ( not (_i < _ref.__length)) { break; end */ if( not (_i < _ref.__length)) { __s = 38; continue; end
				i__1 = _i;
				arg = ((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]);
				if (i__1 > 0) {
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(", ");
				end
				/* */ if (__interfaceIsEqual(arg, __ifaceNil)) { __s = 39; continue; end
				/* */ __s = 40; continue;
				/* if (__interfaceIsEqual(arg, __ifaceNil)) { */ case 39:
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString("<nil>");
					__s = 41; continue;
				/* end else { */ case 40:
					_r__2 = reflect.TypeOf(arg).String(); /* */ __s = 42; case 42: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
					__r = (p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteString(_r__2); /* */ __s = 43; case 43: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
					(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(61);
					__r = p.printArg(arg, 118); /* */ __s = 44; case 44: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
				/* end */ case 41:
				_i++;
			/* end */ __s = 37; continue; case 38:
			(p.__ptr_buf  or  (p.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, p))).WriteByte(41);
		/* end */ case 36:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: pp.ptr.prototype.doPrintf end; end __f._1 = _1; __f._i = _i; __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._ref = _ref; __f._tuple = _tuple; __f._tuple__1 = _tuple__1; __f._tuple__2 = _tuple__2; __f._tuple__3 = _tuple__3; __f._tuple__4 = _tuple__4; __f._tuple__5 = _tuple__5; __f._tuple__6 = _tuple__6; __f._tuple__7 = _tuple__7; __f.a = a; __f.afterIndex = afterIndex; __f.arg = arg; __f.argNum = argNum; __f.c = c; __f.end = end; __f.format = format; __f.i = i; __f.i__1 = i__1; __f.lasti = lasti; __f.p = p; __f.verb = verb; __f.w = w; __f.__s = __s; __f.__r = __r; return __f;
	end;
	pp.prototype.doPrintf = function(a) return this.__val.doPrintf(format, a); end;
	ss.ptr.prototype.Read = function(f)
		var _tmp, _tmp__1, buf, err, n, s;
		n = 0;
		err = __ifaceNil;
		s = this;
		_tmp = 0;
		_tmp__1 = errors.New("ScanState's Read should not be called. Use ReadRune");
		n = _tmp;
		err = _tmp__1;
		return [n, err];
	end;
	ss.prototype.Read = function(f) return this.__val.Read(buf); end;
	ss.ptr.prototype.ReadRune = function()
		var _r, _tuple, err, r, s, size, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; err = __f.err; r = __f.r; s = __f.s; size = __f.size; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		r = 0;
		size = 0;
		err = __ifaceNil;
		s = this;
		if (s.atEOF  or  s.count >= s.ssave.argLimit) {
			err = io.EOF;
			__s = -1; return [r, size, err];
		end
		_r = s.rs.ReadRune(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		r = _tuple[0];
		size = _tuple[1];
		err = _tuple[2];
		if (__interfaceIsEqual(err, __ifaceNil)) {
			s.count = s.count + (1) >> 0;
			if (s.ssave.nlIsEnd  and  (r == 10)) {
				s.atEOF = true;
			end
		end else if (__interfaceIsEqual(err, io.EOF)) {
			s.atEOF = true;
		end
		__s = -1; return [r, size, err];
		/* */ end return; end if __f == nil then  __f = { __blk: ss.ptr.prototype.ReadRune end; end __f._r = _r; __f._tuple = _tuple; __f.err = err; __f.r = r; __f.s = s; __f.size = size; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ss.prototype.ReadRune = function() return this.__val.ReadRune(); end;
	ss.ptr.prototype.Width = function()
		var _tmp, _tmp__1, _tmp__2, _tmp__3, ok, s, wid;
		wid = 0;
		ok = false;
		s = this;
		if (s.ssave.maxWid == 1073741824) {
			_tmp = 0;
			_tmp__1 = false;
			wid = _tmp;
			ok = _tmp__1;
			return [wid, ok];
		end
		_tmp__2 = s.ssave.maxWid;
		_tmp__3 = true;
		wid = _tmp__2;
		ok = _tmp__3;
		return [wid, ok];
	end;
	ss.prototype.Width = function() return this.__val.Width(); end;
	ss.ptr.prototype.getRune = function()
		var _r, _tuple, err, r, s, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _tuple = __f._tuple; err = __f.err; r = __f.r; s = __f.s; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		r = 0;
		s = this;
		_r = s.ReadRune(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_tuple = _r;
		r = _tuple[0];
		err = _tuple[2];
		if ( not (__interfaceIsEqual(err, __ifaceNil))) {
			if (__interfaceIsEqual(err, io.EOF)) {
				r = -1;
				__s = -1; return r;
			end
			s.error(err);
		end
		__s = -1; return r;
		/* */ end return; end if __f == nil then  __f = { __blk: ss.ptr.prototype.getRune end; end __f._r = _r; __f._tuple = _tuple; __f.err = err; __f.r = r; __f.s = s; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ss.prototype.getRune = function() return this.__val.getRune(); end;
	ss.ptr.prototype.UnreadRune = function()
		var _r, s, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; s = __f.s; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		s = this;
		_r = s.rs.UnreadRune(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r;
		s.atEOF = false;
		s.count = s.count - (1) >> 0;
		__s = -1; return __ifaceNil;
		/* */ end return; end if __f == nil then  __f = { __blk: ss.ptr.prototype.UnreadRune end; end __f._r = _r; __f.s = s; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ss.prototype.UnreadRune = function() return this.__val.UnreadRune(); end;
	ss.ptr.prototype.error = function(r)
		var err, s, x;
		s = this;
		__panic((x = new scanError.ptr(err), new x.constructor.elem(x)));
	end;
	ss.prototype.error = function(r) return this.__val.error(err); end;
	ss.ptr.prototype.errorString = function(r)
		var err, s, x;
		s = this;
		__panic((x = new scanError.ptr(errors.New(err)), new x.constructor.elem(x)));
	end;
	ss.prototype.errorString = function(r) return this.__val.errorString(err); end;
	ss.ptr.prototype.Token = function(f)
		var _r, err, f, s, skipSpace, tok, __s, __deferred, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; err = __f.err; f = __f.f; s = __f.s; skipSpace = __f.skipSpace; tok = __f.tok; __s = __f.__s; __deferred = __f.__deferred; __r = __f.__r; end var __err = null; try { s: while (true) { switch (__s) { case 0: __deferred = []; __deferred.index = __curGoroutine.deferStack.length; __curGoroutine.deferStack.push(__deferred);
		err = [err];
		tok = sliceType__2.nil;
		err[0] = __ifaceNil;
		s = this;
		__deferred.push([(function(r) return function()
			var _tuple, e, ok, se;
			e = __recover();
			if ( not (__interfaceIsEqual(e, __ifaceNil))) {
				_tuple = __assertType(e, scanError, true);
				se = __clone(_tuple[0], scanError);
				ok = _tuple[1];
				if (ok) {
					err[0] = se.err;
				end else {
					__panic(e);
				end
			end
		end; end)(err), []]);
		if (f == __throwNilPointerError) {
			f = notSpace;
		end
		s.buf = __subslice(s.buf, 0, 0);
		_r = s.token(skipSpace, f); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		tok = _r;
		__s = -1; return [tok, err[0]];
		/* */ end return; end end catch(err) { __err = err; __s = -1; end finally { __callDeferred(__deferred, __err); if ( not __curGoroutine.asleep) then return  [tok, err[0]]; end if(__curGoroutine.asleep) { if __f == nil then  __f = { __blk: ss.ptr.prototype.Token end; end __f._r = _r; __f.err = err; __f.f = f; __f.s = s; __f.skipSpace = skipSpace; __f.tok = tok; __f.__s = __s; __f.__deferred = __deferred; __f.__r = __r; return __f; end end
	end;
	ss.prototype.Token = function(f) return this.__val.Token(skipSpace, f); end;
	isSpace = function(r)
		var _i, _ref, r, rng, rx;
		if (r >= 65536) {
			return false;
		end
		rx = ((r << 16 >>> 16));
		_ref = space;
		_i = 0;
		while (true) {
			if ( not (_i < _ref.__length)) { break; end
			rng = __clone(((_i < 0  or  _i >= _ref.__length) ? (__throwRuntimeError("index out of range"), nil) : _ref.__array[_ref.__offset + _i]), arrayType__1);
			if (rx < rng[0]) {
				return false;
			end
			if (rx <= rng[1]) {
				return true;
			end
			_i++;
		end
		return false;
	end;
	notSpace = function(r)
		var r;
		return  not isSpace(r);
	end;
	ss.ptr.prototype.SkipSpace = function()
		var s, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; s = __f.s; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		s = this;
		__r = s.skipSpace(false); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: ss.ptr.prototype.SkipSpace end; end __f.s = s; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ss.prototype.SkipSpace = function() return this.__val.SkipSpace(); end;
	ss.ptr.prototype.free = function(d)
		var old, s;
		s = this;
		if (old.validSave) {
			ssave.copy(s.ssave, old);
			return;
		end
		if (s.buf.__capacity > 1024) {
			return;
		end
		s.buf = __subslice(s.buf, 0, 0);
		s.rs = __ifaceNil;
		ssFree.Put(s);
	end;
	ss.prototype.free = function(d) return this.__val.free(old); end;
	ss.ptr.prototype.skipSpace = function(e)
		var _r, _r__1, _r__2, _v, r, s, stopAtNewline, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; _v = __f._v; r = __f.r; s = __f.s; stopAtNewline = __f.stopAtNewline; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		s = this;
		/* while (true) { */ case 1:
			_r = s.getRune(); /* */ __s = 3; case 3: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			r = _r;
			if (r == -1) {
				__s = -1; return;
			end
			if ( not (r == 13)) { _v = false; __s = 6; continue s; end
			_r__1 = s.peek("\n"); /* */ __s = 7; case 7: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			_v = _r__1; case 6:
			/* */ if (_v) { __s = 4; continue; end
			/* */ __s = 5; continue;
			/* if (_v) { */ case 4:
				/* continue; */ __s = 1; continue;
			/* end */ case 5:
			/* */ if (r == 10) { __s = 8; continue; end
			/* */ __s = 9; continue;
			/* if (r == 10) { */ case 8:
				if (stopAtNewline) {
					/* break; */ __s = 2; continue;
				end
				if (s.ssave.nlIsSpace) {
					/* continue; */ __s = 1; continue;
				end
				s.errorString("unexpected newline");
				__s = -1; return;
			/* end */ case 9:
			/* */ if ( not isSpace(r)) { __s = 10; continue; end
			/* */ __s = 11; continue;
			/* if ( not isSpace(r)) { */ case 10:
				_r__2 = s.UnreadRune(); /* */ __s = 12; case 12: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				_r__2;
				/* break; */ __s = 2; continue;
			/* end */ case 11:
		/* end */ __s = 1; continue; case 2:
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: ss.ptr.prototype.skipSpace end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f._v = _v; __f.r = r; __f.s = s; __f.stopAtNewline = stopAtNewline; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ss.prototype.skipSpace = function(e) return this.__val.skipSpace(stopAtNewline); end;
	ss.ptr.prototype.token = function(f)
		var _r, _r__1, _r__2, f, r, s, skipSpace, x, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; _r__2 = __f._r__2; f = __f.f; r = __f.r; s = __f.s; skipSpace = __f.skipSpace; x = __f.x; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		s = this;
		/* */ if (skipSpace) { __s = 1; continue; end
		/* */ __s = 2; continue;
		/* if (skipSpace) { */ case 1:
			__r = s.skipSpace(false); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* end */ case 2:
		/* while (true) { */ case 4:
			_r = s.getRune(); /* */ __s = 6; case 6: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
			r = _r;
			if (r == -1) {
				/* break; */ __s = 5; continue;
			end
			_r__1 = f(r); /* */ __s = 9; case 9: if(__c) then __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			/* */ if ( not _r__1) { __s = 7; continue; end
			/* */ __s = 8; continue;
			/* if ( not _r__1) { */ case 7:
				_r__2 = s.UnreadRune(); /* */ __s = 10; case 10: if(__c) then __c = false; _r__2 = _r__2.__blk(); end if _r__2  and  _r__2.__blk ~= nil then break s; end
				_r__2;
				/* break; */ __s = 5; continue;
			/* end */ case 8:
			(s.__ptr_buf  or  (s.__ptr_buf = new ptrType__1(function() return this.__target.buf; end, function(v) this.__target.buf = __v; end, s))).WriteRune(r);
		/* end */ __s = 4; continue; case 5:
		__s = -1; return (x = s.buf, __subslice(new sliceType__2(x.__array), x.__offset, x.__offset + x.__length));
		/* */ end return; end if __f == nil then  __f = { __blk: ss.ptr.prototype.token end; end __f._r = _r; __f._r__1 = _r__1; __f._r__2 = _r__2; __f.f = f; __f.r = r; __f.s = s; __f.skipSpace = skipSpace; __f.x = x; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ss.prototype.token = function(f) return this.__val.token(skipSpace, f); end;
	indexRune = function(r)
		var _i, _ref, _rune, c, i, r, s;
		_ref = s;
		_i = 0;
		while (true) {
			if not (_i < #_ref) then break; end
			_rune = __decodeRune(_ref, _i);
			i = _i;
			c = _rune[0];
			if (c == r) {
				return i;
			end
			_i += _rune[1];
		end
		return -1;
	end;
	ss.ptr.prototype.peek = function(k)
		var _r, _r__1, ok, r, s, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; _r__1 = __f._r__1; ok = __f.ok; r = __f.r; s = __f.s; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		s = this;
		_r = s.getRune(); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		r = _r;
		/* */ if ( not ((r == -1))) { __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if ( not ((r == -1))) { */ case 2:
			_r__1 = s.UnreadRune(); /* */ __s = 4; case 4: if(__c) then  __c = false; _r__1 = _r__1.__blk(); end if (_r__1  and  _r__1.__blk ~= nil) { break s; end
			_r__1;
		/* end */ case 3:
		__s = -1; return indexRune(ok, r) >= 0;
		/* */ end return; end if __f == nil then  __f = { __blk: ss.ptr.prototype.peek end; end __f._r = _r; __f._r__1 = _r__1; __f.ok = ok; __f.r = r; __f.s = s; __f.__s = __s; __f.__r = __r; return __f;
	end;
	ss.prototype.peek = function(k) return this.__val.peek(ok); end;
	ptrType__25.methods = [{prop: "clearflags", name: "clearflags", pkg: "fmt", typ: __funcType([], [], false)end, {prop: "init", name: "init", pkg: "fmt", typ: __funcType([ptrType__1], [], false)end, {prop: "writePadding", name: "writePadding", pkg: "fmt", typ: __funcType([__Int], [], false)end, {prop: "pad", name: "pad", pkg: "fmt", typ: __funcType([sliceType__2], [], false)end, {prop: "padString", name: "padString", pkg: "fmt", typ: __funcType([__String], [], false)end, {prop: "fmt_boolean", name: "fmt_boolean", pkg: "fmt", typ: __funcType([__Bool], [], false)end, {prop: "fmt_unicode", name: "fmt_unicode", pkg: "fmt", typ: __funcType([__Uint64], [], false)end, {prop: "fmt_integer", name: "fmt_integer", pkg: "fmt", typ: __funcType([__Uint64, __Int, __Bool, __String], [], false)end, {prop: "truncate", name: "truncate", pkg: "fmt", typ: __funcType([__String], [__String], false)end, {prop: "fmt_s", name: "fmt_s", pkg: "fmt", typ: __funcType([__String], [], false)end, {prop: "fmt_sbx", name: "fmt_sbx", pkg: "fmt", typ: __funcType([__String, sliceType__2, __String], [], false)end, {prop: "fmt_sx", name: "fmt_sx", pkg: "fmt", typ: __funcType([__String, __String], [], false)end, {prop: "fmt_bx", name: "fmt_bx", pkg: "fmt", typ: __funcType([sliceType__2, __String], [], false)end, {prop: "fmt_q", name: "fmt_q", pkg: "fmt", typ: __funcType([__String], [], false)end, {prop: "fmt_c", name: "fmt_c", pkg: "fmt", typ: __funcType([__Uint64], [], false)end, {prop: "fmt_qc", name: "fmt_qc", pkg: "fmt", typ: __funcType([__Uint64], [], false)end, {prop: "fmt_float", name: "fmt_float", pkg: "fmt", typ: __funcType([__Float64, __Int, __Int32, __Int], [], false)end];
	ptrType__1.methods = [{prop: "Write", name: "Write", pkg: "", typ: __funcType([sliceType__2], [], false)end, {prop: "WriteString", name: "WriteString", pkg: "", typ: __funcType([__String], [], false)end, {prop: "WriteByte", name: "WriteByte", pkg: "", typ: __funcType([__Uint8], [], false)end, {prop: "WriteRune", name: "WriteRune", pkg: "", typ: __funcType([__Int32], [], false)end];
	ptrType__2.methods = [{prop: "free", name: "free", pkg: "fmt", typ: __funcType([], [], false)end, {prop: "Width", name: "Width", pkg: "", typ: __funcType([], [__Int, __Bool], false)end, {prop: "Precision", name: "Precision", pkg: "", typ: __funcType([], [__Int, __Bool], false)end, {prop: "Flag", name: "Flag", pkg: "", typ: __funcType([__Int], [__Bool], false)end, {prop: "Write", name: "Write", pkg: "", typ: __funcType([sliceType__2], [__Int, __error], false)end, {prop: "unknownType", name: "unknownType", pkg: "fmt", typ: __funcType([reflect.Value], [], false)end, {prop: "badVerb", name: "badVerb", pkg: "fmt", typ: __funcType([__Int32], [], false)end, {prop: "fmtBool", name: "fmtBool", pkg: "fmt", typ: __funcType([__Bool, __Int32], [], false)end, {prop: "fmt0x64", name: "fmt0x64", pkg: "fmt", typ: __funcType([__Uint64, __Bool], [], false)end, {prop: "fmtInteger", name: "fmtInteger", pkg: "fmt", typ: __funcType([__Uint64, __Bool, __Int32], [], false)end, {prop: "fmtFloat", name: "fmtFloat", pkg: "fmt", typ: __funcType([__Float64, __Int, __Int32], [], false)end, {prop: "fmtComplex", name: "fmtComplex", pkg: "fmt", typ: __funcType([__Complex128, __Int, __Int32], [], false)end, {prop: "fmtString", name: "fmtString", pkg: "fmt", typ: __funcType([__String, __Int32], [], false)end, {prop: "fmtBytes", name: "fmtBytes", pkg: "fmt", typ: __funcType([sliceType__2, __Int32, __String], [], false)end, {prop: "fmtPointer", name: "fmtPointer", pkg: "fmt", typ: __funcType([reflect.Value, __Int32], [], false)end, {prop: "catchPanic", name: "catchPanic", pkg: "fmt", typ: __funcType([__emptyInterface, __Int32], [], false)end, {prop: "handleMethods", name: "handleMethods", pkg: "fmt", typ: __funcType([__Int32], [__Bool], false)end, {prop: "printArg", name: "printArg", pkg: "fmt", typ: __funcType([__emptyInterface, __Int32], [], false)end, {prop: "printValue", name: "printValue", pkg: "fmt", typ: __funcType([reflect.Value, __Int32, __Int], [], false)end, {prop: "argNumber", name: "argNumber", pkg: "fmt", typ: __funcType([__Int, __String, __Int, __Int], [__Int, __Int, __Bool], false)end, {prop: "badArgNum", name: "badArgNum", pkg: "fmt", typ: __funcType([__Int32], [], false)end, {prop: "missingArg", name: "missingArg", pkg: "fmt", typ: __funcType([__Int32], [], false)end, {prop: "doPrintf", name: "doPrintf", pkg: "fmt", typ: __funcType([__String, sliceType], [], false)end, {prop: "doPrint", name: "doPrint", pkg: "fmt", typ: __funcType([sliceType], [], false)end, {prop: "doPrintln", name: "doPrintln", pkg: "fmt", typ: __funcType([sliceType], [], false)end];
	ptrType__5.methods = [{prop: "Read", name: "Read", pkg: "", typ: __funcType([sliceType__2], [__Int, __error], false)end, {prop: "ReadRune", name: "ReadRune", pkg: "", typ: __funcType([], [__Int32, __Int, __error], false)end, {prop: "Width", name: "Width", pkg: "", typ: __funcType([], [__Int, __Bool], false)end, {prop: "getRune", name: "getRune", pkg: "fmt", typ: __funcType([], [__Int32], false)end, {prop: "mustReadRune", name: "mustReadRune", pkg: "fmt", typ: __funcType([], [__Int32], false)end, {prop: "UnreadRune", name: "UnreadRune", pkg: "", typ: __funcType([], [__error], false)end, {prop: "error", name: "error", pkg: "fmt", typ: __funcType([__error], [], false)end, {prop: "errorString", name: "errorString", pkg: "fmt", typ: __funcType([__String], [], false)end, {prop: "Token", name: "Token", pkg: "", typ: __funcType([__Bool, funcType], [sliceType__2, __error], false)end, {prop: "SkipSpace", name: "SkipSpace", pkg: "", typ: __funcType([], [], false)end, {prop: "free", name: "free", pkg: "fmt", typ: __funcType([ssave], [], false)end, {prop: "skipSpace", name: "skipSpace", pkg: "fmt", typ: __funcType([__Bool], [], false)end, {prop: "token", name: "token", pkg: "fmt", typ: __funcType([__Bool, funcType], [sliceType__2], false)end, {prop: "consume", name: "consume", pkg: "fmt", typ: __funcType([__String, __Bool], [__Bool], false)end, {prop: "peek", name: "peek", pkg: "fmt", typ: __funcType([__String], [__Bool], false)end, {prop: "notEOF", name: "notEOF", pkg: "fmt", typ: __funcType([], [], false)end, {prop: "accept", name: "accept", pkg: "fmt", typ: __funcType([__String], [__Bool], false)end, {prop: "okVerb", name: "okVerb", pkg: "fmt", typ: __funcType([__Int32, __String, __String], [__Bool], false)end, {prop: "scanBool", name: "scanBool", pkg: "fmt", typ: __funcType([__Int32], [__Bool], false)end, {prop: "getBase", name: "getBase", pkg: "fmt", typ: __funcType([__Int32], [__Int, __String], false)end, {prop: "scanNumber", name: "scanNumber", pkg: "fmt", typ: __funcType([__String, __Bool], [__String], false)end, {prop: "scanRune", name: "scanRune", pkg: "fmt", typ: __funcType([__Int], [__Int64], false)end, {prop: "scanBasePrefix", name: "scanBasePrefix", pkg: "fmt", typ: __funcType([], [__Int, __String, __Bool], false)end, {prop: "scanInt", name: "scanInt", pkg: "fmt", typ: __funcType([__Int32, __Int], [__Int64], false)end, {prop: "scanUint", name: "scanUint", pkg: "fmt", typ: __funcType([__Int32, __Int], [__Uint64], false)end, {prop: "floatToken", name: "floatToken", pkg: "fmt", typ: __funcType([], [__String], false)end, {prop: "complexTokens", name: "complexTokens", pkg: "fmt", typ: __funcType([], [__String, __String], false)end, {prop: "convertFloat", name: "convertFloat", pkg: "fmt", typ: __funcType([__String, __Int], [__Float64], false)end, {prop: "scanComplex", name: "scanComplex", pkg: "fmt", typ: __funcType([__Int32, __Int], [__Complex128], false)end, {prop: "convertString", name: "convertString", pkg: "fmt", typ: __funcType([__Int32], [__String], false)end, {prop: "quotedString", name: "quotedString", pkg: "fmt", typ: __funcType([], [__String], false)end, {prop: "hexByte", name: "hexByte", pkg: "fmt", typ: __funcType([], [__Uint8, __Bool], false)end, {prop: "hexString", name: "hexString", pkg: "fmt", typ: __funcType([], [__String], false)end, {prop: "scanOne", name: "scanOne", pkg: "fmt", typ: __funcType([__Int32, __emptyInterface], [], false)end, {prop: "doScan", name: "doScan", pkg: "fmt", typ: __funcType([sliceType], [__Int, __error], false)end, {prop: "advance", name: "advance", pkg: "fmt", typ: __funcType([__String], [__Int], false)end, {prop: "doScanf", name: "doScanf", pkg: "fmt", typ: __funcType([__String, sliceType], [__Int, __error], false)end];
	fmtFlags.init("fmt", [{prop: "widPresent", name: "widPresent", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "precPresent", name: "precPresent", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "minus", name: "minus", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "plus", name: "plus", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "sharp", name: "sharp", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "space", name: "space", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "zero", name: "zero", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "plusV", name: "plusV", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "sharpV", name: "sharpV", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	fmt.init("fmt", [{prop: "buf", name: "buf", anonymous: false, exported: false, typ: ptrType__1, tag: ""end, {prop: "fmtFlags", name: "fmtFlags", anonymous: true, exported: false, typ: fmtFlags, tag: ""end, {prop: "wid", name: "wid", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "prec", name: "prec", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "intbuf", name: "intbuf", anonymous: false, exported: false, typ: arrayType, tag: ""end]);
	State.init([{prop: "Flag", name: "Flag", pkg: "", typ: __funcType([__Int], [__Bool], false)end, {prop: "Precision", name: "Precision", pkg: "", typ: __funcType([], [__Int, __Bool], false)end, {prop: "Width", name: "Width", pkg: "", typ: __funcType([], [__Int, __Bool], false)end, {prop: "Write", name: "Write", pkg: "", typ: __funcType([sliceType__2], [__Int, __error], false)end]);
	Formatter.init([{prop: "Format", name: "Format", pkg: "", typ: __funcType([State, __Int32], [], false)end]);
	Stringer.init([{prop: "String", name: "String", pkg: "", typ: __funcType([], [__String], false)end]);
	GoStringer.init([{prop: "GoString", name: "GoString", pkg: "", typ: __funcType([], [__String], false)end]);
	buffer.init(__Uint8);
	pp.init("fmt", [{prop: "buf", name: "buf", anonymous: false, exported: false, typ: buffer, tag: ""end, {prop: "arg", name: "arg", anonymous: false, exported: false, typ: __emptyInterface, tag: ""end, {prop: "value", name: "value", anonymous: false, exported: false, typ: reflect.Value, tag: ""end, {prop: "fmt", name: "fmt", anonymous: false, exported: false, typ: fmt, tag: ""end, {prop: "reordered", name: "reordered", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "goodArgNum", name: "goodArgNum", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "panicking", name: "panicking", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "erroring", name: "erroring", anonymous: false, exported: false, typ: __Bool, tag: ""end]);
	scanError.init("fmt", [{prop: "err", name: "err", anonymous: false, exported: false, typ: __error, tag: ""end]);
	ss.init("fmt", [{prop: "rs", name: "rs", anonymous: false, exported: false, typ: io.RuneScanner, tag: ""end, {prop: "buf", name: "buf", anonymous: false, exported: false, typ: buffer, tag: ""end, {prop: "count", name: "count", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "atEOF", name: "atEOF", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "ssave", name: "ssave", anonymous: true, exported: false, typ: ssave, tag: ""end]);
	ssave.init("fmt", [{prop: "validSave", name: "validSave", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "nlIsEnd", name: "nlIsEnd", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "nlIsSpace", name: "nlIsSpace", anonymous: false, exported: false, typ: __Bool, tag: ""end, {prop: "argLimit", name: "argLimit", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "limit", name: "limit", anonymous: false, exported: false, typ: __Int, tag: ""end, {prop: "maxWid", name: "maxWid", anonymous: false, exported: false, typ: __Int, tag: ""end]);
	__init = function()
		__pkg.__init = function()end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = errors.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = io.__init(); /* */ __s = 2; case 2: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = math.__init(); /* */ __s = 3; case 3: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = os.__init(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = reflect.__init(); /* */ __s = 5; case 5: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = strconv.__init(); /* */ __s = 6; case 6: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = sync.__init(); /* */ __s = 7; case 7: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		__r = utf8.__init(); /* */ __s = 8; case 8: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		ppFree = new sync.Pool.ptr(0, 0, sliceType.nil, (function()
			return new pp.ptr(buffer.nil, __ifaceNil, new reflect.Value.ptr(ptrType.nil, 0, 0), new fmt.ptr(ptrType__1.nil, new fmtFlags.ptr(false, false, false, false, false, false, false, false, false), 0, 0, arrayType.zero()), false, false, false, false);
		end));
		space = new sliceType__1([__toNativeArray(__kindUint16, [9, 13]), __toNativeArray(__kindUint16, [32, 32]), __toNativeArray(__kindUint16, [133, 133]), __toNativeArray(__kindUint16, [160, 160]), __toNativeArray(__kindUint16, [5760, 5760]), __toNativeArray(__kindUint16, [8192, 8202]), __toNativeArray(__kindUint16, [8232, 8233]), __toNativeArray(__kindUint16, [8239, 8239]), __toNativeArray(__kindUint16, [8287, 8287]), __toNativeArray(__kindUint16, [12288, 12288])]);
		ssFree = new sync.Pool.ptr(0, 0, sliceType.nil, (function()
			return new ss.ptr(__ifaceNil, buffer.nil, 0, false, new ssave.ptr(false, false, false, 0, 0, 0));
		end));
		complexError = errors.New("syntax error scanning complex number");
		boolError = errors.New("syntax error scanning boolean");
		/* */ end return; end if __f == nil then  __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__packages["github.com/gijit/gi/pkg/compiler/tmp"] = (function()
	var __pkg = {}, __init, fmt, sliceType, main;
	fmt = __packages["fmt"];
	sliceType = __sliceType(__emptyInterface);
	main = function()
		var _r, a, b, c, __s, __r;
		/* */ __s = 0; var __f, __c = false; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; _r = __f._r; a = __f.a; b = __f.b; c = __f.c; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		a = 1;
		b = 2;
		c = ((a + b >> 0));
		_r = fmt.Printf("c=%v\n", new sliceType([new __Float64(c)])); /* */ __s = 1; case 1: if(__c) then __c = false; _r = _r.__blk(); end if (_r  and  _r.__blk ~= nil) then  break s; end
		_r;
		__s = -1; return;
		/* */ end return; end if __f == nil then  __f = { __blk: main end; end __f._r = _r; __f.a = a; __f.b = b; __f.c = c; __f.__s = __s; __f.__r = __r; return __f;
	end;
	__init = function()
		__pkg.__init = function() end;
		/* */ var __f, __c = false, __s = 0, __r; if this ~= nil and this.__blk ~= nil then  __f = this; __c = true; __s = __f.__s; __r = __f.__r; end s: while (true) { switch (__s) { case 0:
		__r = fmt.__init(); /* */ __s = 1; case 1: if(__c) then __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
		/* */ if __pkg == __mainPkg then  __s = 2; continue; end
		/* */ __s = 3; continue;
		/* if __pkg == __mainPkg then  */ case 2:
			__r = main(); /* */ __s = 4; case 4: if(__c) then  __c = false; __r = __r.__blk(); end if __r  and __r.__blk ~= nil then  break s; end
			__mainFinished = true;
		/* end */ case 3:
		/* */ end return; end if (__f == nil) then __f = { __blk: __init end; end __f.__s = __s; __f.__r = __r; return __f;
	end;
	__pkg.__init = __init;
	return __pkg;
end)();
__synthesizeMethods();
var __mainPkg = __packages["github.com/gijit/gi/pkg/compiler/tmp"];
__packages["runtime"].__init();
__go(__mainPkg.__init, []);
__flushConsole();

