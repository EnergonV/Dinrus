﻿/*********************************************************
   Copyright: (C) 2008 by Steven Schveighoffer.
              All rights reserved

   License: $(LICENSE)

**********************************************************/
module col.Link;

private import col.DefaultAllocator;

/**
 * Linked-list узел that is используется in various collection classes.
 */
struct Связка(V)
{
    /**
     * convenience alias
     */
    alias Связка *Узел;
    Узел следщ;
    Узел предш;

    /**
     * the значение that is represented by this link Узел.
     */
    V значение;

    /**
     * вставь the given узел between this узел и предш.  This updates all
     * pointers in this, n, и предш.
     *
     * returns this to allow for chaining.
     */
    Узел приставь(Узел n)
    {
        крепи(предш, n);
        крепи(n, this);
        return this;
    }

    /**
     * вставь the given Узел between this Узел и следщ.  This updates all
     * pointers in this, n, и следщ.
     *
     * returns this to allow for chaining.
     */
    Узел поставь(Узел n)
    {
        крепи(n, следщ);
        крепи(this, n);
        return this;
    }

    /**
     * удали this Узел from the list.  If предш or следщ is non-пусто, their
     * pointers are updated.
     *
     * returns this to allow for chaining.
     */
    Узел открепи()
    {
        крепи(предш, следщ);
        следщ = предш = пусто;
        return this;
    }

    /**
     * link two узелs together.
     */
    static проц крепи(Узел первый, Узел второй)
    {
        if(первый)
            первый.следщ = второй;
        if(второй)
            второй.предш = первый;
    }

    /**
     * счёт how many узелs until концУзел.
     */
    бцел счёт(Узел концУзел = пусто)
    {
        Узел x = this;
        бцел c = 0;
        while(x !is концУзел)
        {
            x = x.следщ;
            c++;
        }
        return c;
    }

    Узел dup(Узел delegate(V v) функцияСоздать)
    {
        //
        // create a дубликат of this и all узелs after this.
        //
        auto n = следщ;
        auto возврзнач = функцияСоздать(значение);
        auto тек = возврзнач;
        while(n !is пусто && n !is this)
        {
            auto x = функцияСоздать(n.значение);
            крепи(тек, x);
            тек = x;
            n = n.следщ;
        }
        if(n is this)
        {
            //
            // circular list, complete the circle
            //
            крепи(тек, возврзнач);
        }
        return возврзнач;
    }

    Узел dup()
    {
        Узел _создай(V v)
        {
            auto n = new Связка!(V);
            n.значение = v;
            return n;
        }
        return dup(&_создай);
    }
}

/**
 * This struct uses a Связка(V) to keep track of a link-list of значения.
 *
 * The implementation uses a dummy link узел to be the голова и хвост of the
 * list.  Basically, the list is circular, with the dummy узел marking the
 * конец/beginning.
 */
struct ГоловаСвязки(V, alias Разместитель=ДефолтныйРазместитель)
{
    /**
     * Convenience alias
     */
    alias Связка!(V).Узел Узел;

    /**
     * Convenience alias
     */
    alias Разместитель!(Связка!(V)) разместитель;

    /**
     * The разместитель for this link голова
     */
    разместитель разм;

    /**
     * The узел that denotes the конец of the list
     */
    Узел конец; // not a действителен узел

    /**
     * The number of узелs in the list
     */
    бцел счёт;

    /**
     * Get the первый действителен узел in the list
     */
    Узел начало()
    {
        return конец.следщ;
    }

    /**
     * Initialize the list
     */
    проц установка()
    {
        //конец = new Узел;
        конец = размести();
        Узел.крепи(конец, конец);
        счёт = 0;
    }

    /**
     * Remove a узел from the list, returning the следщ узел in the list, or
     * конец if the узел was the последн one in the list. O(1) operation.
     */
    Узел удали(Узел n)
    {
        счёт--;
        Узел возврзнач = n.следщ;
        n.открепи;
        static if(разместитель.нужноСвоб)
            разм.освободи(n);
        return возврзнач;
    }

