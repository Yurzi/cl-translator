#include "log.h"
#include "sion.h"

int main(int argc, char *argv[]) {
  sion::String test("flagsaaaaflags");
  auto res = test.Split("flags");

  for (auto i : res) {
    YURZI_LOG_INFO(YURZI_LOG_ROOT()) << "qwq";
  }
  return 0;
}
