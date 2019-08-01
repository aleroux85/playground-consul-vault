#!/bin/bash

/app/sample_server &
exec consul agent -config-dir=/consul/config "$@"