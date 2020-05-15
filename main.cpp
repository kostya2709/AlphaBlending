#include "Bitmap.h"
#include "stdio.h"
#include <time.h>
#include <unistd.h>

//#pragma GCC diagnostic warning "-Wold-style-cast"

void time_testing (BMP_file& background, BMP_file& front);

int main()
{
    BMP_file picture;
    picture.load_file_upd ("matan.bmp");
    BMP_file front;
    front.load_file_upd ("cat_load.bmp");
    //time_testing (picture, front);

    //picture.sse_blend_with (front, 100, 100);
    //picture.draw ();
}

void time_testing (BMP_file& background, BMP_file& front)
{
    clock_t start  = {};
    clock_t end    = {};
    double seconds = {};

    start = clock();
    for (int i = 0; i < 1000; ++i)
        background.blend_with (front, 100, 100);
    end = clock();

    seconds = (double) (end - start) / CLOCKS_PER_SEC;
    printf ("Without SSE: %g seconds.\n", seconds);


    start = clock();
    for (int i = 0; i < 1000; ++i)
        background.sse_blend_with (front, 100, 100);
    end = clock();

    double seconds1 = (double) (end - start) / CLOCKS_PER_SEC;
    printf ("With SSE: %g seconds.\n", seconds1);

    printf ("SSE is faster in: %.3g times\n", seconds / seconds1);

}