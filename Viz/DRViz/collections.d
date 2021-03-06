﻿//Автор Кристофер Миллер. Переработано для Динрус Виталием Кулич.
//Библиотека визуальных конпонентов VIZ (первоначально DFL).


// Not actually part of forms, but is handy.

module viz.collections;

private import viz.x.dlib;

private import viz.base;


проц _blankListCallback(ШЗначение)(т_мера idx, ШЗначение val) // package
{
}


// Mixin.
// Item*Callback called before modifications.
// For сотри(), индекс is т_мера.max and значение is пусто. If СТЕРЕТЬ_КАЖДЫЙ, also called back for each значение.
template ListWrapArray(ШЗначение, alias Массив,
	/+ // DMD 1.005: basic тип expected, not function
	alias ОбрвызДобавленияЭлта = function(т_мера idx, ШЗначение val){},
	alias ОбрвызЭлтДобавлен = function(т_мера idx, ШЗначение val){},
	alias ОбрвызУдаленияЭлта = function(т_мера idx, ШЗначение val){},
	alias ОбрвызЭлтУдалён = function(т_мера idx, ШЗначение val){},
	+/
	alias ОбрвызДобавленияЭлта,
	alias ОбрвызЭлтДобавлен,
	alias ОбрвызУдаленияЭлта,
	alias ОбрвызЭлтУдалён,
	бул ПЕРЕГРУЖАТЬ_СТРОКУ = нет,
	бул ПЕРЕГРУЖАТЬ_ОБЪЕКТ = нет,
	бул COW = да,
	бул СТЕРЕТЬ_КАЖДЫЙ = нет) // package
{
	mixin OpApplyWrapArray!(ШЗначение, Массив); // Note: this overrides COW.
	
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		static assert(!is(ШЗначение == Объект));
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		static assert(!is(ШЗначение == Ткст));
		
		static if(is(ШЗначение == Объект))
			alias СтроковыйОбъект СтрокаШЗначения;
		else
			alias ШЗначение СтрокаШЗначения;
	}
	
	
		проц opIndexAssign(ШЗначение значение, цел индекс) // setter
	{
		ШЗначение oldval = Массив[индекс];
		ОбрвызУдаленияЭлта(индекс, oldval); // Removing.
		static if(COW)
		{
			Массив = Массив.dup;
		}
		else
		{
			//Массив[индекс] = ШЗначение.init;
		}
		ОбрвызЭлтУдалён(индекс, oldval); // Removed.
		
		ОбрвызДобавленияЭлта(индекс, значение); // Adding.
		Массив[индекс] = значение;
		ОбрвызЭлтДобавлен(индекс, значение); // Added.
	}
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		
		проц opIndexAssign(Объект значение, цел индекс) // setter
		{
			ШЗначение tval;
			tval = cast(ШЗначение)значение;
			if(tval)
				return opIndexAssign(tval, индекс);
			else
				return opIndexAssign(new ШЗначение(значение), индекс); // ?
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		
		проц opIndexAssign(Ткст значение, цел индекс) // setter
		{
			return opIndexAssign(new СтрокаШЗначения(значение), индекс);
		}
	}
	
	
		ШЗначение opIndex(цел индекс) // getter
	{
		return Массив[индекс];
	}
	
	
		проц добавь(ШЗначение значение)
	{
		вставь(cast(цел)Массив.length, значение);
	}
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		
		проц добавь(Объект значение)
		{
			вставь(cast(цел)Массив.length, значение);
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		
		проц добавь(Ткст значение)
		{
			вставь(cast(цел)Массив.length, new СтрокаШЗначения(значение));
		}
	}
	
	
		проц сотри()
	{
		ОбрвызУдаленияЭлта(т_мера.max, пусто); // Removing ВСЕ.
		
		т_мера iw;
		iw = Массив.length;
		if(iw)
		{
			static if(СТЕРЕТЬ_КАЖДЫЙ)
			{
				try
				{
					// Remove in reverse order so the indices don't keep shifting.
					ШЗначение oldval;
					for(--iw;; iw--)
					{
						oldval = Массив[iw];
						static if(СТЕРЕТЬ_КАЖДЫЙ)
						{
							ОбрвызУдаленияЭлта(iw, oldval); // Removing.
						}
						/+static if(COW)
						{
						}
						else
						{
							//Массив[iw] = ШЗначение.init;
						}+/
						debug
						{
							Массив = Массив[0 .. iw]; // 'Temporarily' removes it for ОбрвызЭлтУдалён.
						}
						static if(СТЕРЕТЬ_КАЖДЫЙ)
						{
							ОбрвызЭлтУдалён(iw, oldval); // Removed.
						}
						if(!iw)
							break;
					}
				}
				finally
				{
					Массив = Массив[0 .. iw];
					static if(COW)
					{
						if(!iw)
							Массив = пусто;
					}
				}
			}
			else
			{
				Массив = Массив[0 .. 0];
				static if(COW)
				{
					Массив = пусто;
				}
			}
		}
		
		ОбрвызЭлтУдалён(т_мера.max, пусто); // Removed ВСЕ.
	}
	
	
		бул содержит(ШЗначение значение)
	{
		return -1 != найдиИндекс!(ШЗначение)(Массив, значение);
	}
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		
		бул содержит(Объект значение)
		{
			return -1 != индексУ(значение);
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		
		бул содержит(Ткст значение)
		{
			return -1 != индексУ(значение);
		}
	}
	
	
		цел индексУ(ШЗначение значение)
	{
		return найдиИндекс!(ШЗначение)(Массив, значение);
	}
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		
		цел индексУ(Объект значение)
		{
			ШЗначение tval;
			tval = cast(ШЗначение)значение;
			if(tval)
			{
				return индексУ(tval);
			}
			else
			{
				foreach(т_мера idx, ШЗначение onval; Массив)
				{
					if(onval == значение) // ШЗначение must have opEquals.
						return idx;
				}
				return -1;
			}
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		
		цел индексУ(Ткст значение)
		{
			foreach(т_мера idx, ШЗначение onval; Массив)
			{
				static if(is(ШЗначение == СтрокаШЗначения))
				{
					if(onval == значение) // ШЗначение must have opEquals.
						return idx;
				}
				else
				{
					if(дайТкстОбъекта(onval) == значение)
						return idx;
				}
			}
			return -1;
		}
	}
	
	
		проц вставь(цел индекс, ШЗначение значение)
	{
		if(индекс > Массив.length)
			индекс = Массив.length;
		ОбрвызДобавленияЭлта(индекс, значение); // Adding.
		static if(COW)
		{
			if(индекс >= Массив.length)
			{
				if(Массив.length) // Workaround old bug ?
				{
					Массив = Массив[0 .. индекс] ~ (&значение)[0 .. 1];
				}
				else
				{
					Массив = (&значение)[0 .. 1].dup;
				}
				goto insert_done;
			}
		}
		else
		{
			if(индекс >= Массив.length)
			{
				Массив ~= значение;
				goto insert_done;
			}
		}
		Массив = Массив[0 .. индекс] ~ (&значение)[0 .. 1] ~ Массив[индекс .. Массив.length];
		insert_done:
		ОбрвызЭлтДобавлен(индекс, значение); // Added.
	}
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		
		проц вставь(цел индекс, Объект значение)
		{
			ШЗначение tval;
			tval = cast(ШЗначение)значение;
			if(tval)
				return вставь(индекс, tval);
			else
				return вставь(индекс, new ШЗначение(значение)); // ?
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		
		проц вставь(цел индекс, Ткст значение)
		{
			return вставь(индекс, new СтрокаШЗначения(значение));
		}
	}
	
	
		проц удали(ШЗначение значение)
	{
		цел индекс;
		индекс = найдиИндекс!(ШЗначение)(Массив, значение);
		if(-1 != индекс)
			удалиПо(индекс);
	}
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		
		проц удали(Объект значение)
		{
			ШЗначение tval;
			tval = cast(ШЗначение)значение;
			if(tval)
			{
				return удали(tval);
			}
			else
			{
				цел i;
				i = индексУ(значение);
				if(-1 != i)
					удалиПо(i);
			}
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		
		проц удали(Ткст значение)
		{
			цел i;
			i = индексУ(значение);
			if(-1 != i)
				удалиПо(i);
		}
	}
	
	
		проц удалиПо(цел индекс)
	{
		ШЗначение oldval = Массив[индекс];
		ОбрвызУдаленияЭлта(индекс, oldval); // Removing.
		if(!индекс)
			Массив = Массив[1 .. Массив.length];
		else if(индекс == Массив.length - 1)
			Массив = Массив[0 .. индекс];
		else if(индекс > 0 && индекс < cast(цел)Массив.length)
			Массив = Массив[0 .. индекс] ~ Массив[индекс + 1 .. Массив.length];
		ОбрвызЭлтУдалён(индекс, oldval); // Removed.
	}
	
	
	deprecated alias length count;
	
		т_мера length() // getter
	{
		return Массив.length;
	}
	
	
	deprecated alias dup clone;
	
		ШЗначение[] dup()
	{
		return Массив.dup;
	}
	
	
		проц копируйВ(ШЗначение[] dest, цел destIndex)
	{
		dest[destIndex .. destIndex + Массив.length] = Массив;
	}
	
	
		проц добавьДиапазон(ШЗначение[] значения)
	{
		foreach(ШЗначение значение; значения)
		{
			добавь(значение);
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_ОБЪЕКТ)
	{
		
		проц добавьДиапазон(Объект[] значения)
		{
			foreach(Объект значение; значения)
			{
				добавь(значение);
			}
		}
	}
	
	static if(ПЕРЕГРУЖАТЬ_СТРОКУ)
	{
		
		проц добавьДиапазон(Ткст[] значения)
		{
			foreach(Ткст значение; значения)
			{
				добавь(значение);
			}
		}
	}
}


