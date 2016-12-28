all:
	gcc hw8.c -o hw8.bin
	gcc hw8simd.c -msse3 -fopenmp -openmp -o hw8ompsimd.bin
clean:
	rm -f hw8.bin
	rm -f hw8ompsimd.bin
bench:
	gcc hw8.c -D BENCH -o tmp1.bin
	gcc hw8simd.c -D BENCH -msse3 -fopenmp -openmp -o tmp2.bin
	chmod +x Benchmark.sh
	./Benchmark.sh NB=12
	rm -f tmp1.bin
	rm -f tmp2.bin
