#ifndef stdio
#include <stdio.h>
#endif

#ifndef SFML/Window.hpp
#include <SFML/Window.hpp>
#endif

#ifndef SFML/Graphics.hpp
#include <SFML/Graphics.hpp>
#endif

#ifndef string.h
#include <string.h>
#endif

#ifndef emmintrin.h
#include <emmintrin.h>
#endif

#ifndef immintrin.h
#include <immintrin.h>
#endif

#ifndef timmintin.h
#include <tmmintrin.h>
#endif

enum Mask {Alpha = 0xFF000000, Red = 0x00FF0000, Green = 0x0000FF00, Blue = 0x000000FF};

class pixel
{
public:
    
    uint32_t* data_ptr = NULL;

    uint8_t* alpha (void)
    {
        return reinterpret_cast <uint8_t*> (data_ptr + 3 * 8);
    } 

    uint8_t* red (void)
    {
        return reinterpret_cast <uint8_t*> (data_ptr + 2 * 8);
    } 

    uint8_t* green (void)
    {
        return reinterpret_cast <uint8_t*> (data_ptr + 1 * 8);
    } 

    uint8_t* blue (void)
    {
        return reinterpret_cast <uint8_t*> (data_ptr + 0 * 8);
    } 

/*
    explicit pixel (uint32_t pixel) 
    {
        alpha = (pixel & Mask::Alpha) >> 24;
        red   = (pixel & Mask::Red)   >> 16;
        green = (pixel & Mask::Green) >> 8;
        blue  = (pixel & Mask::Blue);   
    }
*/

    pixel           (const pixel& pix) = delete;
    pixel operator= (const pixel& pix) = delete;

    operator uint32_t*()
    {
        return data_ptr;
    }

    pixel (void) {};
};

#pragma pack (push, 1)

struct BMP_file
{
private:

//Bitmap file header:

    struct file_header
    {
        uint16_t*     Type     = NULL;          // Type of the file. 424D or 4D42 is expected for a BMP-file.
        unsigned int* Size     = NULL;          // Size of the file in bytes.
        unsigned int* Reserved = NULL;          // Reserved DWORD. 0 is expected.
        unsigned int* Offbits  = NULL;          // as from the start of the file up to data segment.
    
    } header;


//tmap info

    struct file_info
    {

    // CORE

        unsigned int* Size       = NULL;            // Version of the BMP file: 12 (CORE), 40 (V.3), 108 (V.4), or 124 (V.5).
        int* Width               = NULL;            // Raster width.
        int* Height              = NULL;            // Raster height.
        unsigned short* Planes   = NULL;            // Used for cursor.
        unsigned short* BitCount = NULL;            // Number of bits per pixel.

    // Version 3

        unsigned int* Compression   = NULL;         // The way of bits storage.
        unsigned int* SizeImage     = NULL;         // The size of pixel data.
        unsigned int* XPelsPerMeter = NULL;         // The number of pixels per meter (horizontal).
        unsigned int* YPelsPerMeter = NULL;         // The number of pixels per meter (vertical).
        unsigned int* ClrUsed       = NULL;         // The size of the color table in cells.
        unsigned int* ClrImportant  = NULL;         // The number of cells in the color table.

    // Version 4

        unsigned int* RedMask       = NULL;         // Bit mask to extract red channel.
        unsigned int* GreenMask     = NULL;         // Bit mask to extract red channel.
        unsigned int* BlueMask      = NULL;         // Bit mask to extract red channel.
        unsigned int* AlphaMask     = NULL;         // Bit mask to extract red channel.
        unsigned int* CSType        = NULL;         // Color Space Type.

        unsigned int* Endpoints     = NULL;         // These four fields are taken into account
        unsigned int* GammaRed      = NULL;         // only if CSType is not equal zero.
        unsigned int* GammaGreen    = NULL;         //
        unsigned int* GammaBlue     = NULL;         //

    // Version 5

        unsigned int* Intent        = NULL;         // Intent of raster rendering.
        unsigned int* ProfileData   = NULL;         // Bias till Profile Data.
        unsigned int* ProfileSize   = NULL;         // Profile size, if it is included.
        unsigned int* Reserved      = NULL;         // This field is reserved and should be equal 0.

    } info;

        unsigned int pixel_number = 0;              // Number of pixels in the raster.
        unsigned int bytes_in_pixel = 0;            // Number of bytes in a pixel.


