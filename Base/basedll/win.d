﻿module win;

public  import sys.WinConsts, sys.WinIfaces, sys.WinStructs, sys.WinFuncs;//, io.Stdout;

///////////////////////////////////////////////
/*КОНСОЛЬ*/

public static
{
ук КОНСВВОД;
ук КОНСВЫВОД;
ук КОНСОШ;
бцел ИДПРОЦЕССА;
ук   УКНАПРОЦЕСС;
ук   УКНАНИТЬ;
}

const бцел винВерсия;

static this()
{
  винВерсия = ДайВерсию();
ИДПРОЦЕССА =  GetCurrentProcessId();
УКНАПРОЦЕСС = cast(ук) OpenProcess(0x000F0000|0x00100000|0x0FFF,false,ИДПРОЦЕССА);
УКНАНИТЬ  = GetCurrentThread();
			КОНСВВОД = ДайСтдДескр(ПСтд.Ввод);
			//КОНСВЫВОД = ДайСтдДескр(cast(ПСтд) 0xfffffff5);
			КОНСВЫВОД = ДайСтдДескр(ПСтд.Вывод);
			КОНСОШ = ДайСтдДескр(ПСтд.Ошибка);
}


/*******************************************************************************
        
        external functions

*******************************************************************************/

version (Windows) 
        {
        enum {UTF8 = 65001};
        extern (Windows) void* GetStdHandle (int);
        extern (Windows) int WriteFile (void*, char*, int, int*, void*);
        extern (Windows) bool GetConsoleMode (void*, int*);
        extern (Windows) bool WriteConsoleW (void*, wchar*, int, int*, void*);
        extern (Windows) int MultiByteToWideChar (int, int, char*, int, wchar*, int);
        } 
else 
version (Posix)
         extern (C) ptrdiff_t write (int, in void*, size_t);

		
// convert uint to char[], within the given buffer
// Returns a valid slice of the populated buffer
char[] intToUtf8 (char[] tmp, uint val)
in {
   assert (tmp.length > 9, "буфер intToUtf8 должен быть длиною более 9 символов");
   }
body
{
    char* p = tmp.ptr + tmp.length;

    do {
       *--p = cast(char)((val % 10) + '0');
       } while (val /= 10);

    return tmp [cast(size_t)(p - tmp.ptr) .. $];
}

// convert uint to char[], within the given buffer
// Returns a valid slice of the populated buffer
char[] ulongToUtf8 (char[] tmp, ulong val)
in {
   assert (tmp.length > 19, "буфер ulongToUtf8 должен быть длиною более 19 символов");
   }
body
{
    char* p = tmp.ptr + tmp.length;

    do {
       *--p = cast(char)((val % 10) + '0');
       } while (val /= 10);

    return tmp [cast(size_t)(p - tmp.ptr) .. $];
}


// function to compare two strings
int stringCompare (char[] s1, char[] s2)
{
    auto len = s1.length;

    if (s2.length < len)
        len = s2.length;

    int результат = memcmp(s1.ptr, s2.ptr, len);

    if (результат == 0)
        результат = (s1.length<s2.length)?-1:((s1.length==s2.length)?0:1);

    return результат;
}

/*******************************************************************************
        
        Emit an integer to the console

*******************************************************************************/

export extern (C) void consoleInteger (ulong i)
{
        char[25] tmp = void;

        consoleString (ulongToUtf8 (tmp, i));
}

/*******************************************************************************

        Emit a utf8 string to the console. Codepages are not supported

*******************************************************************************/

