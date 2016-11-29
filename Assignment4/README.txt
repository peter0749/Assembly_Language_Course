編譯環境:Ubuntu 16.04 LTS 64-bit版本
編譯選項:arm-elf-gcc -g -O0 hw5_test.s numsort.s -o hw5.exe
如何執行:直接make 後，會編譯完成，打開insight。
註解：
因為不確定是規定要在函式中複製Array，還是在main中複製Array，因此有兩個版本。一種是在NumSort函式中複製Array，並將結果在函式執行結束前指向r3；另一種是將Array在main中先複製好，排序完後再將結果指向r3。
第一種的程式碼和makefile等放在testfunc資料夾，第二種的放在normal資料夾。
第一種的執行方法是設定記憶體位置100（十進位）的連續十個word數值，程式在離開NumSort之前會將r3指向結果。
第二種的執行方法是先修改r0指向的連續十個記憶體內容，程式執行後結果會放在r3。
第一種與第二種的差異還有：第一種的數值是宣告一塊記憶體使用，而第二種沒有。
