﻿module std.math;

extern(D):

креал син(креал x);
вреал син(вреал x);
реал абс(креал x);
реал абс(вреал x);
креал квкор(креал x);
креал кос(креал x);
креал конъюнк(креал y);
вреал конъюнк(вреал y);
реал кос(вреал x);
реал степень(реал а, бцел н);

реал абс(реал x);
дол абс(дол x);
цел абс(цел x);
реал кос(реал x);
реал син(реал x);
реал тан(реал x);
реал акос(реал x);
реал асин(реал x);
реал атан(реал x);
реал атан2(реал y, реал x);
реал гкос(реал x);
реал гсин(реал x);
реал гтан(реал x);
реал гакос(реал x);
реал гасин(реал x);
реал гатан(реал x);
дол округливдол(реал x);
реал округливближдол(реал x);
плав квкор(плав x);
дво квкор(дво x);
реал квкор(реал x);
реал эксп(реал x);
реал экспм1(реал x);
реал эксп2(реал x);
креал экспи(реал x);
реал прэксп(реал знач, out цел эксп);
цел илогб(реал x);
реал лдэксп(реал н, цел эксп);
реал лог(реал x);
реал лог10(реал x);
реал лог1п(реал x);
реал лог2(реал x);
реал логб(реал x);
реал модф(реал x, inout реал y);
реал скалбн(реал x, цел н);
реал кубкор(реал x);
реал фабс(реал x);
реал гипот(реал x, реал y);
реал фцош(реал x);
реал лгамма(реал x);
реал тгамма(реал x);
реал потолок(реал x);
реал пол(реал x);
реал ближцел(реал x);

цел окрвцел(реал x);
реал окрвреал(реал x);
дол окрвдол(реал x);
реал округли(реал x);
дол докругли(реал x);
реал упрости(реал x);
реал остаток(реал x, реал y);
бул нч_ли(реал x);
бул конечен_ли(реал р);

бул субнорм_ли(плав п);
бул субнорм_ли(дво п);
бул субнорм_ли(реал п);
бул беск_ли(реал р);
бул идентичен_ли(реал р, реал д);
бул битзнака(реал р);
реал копируйзнак(реал кому, реал у_кого);
реал нч(ткст тэгп);
реал следщБольш(реал р);
дво следщБольш(дво р);
плав следщБольш(плав р);
реал следщМеньш(реал р);
дво следщМеньш(дво р);
плав следщМеньш(плав р);
реал следщза(реал а, реал б);
плав следщза(плав а, плав б);
дво следщза(дво а, дво б);
реал пдельта(реал а, реал б);
реал пбольш_из(реал а, реал б);
реал пменьш_из(реал а, реал б);

реал степень(реал а, цел н);
реал степень(реал а, реал н);


цел квадрат(цел а);
дол квадрат(цел а);
цел сумма(цел[] ч);
дол сумма(дол[] ч);
цел меньш_из(цел[] ч);
дол меньш_из(дол[] ч);
цел меньш_из(цел а, цел б);
дол меньш_из(дол а, дол б);
цел больш_из(цел[] ч);
дол больш_из(дол[] ч);
цел больш_из(цел а, цел б);
дол больш_из(дол а, дол б);

бул правны(реал а, реал б);
бул правны(реал а, реал б, реал эпс);

реал квадрат(цел а);
реал дробь(реал а);
цел знак(цел а);
цел знак(дол а);
цел знак(реал а);
реал цикл8градус(реал ц);
реал цикл8радиан(реал ц);
реал цикл8градиент(реал ц);
реал градус8цикл(реал г);
реал градус8радиан(реал г);
реал градус8градиент(реал г);
реал радиан8градус(реал р);
реал радиан8цикл(реал р);
реал радиан8градиент(реал р);
реал градиент8градус(реал г);
реал градиент8цикл(реал г);
реал градиент8радиан(реал г);
реал сариф(реал[] ч);
реал сумма(реал[] ч);
реал меньш_из(реал[] ч);
реал меньш_из(реал а, реал б);
реал больш_из(реал[] ч);
реал больш_из(реал а, реал б);
реал акот(реал р);
реал асек(реал р);
реал акосек(реал р);
реал кот(реал р);
реал сек(реал р);
реал косек(реал р);
реал гкот(реал р);
реал гсек(реал р);
реал гкосек(реал р);
реал гакот(реал р);
реал гасек(реал р);
реал гакосек(реал р);
реал ткст8реал(ткст т);