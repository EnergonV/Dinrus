﻿/*******************************************************************************

        copyright:      Copyright (c) 2004 Kris Bell. все rights reserved

        license:        BSD стиль: $(LICENSE)

        version:        Initial release: January 2006
        
        author:         Kris

*******************************************************************************/

module net.http.HttpPost;

public import   net.Uri;

private import  io.model;

private import  net.http.HttpClient,
                net.http.HttpHeaders;

/*******************************************************************************

        Supports the basic needs of a клиент Отправкаing POST requests в_ a
        HTTP сервер. The following is a usage example:

        ---
        // открой a web-страница for posting (see ГетППГТ for simple reading)
        auto post = new ПостППГТ ("http://yourhost/yourpath");

        // шли, retrieve и display ответ
        Квывод (cast(ткст) post.пиши("posted данные", "текст/plain"));
        ---

*******************************************************************************/

class ПостППГТ : КлиентППГТ
{      
        /***********************************************************************
        
                Созд a клиент for the given URL. The аргумент should be
                fully qualified with an "http:" or "https:" scheme, or an
                явный порт should be provопрed.

        ***********************************************************************/

        this (ткст url);

        /***********************************************************************
        
                Созд a клиент with the provопрed Уир экземпляр. The Уир should 
                be fully qualified with an "http:" or "https:" scheme, or an
                явный порт should be provопрed. 

        ***********************************************************************/

        this (Уир уир);

        /***********************************************************************
        
                Отправка запрос парамы only

        ***********************************************************************/

        проц[] пиши ();

        /***********************************************************************
        
                Отправка необр данные via the provопрed помпа, и no запрос 
                парамы. You have full control over заголовки и so 
                on via this метод.

        ***********************************************************************/

        проц[] пиши (Помпа помпа);

        /***********************************************************************
        
                Отправка контент и no запрос парамы. The длинаКонтента заголовок
                will be установи в_ сверь the provопрed контент, и contentType
                установи в_ the given тип.

        ***********************************************************************/

        проц[] пиши (проц[] контент, ткст тип);
}

