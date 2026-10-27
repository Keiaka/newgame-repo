# Your independent Azeroth Survivors source copy

This repository belongs to **Keiaka** and contains the source snapshot from
`OutThisLife/azeroth-survivors-re` at commit
`72048f4056e2a57d99234e4fb658179e577d1d92` (26 October 2026).
The original tracked files, executable modes, licenses and credits are preserved.
This is a source snapshot import, not a transfer of upstream issues, releases or complete Git history.
Your repository will not automatically pull future changes from the original.

## Download

[Download your source ZIP](https://github.com/Keiaka/newgame-repo/archive/refs/heads/main.zip)

Or clone your own repository:

```bash
git clone https://github.com/Keiaka/newgame-repo.git
cd newgame-repo
```

In GitHub Desktop: **File → Clone repository → URL**, enter the URL above, and choose a local folder.
Edit that folder in Visual Studio Code. The project is Rust + Bevy, not Godot.

## Build and play

Read the original [README.md](README.md) first. It describes the source snapshot's actual features.
It may differ from the original Azeroth Survivors game's current website and screenshots.
The source ZIP does **not** contain a ready-made `.exe`, a compiled browser build, or WoW game data.

The upstream quick start is:

```bash
make build
make start
```

Then open `http://127.0.0.1:8090/` in a browser supporting WebGPU.
These commands require Rust, make, curl, unzip and Bash. The first build also fetches
additional toolchains/dependencies and approximately 5.5 GB of WoW 1.12.1 data.
On Windows, the upstream documentation specifies Git Bash; PowerShell cannot run the Bash scripts directly.
A native desktop target also exists (`make native`); it must be compiled and is not included as a prebuilt download.

To use existing compatible data, inspect `scripts/fetch-data.sh` and the README's
`WOW_DATA` / `--data` guidance. Keep game data, build output and local credentials out of Git.
After setup, your checked-out code is independent of the original GitHub repository;
initial builds still need external package/toolchain/game-data sources.

## Where to edit

- `crates/benilla-app/src/survivors/data.rs`: classes, abilities, passive upgrades, maps, enemies and boss tables.
- `crates/benilla-app/src/survivors/menu.rs`: character/zone selection.
- `crates/benilla-app/src/survivors/cards.rs`: level-up cards.
- `crates/benilla-app/src/survivors/hud.rs`: HUD and results UI.
- `crates/benilla-app/src/survivors/enemies.rs`: spawning, enemy behavior and pickups.
- `web/`: browser entry page and integration.

Make a branch in GitHub Desktop, edit files, rebuild and test, then commit and push to
**Keiaka/newgame-repo**. Upstream-specific URLs and deployment instructions in inherited
documentation describe the original projects; they are not instructions to push your changes there.

## Credits and verification

The original author and engine credits remain in README.md. Keep `LICENSE-MIT`,
`LICENSE-APACHE`, and the vendored licenses when modifying or sharing the source.
The source import is checked by comparing every imported file's Git blob hash and executable
mode with the pinned upstream snapshot. A successful import does not mean a Windows binary
has been compiled or gameplay tested.