export extern (C) void consoleString (char[] s)
{
        version (Windows)
                {
                int  mode, count;
				//КОНСВЫВОД = ДайСтдДескр(cast(ПСтд) 0xfffffff5);
			     if (КОНСВЫВОД != НЕВЕРНХЭНДЛ && GetConsoleMode (КОНСВЫВОД, &mode))
                   {
                   wchar[1024 * 1] utf;
                   while (s.length)
                         {
                         // crop to last complete utf8 sequence
                         auto t = crop (s[0 .. (s.length > utf.length) ? utf.length : s.length]);

                         // convert into output buffer and emit
                         auto i = MultiByteToWideChar (UTF8, 0, s.ptr, t.length, utf.ptr, utf.length);
                         WriteConsoleW (КОНСВЫВОД, utf.ptr, i, &count, null);

                         // process next chunk
                         s = s [t.length .. $];
                         }
                   }
                else
                   // output is probably redirected (we assume utf8 output)
                   WriteFile (КОНСВЫВОД, s.ptr, s.length, &count, null);
                }

        version (Posix)
                 write (2, s.ptr, s.length);
}

export extern (C) void consoleErrString (char[] s)
{
        version (Windows)
                {
                int  mode, count;
				КОНСОШ = ДайСтдДескр(ПСтд.Ошибка);
			     if (КОНСОШ != НЕВЕРНХЭНДЛ && GetConsoleMode (КОНСОШ, &mode))
                   {
                   wchar[1024 * 1] utf;
                   while (s.length)
                         {
                         // crop to last complete utf8 sequence
                         auto t = crop (s[0 .. (s.length > utf.length) ? utf.length : s.length]);

                         // convert into output buffer and emit
                         auto i = MultiByteToWideChar (UTF8, 0, s.ptr, t.length, utf.ptr, utf.length);
                         WriteConsoleW (КОНСОШ, utf.ptr, i, &count, null);

                         // process next chunk
                         s = s [t.length .. $];
                         }
                   }
                else
                   // output is probably redirected (we assume utf8 output)
                   WriteFile (КОНСОШ, s.ptr, s.length, &count, null);
                }

        version (Posix)
                 write (2, s.ptr, s.length);
}

/*******************************************************************************

        Support for chained console (pseudo formatting) output

*******************************************************************************/

export extern (C) struct Console
{
export extern (C):
        alias newline opCall;
        alias emit    opCall;
    
        /// emit a utf8 string to the console
        Console emit (char[] s)
        {
          установиКонсоль();
                consoleString (s);
                return *this;
        }
		
		Console err (char[] s)
        {
                consoleErrString (s);
                return *this;
        }

        /// emit an unsigned integer to the console
        Console emit (ulong i)
        {
                consoleInteger (i);
                return *this;
        }

        /// emit a newline to the console
        Console newline ()
        {
          установиКонсоль();
                version (Windows)
                         const eol = "\r\n";
                version (Posix)
                         const eol = "\n";

                return emit (eol);
        }
		alias newline нс;
}

public Console console;
alias console say;
alias say консоль;

export extern(D)
{
    проц ошибнс(ткст ткт){console.err(ткт~"\r\n");}
	проц скажи(бдол ткт){console(ткт);}
	проц скажинс(бдол ткт){console(ткт).нс;}
	проц скажи(ткст ткт){console(ткт);}
	проц скажинс(ткст ткт){console(ткт).нс;}
	проц нс(){console.нс;}
	проц таб(){console("\t");}
}

///////////////////////
/+
import io.Console;
export extern(D)
{
проц ошибнс(ткст ткт){Кош(ткт~"\r\n");}

проц скажи(ткст ткт){Квывод(ткт);}
	
	проц скажи(бдол ткт)
	{
	сим[25] врем = void;
	Квывод(бдолВЮ8(врем,ткт));
	}
	
alias скажи say, console, консоль;

	проц скажинс(ткст ткт){Квывод(ткт).нс;}
	
	проц скажинс(бдол ткт)
	{
	сим[25] врем = void;
	Квывод(бдолВЮ8(врем,ткт)).нс;
	}
	
	проц нс(){Квывод("").нс;}
	проц таб(){Квывод("\t");}
}
+/
///////////////////////
version (Windows)
{
/*******************************************************************************

        Adjust the content such that no partial encodings exist on the 
        right side of the provided text.

        Returns a slice of the input

*******************************************************************************/

private char[] crop (char[] s)
{
        if (s.length)
           {
           auto i = s.length - 1;
           while (i && (s[i] & 0x80))
                  if ((s[i] & 0xc0) is 0xc0)
                     {
                     // located the first byte of a sequence
                     ubyte b = s[i];
                     int d = s.length - i;

                     // is it a 3 byte sequence?
                     if (b & 0x20)
                         --d;
   
                     // or a four byte sequence?
                     if (b & 0x10)
                         --d;

                     // is the sequence complete?
                     if (d is 2)
                         i = s.length;
                     return s [0..i];
                     }
                  else 
                     --i;
           }
        return s;
}
}

