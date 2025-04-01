#!/bin/env bash

upload() {
  curl -F"file=@$1" -Fsecret=secret -i https://0x0.st
}

upload-delete() {
  curl -Ftoken="$1" -Fdelete=delete -i "$2"
}
