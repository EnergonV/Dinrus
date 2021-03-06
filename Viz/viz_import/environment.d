﻿//Автор Кристофер Миллер. Переработано для Динрус Виталием Кулич.
//Библиотека визуальных конпонентов VIZ (первоначально DFL).

module viz.environment;

private import viz.common;


extern(D)  class Среда
{
	this();
	
	static:
	
	Ткст команднаяСтрока();
	проц текущаяПапка(Ткст cd);
	Ткст текущаяПапка();
	Ткст имяМашины() ;	
	Ткст новСтр();
	ОперационнаяСистема версияОС();
	Ткст папкаСистемы();
	DWORD счётТиков();
	Ткст имяПользователя();
	проц выход(цел code);
	Ткст разверниПеременныеСреды(Ткст str);
	Ткст[] дайАргументыКоманднойСтроки();
	Ткст дайПеременнуюСреды(Ткст имя);
	Ткст[] дайЛогическиеДиски();

}

extern(D) class Версия 
{
	this();
	final:
	this(Ткст str);
	this(цел майор, цел минор);
	this(цел майор, цел минор, цел постройка);
	this(цел майор, цел минор, цел постройка, цел ревизия);
	Ткст вТкст();
	цел майор();
	цел минор();
	цел постройка();
	цел ревизия() ;
}


extern(D) class ОперационнаяСистема 
{
		this(ИдПлатформы platId, Версия вер);
		Ткст вТкст();
		ИдПлатформы платформа();
		Версия вер();
}

