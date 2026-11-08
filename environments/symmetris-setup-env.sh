#!/usr/bin/env bash
# Setup do ambiente de nuvem do Symmetris: .NET 10 SDK (backend) + Flutter (frontend).
# Idempotente, sem interação, deixa tudo no PATH (symlinks em /usr/local/bin).
# Cole no campo "Setup script" do ambiente. Versões podem ser trocadas por env var.
set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-3.44.0}"   # mesma do CI do frontend (ci.yml)
FLUTTER_DIR="${FLUTTER_DIR:-/opt/flutter-${FLUTTER_VERSION}}"
DOTNET_APT_PKG="${DOTNET_APT_PKG:-dotnet-sdk-10.0}"  # backend compila net10.0
INSTALL_DOCKER="${INSTALL_DOCKER:-1}"          # [DatabaseFact] precisam de Docker
INSTALL_MELOS="${INSTALL_MELOS:-0}"            # melos já é dev_dependency (^7.8.1) do frontend; o global 8.x quebra o pub get ("Creation failed .dart_tool")
INSTALL_LINUX_DESKTOP_DEPS="${INSTALL_LINUX_DESKTOP_DEPS:-0}"  # só para "flutter build linux" (mesmas libs do linux.yml)
INSTALL_RUST="${INSTALL_RUST:-1}"            # symmetris_native (flutter_rust_bridge/cargokit)
RUST_TOOLCHAIN="${RUST_TOOLCHAIN:-stable}"
RUST_COMPONENTS="${RUST_COMPONENTS:-rustfmt,clippy}"  # vauedge CI roda cargo fmt --check e clippy -D warnings
RUST_TARGETS="${RUST_TARGETS:-}"              # ex.: "wasm32-unknown-unknown" (Web usa nightly)
INSTALL_GRAPHIFY="${INSTALL_GRAPHIFY:-0}"     # mapa do código (tree-sitter, sem LLM): `graphify update <pasta>`; experimento, ver backlog "avaliar-graphify"
GRAPHIFY_VERSION="${GRAPHIFY_VERSION:-0.9.97}"  # versão testada em 2026-10-29 (o pacote do PyPI tem dois "y": graphifyy)

export DEBIAN_FRONTEND=noninteractive
export DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
log() { echo "[setup] $*"; }

# --- .NET SDK via apt (Ubuntu 24.04 noble-updates). Não usa builds.dotnet.microsoft.com,
# que a política de rede padrão bloqueia. ---
if ! command -v dotnet >/dev/null || ! dotnet --list-sdks | grep -q '^10\.'; then
  log "instalando $DOTNET_APT_PKG"
  $SUDO apt-get update -qq
  $SUDO apt-get install -y -qq --no-install-recommends "$DOTNET_APT_PKG" ca-certificates curl git xz-utils unzip python3
else
  log ".NET 10 já presente"
fi

# --- Submódulos (proto/vauedge é submódulo do backend e do frontend; sem ele o build falha) ---
for repo in /home/user/Symmetris /home/user/Symmetris-backend /home/user/Symmetris-frontend /home/user/vauedge \
            /home/claude/Symmetris /home/claude/Symmetris-backend /home/claude/Symmetris-frontend /home/claude/vauedge; do
  if [ -f "$repo/.gitmodules" ]; then
    (cd "$repo" && git submodule update --init --recursive >/dev/null 2>&1 && log "submódulos ok ($repo)") || log "submódulos falharam em $repo (não crítico)"
  fi
done

# --- Ferramentas locais do backend (swagger CLI) ---
for repo in /home/user/Symmetris-backend /home/claude/Symmetris-backend; do
  if [ -f "$repo/.config/dotnet-tools.json" ]; then
    (cd "$repo" && dotnet tool restore >/dev/null 2>&1 && log "dotnet tool restore ok ($repo)") || log "dotnet tool restore falhou (não crítico)"
  fi
done

# --- Flutter (tarball oficial no GCS; github.com não é necessário) ---
if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  log "baixando Flutter $FLUTTER_VERSION"
  tmp="$(mktemp -d)"
  curl -fsSL --retry 4 --retry-delay 3 \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    -o "$tmp/flutter.tar.xz"
  $SUDO mkdir -p "$(dirname "$FLUTTER_DIR")"
  $SUDO tar -xJf "$tmp/flutter.tar.xz" -C "$tmp"
  $SUDO rm -rf "$FLUTTER_DIR"
  $SUDO mv "$tmp/flutter" "$FLUTTER_DIR"
  rm -rf "$tmp"
else
  log "Flutter $FLUTTER_VERSION já presente"
fi
git config --global --add safe.directory "$FLUTTER_DIR" 2>/dev/null || true
$SUDO ln -sf "$FLUTTER_DIR/bin/flutter" /usr/local/bin/flutter
$SUDO ln -sf "$FLUTTER_DIR/bin/dart" /usr/local/bin/dart
export PATH="$FLUTTER_DIR/bin:$HOME/.pub-cache/bin:$PATH"
export FLUTTER_SUPPRESS_ANALYTICS=true CI=true
flutter config --no-analytics >/dev/null 2>&1 || true
flutter precache --web >/dev/null 2>&1 || log "flutter precache falhou (será feito no 1º uso)"

if [ "$INSTALL_MELOS" = "1" ] && ! command -v melos >/dev/null; then
  dart pub global activate melos >/dev/null 2>&1 && log "melos ok" || log "melos falhou (não crítico)"
fi

# --- Libs de sistema do build Linux desktop (opcional; copiadas de .github/workflows/linux.yml) ---
if [ "$INSTALL_LINUX_DESKTOP_DEPS" = "1" ]; then
  $SUDO apt-get install -y -qq --no-install-recommends clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev \
    libstdc++-12-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libsecret-1-dev
