﻿module sys.memory;
import exception, sys.WinFuncs;

бцел  ЗначФрагмКучи;

enum Тип
{
СТД = 0,//стандартная
НФК = 2,// низко фрагментированная (LFH)
ЛА = 1, // с поддержкой look aside
}

const ФЛ = (ППамять.КучВклВып|ППамять.КучГенИскл);

export extern (D):

/**
*Проверка действенности указателя на функцию
**/
проц проверь (ук процедура)

					{
					if(ПлохойУкНаКод_ли(процедура)) exception.ошибка("Указатель на функцию неверен.\n" ~текстСисОшибки(ДайПоследнююОшибку()));
					}

/**
*Проверка действенности указателя на строку Анзи
**/
проц проверь (усим текст)

					{
					if(ПлохойСтрУк_ли(текст, текст.sizeof)) exception.ошибка("Указатель на текстовую константу/переменную типа усим неверен.\n");
					}
	
/**
*Проверка действенности указателя на широкосимвольную строку 
**/
проц проверь (ушим текст)

					{
					if( ПлохойШСтрУк_ли(текст, текст.sizeof))exception.ошибка("Указатель на текстовую константу/переменную типа ушим неверен.\n");
					}
	
/**
*Проверка открытости доступа для чтения блока памяти 
**/
проц проверьЧитается(ук первБайтБлока)

					{
					if(ПлохойЧтенУк_ли(cast(ук) первБайтБлока, первБайтБлока.sizeof))exception.ошибка("Чтение указанного блока памяти запрещено.\n");
					}
	
/**
*Проверка открытости доступа для записи блока памяти 
**/
проц проверьЗаписывается(ук первБайтБлока)

					{
					if(ПлохойЗапУк_ли(первБайтБлока, первБайтБлока.sizeof))exception.ошибка("Запись в указанный блок памяти запрещена.\n");
					}

/**
*Заполнить нулями память по указателю на указанное число байт 
**/
проц занули(ук где, т_мера сколько)

					{ОбнулиПамять(где, сколько);}

/**
*Заполнить память символами,указанными в параметре "чем",
*по указателю на указанное число байт 
**/
проц  заполни(ук где, т_мера сколько, ббайт чем)

					{ЗаполниПамять(где, сколько, чем);}

/**
*Перемещение указанного числа байт с одного адреса на другой
**/

проц перемести (ук куда, ук откуда, т_мера сколько)

					{ПереместиПамять(куда, откуда, сколько);}

//бцел ДайОбзорЗаписи(ППамять флаги, in ук базАдр, in т_мера размРег, ук* адры, inout бцел* счёт, out бцел* гранулярность);

export struct Куча
{


private ук куча;

/**
Чтобы получить доступ к куче текущего процесса или создать кучу, 
достаточно указать
..................
 Память.Куча куча;
 
 куча.процесса;
 .................
 или
 .................
 куча.новая;
..................

Теперь куча.сожми, куча.удали и другие
операции будут относиться либо к созданной новой,
либо к куче процесса.

**/
export:

проц процесса()

				{ куча = ДайКучуПроцесса();}
	
проц новая( т_мера начРазм = 0, т_мера максРазм = 0,  ППамять опц = ФЛ)
				{ куча = СоздайКучу(опц, начРазм, максРазм);
				if(!куча) exception.ошибка("Ошибка при создании кучи. \n" ~текстСисОшибки(ДайПоследнююОшибку())); 				
				}

/**
Установка типа кучи
*/

проц тип(бцел типКучи = Тип.СТД)

					{
						ЗначФрагмКучи = типКучи;
						if(!УстановиИнфОКуче(куча, 0,  &ЗначФрагмКучи, ЗначФрагмКучи.sizeof) )
						 exception.ошибка("Ошибка при установке типа кучи\n" ~текстСисОшибки(ДайПоследнююОшибку()));
					}
					
//бул ЗапросиИнфОКуче (ук куча, бцел клинф, out ук инф, т_мера длинаклинф, т_мера* длвозвр);

/**
Выполняет удаление
*/
проц удали()
					{if(!УдалиКучу(куча)) exception.ошибка("Куча не удалена\n" ~текстСисОшибки(ДайПоследнююОшибку()));}

/**
Выводит указатель
*/
ук укз()
					{return куча;}

/**
Блокирует
*/
проц блокируй()
					{if(!БлокируйКучу(куча)) exception.ошибка("Куча не заблокирована\n" ~текстСисОшибки(ДайПоследнююОшибку()));}

/**
Разблокирует
*/
проц разблокируй()
					{if(!РазблокируйКучу(куча))exception.ошибка("Куча не разблокирована\n" ~текстСисОшибки(ДайПоследнююОшибку()));	}

/**
Выделяет из кучи указанное число байтов для использования
*/					
ук размести( т_мера байты, ППамять флаги = ФЛ)
					{

					ук рез = РазместиКучу(куча, флаги, байты);
					if(ДайПоследнююОшибку() == ПОшибка.СтатусНеПам||ДайПоследнююОшибку() ==ПОшибка.СтатусНарушДоступа)
						{
						exception.ошибка("При размещении в память кучи произошла ошибка.\n" ~текстСисОшибки(ДайПоследнююОшибку()));}
					return cast(ук) рез;
					}


/**
Изменяет указанное число байтов и атрибуты блока
*/	
ук измени( ук блок, т_мера байты, ППамять флаги = ФЛ)
					{
					auto рез = ПереместиКучу(куча, флаги, cast(ук) блок, байты);
					if(ДайПоследнююОшибку() == ПОшибка.СтатусНеПам||ДайПоследнююОшибку() ==ПОшибка.СтатусНарушДоступа)
						{
						exception.ошибка("При изменении блока памяти кучи произошла exception.ошибка.\n" ~текстСисОшибки(ДайПоследнююОшибку()));
						}
					return cast(ук) рез;
					}

/**
Удаляет указанный блок
*/
проц освободи ( ук блок, ППамять флаги = ФЛ)
					{if(!ОсвободиКучу(куча, флаги, cast(ук) блок))
						exception.ошибка("Неудача при освобождении блока памяти кучи.\n" ~текстСисОшибки(ДайПоследнююОшибку()));}

/**
Выводит размерКласса указанного блока
*/
т_мера размерКласса( ук блок, ППамять флаги = ФЛ)
					{return cast(т_мера) РазмерКучи(куча, флаги, cast(ук) блок );}

/**
Выполняет проверку консистентности памяти блока
*/
бул проверь( ук блок, ППамять флаги = ФЛ)
					{if(!ПроверьКучу(куча, флаги, cast(ук) блок )) exception.ошибка("Блок данных повреждён"); return да;}

/**
Выполняет сжатие кучи за счёт удаления нулевых пространств
*/
т_мера сожми(ППамять флаги = ФЛ)
					{return cast(т_мера) СожмиКучу(куча, флаги);}
/+
проц обход()
					{
					цел запНомер =1;
					ЗАППРОЦКУЧ* зап;
					зап.данук = пусто;
					for(цел н ; ДайПоследнююОшибку() == ПОшибка.ЭлтовБНет; н++)
					{
					if(ОбойдиКучу(куча, зап)) exception.ошибка("Ошибка при обходе записей кучи:\n"~фм("(%d)", ДайПоследнююОшибку()));
						{
						скажинс(фм("Запись Кучи #%i", запНомер));
						скажинс(фм("Адрес данных: %x", зап.данук));
						скажинс(фм("Данные: %x", зап.данные));
						скажинс(фм("Индекс Региона: %x", зап.индексРегиона));
						скажинс(фм("Флаги: %x", зап.флаги));
						/*скажинс(фм("Адрес блока: %x", зап.Блок.пам));
						скажинс(фм("Переданный размерКласса: %x", зап.Регион.переданныйРазм));
						скажинс(фм("Остаток: %x", зап.Регион.непереданныйРазм));
						скажинс(фм("Адрес первого блока: %x", зап.Регион.первБлок));
						скажинс(фм("Адрес последнего блока: %x", зап.Регион.последнБлок));*/
						запНомер++;						
						}
					}
					
		    }+/
	}


