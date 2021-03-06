﻿/*******************************************************************************

        copyright:      Copyright (c) 2005 John Chapman. все rights reserved

        license:        BSD стиль: $(LICENSE)

        version:        Jan 2005: начальное release
                        Mar 2009: выкиньed из_ локаль, и 
                                  преобразованый в_ a struct

        author:         John Chapman, Kris, mwarning

        Support for formatting дата/время значения, in a локаль-specific
        manner. See МестнДатаВремя.форматируй() for a descrИПtion on как 
        formatting is performed (below).

        Reference линки:
        ---
        http://www.opengroup.org/onlinepubs/007908799/xsh/strftime.html
        http://msdn.microsoft.com/en-us/library/system.globalization.datetimeformatinfo(VS.71).aspx
        ---

******************************************************************************/

module text.convert.DateTime;

private import  exception;

private import  time.WallClock;

private import  time.chrono.Calendar,
                time.chrono.Gregorian;

private import  Utf = text.convert.Utf;

private import  Целое = text.convert.Integer;

version (СРасширениями)
         private import text.convert.Extentions;

/******************************************************************************

        O/S specifics
                
******************************************************************************/

version (Windows)
         private import sys.Common;
else
{
        private import stringz;
        private import rt.core.stdc.posix.langinfo;
}

/******************************************************************************

        The default МестнДатаВремя экземпляр
                
******************************************************************************/

public МестнДатаВремя ДефДатаВремя;

static this()
{       
        ДефДатаВремя = МестнДатаВремя.создай;
version (СРасширениями)
        {
        Расширения8.добавь  (typeid(Время), &ДефДатаВремя.мост!(сим));
        Расширения16.добавь (typeid(Время), &ДефДатаВремя.мост!(шим));
        Расширения32.добавь (typeid(Время), &ДефДатаВремя.мост!(дим));
        }
}

/******************************************************************************

        How в_ форматируй локаль-specific дата/время вывод

******************************************************************************/

struct МестнДатаВремя
{       
        static ткст   образецРФС1123 = "ddd, dd MMM yyyy HH':'mm':'ss 'GMT'";
        static ткст   сортируемыйОбразецДатыВремени = "yyyy'-'MM'-'dd'T'HH':'mm':'ss";
        static ткст   универсальныйСортируемыйОбразецДатыВремени = "yyyy'-'MM'-'dd' 'HH':'mm':'ss'Z'";

        Календарь        назначенныйКалендарь;

        ткст          краткийОбразецДаты,
                        краткийОбразецВремени,
                        длинныйОбразецДаты,
                        длинныйОбразецВремени,
                        полныйОбразецДатыВремени,
                        общКраткийОбразецВремени,
                        общДлинныйОбразецВремени,
                        образецДняМесяца,
                        образецМесяцаГода;

        ткст          определительДоПолудня,
                        определительПослеПолудня;

        ткст          разделительВремени,
                        разделительДаты;

        ткст[]        именаДней,
                        именаМесяцев,
                        сокращённыеИменаДней,
                        сокращённыеИменаМесяцев;

