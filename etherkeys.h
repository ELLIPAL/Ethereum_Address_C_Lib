/*
**  (C)ELLIPAL, Tong Chen
**
**  Ethereum private key to address
**     - CLang lib
**     - No dependence. Can be used on linux, windows, Android or iOS
*/

#ifndef __EOSKEYS__
#define __EOSKEYS__

#define u8 unsigned char

#define BN256_STR_LEN 64
#define ETH_ADD_STR_LEN 42

#ifdef __cplusplus
extern "C" { 
#endif


void etherPrivate2Address(const char privStr[BN256_STR_LEN], char addrStr[ETH_ADD_STR_LEN]);

#ifdef __cplusplus
}
#endif

#endif
