@echo off
cd /d D:\Github_scripts\agent-skills-library
set GIT_SSH_COMMAND=ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=3

echo [1/4] Adding context-engineering...
git submodule add --depth 1 git@github.com:muratcankoylan/Agent-Skills-for-Context-Engineering.git skills/context-engineering
IF ERRORLEVEL 1 goto :error

echo [2/4] Adding awesome-agent-skills...
git submodule add --depth 1 git@github.com:VoltAgent/awesome-agent-skills.git skills/awesome-agent-skills
IF ERRORLEVEL 1 goto :error

echo [3/4] Adding vercel-skills-cli...
git submodule add --depth 1 git@github.com:vercel-labs/skills.git skills/vercel-skills-cli
IF ERRORLEVEL 1 goto :error

echo [4/4] Adding SkillSpector...
git submodule add --depth 1 git@github.com:NVIDIA/SkillSpector.git tools/SkillSpector
IF ERRORLEVEL 1 goto :error

echo.
echo ====== ALL DONE ======
git submodule status
echo.
echo Next: git add -A ^&^& git commit -m "chore: add all skill submodules" ^&^& git push
exit /b 0

:error
echo.
echo ====== FAILED ======
exit /b 1
