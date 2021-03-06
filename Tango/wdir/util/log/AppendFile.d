﻿/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. все rights reserved

        license:        BSD стиль: $(LICENSE)
      
        version:        Initial release: May 2004
        
        author:         Kris

*******************************************************************************/

module util.log.AppendFile;

private import  util.log.Log;
private import  io.device.File;
private import  io.stream.Buffered;
private import  io.model;

/*******************************************************************************

        Добавляет сообщения лога в файл. У базовой версии отсутствует поддержка
		rollover, поэтому просто идёт потоянная добавь в файл. ДобВФайлы может
		удовлетворить ваши замыслы.

*******************************************************************************/

class ДобВФайл : Файлер
{
        private Маска    маска_;

        /***********************************************************************
                
            Создаёт базовый FileAppender в файл, расположенный по заданному пути.

        ***********************************************************************/

        this (ткст fp, Добавщик.Выкладка как = пусто)
        {
                // Получить уникальный fingerprint для данного экземпляр
                маска_ = регистрируй (fp);
        
                // сделать открытым для совместного чтения
                auto стиль = Файл.ЧитДоб;
                стиль.совместно = Файл.Общ.Чит;
                конфигурируй (new Файл (fp, стиль));
                выкладка (как);
        }

        /***********************************************************************
                
                Вернуть fingerprint для данного класса

        ***********************************************************************/

        final Маска маска ()
        {
                return маска_;
        }

        /***********************************************************************
                
                Вернуть имя данного класса

        ***********************************************************************/

        final ткст имя ()
        {
                return this.classinfo.имя;
        }
                
        /***********************************************************************
                
                Добавить на вывод событие.
                 
        ***********************************************************************/

        final synchronized проц добавь (СобытиеЛога событие)
        {
                выкладка.форматируй (событие, &буфер.пиши);
                буфер.добавь (ФайлКонст.НовСтрЗнак)
                      .слей;
        }
}


/*******************************************************************************

        Класс-основа для добавщиков в файл.

*******************************************************************************/

class Файлер : Добавщик
{
        package Бвыв            буфер;
        private ИПровод        провод_;

        /***********************************************************************
                
                Вернуть провод.

        ***********************************************************************/

        final ИПровод провод ()
        {
                return провод_;
        }

        /***********************************************************************
                
                Закрыть файл, ассоциированный с этим Добавщиком.

        ***********************************************************************/

        final synchronized проц закрой ()
        {
                if (провод_)
                   {
                   провод_.открепи;
                   провод_ = пусто;
                   }
        }

        /***********************************************************************
                
                Установить провод.

        ***********************************************************************/

        package final Бвыв конфигурируй (ИПровод провод)
        {
                // создай a new буфер upon this провод
                провод_ = провод;
                return (буфер = new Бвыв(провод));
        }
}


