﻿
import viz.form, viz.app, viz.common, viz.environment;
pragma(lib,"Viz.lib");

Среда среда;

class ГлавнаяФорма: Форма
{
	this()
	{
	иницФорму();
	}
	
	
	private void иницФорму()
	{
	скажинс("Инициализация формы началась");
		текст("My Form");
		скажинс("Текст установлен");
		клиентРазм(Размер(292, 266));
		скажинс("Размер формы задан");
		виден(да);
		скажинс("Форма инициализирована");
	}
}

цел main()
{
Приложение прил;
цел рез = 0;
//Среда среда;
ГлавнаяФорма гф;
	
//скажинс(среда.команднаяСтрока());
//скажинс(среда.текущаяПапка());
//скажинс(среда.имяМашины());
//скажинс(среда.папкаСистемы());
//throw new ВизИскл("Проверка");
	try
	{
		прил.вклВизСтили();
		//скажинс("ВизСтили включены");
		//скажинс(прил.путьКПрог());
		прил.пуск(гф = new ГлавнаяФорма);
		//скажинс("Форма запущена");
	}
	catch(Объект о)
	{
	//ОкноСооб(o.toString(), "Fatal Error", MsgBoxButtons.ОК, MsgBoxIcon.ERROR);
		о.выведи;
		рез = 1;
	}
	
	return рез;
}

