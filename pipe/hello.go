package main

import (
    "fmt"
    "os"
    "os/exec"
//    "sync"
)


func Command(cmd string, args... string) {
  output, err := exec.Command(cmd, args...).CombinedOutput()
  if err != nil {
    os.Stderr.WriteString(err.Error())
  }
  fmt.Println(string(output))
}

func main() {
  fmt.Println("hello world")

  //Command("docker", "run", "--rm", "-i", "hello-world")

  stage()

}
