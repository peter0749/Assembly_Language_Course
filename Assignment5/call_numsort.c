#include <stdio.h>
#include <time.h>
#define MAXN 10
extern int* NumSort(int, int*);

int main(void){
    int i, a[MAXN], *res;
    int n=sizeof(a)/sizeof(int);
    srand(1);
    for(i=0; i<MAXN; ++i) a[i]=rand()%50;
    res = NumSort(n,a);
    for(i=0; i<n; ++i) printf("%d ",res[i]);
    return 0;
}