// Mixin.
template OpApplyAddIndex(alias ФункцияПрименить, ШЗначение, бул ДОБАВИТЬ_ФУНКЦ_ПРИМЕНИТЬ = нет) // package
{
		цел opApply(цел delegate(inout т_мера, inout ШЗначение val) дг)
	{
		т_мера idx = 0;
		return ФункцияПрименить(
			(inout ШЗначение val)
			{
				цел результат;
				результат = дг(idx, val);
				idx++;
				return результат;
			});
	}
	
	
	static if(ДОБАВИТЬ_ФУНКЦ_ПРИМЕНИТЬ)
	{
		
		цел opApply(цел delegate(inout ШЗначение val) дг)
		{
			return ФункцияПрименить(дг);
		}
	}
}


// Mixin.
template OpApplyWrapArray(ШЗначение, alias Массив) // package
{
		цел opApply(цел delegate(inout ШЗначение val) дг)
	{
		цел результат = 0;
		foreach(inout ШЗначение val; Массив)
		{
			результат = дг(val);
			if(результат)
				break;
		}
		return результат;
	}
	
	
	цел opApply(цел delegate(inout т_мера, inout ШЗначение val) дг)
	{
		цел результат = 0;
		foreach(т_мера idx, inout ШЗначение val; Массив)
		{
			результат = дг(idx, val);
			if(результат)
				break;
		}
		return результат;
	}
}


template удалиИндекс(T) // package
{
	T[] удалиИндекс(T[] массив, т_мера индекс)
	{
		if(!индекс)
			массив = массив[1 .. массив.length];
		else if(индекс == массив.length - 1)
			массив = массив[0 .. индекс];
		else
			массив = массив[0 .. индекс] ~ массив[индекс + 1 .. массив.length];
		return массив;
	}
}


// Returns -1 if not found.
template найдиИндекс(T) // package
{
	цел найдиИндекс(T[] массив, T объ)
	{
		цел idx;
		for(idx = 0; idx != массив.length; idx++)
		{
			if(объ is массив[idx])
				return idx;
		}
		return -1;
	}
}

