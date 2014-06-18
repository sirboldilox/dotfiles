#!/bin/bash

# Send i3bar JSON header
echo '{"version":1}'
echo '[[]'

exec conky -c ~/.i3/conky.conf
