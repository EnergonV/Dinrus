﻿//Автор Кристофер Миллер. Переработано для Динрус Виталием Кулич.
//Библиотека визуальных конпонентов VIZ (первоначально DFL).
module viz.graphics;
import  tpl.stream, viz.common;


export class СистемныеЦвета // docmain
{
	private this()
	{
	}
	
	export:
	static:
	
	Цвет активныйБордюр() // getter
	{
		return Цвет.системныйЦвет(COLOR_ACTIVEBORDER);
	}	
	
	Цвет активныйЗаголовок() // getter
	{
		return Цвет.системныйЦвет(COLOR_ACTIVECAPTION);
	}	
	
	Цвет текстАктивногоЗаголовка() // getter
	{
		return Цвет.системныйЦвет(COLOR_CAPTIONTEXT);
	}	
	
	Цвет рабочееПространствоПрилож() // getter
	{
		return Цвет.системныйЦвет(COLOR_APPWORKSPACE);
	}	
	
	Цвет упрэлт() // getter
	{
		return Цвет.системныйЦвет(COLOR_BTNFACE);
	}	
	
	Цвет тёмныйУпр() // getter
	{
		return Цвет.системныйЦвет(COLOR_BTNSHADOW);
	}	
	
	Цвет оченьТёмныйУпр() // getter
	{
		return Цвет.системныйЦвет(COLOR_3DDKSHADOW); // ?
	}	
	
	Цвет светлыйУпр() // getter
	{
		return Цвет.системныйЦвет(COLOR_3DLIGHT);
	}	
	
	Цвет оченьСветлыйУпр() // getter
	{
		return Цвет.системныйЦвет(COLOR_BTNHIGHLIGHT); // ?
	}	
	
	Цвет текстУпр() // getter
	{
		return Цвет.системныйЦвет(COLOR_BTNTEXT);
	}	
	
	Цвет рабочийСтол() // getter
	{
		return Цвет.системныйЦвет(COLOR_DESKTOP);
	}	
	
	Цвет серыйТекст() // getter
	{
		return Цвет.системныйЦвет(COLOR_GRAYTEXT);
	}	
	
	Цвет подсветка() // getter
	{
		return Цвет.системныйЦвет(COLOR_HIGHLIGHT);
	}	
	
	Цвет подсветкаТекста() // getter
	{
		return Цвет.системныйЦвет(COLOR_HIGHLIGHTTEXT);
	}	
	
	Цвет хотТрэк() // getter
	{
		return Цвет(0, 0, 0xFF); // ?
	}	
	
	Цвет неактивныйБордюр() // getter
	{
		return Цвет.системныйЦвет(COLOR_INACTIVEBORDER);
	}	
	
	Цвет неактивныйЗаголовок() // getter
	{
		return Цвет.системныйЦвет(COLOR_INACTIVECAPTION);
	}	
	
	Цвет текстНеактивногоЗаголовка() // getter
	{
		return Цвет.системныйЦвет(COLOR_INACTIVECAPTIONTEXT);
	}	
	
	Цвет инфо() // getter
	{
		return Цвет.системныйЦвет(COLOR_INFOBK);
	}	
	
	Цвет текстИнфо() // getter
	{
		return Цвет.системныйЦвет(COLOR_INFOTEXT);
	}	
	
	Цвет меню() // getter
	{
		return Цвет.системныйЦвет(COLOR_MENU);
	}	
	
	Цвет текстМеню() // getter
	{
		return Цвет.системныйЦвет(COLOR_MENUTEXT);
	}	
	
	Цвет полосаПрокрутки() // getter
	{
		return Цвет.системныйЦвет(CTLCOLOR_SCROLLBAR);
	}
		
	Цвет окно() // getter
	{
		return Цвет.системныйЦвет(COLOR_WINDOW);
	}
		
	Цвет рамкаОкна() // getter
	{
		return Цвет.системныйЦвет(COLOR_WINDOWFRAME);
	}
	
	
	Цвет текстОкна() // getter
	{
		return Цвет.системныйЦвет(COLOR_WINDOWTEXT);
	}
}


export class СистемныеПиктограммы // docmain
{
	private this()
	{
	}
	
	export:
	static:
	
	Пиктограмма приложение() // getter
	{
		return new Пиктограмма(LoadIconA(пусто, IDI_APPLICATION), нет);
	}	
	
	Пиктограмма ошибка() // getter
	{
		return new Пиктограмма(LoadIconA(пусто, IDI_HAND), нет);
	}
		
	Пиктограмма вопрос() // getter
	{
		return new Пиктограмма(LoadIconA(пусто, IDI_QUESTION), нет);
	}
		
	Пиктограмма предупреждение() // getter
	{
		return new Пиктограмма(LoadIconA(пусто, IDI_EXCLAMATION), нет);
	}	
	
	Пиктограмма информация() // getter
	{
		return new Пиктограмма(LoadIconA(пусто, IDI_INFORMATION), нет);
	}
}


/+
class ImageFormat
{
	/+
	this(guid)
	{
		
	}
	
	
	final guid() // getter
	{
		return guid;
	}
	+/
	
	
	static:
	
	ImageFormat bmp() // getter
	{
		return пусто;
	}
	
	
	ImageFormat пиктограмма() // getter
	{
		return пусто;
	}
}
+/


export abstract class Рисунок // docmain
{
export:
	//флаги(); // getter ???
	
	
	/+
	final ImageFormat rawFormat(); // getter
	+/
		
	static Битмап изУкНаБитмап(HBITMAP hbm) // package
	{
		return new Битмап(hbm, нет); // Not owned. Up to caller to manage or call вымести().
	}
		
	/+
	static Рисунок изФайла(Ткст file)
	{
		return new Рисунок(LoadImageA());
	}
	+/
		
	проц рисуй(Графика з, Точка тчк);
	
	проц рисуйРастяни(Графика з, Прям к);	
	
	Размер размер(); // getter
		
	цел ширина() // getter
	{
		return размер.ширина;
	}	
	
	цел высота() // getter
	{
		return размер.высота;
	}
		
	цел _imgtype(HGDIOBJ* ph) // internal
	{
		if(ph)
			*ph = HGDIOBJ.init;
		return 0; // 1 = битмап; 2 = пиктограмма.
	}
}

