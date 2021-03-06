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

/*
   From MSDN
  
   Rich Edit version	DLL	Window Class
   ----
   1.0	Riched32.dll	RICHEDIT_CLASS
   2.0	Riched20.dll	RICHEDIT_CLASS
   3.0	Riched20.dll	RICHEDIT_CLASS
   4.1	Msftedit.dll	MSFTEDIT_CLASS
  
   Windows XP SP1:  Includes Microsoft Rich Edit 4.1, Microsoft Rich Edit 3.0, and а Microsoft Rich Edit 1.0 emulator.
   Windows XP: 		Includes Microsoft Rich Edit 3.0 with а Microsoft Rich Edit 1.0 emulator.
   Windows Me: 		Includes Microsoft Rich Edit 1.0 and 3.0.
   Windows 2000:	Includes Microsoft Rich Edit 3.0 with а Microsoft Rich Edit 1.0 emulator.
   Windows NT 4.0:	Includes Microsoft Rich Edit 1.0 and 2.0.
   Windows 98:		Includes Microsoft Rich Edit 1.0 and 2.0.
   Windows 95:		Includes only Microsoft Rich Edit 1.0. However, Riched20.dll is compatible with Windows 95 and may be installed by an application that requires it.
 */

module dgui.richtextbox;

public import dgui.textbox;
public import dgui.core.winapi;

private const string WC_RICHEDIT = "RichEdit20A";
private const string WC_DRICHEDIT = "DRichTextBox";

class RichTextBox: TextControl
{
	private static _refCount = 0;
	private static HMODULE _hRichDll;

	public this()
	{
		
	}

	public override void dispose()
	{
		--_refCount;
		
		if(!_refCount)
		{
			FreeLibrary(_hRichDll);
			_hRichDll = пусто;
		}
	}

	public void redo()
	in
	{
		assert(this.created);
	}
	body
	{
		this.шлиСооб(EM_REDO, 0, 0);
	}

	protected override void preCreateWindow(inout PreCreateWindow pcw)
	{
		++_refCount;

		if(!_hRichDll)
		{
			_hRichDll = LoadLibraryA("riched20.dll"); // Load the standard version
		}

		pcw.Style |= ES_MULTILINE | ES_WANTRETURN;
		pcw.OldClassName = WC_RICHEDIT;
		pcw.ClassName = WC_DRICHEDIT;
		
		super.preCreateWindow(pcw);
	}

	protected override void поСозданиюУказателя(EventArgs e)
	{
		super.поСозданиюУказателя(e);

		this.шлиСооб(EM_SETEVENTMASK, 0, ENM_CHANGE | ENM_UPDATE);
		this.шлиСооб(EM_SETBKGNDCOLOR, 0, this._controlInfo.BackColor.colorref);
	}
}