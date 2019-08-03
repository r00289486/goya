#ifndef _FILE_CLIENT_IMPL_H_
#define _FILE_CLIENT_IMPL_H_

#include <sys/types.h>
#include "file_client.h"

namespace goya {

namespace fs {

class FileClientImpl : public FileClient {
public:
  virtual void Write(const char * buf, ssize_t size);
  virtual void Read(char * buf, ssize_t size);
};

class FileSystemImpl : public FileSystem {
public:
  virtual int CreateDirectory(char* path);
  virtual int ListDirectory(char* path);
};

}

}

#endif
