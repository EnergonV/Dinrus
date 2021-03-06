﻿/*******************************************************************************
        copyright:      Copyright (c) 2008. Fawzi Mohamed
        license:        BSD стиль: $(LICENSE)
        version:        Initial release: Sep 2008
        author:         Fawzi Mohamed
*******************************************************************************/
module math.random.engines.Sync;
private import Целое = text.convert.Integer;
import sync: Стопор;


/+ Производит синхронизированный движок из движка Е, доступ к нескольким нитям поддерживается
+ (но для этого нужно подумать о генераторе случайных чисел для каждой из нитей)
+ Это движок, *никогда* не применяйте его напрямую, всегда используйте через класс СлуччисГ
+/
struct Синх(Е){
    Е движок;
    Стопор блокируй;
    
    const цел canCheckpoint=Е.canCheckpoint;
    const цел можноСеять=Е.можноСеять;
    
    проц пропусти(бцел n);
	
    ббайт следщБ();
	
    бцел следщ();
	
    бдол следщД();
    
    проц сей(бцел delegate() r);
	
    /// записывает текущ статус в ткст
    ткст вТкст();
	
    /// считывает текущ статус в ткст (его следует подзачистить)
    /// возвращает число считанных символов
    т_мера изТкст(ткст s);
}