    /**
     * сортируй the list according to the given сравни function
     */
    проц сортируй(Сравниватель)(Сравниватель comp)
    {
        if(конец.следщ.следщ is конец)
            //
            // no узелs to сортируй
            //
            return;

        //
        // detach the sentinel
        //
        конец.предш.следщ = пусто;

        //
        // use merge сортируй, don't update предш pointers until the сортируй is
        // finished.
        //
        цел K = 1;
        while(K < счёт)
        {
            //
            // конец.следщ serves as the sorted list голова
            //
            Узел голова = конец.следщ;
            конец.следщ = пусто;
            Узел сортированныйхвост = конец;
            цел врмсчёт = счёт;

            while(голова !is пусто)
            {

                if(врмсчёт <= K)
                {
                    //
                    // the rest is alread sorted
                    //
                    сортированныйхвост.следщ = голова;
                    break;
                }
                Узел лево = голова;
                for(цел k = 1; k < K && голова.следщ !is пусто; k++)
                    голова = голова.следщ;
                Узел право = голова.следщ;

                //
                // голова now points to the последн элемент in 'лево', detach the
                // лево side
                //
                голова.следщ = пусто;
                цел члоправ = K;
                while(true)
                {
                    if(лево is пусто)
                    {
                        сортированныйхвост.следщ = право;
                        while(члоправ != 0 && сортированныйхвост.следщ !is пусто)
                        {
                            сортированныйхвост = сортированныйхвост.следщ;
                            члоправ--;
                        }
                        голова = сортированныйхвост.следщ;
                        сортированныйхвост.следщ = пусто;
                        break;
                    }
                    else if(право is пусто || члоправ == 0)
                    {
                        сортированныйхвост.следщ = лево;
                        сортированныйхвост = голова;
                        голова = право;
                        сортированныйхвост.следщ = пусто;
                        break;
                    }
                    else
                    {
                        цел r = comp(лево.значение, право.значение);
                        if(r > 0)
                        {
                            сортированныйхвост.следщ = право;
                            право = право.следщ;
                            члоправ--;
                        }
                        else
                        {
                            сортированныйхвост.следщ = лево;
                            лево = лево.следщ;
                        }
                        сортированныйхвост = сортированныйхвост.следщ;
                    }
                }

                врмсчёт -= 2 * K;
            }

            K *= 2;
        }

        //
        // now, крепи all the предш узелs
        //
        Узел n;
        for(n = конец; n.следщ !is пусто; n = n.следщ)
            n.следщ.предш = n;
        Узел.крепи(n, конец);
    }

    /**
     * Remove all the узелs from первый to последн.  This is an O(n) operation.
     */
    Узел удали(Узел первый, Узел последн)
    {
        Узел.крепи(первый.предш, последн);
        auto n = первый;
        while(n !is последн)
        {
            auto nx = n.следщ;
            static if(разм.нужноСвоб)
                разм.освободи(n);
            счёт--;
            n = nx;
        }
        return последн;
    }

    /**
     * Insert the given значение перед the given Узел.  Use вставь(конец, v) to
     * добавь to the конец of the list, or to an empty list. O(1) operation.
     */
    Узел вставь(Узел перед, V v)
    {
        счёт++;
        //return перед.приставь(new Узел(v)).предш;
        return перед.приставь(размести(v)).предш;
    }

    /**
     * Remove all узелs from the list
     */
    проц очисти()
    {
        Узел.крепи(конец, конец);
        счёт = 0;
    }

    /**
     * Copy this list to the цель.
     */
    проц копируйВ(ref ГоловаСвязки цель, бул копироватьУзлы=true)
    {
        цель = *this;
        //
        // reset the разместитель
        //
        цель.разм = цель.разм.init;

        if(копироватьУзлы)
        {
            цель.конец = конец.dup(&цель.размести);
        }
        else
        {
            //
            // установи up цель like this one
            //
            цель.установка();
        }
    }

    /**
     * Allocate a new Узел
     */
    private Узел размести()
    {
        return разм.размести();
    }

    /**
     * Allocate a new Узел, then установи the значение to v
     */
    private Узел размести(V v)
    {
        auto возврзнач = размести();
        возврзнач.значение = v;
        return возврзнач;
    }
}
