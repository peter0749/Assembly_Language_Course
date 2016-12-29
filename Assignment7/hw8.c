/*-----
 * Author:   Kuang-Yu Jeng
 * Date:     2016/12/29
 * Using:    C99 standard
 * flag:     -msse3 -fopenmp -openmp
 *
 ------*/
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define NROW 300
#define NCOL 304
#define CLIM 302

float __attribute__((aligned(16)))\
          mtxA[NROW][NCOL], mtxB[NROW][NCOL], mtxC[NROW];

void solv(){
    for(int i=0; i<NROW; ++i){// private i
        for(int j=0; j<NROW; ++j){
            for(int k=0; k<CLIM; ++k){
                mtxC[i] += mtxA[i][k] * mtxB[j][k];
            }
        }
    }
}

int main(int argc, char *argv[]) {
    /*Timer*/
    struct timeval sv, ev;
    struct timezone sz, ez;

    /*Open FILE*/
    if(argc!=2) exit(-1);
    FILE *FileIn=NULL, *FileOut=NULL;
    FileIn=fopen(argv[1], "r");
    FileOut=fopen("output.txt", "w");
    if(!FileIn ) exit(-2);
    if(!FileOut) exit(-2);
    /*End of opening FILE*/

    /*Read File*/
    for(int i=0; i<NROW; ++i){
        for(int j=0; j<CLIM; ++j)
            fscanf(FileIn, "%f", &mtxA[i][j]);
    }
    for(int i=0; i<NROW; ++i){
        for(int j=0; j<CLIM; ++j)
            fscanf(FileIn, "%f", &mtxB[i][j]);
    }
    for(int i=0; i<NROW; ++i)for(int j=CLIM; j<NCOL; ++j)
        mtxA[i][j] = mtxB[i][j] = 0;//Paddling
    for(int i=0; i<NROW; ++i) mtxC[i]=0.0f;
    /*End of readimg File*/
    gettimeofday(&sv, &sz);
    solv();
    gettimeofday(&ev, &ez);
    for(int i=0; i<NROW; ++i)
        fprintf(FileOut, "%.6f\n", mtxC[i]);
    fclose(FileIn);
    fclose(FileOut);
#ifdef BENCH
    printf("%.3lf\n", (ev.tv_sec-sv.tv_sec)*1.0e6f + (ev.tv_usec-sv.tv_usec));
#endif
    return 0;
}