export class Битмап: Рисунок // docmain
{
export:
		// Load from а bmp file.
	this(Ткст фимя)
	{
		this.hbm = cast(HBITMAP) загрузиРисунок(пусто, фимя, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
		if(!this.hbm)
			throw new ВизИскл("Не удаётся загрузить битмап из файла '" ~ фимя ~ "'");
	}
	
	// Used internally.
	this(HBITMAP hbm, бул owned = да)
	{
		this.hbm = hbm;
		this.owned = owned;
	}	
	
	final HBITMAP указатель() // getter
	{
		return hbm;
	}
		
	private проц _getInfo(БИТМАП* bm)
	{
		if(GetObjectA(hbm, БИТМАП.sizeof, bm) != БИТМАП.sizeof)
			throw new ВизИскл("Не удаётся получить информацию о рисунке");
	}	
	
	final override Размер размер() // getter
	{
		БИТМАП bm;
		_getInfo(&bm);
		return Размер(bm.ширина, bm.высота);
	}
		
	final override цел ширина() // getter
	{
		return размер.ширина;
	}	
	
	final override цел высота() // getter
	{
		return размер.высота;
	}	
	
	private проц _draw(Графика з, Точка тчк, HDC memdc)
	{
		HGDIOBJ hgo;
		Размер разм;
		
		разм = размер;
		hgo = SelectObject(memdc, hbm);
		BitBlt(з.указатель, тчк.ш, тчк.в, разм.ширина, разм.высота, memdc, 0, 0, SRCCOPY);
		SelectObject(memdc, hgo); // Old битмап.
	}	
	
	final override проц рисуй(Графика з, Точка тчк)
	{
		HDC memdc;
		memdc = CreateCompatibleDC(з.указатель);
		try
		{
			_draw(з, тчк, memdc);
		}
		finally
		{
			DeleteDC(memdc);
		}
	}	
	
	// -tempMemGraphics- is used as а temporary Графика instead of
	// creating and destroying а temporary one for each call.
	final проц рисуй(Графика з, Точка тчк, Графика tempMemGraphics)
	{
		_draw(з, тчк, tempMemGraphics.указатель);
	}	
	
	private проц _drawStretched(Графика з, Прям к, HDC memdc)
	{
		HGDIOBJ hgo;
		Размер разм;
		цел lstretch;
		
		разм = размер;
		hgo = SelectObject(memdc, hbm);
		lstretch = SetStretchBltMode(з.указатель, COLORONCOLOR);
		StretchBlt(з.указатель, к.ш, к.в, к.ширина, к.высота, memdc, 0, 0, разм.ширина, разм.высота, SRCCOPY);
		SetStretchBltMode(з.указатель, lstretch);
		SelectObject(memdc, hgo); // Old битмап.
	}	
	
	final override проц рисуйРастяни(Графика з, Прям к)
	{
		HDC memdc;
		memdc = CreateCompatibleDC(з.указатель);
		try
		{
			_drawStretched(з, к, memdc);
		}
		finally
		{
			DeleteDC(memdc);
		}
	}	
	
	// -tempMemGraphics- is used as а temporary Графика instead of
	// creating and destroying а temporary one for each call.
	final проц рисуйРастяни(Графика з, Прям к, Графика tempMemGraphics)
	{
		_drawStretched(з, к, tempMemGraphics.указатель);
	}	
	
	проц вымести()
	{
		assert(owned);
		DeleteObject(hbm);
		hbm = пусто;
	}	
	
	~this()
	{
		if(owned)
			вымести();
	}	
	
	override цел _imgtype(HGDIOBJ* ph) // internal
	{
		if(ph)
			*ph = cast(HGDIOBJ)hbm;
		return 1;
	}	
	
	private:
	HBITMAP hbm;
	бул owned = да;
}


export extern(D) class Картинка: Рисунок // docmain
{
	// Note: requires OleInitialize(пусто).
	
	export:
		// Throws исключение on failure.
	this(Поток stm)
	{
		this.ipic = _fromStream(stm);
		if(!this.ipic)
			throw new ВизИскл("Не удаётся загрузить картинку из потока");
	}
	
	
	// Throws исключение on failure.
	this(Ткст фимя)
	{
		this.ipic = _fromFileName(фимя);
		if(!this.ipic)
			throw new ВизИскл("Не удаётся загрузить картинку из файла '" ~ фимя ~ "'");
	}
		
	this(проц[] mem)
	{
		this.ipic = _fromMemory(mem);
		if(!this.ipic)
			throw new ВизИскл("Не удаётся загрузить картинку из памяти");
	}
		
	private this(winapi.IPicture ipic)
	{
		this.ipic = ipic;
	}
		
		// Returns пусто on failure instead of throwing исключение.
	static Картинка изПотока(Поток stm)
	{
		auto ipic = _fromStream(stm);
		if(!ipic)
			return пусто;
		return new Картинка(ipic);
	}	
	
		// Returns пусто on failure instead of throwing исключение.
	static Картинка изФайла(Ткст фимя)
	{
		auto ipic = _fromFileName(фимя);
		if(!ipic)
			return пусто;
		return new Картинка(ipic);
	}	
	
	static Картинка изПамяти(проц[] mem)
	{
		auto ipic = _fromMemory(mem);
		if(!ipic)
			return пусто;
		return new Картинка(ipic);
	}	
	
	final проц рисуй(HDC hdc, Точка тчк) // package
	{
		цел lhx, lhy;
		цел ширина, высота;
		lhx = loghimX;
		lhy = loghimY;
		ширина = MAP_LOGHIM_TO_PIX(lhx, GetDeviceCaps(hdc, LOGPIXELSX));
		высота = MAP_LOGHIM_TO_PIX(lhy, GetDeviceCaps(hdc, LOGPIXELSY));
		ipic.Render(hdc, тчк.ш, тчк.в + высота, ширина, -высота, 0, 0, lhx, lhy, пусто);
	}	
	
	final override проц рисуй(Графика з, Точка тчк)
	{
		return рисуй(з.указатель, тчк);
	}	
	
	final проц рисуйРастяни(HDC hdc, Прям к) // package
	{
		цел lhx, lhy;
		lhx = loghimX;
		lhy = loghimY;
		ipic.Render(hdc, к.ш, к.в + к.высота, к.ширина, -к.высота, 0, 0, lhx, lhy, пусто);
	}	
	
	final override проц рисуйРастяни(Графика з, Прям к)
	{
		return рисуйРастяни(з.указатель, к);
	}	
	
	final OLE_XSIZE_HIMETRIC loghimX() // getter
	{
		OLE_XSIZE_HIMETRIC xsz;
		if(S_OK != ipic.get_Width(&xsz))
			return 0; // ?
		return xsz;
	}	
	
	final OLE_YSIZE_HIMETRIC loghimY() // getter
	{
		OLE_YSIZE_HIMETRIC ysz;
		if(S_OK != ipic.get_Height(&ysz))
			return 0; // ?
		return ysz;
	}	
	
	final override цел ширина() // getter
	{
		Графика з;
		цел результат;
		з = Графика.дайЭкран();
		результат = дайШирину(з);
		з.вымести();
		return результат;
	}	
	
	final override цел высота() // getter
	{
		Графика з;
		цел результат;
		з = Графика.дайЭкран();
		результат = дайВысоту(з);
		з.вымести();
		return результат;
	}	
	
	final override Размер размер() // getter
	{
		Графика з;
		Размер результат;
		з = Графика.дайЭкран();
		результат = дайРазмер(з);
		з.вымести();
		return результат;
	}	
	
	final цел дайШирину(HDC hdc) // package
	{
		return MAP_LOGHIM_TO_PIX(loghimX, GetDeviceCaps(hdc, LOGPIXELSX));
	}
	
	
	final цел дайШирину(Графика з)
	{
		return дайШирину(з.указатель);
	}
		
	final цел дайВысоту(HDC hdc) // package
	{
		return MAP_LOGHIM_TO_PIX(loghimY, GetDeviceCaps(hdc, LOGPIXELSX));
	}
		
	final цел дайВысоту(Графика з)
	{
		return дайВысоту(з.указатель);
	}	
	
	final Размер дайРазмер(HDC hdc) // package
	{
		return Размер(дайШирину(hdc), дайВысоту(hdc));
	}
	
	final Размер дайРазмер(Графика з)
	{
		return Размер(дайШирину(з), дайВысоту(з));
	}	
	
	проц вымести()
	{
		if(HBITMAP.init != _hbmimgtype)
		{
			DeleteObject(_hbmimgtype);
			_hbmimgtype = HBITMAP.init;
		}
		
		if(ipic)
		{
			ipic.Release();
			ipic = пусто;
		}
	}
	
	
	~this()
	{
		вымести();
	}
		
	final HBITMAP вУкНаБитмап(HDC hdc) // package
	{
		HDC memdc;
		HBITMAP результат;
		HGDIOBJ oldbm;
		memdc = CreateCompatibleDC(hdc);
		if(!memdc)
			throw new ВизИскл("Ошибка устройства");
		try
		{
			Размер разм;
			разм = дайРазмер(hdc);
			результат = CreateCompatibleBitmap(hdc, разм.ширина, разм.высота);
			if(!результат)
			{
				bad_bm:
				throw new ВизИскл("Не удаётся разместить рисуноr");
			}
			oldbm = SelectObject(memdc, результат);
			рисуй(memdc, Точка(0, 0));
		}
		finally
		{
			if(oldbm)
				SelectObject(memdc, oldbm);
			DeleteDC(memdc);
		}
		return результат;
	}
		
	final Битмап вБитмап(HDC hdc) // package
	{
		HBITMAP hbm;
		hbm = вУкНаБитмап(hdc);
		if(!hbm)
			throw new ВизИскл("Не удаётся создать битмап");
		return new Битмап(hbm, да); // Owned.
	}
		
	final Битмап вБитмап()
	{
		Битмап результат;
		scope Графика з = Графика.дайЭкран();
		результат = вБитмап(з);
		//з.вымести(); // scope'd
		return результат;
	}
		
	final Битмап вБитмап(Графика з)
	{
		return вБитмап(з.указатель);
	}	
	
	HBITMAP _hbmimgtype;
	
	override цел _imgtype(HGDIOBJ* ph) // internal
	{
		if(ph)
		{
			if(HBITMAP.init == _hbmimgtype)
			{
				scope Графика з = Графика.дайЭкран();
				_hbmimgtype = вУкНаБитмап(з.указатель);
				//з.вымести(); // scope'd
			}
			
			*ph = _hbmimgtype;
		}
		return 1;
	}	
	
	private:
	winapi.IPicture ipic = пусто;	
	
	static winapi.IPicture _fromIStream(winapi.IStream istm)
	{
		winapi.IPicture ipic;
		switch(OleLoadPicture(istm, 0, FALSE, &_IID_IPicture, cast(проц**)&ipic))
		{
			case S_OK:
				return ipic;
			
			debug(VIZ_X)
			{
				case E_OUTOFMEMORY:
					debug assert(0, "Картинка: Вне памяти");
					break;
				case E_NOINTERFACE:
					debug assert(0, "Картинка: Объект не поддерживается интерфейсом");
					break;
				case E_UNEXPECTED:
					debug assert(0, "Картинка: Неожиданная ошибка");
					break;
				case E_POINTER:
					debug assert(0, "Картинка: Неверный указатель");
					break;
				case E_FAIL:
					debug assert(0, "Картинка: Провал");
					break;
			}
			
			default: ;
		}
		return пусто;
	}
		
	static winapi.IPicture _fromStream(Поток stm)
	in
	{
		assert(stm !is пусто);
	}
	body
	{
		scope ПотокВИПоток istm = new ПотокВИПоток(stm);
		return _fromIStream(istm);
	}	
	
	static winapi.IPicture _fromFileName(Ткст фимя)
	{
				
		HANDLE hf;
		HANDLE hg;
		ук pg;
		DWORD dwsz, dw;
		
		hf = создайФайл(фимя, GENERIC_READ, FILE_SHARE_READ, пусто,
			OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, пусто);
		if(!hf)
			return пусто;
		
		dwsz = GetFileSize(hf, пусто);
		if(0xFFFFFFFF == dwsz)
		{
			failclose:
			ЗакройДескр(hf);
			return пусто;
		}
		
		hg = GlobalAlloc(GMEM_MOVEABLE, dwsz);
		if(!hg)
			goto failclose;
		
		pg = GlobalLock(hg);
		if(!pg)
		{
			ЗакройДескр(hf);
			ЗакройДескр(hg);
			return пусто;
		}
		
		if(!ReadFile(hf, pg, dwsz, &dw, пусто) || dwsz != dw)
		{
			ЗакройДескр(hf);
			GlobalUnlock(hg);
			ЗакройДескр(hg);
			return пусто;
		}
		
		ЗакройДескр(hf);
		GlobalUnlock(hg);
		
		winapi.IStream istm;
		winapi.IPicture ipic;
		
		if(S_OK != CreateStreamOnHGlobal(hg, TRUE, &istm))
		{
			ЗакройДескр(hg);
			return пусто;
		}
		// Don't need to ЗакройДескр(hg) due to 2nd парам being TRUE.
		
		ipic = _fromIStream(istm);
		istm.Release();
		return ipic;
	}
		
	static winapi.IPicture _fromMemory(проц[] mem)
	{
		return _fromIStream(new ИПотокПамяти(mem));
	}
	
}


export extern(D) class ФорматТекста
{
export:

	this()
	{
	}
		
	this(ФорматТекста tf)
	{
		_trim = tf._trim;
		_flags = tf._flags;
		_align = tf._align;
		_params = tf._params;
	}
		
	this(ФлагиФорматаТекста флаги)
	{
		_flags = флаги;
	}
		
	static ФорматТекста генерныйДефолт() // getter
	{
		ФорматТекста результат;
		результат = new ФорматТекста;
		результат._trim = СокращениеТекста.НЕУК;
		результат._flags = ФлагиФорматаТекста.БЕЗ_ПРЕФИКСОВ | ФлагиФорматаТекста.ПРЕРВАТЬ_СЛОВО |
			ФлагиФорматаТекста.БЕЗ_ОБРЕЗКИ | ФлагиФорматаТекста.ЛИМИТ_СТРОКА;
		return результат;
	}
	
	static ФорматТекста генернаяТипографика() // getter
	{
		return new ФорматТекста;
	}
		
	final проц расположение(РасположениеТекста ta) // setter
	{
		_align = ta;
	}
	
	final РасположениеТекста расположение() // getter
	{
		return _align;
	}
		
	final проц флагиФормата(ФлагиФорматаТекста tff) // setter
	{
		_flags = tff;
	}
		
	final ФлагиФорматаТекста флагиФормата() // getter
	{
		return _flags;
	}	
	
	final проц сокращение(СокращениеТекста tt) // getter
	{
		_trim = tt;
	}
		
	final СокращениеТекста сокращение() // getter
	{
		return _trim;
	}
		
	// Units of the average character ширина.
	
	final проц длинаТаб(цел tablen) // setter
	{
		_params.iTabLength = tablen;
	}
		
	final цел длинаТаб() // getter
	{
		return _params.iTabLength;
	}
		
	// Units of the average character ширина.
	
		final проц левыйКрай(цел разм) // setter
	{
		_params.iLeftMargin = разм;
	}
		
	final цел левыйКрай() // getter
	{
		return _params.iLeftMargin;
	}	
	
	// Units of the average character ширина.
	
		final проц правыйКрай(цел разм) // setter
	{
		_params.iRightMargin = разм;
	}	
	
	final цел правыйКрай() // getter
	{
		return _params.iRightMargin;
	}	
	
	private:
	СокращениеТекста _trim = СокращениеТекста.НЕУК; // СокращениеТекста.CHARACTER.
	ФлагиФорматаТекста _flags = ФлагиФорматаТекста.БЕЗ_ПРЕФИКСОВ | ФлагиФорматаТекста.ПРЕРВАТЬ_СЛОВО;
	РасположениеТекста _align = РасположениеТекста.ЛЕВ;
	package DRAWTEXTPARAMS _params = { DRAWTEXTPARAMS.sizeof, 8, 0, 0 };
}

// Note: currently only works with the one screen.
export class Экран
{
export:

