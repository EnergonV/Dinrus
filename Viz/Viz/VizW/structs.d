﻿module viz.structs;
import winapi, sys.DStructs, viz.control;

alias typeof(""ктрл[]) Ткст;
alias typeof(""ктрл.ptr) Ткст0;
alias typeof(" "ктрл[0]) Сим;
alias typeof(""w[]) Шткст;
alias typeof(""w.ptr) Шткст0;
alias typeof(" "w[0]) Шим;
alias typeof(""d[]) Дткст;
alias typeof(""d.ptr) Дткст0;
alias typeof(" "d[0]) Дим;

struct ШрифтЛога
{
	union
	{
		LOGFONTW шлш;
		LOGFONTA шла;
	}
	alias шлш шл;
	
	Ткст имяФаса;
}

struct КлассОкна
{
	union
	{
		WNDCLASSW кош;
		WNDCLASSA коа;
	}
	alias кош ко;
	
	Ткст имяКласса;
}

struct ДанныеВызова
{
	Объект delegate(Объект[]) дг;
	Объект[] арги;
	Объект результат;
	Объект исключение = пусто;
}

struct ПарамВызоваВиз
{
	проц function(УпрЭлт, т_мера[]) fp;
	т_мера nparams;
	т_мера[1] params;
}

struct ПростыеДанныеВызова
{
	проц delegate() дг;
	Объект исключение = пусто;
}

struct Сообщение
{
	union
	{
		struct
		{
			УОК уок; 
			бцел сооб; 
			бцел парам1; 
			цел парам2; 
		}
		
		package СООБ _винСооб;
	}
	цел результат; 	
	
	static Сообщение opCall(УОК уок, бцел сооб, бцел парам1, цел парам2)
	{
		Сообщение m;
		m.уок = уок;
		m.сооб = сооб;
		m.парам1 = парам1;
		m.парам2 = парам2;
		m.результат = 0;
		return m;
	}
}
/// X and Y coordinate.
struct Точка 
{

	union
	{
		struct
		{
			цел ш;
			цел в;
		}
		ТОЧКА точка; 
	}
		
	/// Construct а new Точка.
	static Точка opCall(цел ш, цел в)
	{
		Точка тчк;
		тчк.ш = ш;
		тчк.в = в;
		return тчк;
	}
		
	static Точка opCall()
	{
		Точка тчк;
		return тчк;
	}
		
	т_рав opEquals(Точка тчк)
	{
		return ш == тчк.ш && в == тчк.в;
	}
	
	
	Точка opAdd(Размер разм)
	{
		Точка результат;
		результат.ш = ш + разм.ширина;
		результат.в = в + разм.высота;
		return результат;
	}
		
	Точка opSub(Размер разм)
	{
		Точка результат;
		результат.ш = ш - разм.ширина;
		результат.в = в - разм.высота;
		return результат;
	}
		
	проц opAddAssign(Размер разм)
	{
		ш += разм.ширина;
		в += разм.высота;
	}
		
	проц opSubAssign(Размер разм)
	{
		ш -= разм.ширина;
		в -= разм.высота;
	}
		
	Точка opNeg()
	{
		return Точка(-ш, -в);
	}
}

/// ширина и высота.
struct Размер 
{
	union
	{
		struct
		{
			цел ширина;
			цел высота;
		}
		РАЗМЕР размер;
	}
	
	/// Construct а new Размер.
	static Размер opCall(цел ширина, цел высота)
	{
		Размер разм;
		разм.ширина = ширина;
		разм.высота = высота;
		return разм;
	}
	
	static Размер opCall()
	{
		Размер разм;
		return разм;
	}
		
	т_рав opEquals(Размер разм)
	{
		return ширина == разм.ширина && высота == разм.высота;
	}
	
	
		Размер opAdd(Размер разм)
	{
		Размер результат;
		результат.ширина = ширина + разм.ширина;
		результат.высота = высота + разм.высота;
		return результат;
	}
	
	
		Размер opSub(Размер разм)
	{
		Размер результат;
		результат.ширина = ширина - разм.ширина;
		результат.высота = высота - разм.высота;
		return результат;
	}
	
	
		проц opAddAssign(Размер разм)
	{
		ширина += разм.ширина;
		высота += разм.высота;
	}
	
	
		проц opSubAssign(Размер разм)
	{
		ширина -= разм.ширина;
		высота -= разм.высота;
	}
}


