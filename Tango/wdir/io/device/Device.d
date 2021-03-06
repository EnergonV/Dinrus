﻿module io.device.Device;

/*private*/ import  dinrus, winapi;
public  import  io.device.Conduit;

extern(Windows) BOOL GetOverlappedResult(HANDLE, OVERLAPPED*, PDWORD, BOOL);

export extern(D):

class Устройство : Провод, ИВыбираемый
{

export:
       /// expose superclass definition also
                    
        /***********************************************************************

                Throw an ВВИскл noting the последний ошибка
        
        ***********************************************************************/

        final проц ошибка ()
        {
                super.ошибка (this.вТкст ~ " :: " ~ СисОш.последнСооб);
        }

        /***********************************************************************

                Return the имя of this устройство

        ***********************************************************************/

        override ткст вТкст ()
        {
                return "<io.device.Device.Устройство>";
        }

        /***********************************************************************

                Return a preferred размер for buffering провод I/O

        ***********************************************************************/

        override т_мера размерБуфера ()
        {
                return 1024 * 16;
        }

        /***********************************************************************

                Windows-specific код

        ***********************************************************************/

        version (Win32)
        {
                struct ВВ
                {
                        АСИНХРОН      асинх; // must be the первый attribute!!
                        Дескр          указатель;
                        бул            след;
                        ук           задача;
                }

                protected ВВ вв;

                /***************************************************************

                        Разрешить adjustment of стандарт ВВ handles

                ***************************************************************/

                проц переоткрой (Дескр указатель)
                {
                        вв.указатель = указатель;
                }

                /***************************************************************

                        Return the underlying OS указатель of this Провод

                ***************************************************************/

                final Дескр фукз () //fileHandle
                {
                        return вв.указатель;
                }

                /***************************************************************

                ***************************************************************/

                override проц вымести ()
                {
                        if (вв.указатель != НЕВЕРНХЭНДЛ)
                            if (планировщик)
                                планировщик.закрой (вв.указатель, вТкст);
                        открепи();
                }

                /***************************************************************

                        Release the underlying файл. Note that an исключение
                        is not thrown on ошибка, as doing so can induce some
                        spaggetti преобр_в ошибка handling. Instead, we need в_
                        change this в_ return a бул instead, so the caller
                        can decопрe что в_ do.                        

                ***************************************************************/

                override проц открепи ()
                {
                        if (вв.указатель != НЕВЕРНХЭНДЛ)
                            ЗакройДескр (cast(ук) вв.указатель);

                        вв.указатель = НЕВЕРНХЭНДЛ;
                }

                /***************************************************************

                        Чит a чанк of байты из_ the файл преобр_в the provопрed
                        Массив. Returns the число of байты читай, or Кф where 
                        there is no further данные.

                        Operates asynchronously where the hosting нить is
                        configured in that manner.

                ***************************************************************/

                override т_мера читай (проц[] приёмн)
                {				
				
				DWORD байты;
					 
				if (cast(HANDLE) вв.указатель == cast(HANDLE) НЕВЕРНХЭНДЛ)	throw new ВВИскл("Указатель неверный");
						 
				auto size = GetFileSize(cast(HANDLE) вв.указатель, null); 
				if (size == НЕВЕРНРАЗМФАЙЛА) throw new ВВИскл("Размер файла неверен");
				
				//auto buf = runtime.malloc(size);
				//if (buf) runtime.hasNoPointers(buf.ptr);
				
				if (!ReadFile (cast(HANDLE) вв.указатель, cast(void*) приёмн.ptr, cast(DWORD) приёмн.length, cast(DWORD*) &байты, cast(OVERLAPPED*) &вв.асинх))// throw new Исключение("Неудачное чтение в приёмник",__FILE__,__LINE__);						

				if ((байты = жди (планировщик.Тип.Чтение, байты, таймаут)) is Кф)
                                return Кф;													

							// синхронно читай of zero means Кф
				if (байты is 0 && приёмн.length > 0)  return Кф;							

							// обнови поток location?
				if (вв.след) (*cast(дол*) &вв.асинх.смещение) += байты;		
				
				//приёмн = buf;			
				return байты;
                }

                /***************************************************************

                        Зап a чанк of байты в_ the файл из_ the provопрed
                        Массив. Returns the число of байты записано, or Кф if 
                        the вывод is no longer available.

                        Operates asynchronously where the hosting нить is
                        configured in that manner.

                ***************************************************************/

                override т_мера пиши (проц[] ист)
                {
                        бцел байты;

                        if (! ПишиФайл (cast(ук) вв.указатель, ист.ptr, ист.length, &байты, &вв.асинх))
                        //WriteFile (вв.указатель, ист.ptr, ист.length, &байты, &вв.асинх);
                        if ((байты = жди (планировщик.Тип.Запись, байты, таймаут)) is Кф)
                             return Кф;

                        // обнови поток location?
                        if (вв.след)
                           (*cast(дол*) &вв.асинх.смещение) += байты;
                        return байты;
                }

                /***************************************************************

                ***************************************************************/

              final т_мера жди (thread.Фибра.Планировщик.Тип тип, бцел байты, бцел таймаут)
                {
                        while (да)
                              {
                              auto код = ДайПоследнююОшибку;
                              if (код is ПОшибка.ОшибкаУкКонцаФайла ||
                                  код is ПОшибка.РазорванныйПайп)
                                  return Кф;

                              if (планировщик)
                                 {
                                 if (код is ПОшибка.Нет || 
                                     код is ПОшибка.ОжидаетсяВВ || 
                                     код is ПОшибка.НеполныйВВ)
                                    {
                                    if (код is ПОшибка.НеполныйВВ)
                                        super.ошибка ("таймаут"); 

                                    вв.задача = cast(ук) Фибра.дайЭту;
                                    планировщик.ожидай (вв.указатель, тип, таймаут);
                                    if (GetOverlappedResult (cast(HANDLE) вв.указатель, cast(OVERLAPPED*) &вв.асинх, &байты, нет))
                                        return байты;
                                    }
                                 else
                                    ошибка;
                                 }
                              else
                                 if (код is ПОшибка.Нет)
                                     return байты;
                                 else
                                    ошибка;
                              }

                        // should never получи here
                        assert(нет);
                }
        }