	static Экран первичныйЭкран() // getter
	{
		static Экран _ps;
		if(!_ps)
		{
			synchronized
			{
				if(!_ps)
					_ps = new Экран();
			}
		}
		return _ps;
	}
		
	Прям границы() // getter
	{
		ПРЯМ area;
		if(!GetWindowRect(GetDesktopWindow(), cast(RECT*) &area))
			assert(0);
		return Прям(&area);
	}
		
	Прям рабочаяЗона() // getter
	{
		ПРЯМ area;
		if(!SystemParametersInfoA(SPI_GETWORKAREA, 0,cast(RECT*)  &area, FALSE))
			return границы;
		return Прям(&area);
	}
		
	private:
	this() { }
}


export extern(D) class Графика // docmain
{
export:
	// Used internally.
	this(HDC hdc, бул owned = да)
	{
		this.hdc = hdc;
		this.owned = owned;
	}
		
	~this()
	{
		if(owned)
			вымести();
	}	
	
	// Used internally.
	final проц drawSizeGrip(цел право, цел верх) // package
	{
		Цвет light, dark;
		цел ш, в;
		
		light = СистемныеЦвета.оченьСветлыйУпр;
		dark = СистемныеЦвета.тёмныйУпр;
		scope Перо lightPen = new Перо(light);
		scope Перо darkPen = new Перо(dark);
		ш = право;
		в = верх;
		
		ш -= 3;
		в -= 3;
		рисуйЛинию(darkPen, ш, верх, право, в);
		ш--;
		в--;
		рисуйЛинию(darkPen, ш, верх, право, в);
		рисуйЛинию(lightPen, ш - 1, верх, право, в - 1);
		
		ш -= 3;
		в -= 3;
		рисуйЛинию(darkPen, ш, верх, право, в);
		ш--;
		в--;
		рисуйЛинию(darkPen, ш, верх, право, в);
		рисуйЛинию(lightPen, ш - 1, верх, право, в - 1);
		
		ш -= 3;
		в -= 3;
		рисуйЛинию(darkPen, ш, верх, право, в);
		ш--;
		в--;
		рисуйЛинию(darkPen, ш, верх, право, в);
		рисуйЛинию(lightPen, ш - 1, верх, право, в - 1);
	}
		
	// Used internally.
	// вСплит=да means the перемещение grip moves лево to право; нет means верх to верх.
	final проц drawMoveGrip(Прям movableArea, бул вСплит = да, т_мера count = 5) // package
	{
		const цел MSPACE = 4;
		const цел MWIDTH = 3;
		const цел MHEIGHT = 3;
		
		if(!count || !movableArea.ширина || !movableArea.высота)
			return;
		
		Цвет norm, light, dark, ddark;
		цел ш, в;
		т_мера iw;
		
		norm = СистемныеЦвета.упрэлт;
		light = СистемныеЦвета.оченьСветлыйУпр.смешайСЦветом(norm); // center
		//dark = СистемныеЦвета.тёмныйУпр.смешайСЦветом(norm); // верх
		ббайт ubmin(цел ub) { if(ub <= 0) return 0; return ub; }
		dark = Цвет(ubmin(cast(цел)norm.к - 0x10), ubmin(cast(цел)norm.з - 0x10), ubmin(cast(цел)norm.с - 0x10));
		//ddark = СистемныеЦвета.оченьТёмныйУпр; // верх
		ddark = СистемныеЦвета.тёмныйУпр.смешайСЦветом(Цвет(0x10, 0x10, 0x10)); // верх
		//scope Перо lightPen = new Перо(light);
		scope Перо darkPen = new Перо(dark);
		scope Перо ddarkPen = new Перо(ddark);
				
		проц drawSingleMoveGrip()
		{
			Точка[3] pts;
			
			pts[0].ш = ш + MWIDTH - 2;
			pts[0].в = в;
			pts[1].ш = ш;
			pts[1].в = в;
			pts[2].ш = ш;
			pts[2].в = в + MHEIGHT - 1;
			рисуйЛинии(darkPen, pts);
			
			pts[0].ш = ш + MWIDTH - 1;
			pts[0].в = в + 1;
			pts[1].ш = pts[0].ш;
			pts[1].в = в + MHEIGHT - 1;
			pts[2].ш = ш;
			pts[2].в = pts[1].в;
			рисуйЛинии(ddarkPen, pts);
			
			заполниПрямоугольник(light, ш + 1, в + 1, 1, 1);
		}
				
		if(вСплит)
		{
			ш = movableArea.ш + (movableArea.ширина / 2 - MWIDTH / 2);
			//в = movableArea.высота / 2 - ((MWIDTH * count) + (MSPACE * (count - 1))) / 2;
			в = movableArea.в + (movableArea.высота / 2 - ((MWIDTH * count) + (MSPACE * count)) / 2);
			
			for(iw = 0; iw != count; iw++)
			{
				drawSingleMoveGrip();
				в += MHEIGHT + MSPACE;
			}
		}
		else // гСплит
		{
			//ш = movableArea.ширина / 2 - ((MHEIGHT * count) + (MSPACE * (count - 1))) / 2;
			ш = movableArea.ш + (movableArea.ширина / 2 - ((MHEIGHT * count) + (MSPACE * count)) / 2);
			в = movableArea.в + (movableArea.высота / 2 - MHEIGHT / 2);
			
			for(iw = 0; iw != count; iw++)
			{
				drawSingleMoveGrip();
				ш += MWIDTH + MSPACE;
			}
		}
	}
		
	package final ФорматТекста дайФорматКэшированногоТекста()
	{
		static ФорматТекста фмт = пусто;
		if(!фмт)
			фмт = ФорматТекста.генерныйДефолт;
		return фмт;
	}
	
		// Windows 95/98/Me limits -текст- to 8192 characters.
	
		final проц рисуйТекст(Ткст текст, Шрифт шрифт, Цвет цвет, Прям к, ФорматТекста фмт)
	{
		// Should SaveDC/RestoreDC be used instead?
		
		ЦВПредст prevColor;
		УШрифт prevFont;
		цел prevBkMode;
		
		prevColor = SetTextColor(hdc, цвет.вКзс());
		prevFont = cast(УШрифт)SelectObject(hdc, шрифт ? шрифт.указатель : пусто);
		prevBkMode = SetBkMode(hdc, TRANSPARENT);
		
		ПРЯМ прям;
		к.дайПрям(&прям);
		рисуйТекстДоп(hdc, текст, cast(RECT*) &прям, DT_EXPANDTABS | DT_TABSTOP |
			фмт._trim | фмт._flags | фмт._align, &фмт._params);
		
		// Reset stuff.
		//if(CLR_INVALID != prevColor)
			SetTextColor(hdc, prevColor);
		//if(prevFont)
			SelectObject(hdc, prevFont);
		//if(prevBkMode)
			SetBkMode(hdc, prevBkMode);
	}
		
	final проц рисуйТекст(Ткст текст, Шрифт шрифт, Цвет цвет, Прям к)
	{
		return рисуйТекст(текст, шрифт, цвет, к, дайФорматКэшированногоТекста());
	}	
	
	final проц рисуйТекстДезакт(Ткст текст, Шрифт шрифт, Цвет цвет, Цвет цветФона, Прям к, ФорматТекста фмт)
	{
		к.смещение(1, 1);
		//рисуйТекст(текст, шрифт, Цвет(24, цвет).плотныйЦвет(цветФона), к, фмт); // Lighter, lower one.
		//рисуйТекст(текст, шрифт, Цвет.изКзс(~цвет.вКзс() & 0xFFFFFF), к, фмт); // Lighter, lower one.
		рисуйТекст(текст, шрифт, Цвет(192, Цвет.изКзс(~цвет.вКзс() & 0xFFFFFF)).плотныйЦвет(цветФона), к, фмт); // Lighter, lower one.
		к.смещение(-1, -1);
		рисуйТекст(текст, шрифт, Цвет(128, цвет).плотныйЦвет(цветФона), к, фмт);
	}	
	
	final проц рисуйТекстДезакт(Ткст текст, Шрифт шрифт, Цвет цвет, Цвет цветФона, Прям к)
	{
		return рисуйТекстДезакт(текст, шрифт, цвет, цветФона, к, дайФорматКэшированногоТекста());
	}	
	
	/+
	final Размер мерьТекст(Ткст текст, Шрифт шрифт)
	{
		РАЗМЕР разм;
		УШрифт prevFont;
		
		prevFont = cast(УШрифт)SelectObject(hdc, шрифт ? шрифт.указатель : пусто);
		
		getTextExtentPoint32(hdc, текст, &разм);
		
		//if(prevFont)
			SelectObject(hdc, prevFont);
		
		return Размер(разм.cx, разм.cy);
	}
	+/	
	
	private const цел DEFAULT_MEASURE_SIZE = short.max; // Has to be smaller because it's 16-bits on win9x.
	
	
	final Размер мерьТекст(Ткст текст, Шрифт шрифт, цел максШирина, ФорматТекста фмт)
	{
		ПРЯМ прям;
		УШрифт prevFont;
		
		прям.лево = 0;
		прям.верх = 0;
		прям.право = максШирина;
		прям.низ = DEFAULT_MEASURE_SIZE;
		
		prevFont = cast(УШрифт)SelectObject(hdc, шрифт ? шрифт.указатель : пусто);
		
		if(!рисуйТекстДоп(hdc, текст,cast(RECT*)  &прям, DT_EXPANDTABS | DT_TABSTOP |
			фмт._trim | фмт._flags | фмт._align | DT_CALCRECT | DT_NOCLIP, &фмт._params))
		{
			//throw new ВизИскл("Text measure ошибка");
			прям.лево = 0;
			прям.верх = 0;
			прям.право = 0;
			прям.низ = 0;
		}
		
		//if(prevFont)
			SelectObject(hdc, prevFont);
		
		return Размер(прям.право - прям.лево, прям.низ - прям.верх);
	}
		
	final Размер мерьТекст(Ткст текст, Шрифт шрифт, ФорматТекста фмт)
	{
		return мерьТекст(текст, шрифт, DEFAULT_MEASURE_SIZE, фмт);
	}	
	
	final Размер мерьТекст(Ткст текст, Шрифт шрифт, цел максШирина)
	{
		return мерьТекст(текст, шрифт, максШирина, дайФорматКэшированногоТекста());
	}	
	
	final Размер мерьТекст(Ткст текст, Шрифт шрифт)
	{
		return мерьТекст(текст, шрифт, DEFAULT_MEASURE_SIZE, дайФорматКэшированногоТекста());
	}	
	
	/+
	// Doesn't work... рисуйТекстДоп uses а different buffer!
	// 	final Ткст getTrimmedText(Ткст текст, Шрифт шрифт, Прям к, ФорматТекста фмт) // deprecated
	{
		switch(фмт.сокращение)
		{
			case СокращениеТекста.ЭЛЛИПСИС:
			case СокращениеТекста.ЭЛЛИПСИС_ПУТЬ:
				{
					сим[] newтекст;
					ПРЯМ прям;
					УШрифт prevFont;
					
					newтекст = текст.dup;
					к.дайПрям(&прям);
					prevFont = cast(УШрифт)SelectObject(hdc, шрифт ? шрифт.указатель : пусто);
					
					// DT_CALCRECT needs to prevent it from actually drawing.
					if(!рисуйТекстДоп(hdc, newтекст, &прям, DT_EXPANDTABS | DT_TABSTOP |
						фмт._trim | фмт._flags | фмт._align | DT_CALCRECT | DT_MODIFYSTRING | DT_NOCLIP, &фмт._params))
					{
						//throw new ВизИскл("Text сокращение ошибка");
					}
					
					//if(prevFont)
						SelectObject(hdc, prevFont);
					
					for(т_мера iw = 0; iw != newтекст.length; iw++)
					{
						if(!newтекст[iw])
							return newтекст[0 .. iw];
					}
					//return newтекст;
					// There was нет change, so нет sense in keeping the duplicate.
					delete newтекст;
					return текст;
				}
				break;
			
			default: ;
				return текст;
		}
	}
	
	// 	final Ткст getTrimmedText(Ткст текст, Шрифт шрифт, Прям к, СокращениеТекста trim)
	{
		scope фмт = new ФорматТекста(ФлагиФорматаТекста.БЕЗ_ПРЕФИКСОВ | ФлагиФорматаТекста.ПРЕРВАТЬ_СЛОВО |
			ФлагиФорматаТекста.БЕЗ_ОБРЕЗКИ | ФлагиФорматаТекста.ЛИМИТ_СТРОКА);
		фмт.сокращение = trim;
		return getTrimmedText(текст, шрифт, к, фмт);
	}
	+/	
	
		final проц рисуйПиктограмму(Пиктограмма пиктограмма, Прям к)
	{
		// DrawIconEx operates differently if the ширина or высота is zero
		// so bail out if zero and pretend the zero размер пиктограмма was drawn.
		цел ширина = к.ширина;
		if(!ширина)
			return;
		цел высота = к.высота;
		if(!высота)
			return;
		
		DrawIconEx(указатель, к.ш, к.в, пиктограмма.указатель, ширина, высота, 0, пусто, DI_NORMAL);
	}	
	
	final проц рисуйПиктограмму(Пиктограмма пиктограмма, цел ш, цел в)
	{
		DrawIconEx(указатель, ш, в, пиктограмма.указатель, 0, 0, 0, пусто, DI_NORMAL);
	}	
	
	final проц заполниПрямоугольник(Кисть кисть, Прям к)
	{
		заполниПрямоугольник(кисть, к.ш, к.в, к.ширина, к.высота);
	}	
	
	final проц заполниПрямоугольник(Кисть кисть, цел ш, цел в, цел ширина, цел высота)
	{
		ПРЯМ прям;
		прям.лево = ш;
		прям.право = ш + ширина;
		прям.верх = в;
		прям.низ = в + высота;
		FillRect(указатель,cast(RECT*)  &прям, кисть.указатель);
	}	
	
	// Extra function.
	final проц заполниПрямоугольник(Цвет цвет, Прям к)
	{
		заполниПрямоугольник(цвет, к.ш, к.в, к.ширина, к.высота);
	}	
	
	// Extra function.
	final проц заполниПрямоугольник(Цвет цвет, цел ш, цел в, цел ширина, цел высота)
	{
		ПРЯМ прям;
		цел prevBkColor;
		
		prevBkColor = SetBkColor(hdc, цвет.вКзс());
		
		прям.лево = ш;
		прям.верх = в;
		прям.право = ш + ширина;
		прям.низ = в + высота;
		ExtTextOutA(hdc, ш, в, ETO_OPAQUE,cast(RECT*)  &прям, "", 0, пусто);
		
		// Reset stuff.
		//if(CLR_INVALID != prevBkColor)
			SetBkColor(hdc, prevBkColor);
	}
		
	final проц заполниРегион(Кисть кисть, Регион регион)
	{
		FillRgn(указатель, регион.указатель, кисть.указатель);
	}
		
	static Графика изУок(УОК уок)
	{
		return new ОбщаяГрафика(уок, GetDC(уок));
	}
		
	/// Get the entire screen's Графика for the primary monitor.
	static Графика дайЭкран()
	{
		return new ОбщаяГрафика(пусто, GetWindowDC(пусто));
	}
		
	final проц рисуйЛинию(Перо pen, Точка старт, Точка end)
	{
		рисуйЛинию(pen, старт.ш, старт.в, end.ш, end.в);
	}	
	
	final проц рисуйЛинию(Перо pen, цел стартX, цел стартY, цел endX, цел endY)
	{
		УПеро prevPen;
		
		prevPen = SelectObject(hdc, pen.указатель);
		
		MoveToEx(hdc, стартX, стартY, пусто);
		LineTo(hdc, endX, endY);
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
	}	
	
		// First two точки is the first line, the other точки link а line
	// to the previous Точка.
	final проц рисуйЛинии(Перо pen, Точка[] точки)
	{
		if(точки.length < 2)
		{
			assert(0); // Not enough line точки.
			return;
		}
		
		УПеро prevPen;
		цел i;
		
		prevPen = SelectObject(hdc, pen.указатель);
		
		MoveToEx(hdc, точки[0].ш, точки[0].в, пусто);
		for(i = 1;;)
		{
			LineTo(hdc, точки[i].ш, точки[i].в);
			
			if(++i == точки.length)
				break;
		}
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
	}
		
	final проц рисуйАрку(Перо pen, цел ш, цел в, цел ширина, цел высота, цел arcX1, цел arcY1, цел arcX2, цел arcY2)
	{
		УПеро prevPen;
		
		prevPen = SelectObject(hdc, pen.указатель);
		
		Arc(hdc, ш, в, ш + ширина, в + высота, arcX1, arcY1, arcX2, arcY2);
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
	}	
	
	final проц рисуйАрку(Перо pen, Прям к, Точка arc1, Точка arc2)
	{
		рисуйАрку(pen, к.ш, к.в, к.ширина, к.высота, arc1.ш, arc1.в, arc2.ш, arc2.в);
	}	
	
	final проц рисуйБезье(Перо pen, Точка[4] точки)
	{
		УПеро prevPen;
		ТОЧКА* cpts;
		
		prevPen = SelectObject(hdc, pen.указатель);
		
		// This assumes а Точка is laid out exactly like а Точка.
		static assert(Точка.sizeof == ТОЧКА.sizeof);
		cpts = cast(ТОЧКА*)точки;
		
		PolyBezier(hdc,cast(POINT*) cpts, 4);
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
	}	
	
	final проц рисуйБезье(Перо pen, Точка pt1, Точка pt2, Точка pt3, Точка pt4)
	{
		Точка[4] точки;
		точки[0] = pt1;
		точки[1] = pt2;
		точки[2] = pt3;
		точки[3] = pt4;
		рисуйБезье(pen, точки);
	}
		
		// First 4 точки are the first bezier, each next 3 are the next
	// beziers, using the previous last Точка as the стартing Точка.
	final проц рисуйБезьеМн(Перо pen, Точка[] точки)
	{
		if(точки.length < 1 || (точки.length - 1) % 3)
		{
			assert(0); // Bad number of точки.
			//return; // Let PolyBezier() do what it wants with the bad number.
		}
		
		УПеро prevPen;
		ТОЧКА* cpts;
		
		prevPen = SelectObject(hdc, pen.указатель);
		
		// This assumes а Точка is laid out exactly like а Точка.
		static assert(Точка.sizeof == ТОЧКА.sizeof);
		cpts = cast(ТОЧКА*)точки;
		
		PolyBezier(hdc, cast(POINT*) cpts, точки.length);
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
	}	
	
	// TODO: drawCurve(), drawClosedCurve() ...
	
	
	final проц рисуйЭллипс(Перо pen, Прям к)
	{
		рисуйЭллипс(pen, к.ш, к.в, к.ширина, к.высота);
	}	
	
	final проц рисуйЭллипс(Перо pen, цел ш, цел в, цел ширина, цел высота)
	{
		УПеро prevPen;
		УКисть prevBrush;
		
		prevPen = SelectObject(hdc, pen.указатель);
		prevBrush = SelectObject(hdc, cast(УКисть)GetStockObject(NULL_BRUSH)); // Don't fill it in.
		
		Ellipse(hdc, ш, в, ш + ширина, в + высота);
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
		SelectObject(hdc, prevBrush);
	}	
	
	// TODO: drawPie()	
	
	final проц рисуйМногоугольник(Перо pen, Точка[] точки)
	{
		if(точки.length < 2)
		{
			assert(0); // Need at least 2 точки.
			//return;
		}
		
		УПеро prevPen;
		УКисть prevBrush;
		ТОЧКА* cpts;
		
		prevPen = SelectObject(hdc, pen.указатель);
		prevBrush = SelectObject(hdc, cast(УКисть)GetStockObject(NULL_BRUSH)); // Don't fill it in.
		
		// This assumes а Точка is laid out exactly like а Точка.
		static assert(Точка.sizeof == ТОЧКА.sizeof);
		cpts = cast(ТОЧКА*)точки;
		
		Polygon(hdc, cast(POINT*) cpts, точки.length);
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
		SelectObject(hdc, prevBrush);
	}
		
	final проц рисуйПрямоугольник(Перо pen, Прям к)
	{
		рисуйПрямоугольник(pen, к.ш, к.в, к.ширина, к.высота);
	}	
	
	final проц рисуйПрямоугольник(Перо pen, цел ш, цел в, цел ширина, цел высота)
	{
		УПеро prevPen;
		УКисть prevBrush;
		
		prevPen = SelectObject(hdc, pen.указатель);
		prevBrush = SelectObject(hdc, cast(УКисть)GetStockObject(NULL_BRUSH)); // Don't fill it in.
		
		Rectangle(hdc, ш, в, ш + ширина, в + высота);
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
		SelectObject(hdc, prevBrush);
	}	
	
	/+
	final проц рисуйПрямоугольник(Цвет ктрл, Прям к)
	{
		рисуйПрямоугольник(ктрл, к.ш, к.в, к.ширина, к.высота);
	}
	
	
	final проц рисуйПрямоугольник(Цвет ктрл, цел ш, цел в, цел ширина, цел высота)
	{
		
	}
	+/	
	
	final проц рисуйПрямоугольники(Перо pen, Прям[] rs)
	{
		УПеро prevPen;
		УКисть prevBrush;
		
		prevPen = SelectObject(hdc, pen.указатель);
		prevBrush = SelectObject(hdc, cast(УКисть)GetStockObject(NULL_BRUSH)); // Don't fill it in.
		
		foreach(inout Прям к; rs)
		{
			Rectangle(hdc, к.ш, к.в, к.ш + к.ширина, к.в + к.высота);
		}
		
		// Reset stuff.
		SelectObject(hdc, prevPen);
		SelectObject(hdc, prevBrush);
	}
		
		// Force pending графика operations.
	final проц слей()
	{
		GdiFlush();
	}
		
	final Цвет дайБлижайшийЦвет(Цвет ктрл)
	{
		ЦВПредст цпредст;
		цпредст = GetNearestColor(указатель, ктрл.вКзс());
		if(CLR_INVALID == цпредст)
			return Цвет.пуст;
		return Цвет.изКзс(ктрл.а, цпредст); // Preserve альфа.
	}
		
	final Размер getScaleSize(Шрифт f)
	{
		// http://support.microsoft.com/kb/125681
		Размер результат;
		version(DIALOG_BOX_SCALE)
		{
			const Ткст SAMPLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
			результат = мерьТекст(SAMPLE, f);
			результат.ширина = (результат.ширина / (SAMPLE.length / 2) + 1) / 2;
			TEXTMETRICA tma;
			if(GetTextMetricsA(указатель, &tma))
				результат.высота = tma.tmHeight;
		}
		else
		{
			const Ткст SAMPLE = "Abcdefghijklmnopqrstuvwxyz";
			результат = мерьТекст(SAMPLE, f);
			результат.ширина /= SAMPLE.length;
		}
		return результат;
	}
		
	final бул копируйВ(HDC dest, цел destX, цел destY, цел ширина, цел высота, цел srcX = 0, цел srcY = 0, DWORD rop = SRCCOPY) // package
	{
		return cast(бул)BitBlt(dest, destX, destY, ширина, высота, this.указатель, srcX, srcY, rop);
	}
		
	final бул копируйВ(Графика destGraphics, цел destX, цел destY, цел ширина, цел высота, цел srcX = 0, цел srcY = 0, DWORD rop = SRCCOPY)
	{
		return копируйВ(destGraphics.указатель, destX, destY, ширина, высота, srcX, srcY, rop);
	}
		
	final бул копируйВ(Графика destGraphics, Прям границы)
	{
		return копируйВ(destGraphics.указатель, границы.ш, границы.в, границы.ширина, границы.высота);
	}	
	
	final HDC указатель() // getter
	{
		return hdc;
	}
	
	проц вымести()
	{
		assert(owned);
		DeleteDC(hdc);
		hdc = пусто;
	}
		
	private:
	HDC hdc;
	бул owned = да;
}


/// Графика for а surface in memory.
export class ГрафикаВПамяти: Графика // docmain
{
export:
		// Графика compatible with the текущий screen.
	this(цел ширина, цел высота)
	{
		HDC hdc;
		hdc = GetWindowDC(пусто);
		scope(exit)
			ReleaseDC(пусто, hdc);
		this(ширина, высота, hdc);
	}	
	