/+

struct Лок
{
лук лок;

	лук размести(бцел байты, бцел флаги){return  РазместиЛок(ППамять флаги, бцел байты);}	
	лук перемести()						{ return ПереместиЛок(лук пам, бцел байты, ППамять флаги);}
	лук укз()							{return ХэндлЛок(ук пам);}	
	проц разблокируй()					{if(!РазблокируйЛок(лук пам)) exception.ошибка("Не удалось разблокировать локальную память");}
    т_мера размерКласса() 					{return РазмерЛок(лук пам);}
	бцел дайФлаги()						{ return ФлагиЛок(лук пам);}
	лук освободи()						{return ОсвободиЛок(лук пам);}
	бцел расширь()						{return РасширьЛок(лук пам, бцел новРазм);}
	бцел сожми()						{return СожмиЛок(бцел минОсв);}
}

struct Глоб
{
гук глоб;

	ук БлокируйГлоб(гук укз);
	бул  РазблокируйГлоб(гук пам);
	гук  ОсвободиГлоб(гук пам);
	бцел СожмиГлоб(бцел минОсвоб);
	проц ФиксируйГлоб(гук пам);
	проц РасфиксируйГлоб(гук пам);
	ук ВяжиГлоб(гук пам);
	бул ОтвяжиГлоб(гук пам);
	проц СтатусГлобПамяти(СТАТПАМ *буф);
	гук РазместиГлоб(ППамять флаги , бцел байты);
	гук ПереместиГлоб(гук укз, т_мера байты, ППамять флаги);
	т_мера РазмерГлоб(гук укз);
	бцел ФлагиГлоб(гук укз);
	гук ХэндлГлоб(ук пам);
}
struct Вирт
{
	бул СлейКэшИнструкций(ук процесс, ук адрБаз, бцел разм);
	ук РазместиВирт(ук адрес, бцел разм, ППамять типРазмещения, бцел защита);
	бул ОсвободиВирт(ук адрес, бцел разм, ППамять типОсвобождения);
	бул ЗащитиВирт(ук адр, бцел разм, бцел новЗащ, убцел старЗащ);
	бцел ОпросиВирт(ук адр, БАЗИОП *буф, бцел длина);
	ук РазместиВиртДоп(ук процесс, ук адрес, бцел разм, ППамять типРазмещ, бцел защита);
	бул ОсвободиВиртДоп(ук процесс, ук адр, бцел разм, ППамять типОсвоб);
	бул ЗащитиВиртДоп(ук процесс, ук адр, бцел разм, бцел новЗащ, убцел старЗащ);
	бцел ОпросиВиртДоп(ук процесс, ук адр, БАЗИОП *буф, бцел длина);
}
+/



/*
enum ППамять
{
//Секции
    ЗапросСекц       = 0x0001,
    ЗаписьСекцКарт   = 0x0002,
    ЧтениеСекцКарт    = 0x0004,
    ВыполнитьСекцКарт = 0x0008,
    УвеличитьРазмСекц = 0x0010,
	Копия = ЗапросСекц,
	Запись = ЗаписьСекцКарт,
	Чтение = ЧтениеСекцКарт,
	ВыполнитьСекцКартЯвно = 0x0020,
    ВсеДоступыКСекции = cast(цел)(ППраваДоступа.ТребуютсяСП|0x0001| 0x0002 | 0x0004 | 0x0008 | 0x0010),
//Страницы
    СтрНедост          = 0x01,
    СтрТолькоЧтен          = 0x02,
    СтрЗапЧтен         = 0x04,
    СтрЗапКоп         = 0x08,
    СтрВып           = 0x10,
    СтрЧтенВып      = 0x20,
    СтрЗапЧтенВып = 0x40,
    СтрЗапКопВып = 0x80,
	СтрЗапКомб = 0x400,
    СтрОхрана            = 0x100,
    СтрБезКэша          = 0x200,
	
//Секции
    СекФайл           = 0x800000,
    СекОбраз         = 0x1000000,
	СекЗащищёнОбраз =  0x2000000 ,
    СекРезерв       = 0x4000000,
    СекОтправить        = 0x8000000,
    СекБезКэша      = 0x10000000,
	СекЗапКомб = 0x40000000,     
	СекБольшиеСтр =  0x80000000,     
	СбросФлОбзЗап = 0x01, //WRITE_WATCH_FLAG_RESET
//ПАМ_
    Отправить           = 0x1000,	//mem_commit
    Резервировать          = 0x2000,//mem_reserve
	Записать = Отправить|Резервировать,
    Взять         = 0x4000,//mem_decommit
    Разблокировать          = 0x8000,
    Освободить            = 0x10000,
    Частная         = 0x20000,
    Картированная          = 0x40000,
    Сброс           = 0x80000,
    СверхуВниз       = 0x100000,
	БольшиеСтр = 0x20000000,
	Физическая = 0X400000,
	ЗапОбзор  =    0x200000,     
    Вращать =        0x800000,    
    Стр4Мб =    0x8000000,
	Образ        = СекОбраз,

//Глоб
    ГлобФиксир =	(0),
    ГлобПеремещ = 	(2),
    Гук =	(64),
    ГДескр =	(66),
	ГлобДДЕСовмест =	(8192),
	ГлобДискард =	(256),
	ГлобНижняя =	(4096),
	ГлобНесжим =	(16),
	ГлобНедискард =	(32),
	ГлобНеБанк =	(4096),
	ГлобУведоми	= (16384),
	ГлобСовмест =	(8192),
	ГлобНульИниц =	(64),
	ГлобДискардир =	(16384),
	ГлобНевернДескр =	(32768),
	ГлобСчётБлокировок =	(255),
//Лок
	Лук	= (64),
	ЛДескр	= (66),
	ЛДескрНеНуль	= (2),
	ЛукНеНуль	= (0),
	ЛокЛДескрНеНуль	= (2),
	ЛокЛукНеНуль	= (0),
	ЛокФиксир	= (0),
	ЛокПеремещ	= (2),
	ЛокНесжим	= (16),
	ЛокНедискард	= (32),
	ЛокНульИниц	= (64),
	ЛокИзмени	= (128),
	ЛокСчётБлокировок	= (255),
	ЛокДискард	= (3840),
	ЛокДискардир	= (16384),
	ЛокНевернДескр	= (32768),

//Вирт

//Куча
	КучГенИскл =	0x00000004,
	КучНеСериализ =	0x00000001,
	КучОбнулиПам	= 0x00000008,	
	КучПереместТолькоНаМесте	= 0x00000010,
	КучВклВып = 0x00040000,
}
*/