/// X, Y, ширина and высота rectangle dimensions.
struct Прям // docmain
{
	цел ш, в, ширина, высота;
	
	// Used internally.
	проц дайПрям(ПРЯМ* к) // package
	{
		к.лево = ш;
		к.право = ш + ширина;
		к.верх = в;
		к.низ = в + высота;
	}
		
	Точка положение() // getter
	{
		return Точка(ш, в);
	}
		
	проц положение(Точка тчк) // setter
	{
		ш = тчк.ш;
		в = тчк.в;
	}
		
	Размер размер() //getter
	{
		return Размер(ширина, высота);
	}
		
	проц размер(Размер разм) // setter
	{
		ширина = разм.ширина;
		высота = разм.высота;
	}
		
	цел право() // getter
	{
		return ш + ширина;
	}
		
		цел низ() // getter
	{
		return в + высота;
	}
		
	/// Construct а new Прям.
	static Прям opCall(цел ш, цел в, цел ширина, цел высота)
	{
		Прям к;
		к.ш = ш;
		к.в = в;
		к.ширина = ширина;
		к.высота = высота;
		return к;
	}
		
	static Прям opCall(Точка положение, Размер размер)
	{
		Прям к;
		к.ш = положение.ш;
		к.в = положение.в;
		к.ширина = размер.ширина;
		к.высота = размер.высота;
		return к;
	}
		
	static Прям opCall()
	{
		Прям к;
		return к;
	}
		
	// Used internally.
	static Прям opCall(ПРЯМ* прям) // package
	{
		Прям к;
		к.ш = прям.лево;
		к.в = прям.верх;
		к.ширина = прям.право - прям.лево;
		к.высота = прям.низ - прям.верх;
		return к;
	}
	
	
	/// Construct а new Прям from лево, верх, право and верх values.
	static Прям изЛВПН(цел лево, цел верх, цел право, цел низ)
	{
		Прям к;
		к.ш = лево;
		к.в = верх;
		к.ширина = право - лево;
		к.высота = низ - верх;
		return к;
	}
		
	т_рав opEquals(Прям к)
	{
		return ш == к.ш && в == к.в &&
			ширина == к.ширина && высота == к.высота;
	}
		
	бул содержит(цел c_x, цел c_y)
	{
		if(c_x >= ш && c_y >= в)
		{
			if(c_x <= право && c_y <= низ)
				return да;
		}
		return нет;
	}
		
	бул содержит(Точка поз)
	{
		return содержит(поз.ш, поз.в);
	}
	
	
	// Contained entirely within -this-.
	бул содержит(Прям к)
	{
		if(к.ш >= ш && к.в >= в)
		{
			if(к.право <= право && к.низ <= низ)
				return да;
		}
		return нет;
	}
	
	проц инфлируй(цел i_width, цел i_height)
	{
		ш -= i_width;
		ширина += i_width * 2;
		в -= i_height;
		высота += i_height * 2;
	}
	
	проц инфлируй(Размер insz)
	{
		инфлируй(insz.ширина, insz.высота);
	}
	
		// Just tests if there's an intersection.
	бул пересекаетсяС(Прям к)
	{
		if(к.право >= ш && к.низ >= в)
		{
			if(к.в <= низ && к.ш <= право)
				return да;
		}
		return нет;
	}
		
	проц смещение(цел ш, цел в)
	{
		this.ш += ш;
		this.в += в;
	}
		
	проц смещение(Точка тчк)
	{
		//return смещение(тчк.ш, тчк.в);
		this.ш += тчк.ш;
		this.в += тчк.в;
	}
	
	
	/+
	// Modify -this- to include only the intersection
	// of -this- and -к-.
	проц intersect(Прям к)
	{
	}
	+/
	
	
	// проц смещение(Точка), проц смещение(цел, цел)
	// static Прям union(Прям, Прям)
}