	// graphicsCompatible cannot be another ГрафикаВПамяти.
	this(цел ширина, цел высота, Графика graphicsCompatible)
	{
		if(cast(ГрафикаВПамяти)graphicsCompatible)
		{
			//throw new ВизИскл("Графика cannot be compatible with memory");
			assert(0, "Графика не совместима с памятью");
		}
		this(ширина, высота, graphicsCompatible.указатель);
	}	
	
	// Used internally.
	this(цел ширина, цел высота, HDC hdcCompatible) // package
	{
		_w = ширина;
		_h = высота;
		
		hbm = CreateCompatibleBitmap(hdcCompatible, ширина, высота);
		if(!hbm)
			throw new ВизИскл("Не удаётся разместить память под Графику");
		scope(failure)
		{
			DeleteObject(hbm);
			//hbm = HBITMAP.init;
		}
		
		HDC hdcc;
		hdcc = CreateCompatibleDC(hdcCompatible);
		if(!hdcc)
			throw new ВизИскл("Не удаётся разместить Графику в памяти");
		scope(failure)
			DeleteDC(hdcc);
		
		hbmOld = SelectObject(hdcc, hbm);
		scope(failure)
			SelectObject(hdcc, hbmOld);
		
		super(hdcc);
	}	
	
	final цел ширина() // getter
	{
		return _w;
	}	
	
