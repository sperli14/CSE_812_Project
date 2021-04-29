# CSE_812_Project

To compile z3:

In the z3-master directory
	- For Windows:
		+ 32-bit Users:
			1. python scripts/mk_make.py

		+ 64-bit Users:
			2. python scripts/mk_make.py -x

		3. cd build
		4. nmake
	- For Unix/Linux:
		1. python scripts/mk_make.py
		2. cd build
		3. make
		4. sudo make install

Copy the main.cpp and all other files into examples/c++

make examples
./cpp_example

Compile, build, run!