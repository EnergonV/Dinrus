﻿module io.stream.Buffered;

public import io.model, cidrus: memmove;
/*private*/ import io.device.Conduit;

public alias БуфВвод  Бввод;        /// shorthand alias
public alias БуфВывод Бвыв;       /// ditto


        protected static ткст перебор  = "буфер вывода полон";
        protected static ткст недобор = "буфер ввода пуст";
        protected static ткст кфЧтен   = "достигнут конец потока при чтении";
        protected static ткст кфЗап  = "достигнут конец потока при записи";

export extern(D):

class БуфВвод : ФильтрВвода, БуферВвода
{

        alias слей             очисть;          /// очисть/слей are the same
        alias ФильтрВвода.ввод ввод;          /// доступ the источник 

        /*private*/ проц[]        данные;             // the необр данные буфер
        /*private*/ т_мера        индекс;            // текущ читай позиция
        /*private*/ т_мера        протяженность;           // предел of действителен контент
        /*private*/ т_мера        дименсия;        // maximum протяженность of контент

			
        invariant()
        {
                assert (индекс <= протяженность);
                assert (протяженность <= дименсия);
        }

		export:
		
        this (ИПотокВвода поток)
        {
                assert (поток);
                this (поток, поток.провод.размерБуфера);
        }

        this (ИПотокВвода поток, т_мера ёмкость)
        {
                установи (new ббайт[ёмкость], 0);
                super (источник = поток);
        }

        static БуферВвода создай (ИПотокВвода поток)
        {
                auto источник = поток;
                auto провод = источник.провод;
                while (cast(Переключатель) источник is пусто)
                      {
                      auto b = cast(БуферВвода) источник;
                      if (b)
                          return b;
                      if (источник is провод)
                          break;
                      источник = источник.ввод;
                      assert (источник);
                      }
                      
                return new БуфВвод (поток, провод.размерБуфера);
        }

        final т_мера наполни ()
        {
                return писатель (&ввод.читай);
        }

        final проц[] opSlice (т_мера старт, т_мера конец)
        {
                assert (старт <= протяженность && конец <= протяженность && старт <= конец);
                return данные [старт .. конец];
        }

        final проц[] срез ()
        {
                return  данные [индекс .. протяженность];
        }

        final проц[] срез (т_мера размер, бул съешь = да)
        {
                if (размер > читаемый)
                   {
                   // сделай some пространство? This will try в_ покинь as much контент
                   // in the буфер as possible, such that entire records may
                   // be есть_алиас directly из_ внутри.
                   if (размер > (дименсия - индекс))
                       if (размер <= дименсия)
                           сожми;
                       else
                          провод.ошибка (недобор);

                   // наполни хвост of буфер with new контент
                   do {
                      if (писатель (&источник.читай) is Кф)
                          провод.ошибка (кфЧтен);
                      } while (размер > читаемый);
                   }

                auto i = индекс;
                if (съешь)
                    индекс += размер;
                return данные [i .. i + размер];
        }

        final т_мера читатель (т_мера delegate (проц[]) дг)
        {
                auto счёт = дг (данные [индекс..протяженность]);

                if (счёт != Кф)
                   {
                   индекс += счёт;
                   assert (индекс <= протяженность);
                   }
                return счёт;
        }

       т_мера писатель (т_мера delegate (проц[]) дг)
        {
                auto счёт = дг (данные [протяженность..дименсия]);

                if (счёт != Кф)
                   {
                   протяженность += счёт;
                   assert (протяженность <= дименсия);
                   }
                return счёт;
        }


        final override т_мера читай (проц[] приёмн)
        {
                т_мера контент = читаемый;
                if (контент)
                   {
                   if (контент >= приёмн.length)
                       контент = приёмн.length;

                   // перемести буфер контент
                   приёмн [0 .. контент] = данные [индекс .. индекс + контент];
                   индекс += контент;
                   }
                else
                   // pathological cases читай directly из_ провод
                   if (приёмн.length > дименсия)
                       контент = источник.читай (приёмн);
                   else
                      {
                      if (записываемый is 0)
                          индекс = протяженность = 0;  // same as очисть, without вызов-chain

                      // keep буфер partially populated
                      if ((контент = писатель (&источник.читай)) != Кф && контент > 0)
                           контент = читай (приёмн);
                      }
                return контент;
        }


        final т_мера заполни (проц[] приёмн, бул exact = нет)
        {
                т_мера длин = 0;

                while (длин < приёмн.length)
                      {
                      т_мера i = читай (приёмн [длин .. $]);
                      if (i is Кф)
                         {
                         if (exact && длин < приёмн.length)
                             провод.ошибка (кфЧтен);
                         return (длин > 0) ? длин : Кф;
                         }
                      длин += i;
                      }
                return длин;
        }

