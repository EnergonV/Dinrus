﻿//import std.file, std.utf, std.io, std.string, exception, cidrus;
import dinrus;

version = UCRT;
version(UCRT)
{
	pragma(lib, "ucrt.lib");
	extern(C)
	{
	int _waccess(wchar* path, int access_mode);
	int _wchmod(wchar* path, int mode);
	}
}
alias скажифнс ск;
 цел удалиФайлы(ткст флрасш, ткст путь = "d:\\dinrus\\dev\\DINRUS\\Base")
 { 
 цел удалено = 0;

ск("Подождите пока строится список файлов => "~флрасш);
нс;
	auto файлы = списпап(путь, флрасш);
	foreach (ф; файлы)
	{	try
		{
		version(UCRT){
		if( _wchmod(вЮ16н(ф), 6) == -1) ошибка(фм("Файл незаписываемый: %s", ф));
		}
		удалиФайл(ф);
		удалено++;
		}
		catch(ВВИскл искл){
		//throw искл;
		}
		ск("Удалён : "~ф);		
	}
	нс;
	ск("Файлов удалено: %d", удалено);
	нс;
	return 0;
}

проц main()
{
	ск("Начало послепостроечной очистки: ");
	alias удалиФайлы уд;
	уд("*.obj");
	уд("*.map");
	//уд("*.exe");
	//уд("*.dll");
	уд("*.bak");
	уд("*.rsp");
	уд("*.lib");
	уд("*.rsp");	
	уд("*.log");

		
	ск("Операция удаления файлов завершена.");
	нс;
	нс;

	
	выход(0);
}