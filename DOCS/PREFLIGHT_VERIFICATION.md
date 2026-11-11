# PRE-CONTEST TECHNICAL VERIFICATION & FREEZE CHECKLIST
*(Complete all checks and freeze `MegaJam2026-Prep` BEFORE 2026-11-11 22:00 TRT.)*

---

## 1. ACCOUNT, CREDITS & IP LICENSE AUDIT
- [ ] **Single Epic Account Lock:** Logged into Epic Games Launcher and itch.io with the single primary, non-Cabined Epic Account; physical residential address in account settings matches legal residence. Do NOT log into or touch any secondary Epic account.
- [ ] **3D & Material Tooling Quotas:** Verified active logins and credit balances for Hyper3D Rodin, Tripo Pro, Meshy Pro, and PBRgen.
- [ ] **AI Audio/Concept Endpoint License Check (`fal.ai`):** Identified exact `fal.ai` audio/music and 2D generation model endpoints to be used during the jam and confirmed each carries a **Commercial Use Allowed** license (avoiding non-commercial research-only weights so full sublicensing rights under Rule 15(a)-(b) are preserved).

---

## 2. RTX 3060 LAPTOP (6 GB VRAM) & NATIVE UE5 TSR BASELINE
- [ ] **Launcher UE5 Installation:** Verified standard Launcher UE5 version path matches `UE5_ROOT` in `SCRIPTS/PackageBuild.bat`, with `Win64` target platform and Visual Studio 2022 C++ / Windows SDK build tools installed.
- [ ] **Zero Third-Party Upscalers:** Confirmed zero third-party upscaling plugins exist in Engine `Plugins/Marketplace` or `Plugins/Runtime`; rendering relies strictly on native UE5 **TSR (Temporal Super Resolution)** and `UGameUserSettings`.
- [ ] **MetaSounds Engine Availability:** Confirmed built-in `Metasound` plugin loads cleanly in Launcher UE5.
- [ ] **6 GB VRAM Protection Discipline:**
  - Keep only one active Realtime UE5 viewport open while running Blender + Antigravity IDE simultaneously.
  - Budget texture pool (`r.Streaming.PoolSize 2000`) and expose `UGameUserSettings` scalability tiers (`Low / Medium / High / Epic`) in-game so both 6 GB GPUs and varied judge hardware hold stable 60+ FPS.

---

## 3. UNREAL MCP & BLENDER MCP HANDSHAKE TEST (DESTROY TEMP FILES AFTERWARD)
Run this 10-minute verification in a **temporary scratch directory outside this repository**:
- [ ] **Blender MCP Socket & Coordinate Contract:**
  - Verified live connection between agent environment and Blender MCP.
  - Confirmed scene unit setup: Metric, `Unit Scale = 0.01` (`1 UE unit = 1 cm`), `+X Forward`, `+Z Up`, applied transforms (`Ctrl+A -> All Transforms`), world-origin pivot, triangulated/clean normals export.
- [ ] **Unreal MCP Socket & Editor Command Check:**
  - Verified live connection between agent environment and Unreal MCP on a disposable blank project.
  - Verified basic actor query/transform response and clean C++ compilation in Rider.
- [ ] **SCRATCH CLEANUP (MANDATORY):** Completely deleted the temporary test project folder from disk after verification. Zero `.uproject`, `.uasset`, `.umap`, `.h`, or `.cpp` files exist in `MegaJam2026-Prep`.

---

## 4. POST-START `DefaultGame.ini` (`MapsToCook`) REFERENCE SNIPPET
*(Do NOT create a `.uproject` now. Apply these settings to `Config/DefaultGame.ini` AFTER November 12, 2026 at 08:00 TRT once the real game project is initialized, keeping the `.zip` archive well below 1 GB:)*

```ini
[/Script/UnrealEd.ProjectPackagingSettings]
BuildConfiguration=PPBC_Development
FullRebuild=False
UsePakFile=True
bCompressed=True
IncludePrerequisites=True
bIncludeDebugFiles=False
bCookAll=False
bCookMapsOnly=True
+MapsToCook=(FilePath="/Game/Maps/L_MainMenu")
+MapsToCook=(FilePath="/Game/Maps/L_MainGameplay")
```

Also verify in `Config/DefaultEngine.ini` before running `SCRIPTS\PackageBuild.bat`:
- `GameDefaultMap` and `GlobalDefaultGameMap` point to `/Game/Maps/L_MainMenu` (or `/Game/Maps/L_MainGameplay`), never to an Engine template map.
- Unzip `Dist\<TeamName>_<GameName>.zip` into a separate folder (e.g., `C:\JamTestRun\`) and launch the `.exe` directly to confirm standalone startup, full English UI, 1920x1080 gameplay video capture readiness (30–60s), and clean exit.

---

## 5. REPOSITORY FREEZE PROTOCOL (BEFORE 2026-11-11 22:00 TRT)
1. Copy `.antigravityignore` to `.cursorignore` and `AGENT_RULES.md` to `.cursorrules` in the repository root.
2. Run `git status` and verify ONLY these generic files are tracked:
   - `.gitignore`
   - `.antigravityignore` & `.cursorignore`
   - `AGENT_RULES.md` & `.cursorrules`
   - `PROMPTS/ARCHITECTURE_SPEC_PROMPT.md`
   - `DOCS/GLASS_BOX_DEVLOG_TEMPLATE.md`
   - `DOCS/PREFLIGHT_VERIFICATION.md`
   - `SCRIPTS/PackageBuild.bat`
3. Commit and push to your remote Git server to lock the server-side timestamp before `22:00 TRT`:
   ```bash
   git add .
   git commit -m "chore: freeze generic Rule 7(h) tooling and agent rules prior to theme reveal"
   git tag v1.0-prejam-freeze
   git push origin main --tags
   ```
4. **Hard Stop:** Do NOT commit to `MegaJam2026-Prep` again, and do NOT create `.uproject`, design docs, prompts, code, or assets until `November 12, 2026, 08:00 TRT (00:00 AM ET)`.