﻿/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. все rights reserved

        license:        BSD стиль: $(LICENSE)
      
        version:        Initial release: May 2004
        
        author:         Kris

*******************************************************************************/

module util.log.LayoutData;

private import  text.Util;

private import  time.Clock,
                time.WallClock;

private import  util.log.Log;

private import  Целое = text.convert.Integer;

/*******************************************************************************

        A выкладка with ISO-8601 дата information псеп_в_начале в_ each сообщение
       
*******************************************************************************/

public class ДанныеОВыкладке : Добавщик.Выкладка
{
        private бул местноеВремя;

        /***********************************************************************
        
                Ctor with indicator for local vs UTC время. Default is 
                local время.
                        
        ***********************************************************************/

        this (бул местноеВремя = да)
        {
                this.местноеВремя = местноеВремя;
        }

        /***********************************************************************
                
                Subclasses should implement this метод в_ perform the
                formatting of the actual сообщение контент.

        ***********************************************************************/

        проц форматируй (СобытиеЛога событие, т_мера delegate(проц[]) дг)
        {
                ткст уровень = событие.имяУровня;
                
                // преобразуй время в_ field значения
                auto tm = событие.время;
                auto dt = (местноеВремя) ? Куранты.вДату(tm) : Часы.вДату(tm);
                                
                // форматируй дата according в_ ISO-8601 (lightweight форматёр)
                сим[20] врем =void;
                сим[256] tmp2 =void;
                дг (выкладка (tmp2, "%0-%1-%2 %3:%4:%5,%6 %7 [%8] - ", 
                            преобразуй (врем[0..4],   dt.дата.год),
                            преобразуй (врем[4..6],   dt.дата.месяц),
                            преобразуй (врем[6..8],   dt.дата.день),
                            преобразуй (врем[8..10],  dt.время.часы),
                            преобразуй (врем[10..12], dt.время.минуты),
                            преобразуй (врем[12..14], dt.время.сек),
                            преобразуй (врем[14..17], dt.время.миллисек),
                            уровень,
                            событие.имя
                            ));
                дг (событие.вТкст);
        }

        /**********************************************************************

                Convert an целое в_ a zero псеп_в_начале текст representation

        **********************************************************************/

        private ткст преобразуй (ткст врем, дол i)
        {
                return Целое.форматёр (врем, i, 'u', '?', 8);
        }
}
