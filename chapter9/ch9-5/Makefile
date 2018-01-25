CXX = g++
CXXFLAGS = -std=c++14 -I /usr/local/boost/include
LDLIBS =  -lmysqlcppconn
NAME = ch9-5
OBJ = $(NAME).o

target: $(OBJ)
	$(CXX) -o $(NAME) $(OBJ) $(LDLIBS)

.PHONY: clean
clean:
	rm $(NAME) $(OBJ)