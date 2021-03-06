﻿/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. все rights reserved

        license:        BSD стиль: $(LICENSE)
        
        version:        Initial release: April 2004      
        
        author:         Kris

*******************************************************************************/

module net.http.HttpParams;

private import  time.Time;

private import  io.stream.Buffered;

private import  net.http.HttpTokens;

private import  io.stream.Delimiters;

public  import  net.http.model.HttpParamsView;

/******************************************************************************

        Maintains a установи of запрос параметры, разобрано из_ an HTTP request.
        Use ПараметрыППГТ instead for вывод параметры.

        Note that these ввод парамы may have been кодирован by the пользователь-
        agent. Unfortunately there имеется been little consensus on что that
        кодировка should be (especially regarding GET запрос-парамы). With
        luck, that will change в_ a consistent usage of UTF-8 внутри the 
        near future.

******************************************************************************/

class ПараметрыППГТ : ТокеныППГТ, ОбзорПараметровППГТ
{
        // tell compiler в_ expose super.разбор() also
       // alias ТокеныППГТ.разбор разбор;

        private Разграничители!(сим) amp;

        /**********************************************************************
                
                Construct параметры by telling the СтэкППГТ that
                имя/значение pairs are seperated by a '=' character.

        **********************************************************************/

        this ()
        {
                super ('=');

                // construct a строка tokenizer for later usage
                amp = new Разграничители!(сим) ("&");
        }

        /**********************************************************************

                Return the число of заголовки

        **********************************************************************/

        бцел размер ()
        {
                return super.стэк.размер;
        }

        /**********************************************************************
                
                Чит все запрос параметры. Everything is mapped rather 
                than being allocated & copied

        **********************************************************************/

        override проц разбор (БуфВвод ввод)
        {
                установиРазобран (да);
                amp.установи (ввод);

                while (amp.следщ || amp.получи.length)
                       стэк.сунь (amp.получи);
        }

        /**********************************************************************
                
                Добавь a имя/значение пара в_ the запрос список

        **********************************************************************/

        проц добавь (ткст имя, ткст значение)
        {
                super.добавь (имя, значение);
        }

        /**********************************************************************
                
                Добавь a имя/целое пара в_ the запрос список 

        **********************************************************************/

        проц добавьЦел (ткст имя, цел значение)
        {
                super.добавьЦел (имя, значение);
        }


        /**********************************************************************
                
                Добавь a имя/дата(дол) пара в_ the запрос список

        **********************************************************************/

        проц добавьДату (ткст имя, Время значение)
        {
                super.добавьДату (имя, значение);
        }

        /**********************************************************************
                
                Return the значение of the provопрed заголовок, or пусто if the
                заголовок does not exist

        **********************************************************************/

        ткст получи (ткст имя, ткст возвр = пусто)
        {
                return super.получи (имя, возвр);
        }

        /**********************************************************************
                
                Return the целое значение of the provопрed заголовок, or the 
                provопрed default-значение if the заголовок does not exist

        **********************************************************************/

        цел получиЦел (ткст имя, цел возвр = -1)
        {
                return super.получиЦел (имя, возвр);
        }

        /**********************************************************************
                
                Return the дата значение of the provопрed заголовок, or the 
                provопрed default-значение if the заголовок does not exist

        **********************************************************************/

        Время дайДату (ткст имя, Время возвр = Время.эпоха)
        {
                return super.дайДату (имя, возвр);
        }


        /**********************************************************************

                Вывод the param список в_ the provопрed consumer

        **********************************************************************/

        проц произведи (т_мера delegate(проц[]) используй, ткст кс=пусто)
        {
                return super.произведи (используй, кс);
        }
}
