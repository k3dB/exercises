#ifndef RAINDROPS_H
#define RAINDROPS_H

// Copy buffer size from tests
#define BUFFER_LENGTH 16

// Sounds
#define PLING "Pling"
#define PLANG "Plang"
#define PLONG "Plong"

void convert(char result[], int drops);
void appendSound(char result[], char *sound);

#endif