        pixel* data = NULL;                         // Array of pixels.
        char* file_name = NULL;                     // Name of the picture.
        uint8_t* file_signature = NULL;               
    

public:

    BMP_file operator= (const BMP_file& file) = delete;
    BMP_file operator= (const char* file_name) { load_file (file_name);}

    void load_file (const char* file_name);             // This function loads BMP-file to the program with all its attributes.
    void load_file_upd (const char* file_name);
    void draw (void);
    void blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y);
    void sse_blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y);
    void asm_blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y);
    void save_to_file (const char* new_file_name);
    void set_transparency (uint8_t new_alpha);
    
    ~BMP_file ();

private:

    void inline fill_ARGB (unsigned int x, unsigned int y, uint8_t Red, uint8_t Green, uint8_t Blue, uint8_t Alpha);
};

#pragma pack (pop)


void BMP_file::load_file_upd (const char* file_name)
{
    FILE* f = NULL;

    try
    {
        f = fopen (file_name, "rb");
        if (!f)
            throw "No such file in the folder!\n";

        const int header_size = 14;

        uint8_t* temp_buf = new uint8_t [header_size];
        fread (temp_buf, header_size, 1, f);

        unsigned long long file_size = *reinterpret_cast <unsigned long long*> (temp_buf + 2);
        uint32_t offset = *reinterpret_cast <uint32_t*> (temp_buf + 10);
        delete [] temp_buf;
        fseek (f, 0, SEEK_SET);
        
        file_signature = new uint8_t [file_size + 16];
        file_signature += (16 - (uint64_t)(file_signature + offset) % 16) % 16;
        fread (file_signature, file_size, 1, f);


        this->file_name = new char [strlen (file_name)];
        sprintf (this->file_name, file_name);

        uint8_t* cur_pos = file_signature;

// Bitmap file header:

        header.Type = reinterpret_cast <uint16_t*> (cur_pos);
        if (*header.Type != 0x424D && *header.Type != 0x4D42)
            throw "Type is wrong. Check out: it should be a BMP-file!";

        cur_pos += sizeof (uint16_t);

        header.Size = reinterpret_cast <unsigned int*> (cur_pos);
        cur_pos += sizeof (unsigned int);  


        header.Reserved = reinterpret_cast <unsigned int*> (cur_pos);

        printf ("so %x\n", header.Reserved);
        cur_pos += sizeof (unsigned int);
        if (*header.Reserved)
            throw "Error! The file is damaged! The reserved bytes should contain only zero!";

        header.Offbits = reinterpret_cast <unsigned int*> (cur_pos);
        cur_pos += sizeof (*header.Offbits);
        printf ("so %u\n", header.Offbits);

//Bitmap info:

        info.Size = reinterpret_cast <unsigned int*> (cur_pos);
        cur_pos += sizeof (unsigned int);

        char ver_size = 4;
        if (*this->info.Size == 12)
            ver_size = 2;

        info.Width = reinterpret_cast <int*> (cur_pos);
        cur_pos += sizeof (int);

        info.Height = reinterpret_cast <int*> (cur_pos);
        cur_pos += sizeof (int);
       
        info.Planes = reinterpret_cast <unsigned short*> (cur_pos);
        cur_pos += sizeof (unsigned short);

        if (!info.Planes)
            throw "Expected '1' in Planes in BMP picture!";

        info.BitCount = reinterpret_cast <unsigned short*> (cur_pos);
        cur_pos += sizeof (unsigned short);
        printf ("bit count %u\n", *info.Width);
        if (*info.BitCount != 32)
            throw "Sorry! I know only 32-bit format! Others are not implemented yet! :(";

        if (*info.Size > 12)
        {
            info.Compression = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.SizeImage = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.XPelsPerMeter = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.YPelsPerMeter = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.ClrUsed = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.ClrImportant = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
        }

        if (*info.Size >= 108)
        {
            info.RedMask = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.GreenMask = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.BlueMask = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.AlphaMask = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);

            info.CSType = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);

            info.Endpoints = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int) * 9;

            info.GammaRed = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.GammaGreen = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.GammaBlue = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
        }

        if (*info.Size == 124)
        {
            info.Intent = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.ProfileData = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.ProfileSize = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            info.Reserved = reinterpret_cast <unsigned int*> (cur_pos);
            cur_pos += sizeof (unsigned int);
            
            if (info.Reserved)
                throw "The file is damaged! The field Reserved should be equal 0!";
        }

        if (cur_pos != file_signature + *header.Offbits)
            throw "Error! Wrond pointer to data!";

        pixel_number = abs (*info.Width * *info.Height);
        bytes_in_pixel = *info.BitCount / 8;

        data = reinterpret_cast <pixel*> (cur_pos);

        uint8_t alpha = 0;

        for (int i = 0; i < pixel_number; i += 1)
        { 
            alpha = *data[i].alpha();

            for (int j = 0; j < bytes_in_pixel - 1; ++j)
            {
                *data [i].red()   = ((*data [i].red() + 1) * alpha) >> 8;
                *data [i].green() = ((*data [i].green() + 1) * alpha) >> 8;
                *data [i].blue()  = ((*data [i].blue() + 1) * alpha) >> 8;
            }
        }

        fclose (f);


    }
    catch (const char* exception)
    {
        printf ("Error while loading \"%s\"! %s\n\n", file_name, exception);
    }
    

    fclose (f);
}


