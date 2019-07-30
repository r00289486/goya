#include <string>

class FSinterface {
public:
  virtual void Execute() = 0;
};

class FSmkdir : public FSinterface {
public:
  virtual void Execute() {

  }
};

class FSlsdir : public FSinterface {
public:
  virtual void Execute() {
  }
};

class FSCmdFactory {
public:
  FSCmdFactory(int argc, char* argv[]) : opcode_(argv[1]) {}
  void CreateOpObject() {
    if (opcode_ == "mkdir") {
      fs_ = new FSmkdir();
      printf("mkdir\n");
    }
    else if (opcode_ == "ls") {
      fs_ = new FSlsdir();
      printf("ls\n");
    }
    else {
      //print_usage();
    }
  }
  
  void Execute() {
    fs_->Execute();
  }

private:
  FSinterface *fs_;
  std::string opcode_;
};

int main(int argc, char* argv[]) {
  FSCmdFactory* instance = new FSCmdFactory(argc, argv);
  instance->CreateOpObject();
  instance->Execute();
}

