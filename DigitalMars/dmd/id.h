// File generated by idgen.c
#pragma once
#ifndef DMD_ID_H
#define DMD_ID_H 1
class Identifier;
struct Id
{
    static Identifier *IUnknown;
    static Identifier *Object;
    static Identifier *object;
    static Identifier *max;
    static Identifier *min;
    static Identifier *This;
    static Identifier *super;
    static Identifier *ctor;
    static Identifier *dtor;
    static Identifier *cpctor;
    static Identifier *_postblit;
    static Identifier *classInvariant;
    static Identifier *unitTest;
    static Identifier *require;
    static Identifier *ensure;
    static Identifier *init;
    static Identifier *size;
    static Identifier *__sizeof;
    static Identifier *__xalignof;
    static Identifier *mangleof;
    static Identifier *stringof;
    static Identifier *tupleof;
    static Identifier *length;
    static Identifier *remove;
    static Identifier *ptr;
    static Identifier *array;
    static Identifier *funcptr;
    static Identifier *dollar;
    static Identifier *ctfe;
    static Identifier *offset;
    static Identifier *offsetof;
    static Identifier *ModuleInfo;
    static Identifier *ClassInfo;
    static Identifier *classinfo;
    static Identifier *typeinfo;
    static Identifier *outer;
    static Identifier *Exception;
    static Identifier *AssociativeArray;
    static Identifier *RTInfo;
    static Identifier *Throwable;
    static Identifier *Error;
    static Identifier *withSym;
    static Identifier *result;
    static Identifier *returnLabel;
    static Identifier *delegate;
    static Identifier *line;
    static Identifier *empty;
    static Identifier *p;
    static Identifier *q;
    static Identifier *coverage;
    static Identifier *__vptr;
    static Identifier *__monitor;
    static Identifier *TypeInfo;
    static Identifier *TypeInfo_Class;
    static Identifier *TypeInfo_Interface;
    static Identifier *TypeInfo_Struct;
    static Identifier *TypeInfo_Enum;
    static Identifier *TypeInfo_Typedef;
    static Identifier *TypeInfo_Pointer;
    static Identifier *TypeInfo_Vector;
    static Identifier *TypeInfo_Array;
    static Identifier *TypeInfo_StaticArray;
    static Identifier *TypeInfo_AssociativeArray;
    static Identifier *TypeInfo_Function;
    static Identifier *TypeInfo_Delegate;
    static Identifier *TypeInfo_Tuple;
    static Identifier *TypeInfo_Const;
    static Identifier *TypeInfo_Invariant;
    static Identifier *TypeInfo_Shared;
    static Identifier *TypeInfo_Wild;
    static Identifier *elements;
    static Identifier *_arguments_typeinfo;
    static Identifier *_arguments;
    static Identifier *_argptr;
    static Identifier *_match;
    static Identifier *destroy;
    static Identifier *postblit;
    static Identifier *LINE;
    static Identifier *FILE;
    static Identifier *MODULE;
    static Identifier *FUNCTION;
    static Identifier *PRETTY_FUNCTION;
    static Identifier *DATE;
    static Identifier *TIME;
    static Identifier *TIMESTAMP;
    static Identifier *VENDOR;
    static Identifier *VERSIONX;
    static Identifier *EOFX;
    static Identifier *nan;
    static Identifier *infinity;
    static Identifier *dig;
    static Identifier *epsilon;
    static Identifier *mant_dig;
    static Identifier *max_10_exp;
    static Identifier *max_exp;
    static Identifier *min_10_exp;
    static Identifier *min_exp;
    static Identifier *min_normal;
    static Identifier *re;
    static Identifier *im;
    static Identifier *C;
    static Identifier *D;
    static Identifier *Windows;
    static Identifier *Pascal;
    static Identifier *System;
    static Identifier *exit;
    static Identifier *success;
    static Identifier *failure;
    static Identifier *keys;
    static Identifier *values;
    static Identifier *rehash;
    static Identifier *sort;
    static Identifier *reverse;
    static Identifier *dup;
    static Identifier *idup;
    static Identifier *property;
    static Identifier *safe;
    static Identifier *trusted;
    static Identifier *system;
    static Identifier *disable;
    static Identifier *___out;
    static Identifier *___in;
    static Identifier *__int;
    static Identifier *__dollar;
    static Identifier *__LOCAL_SIZE;
    static Identifier *uadd;
    static Identifier *neg;
    static Identifier *com;
    static Identifier *add;
    static Identifier *add_r;
    static Identifier *sub;
    static Identifier *sub_r;
    static Identifier *mul;
    static Identifier *mul_r;
    static Identifier *div;
    static Identifier *div_r;
    static Identifier *mod;
    static Identifier *mod_r;
    static Identifier *eq;
    static Identifier *cmp;
    static Identifier *iand;
    static Identifier *iand_r;
    static Identifier *ior;
    static Identifier *ior_r;
    static Identifier *ixor;
    static Identifier *ixor_r;
    static Identifier *shl;
    static Identifier *shl_r;
    static Identifier *shr;
    static Identifier *shr_r;
    static Identifier *ushr;
    static Identifier *ushr_r;
    static Identifier *cat;
    static Identifier *cat_r;
    static Identifier *assign;
    static Identifier *addass;
    static Identifier *subass;
    static Identifier *mulass;
    static Identifier *divass;
    static Identifier *modass;
    static Identifier *andass;
    static Identifier *orass;
    static Identifier *xorass;
    static Identifier *shlass;
    static Identifier *shrass;
    static Identifier *ushrass;
    static Identifier *catass;
    static Identifier *postinc;
    static Identifier *postdec;
    static Identifier *index;
    static Identifier *indexass;
    static Identifier *slice;
    static Identifier *sliceass;
    static Identifier *call;
    static Identifier *cast;
    static Identifier *match;
    static Identifier *next;
    static Identifier *opIn;
    static Identifier *opIn_r;
    static Identifier *opStar;
    static Identifier *opDot;
    static Identifier *opDispatch;
    static Identifier *opDollar;
    static Identifier *opUnary;
    static Identifier *opIndexUnary;
    static Identifier *opSliceUnary;
    static Identifier *opBinary;
    static Identifier *opBinaryRight;
    static Identifier *opOpAssign;
    static Identifier *opIndexOpAssign;
    static Identifier *opSliceOpAssign;
    static Identifier *pow;
    static Identifier *pow_r;
    static Identifier *powass;
    static Identifier *classNew;
    static Identifier *classDelete;
    static Identifier *apply;
    static Identifier *applyReverse;
    static Identifier *Fempty;
    static Identifier *Ffront;
    static Identifier *Fback;
    static Identifier *FpopFront;
    static Identifier *FpopBack;
    static Identifier *adDup;
    static Identifier *adReverse;
    static Identifier *aaLen;
    static Identifier *aaKeys;
    static Identifier *aaValues;
    static Identifier *aaRehash;
    static Identifier *monitorenter;
    static Identifier *monitorexit;
    static Identifier *criticalenter;
    static Identifier *criticalexit;
    static Identifier *_ArrayEq;
    static Identifier *lib;
    static Identifier *msg;
    static Identifier *startaddress;
    static Identifier *mangle;
    static Identifier *tohash;
    static Identifier *tostring;
    static Identifier *getmembers;
    static Identifier *__alloca;
    static Identifier *main;
    static Identifier *WinMain;
    static Identifier *DllMain;
    static Identifier *tls_get_addr;
    static Identifier *entrypoint;
    static Identifier *va_argsave_t;
    static Identifier *va_argsave;
    static Identifier *std;
    static Identifier *core;
    static Identifier *math;
    static Identifier *sin;
    static Identifier *cos;
    static Identifier *tan;
    static Identifier *_sqrt;
    static Identifier *_pow;
    static Identifier *atan2;
    static Identifier *rndtol;
    static Identifier *expm1;
    static Identifier *exp2;
    static Identifier *yl2x;
    static Identifier *yl2xp1;
    static Identifier *fabs;
    static Identifier *bitop;
    static Identifier *bsf;
    static Identifier *bsr;
    static Identifier *bswap;
    static Identifier *isAbstractClass;
    static Identifier *isArithmetic;
    static Identifier *isAssociativeArray;
    static Identifier *isFinalClass;
    static Identifier *isPOD;
    static Identifier *isNested;
    static Identifier *isFloating;
    static Identifier *isIntegral;
    static Identifier *isScalar;
    static Identifier *isStaticArray;
    static Identifier *isUnsigned;
    static Identifier *isVirtualFunction;
    static Identifier *isVirtualMethod;
    static Identifier *isAbstractFunction;
    static Identifier *isFinalFunction;
    static Identifier *isStaticFunction;
    static Identifier *isRef;
    static Identifier *isOut;
    static Identifier *isLazy;
    static Identifier *hasMember;
    static Identifier *identifier;
    static Identifier *getProtection;
    static Identifier *parent;
    static Identifier *getMember;
    static Identifier *getOverloads;
    static Identifier *getVirtualFunctions;
    static Identifier *getVirtualMethods;
    static Identifier *classInstanceSize;
    static Identifier *allMembers;
    static Identifier *derivedMembers;
    static Identifier *isSame;
    static Identifier *compiles;
    static Identifier *parameters;
    static Identifier *getAttributes;
    static Identifier *getUnitTests;
    static Identifier *isOverrideFunction;
    static Identifier *getVirtualIndex;
    static void initialize();
};
#endif