        /**********************************************************************

                Формат the given Время значение преобр_в the provопрed вывод, 
                using the specified выкладка. The выкладка can be a генерный
                variant or a custom one, where generics are indicated
                via a single character:
                
                <pre>
                "t" = 7:04
                "T" = 7:04:02 PM 
                "d" = 3/30/2009
                "D" = Понедельник, March 30, 2009
                "f" = Понедельник, March 30, 2009 7:04 PM
                "F" = Понедельник, March 30, 2009 7:04:02 PM
                "g" = 3/30/2009 7:04 PM
                "G" = 3/30/2009 7:04:02 PM
                "y"
                "Y" = March, 2009
                "r"
                "R" = Mon, 30 Mar 2009 19:04:02 GMT
                "s" = 2009-03-30T19:04:02
                "u" = 2009-03-30 19:04:02Z
                </pre>
        
                For the US локаль, these генерный layouts are expanded in the 
                following manner:
                
                <pre>
                "t" = "h:mm" 
                "T" = "h:mm:ss tt"
                "d" = "M/d/yyyy"  
                "D" = "dddd, MMMM d, yyyy" 
                "f" = "dddd, MMMM d, yyyy h:mm tt"
                "F" = "dddd, MMMM d, yyyy h:mm:ss tt"
                "g" = "M/d/yyyy h:mm tt"
                "G" = "M/d/yyyy h:mm:ss tt"
                "y"
                "Y" = "MMMM, yyyy"        
                "r"
                "R" = "ddd, dd MMM yyyy HH':'mm':'ss 'GMT'"
                "s" = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"      
                "u" = "yyyy'-'MM'-'dd' 'HH':'mm':'ss'Z'"   
                </pre>

                Custom layouts are constructed using a combination of the 
                character codes indicated on the right, above. For example, 
                a выкладка of "dddd, dd MMM yyyy HH':'mm':'ss zzzz" will излей 
                something like this:
                ---
                Понедельник, 30 Mar 2009 19:04:02 -08:00
                ---

                Using these форматируй indicators with Выкладка (Стдвыв etc) is
                straightforward. Formatting целыйs, for example, is готово
                like so:
                ---
                Стдвыв.форматнс ("{:u}", 5);
                Стдвыв.форматнс ("{:b}", 5);
                Стдвыв.форматнс ("{:x}", 5);
                ---

                Formatting дата/время значения is similar, where the форматируй
                indicators are provопрed after the colon:
                ---
                Стдвыв.форматнс ("{:t}", Часы.сейчас);
                Стдвыв.форматнс ("{:D}", Часы.сейчас);
                Стдвыв.форматнс ("{:dddd, dd MMMM yyyy HH:mm}", Часы.сейчас);
                ---

        **********************************************************************/

        ткст форматируй (ткст вывод, Время датаВремя, ткст выкладка);

        /**********************************************************************

        **********************************************************************/

        T[] шФормат(T) (T[] вывод, Время датаВремя, T[] фмт)
        {
                static if (is (T == сим))
                           return форматируй (вывод, датаВремя, фмт);
                else
                   {
                   сим[128] tmp0 =void;
                   сим[128] tmp1 =void;
                   return Utf.изТкст8(форматируй(tmp0, датаВремя, Utf.вТкст(фмт, tmp1)), вывод);
                   }
        }

        /**********************************************************************

                Return a генерный English/US экземпляр

        **********************************************************************/

        static МестнДатаВремя* генерный ();

        /**********************************************************************

                Return the назначено Календарь экземпляр, using Грегориан
                as the default

        **********************************************************************/

        Календарь календарь ();

        /**********************************************************************

                Return a крат день имя 

        **********************************************************************/

        ткст сокращённоеИмяДня (Календарь.ДеньНедели ДеньНедели);

        /**********************************************************************

                Return a дол день имя

        **********************************************************************/

        ткст имяДня (Календарь.ДеньНедели ДеньНедели);
                       
        /**********************************************************************

                Return a крат месяц имя

        **********************************************************************/

        ткст сокращённоеИмяМесяца (цел месяц);

        /**********************************************************************

                Return a дол месяц имя

        **********************************************************************/

        ткст имяМесяца (цел месяц);

version (Windows)
        {
        /**********************************************************************

                создай и наполни an экземпляр via O/S configuration
                for the текущ пользователь

        **********************************************************************/

        static МестнДатаВремя создай ();
        }
else
        {
        /**********************************************************************

                создай и наполни an экземпляр via O/S configuration
                for the текущ пользователь

        **********************************************************************/

        static МестнДатаВремя создай ();

        /**********************************************************************

                Convert POSIX дата время форматируй в_ .NET форматируй syntax.

        **********************************************************************/

        private static ткст преобразуй(ткст фмт);
        }

        /**********************************************************************

        **********************************************************************/

        private ткст разверниИзвестныйФормат (ткст формат);

        /**********************************************************************

        **********************************************************************/

        private ткст форматируйОсобо (ref Результат результат, Время датаВремя, ткст форматируй);

        /**********************************************************************

        **********************************************************************/

        private ткст форматируйМесяц (цел месяц, цел rpt);

        /**********************************************************************

        **********************************************************************/

        private ткст форматируйДеньНедели (Календарь.ДеньНедели ДеньНедели, цел rpt);

        /**********************************************************************

        **********************************************************************/

