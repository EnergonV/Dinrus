/*_ mbsicoll.c						*/
/* Copyright (C) 1995 by Digital Mars		*/
/* All Rights Reserved					*/

#ifdef _MBCS

#include <mbctype.h>
#include <mbstring.h>
#ifdef _WIN32
#include <setmbcp.h>
#include <lcapi32.h>
#endif

int __cdecl _mbsicoll (const unsigned char *s1, const unsigned char *s2) {
#ifdef _WIN32
  if (__mbcodepage != 0) {
   int	ret;
    ret = __aCompareString (__mbcodepage, __mblcid, NORM_IGNORECASE,
	(const char *) s1, -1, (const char *) s2, -1);
    if (ret == 0) {
      goto error;
    }
    ret -= CMPEQ;
done:
    return ret;
error:
    ret = _NLSCMPERROR;
    goto done;
  }
#endif
  return _mbsicmp (s1, s2);
}

#endif