unittest
{
	Прям к = Прям(3, 3, 3, 3);
	
	assert(к.содержит(3, 3));
	assert(!к.содержит(3, 2));
	assert(к.содержит(6, 6));
	assert(!к.содержит(6, 7));
	assert(к.содержит(к));
	assert(к.содержит(Прям(4, 4, 2, 2)));
	assert(!к.содержит(Прям(2, 4, 4, 2)));
	assert(!к.содержит(Прям(4, 3, 2, 4)));
	
	к.инфлируй(2, 1);
	assert(к.ш == 1);
	assert(к.право == 8);
	assert(к.в == 2);
	assert(к.низ == 7);
	к.инфлируй(-2, -1);
	assert(к == Прям(3, 3, 3, 3));
	
	assert(к.пересекаетсяС(Прям(4, 4, 2, 9)));
	assert(к.пересекаетсяС(Прям(3, 3, 1, 1)));
	assert(к.пересекаетсяС(Прям(0, 3, 3, 0)));
	assert(к.пересекаетсяС(Прям(3, 2, 0, 1)));
	assert(!к.пересекаетсяС(Прям(3, 1, 0, 1)));
	assert(к.пересекаетсяС(Прям(5, 6, 1, 1)));
	assert(!к.пересекаетсяС(Прям(7, 6, 1, 1)));
	assert(!к.пересекаетсяС(Прям(6, 7, 1, 1)));
}

/// Цвет значение representation
struct Цвет // docmain
{
	/// Red, зелёный, синий and альфа channel цвет values.
	ббайт к() // getter
	{ оцениЦвет(); return цвет.красный; }
		
	ббайт з() // getter
	{ оцениЦвет(); return цвет.зелёный; }
		
	ббайт с() // getter
	{ оцениЦвет(); return цвет.синий; }
		
	ббайт а() // getter
	{ /+ оцениЦвет(); +/ return цвет.альфа; }
		
	/// Return the numeric цвет значение.
	ЦВПредст вАкзс()
	{
		оцениЦвет();
		return цвет.цпредст;
	}
		
	/// Return the numeric красный, зелёный and синий цвет значение.
	ЦВПредст вКзс()
	{
		оцениЦвет();
		return цвет.цпредст & 0x00FFFFFF;
	}
		
	// Used internally.
	УКисть создайКисть() // package
	{
		УКисть hbr;
		if(_systemColorIndex == Цвет.ИНДЕКС_НЕВЕРНОГО_СИСТЕМНОГО_ЦВЕТА)
			hbr = CreateSolidBrush(вКзс());
		else
			hbr = GetSysColorBrush(_systemColorIndex);
		return hbr;
	}	
	
	deprecated static Цвет opCall(ЦВПредст argb)
	{
		Цвет nc;
		nc.цвет.цпредст = argb;
		return nc;
	}	
	
	/// Construct а new цвет.
	static Цвет opCall(ббайт альфа, Цвет ктрл)
	{
		Цвет nc;
		nc.цвет.синий = ктрл.цвет.синий;
		nc.цвет.зелёный = ктрл.цвет.зелёный;
		nc.цвет.красный = ктрл.цвет.красный;
		nc.цвет.альфа = альфа;
		return nc;
	}
		
	static Цвет opCall(ббайт красный, ббайт зелёный, ббайт синий)
	{
		Цвет nc;
		nc.цвет.синий = синий;
		nc.цвет.зелёный = зелёный;
		nc.цвет.красный = красный;
		nc.цвет.альфа = 0xFF;
		return nc;
	}	
	
	static Цвет opCall(ббайт альфа, ббайт красный, ббайт зелёный, ббайт синий)
	{
		return изАкзс(альфа, красный, зелёный, синий);
	}	
	
	//alias opCall изАкзс;
	static Цвет изАкзс(ббайт альфа, ббайт красный, ббайт зелёный, ббайт синий)
	{
		Цвет nc;
		nc.цвет.синий = синий;
		nc.цвет.зелёный = зелёный;
		nc.цвет.красный = красный;
		nc.цвет.альфа = альфа;
		return nc;
	}	
	
	static Цвет изКзс(ЦВПредст кзс)
	{
		if(CLR_NONE == кзс)
			return пуст;
		Цвет nc;
		nc.цвет.цпредст = кзс;
		nc.цвет.альфа = 0xFF;
		return nc;
	}	
	
	static Цвет изКзс(ббайт альфа, ЦВПредст кзс)
	{
		Цвет nc;
		nc.цвет.цпредст = кзс | ((cast(ЦВПредст)альфа) << 24);
		return nc;
	}	
	
	static Цвет пуст() // getter
	{
		return Цвет(0, 0, 0, 0);
	}	
	
