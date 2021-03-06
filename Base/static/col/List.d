﻿//============================================================================
// Список.d -  Linked список данные structure 
//
// Written in the D Programming Language (http://www.digitalmars.com/d)
/*****************************************************************************
 * A Linked Список данные structure.
 * 
 *  A doubly linked список данные structure based originally on the one in 
 *  ArcLib.  The interface имеется been modified to mimic the STL std.список
 *  type more closely, и a few new members have been added.
 *
 *  Author:  William V. Baxter III, OLM Digital, Inc.
 *  Дата: 04 Sep 2007
 *  License:       zlib/libpng
 */
//============================================================================
module col.List;


class неверный_обходчик : Искл
{
    this(ткст сооб) { super(сооб); }
}


/// Обходчик type for Список
struct ОбходСписка(T, бул резерв_ли = нет) {
    alias T тип_значения;
    alias T* указатель;
    alias Список!(T).Узел тип_узла;
    alias Список!(T).Узел* указатель_на_узел;

    private static ОбходСписка opCall(указатель_на_узел иниц) {
        ОбходСписка M; with(M) {
            укз_ = иниц;
        } return M;
    }

    /// Return the value referred to by the обходчик
    T знач() { assert(укз_ !is пусто); return укз_.данные; }

    /// Return a указатель to the value referred to by the обходчик
    T* укз() { assert(укз_ !is пусто); return &укз_.данные; }
    
    цел opEquals(ref ОбходСписка other) {
        return укз_ is other.укз_;
    }

    /// обход++
    проц opPostInc() {
        _аванс(); 
    }
    /// ++обход
    проц opAddAssign(цел i) {
        assert(i==1, "неверная операция");
        _аванс(); 
    }
    /// обход--
    проц opPostDec() {
        _отход(); 
    }
    /// --обход
    проц opSubAssign(цел i) {
        assert(i==1, "неверная операция");
        _отход(); 
    }
private:
    проц _аванс() {
        assert(укз_ !is пусто);
        static if(резерв_ли) {
            укз_=укз_.предш;
        } else {
            укз_=укз_.следщ;
        }
    }
    проц _отход() {
        assert(укз_ !is пусто);
        static if(резерв_ли) {
            укз_=укз_.следщ;
        }
        else {
            укз_=укз_.предш;
        }
    }
private:
    указатель_на_узел укз_  = пусто;
}

ОбходСписка!(T) обход_списка_начало(T)(T[] x) {
    return x.начало();
}
ОбходСписка!(T) обход_списка_конец(T)(T[] x) {
    return x.конец();
}
ОбходСписка!(T,да) обход_списка_начало_рев(T)(T[] x) {
    return ОбходСписка!(T).начало(x);
}
ОбходСписка!(T,да) обход_списка_конец_рев(T)(T[] x) {
    return ОбходСписка!(T).конец(x);
}

template обходчик_списка(T) {
    alias ОбходСписка!(T,нет) обходчик_списка;
}

template обходчик_списка_рев(T) {
    alias ОбходСписка!(T,да) обходчик_списка_рев;
}


/**  Linked-список данные structure
 *
 *   Uses a doubly-linked список structure internally.
 */
struct Список(T)
{
public:
    alias T тип_значения;
    alias T* указатель;
    alias Узел тип_узла;
    alias Узел* указатель_на_узел;
    alias обходчик_списка!(T) обходчик;
    alias обходчик_списка_рев!(T) реверсОбходчик;

public:

    /// приставь an элт to the список
    обходчик приставь(ref T новДанные)
    {
        return вставь_узел_перед(&якорь_, новДанные);
    }

    /// Also приставь an элт to the список using L ~= элт syntax.
    проц opCatAssign(/*const*/ ref T новДанные) { приставь(новДанные); }

    /// предпоставь an элт onto the голова of список
    обходчик предпоставь(ref T новДанные)
    {
        if (пуст() && голова is пусто) {
            // Really we'd like all списки to be initialized this way,
            // but without forcing the use of a static opCall constructor
            // it's not currently possible.
            якорь_.следщ = &якорь_;
            якорь_.предш = &якорь_;
        }
        return вставь_узел_перед(голова, новДанные);
    }


    /// Insert an элемент перед обход
    обходчик вставь(обходчик обход, ref T новДанные)
    {
        return вставь_узел_перед(обход.укз_, новДанные);
    }

    // Does all insertions
    private обходчик вставь_узел_перед(Узел* перед, ref T новДанные)
    {
        Узел* элт = new Узел;
        элт.данные = новДанные;
      
        if (пуст()) // первый элт in список
        {
            assert (перед is &якорь_);
            элт.следщ = &якорь_;
            элт.предш = &якорь_;
            якорь_.следщ = элт;
            якорь_.предш = элт;
        } 

        else // add перед 'перед'
        {
            Узел* предш = перед.предш;
            assert(предш !is пусто);

            элт.предш   = предш;
            элт.следщ   = перед;
            предш.следщ   = элт;
            перед.предш = элт;
        }

        размерСписка_++;

        return ОбходСписка!(T)(элт);
    }