	final цел высота() // getter
	{
		return _h;
	}	
	
	final Размер размер() // getter
	{
		return Размер(_w, _h);
	}	
	
	final HBITMAP укНаБитмап() // getter // package
	{
		return hbm;
	}	
	
	// Needs to копируй so it can be selected into other DC`s.
	final HBITMAP вУкНаБитмап(HDC hdc) // package
	{
		HDC memdc;
		HBITMAP результат;
		HGDIOBJ oldbm;
		memdc = CreateCompatibleDC(hdc);
		if(!memdc)
			throw new ВизИскл("Ошибка устройства");
		try
		{
			результат = CreateCompatibleBitmap(hdc, ширина, высота);
			if(!результат)
			{
				bad_bm:
				throw new ВизИскл("Не удаётся разместить рисуноr");
			}
			oldbm = SelectObject(memdc, результат);
			копируйВ(memdc, 0, 0, ширина, высота);
		}
		finally
		{
			if(oldbm)
				SelectObject(memdc, oldbm);
			DeleteDC(memdc);
		}
		return результат;
	}
		
	final Битмап вБитмап(HDC hdc) // package
	{
		HBITMAP hbm;
		hbm = вУкНаБитмап(hdc);
		if(!hbm)
			throw new ВизИскл("Не удаётся создание битмапа");
		return new Битмап(hbm, да); // Owned.
	}	
	
