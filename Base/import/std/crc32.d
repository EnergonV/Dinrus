﻿module std.crc32;

extern(D)
{
		бцел иницЦПИ32();
		бцел обновиЦПИ32(ббайт зн, бцел црц);
		бцел обновиЦПИ32(сим зн, бцел црц);
		бцел ткстЦПИ32(ткст т);

		struct ЦПИ32 
		{	

			бцел иниц();
			бцел обнови(ббайт зн, бцел црц);
			бцел обнови(сим зн, бцел црц);
			бцел вЦПИ32(ткст т);
		}
}

