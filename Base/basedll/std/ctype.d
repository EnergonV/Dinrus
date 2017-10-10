﻿module std.ctype;

import std.ctype;


 const dchar[66] РУСАЛФ =['а','б','в','г','д','е','ё','ж','з','и','й','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я','А','Б','В','Г','Д','Е','Ё','Ж','З','И','Й','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ъ','Ы','Ь','Э','Ю','Я'];

 const ubyte[66] РУСАЛФб =cast(ubyte[])['а','б','в','г','д','е','ё','ж','з','и','й','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я','А','Б','В','Г','Д','Е','Ё','Ж','З','И','Й','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ъ','Ы','Ь','Э','Ю','Я'];

 юткст[33] РУСн = [\U00000430,\U00000431,\U00000432,\U00000233,\U00000434,\U00000435,\U00000451,\U00000436,\U00000437,\U00000438,\U00000439,\U0000043a,\U0000043b,\U0000043c,\U0000043d,\U0000043e,\U0000043f,\U00000440,\U00000441,\U00000442,\U00000443,\U00000444,\U00000445,\U00000446,\U00000447,\U00000448,\U00000449,\U0000044a,\U0000044b,\U0000044c,\U0000044d,\U0000044e,\U0000044f];

 юткст[33] РУСв = [\U00000410,\U00000411,\U00000412,\U00000413,\U00000414,\U00000415,\U00000401,\U00000416,\U00000417,\U00000418,\U00000419,\U0000041a,\U0000041b,\U0000041c,\U0000041d,\U0000041e,\U0000041f,\U00000420,\U00000421,\U00000422,\U00000423,\U00000424,\U00000425,\U00000426,\U00000427,\U00000428,\U00000429,\U0000042a,\U0000042b,\U0000042c,\U0000042d,\U0000042e,\U0000042f];


export extern(D)
{

	цел числобукв(дим б){return isalnum(б);}
	цел буква(дим б){return  isalpha(б);}
	цел управ(дим б){return iscntrl(б);}
	цел цифра(дим б){return isdigit(б);}
	цел проп(дим б){return islower(б);}
	цел пунктзнак(дим б){return  ispunct(б);}
	цел межбукв(дим б){return isspace(б);}
	цел заг(дим б){return isupper(б);}
	цел цифраикс(дим б){return isxdigit(б);}
	цел граф(дим б){return  isgraph(б);}
	цел печат(дим б) {return  isprint(б);}
	цел аски(дим б){return  isascii(б);}
	дим впроп(дим б){return  tolower(б);}
	дим взаг(дим б){return toupper(б);}

 бул пробел(сим c) {
  return c == ' ' || c == '\t' || c == '\r' || c == '\n';
}

бул цифра(сим c) {
  return c >= '0' && c <= '9';
}

бул цифра8(сим c) {
  return c >= '0' && c <= '7';
}

бул цифра16(сим c) {
  return цифра(c) || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f');
}

 бул рус(дим б)
 {
  юткст м_б =[б];
  switch(м_б)
 {
 case "а","б","в","г","д","е","ё","ж","з","и","й","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","ъ","ы","ь","э","ю","я","А","Б","В","Г","Д","Е","Ё","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я": return true;
 default:
 }
  return false;
 }

 цел проверьРус(дим б)
 {
	 юткст м_б =[б];
	 switch(м_б)
	 {
	 case "а","б","в","г","д","е","ё","ж","з","и","й","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","ъ","ы","ь","э","ю","я":
	 return _БНР;
	 case "А","Б","В","Г","Д","Е","Ё","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я":
	 return _БВР;
	 default:
	}
  return 0;
}

цел руспроп(дим б) 
 { return (б <= 'я' &&  б >='а' || б == 'ё'); }
 
цел русзаг(дим б)
  { return (б <=  'Я' && б >= 'А' || б == 'Ё') ; }

}

////////////////////////////////////////////////////////////////////
/**
 * Возвращает !=0, если б является буквой в диапазоне (0..9, a..z, A..Z, а..я, А..Я).
 */
int isalnum(dchar б)
  {
  цел рез;
  рез =	(б <= 0x7F) ? _ctype[б] & (_БУКВ|_ЦИФР) : 0;
  if(рус(б)) рез = проверьРус(б)& (_БУКВ|_ЦИФР);
  return рез;
 }
цел числобукв_ли(дим б){return isalnum(б);}
/**
 * Returns !=0 if б is an ascii upper or lower case letter.
 */
int isalpha(dchar б)  {
цел рез;
  рез =	(б <= 0x7F) ? _ctype[б] & (_БУКВ): 0;
  if(рус(б)) рез = проверьРус(б) & (_БУКВ); 
 return рез;
 }
цел буква_ли(дим б){return  isalpha(б);}
/**
 * Returns !=0 if б is a control character.
 */
int iscntrl(dchar б)
  { 
  цел рез;
  рез = (б <= 0x7F) ? _ctype[б] & (_КТРЛ)      : 0;
  if(рус(б)) рез = проверьРус(б)& (_КТРЛ);  
 return рез;  
  }
