#include <stdio.h>
#include <time.h>
#define MAXN 50
extern int* NumSort(int, int*);

int main(void){
    int i, a[MAXN], *res;
    srand(time(NULL));
    for(i=0; i<MAXN; ++i)a[i]=rand()%MAXN;
    res = NumSort(MAXN,a);
    printf("%d",res[0]);
    for(i=1; i<MAXN; ++i) printf(" %d",res[i]);
    printf("\n");
    return 0;
}
