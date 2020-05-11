#include "Bitmap.h"
#include "stdio.h"

int main()
{
    BMP_file picture;
    picture.load_file ("matan3.bmp");
    BMP_file front;
    front.load_file ("cat_load.bmp");
    picture.sse_blend_with (front, 100, 100);
    picture.draw ();
}