void BMP_file :: draw (void)
{
    static int file_counter = 0;

    sf::RenderWindow window(sf::VideoMode(abs (*info.Width), abs (*info.Height), *info.BitCount), file_name);
    sf::Image image;
    image.create (abs (*info.Width), abs (*info.Height), sf::Color (0, 0, 0));
    sf::Sprite sprite;
    sf::Texture texture;

    unsigned int counter = 0;
    char delta = 1;

    if (*info.Height > 0)
    {
        counter = abs (*info.Width * *info.Height) - 1;
        delta = -1;
    }   

    for (int y = 0; y < abs (*info.Height); ++y)
    {
        for (int x = 0; x < abs (*info.Width); ++x)
            {
                image.setPixel (x, y, sf::Color (*data [counter].red(), *data [counter].green(), *data [counter].blue(), 255));
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
    if (x > abs (*info.Width) || x < 0 || y > abs (*info.Height) || y < 0)
    {
        printf ("Error! Wrong coordinates in 'fill_ARGB'!\n");
        return;
    }

    unsigned int coordinate = x + y * abs (*info.Width);

    *this->data [coordinate].blue()  = Blue;
    *this->data [coordinate].green() = Green;
    *this->data [coordinate].red()   = Red;
    *this->data [coordinate].alpha() = Alpha;

    return;
}

void BMP_file :: blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y)
{

    unsigned int pos_f = 0;
    unsigned int pos_b = 0; 


    for (unsigned int y = 0; y < abs (*info.Height); ++y)
    {
        for (unsigned int x = 0; x < abs (*info.Width); ++x)
        {   
            if ((x >= pos_x) && (x < pos_x + abs (*upper.info.Width)) && (y >= pos_y) && (y < pos_y + abs (*upper.info.Height)))
            {
                pos_f = x - pos_x + (y - pos_y) * *upper.info.Width;
                pos_b = x + y * *info.Width;
                
                uint8_t right = (0xFF - *upper.data [pos_f].alpha());
                uint8_t left = *upper.data [pos_f].alpha();
                *data [pos_b].alpha() = left + *data [pos_b].alpha() * right;

                if (!*data [pos_b].alpha())
                {
                    this->fill_ARGB (x, y, 0, 0, 0, 0);
                    return;
                }

                *data [pos_b].red()   = *upper.data [pos_f].red()   + ((*data [pos_b].red()   * right + 1) >> 8);
                *data [pos_b].green() = *upper.data [pos_f].green() + ((*data [pos_b].green() * right + 1) >> 8);
                *data [pos_b].blue()  = *upper.data [pos_f].blue()  + ((*data [pos_b].blue()  * right + 1) >> 8);
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

#define NL 128
                                                //   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
    __m128i mask_shuffle_low       = _mm_setr_epi8 (NL,  0, NL,  1, NL,  2, NL,  3, NL,  4, NL,  5, NL,  6, NL,  7);
    __m128i mask_shuffle_high      = _mm_setr_epi8 (NL,  8, NL,  9, NL, 10, NL, 11, NL, 12, NL, 13, NL, 14, NL, 15);
    __m128i mask_shuffle_back_low  = _mm_setr_epi8 ( 1,  3,  5,  7,  9, 11, 13, 15, NL, NL, NL, NL, NL, NL, NL, NL);
    __m128i mask_shuffle_back_high = _mm_setr_epi8 (NL, NL, NL, NL, NL, NL, NL, NL,  1,  3,  5,  7,  9, 11, 13, 15);
    __m128i mask_add_one           = _mm_setr_epi8 ( 0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1);

    __uint8_t alpha_array [4] = {};

    __uint16_t x = -4;
    __uint16_t y = 0;

    __uint32_t src_right_x = pos_x + abs (*upper.info.Width);
    __uint32_t src_down_y  = pos_y + abs (*upper.info.Height);
    __uint64_t src_i       = 0;

    uint32_t i = 0;


    for (unsigned int y = 0; y < abs (*info.Height); ++y)
    {
        for (unsigned int x = 0; x + 4 < abs (*info.Width); x += 4)
        {
            if ((x >= pos_x) && (x + 4 < src_right_x) && (y >= pos_y) && (y < src_down_y))
            {

                src_i = x - pos_x + (y - pos_y) * *upper.info.Width;


                __m128i dst_pixels = _mm_setr_epi32 (*data[i], *data[i + 1], *data[i + 2], *data[i + 3]);                                   // Stores pixels in a 128-ts register.
                __m128i src_pixels =  _mm_setr_epi32 (*upper.data[src_i], *upper.data[src_i + 1], *upper.data[src_i + 2], *upper.data[src_i + 3]); 


                __m128i res_shuffle_low  = _mm_shuffle_epi8 (dst_pixels, mask_shuffle_low);
                __m128i res_shuffle_high = _mm_shuffle_epi8 (dst_pixels, mask_shuffle_high);


                __m128i res_shuffle_src_low  = _mm_shuffle_epi8 (src_pixels, mask_shuffle_low);
                __m128i res_shuffle_src_high = _mm_shuffle_epi8 (src_pixels, mask_shuffle_high);


                for (int j = 0; j < 4; ++j)
                    alpha_array [j] = 255 - get_alpha (*upper.data [src_i + j]);

            
                dst_pixels  = _mm_setr_epi8 (0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [1], 0, alpha_array [1], 0, alpha_array [1], 0, alpha_array [1]);
                src_pixels  = _mm_setr_epi8 (0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [3], 0, alpha_array [3], 0, alpha_array [3], 0, alpha_array [3]);


                res_shuffle_low  = _mm_mulhi_epu16 (res_shuffle_low, dst_pixels);
                res_shuffle_high = _mm_mulhi_epu16 (res_shuffle_high, src_pixels);


                res_shuffle_low  = _mm_add_epi64 (res_shuffle_low, mask_add_one);
                res_shuffle_high = _mm_add_epi64 (res_shuffle_high, mask_add_one);


                res_shuffle_low  = _mm_add_epi64 (res_shuffle_low, res_shuffle_src_low);
                res_shuffle_high = _mm_add_epi64 (res_shuffle_high, res_shuffle_src_high);


                res_shuffle_low  = _mm_shuffle_epi8 (res_shuffle_low, mask_shuffle_back_low);
                res_shuffle_high = _mm_shuffle_epi8 (res_shuffle_high, mask_shuffle_back_high);
                res_shuffle_low |= res_shuffle_high;


                _mm_storeu_si128 ((__m128i*)(&data[i]), res_shuffle_low);
            }

            i += 4;
        }
        ++i;
    }
}
/*
void BMP_file :: asm_blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y)
{

    uint8_t masks [5][16] = 
    {
        {128, 0, 128, 1, 128, 2, 128, 3, 128, 4, 128, 5, 128, 6, 128, 7},           //mask_shuffle_low
        {128, 8, 128, 9, 128, 10, 128, 11, 128, 12, 128, 13, 128, 14, 128, 15},     //mask_shuffle_hgh
        {1, 3, 5, 7, 9, 11, 13, 15, 128, 128, 128, 128, 128, 128, 128, 128},        //mask_shuffle_back_low
        {128, 128, 128, 128, 128, 128, 128, 128, 1, 3, 5, 7, 9, 11, 13, 15},        //mask_shuffle_back_high
        {27, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1}                           //mask_add_one
    };
    

    uint8_t result    = 0;
    uint32_t src_data = 0;
    uint32_t dst_data = 0;

        __asm__ volatile (   
                ".intel_syntax noprefix \n\t"
                
                ".loop:                 \n\t"
                "mov bl, [rsi]          \n\t"
                "cmp bl, 0              \n\t"
                "je .End                \n\t"
                "inc rsi                \n\t"
                "inc eax                \n\t"
                "jmp .loop              \n\t"
                ".End:                  \n\t"
                "mov rax, [%[mask]]     \n\t"

                ".att_syntax prefix     \n\t"
                : "=a" (result)
                : [mask] "rbx" (&masks), "a" (result)
                : 
    );

    printf ("res %d\n", result);

    __m128i src_pixels  = {};               //xmm0
    __m128i dst_pixels = {};
    __m128i res_shuffle_low  = {};
    __m128i res_shuffle_high = {};

    __m128i res_shuffle_src_low  = {};
    __m128i res_shuffle_src_high = {};

    __uint8_t alpha_array [4] = {};

    __uint16_t x = -4;
    __uint16_t y = 0;

    __uint32_t src_right_x = pos_x + abs (upper.info.Width);
    __uint32_t src_down_y  = pos_y + abs (upper.info.Height);
    __uint64_t src_i       = 0;

    uint32_t i = 0;
*/
/*
    for (unsigned int y = 0; y < abs (Height); ++y)
    {
        for (unsigned int x = 0; x + 4 < abs (Width); x += 4)
        {
            if ((x >= pos_x) && (x + 4 < src_right_x) && (y >= pos_y) && (y < src_down_y))
            {

                src_i = x - pos_x + (y - pos_y) * upper.Width;


                dst_pixels = _mm_setr_epi32 (data[i], data[i + 1], data[i + 2], data[i + 3]);                                   // Stores pixels in a 128-ts register.
                src_pixels =  _mm_setr_epi32 (upper.data[src_i], upper.data[src_i + 1], upper.data[src_i + 2], upper.data[src_i + 3]); 


                res_shuffle_low  = _mm_shuffle_epi8 (dst_pixels, mask_shuffle_low);
                res_shuffle_high = _mm_shuffle_epi8 (dst_pixels, mask_shuffle_high);


                res_shuffle_src_low  = _mm_shuffle_epi8 (src_pixels, mask_shuffle_low);
                res_shuffle_src_high = _mm_shuffle_epi8 (src_pixels, mask_shuffle_high);


                for (int j = 0; j < 4; ++j)
                    alpha_array [j] = 255 - get_alpha (upper.data [src_i + j]);

            
                dst_pixels  = _mm_setr_epi8 (0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [0], 0, alpha_array [1], 0, alpha_array [1], 0, alpha_array [1], 0, alpha_array [1]);
                src_pixels  = _mm_setr_epi8 (0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [2], 0, alpha_array [3], 0, alpha_array [3], 0, alpha_array [3], 0, alpha_array [3]);


                res_shuffle_low  = _mm_mulhi_epu16 (res_shuffle_low, dst_pixels);
                res_shuffle_high = _mm_mulhi_epu16 (res_shuffle_high, src_pixels);


                res_shuffle_low  = _mm_add_epi64 (res_shuffle_low, mask_add_one);
                res_shuffle_high = _mm_add_epi64 (res_shuffle_high, mask_add_one);


                res_shuffle_low  = _mm_add_epi64 (res_shuffle_low, res_shuffle_src_low);
                res_shuffle_high = _mm_add_epi64 (res_shuffle_high, res_shuffle_src_high);


                res_shuffle_low  = _mm_shuffle_epi8 (res_shuffle_low, mask_shuffle_back_low);
                res_shuffle_high = _mm_shuffle_epi8 (res_shuffle_high, mask_shuffle_back_high);
                res_shuffle_low  |= res_shuffle_high;


                _mm_storeu_si128 ((__m128i*)(&data[i]), res_shuffle_low);
            }

            i += 4;
        }
        ++i;
    }*/
//}

void BMP_file :: set_transparency (uint8_t new_alpha)
{
    for (unsigned int i = 0; i < pixel_number; ++i)
    {
        if (*data[i].alpha() == 0)
            continue;

        *data[i].blue()  = (((*data[i].blue()  << 8) / *data[i].alpha() + 1)* new_alpha) >> 8;
        *data[i].red()   = (((*data[i].red()   << 8) / *data[i].alpha() + 1)* new_alpha) >> 8;
        *data[i].green() = (((*data[i].green() << 8) / *data[i].alpha() + 1) * new_alpha) >> 8;
        *data[i].alpha() = new_alpha;
    }
}

/*
void BMP_file :: save_to_file (const char* new_file_name)
{
    char* file = (char*)(this + 10);
    FILE* f = fopen (new_file_name, "wb");

    uint64_t size = Width * Height;

    for (int i = 0; i < Offts; ++i)
        fprintf (f, "%c", *(file++));
printf ("OKKK\n");
    file = (char*)(this + Offts);
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