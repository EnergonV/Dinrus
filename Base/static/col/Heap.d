﻿module col.Heap;

/** Martin, 26.12.2004: 
    1) replaced reразмер(размер()-1) with pop_back(), since the later is more efficient
    2) replaced интерфейс_.установи_положение(запись(0), -1); with сбрось_положение()
    3) added const modifier to various functions
    TODO: in the moment the heap does not conform to the ИнтерфейсКучи specification, 
          i.e., copies are passed instead of references. This is especially important 
          for установи_положение(), where the reference аргумент is non-const. The 
          specification should be changed to reflect that the heap actually (only?)
          works when the heap запись is nothing more but a handle.
    TODO: change the specification of ИнтерфейсКучи to make меньше(), больше() и
          дай_положение() const. Needs changing DecimaterT. Might break 
          someone's код.
*/
    

//=============================================================================
//
//  CLASS Куча
//
//=============================================================================

//== INCLUDES =================================================================

//import auxd.OpenMesh.Core.IO.Streams;
import util = tpl.Std;

//== CLASS DEFINITION =========================================================


/** This class demonstrates the ИнтерфейсКучи's interface.  If you
 *  want to build your customized heap you will have to specity a heap
 *  interface class и use this class as a template parameter for the
 *  class Куча. This class defines the interface that this heap
 *  interface имеется to implement.
 *   
 *  See_Also: Куча
 */
struct ИнтерфейсКучиШ(ЗаписьКучи)
{
  /// Comparison of two ЗаписьКучи's: strict меньше
  бул меньше( ref ЗаписьКучи _e1, ref ЗаписьКучи _e2);

  /// Comparison of two ЗаписьКучи's: strict больше
  бул больше( ref ЗаписьКучи _e1, ref ЗаписьКучи _e2);

  /// Get the heap позиция of ЗаписьКучи _e
  цел  дай_положение( ref ЗаписьКучи _e);

  /// Set the heap позиция of ЗаписьКучи _e
  проц установи_положение(ref ЗаписьКучи _e, цел _i);
}



/**
 *  An efficient, highly customizable heap.
 *
 *  The main difference (и performace boost) of this heap compared
 *  to e.g. the heap of the STL is that here to positions of the
 *  heap's элементы are accessible from the элементы themselves.
 *  Therefore if one changes the priority of an элемент one does not
 *  have to удали и re-вставь this элемент, but can just call the
 *  обнови(ЗаписьКучи) method.
 *
 *  This heap class is parameterized by two template аргументы: 
 *  $(UL
 *    $(LI the class \c ЗаписьКучи, that will be stored in the heap)
 *    $(LI the ИнтерфейсКучи telling the heap how to сравни heap entries и
 *        how to store the heap positions in the heap entries.)
 *  )
 *
 *  As an example how to use the class see declaration of class 
 *  Decimater.DecimaterT.
 *
 *  See_Also: ИнтерфейсКучиШ
 */
 
struct Куча(ЗаписьКучи, ИнтерфейсКучи = ЗаписьКучи)
{
public:

    /// Constructor
    static Куча opCall() { Куча M; return M; }
  
    /// Construct with a given \c HeapIterface. 
    static Куча opCall(ref ИнтерфейсКучи _интерфейс) 
    { 
        Куча M; with (M) {
            интерфейс_=(_интерфейс);
        } return M; 
    }

    /// очисть the heap
    проц очисть() { Основа.длина = 0; }

    /// куча пуста?
    бул пуста() { return Основа.длина == 0; }

    /// возвращает размер кучи
    бцел размер() { return Основа.длина; }
    бцел длина() { return Основа.длина; }

    /// резервирует пространство для _n записей
    проц резервируй(бцел _n) { util.резервируй(Основа,_n); }

    /// сбросить положение в куче в -1 (нет в куче)
    проц сбрось_положение(ЗаписьКучи _h)
    { интерфейс_.установи_положение(_h, -1); }
  
    /// запись есть в куче?
    бул сохранена(ЗаписьКучи _h)
    { return интерфейс_.дай_положение(_h) != -1; }
  
