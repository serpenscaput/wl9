/*

---------------------------------------------------------------------------
| MapData class                |    (c) Oct 1992 Sysma Automatisering     |
---------------------------------------------------------------------------
| Version 1.0         06/10/92 | First implementation.                    |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.05        11/10/92 | Removed all explicit references to far   |
|                              | pointers and changed the memory model to |
|                              | large.                                   |
|                              | J.P. Dijkstra, M.Sc.                     |
---------------------------------------------------------------------------
| A MapData is the smallest unit of information for the maze data of a    |
| map. It holds the actual memory block plus the size. The routines that  |
| are provided support the (re)allocation of the memory holding the data, |
| and contains the actual (de)compression logic for each format.          |
---------------------------------------------------------------------------

*/

#include "wolfmap.h"
#include "alloc.h"
#include "mem.h"

/*

---------------------------------------------------------------------------
| Public functions to implement the desired API.                          |
---------------------------------------------------------------------------
| Function name               | Description.                              |
---------------------------------------------------------------------------

*/

MapDataRec::MapDataRec ()
{
  //
  //   Default constructor, intializes the fields to zero.
  //
  BlockData = NULL;
  BlockSize = 0;
}

MapDataRec::MapDataRec (unsigned MemSize)
{
  //
  //   Constructor for initial allocation.
  //
  BlockData = (unsigned *) malloc (MemSize);
  BlockSize = BlockData != NULL ? MemSize : 0;
}

MapDataRec::~MapDataRec ()
{
  Free ();
}

int MapDataRec::Allocate (unsigned Size)
{
  //
  //   First free the current block if one is allocated.
  //
  if (BlockData != NULL) free (BlockData);

  //
  //   Now allocate the new block.
  //
  BlockData = (unsigned *) malloc (Size);
  BlockSize = BlockData != NULL ? Size : 0;

  return BlockData != NULL ? errOk : errNoMemory;
}

int MapDataRec::Resize (unsigned NewSize)
{
  //
  //   Change the size of the allocated block, if a block is present.
  //
  if (BlockData != NULL)
  {
    unsigned *NewBlock = (unsigned *) realloc (BlockData, NewSize);
    if (NewBlock != NULL)
    {
      //
      //   The resizing is successfull. Now set the fields to the new values.
      //
      BlockData = NewBlock;
      BlockSize = NewSize;

      return errOk;
    }

    //
    //   Reallocation failed, so return an error.
    //
    return errNoMemory;
  }

  //
  //   No block was allocated in the first place, so return an error.
  //
  return errNotAllocated;
}

int MapDataRec::Free ()
{
  //
  //   Free the allocated memory, if any. Return Ok to indicate success.
  //
  if (BlockData != NULL) free (BlockData);
  BlockData = NULL;
  BlockSize = 0;

  return errOk;
}

int MapDataRec::Copy (MapDataRec *Source)
{
  //
  //   Copy the allocated block from the source to this target, if a block
  //   is indeed allocated for the source.
  //
  if (Source->BlockData != NULL)
  {
    //
    //   If a block is still allocated for the target, deallocate it now.
    //
    int Error = Allocate (Source->BlockSize);

    if (Error == errOk)
    {
      memcpy (BlockData, Source->BlockData, Source->BlockSize);
      BlockSize = Source->BlockSize;
    }

    return Error;
  }

  //
  //   No source block was allocated, so return an error and leave the target
  //   block unchanged.
  //
  return errNotAllocated;
}

