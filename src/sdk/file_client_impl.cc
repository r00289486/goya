
#include <stdio.h>
#include "file_client_impl.h"

namespace goya {

namespace fs {
  
void FileClientImpl::Write(const char* buf, ssize_t size) {
  // TODO
}

void FileClientImpl::Read(char* buf, ssize_t size) {
  // TODO
}

int FileSystemImpl::CreateDirectory(char* path) {
  // TODO
  printf("Create Directory %s\n", path);
  return 0;
}

int FileSystemImpl::ListDirectory(char* path) {
  // TODO
}

}
}

