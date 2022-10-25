#include <stdio.h>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <string.h>
#include <emmintrin.h>
#include <immintrin.h>
#include <tmmintrin.h>

enum Mask {Alpha = 0xFF000000, Red = 0x00FF0000, Green = 0x0000FF00, Blue = 0x000000FF};

class pixel
{
public:
    
    uint8_t blue = 0;
    uint8_t green = 0;
    uint8_t red = 0;
    uint8_t alpha = 0;

    explicit pixel (uint32_t pixel) 
    {
        alpha = (pixel & Mask::Alpha) >> 24;
        red = (pixel & Mask::Red) >> 16;
        green = (pixel & Mask::Green) >> 8;
        blue = (pixel & Mask::Blue);   
    }

    operator uint32_t()
    {
        return *((uint32_t*)(this));
    }

    pixel (void) {};
};

struct BMP_file
{
private:

//Bitmap file header:

    uint16_t bfType = 0x424D;             // Type of the file. 424D or 4D42 is expected for BMP-file.
    unsigned int bfSize = 0;                    // Size of the file in bytes.
    unsigned int bfReserved = 0;                // Reserved DWORD. 0 is expected.
    unsigned int bfOffBits = 0x8A;              // Bias from the start of the file up to data segment.

//Bitmap info

// CORE

    unsigned int bcSize = 0x7C;                 // Version of the BMP file: 12 (CORE), 40 (V.3), 108 (V.4), or 124 (V.5).
    int bcWidth = 0x03C2;                       // Raster width.
    int bcHeight = 0x03C0;                      // Raster height.
    unsigned short bcPlanes = 1;                // Used for cursor.
    unsigned short bcBitCount = 0x18;           // Number of bits per pixel.

// Version 3

    unsigned int biCompression = 0;             // The way of bits storage.
    unsigned int biSizeImage = 0;               // The size of pixel data.
    unsigned int biXPelsPerMeter = 0;           // The number of pixels per meter (horizontal).
    unsigned int biYPelsPerMeter = 0;           // The number of pixels per meter (vertical).
    unsigned int biClrUsed = 0;                 // The size of the color table in cells.
    unsigned int biClrImportant = 0;            // The number of cells in the color table.

// Version 4

    unsigned int bV4RedMask = 0x00FF00;         // Bit mask to extract red channel.
    unsigned int bV4GreenMask = 0x0000FF00;     // Bit mask to extract red channel.
    unsigned int bV4BlueMask = 0x000000FF;      // Bit mask to extract red channel.
    unsigned int bV4AlphaMask = 0xFF000000;     // Bit mask to extract red channel.
    unsigned int bV4CSType = 0x73524742;        // Color Space Type.

    unsigned int bV4Endpoints [9] = {};         // These four fields are taken into account
    unsigned int bV4GammaRed = 0;               // only if bV4CSType is not equal zero.
    unsigned int bV4GammaGreen = 0;             //
    unsigned int bV4GammaBlue = 0;              //

// Version 5

    unsigned int bV5Intent = 0;                 // Intent of raster rendering.
    unsigned int bV5ProfileData = 0;            // Bias till Profile Data.
    unsigned int bV5ProfileSize = 0;            // Profile size, if it is included.
    unsigned int bV5Reserved = 0;               // This field is reserved and should be equal 0.

    unsigned int pixel_number = 0;              // Number of pixels in the raster.
    unsigned int bytes_in_pixel = 0;            // Number of bytes in a pixel.

    pixel* data = NULL;                         // Array of pixels.
    char* file_name = NULL;                     // Name of the picture.

public:

    void load_file (const char* file_name);     // This function loads BMP-file to the program with all its attributes.
    void draw (void);
    void blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y);
    void sse_blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y);
    void save_to_file (const char* new_file_name);
    void set_transparency (uint8_t new_alpha);
    ~BMP_file ();

private:

    void inline fill_ARGB (unsigned int x, unsigned int y, uint8_t Red, uint8_t Green, uint8_t Blue, uint8_t Alpha);
};