/+
///////////////////////////////////////////////////////////////
enum
	{
		НКЛАСС = 18,
		ОСТБИН = 113,
		САМБОЛЬШЗАГРР = 24,
		МАКСБЛОК = 65536 - 2 * Куча.Заглав.sizeof - САМБОЛЬШЗАГРР,
		БОЛЬШЗАГРР = 56,
	};
	
//#define LLOG(x) //  LOG(cast(ук )this << ' ' << x)

цел сКБ;
цел с4кб__;
цел с64кб__;
Куча.Уссыл Куча.больш[1];
Куча        Куча.вспом;
СтатическийМютекс Куча.мютекс;
бкрат  Куча.двРазм[ОСТБИН];
ббайт  Куча.размДв[МАКСБЛОК / 8 + 1];
ббайт  Куча.блДв[МАКСБЛОК / 8 + 1];
Куча.УСсыл Куча.пустс[1];
Куча.Страница    наобум;

const ДИ  =  [[ 0, 0, 0, 0, &наобум, &наобум ]];
/*thread__*/ Куча куча = [[ ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ, ДИ ]];

class ПрофильПамяти
{
	this(){	куча.делай(cast(ук) this);}
}

static ПрофильПамяти *сПик;

ук РазместиПамПерманентноСыро(т_мера разм)
{
	if(разм >= 256)
		return cidrus.malloc(разм);
	static ббайт *укз = пусто;
	static ббайт *предел = пусто;
	if(укз + разм >= предел) {
		укз = cast(ббайт *)РазместиСыро4КБ();
		предел = укз + 4096;
	}
	ук p = укз;
	укз += разм;
	return p;
}

ук РазместиПамПерманентно(т_мера разм)
{
	Mutex.Lock __(Куча.мютекс);
	return РазместиПамПерманентноСыро(разм);
}

ПрофильПамяти *ДайПрофильПамяти()
{
	if(сПик)
		return сПик;
	сПик = cast(ПрофильПамяти *) РазместиПамПерманентно(ПрофильПамяти.sizeof);
	memset(сПик, 0, ПрофильПамяти.sizeof);
	return пусто;
}

проц ВыполниПикПрофиль()
{
	if(сПик)
		куча.делай(*сПик);
}

цел   ИспользуетсяКбПамяти() { return сКБ; }

ук СисРазместиСыро(т_мера разм)
{
	сКБ += cast(цел)(((разм + 4095) & ~4095) >> 10);
	ук укз = VirtualAlloc(пусто, разм, ППамять.Резервировать|ППамять.Отправить, ППамять.СтрЗапЧтен);
	if(укз == НЕВЕРНХЭНДЛ)
		укз = пусто;
	if(!укз)
		throw new ВнеПамИскл;
	ВыполниПикПрофиль();
	return укз;
}

проц СисОсвободиСыро(ук укз, т_мера разм)
{
	сКБ -= cast(цел)(((разм + 4095) & ~4095) >> 10);
	VirtualFree(укз, 0, ППамять.Освободить);

}

ук РазместиСыро4КБ()
{
	static цел   остаток;
	static ббайт *укз;
	static цел   n = 32;
	if(остаток == 0) {
		остаток = n >> 5;
		укз = cast(ббайт *)СисРазместиСыро(остаток * 4096);
	}
	n = n + 1;
	if(n > 4096) n = 4096;
	ук p = укз;
	укз += 4096;
	остаток--;
	с4кб__++;
	ВыполниПикПрофиль();
	return p;
}

ук РазместиСыро64КБ()
{
	static цел   остаток;
	static ббайт* укз;
	static цел   n = 32;
	if(остаток == 0) {
		остаток = n >> 5;
		укз = cast(ббайт *)СисРазместиСыро(остаток * 65536);
	}
	n = n + 1;
	if(n > 256) n = 256;
	ук p = укз;
	укз += 65536;
	остаток--;
	с64кб__++;
	ВыполниПикПрофиль();
	return p;
}
/*
проц HeapPanic(сим* текст, ук поз, цел разм)
{
	RLOG("\n\n" << текст << "\n");
	HexDump(VppLog(), поз, разм, 64);
	Panic(текст);
}
*/
проц ОсвободиПамНити()
{
	куча.стопЭкстр();
}

проц ЧекПам()
{
	куча.чек();
}

ук разместиЛ(т_мера& разм);
проц  освободиЛ(ук укз);
///////////////////////////////////\
struct Куча 
{
	enum { КЭШ = 16 };

	static цел размерКласса(цел k)
	{
		return k < 14 ? (k + 1) << 4 : k == 17 ? 576 : k == 16 ? 448 : k == 15 ? 368 : 288;
	}

	struct СсылНаОсвоб 
	{
		СсылНаОсвоб *следщ;
	}

	struct Страница
	{
		ббайт         класс;
		ббайт         актив;
		Куча* 			куча;
		СсылНаОсвоб*  списОсвоб;
		Страница* следщ;
		Страница*        предш;

		проц         привяжись()            { Dbl_Self(this); }
		проц         отвяжи()              { Dbl_Unlink(this); }
		проц         привяжи(Страница* lnk)       { Dbl_LinkAfter(this, lnk);  }

