環境:
OS: Ubuntu 16.04 LTS 64-bit, gcc-5.4.0
CPU: Intel core-M 5y71

程式內容:
讀入矩陣AB檔案，照題目意思算出矩陣C，並將結果存至output.txt。
有兩種版本，一種是普通版(hw8.c)，另一種使用OMP+SIMD 指令加速(hw8simd.c)。

使用方法;
普通版
./hw8 矩陣檔案位置
OMP+SIMD版
./hw8ompsimd 矩陣檔案位置 [指定使用線程數]

編譯方法;
若以設定好環境，直接make 即可，
而 make bench 可用來比較普通板 vs OMP+SIMD 程式執行效率，
自己測試 OMP+SIMD 效率可以超過普通版 4~5 倍左右。
要注意的是若使用make bench，必須在同資料夾下放置data.txt 矩陣資料。

編譯flag;
-std=gnu11 -msse3 -fopenmp -openmp  

工作站上最佳紀錄:
Serial:
150688.000us
OMP+SIMD(32 threads):
17512.000us
差8倍左右

註記:
似乎SSE在計算浮點數時會有一些誤差？因此若兩種版本輸出結果有些微差異應該也是正常的。
