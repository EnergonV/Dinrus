﻿/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. все rights reserved

        license:        BSD стиль: $(LICENSE)
      
        version:        Initial release: May 2004
        
        author:         Kris

*******************************************************************************/

module util.log.Config;

public  import  util.log.Log : Журнал;

private import  util.log.LayoutData,
                util.log.AppendConsole;

/*******************************************************************************

        Средство для инициализации базового поведения дефолтной иерархии
		журналирования.

        Вводит дефолтный консольный добавщик с генерной выкладкой в корневой
		узел и устанавливает уровень активности для активирования всего
                
*******************************************************************************/


static this ()
{
        Журнал.корень.добавь (new ДобВКонсоль (new ДанныеОВыкладке));
}