    /// вставить запись _h
    проц вставь(ЗаписьКучи _h)  
    { 
        Основа ~= _h; 
        upheap(размер()-1); 
    }

    /// получить первую запись
    ЗаписьКучи первая()
    { 
        assert(!пуста()); 
        return запись(0); 
    }

    /// удалить первую запись
    проц удали_первую()
    {    
        assert(!пуста());
        сбрось_положение(запись(0));
        if (размер() > 1)
        {
            запись(0, запись(размер()-1));
            pop_back();
            downheap(0);
        }
        else
        {
            pop_back();
        }
    }

    /// удалить запись
    проц удали(ЗаписьКучи _h)
    {
        цел поз = интерфейс_.дай_положение(_h);
        сбрось_положение(_h);

        assert(поз != -1);
        assert(cast(бцел) поз < размер());
    
        // последний item ?
        if (cast(бцел) поз == размер()-1)
        {
            pop_back();    
        }
        else 
        {
            запись(поз, запись(размер()-1)); // move последний элем to поз
            pop_back();
            downheap(поз);
            upheap(поз);
        }
    }

    /** обнови an запись: change the ключ и обнови the позиция to
        reestablish the heap property.
    */
    проц обнови(ЗаписьКучи _h)
    {
        цел поз = интерфейс_.дай_положение(_h);
        assert(поз != -1, "ЗаписьКучи не в куче (поз=-1)");
        assert(cast(бцел)поз < размер());
        downheap(поз);
        upheap(поз);
    }
  
    /// проверь heap condition
    бул проверь()
    {
        бул ok = true;
        бцел i, j;
        for (i=0; i<размер(); ++i)
        {
            if (((j=left(i))<размер()) && интерфейс_.больше(запись(i), запись(j))) 
            {
                ошибка("Нарушение условий для Кучи");
                ok=false;
            }
            if (((j=right(i))<размер()) && интерфейс_.больше(запись(i), запись(j)))
            {
                ошибка("Нарушение условий для Кучи");
                ok=false;
            }
        }
        return ok;
    }

protected:  
    /// Instance of ИнтерфейсКучи
    ИнтерфейсКучи интерфейс_;
    ЗаписьКучи[]            Основа;
  

private:
    // typedef
    alias ЗаписьКучи[] ВекторКучи;

  
    проц pop_back() {
        assert(!пуста());
        Основа.длина = Основа.длина-1;
    }

    /// Upheap. Establish heap property.
    проц upheap(бцел _idx)
    {
        ЗаписьКучи     h = запись(_idx);
        бцел  parentIdx;

        while ((_idx>0) &&
               интерфейс_.меньше(h, запись(parentIdx=parent(_idx))))
        {
            запись(_idx, запись(parentIdx));
            _idx = parentIdx;    
        }
  
        запись(_idx, h);
    }

  
    /// Downheap. Establish heap property.
    проц downheap(бцел _idx)
    {
        ЗаписьКучи     h = запись(_idx);
        бцел  childIdx;
        бцел  s = размер();
  
        while(_idx < s)
        {
            childIdx = left(_idx);
            if (childIdx >= s) break;
    
            if ((childIdx+1 < s) &&
                (интерфейс_.меньше(запись(childIdx+1), запись(childIdx))))
                ++childIdx;
    
            if (интерфейс_.меньше(h, запись(childIdx))) break;

            запись(_idx, запись(childIdx));
            _idx = childIdx;
        }  

        запись(_idx, h);

    }

      /// Set запись _h to index _idx и обнови _h's heap позиция.
    проц запись(бцел _idx, ЗаписьКучи _h) 
    {
        assert(_idx < размер());
        Основа[_idx] = _h;
        интерфейс_.установи_положение(_h, _idx);
    }

  
    /// Get the запись at index _idx
    ЗаписьКучи запись(бцел _idx)
    {
        assert(_idx < размер());
        return (Основа[_idx]);
    }
  
    /// Get parent's index
    бцел parent(бцел _i) { return (_i-1)>>1; }
    /// Get left child's index
    бцел left(бцел _i)   { return (_i<<1)+1; }
    /// Get right child's index
    бцел right(бцел _i)  { return (_i<<1)+2; }

}