int MapDataRec::CompressFormat10 (unsigned MagicValue)
{
  //
  //   Calculate various sizes and allocate enough memory to write the
  //   compressed data into. In worst case, no compression can take place.
  //   In this case the size needed is the size of the old block plus 2 bytes
  //   to hold the decompressed size. This, therefore, is the size of the
  //   new block we will allocate.
  //
  unsigned *Source     = BlockData;
  unsigned  SourceSize = BlockSize >> 1;
  unsigned *NewBlock   = (unsigned *) malloc (BlockSize + 2);
  unsigned *Target     = NewBlock;
  unsigned  TargetSize = 0;

  //
  //   If the allocation failed, leave the compressed data unchanged and
  //   return the error code.
  //
  if (Target == NULL)
  {
    return errNoMemory;
  }

  //
  //   The allocation of the memory block was successful, so write the
  //   decompressed size (ie. the size of the source block) into the target
  //   memory block.
  //
  *(Target++) = BlockSize;
  TargetSize++;

  //
  //   Now compress the source block and write the compressed data into the
  //   target memory block.
  //
  while (SourceSize > 0)
  {
    //
    //   Try if the current word is the start of a secuence of equal values.
    //   The sequence must at least contain 4 words to be considered, since
    //   the compressed format of a sequence takes 3 words to store.
    //
    if (SourceSize > 3)
    {
      //
      //   Initialize scan pointers and a counter.
      //
      unsigned *SrcPtr     = Source;
      unsigned  FirstValue = *(SrcPtr++);
      unsigned  SrcSize    = SourceSize - 1;
      unsigned  Count      = 1;

      //
      //   Scan the remainder of the source block until a different value
      //   is found.
      //
      while (SrcSize > 0 && *SrcPtr == FirstValue)
      {
        SrcSize--;
        SrcPtr++;
        Count++;
      }

      //
      //   Write the source to the target.
      //
      if (Count > 3)
      {
        //
        //   A sequence of more than 3 equal words was found, so write the
        //   compressed format of this sequence to the target.
        //
        *(Target++) = MagicValue;
        *(Target++) = Count;
        *(Target++) = FirstValue;
        SourceSize  = SrcSize;
        Source      = SrcPtr;
        TargetSize += 3;
      }
      else
      {
        //
        //   A sequence of less than 4 equal words was found, so just copy
        //   this sequence to the target.
        //
        SourceSize -= Count;
        TargetSize += Count;
        while (Count-- > 0)
        {
          *(Target++) = *(Source++);
        }
      }
    }
    else
    {
      //
      //   At this point no relevant sequence of equal values could be found.
      //   So copy just one word and contiue.
      //
      *(Target++) = *(Source++);
      SourceSize--;
      TargetSize++;
    }
  }

  //
  //   The compression is complete. Now reallocate the target memory to the
  //   real, compressed size. If this isn't successfull, return false and
  //   retain the old, uncompressed memory block.
  //
  Target = (unsigned *) realloc (NewBlock, TargetSize << 1);
  if (Target == NULL)
  {
    free (NewBlock);
    return errMemoryCorrupted;
  }

  //
  //   The target block has been resized to the correct size, so free the
  //   old block and set the map structure to the new block and size.
  //
  free (BlockData);
  BlockData = Target;
  BlockSize = TargetSize << 1;

  return errOk;
}

int MapDataRec::CompressFormat11 ()
{
  //
  //   Calculate various sizes and allocate enough memory to write the
  //   compressed data into. In worst case, no compression can take place.
  //   In this case the size needed is the size of the old block plus 2 bytes
  //   to hold the decompressed size. This, therefore, is the size of the
  //   new block we will allocate.
  //
  unsigned *Source     = BlockData;
  unsigned  SourceSize = BlockSize >> 1;
  unsigned *NewBlock   = (unsigned *) malloc (BlockSize + 2);
  unsigned *Target     = NewBlock;
  unsigned  TargetSize = 0;

  //
  //   If the allocation failed, leave the compressed data unchanged and
  //   return the error code.
  //
  if (Target == NULL)
  {
    return errNoMemory;
  }

  //
  //   The allocation of the memory block was successful, so write the
  //   decompressed size (ie. the size of the source block) into the target
  //   memory block.
  //
  *(Target++) = BlockSize;
  TargetSize += 2;

  //
  //   Now compress the source block and write the compressed data into the
  //   target memory block.
  //
  //   For now we only copy the origional data uncompressed.
  //
  while (SourceSize-- > 0)
  {
    *(Target++) = *(Source++);
    TargetSize += 2;
  }

  //
  //   The compression is complete. Now reallocate the target memory to the
  //   real, compressed size. If this isn't successfull, return false and
  //   retain the old, uncompressed memory block.
  //
  Target = (unsigned *) realloc (NewBlock, TargetSize);
  if (Target == NULL)
  {
    free (NewBlock);
    return errMemoryCorrupted;
  }

  //
  //   The target block has been resized to the correct size, so free the
  //   old block and set the map structure to the new block and size.
  //
  free (BlockData);
  BlockData = Target;
  BlockSize = TargetSize;

  return errOk;
}