	final Битмап вБитмап()
	{
		Графика з;
		Битмап результат;
		з = Графика.дайЭкран();
		результат = вБитмап(з);
		з.вымести();
		return результат;
	}	
	
	final Битмап вБитмап(Графика з)
	{
		return вБитмап(з.указатель);
	}	
	
	override проц вымести()
	{
		SelectObject(hdc, hbmOld);
		hbmOld = HGDIOBJ.init;
		DeleteObject(hbm);
		hbm = HBITMAP.init;
		super.вымести();
	}	
	
	private:
	HGDIOBJ hbmOld;
	HBITMAP hbm;
	цел _w, _h;
}

// Use with GetDC()/GetWindowDC()/GetDCEx() so that
// the HDC is properly released instead of deleted.
package class ОбщаяГрафика: Графика
{
	// Used internally.
	this(УОК уок, HDC hdc, бул owned = да)
	{
		super(hdc, owned);
		this.уок = уок;
	}	
	
	override проц вымести()
	{
		ReleaseDC(уок, hdc);
		hdc = пусто;
	}	
	
	package:
	УОК уок;
}

export class Пиктограмма: Рисунок // docmain
{
export:
	// Used internally.
	this(УИконка hi, бул owned = да)
	{
		this.hi = hi;
		this.owned = owned;
	}
		
	deprecated static Пиктограмма поУказателю(УИконка hi)
	{
		return new Пиктограмма(hi, нет); // Not owned. Up to caller to manage or call вымести().
	}	
	
	// -bm- can be пусто.
	// NOTE: the bitmaps in -ii- need to be deleted! _deleteBitmaps() is а быстрыйЗапуск.
	private проц _getInfo(ICONINFO* ii, БИТМАП* bm = пусто)
	{
		if(GetIconInfo(hi, ii))
		{
			if(!bm)
				return;
			
			HBITMAP hbm;
			if(ii.hbmColor)
				hbm = ii.hbmColor;
			else // Monochrome.
				hbm = ii.hbmMask;
			if(GetObjectA(hbm, БИТМАП.sizeof, bm) == БИТМАП.sizeof)
				return;
		}
		
		// Fell through, failed.
		throw new ВизИскл("Не удаётся получить информацию о рисунке");
	}
		
	private проц _deleteBitmaps(ICONINFO* ii)
	{
		DeleteObject(ii.hbmColor);
		ii.hbmColor = пусто;
		DeleteObject(ii.hbmMask);
		ii.hbmMask = пусто;
	}	
	
	final Битмап вБитмап()
	{
		ICONINFO ii;
		БИТМАП bm;
		_getInfo(&ii, &bm);
		// Not calling _deleteBitmaps() because I'm keeping one.
		
		HBITMAP hbm;
		if(ii.hbmColor)
		{
			hbm = ii.hbmColor;
			DeleteObject(ii.hbmMask);
		}
		else // Monochrome.
		{
			hbm = ii.hbmMask;
		}
		
		return new Битмап(hbm, да); // Yes owned.
	}	
	
	final override проц рисуй(Графика з, Точка тчк)
	{
		з.рисуйПиктограмму(this, тчк.ш, тчк.в);
	}	
	
	final override проц рисуйРастяни(Графика з, Прям к)
	{
		з.рисуйПиктограмму(this, к);
	}	
	
	final override Размер размер() // getter
	{
		ICONINFO ii;
		БИТМАП bm;
		_getInfo(&ii, &bm);
		_deleteBitmaps(&ii);
		return Размер(bm.ширина, bm.высота);
	}	
	
	final override цел ширина() // getter
	{
		return размер.ширина;
	}	
	
	final override цел высота() // getter
	{
		return размер.высота;
	}	
	
	~this()
	{
		if(owned)
			вымести();
	}
		
	цел _imgtype(HGDIOBJ* ph) // internal
	{
		if(ph)
			*ph = cast(HGDIOBJ)hi;
		return 2;
	}	
	
	проц вымести()
	{
		assert(owned);
		DestroyIcon(hi);
		hi = пусто;
	}	
	
