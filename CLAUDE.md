# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Sekiro AI modding project that processes Lua scripts for game AI behavior modification. The project handles encoding conversion, BOM removal, and building AI mods for integration into the Sekiro game.

## Core Architecture

The project consists of three main Python scripts that work together to process Sekiro AI script files:

1. **BuildAIMod.py** - Main build script that processes multiple map directories, converts Lua files to Shift-JIS encoding, and uses Yabber to repack them into `.luabnd.dcx` files for the game
2. **encode_to_shiftjis.py** - Standalone utility for encoding conversion of files from UTF-8 to Shift-JIS
3. **remove_bom.py** - Utility for removing BOM (Byte Order Mark) from files across multiple directories

## Directory Structure

- **Map-specific directories**: Named like `m##_##_##_##-luabnd-dcx` (e.g., `m11_01_00_00-luabnd-dcx`) - contain unpacked Lua AI scripts for specific game areas
- **aicommon-luabnd-dcx** - Common AI scripts shared across areas
- **output/** - Temporary directory for processed files during build
- **Yabber/** - Contains the Yabber.exe tool for packing/unpacking FromSoftware BND files
- **AIAttackParam.xml** - Parameter definition file for AI attack behaviors (bilingual Japanese/Chinese comments)

## Common Commands

### Build AI Mod
```bash
python BuildAIMod.py
```
This processes all configured map directories, converts Lua files to Shift-JIS encoding, removes BOM markers, and repacks them using Yabber. Built files are deployed to the Sekiro mods directory.

### Convert Files to Shift-JIS
```bash
python encode_to_shiftjis.py <directory> [--output output_dir] [--extensions .lua,.txt]
```

### Remove BOM from Files
```bash
python remove_bom.py [--directories dir1 dir2] [--extensions .lua,.txt]
```
If no directories specified, processes all default map directories defined in the script.

## Key Technical Details

- **Target Encoding**: All Lua files must be in Shift-JIS encoding for proper game compatibility
- **BOM Handling**: UTF-8 BOM markers are automatically detected and removed during processing
- **Yabber Integration**: Uses Yabber.exe to pack processed Lua directories back into `.luabnd.dcx` format
- **Deployment Path**: Built mods are automatically deployed to `D:/SteamLibrary/steamapps/common/Sekiro/mods/script/`

## Map Directory Configuration

The `BuildAIMod.py` script processes these map areas by default:
- aicommon, m10_00_00_00, m11_00_00_00, m11_01_00_00, m11_02_00_00
- m12_00_00_00, m13_00_00_00, m15_00_00_00, m17_00_00_00, m20_00_00_00
- m25_00_00_00, m25_01_00_00

Individual maps can be processed by modifying the `names` array in BuildAIMod.py.