		проц форматируй(цел k)
		{
			отлЗаполниСвоб(начало(), конец() - начало());
			класс = k;
			актив = 0;
			цел рр = размерКласса(k);
			ббайт *укз = конец() - рр;
			ббайт *b = начало();
			СсылНаОсвоб *l = пусто;
			while(укз >= b) {
				(cast(СсылНаОсвоб *)укз).следщ = l;
				l = cast(СсылНаОсвоб *)укз;
				укз -= рр;
			}
			списОсвоб = l;
		}

		ббайт* начало()                      { return cast(ббайт *)this + Страница.sizeof; }
		ббайт* конец()                        { return cast(ббайт *)this + 4096; }
		цел   чло()                      { return cast(цел)cast(uintptr_t)(конец() - начало()) / размерКласса(класс); }
	}

	struct УСсыл 
	{
		УСсыл       *следщ;
		УСсыл       *предш;

		проц         привяжись()            { Dbl_Self(this); }
		проц         отвяжи()              { Dbl_Unlink(this); }
		проц         привяжи(УСсыл *lnk)      { Dbl_LinkAfter(this, lnk);  }

		Заглав      *дайЗаг()           { return cast(Заглав *)this - 1; }
	}

	struct Заглав
	{
		ббайт    свободно;
		ббайт    заполнитель1, заполнитель2, заполнитель3;
		бкрат    разм;
		бкрат    предш;
		Куча   *куча;
	version(CPU_32)
		бкрат   заполнитель4;

		УСсыл      *дайБлок()             { return cast(УСсыл *)(this + 1); }
		Заглав     *далее()                 { return cast(Заглав *)(cast(ббайт *)this + разм) + 1; }
		Заглав     *ранее()                 { return cast(Заглав *)(cast(ббайт *)this - предш) - 1; }
	}

	struct БольшЗаг : УСсыл
	{
		т_мера       разм;
	}


	static СтатическийМютекс мютекс;

	Страница[НКЛАСС][1] рабоч;
	Страница[НКЛАСС][1] полн;
	Страница*[НКЛАСС]  пуст;
	СсылНаОсвоб*[НКЛАСС] кэш;
	цел[НКЛАСС]  вкэше;

	бул инициализирован;

	static бкрат[ОСТБИН] двРазм;
	static ббайт[МАКСБЛОК / 8 + 1] размДв;
	static ббайт[МАКСБЛОК / 8 + 1] блДв;

	УСсыл[1] самбольш;
	цел    члос;
	УСсыл[ОСТБИН][1] освдв;
	static УСсыл[1] пустс;

	СсылНаОсвоб* дист_освоб;

	static УСсыл[1] больш;
	static Куча  вспом;

version(HEAPDBG)
{

	проц отлЗаполниСвоб(ук p, т_мера разм)
	{
		т_мера чло = разм >> 2;
		бкрат *укз = cast(бкрат *)p;
		while(чло--)
			*укз++ = 0x65657246;
	}

	проц отлПроверьСвоб(ук p, т_мера разм)
	{
		т_мера чло = разм >> 2;
		бкрат *укз = cast(бкрат *)p;
		while(чло--)
			if(*укз++ != 0x65657246)
				HeapPanic("Замечена запись в освобождённые блоки", p, cast(цел)(uintptr_t)разм);
	}

	ук отлПроверьСвобК(ук p, цел k)
	{
		Страница *стран = cast(Страница *)(cast(uintptr_t)p & ~cast(uintptr_t)4095);
		assert(cast(ббайт *)стран + Страница.sizeof <= cast(ббайт *)p && cast(ббайт *)p < cast(ббайт *)стран + 4096);
		assert((4096 - (cast(uintptr_t)p & cast(uintptr_t)4095)) % размерКласса(k) == 0);
		assert(стран.класс == k);
		отлПроверьСвоб(cast(СсылНаОсвоб *)p + 1, размерКласса(k) - СсылНаОсвоб.sizeof);
		return p;
	}

	проц отлЗаполниСвобК(ук p, цел k)
	{
		отлЗаполниСвоб(cast(СсылНаОсвоб *)p + 1, размерКласса(k) - СсылНаОсвоб.sizeof);
	}

}else{
	static проц  отлЗаполниСвоб(ук укз, т_мера разм) {}
	static проц  отлПроверьСвоб(ук укз, т_мера разм) {}
	static проц  отлЗаполниСвобК(ук укз, цел k) {}
	static ук    отлПроверьСвобК(ук p, цел k) { return p; }
}

version(flagHEAPSTAT)
{
	цел мстат[65536];
	цел бстат;

проц стат(т_мера рр)
	{
		if(рр < 65536)
			мстат[рр]++;
		else
			бстат++;
	}

	scope(exit) {
		цел сумма = 0;
		for(цел i = 0; i < 65536; i++)
			сумма += мстат[i];
		сумма += бстат;
		цел всего = 0;
		VppLog() << Sprintf("Статистика размещений: (полн размещений: %d)\n", сумма);
		for(цел i = 0; i < 65536; i++)
			if(мстат[i]) {
				всего += мстат[i];
				VppLog() << Sprintf("%5d %8dx %2d%%, полн %8dx %2d%%\n",
									i, мстат[i], 100 * мстат[i] / сумма, всего, 100 * всего / сумма);
			}
		if(бстат) {
			всего += бстат;
			VppLog() << Sprintf(">64KB %8dx %2d%%, полн %8dx %2d%%\n",
								бстат, 100 * бстат / сумма, всего, 100 * всего / сумма);
		}
	}
}
else
	static проц  стат(т_мера рр) {}


проц иниц()
{
	if(инициализирован)
		return;
	LLOG("иниц куча " << cast(ук)this);
	for(цел i = 0; i < НКЛАСС; i++) {
		пуст[i] = пусто;
		полн[i].привяжись();
		рабоч[i].привяжись();
		рабоч[i].списОсвоб = пусто;
		рабоч[i].класс = i;
		вкэше[i] = 3500 / размерКласса(i);
	}
	assert(Заглав.sizeof == 16);
	assert(УСсыл.sizeof <= 16);
	assert(БольшЗаг.sizeof + Заглав.sizeof < БОЛЬШЗАГРР);
	глобИницЛ();
	for(цел i = 0; i < ОСТБИН; i++)
		освдв[i].привяжись();
	самбольш.привяжись();
	члос = 0;
	if(this != &вспом && !вспом.рабоч[0].следщ) {
		Mutex.Lock __(мютекс);
		вспом.иниц();
	}
	инициализирован = да;
	PROFILEMT(мютекс);
}

проц освободиДист(ук укз)
{
	LLOG("освободиДист " << укз);
	Mutex.Lock __(мютекс);
	СсылНаОсвоб *f = cast(СсылНаОсвоб *)укз;
	f.следщ = дист_освоб;
	дист_освоб = f;
}

проц дистОсвободиСыро()
{
	while(дист_освоб) {
		СсылНаОсвоб *f = дист_освоб;
		дист_освоб = дист_освоб.следщ;
		LLOG("дистОсвободи " << cast(ук)f);
		освободиПрямо(f);
	}
}

проц дистОсвободи()
{
	LLOG("дистОсвободи");
	Mutex.Lock __(мютекс);
	дистОсвободиСыро();
}

проц стопЭкстр()
{
	LLOG("стопЭкстр");
	Mutex.Lock __(мютекс);
	иниц();
	дистОсвободиСыро();
	for(цел i = 0; i < НКЛАСС; i++) {
		LLOG("освободи кэш " << i);
		СсылНаОсвоб *l = кэш[i];
		while(l) {
			СсылНаОсвоб *h = l;
			l = l.следщ;
			освободиПрямо(h);
		}
		while(полн[i].следщ != полн[i]) {
			Страница *p = полн[i].следщ;
			p.отвяжи();
			p.куча = &вспом;
			p.привяжи(вспом.полн[i]);
			LLOG("Orphan полн " << (ук)p);
		}
		while(рабоч[i].следщ != рабоч[i]) {
			Страница *p = рабоч[i].следщ;
			p.отвяжи();
			p.куча = &вспом;
			p.привяжи(p.списОсвоб ? вспом.рабоч[i] : вспом.полн[i]);
			LLOG("Orphan рабоч " << (ук)p);
		}
		if(пуст[i]) {
			assert(пуст[i].списОсвоб);
			assert(пуст[i].актив == 0);
			пуст[i].куча = &вспом;
			пуст[i].следщ = вспом.пуст[i];
			вспом.пуст[i] = пуст[i];
			LLOG("Orphan пуст " << (ук)пуст[i]);
		}
	}
	while(самбольш != самбольш.следщ) {
		Заглав *bh = cast(Заглав *)(cast(ббайт *)самбольш.следщ + САМБОЛЬШЗАГРР);
		LLOG("Orphan самбольш block " << cast(ук)самбольш.следщ << " разм: " << bh.разм);
		if(bh.разм == МАКСБЛОК && bh.свободно)
			переместиВПустое(самбольш.следщ, bh);
		else
			переместиБ(&вспом, самбольш.следщ);
	}
	memset(this, 0, Куча.sizeof));
}