    /// remove узел pointed to by обход from the список
    /// returns the обходчик to the узел following the removed узел.
    обходчик удали(обходчик обход)
    {
        Узел* curr = обход.укз_;
        бул bad_iter = (curr is пусто) || (curr is &якорь_);
        if (bad_iter) {
            throw new неверный_обходчик("Список.удали: неверный обходчик");
        }
        debug {
            // make sure this узел is actually in our список??
        }
        обходчик next_iter = обход; ++next_iter;

        curr.следщ.предш = curr.предш;
        curr.предш.следщ = curr.следщ;
      
        delete curr;
      
        размерСписка_--;

        return next_iter;
    }


    /// Returns the длина of the список
    цел длина() { return размерСписка_; }

    /// Returns the размер of the список, same as длина()
    цел размер() { return размерСписка_; }
   
    /// Simple function to tell if список is пуст or not
    бул пуст() 
    {
        return (размерСписка_ == 0);
    }

    /// Clear all данные from the список
    проц очисть()
    {
        auto it = начало();
        auto конец = конец();

        for (; it != конец; ++it)
            удали(it);
    }

	/// 'элт in список' implementation.  O(N) performance.
	бул opIn_r(T данные)
	{
		foreach(T d; *this)
			if (d == данные)
				return да; 
				
		return нет; 
	}

	/// Find элт список, return an обходчик.  O(N) performance.
    /// If not found returns this.конец()
	обходчик найди(T данные)
	{
        обходчик it = начало(), _конец=конец();
        
        for(; it!=_конец; ++it) {
			if (*it.укз == данные)
				return it; 
		}		
		return it; 
    }

	// foreach обходчик forwards 
	цел opApply(цел delegate(ref T) dg)
	{
		Узел* curr=голова;
        if (curr is пусто) return 0; // special case for unitialized список
		while (curr !is &якорь_)
		{
            Узел* следщ = curr.следщ;
			цел result = dg(curr.данные);
			if(result) return result;
            curr = следщ;
		}
		return 0; 
	}

	// foreach обходчик backwards 
	цел opApplyReverse(цел delegate(ref T) dg)
	{
		Узел* curr = хвост;
        if (curr is пусто) return 0; // special case for unitialized список
		while (curr !is &якорь_)
		{
            Узел* предш = curr.предш;
			цел result = dg(curr.данные);
			if(result) return result;
            curr = предш;
		}
		return 0; 
	}
	

    /*******************************************************************************
   
      Returns the текущ данные from the список
   
    *******************************************************************************/

    обходчик начало() {
        return ОбходСписка!(T)(голова);
    }
    обходчик конец() {
        return ОбходСписка!(T)(&якорь_);
    }
    реверсОбходчик начало_рев() {
        return ОбходСписка!(T,да)(хвост);
    }
    реверсОбходчик конец_рев() {
        return ОбходСписка!(T,да)(&якорь_);
    }

	/// return the первый элемент in the список
    T первый()
    {
        assert(!пуст(), "первый: список пуст!"); 
        return голова.данные;
    }

	/// return the последний элемент in the список 
    T последний()
    {
        assert(!пуст(), "последний: список пуст!"); 
        return хвост.данные;
    }

/+
	// http://www.chiark.greenend.org.uk/~sgtatham/algorithms/спискиort.html
	/// perform merge sort on this linked список 
	проц sort()
	{
		Узел* p;
		Узел* q;
		Узел* e;
		Узел* oldhead;
		
		цел insize, nmerges, psize, qsize, i;

		/*
		 * Silly special case: if `список' was passed in as пусто, return
		 * пусто immediately.
		 */
		if (голова is пусто)
			return;

		insize = 1;

		while (1) 
		{
			p = голова;
			oldhead = голова;		       /* only использован for circular linkage */
			голова = пусто;
			хвост = пусто;

			nmerges = 0;  /* count number of merges we do in this pass */

			while (p !is пусто) 
			{
				nmerges++;  /* there exists a merge to be done */
				/* step `insize' places along from p */
				q = p;
				psize = 0;
				
				for (i = 0; i < insize; i++) 
				{
					psize++;

					q = q.следщ;

					if (q is пусто) break;
				}

				/* if q hasn't fallen off конец, we have two списки to merge */
				qsize = insize;

				/* now we have two списки; merge them */
				while (psize > 0 || (qsize > 0 && q !is пусто)) 
				{

					/* decide whether следщ элемент of merge comes from p or q */
					if (psize == 0) 
					{
						/* p is пуст; e must come from q. */
						e = q; q = q.следщ; qsize--;
					} else if (qsize == 0 || q is пусто) 
					{
						/* q is пуст; e must come from p. */
						e = p; p = p.следщ; psize--;
					} else if (p <= q) {
						/* First элемент of p is lower (or same);
						 * e must come from p. */
						e = p; p = p.следщ; psize--;
					} else {
						/* First элемент of q is lower; e must come from q. */
						e = q; q = q.следщ; qsize--;
					}

                    /* add the следщ элемент to the merged список */
					if (хвост !is пусто) 
					{
						хвост.следщ = e;
					} 
					else 
					{
						голова = e;
					}
                    e.предш = хвост;

					хвост = e;
				}

				/* now p имеется stepped `insize' places along, и q имеется too */
				p = q;
			}
		
			хвост.следщ = пусто;

			/* If we have done only one merge, we're finished. */
			if (nmerges <= 1)   /* allow for nmerges==0, the пуст список case */
				return;

			/* Otherwise повтори, merging списки twice the размер */
			insize *= 2;
		}
	}
+/

protected:
    Узел* голова() { return якорь_.следщ; }
    Узел* хвост() { return якорь_.предш; }
    проц голова(Узел* h) { якорь_.следщ = h; }
    проц хвост(Узел* t) { якорь_.предш = t; }

private:

