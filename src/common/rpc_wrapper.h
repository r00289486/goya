// 目前rpc模块使用baidu sofa-pbrpc框架，待以后自己实现

#ifndef _RPC_WRAPPER_H_
#define _RPC_WRAPPER_H_

#include <string>
#include <map>
#include "masterserver.pb.h"
#include "sofa/pbrpc/pbrpc.h"

namespace goya {

namespace fs {

//typedef void(Stub::*func)(google::protobuf::RpcController*, const Request*, Response*, Callback*);
typedef std::map<std::string, MasterServer_Stub*> ServerMapTypeDef;

class RpcWrapper {
public:
  bool GetStub(std::string server_addr, MasterServer_Stub*& stub) {
    ServerMapTypeDef::iterator iter = server_map_.find(server_addr);
    if (iter != server_map_.end()) {
      stub = iter->second;
      return true;
    } 
    
    sofa::pbrpc::RpcChannelOptions channel_options;
    sofa::pbrpc::RpcChannel* channel = 
            new sofa::pbrpc::RpcChannel(&rpc_client_, server_addr, channel_options);
    stub = new MasterServer_Stub(channel);
    server_map_[server_addr] = stub;

    return true;
  }
  
  /*bool SendRequest(Stub stub, func, const Request* request, Response* reponse, int timeout, int retry_times) {
    
  }*/

private:
  sofa::pbrpc::RpcClient rpc_client_;
  sofa::pbrpc::RpcClientOptions client_options_;
  ServerMapTypeDef server_map_;
};

}
}

#endif

