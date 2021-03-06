﻿//Автор Кристофер Миллер. Переработано для Динрус Виталием Кулич.
//Библиотека визуальных конпонентов VIZ (первоначально DFL).
module viz.label;

private import viz.common, viz.control, viz.app;


extern(D) class Надпись: УпрЭлт
{
	this();
	проц стильКромки(ПСтильКромки bs);
	ПСтильКромки стильКромки() ;
	final проц использоватьМнемонику(бул подтвержд);
	final бул использоватьМнемонику();
	Размер предпочитаемыйРазмер();	
	override проц текст(Ткст newText);
	alias УпрЭлт.текст текст;
	проц автоРазмер(бул подтвержд);
	бул автоРазмер();
	проц разместиТекст(ПРасположение calign);
	ПРасположение разместиТекст();
	protected override Размер дефРазм();
	protected override проц приОтрисовке(АргиСобРис ea);
	protected override проц приИзмененииВключения(АргиСоб ea);
	protected override проц приИзмененииШрифта(АргиСоб ea);
	protected override проц окПроц(inout Сообщение m);
	protected override бул обработайМнемонику(дим кодСим);
}