цел управ_ли(дим б){return iscntrl(б);}
/**
 * Returns !=0 if б is a digit.
 */
int isdigit(dchar б)  {
 цел рез;
  рез = (б <= 0x7F) ? _ctype[б] & (_ЦИФР): 0;
	if(рус(б)) рез = проверьРус(б)& (_ЦИФР);
 return рез;
 }
цел цифра_ли(дим б){return isdigit(б);}
/**
 * Returns !=0 if б is lower case ascii letter.
 */
int islower(dchar б)  { 
цел рез;
  рез = (б <= 0x7F) ? _ctype[б] & (_БНР) : 0;
if(рус(б)) рез = проверьРус(б)& (_БНР);
 return рез;
  }
цел проп_ли(дим б){return islower(б);}
/**
 * Returns !=0 if б is a punctuation character.
 */
int ispunct(dchar б)  {
цел рез;
  рез = (б <= 0x7F) ? _ctype[б] & (_ПУНКТ)      : 0;
  if(рус(б)) рез = проверьРус(б)&(_ПУНКТ);
 return рез;
 }
цел пунктзнак_ли(дим б){return  ispunct(б);}
/**
 * Returns !=0 if б is a space, tab, vertical tab, form feed,
 * carriage return, or linefeed.
 */
int isspace(dchar б)  {
цел рез;
  рез = (б <= 0x7F) ? _ctype[б] & (_ПБЕЛ)      : 0;
    if(рус(б)) рез = проверьРус(б)&(_ПБЕЛ);
 return рез;
 }
цел межбукв_ли(дим б){return isspace(б);}
/**
 * Returns !=0 if б is an upper case ascii character.
 */
int isupper(dchar б)  {
цел рез;
  рез = (б <= 0x7F) ? _ctype[б] & (_БВР)       : 0;
if(рус(б)) рез = проверьРус(б)&(_БВР);
 return рез;
 }
цел заг_ли(дим б){return isupper(б);}
/**
 * Returns !=0 if б is a hex digit (0..9, a..f, A..F).
 */
int isxdigit(dchar б) {
цел рез;
  рез = (б <= 0x7F) ? _ctype[б] & (_ГЕКС)      : 0; 
 if(рус(б)) рез = проверьРус(б)&(_ГЕКС);
 return рез;
 }
цел цифраикс_ли(дим б){return isxdigit(б);}
/**
 * Returns !=0 if б is a printing character except for the space character.
 */
int isgraph(dchar б)  {
цел рез;
  рез =(б <= 0x7F) ? _ctype[б] & (_БУКВ|_ЦИФР|_ПУНКТ) : 0;
   if(рус(б)) рез = проверьРус(б)&(_БУКВ|_ЦИФР|_ПУНКТ);
 return рез;
 }
цел граф_ли(дим б){return  isgraph(б);}
/**
 * Returns !=0 if б is a printing character including the space character.
 */
int isprint(dchar б)
  {
 цел рез;
  рез =(б <= 0x7F) ? _ctype[б] & (_БУКВ|_ЦИФР|_ПУНКТ|_БЛК) : 0;
     if(рус(б)) рез = проверьРус(б)&(_БУКВ|_ЦИФР|_ПУНКТ|_БЛК);
 return рез;
  }
цел печат_ли(дим б) {return  isprint(б);}
/**
 * Returns !=0 if б is in the ascii character set, i.e. in the range 0..0x7F.
 */
int isascii(dchar б)  { return б <= 0x7F; }
цел аски_ли(дим б){return  isascii(б);}

/**
 * If б is an upper case ascii character,
 * return the lower case equivalent, otherwise return б.
 */
dchar tolower(dchar б)
    out (результат)
    {
	assert(!isupper(результат));
    }
    body
    {
	return isupper(б) ? б + (cast(dchar)'a' - 'A') : б;
    }

дим впроп(дим б){return  tolower(б);}

/**
 * If б is a lower case ascii character,
 * return the upper case equivalent, otherwise return б.
 */
dchar toupper(dchar б)
    out (результат)
    {
	assert(!islower(результат));
    }
    body
    {
	return islower(б) ? б - (cast(dchar)'a' - 'A') : б;
    }
дим взаг(дим б){return toupper(б);}

private:

enum
{
    _ПБЕЛ =	8,
    _КТРЛ =	0x20,
    _БЛК =	0x40,
    _ГЕКС =	0x80,
    _БВР  =	1,
    _БНР  =	2,
    _ПУНКТ =	0x10,
    _ЦИФР =	4,
    _БУКВ =	_БВР|_БНР,
}


