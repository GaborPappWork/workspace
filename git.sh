#!/bin/sh
exec /usr/bin/ssh -o StrictHostKeyChecking=no -i /ssh/id_rsa "$@"