        final бул пропусти (цел размер)
        {
                if (размер < 0)
                   {
                   размер = -размер;
                   if (индекс >= размер)
                      {
                      индекс -= размер;
                      return да;
                      }
                   return нет;
                   }
                return срез(размер) !is пусто;
        }


        final override дол сместись (дол смещение, Якорь старт = Якорь.Нач)
        {
                if (старт is Якорь.Тек)
                   {
                   // укз this specially because we know this is
                   // buffered - we should возьми преобр_в account the буфер
                   // позиция when seeking
                   смещение -= читаемый;
                   auto bpos = смещение + предел;

                   if (bpos >= 0 && bpos < предел)
                      {
                      // the new позиция is внутри the текущ
                      // буфер, пропусти в_ that позиция.
                      пропусти (cast(цел) bpos - cast(цел) позиция);

                      // see if we can return a действителен смещение
                      auto поз = источник.сместись (0, Якорь.Тек);
                      if (поз != Кф)
                          return поз - читаемый;
                      return Кф;
                      }
                   // else, позиция is outsопрe the буфер. Do a реал
                   // сместись using the adjusted позиция.
                   }

                очисть;
                return источник.сместись (смещение, старт);
        }

        final бул следщ (т_мера delegate (проц[]) скан)
        {
                while (читатель(скан) is Кф)
                      {
                      // dопр we старт at the beginning?
                      if (позиция)
                          // yep - перемести partial токен в_ старт of буфер
                          сожми;
                      else
                         // no ещё пространство in the буфер?
                         if (записываемый is 0)
                             провод.ошибка (" io.stream.Buffered.БуферВвода.следщ :: буфер ввода переполнен");

                      // читай другой чанк of данные
                      if (писатель(&источник.читай) is Кф)
                          return нет;
                      }
                return да;
        }


        final т_мера резервируй (т_мера пространство)
        {       
                assert (пространство < дименсия);

                if ((дименсия - индекс) < пространство)
                     сожми;
                return индекс;
        }

        final БуферВвода сожми ()
        {       
                auto r = читаемый;

                if (индекс > 0 && r > 0)
                    // контент may overlap ...
                    memmove (&данные[0], &данные[индекс], r);

                индекс = 0;
                протяженность = r;
                return this;
        }


        final т_мера дренируй (ИПотокВывода приёмн)
        {
                assert (приёмн);

                т_мера возвр = читатель (&приёмн.пиши);
                сожми;
                return возвр;
        }


        final т_мера предел ()
        {
                return протяженность;
        }

        final т_мера ёмкость ()
        {
                return дименсия;
        }


        final т_мера позиция ()
        {
                return индекс;
        }

        final т_мера читаемый ()
        {
                return протяженность - индекс;
        }

        static T[] преобразуй(T)(проц[] x)
        {
                return (cast(T*) x.ptr) [0 .. (x.length / T.sizeof)];
        }

        final override БуфВвод слей ()
        {
                индекс = протяженность = 0;

                // очисть the фильтр chain also
                if (источник) 
                    super.слей;
                return this;
        }


        final проц ввод (ИПотокВвода источник)
        {
                this.источник = источник;
        }

        final override проц[] загрузи (т_мера max = т_мера.max)
        {
                загрузи (super.ввод, super.провод.размерБуфера, max);
                return срез;
        }
                
        /*private*/ т_мера загрузи (ИПотокВвода ист, т_мера инкремент, т_мера max)
        {
                т_мера  длин,
                        счёт;
                
                // сделай some room
                сожми;

                // explicitly перемерь?
                if (max != max.max)
                    if ((длин = записываемый) < max)
                         инкремент = max - длин;
                        
                while (счёт < max)
                      {
                      if (! записываемый)
                         {
                         дименсия += инкремент;
                         данные.length = дименсия;               
                         }
                      if ((длин = писатель(&ист.читай)) is Кф)
                           break;
                      else
                         счёт += длин;
                      }
                return счёт;
        }       


       /*private*/ final БуфВвод установи (проц[] данные, т_мера читаемый)
        {
                this.данные = данные;
                this.протяженность = читаемый;
                this.дименсия = данные.length;

                // сбрось в_ старт of ввод
                this.индекс = 0;

                return this;
        }

       /*private*/ final т_мера записываемый ()
        {
                return дименсия - протяженность;
        }
}


class БуфВывод : ФильтрВывода, БуферВывода
{
export:
        alias ФильтрВывода.вывод вывод;       /// доступ the сток

        /*private*/ проц[]        данные;             // the необр данные буфер
        /*private*/ т_мера        индекс;            // текущ читай позиция
        /*private*/ т_мера        протяженность;           // предел of действителен контент
        /*private*/ т_мера        дименсия;        // maximum протяженность of контент

        invariant()
        {
                assert (индекс <= протяженность);
                assert (протяженность <= дименсия);
        }


        this (ИПотокВывода поток)
        {
                assert (поток);
                this (поток, поток.провод.размерБуфера);
        }


