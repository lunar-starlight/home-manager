{
  lib,
  symlinkJoin,
  rustPlatform,
  fetchFromGitHub,
  versionCheckHook,
  gitUpdater,

  # buildInputs
  atk,
  gtk4,
  libadwaita,
  libayatana-appindicator,
  libepoxy,
  libxkbcommon,
  mpv,
  openssl,
  webkitgtk_6_0,

  # nativeBuildInputs
  makeBinaryWrapper,
  pkg-config,
  wrapGAppsHook4,

  # Wrapper
  addDriverRunpath,
  libGL,
  nodejs,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "stremio-linux-shell";
  version = "1.0.0-beta.13";

  src = fetchFromGitHub {
    owner = "Stremio";
    repo = "stremio-linux-shell";
    #tag = "v${finalAttrs.version}";
    #hash = "sha256-1f9IBNo5gxpSqTSIf8QuQOlf+sfRhohOmQTLRbX/OU8=";
    rev = "01967a0202569620afb5b42175a67d6b25039c43";
    hash = "sha256-HG5In34ED5akLFwzYbJuk3IsT8ABqqJaXKoHe4Y2l+Q=";
  };

  cargoHash = "sha256-QhrL7yPu/zAJIXo+D1abbZ4yO3Tk9S+qsNbz3RxQ+uw=";

  #postPatch = ''
  #  substituteInPlace $cargoDepsCopy/*/libappindicator-sys-*/src/lib.rs \
  #    --replace-fail "libayatana-appindicator3.so.1" "${libayatana-appindicator}/lib/libayatana-appindicator3.so.1"
  #  substituteInPlace $cargoDepsCopy/*/xkbcommon-dl-*/src/lib.rs \
  #    --replace-fail "libxkbcommon.so.0" "${libxkbcommon}/lib/libxkbcommon.so.0"
  #  substituteInPlace $cargoDepsCopy/*/xkbcommon-dl-*/src/x11.rs \
  #    --replace-fail "libxkbcommon-x11.so.0" "${libxkbcommon}/lib/libxkbcommon-x11.so.0"
  #'';

  # Don't download CEF during build
  buildFeatures = [ "offline-build" ];

  buildInputs = [
    atk
    gtk4
    libadwaita
    libayatana-appindicator
    libepoxy
    libxkbcommon
    mpv
    openssl
    webkitgtk_6_0
  ];

  nativeBuildInputs = [
    makeBinaryWrapper
    pkg-config
    wrapGAppsHook4
  ];

  strictDeps = true;
  __structuredAttrs = true;

  postInstall = ''
    mkdir -p $out/share/applications
    cp data/com.stremio.Stremio.desktop $out/share/applications/com.stremio.Stremio.desktop

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp data/icons/com.stremio.Stremio.svg $out/share/icons/hicolor/scalable/apps/com.stremio.Stremio.svg

    mkdir -p $out/share/stremio
    cp data/server.js $out/share/stremio/server.js

    mv $out/bin/stremio-linux-shell $out/bin/stremio
  '';

  # Node.js is required to run `server.js`
  # Add to `gappsWrapperArgs` to avoid two layers of wrapping.
  preFixup = ''
    gappsWrapperArgs+=(
      --prefix LD_LIBRARY_PATH : "${addDriverRunpath.driverLink}/lib" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ libGL ]}" \
      --prefix PATH : "${lib.makeBinPath [ nodejs ]}"
      --prefix SERVER_PATH : "/home/muf/.nix-profile/share/stremio/server.js"
    )
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "--version";
  doInstallCheck = true;

  passthru = {
    updateScript = gitUpdater { rev-prefix = "v"; };
  };

  meta = {
    description = "Modern media center that gives you the freedom to watch everything you want";
    homepage = "https://www.stremio.com/";
    license =
      with lib.licenses;
      AND [
        gpl3Only
        unfree # server.js
      ];
    sourceProvenance = with lib.sourceTypes; [
      fromSource
      obfuscatedCode # server.js
    ];
    maintainers = with lib.maintainers; [ thunze ];
    platforms = lib.platforms.linux;
    mainProgram = "stremio";
  };
})
