﻿
module io.model;


interface ФайлКонст
{

        version (Win32)
        {
                ///
                enum : сим 
                {
                        /// The текущ дир character
                        СимТекПап = '.',
                        
                        /// The файл разделитель character
                       СимФайлРазд = '.',
                        
                        /// The путь разделитель character
                        СимПутьРазд = '/',
                        
                        /// The system путь character
                        СимСистПуть = ';',
                }

                /// The предок дир ткст
                static const ткст ТкстРодПап = "..";
                
                /// The текущ дир ткст
                static const ткст ТкстТекПап = ".";
                
                /// The файл разделитель ткст
                static const ткст ТкстФайлРазд = ".";
                
                /// The путь разделитель ткст
                static const ткст ТкстПутьРазд = "/";
                
                /// The system путь ткст
                static const ткст ТкстСистРазд = ";";

                /// The нс ткст
                static const ткст НовСтрЗнак = "\r\n";
        }

        version (Posix)
        {
                ///
                enum : сим 
                {
                        /// The текущ дир character
                        СимТекПап = '.',
                        
                        /// The файл разделитель character
                        СимФайлРазд = '.',
                        
                        /// The путь разделитель character
                        СимПутьРазд = '/',
                        
                        /// The system путь character
                        СимСистПуть = ':',
                }

                /// The предок дир ткст
                static const ткст ТкстРодПап = "..";
                
                /// The текущ дир ткст
                static const ткст ТкстТекПап = ".";
                
                /// The файл разделитель ткст
                static const ткст ТкстФайлРазд = ".";
                
                /// The путь разделитель ткст
                static const ткст ТкстПутьРазд = "/";
                
                /// The system путь ткст
                static const ткст ТкстСистРазд = ":";

                /// The нс ткст
                static const ткст НовСтрЗнак = "\n";
        }
}

struct ИнфОФайле
{
        ткст          путь,
                        имя;
        бдол           байты;
        бул            папка,
                        скрытый,
                        системный;
}

interface ИПровод : ИПотокВвода, ИПотокВывода
{
        abstract т_мера размерБуфера ();                      
		abstract ткст вТкст (); 
        abstract бул жив_ли ();
        abstract проц открепи ();
        abstract проц ошибка (ткст сооб);
		
        interface ИШаг {}

        interface ИОбрез 
        {
                проц упрости (дол размер);
        }
}

interface ИВыбираемый
{     
        version (Windows) 
                 alias ук Дескр;   /// opaque OS file-handle         
             else
                typedef цел Дескр = -1; 
        Дескр фукз();
}

interface ИПотокВВ 
{
        const Кф = -1;  


        enum Якорь {
                    Нач   = 0,
                    Тек = 1,
                    Кон    = 2,
                    };


        дол сместись (дол смещение, Якорь якорь = Якорь.Нач);
        ИПровод провод ();
        ИПотокВВ слей ();               
        проц закрой ();               


        interface Переключатель {}
}

interface ИПотокВвода : ИПотокВВ
{

        т_мера читай (проц[] приёмн);               
        проц[] загрузи (т_мера max = -1);        
        ИПотокВвода ввод ();               
}

interface ИПотокВывода : ИПотокВВ
{

        т_мера пиши (проц[] ист);     
        ИПотокВывода копируй (ИПотокВвода ист, т_мера max = -1);
        ИПотокВывода вывод ();               
}

interface БуферВвода : ИПотокВвода
{
        проц[] срез ();

        бул следщ (т_мера delegate(проц[]) скан);

        т_мера читатель (т_мера delegate(проц[]) потребитель);
}

interface БуферВывода : ИПотокВывода
{
        alias добавь opCall;

        проц[] срез ();
        
        БуферВывода добавь (проц[]);

        т_мера писатель (т_мера delegate(проц[]) производитель);
}

abstract class ИБуфер : ИПровод, ИБуферированный
{
        alias добавь opCall;
        alias слей  opCall;

        abstract ИБуфер буфер ();
        abstract проц[] дайКонтент ();
        abstract ИБуфер устКонтент (проц[] данные);
        abstract ИБуфер устКонтент (проц[] данные, т_мера читаемый);
        abstract ИБуфер добавь (ук контент, т_мера length);
        abstract ИБуфер добавь (проц[] контент);
        abstract ИБуфер добавь (ИБуфер другой);
        abstract проц потреби (проц[] ист);
        abstract проц[] срез ();
        abstract проц[] opSlice (т_мера старт, т_мера конец);
        abstract проц[] срез (т_мера размер, бул съешь = да);
        abstract проц[] читайРовно (ук приёмн, т_мера байты);
        abstract т_мера заполни (проц[] приёмн);
        abstract т_мера писатель (т_мера delegate (проц[]) писатель);
        abstract т_мера читатель (т_мера delegate (проц[]) читатель);
        abstract ИБуфер сожми ();
        abstract бул пропусти (цел размер);
        abstract бул следщ (т_мера delegate (проц[]));
        abstract т_мера заполни (ИПотокВвода ист);
        abstract т_мера дренируй (ИПотокВывода приёмн);
        abstract бул упрости (т_мера протяженность);
        abstract бул сожми (бул да);
        abstract т_мера читаемый (); 
        abstract т_мера записываемый ();
        abstract т_мера резервируй (т_мера пространство);
        abstract т_мера предел ();
        abstract т_мера ёмкость ();
        abstract т_мера позиция ();
        abstract ИБуфер устПровод (ИПровод провод);
        abstract ИБуфер вывод (ИПотокВывода сток);
        abstract ИБуфер ввод (ИПотокВвода источник);
        abstract т_мера читай (проц[] приёмн);
        abstract т_мера пиши (проц[] ист);
        abstract ИПотокВывода вывод ();
        abstract ИПотокВвода ввод ();
        abstract проц ошибка (ткст сооб);
        abstract ИПровод провод ();
        abstract т_мера размерБуфера ();
        abstract ткст вТкст ();
        abstract бул жив_ли ();
        abstract ИПотокВывода слей ();
       abstract ИПотокВвода очисть ();
       abstract ИПотокВывода копируй (ИПотокВвода ист, т_мера max=-1);
       abstract проц открепи ();
       abstract проц закрой ();
}

interface ИБуферированный
{
        ИБуфер буфер();
}