проц проверь(бул b)
{
	if(!b)
		Panic("Куча повреждена!");
}

проц делай(ПрофильПамяти& f)
{
	Mutex.Lock __(мютекс);
	memset(&f, 0, ПрофильПамяти.sizeof);
	for(цел i = 0; i < НКЛАСС; i++) {
		цел qq = размерКласса(i) / 4;
		Страница *p = рабоч[i].следщ;
		while(p != рабоч[i]) {
			f.allocated[qq] += p.актив;
			f.fragmented[qq] += p.чло() - p.актив;
			p = p.следщ;
		}
		p = полн[i].следщ;
		while(p != полн[i]) {
			f.allocated[qq] += p.актив;
			p = p.следщ;
		}
	}
	цел ii = 0;
	цел fi = 0;
	УСсыл *m = больш.следщ;
	while(m != больш) {
		т_мера рр = (cast(БольшЗаг *)(cast(ббайт *)m + БОЛЬШЗАГРР - Заглав.sizeof)).разм;
		f.самбольш_count++;
		f.самбольш_total += рр;
		if(ii < 4096)
			f.самбольш_разм[ii++] = рр;
		m = m.следщ;
	}
	m = самбольш.следщ;
	while(m != самбольш) {
		Заглав *h = cast(Заглав *)(cast(ббайт *)m + САМБОЛЬШЗАГРР);
		while(h.разм) {
			if(h.свободно) {
				f.самбольш_свободно_count++;
				f.самбольш_свободно_total += h.разм;
				if(fi < 4096)
					f.самбольш_свободно_разм[fi++] = h.разм;
			}
			else {
				f.самбольш_count++;
				f.самбольш_total += h.разм;
				if(ii < 4096)
					f.самбольш_разм[ii++] = h.разм;
			}
			h = h.далее();
		}
		m = m.следщ;
	}
}

проц ублЧек(Страница *p)
{
	Страница *l = p;
	do {
		проверь(l.следщ.предш == l && l.предш.следщ == l);
		l = l.следщ;
	}
	while(p != l);
}

цел чекСтрОсвободи(СсылНаОсвоб *l, цел k)
{
	цел n = 0;
	while(l) {
		отлПроверьСвобК(l, k);
		l = l.следщ;
		n++;
	}
	return n;
}

проц чек() {
	Mutex.Lock __(мютекс);
	иниц();
	if(!рабоч[0].следщ)
		иниц();
	for(цел i = 0; i < НКЛАСС; i++) {
		ублЧек(рабоч[i]);
		ублЧек(полн[i]);
		Страница *p = рабоч[i].следщ;
		while(p != рабоч[i]) {
			проверь(p.куча == this);
			проверь(чекСтрОсвободи(p.списОсвоб, p.класс) == p.чло() - p.актив);
			p = p.следщ;
		}
		p = полн[i].следщ;
		while(p != полн[i]) {
			проверь(p.куча == this);
			проверь(p.класс == i);
			проверь(p.актив == p.чло());
			p = p.следщ;
		}
		p = пуст[i];
		if(p) {
			for(;;) {
				проверь(p.куча == this);
				проверь(p.актив == 0);
				проверь(p.класс == i);
				проверь(чекСтрОсвободи(p.списОсвоб, i) == p.чло());
				if(this != &вспом)
					break;
				p = p.следщ;
				if(!p)
					break;
			}
		}
		СсылНаОсвоб *l = кэш[i];
		while(l) {
			отлПроверьСвобК(l, i);
			l = l.следщ;
		}
	}
	УСсыл *l = самбольш.следщ;
	while(l != самбольш) {
		Заглав *bh = cast(Заглав *)(cast(ббайт *)l + САМБОЛЬШЗАГРР);
		while(bh.разм) {
			проверь(cast(ббайт *)bh >= cast(ббайт *)l + САМБОЛЬШЗАГРР && cast(ббайт *)bh < cast(ббайт *)l + 65536);
			if(bh.свободно)
				отлПроверьСвоб(bh.дайБлок() + 1, bh.разм - УСсыл.sizeof);
			bh = bh.далее();
		}
		l = l.следщ;
	}
	if(this != &вспом)
		вспом.чек();
}

