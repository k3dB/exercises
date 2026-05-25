#include "rna_transcription.h"
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

char *to_rna(const char *dna)
{
    size_t length = strlen(dna);
    char* rna = malloc(length + 1);

    if (!rna)
        return NULL;

    size_t i = 0;

    for ( ; i < length; i++)
    {
        switch (dna[i])
        {
            case 'C':
                rna[i] = 'G';
                break;
            case 'G':
                rna[i] = 'C';
                break;
            case 'T':
                rna[i] = 'A';
                break;
            case 'A':
                rna[i] = 'U';
                break;
            default:
                break;
        }
    }

    rna[i] = '\0';

    return rna;
}
