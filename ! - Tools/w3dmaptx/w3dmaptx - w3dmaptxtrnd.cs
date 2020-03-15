using System;
using System.IO;

/*************************************************************************
 * 
 * W3DMAPTX
 * 
 * This program will randomly mix the wall patterns on stone walls in
 * a Wolf3D level.  Feel free to modify and recompile this program if
 * you want to.  See "readme.txt" for information on how to use the
 * program.
 * 
 * **********************************************************************/

namespace w3dmaptx
{
	/// <summary>
	/// Summary description for w3dmaptxtrnd
	/// </summary>
	class w3dmaptxrnd
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
            ttype[] ttypes; // This structure holds the texdef data

            ushort[,] mdata = new ushort[64, 64]; // Map plane
            ushort[,] odata = new ushort[64, 64]; // Object plane
            BinaryReader br;
            BinaryWriter bw;
            StreamReader sr;
            Random Rnd = new Random(); // Create and initialize random number generator

            int ct;

            Console.Write("W3DMAPTX\n\nSee \"readme.txt\" for instructions on how 
to use this program.\n\nEnter texdef file extension: ");
            try
            {
                sr = new StreamReader(File.Open("texdef." + Console.ReadLine(), FileMode.Open));

            }
#pragma warning disable 168
            catch (FileNotFoundException e)
            {
                Console.Write("\nError: txtdef file not found.\n\nPress any key to 
continue...");
                Console.ReadKey();
                return;
            }
#pragma warning restore 168
            try
            {
                ttypes = new ttype[int.Parse(sr.ReadLine())];
                for (int p = 0; p < ttypes.Length; p++)
                {
                    ttypes[p].name = sr.ReadLine();
                    ttypes[p].textures = new ushort[int.Parse(sr.ReadLine())];
                    for (int p2 = 0; p2 < ttypes[p].textures.Length; p2++)
                        ttypes[p].textures[p2] = (ushort)HexToInt(sr.ReadLine().ToCharArray());

                }
                sr.Close();
            }
#pragma warning disable 168
            catch (Exception e)
            {
                Console.Write("\nError loading data from txtdef file.\n\nPress any 
key to continue...");
                Console.ReadKey();
                return;
            }
#pragma warning restore 168

            try
            {
                br = new BinaryReader(File.Open("w3dmap.map", FileMode.Open));
            }
#pragma warning disable 168
            catch (FileNotFoundException e) {
                Console.Write("\nError: file \"w3dmap.map\" not found\n\nPress any 
key to continue...");
                Console.ReadKey();
                return;
            }
#pragma warning restore 168
            try {
                for (int x = 0; x < 64; x++)
                    for (int y = 0; y < 64; y++)
                        mdata[x, y] = br.ReadUInt16();

                for (int x = 0; x < 64; x++)
                    for (int y = 0; y < 64; y++)
                        odata[x, y] = br.ReadUInt16();
            }
#pragma warning disable 168
            catch (Exception e)
            {
                Console.Write("\nError loading data from map file\n\nPress any key 
to continue...");
                Console.ReadKey();
                return;
            }
#pragma warning restore 168

            br.Close();

            for (int x = 0; x < 64; x++)
            {
                for (int y = 0; y < 64; y++)
                {
                    ct = -1;

                    for (int p = 0; p < ttypes.Length; p++)
                    {
                        for (int p2 = 0; p2 < ttypes[p].textures.Length; p2++)
                        {
                            if (mdata[x, y] == ttypes[p].textures[p2]) ct = p;
                        }
                    }

                    if (ct != -1)
                        mdata[x, y] = ttypes[ct].textures[Rnd.Next(ttypes[ct].textures.Length)];

                }
            }

            bw = new BinaryWriter(File.Open("w3dmap.map", FileMode.Open));
            for (int x = 0; x < 64; x++)
                for (int y = 0; y < 64; y++)
                    bw.Write(mdata[x, y]);

            for (int x = 0; x < 64; x++)
                for (int y = 0; y < 64; y++)
                    bw.Write(odata[x, y]);

            bw.Close();

            Console.Write("\nComplete -- press any key to continue");
            Console.ReadKey();
		}

        // HexToInt -- converts a text representation of a hexadecimal number
        // to a 32-bit integer
        public static int HexToInt(char[] hex)
        {
            int hint = 0;

            for (int p = 0; p < hex.Length; p++) {
                switch (hex[p]) {
                    case '0':
                        hint <<= 4;
                        break;
                    case '1':
                        hint = (hint << 4) + 0x1;
                        break;
                    case '2':
                        hint = (hint << 4) + 0x2;
                        break;
                    case '3':
                        hint = (hint << 4) + 0x3;
                        break;
                    case '4':
                        hint = (hint << 4) + 0x4;
                        break;
                    case '5':
                        hint = (hint << 4) + 0x5;
                        break;
                    case '6':
                        hint = (hint << 4) + 0x6;
                        break;
                    case '7':
                        hint = (hint << 4) + 0x7;
                        break;
                    case '8':
                        hint = (hint << 4) + 0x8;
                        break;
                    case '9':
                        hint = (hint << 4) + 0x9;
                        break;
                    case 'a':
                    case 'A':
                        hint = (hint << 4) + 0xa;
                        break;
                    case 'b':
                    case 'B':
                        hint = (hint << 4) + 0xb;
                        break;
                    case 'c':
                    case 'C':
                        hint = (hint << 4) + 0xc;
                        break;
                    case 'd':
                    case 'D':
                        hint = (hint << 4) + 0xd;
                        break;
                    case 'e':
                    case 'E':
                        hint = (hint << 4) + 0xe;
                        break;
                    case 'f':
                    case 'F':
                        hint = (hint << 4) + 0xf;
                        break;
                }
            }

            return hint;
        }
    }

    public struct ttype // Structure for texdef data
    {
        public string name;
        public ushort[] textures;
    }
}
