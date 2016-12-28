/*-----
 * Author:   Kuang-Yu Jeng
 * Date:     2016/12/29
 * Using:    C99 standard
 * flag:     -msse3 -fopenmp -openmp
 *
 ------*/
#include <sys/time.h>
#include <mmintrin.h>
#include <xmmintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>
#define NROW 300
#define NCOL 304
#define CLIM 302

float __attribute__((aligned(16)))\
          mtxA[NROW][NCOL], mtxB[NROW][NCOL], mtxC[NROW];

void solv(){
    const int chunks = NCOL/4;

#pragma omp parallel for shared(mtxA, mtxB)
    for(int i=0; i<NROW; ++i){// private i
        float __attribute__((aligned(16))) temp1[4]={0.0f,0.0f,0.0f,0.0f}, temp2[4]={0.0f,0.0f,0.0f,0.0f};// <-- Initalize float 0.0f constant
        __m128 *a = (__m128*) &mtxA[i][0];
        __m128 *b = NULL;
        __m128 *t1 = (__m128*) temp1;
        __m128 *t2 = (__m128*) temp2;
        for(int j=0; j<NROW; ++j){
            b = (__m128*) &mtxB[j][0];
            for(int k=0; k<chunks; ++k){
                *t1 = _mm_mul_ps(a[k], b[k]);
                *t2 = _mm_add_ps(*t2, *t1);
            }
        }
        mtxC[i] = temp2[0]+temp2[1]+temp2[2]+temp2[3];
    }
}

int main(int argc, char *argv[]) {
    struct timeval sv, ev;
    struct timezone sz, ez;
    /*Open FILE*/
    if(argc<2) exit(-1);
    if(argc>2) omp_set_num_threads( atoi(argv[2]) );
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
    memset(mtxC, 0x00, sizeof(mtxC));
    /*End of readimg File*/
    gettimeofday(&sv, &sz);
    solv();
    gettimeofday(&ev, &ez);
    fprintf(FileOut, "Time elapsed: %.3lfus\n", (ev.tv_sec-sv.tv_sec)*1.0e6f + (ev.tv_usec-sv.tv_usec));
    for(int i=0; i<NROW; ++i)
        fprintf(FileOut, "%.6f\n", mtxC[i]);
    fclose(FileIn);
    fclose(FileOut);
#ifdef BENCH
    FileOut = fopen("bench_parallel.txt","a");
    if(!FileOut) exit(-3);
    printf("%.3lf\n", (ev.tv_sec-sv.tv_sec)*1.0e6f + (ev.tv_usec-sv.tv_usec));
    fclose(FileOut);
#endif
    return 0;
}
