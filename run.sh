#!/bin/bash

set -xe

sudo mitamae local $* role/ubuntu/root
mitamae local $* role/ubuntu/user
