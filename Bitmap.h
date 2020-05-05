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

struct BMP_file
{
private:
//Bitmap file header:

    unsigned short bfType = 0x424D;             // Type of the file. 424D or 4D42 is expected for BMP-file.
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

    uint8_t** data = NULL;                      // Array of pixels.
    char* file_name = NULL;                     // Name of the picture.

public:

    void load_file (const char* file_name);     // This function loads BMP-file to the program with all its attributes.
    void draw (void);
    void blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y);
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

        data = new uint8_t* [pixel_number];
        
        for (int i = 0; i < pixel_number; ++i)
            data[i] = new uint8_t [bytes_in_pixel];


        uint8_t alpha = 0;

        for (int i = 0; i < pixel_number; ++i)
        {   
            for (int j = 0; j < bytes_in_pixel; ++j)
                fine = fread (&data[i][j], 1, 1, f);

            alpha = (data [i][bytes_in_pixel - 1]);
            if (alpha != 0 && alpha != 255)
                printf ("I found it! %u\n", alpha);

            for (int j = 0; j < bytes_in_pixel - 1; ++j)
                data [i][j] = ((data [i][j] + 1) * alpha) >> 8;
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
                image.setPixel (x, y, sf::Color (data [counter][2], data [counter][1], data [counter][0], 255));
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
    if (x > bcWidth || x < 0 || y > abs (bcHeight) || y < 0)
    {
        printf ("Error! Wrong coordinates in 'fill_ARGB'!\n");
        return;
    }

    unsigned int coordinate = x + y * abs (bcWidth);

    this->data [coordinate][0] = Blue;
    this->data [coordinate][1] = Green;
    this->data [coordinate][2] = Red;
    this->data [coordinate][3] = Alpha;

    return;
}

void BMP_file :: blend_with (const BMP_file& upper, unsigned int pos_x, unsigned int pos_y)
{

    unsigned long long coordinate_f = 0;
    unsigned long long coordinate_b = 0; 

    for (unsigned int y = 0; y < abs (bcHeight); ++y)
    {
        for (unsigned int x = 0; x < abs (bcWidth); ++x)
        {   
            if ((x >= pos_x) && (x < pos_x + abs (upper.bcWidth)) && (y >= pos_y) && (y < pos_y + abs (upper.bcHeight)))
            {
                coordinate_f = x - pos_x + (y - pos_y) * upper.bcWidth;
                coordinate_b = x + y * bcWidth;
                
                uint8_t right = data [coordinate_b][3] * (0xFF - upper.data [coordinate_f][3]);
                uint8_t left = upper.data [coordinate_f][3];
                uint8_t res_alpha = left + right;

                if (!res_alpha)
                    this->fill_ARGB (x, y, 0, 0, 0, 0);

                for (int i = 0; i < 4; ++i)
                    data [coordinate_b][i] = (upper.data [coordinate_f][i] * left + data [coordinate_b][i] * right) / res_alpha;
            }
            else
            {

            }
        }
    }

}

BMP_file :: ~BMP_file ()
{

    unsigned int pixel_num = abs (bcWidth * bcHeight);
    for (int i = 0; i < pixel_num; ++i)
    {
        delete [] data[i];
    }
    delete [] data;
}