void BMP_file::load_file (const char* file_name)
{
    FILE* f = NULL;
    
    try 
    {
        f = fopen (file_name, "rb");
        if (!f)
            throw "No such file in the folder!\n";

        this->file_name = new char [strlen (file_name)];
        sprintf (this->file_name, file_name);

        int fine = 0;

// Bitmap file header:

        fine = fread (&bfType, sizeof (bfType), 1, f);
        if (bfType != 0x424D && bfType != 0x4D42)
            throw "Type is wrong. Check out: it should be BMP-file!";

        fine = fread (&bfSize, sizeof (bfSize), 1, f);

        fine = fread (&bfReserved, sizeof (bfReserved), 1, f);
        if (bfReserved)
            throw "Error! The file is damaged! The reserved bytes should contain only zero!";

        fine = fread (&bfOffBits, sizeof (bfOffBits), 1, f);

// Bitmap info:

        fine = fread (&bcSize, sizeof (bcSize), 1, f);

        char ver_size = 4;
        if (this->bcSize == 12)
            ver_size = 2;

        fine = fread (&bcWidth, ver_size, 1, f);

        fine = fread (&bcHeight, ver_size, 1, f);
       
        fine = fread (&bcPlanes, sizeof (bcPlanes), 1, f);
        if (!bcPlanes)
            throw "Expected '1' in bcPlanes in BMP picture!";

        fine = fread (&bcBitCount, sizeof (bcBitCount), 1, f);
        if (bcBitCount != 32)
            throw "Sorry! I know only 32-bit format!";

        if (bcSize > 12)
        {
            fine = fread (&biCompression, sizeof (biCompression), 1, f);
            fine = fread (&biSizeImage, sizeof (biSizeImage), 1, f);
            fine = fread (&biXPelsPerMeter, sizeof (biXPelsPerMeter), 1, f);
            fine = fread (&biYPelsPerMeter, sizeof (biYPelsPerMeter), 1, f);
            fine = fread (&biClrUsed, sizeof (biClrUsed), 1, f);
            fine = fread (&biClrImportant, sizeof (biClrImportant), 1, f);
        }

        if (bcSize >= 108)
        {
            fine = fread (&bV4RedMask, sizeof (bV4RedMask), 1, f);
            fine = fread (&bV4GreenMask, sizeof (bV4GreenMask), 1, f);
            fine = fread (&bV4BlueMask, sizeof (bV4BlueMask), 1, f);
            fine = fread (&bV4AlphaMask, sizeof (bV4AlphaMask), 1, f);

            fine = fread (&bV4CSType, sizeof (bV4CSType), 1, f);

            for (int i = 0; i < 9; ++i)
                fine = fread (&bV4Endpoints[i], sizeof (bV4Endpoints[i]), 1, f);

            fine = fread (&bV4GammaRed, sizeof (bV4GammaRed), 1, f);
            fine = fread (&bV4GammaGreen, sizeof (bV4GammaGreen), 1, f);
            fine = fread (&bV4GammaBlue, sizeof (bV4GammaBlue), 1, f);
        }

        if (bcSize == 124)
        {
            fine = fread (&bV5Intent, sizeof (bV5Intent), 1, f);
            fine = fread (&bV5ProfileData, sizeof (bV5ProfileData), 1, f);
            fine = fread (&bV5ProfileSize, sizeof (bV5ProfileSize), 1, f);
            fine = fread (&bV5Reserved, sizeof (bV5Reserved), 1, f);
            if (bV5Reserved)
                throw "The file is damaged! The field bV5Reserved should be equal 0!";
        }

        fseek (f, bfOffBits, SEEK_SET);

        pixel_number = abs (bcWidth * bcHeight);
        bytes_in_pixel = bcBitCount / 8;

        data = new pixel [pixel_number];

        uint8_t alpha = 0;

        for (int i = 0; i < pixel_number; i += 1)
        {   
            fine = fread (&data[i], 1, 4, f);

            alpha = data[i].alpha;

            for (int j = 0; j < bytes_in_pixel - 1; ++j)
            {
                data [i].red = ((data [i].red + 1) * alpha) >> 8;
                data [i].green = ((data [i].green + 1) * alpha) >> 8;
                data [i].blue = ((data [i].blue + 1) * alpha) >> 8;
            }
        }

        fclose (f);

    }

    catch (const char* str)
    {
        printf ("Warning! %s\n", str);
        fclose (f);
        return;
    }
}

