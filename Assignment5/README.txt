編譯環境: Ubuntu 16.04 LTS 64-bit
編譯選項: arm-elf-gcc -g -O0 call_numsort.c numsort.s -o hw6.exe
執行方法: 直接make, 會編譯+開啟insight
函式定義:
int *NumSort(int *array, int ArraySize);
第一個參數傳入array 的記憶體位置，第二個參數傳入array 大小。回傳值是NumSort 由小到大排序後Array 的記憶體位址。
main函式執行步驟:
初始化array 數值，經由NumSort 排序後，會用for loop 印出。