int MapDataRec::DecompressFormat10 (unsigned MagicValue)
{
  //
  //   Calculate various sizes and allocate enough memory to write the
  //   decompressed data into. Currently, the size of the decompressed data
  //   is stored as the first word in the compressed data stream, so that
  //   can be used.
  //
  unsigned *Source     = BlockData;
  unsigned  TargetSize = *(Source++);
  unsigned  SourceSize = (BlockSize >> 1) - 1;
  unsigned *NewBlock   = (unsigned *) malloc (TargetSize);
  unsigned *Target     = NewBlock;

  //
  //   If the allocation failed, leave the compressed data unchanged and
  //   return the error code.
  //
  if (Target == NULL)
  {
    return errNoMemory;
  }

  //
  //   The allocation of the memory block was successful, so decompress the
  //   source block into the target memory block.
  //
  while (SourceSize-- > 0)
  {
    unsigned Value = *(Source++);
    if (Value == MagicValue)
    {
      //
      //   The next word contains a count of words. It specifies the number
      //   of times the word following that count must be written into the
      //   target buffer.
      //
      unsigned Count = *(Source++);
      Value          = *(Source++);
      while (Count-- > 0)
      {
        *(Target++) = Value;
      }
      SourceSize -= 2;
    }
    else
    {
      *(Target++) = Value;
    }
  }

  //
  //   The decompression is complete. Now free the old memory block, set
  //   the map structure to the new block and size and return Ok.
  //
  free (BlockData);
  BlockData = NewBlock;
  BlockSize = TargetSize;

  return errOk;
}

int MapDataRec::DecompressFormat11 ()
{
  //
  //   Calculate various sizes and allocate enough memory to write the
  //   decompressed data into. Currently, the size of the decompressed data
  //   is stored as the first word in the compressed data stream, so that
  //   can be used.
  //
  unsigned *Source     = BlockData;
  unsigned  TargetSize = *(Source++);
  unsigned  WriteSize  = TargetSize >> 1;
  unsigned *NewBlock   = (unsigned *) malloc (TargetSize);
  unsigned *Target     = NewBlock;

  //
  //   If the allocation failed, leave the compressed data unchanged and
  //   return the error code.
  //
  if (Target == NULL)
  {
    return errNoMemory;
  }

  //
  //   The allocation of the memory block was successful, so decompress the
  //   source block into the target memory block.
  //
  while (WriteSize-- > 0)
  {
    unsigned Value = *(Source++);
    if (Value == 0xA700 || Value == 0xA800)
    {
      //
      //   The values A700 and A800 are special cases. The low byte must
      //   be replaced with the next byte in the source stream and the
      //   resulting word must be written to the target stream.
      //
      (char) Value =  *( ((char *) (Source))++ );
      *(Target++) = Value;
    }
    else
    {
      unsigned HighWord = Value & 0xFF00;
      if (HighWord == 0xA700 || HighWord == 0xA800)
      {
        unsigned  Count = Value & 0x00FF;
        unsigned *TempSrc;

        //
        //   Set the source pointer to the correct position.
        //
        if (HighWord == 0xA700)
        {
          //
          //   The next byte indicates the number of words back from the
          //   current target position from where copying must start.
          //
          TempSrc = Target - (unsigned) (*(( (unsigned char *) Source)++ ));
        }
        else
        {
          //
          //   The next word indicates the number of words from the start of
          //   the target buffer from where copying must start.
          //
          TempSrc = NewBlock + *(Source++);
        }

        //
        //   Copy the designated block in the decompressed target to the
        //   current target position.
        //
        WriteSize -= (Count - 1);
        while (Count-- > 0)
        {
          *(Target++) = *(TempSrc++);
        }
      }
      else
      {
        *(Target++) = Value;
      }
    }
  }

  //
  //   The decompression is complete. Now free the old memory block, set
  //   the map structure to the new block and size and return Ok.
  //
  free (BlockData);
  BlockData = NewBlock;
  BlockSize = TargetSize;

  return errOk;
}

