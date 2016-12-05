#include <stdio.h>
extern int* NumSort(int, int*);

int main(void){
    int i, a[]={1,2,3,4,5,6,7,8,9}, *res;
    int n=sizeof(a)/sizeof(int);
    res = NumSort(n,a);
    for(i=0; i<n; ++i) printf("%d ",res[i]);
    return 0;
}
