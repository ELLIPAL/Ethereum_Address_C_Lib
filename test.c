#include "keccak.h"
#include "etherkeys.h"

#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    unsigned char addr[ETH_ADD_STR_LEN];
    const char *privKey1 = "1122112211221122112211221122112211221122112211221122112211221122";
    char *privKey;
    int i;

    if (argc == 2)
    {
        privKey = argv[1];
        if (strlen(privKey) != strlen(privKey1))
        {
            printf("Bad privKey input\n");
            return -1;
        }
    }
    else
        privKey = privKey1;

    printf("%s\n", privKey);

    etherPrivate2Address(privKey, addr);

    for (i = 0; i < ETH_ADD_STR_LEN; i++)
        printf("%c", addr[i]);
    printf("\n");

    return 0;
}

