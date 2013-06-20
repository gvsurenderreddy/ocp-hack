This is a project from the 2nd OCP Hackathon @ Facebook

This project allows you to clone a BIOS from one Oepn Compute Server to another

The agent directory contains a nodejs agent that allows you to read and write to the NVRAM in SMBIOS

The init directory contains a init script for the agent

The os directory contains a script that generates a PXE disposable OS with the agent installed in it

The utils directory contains two bash scripts for cloneing a BIOS and then pushing it to another node

Authors

Nathan Rockhold - nate@nodeprime.com

License

Copyright 2013 NodePrime, Inc.

Licensed under the MIT License