        private T[] мост(T) (T[] результат, ук арг, T[] форматируй)
        {
                return шФормат (результат, *cast(Время*) арг, форматируй);
        }

        /**********************************************************************

        **********************************************************************/

        private static цел повториРазбор(ткст форматируй, цел поз, сим c);

        /**********************************************************************

        **********************************************************************/

        private static ткст форматируйЦел (ткст врем, цел v, цел minimum);

        /**********************************************************************

        **********************************************************************/

        private static цел разборКавычек (ref Результат результат, ткст форматируй, цел поз);
}

/******************************************************************************
        
        An english/usa локаль
        Used as генерный МестнДатаВремя.

******************************************************************************/

private МестнДатаВремя RuRU = 
{
        краткийОбразецДаты                : "M/d/yyyy",
        краткийОбразецВремени                : "h:mm",       
        длинныйОбразецДаты                 : "dddd, MMMM d, yyyy",
        длинныйОбразецВремени                 : "h:mm:ss tt",        
        полныйОбразецДатыВремени             : "dddd, MMMM d, yyyy h:mm:ss tt",
        общКраткийОбразецВремени         : "M/d/yyyy h:mm",
        общДлинныйОбразецВремени          : "M/d/yyyy h:mm:ss tt",
        образецДняМесяца                 : "MMMM d",
        образецМесяцаГода                : "MMMM, yyyy",
        определительДоПолудня                    : "AM",
        определительПослеПолудня                    : "PM",
        разделительВремени                   : ":",
        разделительДаты                   : "/",
        именаДней                        : ["Sunday", "Monday", "TuesDay", "Wednesday", 
                                           "Thursday", "Friday", "Saturday"],
        именаМесяцев                      : ["January", "February", "March", "April", 
                                           "May", "June", "July", "August", "September", 
                                           "October" "November", "December"],
        сокращённыеИменаДней             : ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],    
        сокращённыеИменаМесяцев           : ["Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                           "Jul", "Aug", "Sep", "Oct" "Nov", "Dec"],
};


/******************************************************************************

******************************************************************************/

private struct Результат
{
        private бцел    индекс;
        private ткст  target_;

        /**********************************************************************

        **********************************************************************/

        private static Результат opCall (ткст мишень);

        /**********************************************************************

        **********************************************************************/

        private проц opCatAssign (ткст rhs);

        /**********************************************************************

        **********************************************************************/

        private проц opCatAssign (сим rhs);

        /**********************************************************************

        **********************************************************************/

        private ткст получи ();
}

/******************************************************************************

******************************************************************************/

debug (ДатаВремя)
{
        import io.Stdout;

        проц main()
        {
                сим[100] врем;
                auto время = Куранты.сейчас;
                auto локаль = МестнДатаВремя.создай;

                Стдвыв.форматнс ("d: {}", локаль.форматируй (врем, время, "d"));
                Стдвыв.форматнс ("D: {}", локаль.форматируй (врем, время, "D"));
                Стдвыв.форматнс ("f: {}", локаль.форматируй (врем, время, "f"));
                Стдвыв.форматнс ("F: {}", локаль.форматируй (врем, время, "F"));
                Стдвыв.форматнс ("g: {}", локаль.форматируй (врем, время, "g"));
                Стдвыв.форматнс ("G: {}", локаль.форматируй (врем, время, "G"));
                Стдвыв.форматнс ("r: {}", локаль.форматируй (врем, время, "r"));
                Стдвыв.форматнс ("s: {}", локаль.форматируй (врем, время, "s"));
                Стдвыв.форматнс ("t: {}", локаль.форматируй (врем, время, "t"));
                Стдвыв.форматнс ("T: {}", локаль.форматируй (врем, время, "T"));
                Стдвыв.форматнс ("y: {}", локаль.форматируй (врем, время, "y"));
                Стдвыв.форматнс ("u: {}", локаль.форматируй (врем, время, "u"));
                Стдвыв.форматнс ("@: {}", локаль.форматируй (врем, время, "@"));
                Стдвыв.форматнс ("{}", локаль.генерный.форматируй (врем, время, "ddd, dd MMM yyyy HH':'mm':'ss zzzz"));
        }
}
