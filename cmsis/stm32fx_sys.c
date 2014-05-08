#include <errno.h>

extern char __HeapStart, __HeapLimit;
static char* heap_end = & __HeapStart;
void* _sbrk(int incr)
{
    char *prev_heap_end, *max_heap;
    max_heap = & __HeapLimit;

    prev_heap_end = heap_end;
    if(prev_heap_end + incr > max_heap)
    {
        errno = ENOMEM;
        return (void*) -1;
    }
    else
    {
        heap_end = prev_heap_end + incr;
        return prev_heap_end;
    }
}
