# install.ps1 - distribute the evidence-based-engineering methodology to
# Claude Code / Codex / TRAE. Qoder already loads this directory as the skill source.
#
# Layering (mixed):
#   - Claude Code skill  -> user-global   (~/.claude/skills/evidence-based-engineering)
#   - Codex AGENTS.md    -> project-level (<Project>/AGENTS.md)
#   - TRAE project_rules -> project-level (<Project>/.trae/rules/project_rules.md)
#
# Safety: an existing user instruction file (AGENTS.md / project_rules.md) is NEVER
# overwritten; a side file is written instead and you are asked to merge manually.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File install.ps1 -Project "D:\path\to\proj"
#   add -SkipClaude / -SkipCodex / -SkipTrae to skip a target.

[CmdletBinding()]
param(
  [string]$Project = (Get-Location).Path,
  [switch]$SkipClaude,
  [switch]$SkipCodex,
  [switch]$SkipTrae
)

$ErrorActionPreference = "Stop"
$name = "evidence-based-engineering"

$src = $PSScriptRoot
if (-not $src) { $src = Split-Path -Parent $MyInvocation.MyCommand.Definition }

# --- preflight: required source files must exist ---
foreach ($f in @("SKILL.md", "reference.md", "AGENTS.md", "trae-rules.md")) {
  if (-not (Test-Path -LiteralPath (Join-Path $src $f))) {
    throw ("missing source file: " + (Join-Path $src $f))
  }
}
Write-Output ("source dir : " + $src)
Write-Output ("project dir: " + $Project)
Write-Output ""

# --- 1) Claude Code : user-global skill ---
if ($SkipClaude) {
  Write-Output "[skip] Claude Code"
} else {
  $claudeDir = Join-Path $env:USERPROFILE (".claude\skills\" + $name)
  New-Item -ItemType Directory -Force -Path $claudeDir | Out-Null
  Copy-Item -LiteralPath (Join-Path $src "SKILL.md")     -Destination (Join-Path $claudeDir "SKILL.md")     -Force
  Copy-Item -LiteralPath (Join-Path $src "reference.md") -Destination (Join-Path $claudeDir "reference.md") -Force
  Write-Output ("[ok]   Claude Code skill -> " + $claudeDir)
}

# --- 2) Codex : project-level AGENTS.md ---
if ($SkipCodex) {
  Write-Output "[skip] Codex"
} else {
  $agents = Join-Path $Project "AGENTS.md"
  if (Test-Path -LiteralPath $agents) {
    $side = Join-Path $Project "AGENTS.evidence-based-engineering.md"
    Copy-Item -LiteralPath (Join-Path $src "AGENTS.md") -Destination $side -Force
    Write-Output ("[warn] AGENTS.md already exists; NOT modified. Wrote side file -> " + $side)
    Write-Output "       merge it manually (Codex also reads AGENTS.override.md)."
  } else {
    Copy-Item -LiteralPath (Join-Path $src "AGENTS.md") -Destination $agents -Force
    Write-Output ("[ok]   Codex AGENTS.md -> " + $agents)
  }
}

# --- 3) TRAE : project-level .trae/rules/project_rules.md ---
if ($SkipTrae) {
  Write-Output "[skip] TRAE"
} else {
  $traeDir = Join-Path $Project ".trae\rules"
  $rules = Join-Path $traeDir "project_rules.md"
  if (Test-Path -LiteralPath $rules) {
    $side = Join-Path $traeDir "project_rules.evidence-based-engineering.md"
    Copy-Item -LiteralPath (Join-Path $src "trae-rules.md") -Destination $side -Force
    Write-Output ("[warn] project_rules.md already exists; NOT modified. Wrote side file -> " + $side)
    Write-Output "       merge it manually."
  } else {
    New-Item -ItemType Directory -Force -Path $traeDir | Out-Null
    Copy-Item -LiteralPath (Join-Path $src "trae-rules.md") -Destination $rules -Force
    Write-Output ("[ok]   TRAE project_rules.md -> " + $rules)
  }
}

Write-Output ""
Write-Output "Done. Qoder needs no action (this directory is its skill source)."
