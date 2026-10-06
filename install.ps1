# 코쇠 삽화 스킬을 Claude Code / Codex 스킬 폴더에 설치한다 (Windows PowerShell).
# 사용법: .\install.ps1            (둘 다 설치)
#         .\install.ps1 -Target claude
#         .\install.ps1 -Target codex
param([ValidateSet('all', 'claude', 'codex')][string]$Target = 'all')
$ErrorActionPreference = 'Stop'
$Skill = 'koscom-kosoe-illustrations'
$Src = Join-Path $PSScriptRoot $Skill
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }

function Install-To($Dir) {
  New-Item -ItemType Directory -Force $Dir | Out-Null
  $Dest = Join-Path $Dir $Skill
  if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
  Copy-Item -Recurse $Src $Dest
  Write-Host "설치 완료: $Dest"
}

if ($Target -in 'all', 'claude') { Install-To (Join-Path $HOME '.claude\skills') }
if ($Target -in 'all', 'codex') { Install-To (Join-Path $CodexHome 'skills') }