    // Note there's always an "якорь" узел, и узелs are stored in circular manner.
    // This makes it work well with STL стиль iterators that need a distinct начало и
    // конец узелs for вперёд и reverse iteration.
    // Unfortunately it wastes T.sizeof байты on useless payload данные.
    // We could make Узел a class и then use inheritance to create AnchorNode и PayloadNode
    // subclasses, but then we have overhead of N*reference.sizeof (i.e. O(N) overhead).
    Узел якорь_;

    // Keep track of размер so that 'длина' проверьs are O(1) 
    цел размерСписка_ = 0;

    /// The internal узел structure with предш/следщ pointers и the user данные payload
    struct Узел
    {
        T данные;
        Узел* предш = пусто;
        Узел* следщ = пусто;
    }
}

version(Unittest) {
    import stdrus;
}
unittest {
    version(Unittest){
    скажинс("----список tests----");

    бул проверь_равно(ref список!(цел) l, ткст знач)
    {
        ткст o;
        foreach(i; l) {
            o ~= фм(i);
        }
        return знач==o;
    }


    Список!(цел) ilist;
    assert(ilist.пуст());

    ilist ~= 1;
    assert(! ilist.пуст());
    ilist.приставь(2);
    ilist ~= 3;
    ilist.приставь(4);
    ilist ~= 5;

    assert(! ilist.пуст());

    ткст o;
    foreach(i; ilist) {
        o ~= фм(i);
    }
    assert(o == "12345");
    o = пусто;
    foreach_reverse(i; ilist) {
        o ~= фм(i);
    }
    assert(o == "54321");

    // Обходчик tests //

    {
        o=пусто;
        auto it=ilist.начало(),конец=ilist.конец();
        for(; it != конец; ++it) {
            o ~= фм(it.знач);
        }
        assert(o == "12345");
    }
    {
        o = пусто;
        auto it=ilist.начало_рев(),конец=ilist.конец_рев();
        for(; it != конец; ++it) {
            o ~= фм(it.знач);
        }
        assert(o == "54321");
    }    

    // opIn_r tests //

    for (цел i=1; i<=5; i++) {
        assert(i in ilist);
    }
    assert(!(99 in ilist));
    assert(!(0 in ilist));

    assert(ilist.последний == 5);
    assert(ilist.первый == 1);

    // Find test //
    {
        auto it = ilist.найди(99);
        assert(it==ilist.конец());
        for (цел i=1; i<=5; i++) {
            it = ilist.найди(i);
            assert(it!=ilist.конец());
            assert(it.знач == i);
            assert(*it.укз == i);
        }
    }
    // вставь tests //
    {
        auto it = ilist.найди(3);
        ilist.вставь(it, 9);
        assert( проверь_равно(ilist, "129345") );
        ilist.вставь(ilist.начало(), 8);
        assert( проверь_равно(ilist, "8129345") );
        ilist.вставь(ilist.конец(), 7);
        assert( проверь_равно(ilist, "81293457") );
    }

    // удали tests //
    {
        auto it = ilist.найди(3);
        ilist.удали(it);
        assert( проверь_равно(ilist, "8129457") );
        ilist.удали(ilist.начало);
        assert( проверь_равно(ilist, "129457") );
        auto последний = ilist.конец; последний--;
        ilist.удали(последний);
        assert( проверь_равно(ilist, "12945") );
        
        ilist.удали(ilist.начало);
        assert( проверь_равно(ilist, "2945") );
        ilist.удали(ilist.начало);
        assert( проверь_равно(ilist, "945") );
        ilist.удали(ilist.начало);
        assert( проверь_равно(ilist, "45") );
        ilist.удали(ilist.начало);
        assert( проверь_равно(ilist, "5") );
        ilist.удали(ilist.начало);
        assert( проверь_равно(ilist, "") );

        assert(ilist.найди(1) == ilist.конец());
        
        // Try inserting into a previously non-пуст список
        assert(ilist.пуст());
        ilist ~= 9;
        assert(!ilist.пуст());
        assert( проверь_равно(ilist, "9") );
        assert( ilist.найди(9).знач == 9 );

        *ilist.найди(9).укз = 8;
        assert( ilist.найди(8).знач == 8 );
        assert(ilist.длина == 1);
    }

    скажинс("----список tests complete ----");
    }
    else {
        assert(нет, "список.d module unittest требует -version=Unittest");
    }
}