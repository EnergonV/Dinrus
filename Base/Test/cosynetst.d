﻿import dinrus, lib.cosyne, cidrus:выход;

void main()
{
COSYNE ко;

    short буфер[ЧЛОСЕМПЛОВ];

	
	 ко = ксИниц(2);
	   if (!ко) {
        скажинс("Неудачная инициализация Cosyne.\n");
        выход(1);
    }

    if (ксГрузиИнстр(ко, 0, синт(АНАЛОГОВЫЙСИНТ))) {
        скажинс(фм( "%s\n", ксОшСооб()));
        выход(1);
    }

    ксИграйНоту(ко,     0, 20000, 0, 40, 0x30);
    ксИграйНоту(ко, 20000, 20000, 0, 42, 0x30);
    ксИграйНоту(ко, 40000, 20000, 0, 43, 0x30);
    ксИграйНоту(ко, 60000, 20000, 0, 46, 0x30);
    ксИграйНоту(ко, 80000, 20000, 0, 47, 0x30);
    ксИграйНоту(ко,100000, 20000, 0, 50, 0x30);

    ксПередай(ко, cast(крат *) буфер, ЧЛОСЕМПЛОВ);
    ксТерм(ко);

    пишиВав("test.wav", 44100, буфер, ЧЛОСЕМПЛОВ);

    сис("test.wav");
	
}