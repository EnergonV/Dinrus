﻿module std.io;

extern(D):


	проц инфо(ткст сооб);
	ткст читайстр();
	т_мера читайстр(inout ткст буф);
	т_мера читайстр(фук чф, inout ткст буф);
	проц скажи(ткст ткт);
	проц скажинс(ткст ткт);
	проц скажи(бдол ткт);
	проц скажинс(бдол ткт);
	проц нс();
	проц таб();
	проц пишиф(...);
	проц пишифнс(...);
	проц скажифнс(...);
	проц скажиф(...);
	проц пишиф_в(cidrus.фук чф, ...);
	проц пишифнс_в(cidrus.фук чф, ...);
	бул выведиФайл(ткст имяф);