//Консоль
static ук _буфЭкрана;
static ук _вызывающийПроцесс;

ИНФОКОНСЭКРБУФ инфОбКонсБуф;
ИНФОСТАРТА стартИнфо;
КООРД размБуфера ={300, 10000};
МПРЯМ размОкна ={300, 100, 800, 900} ;
БЕЗАТРЫ баБуфЭкрана;
ЗАПВВОДА запвво;
ИНФОКОНСКУРСОР консКурсорИнфо;
		
//Это приятно наблюдать, пока всё так незавершено и неполноценно (!)
//Что-то ведь должно вдохновлять человечье тщеславие и стремление к победе(!)
	
		//auto КОМПИЛИРОВАНО_ПРИ_ПОМОЩИ = __VENDOR__;
		//auto КОМПИЛ_ВЕРСИЯ = фм("%d.%d", __VERSION__/1000, __VERSION__%1000);
		//auto КОМПИЛ_ДАТА = __TIMESTAMP__;

//===========================================================================
			

ткст интро =// фм(
"
	_______________________________________
         Язык Программирования Динруc
	Авторское право "~\u00A9~" 2012-2020 Лицензия GPL3
	    Разработчик Dinrus Group (Виталий Кулич)	    		      
	Сайт проекта: http://www.github.com/DinrusGroup	
	_______________________________________
	
	
";
//	Компилятор %s версии %s
//	Штамп времени %s
//	________________________________________

//, КОМПИЛИРОВАНО_ПРИ_ПОМОЩИ, КОМПИЛ_ВЕРСИЯ, КОМПИЛ_ДАТА );

//=========================================================================

const ПТекстКонсоли НАЧАТРЫКОНСОЛИ =  ПТекстКонсоли.СинийПП|ПТекстКонсоли.ЗелёныйПП|ПТекстКонсоли.КрасныйПП;

static ~this(){сбросьЦветКонсоли();}

//++=====================================================================

