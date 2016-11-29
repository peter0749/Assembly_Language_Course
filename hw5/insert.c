#include <stdio.h>
#include <stdlib.h>

int main(void){
    int arr[10]={0,1,2,3,4,5,6,7,8,9};
    int i,j,u;
    for(i=1; i<10; ++i){
        u = arr[i];
        j = i;
        while(j>0 && u>=arr[j]){
            arr[j] = arr[j-1];
            --j;
        }
        arr[j]=u;
    }
    for(i=0; i<10; ++i)printf("%d\n",arr[i]);
    return 0;
}