void BMP_file :: draw (void)
{
    static int file_counter = 0;

    sf::RenderWindow window(sf::VideoMode(abs (bcWidth), abs (bcHeight), bcBitCount), file_name);
    sf::Image image;
    image.create (abs (bcWidth), abs (bcHeight), sf::Color (0, 0, 0));
    sf::Sprite sprite;
    sf::Texture texture;

    unsigned int counter = 0;
    char delta = 1;

    if (bcHeight > 0)
    {
        counter = abs (bcWidth * bcHeight) - 1;
        delta = -1;
    }   

    for (int y = 0; y < abs (bcHeight); ++y)
    {
        for (int x = 0; x < abs (bcWidth); ++x)
            {
                image.setPixel (x, y, sf::Color (data [counter].red, data [counter].green, data [counter].blue, 255));
                counter += delta;
            }
    }

    char file_write [20] = {};
    sprintf (file_write, "result_%d.bmp", file_counter);
    
    image.saveToFile (file_write);

    texture.loadFromImage (image);
    sprite.setTexture (texture, 1);

    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
                window.close();
        }

        window.draw (sprite);
        window.display();
    }
}

void inline BMP_file :: fill_ARGB (unsigned int x, unsigned int y, uint8_t Red, uint8_t Green, uint8_t Blue, uint8_t Alpha)
{
    if (x > abs (bcWidth) || x < 0 || y > abs (bcHeight) || y < 0)
    {
        printf ("Error! Wrong coordinates in 'fill_ARGB'!\n");
        return;
    }

    unsigned int coordinate = x + y * abs (bcWidth);

    this->data [coordinate].blue = Blue;
    this->data [coordinate].green = Green;
    this->data [coordinate].red = Red;
    this->data [coordinate].alpha = Alpha;

    return;
}

void BMP_file :: blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y)
{

    unsigned int pos_f = 0;
    unsigned int pos_b = 0; 

    pixel& pixel_up = data[0];
    pixel& pixel_down = data[0];

    for (unsigned int y = 0; y < abs (bcHeight); ++y)
    {
        for (unsigned int x = 0; x < abs (bcWidth); ++x)
        {   
            if ((x >= pos_x) && (x < pos_x + abs (upper.bcWidth)) && (y >= pos_y) && (y < pos_y + abs (upper.bcHeight)))
            {
                pos_f = x - pos_x + (y - pos_y) * upper.bcWidth;
                pos_b = x + y * bcWidth;

                pixel_up = upper.data [pos_f];
                
                uint8_t right = (0xFF - upper.data [pos_f].alpha);
                uint8_t left = upper.data [pos_f].alpha;
                data [pos_b].alpha = left + data [pos_b].alpha * right;

                if (!data [pos_b].alpha)
                {
                    this->fill_ARGB (x, y, 0, 0, 0, 0);
                    return;
                }

                data [pos_b].red = upper.data [pos_f].red + ((data [pos_b].red * right + 1) >> 8);
                data [pos_b].green = upper.data [pos_f].green + ((data [pos_b].green * right + 1) >> 8);
                data [pos_b].blue = upper.data [pos_f].blue + ((data [pos_b].blue * right + 1) >> 8);
            }
        }
    }
}

inline volatile uint8_t get_alpha (uint32_t pixel)
{
    return (pixel & 0xFF000000) >> 24;
}