	final УИконка указатель() // getter
	{
		return hi;
	}
		
	private:
	УИконка hi;
	бул owned = да;
}


/+
// TODO: check if correct implementation.
enum GenericFontFamilies
{
	MONOSPACE = FF_MODERN,
	SANS_SERIF = FF_ROMAN,
	SERIF = FF_SWISS,
}
+/


/+
abstract class FontCollection
{
	abstract FontFamily[] families(); // getter
}


class FontFamily
{
	/+
	this(GenericFontFamilies genericFamily)
	{
		
	}
	+/
	
	
	this(Ткст имя)
	{
		
	}
	
	
	this(Ткст имя, FontCollection fontCollection)
	{
		
	}
	
	
	final Ткст имя() // getter
	{
		
	}
	
	
	static FontFamily[] families() // getter
	{
		
	}
	
	
	/+
	// TODO: implement.
	
	static FontFamily genericMonospace() // getter
	{
		
	}
	
	
	static FontFamily genericSansSerif() // getter
	{
		
	}
	
	
	static FontFamily genericSerif() // getter
	{
		
	}
	+/
}
+/



export class Шрифт // docmain
{
export:
	// Used internally.
	static проц LOGFONTAtoLogFont(inout ШрифтЛога шл, LOGFONTA* plfa) // package // deprecated
	{
		шл.шла = *plfa;
		шл.имяФаса = изАнзи0(plfa.lfFaceName.ptr);
	}
	
	// Used internally.
	static проц LOGFONTWtoLogFont(inout ШрифтЛога шл, LOGFONTW* plfw) // package // deprecated
	{
		шл.шлш = *plfw;
		шл.имяФаса = изЮникода0(plfw.lfFaceName.ptr);
	}
	
	
	// Used internally.
	this(УШрифт hf, LOGFONTA* plfa, бул owned = да) // package // deprecated
	{
		ШрифтЛога шл;
		LOGFONTAtoLogFont(шл, plfa);
		
		this.hf = hf;
		this.owned = owned;
		this._unit = ЕдиницаГрафики.ТОЧКА;
		
		_fstyle = _style(шл);
		_initLf(шл);
	}
	
	
	// Used internally.
	this(УШрифт hf, inout ШрифтЛога шл, бул owned = да) // package
	{
		this.hf = hf;
		this.owned = owned;
		this._unit = ЕдиницаГрафики.ТОЧКА;
		
		_fstyle = _style(шл);
		_initLf(шл);
	}
	
	
	// Used internally.
	this(УШрифт hf, бул owned = да) // package
	{
		this.hf = hf;
		this.owned = owned;
		this._unit = ЕдиницаГрафики.ТОЧКА;
		
		ШрифтЛога шл;
		_info(шл);
		
		_fstyle = _style(шл);
		_initLf(шл);
	}
	
	
	// Used internally.
	this(LOGFONTA* plfa, бул owned = да) // package // deprecated
	{
		ШрифтЛога шл;
		LOGFONTAtoLogFont(шл, plfa);
		
		this(_create(шл), шл, owned);
	}
	
	
	// Used internally.
	this(inout ШрифтЛога шл, бул owned = да) // package
	{
		this(_create(шл), шл, owned);
	}
	
	
	package static УШрифт _create(inout ШрифтЛога шл)
	{
		УШрифт результат;
		результат = createFontIndirect(шл);
		if(!результат)
			throw new ВизИскл("Не удаётся создать шрифт");
		return результат;
	}
	
	
	private static проц _style(inout ШрифтЛога шл, СтильШрифта стиль)
	{
		шл.шл.lfWeight = (стиль & СтильШрифта.ПОЛУЖИРНЫЙ) ? FW_BOLD : FW_NORMAL;
		шл.шл.lfItalic = (стиль & СтильШрифта.КУРСИВ) ? TRUE : FALSE;
		шл.шл.lfUnderline = (стиль & СтильШрифта.ПОДЧЁРКНУТЫЙ) ? TRUE : FALSE;
		шл.шл.lfStrikeOut = (стиль & СтильШрифта.ЗАЧЁРКНУТЫЙ) ? TRUE : FALSE;
	}
	
	
	private static СтильШрифта _style(inout ШрифтЛога шл)
	{
		СтильШрифта стиль = СтильШрифта.ОБЫЧНЫЙ;
		
		if(шл.шл.lfWeight >= FW_BOLD)
			стиль |= СтильШрифта.ПОЛУЖИРНЫЙ;
		if(шл.шл.lfItalic)
			стиль |= СтильШрифта.КУРСИВ;
		if(шл.шл.lfUnderline)
			стиль |= СтильШрифта.ПОДЧЁРКНУТЫЙ;
		if(шл.шл.lfStrikeOut)
			стиль |= СтильШрифта.ЗАЧЁРКНУТЫЙ;
		
		return стиль;
	}
	
	
	package проц _info(LOGFONTA* шл) // deprecated
	{
		if(GetObjectA(hf, LOGFONTA.sizeof, шл) != LOGFONTA.sizeof)
			throw new ВизИскл("Не получена информация о шрифте");
	}
	
	package проц _info(LOGFONTW* шл) // deprecated
	{
		auto proc = cast(GetObjectWProc)GetProcAddress(GetModuleHandleA("gdi32.dll"), "GetObjectW");
		
		if(!proc || proc(hf, LOGFONTW.sizeof, шл) != LOGFONTW.sizeof)
			throw new ВизИскл("Не удаётся получить информацию о шрифте");
	}
	
	
	package проц _info(inout ШрифтЛога шл)
	{
		if(!getLogFont(hf, шл))
			throw new ВизИскл("Unable to get шрифт информация");
	}
		
	package static цел getLfHeight(float emSize, ЕдиницаГрафики unit)
	{
		цел результат;
		HDC hdc;
		
		switch(unit)
		{
			case ЕдиницаГрафики.ПИКСЕЛЬ:
				результат = cast(цел)emSize;
				break;
			
			case ЕдиницаГрафики.ТОЧКА:
				hdc = GetWindowDC(пусто);
				результат = MulDiv(cast(цел)(emSize * 100), GetDeviceCaps(hdc, LOGPIXELSY), 72 * 100);
				ReleaseDC(пусто, hdc);
				break;
			
			case ЕдиницаГрафики.ДИСПЛЕЙ:
				hdc = GetWindowDC(пусто);
				результат = MulDiv(cast(цел)(emSize * 100), GetDeviceCaps(hdc, LOGPIXELSY), 75 * 100);
				ReleaseDC(пусто, hdc);
				break;
			
			case ЕдиницаГрафики.МИЛЛИМЕТР:
				hdc = GetWindowDC(пусто);
				результат = MulDiv(cast(цел)(emSize * 100), GetDeviceCaps(hdc, LOGPIXELSY), 2540);
				ReleaseDC(пусто, hdc);
				break;
			
			case ЕдиницаГрафики.ДЮЙМ:
				hdc = GetWindowDC(пусто);
				результат = cast(цел)(emSize * cast(float)GetDeviceCaps(hdc, LOGPIXELSY));
				ReleaseDC(пусто, hdc);
				break;
			
			case ЕдиницаГрафики.ДОКУМЕНТ:
				hdc = GetWindowDC(пусто);
				результат = MulDiv(cast(цел)(emSize * 100), GetDeviceCaps(hdc, LOGPIXELSY), 300 * 100);
				ReleaseDC(пусто, hdc);
				break;
			
			case ЕдиницаГрафики.TWIP:
				hdc = GetWindowDC(пусто);
				результат = MulDiv(cast(цел)(emSize * 100), GetDeviceCaps(hdc, LOGPIXELSY), 1440 * 100);
				ReleaseDC(пусто, hdc);
				break;
		}
		
		return результат;
	}
	
	
	package static float getEmSize(HDC hdc, цел lfHeight, ЕдиницаГрафики toUnit)
	{
		float результат;
		
		if(lfHeight < 0)
			lfHeight = -lfHeight;
		
		switch(toUnit)
		{
			case ЕдиницаГрафики.ПИКСЕЛЬ:
				результат = cast(float)lfHeight;
				break;
			
			case ЕдиницаГрафики.ТОЧКА:
				результат = cast(float)MulDiv(lfHeight, 72, GetDeviceCaps(hdc, LOGPIXELSY));
				break;
			
			case ЕдиницаГрафики.МИЛЛИМЕТР:
				результат = cast(float)MulDiv(lfHeight, 254, GetDeviceCaps(hdc, LOGPIXELSY)) / 10.0;
				break;
			
			case ЕдиницаГрафики.ДЮЙМ:
				результат = cast(float)lfHeight / cast(float)GetDeviceCaps(hdc, LOGPIXELSY);
				break;
			
			case ЕдиницаГрафики.ДОКУМЕНТ:
				результат = cast(float)MulDiv(lfHeight, 300, GetDeviceCaps(hdc, LOGPIXELSY));
				break;
			
			case ЕдиницаГрафики.TWIP:
				результат = cast(float)MulDiv(lfHeight, 1440, GetDeviceCaps(hdc, LOGPIXELSY));
				break;
		}
		
		return результат;
	}
	
	
	package static float getEmSize(цел lfHeight, ЕдиницаГрафики toUnit)
	{
		if(ЕдиницаГрафики.ПИКСЕЛЬ == toUnit)
		{
			if(lfHeight < 0)
				return cast(float)-lfHeight;
			return cast(float)lfHeight;
		}
		HDC hdc;
		hdc = GetWindowDC(пусто);
		float результат = getEmSize(hdc, lfHeight, toUnit);
		ReleaseDC(пусто, hdc);
		return результат;
	}
	
	
		this(Шрифт шрифт, СтильШрифта стиль)
	{
		ШрифтЛога шл;
		_unit = шрифт._unit;
		шрифт._info(шл);
		_style(шл, стиль);
		this(_create(шл));
		
		_fstyle = стиль;
		_initLf(шрифт, шл);
	}
	
	
	this(Ткст имя, float emSize, ЕдиницаГрафики unit)
	{
		this(имя, emSize, СтильШрифта.ОБЫЧНЫЙ, unit);
	}
	
	
	
