﻿module io.protocol.Allocator;

private import  io.protocol.model;



class КопияКучи : ИРазместитель
{
        this (ИПротокол протокол);
        final ИПротокол протокол ();
        final проц сбрось ();
        final проц[] размести (ИПротокол.Читатель читатель, бцел байты, ИПротокол.Тип тип);
}

class СрезКучи : ИРазместитель
{

        this (ИПротокол протокол, бцел width=4096, бул autoreset=нет);
        final ИПротокол протокол ();
        final проц сбрось ();
        final проц[] размести (ИПротокол.Читатель читатель, бцел байты, ИПротокол.Тип тип);
}

class СрезБуфера : ИРазместитель
{
        this (ИПротокол протокол);
        final ИПротокол протокол ();
        final проц сбрось ();
        final проц[] размести (ИПротокол.Читатель читатель, бцел байты, ИПротокол.Тип тип);
}