        /***********************************************************************

                 Unix-specific код.

        ***********************************************************************/

        version (Posix)
        {
                protected цел указатель = -1;

                /***************************************************************

                        Разрешить adjustment of стандарт ВВ handles

                ***************************************************************/

                protected проц переоткрой (Дескр указатель)
                {
                        this.указатель = указатель;
                }

                /***************************************************************

                        Return the underlying OS указатель of this Провод

                ***************************************************************/

                final Дескр фукз ()
                {
                        return cast(Дескр) указатель;
                }

                /***************************************************************

                        Release the underlying файл

                ***************************************************************/

                override проц открепи ()
                {
                        if (указатель >= 0)
                           {
                           //if (планировщик)
                               // TODO Not supported on Posix
                               // планировщик.закрой (указатель, вТкст);
                           posix.закрой (указатель);
                           }
                        указатель = -1;
                }

                /***************************************************************

                        Чит a чанк of байты из_ the файл преобр_в the provопрed
                        Массив. Returns the число of байты читай, or Кф where 
                        there is no further данные.

                ***************************************************************/

                override т_мера читай (проц[] приёмн)
                {
                        цел читай = posix.читай (указатель, приёмн.ptr, приёмн.length);
                        if (читай is -1)
                            ошибка;
                        else
                           if (читай is 0 && приёмн.length > 0)
                               return Кф;
                        return читай;
                }

                /***************************************************************

                        Зап a чанк of байты в_ the файл из_ the provопрed
                        Массив. Returns the число of байты записано, or Кф if 
                        the вывод is no longer available.

                ***************************************************************/

                override т_мера пиши (проц[] ист)
                {
                        цел записано = posix.пиши (указатель, ист.ptr, ист.length);
                        if (записано is -1)
                            ошибка;
                        return записано;
                }
        }
}
