#ifndef __KECCAK_H__
#define __KECCAK_H__

#include <stdint.h>
#include <stdlib.h>


extern int keccak256(uint8_t*, size_t, const uint8_t*, size_t);

#endif