void BMP_file :: sse_blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y)
{

    __m128i mask_shuffle_low = _mm_setr_epi8 (128, 0, 128, 1, 128, 2, 128, 3, 128, 4, 128, 5, 128, 6, 128, 7);
    __m128i mask_shuffle_high = _mm_setr_epi8 (128, 8, 128, 9, 128, 10, 128, 11, 128, 12, 128, 13, 128, 14, 128, 15);
    __m128i mask_shuffle_back_low = _mm_setr_epi8 (1, 3, 5, 7, 9, 11, 13, 15, 128, 128, 128, 128, 128, 128, 128, 128);
    __m128i mask_shuffle_back_high = _mm_setr_epi8 (128, 128, 128, 128, 128, 128, 128, 128, 1, 3, 5, 7, 9, 11, 13, 15);
    __m128i mask_add_one = _mm_setr_epi8 (0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1);


    __m128i src_pixels  = {};
    __m128i dst_pixels = {};
    __m128i res_shuffle_low  = {};
    __m128i res_shuffle_high = {};

    __m128i res_shuffle_src_low  = {};
    __m128i res_shuffle_src_high = {};


    __m128i alpha_src_low  = {};
    __m128i alpha_src_high = {};


    __m128i res_mul_low  = {};
    __m128i res_mul_high = {};


    __uint8_t alpha_array [4] = {};


    __m128i alpha_array_src = {};
    __m128i alpha_array_src_upd = {};
    __m128i alpha_array_dst = {};

    __m128i result_low  = {};
    __m128i result_high = {};

    __uint16_t x = -4;
    __uint16_t y = 0;

    __uint16_t src_right_x = pos_x + abs (upper.bcWidth);
    __uint16_t src_down_y  = pos_y + abs (upper.bcHeight);
    __uint64_t src_i       = 0;

    uint32_t i = 0;


    for (unsigned int y = 0; y < abs (bcHeight); ++y)
    {
        for (unsigned int x = 0; x + 4 < abs (bcWidth); x += 4)
        {
            if ((x >= pos_x) && (x + 4 < pos_x + abs (upper.bcWidth)) && (y >= pos_y) && (y < pos_y + abs (upper.bcHeight)))
            {


                src_i = x - pos_x + (y - pos_y) * upper.bcWidth;
                i = x + y * bcWidth;


                dst_pixels = _mm_setr_epi32 (data[i], data[i + 1], data[i + 2], data[i + 3]);                                   // Stores pixels in a 128-bits register.
                src_pixels =  _mm_setr_epi32 (upper.data[src_i], upper.data[src_i + 1], upper.data[src_i + 2], upper.data[src_i + 3]); 


                res_shuffle_low  = _mm_shuffle_epi8 (dst_pixels, mask_shuffle_low);
                res_shuffle_high = _mm_shuffle_epi8 (dst_pixels, mask_shuffle_high);


                res_shuffle_src_low  = _mm_shuffle_epi8 (src_pixels, mask_shuffle_low);
                res_shuffle_src_high = _mm_shuffle_epi8 (src_pixels, mask_shuffle_high);


                for (int j = 0; j < 4; ++j)
                    alpha_array [j] = 255 - get_alpha (upper.data [src_i + j]);

            
                alpha_src_low  = _mm_setr_epi8 (0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [1], 0, alpha_array [1], 0, alpha_array [1], 0, alpha_array [1]);
                alpha_src_high = _mm_setr_epi8 (0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [3], 0, alpha_array [3], 0, alpha_array [3], 0, alpha_array [3]);


                res_mul_low  = _mm_mulhi_epu16 (res_shuffle_low, alpha_src_low);
                res_mul_high = _mm_mulhi_epu16 (res_shuffle_high, alpha_src_high);


                res_mul_low  = _mm_add_epi64 (res_mul_low, mask_add_one);
                res_mul_high = _mm_add_epi64 (res_mul_high, mask_add_one);


                res_shuffle_low  = _mm_add_epi64 (res_mul_low, res_shuffle_src_low);
                res_shuffle_high = _mm_add_epi64 (res_mul_high, res_shuffle_src_high);


                result_low  = _mm_shuffle_epi8 (res_shuffle_low, mask_shuffle_back_low);
                result_high = _mm_shuffle_epi8 (res_shuffle_high, mask_shuffle_back_high);
                result_low  |= result_high;


                _mm_storeu_si128 ((__m128i*)(&data[i]), result_low);
            }
        }
    }

}

void BMP_file :: set_transparency (uint8_t new_alpha)
{
    for (unsigned int i = 0; i < pixel_number; ++i)
    {
        if (data[i].alpha == 0)
            continue;

        data[i].blue = (((data[i].blue << 8) / data[i].alpha + 1)* new_alpha) >> 8;
        data[i].red = (((data[i].red << 8) / data[i].alpha + 1)* new_alpha) >> 8;
        data[i].green = (((data[i].green << 8) / data[i].alpha + 1) * new_alpha) >> 8;
        data[i].alpha = new_alpha;
    }
}

/*
void BMP_file :: save_to_file (const char* new_file_name)
{
    char* file = (char*)(this + 10);
    FILE* f = fopen (new_file_name, "wb");

    uint64_t size = bcWidth * bcHeight;

    for (int i = 0; i < bfOffBits; ++i)
        fprintf (f, "%c", *(file++));
printf ("OKKK\n");
    file = (char*)(this + bfOffBits);
printf ("size %u, %u\n", size, this->pixel_number);
    for (uint64_t i = 0; i < pixel_number; ++i)
    {
        fprintf (f, "%u", data[i]);
        //printf ("%d\n", i);
    }

    fclose (f);
}
*/

BMP_file :: ~BMP_file ()
{
    delete [] data;
}