проц проверьУтечки(бул b)
{
	if(!b)
		Panic("Обнаружены утечки памяти! (завершающая проверка)");
}

проц вспомЗаклЧек()
{
	Mutex.Lock __(мютекс);
	вспом.иниц();
	вспом.дистОсвободиСыро();
	вспом.чек();
	if(!вспом.рабоч[0].следщ)
		вспом.иниц();
	for(цел i = 0; i < НКЛАСС; i++) {
		проверь(!вспом.кэш[i]);
		ублЧек(вспом.рабоч[i]);
		ублЧек(вспом.полн[i]);
		проверьУтечки(вспом.рабоч[i] == вспом.рабоч[i].следщ);
		проверьУтечки(вспом.полн[i] == вспом.полн[i].следщ);
		Страница *p = вспом.пуст[i];
		if(p) {
			for(;;) {
				проверь(p.куча == &вспом);
				проверь(p.актив == 0);
				проверь(чекСтрОсвободи(p.списОсвоб, p.класс) == p.чло());
				p = p.следщ;
				if(!p)
					break;
			}
		}
	}
	проверьУтечки(вспом.самбольш == вспом.самбольш.следщ);
	проверьУтечки(больш == больш.следщ);
}


проц глобИницЛ()
{
	ONCELOCK {
		цел p = 32;
		цел bi = 0;
		while(p < МАКСБЛОК) {
			двРазм[bi++] = p;
			цел add = minmax(6 * p / 100 / 32 * 32, 32, 2048);
			p += add;
		}
		assert(bi == ОСТБИН - 1);
		двРазм[ОСТБИН - 1] = МАКСБЛОК;
		цел k = 0;
		for(цел i = 0; i < МАКСБЛОК / 8; i++) {
			while(i * 8 + 7 > двРазм[k])
				k++;
			размДв[i] = k;
		}
		k = ОСТБИН - 1;
		for(цел i = МАКСБЛОК / 8; i >= 0; i--) {
			while(i * 8 < двРазм[k]) k--;
			блДв[i] = k;
		}
		блДв[0] = 0;
		больш.привяжись();
		пустс.привяжись();
	}
}

проц освободиС(УСсыл *b, цел разм)
{
	цел q = блДв[разм >> 4];
	b.привяжи(свободноbin[q]);
}

Куча.УСсыл *добавьЧанк()
{
	УСсыл *ml;
	if(пустс.следщ != пустс) {
		ml = пустс.следщ;
		ml.отвяжи();
		LLOG("Retrieved пуст самбольш " << (ук )ml);
	}
	else {
		ml = cast(УСсыл *)РазместиСыро64КБ();
		LLOG("РазместиСыро64КБ " << (ук )ml);
	}
	члос++;
	LLOG("члос = " << члос);
	if(!ml) return пусто;
	ml.привяжи(самбольш);
	Заглав *bh = cast(Заглав *)(cast(ббайт *)ml + САМБОЛЬШЗАГРР);
	bh.разм = МАКСБЛОК;
	bh.предш = 0;
	bh.свободно = да;
	bh.куча = this;
	УСсыл *b = bh.дайБлок();
	освободиС(b, МАКСБЛОК);
	отлЗаполниСвоб(b + 1, МАКСБЛОК - УСсыл.sizeof);
	bh = bh.далее();
	bh.предш = МАКСБЛОК;
	bh.разм = 0;
	bh.свободно = нет;
	bh.куча = this;
	return b;
}


ук разделиБлок(УСсыл *b, цел разм, цел ii)
{
	b.отвяжи();
	Заглав *bh = b.дайЗаг();
	assert(bh.разм >= разм && разм > 0);
	bh.свободно = нет;
	цел sz2 = bh.разм - разм - Заглав.sizeof;
	if(sz2 >= 32) {
		Заглав *bh2 = cast(Заглав *)(cast(ббайт *)b + разм);
		bh2.предш = разм;
		bh2.свободно = да;
		bh2.куча = this;
		освободиС(bh2.дайБлок(), sz2);
		bh.далее().предш = bh2.разм = sz2;
		bh.разм = разм;
	}
	отлПроверьСвоб(b + 1, разм - УСсыл.sizeof);
	return b;
}

проц переместиБ(Куча *куда, УСсыл *l)
{
	куда.члос++;
	LLOG("Большое перемещение " << cast(ук )l << " в " << cast(ук )куда << " члос " << куда.члос);
	Mutex.Lock __(мютекс);
	l.отвяжи();
	l.привяжи(куда.самбольш);
	Заглав *h = cast(Заглав *)(cast(ббайт *)l + САМБОЛЬШЗАГРР);
	while(h.разм) {
		h.куча = куда;
		if(h.свободно) {
			УСсыл *b = h.дайБлок();
			b.отвяжи();
			куда.освободиС(b, h.разм);
		}
		h = h.далее();
	}
	вспом.члос = 10000;
}

проц переместиВПустое(УСсыл *l, Заглав *bh)
{
	LLOG("Перемещение пустого самбольш " << cast(ук )l << " в пустое глобальное хранилище, члос " << члос);
	bh.дайБлок().отвяжи();
	l.отвяжи();
	Mutex.Lock __(мютекс);
	l.привяжи(пустс);
	вспом.члос = 10000;
}


ук пробуйРазместитьЛок(цел ii, т_мера разм)
{
	while(ii < ОСТБИН) {
		if(свободноbin[ii] != свободноbin[ii].следщ) {
			ук укз = разделиБлок(свободноbin[ii].следщ, (цел)разм, ii);
			LLOG("пробуйРазместитьЛок успешно " << cast(ук )укз);
			assert((т_мера)укз & 8);
			return укз;
		}
		ii++;
	}
	return пусто;
}

цел sBig__;