        this (ИПотокВывода поток, т_мера ёмкость)
        {
                установи (new ббайт[ёмкость], 0);
                super (сток = поток);
        }


       static БуфВывод создай (ИПотокВывода поток)
        {
                auto сток = поток;
                auto провод = сток.провод;
                while (cast(Переключатель) сток is пусто)
                      {
                      auto b = cast(БуфВывод) сток;
                      if (b)
                          return b;
                      if (сток is провод)
                          break;
                      сток = сток.вывод;
                      assert (сток);
                      }
                      
                return new БуфВывод (поток, провод.размерБуфера);
        }


        final проц[] срез ()
        {
                return данные [индекс .. протяженность];
        }


        final override т_мера пиши (проц[] ист)
        {
                добавь (ист.ptr, ист.length);
                return ист.length;
        }


        final БуфВывод добавь (проц[] ист)
        {
                return добавь (ист.ptr, ист.length);
        }


        final БуфВывод добавь (ук ист, т_мера длина)
        {
                if (длина > записываемый)
                   {
                   слей;

                   // проверь for pathological case
                   if (длина > дименсия)
                       do {
                          auto записано = сток.пиши (ист [0 .. длина]);
                          if (записано is Кф)
                              провод.ошибка (кфЗап);
                          длина -= записано;
                          ист += записано; 
                          } while (длина > дименсия);
                    }

                // avoопр "out of bounds" тест on zero длина
                if (длина)
                   {
                   // контент may overlap ...
                   memmove (&данные[протяженность], ист, длина);
                   протяженность += длина;
                   }
                return this;
        }


        final т_мера записываемый ()
        {
                return дименсия - протяженность;
        }


        final т_мера предел ()
        {
                return протяженность;
        }


        final т_мера ёмкость ()
        {
                return дименсия;
        }


        final бул упрости (т_мера длина)
        {
                if (длина <= данные.length)
                   {
                   протяженность = длина;
                   return да;
                   }
                return нет;
        }


        static T[] преобразуй(T)(проц[] x)
        {
                return (cast(T*) x.ptr) [0 .. (x.length / T.sizeof)];
        }


        final override БуфВывод слей ()
        {
                while (читаемый > 0)
                      {
                      auto возвр = читатель (&сток.пиши);
                      if (возвр is Кф)
                          провод.ошибка (кфЗап);
                      }

                // слей the фильтр chain also
                очисть;
                super.слей;
                return this;
        }


        final override БуфВывод копируй (ИПотокВвода ист, т_мера max = -1)
        {
                т_мера чанк,
                       copied;

                while (copied < max && (чанк = писатель(&ист.читай)) != Кф)
                      {
                      copied += чанк;

                      // don't дренируй until we actually need в_
                      if (записываемый is 0)
                          if (дренируй(сток) is Кф)
                              провод.ошибка (кфЗап);
                      }
                return this;
        }


        final т_мера дренируй (ИПотокВывода приёмн)
        {
                assert (приёмн);

                т_мера возвр = читатель (&приёмн.пиши);
                сожми;
                return возвр;
        }

        final БуфВывод очисть ()
        {
                индекс = протяженность = 0;
                return this;
        }


        final проц вывод (ИПотокВывода сток)
        {
                this.сток = сток;
        }


        final override дол сместись (дол смещение, Якорь старт = Якорь.Нач)
        {       
                очисть;
                return super.сместись (смещение, старт);
        }


        final т_мера писатель (т_мера delegate (проц[]) дг)
        {
                auto счёт = дг (данные [протяженность..дименсия]);

                if (счёт != Кф)
                   {
                   протяженность += счёт;
                   assert (протяженность <= дименсия);
                   }
                return счёт;
        }


       /*private*/ final т_мера читатель (т_мера delegate (проц[]) дг)
        {
                auto счёт = дг (данные [индекс..протяженность]);

                if (счёт != Кф)
                   {
                   индекс += счёт;
                   assert (индекс <= протяженность);
                   }
                return счёт;
        }


       /*private*/ final т_мера читаемый ()
        {
                return протяженность - индекс;
        }


        /*private*/ final БуфВывод установи (проц[] данные, т_мера читаемый)
        {
                this.данные = данные;
                this.протяженность = читаемый;
                this.дименсия = данные.length;

                // сбрось в_ старт of ввод
                this.индекс = 0;

                return this;
        }


       /*private*/ final БуфВывод сожми ()
        {       
                т_мера r = читаемый;

                if (индекс > 0 && r > 0)
                    // контент may overlap ...
                    memmove (&данные[0], &данные[индекс], r);

                индекс = 0;
                протяженность = r;
                return this;
        }
}



debug (Буферированный)
{
        проц main()
        {
                auto ввод = new БуфВвод (пусто);
                auto вывод = new БуфВывод (пусто);
        }
}
