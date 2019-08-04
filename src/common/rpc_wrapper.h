// 目前rpc模块使用baidu sofa-pbrpc框架，带以后自己实现

#ifndef _RPC_WRAPPER_H_
#define _RPC_WRAPPER_H_

#include <string>
#include "masterserver.pb.h"

namespace goya {

namespace fs {

//typedef void(Stub::*func)(google::protobuf::RpcController*, const Request*, Response*, Callback*);

class RpcWrapper {
public:
  bool GetStub(std::string name, MasterServer_Stub* stub) {
    return false;
  }
  
  /*bool SendRequest(Stub stub, func, const Request* request, Response* reponse, int timeout, int retry_times) {
    
  }*/
};

}
}

#endif

