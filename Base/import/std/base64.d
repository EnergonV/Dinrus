﻿module std.base64;

	extern(D)
	{

	бцел кодируйДлину64(бцел сдлин);
	ткст кодируй64(ткст стр, ткст буф = ткст.init);
	бцел раскодируйДлину64(бцел кдлин);
	ткст раскодируй64(ткст кстр, ткст буф = ткст.init);

	alias кодируйДлину64 encodeLength;
	alias кодируй64 encode;
	alias раскодируйДлину64 decodeLength;
	alias раскодируй64 decode;
    }



