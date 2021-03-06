﻿/*******************************************************************************

        copyright:      Copyright (c) 2006 Dinrus. все rights reserved

        license:        BSD стиль: see doc/license.txt for details

        version:        Initial release: Feb 2006

        author:         Regan Heath, Oskar Linde

        This module реализует common части of the SHA-0 и SHA-1 algoritms

*******************************************************************************/

module util.digest.Sha01;

private import stdrus;

private import util.digest.MerkleDamgard;

/*******************************************************************************

*******************************************************************************/

package abstract class Sha01 : MerkleDamgard
{
        protected бцел[5]               контекст;
        private static const ббайт      padChar = 0x80;
        package static const бцел       маска = 0x0000000F;
    
        /***********************************************************************

                The дайджест размер of Sha-0 и Sha-1 is 20 байты

        ***********************************************************************/

        final бцел размерДайджеста() { return 20; }

        /***********************************************************************

                Initialize the cipher

                Remarks:
                Returns the cipher состояние в_ it's начальное значение

        ***********************************************************************/

        final protected override проц сбрось()
        {
                super.сбрось();
                контекст[] = начальное[];
        }

        /***********************************************************************

                Obtain the дайджест

                Возвращает:
                the дайджест

                Remarks:
                Returns a дайджест of the текущ cipher состояние, this may be the
                final дайджест, or a дайджест of the состояние between calls в_ обнови()

        ***********************************************************************/

        final protected override проц создайДайджест(ббайт[] буф)
        {
                version (ЛитлЭндиан)
                         ПерестановкаБайт.своп32 (контекст.ptr, контекст.length * бцел.sizeof);

                буф[] = cast(ббайт[]) контекст;
        }

        /***********************************************************************

                 блок размер

                Возвращает:
                the блок размер

                Remarks:
                Specifies the размер (in байты) of the блок of данные в_ пароль в_
                each вызов в_ трансформируй(). For SHA0 the размерБлока is 64.

        ***********************************************************************/

        final protected override бцел размерБлока() { return 64; }

        /***********************************************************************

                Length паддинг размер

                Возвращает:
                the length паддинг размер

                Remarks:
                Specifies the размер (in байты) of the паддинг which uses the
                length of the данные which имеется been ciphered, this паддинг is
                carried out by the padLength метод. For SHA0 the добавьРазмер is 0.

        ***********************************************************************/

        final protected override бцел добавьРазмер() {return 8;}

        /***********************************************************************

                Pads the cipher данные

                Параметры:
                данные = a срез of the cipher буфер в_ заполни with паддинг

                Remarks:
                Fills the passed буфер срез with the appropriate паддинг for
                the final вызов в_ трансформируй(). This паддинг will заполни the cipher
                буфер up в_ размерБлока()-добавьРазмер().

        ***********************************************************************/

        final protected override проц padMessage(ббайт[] данные)
        {
                данные[0] = padChar;
                данные[1..$] = 0;
        }

        /***********************************************************************

                Performs the length паддинг

                Параметры:
                данные   = the срез of the cipher буфер в_ заполни with паддинг
                length = the length of the данные which имеется been ciphered

                Remarks:
                Fills the passed буфер срез with добавьРазмер() байты of паддинг
                based on the length in байты of the ввод данные which имеется been
                ciphered.

        ***********************************************************************/

        final protected override проц padLength(ббайт[] данные, бдол length)
        {
                length <<= 3;
                for(цел j = данные.length-1; j >= 0; j--)
                        данные[$-j-1] = cast(ббайт) (length >> j*данные.length);
        }


        /***********************************************************************

        ***********************************************************************/

        protected static бцел f(бцел t, бцел B, бцел C, бцел D)
        {
                if (t < 20) return (B & C) | ((~B) & D);
                else if (t < 40) return B ^ C ^ D;
                else if (t < 60) return (B & C) | (B & D) | (C & D);
                else return B ^ C ^ D;
        }

        /***********************************************************************

        ***********************************************************************/

        protected static const бцел[] K =
        [
                0x5A827999,
                0x6ED9EBA1,
                0x8F1BBCDC,
                0xCA62C1D6
        ];

        /***********************************************************************

        ***********************************************************************/

        private static const бцел[5] начальное =
        [
                0x67452301,
                0xEFCDAB89,
                0x98BADCFE,
                0x10325476,
                0xC3D2E1F0
        ];
}
