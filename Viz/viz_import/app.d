﻿//Автор Кристофер Миллер. Переработано для Динрус Виталием Кулич.
//Библиотека визуальных конпонентов VIZ (первоначально DFL).


module viz.app;

private import stdrus;


private import viz.common, viz.form, viz.event;
private import viz.control, viz.label;
private import viz.button, viz.textbox, viz.environment;
private import viz.resources, viz.menu;


extern(D):

 class КонтекстПриложения
 {
	this();
	this(Форма главФорма);
	final проц главФорма(Форма главФорма);
	final Форма главФорма();
	final проц выйдиИзНити();
	проц выйдиИзЯдраНити();
	проц приЗакрытииГлавФормы(Объект отправитель, АргиСоб арги);
}


class Приложение // docmain
{

	static:
		Событие!(Объект, АргиСоб) вБездействии; // Finished processing and is now вБездействии.
		Событие!(Объект, АргиСобИсклНити) исклНити;
		Событие!(Объект, АргиСоб) выходИзНити;
	
	
	проц вклВизСтили();
	Ткст путьКПрог() ;
	Ткст папкаСтарта();
	Ткст дайОсобыйПуть(Ткст имя) ;
	Ткст путьКАппДата() ;
	бул циклСооб() ;
	проц добавьФильтрСооб(ИФильтрСооб mf);
	проц удалиФильтрСооб(ИФильтрСооб mf);
	бул вершиСобытия();
	бул вершиСобытия(бцел msDelay);
	проц пуск();
	проц пуск(проц delegate() бездействуя);
	проц пуск(КонтекстПриложения конткстприл);
	проц пуск(КонтекстПриложения конткстприл, проц delegate() бездействуя);
	проц пуск(Форма главФорма, проц delegate() бездействуя);
	проц пуск(Форма главФорма);
	проц выход();
	проц выйдиИзНити();
	проц устЭкз(экз экземп);
	
	static class ОшФорма: Форма
	{	
		проц приНажатииОк(Объект отправитель, АргиСоб ea);		
		проц приНажатииОтмена(Объект отправитель, АргиСоб ea);		
		this(Ткст ошсооб);
		бул продолжай();
		Ткст вТкст();
	}	
	бул покажиДефДиалогИскл(Объект e);
	проц приИсклНити(Объект e);
	проц автоСбор(бул подтвержд);	
	бул автоСбор() ;	
	проц ждиСобытия();
}
