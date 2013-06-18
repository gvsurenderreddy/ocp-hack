#!/usr/bin/python
import commands
commands.getoutput("cat /dev/nvram > /tmp/BIOS.np")
print commands.getoutput("cat /tmp/BIOS.np")