ук разместиЛ(т_мера& разм) {
	LLOG("разместиЛ " << разм);
	assert(разм > 256);
	if(!инициализирован)
		иниц();
	if(разм > МАКСБЛОК) {
		Mutex.Lock __(мютекс);
		БольшЗаг *h = cast(БольшЗаг *)СисРазместиСыро(разм + БОЛЬШЗАГРР);
		if(!h)
			Panic("Out of memory!");
		h.привяжи(больш);
		h.разм = разм = ((разм + БОЛЬШЗАГРР + 4095) & ~4095) - БОЛЬШЗАГРР;
		Заглав *b = cast(Заглав *)((ббайт *)h + БОЛЬШЗАГРР - Заглав.sizeof);
		b.разм = 0;
		b.свободно = нет;
		sBig__++;
		LLOG("Big alloc " << (ук )b.дайБлок());
		return b.дайБлок();
	}
	цел bini = размВБин(cast(цел)разм);
	разм = двРазм[bini];
	ук укз = пробуйРазместитьЛок(bini, разм);
	if(укз)
		return укз;
	Mutex.Lock __(мютекс);
	if(remote_свободно) {
		дистОсвободиСыро();
		укз = пробуйРазместитьЛок(bini, разм);
		if(укз) return укз;
	}
	вспом.дистОсвободиСыро();
	while(вспом.самбольш.следщ != вспом.самбольш) {
		LLOG("Подбирается болк самбольш " << (ук )вспом.самбольш.следщ);
		переместиБ(this, вспом.самбольш.следщ);
		члос++;
		укз = пробуйРазместитьЛок(bini, разм);
		if(укз) return укз;
	}
	УСсыл *n = добавьЧанк();
	if(!n)
		throw new ВнеПамИскл;
	укз = разделиБлок(n, cast(цел)разм, ОСТБИН - 1);
	LLOG("разместиЛ с помощью добавьЧанк " << (ук )укз);
	assert(cast(т_мера)укз & 8);
	return укз;
}

проц освободиЛ(ук укз) {
	УСсыл  *b = cast(УСсыл *)укз;
	Заглав *bh = b.дайЗаг();
	if(bh.разм == 0) {
		Mutex.Lock __(мютекс);
		assert((cast(бкрат)cast(uintptr_t)bh & 4095) == БОЛЬШЗАГРР - Заглав.sizeof);
		БольшЗаг *h = cast(БольшЗаг *)(cast(ббайт *)укз - БОЛЬШЗАГРР);
		h.отвяжи();
		LLOG("Большое освобождение " << cast(ук ) укз << " разм " << h.разм);
		СисОсвободиСыро(h, h.разм);
		sBig__--;
		return;
	}
	if(bh.куча != this) {
		LLOG("Дист самбольш, куча " << cast(ук )bh.куча);
		bh.куча.RemoteFree(укз);
		return;
	}
	if(bh.предш) {
		Заглав *p = bh.ранее();
		if(p.свободно) {
			b = p.дайБлок();
			b.отвяжи();
			p.разм += bh.разм + Заглав.sizeof;
			p.далее().предш = p.разм;
			bh = p;
		}
	}
	Заглав *n = bh.далее();
	if(n.свободно) {
		n.дайБлок().отвяжи();
		bh.разм += n.разм + Заглав.sizeof;
		n.далее().предш = bh.разм;
	}
	bh.свободно = да;
	освободиС(b, bh.разм);
	отлЗаполниСвоб(b + 1, bh.разм - УСсыл.sizeof);
	LLOG("Освобождено, присоединено разм " << bh.разм << " члос " << члос);
	if(bh.разм == МАКСБЛОК && члос > 1) {
		УСсыл *l = cast(УСсыл *)(cast(ббайт *)bh - САМБОЛЬШЗАГРР);
		члос--;
		переместиВПустое(l, bh);
	}
}

static цел  размВБин(цел n) { return размДв[(n - 1) >> 3]; }
	

Куча.Страница* рабочСтраница(цел k)
{
	LLOG("РазместиК - следщ рабоч недоступна " << k << " пуст: " << (ук )пуст[k]);
	Страница *стр = пуст[k];
	пуст[k] = пусто;
	if(!стр) {
		LLOG("РазместиК - попытка выполнить FreeRemote");
		FreeRemote();
		if(рабоч[k].списОсвоб) {
			LLOG("РазместиК - рабоч доступна после FreeRemote " << k);
			return рабоч[k];
		}
		стр = пуст[k];
		пуст[k] = пусто;
	}
	if(!стр)
		for(цел i = 0; i < НКЛАСС; i++)
			if(пуст[i]) {
				LLOG("РазместиК - свободн стр доступных для реформатирования " << k);
				стр = пуст[i];
				пуст[i] = пусто;
				стр.форматируй(k);
				break;
			}
	if(!стр) {
		Mutex.Lock __(мютекс);
		вспом.дистОсвободиСыро();
		if(вспом.рабоч[k].следщ != вспом.рабоч[k]) {
			стр = вспом.рабоч[k].следщ;
			стр.отвяжи();
			стр.куча = this;
			LLOG("РазместиК - адаптирование вспом стр " << k << " стр: " << (ук )стр << ", свободно " << (ук )стр.списОсвоб);
		}
		if(!стр && вспом.пуст[k]) {
			стр = вспом.пуст[k];
			вспом.пуст[k] = стр.следщ;
			LLOG("РазместиК - пуст вспом стр доступных того же формата " << k << " стр: " << (ук )стр << ", свободно " << (ук )стр.списОсвоб);
		}
		if(!стр)
			for(цел i = 0; i < НКЛАСС; i++)
				if(вспом.пуст[i]) {
					стр = вспом.пуст[i];
					вспом.пуст[i] = стр.следщ;
					стр.форматируй(k);
					LLOG("РазместиК - пуст вспом стр доступных для реформатирования " << k << " стр: " << (ук )стр << ", свободно " << cast(ук )стр.списОсвоб);
					break;
				}
		if(!стр) {
			стр = cast(Страница *)РазместиСыро4КБ();
			LLOG("РазместиК - размещена новая системная стр " << (ук )стр << " " << k);
			стр.форматируй(k);
		}
		стр.куча = this;
	}
	стр.привяжи(рабоч[k]);
	assert(стр.класс == k);
	return стр;
}

ук РазместиК(цел k)
{
	LLOG("РазместиК " << k);
	if(!инициализирован)
		иниц();
	Страница *стр = рабоч[k].следщ;
	for(;;) {
		assert(стр.класс == k);
		СсылНаОсвоб *p = стр.списОсвоб;
		if(p) {
			LLOG("РазместиК размещается из " << cast(ук )стр << " " << cast(ук )p);
			стр.списОсвоб = p.следщ;
			++стр.актив;
			return p;
		}
		LLOG("РазместиК - стр исчерпана " << k << " стр: " << cast(ук )стр);
		if(стр.следщ != стр) {
			LLOG("Перемещение " << cast(ук )стр << " в полн");
			стр.отвяжи();
			стр.привяжи(полн[k]);
			стр = рабоч[k].следщ;
		}
		if(стр.следщ == стр)
			стр = рабочСтраница(k);
	}
}

ук разместик(цел k)
{
	СсылНаОсвоб *укз = кэш[k];
	if(укз) {
		вкэше[k]++;
		кэш[k] = укз.следщ;
		return отлПроверьСвобK(укз, k);
	}
	return отлПроверьСвобK(РазместиК(k), k);
}


