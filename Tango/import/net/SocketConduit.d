﻿/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. все rights reserved

        license:        BSD стиль: $(LICENSE)

        version:        Mar 2004 : Initial release
        version:        Jan 2005 : RedShodan patch for таймаут запрос
        version:        Dec 2006 : Outback release
        
        author:         Kris

*******************************************************************************/

module net.SocketConduit;

public  import  io.device.Conduit;

private import  net.Socket;

/*******************************************************************************

        A wrapper around the bare Сокет в_ implement the ИПровод abstraction
        и добавь сокет-specific functionality.

        СокетПровод данные-перемести is typically performed in conjunction with
        an ИБуфер, but can happily be handled directly using проц Массив where
        preferred
        
*******************************************************************************/

class СокетПровод : Провод, ИВыбираемый
{
        private значврем                 tv;
        private НаборСокетов               ss;
        package Сокет                  сокет_;
        private бул                    таймаут;

        // freelist support
        private СокетПровод           следщ;   
        private бул                    fromList;
        private static СокетПровод    freelist;

        /***********************************************************************
        
                Созд a Потокing Internet Сокет

        ***********************************************************************/

        this ();

        /***********************************************************************
        
                Созд an Internet Сокет with the provопрed characteristics

        ***********************************************************************/

        this (ПСемействоАдресов семейство, ПТипСок тип, ППротокол протокол);

        /***********************************************************************
        
                Созд an Internet Сокет. See метод размести() below

        ***********************************************************************/

        private this (ПСемействоАдресов семейство, ПТипСок тип, ППротокол протокол, бул создать);

        /***********************************************************************

                Return the имя of this устройство

        ***********************************************************************/

        override ткст вТкст();

        /***********************************************************************

                Return the сокет wrapper
                
        ***********************************************************************/

        Сокет сокет ();

        /***********************************************************************

                Return a preferred размер for buffering провод I/O

        ***********************************************************************/

        override т_мера размерБуфера ();

        /***********************************************************************

                Models a укз-oriented устройство.

                TODO: figure out как в_ avoопр exposing this in the general
                case

        ***********************************************************************/

        Дескр фукз ();

        /***********************************************************************

                Набор the читай таймаут в_ the specified интервал. Набор a
                значение of zero в_ disable таймаут support.

                The интервал is in units of сек, where 0.500 would
                represent 500 milliseconds. Use ИнтервалВремени.интервал в_
                преобразуй из_ a ИнтервалВремени экземпляр.

        ***********************************************************************/

        СокетПровод установиТаймаут (плав таймаут);

        /***********************************************************************

                Dопр the последний operation результат in a таймаут? 

        ***********************************************************************/

        бул былТаймаут ();

        /***********************************************************************

                Is this сокет still alive?

        ***********************************************************************/

        override бул жив_ли ();

        /***********************************************************************

                Connect в_ the provопрed endpoint
        
        ***********************************************************************/

        СокетПровод подключись (Адрес адр);

        /***********************************************************************

                Bind the сокет. This is typically использован в_ конфигурируй a
                listening сокет (such as a сервер or multicast сокет).
                The адрес given should describe a local адаптер, or
                specify the порт alone (АДР_ЛЮБОЙ) в_ have the OS присвой
                a local адаптер адрес.
        
        ***********************************************************************/

        СокетПровод вяжи (Адрес адрес);

        /***********************************************************************

                Inform другой конец of a подключен сокет that we're no longer
                available. In general, this should be invoked before закрой()
                is invoked
        
                The глуши function shuts down the connection of the сокет: 

                    -   stops receiving данные for this сокет. If further данные 
                        arrives, it is rejected.

                    -   stops trying в_ transmit данные из_ this сокет. Also
                        discards any данные waiting в_ be sent. Стоп looking for 
                        acknowledgement of данные already sent; don't retransmit 
                        if any данные is lost.

        ***********************************************************************/

        СокетПровод глуши ();

        /***********************************************************************

                Release this СокетПровод

                Note that one should always disconnect a СокетПровод 
                under нормаль conditions, и generally invoke глуши 
                on все подключен СОКЕТs beforehand

        ***********************************************************************/

        override проц открепи ();

       /***********************************************************************

                Чит контент из_ the сокет. Note that the operation 
                may таймаут if метод установиТаймаут() имеется been invoked with 
                a non-zero значение.

                Returns the число of байты читай из_ the сокет, or
                ИПровод.Кф where there's no ещё контент available.

                If the underlying сокет is a блокируется сокет, Кф will 
                only be returned once the сокет имеется закрыт.

                Note that a таймаут is equivalent в_ Кф. Isolating
                a таймаут condition can be achieved via былТаймаут()

                Note also that a zero return значение is not legitimate;
                such a значение indicates Кф

        ***********************************************************************/

        override т_мера читай (проц[] приёмн);
        
        /***********************************************************************

                Callback routine в_ пиши the provопрed контент в_ the
                сокет. This will stall until the сокет responds in
                some manner. Returns the число of байты sent в_ the
                вывод, or ИПровод.Кф if the сокет cannot пиши.

        ***********************************************************************/

        override т_мера пиши (проц[] ист);

        /***********************************************************************
 
                Internal routine в_ укз сокет читай under a таймаут.
                Note that this is synchronized, in order в_ serialize
                сокет доступ

        ***********************************************************************/

        package final synchronized т_мера читай (проц[] приёмн, т_мера delegate(проц[]) дг);
        
        /***********************************************************************

                Размести a СокетПровод из_ a список rather than creating
                a new one. Note that the сокет itself is not opened; only
                the wrappers. This is because the сокет is often назначено
                directly via прими()

        ***********************************************************************/

        package static synchronized СокетПровод размести ();

        /***********************************************************************

                Return this СокетПровод в_ the free-список

        ***********************************************************************/

        private static synchronized проц вымести (СокетПровод s);
}


