#include "Bitmap.h"
#include "stdio.h"

int main()
{
    BMP_file picture;
    picture.load_file ("cats.bmp");
    BMP_file front;
    front.load_file ("zxc_(2).bmp");
    picture.blend_with (front, 50, 0);
    picture.draw ();
}