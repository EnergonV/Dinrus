﻿/*******************************************************************************

        copyright:      Copyright (c) 2006 Dinrus. все rights reserved

        license:        BSD стиль: see doc/license.txt for details

        version:        Initial release: Feb 2006

        author:         Regan Heath, Oskar Linde

        This module реализует the SHA-256 Algorithm described by Secure
        Хэш Standard, FИПS PUB 180-2

*******************************************************************************/

module util.digest.Sha256;

private import stdrus;

public  import util.digest.Digest;

private import util.digest.MerkleDamgard;

/*******************************************************************************

*******************************************************************************/

final class Sha256 : MerkleDamgard
{
        private бцел[8]         контекст;
        private const бцел      padChar = 0x80;

        /***********************************************************************

                Construct an Sha256

        ***********************************************************************/

        this() { }

        /***********************************************************************

                Initialize the cipher

                Remarks:
                Returns the cipher состояние в_ it's начальное значение

        ***********************************************************************/

        protected override проц сбрось()
        {
                super.сбрось();
                контекст[] = начальное[];
        }

        /***********************************************************************

                Obtain the дайджест

                Remarks:
                Returns a дайджест of the текущ cipher состояние, this may be the
                final дайджест, or a дайджест of the состояние between calls в_ обнови()

        ***********************************************************************/

        protected override проц создайДайджест (ббайт[] буф)
        {
                version (ЛитлЭндиан)
                         ПерестановкаБайт.своп32 (контекст.ptr, контекст.length * бцел.sizeof);

                буф[] = cast(ббайт[]) контекст;
        }

        /***********************************************************************

                The дайджест размер of Sha-256 is 32 байты

        ***********************************************************************/

        бцел размерДайджеста() { return 32; }

        /***********************************************************************

                Шифр блок размер

                Возвращает:
                the блок размер

                Remarks:
                Specifies the размер (in байты) of the блок of данные в_ пароль в_
                each вызов в_ трансформируй(). For SHA256 the размерБлока is 64.

        ***********************************************************************/

        protected override бцел размерБлока() { return 64; }

        /***********************************************************************

                Length паддинг размер

                Возвращает:
                the length паддинг размер

                Remarks:
                Specifies the размер (in байты) of the паддинг which uses the
                length of the данные which имеется been ciphered, this паддинг is
                carried out by the padLength метод. For SHA256 the добавьРазмер is 8.

        ***********************************************************************/

        protected override бцел добавьРазмер()   { return 8;  }

        /***********************************************************************

                Pads the cipher данные

                Параметры:
                данные = a срез of the cipher буфер в_ заполни with паддинг

                Remarks:
                Fills the passed буфер срез with the appropriate паддинг for
                the final вызов в_ трансформируй(). This паддинг will заполни the cipher
                буфер up в_ размерБлока()-добавьРазмер().

        ***********************************************************************/

        protected override проц padMessage(ббайт[] данные)
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

        protected override проц padLength(ббайт[] данные, бдол length)
        {
                length <<= 3;
                for(цел j = данные.length-1; j >= 0; j--)
                        данные[$-j-1] = cast(ббайт) (length >> j*8);
        }

        /***********************************************************************

                Performs the cipher on a блок of данные

                Параметры:
                данные = the блок of данные в_ cipher

                Remarks:
                The actual cipher algorithm is carried out by this метод on
                the passed блок of данные. This метод is called for every
                размерБлока() байты of ввод данные и once ещё with the остаток
                данные псеп_в_конце в_ размерБлока().

        ***********************************************************************/

        protected override проц трансформируй(ббайт[] ввод)
        {
                бцел[64] W;
                бцел a,b,c,d,e,f,g,h;
                бцел j,t1,t2;

                a = контекст[0];
                b = контекст[1];
                c = контекст[2];
                d = контекст[3];
                e = контекст[4];
                f = контекст[5];
                g = контекст[6];
                h = контекст[7];

                bigEndian32(ввод,W[0..16]);
                for(j = 16; j < 64; j++) {
                        W[j] = mix1(W[j-2]) + W[j-7] + mix0(W[j-15]) + W[j-16];
                }

                for(j = 0; j < 64; j++) {
                        t1 = h + sum1(e) + Ch(e,f,g) + K[j] + W[j];
                        t2 = sum0(a) + Maj(a,b,c);
                        h = g;
                        g = f;
                        f = e;
                        e = d + t1;
                        d = c;
                        c = b;
                        b = a;
                        a = t1 + t2;
                }

                контекст[0] += a;
                контекст[1] += b;
                контекст[2] += c;
                контекст[3] += d;
                контекст[4] += e;
                контекст[5] += f;
                контекст[6] += g;
                контекст[7] += h;
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел Ch(бцел x, бцел y, бцел z)
        {
                return (x&y)^(~x&z);
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел Maj(бцел x, бцел y, бцел z)
        {
                return (x&y)^(x&z)^(y&z);
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел sum0(бцел x)
        {
                return вращайВправо(x,2)^вращайВправо(x,13)^вращайВправо(x,22);
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел sum1(бцел x)
        {
                return вращайВправо(x,6)^вращайВправо(x,11)^вращайВправо(x,25);
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел mix0(бцел x)
        {
                return вращайВправо(x,7)^вращайВправо(x,18)^shiftRight(x,3);
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел mix1(бцел x)
        {
                return вращайВправо(x,17)^вращайВправо(x,19)^shiftRight(x,10);
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел вращайВправо(бцел x, бцел n)
        {
                return (x >> n) | (x << (32-n));
        }

        /***********************************************************************

        ***********************************************************************/

        private static бцел shiftRight(бцел x, бцел n)
        {
                return x >> n;
        }
}


/*******************************************************************************

*******************************************************************************/

private static бцел[] K =
[
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
];

/*******************************************************************************

*******************************************************************************/

private static const бцел[8] начальное =
[
        0x6a09e667,
        0xbb67ae85,
        0x3c6ef372,
        0xa54ff53a,
        0x510e527f,
        0x9b05688c,
        0x1f83d9ab,
        0x5be0cd19
];

/*******************************************************************************

*******************************************************************************/

debug(UnitTest)
{
        unittest
        {
        static ткст[] strings =
        [
                "abc",
                "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
        ];

        static ткст[] results =
        [
                "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
                "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1"
        ];

        Sha256 h = new Sha256();

        foreach (цел i, ткст s; strings)
                {
                h.обнови(s);
                ткст d = h.гексДайджест();
                assert(d == results[i],"Шифр:("~s~")("~d~")!=("~results[i]~")");
                }
        }
}

