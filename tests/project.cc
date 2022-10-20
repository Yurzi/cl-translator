#include <iostream>
#include "src/log.h"

int main(int argc, char *agrv[]) {
  std::cout << "Hello" << std::endl;
  YURZI_LOG_INFO(YURZI_LOG_ROOT()) << "HELLO WORLD!";
  return 0;
}
