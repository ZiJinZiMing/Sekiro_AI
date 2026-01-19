# Sekiro AI Modding Project

## Project Overview

This project is a comprehensive toolkit and workspace for analyzing and modifying the AI and Action systems of the game **Sekiro: Shadows Die Twice**. It allows for deep customization of enemy behaviors, combat logic, and character actions through Lua scripting and parameter editing.

## Key Architecture

The system is divided into two main layers that work in tandem:

### 1. AI Layer (Strategy)
*   **Directory:** `m*-luabnd-dcx/` & `aicommon-luabnd-dcx`
*   **Purpose:** High-level decision making. Determines *what* an enemy wants to do (e.g., "Attack", "Guard", "Approach").
*   **Mechanism:** **Goal-Oriented Behavior**.
    *   `Goal`: The objective (e.g., `Goal710000Battle`).
    *   `Activate`: Logic to select the next `Act` based on weights/priorities.
    *   `Act`: Specific actions (e.g., `Act01` might be a specific sword combo).
*   **Key Files:**
    *   `*_battle.lua`: Combat logic (Attack patterns, aggression).
    *   `*_logic.lua`: Idle/Patrol logic (Detection, non-combat movement).

### 2. Action Layer (Tactics & Execution)
*   **Directory:** `action/`
*   **Purpose:** Low-level execution. Determines *how* an action is performed (animations, damage frames, state transitions).
*   **Mechanism:** Event-driven state machines interacting with the Havok Behavior engine.
*   **Key Files:**
    *   `c9997.dec.lua`: **Core Engine Script**. Handles shared logic for ALL characters (Damage calculation, Deflection, Posture break).
    *   `c7xxx.dec.lua`: Character-specific scripts (e.g., `c7100` for Genichiro).
    *   `c0000.dec.lua`: Player (Sekiro) script.

## Directory Structure

*   **`BuildAIMod.py`**: The primary build script. Packs modified Lua scripts using `Yabber` and deploys them to the game's mod directory.
*   **`action/`**: Decompiled `.dec.lua` action scripts.
*   **`m##_##_##_##-luabnd-dcx/`**: Map-specific AI scripts (Lua bytecode in `script/ai/out/bin/`).
*   **`aicommon-luabnd-dcx/`**: Common AI functions shared across all enemies.
*   **`param/`**: Game parameter tables (`SpEffectParam.txt`, `AtkParam_Npc.txt`). **Critical for ID lookups.**
*   **`docs/`**: Extensive documentation (Damage flow, Animation mappings, Goal architecture).
*   **`Yabber/`**: Tool for packing/unpacking FromSoftware's BND file format.

## Development Workflow

### 1. Modifying AI (Behavior)
*   **Goal**: Change *when* an enemy attacks or *how aggressive* they are.
*   **Action**: Edit `*_battle.lua` in the relevant map folder. Adjust weights (`SetSubGoalWeight`) or add new SubGoals.
*   **Build**: Run `python BuildAIMod.py`. ensure the `names` list in the script includes your map.

### 2. Modifying Actions (Mechanics)
*   **Goal**: Change *damage formulas*, *deflection logic*, or *status effects*.
*   **Action**: Edit `action/c9997.dec.lua` (global) or specific character scripts.
*   **Note**: This is advanced. Be careful with `transition_rank` and `env()` calls.

### 3. Parameters
*   **Goal**: Look up or change properties of specific moves/effects.
*   **Action**: Consult `param/` files.
    *   `SpEffectParam`: Status effects, buffs/debuffs.
    *   `AtkParam_Npc`: Attack damage, impact levels.

## Key Concepts & Functions

*   **`env(ID, ...)`**: The bridge between Lua and the C++ Game Engine.
    *   `env(284)`: Get Physical Damage Type.
    *   `env(285)`: Get Element Damage Type.
    *   `env(3036, ID)`: Check if a specific SpEffect is active.
*   **`act(ID, ...)`**: Execute a game engine command (e.g., Play Animation).
*   **`Fire("EventName")`**: Trigger a Havok Behavior event (often leads to animation changes).
*   **Damage Types**:
    *   **Physical**: Slash, Strike, Thrust.
    *   **Element**: Fire, Lightning, Magic (Terror).
    *   **Special**: Defined via `SpEffectParam`.

## Common Tasks & Troubleshooting

*   **Find Animation ID**:
    *   Use `python build_animation_mapping.py` to generate `docs/动画映射表.md`.
    *   Search for `Fire("W_EventName")` in the code, then look up the event in the mapping table.
*   **Trace Damage Logic**:
    *   Start at `ExecDamage` in `c9997.dec.lua`.
    *   Follow the chain: `ExecDebuffReaction` -> `ExecGuardBlock` -> `ExecDamageDefault`.
*   **Text Encoding**: Always use **UTF-8** for Lua files to support Chinese comments.

## Commands

*   `python BuildAIMod.py`: Build and deploy the mod.
*   `python build_animation_mapping.py`: Update animation mapping docs.
*   `grep "710000" param/SpEffectParam.txt`: Look up SpEffect ID 710000.