	this(Ткст имя, float emSize, СтильШрифта стиль = СтильШрифта.ОБЫЧНЫЙ,
		ЕдиницаГрафики unit = ЕдиницаГрафики.ТОЧКА)
	{
		this(имя, emSize, стиль, unit, DEFAULT_CHARSET, СглаживаниеШрифта.ПО_УМОЛЧАНИЮ);
	}
	
	
	
	this(Ткст имя, float emSize, СтильШрифта стиль,
		ЕдиницаГрафики unit, СглаживаниеШрифта smoothing)
	{
		this(имя, emSize, стиль, unit, DEFAULT_CHARSET, smoothing);
	}
	
	// 
	// This is а somewhat internal function.
	// -гарнитураГди- is one of *_CHARSET from wingdi.h
	this(Ткст имя, float emSize, СтильШрифта стиль,
		ЕдиницаГрафики unit, ббайт гарнитураГди,
		СглаживаниеШрифта smoothing = СглаживаниеШрифта.ПО_УМОЛЧАНИЮ)
	{
		ШрифтЛога шл;
		
		_unit = unit;
		
		шл.имяФаса = имя;
		
		шл.шл.lfHeight = -getLfHeight(emSize, unit);
		_style(шл, стиль);
		
		шл.шл.lfCharSet = гарнитураГди;
		шл.шл.lfOutPrecision = OUT_DEFAULT_PRECIS;
		шл.шл.lfClipPrecision = CLIP_DEFAULT_PRECIS;
		//шл.шл.lfQuality = DEFAULT_QUALITY;
		шл.шл.lfQuality = smoothing;
		шл.шл.lfPitchAndFamily = DEFAULT_PITCH | FF_DONTCARE;
		
		this(_create(шл));
		
		_fstyle = стиль;
		_initLf(шл);
	}
	
	
	~this()
	{
		if(owned)
			DeleteObject(hf);
	}
	
	
		final УШрифт указатель() // getter
	{
		return hf;
	}
	
	
		final ЕдиницаГрафики unit() // getter
	{
		return _unit;
	}
	
	
		final float размер() // getter
	{
		/+
		LOGFONTA шл;
		_info(&шл);
		return getEmSize(шл.шл.lfHeight, _unit);
		+/
		return getEmSize(this.lfHeight, _unit);
	}
	
	
		final float дайРазмер(ЕдиницаГрафики unit)
	{
		/+
		LOGFONTA шл;
		_info(&шл);
		return getEmSize(шл.шл.lfHeight, unit);
		+/
		return getEmSize(this.lfHeight, unit);
	}
	
	
	final float дайРазмер(ЕдиницаГрафики unit, Графика з)
	{
		return getEmSize(з.указатель, this.lfHeight, unit);
	}
	
	
		final СтильШрифта стиль() // getter
	{
		return _fstyle;
	}
	
	
		final Ткст имя() // getter
	{
		return lfName;
	}
	
	
	final ббайт гарнитураГди() // getter
	{
		return lfCharSet;
	}
	
	
	/+
	private проц _initLf(LOGFONTA* шл)
	{
		this.lfHeight = шл.lfHeight;
		this.lfName = вТкст(шл.lfFaceName.ptr).dup;
		this.lfCharSet = шл.lfCharSet;
	}
	+/
	
	private проц _initLf(inout ШрифтЛога шл)
	{
		this.lfHeight = шл.шл.lfHeight;
		this.lfName = шл.имяФаса;
		this.lfCharSet = шл.шл.lfCharSet;
	}
	
	
	/+
	private проц _initLf(Шрифт otherfont, LOGFONTA* шл)
	{
		this.lfHeight = otherfont.lfHeight;
		this.lfName = otherfont.lfName;
		this.lfCharSet = otherfont.lfCharSet;
	}
	+/
	
	private проц _initLf(Шрифт otherfont, inout ШрифтЛога шл)
	{
		this.lfHeight = otherfont.lfHeight;
		this.lfName = otherfont.lfName;
		this.lfCharSet = otherfont.lfCharSet;
	}
	
	
	private:
	УШрифт hf;
	ЕдиницаГрафики _unit;
	бул owned = да;
	СтильШрифта _fstyle;
	
	цел lfHeight;
	Ткст lfName;
	ббайт lfCharSet;
}


// If the pen ширина is greater than 1 the стиль cannot have dashes or dots.
export class Перо // docmain
{
export:
	// Used internally.
	this(УПеро hp, бул owned = да)
	{
		this.hp = hp;
		this.owned = owned;
	}
	
	
		this(Цвет цвет, цел ширина = 1, ПСтильПера ps = ПСтильПера.Сплошной)
	{
		hp = CreatePen(ps, ширина, цвет.вКзс());
	}
	
	
	~this()
	{
		if(owned)
			DeleteObject(hp);
	}
	
	
		final УПеро указатель() // getter
	{
		return hp;
	}
	
	
	private:
	УПеро hp;
	бул owned = да;
}


export class Кисть // docmain
{
export:
	// Used internally.
	this(УКисть hb, бул owned = да)
	{
		this.hb = hb;
		this.owned = owned;
	}
	
	
	this()
	{
	}
	
	
	~this()
	{
		if(owned)
			DeleteObject(hb);
	}
	
	
		final УКисть указатель() // getter
	{
		return hb;
	}
	
	
	private:
	УКисть hb;
	бул owned = да;
}


export class ПлотнаяКисть: Кисть // docmain
{
export:
		this(Цвет ктрл)
	{
		super(CreateSolidBrush(ктрл.вКзс()));
	}
	
	
	/+
	final проц цвет(Цвет ктрл) // setter
	{
		// delete..
		super.hb = CreateSolidBrush(ктрл.вКзс());
	}
	+/
	
	
	final Цвет цвет() // getter
	{
		Цвет результат;
		LOGBRUSH lb;
		
		if(GetObjectA(hb, lb.sizeof, &lb))
		{
			результат = Цвет.изКзс(lb.lbColor);
		}
		
		return результат;
	}
}


// PatternBrush has the win9x/ME limitation of not supporting images larger than 8x8 pixels.
// TextureBrush supports any размер images but requires GDI+.


/+
class PatternBrush: Кисть
{
	//CreatePatternBrush() ...
}
+/


/+
class TextureBrush: Кисть
{
	// GDI+ ...
}
+/


export class HatchBrush: Кисть // docmain
{
export:
		this(HatchStyle hs, Цвет ктрл)
	{
		super(CreateHatchBrush(hs, ктрл.вКзс()));
	}
	
	
		final Цвет foregroundColor() // getter
	{
		Цвет результат;
		LOGBRUSH lb;
		
		if(GetObjectA(hb, lb.sizeof, &lb))
		{
			результат = Цвет.изКзс(lb.lbColor);
		}
		
		return результат;
	}
	
	
		final HatchStyle hatchStyle() // getter
	{
		HatchStyle результат;
		LOGBRUSH lb;
		
		if(GetObjectA(hb, lb.sizeof, &lb))
		{
			результат = cast(HatchStyle)lb.lbHatch;
		}
		
		return результат;
	}
}


export class Регион // docmain
{
export:
	// Used internally.
	this(HRGN hrgn, бул owned = да)
	{
		this.hrgn = hrgn;
		this.owned = owned;
	}
	
	
	~this()
	{
		if(owned)
			DeleteObject(hrgn);
	}
	
	
		final HRGN указатель() // getter
	{
		return hrgn;
	}
	
	
	override т_рав opEquals(Объект o)
	{
		Регион rgn = cast(Регион)o;
		if(!rgn)
			return 0; // Not equal.
		return opEquals(rgn);
	}
	
	
	т_рав opEquals(Регион rgn)
	{
		return hrgn == rgn.hrgn;
	}
	
	
	private:
	HRGN hrgn;
	бул owned = да;
}