	/// Return а completely прозрачный цвет значение.
	static Цвет прозрачный() // getter
	{
		return Цвет.изАкзс(0, 0xFF, 0xFF, 0xFF);
	}	
		
	/// Blend colors; альфа channels are ignored.
	// Blends the цвет channels half way.
	// Does not consider альфа channels and discards them.
	// The new blended цвет is returned; -this- Цвет is not изменён.
	Цвет смешайСЦветом(Цвет ко)
	{
		if(*this == Цвет.пуст)
			return ко;
		if(ко == Цвет.пуст)
			return *this;
		
		оцениЦвет();
		ко.оцениЦвет();
		
		return Цвет((cast(бцел)цвет.красный + cast(бцел)ко.цвет.красный) >> 1,
			(cast(бцел)цвет.зелёный + cast(бцел)ко.цвет.зелёный) >> 1,
			(cast(бцел)цвет.синий + cast(бцел)ко.цвет.синий) >> 1);
	}	
	
	/// Alpha blend this цвет with а background цвет to return а solid цвет (100% opaque).
	// Blends with цветФона if this цвет has непрозрачность to produce а solid цвет.
	// Returns the new solid цвет, or the original цвет if нет непрозрачность.
	// If цветФона has непрозрачность, it is ignored.
	// The new blended цвет is returned; -this- Цвет is not изменён.
	Цвет плотныйЦвет(Цвет цветФона)
	{
		//if(0x7F == this.цвет.альфа)
		//	return смешайСЦветом(цветФона);
		//if(*this == Цвет.пуст) // Checked if(0 == this.цвет.альфа)
		//	return цветФона;
		if(0 == this.цвет.альфа)
			return цветФона;
		if(цветФона == Цвет.пуст)
			return *this;
		if(0xFF == this.цвет.альфа)
			return *this;
		
		оцениЦвет();
		цветФона.оцениЦвет();
		
		float fa, ba;
		fa = cast(float)цвет.альфа / 255.0;
		ba = 1.0 - fa;
		
		Цвет результат;
		результат.цвет.альфа = 0xFF;
		результат.цвет.красный = cast(ббайт)(this.цвет.красный * fa + цветФона.цвет.красный * ba);
		результат.цвет.зелёный = cast(ббайт)(this.цвет.зелёный * fa + цветФона.цвет.зелёный * ba);
		результат.цвет.синий = cast(ббайт)(this.цвет.синий * fa + цветФона.цвет.синий * ba);
		return результат;
	}
	
	package static Цвет системныйЦвет(цел индексЦвета)
	{
		Цвет ктрл;
		ктрл.sysIndex = индексЦвета;
		ктрл.цвет.альфа = 0xFF;
		return ктрл;
	}	
	
	// Gets цвет индекс or ИНДЕКС_НЕВЕРНОГО_СИСТЕМНОГО_ЦВЕТА.
	package цел _systemColorIndex() // getter
	{
		return sysIndex;
	}	
	
	package const ббайт ИНДЕКС_НЕВЕРНОГО_СИСТЕМНОГО_ЦВЕТА = ббайт.max;
		
	private:
	union _цвет
	{
		struct
		{
			align(1):
			ббайт красный;
			ббайт зелёный;
			ббайт синий;
			ббайт альфа;
		}
		ЦВПредст цпредст;
	}
	static assert(_цвет.sizeof == бцел.sizeof);
	_цвет цвет;
	
	ббайт sysIndex = ИНДЕКС_НЕВЕРНОГО_СИСТЕМНОГО_ЦВЕТА;
		
	проц оцениЦвет()
	{
		if(sysIndex != ИНДЕКС_НЕВЕРНОГО_СИСТЕМНОГО_ЦВЕТА)
		{
			цвет.цпредст = GetSysColor(sysIndex);
			//цвет.альфа = 0xFF; // Should already be установи.
		}
	}
}

/// УпрЭлт creation parameters.
struct ПарамыСозд
{
	Ткст имяКласса; 
	Ткст заглавие; 
	ук парам; 
	УОК родитель; 
	HMENU меню; 
	экз экземп; 
	цел ш; 
	цел в; 
	цел ширина; 
	цел высота; 
	DWORD стильКласса; 
	DWORD допСтиль; 
	DWORD стиль; 
}