extern (C) проц установиКонсоль()
{
	
	
version(EmbeddedConsoleDetached)
	{			
	//После такой манипуляции каждая программа становится единоличницей!)))
	//Иногда это может быть полезным, например, если в WinMain выполнить такую команду, то
	//создаваемая здесь консоль будет затёрта, т.е. надпись "интро" перестанет досаждать(!)				
					ОсвободиКонсоль();
					РазместиКонсоль();
	}
	else
	{
				//Это поможет прикрепиться к вызывающей программе консольно.
				//В ExeMain|WinMain|DllMain делается то же самое, таким образом сшивается цепочка
				//между системной консолью, ДЛЛ и Экзешником.
				ПрикрепиКонсоль(-1);			
				
	}	
//=================================================================================
//3.Получим важные данные о  трёх консольных адресах, которые
//далее становятся аналогами стдвхо, стдвых и стдош
// (эти элементы могли бы потеряться, но, получается, что мы их просто меняем на новые,
//конкретные указатели на конкретную область памяти, в которой располагается наша консоль).			

			ДайИнфоСтарта(&стартИнфо);
//============================================================
//4.Функция обратного вызова, используемая в WinMain, может
//устанавливать соответствующий её  имени заголовок, либо выводить в заголовок
//какие=либо сообщения. Для этого мы просто создадим такую возможность:

			//УстановиЗагКонсоли("Язык Программирования ДИНРУС");
//==============================================================			
//5.		
			УстановиРазмерБуфераЭкранаКонсоли(КОНСВЫВОД, размБуфера) ;
			УстановиИнфОКурсореКонсоли(КОНСВЫВОД, &консКурсорИнфо);
			УстановиИнфОбОкнеКонсоли(КОНСВЫВОД, да, &размОкна);	

//============================================================================	
		
		УстановиАтрибутыТекстаКонсоли(КОНСВЫВОД, ПТекстКонсоли.ЗелёныйПП|ПТекстКонсоли.ИнтПП);			
		скажи(интро);
		УстановиАтрибутыТекстаКонсоли(КОНСВЫВОД, ПТекстКонсоли.СинийПП|ПТекстКонсоли.ЗелёныйПП|ПТекстКонсоли.ИнтПП);
//=============================================================================			
			//Будем использовать для ввода и вывода стандарт Виндовс,
			//хотя мечталось бы установить ПКодСтр.УТФ8 вместо ПКодСтр.ОЕМ. 866
			if(ДайКСКонсоли() != cast(бцел)ПКодСтр.ОЕМ) УстановиКСКонсоли(cast(ПКодСтр) ПКодСтр.ОЕМ);
			if(ДайКСВыводаКонсоли() != cast(бцел)ПКодСтр.ОЕМ) УстановиКСВыводаКонсоли(cast(ПКодСтр) ПКодСтр.ОЕМ);
			
			//Это открывает доступ для чтения и записи из консольного буфера.
			баБуфЭкрана.длина = БЕЗАТРЫ.sizeof;
			баБуфЭкрана.дескрБезоп = пусто;
			баБуфЭкрана.наследДескр = да;
			//_буфЭкрана = СоздайБуферЭкранаКонсоли(ППраваДоступа.ГенерноеЧтение| ППраваДоступа.ГенернаяЗапись, ПСовмИспФайла.Чтение|ПСовмИспФайла.Запись, &баБуфЭкрана);
			//УстановиАктивныйБуферКонсоли(_буфЭкрана);
}


//==================================================	

const бцел ДУБЛИРУЙ_ПРАВА_ДОСТУПА = 0x00000002;
		
export extern (C) проц укВызывающегоПроцесса(ук процесс){_вызывающийПроцесс = процесс;}

export extern (C)
{

бцел идБазовогоПроцесса(){return GetCurrentProcessId();}

 ук консБуфЭкрана(){  

             ук   hndl;
    if(_вызывающийПроцесс)  ДублируйДескр( УКНАПРОЦЕСС, _буфЭкрана, _вызывающийПроцесс, &hndl, cast(ППраваДоступа) 0, да, ДУБЛИРУЙ_ПРАВА_ДОСТУПА );
		  else return _буфЭкрана;
                return hndl;
 
 }
 
ук консВход(){
// if(!УстановиСтдДескр(ПСтд.Ввод, КОНСВВОД)) ошибка("Установка стандартного дескриптора не удалась"); 
  

                ук    hndl;

   if(_вызывающийПроцесс)    ДублируйДескр( УКНАПРОЦЕСС, КОНСВВОД, _вызывающийПроцесс, &hndl, cast(ППраваДоступа) 0, да, ДУБЛИРУЙ_ПРАВА_ДОСТУПА );
			  else return КОНСВВОД;
                return hndl;
 }
 
ук консВыход(){
  

                ук  hndl;

    if(_вызывающийПроцесс)      ДублируйДескр( УКНАПРОЦЕСС, КОНСВЫВОД, _вызывающийПроцесс, &hndl, cast(ППраваДоступа) 0, да, ДУБЛИРУЙ_ПРАВА_ДОСТУПА );
                else return КОНСВЫВОД;
                return hndl;
 }
 
ук консОш(){
  

                ук   hndl;

              if(_вызывающийПроцесс)   ДублируйДескр( УКНАПРОЦЕСС, КОНСОШ, _вызывающийПроцесс, &hndl, cast(ППраваДоступа) 0, да, ДУБЛИРУЙ_ПРАВА_ДОСТУПА );
                     else return КОНСОШ;
                return hndl;
 
 }
 
 //ИНФОСТАРТА дайСтартИнфо(){assert(стартИнфо.размер != 0, "ИнфоСтартаПроцесса отсутствует"); return стартИнфо;}
}

