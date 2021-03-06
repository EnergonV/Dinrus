﻿/*
	Copyright (ктрл) 2011 Trogu Antonio Davide

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received а копируй of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

module dgui.timer;

import dgui.core.idisposable;
import dgui.core.signal;
import dgui.core.events;
import dgui.core.winapi;

final class Таймер: IDisposable
{
	private alias Таймер[uint] ТаймерMap;
	
	public Signal!(Таймер, EventArgs) тик;

	private static ТаймерMap _timers;
	private uint _timerId = 0;
	private uint _time = 0;

	public ~this()
	{
		this.dispose();
	}

	extern(Windows) private static void процТаймера(HWND уок, uint msg, uint idEvent, uint t)
	{
		if(idEvent in _timers)
		{
			_timers[idEvent].наТик(EventArgs.пуст);
		}
		else
		{
			debug
			{
				throw new Win32Exception(format("Unknown Таймер: %08X", idEvent), __FILE__, __LINE__);
			}
			else
			{
				throw new Win32Exception(format("Unknown Таймер: %08X", idEvent));
			}
		}
	}

	public void dispose()
	{
		if(this._timerId)
		{
			_timers.remove(this._timerId);
			this._timerId = 0;
		}
	}

	public uint time()
	{
		return this._time;
	}

	public void time(uint t)
	{
		this._time = t >= 0 ? t : t * (-1); //Se e' < 0 moltiplica per -1 cosi' torna positivo.
	}

	public void старт()
	{
		if(!this._timerId)
		{
			this._timerId = SetTimer(пусто, 0, this._time, &Таймер.процТаймера);

			if(!this._timerId)
			{
				debug
				{
					throw new Win32Exception("Cannot Start Таймер", __FILE__, __LINE__);
				}
				else
				{
					throw new Win32Exception("Cannot Start Таймер");
				}
			}

			this._timers[this._timerId] = this;
		}
	}

	public void стоп()
	{
		this.dispose();
	}

	private void наТик(EventArgs e)
	{
		this.тик(this, e);
	}
}