ббайт _ctype[128] =
[
	_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,
	_КТРЛ,_КТРЛ|_ПБЕЛ,_КТРЛ|_ПБЕЛ,_КТРЛ|_ПБЕЛ,_КТРЛ|_ПБЕЛ,_КТРЛ|_ПБЕЛ,_КТРЛ,_КТРЛ,
	_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,
	_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,_КТРЛ,
	_ПБЕЛ|_БЛК,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,
	_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,
	_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,
	_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,_ЦИФР|_ГЕКС,
	_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,
	_ПУНКТ,_БВР|_ГЕКС,_БВР|_ГЕКС,_БВР|_ГЕКС,_БВР|_ГЕКС,_БВР|_ГЕКС,_БВР|_ГЕКС,_БВР,
	_БВР,_БВР,_БВР,_БВР,_БВР,_БВР,_БВР,_БВР,
	_БВР,_БВР,_БВР,_БВР,_БВР,_БВР,_БВР,_БВР,
	_БВР,_БВР,_БВР,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,
	_ПУНКТ,_БНР|_ГЕКС,_БНР|_ГЕКС,_БНР|_ГЕКС,_БНР|_ГЕКС,_БНР|_ГЕКС,_БНР|_ГЕКС,_БНР,
	_БНР,_БНР,_БНР,_БНР,_БНР,_БНР,_БНР,_БНР,
	_БНР,_БНР,_БНР,_БНР,_БНР,_БНР,_БНР,_БНР,
	_БНР,_БНР,_БНР,_ПУНКТ,_ПУНКТ,_ПУНКТ,_ПУНКТ,_КТРЛ
];


//////////////////////////////////////////////////////////////////////

unittest
{

ткст а = "а";
//шим Ан = РУСАЛФ[1];
	assert(а == \u0430);
	//assert(Ан == \U00000430);
	assert(числобукв_ли('а'));
	assert(числобукв_ли('б'));
	assert(числобукв_ли('в'));
	assert(числобукв_ли('г'));
	assert(числобукв_ли('д'));
	assert(числобукв_ли('е'));
	assert(числобукв_ли('D'));
	assert(числобукв_ли('ё'));
	assert(числобукв_ли('ж'));
	assert(числобукв_ли('з'));
	assert(числобукв_ли('и'));
	assert(числобукв_ли('й'));
	assert(числобукв_ли('к'));
	assert(числобукв_ли('л'));
	assert(числобукв_ли('м'));
	assert(числобукв_ли('н'));
	assert(числобукв_ли('о'));
	assert(числобукв_ли('п'));
	assert(числобукв_ли('р'));
	assert(числобукв_ли('с'));
	assert(числобукв_ли('т'));
	assert(числобукв_ли('у'));
	assert(числобукв_ли('ф'));
	assert(числобукв_ли('х'));
	assert(числобукв_ли('ц'));
	assert(числобукв_ли('ч'));
	assert(числобукв_ли('ш'));
	assert(числобукв_ли('щ'));
	assert(числобукв_ли('ъ'));
	assert(числобукв_ли('ы'));
	assert(числобукв_ли('ь'));
	assert(числобукв_ли('э'));
	assert(числобукв_ли('ю'));
	assert(числобукв_ли('я'));
	assert(числобукв_ли('А'));
	assert(числобукв_ли('Б'));
	assert(числобукв_ли('В'));
	assert(числобукв_ли('Г'));
	assert(числобукв_ли('Д'));
	assert(числобукв_ли('Е'));
	assert(числобукв_ли('Ё'));
	assert(числобукв_ли('Ж'));
	assert(числобукв_ли('З'));
	assert(числобукв_ли('И'));
	assert(числобукв_ли('Й'));
	assert(числобукв_ли('К'));
	assert(числобукв_ли('Л'));
	assert(числобукв_ли('М'));
	assert(числобукв_ли('Н'));
	assert(числобукв_ли('О'));
	assert(числобукв_ли('П'));
	assert(числобукв_ли('Р'));
	assert(числобукв_ли('С'));
	assert(числобукв_ли('Т'));
	assert(числобукв_ли('У'));
	assert(числобукв_ли('Ф'));
	assert(числобукв_ли('Х'));
	assert(числобукв_ли('Ц'));
	assert(числобукв_ли('Ч'));
	assert(числобукв_ли('Ш'));
	assert(числобукв_ли('Щ'));
	assert(числобукв_ли('Ъ'));
	assert(числобукв_ли('Ы'));
	assert(числобукв_ли('Ь'));
	assert(числобукв_ли('Э'));
	assert(числобукв_ли('Ю'));
	assert(буква_ли('Я'));
	assert(!управ_ли('Я'));
	assert(!управ_ли('ё'));
    assert(межбукв_ли(' '));
    assert(!межбукв_ли('z'));
	assert(!межбукв_ли('Ъ'));
    assert(взаг('a') == 'A');
	assert(взаг('м') == 'М');
    assert(впроп('Q') == 'q');
	assert(впроп('Ю') == 'ю');
    assert(!цифраикс_ли('G'));
	assert(руспроп_ли('ф'));
	assert(!цифраикс_ли('Ш'));
    assert(!руспроп_ли('z'));
	assert (русзаг_ли('П'));
	assert (русзаг_ли('Ё'));
	assert(!русзаг_ли('п'));
	assert (заг_ли('Ё'));
	эхо("!!!!!!!!!!");
}