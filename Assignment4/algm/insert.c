#include <stdio.h>
#include <stdlib.h>
#define MAXN 11

int main(void){
    int arr[MAXN];
    int i,j,u;
    srand(1);
    for(i=0; i<MAXN; ++i) arr[i]=rand()%50;
    for(i=1; i<MAXN; ++i){
        u = arr[i];
        j = i-1;
        while(j>=0 && u>arr[j]){
            arr[j+1] = arr[j];
            --j;
        }
        arr[j+1]=u;
    }
    for(i=0; i<MAXN; ++i)printf("%d\n",arr[i]);
    return 0;
}