ук размести(т_мера рр)
{
	стат(рр);
	if(рр <= 224) {
		if(рр == 0) рр = 1;
		return разместик((cast(цел)рр - 1) >> 4);
	}
	if(рр <= 576)
		return разместик(рр <= 368 ? рр <= 288 ? 14 : 15 : рр <= 448 ? 16 : 17);
	return разместиЛ(рр);
}

ук разместиРр(т_мера& рр)
{
	стат(рр);
	if(рр <= 224) {
		if(рр == 0) рр = 1;
		цел k = (cast(цел)рр - 1) >> 4;
		рр = (k + 1) << 4;
		return разместик(k);
	}
	if(рр <= 576) {
		цел k;
		if(рр <= 368)
			if(рр <= 288)
				рр = 288, k = 14;
			else
				рр = 368, k = 15;
		else
			if(рр <= 448)
				рр = 448, k = 16;
			else
				рр = 576, k = 17;
		return разместик(k);
	}
	return разместиЛ(рр);
}

проц освободиК(ук укз, Страница *стр, цел k)
{
	if(стр.списОсвоб) {
		LLOG("Освобождение следщ из рабоч стр " << k);
		((СсылНаОсвоб *)укз).следщ = стр.списОсвоб;
	}
	else {
		LLOG("Освобождение полн в рабоч " << k << " куча: " << (ук )стр.куча);
		стр.отвяжи();
		стр.привяжи(рабоч[k]);
		(cast(СсылНаОсвоб *)укз).следщ = пусто;
	}
	стр.списОсвоб = (СсылНаОсвоб *)укз;
	if(--стр.актив == 0) {
		LLOG("Свободн стр пуст" << " " << (ук )стр);
		стр.отвяжи();
		if(this == &вспом) {
			LLOG("...есть вспом");
			стр.следщ = пуст[k];
			пуст[k] = стр;
		}
		else {
			if(пуст[k]) {
				LLOG("Глобально свободно " << k << " " << cast(ук )пуст[k]);
				Mutex.Lock __(мютекс);
				пуст[k].куча = &вспом;
				пуст[k].следщ = вспом.пуст[k];
				вспом.пуст[k] = пуст[k];
			}
			пуст[k] = стр;
		}
	}
}

проц освободи(ук укз)
{
	if(!укз) return;
	LLOG("освободи " << укз);
	if(((cast(бкрат)cast(uintptr_t)укз) & 8) == 0) {
		Страница *стр = cast(Страница *)(cast(uintptr_t)укз & ~cast(uintptr_t)4095);
		цел k = стр.класс;
		LLOG("Small свободно стр: " << cast(ук )стр << ", k: " << k << ", ksz: " << размерКласса(k));
		assert((4096 - (cast(uintptr_t)укз & cast(uintptr_t)4095)) % размерКласса(k) == 0);
version(_MULTITHREADED)
{
		if(стр.куча != this) {
			стр.куча.RemoteFree(укз);
			return;
		}
}
		отлЗаполниСвобK(укз, k);
		if(вкэше[k]) {
			вкэше[k]--;
			СсылНаОсвоб *l = cast(СсылНаОсвоб *)укз;
			l.следщ = кэш[k];
			кэш[k] = l;
			return;
		}
		освободиК(укз, стр, k);
	}
	else
		освободиЛ(укз);
}

проц освободиПрямо(ук укз)
{
	LLOG("освободи Direct " << укз);
	if(((cast(бкрат)cast(uintptr_t)укз) & 8) == 0) {
		Страница *стр = (Страница *)(cast(uintptr_t)укз & ~cast(uintptr_t)4095);
		цел k = стр.класс;
		LLOG("Small свободно стр: " << (ук )стр << ", k: " << k << ", ksz: " << размерКласса(k));
		assert((4096 - (cast(uintptr_t)укз & cast(uintptr_t)4095)) % размерКласса(k) == 0);
		отлЗаполниСвобK(укз, k);
		освободиК(укз, стр, k);
	}
	else
		освободиЛ(укз);
}

ук размести32()
{
	стат(32);
	return разместик(1);
}


проц освободи32(ук укз)
{
	Страница *стр = cast(Страница *)(cast(uintptr_t)укз & ~cast(uintptr_t)4095);
	LLOG("Small свободно стр: " << cast(ук )стр << ", k: " << k << ", ksz: " << размерКласса(k));
	assert((4096 - (cast(uintptr_t)укз & cast(uintptr_t)4095)) % размерКласса(1) == 0);
version(_MULTITHREADED)
{
	if(стр.куча != this) {
		стр.куча.RemoteFree(укз);
		return;
	}
}
	отлЗаполниСвобK(укз, 1);
	if(вкэше[1]) {
		вкэше[1]--;
		СсылНаОсвоб *l = cast(СсылНаОсвоб *)укз;
		l.следщ = кэш[1];
		кэш[1] = l;
		return;
	}
	освободиК(укз, стр, 1);
}

ук размести48()
{
	стат(48);
	return разместик(2);
}

проц освободи48(ук укз)
{
	Страница *стр = cast(Страница *)(cast(uintptr_t)укз & ~cast(uintptr_t)4095);
	LLOG("Small свободно стр: " << cast(ук )стр << ", k: " << k << ", ksz: " << размерКласса(k));
	assert((4096 - (cast(uintptr_t)укз & cast(uintptr_t)4095)) % размерКласса(2) == 0);
version(_MULTITHREADED)
{
	if(стр.куча != this) {
		стр.куча.RemoteFree(укз);
		return;
	}
}
	отлЗаполниСвобK(укз, 2);
	if(вкэше[2]) {
		вкэше[2]--;
		СсылНаОсвоб *l = cast(СсылНаОсвоб *)укз;
		l.следщ = кэш[2];
		кэш[2] = l;
		return;
	}
	освободиК(укз, стр, 2);
}

	проц  освободик(ук укз, цел k){}

};
//кон кучи

version(HEAPDBG)
{
	ук РазместиПам_(т_мера рр)
	{
		return куча.размести(рр);
	}

	проц  ОсвободиПам_(ук укз)
	{
		куча.освободи(укз);
	}
}
else
{
	ук РазместиПам(т_мера рр)
	{
		return куча.размести(рр);
	}

	ук РазместиПамРр(т_мера& рр)
	{
		return куча.разместиРр(рр);
	}

	проц  ОсвободиПам(ук укз)
	{
		куча.освободи(укз);
	}

	ук РазместиПам32()
	{
		return куча.размести32();
	}
}
+/