fi

# --- Docker (daemon precisa subir a cada sessão: ver nota no fim) ---
if [ "$INSTALL_DOCKER" = "1" ] && ! command -v dockerd >/dev/null; then
  log "instalando docker.io"
  $SUDO apt-get install -y -qq --no-install-recommends docker.io
fi

# --- Rust (rustup-init direto de static.rust-lang.org; sh.rustup.rs é bloqueado) ---
if [ "$INSTALL_RUST" = "1" ]; then
  export RUSTUP_HOME="${RUSTUP_HOME:-/opt/rustup}" CARGO_HOME="${CARGO_HOME:-/opt/cargo}"
  if [ ! -x "$CARGO_HOME/bin/rustup" ]; then
    log "instalando Rust $RUST_TOOLCHAIN"
    $SUDO apt-get install -y -qq --no-install-recommends build-essential pkg-config libssl-dev
    $SUDO mkdir -p "$RUSTUP_HOME" "$CARGO_HOME"
    curl -fsSL --retry 4 https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -o /tmp/rustup-init
    chmod +x /tmp/rustup-init
    $SUDO env RUSTUP_HOME="$RUSTUP_HOME" CARGO_HOME="$CARGO_HOME" /tmp/rustup-init -y --no-modify-path --profile minimal -c rustfmt -c clippy --default-toolchain "$RUST_TOOLCHAIN"
    rm -f /tmp/rustup-init
  else
    log "Rust já presente"
  fi
  for b in cargo rustc rustup; do $SUDO ln -sf "$CARGO_HOME/bin/$b" /usr/local/bin/$b; done
  for c in ${RUST_COMPONENTS//,/ }; do $SUDO env RUSTUP_HOME="$RUSTUP_HOME" CARGO_HOME="$CARGO_HOME" "$CARGO_HOME/bin/rustup" component add "$c" || true; done
  for t in ${RUST_TARGETS//,/ }; do $SUDO env RUSTUP_HOME="$RUSTUP_HOME" CARGO_HOME="$CARGO_HOME" "$CARGO_HOME/bin/rustup" target add "$t"; done
fi

# --- Graphify (opcional): só a CLI, em ambiente isolado; não registra a skill no assistente
# (`graphify install` é outro passo) e não usa LLM. Precisa de pypi.org liberado na rede. ---
if [ "$INSTALL_GRAPHIFY" = "1" ] && ! command -v graphify >/dev/null; then
  log "instalando graphify $GRAPHIFY_VERSION"
  if command -v uv >/dev/null; then
    $SUDO env UV_TOOL_DIR=/opt/uv-tools UV_TOOL_BIN_DIR=/usr/local/bin uv tool install "graphifyy==$GRAPHIFY_VERSION" >/dev/null 2>&1 \
      && log "graphify ok" || log "graphify falhou (não crítico; pypi.org liberado?)"
  else
    { $SUDO apt-get install -y -qq --no-install-recommends python3-venv python3-pip \
      && $SUDO python3 -m venv /opt/graphify \
      && $SUDO /opt/graphify/bin/pip install -q "graphifyy==$GRAPHIFY_VERSION" \
      && $SUDO ln -sf /opt/graphify/bin/graphify /usr/local/bin/graphify \
      && log "graphify ok"; } >/dev/null 2>&1 || log "graphify falhou (não crítico; pypi.org liberado?)"
  fi
fi

# --- PATH/env persistentes para shells futuros ---
$SUDO tee /etc/profile.d/symmetris-env.sh >/dev/null <<PROFILE
export PATH="$FLUTTER_DIR/bin:\$HOME/.pub-cache/bin:\$HOME/.dotnet/tools:\$PATH"
export DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1 FLUTTER_SUPPRESS_ANALYTICS=true
PROFILE

if [ "$INSTALL_RUST" = "1" ]; then
  echo "export RUSTUP_HOME=\"$RUSTUP_HOME\" CARGO_HOME=\"$CARGO_HOME\"" | $SUDO tee -a /etc/profile.d/symmetris-env.sh >/dev/null
fi

log "dotnet: $(dotnet --version)"
log "flutter: $(flutter --version 2>/dev/null | head -1)"
command -v cargo >/dev/null && log "rust: $(rustc --version)"
command -v graphify >/dev/null && log "graphify: instalado"
# --- Comando `start-docker`: sobe o dockerd e baixa a imagem dos [DatabaseFact]
# (Testcontainers: postgres:16-alpine). Fica instalado em /usr/local/bin para poder ser
# chamado de novo a qualquer momento (início de sessão, se o daemon não persistir).
$SUDO tee /usr/local/bin/start-docker >/dev/null <<'STARTDOCKER'
#!/usr/bin/env bash
set -uo pipefail
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
if ! docker info >/dev/null 2>&1; then
  $SUDO nohup dockerd >/tmp/dockerd.log 2>&1 &
  for _ in $(seq 1 30); do docker info >/dev/null 2>&1 && break; sleep 1; done
fi
docker info >/dev/null 2>&1 || { echo "dockerd não subiu; veja /tmp/dockerd.log" >&2; exit 1; }
docker pull postgres:16-alpine >/dev/null && echo "docker ok (postgres:16-alpine)"
STARTDOCKER
$SUDO chmod +x /usr/local/bin/start-docker
if [ "$INSTALL_DOCKER" = "1" ]; then
  start-docker || log "start-docker falhou (não crítico); rode 'start-docker' no início da sessão"
fi

log "pronto. Se o Docker não persistir entre sessões, rode: start-docker"
