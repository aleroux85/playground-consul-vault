#!/bin/bash

exec consul agent -config-dir=/consul/config "$@"