//======================================================================
//УТИЛИТНЫЕ ФУНКЦИИ

extern(C) ук адаптВыхУкз(ук укз)
{
                  ук    hndl;

    if(_вызывающийПроцесс)  ДублируйДескр( УКНАПРОЦЕСС, укз, _вызывающийПроцесс, &hndl, ППраваДоступа.ГенерноеЧтение| ППраваДоступа.ГенернаяЗапись, да, ДУБЛИРУЙ_ПРАВА_ДОСТУПА );
		  else return укз;
                return hndl;
}

extern(C) ук адаптВхоУкз(ук укз)
{
                  ук   hndl;

    if(_вызывающийПроцесс)  ДублируйДескр( _вызывающийПроцесс, укз, УКНАПРОЦЕСС, &hndl, ППраваДоступа.ГенерноеЧтение| ППраваДоступа.ГенернаяЗапись, да, ДУБЛИРУЙ_ПРАВА_ДОСТУПА );
		  else return укз;
                return hndl;
}

export extern (C) проц максПриоритетПроцессу()
 {
		SetPriorityClass(УКНАПРОЦЕСС, 0x00000080);
		SetThreadPriority(УКНАНИТЬ,15);
}
//================================================

КООРД верхлево = {0, 0};

export extern (C) проц  перейдиНаТочкуКонсоли( цел aX, цел aY)
{
КООРД коорд;

  коорд.X = aX;
  коорд.Y = aY;
  УстановиПозициюКурсораКонсоли(КОНСВЫВОД,коорд);
}

export extern (C) проц установиАтрыКонсоли(ПТекстКонсоли атр)
{
  УстановиАтрибутыТекстаКонсоли(КОНСВЫВОД,атр);
}

export extern (C) цел гдеИксКонсоли()
{
  ДайИнфОБуфЭкранаКонсоли(КОНСВЫВОД,&инфОбКонсБуф);
  return инфОбКонсБуф.позКурсора.X;
}

export extern (C) цел гдеИгрекКонсоли()
{ 
  ДайИнфОБуфЭкранаКонсоли(КОНСВЫВОД,&инфОбКонсБуф);
  return инфОбКонсБуф.позКурсора.Y;
}

export extern (C) ПТекстКонсоли дайАтрыКонсоли()
{
  ДайИнфОБуфЭкранаКонсоли(КОНСВЫВОД,&инфОбКонсБуф);
  return инфОбКонсБуф.атрибуты;
}

extern(Windows) BOOL FillConsoleOutputCharacter(HANDLE hConsoleOutput, TCHAR cCharacter, DWORD nLength, COORD dwWriteCoord, out  LPDWORD lpNumberOfCharsWritten);

/+
проц очистьЭкран()
{
  ДайИнфОБуфЭкранаКонсоли(КОНСВЫВОД,&инфОбКонсБуф);
  auto заливка = инфОбКонсБуф.размер.X * инфОбКонсБуф.размер.Y;
  FillConsoleOutputCharacter(КОНСВЫВОД, ' ', заливка, cast(COORD) верхлево, cast(LPDWORD) заливка);
  АтрибутЗаливкиВыводаКонсоли(КОНСВЫВОД,инфОбКонсБуф.атрибуты, заливка,  верхлево, заливка);
}
+/

export extern(C) проц сбросьЦветКонсоли(){установиАтрыКонсоли(НАЧАТРЫКОНСОЛИ);}

