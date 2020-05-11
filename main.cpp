#include "Bitmap.h"
#include "stdio.h"

int main()
{
    BMP_file picture;
    picture.load_file ("cats.bmp");
    BMP_file front;
    front.load_file ("zxc_(2).bmp");
    //front.set_transparency (50);
    //front.set_transparency (50);
    //front.set_transparency (50);
    //front.set_transparency (50);
    picture.sse_blend_with (front, 1, 0);
    picture.draw ();
    //front.draw();
}